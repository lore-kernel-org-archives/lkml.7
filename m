Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFED1C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99EF3206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfD0PYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:24:01 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33552 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727494AbfD0PP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:28 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2z-0000zB-6C; Sat, 27 Apr 2019 16:15:25 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2l-0004Z6-PC; Sat, 27 Apr 2019 16:15:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Richard Weinberger" <richard@nod.at>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.543049242@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 133/202] xtensa: Use get_signal() signal_setup_done()
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

commit 5bdb7611eb7987102f3c0fef1220dd64b6fbd9fd upstream.

Use the more generic functions get_signal() signal_setup_done()
for signal delivery.

Signed-off-by: Richard Weinberger <richard@nod.at>
[bwh: Backported to 3.16 as dependency of commit 35634ffa1751
 "signal: Always notice exiting tasks"]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/xtensa/kernel/signal.c | 43 ++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 27 deletions(-)

diff --git a/arch/xtensa/kernel/signal.c b/arch/xtensa/kernel/signal.c
index 98b67d5f1514..4612321c73cc 100644
--- a/arch/xtensa/kernel/signal.c
+++ b/arch/xtensa/kernel/signal.c
@@ -331,17 +331,17 @@ gen_return_code(unsigned char *codemem)
 }
 
 
-static int setup_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
-		       sigset_t *set, struct pt_regs *regs)
+static int setup_frame(struct ksignal *ksig, sigset_t *set,
+		       struct pt_regs *regs)
 {
 	struct rt_sigframe *frame;
-	int err = 0;
+	int err = 0, sig = ksig->sig;
 	int signal;
 	unsigned long sp, ra, tp;
 
 	sp = regs->areg[1];
 
-	if ((ka->sa.sa_flags & SA_ONSTACK) != 0 && sas_ss_flags(sp) == 0) {
+	if ((ksig->ka.sa.sa_flags & SA_ONSTACK) != 0 && sas_ss_flags(sp) == 0) {
 		sp = current->sas_ss_sp + current->sas_ss_size;
 	}
 
@@ -351,7 +351,7 @@ static int setup_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
 		panic ("Double exception sys_sigreturn\n");
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame))) {
-		goto give_sigsegv;
+		return -EFAULT;
 	}
 
 	signal = current_thread_info()->exec_domain
@@ -360,8 +360,8 @@ static int setup_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
 		? current_thread_info()->exec_domain->signal_invmap[sig]
 		: sig;
 
-	if (ka->sa.sa_flags & SA_SIGINFO) {
-		err |= copy_siginfo_to_user(&frame->info, info);
+	if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
+		err |= copy_siginfo_to_user(&frame->info, &ksig->info);
 	}
 
 	/* Create the user context.  */
@@ -372,8 +372,8 @@ static int setup_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
 	err |= setup_sigcontext(frame, regs);
 	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
 
-	if (ka->sa.sa_flags & SA_RESTORER) {
-		ra = (unsigned long)ka->sa.sa_restorer;
+	if (ksig->ka.sa.sa_flags & SA_RESTORER) {
+		ra = (unsigned long)ksig->ka.sa.sa_restorer;
 	} else {
 
 		/* Create sys_rt_sigreturn syscall in stack frame */
@@ -381,7 +381,7 @@ static int setup_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
 		err |= gen_return_code(frame->retcode);
 
 		if (err) {
-			goto give_sigsegv;
+			return -EFAULT;
 		}
 		ra = (unsigned long) frame->retcode;
 	}
@@ -393,7 +393,7 @@ static int setup_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
 
 	/* Set up registers for signal handler; preserve the threadptr */
 	tp = regs->threadptr;
-	start_thread(regs, (unsigned long) ka->sa.sa_handler,
+	start_thread(regs, (unsigned long) ksig->ka.sa.sa_handler,
 		     (unsigned long) frame);
 
 	/* Set up a stack frame for a call4
@@ -416,10 +416,6 @@ static int setup_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
 #endif
 
 	return 0;
-
-give_sigsegv:
-	force_sigsegv(sig, current);
-	return -EFAULT;
 }
 
 /*
@@ -433,15 +429,11 @@ static int setup_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
  */
 static void do_signal(struct pt_regs *regs)
 {
-	siginfo_t info;
-	int signr;
-	struct k_sigaction ka;
+	struct ksignal ksig;
 
 	task_pt_regs(current)->icountlevel = 0;
 
-	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
-
-	if (signr > 0) {
+	if (get_signal(&ksig)) {
 		int ret;
 
 		/* Are we from a system call? */
@@ -457,7 +449,7 @@ static void do_signal(struct pt_regs *regs)
 					break;
 
 				case -ERESTARTSYS:
-					if (!(ka.sa.sa_flags & SA_RESTART)) {
+					if (!(ksig.ka.sa.sa_flags & SA_RESTART)) {
 						regs->areg[2] = -EINTR;
 						break;
 					}
@@ -476,11 +468,8 @@ static void do_signal(struct pt_regs *regs)
 
 		/* Whee!  Actually deliver the signal.  */
 		/* Set up the stack frame */
-		ret = setup_frame(signr, &ka, &info, sigmask_to_save(), regs);
-		if (ret)
-			return;
-
-		signal_delivered(signr, &info, &ka, regs, 0);
+		ret = setup_frame(&ksig, sigmask_to_save(), regs);
+		signal_setup_done(ret, &ksig, 0);
 		if (current->ptrace & PT_SINGLESTEP)
 			task_pt_regs(current)->icountlevel = 1;
 

