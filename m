Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F37C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11030206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfKMVDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:03:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38912 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbfKMVCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:02:22 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iUzmO-00067Z-Pi; Wed, 13 Nov 2019 22:02:20 +0100
Message-Id: <20191113210104.790774205@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 13 Nov 2019 21:42:51 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [patch V3 11/20] x86/ioperm: Add bitmap sequence number
References: <20191113204240.767922595@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

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
V3: Remove the pointer comparison (Peter, Andy)

V2: New patch
---
 arch/x86/include/asm/io_bitmap.h |    1 +
 arch/x86/include/asm/processor.h |    3 +++
 arch/x86/kernel/cpu/common.c     |    1 +
 arch/x86/kernel/ioport.c         |    5 +++++
 arch/x86/kernel/process.c        |   38 ++++++++++++++++++++++++++++----------
 5 files changed, 38 insertions(+), 10 deletions(-)

--- a/arch/x86/include/asm/io_bitmap.h
+++ b/arch/x86/include/asm/io_bitmap.h
@@ -5,6 +5,7 @@
 #include <asm/processor.h>
 
 struct io_bitmap {
+	u64		sequence;
 	/* The maximum number of bytes to copy so all zero bits are covered */
 	unsigned int	max;
 	unsigned long	bitmap[IO_BITMAP_LONGS];
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
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1862,6 +1862,7 @@ void cpu_init(void)
 	tss_setup_ist(tss);
 	tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_INVALID;
 	tss->io_bitmap.prev_max = 0;
+	tss->io_bitmap.prev_sequence = 0;
 	memset(tss->io_bitmap.bitmap, 0xff, sizeof(tss->io_bitmap.bitmap));
 	set_tss_desc(cpu, &get_cpu_entry_area(cpu)->tss.x86_tss);
 
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
@@ -72,6 +74,9 @@ long ksys_ioperm(unsigned long from, uns
 
 	/* Update the thread data */
 	iobm->max = bytes;
+	/* Update the sequence number to force an update in switch_to() */
+	iobm->sequence = atomic64_add_return(1, &io_bitmap_sequence);
+
 	/*
 	 * Store the bitmap pointer (might be the same if the task already
 	 * head one). Set the TIF flag, just in case this is the first
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -354,6 +354,28 @@ void arch_setup_new_exec(void)
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
@@ -363,18 +385,14 @@ static inline void switch_to_bitmap(stru
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


