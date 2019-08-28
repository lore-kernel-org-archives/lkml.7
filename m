Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B199C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F282189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfH1KR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:17:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46461 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbfH1KQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:16:43 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2v0I-0000Jj-85; Wed, 28 Aug 2019 12:16:38 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B31481C0DE4;
        Wed, 28 Aug 2019 12:16:30 +0200 (CEST)
Date:   Wed, 28 Aug 2019 10:16:30 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Make expiry checks array based
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190821192921.695481430@linutronix.de>
References: <20190821192921.695481430@linutronix.de>
MIME-Version: 1.0
Message-ID: <156698739066.5765.12481793314438472083.tip-bot2@tip-bot2>
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

Commit-ID:     001f7971433a53bb76443cd8f5827ca27b0bc8ca
Gitweb:        https://git.kernel.org/tip/001f7971433a53bb76443cd8f5827ca27b0bc8ca
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 21 Aug 2019 21:09:13 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Aug 2019 11:50:38 +02:00

posix-cpu-timers: Make expiry checks array based

The expiry cache is an array indexed by clock ids. The new sample functions
allow to retrieve a corresponding array of samples.

Convert the fastpath expiry checks to make use of the new sample functions
and do the comparisons on the sample and the expiry array.

Make the check for the expiry array being zero array based as well.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lkml.kernel.org/r/20190821192921.695481430@linutronix.de

---
 kernel/time/posix-cpu-timers.c | 85 +++++++++++++--------------------
 1 file changed, 36 insertions(+), 49 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 11c841c..e159b03 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -39,7 +39,7 @@ void posix_cputimers_group_init(struct posix_cputimers *pct, u64 cpu_limit)
 
 /*
  * Called after updating RLIMIT_CPU to run cpu timer and update
- * tsk->signal->posix_cputimers.cputime_expires expiration cache if
+ * tsk->signal->posix_cputimers.expiries expiration cache if
  * necessary. Needs siglock protection since other code may update
  * expiration cache as well.
  */
@@ -132,19 +132,9 @@ static void bump_cpu_timer(struct k_itimer *timer, u64 now)
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
@@ -811,10 +801,10 @@ static void check_thread_timers(struct task_struct *tsk,
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
@@ -860,7 +850,7 @@ static void check_thread_timers(struct task_struct *tsk,
 		}
 	}
 
-	if (task_cputime_zero(&tsk->posix_cputimers.cputime_expires))
+	if (expiry_cache_is_zero(tsk->posix_cputimers.expiries))
 		tick_dep_clear_task(tsk, TICK_DEP_BIT_POSIX_TIMER);
 }
 
@@ -983,7 +973,7 @@ static void check_process_timers(struct task_struct *tsk,
 	sig->posix_cputimers.expiries[CPUCLOCK_VIRT] = virt_expires;
 	sig->posix_cputimers.expiries[CPUCLOCK_SCHED] = sched_expires;
 
-	if (task_cputime_zero(&sig->posix_cputimers.cputime_expires))
+	if (expiry_cache_is_zero(sig->posix_cputimers.expiries))
 		stop_process_timers(sig);
 
 	sig->cputimer.checking_timer = false;
@@ -1048,26 +1038,23 @@ static void posix_cpu_timer_rearm(struct k_itimer *timer)
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
@@ -1080,18 +1067,17 @@ static inline int task_cputime_expired(const struct task_cputime *sample,
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
@@ -1111,19 +1097,20 @@ static inline int fastpath_timer_check(struct task_struct *tsk)
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
