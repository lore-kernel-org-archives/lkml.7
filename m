Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F912C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B58206F3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfKMVDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:03:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38936 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfKMVCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:02:23 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iUzmQ-000682-5A; Wed, 13 Nov 2019 22:02:22 +0100
Message-Id: <20191113210104.988865829@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 13 Nov 2019 21:42:53 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [patch V3 13/20] x86/ioperm: Remove bitmap if all permissions dropped
References: <20191113204240.767922595@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

If ioperm() results in a bitmap with all bits set (no permissions to any
I/O port), then handling that bitmap on context switch and exit to user
mode is pointless. Drop it.

Move the bitmap exit handling to the ioport code and reuse it for both the
thread exit path and dropping it. This allows to reuse this code for the
upcoming iopl() emulation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
---
V3: Reduced the preempt disable scope (Ingo)

V2: New patch
---
 arch/x86/include/asm/io_bitmap.h |    2 ++
 arch/x86/kernel/ioport.c         |   19 ++++++++++++++++++-
 arch/x86/kernel/process.c        |   15 ++-------------
 3 files changed, 22 insertions(+), 14 deletions(-)

--- a/arch/x86/include/asm/io_bitmap.h
+++ b/arch/x86/include/asm/io_bitmap.h
@@ -11,6 +11,8 @@ struct io_bitmap {
 	unsigned long	bitmap[IO_BITMAP_LONGS];
 };
 
+void io_bitmap_exit(void);
+
 void tss_update_io_bitmap(void);
 
 #endif
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -16,6 +16,18 @@
 
 static atomic64_t io_bitmap_sequence;
 
+void io_bitmap_exit(void)
+{
+	struct io_bitmap *iobm = current->thread.io_bitmap;
+
+	current->thread.io_bitmap = NULL;
+	clear_thread_flag(TIF_IO_BITMAP);
+	preempt_disable();
+	tss_update_io_bitmap();
+	preempt_enable();
+	kfree(iobm);
+}
+
 /*
  * this changes the io permissions bitmap in the current task.
  */
@@ -61,11 +73,16 @@ long ksys_ioperm(unsigned long from, uns
 	 * Search for a (possibly new) maximum. This is simple and stupid,
 	 * to keep it obviously correct:
 	 */
-	max_long = 0;
+	max_long = UINT_MAX;
 	for (i = 0; i < IO_BITMAP_LONGS; i++) {
 		if (iobm->bitmap[i] != ~0UL)
 			max_long = i;
 	}
+	/* All permissions dropped? */
+	if (max_long == UINT_MAX) {
+		io_bitmap_exit();
+		return 0;
+	}
 
 	iobm->max = (max_long + 1) * sizeof(unsigned long);
 
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -102,21 +102,10 @@ int arch_dup_task_struct(struct task_str
 void exit_thread(struct task_struct *tsk)
 {
 	struct thread_struct *t = &tsk->thread;
-	struct io_bitmap *iobm = t->io_bitmap;
 	struct fpu *fpu = &t->fpu;
-	struct tss_struct *tss;
 
-	if (iobm) {
-		preempt_disable();
-		tss = this_cpu_ptr(&cpu_tss_rw);
-
-		t->io_bitmap = NULL;
-		clear_thread_flag(TIF_IO_BITMAP);
-		/* Invalidate the io bitmap base in the TSS */
-		tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_INVALID;
-		preempt_enable();
-		kfree(iobm);
-	}
+	if (test_thread_flag(TIF_IO_BITMAP))
+		io_bitmap_exit();
 
 	free_vm86(t);
 


