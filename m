Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F7DC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 17:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B302082E
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 17:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfK3RLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 12:11:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50282 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfK3RLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 12:11:47 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ib6HO-0003Jn-Mb; Sat, 30 Nov 2019 18:11:39 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4E1791C1E6C;
        Sat, 30 Nov 2019 18:11:34 +0100 (CET)
Date:   Sat, 30 Nov 2019 17:11:34 -0000
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/ioperm: Save an indentation level in
 tss_update_io_bitmap()
Cc:     Borislav Petkov <bp@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157513389416.21853.341175495479057538.tip-bot2@tip-bot2>
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

Commit-ID:     7b0b8cfd261c569177d64d6e9b1800fbe412fd65
Gitweb:        https://git.kernel.org/tip/7b0b8cfd261c569177d64d6e9b1800fbe412fd65
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Sat, 30 Nov 2019 16:00:53 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 30 Nov 2019 18:06:56 +01:00

x86/ioperm: Save an indentation level in tss_update_io_bitmap()

... for better readability.

No functional changes.

[ Minor edit. ]

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/process.c | 52 +++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index bd2a11c..61e93a3 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -377,37 +377,37 @@ static void tss_copy_io_bitmap(struct tss_struct *tss, struct io_bitmap *iobm)
 void tss_update_io_bitmap(void)
 {
 	struct tss_struct *tss = this_cpu_ptr(&cpu_tss_rw);
+	struct thread_struct *t = &current->thread;
 	u16 *base = &tss->x86_tss.io_bitmap_base;
 
-	if (test_thread_flag(TIF_IO_BITMAP)) {
-		struct thread_struct *t = &current->thread;
-
-		if (IS_ENABLED(CONFIG_X86_IOPL_IOPERM) && t->iopl_emul == 3) {
-			*base = IO_BITMAP_OFFSET_VALID_ALL;
-		} else {
-			struct io_bitmap *iobm = t->io_bitmap;
-			/*
-			 * Only copy bitmap data when the sequence number
-			 * differs. The update time is accounted to the
-			 * incoming task.
-			 */
-			if (tss->io_bitmap.prev_sequence != iobm->sequence)
-				tss_copy_io_bitmap(tss, iobm);
-
-			/* Enable the bitmap */
-			*base = IO_BITMAP_OFFSET_VALID_MAP;
-		}
+	if (!test_thread_flag(TIF_IO_BITMAP)) {
+		tss_invalidate_io_bitmap(tss);
+		return;
+	}
+
+	if (IS_ENABLED(CONFIG_X86_IOPL_IOPERM) && t->iopl_emul == 3) {
+		*base = IO_BITMAP_OFFSET_VALID_ALL;
+	} else {
+		struct io_bitmap *iobm = t->io_bitmap;
+
 		/*
-		 * Make sure that the TSS limit is covering the io bitmap.
-		 * It might have been cut down by a VMEXIT to 0x67 which
-		 * would cause a subsequent I/O access from user space to
-		 * trigger a #GP because tbe bitmap is outside the TSS
-		 * limit.
+		 * Only copy bitmap data when the sequence number differs. The
+		 * update time is accounted to the incoming task.
 		 */
-		refresh_tss_limit();
-	} else {
-		tss_invalidate_io_bitmap(tss);
+		if (tss->io_bitmap.prev_sequence != iobm->sequence)
+			tss_copy_io_bitmap(tss, iobm);
+
+		/* Enable the bitmap */
+		*base = IO_BITMAP_OFFSET_VALID_MAP;
 	}
+
+	/*
+	 * Make sure that the TSS limit is covering the IO bitmap. It might have
+	 * been cut down by a VMEXIT to 0x67 which would cause a subsequent I/O
+	 * access from user space to trigger a #GP because tbe bitmap is outside
+	 * the TSS limit.
+	 */
+	refresh_tss_limit();
 }
 #else /* CONFIG_X86_IOPL_IOPERM */
 static inline void switch_to_bitmap(unsigned long tifp) { }
