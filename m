Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD6EC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD6F20678
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfK0ITu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 03:19:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43990 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfK0ITo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 03:19:44 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iZsXp-0002Pf-Uz; Wed, 27 Nov 2019 09:19:30 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9B4EF1C1E6F;
        Wed, 27 Nov 2019 09:19:29 +0100 (CET)
Date:   Wed, 27 Nov 2019 08:19:29 -0000
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/doublefault/32: Rewrite the x86_32 #DF handler
 and unify with 64-bit
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157484276952.21853.12670331682805657771.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     7d8d8cfdee9a7bd6f9682f253fa98efdd8048a9e
Gitweb:        https://git.kernel.org/tip/7d8d8cfdee9a7bd6f9682f253fa98efdd8048a9e
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Wed, 20 Nov 2019 23:06:41 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 Nov 2019 22:00:04 +01:00

x86/doublefault/32: Rewrite the x86_32 #DF handler and unify with 64-bit

The old x86_32 doublefault_fn() was old and crufty, and it did not
even try to recover.  do_double_fault() is much nicer.  Rewrite the
32-bit double fault code to sanitize CPU state and call
do_double_fault().  This is mostly an exercise i386 archaeology.

With this patch applied, 32-bit double faults get a real stack trace,
just like 64-bit double faults.

[ mingo: merged the patch to a later kernel base. ]

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/entry_32.S        |  42 ++++++++++++-
 arch/x86/include/asm/traps.h     |   3 +-
 arch/x86/kernel/doublefault_32.c | 107 +++++++++++++++++++++---------
 arch/x86/kernel/traps.c          |  19 ++++-
 4 files changed, 138 insertions(+), 33 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 5832b11..632432b 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1537,6 +1537,48 @@ SYM_CODE_START(debug)
 	jmp	common_exception
 SYM_CODE_END(debug)
 
+#ifdef CONFIG_DOUBLEFAULT
+SYM_CODE_START(double_fault)
+1:
+	/*
+	 * This is a task gate handler, not an interrupt gate handler.
+	 * The error code is on the stack, but the stack is otherwise
+	 * empty.  Interrupts are off.  Our state is sane with the following
+	 * exceptions:
+	 *
+	 *  - CR0.TS is set.  "TS" literally means "task switched".
+	 *  - EFLAGS.NT is set because we're a "nested task".
+	 *  - The doublefault TSS has back_link set and has been marked busy.
+	 *  - TR points to the doublefault TSS and the normal TSS is busy.
+	 *  - CR3 is the normal kernel PGD.  This would be delightful, except
+	 *    that the CPU didn't bother to save the old CR3 anywhere.  This
+	 *    would make it very awkward to return back to the context we came
+	 *    from.
+	 *
+	 * The rest of EFLAGS is sanitized for us, so we don't need to
+	 * worry about AC or DF.
+	 *
+	 * Don't even bother popping the error code.  It's always zero,
+	 * and ignoring it makes us a bit more robust against buggy
+	 * hypervisor task gate implementations.
+	 *
+	 * We will manually undo the task switch instead of doing a
+	 * task-switching IRET.
+	 */
+
+	clts				/* clear CR0.TS */
+	pushl	$X86_EFLAGS_FIXED
+	popfl				/* clear EFLAGS.NT */
+
+	call	doublefault_shim
+
+	/* We don't support returning, so we have no IRET here. */
+1:
+	hlt
+	jmp 1b
+SYM_CODE_END(double_fault)
+#endif
+
 /*
  * NMI is doubly nasty.  It can happen on the first instruction of
  * entry_SYSENTER_32 (just like #DB), but it can also interrupt the beginning
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index b25e633..ffa0dc8 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -69,6 +69,9 @@ dotraplinkage void do_overflow(struct pt_regs *regs, long error_code);
 dotraplinkage void do_bounds(struct pt_regs *regs, long error_code);
 dotraplinkage void do_invalid_op(struct pt_regs *regs, long error_code);
 dotraplinkage void do_device_not_available(struct pt_regs *regs, long error_code);
+#if defined(CONFIG_X86_64) || defined(CONFIG_DOUBLEFAULT)
+dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsigned long cr2);
+#endif
 dotraplinkage void do_coprocessor_segment_overrun(struct pt_regs *regs, long error_code);
 dotraplinkage void do_invalid_TSS(struct pt_regs *regs, long error_code);
 dotraplinkage void do_segment_not_present(struct pt_regs *regs, long error_code);
diff --git a/arch/x86/kernel/doublefault_32.c b/arch/x86/kernel/doublefault_32.c
index 4eecfe4..3793646 100644
--- a/arch/x86/kernel/doublefault_32.c
+++ b/arch/x86/kernel/doublefault_32.c
@@ -9,42 +9,83 @@
 #include <asm/pgtable.h>
 #include <asm/processor.h>
 #include <asm/desc.h>
+#include <asm/traps.h>
 
+extern void double_fault(void);
 #define ptr_ok(x) ((x) > PAGE_OFFSET && (x) < PAGE_OFFSET + MAXMEM)
 
-static void doublefault_fn(void)
-{
-	struct desc_ptr gdt_desc = {0, 0};
-	unsigned long gdt, tss;
+#define TSS(x) this_cpu_read(cpu_tss_rw.x86_tss.x)
 
-	BUILD_BUG_ON(sizeof(struct doublefault_stack) != PAGE_SIZE);
+static void set_df_gdt_entry(unsigned int cpu);
 
-	native_store_gdt(&gdt_desc);
-	gdt = gdt_desc.address;
+/*
+ * Called by double_fault with CR0.TS and EFLAGS.NT cleared.  The CPU thinks
+ * we're running the doublefault task.  Cannot return.
+ */
+asmlinkage notrace void __noreturn doublefault_shim(void)
+{
+	unsigned long cr2;
+	struct pt_regs regs;
 
-	printk(KERN_EMERG "PANIC: double fault, gdt at %08lx [%d bytes]\n", gdt, gdt_desc.size);
+	BUILD_BUG_ON(sizeof(struct doublefault_stack) != PAGE_SIZE);
 
-	if (ptr_ok(gdt)) {
-		gdt += GDT_ENTRY_TSS << 3;
-		tss = get_desc_base((struct desc_struct *)gdt);
-		printk(KERN_EMERG "double fault, tss at %08lx\n", tss);
+	cr2 = native_read_cr2();
 
-		if (ptr_ok(tss)) {
-			struct x86_hw_tss *t = (struct x86_hw_tss *)tss;
+	/* Reset back to the normal kernel task. */
+	force_reload_TR();
+	set_df_gdt_entry(smp_processor_id());
 
-			printk(KERN_EMERG "eip = %08lx, esp = %08lx\n",
-			       t->ip, t->sp);
+	trace_hardirqs_off();
 
-			printk(KERN_EMERG "eax = %08lx, ebx = %08lx, ecx = %08lx, edx = %08lx\n",
-				t->ax, t->bx, t->cx, t->dx);
-			printk(KERN_EMERG "esi = %08lx, edi = %08lx\n",
-				t->si, t->di);
-		}
-	}
+	/*
+	 * Fill in pt_regs.  A downside of doing this in C is that the unwinder
+	 * won't see it (no ENCODE_FRAME_POINTER), so a nested stack dump
+	 * won't successfully unwind to the source of the double fault.
+	 * The main dump from do_double_fault() is fine, though, since it
+	 * uses these regs directly.
+	 *
+	 * If anyone ever cares, this could be moved to asm.
+	 */
+	regs.ss		= TSS(ss);
+	regs.__ssh	= 0;
+	regs.sp		= TSS(sp);
+	regs.flags	= TSS(flags);
+	regs.cs		= TSS(cs);
+	/* We won't go through the entry asm, so we can leave __csh as 0. */
+	regs.__csh	= 0;
+	regs.ip		= TSS(ip);
+	regs.orig_ax	= 0;
+	regs.gs		= TSS(gs);
+	regs.__gsh	= 0;
+	regs.fs		= TSS(fs);
+	regs.__fsh	= 0;
+	regs.es		= TSS(es);
+	regs.__esh	= 0;
+	regs.ds		= TSS(ds);
+	regs.__dsh	= 0;
+	regs.ax		= TSS(ax);
+	regs.bp		= TSS(bp);
+	regs.di		= TSS(di);
+	regs.si		= TSS(si);
+	regs.dx		= TSS(dx);
+	regs.cx		= TSS(cx);
+	regs.bx		= TSS(bx);
+
+	do_double_fault(&regs, 0, cr2);
 
-	for (;;)
-		cpu_relax();
+	/*
+	 * x86_32 does not save the original CR3 anywhere on a task switch.
+	 * This means that, even if we wanted to return, we would need to find
+	 * some way to reconstruct CR3.  We could make a credible guess based
+	 * on cpu_tlbstate, but that would be racy and would not account for
+	 * PTI.
+	 *
+	 * Instead, don't bother.  We can return through
+	 * rewind_stack_do_exit() instead.
+	 */
+	panic("cannot return from double fault\n");
 }
+NOKPROBE_SYMBOL(doublefault_shim);
 
 DEFINE_PER_CPU_PAGE_ALIGNED(struct doublefault_stack, doublefault_stack) = {
 	.tss = {
@@ -55,9 +96,8 @@ DEFINE_PER_CPU_PAGE_ALIGNED(struct doublefault_stack, doublefault_stack) = {
 		.ldt		= 0,
 	.io_bitmap_base	= IO_BITMAP_OFFSET_INVALID,
 
-		.ip		= (unsigned long) doublefault_fn,
-		/* 0x2 bit is always set */
-		.flags		= X86_EFLAGS_SF | 0x2,
+		.ip		= (unsigned long) double_fault,
+		.flags		= X86_EFLAGS_FIXED,
 		.es		= __USER_DS,
 		.cs		= __KERNEL_CS,
 		.ss		= __KERNEL_DS,
@@ -71,6 +111,14 @@ DEFINE_PER_CPU_PAGE_ALIGNED(struct doublefault_stack, doublefault_stack) = {
 	},
 };
 
+static void set_df_gdt_entry(unsigned int cpu)
+{
+	/* Set up doublefault TSS pointer in the GDT */
+	__set_tss_desc(cpu, GDT_ENTRY_DOUBLEFAULT_TSS,
+		       &get_cpu_entry_area(cpu)->doublefault_stack.tss);
+
+}
+
 void doublefault_init_cpu_tss(void)
 {
 	unsigned int cpu = smp_processor_id();
@@ -84,8 +132,5 @@ void doublefault_init_cpu_tss(void)
                        (unsigned long)&cea->doublefault_stack.stack +
                        sizeof(doublefault_stack.stack));
 
-	/* Set up doublefault TSS pointer in the GDT */
-	__set_tss_desc(cpu, GDT_ENTRY_DOUBLEFAULT_TSS,
-		       &get_cpu_entry_area(cpu)->doublefault_stack.tss);
-
+	set_df_gdt_entry(cpu);
 }
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 76381b0..a9b16c3 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -306,8 +306,23 @@ __visible void __noreturn handle_stack_overflow(const char *message,
 }
 #endif
 
-#ifdef CONFIG_X86_64
-/* Runs on IST stack */
+#if defined(CONFIG_X86_64) || defined(CONFIG_DOUBLEFAULT)
+/*
+ * Runs on an IST stack for x86_64 and on a special task stack for x86_32.
+ *
+ * On x86_64, this is more or less a normal kernel entry.  Notwithstanding the
+ * SDM's warnings about double faults being unrecoverable, returning works as
+ * expected.  Presumably what the SDM actually means is that the CPU may get
+ * the register state wrong on entry, so returning could be a bad idea.
+ *
+ * Various CPU engineers have promised that double faults due to an IRET fault
+ * while the stack is read-only are, in fact, recoverable.
+ *
+ * On x86_32, this is entered through a task gate, and regs are synthesized
+ * from the TSS.  Returning is, in principle, okay, but changes to regs will
+ * be lost.  If, for some reason, we need to return to a context with modified
+ * regs, the shim code could be adjusted to synchronize the registers.
+ */
 dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsigned long cr2)
 {
 	static const char str[] = "double fault";
