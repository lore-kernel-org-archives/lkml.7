Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AA3C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 12:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC6FC20989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 12:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BbdHQHOT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbfEHMEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 08:04:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53426 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbfEHMEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 08:04:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=a4N5d3+J61zEDzUpaHhBlkj2KG/wlTG6nB4CxBf7TaY=; b=BbdHQHOTPB6xFc6bCqoYQED5j
        rtNPCDjTaX0yyk9wuTFPSvTjzz7MMpdmMzq3d8bucAspIGuxMNBAdR2jDrhFMA8WA60yVWSh5u2yE
        AG8B9ucMoe14oAsSs+AJk6Ptc4vE+m6lbnRUagcxJQuyP3j1Qu9o8SacF4syS6//WvKXvYXtcBUpS
        Nz3aSiiohUvJCvFQO+4FeGUO+9rEANKIiMPfTvQIWFgskSAb+sgUgoqeIz34t+zHZV2NfdaXfcEhv
        swkGxNjqsYLb0rnlrl9PVGyxIUj88H5MkGMBGMQ6Vz8ExQA/X0xVsYPoHh4553aEcV9CxZikaaX5r
        8E5SZGohw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOLJ4-0004TC-BS; Wed, 08 May 2019 12:04:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D0BE92029F882; Wed,  8 May 2019 14:04:16 +0200 (CEST)
Date:   Wed, 8 May 2019 14:04:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joerg Roedel <jroedel@suse.de>,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 2/4] x86/kprobes: Fix frame pointer annotations
Message-ID: <20190508120416.GL2589@hirez.programming.kicks-ass.net>
References: <20190508074901.982470324@infradead.org>
 <20190508080612.721269814@infradead.org>
 <20190508115416.nblx7c2kocidpytm@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508115416.nblx7c2kocidpytm@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 06:54:16AM -0500, Josh Poimboeuf wrote:
> On Wed, May 08, 2019 at 09:49:03AM +0200, Peter Zijlstra wrote:
> > The kprobe trampolines have a FRAME_POINTER annotation that makes no
> > sense. It marks the frame in the middle of pt_regs, at the place of
> > saving BP.
> > 
> > Change it to mark the pt_regs frame as per the ENCODE_FRAME_POINTER
> > from the respective entry_*.S.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/x86/kernel/kprobes/common.h |   32 +++++++++++++++++++++++---------
> >  1 file changed, 23 insertions(+), 9 deletions(-)
> > 
> > --- a/arch/x86/kernel/kprobes/common.h
> > +++ b/arch/x86/kernel/kprobes/common.h
> > @@ -6,14 +6,15 @@
> >  
> >  #include <asm/asm.h>
> >  
> > +#ifdef CONFIG_X86_64
> > +
> >  #ifdef CONFIG_FRAME_POINTER
> > -# define SAVE_RBP_STRING "	push %" _ASM_BP "\n" \
> > -			 "	mov  %" _ASM_SP ", %" _ASM_BP "\n"
> > +#define ENCODE_FRAME_POINTER			\
> > +	"	leaq 1(%rsp), %rbp\n"
> >  #else
> > -# define SAVE_RBP_STRING "	push %" _ASM_BP "\n"
> > +#define ENCODE_FRAME_POINTER
> >  #endif
> 
> > +#ifdef CONFIG_FRAME_POINTER
> > +#define ENCODE_FRAME_POINTER			\
> > +	"	movl %esp, %ebp\n"		\
> > +	"	andl $0x7fffffff, %ebp\n"
> > +#else
> > +#define ENCODE_FRAME_POINTER
> > +#endif
> 
> We should put these macros in a header file somewhere (including
> stringified versions).

Probably a good idea. I'll frob them into asm/frame.h.

Do the x86_64 variants also want some ORC annotation?
