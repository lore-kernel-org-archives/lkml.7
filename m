Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28D4C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D12722070B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfHSPqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 11:46:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47817 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbfHSPp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:45:56 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzjqz-00072b-AD; Mon, 19 Aug 2019 17:45:53 +0200
Message-Id: <20190819143805.328815191@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 19 Aug 2019 16:32:22 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [patch 41/44] posix-cpu-timers: Deduplicate rlimit handling
References: <20190819143141.221906747@linutronix.de>
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
 kernel/time/posix-cpu-timers.c |   71 +++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 44 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -765,6 +765,20 @@ static inline void check_dl_overrun(stru
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
@@ -792,34 +806,18 @@ static void check_thread_timers(struct t
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
 
@@ -904,31 +902,16 @@ static void check_process_timers(struct
 		/* RLIMIT_CPU is in seconds. Samples are nanoseconds */
 		unsigned long hard = task_rlimit_max(tsk, RLIMIT_CPU);
 		u64 ptime = samples[CPUCLOCK_PROF];
-		u64 softns = (u64)soft * NSEC_PER_SEC;
-		u64 hardns = (u64)hard * NSEC_PER_SEC;
+		u64 softns = soft * NSEC_PER_SEC;
+		u64 hardns = hard * NSEC_PER_SEC;
 
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
 			soft++;
 			sig->rlim[RLIMIT_CPU].rlim_cur = soft;
 		}


