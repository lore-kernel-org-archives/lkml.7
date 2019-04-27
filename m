Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8045CC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48247206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbfD0PWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:22:53 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33714 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727527AbfD0PPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:30 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP31-00014I-QX; Sat, 27 Apr 2019 16:15:27 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2l-0004Xy-8y; Sat, 27 Apr 2019 16:15:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Richard Weinberger" <richard@nod.at>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.493953240@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 119/202] mips: Use get_signal() signal_setup_done()
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

commit 81d103bf80678669c56658185e758fc3f9845d71 upstream.

Use the more generic functions get_signal() signal_setup_done()
for signal delivery.

Signed-off-by: Richard Weinberger <richard@nod.at>
[bwh: Backported to 3.16 as dependency of commit 35634ffa1751
 "signal: Always notice exiting tasks"]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/include/asm/abi.h      | 10 ++---
 arch/mips/kernel/signal-common.h |  2 +-
 arch/mips/kernel/signal.c        | 66 ++++++++++++--------------------
 arch/mips/kernel/signal32.c      | 39 ++++++++-----------
 arch/mips/kernel/signal_n32.c    | 20 ++++------
 5 files changed, 53 insertions(+), 84 deletions(-)

--- a/arch/mips/include/asm/abi.h
+++ b/arch/mips/include/asm/abi.h
@@ -13,13 +13,11 @@
 #include <asm/siginfo.h>
 
 struct mips_abi {
-	int (* const setup_frame)(void *sig_return, struct k_sigaction *ka,
-				  struct pt_regs *regs, int signr,
-				  sigset_t *set);
+	int (* const setup_frame)(void *sig_return, struct ksignal *ksig,
+				  struct pt_regs *regs, sigset_t *set);
 	const unsigned long	signal_return_offset;
-	int (* const setup_rt_frame)(void *sig_return, struct k_sigaction *ka,
-			       struct pt_regs *regs, int signr,
-			       sigset_t *set, siginfo_t *info);
+	int (* const setup_rt_frame)(void *sig_return, struct ksignal *ksig,
+				     struct pt_regs *regs, sigset_t *set);
 	const unsigned long	rt_signal_return_offset;
 	const unsigned long	restart;
 };
--- a/arch/mips/kernel/signal-common.h
+++ b/arch/mips/kernel/signal-common.h
@@ -22,7 +22,7 @@
 /*
  * Determine which stack to use..
  */
-extern void __user *get_sigframe(struct k_sigaction *ka, struct pt_regs *regs,
+extern void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs,
 				 size_t frame_size);
 /* Check and clear pending FPU exceptions in saved CSR */
 extern int fpcsr_pending(unsigned int __user *fpcsr);
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -428,20 +428,20 @@ badframe:
 }
 
 #ifdef CONFIG_TRAD_SIGNALS
-static int setup_frame(void *sig_return, struct k_sigaction *ka,
-		       struct pt_regs *regs, int signr, sigset_t *set)
+static int setup_frame(void *sig_return, struct ksignal *ksig,
+		       struct pt_regs *regs, sigset_t *set)
 {
 	struct sigframe __user *frame;
 	int err = 0;
 
-	frame = get_sigframe(ka, regs, sizeof(*frame));
+	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame));
 	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
-		goto give_sigsegv;
+		return -EFAULT;
 
 	err |= setup_sigcontext(regs, &frame->sf_sc);
 	err |= __copy_to_user(&frame->sf_mask, set, sizeof(*set));
 	if (err)
-		goto give_sigsegv;
+		return -EFAULT;
 
 	/*
 	 * Arguments to signal handler:
@@ -453,37 +453,32 @@ static int setup_frame(void *sig_return,
 	 * $25 and c0_epc point to the signal handler, $29 points to the
 	 * struct sigframe.
 	 */
-	regs->regs[ 4] = signr;
+	regs->regs[ 4] = ksig->sig;
 	regs->regs[ 5] = 0;
 	regs->regs[ 6] = (unsigned long) &frame->sf_sc;
 	regs->regs[29] = (unsigned long) frame;
 	regs->regs[31] = (unsigned long) sig_return;
-	regs->cp0_epc = regs->regs[25] = (unsigned long) ka->sa.sa_handler;
+	regs->cp0_epc = regs->regs[25] = (unsigned long) ksig->ka.sa.sa_handler;
 
 	DEBUGP("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%lx\n",
 	       current->comm, current->pid,
 	       frame, regs->cp0_epc, regs->regs[31]);
 	return 0;
-
-give_sigsegv:
-	force_sigsegv(signr, current);
-	return -EFAULT;
 }
 #endif
 
-static int setup_rt_frame(void *sig_return, struct k_sigaction *ka,
-			  struct pt_regs *regs, int signr, sigset_t *set,
-			  siginfo_t *info)
+static int setup_rt_frame(void *sig_return, struct ksignal *ksig,
+			  struct pt_regs *regs, sigset_t *set)
 {
 	struct rt_sigframe __user *frame;
 	int err = 0;
 
-	frame = get_sigframe(ka, regs, sizeof(*frame));
+	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame));
 	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
-		goto give_sigsegv;
+		return -EFAULT;
 
 	/* Create siginfo.  */
-	err |= copy_siginfo_to_user(&frame->rs_info, info);
+	err |= copy_siginfo_to_user(&frame->rs_info, &ksig->info);
 
 	/* Create the ucontext.	 */
 	err |= __put_user(0, &frame->rs_uc.uc_flags);
@@ -493,7 +488,7 @@ static int setup_rt_frame(void *sig_retu
 	err |= __copy_to_user(&frame->rs_uc.uc_sigmask, set, sizeof(*set));
 
 	if (err)
-		goto give_sigsegv;
+		return -EFAULT;
 
 	/*
 	 * Arguments to signal handler:
@@ -505,22 +500,18 @@ static int setup_rt_frame(void *sig_retu
 	 * $25 and c0_epc point to the signal handler, $29 points to
 	 * the struct rt_sigframe.
 	 */
-	regs->regs[ 4] = signr;
+	regs->regs[ 4] = ksig->sig;
 	regs->regs[ 5] = (unsigned long) &frame->rs_info;
 	regs->regs[ 6] = (unsigned long) &frame->rs_uc;
 	regs->regs[29] = (unsigned long) frame;
 	regs->regs[31] = (unsigned long) sig_return;
-	regs->cp0_epc = regs->regs[25] = (unsigned long) ka->sa.sa_handler;
+	regs->cp0_epc = regs->regs[25] = (unsigned long) ksig->ka.sa.sa_handler;
 
 	DEBUGP("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%lx\n",
 	       current->comm, current->pid,
 	       frame, regs->cp0_epc, regs->regs[31]);
 
 	return 0;
-
-give_sigsegv:
-	force_sigsegv(signr, current);
-	return -EFAULT;
 }
 
 struct mips_abi mips_abi = {
@@ -534,8 +525,7 @@ struct mips_abi mips_abi = {
 	.restart	= __NR_restart_syscall
 };
 
-static void handle_signal(unsigned long sig, siginfo_t *info,
-	struct k_sigaction *ka, struct pt_regs *regs)
+static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 {
 	sigset_t *oldset = sigmask_to_save();
 	int ret;
@@ -557,7 +547,7 @@ static void handle_signal(unsigned long
 			regs->regs[2] = EINTR;
 			break;
 		case ERESTARTSYS:
-			if (!(ka->sa.sa_flags & SA_RESTART)) {
+			if (!(ksig->ka.sa.sa_flags & SA_RESTART)) {
 				regs->regs[2] = EINTR;
 				break;
 			}
@@ -571,29 +561,23 @@ static void handle_signal(unsigned long
 		regs->regs[0] = 0;		/* Don't deal with this again.	*/
 	}
 
-	if (sig_uses_siginfo(ka))
+	if (sig_uses_siginfo(&ksig->ka))
 		ret = abi->setup_rt_frame(vdso + abi->rt_signal_return_offset,
-					  ka, regs, sig, oldset, info);
+					  ksig, regs, oldset);
 	else
-		ret = abi->setup_frame(vdso + abi->signal_return_offset,
-				       ka, regs, sig, oldset);
-
-	if (ret)
-		return;
+		ret = abi->setup_frame(vdso + abi->signal_return_offset, ksig,
+				       regs, oldset);
 
-	signal_delivered(sig, info, ka, regs, 0);
+	signal_setup_done(ret, ksig, 0);
 }
 
 static void do_signal(struct pt_regs *regs)
 {
-	struct k_sigaction ka;
-	siginfo_t info;
-	int signr;
+	struct ksignal ksig;
 
-	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
-	if (signr > 0) {
+	if (get_signal(&ksig)) {
 		/* Whee!  Actually deliver the signal.	*/
-		handle_signal(signr, &info, &ka, regs);
+		handle_signal(&ksig, regs);
 		return;
 	}
 
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -488,21 +488,21 @@ badframe:
 	force_sig(SIGSEGV, current);
 }
 
-static int setup_frame_32(void *sig_return, struct k_sigaction *ka,
-			  struct pt_regs *regs, int signr, sigset_t *set)
+static int setup_frame_32(void *sig_return, struct ksignal *ksig,
+			  struct pt_regs *regs, sigset_t *set)
 {
 	struct sigframe32 __user *frame;
 	int err = 0;
 
-	frame = get_sigframe(ka, regs, sizeof(*frame));
+	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame));
 	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
-		goto give_sigsegv;
+		return -EFAULT;
 
 	err |= setup_sigcontext32(regs, &frame->sf_sc);
 	err |= __copy_conv_sigset_to_user(&frame->sf_mask, set);
 
 	if (err)
-		goto give_sigsegv;
+		return -EFAULT;
 
 	/*
 	 * Arguments to signal handler:
@@ -514,37 +514,32 @@ static int setup_frame_32(void *sig_retu
 	 * $25 and c0_epc point to the signal handler, $29 points to the
 	 * struct sigframe.
 	 */
-	regs->regs[ 4] = signr;
+	regs->regs[ 4] = ksig->sig;
 	regs->regs[ 5] = 0;
 	regs->regs[ 6] = (unsigned long) &frame->sf_sc;
 	regs->regs[29] = (unsigned long) frame;
 	regs->regs[31] = (unsigned long) sig_return;
-	regs->cp0_epc = regs->regs[25] = (unsigned long) ka->sa.sa_handler;
+	regs->cp0_epc = regs->regs[25] = (unsigned long) ksig->ka.sa.sa_handler;
 
 	DEBUGP("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%lx\n",
 	       current->comm, current->pid,
 	       frame, regs->cp0_epc, regs->regs[31]);
 
 	return 0;
-
-give_sigsegv:
-	force_sigsegv(signr, current);
-	return -EFAULT;
 }
 
-static int setup_rt_frame_32(void *sig_return, struct k_sigaction *ka,
-			     struct pt_regs *regs, int signr, sigset_t *set,
-			     siginfo_t *info)
+static int setup_rt_frame_32(void *sig_return, struct ksignal *ksig,
+			     struct pt_regs *regs, sigset_t *set)
 {
 	struct rt_sigframe32 __user *frame;
 	int err = 0;
 
-	frame = get_sigframe(ka, regs, sizeof(*frame));
+	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame));
 	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
-		goto give_sigsegv;
+		return -EFAULT;
 
 	/* Convert (siginfo_t -> compat_siginfo_t) and copy to user. */
-	err |= copy_siginfo_to_user32(&frame->rs_info, info);
+	err |= copy_siginfo_to_user32(&frame->rs_info, &ksig->info);
 
 	/* Create the ucontext.	 */
 	err |= __put_user(0, &frame->rs_uc.uc_flags);
@@ -554,7 +549,7 @@ static int setup_rt_frame_32(void *sig_r
 	err |= __copy_conv_sigset_to_user(&frame->rs_uc.uc_sigmask, set);
 
 	if (err)
-		goto give_sigsegv;
+		return -EFAULT;
 
 	/*
 	 * Arguments to signal handler:
@@ -566,22 +561,18 @@ static int setup_rt_frame_32(void *sig_r
 	 * $25 and c0_epc point to the signal handler, $29 points to
 	 * the struct rt_sigframe32.
 	 */
-	regs->regs[ 4] = signr;
+	regs->regs[ 4] = ksig->sig;
 	regs->regs[ 5] = (unsigned long) &frame->rs_info;
 	regs->regs[ 6] = (unsigned long) &frame->rs_uc;
 	regs->regs[29] = (unsigned long) frame;
 	regs->regs[31] = (unsigned long) sig_return;
-	regs->cp0_epc = regs->regs[25] = (unsigned long) ka->sa.sa_handler;
+	regs->cp0_epc = regs->regs[25] = (unsigned long) ksig->ka.sa.sa_handler;
 
 	DEBUGP("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%lx\n",
 	       current->comm, current->pid,
 	       frame, regs->cp0_epc, regs->regs[31]);
 
 	return 0;
-
-give_sigsegv:
-	force_sigsegv(signr, current);
-	return -EFAULT;
 }
 
 /*
--- a/arch/mips/kernel/signal_n32.c
+++ b/arch/mips/kernel/signal_n32.c
@@ -102,18 +102,18 @@ badframe:
 	force_sig(SIGSEGV, current);
 }
 
-static int setup_rt_frame_n32(void *sig_return, struct k_sigaction *ka,
-	struct pt_regs *regs, int signr, sigset_t *set, siginfo_t *info)
+static int setup_rt_frame_n32(void *sig_return, struct ksignal *ksig,
+			      struct pt_regs *regs, sigset_t *set)
 {
 	struct rt_sigframe_n32 __user *frame;
 	int err = 0;
 
-	frame = get_sigframe(ka, regs, sizeof(*frame));
+	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame));
 	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
-		goto give_sigsegv;
+		return -EFAULT;
 
 	/* Create siginfo.  */
-	err |= copy_siginfo_to_user32(&frame->rs_info, info);
+	err |= copy_siginfo_to_user32(&frame->rs_info, &ksig->info);
 
 	/* Create the ucontext.	 */
 	err |= __put_user(0, &frame->rs_uc.uc_flags);
@@ -123,7 +123,7 @@ static int setup_rt_frame_n32(void *sig_
 	err |= __copy_conv_sigset_to_user(&frame->rs_uc.uc_sigmask, set);
 
 	if (err)
-		goto give_sigsegv;
+		return -EFAULT;
 
 	/*
 	 * Arguments to signal handler:
@@ -135,22 +135,18 @@ static int setup_rt_frame_n32(void *sig_
 	 * $25 and c0_epc point to the signal handler, $29 points to
 	 * the struct rt_sigframe.
 	 */
-	regs->regs[ 4] = signr;
+	regs->regs[ 4] = ksig->sig;
 	regs->regs[ 5] = (unsigned long) &frame->rs_info;
 	regs->regs[ 6] = (unsigned long) &frame->rs_uc;
 	regs->regs[29] = (unsigned long) frame;
 	regs->regs[31] = (unsigned long) sig_return;
-	regs->cp0_epc = regs->regs[25] = (unsigned long) ka->sa.sa_handler;
+	regs->cp0_epc = regs->regs[25] = (unsigned long) ksig->ka.sa.sa_handler;
 
 	DEBUGP("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%lx\n",
 	       current->comm, current->pid,
 	       frame, regs->cp0_epc, regs->regs[31]);
 
 	return 0;
-
-give_sigsegv:
-	force_sigsegv(signr, current);
-	return -EFAULT;
 }
 
 struct mips_abi mips_abi_n32 = {

