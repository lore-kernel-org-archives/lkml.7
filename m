Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A939EC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 11:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C93120700
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 11:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfKPLvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 06:51:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45244 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbfKPLv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 06:51:29 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVwbt-000299-79; Sat, 16 Nov 2019 12:51:25 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 622C61C1904;
        Sat, 16 Nov 2019 12:51:23 +0100 (CET)
Date:   Sat, 16 Nov 2019 11:51:23 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/iopl] x86/ioperm: Move iobitmap data into a struct
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157390508336.12247.4503138620430942841.tip-bot2@tip-bot2>
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

Commit-ID:     577d5cd7e5851d3832066cd0422475fa7db2ee17
Gitweb:        https://git.kernel.org/tip/577d5cd7e5851d3832066cd0422475fa7db2ee17
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 11 Nov 2019 23:03:21 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 16 Nov 2019 11:24:02 +01:00

x86/ioperm: Move iobitmap data into a struct

No point in having all the data in thread_struct, especially as upcoming
changes add more.

Make the bitmap in the new struct accessible as array of longs and as array
of characters via a union, so both the bitmap functions and the update
logic can avoid type casts.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/include/asm/io_bitmap.h | 13 +++++++++++-
 arch/x86/include/asm/processor.h |  6 +----
 arch/x86/kernel/ioport.c         | 27 +++++++++++-----------
 arch/x86/kernel/process.c        | 38 ++++++++++++++++---------------
 arch/x86/kernel/ptrace.c         | 12 ++++++----
 5 files changed, 57 insertions(+), 39 deletions(-)
 create mode 100644 arch/x86/include/asm/io_bitmap.h

diff --git a/arch/x86/include/asm/io_bitmap.h b/arch/x86/include/asm/io_bitmap.h
new file mode 100644
index 0000000..1a12b9f
--- /dev/null
+++ b/arch/x86/include/asm/io_bitmap.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_IOBITMAP_H
+#define _ASM_X86_IOBITMAP_H
+
+#include <asm/processor.h>
+
+struct io_bitmap {
+	/* The maximum number of bytes to copy so all zero bits are covered */
+	unsigned int	max;
+	unsigned long	bitmap[IO_BITMAP_LONGS];
+};
+
+#endif
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index cd7cd7d..c949e0e 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -7,6 +7,7 @@
 /* Forward declaration, a strange C thing */
 struct task_struct;
 struct mm_struct;
+struct io_bitmap;
 struct vm86;
 
 #include <asm/math_emu.h>
@@ -501,10 +502,8 @@ struct thread_struct {
 	struct vm86		*vm86;
 #endif
 	/* IO permissions: */
-	unsigned long		*io_bitmap_ptr;
+	struct io_bitmap	*io_bitmap;
 	unsigned long		iopl;
-	/* Max allowed port in the bitmap, in bytes: */
-	unsigned		io_bitmap_max;
 
 	mm_segment_t		addr_limit;
 
@@ -862,7 +861,6 @@ static inline void spin_lock_prefetch(const void *x)
 #define INIT_THREAD  {							  \
 	.sp0			= TOP_OF_INIT_STACK,			  \
 	.sysenter_cs		= __KERNEL_CS,				  \
-	.io_bitmap_ptr		= NULL,					  \
 	.addr_limit		= KERNEL_DS,				  \
 }
 
diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
index 80d99bb..05f77f3 100644
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -11,6 +11,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 
+#include <asm/io_bitmap.h>
 #include <asm/desc.h>
 
 /*
@@ -21,7 +22,7 @@ long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
 	unsigned int i, max_long, bytes, bytes_updated;
 	struct thread_struct *t = &current->thread;
 	struct tss_struct *tss;
-	unsigned long *bitmap;
+	struct io_bitmap *iobm;
 
 	if ((from + num <= from) || (from + num > IO_BITMAP_BITS))
 		return -EINVAL;
@@ -34,16 +35,16 @@ long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
 	 * IO bitmap up. ioperm() is much less timing critical than clone(),
 	 * this is why we delay this operation until now:
 	 */
-	bitmap = t->io_bitmap_ptr;
-	if (!bitmap) {
+	iobm = t->io_bitmap;
+	if (!iobm) {
 		/* No point to allocate a bitmap just to clear permissions */
 		if (!turn_on)
 			return 0;
-		bitmap = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
-		if (!bitmap)
+		iobm = kmalloc(sizeof(*iobm), GFP_KERNEL);
+		if (!iobm)
 			return -ENOMEM;
 
-		memset(bitmap, 0xff, IO_BITMAP_BYTES);
+		memset(iobm->bitmap, 0xff, sizeof(iobm->bitmap));
 	}
 
 	/*
@@ -52,9 +53,9 @@ long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
 	 */
 	preempt_disable();
 	if (turn_on)
-		bitmap_clear(bitmap, from, num);
+		bitmap_clear(iobm->bitmap, from, num);
 	else
-		bitmap_set(bitmap, from, num);
+		bitmap_set(iobm->bitmap, from, num);
 
 	/*
 	 * Search for a (possibly new) maximum. This is simple and stupid,
@@ -62,26 +63,26 @@ long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
 	 */
 	max_long = 0;
 	for (i = 0; i < IO_BITMAP_LONGS; i++) {
-		if (bitmap[i] != ~0UL)
+		if (iobm->bitmap[i] != ~0UL)
 			max_long = i;
 	}
 
 	bytes = (max_long + 1) * sizeof(unsigned long);
-	bytes_updated = max(bytes, t->io_bitmap_max);
+	bytes_updated = max(bytes, t->io_bitmap->max);
 
 	/* Update the thread data */
-	t->io_bitmap_max = bytes;
+	iobm->max = bytes;
 	/*
 	 * Store the bitmap pointer (might be the same if the task already
 	 * head one). Set the TIF flag, just in case this is the first
 	 * invocation.
 	 */
-	t->io_bitmap_ptr = bitmap;
+	t->io_bitmap = iobm;
 	set_thread_flag(TIF_IO_BITMAP);
 
 	/* Update the TSS */
 	tss = this_cpu_ptr(&cpu_tss_rw);
-	memcpy(tss->io_bitmap.bitmap, t->io_bitmap_ptr, bytes_updated);
+	memcpy(tss->io_bitmap.bitmap, iobm->bitmap, bytes_updated);
 	/* Store the new end of the zero bits */
 	tss->io_bitmap.prev_max = bytes;
 	/* Make the bitmap base in the TSS valid */
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 35f1c80..1504fd2 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -41,6 +41,7 @@
 #include <asm/desc.h>
 #include <asm/prctl.h>
 #include <asm/spec-ctrl.h>
+#include <asm/io_bitmap.h>
 #include <asm/proto.h>
 
 #include "process.h"
@@ -101,21 +102,20 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 void exit_thread(struct task_struct *tsk)
 {
 	struct thread_struct *t = &tsk->thread;
-	unsigned long *bp = t->io_bitmap_ptr;
+	struct io_bitmap *iobm = t->io_bitmap;
 	struct fpu *fpu = &t->fpu;
 	struct tss_struct *tss;
 
-	if (bp) {
+	if (iobm) {
 		preempt_disable();
 		tss = this_cpu_ptr(&cpu_tss_rw);
 
-		t->io_bitmap_ptr = NULL;
-		t->io_bitmap_max = 0;
+		t->io_bitmap = NULL;
 		clear_thread_flag(TIF_IO_BITMAP);
 		/* Invalidate the io bitmap base in the TSS */
 		tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_INVALID;
 		preempt_enable();
-		kfree(bp);
+		kfree(iobm);
 	}
 
 	free_vm86(t);
@@ -135,25 +135,25 @@ static int set_new_tls(struct task_struct *p, unsigned long tls)
 
 static inline int copy_io_bitmap(struct task_struct *tsk)
 {
+	struct io_bitmap *iobm = current->thread.io_bitmap;
+
 	if (likely(!test_tsk_thread_flag(current, TIF_IO_BITMAP)))
 		return 0;
 
-	tsk->thread.io_bitmap_ptr = kmemdup(current->thread.io_bitmap_ptr,
-					    IO_BITMAP_BYTES, GFP_KERNEL);
-	if (!tsk->thread.io_bitmap_ptr) {
-		tsk->thread.io_bitmap_max = 0;
+	tsk->thread.io_bitmap = kmemdup(iobm, sizeof(*iobm), GFP_KERNEL);
+
+	if (!tsk->thread.io_bitmap)
 		return -ENOMEM;
-	}
+
 	set_tsk_thread_flag(tsk, TIF_IO_BITMAP);
 	return 0;
 }
 
 static inline void free_io_bitmap(struct task_struct *tsk)
 {
-	if (tsk->thread.io_bitmap_ptr) {
-		kfree(tsk->thread.io_bitmap_ptr);
-		tsk->thread.io_bitmap_ptr = NULL;
-		tsk->thread.io_bitmap_max = 0;
+	if (tsk->thread.io_bitmap) {
+		kfree(tsk->thread.io_bitmap);
+		tsk->thread.io_bitmap = NULL;
 	}
 }
 
@@ -172,7 +172,7 @@ int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
 	frame->bp = 0;
 	frame->ret_addr = (unsigned long) ret_from_fork;
 	p->thread.sp = (unsigned long) fork_frame;
-	p->thread.io_bitmap_ptr = NULL;
+	p->thread.io_bitmap = NULL;
 	memset(p->thread.ptrace_bps, 0, sizeof(p->thread.ptrace_bps));
 
 #ifdef CONFIG_X86_64
@@ -366,6 +366,8 @@ static inline void switch_to_bitmap(struct thread_struct *next,
 	struct tss_struct *tss = this_cpu_ptr(&cpu_tss_rw);
 
 	if (tifn & _TIF_IO_BITMAP) {
+		struct io_bitmap *iobm = next->io_bitmap;
+
 		/*
 		 * Copy at least the size of the incoming tasks bitmap
 		 * which covers the last permitted I/O port.
@@ -374,11 +376,11 @@ static inline void switch_to_bitmap(struct thread_struct *next,
 		 * bits permitted, then the copy needs to cover those as
 		 * well so they get turned off.
 		 */
-		memcpy(tss->io_bitmap.bitmap, next->io_bitmap_ptr,
-		       max(tss->io_bitmap.prev_max, next->io_bitmap_max));
+		memcpy(tss->io_bitmap.bitmap, next->io_bitmap->bitmap,
+		       max(tss->io_bitmap.prev_max, next->io_bitmap->max));
 
 		/* Store the new max and set io_bitmap_base valid */
-		tss->io_bitmap.prev_max = next->io_bitmap_max;
+		tss->io_bitmap.prev_max = next->io_bitmap->max;
 		tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_VALID;
 
 		/*
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 7c52674..066e5b0 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -42,6 +42,7 @@
 #include <asm/traps.h>
 #include <asm/syscall.h>
 #include <asm/fsgsbase.h>
+#include <asm/io_bitmap.h>
 
 #include "tls.h"
 
@@ -697,7 +698,9 @@ static int ptrace_set_debugreg(struct task_struct *tsk, int n,
 static int ioperm_active(struct task_struct *target,
 			 const struct user_regset *regset)
 {
-	return DIV_ROUND_UP(target->thread.io_bitmap_max, regset->size);
+	struct io_bitmap *iobm = target->thread.io_bitmap;
+
+	return iobm ? DIV_ROUND_UP(iobm->max, regset->size) : 0;
 }
 
 static int ioperm_get(struct task_struct *target,
@@ -705,12 +708,13 @@ static int ioperm_get(struct task_struct *target,
 		      unsigned int pos, unsigned int count,
 		      void *kbuf, void __user *ubuf)
 {
-	if (!target->thread.io_bitmap_ptr)
+	struct io_bitmap *iobm = target->thread.io_bitmap;
+
+	if (!iobm)
 		return -ENXIO;
 
 	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				   target->thread.io_bitmap_ptr,
-				   0, IO_BITMAP_BYTES);
+				   iobm->bitmap, 0, IO_BITMAP_BYTES);
 }
 
 /*
