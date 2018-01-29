syntax on
set background=dark
set encoding=utf-8
"colorscheme solarized
set term=screen-256color

"if has('mouse')
"	set mouse=a
"endif

set tabstop=2
set softtabstop=2
set ts=2
set shiftwidth=2
set expandtab
set cursorline
set number relativenumber
set smartindent

set backspace=eol,start,indent
set whichwrap+=<,>

"开始使用Vundle的必须配置
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
set path+=~/Library/Haskell/bin/
autocmd BufEnter *.hs set formatprg=pointfree
autocmd BufNewFile,BufRead *.y set syntax=happy

call vundle#begin()

"使用Vundle来管理Vundle
Plugin 'gmarik/vundle'

"PowerLine插件 状态栏增强展示
Plugin 'Lokaltog/vim-powerline'
"vim有一个状态栏 加上powline则有两个状态栏
set laststatus=2
set t_Co=256
let g:Powline_symbols='fancy'

"Vundle配置必须 开启插件
filetype plugin indent on

Plugin 'Valloric/YouCompleteMe'
let g:ycm_auto_trigger = 1
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'
"自动语法检测插件
Plugin 'scrooloose/syntastic'
"Recommended Setting
map <Leader>s :SyntasticToggleMode<CR>
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"let g:syntastic_haskell_checkers = []

Plugin 'rdnetto/YCM-Generator'

Plugin 'jez/vim-ispc'
:setf ispc

Plugin 'rhysd/vim-clang-format'

Plugin 'tikhomirov/vim-glsl'

Plugin 'ctrlpvim/ctrlp.vim'

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'

Plugin 'scrooloose/nerdtree'

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

map <C-n> :NERDTreeToggle<CR>

Plugin 'eagletmt/ghcmod-vim', {'for': 'haskell'}
Plugin 'Shougo/vimproc.vim', {'do': 'make'}
Plugin 'Shougo/neocomplete.vim', {'for': 'haskell'}
"Plugin 'eagletmt/neco-ghc', {'for': 'haskell'}

let g:ghcmod_ghc_options = ['-isrc', '-idist/build/autogen', '-fno-warn-missing-signatures']
let g:ghcmod_hlint_options = ['--ignore=Redundant $']
" Async checking on write
" autocmd BufWritePost *.hs GhcModCheckAndLintAsync

Plugin 'godlygeek/tabular'

let g:haskell_tabular = 1

vmap a= :Tabularize /=<CR>
vmap a; :Tabularize /::<CR>
vmap a- :Tabularize /-><CR>

Plugin 'scrooloose/nerdcommenter'
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

Plugin 'majutsushi/tagbar'
nmap <C-t> :TagbarToggle<CR>

Plugin 'Saul-Mirone/lushtags-fix'
Plugin 'MarcWeber/hasktags'

Plugin 'mkasa/neco-ghc-lushtags', {'for': 'haskell'}

" Use neco-ghc for completion
let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
let g:ycm_semantic_triggers = {'haskell' : ['.']}
let g:necoghc_enable_detailed_browse = 1

"Plugin 'brookHong/cscope.vim'

nnoremap <leader>fa :call CscopeFindInteractive(expand('<cword>'))<CR>
nnoremap <leader>l :call ToggleLocationList()<CR>

" s: Find this C symbol
nnoremap  <leader>fs :call CscopeFind('s', expand('<cword>'))<CR>
" g: Find this definition
nnoremap  <leader>fg :call CscopeFind('g', expand('<cword>'))<CR>
" d: Find functions called by this function
nnoremap  <leader>fd :call CscopeFind('d', expand('<cword>'))<CR>
" c: Find functions calling this function
nnoremap  <leader>fc :call CscopeFind('c', expand('<cword>'))<CR>
" t: Find this text string
nnoremap  <leader>ft :call CscopeFind('t', expand('<cword>'))<CR>
" e: Find this egrep pattern
nnoremap  <leader>fe :call CscopeFind('e', expand('<cword>'))<CR>
" f: Find this file
nnoremap  <leader>ff :call CscopeFind('f', expand('<cword>'))<CR>
" i: Find files #including this file
nnoremap  <leader>fi :call CscopeFind('i', expand('<cword>'))<CR>
filetype plugin indent on   

set tags=./tags,./TAGS,tags;~,TAGS;~

au BufEnter /home/my/proj1/* setlocal tags+=/home/my/proj1/tags

set clipboard=unnamedplus

" Add maktaba and codefmt to the runtimepath.
" (The latter must be installed before it can be used.)
Plugin 'google/vim-maktaba'
Plugin 'google/vim-codefmt'
" Also add Glaive, which is used to configure codefmt's maktaba flags. See
" `:help :Glaive` for usage.
Plugin 'google/vim-glaive'
call vundle#end()
" the glaive#Install() should go after the "call vundle#end()"
call glaive#Install()
" Optional: Enable codefmt's default mappings on the <Leader>= prefix.
Glaive codefmt plugin[mappings]
Glaive codefmt google_java_executable="java -jar /path/to/google-java-format-VERSION-all-deps.jar"

augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType html,css,json AutoFormatBuffer js-beautify
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer yapf
  " Alternative: autocmd FileType python AutoFormatBuffer autopep8
augroup END
