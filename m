Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9360C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA2C1206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbfD0PQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:16:06 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33562 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727499AbfD0PP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:28 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2z-0000zG-6E; Sat, 27 Apr 2019 16:15:25 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2l-0004Ym-IU; Sat, 27 Apr 2019 16:15:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Chris Metcalf" <cmetcalf@tilera.com>,
        "Richard Weinberger" <richard@nod.at>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.528038469@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 129/202] tile: Use get_signal() signal_setup_done()
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

commit b3707c7ed013d36752272ca2f9ed20dc8aed92e4 upstream.

Use the more generic functions get_signal() signal_setup_done()
for signal delivery.

Signed-off-by: Richard Weinberger <richard@nod.at>
Acked-by: Chris Metcalf <cmetcalf@tilera.com>
[bwh: Backported to 3.16 as dependency of commit 35634ffa1751
 "signal: Always notice exiting tasks"]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/tile/include/asm/compat.h   |  3 +-
 arch/tile/kernel/compat_signal.c | 29 ++++++++---------
 arch/tile/kernel/signal.c        | 54 ++++++++++++++------------------
 3 files changed, 40 insertions(+), 46 deletions(-)

--- a/arch/tile/include/asm/compat.h
+++ b/arch/tile/include/asm/compat.h
@@ -267,8 +267,7 @@ static inline int is_compat_task(void)
 	return current_thread_info()->status & TS_COMPAT;
 }
 
-extern int compat_setup_rt_frame(int sig, struct k_sigaction *ka,
-				 siginfo_t *info, sigset_t *set,
+extern int compat_setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 				 struct pt_regs *regs);
 
 /* Compat syscalls. */
--- a/arch/tile/kernel/compat_signal.c
+++ b/arch/tile/kernel/compat_signal.c
@@ -190,18 +190,18 @@ static inline void __user *compat_get_si
 	return (void __user *) sp;
 }
 
-int compat_setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
-			  sigset_t *set, struct pt_regs *regs)
+int compat_setup_rt_frame(struct ksignal *ksig, sigset_t *set,
+			  struct pt_regs *regs)
 {
 	unsigned long restorer;
 	struct compat_rt_sigframe __user *frame;
-	int err = 0;
+	int err = 0, sig = ksig->sig;
 	int usig;
 
-	frame = compat_get_sigframe(ka, regs, sizeof(*frame));
+	frame = compat_get_sigframe(&ksig->ka, regs, sizeof(*frame));
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
-		goto give_sigsegv;
+		goto err;
 
 	usig = current_thread_info()->exec_domain
 		&& current_thread_info()->exec_domain->signal_invmap
@@ -210,12 +210,12 @@ int compat_setup_rt_frame(int sig, struc
 		: sig;
 
 	/* Always write at least the signal number for the stack backtracer. */
-	if (ka->sa.sa_flags & SA_SIGINFO) {
+	if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
 		/* At sigreturn time, restore the callee-save registers too. */
-		err |= copy_siginfo_to_user32(&frame->info, info);
+		err |= copy_siginfo_to_user32(&frame->info, &ksig->info);
 		regs->flags |= PT_FLAGS_RESTORE_REGS;
 	} else {
-		err |= __put_user(info->si_signo, &frame->info.si_signo);
+		err |= __put_user(ksig->info.si_signo, &frame->info.si_signo);
 	}
 
 	/* Create the ucontext.  */
@@ -226,11 +226,11 @@ int compat_setup_rt_frame(int sig, struc
 	err |= setup_sigcontext(&frame->uc.uc_mcontext, regs);
 	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
 	if (err)
-		goto give_sigsegv;
+		goto err;
 
 	restorer = VDSO_SYM(&__vdso_rt_sigreturn);
-	if (ka->sa.sa_flags & SA_RESTORER)
-		restorer = ptr_to_compat_reg(ka->sa.sa_restorer);
+	if (ksig->ka.sa.sa_flags & SA_RESTORER)
+		restorer = ptr_to_compat_reg(ksig->ka.sa.sa_restorer);
 
 	/*
 	 * Set up registers for signal handler.
@@ -239,7 +239,7 @@ int compat_setup_rt_frame(int sig, struc
 	 * We always pass siginfo and mcontext, regardless of SA_SIGINFO,
 	 * since some things rely on this (e.g. glibc's debug/segfault.c).
 	 */
-	regs->pc = ptr_to_compat_reg(ka->sa.sa_handler);
+	regs->pc = ptr_to_compat_reg(ksig->ka.sa.sa_handler);
 	regs->ex1 = PL_ICS_EX1(USER_PL, 1); /* set crit sec in handler */
 	regs->sp = ptr_to_compat_reg(frame);
 	regs->lr = restorer;
@@ -249,7 +249,8 @@ int compat_setup_rt_frame(int sig, struc
 	regs->flags |= PT_FLAGS_CALLER_SAVES;
 	return 0;
 
-give_sigsegv:
-	signal_fault("bad setup frame", regs, frame, sig);
+err:
+	trace_unhandled_signal("bad sigreturn frame", regs,
+			      (unsigned long)frame, SIGSEGV);
 	return -EFAULT;
 }
--- a/arch/tile/kernel/signal.c
+++ b/arch/tile/kernel/signal.c
@@ -153,18 +153,18 @@ static inline void __user *get_sigframe(
 	return (void __user *) sp;
 }
 
-static int setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
-			   sigset_t *set, struct pt_regs *regs)
+static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
+			  struct pt_regs *regs)
 {
 	unsigned long restorer;
 	struct rt_sigframe __user *frame;
-	int err = 0;
+	int err = 0, sig = ksig->sig;
 	int usig;
 
-	frame = get_sigframe(ka, regs, sizeof(*frame));
+	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame));
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
-		goto give_sigsegv;
+		goto err;
 
 	usig = current_thread_info()->exec_domain
 		&& current_thread_info()->exec_domain->signal_invmap
@@ -173,12 +173,12 @@ static int setup_rt_frame(int sig, struc
 		: sig;
 
 	/* Always write at least the signal number for the stack backtracer. */
-	if (ka->sa.sa_flags & SA_SIGINFO) {
+	if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
 		/* At sigreturn time, restore the callee-save registers too. */
-		err |= copy_siginfo_to_user(&frame->info, info);
+		err |= copy_siginfo_to_user(&frame->info, &ksig->info);
 		regs->flags |= PT_FLAGS_RESTORE_REGS;
 	} else {
-		err |= __put_user(info->si_signo, &frame->info.si_signo);
+		err |= __put_user(ksig->info.si_signo, &frame->info.si_signo);
 	}
 
 	/* Create the ucontext.  */
@@ -189,11 +189,11 @@ static int setup_rt_frame(int sig, struc
 	err |= setup_sigcontext(&frame->uc.uc_mcontext, regs);
 	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
 	if (err)
-		goto give_sigsegv;
+		goto err;
 
 	restorer = VDSO_SYM(&__vdso_rt_sigreturn);
-	if (ka->sa.sa_flags & SA_RESTORER)
-		restorer = (unsigned long) ka->sa.sa_restorer;
+	if (ksig->ka.sa.sa_flags & SA_RESTORER)
+		restorer = (unsigned long) ksig->ka.sa.sa_restorer;
 
 	/*
 	 * Set up registers for signal handler.
@@ -202,7 +202,7 @@ static int setup_rt_frame(int sig, struc
 	 * We always pass siginfo and mcontext, regardless of SA_SIGINFO,
 	 * since some things rely on this (e.g. glibc's debug/segfault.c).
 	 */
-	regs->pc = (unsigned long) ka->sa.sa_handler;
+	regs->pc = (unsigned long) ksig->ka.sa.sa_handler;
 	regs->ex1 = PL_ICS_EX1(USER_PL, 1); /* set crit sec in handler */
 	regs->sp = (unsigned long) frame;
 	regs->lr = restorer;
@@ -212,8 +212,9 @@ static int setup_rt_frame(int sig, struc
 	regs->flags |= PT_FLAGS_CALLER_SAVES;
 	return 0;
 
-give_sigsegv:
-	signal_fault("bad setup frame", regs, frame, sig);
+err:
+	trace_unhandled_signal("bad sigreturn frame", regs,
+			      (unsigned long)frame, SIGSEGV);
 	return -EFAULT;
 }
 
@@ -221,9 +222,7 @@ give_sigsegv:
  * OK, we're invoking a handler
  */
 
-static void handle_signal(unsigned long sig, siginfo_t *info,
-			 struct k_sigaction *ka,
-			 struct pt_regs *regs)
+static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 {
 	sigset_t *oldset = sigmask_to_save();
 	int ret;
@@ -238,7 +237,7 @@ static void handle_signal(unsigned long
 			break;
 
 		case -ERESTARTSYS:
-			if (!(ka->sa.sa_flags & SA_RESTART)) {
+			if (!(ksig->ka.sa.sa_flags & SA_RESTART)) {
 				regs->regs[0] = -EINTR;
 				break;
 			}
@@ -254,14 +253,12 @@ static void handle_signal(unsigned long
 	/* Set up the stack frame */
 #ifdef CONFIG_COMPAT
 	if (is_compat_task())
-		ret = compat_setup_rt_frame(sig, ka, info, oldset, regs);
+		ret = compat_setup_rt_frame(ksig, oldset, regs);
 	else
 #endif
-		ret = setup_rt_frame(sig, ka, info, oldset, regs);
-	if (ret)
-		return;
-	signal_delivered(sig, info, ka, regs,
-			test_thread_flag(TIF_SINGLESTEP));
+		ret = setup_rt_frame(ksig, oldset, regs);
+
+	signal_setup_done(ret, ksig, test_thread_flag(TIF_SINGLESTEP));
 }
 
 /*
@@ -271,9 +268,7 @@ static void handle_signal(unsigned long
  */
 void do_signal(struct pt_regs *regs)
 {
-	siginfo_t info;
-	int signr;
-	struct k_sigaction ka;
+	struct ksignal ksig;
 
 	/*
 	 * i386 will check if we're coming from kernel mode and bail out
@@ -282,10 +277,9 @@ void do_signal(struct pt_regs *regs)
 	 * helpful, we can reinstate the check on "!user_mode(regs)".
 	 */
 
-	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
-	if (signr > 0) {
+	if (get_signal(&ksig)) {
 		/* Whee! Actually deliver the signal.  */
-		handle_signal(signr, &info, &ka, regs);
+		handle_signal(&ksig, regs);
 		goto done;
 	}
 

