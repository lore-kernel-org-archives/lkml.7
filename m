Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD1BC43215
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 11:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819FD206A4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 11:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfKPLvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 06:51:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45274 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727615AbfKPLvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 06:51:33 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVwbw-00028N-Td; Sat, 16 Nov 2019 12:51:29 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4593A1C1906;
        Sat, 16 Nov 2019 12:51:23 +0100 (CET)
Date:   Sat, 16 Nov 2019 11:51:23 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/iopl] x86/ioperm: Add bitmap sequence number
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157390508324.12247.190386660621612786.tip-bot2@tip-bot2>
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

Commit-ID:     060aa16fdb7c5078a4159a76e5dc87d6a493af9b
Gitweb:        https://git.kernel.org/tip/060aa16fdb7c5078a4159a76e5dc87d6a493af9b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 11 Nov 2019 23:03:22 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 16 Nov 2019 11:24:02 +01:00

x86/ioperm: Add bitmap sequence number

Add a globally unique sequence number which is incremented when ioperm() is
changing the I/O bitmap of a task. Store the new sequence number in the
io_bitmap structure and compare it with the sequence number of the I/O
bitmap which was last loaded on a CPU. Only update the bitmap if the
sequence is different.

That should further reduce the overhead of I/O bitmap scheduling when there
are only a few I/O bitmap users on the system.

The 64bit sequence counter is sufficient. A wraparound of the sequence
counter assuming an ioperm() call every nanosecond would require about 584
years of uptime.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/include/asm/io_bitmap.h |  1 +-
 arch/x86/include/asm/processor.h |  3 ++-
 arch/x86/kernel/cpu/common.c     |  1 +-
 arch/x86/kernel/ioport.c         |  5 ++++-
 arch/x86/kernel/process.c        | 38 ++++++++++++++++++++++---------
 5 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/io_bitmap.h b/arch/x86/include/asm/io_bitmap.h
index 1a12b9f..d63bd5a 100644
--- a/arch/x86/include/asm/io_bitmap.h
+++ b/arch/x86/include/asm/io_bitmap.h
@@ -5,6 +5,7 @@
 #include <asm/processor.h>
 
 struct io_bitmap {
+	u64		sequence;
 	/* The maximum number of bytes to copy so all zero bits are covered */
 	unsigned int	max;
 	unsigned long	bitmap[IO_BITMAP_LONGS];
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index c949e0e..40bb0f7 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -361,6 +361,9 @@ struct entry_stack_page {
  * All IO bitmap related data stored in the TSS:
  */
 struct x86_io_bitmap {
+	/* The sequence number of the last active bitmap. */
+	u64			prev_sequence;
+
 	/*
 	 * Store the dirty size of the last io bitmap offender. The next
 	 * one will have to do the cleanup as the switch out to a non io
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 3aee167..79dd544 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1862,6 +1862,7 @@ void cpu_init(void)
 	tss_setup_ist(tss);
 	tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_INVALID;
 	tss->io_bitmap.prev_max = 0;
+	tss->io_bitmap.prev_sequence = 0;
 	memset(tss->io_bitmap.bitmap, 0xff, sizeof(tss->io_bitmap.bitmap));
 	set_tss_desc(cpu, &get_cpu_entry_area(cpu)->tss.x86_tss);
 
diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
index 05f77f3..7c1ab5c 100644
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -14,6 +14,8 @@
 #include <asm/io_bitmap.h>
 #include <asm/desc.h>
 
+static atomic64_t io_bitmap_sequence;
+
 /*
  * this changes the io permissions bitmap in the current task.
  */
@@ -72,6 +74,9 @@ long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
 
 	/* Update the thread data */
 	iobm->max = bytes;
+	/* Update the sequence number to force an update in switch_to() */
+	iobm->sequence = atomic64_add_return(1, &io_bitmap_sequence);
+
 	/*
 	 * Store the bitmap pointer (might be the same if the task already
 	 * head one). Set the TIF flag, just in case this is the first
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 1504fd2..7c49be9 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -360,6 +360,28 @@ void arch_setup_new_exec(void)
 	}
 }
 
+static void switch_to_update_io_bitmap(struct tss_struct *tss,
+				       struct io_bitmap *iobm)
+{
+	/*
+	 * Copy at least the byte range of the incoming tasks bitmap which
+	 * covers the permitted I/O ports.
+	 *
+	 * If the previous task which used an I/O bitmap had more bits
+	 * permitted, then the copy needs to cover those as well so they
+	 * get turned off.
+	 */
+	memcpy(tss->io_bitmap.bitmap, iobm->bitmap,
+	       max(tss->io_bitmap.prev_max, iobm->max));
+
+	/*
+	 * Store the new max and the sequence number of this bitmap
+	 * and a pointer to the bitmap itself.
+	 */
+	tss->io_bitmap.prev_max = iobm->max;
+	tss->io_bitmap.prev_sequence = iobm->sequence;
+}
+
 static inline void switch_to_bitmap(struct thread_struct *next,
 				    unsigned long tifp, unsigned long tifn)
 {
@@ -369,18 +391,14 @@ static inline void switch_to_bitmap(struct thread_struct *next,
 		struct io_bitmap *iobm = next->io_bitmap;
 
 		/*
-		 * Copy at least the size of the incoming tasks bitmap
-		 * which covers the last permitted I/O port.
-		 *
-		 * If the previous task which used an io bitmap had more
-		 * bits permitted, then the copy needs to cover those as
-		 * well so they get turned off.
+		 * Only copy bitmap data when the sequence number
+		 * differs. The update time is accounted to the incoming
+		 * task.
 		 */
-		memcpy(tss->io_bitmap.bitmap, next->io_bitmap->bitmap,
-		       max(tss->io_bitmap.prev_max, next->io_bitmap->max));
+		if (tss->io_bitmap.prev_sequence != iobm->sequence)
+			switch_to_update_io_bitmap(tss, iobm);
 
-		/* Store the new max and set io_bitmap_base valid */
-		tss->io_bitmap.prev_max = next->io_bitmap->max;
+		/* Enable the bitmap */
 		tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_VALID;
 
 		/*
