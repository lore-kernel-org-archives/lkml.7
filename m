Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8322C74A42
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 03:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD34C21019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 03:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbfGKDZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 23:25:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:46430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfGKDZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 23:25:01 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81CB0206B8;
        Thu, 11 Jul 2019 03:24:59 +0000 (UTC)
Date:   Wed, 10 Jul 2019 23:24:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, bp@alien8.de, mingo@kernel.org,
        luto@kernel.org, torvalds@linux-foundation.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, zhe.he@windriver.com,
        joel@joelfernandes.org, devel@etsukata.com
Subject: Re: [PATCH v2 6/7] x86/entry/64: Remove TRACE_IRQS_*_DEBUG
Message-ID: <20190710232456.5f2de961@oasis.local.home>
In-Reply-To: <20190704200050.591915266@infradead.org>
References: <20190704195555.580363209@infradead.org>
        <20190704200050.591915266@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Jul 2019 21:56:01 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Since INT3/#BP no longer runs on an IST, this workaround is no longer
> required.
> 
> Tested by running lockdep+ftrace as described in the initial commit:
> 
>   5963e317b1e9 ("ftrace/x86: Do not change stacks in DEBUG when calling lockdep")

It looks like a clean revert, and it passed my ftrace smoke tests with
lockdep enabled (although I triggered a locked warning unrelated to
this, with the text_mutex and module_mutex, but I'm hoping my tree has
the fixes for that).

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Hmm, does this mean we can remove the IDT switching in the NMI handler
as well?

-- Steve


> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/entry/entry_64.S |   46 ++--------------------------------------------
>  1 file changed, 2 insertions(+), 44 deletions(-)
> 
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -68,44 +68,6 @@ END(native_usergs_sysret64)
>  .endm
>  
>  /*
> - * When dynamic function tracer is enabled it will add a breakpoint
> - * to all locations that it is about to modify, sync CPUs, update
> - * all the code, sync CPUs, then remove the breakpoints. In this time
> - * if lockdep is enabled, it might jump back into the debug handler
> - * outside the updating of the IST protection. (TRACE_IRQS_ON/OFF).
> - *
> - * We need to change the IDT table before calling TRACE_IRQS_ON/OFF to
> - * make sure the stack pointer does not get reset back to the top
> - * of the debug stack, and instead just reuses the current stack.
> - */
> -#if defined(CONFIG_DYNAMIC_FTRACE) && defined(CONFIG_TRACE_IRQFLAGS)
> -
> -.macro TRACE_IRQS_OFF_DEBUG
> -	call	debug_stack_set_zero
> -	TRACE_IRQS_OFF
> -	call	debug_stack_reset
> -.endm
> -
> -.macro TRACE_IRQS_ON_DEBUG
> -	call	debug_stack_set_zero
> -	TRACE_IRQS_ON
> -	call	debug_stack_reset
> -.endm
> -
> -.macro TRACE_IRQS_IRETQ_DEBUG
> -	btl	$9, EFLAGS(%rsp)		/* interrupts off? */
> -	jnc	1f
> -	TRACE_IRQS_ON_DEBUG
> -1:
> -.endm
> -
> -#else
> -# define TRACE_IRQS_OFF_DEBUG			TRACE_IRQS_OFF
> -# define TRACE_IRQS_ON_DEBUG			TRACE_IRQS_ON
> -# define TRACE_IRQS_IRETQ_DEBUG			TRACE_IRQS_IRETQ
> -#endif
> -
> -/*
>   * 64-bit SYSCALL instruction entry. Up to 6 arguments in registers.
>   *
>   * This is the only entry point used for 64-bit system calls.  The
> @@ -879,11 +841,7 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
>  	GET_CR2_INTO(%rdx);			/* can clobber %rax */
>  	.endif
>  
> -	.if \shift_ist != -1
> -	TRACE_IRQS_OFF_DEBUG			/* reload IDT in case of recursion */
> -	.else
>  	TRACE_IRQS_OFF
> -	.endif
>  
>  	.if \paranoid == 0
>  	testb	$3, CS(%rsp)
> @@ -1292,7 +1250,7 @@ END(paranoid_entry)
>  ENTRY(paranoid_exit)
>  	UNWIND_HINT_REGS
>  	DISABLE_INTERRUPTS(CLBR_ANY)
> -	TRACE_IRQS_OFF_DEBUG
> +	TRACE_IRQS_OFF
>  
>  	/* Handle GS depending on FSGSBASE availability */
>  	ALTERNATIVE "jmp .Lparanoid_exit_checkgs", "nop",X86_FEATURE_FSGSBASE
> @@ -1312,7 +1270,7 @@ ENTRY(paranoid_exit)
>  	jmp	.Lparanoid_exit_restore
>  
>  .Lparanoid_exit_no_swapgs:
> -	TRACE_IRQS_IRETQ_DEBUG
> +	TRACE_IRQS_IRETQ
>  	/* Always restore stashed CR3 value (see paranoid_entry) */
>  	RESTORE_CR3	scratch_reg=%rbx save_reg=%r14
>  
> 

