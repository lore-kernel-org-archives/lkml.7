Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63699C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29237206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfD0PXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:23:04 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33632 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727509AbfD0PP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:29 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP30-00014C-SV; Sat, 27 Apr 2019 16:15:26 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2l-0004YI-Dn; Sat, 27 Apr 2019 16:15:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Richard Weinberger" <richard@nod.at>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.381748030@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 123/202] powerpc: Use get_signal() signal_setup_done()
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

commit 129b69df9c9074750245fca8aa92df5cc1a86ef4 upstream.

Use the more generic functions get_signal() signal_setup_done()
for signal delivery.
This inverts also the return codes of setup_*frame() to follow the
kernel convention.

Signed-off-by: Richard Weinberger <richard@nod.at>
[bwh: Backported to 3.16 as dependency of commit 35634ffa1751
 "signal: Always notice exiting tasks"]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/powerpc/kernel/signal.c    | 31 ++++++++++------------------
 arch/powerpc/kernel/signal.h    | 14 +++++--------
 arch/powerpc/kernel/signal_32.c | 36 +++++++++++++++------------------
 arch/powerpc/kernel/signal_64.c | 28 ++++++++++++-------------
 4 files changed, 45 insertions(+), 64 deletions(-)

--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -105,25 +105,23 @@ static void check_syscall_restart(struct
 	}
 }
 
-static int do_signal(struct pt_regs *regs)
+static void do_signal(struct pt_regs *regs)
 {
 	sigset_t *oldset = sigmask_to_save();
-	siginfo_t info;
-	int signr;
-	struct k_sigaction ka;
+	struct ksignal ksig;
 	int ret;
 	int is32 = is_32bit_task();
 
-	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
+	get_signal(&ksig);
 
 	/* Is there any syscall restart business here ? */
-	check_syscall_restart(regs, &ka, signr > 0);
+	check_syscall_restart(regs, &ksig.ka, ksig.sig > 0);
 
-	if (signr <= 0) {
+	if (ksig.sig <= 0) {
 		/* No signal to deliver -- put the saved sigmask back */
 		restore_saved_sigmask();
 		regs->trap = 0;
-		return 0;               /* no signals delivered */
+		return;               /* no signals delivered */
 	}
 
 #ifndef CONFIG_PPC_ADV_DEBUG_REGS
@@ -140,23 +138,16 @@ static int do_signal(struct pt_regs *reg
 	thread_change_pc(current, regs);
 
 	if (is32) {
-        	if (ka.sa.sa_flags & SA_SIGINFO)
-			ret = handle_rt_signal32(signr, &ka, &info, oldset,
-					regs);
+        	if (ksig.ka.sa.sa_flags & SA_SIGINFO)
+			ret = handle_rt_signal32(&ksig, oldset, regs);
 		else
-			ret = handle_signal32(signr, &ka, &info, oldset,
-					regs);
+			ret = handle_signal32(&ksig, oldset, regs);
 	} else {
-		ret = handle_rt_signal64(signr, &ka, &info, oldset, regs);
+		ret = handle_rt_signal64(&ksig, oldset, regs);
 	}
 
 	regs->trap = 0;
-	if (ret) {
-		signal_delivered(signr, &info, &ka, regs,
-					 test_thread_flag(TIF_SINGLESTEP));
-	}
-
-	return ret;
+	signal_setup_done(ret, &ksig, test_thread_flag(TIF_SINGLESTEP));
 }
 
 void do_notify_resume(struct pt_regs *regs, unsigned long thread_info_flags)
--- a/arch/powerpc/kernel/signal.h
+++ b/arch/powerpc/kernel/signal.h
@@ -12,15 +12,13 @@
 
 extern void do_notify_resume(struct pt_regs *regs, unsigned long thread_info_flags);
 
-extern void __user * get_sigframe(struct k_sigaction *ka, unsigned long sp,
+extern void __user *get_sigframe(struct ksignal *ksig, unsigned long sp,
 				  size_t frame_size, int is_32);
 
-extern int handle_signal32(unsigned long sig, struct k_sigaction *ka,
-			   siginfo_t *info, sigset_t *oldset,
+extern int handle_signal32(struct ksignal *ksig, sigset_t *oldset,
 			   struct pt_regs *regs);
 
-extern int handle_rt_signal32(unsigned long sig, struct k_sigaction *ka,
-			      siginfo_t *info, sigset_t *oldset,
+extern int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 			      struct pt_regs *regs);
 
 extern unsigned long copy_fpr_to_user(void __user *to,
@@ -44,14 +42,12 @@ extern unsigned long copy_transact_vsx_f
 
 #ifdef CONFIG_PPC64
 
-extern int handle_rt_signal64(int signr, struct k_sigaction *ka,
-			      siginfo_t *info, sigset_t *set,
+extern int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 			      struct pt_regs *regs);
 
 #else /* CONFIG_PPC64 */
 
-static inline int handle_rt_signal64(int signr, struct k_sigaction *ka,
-				     siginfo_t *info, sigset_t *set,
+static inline int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 				     struct pt_regs *regs)
 {
 	return -EFAULT;
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -1001,9 +1001,8 @@ int copy_siginfo_from_user32(siginfo_t *
  * Set up a signal frame for a "real-time" signal handler
  * (one which gets siginfo).
  */
-int handle_rt_signal32(unsigned long sig, struct k_sigaction *ka,
-		siginfo_t *info, sigset_t *oldset,
-		struct pt_regs *regs)
+int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
+		       struct pt_regs *regs)
 {
 	struct rt_sigframe __user *rt_sf;
 	struct mcontext __user *frame;
@@ -1015,13 +1014,13 @@ int handle_rt_signal32(unsigned long sig
 
 	/* Set up Signal Frame */
 	/* Put a Real Time Context onto stack */
-	rt_sf = get_sigframe(ka, get_tm_stackpointer(regs), sizeof(*rt_sf), 1);
+	rt_sf = get_sigframe(&ksig->ka, get_tm_stackpointer(regs), sizeof(*rt_sf), 1);
 	addr = rt_sf;
 	if (unlikely(rt_sf == NULL))
 		goto badframe;
 
 	/* Put the siginfo & fill in most of the ucontext */
-	if (copy_siginfo_to_user(&rt_sf->info, info)
+	if (copy_siginfo_to_user(&rt_sf->info, &ksig->info)
 	    || __put_user(0, &rt_sf->uc.uc_flags)
 	    || __save_altstack(&rt_sf->uc.uc_stack, regs->gpr[1])
 	    || __put_user(to_user_ptr(&rt_sf->uc.uc_mcontext),
@@ -1071,15 +1070,15 @@ int handle_rt_signal32(unsigned long sig
 
 	/* Fill registers for signal handler */
 	regs->gpr[1] = newsp;
-	regs->gpr[3] = sig;
+	regs->gpr[3] = ksig->sig;
 	regs->gpr[4] = (unsigned long) &rt_sf->info;
 	regs->gpr[5] = (unsigned long) &rt_sf->uc;
 	regs->gpr[6] = (unsigned long) rt_sf;
-	regs->nip = (unsigned long) ka->sa.sa_handler;
+	regs->nip = (unsigned long) ksig->ka.sa.sa_handler;
 	/* enter the signal handler in native-endian mode */
 	regs->msr &= ~MSR_LE;
 	regs->msr |= (MSR_KERNEL & MSR_LE);
-	return 1;
+	return 0;
 
 badframe:
 	if (show_unhandled_signals)
@@ -1089,8 +1088,7 @@ badframe:
 				   current->comm, current->pid,
 				   addr, regs->nip, regs->link);
 
-	force_sigsegv(sig, current);
-	return 0;
+	return 1;
 }
 
 static int do_setcontext(struct ucontext __user *ucp, struct pt_regs *regs, int sig)
@@ -1437,8 +1435,7 @@ int sys_debug_setcontext(struct ucontext
 /*
  * OK, we're invoking a handler
  */
-int handle_signal32(unsigned long sig, struct k_sigaction *ka,
-		    siginfo_t *info, sigset_t *oldset, struct pt_regs *regs)
+int handle_signal32(struct ksignal *ksig, sigset_t *oldset, struct pt_regs *regs)
 {
 	struct sigcontext __user *sc;
 	struct sigframe __user *frame;
@@ -1448,7 +1445,7 @@ int handle_signal32(unsigned long sig, s
 	unsigned long tramp;
 
 	/* Set up Signal Frame */
-	frame = get_sigframe(ka, get_tm_stackpointer(regs), sizeof(*frame), 1);
+	frame = get_sigframe(&ksig->ka, get_tm_stackpointer(regs), sizeof(*frame), 1);
 	if (unlikely(frame == NULL))
 		goto badframe;
 	sc = (struct sigcontext __user *) &frame->sctx;
@@ -1456,7 +1453,7 @@ int handle_signal32(unsigned long sig, s
 #if _NSIG != 64
 #error "Please adjust handle_signal()"
 #endif
-	if (__put_user(to_user_ptr(ka->sa.sa_handler), &sc->handler)
+	if (__put_user(to_user_ptr(ksig->ka.sa.sa_handler), &sc->handler)
 	    || __put_user(oldset->sig[0], &sc->oldmask)
 #ifdef CONFIG_PPC64
 	    || __put_user((oldset->sig[0] >> 32), &sc->_unused[3])
@@ -1464,7 +1461,7 @@ int handle_signal32(unsigned long sig, s
 	    || __put_user(oldset->sig[1], &sc->_unused[3])
 #endif
 	    || __put_user(to_user_ptr(&frame->mctx), &sc->regs)
-	    || __put_user(sig, &sc->signal))
+	    || __put_user(ksig->sig, &sc->signal))
 		goto badframe;
 
 	if (vdso32_sigtramp && current->mm->context.vdso_base) {
@@ -1499,12 +1496,12 @@ int handle_signal32(unsigned long sig, s
 		goto badframe;
 
 	regs->gpr[1] = newsp;
-	regs->gpr[3] = sig;
+	regs->gpr[3] = ksig->sig;
 	regs->gpr[4] = (unsigned long) sc;
-	regs->nip = (unsigned long) ka->sa.sa_handler;
+	regs->nip = (unsigned long) (unsigned long)ksig->ka.sa.sa_handler;
 	/* enter the signal handler in big-endian mode */
 	regs->msr &= ~MSR_LE;
-	return 1;
+	return 0;
 
 badframe:
 	if (show_unhandled_signals)
@@ -1514,8 +1511,7 @@ badframe:
 				   current->comm, current->pid,
 				   frame, regs->nip, regs->link);
 
-	force_sigsegv(sig, current);
-	return 0;
+	return 1;
 }
 
 /*
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -743,20 +743,19 @@ badframe:
 	return 0;
 }
 
-int handle_rt_signal64(int signr, struct k_sigaction *ka, siginfo_t *info,
-		sigset_t *set, struct pt_regs *regs)
+int handle_rt_signal64(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs)
 {
 	struct rt_sigframe __user *frame;
 	unsigned long newsp = 0;
 	long err = 0;
 
-	frame = get_sigframe(ka, get_tm_stackpointer(regs), sizeof(*frame), 0);
+	frame = get_sigframe(&ksig->ka, get_tm_stackpointer(regs), sizeof(*frame), 0);
 	if (unlikely(frame == NULL))
 		goto badframe;
 
 	err |= __put_user(&frame->info, &frame->pinfo);
 	err |= __put_user(&frame->uc, &frame->puc);
-	err |= copy_siginfo_to_user(&frame->info, info);
+	err |= copy_siginfo_to_user(&frame->info, &ksig->info);
 	if (err)
 		goto badframe;
 
@@ -771,15 +770,15 @@ int handle_rt_signal64(int signr, struct
 		err |= __put_user(&frame->uc_transact, &frame->uc.uc_link);
 		err |= setup_tm_sigcontexts(&frame->uc.uc_mcontext,
 					    &frame->uc_transact.uc_mcontext,
-					    regs, signr,
+					    regs, ksig->sig,
 					    NULL,
-					    (unsigned long)ka->sa.sa_handler);
+					    (unsigned long)ksig->ka.sa.sa_handler);
 	} else
 #endif
 	{
 		err |= __put_user(0, &frame->uc.uc_link);
-		err |= setup_sigcontext(&frame->uc.uc_mcontext, regs, signr,
-					NULL, (unsigned long)ka->sa.sa_handler,
+		err |= setup_sigcontext(&frame->uc.uc_mcontext, regs, ksig->sig,
+					NULL, (unsigned long)ksig->ka.sa.sa_handler,
 					1);
 	}
 	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
@@ -805,7 +804,7 @@ int handle_rt_signal64(int signr, struct
 
 	/* Set up "regs" so we "return" to the signal handler. */
 	if (is_elf2_task()) {
-		regs->nip = (unsigned long) ka->sa.sa_handler;
+		regs->nip = (unsigned long) ksig->ka.sa.sa_handler;
 		regs->gpr[12] = regs->nip;
 	} else {
 		/* Handler is *really* a pointer to the function descriptor for
@@ -814,7 +813,7 @@ int handle_rt_signal64(int signr, struct
 		 * entry is the TOC value we need to use.
 		 */
 		func_descr_t __user *funct_desc_ptr =
-			(func_descr_t __user *) ka->sa.sa_handler;
+			(func_descr_t __user *) ksig->ka.sa.sa_handler;
 
 		err |= get_user(regs->nip, &funct_desc_ptr->entry);
 		err |= get_user(regs->gpr[2], &funct_desc_ptr->toc);
@@ -824,9 +823,9 @@ int handle_rt_signal64(int signr, struct
 	regs->msr &= ~MSR_LE;
 	regs->msr |= (MSR_KERNEL & MSR_LE);
 	regs->gpr[1] = newsp;
-	regs->gpr[3] = signr;
+	regs->gpr[3] = ksig->sig;
 	regs->result = 0;
-	if (ka->sa.sa_flags & SA_SIGINFO) {
+	if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
 		err |= get_user(regs->gpr[4], (unsigned long __user *)&frame->pinfo);
 		err |= get_user(regs->gpr[5], (unsigned long __user *)&frame->puc);
 		regs->gpr[6] = (unsigned long) frame;
@@ -836,7 +835,7 @@ int handle_rt_signal64(int signr, struct
 	if (err)
 		goto badframe;
 
-	return 1;
+	return 0;
 
 badframe:
 	if (show_unhandled_signals)
@@ -844,6 +843,5 @@ badframe:
 				   current->comm, current->pid, "setup_rt_frame",
 				   (long)frame, regs->nip, regs->link);
 
-	force_sigsegv(signr, current);
-	return 0;
+	return 1;
 }

