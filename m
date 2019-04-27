Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F396C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44265206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbfD0PX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:23:56 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33590 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727500AbfD0PP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:29 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2z-0000zK-6D; Sat, 27 Apr 2019 16:15:25 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2l-0004ZG-Sq; Sat, 27 Apr 2019 16:15:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Richard Weinberger" <richard@nod.at>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.599178696@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 135/202] Clean up signal_delivered()
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

commit 10b1c7ac8bfed429cf3dcb0225482c8dc1485d8e upstream.

 - Pass a ksignal struct to it
 - Remove unused regs parameter
 - Make it private as it's nowhere outside of kernel/signal.c is used

Signed-off-by: Richard Weinberger <richard@nod.at>
[bwh: Backported to 3.16 as dependency of commit 35634ffa1751
 "signal: Always notice exiting tasks"]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/linux/signal.h |  1 -
 kernel/signal.c        | 21 ++++++++-------------
 2 files changed, 8 insertions(+), 14 deletions(-)

--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -281,7 +281,6 @@ struct ksignal {
 
 extern int get_signal_to_deliver(siginfo_t *info, struct k_sigaction *return_ka, struct pt_regs *regs, void *cookie);
 extern void signal_setup_done(int failed, struct ksignal *ksig, int stepping);
-extern void signal_delivered(int sig, siginfo_t *info, struct k_sigaction *ka, struct pt_regs *regs, int stepping);
 extern void exit_signals(struct task_struct *tsk);
 extern void kernel_sigaction(int, __sighandler_t);
 
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2361,19 +2361,15 @@ relock:
 
 /**
  * signal_delivered - 
- * @sig:		number of signal being delivered
- * @info:		siginfo_t of signal being delivered
- * @ka:			sigaction setting that chose the handler
- * @regs:		user register state
+ * @ksig:		kernel signal struct
  * @stepping:		nonzero if debugger single-step or block-step in use
  *
  * This function should be called when a signal has successfully been
- * delivered. It updates the blocked signals accordingly (@ka->sa.sa_mask
+ * delivered. It updates the blocked signals accordingly (@ksig->ka.sa.sa_mask
  * is always blocked, and the signal itself is blocked unless %SA_NODEFER
- * is set in @ka->sa.sa_flags.  Tracing is notified.
+ * is set in @ksig->ka.sa.sa_flags.  Tracing is notified.
  */
-void signal_delivered(int sig, siginfo_t *info, struct k_sigaction *ka,
-			struct pt_regs *regs, int stepping)
+static void signal_delivered(struct ksignal *ksig, int stepping)
 {
 	sigset_t blocked;
 
@@ -2383,9 +2379,9 @@ void signal_delivered(int sig, siginfo_t
 	   simply clear the restore sigmask flag.  */
 	clear_restore_sigmask();
 
-	sigorsets(&blocked, &current->blocked, &ka->sa.sa_mask);
-	if (!(ka->sa.sa_flags & SA_NODEFER))
-		sigaddset(&blocked, sig);
+	sigorsets(&blocked, &current->blocked, &ksig->ka.sa.sa_mask);
+	if (!(ksig->ka.sa.sa_flags & SA_NODEFER))
+		sigaddset(&blocked, ksig->sig);
 	set_current_blocked(&blocked);
 	tracehook_signal_handler(stepping);
 }
@@ -2395,8 +2391,7 @@ void signal_setup_done(int failed, struc
 	if (failed)
 		force_sigsegv(ksig->sig, current);
 	else
-		signal_delivered(ksig->sig, &ksig->info, &ksig->ka,
-			signal_pt_regs(), stepping);
+		signal_delivered(ksig, stepping);
 }
 
 /*

