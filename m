Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E1AC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 08:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B9C2063F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 08:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfHPIrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 04:47:51 -0400
Received: from smtprelay0082.hostedemail.com ([216.40.44.82]:34792 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726753AbfHPIrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 04:47:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 8FC5618224D6E;
        Fri, 16 Aug 2019 08:47:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: spot41_26fea4e843a48
X-Filterd-Recvd-Size: 4132
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Fri, 16 Aug 2019 08:47:47 +0000 (UTC)
Message-ID: <dc21098f97f864523df808797c49c734e07e1cfb.camel@perches.com>
Subject: Re: [PATCH] Makefile: Convert -Wimplicit-fallthrough=3 to just
 -Wimplicit-fallthrough for clang
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vivien Didelot <vivien.didelot@gmail.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Date:   Fri, 16 Aug 2019 01:47:46 -0700
In-Reply-To: <128728a0965240aa5b68970d7721d857176ae7cd.camel@perches.com>
References: <c0005a09c89c20093ac699c97e7420331ec46b01.camel@perches.com>
         <9c7a79b4d21aea52464d00c8fa4e4b92638560b6.camel@perches.com>
         <CAHk-=wiL7jqYNfYrNikgBw3byY+Zn37-8D8yR=WUu0x=_2BpZA@mail.gmail.com>
         <6a5f470c1375289908c37632572c4aa60d6486fa.camel@perches.com>
         <20190811020442.GA22736@archlinux-threadripper>
         <871efd6113ee2f6491410409511b871b7637f9e3.camel@perches.com>
         <CAKwvOdmAj34xDcMUn7Fu_aXdtD-7xHjHuU20qY=rFcr_Kz7gpg@mail.gmail.com>
         <CANiq72m5=pqHaNi3P5VAMviaoX6yxT7OPg6sys1uMDki0g2bOw@mail.gmail.com>
         <128728a0965240aa5b68970d7721d857176ae7cd.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(adding Vivien Didelot for vim)

On Wed, 2019-08-14 at 19:44 -0700, Joe Perches wrote:
> On Tue, 2019-08-13 at 14:44 +0200, Miguel Ojeda wrote:
> > Hm... I would go for either __fallthrough as the rest of attributes,
> > or simply fallthrough -- FALLTHROUGH seems wrong. If you want it that
> > way for visibility, then I would choose __fallthrough, since the
> > underscores are quite prominent and anyway IDEs typically highlight
> > macros in a different color than keywords (return etc.).
> 
> Just fyi:
> 
> I added this line to my .emacs and "fallthrough" is now
> syntax highlighted like every other keyword.
> 
>   (font-lock-add-keywords 'c-mode
> 			'(("\\<\\(fallthrough\\)\\>" . font-lock-keyword-face)))
> 
> So now my linux-c-mode block is:
> 
> (defun linux-c-mode ()
>   "C mode with adjusted defaults for use with the Linux kernel."
>   (interactive)
>   (font-lock-add-keywords 'c-mode
> 			'(("\\<\\(fallthrough\\)\\>" . font-lock-keyword-face)))
>   (c-mode)
>   (c-set-style "K&R")
>   (setq c-basic-offset 8)
>   (setq c-indent-level 8)
>   (setq c-brace-imaginary-offset 0)
>   (setq c-brace-offset -8)
>   (setq c-argdecl-indent 8)
>   (setq c-label-offset -8)
>   (setq c-continued-statement-offset 8)
>   (setq indent-tabs-mode t)
>   (setq tab-width 8)
>   (setq show-trailing-whitespace t)
>   )
> 
> I don't know to do that for vim nor any other ide,
> but I trust someone will know and show how it's done.

I investigated vim a bit as I am not a vim user.

If this is the most commonly used vim style,
perhaps a reference to this style could be added
to Documentation/process/coding-style.rst

https://github.com/vivien/vim-linux-coding-style

I had thought that
	syn keyword cKeyword fallthrough
would work, but it does not add syntax coloring
	syn keyword cStatement fallthrough
does through.

If ~.vim/plugin/linuxsty.vim is commonly used, maybe
---
 plugin/linuxsty.vim | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugin/linuxsty.vim b/plugin/linuxsty.vim
index 18b2867..44824b8 100644
--- a/plugin/linuxsty.vim
+++ b/plugin/linuxsty.vim
@@ -69,6 +69,7 @@ function s:LinuxFormatting()
 endfunction
 
 function s:LinuxKeywords()
+    syn keyword cStatement fallthrough
     syn keyword cOperator likely unlikely
     syn keyword cType u8 u16 u32 u64 s8 s16 s32 s64
     syn keyword cType __u8 __u16 __u32 __u64 __s8 __s16 __s32 __s64


