Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EC6C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ECD8217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfH1KRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:17:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46441 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfH1KQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:16:41 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2v0F-0000KU-7g; Wed, 28 Aug 2019 12:16:35 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8ED2E1C0DE8;
        Wed, 28 Aug 2019 12:16:31 +0200 (CEST)
Date:   Wed, 28 Aug 2019 10:16:31 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Restructure expiry array
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.1908262021140.1939@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1908262021140.1939@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID: <156698739147.5771.2454985201594571234.tip-bot2@tip-bot2>
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

Commit-ID:     87dc64480fb19a6a0fedbdff1e2557be50673287
Gitweb:        https://git.kernel.org/tip/87dc64480fb19a6a0fedbdff1e2557be50673287
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 26 Aug 2019 20:22:24 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Aug 2019 11:50:39 +02:00

posix-cpu-timers: Restructure expiry array

Now that the abused struct task_cputime is gone, it's more natural to
bundle the expiry cache and the list head of each clock into a struct and
have an array of those structs.

Follow the hrtimer naming convention of 'bases' and rename the expiry cache
to 'nextevt' and adapt all usage sites.

Generates also better code .text size shrinks by 80 bytes.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1908262021140.1939@nanos.tec.linutronix.de

---
 include/linux/posix-timers.h   |  41 +++++++-----
 kernel/time/posix-cpu-timers.c | 105 +++++++++++++++++---------------
 2 files changed, 83 insertions(+), 63 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index fd90984..64bd10d 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -63,24 +63,33 @@ static inline int clockid_to_fd(const clockid_t clk)
 }
 
 #ifdef CONFIG_POSIX_TIMERS
+
 /**
- * posix_cputimers - Container for posix CPU timer related data
- * @expiries:		Earliest-expiration cache array based
+ * posix_cputimer_base - Container per posix CPU clock
+ * @nextevt:		Earliest-expiration cache
  * @cpu_timers:		List heads to queue posix CPU timers
+ */
+struct posix_cputimer_base {
+	u64			nextevt;
+	struct list_head	cpu_timers;
+};
+
+/**
+ * posix_cputimers - Container for posix CPU timer related data
+ * @bases:		Base container for posix CPU clocks
  *
  * Used in task_struct and signal_struct
  */
 struct posix_cputimers {
-	u64			expiries[CPUCLOCK_MAX];
-	struct list_head	cpu_timers[CPUCLOCK_MAX];
+	struct posix_cputimer_base	bases[CPUCLOCK_MAX];
 };
 
 static inline void posix_cputimers_init(struct posix_cputimers *pct)
 {
-	memset(&pct->expiries, 0, sizeof(pct->expiries));
-	INIT_LIST_HEAD(&pct->cpu_timers[0]);
-	INIT_LIST_HEAD(&pct->cpu_timers[1]);
-	INIT_LIST_HEAD(&pct->cpu_timers[2]);
+	memset(pct->bases, 0, sizeof(pct->bases));
+	INIT_LIST_HEAD(&pct->bases[0].cpu_timers);
+	INIT_LIST_HEAD(&pct->bases[1].cpu_timers);
+	INIT_LIST_HEAD(&pct->bases[2].cpu_timers);
 }
 
 void posix_cputimers_group_init(struct posix_cputimers *pct, u64 cpu_limit);
@@ -88,19 +97,23 @@ void posix_cputimers_group_init(struct posix_cputimers *pct, u64 cpu_limit);
 static inline void posix_cputimers_rt_watchdog(struct posix_cputimers *pct,
 					       u64 runtime)
 {
-	pct->expiries[CPUCLOCK_SCHED] = runtime;
+	pct->bases[CPUCLOCK_SCHED].nextevt = runtime;
 }
 
 /* Init task static initializer */
-#define INIT_CPU_TIMERLISTS(c)	{					\
-	LIST_HEAD_INIT(c.cpu_timers[0]),				\
-	LIST_HEAD_INIT(c.cpu_timers[1]),				\
-	LIST_HEAD_INIT(c.cpu_timers[2]),				\
+#define INIT_CPU_TIMERBASE(b) {						\
+	.cpu_timers = LIST_HEAD_INIT(b.cpu_timers),			\
+}
+
+#define INIT_CPU_TIMERBASES(b) {					\
+	INIT_CPU_TIMERBASE(b[0]),					\
+	INIT_CPU_TIMERBASE(b[1]),					\
+	INIT_CPU_TIMERBASE(b[2]),					\
 }
 
 #define INIT_CPU_TIMERS(s)						\
 	.posix_cputimers = {						\
-		.cpu_timers = INIT_CPU_TIMERLISTS(s.posix_cputimers),	\
+		.bases = INIT_CPU_TIMERBASES(s.posix_cputimers.bases),	\
 	},
 #else
 struct posix_cputimers { };
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index ffd4918..9ac601a 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -24,13 +24,13 @@ void posix_cputimers_group_init(struct posix_cputimers *pct, u64 cpu_limit)
 {
 	posix_cputimers_init(pct);
 	if (cpu_limit != RLIM_INFINITY)
-		pct->expiries[CPUCLOCK_PROF] = cpu_limit * NSEC_PER_SEC;
+		pct->bases[CPUCLOCK_PROF].nextevt = cpu_limit * NSEC_PER_SEC;
 }
 
 /*
  * Called after updating RLIMIT_CPU to run cpu timer and update
- * tsk->signal->posix_cputimers.expiries expiration cache if
- * necessary. Needs siglock protection since other code may update
+ * tsk->signal->posix_cputimers.bases[clock].nextevt expiration cache if
+ * necessary. Needs siglock protection since other code may update the
  * expiration cache as well.
  */
 void update_rlimit_cpu(struct task_struct *task, unsigned long rlim_new)
@@ -122,9 +122,11 @@ static void bump_cpu_timer(struct k_itimer *timer, u64 now)
 	}
 }
 
-static inline bool expiry_cache_is_zero(const u64 *ec)
+static inline bool expiry_cache_is_zero(const struct posix_cputimers *pct)
 {
-	return !(ec[CPUCLOCK_PROF] | ec[CPUCLOCK_VIRT] | ec[CPUCLOCK_SCHED]);
+	return !(pct->bases[CPUCLOCK_PROF].nextevt |
+		 pct->bases[CPUCLOCK_VIRT].nextevt |
+		 pct->bases[CPUCLOCK_SCHED].nextevt);
 }
 
 static int
@@ -432,9 +434,9 @@ static void cleanup_timers_list(struct list_head *head)
  */
 static void cleanup_timers(struct posix_cputimers *pct)
 {
-	cleanup_timers_list(&pct->cpu_timers[CPUCLOCK_PROF]);
-	cleanup_timers_list(&pct->cpu_timers[CPUCLOCK_VIRT]);
-	cleanup_timers_list(&pct->cpu_timers[CPUCLOCK_SCHED]);
+	cleanup_timers_list(&pct->bases[CPUCLOCK_PROF].cpu_timers);
+	cleanup_timers_list(&pct->bases[CPUCLOCK_VIRT].cpu_timers);
+	cleanup_timers_list(&pct->bases[CPUCLOCK_SCHED].cpu_timers);
 }
 
 /*
@@ -464,21 +466,19 @@ static void arm_timer(struct k_itimer *timer)
 {
 	struct cpu_timer_list *const nt = &timer->it.cpu;
 	int clkidx = CPUCLOCK_WHICH(timer->it_clock);
-	u64 *cpuexp, newexp = timer->it.cpu.expires;
 	struct task_struct *p = timer->it.cpu.task;
+	u64 newexp = timer->it.cpu.expires;
+	struct posix_cputimer_base *base;
 	struct list_head *head, *listpos;
 	struct cpu_timer_list *next;
 
-	if (CPUCLOCK_PERTHREAD(timer->it_clock)) {
-		head = p->posix_cputimers.cpu_timers + clkidx;
-		cpuexp = p->posix_cputimers.expiries + clkidx;
-	} else {
-		head = p->signal->posix_cputimers.cpu_timers + clkidx;
-		cpuexp = p->signal->posix_cputimers.expiries + clkidx;
-	}
+	if (CPUCLOCK_PERTHREAD(timer->it_clock))
+		base = p->posix_cputimers.bases + clkidx;
+	else
+		base = p->signal->posix_cputimers.bases + clkidx;
 
-	listpos = head;
-	list_for_each_entry(next, head, entry) {
+	listpos = head = &base->cpu_timers;
+	list_for_each_entry(next,head, entry) {
 		if (nt->expires < next->expires)
 			break;
 		listpos = &next->entry;
@@ -494,8 +494,8 @@ static void arm_timer(struct k_itimer *timer)
 	 * for process timers we share expiration cache with itimers
 	 * and RLIMIT_CPU and for thread timers with RLIMIT_RTTIME.
 	 */
-	if (expires_gt(*cpuexp, newexp))
-		*cpuexp = newexp;
+	if (expires_gt(base->nextevt, newexp))
+		base->nextevt = newexp;
 
 	if (CPUCLOCK_PERTHREAD(timer->it_clock))
 		tick_dep_set_task(p, TICK_DEP_BIT_POSIX_TIMER);
@@ -783,9 +783,9 @@ static inline void check_dl_overrun(struct task_struct *tsk)
 static void check_thread_timers(struct task_struct *tsk,
 				struct list_head *firing)
 {
-	struct list_head *timers = tsk->posix_cputimers.cpu_timers;
-	u64 stime, utime, *expires = tsk->posix_cputimers.expiries;
+	struct posix_cputimer_base *base = tsk->posix_cputimers.bases;
 	unsigned long soft;
+	u64 stime, utime;
 
 	if (dl_task(tsk))
 		check_dl_overrun(tsk);
@@ -794,14 +794,18 @@ static void check_thread_timers(struct task_struct *tsk,
 	 * If the expiry cache is zero, then there are no active per thread
 	 * CPU timers.
 	 */
-	if (expiry_cache_is_zero(tsk->posix_cputimers.expiries))
+	if (expiry_cache_is_zero(&tsk->posix_cputimers))
 		return;
 
 	task_cputime(tsk, &utime, &stime);
 
-	*expires++ = check_timers_list(timers, firing, utime + stime);
-	*expires++ = check_timers_list(++timers, firing, utime);
-	*expires = check_timers_list(++timers, firing, tsk->se.sum_exec_runtime);
+	base->nextevt = check_timers_list(&base->cpu_timers, firing,
+					  utime + stime);
+	base++;
+	base->nextevt = check_timers_list(&base->cpu_timers, firing, utime);
+	base++;
+	base->nextevt = check_timers_list(&base->cpu_timers, firing,
+					  tsk->se.sum_exec_runtime);
 
 	/*
 	 * Check for the special case thread timers.
@@ -840,7 +844,7 @@ static void check_thread_timers(struct task_struct *tsk,
 		}
 	}
 
-	if (expiry_cache_is_zero(tsk->posix_cputimers.expiries))
+	if (expiry_cache_is_zero(&tsk->posix_cputimers))
 		tick_dep_clear_task(tsk, TICK_DEP_BIT_POSIX_TIMER);
 }
 
@@ -884,7 +888,7 @@ static void check_process_timers(struct task_struct *tsk,
 				 struct list_head *firing)
 {
 	struct signal_struct *const sig = tsk->signal;
-	struct list_head *timers = sig->posix_cputimers.cpu_timers;
+	struct posix_cputimer_base *base = sig->posix_cputimers.bases;
 	u64 utime, ptime, virt_expires, prof_expires;
 	u64 sum_sched_runtime, sched_expires;
 	struct task_cputime cputime;
@@ -912,9 +916,12 @@ static void check_process_timers(struct task_struct *tsk,
 	ptime = utime + cputime.stime;
 	sum_sched_runtime = cputime.sum_exec_runtime;
 
-	prof_expires = check_timers_list(timers, firing, ptime);
-	virt_expires = check_timers_list(++timers, firing, utime);
-	sched_expires = check_timers_list(++timers, firing, sum_sched_runtime);
+	prof_expires = check_timers_list(&base[CPUCLOCK_PROF].cpu_timers,
+					 firing, ptime);
+	virt_expires = check_timers_list(&base[CPUCLOCK_VIRT].cpu_timers,
+					 firing, utime);
+	sched_expires = check_timers_list(&base[CPUCLOCK_SCHED].cpu_timers,
+					  firing, sum_sched_runtime);
 
 	/*
 	 * Check for the special case process timers.
@@ -959,11 +966,11 @@ static void check_process_timers(struct task_struct *tsk,
 			prof_expires = x;
 	}
 
-	sig->posix_cputimers.expiries[CPUCLOCK_PROF] = prof_expires;
-	sig->posix_cputimers.expiries[CPUCLOCK_VIRT] = virt_expires;
-	sig->posix_cputimers.expiries[CPUCLOCK_SCHED] = sched_expires;
+	base[CPUCLOCK_PROF].nextevt = prof_expires;
+	base[CPUCLOCK_VIRT].nextevt = virt_expires;
+	base[CPUCLOCK_SCHED].nextevt = sched_expires;
 
-	if (expiry_cache_is_zero(sig->posix_cputimers.expiries))
+	if (expiry_cache_is_zero(&sig->posix_cputimers))
 		stop_process_timers(sig);
 
 	sig->cputimer.checking_timer = false;
@@ -1028,20 +1035,21 @@ static void posix_cpu_timer_rearm(struct k_itimer *timer)
 }
 
 /**
- * task_cputimers_expired - Compare two task_cputime entities.
+ * task_cputimers_expired - Check whether posix CPU timers are expired
  *
  * @samples:	Array of current samples for the CPUCLOCK clocks
- * @expiries:	Array of expiry values for the CPUCLOCK clocks
+ * @pct:	Pointer to a posix_cputimers container
  *
- * Returns true if any mmember of @samples is greater than the corresponding
- * member of @expiries if that member is non zero. False otherwise
+ * Returns true if any member of @samples is greater than the corresponding
+ * member of @pct->bases[CLK].nextevt. False otherwise
  */
-static inline bool task_cputimers_expired(const u64 *sample, const u64 *expiries)
+static inline bool
+task_cputimers_expired(const u64 *sample, struct posix_cputimers *pct)
 {
 	int i;
 
 	for (i = 0; i < CPUCLOCK_MAX; i++) {
-		if (expiries[i] && sample[i] >= expiries[i])
+		if (pct->bases[i].nextevt && sample[i] >= pct->bases[i].nextevt)
 			return true;
 	}
 	return false;
@@ -1059,14 +1067,13 @@ static inline bool task_cputimers_expired(const u64 *sample, const u64 *expiries
  */
 static inline bool fastpath_timer_check(struct task_struct *tsk)
 {
-	u64 *expiries = tsk->posix_cputimers.expiries;
 	struct signal_struct *sig;
 
-	if (!expiry_cache_is_zero(expiries)) {
+	if (!expiry_cache_is_zero(&tsk->posix_cputimers)) {
 		u64 samples[CPUCLOCK_MAX];
 
 		task_sample_cputime(tsk, samples);
-		if (task_cputimers_expired(samples, expiries))
+		if (task_cputimers_expired(samples, &tsk->posix_cputimers))
 			return true;
 	}
 
@@ -1092,8 +1099,7 @@ static inline bool fastpath_timer_check(struct task_struct *tsk)
 		proc_sample_cputime_atomic(&sig->cputimer.cputime_atomic,
 					   samples);
 
-		if (task_cputimers_expired(samples,
-					   sig->posix_cputimers.expiries))
+		if (task_cputimers_expired(samples, &sig->posix_cputimers))
 			return true;
 	}
 
@@ -1176,11 +1182,12 @@ void run_posix_cpu_timers(void)
 void set_process_cpu_timer(struct task_struct *tsk, unsigned int clkid,
 			   u64 *newval, u64 *oldval)
 {
-	u64 now, *expiry = tsk->signal->posix_cputimers.expiries + clkid;
+	u64 now, *nextevt;
 
 	if (WARN_ON_ONCE(clkid >= CPUCLOCK_SCHED))
 		return;
 
+	nextevt = &tsk->signal->posix_cputimers.bases[clkid].nextevt;
 	now = cpu_clock_sample_group(clkid, tsk, true);
 
 	if (oldval) {
@@ -1207,8 +1214,8 @@ void set_process_cpu_timer(struct task_struct *tsk, unsigned int clkid,
 	 * Update expiration cache if this is the earliest timer. CPUCLOCK_PROF
 	 * expiry cache is also used by RLIMIT_CPU!.
 	 */
-	if (expires_gt(*expiry, *newval))
-		*expiry = *newval;
+	if (expires_gt(*nextevt, *newval))
+		*nextevt = *newval;
 
 	tick_dep_set_signal(tsk->signal, TICK_DEP_BIT_POSIX_TIMER);
 }
