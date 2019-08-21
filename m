Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D38C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC6B2332A
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730480AbfHUTcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 15:32:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57295 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730153AbfHUTbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 15:31:05 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i0WJy-0004F7-Kl; Wed, 21 Aug 2019 21:31:02 +0200
Message-Id: <20190821192921.695481430@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 21 Aug 2019 21:09:13 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: [patch V2 26/38] posix-cpu-timers: Make expiry checks array based
References: <20190821190847.665673890@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The expiry cache is an array indexed by clock ids. The new sample functions
allow to retrieve a corresponding array of samples.

Convert the fastpath expiry checks to make use of the new sample functions
and do the comparisons on the sample and the expiry array.

Make the check for the expiry array being zero array based as well.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-cpu-timers.c |   85 +++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 49 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -39,7 +39,7 @@ void posix_cputimers_group_init(struct p
 
 /*
  * Called after updating RLIMIT_CPU to run cpu timer and update
- * tsk->signal->posix_cputimers.cputime_expires expiration cache if
+ * tsk->signal->posix_cputimers.expiries expiration cache if
  * necessary. Needs siglock protection since other code may update
  * expiration cache as well.
  */
@@ -132,19 +132,9 @@ static void bump_cpu_timer(struct k_itim
 	}
 }
 
-/**
- * task_cputime_zero - Check a task_cputime struct for all zero fields.
- *
- * @cputime:	The struct to compare.
- *
- * Checks @cputime to see if all fields are zero.  Returns true if all fields
- * are zero, false if any field is nonzero.
- */
-static inline int task_cputime_zero(const struct task_cputime *cputime)
+static inline bool expiry_cache_is_zero(const u64 *ec)
 {
-	if (!cputime->utime && !cputime->stime && !cputime->sum_exec_runtime)
-		return 1;
-	return 0;
+	return !(ec[CPUCLOCK_PROF] | ec[CPUCLOCK_VIRT] | ec[CPUCLOCK_SCHED]);
 }
 
 static int
@@ -811,10 +801,10 @@ static void check_thread_timers(struct t
 		check_dl_overrun(tsk);
 
 	/*
-	 * If cputime_expires is zero, then there are no active
-	 * per thread CPU timers.
+	 * If the expiry cache is zero, then there are no active per thread
+	 * CPU timers.
 	 */
-	if (task_cputime_zero(&tsk->posix_cputimers.cputime_expires))
+	if (expiry_cache_is_zero(tsk->posix_cputimers.expiries))
 		return;
 
 	task_cputime(tsk, &utime, &stime);
@@ -860,7 +850,7 @@ static void check_thread_timers(struct t
 		}
 	}
 
-	if (task_cputime_zero(&tsk->posix_cputimers.cputime_expires))
+	if (expiry_cache_is_zero(tsk->posix_cputimers.expiries))
 		tick_dep_clear_task(tsk, TICK_DEP_BIT_POSIX_TIMER);
 }
 
@@ -983,7 +973,7 @@ static void check_process_timers(struct
 	sig->posix_cputimers.expiries[CPUCLOCK_VIRT] = virt_expires;
 	sig->posix_cputimers.expiries[CPUCLOCK_SCHED] = sched_expires;
 
-	if (task_cputime_zero(&sig->posix_cputimers.cputime_expires))
+	if (expiry_cache_is_zero(sig->posix_cputimers.expiries))
 		stop_process_timers(sig);
 
 	sig->cputimer.checking_timer = false;
@@ -1048,26 +1038,23 @@ static void posix_cpu_timer_rearm(struct
 }
 
 /**
- * task_cputime_expired - Compare two task_cputime entities.
+ * task_cputimers_expired - Compare two task_cputime entities.
  *
- * @sample:	The task_cputime structure to be checked for expiration.
- * @expires:	Expiration times, against which @sample will be checked.
+ * @samples:	Array of current samples for the CPUCLOCK clocks
+ * @expiries:	Array of expiry values for the CPUCLOCK clocks
  *
- * Checks @sample against @expires to see if any field of @sample has expired.
- * Returns true if any field of the former is greater than the corresponding
- * field of the latter if the latter field is set.  Otherwise returns false.
+ * Returns true if any mmember of @samples is greater than the corresponding
+ * member of @expiries if that member is non zero. False otherwise
  */
-static inline int task_cputime_expired(const struct task_cputime *sample,
-					const struct task_cputime *expires)
+static inline bool task_cputimers_expired(const u64 *sample, const u64 *expiries)
 {
-	if (expires->utime && sample->utime >= expires->utime)
-		return 1;
-	if (expires->stime && sample->utime + sample->stime >= expires->stime)
-		return 1;
-	if (expires->sum_exec_runtime != 0 &&
-	    sample->sum_exec_runtime >= expires->sum_exec_runtime)
-		return 1;
-	return 0;
+	int i;
+
+	for (i = 0; i < CPUCLOCK_MAX; i++) {
+		if (expiries[i] && sample[i] >= expiries[i])
+			return true;
+	}
+	return false;
 }
 
 /**
@@ -1080,18 +1067,17 @@ static inline int task_cputime_expired(c
  * timers and compare them with the corresponding expiration times.  Return
  * true if a timer has expired, else return false.
  */
-static inline int fastpath_timer_check(struct task_struct *tsk)
+static inline bool fastpath_timer_check(struct task_struct *tsk)
 {
+	u64 *expiries = tsk->posix_cputimers.expiries;
 	struct signal_struct *sig;
 
-	if (!task_cputime_zero(&tsk->posix_cputimers.cputime_expires)) {
-		struct task_cputime task_sample;
+	if (!expiry_cache_is_zero(expiries)) {
+		u64 samples[CPUCLOCK_MAX];
 
-		task_cputime(tsk, &task_sample.utime, &task_sample.stime);
-		task_sample.sum_exec_runtime = tsk->se.sum_exec_runtime;
-		if (task_cputime_expired(&task_sample,
-					 &tsk->posix_cputimers.cputime_expires))
-			return 1;
+		task_sample_cputime(tsk, samples);
+		if (task_cputimers_expired(samples, expiries))
+			return true;
 	}
 
 	sig = tsk->signal;
@@ -1111,19 +1097,20 @@ static inline int fastpath_timer_check(s
 	 */
 	if (READ_ONCE(sig->cputimer.running) &&
 	    !READ_ONCE(sig->cputimer.checking_timer)) {
-		struct task_cputime group_sample;
+		u64 samples[CPUCLOCK_MAX];
 
-		sample_cputime_atomic(&group_sample, &sig->cputimer.cputime_atomic);
+		proc_sample_cputime_atomic(&sig->cputimer.cputime_atomic,
+					   samples);
 
-		if (task_cputime_expired(&group_sample,
-					 &sig->posix_cputimers.cputime_expires))
-			return 1;
+		if (task_cputimers_expired(samples,
+					   sig->posix_cputimers.expiries))
+			return true;
 	}
 
 	if (dl_task(tsk) && tsk->dl.dl_overrun)
-		return 1;
+		return true;
 
-	return 0;
+	return false;
 }
 
 /*


