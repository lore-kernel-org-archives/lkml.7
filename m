Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26021C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7213206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfD0PWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:22:23 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33774 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727543AbfD0PPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:31 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP32-0000zQ-DH; Sat, 27 Apr 2019 16:15:28 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2k-0004X5-VU; Sat, 27 Apr 2019 16:15:10 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Richard Weinberger" <richard@nod.at>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.929310377@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 108/202] arm64: Use get_signal() signal_setup_done()
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

commit 00554fa4f80279db92f82c4f52c8ae72711f173e upstream.

Use the more generic functions get_signal() signal_setup_done()
for signal delivery.

Signed-off-by: Richard Weinberger <richard@nod.at>
[bwh: Backported to 3.16 as dependency of commit 35634ffa1751
 "signal: Always notice exiting tasks"]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/arm64/include/asm/signal32.h | 11 ++++---
 arch/arm64/kernel/signal.c        | 48 +++++++++++++------------------
 arch/arm64/kernel/signal32.c      | 14 ++++-----
 3 files changed, 32 insertions(+), 41 deletions(-)

--- a/arch/arm64/include/asm/signal32.h
+++ b/arch/arm64/include/asm/signal32.h
@@ -24,22 +24,21 @@
 
 extern const compat_ulong_t aarch32_sigret_code[6];
 
-int compat_setup_frame(int usig, struct k_sigaction *ka, sigset_t *set,
+int compat_setup_frame(int usig, struct ksignal *ksig, sigset_t *set,
 		       struct pt_regs *regs);
-int compat_setup_rt_frame(int usig, struct k_sigaction *ka, siginfo_t *info,
-			  sigset_t *set, struct pt_regs *regs);
+int compat_setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
+			  struct pt_regs *regs);
 
 void compat_setup_restart_syscall(struct pt_regs *regs);
 #else
 
-static inline int compat_setup_frame(int usid, struct k_sigaction *ka,
+static inline int compat_setup_frame(int usid, struct ksignal *ksig,
 				     sigset_t *set, struct pt_regs *regs)
 {
 	return -ENOSYS;
 }
 
-static inline int compat_setup_rt_frame(int usig, struct k_sigaction *ka,
-					siginfo_t *info, sigset_t *set,
+static inline int compat_setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
 					struct pt_regs *regs)
 {
 	return -ENOSYS;
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -253,13 +253,13 @@ static void setup_return(struct pt_regs
 	regs->regs[30] = (unsigned long)sigtramp;
 }
 
-static int setup_rt_frame(int usig, struct k_sigaction *ka, siginfo_t *info,
-			  sigset_t *set, struct pt_regs *regs)
+static int setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
+			  struct pt_regs *regs)
 {
 	struct rt_sigframe __user *frame;
 	int err = 0;
 
-	frame = get_sigframe(ka, regs);
+	frame = get_sigframe(&ksig->ka, regs);
 	if (!frame)
 		return 1;
 
@@ -269,9 +269,9 @@ static int setup_rt_frame(int usig, stru
 	err |= __save_altstack(&frame->uc.uc_stack, regs->sp);
 	err |= setup_sigframe(frame, regs, set);
 	if (err == 0) {
-		setup_return(regs, ka, frame, usig);
-		if (ka->sa.sa_flags & SA_SIGINFO) {
-			err |= copy_siginfo_to_user(&frame->info, info);
+		setup_return(regs, &ksig->ka, frame, usig);
+		if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
+			err |= copy_siginfo_to_user(&frame->info, &ksig->info);
 			regs->regs[1] = (unsigned long)&frame->info;
 			regs->regs[2] = (unsigned long)&frame->uc;
 		}
@@ -291,13 +291,12 @@ static void setup_restart_syscall(struct
 /*
  * OK, we're invoking a handler
  */
-static void handle_signal(unsigned long sig, struct k_sigaction *ka,
-			  siginfo_t *info, struct pt_regs *regs)
+static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 {
 	struct thread_info *thread = current_thread_info();
 	struct task_struct *tsk = current;
 	sigset_t *oldset = sigmask_to_save();
-	int usig = sig;
+	int usig = ksig->sig;
 	int ret;
 
 	/*
@@ -310,13 +309,12 @@ static void handle_signal(unsigned long
 	 * Set up the stack frame
 	 */
 	if (is_compat_task()) {
-		if (ka->sa.sa_flags & SA_SIGINFO)
-			ret = compat_setup_rt_frame(usig, ka, info, oldset,
-						    regs);
+		if (ksig->ka.sa.sa_flags & SA_SIGINFO)
+			ret = compat_setup_rt_frame(usig, ksig, oldset, regs);
 		else
-			ret = compat_setup_frame(usig, ka, oldset, regs);
+			ret = compat_setup_frame(usig, ksig, oldset, regs);
 	} else {
-		ret = setup_rt_frame(usig, ka, info, oldset, regs);
+		ret = setup_rt_frame(usig, ksig, oldset, regs);
 	}
 
 	/*
@@ -324,18 +322,14 @@ static void handle_signal(unsigned long
 	 */
 	ret |= !valid_user_regs(&regs->user_regs, current);
 
-	if (ret != 0) {
-		force_sigsegv(sig, tsk);
-		return;
-	}
-
 	/*
 	 * Fast forward the stepping logic so we step into the signal
 	 * handler.
 	 */
-	user_fastforward_single_step(tsk);
+	if (!ret)
+		user_fastforward_single_step(tsk);
 
-	signal_delivered(sig, info, ka, regs, 0);
+	signal_setup_done(ret, ksig, 0);
 }
 
 /*
@@ -350,10 +344,9 @@ static void handle_signal(unsigned long
 static void do_signal(struct pt_regs *regs)
 {
 	unsigned long continue_addr = 0, restart_addr = 0;
-	struct k_sigaction ka;
-	siginfo_t info;
-	int signr, retval = 0;
+	int retval = 0;
 	int syscall = (int)regs->syscallno;
+	struct ksignal ksig;
 
 	/*
 	 * If we were from a system call, check for system call restarting...
@@ -387,8 +380,7 @@ static void do_signal(struct pt_regs *re
 	 * Get the signal to deliver. When running under ptrace, at this point
 	 * the debugger may change all of our registers.
 	 */
-	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
-	if (signr > 0) {
+	if (get_signal(&ksig)) {
 		/*
 		 * Depending on the signal settings, we may need to revert the
 		 * decision to restart the system call, but skip this if a
@@ -398,12 +390,12 @@ static void do_signal(struct pt_regs *re
 		    (retval == -ERESTARTNOHAND ||
 		     retval == -ERESTART_RESTARTBLOCK ||
 		     (retval == -ERESTARTSYS &&
-		      !(ka.sa.sa_flags & SA_RESTART)))) {
+		      !(ksig.ka.sa.sa_flags & SA_RESTART)))) {
 			regs->regs[0] = -EINTR;
 			regs->pc = continue_addr;
 		}
 
-		handle_signal(signr, &ka, &info, regs);
+		handle_signal(&ksig, regs);
 		return;
 	}
 
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -543,18 +543,18 @@ static int compat_setup_sigframe(struct
 /*
  * 32-bit signal handling routines called from signal.c
  */
-int compat_setup_rt_frame(int usig, struct k_sigaction *ka, siginfo_t *info,
+int compat_setup_rt_frame(int usig, struct ksignal *ksig,
 			  sigset_t *set, struct pt_regs *regs)
 {
 	struct compat_rt_sigframe __user *frame;
 	int err = 0;
 
-	frame = compat_get_sigframe(ka, regs, sizeof(*frame));
+	frame = compat_get_sigframe(&ksig->ka, regs, sizeof(*frame));
 
 	if (!frame)
 		return 1;
 
-	err |= copy_siginfo_to_user32(&frame->info, info);
+	err |= copy_siginfo_to_user32(&frame->info, &ksig->info);
 
 	__put_user_error(0, &frame->sig.uc.uc_flags, err);
 	__put_user_error(0, &frame->sig.uc.uc_link, err);
@@ -564,7 +564,7 @@ int compat_setup_rt_frame(int usig, stru
 	err |= compat_setup_sigframe(&frame->sig, regs, set);
 
 	if (err == 0) {
-		compat_setup_return(regs, ka, frame->sig.retcode, frame, usig);
+		compat_setup_return(regs, &ksig->ka, frame->sig.retcode, frame, usig);
 		regs->regs[1] = (compat_ulong_t)(unsigned long)&frame->info;
 		regs->regs[2] = (compat_ulong_t)(unsigned long)&frame->sig.uc;
 	}
@@ -572,13 +572,13 @@ int compat_setup_rt_frame(int usig, stru
 	return err;
 }
 
-int compat_setup_frame(int usig, struct k_sigaction *ka, sigset_t *set,
+int compat_setup_frame(int usig, struct ksignal *ksig, sigset_t *set,
 		       struct pt_regs *regs)
 {
 	struct compat_sigframe __user *frame;
 	int err = 0;
 
-	frame = compat_get_sigframe(ka, regs, sizeof(*frame));
+	frame = compat_get_sigframe(&ksig->ka, regs, sizeof(*frame));
 
 	if (!frame)
 		return 1;
@@ -587,7 +587,7 @@ int compat_setup_frame(int usig, struct
 
 	err |= compat_setup_sigframe(frame, regs, set);
 	if (err == 0)
-		compat_setup_return(regs, ka, frame->retcode, frame, usig);
+		compat_setup_return(regs, &ksig->ka, frame->retcode, frame, usig);
 
 	return err;
 }

