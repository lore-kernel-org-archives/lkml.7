Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4371BC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1917B206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfD0PQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:16:07 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33540 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727491AbfD0PP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:28 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2z-0000zL-6D; Sat, 27 Apr 2019 16:15:25 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2l-0004Yw-Ls; Sat, 27 Apr 2019 16:15:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Richard Weinberger" <richard@nod.at>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.217591220@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 131/202] unicore32: Use get_signal() signal_setup_done()
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

commit 649671c90eaf3cbbd0cd03460b6a92c0b674a32e upstream.

Use the more generic functions get_signal() signal_setup_done()
for signal delivery.

Signed-off-by: Richard Weinberger <richard@nod.at>
[bwh: Backported to 3.16 as dependency of commit 35634ffa1751
 "signal: Always notice exiting tasks"]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/unicore32/kernel/signal.c | 48 ++++++++++++++--------------------
 1 file changed, 20 insertions(+), 28 deletions(-)

diff --git a/arch/unicore32/kernel/signal.c b/arch/unicore32/kernel/signal.c
index 6905f0ebdc77..780d77388dec 100644
--- a/arch/unicore32/kernel/signal.c
+++ b/arch/unicore32/kernel/signal.c
@@ -238,10 +238,10 @@ static int setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 	return 0;
 }
 
-static int setup_frame(int usig, struct k_sigaction *ka,
-		sigset_t *set, struct pt_regs *regs)
+static int setup_frame(struct ksignal *ksig, sigset_t *set,
+		       struct pt_regs *regs)
 {
-	struct sigframe __user *frame = get_sigframe(ka, regs, sizeof(*frame));
+	struct sigframe __user *frame = get_sigframe(&ksig->ka, regs, sizeof(*frame));
 	int err = 0;
 
 	if (!frame)
@@ -254,29 +254,29 @@ static int setup_frame(int usig, struct k_sigaction *ka,
 
 	err |= setup_sigframe(frame, regs, set);
 	if (err == 0)
-		err |= setup_return(regs, ka, frame->retcode, frame, usig);
+		err |= setup_return(regs, &ksig->ka, frame->retcode, frame, usig);
 
 	return err;
 }
 
-static int setup_rt_frame(int usig, struct k_sigaction *ka, siginfo_t *info,
-	       sigset_t *set, struct pt_regs *regs)
+static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
+			  struct pt_regs *regs)
 {
 	struct rt_sigframe __user *frame =
-			get_sigframe(ka, regs, sizeof(*frame));
+			get_sigframe(&ksig->ka, regs, sizeof(*frame));
 	int err = 0;
 
 	if (!frame)
 		return 1;
 
-	err |= copy_siginfo_to_user(&frame->info, info);
+	err |= copy_siginfo_to_user(&frame->info, &ksig->info);
 
 	err |= __put_user(0, &frame->sig.uc.uc_flags);
 	err |= __put_user(NULL, &frame->sig.uc.uc_link);
 	err |= __save_altstack(&frame->sig.uc.uc_stack, regs->UCreg_sp);
 	err |= setup_sigframe(&frame->sig, regs, set);
 	if (err == 0)
-		err |= setup_return(regs, ka, frame->sig.retcode, frame, usig);
+		err |= setup_return(regs, &ksig->ka, frame->sig.retcode, frame, usig);
 
 	if (err == 0) {
 		/*
@@ -299,13 +299,13 @@ static inline void setup_syscall_restart(struct pt_regs *regs)
 /*
  * OK, we're invoking a handler
  */
-static void handle_signal(unsigned long sig, struct k_sigaction *ka,
-	      siginfo_t *info, struct pt_regs *regs, int syscall)
+static void handle_signal(struct ksignal *ksig, struct pt_regs *regs,
+			  int syscall)
 {
 	struct thread_info *thread = current_thread_info();
 	struct task_struct *tsk = current;
 	sigset_t *oldset = sigmask_to_save();
-	int usig = sig;
+	int usig = ksig->sig;
 	int ret;
 
 	/*
@@ -318,7 +318,7 @@ static void handle_signal(unsigned long sig, struct k_sigaction *ka,
 			regs->UCreg_00 = -EINTR;
 			break;
 		case -ERESTARTSYS:
-			if (!(ka->sa.sa_flags & SA_RESTART)) {
+			if (!(ksig->ka.sa.sa_flags & SA_RESTART)) {
 				regs->UCreg_00 = -EINTR;
 				break;
 			}
@@ -338,22 +338,17 @@ static void handle_signal(unsigned long sig, struct k_sigaction *ka,
 	/*
 	 * Set up the stack frame
 	 */
-	if (ka->sa.sa_flags & SA_SIGINFO)
-		ret = setup_rt_frame(usig, ka, info, oldset, regs);
+	if (ksig->ka.sa.sa_flags & SA_SIGINFO)
+		ret = setup_rt_frame(ksig, oldset, regs);
 	else
-		ret = setup_frame(usig, ka, oldset, regs);
+		ret = setup_frame(ksig, oldset, regs);
 
 	/*
 	 * Check that the resulting registers are actually sane.
 	 */
 	ret |= !valid_user_regs(regs);
 
-	if (ret != 0) {
-		force_sigsegv(sig, tsk);
-		return;
-	}
-
-	signal_delivered(sig, info, ka, regs, 0);
+	signal_setup_done(ret, ksig, 0);
 }
 
 /*
@@ -367,9 +362,7 @@ static void handle_signal(unsigned long sig, struct k_sigaction *ka,
  */
 static void do_signal(struct pt_regs *regs, int syscall)
 {
-	struct k_sigaction ka;
-	siginfo_t info;
-	int signr;
+	struct ksignal ksig;
 
 	/*
 	 * We want the common case to go fast, which
@@ -380,9 +373,8 @@ static void do_signal(struct pt_regs *regs, int syscall)
 	if (!user_mode(regs))
 		return;
 
-	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
-	if (signr > 0) {
-		handle_signal(signr, &ka, &info, regs, syscall);
+	if (get_signsl(&ksig)) {
+		handle_signal(&ksig, regs, syscall);
 		return;
 	}
 

