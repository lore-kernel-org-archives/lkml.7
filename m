Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37160C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 11:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D0962068D
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 11:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfKPLvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 06:51:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45238 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbfKPLv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 06:51:28 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVwbr-000278-Ae; Sat, 16 Nov 2019 12:51:23 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D9EEC1C1901;
        Sat, 16 Nov 2019 12:51:22 +0100 (CET)
Date:   Sat, 16 Nov 2019 11:51:22 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/iopl] x86/ioperm: Share I/O bitmap if identical
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157390508283.12247.865905500135384734.tip-bot2@tip-bot2>
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

Commit-ID:     4804e382c117ce213cd5c43512cf4b1d71bb2650
Gitweb:        https://git.kernel.org/tip/4804e382c117ce213cd5c43512cf4b1d71bb2650
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 11 Nov 2019 23:03:25 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 16 Nov 2019 11:24:04 +01:00

x86/ioperm: Share I/O bitmap if identical

The I/O bitmap is duplicated on fork. That's wasting memory and slows down
fork. There is no point to do so. As long as the bitmap is not modified it
can be shared between threads and processes.

Add a refcount and just share it on fork. If a task modifies the bitmap
then it has to do the duplication if and only if it is shared.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski <luto@kernel.org>

---
 arch/x86/include/asm/io_bitmap.h |  5 +++-
 arch/x86/kernel/ioport.c         | 48 +++++++++++++++++++++++++------
 arch/x86/kernel/process.c        | 39 +++----------------------
 3 files changed, 50 insertions(+), 42 deletions(-)

diff --git a/arch/x86/include/asm/io_bitmap.h b/arch/x86/include/asm/io_bitmap.h
index 784a88e..b664baa 100644
--- a/arch/x86/include/asm/io_bitmap.h
+++ b/arch/x86/include/asm/io_bitmap.h
@@ -2,15 +2,20 @@
 #ifndef _ASM_X86_IOBITMAP_H
 #define _ASM_X86_IOBITMAP_H
 
+#include <linux/refcount.h>
 #include <asm/processor.h>
 
 struct io_bitmap {
 	u64		sequence;
+	refcount_t	refcnt;
 	/* The maximum number of bytes to copy so all zero bits are covered */
 	unsigned int	max;
 	unsigned long	bitmap[IO_BITMAP_LONGS];
 };
 
+struct task_struct;
+
+void io_bitmap_share(struct task_struct *tsk);
 void io_bitmap_exit(void);
 
 void tss_update_io_bitmap(void);
diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
index f9fc69a..f82ca1c 100644
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -16,6 +16,17 @@
 
 static atomic64_t io_bitmap_sequence;
 
+void io_bitmap_share(struct task_struct *tsk)
+ {
+	/*
+	 * Take a refcount on current's bitmap. It can be used by
+	 * both tasks as long as none of them changes the bitmap.
+	 */
+	refcount_inc(&current->thread.io_bitmap->refcnt);
+	tsk->thread.io_bitmap = current->thread.io_bitmap;
+	set_tsk_thread_flag(tsk, TIF_IO_BITMAP);
+}
+
 void io_bitmap_exit(void)
 {
 	struct io_bitmap *iobm = current->thread.io_bitmap;
@@ -25,7 +36,8 @@ void io_bitmap_exit(void)
 	preempt_disable();
 	tss_update_io_bitmap();
 	preempt_enable();
-	kfree(iobm);
+	if (iobm && refcount_dec_and_test(&iobm->refcnt))
+		kfree(iobm);
 }
 
 /*
@@ -58,9 +70,32 @@ long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
 			return -ENOMEM;
 
 		memset(iobm->bitmap, 0xff, sizeof(iobm->bitmap));
+		refcount_set(&iobm->refcnt, 1);
+	}
+
+	/*
+	 * If the bitmap is not shared, then nothing can take a refcount as
+	 * current can obviously not fork at the same time. If it's shared
+	 * duplicate it and drop the refcount on the original one.
+	 */
+	if (refcount_read(&iobm->refcnt) > 1) {
+		iobm = kmemdup(iobm, sizeof(*iobm), GFP_KERNEL);
+		if (!iobm)
+			return -ENOMEM;
+		refcount_set(&iobm->refcnt, 1);
+		io_bitmap_exit();
 	}
 
 	/*
+	 * Store the bitmap pointer (might be the same if the task already
+	 * head one). Must be done here so freeing the bitmap when all
+	 * permissions are dropped has the pointer set up.
+	 */
+	t->io_bitmap = iobm;
+	/* Mark it active for context switching and exit to user mode */
+	set_thread_flag(TIF_IO_BITMAP);
+
+	/*
 	 * Update the tasks bitmap. The update of the TSS bitmap happens on
 	 * exit to user mode. So this needs no protection.
 	 */
@@ -86,16 +121,11 @@ long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
 
 	iobm->max = (max_long + 1) * sizeof(unsigned long);
 
-	/* Update the sequence number to force an update in switch_to() */
-	iobm->sequence = atomic64_add_return(1, &io_bitmap_sequence);
-
 	/*
-	 * Store the bitmap pointer (might be the same if the task already
-	 * head one). Set the TIF flag, just in case this is the first
-	 * invocation.
+	 * Update the sequence number to force a TSS update on return to
+	 * user mode.
 	 */
-	t->io_bitmap = iobm;
-	set_thread_flag(TIF_IO_BITMAP);
+	iobm->sequence = atomic64_add_return(1, &io_bitmap_sequence);
 
 	return 0;
 }
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 7ba4d54..0b19c13 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -122,37 +122,13 @@ static int set_new_tls(struct task_struct *p, unsigned long tls)
 		return do_set_thread_area_64(p, ARCH_SET_FS, tls);
 }
 
-static inline int copy_io_bitmap(struct task_struct *tsk)
-{
-	struct io_bitmap *iobm = current->thread.io_bitmap;
-
-	if (likely(!test_tsk_thread_flag(current, TIF_IO_BITMAP)))
-		return 0;
-
-	tsk->thread.io_bitmap = kmemdup(iobm, sizeof(*iobm), GFP_KERNEL);
-
-	if (!tsk->thread.io_bitmap)
-		return -ENOMEM;
-
-	set_tsk_thread_flag(tsk, TIF_IO_BITMAP);
-	return 0;
-}
-
-static inline void free_io_bitmap(struct task_struct *tsk)
-{
-	if (tsk->thread.io_bitmap) {
-		kfree(tsk->thread.io_bitmap);
-		tsk->thread.io_bitmap = NULL;
-	}
-}
-
 int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
 		    unsigned long arg, struct task_struct *p, unsigned long tls)
 {
 	struct inactive_task_frame *frame;
 	struct fork_frame *fork_frame;
 	struct pt_regs *childregs;
-	int ret;
+	int ret = 0;
 
 	childregs = task_pt_regs(p);
 	fork_frame = container_of(childregs, struct fork_frame, regs);
@@ -199,16 +175,13 @@ int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
 	task_user_gs(p) = get_user_gs(current_pt_regs());
 #endif
 
-	ret = copy_io_bitmap(p);
-	if (ret)
-		return ret;
-
 	/* Set a new TLS for the child thread? */
-	if (clone_flags & CLONE_SETTLS) {
+	if (clone_flags & CLONE_SETTLS)
 		ret = set_new_tls(p, tls);
-		if (ret)
-			free_io_bitmap(p);
-	}
+
+	if (!ret && unlikely(test_tsk_thread_flag(current, TIF_IO_BITMAP)))
+		io_bitmap_share(p);
+
 	return ret;
 }
 
