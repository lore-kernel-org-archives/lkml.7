Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D751CC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C9F2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbfHSPrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 11:47:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47676 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbfHSPpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:45:46 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzjqq-0006wt-GA; Mon, 19 Aug 2019 17:45:44 +0200
Message-Id: <20190819143803.386913035@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 19 Aug 2019 16:32:02 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [patch 21/44] posix-cpu-timers: Get rid of pointer indirection
References: <20190819143141.221906747@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the sample functions have no return value anymore, the result can
simply be returned instead of using pointer indirection.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-cpu-timers.c |   50 ++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -182,22 +182,19 @@ posix_cpu_clock_set(const clockid_t cloc
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
@@ -299,8 +296,8 @@ thread_group_start_cputime(struct task_s
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
@@ -316,17 +313,15 @@ static void cpu_clock_sample_group(const
 
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
@@ -340,9 +335,9 @@ static int posix_cpu_clock_get(const clo
 		return -EINVAL;
 
 	if (CPUCLOCK_PERTHREAD(clock))
-		cpu_clock_sample(clkid, tsk, &t);
+		t = cpu_clock_sample(clkid, tsk);
 	else
-		cpu_clock_sample_group(clkid, tsk, &t, false);
+		t = cpu_clock_sample_group(clkid, tsk, false);
 	put_task_struct(tsk);
 
 	*tp = ns_to_timespec64(t);
@@ -604,11 +599,10 @@ static int posix_cpu_timer_set(struct k_
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
@@ -716,7 +710,7 @@ static void posix_cpu_timer_get(struct k
 	 * Sample the clock to take the difference with the expiry time.
 	 */
 	if (CPUCLOCK_PERTHREAD(timer->it_clock)) {
-		cpu_clock_sample(clkid, p, &now);
+		now = cpu_clock_sample(clkid, p);
 	} else {
 		struct sighand_struct *sighand;
 		unsigned long flags;
@@ -736,7 +730,7 @@ static void posix_cpu_timer_get(struct k
 			timer->it.cpu.expires = 0;
 			return;
 		} else {
-			cpu_clock_sample_group(clkid, p, &now, false);
+			now = cpu_clock_sample_group(clkid, p, false);
 			unlock_task_sighand(p, &flags);
 		}
 	}
@@ -998,7 +992,7 @@ static void posix_cpu_timer_rearm(struct
 	 * Fetch the current sample and update the timer's expiry time.
 	 */
 	if (CPUCLOCK_PERTHREAD(timer->it_clock)) {
-		cpu_clock_sample(clkid, p, &now);
+		now = cpu_clock_sample(clkid, p);
 		bump_cpu_timer(timer, now);
 		if (unlikely(p->exit_state))
 			return;
@@ -1024,7 +1018,7 @@ static void posix_cpu_timer_rearm(struct
 			/* If the process is dying, no need to rearm */
 			goto unlock;
 		}
-		cpu_clock_sample_group(clkid, p, &now, true);
+		now = cpu_clock_sample_group(clkid, p, true);
 		bump_cpu_timer(timer, now);
 		/* Leave the sighand locked for the call below.  */
 	}
@@ -1206,7 +1200,7 @@ void set_process_cpu_timer(struct task_s
 	if (WARN_ON_ONCE(clock_idx >= CPUCLOCK_SCHED))
 		return;
 
-	cpu_clock_sample_group(clock_idx, tsk, &now, true);
+	now = cpu_clock_sample_group(clock_idx, tsk, true);
 
 	if (oldval) {
 		/*


