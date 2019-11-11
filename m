Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E79CC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 22:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27AC52184C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 22:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfKKWfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 17:35:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60025 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbfKKWfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 17:35:47 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iUIHf-0000u4-Oi; Mon, 11 Nov 2019 23:35:43 +0100
Message-Id: <20191111223052.199713620@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 11 Nov 2019 23:03:21 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [patch V2 07/16] x86/ioperm: Move iobitmap data into a struct
References: <20191111220314.519933535@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No point in having all the data in thread_struct, especially as upcoming
changes add more.

Make the bitmap in the new struct accessible as array of longs and as array
of characters via a union, so both the bitmap functions and the update
logic can avoid type casts.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 arch/x86/include/asm/iobitmap.h  |   15 ++++++++
 arch/x86/include/asm/processor.h |   21 +++++------
 arch/x86/kernel/cpu/common.c     |    2 -
 arch/x86/kernel/ioport.c         |   69 +++++++++++++++++++--------------------
 arch/x86/kernel/process.c        |   38 +++++++++++----------
 arch/x86/kernel/ptrace.c         |   12 ++++--
 6 files changed, 89 insertions(+), 68 deletions(-)

--- /dev/null
+++ b/arch/x86/include/asm/iobitmap.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_IOBITMAP_H
+#define _ASM_X86_IOBITMAP_H
+
+#include <asm/processor.h>
+
+struct io_bitmap {
+	unsigned int		io_bitmap_max;
+	union {
+		unsigned long	bits[IO_BITMAP_LONGS];
+		unsigned char	bitmap_bytes[IO_BITMAP_BYTES];
+	};
+};
+
+#endif
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -7,6 +7,7 @@
 /* Forward declaration, a strange C thing */
 struct task_struct;
 struct mm_struct;
+struct io_bitmap;
 struct vm86;
 
 #include <asm/math_emu.h>
@@ -328,22 +329,22 @@ struct x86_hw_tss {
  * IO-bitmap sizes:
  */
 #define IO_BITMAP_BITS			65536
-#define IO_BITMAP_BYTES			(IO_BITMAP_BITS/8)
-#define IO_BITMAP_LONGS			(IO_BITMAP_BYTES/sizeof(long))
+#define IO_BITMAP_BYTES			(IO_BITMAP_BITS / BITS_PER_BYTE)
+#define IO_BITMAP_LONGS			(IO_BITMAP_BYTES / sizeof(long))
 
 #define IO_BITMAP_OFFSET_VALID				\
-	(offsetof(struct tss_struct, io_bitmap) -	\
+	(offsetof(struct tss_struct, io_bitmap_bytes) -	\
 	 offsetof(struct tss_struct, x86_tss))
 
 /*
- * sizeof(unsigned long) coming from an extra "long" at the end
- * of the iobitmap.
+ * The extra byte at the end is required by the hardware. It has all
+ * bits set.
  *
  * -1? seg base+limit should be pointing to the address of the
  * last valid byte
  */
 #define __KERNEL_TSS_LIMIT	\
-	(IO_BITMAP_OFFSET_VALID + IO_BITMAP_BYTES + sizeof(unsigned long) - 1)
+	(IO_BITMAP_OFFSET_VALID + IO_BITMAP_BYTES + 1 - 1)
 
 /* Base offset outside of TSS_LIMIT so unpriviledged IO causes #GP */
 #define IO_BITMAP_OFFSET_INVALID	(__KERNEL_TSS_LIMIT + 1)
@@ -379,7 +380,8 @@ struct tss_struct {
 	 * bitmap. The extra byte must be all 1 bits, and must
 	 * be within the limit.
 	 */
-	unsigned long		io_bitmap[IO_BITMAP_LONGS + 1];
+	unsigned char		io_bitmap_bytes[IO_BITMAP_BYTES + 1]
+				__aligned(sizeof(unsigned long));
 } __aligned(PAGE_SIZE);
 
 DECLARE_PER_CPU_PAGE_ALIGNED(struct tss_struct, cpu_tss_rw);
@@ -494,10 +496,8 @@ struct thread_struct {
 	struct vm86		*vm86;
 #endif
 	/* IO permissions: */
-	unsigned long		*io_bitmap_ptr;
+	struct io_bitmap	*io_bitmap;
 	unsigned long		iopl;
-	/* Max allowed port in the bitmap, in bytes: */
-	unsigned		io_bitmap_max;
 
 	mm_segment_t		addr_limit;
 
@@ -855,7 +855,6 @@ static inline void spin_lock_prefetch(co
 #define INIT_THREAD  {							  \
 	.sp0			= TOP_OF_INIT_STACK,			  \
 	.sysenter_cs		= __KERNEL_CS,				  \
-	.io_bitmap_ptr		= NULL,					  \
 	.addr_limit		= KERNEL_DS,				  \
 }
 
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1862,7 +1862,7 @@ void cpu_init(void)
 	tss_setup_ist(tss);
 	tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_INVALID;
 	tss->io_bitmap_prev_max = 0;
-	memset(tss->io_bitmap, 0xff, sizeof(tss->io_bitmap));
+	memset(tss->io_bitmap_bytes, 0xff, sizeof(tss->io_bitmap_bytes));
 	set_tss_desc(cpu, &get_cpu_entry_area(cpu)->tss.x86_tss);
 
 	load_TR_desc();
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -11,6 +11,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 
+#include <asm/iobitmap.h>
 #include <asm/desc.h>
 
 /*
@@ -18,9 +19,10 @@
  */
 long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
 {
+	unsigned int i, max_long, bytes, bytes_updated;
 	struct thread_struct *t = &current->thread;
 	struct tss_struct *tss;
-	unsigned int i, max_long, bytes, bytes_updated;
+	struct io_bitmap *iobm;
 
 	if ((from + num <= from) || (from + num > IO_BITMAP_BITS))
 		return -EINVAL;
@@ -33,62 +35,61 @@ long ksys_ioperm(unsigned long from, uns
 	 * IO bitmap up. ioperm() is much less timing critical than clone(),
 	 * this is why we delay this operation until now:
 	 */
-	if (!t->io_bitmap_ptr) {
-		unsigned long *bitmap = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
+	iobm = t->io_bitmap;
 
-		if (!bitmap)
-			return -ENOMEM;
+	if (!iobm) {
+		if (!turn_on)
+			return 0;
 
-		memset(bitmap, 0xff, IO_BITMAP_BYTES);
+		iobm = kmalloc(sizeof(*iobm), GFP_KERNEL);
+		if (!iobm)
+			return -ENOMEM;
 
-		/*
-		 * Now that we have an IO bitmap, we need our TSS limit to be
-		 * correct.  It's fine if we are preempted after doing this:
-		 * with TIF_IO_BITMAP set, context switches will keep our TSS
-		 * limit correct.
-		 */
-		preempt_disable();
-		t->io_bitmap_ptr = bitmap;
-		set_thread_flag(TIF_IO_BITMAP);
-		/* Make the bitmap base in the TSS valid */
-		tss = this_cpu_ptr(&cpu_tss_rw);
-		tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_VALID;
-		refresh_tss_limit();
-		preempt_enable();
+		memset(iobm->bits, 0xff, sizeof(iobm->bits));
 	}
 
 	/*
-	 * do it in the per-thread copy and in the TSS ...
-	 *
-	 * Disable preemption via get_cpu() - we must not switch away
-	 * because the ->io_bitmap_max value must match the bitmap
-	 * contents:
+	 * Update the tasks bitmap and the TSS copy. This requires to have
+	 * preemption disabled to protect against a context switch.
 	 */
-	tss = &per_cpu(cpu_tss_rw, get_cpu());
+	preempt_disable();
+	tss = this_cpu_ptr(&cpu_tss_rw);
 
+	/* Update the bitmap */
 	if (turn_on)
-		bitmap_clear(t->io_bitmap_ptr, from, num);
+		bitmap_clear(iobm->bits, from, num);
 	else
-		bitmap_set(t->io_bitmap_ptr, from, num);
+		bitmap_set(iobm->bits, from, num);
 
 	/*
 	 * Search for a (possibly new) maximum. This is simple and stupid,
 	 * to keep it obviously correct:
 	 */
 	max_long = 0;
-	for (i = 0; i < IO_BITMAP_LONGS; i++)
-		if (t->io_bitmap_ptr[i] != ~0UL)
+	for (i = 0; i < IO_BITMAP_LONGS; i++) {
+		if (iobm->bits[i] != ~0UL)
 			max_long = i;
+	}
 
 	bytes = (max_long + 1) * sizeof(unsigned long);
-	bytes_updated = max(bytes, t->io_bitmap_max);
+	bytes_updated = max(bytes, iobm->io_bitmap_max);
 
-	t->io_bitmap_max = bytes;
+	iobm->io_bitmap_max = bytes;
 
 	/* Update the TSS: */
-	memcpy(tss->io_bitmap, t->io_bitmap_ptr, bytes_updated);
+	memcpy(tss->io_bitmap_bytes, iobm->bitmap_bytes, bytes_updated);
 
-	put_cpu();
+	/* Set the tasks io_bitmap pointer (might be the same) */
+	t->io_bitmap = iobm;
+	/* Mark it active for context switching */
+	set_thread_flag(TIF_IO_BITMAP);
+
+	/* Make the bitmap base in the TSS valid */
+	tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_VALID;
+
+	/* Make sure the TSS limit covers the I/O bitmap. */
+	refresh_tss_limit();
+	preempt_enable();
 
 	return 0;
 }
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -41,6 +41,7 @@
 #include <asm/desc.h>
 #include <asm/prctl.h>
 #include <asm/spec-ctrl.h>
+#include <asm/iobitmap.h>
 #include <asm/proto.h>
 
 #include "process.h"
@@ -101,21 +102,20 @@ int arch_dup_task_struct(struct task_str
 void exit_thread(struct task_struct *tsk)
 {
 	struct thread_struct *t = &tsk->thread;
-	unsigned long *bp = t->io_bitmap_ptr;
+	struct io_bitmap *bm = t->io_bitmap;
 	struct fpu *fpu = &t->fpu;
 	struct tss_struct *tss;
 
-	if (bp) {
+	if (bm) {
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
+		kfree(bm);
 	}
 
 	free_vm86(t);
@@ -135,25 +135,25 @@ static int set_new_tls(struct task_struc
 
 static inline int copy_io_bitmap(struct task_struct *tsk)
 {
+	struct io_bitmap *bm = current->thread.io_bitmap;
+
 	if (likely(!test_tsk_thread_flag(current, TIF_IO_BITMAP)))
 		return 0;
 
-	tsk->thread.io_bitmap_ptr = kmemdup(current->thread.io_bitmap_ptr,
-					    IO_BITMAP_BYTES, GFP_KERNEL);
-	if (!tsk->thread.io_bitmap_ptr) {
-		tsk->thread.io_bitmap_max = 0;
+	tsk->thread.io_bitmap = kmemdup(bm, sizeof(*bm), GFP_KERNEL);
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
 
@@ -172,7 +172,7 @@ int copy_thread_tls(unsigned long clone_
 	frame->bp = 0;
 	frame->ret_addr = (unsigned long) ret_from_fork;
 	p->thread.sp = (unsigned long) fork_frame;
-	p->thread.io_bitmap_ptr = NULL;
+	p->thread.io_bitmap = NULL;
 	memset(p->thread.ptrace_bps, 0, sizeof(p->thread.ptrace_bps));
 
 #ifdef CONFIG_X86_64
@@ -360,6 +360,8 @@ static inline void switch_to_bitmap(stru
 	struct tss_struct *tss = this_cpu_ptr(&cpu_tss_rw);
 
 	if (tifn & _TIF_IO_BITMAP) {
+		struct io_bitmap *iobm = next->io_bitmap;
+
 		/*
 		 * Copy at least the size of the incoming tasks bitmap
 		 * which covers the last permitted I/O port.
@@ -368,11 +370,11 @@ static inline void switch_to_bitmap(stru
 		 * bits permitted, then the copy needs to cover those as
 		 * well so they get turned off.
 		 */
-		memcpy(tss->io_bitmap, next->io_bitmap_ptr,
-		       max(tss->io_bitmap_prev_max, next->io_bitmap_max));
+		memcpy(tss->io_bitmap_bytes, iobm->bitmap_bytes,
+		       max(tss->io_bitmap_prev_max, iobm->io_bitmap_max));
 
 		/* Store the new max and set io_bitmap_base valid */
-		tss->io_bitmap_prev_max = next->io_bitmap_max;
+		tss->io_bitmap_prev_max = iobm->io_bitmap_max;
 		tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_VALID;
 
 		/*
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -42,6 +42,7 @@
 #include <asm/traps.h>
 #include <asm/syscall.h>
 #include <asm/fsgsbase.h>
+#include <asm/iobitmap.h>
 
 #include "tls.h"
 
@@ -697,7 +698,9 @@ static int ptrace_set_debugreg(struct ta
 static int ioperm_active(struct task_struct *target,
 			 const struct user_regset *regset)
 {
-	return DIV_ROUND_UP(target->thread.io_bitmap_max, regset->size);
+	struct io_bitmap *iobm = target->thread.io_bitmap;
+
+	return iobm ? DIV_ROUND_UP(iobm->io_bitmap_max, regset->size) : 0;
 }
 
 static int ioperm_get(struct task_struct *target,
@@ -705,12 +708,13 @@ static int ioperm_get(struct task_struct
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
+				   iobm->bitmap_bytes, 0, IO_BITMAP_BYTES);
 }
 
 /*


