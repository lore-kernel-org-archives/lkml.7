Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4570FC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2322422CE3
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbfHSPrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 11:47:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47737 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbfHSPpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:45:50 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzjqu-0006yr-3M; Mon, 19 Aug 2019 17:45:48 +0200
Message-Id: <20190819143804.235958550@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 19 Aug 2019 16:32:11 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [patch 30/44] posix-cpu-timers: Switch check_*_timers() to array cache
References: <20190819143141.221906747@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the array based expiry cache in check_thread_timers() and convert the
store in check_process_timers() for consistency.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-cpu-timers.c |   26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -771,8 +771,7 @@ static void check_thread_timers(struct t
 				struct list_head *firing)
 {
 	struct list_head *timers = tsk->posix_cputimers.cpu_timers;
-	struct task_cputime *tsk_expires = &tsk->posix_cputimers.cputime_expires;
-	u64 expires, stime, utime;
+	u64 stime, utime, *expires = tsk->posix_cputimers.expiries;
 	unsigned long soft;
 
 	if (dl_task(tsk))
@@ -782,19 +781,14 @@ static void check_thread_timers(struct t
 	 * If cputime_expires is zero, then there are no active
 	 * per thread CPU timers.
 	 */
-	if (task_cputime_zero(tsk_expires))
+	if (task_cputime_zero(&tsk->posix_cputimers.cputime_expires))
 		return;
 
 	task_cputime(tsk, &utime, &stime);
 
-	expires = check_timers_list(timers, firing, utime + stime);
-	tsk_expires->prof_exp = expires;
-
-	expires = check_timers_list(++timers, firing, utime);
-	tsk_expires->virt_exp = expires;
-
-	tsk_expires->sched_exp = check_timers_list(++timers, firing,
-						   tsk->se.sum_exec_runtime);
+	*expires++ = check_timers_list(timers, firing, utime + stime);
+	*expires++ = check_timers_list(++timers, firing, utime);
+	*expires = check_timers_list(++timers, firing, tsk->se.sum_exec_runtime);
 
 	/*
 	 * Check for the special case thread timers.
@@ -832,7 +826,8 @@ static void check_thread_timers(struct t
 			__group_send_sig_info(SIGXCPU, SEND_SIG_PRIV, tsk);
 		}
 	}
-	if (task_cputime_zero(tsk_expires))
+
+	if (task_cputime_zero(&tsk->posix_cputimers.cputime_expires))
 		tick_dep_clear_task(tsk, TICK_DEP_BIT_POSIX_TIMER);
 }
 
@@ -951,9 +946,10 @@ static void check_process_timers(struct
 			prof_expires = x;
 	}
 
-	sig->posix_cputimers.cputime_expires.prof_exp = prof_expires;
-	sig->posix_cputimers.cputime_expires.virt_exp = virt_expires;
-	sig->posix_cputimers.cputime_expires.sched_exp = sched_expires;
+	sig->posix_cputimers.expiries[CPUCLOCK_PROF] = prof_expires;
+	sig->posix_cputimers.expiries[CPUCLOCK_VIRT] = virt_expires;
+	sig->posix_cputimers.expiries[CPUCLOCK_SCHED] = sched_expires;
+
 	if (task_cputime_zero(&sig->posix_cputimers.cputime_expires))
 		stop_process_timers(sig);
 


