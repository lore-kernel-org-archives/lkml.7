Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4F9C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 250C3208CB
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbfD0PVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:21:52 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33832 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727559AbfD0PPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:32 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP32-0000zP-DS; Sat, 27 Apr 2019 16:15:28 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2l-0004XA-04; Sat, 27 Apr 2019 16:15:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Richard Weinberger" <richard@nod.at>,
        "Hans-Christian Egtvedt" <egtvedt@samfundet.no>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.689364218@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 109/202] avr32: Use get_signal() signal_setup_done()
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

commit d809709a8845954a95c2ac86c13bd0dfd549c1ae upstream.

Use the more generic functions get_signal() signal_setup_done()
for signal delivery.

Signed-off-by: Richard Weinberger <richard@nod.at>
Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>
[bwh: Backported to 3.16 as dependency of commit 35634ffa1751
 "signal: Always notice exiting tasks"]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/avr32/kernel/signal.c | 43 ++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 25 deletions(-)

--- a/arch/avr32/kernel/signal.c
+++ b/arch/avr32/kernel/signal.c
@@ -138,13 +138,12 @@ get_sigframe(struct k_sigaction *ka, str
 }
 
 static int
-setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
-	       sigset_t *set, struct pt_regs *regs)
+setup_rt_frame(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs)
 {
 	struct rt_sigframe __user *frame;
 	int err = 0;
 
-	frame = get_sigframe(ka, regs, sizeof(*frame));
+	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame));
 	err = -EFAULT;
 	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
 		goto out;
@@ -164,7 +163,7 @@ setup_rt_frame(int sig, struct k_sigacti
 	err = __put_user(0x3008d733 | (__NR_rt_sigreturn << 20),
 			 &frame->retcode);
 
-	err |= copy_siginfo_to_user(&frame->info, info);
+	err |= copy_siginfo_to_user(&frame->info, &ksig->info);
 
 	/* Set up the ucontext */
 	err |= __put_user(0, &frame->uc.uc_flags);
@@ -176,12 +175,12 @@ setup_rt_frame(int sig, struct k_sigacti
 	if (err)
 		goto out;
 
-	regs->r12 = sig;
+	regs->r12 = ksig->sig;
 	regs->r11 = (unsigned long) &frame->info;
 	regs->r10 = (unsigned long) &frame->uc;
 	regs->sp = (unsigned long) frame;
-	if (ka->sa.sa_flags & SA_RESTORER)
-		regs->lr = (unsigned long)ka->sa.sa_restorer;
+	if (ksig->ka.sa.sa_flags & SA_RESTORER)
+		regs->lr = (unsigned long)ksig->ka.sa.sa_restorer;
 	else {
 		printk(KERN_NOTICE "[%s:%d] did not set SA_RESTORER\n",
 		       current->comm, current->pid);
@@ -189,10 +188,10 @@ setup_rt_frame(int sig, struct k_sigacti
 	}
 
 	pr_debug("SIG deliver [%s:%d]: sig=%d sp=0x%lx pc=0x%lx->0x%p lr=0x%lx\n",
-		 current->comm, current->pid, sig, regs->sp,
-		 regs->pc, ka->sa.sa_handler, regs->lr);
+		 current->comm, current->pid, ksig->sig, regs->sp,
+		 regs->pc, ksig->ka.sa.sa_handler, regs->lr);
 
-	regs->pc = (unsigned long) ka->sa.sa_handler;
+	regs->pc = (unsigned long)ksig->ka.sa.sa_handler;
 
 out:
 	return err;
@@ -208,15 +207,14 @@ static inline void setup_syscall_restart
 }
 
 static inline void
-handle_signal(unsigned long sig, struct k_sigaction *ka, siginfo_t *info,
-	      struct pt_regs *regs, int syscall)
+handle_signal(struct ksignal *ksig, struct pt_regs *regs, int syscall)
 {
 	int ret;
 
 	/*
 	 * Set up the stack frame
 	 */
-	ret = setup_rt_frame(sig, ka, info, sigmask_to_save(), regs);
+	ret = setup_rt_frame(ksig, sigmask_to_save(), regs);
 
 	/*
 	 * Check that the resulting registers are sane
@@ -226,10 +224,7 @@ handle_signal(unsigned long sig, struct
 	/*
 	 * Block the signal if we were successful.
 	 */
-	if (ret != 0)
-		force_sigsegv(sig, current);
-	else
-		signal_delivered(sig, info, ka, regs, 0);
+	signal_setup_done(ret, ksig, 0);
 }
 
 /*
@@ -239,9 +234,7 @@ handle_signal(unsigned long sig, struct
  */
 static void do_signal(struct pt_regs *regs, int syscall)
 {
-	siginfo_t info;
-	int signr;
-	struct k_sigaction ka;
+	struct ksignal ksig;
 
 	/*
 	 * We want the common case to go fast, which is why we may in
@@ -251,18 +244,18 @@ static void do_signal(struct pt_regs *re
 	if (!user_mode(regs))
 		return;
 
-	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
+	get_signal(&ksig);
 	if (syscall) {
 		switch (regs->r12) {
 		case -ERESTART_RESTARTBLOCK:
 		case -ERESTARTNOHAND:
-			if (signr > 0) {
+			if (ksig.sig > 0) {
 				regs->r12 = -EINTR;
 				break;
 			}
 			/* fall through */
 		case -ERESTARTSYS:
-			if (signr > 0 && !(ka.sa.sa_flags & SA_RESTART)) {
+			if (ksig.sig > 0 && !(ksig.ka.sa.sa_flags & SA_RESTART)) {
 				regs->r12 = -EINTR;
 				break;
 			}
@@ -272,13 +265,13 @@ static void do_signal(struct pt_regs *re
 		}
 	}
 
-	if (signr == 0) {
+	if (!ksig.sig) {
 		/* No signal to deliver -- put the saved sigmask back */
 		restore_saved_sigmask();
 		return;
 	}
 
-	handle_signal(signr, &ka, &info, regs, syscall);
+	handle_signal(&ksig, regs, syscall);
 }
 
 asmlinkage void do_notify_resume(struct pt_regs *regs, struct thread_info *ti)

