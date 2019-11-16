Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BE8C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 11:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2DA92068D
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 11:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfKPLw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 06:52:26 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45252 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbfKPLva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 06:51:30 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVwbu-00029U-Qg; Sat, 16 Nov 2019 12:51:26 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7CDC91C1905;
        Sat, 16 Nov 2019 12:51:23 +0100 (CET)
Date:   Sat, 16 Nov 2019 11:51:23 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/iopl] x86/tss: Move I/O bitmap data into a seperate struct
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157390508347.12247.16150961072567277571.tip-bot2@tip-bot2>
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

Commit-ID:     f5848e5fd2f813c3a8009a642dfbcf635287c199
Gitweb:        https://git.kernel.org/tip/f5848e5fd2f813c3a8009a642dfbcf635287c199
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 12 Nov 2019 18:45:29 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 16 Nov 2019 11:24:01 +01:00

x86/tss: Move I/O bitmap data into a seperate struct

Move the non hardware portion of I/O bitmap data into a seperate struct for
readability sake.

Originally-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/processor.h | 35 ++++++++++++++++++-------------
 arch/x86/kernel/cpu/common.c     |  4 ++--
 arch/x86/kernel/ioport.c         |  4 ++--
 arch/x86/kernel/process.c        |  6 ++---
 4 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 6d0059c..cd7cd7d 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -328,11 +328,11 @@ struct x86_hw_tss {
  * IO-bitmap sizes:
  */
 #define IO_BITMAP_BITS			65536
-#define IO_BITMAP_BYTES			(IO_BITMAP_BITS/8)
-#define IO_BITMAP_LONGS			(IO_BITMAP_BYTES/sizeof(long))
+#define IO_BITMAP_BYTES			(IO_BITMAP_BITS / BITS_PER_BYTE)
+#define IO_BITMAP_LONGS			(IO_BITMAP_BYTES / sizeof(long))
 
-#define IO_BITMAP_OFFSET_VALID				\
-	(offsetof(struct tss_struct, io_bitmap) -	\
+#define IO_BITMAP_OFFSET_VALID					\
+	(offsetof(struct tss_struct, io_bitmap.bitmap) -	\
 	 offsetof(struct tss_struct, x86_tss))
 
 /*
@@ -356,14 +356,10 @@ struct entry_stack_page {
 	struct entry_stack stack;
 } __aligned(PAGE_SIZE);
 
-struct tss_struct {
-	/*
-	 * The fixed hardware portion.  This must not cross a page boundary
-	 * at risk of violating the SDM's advice and potentially triggering
-	 * errata.
-	 */
-	struct x86_hw_tss	x86_tss;
-
+/*
+ * All IO bitmap related data stored in the TSS:
+ */
+struct x86_io_bitmap {
 	/*
 	 * Store the dirty size of the last io bitmap offender. The next
 	 * one will have to do the cleanup as the switch out to a non io
@@ -371,7 +367,7 @@ struct tss_struct {
 	 * outside of the TSS limit. So for sane tasks there is no need to
 	 * actually touch the io_bitmap at all.
 	 */
-	unsigned int		io_bitmap_prev_max;
+	unsigned int		prev_max;
 
 	/*
 	 * The extra 1 is there because the CPU will access an
@@ -379,7 +375,18 @@ struct tss_struct {
 	 * bitmap. The extra byte must be all 1 bits, and must
 	 * be within the limit.
 	 */
-	unsigned long		io_bitmap[IO_BITMAP_LONGS + 1];
+	unsigned long		bitmap[IO_BITMAP_LONGS + 1];
+};
+
+struct tss_struct {
+	/*
+	 * The fixed hardware portion.  This must not cross a page boundary
+	 * at risk of violating the SDM's advice and potentially triggering
+	 * errata.
+	 */
+	struct x86_hw_tss	x86_tss;
+
+	struct x86_io_bitmap	io_bitmap;
 } __aligned(PAGE_SIZE);
 
 DECLARE_PER_CPU_PAGE_ALIGNED(struct tss_struct, cpu_tss_rw);
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 8c1000a..3aee167 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1861,8 +1861,8 @@ void cpu_init(void)
 	/* Initialize the TSS. */
 	tss_setup_ist(tss);
 	tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_INVALID;
-	tss->io_bitmap_prev_max = 0;
-	memset(tss->io_bitmap, 0xff, sizeof(tss->io_bitmap));
+	tss->io_bitmap.prev_max = 0;
+	memset(tss->io_bitmap.bitmap, 0xff, sizeof(tss->io_bitmap.bitmap));
 	set_tss_desc(cpu, &get_cpu_entry_area(cpu)->tss.x86_tss);
 
 	load_TR_desc();
diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
index eed218a..80d99bb 100644
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -81,9 +81,9 @@ long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
 
 	/* Update the TSS */
 	tss = this_cpu_ptr(&cpu_tss_rw);
-	memcpy(tss->io_bitmap, t->io_bitmap_ptr, bytes_updated);
+	memcpy(tss->io_bitmap.bitmap, t->io_bitmap_ptr, bytes_updated);
 	/* Store the new end of the zero bits */
-	tss->io_bitmap_prev_max = bytes;
+	tss->io_bitmap.prev_max = bytes;
 	/* Make the bitmap base in the TSS valid */
 	tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_VALID;
 	/* Make sure the TSS limit covers the I/O bitmap. */
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 2444fe2..35f1c80 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -374,11 +374,11 @@ static inline void switch_to_bitmap(struct thread_struct *next,
 		 * bits permitted, then the copy needs to cover those as
 		 * well so they get turned off.
 		 */
-		memcpy(tss->io_bitmap, next->io_bitmap_ptr,
-		       max(tss->io_bitmap_prev_max, next->io_bitmap_max));
+		memcpy(tss->io_bitmap.bitmap, next->io_bitmap_ptr,
+		       max(tss->io_bitmap.prev_max, next->io_bitmap_max));
 
 		/* Store the new max and set io_bitmap_base valid */
-		tss->io_bitmap_prev_max = next->io_bitmap_max;
+		tss->io_bitmap.prev_max = next->io_bitmap_max;
 		tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_VALID;
 
 		/*
