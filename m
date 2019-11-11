Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AC7C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 22:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1382921872
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 22:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfKKWgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 17:36:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60044 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfKKWfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 17:35:47 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iUIHh-0000uR-63; Mon, 11 Nov 2019 23:35:45 +0100
Message-Id: <20191111223052.400498664@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 11 Nov 2019 23:03:23 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [patch V2 09/16] x86/ioperm: Move TSS bitmap update to exit to user
 work
References: <20191111220314.519933535@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point to update the TSS bitmap for tasks which use I/O bitmaps
on every context switch. It's enough to update it right before exiting to
user space.

That reduces the context switch bitmap handling to invalidating the io
bitmap base offset in the TSS when the outgoing task has TIF_IO_BITMAP
set. It also removes the requirement to update the tasks bitmap atomically
in ioperm().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 arch/x86/entry/common.c         |    4 ++
 arch/x86/include/asm/iobitmap.h |    2 +
 arch/x86/kernel/ioport.c        |   27 +++----------------
 arch/x86/kernel/process.c       |   56 +++++++++++++++++++++++++---------------
 4 files changed, 47 insertions(+), 42 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -33,6 +33,7 @@
 #include <asm/cpufeature.h>
 #include <asm/fpu/api.h>
 #include <asm/nospec-branch.h>
+#include <asm/iobitmap.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
@@ -196,6 +197,9 @@ static void exit_to_usermode_loop(struct
 	/* Reload ti->flags; we may have rescheduled above. */
 	cached_flags = READ_ONCE(ti->flags);
 
+	if (unlikely(cached_flags & _TIF_IO_BITMAP))
+		tss_update_io_bitmap();
+
 	fpregs_assert_state_consistent();
 	if (unlikely(cached_flags & _TIF_NEED_FPU_LOAD))
 		switch_fpu_return();
--- a/arch/x86/include/asm/iobitmap.h
+++ b/arch/x86/include/asm/iobitmap.h
@@ -13,4 +13,6 @@ struct io_bitmap {
 	};
 };
 
+void tss_update_io_bitmap(void);
+
 #endif
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -21,9 +21,8 @@ static atomic64_t io_bitmap_sequence;
  */
 long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
 {
-	unsigned int i, max_long, bytes, bytes_updated;
 	struct thread_struct *t = &current->thread;
-	struct tss_struct *tss;
+	unsigned int i, max_long;
 	struct io_bitmap *iobm;
 
 	if ((from + num <= from) || (from + num > IO_BITMAP_BITS))
@@ -51,13 +50,9 @@ long ksys_ioperm(unsigned long from, uns
 	}
 
 	/*
-	 * Update the tasks bitmap and the TSS copy. This requires to have
-	 * preemption disabled to protect against a context switch.
+	 * Update the tasks bitmap. The update of the TSS bitmap happens on
+	 * exit to user mode. So this needs no protection.
 	 */
-	preempt_disable();
-	tss = this_cpu_ptr(&cpu_tss_rw);
-
-	/* Update the bitmap */
 	if (turn_on)
 		bitmap_clear(iobm->bits, from, num);
 	else
@@ -73,27 +68,15 @@ long ksys_ioperm(unsigned long from, uns
 			max_long = i;
 	}
 
-	bytes = (max_long + 1) * sizeof(unsigned long);
-	bytes_updated = max(bytes, iobm->io_bitmap_max);
-
-	iobm->io_bitmap_max = bytes;
+	iobm->io_bitmap_max = (max_long + 1) * sizeof(unsigned long);
 
 	/* Update the sequence number to force an update in switch_to() */
 	iobm->sequence = atomic64_add_return(1, &io_bitmap_sequence);
 	/* Set the tasks io_bitmap pointer (might be the same) */
 	t->io_bitmap = iobm;
-	/* Mark it active for context switching */
+	/* Mark it active for context switching and exit to user mode */
 	set_thread_flag(TIF_IO_BITMAP);
 
-	/* Update the TSS: */
-	memcpy(tss->io_bitmap_bytes, iobm->bitmap_bytes, bytes_updated);
-	/* Make the bitmap base in the TSS valid */
-	tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_VALID;
-
-	/* Make sure the TSS limit covers the I/O bitmap. */
-	refresh_tss_limit();
-	preempt_enable();
-
 	return 0;
 }
 
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -354,8 +354,31 @@ void arch_setup_new_exec(void)
 	}
 }
 
-static void switch_to_update_io_bitmap(struct tss_struct *tss,
-				       struct io_bitmap *iobm)
+static inline void tss_invalidate_io_bitmap(struct tss_struct *tss)
+{
+	/*
+	 * Invalidate the I/O bitmap by moving io_bitmap_base outside the
+	 * TSS limit so any subsequent I/O access from user space will
+	 * trigger a #GP.
+	 *
+	 * This is correct even when VMEXIT rewrites the TSS limit
+	 * to 0x67 as the only requirement is that the base points
+	 * outside the limit.
+	 */
+	tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_INVALID;
+}
+
+static inline void switch_to_bitmap(unsigned long tifp)
+{
+	/*
+	 * Invalidate I/O bitmap if the previous task used it. If the next
+	 * task has an I/O bitmap it will handle it on exit to user mode.
+	 */
+	if (tifp & _TIF_IO_BITMAP)
+		tss_invalidate_io_bitmap(this_cpu_ptr(&cpu_tss_rw));
+}
+
+static void tss_copy_io_bitmap(struct tss_struct *tss, struct io_bitmap *iobm)
 {
 	/*
 	 * Copy at least the byte range of the incoming tasks bitmap which
@@ -377,13 +400,15 @@ static void switch_to_update_io_bitmap(s
 	tss->last_bitmap = iobm;
 }
 
-static inline void switch_to_bitmap(struct thread_struct *next,
-				    unsigned long tifp, unsigned long tifn)
+/**
+ * tss_update_io_bitmap - Update I/O bitmap before exiting to usermode
+ */
+void tss_update_io_bitmap(void)
 {
 	struct tss_struct *tss = this_cpu_ptr(&cpu_tss_rw);
 
-	if (tifn & _TIF_IO_BITMAP) {
-		struct io_bitmap *iobm = next->io_bitmap;
+	if (test_thread_flag(TIF_IO_BITMAP)) {
+		struct io_bitmap *iobm = current->thread.io_bitmap;
 
 		/*
 		 * Only copy bitmap data when the bitmap or the sequence
@@ -392,7 +417,7 @@ static inline void switch_to_bitmap(stru
 		 */
 		if (tss->last_bitmap != iobm ||
 		    tss->last_sequence != iobm->sequence)
-			switch_to_update_io_bitmap(tss, iobm);
+			tss_copy_io_bitmap(tss, iobm);
 
 		/* Enable the bitmap */
 		tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_VALID;
@@ -405,18 +430,8 @@ static inline void switch_to_bitmap(stru
 		 * limit.
 		 */
 		refresh_tss_limit();
-	} else if (tifp & _TIF_IO_BITMAP) {
-		/*
-		 * Do not touch the bitmap. Let the next bitmap using task
-		 * deal with the mess. Just make the io_bitmap_base invalid
-		 * by moving it outside the TSS limit so any subsequent I/O
-		 * access from user space will trigger a #GP.
-		 *
-		 * This is correct even when VMEXIT rewrites the TSS limit
-		 * to 0x67 as the only requirement is that the base points
-		 * outside the limit.
-		 */
-		tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_INVALID;
+	} else {
+		tss_invalidate_io_bitmap(tss);
 	}
 }
 
@@ -630,7 +645,8 @@ void __switch_to_xtra(struct task_struct
 
 	tifn = READ_ONCE(task_thread_info(next_p)->flags);
 	tifp = READ_ONCE(task_thread_info(prev_p)->flags);
-	switch_to_bitmap(next, tifp, tifn);
+
+	switch_to_bitmap(tifp);
 
 	propagate_user_return_notify(prev_p, next_p);
 


