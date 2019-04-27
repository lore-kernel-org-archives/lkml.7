Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B10C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD382053B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbfD0PWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:22:12 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33808 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727557AbfD0PPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:32 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP32-0000zG-BZ; Sat, 27 Apr 2019 16:15:28 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2l-0004Xo-5s; Sat, 27 Apr 2019 16:15:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Richard Weinberger" <richard@nod.at>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.460399083@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 117/202] m68k: Use get_signal() signal_setup_done()
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Weinberger <richard@nod.at>

commit 0d97500d393012690f3579056629bea0369e6554 upstream.

Use the more generic functions get_signal() signal_setup_done()
for signal delivery.

Signed-off-by: Richard Weinberger <richard@nod.at>
[bwh: Backported to 3.16 as dependency of commit 35634ffa1751
 "signal: Always notice exiting tasks"]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/m68k/kernel/signal.c | 63 +++++++++++++++------------------------
 1 file changed, 24 insertions(+), 39 deletions(-)

--- a/arch/m68k/kernel/signal.c
+++ b/arch/m68k/kernel/signal.c
@@ -850,23 +850,23 @@ get_sigframe(struct k_sigaction *ka, str
 	return (void __user *)((usp - frame_size) & -8UL);
 }
 
-static int setup_frame (int sig, struct k_sigaction *ka,
-			 sigset_t *set, struct pt_regs *regs)
+static int setup_frame(struct ksignal *ksig, sigset_t *set,
+			struct pt_regs *regs)
 {
 	struct sigframe __user *frame;
 	int fsize = frame_extra_sizes(regs->format);
 	struct sigcontext context;
-	int err = 0;
+	int err = 0, sig = ksig->sig;
 
 	if (fsize < 0) {
 #ifdef DEBUG
 		printk ("setup_frame: Unknown frame format %#x\n",
 			regs->format);
 #endif
-		goto give_sigsegv;
+		return -EFAULT;
 	}
 
-	frame = get_sigframe(ka, regs, sizeof(*frame) + fsize);
+	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame) + fsize);
 
 	if (fsize)
 		err |= copy_to_user (frame + 1, regs + 1, fsize);
@@ -899,7 +899,7 @@ static int setup_frame (int sig, struct
 #endif
 
 	if (err)
-		goto give_sigsegv;
+		return -EFAULT;
 
 	push_cache ((unsigned long) &frame->retcode);
 
@@ -908,7 +908,7 @@ static int setup_frame (int sig, struct
 	 * to destroy is successfully copied to sigframe.
 	 */
 	wrusp ((unsigned long) frame);
-	regs->pc = (unsigned long) ka->sa.sa_handler;
+	regs->pc = (unsigned long) ksig->ka.sa.sa_handler;
 	adjustformat(regs);
 
 	/*
@@ -934,28 +934,24 @@ static int setup_frame (int sig, struct
 		tregs->sr = regs->sr;
 	}
 	return 0;
-
-give_sigsegv:
-	force_sigsegv(sig, current);
-	return err;
 }
 
-static int setup_rt_frame (int sig, struct k_sigaction *ka, siginfo_t *info,
-			    sigset_t *set, struct pt_regs *regs)
+static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
+			   struct pt_regs *regs)
 {
 	struct rt_sigframe __user *frame;
 	int fsize = frame_extra_sizes(regs->format);
-	int err = 0;
+	int err = 0, sig = ksig->sig;
 
 	if (fsize < 0) {
 #ifdef DEBUG
 		printk ("setup_frame: Unknown frame format %#x\n",
 			regs->format);
 #endif
-		goto give_sigsegv;
+		return -EFAULT;
 	}
 
-	frame = get_sigframe(ka, regs, sizeof(*frame));
+	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame));
 
 	if (fsize)
 		err |= copy_to_user (&frame->uc.uc_extra, regs + 1, fsize);
@@ -968,7 +964,7 @@ static int setup_rt_frame (int sig, stru
 			  &frame->sig);
 	err |= __put_user(&frame->info, &frame->pinfo);
 	err |= __put_user(&frame->uc, &frame->puc);
-	err |= copy_siginfo_to_user(&frame->info, info);
+	err |= copy_siginfo_to_user(&frame->info, &ksig->info);
 
 	/* Create the ucontext.  */
 	err |= __put_user(0, &frame->uc.uc_flags);
@@ -996,7 +992,7 @@ static int setup_rt_frame (int sig, stru
 #endif /* CONFIG_MMU */
 
 	if (err)
-		goto give_sigsegv;
+		return -EFAULT;
 
 	push_cache ((unsigned long) &frame->retcode);
 
@@ -1005,7 +1001,7 @@ static int setup_rt_frame (int sig, stru
 	 * to destroy is successfully copied to sigframe.
 	 */
 	wrusp ((unsigned long) frame);
-	regs->pc = (unsigned long) ka->sa.sa_handler;
+	regs->pc = (unsigned long) ksig->ka.sa.sa_handler;
 	adjustformat(regs);
 
 	/*
@@ -1031,10 +1027,6 @@ static int setup_rt_frame (int sig, stru
 		tregs->sr = regs->sr;
 	}
 	return 0;
-
-give_sigsegv:
-	force_sigsegv(sig, current);
-	return err;
 }
 
 static inline void
@@ -1074,26 +1066,22 @@ handle_restart(struct pt_regs *regs, str
  * OK, we're invoking a handler
  */
 static void
-handle_signal(int sig, struct k_sigaction *ka, siginfo_t *info,
-	      struct pt_regs *regs)
+handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 {
 	sigset_t *oldset = sigmask_to_save();
 	int err;
 	/* are we from a system call? */
 	if (regs->orig_d0 >= 0)
 		/* If so, check system call restarting.. */
-		handle_restart(regs, ka, 1);
+		handle_restart(regs, &ksig->ka, 1);
 
 	/* set up the stack frame */
-	if (ka->sa.sa_flags & SA_SIGINFO)
-		err = setup_rt_frame(sig, ka, info, oldset, regs);
+	if (ksig->ka.sa.sa_flags & SA_SIGINFO)
+		err = setup_rt_frame(ksig, oldset, regs);
 	else
-		err = setup_frame(sig, ka, oldset, regs);
-
-	if (err)
-		return;
+		err = setup_frame(ksig, oldset, regs);
 
-	signal_delivered(sig, info, ka, regs, 0);
+	signal_setup_done(err, ksig, 0);
 
 	if (test_thread_flag(TIF_DELAYED_TRACE)) {
 		regs->sr &= ~0x8000;
@@ -1108,16 +1096,13 @@ handle_signal(int sig, struct k_sigactio
  */
 static void do_signal(struct pt_regs *regs)
 {
-	siginfo_t info;
-	struct k_sigaction ka;
-	int signr;
+	struct ksignal ksig;
 
 	current->thread.esp0 = (unsigned long) regs;
 
-	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
-	if (signr > 0) {
+	if (get_signal(&ksig)) {
 		/* Whee!  Actually deliver the signal.  */
-		handle_signal(signr, &ka, &info, regs);
+		handle_signal(&ksig, regs);
 		return;
 	}
 

