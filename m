Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45846C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C6FD208CA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbfD0PQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:16:03 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33558 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727492AbfD0PP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:28 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2z-0000zO-9x; Sat, 27 Apr 2019 16:15:25 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2l-0004Yc-Gz; Sat, 27 Apr 2019 16:15:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Richard Weinberger" <richard@nod.at>,
        "Lennox Wu" <lennox.wu@gmail.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.968323605@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 127/202] score: Use get_signal() signal_setup_done()
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

commit 2bb12b773feb3e792145961e57ab356e6134d4a5 upstream.

Use the more generic functions get_signal() signal_setup_done()
for signal delivery.

Acked-by: Lennox Wu <lennox.wu@gmail.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
[bwh: Backported to 3.16 as dependency of commit 35634ffa1751
 "signal: Always notice exiting tasks"]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/score/kernel/signal.c | 43 ++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 25 deletions(-)

--- a/arch/score/kernel/signal.c
+++ b/arch/score/kernel/signal.c
@@ -173,15 +173,15 @@ badframe:
 	return 0;
 }
 
-static int setup_rt_frame(struct k_sigaction *ka, struct pt_regs *regs,
-		int signr, sigset_t *set, siginfo_t *info)
+static int setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs,
+			  sigset_t *set)
 {
 	struct rt_sigframe __user *frame;
 	int err = 0;
 
-	frame = get_sigframe(ka, regs, sizeof(*frame));
+	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame));
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
-		goto give_sigsegv;
+		return -EFAULT;
 
 	/*
 	 * Set up the return code ...
@@ -194,7 +194,7 @@ static int setup_rt_frame(struct k_sigac
 	err |= __put_user(0x80008002, frame->rs_code + 1);
 	flush_cache_sigtramp((unsigned long) frame->rs_code);
 
-	err |= copy_siginfo_to_user(&frame->rs_info, info);
+	err |= copy_siginfo_to_user(&frame->rs_info, &ksig->info);
 	err |= __put_user(0, &frame->rs_uc.uc_flags);
 	err |= __put_user(NULL, &frame->rs_uc.uc_link);
 	err |= __save_altstack(&frame->rs_uc.uc_stack, regs->regs[0]);
@@ -202,26 +202,23 @@ static int setup_rt_frame(struct k_sigac
 	err |= __copy_to_user(&frame->rs_uc.uc_sigmask, set, sizeof(*set));
 
 	if (err)
-		goto give_sigsegv;
+		return -EFAULT;
 
 	regs->regs[0] = (unsigned long) frame;
 	regs->regs[3] = (unsigned long) frame->rs_code;
-	regs->regs[4] = signr;
+	regs->regs[4] = ksig->sig;
 	regs->regs[5] = (unsigned long) &frame->rs_info;
 	regs->regs[6] = (unsigned long) &frame->rs_uc;
-	regs->regs[29] = (unsigned long) ka->sa.sa_handler;
-	regs->cp0_epc = (unsigned long) ka->sa.sa_handler;
+	regs->regs[29] = (unsigned long) ksig->ka.sa.sa_handler;
+	regs->cp0_epc = (unsigned long) ksig->ka.sa.sa_handler;
 
 	return 0;
-
-give_sigsegv:
-	force_sigsegv(signr, current);
-	return -EFAULT;
 }
 
-static void handle_signal(unsigned long sig, siginfo_t *info,
-	struct k_sigaction *ka, struct pt_regs *regs)
+static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 {
+	int ret;
+
 	if (regs->is_syscall) {
 		switch (regs->regs[4]) {
 		case ERESTART_RESTARTBLOCK:
@@ -229,7 +226,7 @@ static void handle_signal(unsigned long
 			regs->regs[4] = EINTR;
 			break;
 		case ERESTARTSYS:
-			if (!(ka->sa.sa_flags & SA_RESTART)) {
+			if (!(ksig->ka.sa.sa_flags & SA_RESTART)) {
 				regs->regs[4] = EINTR;
 				break;
 			}
@@ -245,17 +242,14 @@ static void handle_signal(unsigned long
 	/*
 	 * Set up the stack frame
 	 */
-	if (setup_rt_frame(ka, regs, sig, sigmask_to_save(), info) < 0)
-		return;
+	ret = setup_rt_frame(ksig, regs, sigmask_to_save());
 
-	signal_delivered(sig, info, ka, regs, 0);
+	signal_setup_done(ret, ksig, 0);
 }
 
 static void do_signal(struct pt_regs *regs)
 {
-	struct k_sigaction ka;
-	siginfo_t info;
-	int signr;
+	struct ksignal ksig;
 
 	/*
 	 * We want the common case to go fast, which is why we may in certain
@@ -265,10 +259,9 @@ static void do_signal(struct pt_regs *re
 	if (!user_mode(regs))
 		return;
 
-	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
-	if (signr > 0) {
+	if (get_signal(&ksig)) {
 		/* Actually deliver the signal.  */
-		handle_signal(signr, &info, &ka, regs);
+		handle_signal(&ksig, regs);
 		return;
 	}
 

