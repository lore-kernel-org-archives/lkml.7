Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11222C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6AD6206ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbfKMVDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:03:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38864 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfKMVCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:02:19 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iUzmL-00066b-AT; Wed, 13 Nov 2019 22:02:17 +0100
Message-Id: <20191113210104.295618595@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 13 Nov 2019 21:42:46 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [patch V3 06/20] x86/ioperm: Simplify first ioperm() invocation logic
References: <20191113204240.767922595@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the first allocation of a task the I/O bitmap needs to be
allocated. After the allocation it is installed as an empty bitmap and
immediately afterwards updated.

Avoid that and just do the initial updates (store bitmap pointer, set TIF
flag and make TSS limit valid) in the update path unconditionally. If the
bitmap was already active this is redundant but harmless.

Preparatory change for later optimizations in the context switch code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: Split out from a later patch for simpler review and to make the first
    context switch optimization correct.
---
 arch/x86/kernel/ioport.c |   57 +++++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 29 deletions(-)

--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -18,9 +18,10 @@
  */
 long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
 {
+	unsigned int i, max_long, bytes, bytes_updated;
 	struct thread_struct *t = &current->thread;
 	struct tss_struct *tss;
-	unsigned int i, max_long, bytes, bytes_updated;
+	unsigned long *bitmap;
 
 	if ((from + num <= from) || (from + num > IO_BITMAP_BITS))
 		return -EINVAL;
@@ -33,59 +34,57 @@ long ksys_ioperm(unsigned long from, uns
 	 * IO bitmap up. ioperm() is much less timing critical than clone(),
 	 * this is why we delay this operation until now:
 	 */
-	if (!t->io_bitmap_ptr) {
-		unsigned long *bitmap = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
-
+	bitmap = t->io_bitmap_ptr;
+	if (!bitmap) {
+		bitmap = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
 		if (!bitmap)
 			return -ENOMEM;
 
 		memset(bitmap, 0xff, IO_BITMAP_BYTES);
-		t->io_bitmap_ptr = bitmap;
-		set_thread_flag(TIF_IO_BITMAP);
-
-		/*
-		 * Now that we have an IO bitmap, we need our TSS limit to be
-		 * correct.  It's fine if we are preempted after doing this:
-		 * with TIF_IO_BITMAP set, context switches will keep our TSS
-		 * limit correct.
-		 */
-		preempt_disable();
-		refresh_tss_limit();
-		preempt_enable();
 	}
 
 	/*
-	 * do it in the per-thread copy and in the TSS ...
-	 *
-	 * Disable preemption via get_cpu() - we must not switch away
-	 * because the ->io_bitmap_max value must match the bitmap
-	 * contents:
+	 * Update the bitmap and the TSS copy with preemption disabled to
+	 * prevent a race against context switch.
 	 */
-	tss = &per_cpu(cpu_tss_rw, get_cpu());
-
+	preempt_disable();
 	if (turn_on)
-		bitmap_clear(t->io_bitmap_ptr, from, num);
+		bitmap_clear(bitmap, from, num);
 	else
-		bitmap_set(t->io_bitmap_ptr, from, num);
+		bitmap_set(bitmap, from, num);
 
 	/*
 	 * Search for a (possibly new) maximum. This is simple and stupid,
 	 * to keep it obviously correct:
 	 */
 	max_long = 0;
-	for (i = 0; i < IO_BITMAP_LONGS; i++)
-		if (t->io_bitmap_ptr[i] != ~0UL)
+	for (i = 0; i < IO_BITMAP_LONGS; i++) {
+		if (bitmap[i] != ~0UL)
 			max_long = i;
+	}
 
 	bytes = (max_long + 1) * sizeof(unsigned long);
 	bytes_updated = max(bytes, t->io_bitmap_max);
 
+	/* Update the thread data */
 	t->io_bitmap_max = bytes;
+	/*
+	 * Store the bitmap pointer (might be the same if the task already
+	 * head one). Set the TIF flag, just in case this is the first
+	 * invocation.
+	 */
+	t->io_bitmap_ptr = bitmap;
+	set_thread_flag(TIF_IO_BITMAP);
 
-	/* Update the TSS: */
+	/* Update the TSS */
+	tss = this_cpu_ptr(&cpu_tss_rw);
 	memcpy(tss->io_bitmap, t->io_bitmap_ptr, bytes_updated);
+	/* Store the new end of the zero bits */
+	tss->io_bitmap_prev_max = bytes;
+	/* Make sure the TSS limit covers the I/O bitmap. */
+	refresh_tss_limit();
 
-	put_cpu();
+	preempt_enable();
 
 	return 0;
 }


