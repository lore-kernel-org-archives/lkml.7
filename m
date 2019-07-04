Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E66C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 20:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944F221852
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 20:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PzJfPCu9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfGDUDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 16:03:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42170 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfGDUDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 16:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8OUkOSFUSlg8lZ/+shi+ntJHZ3wprpzxgIPHw3BJsZs=; b=PzJfPCu9L0FQedjvOCKCQjv+j7
        q3K8qVRlJKMd1mr64GO1QVgpyFRiTKGOT4Dqj2gYNAmFXvQ31qyeemPv0GIvlfjnEAiVmIDOI0zp2
        9CJVE/Jj2BFpNH66Dg9Sog+yq8FcDhii/Ifbp3c2tKIxm2VlyzmRvWSlKcZSZ+B0IIrOJG0ib6nK9
        A5e9tk5TS/omG3cEc6zBWpZ8pBGQZPl/BHiZkbiCrtddggTLlYrpVd7sUlpBTiP0IwTeMHUcctEo/
        zIQlT8i7yj38mtfd9CZm8Z/8NS6OC/kon0baqVHQYoy9JdaOPnyRC2C0UdNUtme+qKI0x7QKR0Prs
        B4TFNNsw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hj7wb-0006lP-KR; Thu, 04 Jul 2019 20:03:01 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 575F72059DEDD; Thu,  4 Jul 2019 22:02:58 +0200 (CEST)
Message-Id: <20190704200050.648944551@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 04 Jul 2019 21:56:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, bp@alien8.de, mingo@kernel.org,
        rostedt@goodmis.org, luto@kernel.org, torvalds@linux-foundation.org
Cc:     hpa@zytor.com, dave.hansen@linux.intel.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, zhe.he@windriver.com,
        joel@joelfernandes.org, devel@etsukata.com, peterz@infradead.org
Subject: [RFC][PATCH v2 7/7] x86/entry/64: Pull bits into C
References: <20190704195555.580363209@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TODO: 32bit, Xen

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_64.S       |   13 +++-------
 arch/x86/include/asm/idtentry.h |   49 ++++++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/traps.h    |    1 
 arch/x86/kernel/cpu/mce/core.c  |    2 -
 arch/x86/kernel/kvm.c           |    4 ---
 arch/x86/kernel/traps.c         |   30 ++++++++----------------
 arch/x86/mm/fault.c             |    4 ---
 7 files changed, 68 insertions(+), 35 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -841,15 +841,6 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
 	GET_CR2_INTO(%rdx);			/* can clobber %rax */
 	.endif
 
-	TRACE_IRQS_OFF
-
-	.if \paranoid == 0
-	testb	$3, CS(%rsp)
-	jz	.Lfrom_kernel_no_context_tracking_\@
-	CALL_enter_from_user_mode
-.Lfrom_kernel_no_context_tracking_\@:
-	.endif
-
 	movq	%rsp, %rdi			/* pt_regs pointer */
 
 	.if \has_error_code
@@ -863,7 +854,11 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
 	subq	$\ist_offset, CPU_TSS_IST(\shift_ist)
 	.endif
 
+	.if \paranoid
+	call	\do_sym\()_paranoid
+	.else
 	call	\do_sym
+	.endif
 
 	.if \shift_ist != -1
 	addq	$\ist_offset, CPU_TSS_IST(\shift_ist)
--- /dev/null
+++ b/arch/x86/include/asm/idtentry.h
@@ -0,0 +1,49 @@
+#ifndef __ASM_IDTENTRY_H
+#define __ASM_IDTENTRY_H
+
+/* shamelessly stolen from linux/syscalls.h; XXX share */
+
+#define __IDT_MAP0(m,...)
+#define __IDT_MAP1(m,t,a,...) m(t,a)
+#define __IDT_MAP2(m,t,a,...) m(t,a), __IDT_MAP1(m,__VA_ARGS__)
+#define __IDT_MAP3(m,t,a,...) m(t,a), __IDT_MAP2(m,__VA_ARGS__)
+
+#define __IDT_MAP(n,...) __IDT_MAP##n(__VA_ARGS__)
+
+#define __IDT_DECL(t, a) t a
+#define __IDT_ARGS(t, a) a
+#define __IDT_TEST(t, a) (void)BUILD_BUG_ON_ZERO(sizeof(t) != sizeof(long))
+
+#ifdef CONFIG_CONTEXT_TRACKING
+#define CALL_enter_from_user_mode(_regs) \
+	if (static_branch_unlikely(&context_tracking_enabled) && user_mode(_regs)) \
+		enter_from_user_mode()
+#else
+#define CALL_enter_from_user_mode(_regs)
+#endif
+
+#define IDTENTRYx(n, name, ...)	\
+	static notrace void __idt_##name(__IDT_MAP(n, __IDT_DECL, __VA_ARGS__)); \
+	NOKPROBE_SYMBOL(__idt_##name); \
+	dotraplinkage notrace void name(__IDT_MAP(n, __IDT_DECL, __VA_ARGS__)) \
+	{ \
+		__IDT_MAP(n, __IDT_TEST, __VA_ARGS__); \
+		trace_hardirqs_off(); \
+		CALL_enter_from_user_mode(regs); \
+		__idt_##name(__IDT_MAP(n, __IDT_ARGS, __VA_ARGS__)); \
+	} \
+	NOKPROBE_SYMBOL(name); \
+	dotraplinkage notrace void name##_paranoid(__IDT_MAP(n, __IDT_DECL, __VA_ARGS__)) \
+	{ \
+		__IDT_MAP(n, __IDT_TEST, __VA_ARGS__); \
+		trace_hardirqs_off(); \
+		__idt_##name(__IDT_MAP(n, __IDT_ARGS, __VA_ARGS__)); \
+	} \
+	NOKPROBE_SYMBOL(name##_paranoid); \
+	static notrace void __idt_##name(__IDT_MAP(n, __IDT_DECL, __VA_ARGS__))
+
+#define IDTENTRY1(name,...) IDTENTRYx(1, name, __VA_ARGS__)
+#define IDTENTRY2(name,...) IDTENTRYx(2, name, __VA_ARGS__)
+#define IDTENTRY3(name,...) IDTENTRYx(3, name, __VA_ARGS__)
+
+#endif /* __ASM_IDTENTRY_H */
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -7,6 +7,7 @@
 
 #include <asm/debugreg.h>
 #include <asm/siginfo.h>			/* TRAP_TRACE, ... */
+#include <asm/idtentry.h>
 
 #define dotraplinkage __visible
 
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1842,7 +1842,7 @@ static void unexpected_machine_check(str
 void (*machine_check_vector)(struct pt_regs *, long error_code) =
 						unexpected_machine_check;
 
-dotraplinkage void do_mce(struct pt_regs *regs, long error_code)
+IDTENTRY2(do_mce, struct pt_regs *, regs, long, error_code)
 {
 	machine_check_vector(regs, error_code);
 }
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -241,8 +241,7 @@ u32 kvm_read_and_reset_pf_reason(void)
 EXPORT_SYMBOL_GPL(kvm_read_and_reset_pf_reason);
 NOKPROBE_SYMBOL(kvm_read_and_reset_pf_reason);
 
-dotraplinkage void
-do_async_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address)
+IDTENTRY3(do_async_page_fault, struct pt_regs *, regs, unsigned long, error_code, unsigned long, address)
 {
 	enum ctx_state prev_state;
 
@@ -263,7 +262,6 @@ do_async_page_fault(struct pt_regs *regs
 		break;
 	}
 }
-NOKPROBE_SYMBOL(do_async_page_fault);
 
 static void __init paravirt_ops_setup(void)
 {
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -281,7 +281,7 @@ static void do_error_trap(struct pt_regs
 
 #define IP ((void __user *)uprobe_get_trap_addr(regs))
 #define DO_ERROR(trapnr, signr, sicode, addr, str, name)		   \
-dotraplinkage void do_##name(struct pt_regs *regs, long error_code)	   \
+IDTENTRY2(do_##name, struct pt_regs *, regs, long, error_code)		   \
 {									   \
 	do_error_trap(regs, error_code, str, trapnr, signr, sicode, addr); \
 }
@@ -313,7 +313,7 @@ __visible void __noreturn handle_stack_o
 
 #ifdef CONFIG_X86_64
 /* Runs on IST stack */
-dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsigned long cr2)
+IDTENTRY3(do_double_fault, struct pt_regs *, regs, long, error_code, unsigned long, cr2)
 {
 	static const char str[] = "double fault";
 	struct task_struct *tsk = current;
@@ -428,7 +428,7 @@ dotraplinkage void do_double_fault(struc
 }
 #endif
 
-dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
+IDTENTRY2(do_bounds, struct pt_regs *, regs, long, error_code)
 {
 	const struct mpx_bndcsr *bndcsr;
 
@@ -514,8 +514,7 @@ dotraplinkage void do_bounds(struct pt_r
 	do_trap(X86_TRAP_BR, SIGSEGV, "bounds", regs, error_code, 0, NULL);
 }
 
-dotraplinkage void
-do_general_protection(struct pt_regs *regs, long error_code)
+IDTENTRY2(do_general_protection, struct pt_regs *, regs, long, error_code)
 {
 	const char *desc = "general protection fault";
 	struct task_struct *tsk;
@@ -564,9 +563,8 @@ do_general_protection(struct pt_regs *re
 
 	force_sig(SIGSEGV, tsk);
 }
-NOKPROBE_SYMBOL(do_general_protection);
 
-dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code)
+IDTENTRY2(do_int3, struct pt_regs *, regs, long, error_code)
 {
 #ifdef CONFIG_DYNAMIC_FTRACE
 	/*
@@ -611,7 +609,6 @@ dotraplinkage void notrace do_int3(struc
 exit:
 	ist_exit(regs);
 }
-NOKPROBE_SYMBOL(do_int3);
 
 #ifdef CONFIG_X86_64
 /*
@@ -706,7 +703,7 @@ static bool is_sysenter_singlestep(struc
  *
  * May run on IST stack.
  */
-dotraplinkage void do_debug(struct pt_regs *regs, long error_code)
+IDTENTRY2(do_debug, struct pt_regs *, regs, long, error_code)
 {
 	struct task_struct *tsk = current;
 	int user_icebp = 0;
@@ -808,7 +805,6 @@ dotraplinkage void do_debug(struct pt_re
 exit:
 	ist_exit(regs);
 }
-NOKPROBE_SYMBOL(do_debug);
 
 /*
  * Note that we play around with the 'TS' bit in an attempt to get
@@ -855,27 +851,24 @@ static void math_error(struct pt_regs *r
 			(void __user *)uprobe_get_trap_addr(regs), task);
 }
 
-dotraplinkage void do_coprocessor_error(struct pt_regs *regs, long error_code)
+IDTENTRY2(do_coprocessor_error, struct pt_regs *, regs, long, error_code)
 {
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
 	math_error(regs, error_code, X86_TRAP_MF);
 }
 
-dotraplinkage void
-do_simd_coprocessor_error(struct pt_regs *regs, long error_code)
+IDTENTRY2(do_simd_coprocessor_error, struct pt_regs *, regs, long, error_code)
 {
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
 	math_error(regs, error_code, X86_TRAP_XF);
 }
 
-dotraplinkage void
-do_spurious_interrupt_bug(struct pt_regs *regs, long error_code)
+IDTENTRY2(do_spurious_interrupt_bug, struct pt_regs *, regs, long, error_code)
 {
 	cond_local_irq_enable(regs);
 }
 
-dotraplinkage void
-do_device_not_available(struct pt_regs *regs, long error_code)
+IDTENTRY2(do_device_not_available, struct pt_regs *, regs, long,  error_code)
 {
 	unsigned long cr0 = read_cr0();
 
@@ -906,10 +899,9 @@ do_device_not_available(struct pt_regs *
 		die("unexpected #NM exception", regs, error_code);
 	}
 }
-NOKPROBE_SYMBOL(do_device_not_available);
 
 #ifdef CONFIG_X86_32
-dotraplinkage void do_iret_error(struct pt_regs *regs, long error_code)
+IDTENTRY2(do_iret_error, struct pt_regs *, regs, long, error_code)
 {
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
 	local_irq_enable();
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1542,8 +1542,7 @@ trace_page_fault_entries(struct pt_regs
 		trace_page_fault_kernel(address, regs, error_code);
 }
 
-dotraplinkage void
-do_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address)
+IDTENTRY3(do_page_fault, struct pt_regs *, regs, unsigned long, error_code, unsigned long, address)
 {
 	enum ctx_state prev_state;
 
@@ -1552,4 +1551,3 @@ do_page_fault(struct pt_regs *regs, unsi
 	__do_page_fault(regs, error_code, address);
 	exception_exit(prev_state);
 }
-NOKPROBE_SYMBOL(do_page_fault);


