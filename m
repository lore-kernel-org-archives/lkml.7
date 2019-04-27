Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C4CC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A2F206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbfD0PVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:21:49 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33830 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727561AbfD0PPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:32 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP32-0000zA-E2; Sat, 27 Apr 2019 16:15:28 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2l-0004Xj-5G; Sat, 27 Apr 2019 16:15:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Richard Weinberger" <richard@nod.at>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.692076263@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 116/202] m32r: Use get_signal() signal_setup_done()
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

commit 0f5bef660a7c3b030eb60ceb29e3b2d89f894f56 upstream.

Use the more generic functions get_signal() signal_setup_done()
for signal delivery.

Signed-off-by: Richard Weinberger <richard@nod.at>
[bwh: Backported to 3.16 as dependency of commit 35634ffa1751
 "signal: Always notice exiting tasks"]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/m32r/kernel/signal.c | 47 +++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 27 deletions(-)

--- a/arch/m32r/kernel/signal.c
+++ b/arch/m32r/kernel/signal.c
@@ -173,17 +173,17 @@ get_sigframe(struct k_sigaction *ka, uns
 	return (void __user *)((sp - frame_size) & -8ul);
 }
 
-static int setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
-			   sigset_t *set, struct pt_regs *regs)
+static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
+			  struct pt_regs *regs)
 {
 	struct rt_sigframe __user *frame;
 	int err = 0;
-	int signal;
+	int signal, sig = ksig->sig;
 
-	frame = get_sigframe(ka, regs->spu, sizeof(*frame));
+	frame = get_sigframe(&ksig->ka, regs->spu, sizeof(*frame));
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
-		goto give_sigsegv;
+		return -EFAULT;
 
 	signal = current_thread_info()->exec_domain
 		&& current_thread_info()->exec_domain->signal_invmap
@@ -193,13 +193,13 @@ static int setup_rt_frame(int sig, struc
 
 	err |= __put_user(signal, &frame->sig);
 	if (err)
-		goto give_sigsegv;
+		return -EFAULT;
 
 	err |= __put_user(&frame->info, &frame->pinfo);
 	err |= __put_user(&frame->uc, &frame->puc);
-	err |= copy_siginfo_to_user(&frame->info, info);
+	err |= copy_siginfo_to_user(&frame->info, &ksig->info);
 	if (err)
-		goto give_sigsegv;
+		return -EFAULT;
 
 	/* Create the ucontext.  */
 	err |= __put_user(0, &frame->uc.uc_flags);
@@ -208,17 +208,17 @@ static int setup_rt_frame(int sig, struc
 	err |= setup_sigcontext(&frame->uc.uc_mcontext, regs, set->sig[0]);
 	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
 	if (err)
-		goto give_sigsegv;
+		return -EFAULT;
 
 	/* Set up to return from userspace.  */
-	regs->lr = (unsigned long)ka->sa.sa_restorer;
+	regs->lr = (unsigned long)ksig->ka.sa.sa_restorer;
 
 	/* Set up registers for signal handler */
 	regs->spu = (unsigned long)frame;
 	regs->r0 = signal;	/* Arg for signal handler */
 	regs->r1 = (unsigned long)&frame->info;
 	regs->r2 = (unsigned long)&frame->uc;
-	regs->bpc = (unsigned long)ka->sa.sa_handler;
+	regs->bpc = (unsigned long)ksig->ka.sa.sa_handler;
 
 	set_fs(USER_DS);
 
@@ -228,10 +228,6 @@ static int setup_rt_frame(int sig, struc
 #endif
 
 	return 0;
-
-give_sigsegv:
-	force_sigsegv(sig, current);
-	return -EFAULT;
 }
 
 static int prev_insn(struct pt_regs *regs)
@@ -252,9 +248,10 @@ static int prev_insn(struct pt_regs *reg
  */
 
 static void
-handle_signal(unsigned long sig, struct k_sigaction *ka, siginfo_t *info,
-	      struct pt_regs *regs)
+handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 {
+	int ret;
+
 	/* Are we from a system call? */
 	if (regs->syscall_nr >= 0) {
 		/* If so, check system call restarting.. */
@@ -265,7 +262,7 @@ handle_signal(unsigned long sig, struct
 				break;
 
 			case -ERESTARTSYS:
-				if (!(ka->sa.sa_flags & SA_RESTART)) {
+				if (!(ksig->ka.sa.sa_flags & SA_RESTART)) {
 					regs->r0 = -EINTR;
 					break;
 				}
@@ -278,10 +275,9 @@ handle_signal(unsigned long sig, struct
 	}
 
 	/* Set up the stack frame */
-	if (setup_rt_frame(sig, ka, info, sigmask_to_save(), regs))
-		return;
+	ret = setup_rt_frame(ksig, sigmask_to_save(), regs);
 
-	signal_delivered(sig, info, ka, regs, 0);
+	signal_setup_done(ret, ksig, 0);
 }
 
 /*
@@ -291,9 +287,7 @@ handle_signal(unsigned long sig, struct
  */
 static void do_signal(struct pt_regs *regs)
 {
-	siginfo_t info;
-	int signr;
-	struct k_sigaction ka;
+	struct ksignal ksig;
 
 	/*
 	 * We want the common case to go fast, which
@@ -304,8 +298,7 @@ static void do_signal(struct pt_regs *re
 	if (!user_mode(regs))
 		return;
 
-	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
-	if (signr > 0) {
+	if (get_signal(&ksig)) {
 		/* Re-enable any watchpoints before delivering the
 		 * signal to user space. The processor register will
 		 * have been cleared if the watchpoint triggered
@@ -313,7 +306,7 @@ static void do_signal(struct pt_regs *re
 		 */
 
 		/* Whee!  Actually deliver the signal.  */
-		handle_signal(signr, &ka, &info, regs);
+		handle_signal(&ksig, regs);
 
 		return;
 	}

