Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD8BC5DF64
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 20:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52CBD21A49
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 20:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732553AbfKFU4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 15:56:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45266 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732141AbfKFU4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 15:56:48 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iSSM9-00032o-4K; Wed, 06 Nov 2019 21:56:45 +0100
Message-Id: <20191106202806.241007755@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 06 Nov 2019 20:35:04 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [patch 5/9] x86/ioport: Reduce ioperm impact for sane usage further
References: <20191106193459.581614484@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sane ioperm() users only set the few bits in the I/O space which they need to
access. But the update logic of the TSS I/O bitmap copies always from byte
0 to the last byte in the tasks bitmap which contains a zero permission bit.

That means that for access only to port 65335 the full 8K bitmap has to be
copied even if all the bytes in the TSS I/O bitmap are already filled with
0xff.

Calculate both the position of the first zero bit and the last zero bit to
limit the range which needs to be copied. This does not solve the problem
when the previous tasked had only byte 0 cleared and the next one has only
byte 65535 cleared, but trying to solve that would be too complex and
heavyweight for the context switch path. As the ioperm() usage is very rare
the case which is optimized is the single task/process which uses ioperm().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/processor.h |   28 ++++---
 arch/x86/kernel/cpu/common.c     |    3 
 arch/x86/kernel/ioport.c         |  141 +++++++++++++++++++++++++++------------
 arch/x86/kernel/process.c        |   51 +++++++++-----
 arch/x86/kernel/ptrace.c         |    2 
 5 files changed, 152 insertions(+), 73 deletions(-)

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -365,19 +365,19 @@ struct tss_struct {
 	struct x86_hw_tss	x86_tss;
 
 	/*
-	 * Store the dirty size of the last io bitmap offender. The next
-	 * one will have to do the cleanup as the switch out to a non
-	 * io bitmap user will just set x86_tss.io_bitmap_base to a value
-	 * outside of the TSS limit. So for sane tasks there is no need
-	 * to actually touch the io_bitmap at all.
+	 * Store the dirty byte range of the last io bitmap offender. The
+	 * next one will have to do the cleanup because the switch out to a
+	 * non I/O bitmap user will just set x86_tss.io_bitmap_base to a
+	 * value outside of the TSS limit to not penalize tasks which do
+	 * not use the I/O bitmap at all.
 	 */
-	unsigned int		io_bitmap_prev_max;
+	unsigned int		io_zerobits_start;
+	unsigned int		io_zerobits_end;
 
 	/*
-	 * The extra 1 is there because the CPU will access an
-	 * additional byte beyond the end of the IO permission
-	 * bitmap. The extra byte must be all 1 bits, and must
-	 * be within the limit.
+	 * The extra 1 is there because the CPU will access an additional
+	 * byte beyond the end of the I/O permission bitmap. The extra byte
+	 * must have all bits set and must be within the TSS limit.
 	 */
 	unsigned long		io_bitmap[IO_BITMAP_LONGS + 1];
 } __aligned(PAGE_SIZE);
@@ -496,8 +496,12 @@ struct thread_struct {
 	/* IO permissions: */
 	unsigned long		*io_bitmap_ptr;
 	unsigned long		iopl;
-	/* Max allowed port in the bitmap, in bytes: */
-	unsigned		io_bitmap_max;
+	/*
+	 * The byte range in the I/O permission bitmap which contains zero
+	 * bits.
+	 */
+	unsigned int		io_zerobits_start;
+	unsigned int		io_zerobits_end;
 
 	mm_segment_t		addr_limit;
 
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1864,7 +1864,8 @@ void cpu_init(void)
 	/* Initialize the TSS. */
 	tss_setup_ist(tss);
 	tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_INVALID;
-	tss->io_bitmap_prev_max = 0;
+	tss->io_zerobits_start = IO_BITMAP_BYTES;
+	tss->io_zerobits_end = 0;
 	memset(tss->io_bitmap, 0xff, sizeof(tss->io_bitmap));
 	set_tss_desc(cpu, &get_cpu_entry_area(cpu)->tss.x86_tss);
 
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -26,9 +26,11 @@
  */
 long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
 {
+	unsigned int first, last, next, start, end, copy_start, copy_len;
 	struct thread_struct *t = &current->thread;
+	unsigned long *bitmap, *tofree = NULL;
 	struct tss_struct *tss;
-	unsigned int i, max_long, bytes, bytes_updated;
+	char *src, *dst;
 
 	if ((from + num <= from) || (from + num > IO_BITMAP_BITS))
 		return -EINVAL;
@@ -37,63 +39,120 @@ long ksys_ioperm(unsigned long from, uns
 		return -EPERM;
 
 	/*
-	 * If it's the first ioperm() call in this thread's lifetime, set the
-	 * IO bitmap up. ioperm() is much less timing critical than clone(),
-	 * this is why we delay this operation until now:
+	 * I/O bitmap storage is allocated on demand, but don't bother if
+	 * the task does not have one and permissions are only cleared.
 	 */
-	if (!t->io_bitmap_ptr) {
-		unsigned long *bitmap = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
+	if (!t->io_bitmap_ptr && !turn_on)
+		return 0;
 
-		if (!bitmap)
-			return -ENOMEM;
+	/*
+	 * Allocate a temporary bitmap to minimize the amount of work
+	 * in the atomic region.
+	 */
+	bitmap = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
+	if (!bitmap)
+		return -ENOMEM;
 
+	if (!t->io_bitmap_ptr)
 		memset(bitmap, 0xff, IO_BITMAP_BYTES);
-		t->io_bitmap_ptr = bitmap;
-		set_thread_flag(TIF_IO_BITMAP);
+	else
+		memcpy(bitmap, t->io_bitmap_ptr, IO_BITMAP_BYTES);
+
+	/* Update the bitmap */
+	if (turn_on) {
+		bitmap_clear(bitmap, from, num);
+	} else {
+		bitmap_set(bitmap, from, num);
+	}
+
+	/* Get the new range */
+	first = find_first_zero_bit(bitmap, IO_BITMAP_BITS);
+
+	for (last = next = first; next < IO_BITMAP_BITS; last = next) {
+		/* Find the next set bit and update last */
+		next = find_next_bit(bitmap, IO_BITMAP_BITS, last);
+		last = next - 1;
+		if (next == IO_BITMAP_BITS)
+			break;
+		/* Find the next zero bit and continue searching */
+		next = find_next_zero_bit(bitmap, IO_BITMAP_BITS, next);
+	}
+
+	/* Calculate the byte boundaries for the updated region */
+	copy_start = from / 8;
+	copy_len = (round_up(from + num, 8) / 8) - copy_start;
+
+	/*
+	 * Update the per thread storage and the TSS bitmap. This must be
+	 * done with preemption disabled to prevent racing against a
+	 * context switch.
+	 */
+	preempt_disable();
+	tss = this_cpu_ptr(&cpu_tss_rw);
 
+	if (!t->io_bitmap_ptr) {
+		unsigned int tss_start = tss->io_zerobits_start;
+		/*
+		 * If the task did not use the I/O bitmap yet then the
+		 * perhaps stale content in the TSS needs to be taken into
+		 * account. If tss start is out of bounds the TSS storage
+		 * does not contain a zero bit and it's sufficient just to
+		 * copy the new range over.
+		 */
+		if (tss_start < IO_BITMAP_BYTES) {
+			unsigned int tss_end =  tss->io_zerobits_end;
+			unsigned int copy_end = copy_start + copy_len;
+
+			copy_start = min(tss_start, copy_start);
+			copy_len = max(tss_end, copy_end) - copy_start;
+		}
+	}
+
+	/* Copy the changed range over to the TSS bitmap */
+	dst = (char *)tss->io_bitmap;
+	src = (char *)bitmap;
+	memcpy(dst + copy_start, src + copy_start, copy_len);
+
+	if (first >= IO_BITMAP_BITS) {
+		/*
+		 * If the resulting bitmap has all permissions dropped, clear
+		 * TIF_IO_BITMAP and set the IO bitmap offset in the TSS to
+		 * invalid. Deallocate both the new and the thread's bitmap.
+		 */
+		clear_thread_flag(TIF_IO_BITMAP);
+		tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_INVALID;
+		tofree = bitmap;
+		bitmap = NULL;
+	} else {
 		/*
-		 * Now that we have an IO bitmap, we need our TSS limit to be
-		 * correct.  It's fine if we are preempted after doing this:
-		 * with TIF_IO_BITMAP set, context switches will keep our TSS
-		 * limit correct.
+		 * I/O bitmap contains zero bits. Set TIF_IO_BITMAP, make
+		 * the bitmap offset valid and make sure that the TSS limit
+		 * is correct. It might have been wreckaged by a VMEXiT.
 		 */
-		preempt_disable();
+		set_thread_flag(TIF_IO_BITMAP);
+		tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_VALID;
 		refresh_tss_limit();
-		preempt_enable();
 	}
 
 	/*
-	 * do it in the per-thread copy and in the TSS ...
+	 * Update the range in the thread and the TSS
 	 *
-	 * Disable preemption via get_cpu() - we must not switch away
-	 * because the ->io_bitmap_max value must match the bitmap
-	 * contents:
+	 * Get the byte position of the first zero bit and calculate
+	 * the length of the range in which zero bits exist.
 	 */
-	tss = &per_cpu(cpu_tss_rw, get_cpu());
-
-	if (turn_on)
-		bitmap_clear(t->io_bitmap_ptr, from, num);
-	else
-		bitmap_set(t->io_bitmap_ptr, from, num);
+	start = first / 8;
+	end = first < IO_BITMAP_BITS ? round_up(last, 8) / 8 : 0;
+	t->io_zerobits_start = tss->io_zerobits_start = start;
+	t->io_zerobits_end = tss->io_zerobits_end = end;
 
 	/*
-	 * Search for a (possibly new) maximum. This is simple and stupid,
-	 * to keep it obviously correct:
+	 * Finally exchange the bitmap pointer in the thread.
 	 */
-	max_long = 0;
-	for (i = 0; i < IO_BITMAP_LONGS; i++)
-		if (t->io_bitmap_ptr[i] != ~0UL)
-			max_long = i;
-
-	bytes = (max_long + 1) * sizeof(unsigned long);
-	bytes_updated = max(bytes, t->io_bitmap_max);
-
-	t->io_bitmap_max = bytes;
-
-	/* Update the TSS: */
-	memcpy(tss->io_bitmap, t->io_bitmap_ptr, bytes_updated);
+	bitmap = xchg(&t->io_bitmap_ptr, bitmap);
+	preempt_enable();
 
-	put_cpu();
+	kfree(bitmap);
+	kfree(tofree);
 
 	return 0;
 }
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -110,7 +110,8 @@ void exit_thread(struct task_struct *tsk
 		tss = this_cpu_ptr(&cpu_tss_rw);
 
 		t->io_bitmap_ptr = NULL;
-		t->io_bitmap_max = 0;
+		t->io_zerobits_start = IO_BITMAP_BYTES;
+		t->io_zerobits_end = 0;
 		clear_thread_flag(TIF_IO_BITMAP);
 		/* Invalidate the io bitmap base in the TSS */
 		tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_INVALID;
@@ -141,7 +142,8 @@ static inline int copy_io_bitmap(struct
 	tsk->thread.io_bitmap_ptr = kmemdup(current->thread.io_bitmap_ptr,
 					    IO_BITMAP_BYTES, GFP_KERNEL);
 	if (!tsk->thread.io_bitmap_ptr) {
-		tsk->thread.io_bitmap_max = 0;
+		tsk->thread.io_zerobits_start = IO_BITMAP_BYTES;
+		tsk->thread.io_zerobits_end = 0;
 		return -ENOMEM;
 	}
 	set_tsk_thread_flag(tsk, TIF_IO_BITMAP);
@@ -153,7 +155,8 @@ static inline void free_io_bitmap(struct
 	if (tsk->thread.io_bitmap_ptr) {
 		kfree(tsk->thread.io_bitmap_ptr);
 		tsk->thread.io_bitmap_ptr = NULL;
-		tsk->thread.io_bitmap_max = 0;
+		tsk->thread.io_zerobits_start = IO_BITMAP_BYTES;
+		tsk->thread.io_zerobits_end = 0;
 	}
 }
 
@@ -354,27 +357,39 @@ void arch_setup_new_exec(void)
 	}
 }
 
+static void tss_update_io_bitmap(struct tss_struct *tss,
+				 struct thread_struct *thread)
+{
+	unsigned int start, len;
+	char *src, *dst;
+
+	/*
+	 * Copy at least the byte range of the incoming tasks bitmap which
+	 * covers the permitted I/O ports.
+	 *
+	 * If the previous task which used an I/O bitmap had more bits
+	 * permitted, then the copy needs to cover those as well so they
+	 * get turned off.
+	 */
+	start = min(tss->io_zerobits_start, thread->io_zerobits_start);
+	len = max(tss->io_zerobits_end, thread->io_zerobits_end) - start;
+	src = (char *)thread->io_bitmap_ptr;
+	dst = (char *)tss->io_bitmap_map;
+	memcpy(dst + start, dst + start, len);
+
+	/* Store the new start/end and set io_bitmap_base valid */
+	tss->io_zerobits_start = thread->io_zerobits_start;
+	tss->io_zerobits_end = thread->io_zerobits_end;
+	tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_VALID_MAP;
+}
+
 static inline void switch_to_bitmap(struct thread_struct *next,
 				    unsigned long tifp, unsigned long tifn)
 {
 	struct tss_struct *tss = this_cpu_ptr(&cpu_tss_rw);
 
 	if (tifn & _TIF_IO_BITMAP) {
-		/*
-		 * Copy at least the size of the incoming tasks bitmap
-		 * which covers the last permitted I/O port.
-		 *
-		 * If the previous task which used an io bitmap had more
-		 * bits permitted, then the copy needs to cover those as
-		 * well so they get turned off.
-		 */
-		memcpy(tss->io_bitmap, next->io_bitmap_ptr,
-		       max(tss->io_bitmap_prev_max, next->io_bitmap_max));
-
-		/* Store the new max and set io_bitmap_base valid */
-		tss->io_bitmap_prev_max = next->io_bitmap_max;
-		tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_VALID;
-
+		tss_update_io_bitmap(tss, next);
 		/*
 		 * Make sure that the TSS limit is covering the io bitmap.
 		 * It might have been cut down by a VMEXIT to 0x67 which
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -697,7 +697,7 @@ static int ptrace_set_debugreg(struct ta
 static int ioperm_active(struct task_struct *target,
 			 const struct user_regset *regset)
 {
-	return DIV_ROUND_UP(target->thread.io_bitmap_max, regset->size);
+	return DIV_ROUND_UP(target->thread.io_zerobits_end, regset->size);
 }
 
 static int ioperm_get(struct task_struct *target,


