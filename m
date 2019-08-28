Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED0FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD0A422CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfH1KSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:18:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46410 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfH1KQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:16:33 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2v0A-0000EP-7J; Wed, 28 Aug 2019 12:16:30 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DB9C11C0DE4;
        Wed, 28 Aug 2019 12:16:24 +0200 (CEST)
Date:   Wed, 28 Aug 2019 10:16:24 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Get rid of pointer indirection
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190821192920.535079278@linutronix.de>
References: <20190821192920.535079278@linutronix.de>
MIME-Version: 1.0
Message-ID: <156698738480.5727.2758659993709389602.tip-bot2@tip-bot2>
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

Commit-ID:     8c2d74f03705c2c993a57673bae8fd535eabede6
Gitweb:        https://git.kernel.org/tip/8c2d74f03705c2c993a57673bae8fd535eabede6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 21 Aug 2019 21:09:01 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Aug 2019 11:50:32 +02:00

posix-cpu-timers: Get rid of pointer indirection

Now that the sample functions have no return value anymore, the result can
simply be returned instead of using pointer indirection.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lkml.kernel.org/r/20190821192920.535079278@linutronix.de

---
 kernel/time/posix-cpu-timers.c | 50 ++++++++++++++-------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index cc3d148..a2007ce 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -182,22 +182,19 @@ posix_cpu_clock_set(const clockid_t clock, const struct timespec64 *tp)
 /*
  * Sample a per-thread clock for the given task. clkid is validated.
  */
-static void cpu_clock_sample(const clockid_t clkid, struct task_struct *p,
-			     u64 *sample)
+static u64 cpu_clock_sample(const clockid_t clkid, struct task_struct *p)
 {
 	switch (clkid) {
 	case CPUCLOCK_PROF:
-		*sample = prof_ticks(p);
-		break;
+		return prof_ticks(p);
 	case CPUCLOCK_VIRT:
-		*sample = virt_ticks(p);
-		break;
+		return virt_ticks(p);
 	case CPUCLOCK_SCHED:
-		*sample = task_sched_runtime(p);
-		break;
+		return task_sched_runtime(p);
 	default:
 		WARN_ON_ONCE(1);
 	}
+	return 0;
 }
 
 /*
@@ -299,8 +296,8 @@ thread_group_start_cputime(struct task_struct *tsk, struct task_cputime *times)
  * held to protect the task traversal on a full update. clkid is already
  * validated.
  */
-static void cpu_clock_sample_group(const clockid_t clkid, struct task_struct *p,
-				   u64 *sample, bool start)
+static u64 cpu_clock_sample_group(const clockid_t clkid, struct task_struct *p,
+				  bool start)
 {
 	struct thread_group_cputimer *cputimer = &p->signal->cputimer;
 	struct task_cputime cputime;
@@ -316,17 +313,15 @@ static void cpu_clock_sample_group(const clockid_t clkid, struct task_struct *p,
 
 	switch (clkid) {
 	case CPUCLOCK_PROF:
-		*sample = cputime.utime + cputime.stime;
-		break;
+		return cputime.utime + cputime.stime;
 	case CPUCLOCK_VIRT:
-		*sample = cputime.utime;
-		break;
+		return cputime.utime;
 	case CPUCLOCK_SCHED:
-		*sample = cputime.sum_exec_runtime;
-		break;
+		return cputime.sum_exec_runtime;
 	default:
 		WARN_ON_ONCE(1);
 	}
+	return 0;
 }
 
 static int posix_cpu_clock_get(const clockid_t clock, struct timespec64 *tp)
@@ -340,9 +335,9 @@ static int posix_cpu_clock_get(const clockid_t clock, struct timespec64 *tp)
 		return -EINVAL;
 
 	if (CPUCLOCK_PERTHREAD(clock))
-		cpu_clock_sample(clkid, tsk, &t);
+		t = cpu_clock_sample(clkid, tsk);
 	else
-		cpu_clock_sample_group(clkid, tsk, &t, false);
+		t = cpu_clock_sample_group(clkid, tsk, false);
 	put_task_struct(tsk);
 
 	*tp = ns_to_timespec64(t);
@@ -604,11 +599,10 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 	 * times (in arm_timer).  With an absolute time, we must
 	 * check if it's already passed.  In short, we need a sample.
 	 */
-	if (CPUCLOCK_PERTHREAD(timer->it_clock)) {
-		cpu_clock_sample(clkid, p, &val);
-	} else {
-		cpu_clock_sample_group(clkid, p, &val, true);
-	}
+	if (CPUCLOCK_PERTHREAD(timer->it_clock))
+		val = cpu_clock_sample(clkid, p);
+	else
+		val = cpu_clock_sample_group(clkid, p, true);
 
 	if (old) {
 		if (old_expires == 0) {
@@ -716,7 +710,7 @@ static void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp
 	 * Sample the clock to take the difference with the expiry time.
 	 */
 	if (CPUCLOCK_PERTHREAD(timer->it_clock)) {
-		cpu_clock_sample(clkid, p, &now);
+		now = cpu_clock_sample(clkid, p);
 	} else {
 		struct sighand_struct *sighand;
 		unsigned long flags;
@@ -736,7 +730,7 @@ static void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp
 			timer->it.cpu.expires = 0;
 			return;
 		} else {
-			cpu_clock_sample_group(clkid, p, &now, false);
+			now = cpu_clock_sample_group(clkid, p, false);
 			unlock_task_sighand(p, &flags);
 		}
 	}
@@ -998,7 +992,7 @@ static void posix_cpu_timer_rearm(struct k_itimer *timer)
 	 * Fetch the current sample and update the timer's expiry time.
 	 */
 	if (CPUCLOCK_PERTHREAD(timer->it_clock)) {
-		cpu_clock_sample(clkid, p, &now);
+		now = cpu_clock_sample(clkid, p);
 		bump_cpu_timer(timer, now);
 		if (unlikely(p->exit_state))
 			return;
@@ -1024,7 +1018,7 @@ static void posix_cpu_timer_rearm(struct k_itimer *timer)
 			/* If the process is dying, no need to rearm */
 			goto unlock;
 		}
-		cpu_clock_sample_group(clkid, p, &now, true);
+		now = cpu_clock_sample_group(clkid, p, true);
 		bump_cpu_timer(timer, now);
 		/* Leave the sighand locked for the call below.  */
 	}
@@ -1192,7 +1186,7 @@ void set_process_cpu_timer(struct task_struct *tsk, unsigned int clock_idx,
 	if (WARN_ON_ONCE(clock_idx >= CPUCLOCK_SCHED))
 		return;
 
-	cpu_clock_sample_group(clock_idx, tsk, &now, true);
+	now = cpu_clock_sample_group(clock_idx, tsk, true);
 
 	if (oldval) {
 		/*
