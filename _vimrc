set nocompatible

" Sourced from $VIMRUNTIME/vimrc_example.vim
if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  " Commented out because this is annoying
  "autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif


source $VIMRUNTIME/mswin.vim

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction


" My vimrc changes - line numbers, window size, wrap by words, font/color
set number
set lines=45 columns=140
set linebreak
colorscheme monokai

" Remove GVIM GUI chrome, change font, remove scrollbars, and suppress GUI popups
if has ("gui_running")
  set guifont=Consolas
  set guioptions-=T  " remove toolbar
  set guioptions-=m  " remove menubar
  set guioptions+=c  " use console-like dialogs, not graphical popups
  set guioptions-=l  " remove scrollbars
  set guioptions-=L
  set guioptions-=r
  set guioptions-=R
  set guioptions-=b
endif

" Indentation settings, using spaces for tabs
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent

" make ctrl-backspace delete back a word (like ctrl-w) and ctrl-delete work
imap <C-BS> <C-W>
imap <C-Del> <C-O>de

" Cycle through open buffers, including hidden, using ctrl-n and ctrl-p
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>
set hidden

" When switching buffers and paging through a file, do not automatically
" switch to first non-whitespace character on the line
set nostartofline

" Changes recommended by Steve Losh http://stevelosh.com/blog/2010/09/coming-home-to-vim
set encoding=utf-8
set showmode
set wildmenu
set wildmode=list:longest
set ttyfast
set laststatus=2
set ignorecase
set smartcase
set showmatch
set hlsearch

" Instead of failing a command because of unsaved changes, instead raise a dialogue asking if you wish to save changed files.
set confirm

" Set the command window height to 2 lines, to avoid many cases of having to press <Enter> to continue
"set cmdheight=2

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Use <F11> to toggle between 'paste' and 'nopaste' - mode that allows pasting without changing formatting/indenting
"set pastetoggle=<F11>

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy, which is the default
map Y y$

" Turn beeping and visual bell off
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

"  <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohlsearch<CR><C-l>

" Pathogen-required vimrc line
execute pathogen#infect()

" change MiniBufExpl terrible pink block for ActiveChanged
hi link MBEVisibleActiveChanged MBEVisibleActiveNormal
hi link MBEVisibleChanged MBEChanged

" Showing taglist plugin where exuberant ctags is located
"let Tlist_Ctags_Cmd='"C:\ctags58\ctags.exe"'

" change starting directory
cd C:\
