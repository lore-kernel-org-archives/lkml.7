Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79759C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B0E4208CA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbfD0PP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:15:59 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33534 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727488AbfD0PP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:28 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2z-000144-0q; Sat, 27 Apr 2019 16:15:25 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2l-0004ZM-V1; Sat, 27 Apr 2019 16:15:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Richard Weinberger" <richard@nod.at>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.281994154@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 136/202] Rip out get_signal_to_deliver()
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

commit 828b1f65d23cf8a68795739f6dd08fc8abd9ee64 upstream.

Now we can turn get_signal() to the main function.

Signed-off-by: Richard Weinberger <richard@nod.at>
[bwh: Backported to 3.16 as dependency of commit 35634ffa1751
 "signal: Always notice exiting tasks"]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/linux/signal.h | 14 +-------------
 kernel/signal.c        | 23 ++++++++++++-----------
 2 files changed, 13 insertions(+), 24 deletions(-)

--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -279,7 +279,7 @@ struct ksignal {
 	int sig;
 };
 
-extern int get_signal_to_deliver(siginfo_t *info, struct k_sigaction *return_ka, struct pt_regs *regs, void *cookie);
+extern int get_signal(struct ksignal *ksig);
 extern void signal_setup_done(int failed, struct ksignal *ksig, int stepping);
 extern void exit_signals(struct task_struct *tsk);
 extern void kernel_sigaction(int, __sighandler_t);
@@ -299,18 +299,6 @@ static inline void disallow_signal(int s
 	kernel_sigaction(sig, SIG_IGN);
 }
 
-/*
- * Eventually that'll replace get_signal_to_deliver(); macro for now,
- * to avoid nastiness with include order.
- */
-#define get_signal(ksig)					\
-({								\
-	struct ksignal *p = (ksig);				\
-	p->sig = get_signal_to_deliver(&p->info, &p->ka,	\
-					signal_pt_regs(), NULL);\
-	p->sig > 0;						\
-})
-
 extern struct kmem_cache *sighand_cachep;
 
 int unhandled_signal(struct task_struct *tsk, int sig);
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2174,8 +2174,7 @@ static int ptrace_signal(int signr, sigi
 	return signr;
 }
 
-int get_signal_to_deliver(siginfo_t *info, struct k_sigaction *return_ka,
-			  struct pt_regs *regs, void *cookie)
+int get_signal(struct ksignal *ksig)
 {
 	struct sighand_struct *sighand = current->sighand;
 	struct signal_struct *signal = current->signal;
@@ -2245,13 +2244,13 @@ relock:
 			goto relock;
 		}
 
-		signr = dequeue_signal(current, &current->blocked, info);
+		signr = dequeue_signal(current, &current->blocked, &ksig->info);
 
 		if (!signr)
 			break; /* will return 0 */
 
 		if (unlikely(current->ptrace) && signr != SIGKILL) {
-			signr = ptrace_signal(signr, info);
+			signr = ptrace_signal(signr, &ksig->info);
 			if (!signr)
 				continue;
 		}
@@ -2259,13 +2258,13 @@ relock:
 		ka = &sighand->action[signr-1];
 
 		/* Trace actually delivered signals. */
-		trace_signal_deliver(signr, info, ka);
+		trace_signal_deliver(signr, &ksig->info, ka);
 
 		if (ka->sa.sa_handler == SIG_IGN) /* Do nothing.  */
 			continue;
 		if (ka->sa.sa_handler != SIG_DFL) {
 			/* Run the handler.  */
-			*return_ka = *ka;
+			ksig->ka = *ka;
 
 			if (ka->sa.sa_flags & SA_ONESHOT)
 				ka->sa.sa_handler = SIG_DFL;
@@ -2315,7 +2314,7 @@ relock:
 				spin_lock_irq(&sighand->siglock);
 			}
 
-			if (likely(do_signal_stop(info->si_signo))) {
+			if (likely(do_signal_stop(ksig->info.si_signo))) {
 				/* It released the siglock.  */
 				goto relock;
 			}
@@ -2336,7 +2335,7 @@ relock:
 
 		if (sig_kernel_coredump(signr)) {
 			if (print_fatal_signals)
-				print_fatal_signal(info->si_signo);
+				print_fatal_signal(ksig->info.si_signo);
 			proc_coredump_connector(current);
 			/*
 			 * If it was able to dump core, this kills all
@@ -2346,17 +2345,19 @@ relock:
 			 * first and our do_group_exit call below will use
 			 * that value and ignore the one we pass it.
 			 */
-			do_coredump(info);
+			do_coredump(&ksig->info);
 		}
 
 		/*
 		 * Death signals, no core dump.
 		 */
-		do_group_exit(info->si_signo);
+		do_group_exit(ksig->info.si_signo);
 		/* NOTREACHED */
 	}
 	spin_unlock_irq(&sighand->siglock);
-	return signr;
+
+	ksig->sig = signr;
+	return ksig->sig > 0;
 }
 
 /**

