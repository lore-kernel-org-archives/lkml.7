Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11993C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7580208CB
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfD0PVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:21:52 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33802 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727554AbfD0PPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:32 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP32-0000zH-E0; Sat, 27 Apr 2019 16:15:28 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2l-0004XO-2I; Sat, 27 Apr 2019 16:15:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Richard Weinberger" <richard@nod.at>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.608755868@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 112/202] cris: Use get_signal() signal_setup_done()
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

commit fa0197722eb7559a6a9733881bbb8d9e76364f33 upstream.

Use the more generic functions get_signal() signal_setup_done()
for signal delivery.

Signed-off-by: Richard Weinberger <richard@nod.at>
[bwh: Backported to 3.16 as dependency of commit 35634ffa1751
 "signal: Always notice exiting tasks"]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/cris/arch-v10/kernel/signal.c | 79 +++++++++++++-----------------
 arch/cris/arch-v32/kernel/signal.c | 77 ++++++++++++-----------------
 2 files changed, 63 insertions(+), 93 deletions(-)

--- a/arch/cris/arch-v10/kernel/signal.c
+++ b/arch/cris/arch-v10/kernel/signal.c
@@ -228,33 +228,33 @@ get_sigframe(struct k_sigaction *ka, str
  * user-mode trampoline.
  */
 
-static int setup_frame(int sig, struct k_sigaction *ka,
-		       sigset_t *set, struct pt_regs *regs)
+static int setup_frame(struct ksignal *ksig, sigset_t *set,
+		       struct pt_regs *regs)
 {
 	struct sigframe __user *frame;
 	unsigned long return_ip;
 	int err = 0;
 
-	frame = get_sigframe(ka, regs, sizeof(*frame));
+	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame));
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
-		goto give_sigsegv;
+		return -EFAULT;
 
 	err |= setup_sigcontext(&frame->sc, regs, set->sig[0]);
 	if (err)
-		goto give_sigsegv;
+		return -EFAULT;
 
 	if (_NSIG_WORDS > 1) {
 		err |= __copy_to_user(frame->extramask, &set->sig[1],
 				      sizeof(frame->extramask));
 	}
 	if (err)
-		goto give_sigsegv;
+		return -EFAULT;
 
 	/* Set up to return from userspace.  If provided, use a stub
 	   already in userspace.  */
-	if (ka->sa.sa_flags & SA_RESTORER) {
-		return_ip = (unsigned long)ka->sa.sa_restorer;
+	if (ksig->ka.sa.sa_flags & SA_RESTORER) {
+		return_ip = (unsigned long)ksig->ka.sa.sa_restorer;
 	} else {
 		/* trampoline - the desired return ip is the retcode itself */
 		return_ip = (unsigned long)&frame->retcode;
@@ -265,42 +265,38 @@ static int setup_frame(int sig, struct k
 	}
 
 	if (err)
-		goto give_sigsegv;
+		return -EFAULT;
 
 	/* Set up registers for signal handler */
 
-	regs->irp = (unsigned long) ka->sa.sa_handler;  /* what we enter NOW   */
+	regs->irp = (unsigned long) ksig->ka.sa.sa_handler;  /* what we enter NOW   */
 	regs->srp = return_ip;                          /* what we enter LATER */
-	regs->r10 = sig;                                /* first argument is signo */
+	regs->r10 = ksig->sig;                                /* first argument is signo */
 
 	/* actually move the usp to reflect the stacked frame */
 
 	wrusp((unsigned long)frame);
 
 	return 0;
-
-give_sigsegv:
-	force_sigsegv(sig, current);
-	return -EFAULT;
 }
 
-static int setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
-	sigset_t *set, struct pt_regs *regs)
+static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
+			  struct pt_regs *regs)
 {
 	struct rt_sigframe __user *frame;
 	unsigned long return_ip;
 	int err = 0;
 
-	frame = get_sigframe(ka, regs, sizeof(*frame));
+	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame));
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
-		goto give_sigsegv;
+		return -EFAULT;
 
 	err |= __put_user(&frame->info, &frame->pinfo);
 	err |= __put_user(&frame->uc, &frame->puc);
-	err |= copy_siginfo_to_user(&frame->info, info);
+	err |= copy_siginfo_to_user(&frame->info, &ksig->info);
 	if (err)
-		goto give_sigsegv;
+		return -EFAULT;
 
 	/* Clear all the bits of the ucontext we don't use.  */
         err |= __clear_user(&frame->uc, offsetof(struct ucontext, uc_mcontext));
@@ -312,12 +308,12 @@ static int setup_rt_frame(int sig, struc
 	err |= __save_altstack(&frame->uc.uc_stack, rdusp());
 
 	if (err)
-		goto give_sigsegv;
+		return -EFAULT;
 
 	/* Set up to return from userspace.  If provided, use a stub
 	   already in userspace.  */
-	if (ka->sa.sa_flags & SA_RESTORER) {
-		return_ip = (unsigned long)ka->sa.sa_restorer;
+	if (ksig->ka.sa.sa_flags & SA_RESTORER) {
+		return_ip = (unsigned long)ksig->ka.sa.sa_restorer;
 	} else {
 		/* trampoline - the desired return ip is the retcode itself */
 		return_ip = (unsigned long)&frame->retcode;
@@ -329,18 +325,18 @@ static int setup_rt_frame(int sig, struc
 	}
 
 	if (err)
-		goto give_sigsegv;
+		return -EFAULT;
 
 	/* TODO what is the current->exec_domain stuff and invmap ? */
 
 	/* Set up registers for signal handler */
 
 	/* What we enter NOW   */
-	regs->irp = (unsigned long) ka->sa.sa_handler;
+	regs->irp = (unsigned long) ksig->ka.sa.sa_handler;
 	/* What we enter LATER */
 	regs->srp = return_ip;
 	/* First argument is signo */
-	regs->r10 = sig;
+	regs->r10 = ksig->sig;
 	/* Second argument is (siginfo_t *) */
 	regs->r11 = (unsigned long)&frame->info;
 	/* Third argument is unused */
@@ -350,19 +346,14 @@ static int setup_rt_frame(int sig, struc
 	wrusp((unsigned long)frame);
 
 	return 0;
-
-give_sigsegv:
-	force_sigsegv(sig, current);
-	return -EFAULT;
 }
 
 /*
  * OK, we're invoking a handler
  */
 
-static inline void handle_signal(int canrestart, unsigned long sig,
-	siginfo_t *info, struct k_sigaction *ka,
-	struct pt_regs *regs)
+static inline void handle_signal(int canrestart, struct ksignal *ksig,
+				 struct pt_regs *regs)
 {
 	sigset_t *oldset = sigmask_to_save();
 	int ret;
@@ -383,7 +374,7 @@ static inline void handle_signal(int can
 			/* ERESTARTSYS means to restart the syscall if
 			 * there is no handler or the handler was
 			 * registered with SA_RESTART */
-			if (!(ka->sa.sa_flags & SA_RESTART)) {
+			if (!(ksig->ka.sa.sa_flags & SA_RESTART)) {
 				regs->r10 = -EINTR;
 				break;
 			}
@@ -396,13 +387,12 @@ static inline void handle_signal(int can
 	}
 
 	/* Set up the stack frame */
-	if (ka->sa.sa_flags & SA_SIGINFO)
-		ret = setup_rt_frame(sig, ka, info, oldset, regs);
+	if (ksig->ka.sa.sa_flags & SA_SIGINFO)
+		ret = setup_rt_frame(ksig, oldset, regs);
 	else
-		ret = setup_frame(sig, ka, oldset, regs);
+		ret = setup_frame(ksig, oldset, regs);
 
-	if (ret == 0)
-		signal_delivered(sig, info, ka, regs, 0);
+	signal_setup_done(ret, ksig, 0);
 }
 
 /*
@@ -419,9 +409,7 @@ static inline void handle_signal(int can
 
 void do_signal(int canrestart, struct pt_regs *regs)
 {
-	siginfo_t info;
-	int signr;
-        struct k_sigaction ka;
+	struct ksignal ksig;
 
 	/*
 	 * We want the common case to go fast, which
@@ -432,10 +420,9 @@ void do_signal(int canrestart, struct pt
 	if (!user_mode(regs))
 		return;
 
-	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
-	if (signr > 0) {
+	if (get_signal(&ksig)) {
 		/* Whee!  Actually deliver the signal.  */
-		handle_signal(canrestart, signr, &info, &ka, regs);
+		handle_signal(canrestart, &ksig, regs);
 		return;
 	}
 
--- a/arch/cris/arch-v32/kernel/signal.c
+++ b/arch/cris/arch-v32/kernel/signal.c
@@ -215,23 +215,22 @@ get_sigframe(struct k_sigaction *ka, str
  * trampoline.
   */
 static int
-setup_frame(int sig, struct k_sigaction *ka,  sigset_t *set,
-	    struct pt_regs * regs)
+setup_frame(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs)
 {
 	int err;
 	unsigned long return_ip;
 	struct signal_frame __user *frame;
 
 	err = 0;
-	frame = get_sigframe(ka, regs, sizeof(*frame));
+	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame));
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
-		goto give_sigsegv;
+		return -EFAULT;
 
 	err |= setup_sigcontext(&frame->sc, regs, set->sig[0]);
 
 	if (err)
-		goto give_sigsegv;
+		return -EFAULT;
 
 	if (_NSIG_WORDS > 1) {
 		err |= __copy_to_user(frame->extramask, &set->sig[1],
@@ -239,14 +238,14 @@ setup_frame(int sig, struct k_sigaction
 	}
 
 	if (err)
-		goto give_sigsegv;
+		return -EFAULT;
 
 	/*
 	 * Set up to return from user-space. If provided, use a stub
 	 * already located in user-space.
 	 */
-	if (ka->sa.sa_flags & SA_RESTORER) {
-		return_ip = (unsigned long)ka->sa.sa_restorer;
+	if (ksig->ka.sa.sa_flags & SA_RESTORER) {
+		return_ip = (unsigned long)ksig->ka.sa.sa_restorer;
 	} else {
 		/* Trampoline - the desired return ip is in the signal return page. */
 		return_ip = cris_signal_return_page;
@@ -264,7 +263,7 @@ setup_frame(int sig, struct k_sigaction
 	}
 
 	if (err)
-		goto give_sigsegv;
+		return -EFAULT;
 
 	/*
 	 * Set up registers for signal handler.
@@ -273,42 +272,37 @@ setup_frame(int sig, struct k_sigaction
 	 * Where the code enter later.
 	 * First argument, signo.
 	 */
-	regs->erp = (unsigned long) ka->sa.sa_handler;
+	regs->erp = (unsigned long) ksig->ka.sa.sa_handler;
 	regs->srp = return_ip;
-	regs->r10 = sig;
+	regs->r10 = ksig->sig;
 
 	/* Actually move the USP to reflect the stacked frame. */
 	wrusp((unsigned long)frame);
 
 	return 0;
-
-give_sigsegv:
-	force_sigsegv(sig, current);
-	return -EFAULT;
 }
 
 static int
-setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
-	       sigset_t *set, struct pt_regs * regs)
+setup_rt_frame(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs)
 {
 	int err;
 	unsigned long return_ip;
 	struct rt_signal_frame __user *frame;
 
 	err = 0;
-	frame = get_sigframe(ka, regs, sizeof(*frame));
+	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame));
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
-		goto give_sigsegv;
+		return -EFAULT;
 
 	/* TODO: what is the current->exec_domain stuff and invmap ? */
 
 	err |= __put_user(&frame->info, &frame->pinfo);
 	err |= __put_user(&frame->uc, &frame->puc);
-	err |= copy_siginfo_to_user(&frame->info, info);
+	err |= copy_siginfo_to_user(&frame->info, &ksig->info);
 
 	if (err)
-		goto give_sigsegv;
+		return -EFAULT;
 
 	/* Clear all the bits of the ucontext we don't use.  */
 	err |= __clear_user(&frame->uc, offsetof(struct ucontext, uc_mcontext));
@@ -317,14 +311,14 @@ setup_rt_frame(int sig, struct k_sigacti
 	err |= __save_altstack(&frame->uc.uc_stack, rdusp());
 
 	if (err)
-		goto give_sigsegv;
+		return -EFAULT;
 
 	/*
 	 * Set up to return from user-space. If provided, use a stub
 	 * already located in user-space.
 	 */
-	if (ka->sa.sa_flags & SA_RESTORER) {
-		return_ip = (unsigned long) ka->sa.sa_restorer;
+	if (ksig->ka.sa.sa_flags & SA_RESTORER) {
+		return_ip = (unsigned long) ksig->ka.sa.sa_restorer;
 	} else {
 		/* Trampoline - the desired return ip is in the signal return page. */
 		return_ip = cris_signal_return_page + 6;
@@ -345,7 +339,7 @@ setup_rt_frame(int sig, struct k_sigacti
 	}
 
 	if (err)
-		goto give_sigsegv;
+		return -EFAULT;
 
 	/*
 	 * Set up registers for signal handler.
@@ -356,9 +350,9 @@ setup_rt_frame(int sig, struct k_sigacti
 	 * Second argument is (siginfo_t *).
 	 * Third argument is unused.
 	 */
-	regs->erp = (unsigned long) ka->sa.sa_handler;
+	regs->erp = (unsigned long) ksig->ka.sa.sa_handler;
 	regs->srp = return_ip;
-	regs->r10 = sig;
+	regs->r10 = ksig->sig;
 	regs->r11 = (unsigned long) &frame->info;
 	regs->r12 = 0;
 
@@ -366,17 +360,11 @@ setup_rt_frame(int sig, struct k_sigacti
 	wrusp((unsigned long)frame);
 
 	return 0;
-
-give_sigsegv:
-	force_sigsegv(sig, current);
-	return -EFAULT;
 }
 
 /* Invoke a signal handler to, well, handle the signal. */
 static inline void
-handle_signal(int canrestart, unsigned long sig,
-	      siginfo_t *info, struct k_sigaction *ka,
-              struct pt_regs * regs)
+handle_signal(int canrestart, struct ksignal *ksig, struct pt_regs *regs)
 {
 	sigset_t *oldset = sigmask_to_save();
 	int ret;
@@ -404,7 +392,7 @@ handle_signal(int canrestart, unsigned l
                                  * there is no handler, or the handler
                                  * was registered with SA_RESTART.
 				 */
-				if (!(ka->sa.sa_flags & SA_RESTART)) {
+				if (!(ksig->ka.sa.sa_flags & SA_RESTART)) {
 					regs->r10 = -EINTR;
 					break;
 				}
@@ -423,13 +411,12 @@ handle_signal(int canrestart, unsigned l
         }
 
 	/* Set up the stack frame. */
-	if (ka->sa.sa_flags & SA_SIGINFO)
-		ret = setup_rt_frame(sig, ka, info, oldset, regs);
+	if (ksig->ka.sa.sa_flags & SA_SIGINFO)
+		ret = setup_rt_frame(ksig, oldset, regs);
 	else
-		ret = setup_frame(sig, ka, oldset, regs);
+		ret = setup_frame(ksig, oldset, regs);
 
-	if (ret == 0)
-		signal_delivered(sig, info, ka, regs, 0);
+	signal_setup_done(ret, ksig, 0);
 }
 
 /*
@@ -446,9 +433,7 @@ handle_signal(int canrestart, unsigned l
 void
 do_signal(int canrestart, struct pt_regs *regs)
 {
-	int signr;
-	siginfo_t info;
-        struct k_sigaction ka;
+	struct ksignal ksig;
 
 	/*
 	 * The common case should go fast, which is why this point is
@@ -458,11 +443,9 @@ do_signal(int canrestart, struct pt_regs
 	if (!user_mode(regs))
 		return;
 
-	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
-
-	if (signr > 0) {
+	if (get_signal(&ksig)) {
 		/* Whee!  Actually deliver the signal.  */
-		handle_signal(canrestart, signr, &info, &ka, regs);
+		handle_signal(canrestart, &ksig, regs);
 		return;
 	}
 

