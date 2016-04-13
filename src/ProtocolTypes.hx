import haxe.extern.EitherType;

import BasicTypes;

/**
    Helper type for the `MethodName` values.
    Represents that value of this type is a request.
**/
abstract Request<TParams,TResponse,TError>(String) to String {}

/**
    Helper type for the `MethodName` values.
    Represents that value of this type is a notification.
**/
abstract Notification<TParams>(String) to String {}

/**
    Method names for the protocol requests and notifications.
    Each value must be typed as either `Request` or `Notification.
**/
@:enum abstract MethodName<TParams,TResponse,TError>(String) to String from Request<TParams,TResponse,TError> from Notification<TParams> {
    /**
        The initialize request is sent as the first request from the client to the server.
    **/
    var Initialize : Request<InitializeParams,InitializeResult,InitializeError> = "initialize";

    /**
        The shutdown request is sent from the client to the server.
        It asks the server to shutdown, but to not exit (otherwise the response might not be delivered correctly to the client).
        There is a separate exit notification that asks the server to exit.
    **/
    var Shutdown : Notification<Void> = "shutdown";

    /**
        A notification to ask the server to exit its process.
    **/
    var Exit : Notification<Void> = "exit";

    /**
        The show message notification is sent from a server to a client to ask the client to display a particular message in the user interface.
    **/
    var ShowMessage : Notification<ShowMessageParams> = "window/showMessage";

    /**
        The log message notification is send from the server to the client to ask the client to log a particular message.
    **/
    var LogMessage : Notification<LogMessageParams> = "window/logMessage";

    /**
        A notification send from the client to the server to signal the change of configuration settings.
    **/
    var DidChangeConfiguration : Notification<DidChangeConfigurationParams> = "workspace/didChangeConfiguration";

    /**
        The document open notification is sent from the client to the server to signal newly opened text documents.
        The document's truth is now managed by the client and the server must not try to read the document's truth using the document's uri.
    **/
    var DidOpenTextDocument : Notification<DidOpenTextDocumentParams> = "textDocument/didOpen";

    /**
        The document change notification is sent from the client to the server to signal changes to a text document.
    **/
    var DidChangeTextDocument : Notification<DidChangeTextDocumentParams> = "textDocument/didChange";

    /**
        The document close notification is sent from the client to the server when the document got closed in the client.
        The document's truth now exists where the document's uri points to (e.g. if the document's uri is a file uri the truth now exists on disk).
    **/
    var DidCloseTextDocument : Notification<DidCloseTextDocumentParams> = "textDocument/didClose";

    /**
        The document save notification is sent from the client to the server when the document for saved in the clinet.
    **/
    var DidSaveTextDocument : Notification<DidCloseTextDocumentParams> = "textDocument/didSave";

    /**
        The watched files notification is sent from the client to the server when the client detects changes to file watched by the lanaguage client.
    **/
    var DidChangeWatchedFiles : Notification<DidChangeWatchedFilesParams> = "workspace/didChangeWatchedFiles";

    /**
        Diagnostics notification are sent from the server to the client to signal results of validation runs.
    **/
    var PublishDiagnostics : Notification<PublishDiagnosticsParams> = "textDocument/publishDiagnostics";

    /**
        The Completion request is sent from the client to the server to compute completion items at a given cursor position.
        Completion items are presented in the IntelliSense user interface.
        If computing complete completion items is expensive servers can additional provide a handler for the resolve completion item request.
        This request is send when a completion item is selected in the user interface.
    **/
    var Completion : Request<TextDocumentPositionParams,Array<CompletionItem>,Void> = "textDocument/completion";

    /**
        The request is sent from the client to the server to resolve additional information for a given completion item.
    **/
    var CompletionItemResolve : Request<CompletionItem,CompletionItem,Void> = "completionItem/resolve";

    /**
        The hover request is sent from the client to the server to request hover information at a given text document position.
    **/
    var Hover : Request<TextDocumentPositionParams,Hover,Void> = "textDocument/hover";

    /**
        The signature help request is sent from the client to the server to request signature information at a given cursor position.
    **/
    var SignatureHelp : Request<TextDocumentPositionParams,SignatureHelp,Void> = "textDocument/signatureHelp";

    /**
        The goto definition request is sent from the client to the server to to resolve the defintion location of a symbol at a given text document position.
    **/
    var GotoDefinition : Request<TextDocumentPositionParams,EitherType<Location,Array<Location>>,Void> = "textDocument/definition";

    /**
        The references request is sent from the client to the server to resolve project-wide references for the symbol denoted by the given text document position.
    **/
    var FindReferences : Request<ReferenceParams,Array<Location>,Void> = "textDocument/references";

    /**
        The document highlight request is sent from the client to the server to to resolve a document highlights for a given text document position.
    **/
    var DocumentHighlights : Request<TextDocumentPositionParams,DocumentHighlight,Void> = "textDocument/documentHighlight";

    /**
        The document symbol request is sent from the client to the server to list all symbols found in a given text document.
    **/
    var DocumentSymbols : Request<DocumentSymbolParams,Array<SymbolInformation>,Void> = "textDocument/documentSymbol";

    /**
        The workspace symbol request is sent from the client to the server to list project-wide symbols matching the query string.
    **/
    var WorkspaceSymbols : Request<WorkspaceSymbolParams,Array<SymbolInformation>,Void> = "workspace/symbol";

    /**
        The code action request is sent from the client to the server to compute commands for a given text document and range.
        The request is trigger when the user moves the cursor into an problem marker in the editor or presses the lightbulb associated with a marker.
    **/
    var CodeAction : Request<CodeActionParams,Array<Command>,Void> = "textDocument/codeAction";

    /**
        The code lens request is sent from the client to the server to compute code lenses for a given text document.
    **/
    var CodeLens : Request<CodeLensParams,Array<CodeLens>,Void> = "textDocument/codeLens";

    /**
        The code lens resolve request is sent from the clien to the server to resolve the command for a given code lens item.
    **/
    var CodeLensResolve : Request<CodeLens,CodeLens,Void> = "codeLens/resolve";

    /**
        The document formatting resquest is sent from the server to the client to format a whole document.
    **/
    var DocumentFormatting : Request<DocumentFormattingParams,Array<TextEdit>,Void> = "textDocument/formatting";

    /**
        The document range formatting request is sent from the client to the server to format a given range in a document.
    **/
    var DocumentOnTypeFormatting : Request<DocumentOnTypeFormattingParams,Array<TextEdit>,Void> = "textDocument/onTypeFormatting";

    /**
        The document on type formatting request is sent from the client to the server to format parts of the document during typing.
    **/
    var Rename : Request<RenameParams,WorkspaceEdit,Void> = "textDocument/rename";    
}

typedef InitializeParams = {
    /**
        The process Id of the parent process that started the server.
    **/
    var processId:Int;

    /**
        The rootPath of the workspace.
        Is `null` if no folder is open.
    **/
    var rootPath:Null<String>;

    /**
        The capabilities provided by the client (editor).
    **/
    var capabilities:ClientCapabilities;
}

typedef InitializeResult = {
    /**
        The capabilities the language server provides.
    **/
    var capabilities:ServerCapabilities;
}

typedef InitializeError = {
    /**
        Indicates whether the client should retry to send the initilize request
        after showing the message provided in the `ResponseError`.
    **/
    var retry:Bool;
}

typedef ClientCapabilities = {} // unspecified

/**
    Defines how the host (editor) should sync document changes to the language server.
**/
@:enum abstract TextDocumentSyncKind(Int) {
    /**
        Documents should not be synced at all.
    **/
    var None = 0;

    /**
        Documents are synced by always sending the full content of the document.
    **/
    var Full = 1;

    /**
        Documents are synced by sending the full content on open.
        After that only incremental updates to the document are send.
    **/
    var Incremental = 2;
}

typedef CompletionOptions = {
    /**
        The server provides support to resolve additional information for a completion item.
    **/
    @:optional var resolveProvider:Bool;

    /**
        The characters that trigger completion automatically.
    **/
    @:optional var triggerCharacters:Array<String>;
}

typedef SignatureHelpOptions = {
    /**
        The characters that trigger signature help automatically.
    **/
    @:optional var triggerCharacters:Array<String>;
}

typedef CodeLensOptions = {
    /**
        Code lens has a resolve provider as well.
    **/
    @:optional var resolveProvider:Bool;
}

typedef DocumentOnTypeFormattingOptions = {
    /**
        A character on which formatting should be triggered, like `}`.
    **/
    var firstTriggerCharacter:String;

    /**
        More trigger characters.
    **/
    @:optional var moreTriggerCharacter:Array<String>;
}

typedef ServerCapabilities = {
    /**
        Defines how text documents are synced.
    **/
    @:optional var textDocumentSync:TextDocumentSyncKind;

    /**
        The server provides hover support.
    **/
    @:optional var hoverProvider:Bool;

    /**
        The server provides completion support.
    **/
    @:optional var completionProvider:CompletionOptions;

    /**
        The server provides signature help support.
    **/
    @:optional var signatureHelpProvider:SignatureHelpOptions;

    /**
        The server provides goto definition support.
    **/
    @:optional var definitionProvider:Bool;

    /**
        The server provides find references support.
    **/
    @:optional var referencesProvider:Bool;

    /**
        The server provides document highlight support.
    **/
    @:optional var documentHighlightProvider:Bool;

    /**
        The server provides document symbol support.
    **/
    @:optional var documentSymbolProvider:Bool;

    /**
        The server provides workspace symbol support.
    **/
    @:optional var workspaceSymbolProvider:Bool;

    /**
        The server provides code actions.
    **/
    @:optional var codeActionProvider:Bool;

    /**
        The server provides code lens.
    **/
    @:optional var codeLensProvider:CodeLensOptions;

    /**
        The server provides document formatting.
    **/
    @:optional var documentFormattingProvider:Bool;

    /**
        The server provides document range formatting.
    **/
    @:optional var documentRangeFormattingProvider:Bool;

    /**
        The server provides document formatting on typing.
    **/
    @:optional var documentOnTypeFormattingProvider:DocumentOnTypeFormattingOptions;

    /**
        The server provides rename support.
    **/
    @:optional var renameProvider:Bool;
}

typedef ShowMessageParams = {
    /**
        The message type.
    **/
    var type:MessageType;

    /**
        The actual message.
    **/
    var message:String;
}

@:enum abstract MessageType(Int) to Int {
    var Error = 1;
    var Warning = 2;
    var Info = 3;
    var Log = 4;
}

typedef LogMessageParams = {
    /**
        The message type.
    **/
    var type:MessageType;

    /**
        The actual message.
    **/
    var message:String;
}

typedef DidChangeConfigurationParams = {
    /**
        The actual changed settings.
    **/
    var settings:Dynamic;
}

typedef DidOpenTextDocumentParams = {
    >TextDocumentIdentifier,

    /**
        The document that was opened.
    **/
    var textDocument:TextDocumentItem;
}

typedef DidChangeTextDocumentParams = {
    /**
        The document that did change.
        The version number points to the version after all provided content changes have been applied.
    **/
    var textDocument:VersionedTextDocumentIdentifier;

    /**
        The actual content changes.
    **/
    var contentChanges:Array<TextDocumentContentChangeEvent>;
}

/**
    An event describing a change to a text document.
    If `range` and `rangeLength` are omitted the new text is considered to be the full content of the document.
**/
typedef TextDocumentContentChangeEvent = {
    /**
        The range of the document that changed.
    **/
    @:optional var range:Range;

    /**
        The length of the range that got replaced.
    **/
    @:optional var rangeLength:Int;

    /**
        The new text of the document.
    **/
    var text:String;
}

typedef DidCloseTextDocumentParams = {
    /**
        The document that was closed.
    **/
    var textDocument:TextDocumentIdentifier;
}

typedef DidSaveTextDocumentParams = {
    /**
        The document that was saved.
    **/
    var textDocument:TextDocumentIdentifier;
}

typedef DidChangeWatchedFilesParams = {
    /**
        The actual file events.
    **/
    var changes:Array<FileEvent>;
}

/**
    The file event type.
**/
@:enum abstract FileChangeType(Int) to Int {
    var Created = 1;
    var Changed = 2;
    var Deleted = 3;
}

/**
    An event describing a file change.
**/
typedef FileEvent = {
    /**
        The file's uri.
    **/
    var uri:String;

    /**
        The change type.
    **/
    var type:FileChangeType;
}

typedef PublishDiagnosticsParams = {
    /**
        The URI for which diagnostic information is reported.
    **/
    var uri:String;

    /**
        An array of diagnostic information items.
    **/
    var diagnostics:Array<Diagnostic>;
}

typedef CompletionItem = {
    /**
        The label of this completion item.
        By default also the text that is inserted when selecting this completion.
    **/
    var label:String;

    /**
        The kind of this completion item.
        Based of the kind an icon is chosen by the editor.
    **/
    @:optional var kind:CompletionItemKind;

    /**
        A human-readable string with additional information about this item, like type or symbol information.
    **/
    @:optional var detail:String;

    /**
        A human-readable string that represents a doc-comment.
    **/
    @:optional var documentation:String;

    /**
        A string that shoud be used when comparing this item with other items.
        When `falsy` the label is used.
    **/
    @:optional var sortText:String;

    /**
        A string that should be used when filtering a set of completion items.
        When `falsy` the label is used.
    **/
    @:optional var filterText:String;

    /**
        A string that should be inserted a document when selecting this completion.
        When `falsy` the label is used.
    **/
    @:optional var insertText:String;

    /**
        An edit which is applied to a document when selecting this completion.
        When an edit is provided the value of `insertText` is ignored.
    **/
    @:optional var textEdit:TextEdit;

    /**
        An data entry field that is preserved on a completion item between a completion and a completion resolve request.
    **/
    @:optional var data:Dynamic;
}

/**
    The kind of a completion entry.
**/
@:enum abstract CompletionItemKind(Int) to Int {
    var Text = 1;
    var Method = 2;
    var Function = 3;
    var Constructor = 4;
    var Field = 5;
    var Variable = 6;
    var Class = 7;
    var Interface = 8;
    var Module = 9;
    var Property = 10;
    var Unit = 11;
    var Value = 12;
    var Enum = 13;
    var Keyword = 14;
    var Snippet = 15;
    var Color = 16;
    var File = 17;
    var Reference = 18;
}

typedef MarkedString = EitherType<String,{language:String, value:String}>;

typedef Hover = {
    var contents:EitherType<MarkedString,Array<MarkedString>>;
    @:optional var range:Range;
}

typedef SignatureHelp = {
    var signatures:Array<SignatureInformation>;
    @:optional var activeSignature:Int;
    @:optional var activeParameter:Int;
}

typedef SignatureInformation = {
    var label:String;
    @:optional var documentation:String;
    @:optional var parameters:Array<ParameterInformation>;
}

typedef ParameterInformation = {
    var label:String;
    @:optional var documentation:String;
}

typedef ReferenceParams = {
    >TextDocumentPositionParams,
    var context:ReferenceContext;
}

typedef ReferenceContext = {
    var includeDeclaration:Bool;
}

typedef DocumentHighlight = {
    var range:Range;
    @:optional var kind:DocumentHighlightKind;
}

@:enum abstract DocumentHighlightKind(Int) to Int {
    var Text = 1;
    var Read = 2;
    var Write = 3;
}

typedef DocumentSymbolParams = {
    var textDocument:TextDocumentIdentifier;
}

typedef SymbolInformation = {
    var name:String;
    var kind:SymbolKind;
    var location:Location;
    @:optional var containerName:String;
}

@:enum abstract SymbolKind(Int) to Int {
    var File = 1;
    var Module = 2;
    var Namespace = 3;
    var Package = 4;
    var Class = 5;
    var Method = 6;
    var Property = 7;
    var Field = 8;
    var Constructor = 9;
    var Enum = 10;
    var Interface = 11;
    var Function = 12;
    var Variable = 13;
    var Constant = 14;
    var String = 15;
    var Number = 16;
    var Boolean = 17;
    var Array = 18;
}

typedef WorkspaceSymbolParams = {
    var query:String;
}

typedef CodeActionParams = {
    var textDocument:TextDocumentIdentifier;
    var range:Range;
    var context:CodeActionContext;
}

typedef CodeActionContext = {
    var diagnostics:Array<Diagnostic>;
}

typedef CodeLensParams = {
    var textDocument:TextDocumentIdentifier;
}

typedef CodeLens = {
    var range:Range;
    @:optional var command:Command;
    @:optional var data:Dynamic;
}

typedef DocumentFormattingParams = {
    var textDocument:TextDocumentIdentifier;
    var options:FormattingOptions;
}

typedef FormattingOptions = {
    var tabSize:Int;
    var insertSpaces:Bool;
}

typedef DocumentOnTypeFormattingParams = {
    var textDocument:TextDocumentIdentifier;
    var position:Position;
    var ch:String;
    var options:FormattingOptions;
}

typedef RenameParams = {
    var textDocument:TextDocumentIdentifier;
    var position:Position;
    var newName:String;
}