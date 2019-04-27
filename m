Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22511C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA2A6206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbfD0PYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:24:02 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33554 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727498AbfD0PP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:28 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2z-0000zP-Ae; Sat, 27 Apr 2019 16:15:25 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2l-0004Yg-Hh; Sat, 27 Apr 2019 16:15:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Richard Weinberger" <richard@nod.at>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.986158014@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 128/202] sh: Use get_signal() signal_setup_done()
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

commit b46e848768acc458ba94feef162b8901592dbb9c upstream.

Use the more generic functions get_signal() signal_setup_done()
for signal delivery.

Signed-off-by: Richard Weinberger <richard@nod.at>
[bwh: Backported to 3.16 as dependency of commit 35634ffa1751
 "signal: Always notice exiting tasks"]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/sh/kernel/signal_32.c | 79 +++++++++++++++---------------------
 arch/sh/kernel/signal_64.c | 82 +++++++++++++++-----------------------
 2 files changed, 64 insertions(+), 97 deletions(-)

--- a/arch/sh/kernel/signal_32.c
+++ b/arch/sh/kernel/signal_32.c
@@ -262,17 +262,17 @@ get_sigframe(struct k_sigaction *ka, uns
 extern void __kernel_sigreturn(void);
 extern void __kernel_rt_sigreturn(void);
 
-static int setup_frame(int sig, struct k_sigaction *ka,
-			sigset_t *set, struct pt_regs *regs)
+static int setup_frame(struct ksignal *ksig, sigset_t *set,
+		       struct pt_regs *regs)
 {
 	struct sigframe __user *frame;
-	int err = 0;
+	int err = 0, sig = ksig->sig;
 	int signal;
 
-	frame = get_sigframe(ka, regs->regs[15], sizeof(*frame));
+	frame = get_sigframe(&ksig->ka, regs->regs[15], sizeof(*frame));
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
-		goto give_sigsegv;
+		return -EFAULT;
 
 	signal = current_thread_info()->exec_domain
 		&& current_thread_info()->exec_domain->signal_invmap
@@ -288,8 +288,8 @@ static int setup_frame(int sig, struct k
 
 	/* Set up to return from userspace.  If provided, use a stub
 	   already in userspace.  */
-	if (ka->sa.sa_flags & SA_RESTORER) {
-		regs->pr = (unsigned long) ka->sa.sa_restorer;
+	if (ksig->ka.sa.sa_flags & SA_RESTORER) {
+		regs->pr = (unsigned long) ksig->ka.sa.sa_restorer;
 #ifdef CONFIG_VSYSCALL
 	} else if (likely(current->mm->context.vdso)) {
 		regs->pr = VDSO_SYM(&__kernel_sigreturn);
@@ -309,7 +309,7 @@ static int setup_frame(int sig, struct k
 	}
 
 	if (err)
-		goto give_sigsegv;
+		return -EFAULT;
 
 	/* Set up registers for signal handler */
 	regs->regs[15] = (unsigned long) frame;
@@ -319,15 +319,15 @@ static int setup_frame(int sig, struct k
 
 	if (current->personality & FDPIC_FUNCPTRS) {
 		struct fdpic_func_descriptor __user *funcptr =
-			(struct fdpic_func_descriptor __user *)ka->sa.sa_handler;
+			(struct fdpic_func_descriptor __user *)ksig->ka.sa.sa_handler;
 
 		err |= __get_user(regs->pc, &funcptr->text);
 		err |= __get_user(regs->regs[12], &funcptr->GOT);
 	} else
-		regs->pc = (unsigned long)ka->sa.sa_handler;
+		regs->pc = (unsigned long)ksig->ka.sa.sa_handler;
 
 	if (err)
-		goto give_sigsegv;
+		return -EFAULT;
 
 	set_fs(USER_DS);
 
@@ -335,23 +335,19 @@ static int setup_frame(int sig, struct k
 		 current->comm, task_pid_nr(current), frame, regs->pc, regs->pr);
 
 	return 0;
-
-give_sigsegv:
-	force_sigsegv(sig, current);
-	return -EFAULT;
 }
 
-static int setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
-			   sigset_t *set, struct pt_regs *regs)
+static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
+			  struct pt_regs *regs)
 {
 	struct rt_sigframe __user *frame;
-	int err = 0;
+	int err = 0, sig = ksig->sig;
 	int signal;
 
-	frame = get_sigframe(ka, regs->regs[15], sizeof(*frame));
+	frame = get_sigframe(&ksig->ka, regs->regs[15], sizeof(*frame));
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
-		goto give_sigsegv;
+		return -EFAULT;
 
 	signal = current_thread_info()->exec_domain
 		&& current_thread_info()->exec_domain->signal_invmap
@@ -359,7 +355,7 @@ static int setup_rt_frame(int sig, struc
 		? current_thread_info()->exec_domain->signal_invmap[sig]
 		: sig;
 
-	err |= copy_siginfo_to_user(&frame->info, info);
+	err |= copy_siginfo_to_user(&frame->info, &ksig->info);
 
 	/* Create the ucontext.  */
 	err |= __put_user(0, &frame->uc.uc_flags);
@@ -371,8 +367,8 @@ static int setup_rt_frame(int sig, struc
 
 	/* Set up to return from userspace.  If provided, use a stub
 	   already in userspace.  */
-	if (ka->sa.sa_flags & SA_RESTORER) {
-		regs->pr = (unsigned long) ka->sa.sa_restorer;
+	if (ksig->ka.sa.sa_flags & SA_RESTORER) {
+		regs->pr = (unsigned long) ksig->ka.sa.sa_restorer;
 #ifdef CONFIG_VSYSCALL
 	} else if (likely(current->mm->context.vdso)) {
 		regs->pr = VDSO_SYM(&__kernel_rt_sigreturn);
@@ -392,7 +388,7 @@ static int setup_rt_frame(int sig, struc
 	}
 
 	if (err)
-		goto give_sigsegv;
+		return -EFAULT;
 
 	/* Set up registers for signal handler */
 	regs->regs[15] = (unsigned long) frame;
@@ -402,15 +398,15 @@ static int setup_rt_frame(int sig, struc
 
 	if (current->personality & FDPIC_FUNCPTRS) {
 		struct fdpic_func_descriptor __user *funcptr =
-			(struct fdpic_func_descriptor __user *)ka->sa.sa_handler;
+			(struct fdpic_func_descriptor __user *)ksig->ka.sa.sa_handler;
 
 		err |= __get_user(regs->pc, &funcptr->text);
 		err |= __get_user(regs->regs[12], &funcptr->GOT);
 	} else
-		regs->pc = (unsigned long)ka->sa.sa_handler;
+		regs->pc = (unsigned long)ksig->ka.sa.sa_handler;
 
 	if (err)
-		goto give_sigsegv;
+		return -EFAULT;
 
 	set_fs(USER_DS);
 
@@ -418,10 +414,6 @@ static int setup_rt_frame(int sig, struc
 		 current->comm, task_pid_nr(current), frame, regs->pc, regs->pr);
 
 	return 0;
-
-give_sigsegv:
-	force_sigsegv(sig, current);
-	return -EFAULT;
 }
 
 static inline void
@@ -455,22 +447,18 @@ handle_syscall_restart(unsigned long sav
  * OK, we're invoking a handler
  */
 static void
-handle_signal(unsigned long sig, struct k_sigaction *ka, siginfo_t *info,
-	      struct pt_regs *regs, unsigned int save_r0)
+handle_signal(struct ksignal *ksig, struct pt_regs *regs, unsigned int save_r0)
 {
 	sigset_t *oldset = sigmask_to_save();
 	int ret;
 
 	/* Set up the stack frame */
-	if (ka->sa.sa_flags & SA_SIGINFO)
-		ret = setup_rt_frame(sig, ka, info, oldset, regs);
+	if (ksig->ka.sa.sa_flags & SA_SIGINFO)
+		ret = setup_rt_frame(ksig, oldset, regs);
 	else
-		ret = setup_frame(sig, ka, oldset, regs);
+		ret = setup_frame(ksig, oldset, regs);
 
-	if (ret)
-		return;
-	signal_delivered(sig, info, ka, regs,
-			test_thread_flag(TIF_SINGLESTEP));
+	signal_setup_done(ret, ksig, test_thread_flag(TIF_SINGLESTEP));
 }
 
 /*
@@ -484,9 +472,7 @@ handle_signal(unsigned long sig, struct
  */
 static void do_signal(struct pt_regs *regs, unsigned int save_r0)
 {
-	siginfo_t info;
-	int signr;
-	struct k_sigaction ka;
+	struct ksignal ksig;
 
 	/*
 	 * We want the common case to go fast, which
@@ -497,12 +483,11 @@ static void do_signal(struct pt_regs *re
 	if (!user_mode(regs))
 		return;
 
-	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
-	if (signr > 0) {
-		handle_syscall_restart(save_r0, regs, &ka.sa);
+	if (get_signal(&ksig)) {
+		handle_syscall_restart(save_r0, regs, &ksig.ka.sa);
 
 		/* Whee!  Actually deliver the signal.  */
-		handle_signal(signr, &ka, &info, regs, save_r0);
+		handle_signal(&ksig, regs, save_r0);
 		return;
 	}
 
--- a/arch/sh/kernel/signal_64.c
+++ b/arch/sh/kernel/signal_64.c
@@ -41,8 +41,7 @@
 #define DEBUG_SIG 0
 
 static void
-handle_signal(unsigned long sig, siginfo_t *info, struct k_sigaction *ka,
-		struct pt_regs * regs);
+handle_signal(struct ksignal *ksig, struct pt_regs *regs);
 
 static inline void
 handle_syscall_restart(struct pt_regs *regs, struct sigaction *sa)
@@ -82,9 +81,7 @@ handle_syscall_restart(struct pt_regs *r
  */
 static void do_signal(struct pt_regs *regs)
 {
-	siginfo_t info;
-	int signr;
-	struct k_sigaction ka;
+	struct ksignal ksig;
 
 	/*
 	 * We want the common case to go fast, which
@@ -95,12 +92,11 @@ static void do_signal(struct pt_regs *re
 	if (!user_mode(regs))
 		return;
 
-	signr = get_signal_to_deliver(&info, &ka, regs, 0);
-	if (signr > 0) {
-		handle_syscall_restart(regs, &ka.sa);
+	if (get_signal(&ksig)) {
+		handle_syscall_restart(regs, &ksig.ka.sa);
 
 		/* Whee!  Actually deliver the signal.  */
-		handle_signal(signr, &info, &ka, regs);
+		handle_signal(&ksig, regs);
 		return;
 	}
 
@@ -378,17 +374,16 @@ get_sigframe(struct k_sigaction *ka, uns
 void sa_default_restorer(void);		/* See comments below */
 void sa_default_rt_restorer(void);	/* See comments below */
 
-static int setup_frame(int sig, struct k_sigaction *ka,
-		       sigset_t *set, struct pt_regs *regs)
+static int setup_frame(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs)
 {
 	struct sigframe __user *frame;
-	int err = 0;
+	int err = 0, sig = ksig->sig;
 	int signal;
 
-	frame = get_sigframe(ka, regs->regs[REG_SP], sizeof(*frame));
+	frame = get_sigframe(&ksig->ka, regs->regs[REG_SP], sizeof(*frame));
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
-		goto give_sigsegv;
+		return -EFAULT;
 
 	signal = current_thread_info()->exec_domain
 		&& current_thread_info()->exec_domain->signal_invmap
@@ -400,7 +395,7 @@ static int setup_frame(int sig, struct k
 
 	/* Give up earlier as i386, in case */
 	if (err)
-		goto give_sigsegv;
+		return -EFAULT;
 
 	if (_NSIG_WORDS > 1) {
 		err |= __copy_to_user(frame->extramask, &set->sig[1],
@@ -408,16 +403,16 @@ static int setup_frame(int sig, struct k
 
 	/* Give up earlier as i386, in case */
 	if (err)
-		goto give_sigsegv;
+		return -EFAULT;
 
 	/* Set up to return from userspace.  If provided, use a stub
 	   already in userspace.  */
-	if (ka->sa.sa_flags & SA_RESTORER) {
+	if (ksig->ka.sa.sa_flags & SA_RESTORER) {
 		/*
 		 * On SH5 all edited pointers are subject to NEFF
 		 */
 		DEREF_REG_PR = neff_sign_extend((unsigned long)
-			ka->sa.sa_restorer | 0x1);
+			ksig->ka->sa.sa_restorer | 0x1);
 	} else {
 		/*
 		 * Different approach on SH5.
@@ -435,7 +430,7 @@ static int setup_frame(int sig, struct k
 
 		if (__copy_to_user(frame->retcode,
 			(void *)((unsigned long)sa_default_restorer & (~1)), 16) != 0)
-			goto give_sigsegv;
+			return -EFAULT;
 
 		/* Cohere the trampoline with the I-cache. */
 		flush_cache_sigtramp(DEREF_REG_PR-1);
@@ -460,7 +455,7 @@ static int setup_frame(int sig, struct k
 	regs->regs[REG_ARG2] = (unsigned long long)(unsigned long)(signed long)&frame->sc;
 	regs->regs[REG_ARG3] = (unsigned long long)(unsigned long)(signed long)&frame->sc;
 
-	regs->pc = neff_sign_extend((unsigned long)ka->sa.sa_handler);
+	regs->pc = neff_sign_extend((unsigned long)ksig->ka.sa.sa_handler);
 
 	set_fs(USER_DS);
 
@@ -471,23 +466,19 @@ static int setup_frame(int sig, struct k
 		 DEREF_REG_PR >> 32, DEREF_REG_PR & 0xffffffff);
 
 	return 0;
-
-give_sigsegv:
-	force_sigsegv(sig, current);
-	return -EFAULT;
 }
 
-static int setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
-			  sigset_t *set, struct pt_regs *regs)
+static int setup_rt_frame(struct ksignal *kig, sigset_t *set,
+			  struct pt_regs *regs)
 {
 	struct rt_sigframe __user *frame;
-	int err = 0;
+	int err = 0, sig = ksig->sig;
 	int signal;
 
-	frame = get_sigframe(ka, regs->regs[REG_SP], sizeof(*frame));
+	frame = get_sigframe(&ksig->ka, regs->regs[REG_SP], sizeof(*frame));
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
-		goto give_sigsegv;
+		return -EFAULT;
 
 	signal = current_thread_info()->exec_domain
 		&& current_thread_info()->exec_domain->signal_invmap
@@ -497,11 +488,11 @@ static int setup_rt_frame(int sig, struc
 
 	err |= __put_user(&frame->info, &frame->pinfo);
 	err |= __put_user(&frame->uc, &frame->puc);
-	err |= copy_siginfo_to_user(&frame->info, info);
+	err |= copy_siginfo_to_user(&frame->info, &ksig->info);
 
 	/* Give up earlier as i386, in case */
 	if (err)
-		goto give_sigsegv;
+		return -EFAULT;
 
 	/* Create the ucontext.  */
 	err |= __put_user(0, &frame->uc.uc_flags);
@@ -513,16 +504,16 @@ static int setup_rt_frame(int sig, struc
 
 	/* Give up earlier as i386, in case */
 	if (err)
-		goto give_sigsegv;
+		return -EFAULT;
 
 	/* Set up to return from userspace.  If provided, use a stub
 	   already in userspace.  */
-	if (ka->sa.sa_flags & SA_RESTORER) {
+	if (ksig->ka.sa.sa_flags & SA_RESTORER) {
 		/*
 		 * On SH5 all edited pointers are subject to NEFF
 		 */
 		DEREF_REG_PR = neff_sign_extend((unsigned long)
-			ka->sa.sa_restorer | 0x1);
+			ksig->ka.sa.sa_restorer | 0x1);
 	} else {
 		/*
 		 * Different approach on SH5.
@@ -540,7 +531,7 @@ static int setup_rt_frame(int sig, struc
 
 		if (__copy_to_user(frame->retcode,
 			(void *)((unsigned long)sa_default_rt_restorer & (~1)), 16) != 0)
-			goto give_sigsegv;
+			return -EFAULT;
 
 		/* Cohere the trampoline with the I-cache. */
 		flush_icache_range(DEREF_REG_PR-1, DEREF_REG_PR-1+15);
@@ -554,7 +545,7 @@ static int setup_rt_frame(int sig, struc
 	regs->regs[REG_ARG1] = signal; /* Arg for signal handler */
 	regs->regs[REG_ARG2] = (unsigned long long)(unsigned long)(signed long)&frame->info;
 	regs->regs[REG_ARG3] = (unsigned long long)(unsigned long)(signed long)&frame->uc.uc_mcontext;
-	regs->pc = neff_sign_extend((unsigned long)ka->sa.sa_handler);
+	regs->pc = neff_sign_extend((unsigned long)ksig->ka.sa.sa_handler);
 
 	set_fs(USER_DS);
 
@@ -564,33 +555,24 @@ static int setup_rt_frame(int sig, struc
 		 DEREF_REG_PR >> 32, DEREF_REG_PR & 0xffffffff);
 
 	return 0;
-
-give_sigsegv:
-	force_sigsegv(sig, current);
-	return -EFAULT;
 }
 
 /*
  * OK, we're invoking a handler
  */
 static void
-handle_signal(unsigned long sig, siginfo_t *info, struct k_sigaction *ka,
-		struct pt_regs * regs)
+handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 {
 	sigset_t *oldset = sigmask_to_save();
 	int ret;
 
 	/* Set up the stack frame */
-	if (ka->sa.sa_flags & SA_SIGINFO)
-		ret = setup_rt_frame(sig, ka, info, oldset, regs);
+	if (ksig->ka.sa.sa_flags & SA_SIGINFO)
+		ret = setup_rt_frame(ksig, oldset, regs);
 	else
-		ret = setup_frame(sig, ka, oldset, regs);
-
-	if (ret)
-		return;
+		ret = setup_frame(ksig, oldset, regs);
 
-	signal_delivered(sig, info, ka, regs,
-			test_thread_flag(TIF_SINGLESTEP));
+	signal_setup_done(ret, ksig, test_thread_flag(TIF_SINGLESTEP));
 }
 
 asmlinkage void do_notify_resume(struct pt_regs *regs, unsigned long thread_info_flags)

