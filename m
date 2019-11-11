Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3472BC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 22:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0056821872
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 22:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfKKWg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 17:36:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60033 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKKWfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 17:35:46 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iUIHg-0000uG-HL; Mon, 11 Nov 2019 23:35:44 +0100
Message-Id: <20191111223052.292300453@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 11 Nov 2019 23:03:22 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [patch V2 08/16] x86/ioperm: Add bitmap sequence number
References: <20191111220314.519933535@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a globally unique sequence number which is incremented when ioperm() is
changing the I/O bitmap of a task. Store the new sequence number in the
io_bitmap structure and compare it along with the actual struct pointer
with the one which was last loaded on a CPU. Only update the bitmap if
either of the two changes. That should further reduce the overhead of I/O
bitmap scheduling when there are only a few I/O bitmap users on the system.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 arch/x86/include/asm/iobitmap.h  |    1 
 arch/x86/include/asm/processor.h |    8 +++++++
 arch/x86/kernel/cpu/common.c     |    1 
 arch/x86/kernel/ioport.c         |    9 +++++---
 arch/x86/kernel/process.c        |   40 +++++++++++++++++++++++++++++----------
 5 files changed, 46 insertions(+), 13 deletions(-)

--- a/arch/x86/include/asm/iobitmap.h
+++ b/arch/x86/include/asm/iobitmap.h
@@ -5,6 +5,7 @@
 #include <asm/processor.h>
 
 struct io_bitmap {
+	u64			sequence;
 	unsigned int		io_bitmap_max;
 	union {
 		unsigned long	bits[IO_BITMAP_LONGS];
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -366,6 +366,14 @@ struct tss_struct {
 	struct x86_hw_tss	x86_tss;
 
 	/*
+	 * The bitmap pointer and the sequence number of the last active
+	 * bitmap. last_bitmap cannot be dereferenced. It's solely for
+	 * comparison.
+	 */
+	struct io_bitmap	*last_bitmap;
+	u64			last_sequence;
+
+	/*
 	 * Store the dirty size of the last io bitmap offender. The next
 	 * one will have to do the cleanup as the switch out to a non io
 	 * bitmap user will just set x86_tss.io_bitmap_base to a value
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1861,6 +1861,7 @@ void cpu_init(void)
 	/* Initialize the TSS. */
 	tss_setup_ist(tss);
 	tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_INVALID;
+	tss->last_bitmap = NULL;
 	tss->io_bitmap_prev_max = 0;
 	memset(tss->io_bitmap_bytes, 0xff, sizeof(tss->io_bitmap_bytes));
 	set_tss_desc(cpu, &get_cpu_entry_area(cpu)->tss.x86_tss);
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -14,6 +14,8 @@
 #include <asm/iobitmap.h>
 #include <asm/desc.h>
 
+static atomic64_t io_bitmap_sequence;
+
 /*
  * this changes the io permissions bitmap in the current task.
  */
@@ -76,14 +78,15 @@ long ksys_ioperm(unsigned long from, uns
 
 	iobm->io_bitmap_max = bytes;
 
-	/* Update the TSS: */
-	memcpy(tss->io_bitmap_bytes, iobm->bitmap_bytes, bytes_updated);
-
+	/* Update the sequence number to force an update in switch_to() */
+	iobm->sequence = atomic64_add_return(1, &io_bitmap_sequence);
 	/* Set the tasks io_bitmap pointer (might be the same) */
 	t->io_bitmap = iobm;
 	/* Mark it active for context switching */
 	set_thread_flag(TIF_IO_BITMAP);
 
+	/* Update the TSS: */
+	memcpy(tss->io_bitmap_bytes, iobm->bitmap_bytes, bytes_updated);
 	/* Make the bitmap base in the TSS valid */
 	tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_VALID;
 
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -354,6 +354,29 @@ void arch_setup_new_exec(void)
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
+	memcpy(tss->io_bitmap_bytes, iobm->bitmap_bytes,
+	       max(tss->io_bitmap_prev_max, iobm->io_bitmap_max));
+
+	/*
+	 * Store the new max and the sequence number of this bitmap
+	 * and a pointer to the bitmap itself.
+	 */
+	tss->io_bitmap_prev_max = iobm->io_bitmap_max;
+	tss->last_sequence = iobm->sequence;
+	tss->last_bitmap = iobm;
+}
+
 static inline void switch_to_bitmap(struct thread_struct *next,
 				    unsigned long tifp, unsigned long tifn)
 {
@@ -363,18 +386,15 @@ static inline void switch_to_bitmap(stru
 		struct io_bitmap *iobm = next->io_bitmap;
 
 		/*
-		 * Copy at least the size of the incoming tasks bitmap
-		 * which covers the last permitted I/O port.
-		 *
-		 * If the previous task which used an io bitmap had more
-		 * bits permitted, then the copy needs to cover those as
-		 * well so they get turned off.
+		 * Only copy bitmap data when the bitmap or the sequence
+		 * number differs. The update time is accounted to the
+		 * incoming task.
 		 */
-		memcpy(tss->io_bitmap_bytes, iobm->bitmap_bytes,
-		       max(tss->io_bitmap_prev_max, iobm->io_bitmap_max));
+		if (tss->last_bitmap != iobm ||
+		    tss->last_sequence != iobm->sequence)
+			switch_to_update_io_bitmap(tss, iobm);
 
-		/* Store the new max and set io_bitmap_base valid */
-		tss->io_bitmap_prev_max = iobm->io_bitmap_max;
+		/* Enable the bitmap */
 		tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_VALID;
 
 		/*


