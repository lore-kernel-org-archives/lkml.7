Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB2FC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E048206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbfD0PXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:23:31 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33608 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727505AbfD0PP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:29 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2z-00014L-AN; Sat, 27 Apr 2019 16:15:25 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2l-0004YX-GC; Sat, 27 Apr 2019 16:15:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Richard Weinberger" <richard@nod.at>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.743612148@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 126/202] s390: Use get_signal() signal_setup_done()
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

commit 067bf2d4d3a7aedc5982f6a58716054e5004b801 upstream.

Use the more generic functions get_signal() signal_setup_done()
for signal delivery.

Signed-off-by: Richard Weinberger <richard@nod.at>
[bwh: Backported to 3.16 as dependency of commit 35634ffa1751
 "signal: Always notice exiting tasks"]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/s390/kernel/compat_signal.c | 79 ++++++++++++++------------------
 arch/s390/kernel/entry.h         |  4 +-
 arch/s390/kernel/signal.c        | 78 +++++++++++++------------------
 3 files changed, 69 insertions(+), 92 deletions(-)

--- a/arch/s390/kernel/compat_signal.c
+++ b/arch/s390/kernel/compat_signal.c
@@ -320,38 +320,39 @@ static inline int map_signal(int sig)
 		return sig;
 }
 
-static int setup_frame32(int sig, struct k_sigaction *ka,
-			sigset_t *set, struct pt_regs * regs)
+static int setup_frame32(struct ksignal *ksig, sigset_t *set,
+			 struct pt_regs *regs)
 {
-	sigframe32 __user *frame = get_sigframe(ka, regs, sizeof(sigframe32));
+	int sig = ksig->sig;
+	sigframe32 __user *frame = get_sigframe(&ksig->ka, regs, sizeof(sigframe32));
 
 	if (frame == (void __user *) -1UL)
-		goto give_sigsegv;
+		return -EFAULT;
 
 	if (__copy_to_user(&frame->sc.oldmask, &set->sig, _SIGMASK_COPY_SIZE32))
-		goto give_sigsegv;
+		return -EFAULT;
 
 	if (save_sigregs32(regs, &frame->sregs))
-		goto give_sigsegv;
+		return -EFAULT;
 	if (save_sigregs_gprs_high(regs, frame->gprs_high))
-		goto give_sigsegv;
+		return -EFAULT;
 	if (__put_user((unsigned long) &frame->sregs, &frame->sc.sregs))
-		goto give_sigsegv;
+		return -EFAULT;
 
 	/* Set up to return from userspace.  If provided, use a stub
 	   already in userspace.  */
-	if (ka->sa.sa_flags & SA_RESTORER) {
-		regs->gprs[14] = (__u64 __force) ka->sa.sa_restorer | PSW32_ADDR_AMODE;
+	if (ksig->ka.sa.sa_flags & SA_RESTORER) {
+		regs->gprs[14] = (__u64 __force) ksig->ka.sa.sa_restorer | PSW32_ADDR_AMODE;
 	} else {
 		regs->gprs[14] = (__u64 __force) frame->retcode | PSW32_ADDR_AMODE;
 		if (__put_user(S390_SYSCALL_OPCODE | __NR_sigreturn,
 			       (u16 __force __user *)(frame->retcode)))
-			goto give_sigsegv;
+			return -EFAULT;
         }
 
 	/* Set up backchain. */
 	if (__put_user(regs->gprs[15], (unsigned int __user *) frame))
-		goto give_sigsegv;
+		return -EFAULT;
 
 	/* Set up registers for signal handler */
 	regs->gprs[15] = (__force __u64) frame;
@@ -359,7 +360,7 @@ static int setup_frame32(int sig, struct
 	regs->psw.mask = PSW_MASK_BA |
 		(PSW_USER_BITS & PSW_MASK_ASC) |
 		(regs->psw.mask & ~PSW_MASK_ASC);
-	regs->psw.addr = (__force __u64) ka->sa.sa_handler;
+	regs->psw.addr = (__force __u64) ksig->ka.sa.sa_handler;
 
 	regs->gprs[2] = map_signal(sig);
 	regs->gprs[3] = (__force __u64) &frame->sc;
@@ -376,25 +377,21 @@ static int setup_frame32(int sig, struct
 
 	/* Place signal number on stack to allow backtrace from handler.  */
 	if (__put_user(regs->gprs[2], (int __force __user *) &frame->signo))
-		goto give_sigsegv;
+		return -EFAULT;
 	return 0;
-
-give_sigsegv:
-	force_sigsegv(sig, current);
-	return -EFAULT;
 }
 
-static int setup_rt_frame32(int sig, struct k_sigaction *ka, siginfo_t *info,
-			   sigset_t *set, struct pt_regs * regs)
+static int setup_rt_frame32(struct ksignal *ksig, sigset_t *set,
+			    struct pt_regs *regs)
 {
 	int err = 0;
-	rt_sigframe32 __user *frame = get_sigframe(ka, regs, sizeof(rt_sigframe32));
+	rt_sigframe32 __user *frame = get_sigframe(&ksig->ka, regs, sizeof(rt_sigframe32));
 
 	if (frame == (void __user *) -1UL)
-		goto give_sigsegv;
+		return -EFAULT;
 
-	if (copy_siginfo_to_user32(&frame->info, info))
-		goto give_sigsegv;
+	if (copy_siginfo_to_user32(&frame->info, &ksig->info))
+		return -EFAULT;
 
 	/* Create the ucontext.  */
 	err |= __put_user(UC_EXTENDED, &frame->uc.uc_flags);
@@ -404,22 +401,22 @@ static int setup_rt_frame32(int sig, str
 	err |= save_sigregs_gprs_high(regs, frame->gprs_high);
 	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
 	if (err)
-		goto give_sigsegv;
+		return -EFAULT;
 
 	/* Set up to return from userspace.  If provided, use a stub
 	   already in userspace.  */
-	if (ka->sa.sa_flags & SA_RESTORER) {
-		regs->gprs[14] = (__u64 __force) ka->sa.sa_restorer | PSW32_ADDR_AMODE;
+	if (ksig->ka.sa.sa_flags & SA_RESTORER) {
+		regs->gprs[14] = (__u64 __force) ksig->ka.sa.sa_restorer | PSW32_ADDR_AMODE;
 	} else {
 		regs->gprs[14] = (__u64 __force) frame->retcode | PSW32_ADDR_AMODE;
 		if (__put_user(S390_SYSCALL_OPCODE | __NR_rt_sigreturn,
 			       (u16 __force __user *)(frame->retcode)))
-			goto give_sigsegv;
+			return -EFAULT;
 	}
 
 	/* Set up backchain. */
 	if (__put_user(regs->gprs[15], (unsigned int __force __user *) frame))
-		goto give_sigsegv;
+		return -EFAULT;
 
 	/* Set up registers for signal handler */
 	regs->gprs[15] = (__force __u64) frame;
@@ -427,36 +424,30 @@ static int setup_rt_frame32(int sig, str
 	regs->psw.mask = PSW_MASK_BA |
 		(PSW_USER_BITS & PSW_MASK_ASC) |
 		(regs->psw.mask & ~PSW_MASK_ASC);
-	regs->psw.addr = (__u64 __force) ka->sa.sa_handler;
+	regs->psw.addr = (__u64 __force) ksig->ka.sa.sa_handler;
 
-	regs->gprs[2] = map_signal(sig);
+	regs->gprs[2] = map_signal(ksig->sig);
 	regs->gprs[3] = (__force __u64) &frame->info;
 	regs->gprs[4] = (__force __u64) &frame->uc;
 	regs->gprs[5] = task_thread_info(current)->last_break;
 	return 0;
-
-give_sigsegv:
-	force_sigsegv(sig, current);
-	return -EFAULT;
 }
 
 /*
  * OK, we're invoking a handler
  */	
 
-void handle_signal32(unsigned long sig, struct k_sigaction *ka,
-		    siginfo_t *info, sigset_t *oldset, struct pt_regs *regs)
+void handle_signal32(struct ksignal *ksig, sigset_t *oldset,
+		     struct pt_regs *regs)
 {
 	int ret;
 
 	/* Set up the stack frame */
-	if (ka->sa.sa_flags & SA_SIGINFO)
-		ret = setup_rt_frame32(sig, ka, info, oldset, regs);
+	if (ksig->ka.sa.sa_flags & SA_SIGINFO)
+		ret = setup_rt_frame32(ksig, oldset, regs);
 	else
-		ret = setup_frame32(sig, ka, oldset, regs);
-	if (ret)
-		return;
-	signal_delivered(sig, info, ka, regs,
-				 test_thread_flag(TIF_SINGLE_STEP));
+		ret = setup_frame32(ksig, oldset, regs);
+
+	signal_setup_done(ret, ksig, test_thread_flag(TIF_SINGLE_STEP));
 }
 
--- a/arch/s390/kernel/entry.h
+++ b/arch/s390/kernel/entry.h
@@ -48,8 +48,8 @@ void do_per_trap(struct pt_regs *regs);
 void syscall_trace(struct pt_regs *regs, int entryexit);
 void kernel_stack_overflow(struct pt_regs * regs);
 void do_signal(struct pt_regs *regs);
-void handle_signal32(unsigned long sig, struct k_sigaction *ka,
-		    siginfo_t *info, sigset_t *oldset, struct pt_regs *regs);
+void handle_signal32(struct ksignal *ksig, sigset_t *oldset,
+		     struct pt_regs *regs);
 void do_notify_resume(struct pt_regs *regs);
 
 void __init init_IRQ(void);
--- a/arch/s390/kernel/signal.c
+++ b/arch/s390/kernel/signal.c
@@ -200,15 +200,15 @@ static int setup_frame(int sig, struct k
 	frame = get_sigframe(ka, regs, sizeof(sigframe));
 
 	if (frame == (void __user *) -1UL)
-		goto give_sigsegv;
+		return -EFAULT;
 
 	if (__copy_to_user(&frame->sc.oldmask, &set->sig, _SIGMASK_COPY_SIZE))
-		goto give_sigsegv;
+		return -EFAULT;
 
 	if (save_sigregs(regs, &frame->sregs))
-		goto give_sigsegv;
+		return -EFAULT;
 	if (__put_user(&frame->sregs, &frame->sc.sregs))
-		goto give_sigsegv;
+		return -EFAULT;
 
 	/* Set up to return from userspace.  If provided, use a stub
 	   already in userspace.  */
@@ -220,12 +220,12 @@ static int setup_frame(int sig, struct k
 			frame->retcode | PSW_ADDR_AMODE;
 		if (__put_user(S390_SYSCALL_OPCODE | __NR_sigreturn,
 	                       (u16 __user *)(frame->retcode)))
-			goto give_sigsegv;
+			return -EFAULT;
 	}
 
 	/* Set up backchain. */
 	if (__put_user(regs->gprs[15], (addr_t __user *) frame))
-		goto give_sigsegv;
+		return -EFAULT;
 
 	/* Set up registers for signal handler */
 	regs->gprs[15] = (unsigned long) frame;
@@ -250,27 +250,23 @@ static int setup_frame(int sig, struct k
 
 	/* Place signal number on stack to allow backtrace from handler.  */
 	if (__put_user(regs->gprs[2], (int __user *) &frame->signo))
-		goto give_sigsegv;
+		return -EFAULT;
 	return 0;
-
-give_sigsegv:
-	force_sigsegv(sig, current);
-	return -EFAULT;
 }
 
-static int setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
-			   sigset_t *set, struct pt_regs * regs)
+static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
+			  struct pt_regs *regs)
 {
 	int err = 0;
 	rt_sigframe __user *frame;
 
-	frame = get_sigframe(ka, regs, sizeof(rt_sigframe));
+	frame = get_sigframe(&ksig->ka, regs, sizeof(rt_sigframe));
 
 	if (frame == (void __user *) -1UL)
-		goto give_sigsegv;
+		return -EFAULT;
 
-	if (copy_siginfo_to_user(&frame->info, info))
-		goto give_sigsegv;
+	if (copy_siginfo_to_user(&frame->info, &ksig->info))
+		return -EFAULT;
 
 	/* Create the ucontext.  */
 	err |= __put_user(0, &frame->uc.uc_flags);
@@ -279,24 +275,24 @@ static int setup_rt_frame(int sig, struc
 	err |= save_sigregs(regs, &frame->uc.uc_mcontext);
 	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
 	if (err)
-		goto give_sigsegv;
+		return -EFAULT;
 
 	/* Set up to return from userspace.  If provided, use a stub
 	   already in userspace.  */
-	if (ka->sa.sa_flags & SA_RESTORER) {
+	if (ksig->ka.sa.sa_flags & SA_RESTORER) {
                 regs->gprs[14] = (unsigned long)
-			ka->sa.sa_restorer | PSW_ADDR_AMODE;
+			ksig->ka.sa.sa_restorer | PSW_ADDR_AMODE;
 	} else {
                 regs->gprs[14] = (unsigned long)
 			frame->retcode | PSW_ADDR_AMODE;
 		if (__put_user(S390_SYSCALL_OPCODE | __NR_rt_sigreturn,
 			       (u16 __user *)(frame->retcode)))
-			goto give_sigsegv;
+			return -EFAULT;
 	}
 
 	/* Set up backchain. */
 	if (__put_user(regs->gprs[15], (addr_t __user *) frame))
-		goto give_sigsegv;
+		return -EFAULT;
 
 	/* Set up registers for signal handler */
 	regs->gprs[15] = (unsigned long) frame;
@@ -304,34 +300,27 @@ static int setup_rt_frame(int sig, struc
 	regs->psw.mask = PSW_MASK_EA | PSW_MASK_BA |
 		(PSW_USER_BITS & PSW_MASK_ASC) |
 		(regs->psw.mask & ~PSW_MASK_ASC);
-	regs->psw.addr = (unsigned long) ka->sa.sa_handler | PSW_ADDR_AMODE;
+	regs->psw.addr = (unsigned long) ksig->ka.sa.sa_handler | PSW_ADDR_AMODE;
 
-	regs->gprs[2] = map_signal(sig);
+	regs->gprs[2] = map_signal(ksig->sig);
 	regs->gprs[3] = (unsigned long) &frame->info;
 	regs->gprs[4] = (unsigned long) &frame->uc;
 	regs->gprs[5] = task_thread_info(current)->last_break;
 	return 0;
-
-give_sigsegv:
-	force_sigsegv(sig, current);
-	return -EFAULT;
 }
 
-static void handle_signal(unsigned long sig, struct k_sigaction *ka,
-			 siginfo_t *info, sigset_t *oldset,
-			 struct pt_regs *regs)
+static void handle_signal(struct ksignal *ksig, sigset_t *oldset,
+			  struct pt_regs *regs)
 {
 	int ret;
 
 	/* Set up the stack frame */
-	if (ka->sa.sa_flags & SA_SIGINFO)
-		ret = setup_rt_frame(sig, ka, info, oldset, regs);
+	if (ksig->ka.sa.sa_flags & SA_SIGINFO)
+		ret = setup_rt_frame(ksig, oldset, regs);
 	else
-		ret = setup_frame(sig, ka, oldset, regs);
-	if (ret)
-		return;
-	signal_delivered(sig, info, ka, regs,
-				 test_thread_flag(TIF_SINGLE_STEP));
+		ret = setup_frame(ksig->sig, &ksig->ka, oldset, regs);
+
+	signal_setup_done(ret, ksig, test_thread_flag(TIF_SINGLE_STEP));
 }
 
 /*
@@ -345,9 +334,7 @@ static void handle_signal(unsigned long
  */
 void do_signal(struct pt_regs *regs)
 {
-	siginfo_t info;
-	int signr;
-	struct k_sigaction ka;
+	struct ksignal ksig;
 	sigset_t *oldset = sigmask_to_save();
 
 	/*
@@ -357,9 +344,8 @@ void do_signal(struct pt_regs *regs)
 	 */
 	current_thread_info()->system_call =
 		test_pt_regs_flag(regs, PIF_SYSCALL) ? regs->int_code : 0;
-	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
 
-	if (signr > 0) {
+	if (get_signal(&ksig)) {
 		/* Whee!  Actually deliver the signal.  */
 		if (current_thread_info()->system_call) {
 			regs->int_code = current_thread_info()->system_call;
@@ -370,7 +356,7 @@ void do_signal(struct pt_regs *regs)
 				regs->gprs[2] = -EINTR;
 				break;
 			case -ERESTARTSYS:
-				if (!(ka.sa.sa_flags & SA_RESTART)) {
+				if (!(ksig.ka.sa.sa_flags & SA_RESTART)) {
 					regs->gprs[2] = -EINTR;
 					break;
 				}
@@ -387,9 +373,9 @@ void do_signal(struct pt_regs *regs)
 		clear_pt_regs_flag(regs, PIF_SYSCALL);
 
 		if (is_compat_task())
-			handle_signal32(signr, &ka, &info, oldset, regs);
+			handle_signal32(&ksig, oldset, regs);
 		else
-			handle_signal(signr, &ka, &info, oldset, regs);
+			handle_signal(&ksig, oldset, regs);
 		return;
 	}
 

