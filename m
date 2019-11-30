Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07763C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 16:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B8520732
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 16:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Rzw0u3V5";
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="MacqzdGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfK3QFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 11:05:35 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47388 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfK3QFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 11:05:35 -0500
Received: from zn.tnic (p200300EC2F231600329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f23:1600:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 394531EC05B5
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 17:05:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1575129934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:resent-to:
         resent-from:resent-message-id:in-reply-to:references;
        bh=58JOWUyVHJnA750X125x9DMXmM9l/Ae0mVfsBCNM2Xo=;
        b=Rzw0u3V5j55zDitkuDBepOfCXOtIBjFSA0rkP2zq+g6CEoXCvVsIF0rkcvjEWgoJLChIou
        8mGkZX2ESSWc0pOaM6nl9JADyMUonMtLbmLHbB1P3BJg1hOpUXvxyf2DVKe2vFaFNnzSb5
        hzgb+JFohg0zNTlcBbzZASWPV5D5xeQ=
Received: from deliver ([unix socket])
         by localhost (Cyrus v2.4.17-caldav-beta9-Debian-2.4.17+caldav~beta9-3) with LMTPA;
         Sat, 30 Nov 2019 16:01:05 +0100
X-Sieve: CMU Sieve 2.4
Received: from zn.tnic (p200300EC2F231600329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f23:1600:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 43E371EC0235;
        Sat, 30 Nov 2019 16:01:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1575126065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=58JOWUyVHJnA750X125x9DMXmM9l/Ae0mVfsBCNM2Xo=;
        b=MacqzdGO93UUlILvsXlgX7qKtg52ubpJKTrUjXIiwi7AIOjC8ePaZc3fqDcoYcBEny+GQe
        MBBtWegKkIK9x6aUA7n3eMhhOlqx/72VznMez55U7QTMstxATbYHDRtLsRfyNAQ/E1xOLQ
        fx6IY+/mpZYqF1T+3hBmz2PTpM+pm3E=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] x86/ioperm: Save an indentation level in tss_update_io_bitmap()
Date:   Sat, 30 Nov 2019 16:00:53 +0100
Message-Id: <20191130150053.23014-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

... for better readability.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
---
 arch/x86/kernel/process.c | 52 +++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index bd2a11ca5dd6..17ef878fd5dd 100644
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
+	 * Make sure that the TSS limit is covering the io bitmap. It might have
+	 * been cut down by a VMEXIT to 0x67 which would cause a subsequent I/O
+	 * access from user space to trigger a #GP because tbe bitmap is outside
+	 * the TSS limit.
+	 */
+	refresh_tss_limit();
 }
 #else /* CONFIG_X86_IOPL_IOPERM */
 static inline void switch_to_bitmap(unsigned long tifp) { }
-- 
2.21.0

