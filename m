Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB16CC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 21:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7CA217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 21:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="tsYcV9mN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbfGQV0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 17:26:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55315 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbfGQV0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 17:26:39 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6HLPx1g1695776
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Jul 2019 14:26:00 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6HLPx1g1695776
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563398760;
        bh=IQoVFOGJwkTwAaxPJuafvFXENAo0VRWi+2T3eqH4yRE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=tsYcV9mNY7MXhVXYO7kXdXX4w9g7qrOiHI2y2WPhKa524BThZ37FohSVnUyvZMtxW
         S7YT3vT1mWRsCrtwmeSYRJwgEcnpitxbbVWtZYgr2S5aGNQPxOP3drbFfx53f67Ndo
         0DuZ6jTPJvi/eqmfC5G4ODKib7blxy2h/PAdbd1paDOGn71Abj63gnHRtPWalzHl3G
         QcCk5n3a2ur6h9WxCm3JDtlFkZhCGt5MvziSWW3bYCBxS3Ypj0o/gHmLW8uZU+81C8
         9DsMqvGvsNw8x1tKhkq96KlKu8f0zqSui6oiSsgv3y+5SsgEaJ7oII3bT9QnAVm2xg
         rciAvheL/AmAw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6HLPx5O1695773;
        Wed, 17 Jul 2019 14:25:59 -0700
Date:   Wed, 17 Jul 2019 14:25:59 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-a0d14b8909de55139b8702fe0c7e80b69763dcfb@git.kernel.org>
Cc:     mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, zhe.he@windriver.com,
        rostedt@goodmis.org, devel@etsukata.com, hpa@zytor.com,
        luto@kernel.org, tglx@linutronix.de
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org,
          peterz@infradead.org, zhe.he@windriver.com, devel@etsukata.com,
          rostedt@goodmis.org, hpa@zytor.com, luto@kernel.org,
          tglx@linutronix.de
In-Reply-To: <20190711114336.116812491@infradead.org>
References: <20190711114336.116812491@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/mm, tracing: Fix CR2 corruption
Git-Commit-ID: a0d14b8909de55139b8702fe0c7e80b69763dcfb
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  a0d14b8909de55139b8702fe0c7e80b69763dcfb
Gitweb:     https://git.kernel.org/tip/a0d14b8909de55139b8702fe0c7e80b69763dcfb
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Thu, 11 Jul 2019 13:40:59 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 17 Jul 2019 23:17:38 +0200

x86/mm, tracing: Fix CR2 corruption

Despite the current efforts to read CR2 before tracing happens there still
exist a number of possible holes:

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

Reported-by: He Zhe <zhe.he@windriver.com>
Reported-by: Eiichi Tsukata <devel@etsukata.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Cc: bp@alien8.de
Cc: rostedt@goodmis.org
Cc: torvalds@linux-foundation.org
Cc: hpa@zytor.com
Cc: dave.hansen@linux.intel.com
Cc: jgross@suse.com
Cc: joel@joelfernandes.org
Link: https://lkml.kernel.org/r/20190711114336.116812491@infradead.org

Debugged-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/x86/entry/entry_32.S       | 25 ++++++++++++++++++++++---
 arch/x86/entry/entry_64.S       | 35 ++++++++++++++++++-----------------
 arch/x86/include/asm/kvm_para.h |  2 +-
 arch/x86/include/asm/traps.h    |  4 ++--
 arch/x86/kernel/kvm.c           |  8 ++++----
 arch/x86/kernel/traps.c         |  6 +-----
 arch/x86/mm/fault.c             | 30 +++++++++++-------------------
 7 files changed, 59 insertions(+), 51 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 4d4b6100f0e8..2bb986f305ac 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1443,9 +1443,28 @@ BUILD_INTERRUPT3(hv_stimer0_callback_vector, HYPERV_STIMER0_VECTOR,
 
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
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 95ae05f0edf2..7cb2e1f1ec09 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -864,7 +864,7 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
  */
 #define CPU_TSS_IST(x) PER_CPU_VAR(cpu_tss_rw) + (TSS_ist + (x) * 8)
 
-.macro idtentry_part do_sym, has_error_code:req, paranoid:req, shift_ist=-1, ist_offset=0
+.macro idtentry_part do_sym, has_error_code:req, read_cr2:req, paranoid:req, shift_ist=-1, ist_offset=0
 
 	.if \paranoid
 	call	paranoid_entry
@@ -874,12 +874,21 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
 	.endif
 	UNWIND_HINT_REGS
 
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
@@ -923,6 +932,7 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
  *			fresh stack.  (This is for #DB, which has a nasty habit
  *			of recursing.)
  * @create_gap:		create a 6-word stack gap when coming from kernel mode.
+ * @read_cr2:		load CR2 into the 3rd argument; done before calling any C code
  *
  * idtentry generates an IDT stub that sets up a usable kernel context,
  * creates struct pt_regs, and calls @do_sym.  The stub has the following
@@ -947,7 +957,7 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
  * @paranoid == 2 is special: the stub will never switch stacks.  This is for
  * #DF: if the thread stack is somehow unusable, we'll still get a useful OOPS.
  */
-.macro idtentry sym do_sym has_error_code:req paranoid=0 shift_ist=-1 ist_offset=0 create_gap=0
+.macro idtentry sym do_sym has_error_code:req paranoid=0 shift_ist=-1 ist_offset=0 create_gap=0 read_cr2=0
 ENTRY(\sym)
 	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
 
@@ -985,7 +995,7 @@ ENTRY(\sym)
 .Lfrom_usermode_no_gap_\@:
 	.endif
 
-	idtentry_part \do_sym, \has_error_code, \paranoid, \shift_ist, \ist_offset
+	idtentry_part \do_sym, \has_error_code, \read_cr2, \paranoid, \shift_ist, \ist_offset
 
 	.if \paranoid == 1
 	/*
@@ -994,7 +1004,7 @@ ENTRY(\sym)
 	 * run in real process context if user_mode(regs).
 	 */
 .Lfrom_usermode_switch_stack_\@:
-	idtentry_part \do_sym, \has_error_code, paranoid=0
+	idtentry_part \do_sym, \has_error_code, \read_cr2, paranoid=0
 	.endif
 
 _ASM_NOKPROBE(\sym)
@@ -1006,7 +1016,7 @@ idtentry overflow			do_overflow			has_error_code=0
 idtentry bounds				do_bounds			has_error_code=0
 idtentry invalid_op			do_invalid_op			has_error_code=0
 idtentry device_not_available		do_device_not_available		has_error_code=0
-idtentry double_fault			do_double_fault			has_error_code=1 paranoid=2
+idtentry double_fault			do_double_fault			has_error_code=1 paranoid=2 read_cr2=1
 idtentry coprocessor_segment_overrun	do_coprocessor_segment_overrun	has_error_code=0
 idtentry invalid_TSS			do_invalid_TSS			has_error_code=1
 idtentry segment_not_present		do_segment_not_present		has_error_code=1
@@ -1179,10 +1189,10 @@ idtentry xenint3		do_int3			has_error_code=0
 #endif
 
 idtentry general_protection	do_general_protection	has_error_code=1
-idtentry page_fault		do_page_fault		has_error_code=1
+idtentry page_fault		do_page_fault		has_error_code=1	read_cr2=1
 
 #ifdef CONFIG_KVM_GUEST
-idtentry async_page_fault	do_async_page_fault	has_error_code=1
+idtentry async_page_fault	do_async_page_fault	has_error_code=1	read_cr2=1
 #endif
 
 #ifdef CONFIG_X86_MCE
@@ -1281,18 +1291,9 @@ ENTRY(error_entry)
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
diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
index 5ed3cf1c3934..9b4df6eaa11a 100644
--- a/arch/x86/include/asm/kvm_para.h
+++ b/arch/x86/include/asm/kvm_para.h
@@ -92,7 +92,7 @@ void kvm_async_pf_task_wait(u32 token, int interrupt_kernel);
 void kvm_async_pf_task_wake(u32 token);
 u32 kvm_read_and_reset_pf_reason(void);
 extern void kvm_disable_steal_time(void);
-void do_async_page_fault(struct pt_regs *regs, unsigned long error_code);
+void do_async_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address);
 
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
 void __init kvm_spinlock_init(void);
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 7d6f3f3fad78..5dd1674ddf4c 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -74,14 +74,14 @@ dotraplinkage void do_invalid_TSS(struct pt_regs *regs, long error_code);
 dotraplinkage void do_segment_not_present(struct pt_regs *regs, long error_code);
 dotraplinkage void do_stack_segment(struct pt_regs *regs, long error_code);
 #ifdef CONFIG_X86_64
-dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code);
+dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsigned long address);
 asmlinkage __visible notrace struct pt_regs *sync_regs(struct pt_regs *eregs);
 asmlinkage __visible notrace
 struct bad_iret_stack *fixup_bad_iret(struct bad_iret_stack *s);
 void __init trap_init(void);
 #endif
 dotraplinkage void do_general_protection(struct pt_regs *regs, long error_code);
-dotraplinkage void do_page_fault(struct pt_regs *regs, unsigned long error_code);
+dotraplinkage void do_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address);
 dotraplinkage void do_spurious_interrupt_bug(struct pt_regs *regs, long error_code);
 dotraplinkage void do_coprocessor_error(struct pt_regs *regs, long error_code);
 dotraplinkage void do_alignment_check(struct pt_regs *regs, long error_code);
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 82caf01b63dd..3231440d6253 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -242,23 +242,23 @@ EXPORT_SYMBOL_GPL(kvm_read_and_reset_pf_reason);
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
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 87095a477154..4bb0f8447112 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -313,13 +313,10 @@ __visible void __noreturn handle_stack_overflow(const char *message,
 
 #ifdef CONFIG_X86_64
 /* Runs on IST stack */
-dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code)
+dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsigned long cr2)
 {
 	static const char str[] = "double fault";
 	struct task_struct *tsk = current;
-#ifdef CONFIG_VMAP_STACK
-	unsigned long cr2;
-#endif
 
 #ifdef CONFIG_X86_ESPFIX64
 	extern unsigned char native_irq_return_iret[];
@@ -415,7 +412,6 @@ dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code)
 	 * stack even if the actual trigger for the double fault was
 	 * something else.
 	 */
-	cr2 = read_cr2();
 	if ((unsigned long)task_stack_page(tsk) - 1 - cr2 < PAGE_SIZE)
 		handle_stack_overflow("kernel stack overflow (double-fault)", regs, cr2);
 #endif
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 794f364cb882..0799cc79efd3 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1507,9 +1507,8 @@ good_area:
 NOKPROBE_SYMBOL(do_user_addr_fault);
 
 /*
- * This routine handles page faults.  It determines the address,
- * and the problem, and then passes it off to one of the appropriate
- * routines.
+ * Explicitly marked noinline such that the function tracer sees this as the
+ * page_fault entry point.
  */
 static noinline void
 __do_page_fault(struct pt_regs *regs, unsigned long hw_error_code,
@@ -1528,33 +1527,26 @@ __do_page_fault(struct pt_regs *regs, unsigned long hw_error_code,
 }
 NOKPROBE_SYMBOL(__do_page_fault);
 
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
