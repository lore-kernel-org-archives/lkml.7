Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4FAC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF678206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbfD0PXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:23:34 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33610 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727506AbfD0PP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:29 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2z-0000zH-6D; Sat, 27 Apr 2019 16:15:25 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2l-0004Ys-KN; Sat, 27 Apr 2019 16:15:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Richard Weinberger" <richard@nod.at>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.961315834@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 130/202] um: Use get_signal() signal_setup_done()
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

commit 307627eebbb0bc41b21e74d78b932362a6c1b38d upstream.

Use the more generic functions get_signal() signal_setup_done()
for signal delivery.

Signed-off-by: Richard Weinberger <richard@nod.at>
[bwh: Backported to 3.16 as dependency of commit 35634ffa1751
 "signal: Always notice exiting tasks"]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/um/include/shared/frame_kern.h | 12 +++-----
 arch/um/kernel/signal.c             | 27 +++++++----------
 arch/x86/um/signal.c                | 45 ++++++++++++++---------------
 3 files changed, 36 insertions(+), 48 deletions(-)

--- a/arch/um/include/shared/frame_kern.h
+++ b/arch/um/include/shared/frame_kern.h
@@ -6,14 +6,10 @@
 #ifndef __FRAME_KERN_H_
 #define __FRAME_KERN_H_
 
-extern int setup_signal_stack_sc(unsigned long stack_top, int sig,
-				 struct k_sigaction *ka,
-				 struct pt_regs *regs,
-				 sigset_t *mask);
-extern int setup_signal_stack_si(unsigned long stack_top, int sig,
-				 struct k_sigaction *ka,
-				 struct pt_regs *regs, struct siginfo *info,
-				 sigset_t *mask);
+extern int setup_signal_stack_sc(unsigned long stack_top, struct ksignal *ksig,
+				 struct pt_regs *regs, sigset_t *mask);
+extern int setup_signal_stack_si(unsigned long stack_top, struct ksignal *ksig,
+				 struct pt_regs *regs, sigset_t *mask);
 
 #endif
 
--- a/arch/um/kernel/signal.c
+++ b/arch/um/kernel/signal.c
@@ -18,8 +18,7 @@ EXPORT_SYMBOL(unblock_signals);
 /*
  * OK, we're invoking a handler
  */
-static void handle_signal(struct pt_regs *regs, unsigned long signr,
-			 struct k_sigaction *ka, struct siginfo *info)
+static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 {
 	sigset_t *oldset = sigmask_to_save();
 	int singlestep = 0;
@@ -39,7 +38,7 @@ static void handle_signal(struct pt_regs
 			break;
 
 		case -ERESTARTSYS:
-			if (!(ka->sa.sa_flags & SA_RESTART)) {
+			if (!(ksig->ka.sa.sa_flags & SA_RESTART)) {
 				PT_REGS_SYSCALL_RET(regs) = -EINTR;
 				break;
 			}
@@ -52,32 +51,28 @@ static void handle_signal(struct pt_regs
 	}
 
 	sp = PT_REGS_SP(regs);
-	if ((ka->sa.sa_flags & SA_ONSTACK) && (sas_ss_flags(sp) == 0))
+	if ((ksig->ka.sa.sa_flags & SA_ONSTACK) && (sas_ss_flags(sp) == 0))
 		sp = current->sas_ss_sp + current->sas_ss_size;
 
 #ifdef CONFIG_ARCH_HAS_SC_SIGNALS
-	if (!(ka->sa.sa_flags & SA_SIGINFO))
-		err = setup_signal_stack_sc(sp, signr, ka, regs, oldset);
+	if (!(ksig->ka.sa.sa_flags & SA_SIGINFO))
+		err = setup_signal_stack_sc(sp, ksig, regs, oldset);
 	else
 #endif
-		err = setup_signal_stack_si(sp, signr, ka, regs, info, oldset);
+		err = setup_signal_stack_si(sp, ksig, regs, oldset);
 
-	if (err)
-		force_sigsegv(signr, current);
-	else
-		signal_delivered(signr, info, ka, regs, singlestep);
+	signal_setup_done(err, ksig, singlestep);
 }
 
 static int kern_do_signal(struct pt_regs *regs)
 {
-	struct k_sigaction ka_copy;
-	struct siginfo info;
-	int sig, handled_sig = 0;
+	struct ksignal ksig;
+	int handled_sig = 0;
 
-	while ((sig = get_signal_to_deliver(&info, &ka_copy, regs, NULL)) > 0) {
+	while (get_signal(&ksig)) {
 		handled_sig = 1;
 		/* Whee!  Actually deliver the signal.  */
-		handle_signal(regs, sig, &ka_copy, &info);
+		handle_signal(&ksig, regs);
 	}
 
 	/* Did we come from a system call? */
--- a/arch/x86/um/signal.c
+++ b/arch/x86/um/signal.c
@@ -370,13 +370,12 @@ struct rt_sigframe
 	char retcode[8];
 };
 
-int setup_signal_stack_sc(unsigned long stack_top, int sig,
-			  struct k_sigaction *ka, struct pt_regs *regs,
-			  sigset_t *mask)
+int setup_signal_stack_sc(unsigned long stack_top, struct ksignal *ksig,
+			  struct pt_regs *regs, sigset_t *mask)
 {
 	struct sigframe __user *frame;
 	void __user *restorer;
-	int err = 0;
+	int err = 0, sig = ksig->sig;
 
 	/* This is the same calculation as i386 - ((sp + 4) & 15) == 0 */
 	stack_top = ((stack_top + 4) & -16UL) - 4;
@@ -385,8 +384,8 @@ int setup_signal_stack_sc(unsigned long
 		return 1;
 
 	restorer = frame->retcode;
-	if (ka->sa.sa_flags & SA_RESTORER)
-		restorer = ka->sa.sa_restorer;
+	if (ksig->ka.sa.sa_flags & SA_RESTORER)
+		restorer = ksig->ka.sa.sa_restorer;
 
 	err |= __put_user(restorer, &frame->pretcode);
 	err |= __put_user(sig, &frame->sig);
@@ -410,20 +409,19 @@ int setup_signal_stack_sc(unsigned long
 		return err;
 
 	PT_REGS_SP(regs) = (unsigned long) frame;
-	PT_REGS_IP(regs) = (unsigned long) ka->sa.sa_handler;
+	PT_REGS_IP(regs) = (unsigned long) ksig->ka.sa.sa_handler;
 	PT_REGS_AX(regs) = (unsigned long) sig;
 	PT_REGS_DX(regs) = (unsigned long) 0;
 	PT_REGS_CX(regs) = (unsigned long) 0;
 	return 0;
 }
 
-int setup_signal_stack_si(unsigned long stack_top, int sig,
-			  struct k_sigaction *ka, struct pt_regs *regs,
-			  siginfo_t *info, sigset_t *mask)
+int setup_signal_stack_si(unsigned long stack_top, struct ksignal *ksig,
+			  struct pt_regs *regs, sigset_t *mask)
 {
 	struct rt_sigframe __user *frame;
 	void __user *restorer;
-	int err = 0;
+	int err = 0, sig = ksig->sig;
 
 	stack_top &= -8UL;
 	frame = (struct rt_sigframe __user *) stack_top - 1;
@@ -431,14 +429,14 @@ int setup_signal_stack_si(unsigned long
 		return 1;
 
 	restorer = frame->retcode;
-	if (ka->sa.sa_flags & SA_RESTORER)
-		restorer = ka->sa.sa_restorer;
+	if (ksig->ka.sa.sa_flags & SA_RESTORER)
+		restorer = ksig->ka.sa.sa_restorer;
 
 	err |= __put_user(restorer, &frame->pretcode);
 	err |= __put_user(sig, &frame->sig);
 	err |= __put_user(&frame->info, &frame->pinfo);
 	err |= __put_user(&frame->uc, &frame->puc);
-	err |= copy_siginfo_to_user(&frame->info, info);
+	err |= copy_siginfo_to_user(&frame->info, &ksig->info);
 	err |= copy_ucontext_to_user(&frame->uc, &frame->fpstate, mask,
 					PT_REGS_SP(regs));
 
@@ -457,7 +455,7 @@ int setup_signal_stack_si(unsigned long
 		return err;
 
 	PT_REGS_SP(regs) = (unsigned long) frame;
-	PT_REGS_IP(regs) = (unsigned long) ka->sa.sa_handler;
+	PT_REGS_IP(regs) = (unsigned long) ksig->ka.sa.sa_handler;
 	PT_REGS_AX(regs) = (unsigned long) sig;
 	PT_REGS_DX(regs) = (unsigned long) &frame->info;
 	PT_REGS_CX(regs) = (unsigned long) &frame->uc;
@@ -502,12 +500,11 @@ struct rt_sigframe
 	struct _fpstate fpstate;
 };
 
-int setup_signal_stack_si(unsigned long stack_top, int sig,
-			  struct k_sigaction *ka, struct pt_regs * regs,
-			  siginfo_t *info, sigset_t *set)
+int setup_signal_stack_si(unsigned long stack_top, struct ksignal *ksig,
+			  struct pt_regs *regs, sigset_t *set)
 {
 	struct rt_sigframe __user *frame;
-	int err = 0;
+	int err = 0, sig = ksig->sig;
 
 	frame = (struct rt_sigframe __user *)
 		round_down(stack_top - sizeof(struct rt_sigframe), 16);
@@ -517,8 +514,8 @@ int setup_signal_stack_si(unsigned long
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
 		goto out;
 
-	if (ka->sa.sa_flags & SA_SIGINFO) {
-		err |= copy_siginfo_to_user(&frame->info, info);
+	if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
+		err |= copy_siginfo_to_user(&frame->info, &ksig->info);
 		if (err)
 			goto out;
 	}
@@ -543,8 +540,8 @@ int setup_signal_stack_si(unsigned long
 	 * already in userspace.
 	 */
 	/* x86-64 should always use SA_RESTORER. */
-	if (ka->sa.sa_flags & SA_RESTORER)
-		err |= __put_user(ka->sa.sa_restorer, &frame->pretcode);
+	if (ksig->ka.sa.sa_flags & SA_RESTORER)
+		err |= __put_user(ksig->ka.sa.sa_restorer, &frame->pretcode);
 	else
 		/* could use a vstub here */
 		return err;
@@ -570,7 +567,7 @@ int setup_signal_stack_si(unsigned long
 	 */
 	PT_REGS_SI(regs) = (unsigned long) &frame->info;
 	PT_REGS_DX(regs) = (unsigned long) &frame->uc;
-	PT_REGS_IP(regs) = (unsigned long) ka->sa.sa_handler;
+	PT_REGS_IP(regs) = (unsigned long) ksig->ka.sa.sa_handler;
  out:
 	return err;
 }

