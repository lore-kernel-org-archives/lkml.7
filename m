Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60787C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 21:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3999E20729
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 21:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfKOVNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 16:13:06 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44641 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbfKOVMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 16:12:44 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVitT-0007RX-KY; Fri, 15 Nov 2019 22:12:39 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3DC2E1C18CE;
        Fri, 15 Nov 2019 22:12:30 +0100 (CET)
Date:   Fri, 15 Nov 2019 21:12:30 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/iopl] x86/ioperm: Simplify first ioperm() invocation logic
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191113210104.295618595@linutronix.de>
References: <20191113210104.295618595@linutronix.de>
MIME-Version: 1.0
Message-ID: <157385235022.12247.13427059796080402232.tip-bot2@tip-bot2>
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

Commit-ID:     3817927e6f5686a5c7571ae33f7b1a8483821c5b
Gitweb:        https://git.kernel.org/tip/3817927e6f5686a5c7571ae33f7b1a8483821c5b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 13 Nov 2019 21:42:46 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 14 Nov 2019 20:15:01 +01:00

x86/ioperm: Simplify first ioperm() invocation logic

On the first allocation of a task the I/O bitmap needs to be
allocated. After the allocation it is installed as an empty bitmap and
immediately afterwards updated.

Avoid that and just do the initial updates (store bitmap pointer, set TIF
flag and make TSS limit valid) in the update path unconditionally. If the
bitmap was already active this is redundant but harmless.

Preparatory change for later optimizations in the context switch code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20191113210104.295618595@linutronix.de

---
 arch/x86/kernel/ioport.c | 55 ++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
index 76fc2ef..ca6aa1e 100644
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
@@ -33,59 +34,55 @@ long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
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
+	/* Make sure the TSS limit covers the I/O bitmap. */
+	refresh_tss_limit();
 
-	put_cpu();
+	preempt_enable();
 
 	return 0;
 }
