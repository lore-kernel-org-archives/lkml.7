Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19E5C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 10:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C28421882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 10:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wEIreioh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfGCK3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 06:29:06 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33244 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfGCK3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 06:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=From:Content-Type:MIME-Version:
        References:Subject:Cc:To:Date:Message-Id:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=V8jm+0gaGgpTzNz4iGV/i3mFan+wp15EVDqd2fvxfbU=; b=wEIreiohSDgx
        +I25FqrGaJSvepSr4pgrSREMOjN6dOumR8HZlpsiAtLjRqvSsL/5eIycE8oRVBfeUsvE89JzeMlW4
        X7Smu8XBaiqgX29LKvuL7gFufB9u4Gj3VgYSWlcRH4zapRedvPj8cHHjwRcKlRPxEpTA4BKRvHT0j
        j5AKVoBbXjLAum9M9+wqdhoYdaLxm6p8LpevLonwoWGTfnKwUrJtux+K4Qzki6cBbaTRhyQP+Vcnz
        ajWt423JorCcaHDm2L5KjFdTw1fP0yVuSf+MyyjPqrsdYrxWw96FhdiD6Vpvi8rb45pySbUwccByw
        HbyrOzDTXyvLdlYZpXoY1Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hicV2-0006Fa-A6; Wed, 03 Jul 2019 10:28:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C9D5E2013A3DA; Wed,  3 Jul 2019 12:28:25 +0200 (CEST)
Message-Id: <20190703102807.588906400@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 03 Jul 2019 12:27:34 +0200
To:     tglx@linutronix.de, bp@alien8.de, mingo@kernel.org,
        rostedt@goodmis.org, luto@kernel.org, torvalds@linux-foundation.org
Cc:     hpa@zytor.com, dave.hansen@linux.intel.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, zhe.he@windriver.com,
        joel@joelfernandes.org, devel@etsukata.com, peterz@infradead.org
Subject: [PATCH 3/3] x86/mm, tracing: Fix CR2 corruption
References: <20190703102731.236024951@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
From:   root <peterz@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Despire the current efforts to read CR2 before tracing happens there
still exist a number of possible holes:

  idtentry page_fault             do_page_fault           has_error_code=1
    call error_entry
      TRACE_IRQS_OFF
        call trace_hardirqs_off*
          #PF // modifies CR2

      CALL_enter_from_user_mode
        __context_tracking_exit()
          trace_user_exit(0)
            #PF // modifies CR2

    call do_page_fault
      address = read_cr2(); /* whoopsie */

And similar for i386.

Fix it by pulling the CR2 read into the entry code, before any of that
stuff gets a chance to run and ruin things.

Ideally we'll clean up the entry code by moving this tracing and
context tracking nonsense into C some day, but let's not delay fixing
this longer.

Reported-by: He Zhe <zhe.he@windriver.com>
Reported-by: Eiichi Tsukata <devel@etsukata.com>
Debugged-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_32.S       |   25 ++++++++++++++++++++++---
 arch/x86/entry/entry_64.S       |   28 ++++++++++++++--------------
 arch/x86/include/asm/kvm_para.h |    2 +-
 arch/x86/include/asm/traps.h    |    2 +-
 arch/x86/kernel/kvm.c           |    8 ++++----
 arch/x86/mm/fault.c             |   28 ++++++++++------------------
 6 files changed, 52 insertions(+), 41 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1443,9 +1443,28 @@ BUILD_INTERRUPT3(hv_stimer0_callback_vec
 
 ENTRY(page_fault)
 	ASM_CLAC
-	pushl	$do_page_fault
-	ALIGN
-	jmp common_exception
+	pushl	$0; /* %gs's slot on the stack */
+
+	SAVE_ALL switch_stacks=1 skip_gs=1
+
+	ENCODE_FRAME_POINTER
+	UNWIND_ESPFIX_STACK
+
+	/* fixup %gs */
+	GS_TO_REG %ecx
+	REG_TO_PTGS %ecx
+	SET_KERNEL_GS %ecx
+
+	GET_CR2_INTO(%ecx)			# might clobber %eax
+
+	/* fixup orig %eax */
+	movl	PT_ORIG_EAX(%esp), %edx		# get the error code
+	movl	$-1, PT_ORIG_EAX(%esp)		# no syscall to restart
+
+	TRACE_IRQS_OFF
+	movl	%esp, %eax			# pt_regs pointer
+	call	do_page_fault
+	jmp	ret_from_exception
 END(page_fault)
 
 common_exception:
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -901,7 +901,7 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
  * @paranoid == 2 is special: the stub will never switch stacks.  This is for
  * #DF: if the thread stack is somehow unusable, we'll still get a useful OOPS.
  */
-.macro idtentry sym do_sym has_error_code:req paranoid=0 shift_ist=-1 ist_offset=0 create_gap=0
+.macro idtentry sym do_sym has_error_code:req paranoid=0 shift_ist=-1 ist_offset=0 create_gap=0 read_cr2=0
 ENTRY(\sym)
 	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
 
@@ -937,18 +937,27 @@ ENTRY(\sym)
 
 	.if \paranoid
 	call	paranoid_entry
+	/* returned flag: ebx=0: need swapgs on exit, ebx=1: don't need it */
 	.else
 	call	error_entry
 	.endif
 	UNWIND_HINT_REGS
-	/* returned flag: ebx=0: need swapgs on exit, ebx=1: don't need it */
 
-	.if \paranoid
+	.if \read_cr2
+	GET_CR2_INTO(%rdx);			/* can clobber %rax */
+	.endif
+
 	.if \shift_ist != -1
 	TRACE_IRQS_OFF_DEBUG			/* reload IDT in case of recursion */
 	.else
 	TRACE_IRQS_OFF
 	.endif
+
+	.if \paranoid == 0
+	testb	$3, CS(%rsp)
+	jz	.Lfrom_kernel_no_context_tracking_\@
+	CALL_enter_from_user_mode
+.Lfrom_kernel_no_context_tracking_\@:
 	.endif
 
 	movq	%rsp, %rdi			/* pt_regs pointer */
@@ -1180,10 +1189,10 @@ idtentry xenint3		do_int3			has_error_co
 #endif
 
 idtentry general_protection	do_general_protection	has_error_code=1
-idtentry page_fault		do_page_fault		has_error_code=1
+idtentry page_fault		do_page_fault		has_error_code=1	read_cr2=1
 
 #ifdef CONFIG_KVM_GUEST
-idtentry async_page_fault	do_async_page_fault	has_error_code=1
+idtentry async_page_fault	do_async_page_fault	has_error_code=1	read_cr2=1
 #endif
 
 #ifdef CONFIG_X86_MCE
@@ -1338,18 +1347,9 @@ ENTRY(error_entry)
 	movq	%rax, %rsp			/* switch stack */
 	ENCODE_FRAME_POINTER
 	pushq	%r12
-
-	/*
-	 * We need to tell lockdep that IRQs are off.  We can't do this until
-	 * we fix gsbase, and we should do it before enter_from_user_mode
-	 * (which can take locks).
-	 */
-	TRACE_IRQS_OFF
-	CALL_enter_from_user_mode
 	ret
 
 .Lerror_entry_done:
-	TRACE_IRQS_OFF
 	ret
 
 	/*
--- a/arch/x86/include/asm/kvm_para.h
+++ b/arch/x86/include/asm/kvm_para.h
@@ -92,7 +92,7 @@ void kvm_async_pf_task_wait(u32 token, i
 void kvm_async_pf_task_wake(u32 token);
 u32 kvm_read_and_reset_pf_reason(void);
 extern void kvm_disable_steal_time(void);
-void do_async_page_fault(struct pt_regs *regs, unsigned long error_code);
+void do_async_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address);
 
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
 void __init kvm_spinlock_init(void);
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -81,7 +81,7 @@ struct bad_iret_stack *fixup_bad_iret(st
 void __init trap_init(void);
 #endif
 dotraplinkage void do_general_protection(struct pt_regs *regs, long error_code);
-dotraplinkage void do_page_fault(struct pt_regs *regs, unsigned long error_code);
+dotraplinkage void do_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address);
 dotraplinkage void do_spurious_interrupt_bug(struct pt_regs *regs, long error_code);
 dotraplinkage void do_coprocessor_error(struct pt_regs *regs, long error_code);
 dotraplinkage void do_alignment_check(struct pt_regs *regs, long error_code);
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -242,23 +242,23 @@ EXPORT_SYMBOL_GPL(kvm_read_and_reset_pf_
 NOKPROBE_SYMBOL(kvm_read_and_reset_pf_reason);
 
 dotraplinkage void
-do_async_page_fault(struct pt_regs *regs, unsigned long error_code)
+do_async_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address)
 {
 	enum ctx_state prev_state;
 
 	switch (kvm_read_and_reset_pf_reason()) {
 	default:
-		do_page_fault(regs, error_code);
+		do_page_fault(regs, error_code, address);
 		break;
 	case KVM_PV_REASON_PAGE_NOT_PRESENT:
 		/* page is swapped out by the host. */
 		prev_state = exception_enter();
-		kvm_async_pf_task_wait((u32)read_cr2(), !user_mode(regs));
+		kvm_async_pf_task_wait((u32)address, !user_mode(regs));
 		exception_exit(prev_state);
 		break;
 	case KVM_PV_REASON_PAGE_READY:
 		rcu_irq_enter();
-		kvm_async_pf_task_wake((u32)read_cr2());
+		kvm_async_pf_task_wake((u32)address);
 		rcu_irq_exit();
 		break;
 	}
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1513,7 +1513,7 @@ NOKPROBE_SYMBOL(do_user_addr_fault);
  * and the problem, and then passes it off to one of the appropriate
  * routines.
  */
-static noinline void
+static __always_inline void
 __do_page_fault(struct pt_regs *regs, unsigned long hw_error_code,
 		unsigned long address)
 {
@@ -1528,35 +1528,27 @@ __do_page_fault(struct pt_regs *regs, un
 	else
 		do_user_addr_fault(regs, hw_error_code, address);
 }
-NOKPROBE_SYMBOL(__do_page_fault);
 
-static nokprobe_inline void
-trace_page_fault_entries(unsigned long address, struct pt_regs *regs,
-			 unsigned long error_code)
+static __always_inline void
+trace_page_fault_entries(struct pt_regs *regs, unsigned long error_code,
+			 unsigned long address)
 {
+	if (!trace_pagefault_enabled())
+		return;
+
 	if (user_mode(regs))
 		trace_page_fault_user(address, regs, error_code);
 	else
 		trace_page_fault_kernel(address, regs, error_code);
 }
 
-/*
- * We must have this function blacklisted from kprobes, tagged with notrace
- * and call read_cr2() before calling anything else. To avoid calling any
- * kind of tracing machinery before we've observed the CR2 value.
- *
- * exception_{enter,exit}() contains all sorts of tracepoints.
- */
-dotraplinkage void notrace
-do_page_fault(struct pt_regs *regs, unsigned long error_code)
+dotraplinkage void
+do_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address)
 {
-	unsigned long address = read_cr2(); /* Get the faulting address */
 	enum ctx_state prev_state;
 
 	prev_state = exception_enter();
-	if (trace_pagefault_enabled())
-		trace_page_fault_entries(address, regs, error_code);
-
+	trace_page_fault_entries(regs, error_code, address);
 	__do_page_fault(regs, error_code, address);
 	exception_exit(prev_state);
 }


