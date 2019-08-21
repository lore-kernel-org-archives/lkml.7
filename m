Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C65C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071512064A
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbfHUTbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 15:31:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57338 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730222AbfHUTbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 15:31:10 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i0WK3-0004GJ-Ra; Wed, 21 Aug 2019 21:31:07 +0200
Message-Id: <20190821192922.275086128@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 21 Aug 2019 21:09:19 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: [patch V2 32/38] posix-cpu-timers: Get rid of zero checks
References: <20190821190847.665673890@linutronix.de>
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

This also removes the weird workaround in do_prlimit() which was required
to convert a RLIMIT_CPU value of 0 (immediate expiry) to 1 because handing
in 0 to the posix CPU timer code would have effectively disarmed it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Adopt to the per clock base struct and cleanup the rlimit setter code.
---
 include/linux/posix-timers.h   |    7 +++++--
 kernel/sys.c                   |    9 ---------
 kernel/time/posix-cpu-timers.c |   36 ++++++++++++++----------------------
 3 files changed, 19 insertions(+), 33 deletions(-)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -86,7 +86,9 @@ struct posix_cputimers {
 
 static inline void posix_cputimers_init(struct posix_cputimers *pct)
 {
-	memset(pct->bases, 0, sizeof(pct->bases));
+	pct->bases[0].nextevt = U64_MAX;
+	pct->bases[1].nextevt = U64_MAX;
+	pct->bases[2].nextevt = U64_MAX;
 	INIT_LIST_HEAD(&pct->bases[0].cpu_timers);
 	INIT_LIST_HEAD(&pct->bases[1].cpu_timers);
 	INIT_LIST_HEAD(&pct->bases[2].cpu_timers);
@@ -102,7 +104,8 @@ static inline void posix_cputimers_rt_wa
 
 /* Init task static initializer */
 #define INIT_CPU_TIMERBASE(b) {						\
-	.cpu_timers = LIST_HEAD_INIT(b.cpu_timers),			\
+	.nextevt	= U64_MAX,					\
+	.cpu_timers	= LIST_HEAD_INIT(b.cpu_timers),			\
 }
 
 #define INIT_CPU_TIMERBASES(b) {					\
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1557,15 +1557,6 @@ int do_prlimit(struct task_struct *tsk,
 			retval = -EPERM;
 		if (!retval)
 			retval = security_task_setrlimit(tsk, resource, new_rlim);
-		if (resource == RLIMIT_CPU && new_rlim->rlim_cur == 0) {
-			/*
-			 * The caller is asking for an immediate RLIMIT_CPU
-			 * expiry.  But we use the zero value to mean "it was
-			 * never set".  So let's cheat and make it one second
-			 * instead
-			 */
-			new_rlim->rlim_cur = 1;
-		}
 	}
 	if (!retval) {
 		if (old_rlim)
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -122,11 +122,12 @@ static void bump_cpu_timer(struct k_itim
 	}
 }
 
-static inline bool expiry_cache_is_zero(const struct posix_cputimers *pct)
+/* Check whether all cache entries contain U64_MAX, i.e. eternal expiry time */
+static inline bool expiry_cache_is_inactive(const struct posix_cputimers *pct)
 {
-	return !(pct->bases[CPUCLOCK_PROF].nextevt |
-		 pct->bases[CPUCLOCK_VIRT].nextevt |
-		 pct->bases[CPUCLOCK_SCHED].nextevt);
+	return !(~pct->bases[CPUCLOCK_PROF].nextevt |
+		 ~pct->bases[CPUCLOCK_VIRT].nextevt |
+		 ~pct->bases[CPUCLOCK_SCHED].nextevt);
 }
 
 static int
@@ -442,11 +443,6 @@ void posix_cpu_timers_exit_group(struct
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
@@ -483,7 +479,7 @@ static void arm_timer(struct k_itimer *t
 	 * for process timers we share expiration cache with itimers
 	 * and RLIMIT_CPU and for thread timers with RLIMIT_RTTIME.
 	 */
-	if (expires_gt(base->nextevt, newexp))
+	if (newexp < base->nextevt)
 		base->nextevt = newexp;
 
 	if (CPUCLOCK_PERTHREAD(timer->it_clock))
@@ -753,7 +749,7 @@ check_timers_list(struct list_head *time
 		list_move_tail(&t->entry, firing);
 	}
 
-	return 0;
+	return U64_MAX;
 }
 
 static inline void check_dl_overrun(struct task_struct *tsk)
@@ -779,11 +775,7 @@ static void check_thread_timers(struct t
 	if (dl_task(tsk))
 		check_dl_overrun(tsk);
 
-	/*
-	 * If the expiry cache is zero, then there are no active per thread
-	 * CPU timers.
-	 */
-	if (expiry_cache_is_zero(&tsk->posix_cputimers))
+	if (expiry_cache_is_inactive(&tsk->posix_cputimers))
 		return;
 
 	task_cputime(tsk, &utime, &stime);
@@ -833,7 +825,7 @@ static void check_thread_timers(struct t
 		}
 	}
 
-	if (expiry_cache_is_zero(&tsk->posix_cputimers))
+	if (expiry_cache_is_inactive(&tsk->posix_cputimers))
 		tick_dep_clear_task(tsk, TICK_DEP_BIT_POSIX_TIMER);
 }
 
@@ -864,7 +856,7 @@ static void check_cpu_itimer(struct task
 		__group_send_sig_info(signo, SEND_SIG_PRIV, tsk);
 	}
 
-	if (it->expires && (!*expires || it->expires < *expires))
+	if (it->expires && it->expires < *expires)
 		*expires = it->expires;
 }
 
@@ -948,7 +940,7 @@ static void check_process_timers(struct
 			}
 		}
 		softns = soft * NSEC_PER_SEC;
-		if (!prof_exp || softns < prof_exp)
+		if (softns < prof_exp)
 			prof_exp = softns;
 	}
 
@@ -956,7 +948,7 @@ static void check_process_timers(struct
 	base[CPUCLOCK_VIRT].nextevt = virt_exp;
 	base[CPUCLOCK_SCHED].nextevt = sched_exp;
 
-	if (expiry_cache_is_zero(&sig->posix_cputimers))
+	if (expiry_cache_is_inactive(&sig->posix_cputimers))
 		stop_process_timers(sig);
 
 	sig->cputimer.checking_timer = false;
@@ -1055,7 +1047,7 @@ static inline bool fastpath_timer_check(
 {
 	struct signal_struct *sig;
 
-	if (!expiry_cache_is_zero(&tsk->posix_cputimers)) {
+	if (!expiry_cache_is_inactive(&tsk->posix_cputimers)) {
 		u64 samples[CPUCLOCK_MAX];
 
 		task_sample_cputime(tsk, samples);
@@ -1199,7 +1191,7 @@ void set_process_cpu_timer(struct task_s
 	 * Update expiration cache if this is the earliest timer. CPUCLOCK_PROF
 	 * expiry cache is also used by RLIMIT_CPU!.
 	 */
-	if (expires_gt(*nextevt, *newval))
+	if (*newval < *nextevt)
 		*nextevt = *newval;
 
 	tick_dep_set_signal(tsk->signal, TICK_DEP_BIT_POSIX_TIMER);


