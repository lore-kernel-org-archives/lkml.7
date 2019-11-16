Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0514C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 11:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9912067D
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 11:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfKPLvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 06:51:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45256 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727588AbfKPLvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 06:51:31 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVwbv-0002AA-C0; Sat, 16 Nov 2019 12:51:27 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 994521C1907;
        Sat, 16 Nov 2019 12:51:23 +0100 (CET)
Date:   Sat, 16 Nov 2019 11:51:23 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/iopl] x86/io: Speedup schedule out of I/O bitmap user
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157390508358.12247.6103605725902471507.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/iopl branch of tip:

Commit-ID:     ecc7e37d4dadd16f6be125ca496feccd05454da4
Gitweb:        https://git.kernel.org/tip/ecc7e37d4dadd16f6be125ca496feccd05454da4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 11 Nov 2019 23:03:20 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 16 Nov 2019 11:24:01 +01:00

x86/io: Speedup schedule out of I/O bitmap user

There is no requirement to update the TSS I/O bitmap when a thread using it is
scheduled out and the incoming thread does not use it.

For the permission check based on the TSS I/O bitmap the CPU calculates the memory
location of the I/O bitmap by the address of the TSS and the io_bitmap_base member
of the tss_struct. The easiest way to invalidate the I/O bitmap is to switch the
offset to an address outside of the TSS limit.

If an I/O instruction is issued from user space the TSS limit causes #GP to be
raised in the same was as valid I/O bitmap with all bits set to 1 would do.

This removes the extra work when an I/O bitmap using task is scheduled out
and puts the burden on the rare I/O bitmap users when they are scheduled
in.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/processor.h | 38 +++++++++++++------
 arch/x86/kernel/cpu/common.c     |  3 +-
 arch/x86/kernel/doublefault.c    |  2 +-
 arch/x86/kernel/ioport.c         |  4 ++-
 arch/x86/kernel/process.c        | 63 +++++++++++++++++--------------
 5 files changed, 69 insertions(+), 41 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 6e0a3b4..6d0059c 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -330,8 +330,23 @@ struct x86_hw_tss {
 #define IO_BITMAP_BITS			65536
 #define IO_BITMAP_BYTES			(IO_BITMAP_BITS/8)
 #define IO_BITMAP_LONGS			(IO_BITMAP_BYTES/sizeof(long))
-#define IO_BITMAP_OFFSET		(offsetof(struct tss_struct, io_bitmap) - offsetof(struct tss_struct, x86_tss))
-#define INVALID_IO_BITMAP_OFFSET	0x8000
+
+#define IO_BITMAP_OFFSET_VALID				\
+	(offsetof(struct tss_struct, io_bitmap) -	\
+	 offsetof(struct tss_struct, x86_tss))
+
+/*
+ * sizeof(unsigned long) coming from an extra "long" at the end
+ * of the iobitmap.
+ *
+ * -1? seg base+limit should be pointing to the address of the
+ * last valid byte
+ */
+#define __KERNEL_TSS_LIMIT	\
+	(IO_BITMAP_OFFSET_VALID + IO_BITMAP_BYTES + sizeof(unsigned long) - 1)
+
+/* Base offset outside of TSS_LIMIT so unpriviledged IO causes #GP */
+#define IO_BITMAP_OFFSET_INVALID	(__KERNEL_TSS_LIMIT + 1)
 
 struct entry_stack {
 	unsigned long		words[64];
@@ -350,6 +365,15 @@ struct tss_struct {
 	struct x86_hw_tss	x86_tss;
 
 	/*
+	 * Store the dirty size of the last io bitmap offender. The next
+	 * one will have to do the cleanup as the switch out to a non io
+	 * bitmap user will just set x86_tss.io_bitmap_base to a value
+	 * outside of the TSS limit. So for sane tasks there is no need to
+	 * actually touch the io_bitmap at all.
+	 */
+	unsigned int		io_bitmap_prev_max;
+
+	/*
 	 * The extra 1 is there because the CPU will access an
 	 * additional byte beyond the end of the IO permission
 	 * bitmap. The extra byte must be all 1 bits, and must
@@ -360,16 +384,6 @@ struct tss_struct {
 
 DECLARE_PER_CPU_PAGE_ALIGNED(struct tss_struct, cpu_tss_rw);
 
-/*
- * sizeof(unsigned long) coming from an extra "long" at the end
- * of the iobitmap.
- *
- * -1? seg base+limit should be pointing to the address of the
- * last valid byte
- */
-#define __KERNEL_TSS_LIMIT	\
-	(IO_BITMAP_OFFSET + IO_BITMAP_BYTES + sizeof(unsigned long) - 1)
-
 /* Per CPU interrupt stacks */
 struct irq_stack {
 	char		stack[IRQ_STACK_SIZE];
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index d52ec1a..8c1000a 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1860,7 +1860,8 @@ void cpu_init(void)
 
 	/* Initialize the TSS. */
 	tss_setup_ist(tss);
-	tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET;
+	tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_INVALID;
+	tss->io_bitmap_prev_max = 0;
 	memset(tss->io_bitmap, 0xff, sizeof(tss->io_bitmap));
 	set_tss_desc(cpu, &get_cpu_entry_area(cpu)->tss.x86_tss);
 
diff --git a/arch/x86/kernel/doublefault.c b/arch/x86/kernel/doublefault.c
index 0b8cedb..cedb07d 100644
--- a/arch/x86/kernel/doublefault.c
+++ b/arch/x86/kernel/doublefault.c
@@ -54,7 +54,7 @@ struct x86_hw_tss doublefault_tss __cacheline_aligned = {
 	.sp0		= STACK_START,
 	.ss0		= __KERNEL_DS,
 	.ldt		= 0,
-	.io_bitmap_base	= INVALID_IO_BITMAP_OFFSET,
+	.io_bitmap_base	= IO_BITMAP_OFFSET_INVALID,
 
 	.ip		= (unsigned long) doublefault_fn,
 	/* 0x2 bit is always set */
diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
index 80fa36b..eed218a 100644
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -82,6 +82,10 @@ long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
 	/* Update the TSS */
 	tss = this_cpu_ptr(&cpu_tss_rw);
 	memcpy(tss->io_bitmap, t->io_bitmap_ptr, bytes_updated);
+	/* Store the new end of the zero bits */
+	tss->io_bitmap_prev_max = bytes;
+	/* Make the bitmap base in the TSS valid */
+	tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_VALID;
 	/* Make sure the TSS limit covers the I/O bitmap. */
 	refresh_tss_limit();
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 7e07f0b..2444fe2 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -72,18 +72,9 @@ __visible DEFINE_PER_CPU_PAGE_ALIGNED(struct tss_struct, cpu_tss_rw) = {
 #ifdef CONFIG_X86_32
 		.ss0 = __KERNEL_DS,
 		.ss1 = __KERNEL_CS,
-		.io_bitmap_base	= INVALID_IO_BITMAP_OFFSET,
 #endif
+		.io_bitmap_base	= IO_BITMAP_OFFSET_INVALID,
 	 },
-#ifdef CONFIG_X86_32
-	 /*
-	  * Note that the .io_bitmap member must be extra-big. This is because
-	  * the CPU will access an additional byte beyond the end of the IO
-	  * permission bitmap. The extra byte must be all 1 bits, and must
-	  * be within the limit.
-	  */
-	.io_bitmap		= { [0 ... IO_BITMAP_LONGS] = ~0 },
-#endif
 };
 EXPORT_PER_CPU_SYMBOL(cpu_tss_rw);
 
@@ -112,18 +103,18 @@ void exit_thread(struct task_struct *tsk)
 	struct thread_struct *t = &tsk->thread;
 	unsigned long *bp = t->io_bitmap_ptr;
 	struct fpu *fpu = &t->fpu;
+	struct tss_struct *tss;
 
 	if (bp) {
-		struct tss_struct *tss = &per_cpu(cpu_tss_rw, get_cpu());
+		preempt_disable();
+		tss = this_cpu_ptr(&cpu_tss_rw);
 
 		t->io_bitmap_ptr = NULL;
-		clear_thread_flag(TIF_IO_BITMAP);
-		/*
-		 * Careful, clear this in the TSS too:
-		 */
-		memset(tss->io_bitmap, 0xff, t->io_bitmap_max);
 		t->io_bitmap_max = 0;
-		put_cpu();
+		clear_thread_flag(TIF_IO_BITMAP);
+		/* Invalidate the io bitmap base in the TSS */
+		tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_INVALID;
+		preempt_enable();
 		kfree(bp);
 	}
 
@@ -369,29 +360,47 @@ void arch_setup_new_exec(void)
 	}
 }
 
-static inline void switch_to_bitmap(struct thread_struct *prev,
-				    struct thread_struct *next,
+static inline void switch_to_bitmap(struct thread_struct *next,
 				    unsigned long tifp, unsigned long tifn)
 {
 	struct tss_struct *tss = this_cpu_ptr(&cpu_tss_rw);
 
 	if (tifn & _TIF_IO_BITMAP) {
 		/*
-		 * Copy the relevant range of the IO bitmap.
-		 * Normally this is 128 bytes or less:
+		 * Copy at least the size of the incoming tasks bitmap
+		 * which covers the last permitted I/O port.
+		 *
+		 * If the previous task which used an io bitmap had more
+		 * bits permitted, then the copy needs to cover those as
+		 * well so they get turned off.
 		 */
 		memcpy(tss->io_bitmap, next->io_bitmap_ptr,
-		       max(prev->io_bitmap_max, next->io_bitmap_max));
+		       max(tss->io_bitmap_prev_max, next->io_bitmap_max));
+
+		/* Store the new max and set io_bitmap_base valid */
+		tss->io_bitmap_prev_max = next->io_bitmap_max;
+		tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_VALID;
+
 		/*
-		 * Make sure that the TSS limit is correct for the CPU
-		 * to notice the IO bitmap.
+		 * Make sure that the TSS limit is covering the io bitmap.
+		 * It might have been cut down by a VMEXIT to 0x67 which
+		 * would cause a subsequent I/O access from user space to
+		 * trigger a #GP because tbe bitmap is outside the TSS
+		 * limit.
 		 */
 		refresh_tss_limit();
 	} else if (tifp & _TIF_IO_BITMAP) {
 		/*
-		 * Clear any possible leftover bits:
+		 * Do not touch the bitmap. Let the next bitmap using task
+		 * deal with the mess. Just make the io_bitmap_base invalid
+		 * by moving it outside the TSS limit so any subsequent I/O
+		 * access from user space will trigger a #GP.
+		 *
+		 * This is correct even when VMEXIT rewrites the TSS limit
+		 * to 0x67 as the only requirement is that the base points
+		 * outside the limit.
 		 */
-		memset(tss->io_bitmap, 0xff, prev->io_bitmap_max);
+		tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_INVALID;
 	}
 }
 
@@ -605,7 +614,7 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
 
 	tifn = READ_ONCE(task_thread_info(next_p)->flags);
 	tifp = READ_ONCE(task_thread_info(prev_p)->flags);
-	switch_to_bitmap(prev, next, tifp, tifn);
+	switch_to_bitmap(next, tifp, tifn);
 
 	propagate_user_return_notify(prev_p, next_p);
 
