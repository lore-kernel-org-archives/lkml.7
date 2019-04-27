Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B93C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4EB9208CA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbfD0PQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:16:09 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33776 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727541AbfD0PPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:31 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP32-0000zB-Dv; Sat, 27 Apr 2019 16:15:28 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2l-0004XZ-3o; Sat, 27 Apr 2019 16:15:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Richard Weinberger" <richard@nod.at>,
        "Richard Kuo" <rkuo@codeaurora.org>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.576552224@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 114/202] hexagon: Use get_signal() signal_setup_done()
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

commit ac443624490f7033aefd06713e7761aee5977de3 upstream.

Use the more generic functions get_signal() signal_setup_done()
for signal delivery.

Acked-by: Richard Kuo <rkuo@codeaurora.org>
Signed-off-by: Richard Weinberger <richard@nod.at>
[bwh: Backported to 3.16 as dependency of commit 35634ffa1751
 "signal: Always notice exiting tasks"]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/hexagon/kernel/signal.c | 45 +++++++++++++++---------------------
 1 file changed, 18 insertions(+), 27 deletions(-)

--- a/arch/hexagon/kernel/signal.c
+++ b/arch/hexagon/kernel/signal.c
@@ -112,20 +112,20 @@ static int restore_sigcontext(struct pt_
 /*
  * Setup signal stack frame with siginfo structure
  */
-static int setup_rt_frame(int signr, struct k_sigaction *ka, siginfo_t *info,
-			  sigset_t *set,  struct pt_regs *regs)
+static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
+			  struct pt_regs *regs)
 {
 	int err = 0;
 	struct rt_sigframe __user *frame;
 	struct hexagon_vdso *vdso = current->mm->context.vdso;
 
-	frame = get_sigframe(ka, regs, sizeof(struct rt_sigframe));
+	frame = get_sigframe(&ksig->ka, regs, sizeof(struct rt_sigframe));
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(struct rt_sigframe)))
-		goto	sigsegv;
+		return -EFAULT;
 
-	if (copy_siginfo_to_user(&frame->info, info))
-		goto	sigsegv;
+	if (copy_siginfo_to_user(&frame->info, &ksig->info))
+		return -EFAULT;
 
 	/* The on-stack signal trampoline is no longer executed;
 	 * however, the libgcc signal frame unwinding code checks for
@@ -137,29 +137,26 @@ static int setup_rt_frame(int signr, str
 	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
 	err |= __save_altstack(&frame->uc.uc_stack, user_stack_pointer(regs));
 	if (err)
-		goto sigsegv;
+		return -EFAULT;
 
 	/* Load r0/r1 pair with signumber/siginfo pointer... */
 	regs->r0100 = ((unsigned long long)((unsigned long)&frame->info) << 32)
-		| (unsigned long long)signr;
+		| (unsigned long long)ksig->sig;
 	regs->r02 = (unsigned long) &frame->uc;
 	regs->r31 = (unsigned long) vdso->rt_signal_trampoline;
 	pt_psp(regs) = (unsigned long) frame;
-	pt_set_elr(regs, (unsigned long)ka->sa.sa_handler);
+	pt_set_elr(regs, (unsigned long)ksig->ka.sa.sa_handler);
 
 	return 0;
-
-sigsegv:
-	force_sigsegv(signr, current);
-	return -EFAULT;
 }
 
 /*
  * Setup invocation of signal handler
  */
-static void handle_signal(int sig, siginfo_t *info, struct k_sigaction *ka,
-			 struct pt_regs *regs)
+static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 {
+	int ret;
+
 	/*
 	 * If we're handling a signal that aborted a system call,
 	 * set up the error return value before adding the signal
@@ -173,7 +170,7 @@ static void handle_signal(int sig, sigin
 			regs->r00 = -EINTR;
 			break;
 		case -ERESTARTSYS:
-			if (!(ka->sa.sa_flags & SA_RESTART)) {
+			if (!(ksig->ka.sa.sa_flags & SA_RESTART)) {
 				regs->r00 = -EINTR;
 				break;
 			}
@@ -193,11 +190,9 @@ static void handle_signal(int sig, sigin
 	 * only set up the rt_frame flavor.
 	 */
 	/* If there was an error on setup, no signal was delivered. */
-	if (setup_rt_frame(sig, ka, info, sigmask_to_save(), regs) < 0)
-		return;
+	ret = setup_rt_frame(ksig, sigmask_to_save(), regs);
 
-	signal_delivered(sig, info, ka, regs,
-			test_thread_flag(TIF_SINGLESTEP));
+	signal_setup_done(ret, ksig, test_thread_flag(TIF_SINGLESTEP));
 }
 
 /*
@@ -205,17 +200,13 @@ static void handle_signal(int sig, sigin
  */
 void do_signal(struct pt_regs *regs)
 {
-	struct k_sigaction sigact;
-	siginfo_t info;
-	int signo;
+	struct ksignal ksig;
 
 	if (!user_mode(regs))
 		return;
 
-	signo = get_signal_to_deliver(&info, &sigact, regs, NULL);
-
-	if (signo > 0) {
-		handle_signal(signo, &info, &sigact, regs);
+	if (get_signal(&ksig)) {
+		handle_signal(&ksig, regs);
 		return;
 	}
 

