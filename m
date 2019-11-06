Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24632C5DF64
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 20:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A7B217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 20:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732693AbfKFU5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 15:57:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45282 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731910AbfKFU4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 15:56:48 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iSSMB-00033D-2a; Wed, 06 Nov 2019 21:56:47 +0100
Message-Id: <20191106202806.518518372@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 06 Nov 2019 20:35:07 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [patch 8/9] x86/iopl: Remove legacy IOPL option
References: <20191106193459.581614484@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IOPL emulation via the I/O bitmap is sufficient. Remove the legacy
cruft dealing with the (e)flags based IOPL mechanism.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/Kconfig                      |   10 ----
 arch/x86/include/asm/paravirt.h       |    4 -
 arch/x86/include/asm/paravirt_types.h |    2 
 arch/x86/include/asm/processor.h      |   26 +---------
 arch/x86/include/asm/xen/hypervisor.h |    2 
 arch/x86/kernel/ioport.c              |   84 +++++++++++-----------------------
 arch/x86/kernel/paravirt.c            |    2 
 arch/x86/kernel/process_32.c          |    9 ---
 arch/x86/kernel/process_64.c          |   11 ----
 arch/x86/xen/enlighten_pv.c           |   10 ----
 10 files changed, 34 insertions(+), 126 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1269,14 +1269,8 @@ config X86_IOPL_EMULATION
 
 	  The emulation restricts the functionality of the syscall to
 	  only allowing the full range I/O port access, but prevents the
-	  ability to disable interrupts from user space.
-
-config X86_IOPL_LEGACY
-	bool "IOPL Legacy"
-	---help---
-	Allow the full IOPL permissions, i.e. user space access to all
-	65536 I/O ports and also the ability to disable interrupts, which
-	is overbroad and can result in system lockups.
+	  ability to disable interrupts from user space which would be
+	  granted if the hardware IOPL mechanism would be used.
 
 config X86_IOPL_NONE
 	bool "IOPL None"
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -294,10 +294,6 @@ static inline void write_idt_entry(gate_
 {
 	PVOP_VCALL3(cpu.write_idt_entry, dt, entry, g);
 }
-static inline void set_iopl_mask(unsigned mask)
-{
-	PVOP_VCALL1(cpu.set_iopl_mask, mask);
-}
 
 static inline void paravirt_activate_mm(struct mm_struct *prev,
 					struct mm_struct *next)
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -140,8 +140,6 @@ struct pv_cpu_ops {
 
 	void (*load_sp0)(unsigned long sp0);
 
-	void (*set_iopl_mask)(unsigned mask);
-
 	void (*wbinvd)(void);
 
 	/* cpuid emulation, mostly so that caps bits can be disabled */
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -508,10 +508,10 @@ struct thread_struct {
 	unsigned int		io_zerobits_end;
 
 	/*
-	 * IOPL. Priviledge level dependent I/O permission which includes
-	 * user space CLI/STI when granted.
+	 * IOPL. Priviledge level dependent I/O permission which is
+	 * emulated via the I/O bitmap to prevent user space from disabling
+	 * interrupts.
 	 */
-	unsigned long		iopl;
 	unsigned long		iopl_emul;
 
 	mm_segment_t		addr_limit;
@@ -547,25 +547,6 @@ extern void tss_update_io_bitmap(struct
  */
 #define TS_COMPAT		0x0002	/* 32bit syscall active (64BIT)*/
 
-/*
- * Set IOPL bits in EFLAGS from given mask
- */
-static inline void native_set_iopl_mask(unsigned mask)
-{
-#ifdef CONFIG_X86_32
-	unsigned int reg;
-
-	asm volatile ("pushfl;"
-		      "popl %0;"
-		      "andl %1, %0;"
-		      "orl %2, %0;"
-		      "pushl %0;"
-		      "popfl"
-		      : "=&r" (reg)
-		      : "i" (~X86_EFLAGS_IOPL), "r" (mask));
-#endif
-}
-
 static inline void
 native_load_sp0(unsigned long sp0)
 {
@@ -605,7 +586,6 @@ static inline void load_sp0(unsigned lon
 	native_load_sp0(sp0);
 }
 
-#define set_iopl_mask native_set_iopl_mask
 #endif /* CONFIG_PARAVIRT_XXL */
 
 /* Free all resources held by a thread. */
--- a/arch/x86/include/asm/xen/hypervisor.h
+++ b/arch/x86/include/asm/xen/hypervisor.h
@@ -62,6 +62,4 @@ void xen_arch_register_cpu(int num);
 void xen_arch_unregister_cpu(int num);
 #endif
 
-extern void xen_set_iopl_mask(unsigned mask);
-
 #endif /* _ASM_X86_XEN_HYPERVISOR_H */
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -164,21 +164,17 @@ SYSCALL_DEFINE3(ioperm, unsigned long, f
 
 /*
  * The sys_iopl functionality depends on the level argument, which if
- * granted for the task is used by the CPU to check I/O instruction and
- * CLI/STI against the current priviledge level (CPL). If CPL is less than
- * or equal the tasks IOPL level the instructions take effect. If not a #GP
- * is raised. The default IOPL is 0, i.e. no permissions.
+ * granted for the task is used to enable access to all 65536 I/O ports.
  *
- * Setting IOPL to level 0-2 is disabling the userspace access. Only level
- * 3 enables it. If set it allows the user space thread:
+ * This does not use the IOPL mechanism provided by the CPU as that would
+ * also allow the user space task to use the CLI/STI instructions.
  *
- * - Unrestricted access to all 65535 I/O ports
- * - The usage of CLI/STI instructions
+ * Disabling interrupts in a user space task is dangerous as it might lock
+ * up the machine and the semantics vs. syscalls and exceptions is
+ * undefined.
  *
- * The advantage over ioperm is that the context switch does not require to
- * update the I/O bitmap which is especially true when a large number of
- * ports is accessed. But the allowance of CLI/STI in userspace is
- * considered a major problem.
+ * Setting IOPL to level 0-2 is disabling I/O permissions. Level 3
+ * 3 enables them.
  *
  * IOPL is strictly per thread and inherited on fork.
  */
@@ -186,6 +182,8 @@ SYSCALL_DEFINE1(iopl, unsigned int, leve
 {
 	struct thread_struct *t = &current->thread;
 	struct pt_regs *regs = current_pt_regs();
+	struct tss_struct *tss;
+	unsigned int tss_base;
 	unsigned int old;
 
 	/*
@@ -198,10 +196,7 @@ SYSCALL_DEFINE1(iopl, unsigned int, leve
 	if (level > 3)
 		return -EINVAL;
 
-	if (IS_ENABLED(CONFIG_X86_IOPL_EMULATION))
-		old = t->iopl_emul;
-	else
-		old = t->iopl >> X86_EFLAGS_IOPL_BIT;
+	old = t->iopl_emul;
 
 	/* No point in going further if nothing changes */
 	if (level == old)
@@ -214,47 +209,26 @@ SYSCALL_DEFINE1(iopl, unsigned int, leve
 			return -EPERM;
 	}
 
-	if (IS_ENABLED(CONFIG_X86_IOPL_EMULATION)) {
-		struct tss_struct *tss;
-		unsigned int tss_base;
-
-		/* Prevent racing against a task switch */
-		preempt_disable();
-		tss = this_cpu_ptr(&cpu_tss_rw);
-		if (level == 3) {
-			/* Grant access to all I/O ports */
-			set_thread_flag(TIF_IO_BITMAP);
-			tss_base = IO_BITMAP_OFFSET_VALID_ALL;
-		} else if (t->io_bitmap_ptr) {
-			/* Thread has a I/O bitmap */
-			tss_update_io_bitmap(tss, t);
-			set_thread_flag(TIF_IO_BITMAP);
-			tss_base = IO_BITMAP_OFFSET_VALID_MAP;
-		} else {
-			/* Take it out of the context switch work burden */
-			clear_thread_flag(TIF_IO_BITMAP);
-			tss_base = IO_BITMAP_OFFSET_INVALID;
-		}
-		tss->x86_tss.io_bitmap_base = tss_base;
-		t->iopl_emul = level;
-		preempt_enable();
-
+	/* Prevent racing against a task switch */
+	preempt_disable();
+	tss = this_cpu_ptr(&cpu_tss_rw);
+	if (level == 3) {
+		/* Grant access to all I/O ports */
+		set_thread_flag(TIF_IO_BITMAP);
+		tss_base = IO_BITMAP_OFFSET_VALID_ALL;
+	} else if (t->io_bitmap_ptr) {
+		/* Thread has a I/O bitmap */
+		tss_update_io_bitmap(tss, t);
+		set_thread_flag(TIF_IO_BITMAP);
+		tss_base = IO_BITMAP_OFFSET_VALID_MAP;
 	} else {
-		/*
-		 * Change the flags value on the return stack, which has
-		 * been set up on system-call entry. See also the fork and
-		 * signal handling code how this is handled.
-		 */
-		regs->flags = (regs->flags & ~X86_EFLAGS_IOPL) |
-			(level << X86_EFLAGS_IOPL_BIT);
-		/* Store the new level in the thread struct */
-		t->iopl = level << X86_EFLAGS_IOPL_BIT;
-		/*
-		 * X86_32 switches immediately and XEN handles it via
-		 * emulation.
-		 */
-		set_iopl_mask(t->iopl);
+		/* Take it out of the context switch work burden */
+		clear_thread_flag(TIF_IO_BITMAP);
+		tss_base = IO_BITMAP_OFFSET_INVALID;
 	}
+	tss->x86_tss.io_bitmap_base = tss_base;
+	t->iopl_emul = level;
+	preempt_enable();
 
 	return 0;
 }
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -341,8 +341,6 @@ struct paravirt_patch_template pv_ops =
 	.cpu.iret		= native_iret,
 	.cpu.swapgs		= native_swapgs,
 
-	.cpu.set_iopl_mask	= native_set_iopl_mask,
-
 	.cpu.start_context_switch	= paravirt_nop,
 	.cpu.end_context_switch		= paravirt_nop,
 
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -187,15 +187,6 @@ EXPORT_SYMBOL_GPL(start_thread);
 	 */
 	load_TLS(next, cpu);
 
-	/*
-	 * Restore IOPL if needed.  In normal use, the flags restore
-	 * in the switch assembly will handle this.  But if the kernel
-	 * is running virtualized at a non-zero CPL, the popf will
-	 * not restore flags, so it must be done in a separate step.
-	 */
-	if (get_kernel_rpl() && unlikely(prev->iopl != next->iopl))
-		set_iopl_mask(next->iopl);
-
 	switch_to_extra(prev_p, next_p);
 
 	/*
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -497,17 +497,6 @@ void compat_start_thread(struct pt_regs
 
 	switch_to_extra(prev_p, next_p);
 
-#ifdef CONFIG_XEN_PV
-	/*
-	 * On Xen PV, IOPL bits in pt_regs->flags have no effect, and
-	 * current_pt_regs()->flags may not match the current task's
-	 * intended IOPL.  We need to switch it manually.
-	 */
-	if (unlikely(static_cpu_has(X86_FEATURE_XENPV) &&
-		     prev->iopl != next->iopl))
-		xen_set_iopl_mask(next->iopl);
-#endif
-
 	if (static_cpu_has_bug(X86_BUG_SYSRET_SS_ATTRS)) {
 		/*
 		 * AMD CPUs have a misfeature: SYSRET sets the SS selector but
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -829,15 +829,6 @@ static void xen_load_sp0(unsigned long s
 	this_cpu_write(cpu_tss_rw.x86_tss.sp0, sp0);
 }
 
-void xen_set_iopl_mask(unsigned mask)
-{
-	struct physdev_set_iopl set_iopl;
-
-	/* Force the change at ring 0. */
-	set_iopl.iopl = (mask == 0) ? 1 : (mask >> 12) & 3;
-	HYPERVISOR_physdev_op(PHYSDEVOP_set_iopl, &set_iopl);
-}
-
 static void xen_io_delay(void)
 {
 }
@@ -1047,7 +1038,6 @@ static const struct pv_cpu_ops xen_cpu_o
 	.write_idt_entry = xen_write_idt_entry,
 	.load_sp0 = xen_load_sp0,
 
-	.set_iopl_mask = xen_set_iopl_mask,
 	.io_delay = xen_io_delay,
 
 	/* Xen takes care of %gs when switching to usermode for us */


