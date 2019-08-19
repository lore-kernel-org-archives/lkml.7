Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAB0C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E122070B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbfHSPrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 11:47:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47790 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbfHSPpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:45:54 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzjqw-00070y-UF; Mon, 19 Aug 2019 17:45:51 +0200
Message-Id: <20190819143804.840949051@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 19 Aug 2019 16:32:17 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [patch 36/44] posix-cpu-timers: Get rid of zero checks
References: <20190819143141.221906747@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deactivation of the expiry cache is done by setting all clock caches to
0. That requires to have a check for zero in all places which update the
expiry cache:

	if (cache == 0 || new < cache)
		cache = new;

Use U64_MAX as the deactivated value, which allows to remove the zero
checks when updating the cache and reduces it to the obvious check:

	if (new < cache)
		cache = new;

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/posix-timers.h   |    4 +++-
 kernel/time/posix-cpu-timers.c |   36 ++++++++++++++----------------------
 2 files changed, 17 insertions(+), 23 deletions(-)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -77,7 +77,7 @@ struct posix_cputimers {
 
 static inline void posix_cputimers_init(struct posix_cputimers *pct)
 {
-	memset(&pct->expiries, 0, sizeof(pct->expiries));
+	memset(&pct->expiries, 0xff, sizeof(pct->expiries));
 	INIT_LIST_HEAD(&pct->cpu_timers[0]);
 	INIT_LIST_HEAD(&pct->cpu_timers[1]);
 	INIT_LIST_HEAD(&pct->cpu_timers[2]);
@@ -106,8 +106,10 @@ static inline void posix_cputimers_rt_wa
 
 #define INIT_CPU_TIMERS(s)						\
 	.posix_cputimers = {						\
+		.expiries   = { U64_MAX, U64_MAX, U64_MAX },		\
 		.cpu_timers = INIT_CPU_TIMERLISTS(s.posix_cputimers),	\
 	},
+
 #else
 struct posix_cputimers { };
 #define INIT_CPU_TIMERS(s)
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -115,9 +115,10 @@ static void bump_cpu_timer(struct k_itim
 	}
 }
 
-static inline bool expiry_cache_is_zero(const u64 *ec)
+/* Check whether all cache entries contain U64_MAX, i.e. eternal expiry time */
+static inline bool expiry_cache_is_inactive(const u64 *ec)
 {
-	return !(ec[CPUCLOCK_PROF] | ec[CPUCLOCK_VIRT] | ec[CPUCLOCK_SCHED]);
+	return !(~ec[CPUCLOCK_PROF] | ~ec[CPUCLOCK_VIRT] | ~ec[CPUCLOCK_SCHED]);
 }
 
 static int
@@ -434,11 +435,6 @@ void posix_cpu_timers_exit_group(struct
 	cleanup_timers(&tsk->signal->posix_cputimers);
 }
 
-static inline int expires_gt(u64 expires, u64 new_exp)
-{
-	return expires == 0 || expires > new_exp;
-}
-
 /*
  * Insert the timer on the appropriate list before any timers that
  * expire later.  This must be called with the sighand lock held.
@@ -477,7 +473,7 @@ static void arm_timer(struct k_itimer *t
 	 * for process timers we share expiration cache with itimers
 	 * and RLIMIT_CPU and for thread timers with RLIMIT_RTTIME.
 	 */
-	if (expires_gt(*cpuexp, newexp))
+	if (newexp < *cpuexp)
 		*cpuexp = newexp;
 
 	if (CPUCLOCK_PERTHREAD(timer->it_clock))
@@ -747,7 +743,7 @@ check_timers_list(struct list_head *time
 		list_move_tail(&t->entry, firing);
 	}
 
-	return 0;
+	return U64_MAX;
 }
 
 static inline void check_dl_overrun(struct task_struct *tsk)
@@ -773,11 +769,7 @@ static void check_thread_timers(struct t
 	if (dl_task(tsk))
 		check_dl_overrun(tsk);
 
-	/*
-	 * If the expiry cache is zero, then there are no active per thread
-	 * CPU timers.
-	 */
-	if (expiry_cache_is_zero(tsk->posix_cputimers.expiries))
+	if (expiry_cache_is_inactive(tsk->posix_cputimers.expiries))
 		return;
 
 	task_cputime(tsk, &utime, &stime);
@@ -823,7 +815,7 @@ static void check_thread_timers(struct t
 		}
 	}
 
-	if (expiry_cache_is_zero(tsk->posix_cputimers.expiries))
+	if (expiry_cache_is_inactive(tsk->posix_cputimers.expiries))
 		tick_dep_clear_task(tsk, TICK_DEP_BIT_POSIX_TIMER);
 }
 
@@ -854,7 +846,7 @@ static void check_cpu_itimer(struct task
 		__group_send_sig_info(signo, SEND_SIG_PRIV, tsk);
 	}
 
-	if (it->expires && (!*expires || it->expires < *expires))
+	if (it->expires && it->expires < *expires)
 		*expires = it->expires;
 }
 
@@ -935,14 +927,14 @@ static void check_process_timers(struct
 			}
 		}
 		softns = soft * NSEC_PER_SEC;
-		if (!prof_exp || softns < prof_exp)
+		if (softns < prof_exp)
 			prof_exp = softns;
 	}
 
 	store_samples(sig->posix_cputimers.expiries, prof_exp, virt_exp,
 		      sched_exp);
 
-	if (expiry_cache_is_zero(sig->posix_cputimers.expiries))
+	if (expiry_cache_is_inactive(sig->posix_cputimers.expiries))
 		stop_process_timers(sig);
 
 	sig->cputimer.checking_timer = false;
@@ -1013,14 +1005,14 @@ static void posix_cpu_timer_rearm(struct
  * @expiries:	Array of expiry values for the CPUCLOCK clocks
  *
  * Returns true if any mmember of @samples is greater than the corresponding
- * member of @expiries if that member is non zero. False otherwise
+ * member of @expiries. False otherwise
  */
 static inline bool task_cputimers_expired(const u64 *sample, const u64 *expiries)
 {
 	int i;
 
 	for (i = 0; i < CPUCLOCK_MAX; i++) {
-		if (expiries[i] && sample[i] >= expiries[i])
+		if (sample[i] >= expiries[i])
 			return true;
 	}
 	return false;
@@ -1041,7 +1033,7 @@ static inline bool fastpath_timer_check(
 	u64 *expiries = tsk->posix_cputimers.expiries;
 	struct signal_struct *sig;
 
-	if (!expiry_cache_is_zero(expiries)) {
+	if (!expiry_cache_is_inactive(expiries)) {
 		u64 samples[CPUCLOCK_MAX];
 
 		task_sample_cputime(tsk, samples);
@@ -1200,7 +1192,7 @@ void set_process_cpu_timer(struct task_s
 	 * Update expiration cache if this is the earliest timer. CPUCLOCK_PROF
 	 * expiry cache is also used by RLIMIT_CPU!.
 	 */
-	if (expires_gt(*expiry, *newval))
+	if (*newval < *expiry)
 		*expiry = *newval;
 
 	tick_dep_set_signal(tsk->signal, TICK_DEP_BIT_POSIX_TIMER);


