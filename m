Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3437C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE531206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbfD0PWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:22:39 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33790 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727548AbfD0PPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:31 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP32-00014L-E5; Sat, 27 Apr 2019 16:15:28 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2k-0004X0-Tb; Sat, 27 Apr 2019 16:15:10 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Richard Weinberger" <richard@nod.at>,
        "Vineet Gupta" <vgupta@synopsys.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.273527997@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 107/202] arc: Use get_signal() signal_setup_done()
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

commit f6dd2a3f1f8d8df640cfa2d60f85c0b818af1593 upstream.

Use the more generic functions get_signal() signal_setup_done()
for signal delivery.

Signed-off-by: Richard Weinberger <richard@nod.at>
Acked-by: Vineet Gupta <vgupta@synopsys.com>
[bwh: Backported to 3.16 as dependency of commit 35634ffa1751
 "signal: Always notice exiting tasks"
 - Adjust to apply after "ARC: signal handling robustify"]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/arc/kernel/signal.c | 39 +++++++++++++++------------------------
 1 file changed, 15 insertions(+), 24 deletions(-)

--- a/arch/arc/kernel/signal.c
+++ b/arch/arc/kernel/signal.c
@@ -189,14 +189,13 @@ static inline int map_sig(int sig)
 }
 
 static int
-setup_rt_frame(int signo, struct k_sigaction *ka, siginfo_t *info,
-	       sigset_t *set, struct pt_regs *regs)
+setup_rt_frame(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs)
 {
 	struct rt_sigframe __user *sf;
 	unsigned int magic = 0;
 	int err = 0;
 
-	sf = get_sigframe(ka, regs, sizeof(struct rt_sigframe));
+	sf = get_sigframe(&ksig->ka, regs, sizeof(struct rt_sigframe));
 	if (!sf)
 		return 1;
 
@@ -215,8 +214,8 @@ setup_rt_frame(int signo, struct k_sigac
 	 *  #2: struct siginfo
 	 *  #3: struct ucontext (completely populated)
 	 */
-	if (unlikely(ka->sa.sa_flags & SA_SIGINFO)) {
-		err |= copy_siginfo_to_user(&sf->info, info);
+	if (unlikely(ksig->ka.sa.sa_flags & SA_SIGINFO)) {
+		err |= copy_siginfo_to_user(&sf->info, &ksig->info);
 		err |= __put_user(0, &sf->uc.uc_flags);
 		err |= __put_user(NULL, &sf->uc.uc_link);
 		err |= __save_altstack(&sf->uc.uc_stack, regs->sp);
@@ -237,19 +236,19 @@ setup_rt_frame(int signo, struct k_sigac
 		return err;
 
 	/* #1 arg to the user Signal handler */
-	regs->r0 = map_sig(signo);
+	regs->r0 = map_sig(ksig->sig);
 
 	/* setup PC of user space signal handler */
-	regs->ret = (unsigned long)ka->sa.sa_handler;
+	regs->ret = (unsigned long)ksig->ka.sa.sa_handler;
 
 	/*
 	 * handler returns using sigreturn stub provided already by userpsace
 	 * If not, nuke the process right away
 	 */
-	if(!(ka->sa.sa_flags & SA_RESTORER))
+	if(!(ksig->ka.sa.sa_flags & SA_RESTORER))
 		return 1;
 
-	regs->blink = (unsigned long)ka->sa.sa_restorer;
+	regs->blink = (unsigned long)ksig->ka.sa.sa_restorer;
 
 	/* User Stack for signal handler will be above the frame just carved */
 	regs->sp = (unsigned long)sf;
@@ -311,38 +310,30 @@ static void arc_restart_syscall(struct k
  * OK, we're invoking a handler
  */
 static void
-handle_signal(unsigned long sig, struct k_sigaction *ka, siginfo_t *info,
-	      struct pt_regs *regs)
+handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 {
 	sigset_t *oldset = sigmask_to_save();
 	int failed;
 
 	/* Set up the stack frame */
-	failed = setup_rt_frame(sig, ka, info, oldset, regs);
+	failed = setup_rt_frame(ksig, oldset, regs);
 
-	if (failed)
-		force_sigsegv(sig, current);
-	else
-		signal_delivered(sig, info, ka, regs, 0);
+	signal_setup_done(failed, ksig, 0);
 }
 
 void do_signal(struct pt_regs *regs)
 {
-	struct k_sigaction ka;
-	siginfo_t info;
-	int signr;
+	struct ksignal ksig;
 	int restart_scall;
 
-	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
-
 	restart_scall = in_syscall(regs) && syscall_restartable(regs);
 
-	if (signr > 0) {
+	if (get_signal(&ksig)) {
 		if (restart_scall) {
-			arc_restart_syscall(&ka, regs);
+			arc_restart_syscall(&ksig.ka, regs);
 			syscall_wont_restart(regs);	/* No more restarts */
 		}
-		handle_signal(signr, &ka, &info, regs);
+		handle_signal(&ksig, regs);
 		return;
 	}
 

