Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C73C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3694206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfKMVCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:02:22 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38891 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbfKMVCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:02:21 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iUzmN-000671-90; Wed, 13 Nov 2019 22:02:19 +0100
Message-Id: <20191113210104.591976506@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 13 Nov 2019 21:42:49 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [patch V3 09/20] x86/tss: Move I/O bitmap data into a seperate struct
References: <20191113204240.767922595@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the non hardware portion of I/O bitmap data into a seperate struct for
readability sake.

Originally-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: New patch
---
 arch/x86/include/asm/processor.h |   35 +++++++++++++++++++++--------------
 arch/x86/kernel/cpu/common.c     |    4 ++--
 arch/x86/kernel/ioport.c         |    4 ++--
 arch/x86/kernel/process.c        |    6 +++---
 4 files changed, 28 insertions(+), 21 deletions(-)

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
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -81,9 +81,9 @@ long ksys_ioperm(unsigned long from, uns
 
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
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -368,11 +368,11 @@ static inline void switch_to_bitmap(stru
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


