Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C8CC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89CE32189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfH1KRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:17:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46488 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbfH1KQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:16:47 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2v0O-0000O2-Cy; Wed, 28 Aug 2019 12:16:44 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5AB511C07D2;
        Wed, 28 Aug 2019 12:16:35 +0200 (CEST)
Date:   Wed, 28 Aug 2019 10:16:35 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Deduplicate rlimit handling
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190821192922.653276779@linutronix.de>
References: <20190821192922.653276779@linutronix.de>
MIME-Version: 1.0
Message-ID: <156698739526.5795.11005886170189232333.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     8991afe2640d05a805eba01277856e8549cdc838
Gitweb:        https://git.kernel.org/tip/8991afe2640d05a805eba01277856e8549cdc838
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 21 Aug 2019 21:09:23 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Aug 2019 11:50:42 +02:00

posix-cpu-timers: Deduplicate rlimit handling

Both thread and process expiry functions have the same functionality for
sending signals for soft and hard RLIMITs duplicated in 4 different
ways.

Split it out into a common function and cleanup the callsites.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lkml.kernel.org/r/20190821192922.653276779@linutronix.de

---
 kernel/time/posix-cpu-timers.c | 67 ++++++++++++---------------------
 1 file changed, 25 insertions(+), 42 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 115c8df..ef39a7a 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -772,6 +772,20 @@ static inline void check_dl_overrun(struct task_struct *tsk)
 	}
 }
 
+static bool check_rlimit(u64 time, u64 limit, int signo, bool rt, bool hard)
+{
+	if (time < limit)
+		return false;
+
+	if (print_fatal_signals) {
+		pr_info("%s Watchdog Timeout (%s): %s[%d]\n",
+			rt ? "RT" : "CPU", hard ? "hard" : "soft",
+			current->comm, task_pid_nr(current));
+	}
+	__group_send_sig_info(signo, SEND_SIG_PRIV, current);
+	return true;
+}
+
 /*
  * Check for any per-thread CPU timers that have fired and move them off
  * the tsk->cpu_timers[N] list onto the firing list.  Here we update the
@@ -799,34 +813,18 @@ static void check_thread_timers(struct task_struct *tsk,
 	soft = task_rlimit(tsk, RLIMIT_RTTIME);
 	if (soft != RLIM_INFINITY) {
 		/* Task RT timeout is accounted in jiffies. RTTIME is usec */
-		unsigned long rtim = tsk->rt.timeout * (USEC_PER_SEC / HZ);
+		unsigned long rttime = tsk->rt.timeout * (USEC_PER_SEC / HZ);
 		unsigned long hard = task_rlimit_max(tsk, RLIMIT_RTTIME);
 
-		if (hard != RLIM_INFINITY && rtim >= hard) {
-			/*
-			 * At the hard limit, we just die.
-			 * No need to calculate anything else now.
-			 */
-			if (print_fatal_signals) {
-				pr_info("CPU Watchdog Timeout (hard): %s[%d]\n",
-					tsk->comm, task_pid_nr(tsk));
-			}
-			__group_send_sig_info(SIGKILL, SEND_SIG_PRIV, tsk);
+		/* At the hard limit, send SIGKILL. No further action. */
+		if (hard != RLIM_INFINITY &&
+		    check_rlimit(rttime, hard, SIGKILL, true, true))
 			return;
-		}
 
-		if (rtim >= soft) {
-			/*
-			 * At the soft limit, send a SIGXCPU every second.
-			 */
+		/* At the soft limit, send a SIGXCPU every second */
+		if (check_rlimit(rttime, soft, SIGXCPU, true, false)) {
 			soft += USEC_PER_SEC;
 			tsk->signal->rlim[RLIMIT_RTTIME].rlim_cur = soft;
-
-			if (print_fatal_signals) {
-				pr_info("RT Watchdog Timeout (soft): %s[%d]\n",
-					tsk->comm, task_pid_nr(tsk));
-			}
-			__group_send_sig_info(SIGXCPU, SEND_SIG_PRIV, tsk);
 		}
 	}
 
@@ -916,28 +914,13 @@ static void check_process_timers(struct task_struct *tsk,
 		u64 softns = (u64)soft * NSEC_PER_SEC;
 		u64 hardns = (u64)hard * NSEC_PER_SEC;
 
-		if (hard != RLIM_INFINITY && ptime >= hardns) {
-			/*
-			 * At the hard limit, we just die.
-			 * No need to calculate anything else now.
-			 */
-			if (print_fatal_signals) {
-				pr_info("RT Watchdog Timeout (hard): %s[%d]\n",
-					tsk->comm, task_pid_nr(tsk));
-			}
-			__group_send_sig_info(SIGKILL, SEND_SIG_PRIV, tsk);
+		/* At the hard limit, send SIGKILL. No further action. */
+		if (hard != RLIM_INFINITY &&
+		    check_rlimit(ptime, hardns, SIGKILL, false, true))
 			return;
-		}
-		if (ptime >= softns) {
-			/*
-			 * At the soft limit, send a SIGXCPU every second.
-			 */
-			if (print_fatal_signals) {
-				pr_info("CPU Watchdog Timeout (soft): %s[%d]\n",
-					tsk->comm, task_pid_nr(tsk));
-			}
-			__group_send_sig_info(SIGXCPU, SEND_SIG_PRIV, tsk);
 
+		/* At the soft limit, send a SIGXCPU every second */
+		if (check_rlimit(ptime, softns, SIGXCPU, false, false)) {
 			sig->rlim[RLIMIT_CPU].rlim_cur = soft + 1;
 			softns += NSEC_PER_SEC;
 		}
