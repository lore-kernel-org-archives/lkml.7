Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9352EC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7106C20679
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730441AbfHUTbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 15:31:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57368 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730261AbfHUTbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 15:31:13 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i0WK6-0004H8-Oe; Wed, 21 Aug 2019 21:31:10 +0200
Message-Id: <20190821192922.653276779@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 21 Aug 2019 21:09:23 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: [patch V2 36/38] posix-cpu-timers: Deduplicate rlimit handling
References: <20190821190847.665673890@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both thread and process expiry functions have the same functionality for
sending signals for soft and hard RLIMITs duplicated in 4 different
ways.

Split it out into a common function and cleanup the callsites.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Restore the dropped (u64) casts
---
 kernel/time/posix-cpu-timers.c |   67 +++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 42 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -772,6 +772,20 @@ static inline void check_dl_overrun(stru
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
@@ -799,34 +813,18 @@ static void check_thread_timers(struct t
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
 
@@ -916,28 +914,13 @@ static void check_process_timers(struct
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


