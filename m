Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C23C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 731CB206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfKNPfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 10:35:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:53792 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726339AbfKNPfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 10:35:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 131ECAC18;
        Thu, 14 Nov 2019 15:35:02 +0000 (UTC)
Date:   Thu, 14 Nov 2019 16:34:58 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Steven Rostedt <rostedt@goodmis.org>
cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
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
Subject: Re: [PATCH 09/10] ftrace/x86: Add register_ftrace_direct() for custom
 trampolines
In-Reply-To: <20191108213450.891579507@goodmis.org>
Message-ID: <alpine.LSU.2.21.1911141627300.20723@pobox.suse.cz>
References: <20191108212834.594904349@goodmis.org> <20191108213450.891579507@goodmis.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Nov 2019, Steven Rostedt wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Enable x86 to allow for register_ftrace_direct(), where a custom trampoline
> may be called directly from an ftrace mcount/fentry location.
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

[...]

> +++ b/arch/x86/kernel/ftrace_64.S
> @@ -88,6 +88,7 @@ EXPORT_SYMBOL(__fentry__)
>  	movq %rdi, RDI(%rsp)
>  	movq %r8, R8(%rsp)
>  	movq %r9, R9(%rsp)
> +	movq $0, ORIG_RAX(%rsp)
>  	/*
>  	 * Save the original RBP. Even though the mcount ABI does not
>  	 * require this, it helps out callers.
> @@ -114,7 +115,8 @@ EXPORT_SYMBOL(__fentry__)
>  	subq $MCOUNT_INSN_SIZE, %rdi
>  	.endm
>  
> -.macro restore_mcount_regs
> +.macro restore_mcount_regs save=0
> +
>  	movq R9(%rsp), %r9
>  	movq R8(%rsp), %r8
>  	movq RDI(%rsp), %rdi
> @@ -123,10 +125,7 @@ EXPORT_SYMBOL(__fentry__)
>  	movq RCX(%rsp), %rcx
>  	movq RAX(%rsp), %rax
>  
> -	/* ftrace_regs_caller can modify %rbp */
> -	movq RBP(%rsp), %rbp
> -
> -	addq $MCOUNT_REG_SIZE, %rsp
> +	addq $MCOUNT_REG_SIZE-\save, %rsp
>  
>  	.endm
>  
> @@ -228,10 +227,30 @@ GLOBAL(ftrace_regs_call)
>  	movq R10(%rsp), %r10
>  	movq RBX(%rsp), %rbx
>  
> -	restore_mcount_regs
> +	movq RBP(%rsp), %rbp
> +
> +	movq ORIG_RAX(%rsp), %rax
> +	movq %rax, MCOUNT_REG_SIZE-8(%rsp)
> +
> +	/* If ORIG_RAX is anything but zero, make this a call to that */
> +	movq ORIG_RAX(%rsp), %rax
> +	cmpq	$0, %rax
> +	je	1f
> +
> +	/* Swap the flags with orig_rax */
> +	movq MCOUNT_REG_SIZE(%rsp), %rdi
> +	movq %rdi, MCOUNT_REG_SIZE-8(%rsp)
> +	movq %rax, MCOUNT_REG_SIZE(%rsp)
> +
> +	restore_mcount_regs 8
> +
> +	jmp	2f
> +
> +1:	restore_mcount_regs
> +
>  
>  	/* Restore flags */
> -	popfq
> +2:	popfq

If I am reading the code correctly (and I was confused couple of times, so 
maybe I am not), this is what makes the direct fops incompatible with 
ipmodify and livepatching for now. Is that correct?

What are your plans regarding this?

Moreover, we could replace ftrace_regs_caller with direct fops for live 
patching when this is merged with all arch support we need. After all, all 
we need is to change the rip, which we could do easily in the direct 
trampoline. On the other hand, it would exclude coexistence of a live 
patch and a BPF filter (both direct now) on one function.

I may have missed something though.

Thanks
Miroslav
