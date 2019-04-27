Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55AAC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F24E206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbfD0PWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:22:37 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33782 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727544AbfD0PPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:31 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP32-0000zO-E0; Sat, 27 Apr 2019 16:15:28 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2l-0004XK-1P; Sat, 27 Apr 2019 16:15:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Mark Salter" <msalter@redhat.com>,
        "Richard Weinberger" <richard@nod.at>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.513261021@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 111/202] c6x: Use get_signal() signal_setup_done()
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

commit e19c025bc9a184ed9c5daf06ffb89abc81d1696a upstream.

Use the more generic functions get_signal() signal_setup_done()
for signal delivery.

Tested-by: Mark Salter <msalter@redhat.com>
Acked-by: Mark Salter <msalter@redhat.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
[bwh: Backported to 3.16 as dependency of commit 35634ffa1751
 "signal: Always notice exiting tasks"]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/c6x/kernel/signal.c | 43 +++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 25 deletions(-)

--- a/arch/c6x/kernel/signal.c
+++ b/arch/c6x/kernel/signal.c
@@ -146,21 +146,21 @@ static inline void __user *get_sigframe(
 	return (void __user *)((sp - framesize) & ~7);
 }
 
-static int setup_rt_frame(int signr, struct k_sigaction *ka, siginfo_t *info,
-			   sigset_t *set, struct pt_regs *regs)
+static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
+			  struct pt_regs *regs)
 {
 	struct rt_sigframe __user *frame;
 	unsigned long __user *retcode;
 	int err = 0;
 
-	frame = get_sigframe(ka, regs, sizeof(*frame));
+	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame));
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
-		goto segv_and_exit;
+		return -EFAULT;
 
 	err |= __put_user(&frame->info, &frame->pinfo);
 	err |= __put_user(&frame->uc, &frame->puc);
-	err |= copy_siginfo_to_user(&frame->info, info);
+	err |= copy_siginfo_to_user(&frame->info, &ksig->info);
 
 	/* Clear all the bits of the ucontext we don't use.  */
 	err |= __clear_user(&frame->uc, offsetof(struct ucontext, uc_mcontext));
@@ -188,7 +188,7 @@ static int setup_rt_frame(int signr, str
 #undef COPY
 
 	if (err)
-		goto segv_and_exit;
+		return -EFAULT;
 
 	flush_icache_range((unsigned long) &frame->retcode,
 			   (unsigned long) &frame->retcode + RETCODE_SIZE);
@@ -198,10 +198,10 @@ static int setup_rt_frame(int signr, str
 	/* Change user context to branch to signal handler */
 	regs->sp = (unsigned long) frame - 8;
 	regs->b3 = (unsigned long) retcode;
-	regs->pc = (unsigned long) ka->sa.sa_handler;
+	regs->pc = (unsigned long) ksig->ka.sa.sa_handler;
 
 	/* Give the signal number to the handler */
-	regs->a4 = signr;
+	regs->a4 = ksig->sig;
 
 	/*
 	 * For realtime signals we must also set the second and third
@@ -212,10 +212,6 @@ static int setup_rt_frame(int signr, str
 	regs->a6 = (unsigned long)&frame->uc;
 
 	return 0;
-
-segv_and_exit:
-	force_sigsegv(signr, current);
-	return -EFAULT;
 }
 
 static inline void
@@ -245,10 +241,11 @@ do_restart:
 /*
  * handle the actual delivery of a signal to userspace
  */
-static void handle_signal(int sig,
-			 siginfo_t *info, struct k_sigaction *ka,
-			 struct pt_regs *regs, int syscall)
+static void handle_signal(struct ksignal *ksig, struct pt_regs *regs,
+			  int syscall)
 {
+	int ret;
+
 	/* Are we from a system call? */
 	if (syscall) {
 		/* If so, check system call restarting.. */
@@ -259,7 +256,7 @@ static void handle_signal(int sig,
 			break;
 
 		case -ERESTARTSYS:
-			if (!(ka->sa.sa_flags & SA_RESTART)) {
+			if (!(ksig->ka.sa.sa_flags & SA_RESTART)) {
 				regs->a4 = -EINTR;
 				break;
 			}
@@ -272,9 +269,8 @@ static void handle_signal(int sig,
 	}
 
 	/* Set up the stack frame */
-	if (setup_rt_frame(sig, ka, info, sigmask_to_save(), regs) < 0)
-		return;
-	signal_delivered(sig, info, ka, regs, 0);
+	ret = setup_rt_frame(ksig, sigmask_to_save(), regs);
+	signal_setup_done(ret, ksig, 0);
 }
 
 /*
@@ -282,18 +278,15 @@ static void handle_signal(int sig,
  */
 static void do_signal(struct pt_regs *regs, int syscall)
 {
-	struct k_sigaction ka;
-	siginfo_t info;
-	int signr;
+	struct ksignal ksig;
 
 	/* we want the common case to go fast, which is why we may in certain
 	 * cases get here from kernel mode */
 	if (!user_mode(regs))
 		return;
 
-	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
-	if (signr > 0) {
-		handle_signal(signr, &info, &ka, regs, syscall);
+	if (get_signal(&ksig)) {
+		handle_signal(&ksig, regs, syscall);
 		return;
 	}
 

