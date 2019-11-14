Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6EDC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 16:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718CE20715
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 16:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfKNQT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 11:19:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:43262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbfKNQT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 11:19:56 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9513720672;
        Thu, 14 Nov 2019 16:19:53 +0000 (UTC)
Date:   Thu, 14 Nov 2019 11:19:52 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        X86 ML <x86@kernel.org>, Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 09/10] ftrace/x86: Add register_ftrace_direct() for
 custom trampolines
Message-ID: <20191114111952.3eb1a011@gandalf.local.home>
In-Reply-To: <alpine.LSU.2.21.1911141627300.20723@pobox.suse.cz>
References: <20191108212834.594904349@goodmis.org>
        <20191108213450.891579507@goodmis.org>
        <alpine.LSU.2.21.1911141627300.20723@pobox.suse.cz>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2019 16:34:58 +0100 (CET)
Miroslav Benes <mbenes@suse.cz> wrote:

> On Fri, 8 Nov 2019, Steven Rostedt wrote:
> 
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > 
> > Enable x86 to allow for register_ftrace_direct(), where a custom trampoline
> > may be called directly from an ftrace mcount/fentry location.
> > 
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>  
> 
> [...]
> 
> > +++ b/arch/x86/kernel/ftrace_64.S
> > @@ -88,6 +88,7 @@ EXPORT_SYMBOL(__fentry__)
> >  	movq %rdi, RDI(%rsp)
> >  	movq %r8, R8(%rsp)
> >  	movq %r9, R9(%rsp)
> > +	movq $0, ORIG_RAX(%rsp)
> >  	/*
> >  	 * Save the original RBP. Even though the mcount ABI does not
> >  	 * require this, it helps out callers.
> > @@ -114,7 +115,8 @@ EXPORT_SYMBOL(__fentry__)
> >  	subq $MCOUNT_INSN_SIZE, %rdi
> >  	.endm
> >  
> > -.macro restore_mcount_regs
> > +.macro restore_mcount_regs save=0
> > +
> >  	movq R9(%rsp), %r9
> >  	movq R8(%rsp), %r8
> >  	movq RDI(%rsp), %rdi
> > @@ -123,10 +125,7 @@ EXPORT_SYMBOL(__fentry__)
> >  	movq RCX(%rsp), %rcx
> >  	movq RAX(%rsp), %rax
> >  
> > -	/* ftrace_regs_caller can modify %rbp */
> > -	movq RBP(%rsp), %rbp
> > -
> > -	addq $MCOUNT_REG_SIZE, %rsp
> > +	addq $MCOUNT_REG_SIZE-\save, %rsp
> >  
> >  	.endm
> >  
> > @@ -228,10 +227,30 @@ GLOBAL(ftrace_regs_call)
> >  	movq R10(%rsp), %r10
> >  	movq RBX(%rsp), %rbx
> >  
> > -	restore_mcount_regs
> > +	movq RBP(%rsp), %rbp
> > +
> > +	movq ORIG_RAX(%rsp), %rax
> > +	movq %rax, MCOUNT_REG_SIZE-8(%rsp)
> > +
> > +	/* If ORIG_RAX is anything but zero, make this a call to that */
> > +	movq ORIG_RAX(%rsp), %rax
> > +	cmpq	$0, %rax
> > +	je	1f
> > +
> > +	/* Swap the flags with orig_rax */
> > +	movq MCOUNT_REG_SIZE(%rsp), %rdi
> > +	movq %rdi, MCOUNT_REG_SIZE-8(%rsp)
> > +	movq %rax, MCOUNT_REG_SIZE(%rsp)
> > +
> > +	restore_mcount_regs 8
> > +
> > +	jmp	2f
> > +
> > +1:	restore_mcount_regs
> > +
> >  
> >  	/* Restore flags */
> > -	popfq
> > +2:	popfq  
> 
> If I am reading the code correctly (and I was confused couple of times, so 
> maybe I am not), this is what makes the direct fops incompatible with 
> ipmodify and livepatching for now. Is that correct?

Actually, it's the fact that the return goes to some unknown trampoline
that may do something else as well.

> 
> What are your plans regarding this?

I wanted to see what the eBPF folks were doing, and then perhaps allow
the ip modify occur too. I could let it happen as well now, and then we
can see what the fallout is later ;-)

> 
> Moreover, we could replace ftrace_regs_caller with direct fops for live 
> patching when this is merged with all arch support we need. After all, all 

Note, direct call is currently only available for x86_64.

> we need is to change the rip, which we could do easily in the direct 
> trampoline. On the other hand, it would exclude coexistence of a live 
> patch and a BPF filter (both direct now) on one function.

It may also end up being more complex, and not much of a performance
benefit. I believe the BPF is injecting programs into the start of
functions, but your trampoline for live patching may be not much
different than what ftrace gives you today.

-- Steve
