Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5F0C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818012189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfH1KQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:16:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46460 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfH1KQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:16:43 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2v0I-0000Md-3H; Wed, 28 Aug 2019 12:16:38 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 11DEA1C0DE7;
        Wed, 28 Aug 2019 12:16:34 +0200 (CEST)
Date:   Wed, 28 Aug 2019 10:16:33 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Consolidate timer expiry further
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190821192922.365469982@linutronix.de>
References: <20190821192922.365469982@linutronix.de>
MIME-Version: 1.0
Message-ID: <156698739395.5786.693651296957117258.tip-bot2@tip-bot2>
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

Commit-ID:     1cd07c0b94f2c320270d76edb7dd49bceb09c1df
Gitweb:        https://git.kernel.org/tip/1cd07c0b94f2c320270d76edb7dd49bceb09c1df
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 21 Aug 2019 21:09:20 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Aug 2019 11:50:41 +02:00

posix-cpu-timers: Consolidate timer expiry further

With the array based samples and expiry cache, the expiry function can use
a loop to collect timers from the clock specific lists.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lkml.kernel.org/r/20190821192922.365469982@linutronix.de

---
 kernel/time/posix-cpu-timers.c | 63 +++++++++++++++------------------
 1 file changed, 30 insertions(+), 33 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index cf85292..caafdfd 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -752,6 +752,18 @@ check_timers_list(struct list_head *timers,
 	return U64_MAX;
 }
 
+static void collect_posix_cputimers(struct posix_cputimers *pct,
+				    u64 *samples, struct list_head *firing)
+{
+	struct posix_cputimer_base *base = pct->bases;
+	int i;
+
+	for (i = 0; i < CPUCLOCK_MAX; i++, base++) {
+		base->nextevt = check_timers_list(&base->cpu_timers, firing,
+						   samples[i]);
+	}
+}
+
 static inline void check_dl_overrun(struct task_struct *tsk)
 {
 	if (tsk->dl.dl_overrun) {
@@ -768,25 +780,18 @@ static inline void check_dl_overrun(struct task_struct *tsk)
 static void check_thread_timers(struct task_struct *tsk,
 				struct list_head *firing)
 {
-	struct posix_cputimer_base *base = tsk->posix_cputimers.bases;
+	struct posix_cputimers *pct = &tsk->posix_cputimers;
+	u64 samples[CPUCLOCK_MAX];
 	unsigned long soft;
-	u64 stime, utime;
 
 	if (dl_task(tsk))
 		check_dl_overrun(tsk);
 
-	if (expiry_cache_is_inactive(&tsk->posix_cputimers))
+	if (expiry_cache_is_inactive(pct))
 		return;
 
-	task_cputime(tsk, &utime, &stime);
-
-	base->nextevt = check_timers_list(&base->cpu_timers, firing,
-					  utime + stime);
-	base++;
-	base->nextevt = check_timers_list(&base->cpu_timers, firing, utime);
-	base++;
-	base->nextevt = check_timers_list(&base->cpu_timers, firing,
-					  tsk->se.sum_exec_runtime);
+	task_sample_cputime(tsk, samples);
+	collect_posix_cputimers(pct, samples, firing);
 
 	/*
 	 * Check for the special case thread timers.
@@ -825,7 +830,7 @@ static void check_thread_timers(struct task_struct *tsk,
 		}
 	}
 
-	if (expiry_cache_is_inactive(&tsk->posix_cputimers))
+	if (expiry_cache_is_inactive(pct))
 		tick_dep_clear_task(tsk, TICK_DEP_BIT_POSIX_TIMER);
 }
 
@@ -869,15 +874,15 @@ static void check_process_timers(struct task_struct *tsk,
 				 struct list_head *firing)
 {
 	struct signal_struct *const sig = tsk->signal;
-	struct posix_cputimer_base *base = sig->posix_cputimers.bases;
-	u64 virt_exp, prof_exp, sched_exp, samples[CPUCLOCK_MAX];
+	struct posix_cputimers *pct = &sig->posix_cputimers;
+	u64 samples[CPUCLOCK_MAX];
 	unsigned long soft;
 
 	/*
 	 * If cputimer is not running, then there are no active
 	 * process wide timers (POSIX 1.b, itimers, RLIMIT_CPU).
 	 */
-	if (!READ_ONCE(tsk->signal->cputimer.running))
+	if (!READ_ONCE(sig->cputimer.running))
 		return;
 
        /*
@@ -891,21 +896,17 @@ static void check_process_timers(struct task_struct *tsk,
 	 * so the sample can be taken directly.
 	 */
 	proc_sample_cputime_atomic(&sig->cputimer.cputime_atomic, samples);
-
-	prof_exp = check_timers_list(&base[CPUCLOCK_PROF].cpu_timers,
-				     firing, samples[CPUCLOCK_PROF]);
-	virt_exp = check_timers_list(&base[CPUCLOCK_VIRT].cpu_timers,
-				     firing, samples[CPUCLOCK_VIRT]);
-	sched_exp = check_timers_list(&base[CPUCLOCK_SCHED].cpu_timers,
-				      firing, samples[CPUCLOCK_SCHED]);
+	collect_posix_cputimers(pct, samples, firing);
 
 	/*
 	 * Check for the special case process timers.
 	 */
-	check_cpu_itimer(tsk, &sig->it[CPUCLOCK_PROF], &prof_exp,
+	check_cpu_itimer(tsk, &sig->it[CPUCLOCK_PROF],
+			 &pct->bases[CPUCLOCK_PROF].nextevt,
 			 samples[CPUCLOCK_PROF], SIGPROF);
-	check_cpu_itimer(tsk, &sig->it[CPUCLOCK_VIRT], &virt_exp,
-			 samples[CPUCLOCK_PROF], SIGVTALRM);
+	check_cpu_itimer(tsk, &sig->it[CPUCLOCK_VIRT],
+			 &pct->bases[CPUCLOCK_VIRT].nextevt,
+			 samples[CPUCLOCK_VIRT], SIGVTALRM);
 
 	soft = task_rlimit(tsk, RLIMIT_CPU);
 	if (soft != RLIM_INFINITY) {
@@ -940,15 +941,11 @@ static void check_process_timers(struct task_struct *tsk,
 			}
 		}
 		softns = soft * NSEC_PER_SEC;
-		if (softns < prof_exp)
-			prof_exp = softns;
+		if (softns < pct->bases[CPUCLOCK_PROF].nextevt)
+			pct->bases[CPUCLOCK_PROF].nextevt = softns;
 	}
 
-	base[CPUCLOCK_PROF].nextevt = prof_exp;
-	base[CPUCLOCK_VIRT].nextevt = virt_exp;
-	base[CPUCLOCK_SCHED].nextevt = sched_exp;
-
-	if (expiry_cache_is_inactive(&sig->posix_cputimers))
+	if (expiry_cache_is_inactive(pct))
 		stop_process_timers(sig);
 
 	sig->cputimer.checking_timer = false;
