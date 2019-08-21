Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299C8C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04BE22064A
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbfHUTcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 15:32:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57277 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730126AbfHUTbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 15:31:02 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i0WJw-0004E8-5Q; Wed, 21 Aug 2019 21:31:00 +0200
Message-Id: <20190821192921.408222378@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 21 Aug 2019 21:09:10 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: [patch V2 23/38] posix-cpu-timers: Switch check_*_timers() to array
 cache
References: <20190821190847.665673890@linutronix.de>
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
@@ -778,8 +778,7 @@ static void check_thread_timers(struct t
 				struct list_head *firing)
 {
 	struct list_head *timers = tsk->posix_cputimers.cpu_timers;
-	struct task_cputime *tsk_expires = &tsk->posix_cputimers.cputime_expires;
-	u64 expires, stime, utime;
+	u64 stime, utime, *expires = tsk->posix_cputimers.expiries;
 	unsigned long soft;
 
 	if (dl_task(tsk))
@@ -789,19 +788,14 @@ static void check_thread_timers(struct t
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
@@ -839,7 +833,8 @@ static void check_thread_timers(struct t
 			__group_send_sig_info(SIGXCPU, SEND_SIG_PRIV, tsk);
 		}
 	}
-	if (task_cputime_zero(tsk_expires))
+
+	if (task_cputime_zero(&tsk->posix_cputimers.cputime_expires))
 		tick_dep_clear_task(tsk, TICK_DEP_BIT_POSIX_TIMER);
 }
 
@@ -958,9 +953,10 @@ static void check_process_timers(struct
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
 


