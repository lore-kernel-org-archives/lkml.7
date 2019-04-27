Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05694C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D67F1206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfD0PQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:16:08 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33758 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727533AbfD0PPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:31 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP32-0000zL-Ca; Sat, 27 Apr 2019 16:15:28 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2l-0004XF-0q; Sat, 27 Apr 2019 16:15:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Richard Weinberger" <richard@nod.at>,
        "Steven Miao" <realmz6@gmail.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.29456596@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 110/202] blackfin: Use get_signal() signal_setup_done()
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

commit 1270cff147a39f7da5b25225dca6ca3132ca6130 upstream.

Use the more generic functions get_signal() signal_setup_done()
for signal delivery.

Signed-off-by: Richard Weinberger <richard@nod.at>
Acked-by: Steven Miao <realmz6@gmail.com>
[bwh: Backported to 3.16 as dependency of commit 35634ffa1751
 "signal: Always notice exiting tasks"]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/blackfin/kernel/signal.c | 39 +++++++++++++++--------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

--- a/arch/blackfin/kernel/signal.c
+++ b/arch/blackfin/kernel/signal.c
@@ -152,23 +152,22 @@ static inline void *get_sigframe(struct
 }
 
 static int
-setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t * info,
-	       sigset_t * set, struct pt_regs *regs)
+setup_rt_frame(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs)
 {
 	struct rt_sigframe *frame;
 	int err = 0;
 
-	frame = get_sigframe(ka, regs, sizeof(*frame));
+	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame));
 
 	err |= __put_user((current_thread_info()->exec_domain
 			   && current_thread_info()->exec_domain->signal_invmap
-			   && sig < 32
+			   && ksig->sig < 32
 			   ? current_thread_info()->exec_domain->
-			   signal_invmap[sig] : sig), &frame->sig);
+			   signal_invmap[ksig->sig] : ksig->sig), &frame->sig);
 
 	err |= __put_user(&frame->info, &frame->pinfo);
 	err |= __put_user(&frame->uc, &frame->puc);
-	err |= copy_siginfo_to_user(&frame->info, info);
+	err |= copy_siginfo_to_user(&frame->info, &ksig->info);
 
 	/* Create the ucontext.  */
 	err |= __put_user(0, &frame->uc.uc_flags);
@@ -183,7 +182,7 @@ setup_rt_frame(int sig, struct k_sigacti
 	/* Set up registers for signal handler */
 	if (current->personality & FDPIC_FUNCPTRS) {
 		struct fdpic_func_descriptor __user *funcptr =
-			(struct fdpic_func_descriptor *) ka->sa.sa_handler;
+			(struct fdpic_func_descriptor *) ksig->ka.sa.sa_handler;
 		u32 pc, p3;
 		err |= __get_user(pc, &funcptr->text);
 		err |= __get_user(p3, &funcptr->GOT);
@@ -192,7 +191,7 @@ setup_rt_frame(int sig, struct k_sigacti
 		regs->pc = pc;
 		regs->p3 = p3;
 	} else
-		regs->pc = (unsigned long)ka->sa.sa_handler;
+		regs->pc = (unsigned long)ksig->ka.sa.sa_handler;
 	wrusp((unsigned long)frame);
 	regs->rets = SIGRETURN_STUB;
 
@@ -237,20 +236,19 @@ handle_restart(struct pt_regs *regs, str
  * OK, we're invoking a handler
  */
 static void
-handle_signal(int sig, siginfo_t *info, struct k_sigaction *ka,
-	      struct pt_regs *regs)
+handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 {
+	int ret;
+
 	/* are we from a system call? to see pt_regs->orig_p0 */
 	if (regs->orig_p0 >= 0)
 		/* If so, check system call restarting.. */
-		handle_restart(regs, ka, 1);
+		handle_restart(regs, &ksig->ka, 1);
 
 	/* set up the stack frame */
-	if (setup_rt_frame(sig, ka, info, sigmask_to_save(), regs) < 0)
-		force_sigsegv(sig, current);
-	else 
-		signal_delivered(sig, info, ka, regs,
-				test_thread_flag(TIF_SINGLESTEP));
+	ret = setup_rt_frame(ksig, sigmask_to_save(), regs);
+
+	signal_setup_done(ret, ksig, test_thread_flag(TIF_SINGLESTEP));
 }
 
 /*
@@ -264,16 +262,13 @@ handle_signal(int sig, siginfo_t *info,
  */
 asmlinkage void do_signal(struct pt_regs *regs)
 {
-	siginfo_t info;
-	int signr;
-	struct k_sigaction ka;
+	struct ksignal ksig;
 
 	current->thread.esp0 = (unsigned long)regs;
 
-	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
-	if (signr > 0) {
+	if (get_signal(&ksig)) {
 		/* Whee!  Actually deliver the signal.  */
-		handle_signal(signr, &info, &ka, regs);
+		handle_signal(&ksig, regs);
 		return;
 	}
 

