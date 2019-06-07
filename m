Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5782C468BC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 13:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9272146E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 13:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559913193;
	bh=qO1jD7BqX5Fs0UEytYYLQQLoV21dfFYCTErHKk6Dxdo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=xaHETx8NHXcDsimx6iYwARkHH55VcnUFgdRXWAKp0sI0YpBHJ8vUxG6UrRpgSutZa
	 GBLvDftZM5ioS0mSuwU1AeFoioqwnTvIOj0gLoSzmidTqhl7Li/swgwgymEUq0eADC
	 MB9ayY8cjHmZ8q208DdGnPaSv6ATE3pQxQQD/YyQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbfFGNNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 09:13:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:54386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727963AbfFGNNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:13:11 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8717C208E3;
        Fri,  7 Jun 2019 13:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559913190;
        bh=qO1jD7BqX5Fs0UEytYYLQQLoV21dfFYCTErHKk6Dxdo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E/D8xbM3QiswZmocYmKVXLH5sWlvcMtzpoj+nQSxsMNiWEWBOjxTF62ifJajS7DZ5
         eb1hLCyucWY5mFf+2yXC5DXb9AXRzKLFXwdsq9hMkpn6Lf8dZeUDZI2fcJBKKXsZvB
         KcBRjvaZPJvQlAGzvjA0iMJVz5aBddCj7NzMt0uo=
Date:   Fri, 7 Jun 2019 22:13:03 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 05/15] x86_32: Provide consistent pt_regs
Message-Id: <20190607221303.d35eb454c12fa7bff3f4ce82@kernel.org>
In-Reply-To: <20190605131944.829537410@infradead.org>
References: <20190605130753.327195108@infradead.org>
        <20190605131944.829537410@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Jun 2019 15:07:58 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Currently pt_regs on x86_32 has an oddity in that kernel regs
> (!user_mode(regs)) are short two entries (esp/ss). This means that any
> code trying to use them (typically: regs->sp) needs to jump through
> some unfortunate hoops.
> 
> Change the entry code to fix this up and create a full pt_regs frame.
> 
> This then simplifies various trampolines in ftrace and kprobes, the
> stack unwinder, ptrace, kdump and kgdb.

The kprobes parts are looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/entry/entry_32.S         |  105 ++++++++++++++++++++++++++++++++++----
>  arch/x86/include/asm/kexec.h      |   17 ------
>  arch/x86/include/asm/ptrace.h     |   17 ------
>  arch/x86/include/asm/stacktrace.h |    2 
>  arch/x86/kernel/crash.c           |    8 --
>  arch/x86/kernel/ftrace_32.S       |   77 +++++++++++++++------------
>  arch/x86/kernel/kgdb.c            |    8 --
>  arch/x86/kernel/kprobes/common.h  |    4 -
>  arch/x86/kernel/kprobes/core.c    |   29 ++++------
>  arch/x86/kernel/kprobes/opt.c     |   20 ++++---
>  arch/x86/kernel/process_32.c      |   16 +----
>  arch/x86/kernel/ptrace.c          |   29 ----------
>  arch/x86/kernel/time.c            |    3 -
>  arch/x86/kernel/unwind_frame.c    |   32 +----------
>  arch/x86/kernel/unwind_orc.c      |    2 
>  15 files changed, 178 insertions(+), 191 deletions(-)
> 
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -202,9 +202,102 @@
>  .Lend_\@:
>  .endm
>  
> +#define CS_FROM_ENTRY_STACK	(1 << 31)
> +#define CS_FROM_USER_CR3	(1 << 30)
> +#define CS_FROM_KERNEL		(1 << 29)
> +
> +.macro FIXUP_FRAME
> +	/*
> +	 * The high bits of the CS dword (__csh) are used for CS_FROM_*.
> +	 * Clear them in case hardware didn't do this for us.
> +	 */
> +	andl	$0x0000ffff, 3*4(%esp)
> +
> +#ifdef CONFIG_VM86
> +	testl	$X86_EFLAGS_VM, 4*4(%esp)
> +	jnz	.Lfrom_usermode_no_fixup_\@
> +#endif
> +	testl	$SEGMENT_RPL_MASK, 3*4(%esp)
> +	jnz	.Lfrom_usermode_no_fixup_\@
> +
> +	orl	$CS_FROM_KERNEL, 3*4(%esp)
> +
> +	/*
> +	 * When we're here from kernel mode; the (exception) stack looks like:
> +	 *
> +	 *  5*4(%esp) - <previous context>
> +	 *  4*4(%esp) - flags
> +	 *  3*4(%esp) - cs
> +	 *  2*4(%esp) - ip
> +	 *  1*4(%esp) - orig_eax
> +	 *  0*4(%esp) - gs / function
> +	 *
> +	 * Lets build a 5 entry IRET frame after that, such that struct pt_regs
> +	 * is complete and in particular regs->sp is correct. This gives us
> +	 * the original 5 enties as gap:
> +	 *
> +	 * 12*4(%esp) - <previous context>
> +	 * 11*4(%esp) - gap / flags
> +	 * 10*4(%esp) - gap / cs
> +	 *  9*4(%esp) - gap / ip
> +	 *  8*4(%esp) - gap / orig_eax
> +	 *  7*4(%esp) - gap / gs / function
> +	 *  6*4(%esp) - ss
> +	 *  5*4(%esp) - sp
> +	 *  4*4(%esp) - flags
> +	 *  3*4(%esp) - cs
> +	 *  2*4(%esp) - ip
> +	 *  1*4(%esp) - orig_eax
> +	 *  0*4(%esp) - gs / function
> +	 */
> +
> +	pushl	%ss		# ss
> +	pushl	%esp		# sp (points at ss)
> +	addl	$6*4, (%esp)	# point sp back at the previous context
> +	pushl	6*4(%esp)	# flags
> +	pushl	6*4(%esp)	# cs
> +	pushl	6*4(%esp)	# ip
> +	pushl	6*4(%esp)	# orig_eax
> +	pushl	6*4(%esp)	# gs / function
> +.Lfrom_usermode_no_fixup_\@:
> +.endm
> +
> +.macro IRET_FRAME
> +	testl $CS_FROM_KERNEL, 1*4(%esp)
> +	jz .Lfinished_frame_\@
> +
> +	/*
> +	 * Reconstruct the 3 entry IRET frame right after the (modified)
> +	 * regs->sp without lowering %esp in between, such that an NMI in the
> +	 * middle doesn't scribble our stack.
> +	 */
> +	pushl	%eax
> +	pushl	%ecx
> +	movl	5*4(%esp), %eax		# (modified) regs->sp
> +
> +	movl	4*4(%esp), %ecx		# flags
> +	movl	%ecx, -4(%eax)
> +
> +	movl	3*4(%esp), %ecx		# cs
> +	andl	$0x0000ffff, %ecx
> +	movl	%ecx, -8(%eax)
> +
> +	movl	2*4(%esp), %ecx		# ip
> +	movl	%ecx, -12(%eax)
> +
> +	movl	1*4(%esp), %ecx		# eax
> +	movl	%ecx, -16(%eax)
> +
> +	popl	%ecx
> +	lea	-16(%eax), %esp
> +	popl	%eax
> +.Lfinished_frame_\@:
> +.endm
> +
>  .macro SAVE_ALL pt_regs_ax=%eax switch_stacks=0
>  	cld
>  	PUSH_GS
> +	FIXUP_FRAME
>  	pushl	%fs
>  	pushl	%es
>  	pushl	%ds
> @@ -358,9 +451,6 @@
>   * switch to it before we do any copying.
>   */
>  
> -#define CS_FROM_ENTRY_STACK	(1 << 31)
> -#define CS_FROM_USER_CR3	(1 << 30)
> -
>  .macro SWITCH_TO_KERNEL_STACK
>  
>  	ALTERNATIVE     "", "jmp .Lend_\@", X86_FEATURE_XENPV
> @@ -374,13 +464,6 @@
>  	 * that register for the time this macro runs
>  	 */
>  
> -	/*
> -	 * The high bits of the CS dword (__csh) are used for
> -	 * CS_FROM_ENTRY_STACK and CS_FROM_USER_CR3. Clear them in case
> -	 * hardware didn't do this for us.
> -	 */
> -	andl	$(0x0000ffff), PT_CS(%esp)
> -
>  	/* Are we on the entry stack? Bail out if not! */
>  	movl	PER_CPU_VAR(cpu_entry_area), %ecx
>  	addl	$CPU_ENTRY_AREA_entry_stack + SIZEOF_entry_stack, %ecx
> @@ -990,6 +1073,7 @@ ENTRY(entry_INT80_32)
>  	/* Restore user state */
>  	RESTORE_REGS pop=4			# skip orig_eax/error_code
>  .Lirq_return:
> +	IRET_FRAME
>  	/*
>  	 * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on IRET core serialization
>  	 * when returning from IPI handler and when returning from
> @@ -1340,6 +1424,7 @@ END(page_fault)
>  
>  common_exception:
>  	/* the function address is in %gs's slot on the stack */
> +	FIXUP_FRAME
>  	pushl	%fs
>  	pushl	%es
>  	pushl	%ds
> --- a/arch/x86/include/asm/kexec.h
> +++ b/arch/x86/include/asm/kexec.h
> @@ -71,22 +71,6 @@ struct kimage;
>  #define KEXEC_BACKUP_SRC_END	(640 * 1024UL - 1)	/* 640K */
>  
>  /*
> - * CPU does not save ss and sp on stack if execution is already
> - * running in kernel mode at the time of NMI occurrence. This code
> - * fixes it.
> - */
> -static inline void crash_fixup_ss_esp(struct pt_regs *newregs,
> -				      struct pt_regs *oldregs)
> -{
> -#ifdef CONFIG_X86_32
> -	newregs->sp = (unsigned long)&(oldregs->sp);
> -	asm volatile("xorl %%eax, %%eax\n\t"
> -		     "movw %%ss, %%ax\n\t"
> -		     :"=a"(newregs->ss));
> -#endif
> -}
> -
> -/*
>   * This function is responsible for capturing register states if coming
>   * via panic otherwise just fix up the ss and sp if coming via kernel
>   * mode exception.
> @@ -96,7 +80,6 @@ static inline void crash_setup_regs(stru
>  {
>  	if (oldregs) {
>  		memcpy(newregs, oldregs, sizeof(*newregs));
> -		crash_fixup_ss_esp(newregs, oldregs);
>  	} else {
>  #ifdef CONFIG_X86_32
>  		asm volatile("movl %%ebx,%0" : "=m"(newregs->bx));
> --- a/arch/x86/include/asm/ptrace.h
> +++ b/arch/x86/include/asm/ptrace.h
> @@ -166,14 +166,10 @@ static inline bool user_64bit_mode(struc
>  #define compat_user_stack_pointer()	current_pt_regs()->sp
>  #endif
>  
> -#ifdef CONFIG_X86_32
> -extern unsigned long kernel_stack_pointer(struct pt_regs *regs);
> -#else
>  static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
>  {
>  	return regs->sp;
>  }
> -#endif
>  
>  #define GET_IP(regs) ((regs)->ip)
>  #define GET_FP(regs) ((regs)->bp)
> @@ -201,14 +197,6 @@ static inline unsigned long regs_get_reg
>  	if (unlikely(offset > MAX_REG_OFFSET))
>  		return 0;
>  #ifdef CONFIG_X86_32
> -	/*
> -	 * Traps from the kernel do not save sp and ss.
> -	 * Use the helper function to retrieve sp.
> -	 */
> -	if (offset == offsetof(struct pt_regs, sp) &&
> -	    regs->cs == __KERNEL_CS)
> -		return kernel_stack_pointer(regs);
> -
>  	/* The selector fields are 16-bit. */
>  	if (offset == offsetof(struct pt_regs, cs) ||
>  	    offset == offsetof(struct pt_regs, ss) ||
> @@ -234,8 +222,7 @@ static inline unsigned long regs_get_reg
>  static inline int regs_within_kernel_stack(struct pt_regs *regs,
>  					   unsigned long addr)
>  {
> -	return ((addr & ~(THREAD_SIZE - 1))  ==
> -		(kernel_stack_pointer(regs) & ~(THREAD_SIZE - 1)));
> +	return ((addr & ~(THREAD_SIZE - 1)) == (regs->sp & ~(THREAD_SIZE - 1)));
>  }
>  
>  /**
> @@ -249,7 +236,7 @@ static inline int regs_within_kernel_sta
>   */
>  static inline unsigned long *regs_get_kernel_stack_nth_addr(struct pt_regs *regs, unsigned int n)
>  {
> -	unsigned long *addr = (unsigned long *)kernel_stack_pointer(regs);
> +	unsigned long *addr = (unsigned long *)regs->sp;
>  
>  	addr += n;
>  	if (regs_within_kernel_stack(regs, (unsigned long)addr))
> --- a/arch/x86/include/asm/stacktrace.h
> +++ b/arch/x86/include/asm/stacktrace.h
> @@ -78,7 +78,7 @@ static inline unsigned long *
>  get_stack_pointer(struct task_struct *task, struct pt_regs *regs)
>  {
>  	if (regs)
> -		return (unsigned long *)kernel_stack_pointer(regs);
> +		return (unsigned long *)regs->sp;
>  
>  	if (task == current)
>  		return __builtin_frame_address(0);
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -72,14 +72,6 @@ static inline void cpu_crash_vmclear_loa
>  
>  static void kdump_nmi_callback(int cpu, struct pt_regs *regs)
>  {
> -#ifdef CONFIG_X86_32
> -	struct pt_regs fixed_regs;
> -
> -	if (!user_mode(regs)) {
> -		crash_fixup_ss_esp(&fixed_regs, regs);
> -		regs = &fixed_regs;
> -	}
> -#endif
>  	crash_save_cpu(regs, cpu);
>  
>  	/*
> --- a/arch/x86/kernel/ftrace_32.S
> +++ b/arch/x86/kernel/ftrace_32.S
> @@ -10,6 +10,7 @@
>  #include <asm/ftrace.h>
>  #include <asm/nospec-branch.h>
>  #include <asm/frame.h>
> +#include <asm/asm-offsets.h>
>  
>  # define function_hook	__fentry__
>  EXPORT_SYMBOL(__fentry__)
> @@ -90,26 +91,38 @@ END(ftrace_caller)
>  
>  ENTRY(ftrace_regs_caller)
>  	/*
> -	 * i386 does not save SS and ESP when coming from kernel.
> -	 * Instead, to get sp, &regs->sp is used (see ptrace.h).
> -	 * Unfortunately, that means eflags must be at the same location
> -	 * as the current return ip is. We move the return ip into the
> -	 * regs->ip location, and move flags into the return ip location.
> +	 * We're here from an mcount/fentry CALL, and the stack frame looks like:
> +	 *
> +	 *  <previous context>
> +	 *  RET-IP
> +	 *
> +	 * The purpose of this function is to call out in an emulated INT3
> +	 * environment with a stack frame like:
> +	 *
> +	 *  <previous context>
> +	 *  gap / RET-IP
> +	 *  gap
> +	 *  gap
> +	 *  gap
> +	 *  pt_regs
> +	 *
> +	 * We do _NOT_ restore: ss, flags, cs, gs, fs, es, ds
>  	 */
> -	pushl	$__KERNEL_CS
> -	pushl	4(%esp)				/* Save the return ip */
> -	pushl	$0				/* Load 0 into orig_ax */
> +	subl	$3*4, %esp	# RET-IP + 3 gaps
> +	pushl	%ss		# ss
> +	pushl	%esp		# points at ss
> +	addl	$5*4, (%esp)	#   make it point at <previous context>
> +	pushfl			# flags
> +	pushl	$__KERNEL_CS	# cs
> +	pushl	7*4(%esp)	# ip <- RET-IP
> +	pushl	$0		# orig_eax
> +
>  	pushl	%gs
>  	pushl	%fs
>  	pushl	%es
>  	pushl	%ds
> -	pushl	%eax
> -
> -	/* Get flags and place them into the return ip slot */
> -	pushf
> -	popl	%eax
> -	movl	%eax, 8*4(%esp)
>  
> +	pushl	%eax
>  	pushl	%ebp
>  	pushl	%edi
>  	pushl	%esi
> @@ -119,24 +132,25 @@ ENTRY(ftrace_regs_caller)
>  
>  	ENCODE_FRAME_POINTER
>  
> -	movl	12*4(%esp), %eax		/* Load ip (1st parameter) */
> -	subl	$MCOUNT_INSN_SIZE, %eax		/* Adjust ip */
> -	movl	15*4(%esp), %edx		/* Load parent ip (2nd parameter) */
> -	movl	function_trace_op, %ecx		/* Save ftrace_pos in 3rd parameter */
> -	pushl	%esp				/* Save pt_regs as 4th parameter */
> +	movl	PT_EIP(%esp), %eax	# 1st argument: IP
> +	subl	$MCOUNT_INSN_SIZE, %eax
> +	movl	21*4(%esp), %edx	# 2nd argument: parent ip
> +	movl	function_trace_op, %ecx	# 3rd argument: ftrace_pos
> +	pushl	%esp			# 4th argument: pt_regs
>  
>  GLOBAL(ftrace_regs_call)
>  	call	ftrace_stub
>  
> -	addl	$4, %esp			/* Skip pt_regs */
> +	addl	$4, %esp		# skip 4th argument
>  
> -	/* restore flags */
> -	push	14*4(%esp)
> -	popf
> -
> -	/* Move return ip back to its original location */
> -	movl	12*4(%esp), %eax
> -	movl	%eax, 14*4(%esp)
> +	/* place IP below the new SP */
> +	movl	PT_OLDESP(%esp), %eax
> +	movl	PT_EIP(%esp), %ecx
> +	movl	%ecx, -4(%eax)
> +
> +	/* place EAX below that */
> +	movl	PT_EAX(%esp), %ecx
> +	movl	%ecx, -8(%eax)
>  
>  	popl	%ebx
>  	popl	%ecx
> @@ -144,14 +158,9 @@ GLOBAL(ftrace_regs_call)
>  	popl	%esi
>  	popl	%edi
>  	popl	%ebp
> -	popl	%eax
> -	popl	%ds
> -	popl	%es
> -	popl	%fs
> -	popl	%gs
>  
> -	/* use lea to not affect flags */
> -	lea	3*4(%esp), %esp			/* Skip orig_ax, ip and cs */
> +	lea	-8(%eax), %esp
> +	popl	%eax
>  
>  	jmp	.Lftrace_ret
>  
> --- a/arch/x86/kernel/kgdb.c
> +++ b/arch/x86/kernel/kgdb.c
> @@ -127,14 +127,6 @@ char *dbg_get_reg(int regno, void *mem,
>  
>  #ifdef CONFIG_X86_32
>  	switch (regno) {
> -	case GDB_SS:
> -		if (!user_mode(regs))
> -			*(unsigned long *)mem = __KERNEL_DS;
> -		break;
> -	case GDB_SP:
> -		if (!user_mode(regs))
> -			*(unsigned long *)mem = kernel_stack_pointer(regs);
> -		break;
>  	case GDB_GS:
>  	case GDB_FS:
>  		*(unsigned long *)mem = 0xFFFF;
> --- a/arch/x86/kernel/kprobes/common.h
> +++ b/arch/x86/kernel/kprobes/common.h
> @@ -72,8 +72,8 @@
>  	"	popl %edi\n"			\
>  	"	popl %ebp\n"			\
>  	"	popl %eax\n"			\
> -	/* Skip ds, es, fs, gs, orig_ax, and ip. Note: don't pop cs here*/\
> -	"	addl $24, %esp\n"
> +	/* Skip ds, es, fs, gs, orig_ax, ip, and cs. */\
> +	"	addl $7*4, %esp\n"
>  #endif
>  
>  /* Ensure if the instruction can be boostable */
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -69,7 +69,7 @@
>  DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
>  DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
>  
> -#define stack_addr(regs) ((unsigned long *)kernel_stack_pointer(regs))
> +#define stack_addr(regs) ((unsigned long *)regs->sp)
>  
>  #define W(row, b0, b1, b2, b3, b4, b5, b6, b7, b8, b9, ba, bb, bc, bd, be, bf)\
>  	(((b0##UL << 0x0)|(b1##UL << 0x1)|(b2##UL << 0x2)|(b3##UL << 0x3) |   \
> @@ -731,29 +731,27 @@ asm(
>  	".global kretprobe_trampoline\n"
>  	".type kretprobe_trampoline, @function\n"
>  	"kretprobe_trampoline:\n"
> -#ifdef CONFIG_X86_64
>  	/* We don't bother saving the ss register */
> +#ifdef CONFIG_X86_64
>  	"	pushq %rsp\n"
>  	"	pushfq\n"
>  	SAVE_REGS_STRING
>  	"	movq %rsp, %rdi\n"
>  	"	call trampoline_handler\n"
>  	/* Replace saved sp with true return address. */
> -	"	movq %rax, 152(%rsp)\n"
> +	"	movq %rax, 19*8(%rsp)\n"
>  	RESTORE_REGS_STRING
>  	"	popfq\n"
>  #else
> -	"	pushf\n"
> +	"	pushl %esp\n"
> +	"	pushfl\n"
>  	SAVE_REGS_STRING
>  	"	movl %esp, %eax\n"
>  	"	call trampoline_handler\n"
> -	/* Move flags to cs */
> -	"	movl 56(%esp), %edx\n"
> -	"	movl %edx, 52(%esp)\n"
> -	/* Replace saved flags with true return address. */
> -	"	movl %eax, 56(%esp)\n"
> +	/* Replace saved sp with true return address. */
> +	"	movl %eax, 15*4(%esp)\n"
>  	RESTORE_REGS_STRING
> -	"	popf\n"
> +	"	popfl\n"
>  #endif
>  	"	ret\n"
>  	".size kretprobe_trampoline, .-kretprobe_trampoline\n"
> @@ -794,16 +792,13 @@ __used __visible void *trampoline_handle
>  	INIT_HLIST_HEAD(&empty_rp);
>  	kretprobe_hash_lock(current, &head, &flags);
>  	/* fixup registers */
> -#ifdef CONFIG_X86_64
>  	regs->cs = __KERNEL_CS;
> -	/* On x86-64, we use pt_regs->sp for return address holder. */
> -	frame_pointer = &regs->sp;
> -#else
> -	regs->cs = __KERNEL_CS | get_kernel_rpl();
> +#ifdef CONFIG_X86_32
> +	regs->cs |= get_kernel_rpl();
>  	regs->gs = 0;
> -	/* On x86-32, we use pt_regs->flags for return address holder. */
> -	frame_pointer = &regs->flags;
>  #endif
> +	/* We use pt_regs->sp for return address holder. */
> +	frame_pointer = &regs->sp;
>  	regs->ip = trampoline_address;
>  	regs->orig_ax = ~0UL;
>  
> --- a/arch/x86/kernel/kprobes/opt.c
> +++ b/arch/x86/kernel/kprobes/opt.c
> @@ -115,14 +115,15 @@ asm (
>  			"optprobe_template_call:\n"
>  			ASM_NOP5
>  			/* Move flags to rsp */
> -			"	movq 144(%rsp), %rdx\n"
> -			"	movq %rdx, 152(%rsp)\n"
> +			"	movq 18*8(%rsp), %rdx\n"
> +			"	movq %rdx, 19*8(%rsp)\n"
>  			RESTORE_REGS_STRING
>  			/* Skip flags entry */
>  			"	addq $8, %rsp\n"
>  			"	popfq\n"
>  #else /* CONFIG_X86_32 */
> -			"	pushf\n"
> +			"	pushl %esp\n"
> +			"	pushfl\n"
>  			SAVE_REGS_STRING
>  			"	movl %esp, %edx\n"
>  			".global optprobe_template_val\n"
> @@ -131,9 +132,13 @@ asm (
>  			".global optprobe_template_call\n"
>  			"optprobe_template_call:\n"
>  			ASM_NOP5
> +			/* Move flags into esp */
> +			"	movl 14*4(%esp), %edx\n"
> +			"	movl %edx, 15*4(%esp)\n"
>  			RESTORE_REGS_STRING
> -			"	addl $4, %esp\n"	/* skip cs */
> -			"	popf\n"
> +			/* Skip flags entry */
> +			"	addl $4, %esp\n"
> +			"	popfl\n"
>  #endif
>  			".global optprobe_template_end\n"
>  			"optprobe_template_end:\n"
> @@ -165,10 +170,9 @@ optimized_callback(struct optimized_kpro
>  	} else {
>  		struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
>  		/* Save skipped registers */
> -#ifdef CONFIG_X86_64
>  		regs->cs = __KERNEL_CS;
> -#else
> -		regs->cs = __KERNEL_CS | get_kernel_rpl();
> +#ifdef CONFIG_X86_32
> +		regs->cs |= get_kernel_rpl();
>  		regs->gs = 0;
>  #endif
>  		regs->ip = (unsigned long)op->kp.addr + INT3_SIZE;
> --- a/arch/x86/kernel/process_32.c
> +++ b/arch/x86/kernel/process_32.c
> @@ -62,27 +62,21 @@ void __show_regs(struct pt_regs *regs, e
>  {
>  	unsigned long cr0 = 0L, cr2 = 0L, cr3 = 0L, cr4 = 0L;
>  	unsigned long d0, d1, d2, d3, d6, d7;
> -	unsigned long sp;
> -	unsigned short ss, gs;
> +	unsigned short gs;
>  
> -	if (user_mode(regs)) {
> -		sp = regs->sp;
> -		ss = regs->ss;
> +	if (user_mode(regs))
>  		gs = get_user_gs(regs);
> -	} else {
> -		sp = kernel_stack_pointer(regs);
> -		savesegment(ss, ss);
> +	else
>  		savesegment(gs, gs);
> -	}
>  
>  	show_ip(regs, KERN_DEFAULT);
>  
>  	printk(KERN_DEFAULT "EAX: %08lx EBX: %08lx ECX: %08lx EDX: %08lx\n",
>  		regs->ax, regs->bx, regs->cx, regs->dx);
>  	printk(KERN_DEFAULT "ESI: %08lx EDI: %08lx EBP: %08lx ESP: %08lx\n",
> -		regs->si, regs->di, regs->bp, sp);
> +		regs->si, regs->di, regs->bp, regs->sp);
>  	printk(KERN_DEFAULT "DS: %04x ES: %04x FS: %04x GS: %04x SS: %04x EFLAGS: %08lx\n",
> -	       (u16)regs->ds, (u16)regs->es, (u16)regs->fs, gs, ss, regs->flags);
> +	       (u16)regs->ds, (u16)regs->es, (u16)regs->fs, gs, regs->ss, regs->flags);
>  
>  	if (mode != SHOW_REGS_ALL)
>  		return;
> --- a/arch/x86/kernel/ptrace.c
> +++ b/arch/x86/kernel/ptrace.c
> @@ -153,35 +153,6 @@ static inline bool invalid_selector(u16
>  
>  #define FLAG_MASK		FLAG_MASK_32
>  
> -/*
> - * X86_32 CPUs don't save ss and esp if the CPU is already in kernel mode
> - * when it traps.  The previous stack will be directly underneath the saved
> - * registers, and 'sp/ss' won't even have been saved. Thus the '&regs->sp'.
> - *
> - * Now, if the stack is empty, '&regs->sp' is out of range. In this
> - * case we try to take the previous stack. To always return a non-null
> - * stack pointer we fall back to regs as stack if no previous stack
> - * exists.
> - *
> - * This is valid only for kernel mode traps.
> - */
> -unsigned long kernel_stack_pointer(struct pt_regs *regs)
> -{
> -	unsigned long context = (unsigned long)regs & ~(THREAD_SIZE - 1);
> -	unsigned long sp = (unsigned long)&regs->sp;
> -	u32 *prev_esp;
> -
> -	if (context == (sp & ~(THREAD_SIZE - 1)))
> -		return sp;
> -
> -	prev_esp = (u32 *)(context);
> -	if (*prev_esp)
> -		return (unsigned long)*prev_esp;
> -
> -	return (unsigned long)regs;
> -}
> -EXPORT_SYMBOL_GPL(kernel_stack_pointer);
> -
>  static unsigned long *pt_regs_access(struct pt_regs *regs, unsigned long regno)
>  {
>  	BUILD_BUG_ON(offsetof(struct pt_regs, bx) != 0);
> --- a/arch/x86/kernel/time.c
> +++ b/arch/x86/kernel/time.c
> @@ -37,8 +37,7 @@ unsigned long profile_pc(struct pt_regs
>  #ifdef CONFIG_FRAME_POINTER
>  		return *(unsigned long *)(regs->bp + sizeof(long));
>  #else
> -		unsigned long *sp =
> -			(unsigned long *)kernel_stack_pointer(regs);
> +		unsigned long *sp = (unsigned long *)regs->sp;
>  		/*
>  		 * Return address is either directly at stack pointer
>  		 * or above a saved flags. Eflags has bits 22-31 zero,
> --- a/arch/x86/kernel/unwind_frame.c
> +++ b/arch/x86/kernel/unwind_frame.c
> @@ -69,15 +69,6 @@ static void unwind_dump(struct unwind_st
>  	}
>  }
>  
> -static size_t regs_size(struct pt_regs *regs)
> -{
> -	/* x86_32 regs from kernel mode are two words shorter: */
> -	if (IS_ENABLED(CONFIG_X86_32) && !user_mode(regs))
> -		return sizeof(*regs) - 2*sizeof(long);
> -
> -	return sizeof(*regs);
> -}
> -
>  static bool in_entry_code(unsigned long ip)
>  {
>  	char *addr = (char *)ip;
> @@ -197,12 +188,6 @@ static struct pt_regs *decode_frame_poin
>  }
>  #endif
>  
> -#ifdef CONFIG_X86_32
> -#define KERNEL_REGS_SIZE (sizeof(struct pt_regs) - 2*sizeof(long))
> -#else
> -#define KERNEL_REGS_SIZE (sizeof(struct pt_regs))
> -#endif
> -
>  static bool update_stack_state(struct unwind_state *state,
>  			       unsigned long *next_bp)
>  {
> @@ -213,7 +198,7 @@ static bool update_stack_state(struct un
>  	size_t len;
>  
>  	if (state->regs)
> -		prev_frame_end = (void *)state->regs + regs_size(state->regs);
> +		prev_frame_end = (void *)state->regs + sizeof(*state->regs);
>  	else
>  		prev_frame_end = (void *)state->bp + FRAME_HEADER_SIZE;
>  
> @@ -221,7 +206,7 @@ static bool update_stack_state(struct un
>  	regs = decode_frame_pointer(next_bp);
>  	if (regs) {
>  		frame = (unsigned long *)regs;
> -		len = KERNEL_REGS_SIZE;
> +		len = sizeof(*regs);
>  		state->got_irq = true;
>  	} else {
>  		frame = next_bp;
> @@ -245,14 +230,6 @@ static bool update_stack_state(struct un
>  	    frame < prev_frame_end)
>  		return false;
>  
> -	/*
> -	 * On 32-bit with user mode regs, make sure the last two regs are safe
> -	 * to access:
> -	 */
> -	if (IS_ENABLED(CONFIG_X86_32) && regs && user_mode(regs) &&
> -	    !on_stack(info, frame, len + 2*sizeof(long)))
> -		return false;
> -
>  	/* Move state to the next frame: */
>  	if (regs) {
>  		state->regs = regs;
> @@ -411,10 +388,9 @@ void __unwind_start(struct unwind_state
>  	 * Pretend that the frame is complete and that BP points to it, but save
>  	 * the real BP so that we can use it when looking for the next frame.
>  	 */
> -	if (regs && regs->ip == 0 &&
> -	    (unsigned long *)kernel_stack_pointer(regs) >= first_frame) {
> +	if (regs && regs->ip == 0 && (unsigned long *)regs->sp >= first_frame) {
>  		state->next_bp = bp;
> -		bp = ((unsigned long *)kernel_stack_pointer(regs)) - 1;
> +		bp = ((unsigned long *)regs->sp) - 1;
>  	}
>  
>  	/* Initialize stack info and make sure the frame data is accessible: */
> --- a/arch/x86/kernel/unwind_orc.c
> +++ b/arch/x86/kernel/unwind_orc.c
> @@ -579,7 +579,7 @@ void __unwind_start(struct unwind_state
>  			goto done;
>  
>  		state->ip = regs->ip;
> -		state->sp = kernel_stack_pointer(regs);
> +		state->sp = regs->sp;
>  		state->bp = regs->bp;
>  		state->regs = regs;
>  		state->full_regs = true;
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
