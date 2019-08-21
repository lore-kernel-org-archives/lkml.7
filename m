Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DB1C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B003E20679
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730543AbfHUTcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 15:32:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57171 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729893AbfHUTat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 15:30:49 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i0WJi-0004AS-Jh; Wed, 21 Aug 2019 21:30:46 +0200
Message-Id: <20190821192919.960966884@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 21 Aug 2019 21:08:55 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: [patch V2 08/38] posix-cpu-timers: Consolidate thread group sample
 code
References: <20190821190847.665673890@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpu_clock_sample_group() and cpu_timer_sample_group() are almost the
same. Before the rename one called thread_group_cputimer() and the other
thread_group_cputime(). Really intuitive function names.

Consolidate the functions and also avoid the thread traversal when
the thread group's accounting is already active.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Fixed typos
---
 kernel/time/posix-cpu-timers.c |   59 +++++++++++++----------------------------
 1 file changed, 20 insertions(+), 39 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -294,29 +294,37 @@ thread_group_start_cputime(struct task_s
 }
 
 /*
- * Sample a process (thread group) clock for the given group_leader task.
- * Must be called with task sighand lock held for safe while_each_thread()
- * traversal.
+ * Sample a process (thread group) clock for the given task clkid. If the
+ * group's cputime accounting is already enabled, read the atomic
+ * store. Otherwise a full update is required.  Task's sighand lock must be
+ * held to protect the task traversal on a full update.
  */
 static int cpu_clock_sample_group(const clockid_t which_clock,
 				  struct task_struct *p,
-				  u64 *sample)
+				  u64 *sample, bool start)
 {
+	struct thread_group_cputimer *cputimer = &p->signal->cputimer;
 	struct task_cputime cputime;
 
+	if (!READ_ONCE(cputimer->running)) {
+		if (start)
+			thread_group_start_cputime(p, &cputime);
+		else
+			thread_group_cputime(p, &cputime);
+	} else {
+		sample_cputime_atomic(&cputime, &cputimer->cputime_atomic);
+	}
+
 	switch (CPUCLOCK_WHICH(which_clock)) {
 	default:
 		return -EINVAL;
 	case CPUCLOCK_PROF:
-		thread_group_cputime(p, &cputime);
 		*sample = cputime.utime + cputime.stime;
 		break;
 	case CPUCLOCK_VIRT:
-		thread_group_cputime(p, &cputime);
 		*sample = cputime.utime;
 		break;
 	case CPUCLOCK_SCHED:
-		thread_group_cputime(p, &cputime);
 		*sample = cputime.sum_exec_runtime;
 		break;
 	}
@@ -336,7 +344,7 @@ static int posix_cpu_clock_get(const clo
 	if (CPUCLOCK_PERTHREAD(clock))
 		cpu_clock_sample(clkid, tsk, &t);
 	else
-		cpu_clock_sample_group(clkid, tsk, &t);
+		cpu_clock_sample_group(clkid, tsk, &t, false);
 	put_task_struct(tsk);
 
 	*tp = ns_to_timespec64(t);
@@ -540,33 +548,6 @@ static void cpu_timer_fire(struct k_itim
 }
 
 /*
- * Sample a process (thread group) timer for the given group_leader task.
- * Must be called with task sighand lock held for safe while_each_thread()
- * traversal.
- */
-static int cpu_timer_sample_group(const clockid_t which_clock,
-				  struct task_struct *p, u64 *sample)
-{
-	struct task_cputime cputime;
-
-	thread_group_start_cputime(p, &cputime);
-	switch (CPUCLOCK_WHICH(which_clock)) {
-	default:
-		return -EINVAL;
-	case CPUCLOCK_PROF:
-		*sample = cputime.utime + cputime.stime;
-		break;
-	case CPUCLOCK_VIRT:
-		*sample = cputime.utime;
-		break;
-	case CPUCLOCK_SCHED:
-		*sample = cputime.sum_exec_runtime;
-		break;
-	}
-	return 0;
-}
-
-/*
  * Guts of sys_timer_settime for CPU timers.
  * This is called with the timer locked and interrupts disabled.
  * If we return TIMER_RETRY, it's necessary to release the timer's lock
@@ -627,7 +608,7 @@ static int posix_cpu_timer_set(struct k_
 	if (CPUCLOCK_PERTHREAD(timer->it_clock)) {
 		cpu_clock_sample(timer->it_clock, p, &val);
 	} else {
-		cpu_timer_sample_group(timer->it_clock, p, &val);
+		cpu_clock_sample_group(timer->it_clock, p, &val, true);
 	}
 
 	if (old) {
@@ -755,7 +736,7 @@ static void posix_cpu_timer_get(struct k
 			timer->it.cpu.expires = 0;
 			return;
 		} else {
-			cpu_timer_sample_group(timer->it_clock, p, &now);
+			cpu_clock_sample_group(timer->it_clock, p, &now, false);
 			unlock_task_sighand(p, &flags);
 		}
 	}
@@ -1042,7 +1023,7 @@ static void posix_cpu_timer_rearm(struct
 			/* If the process is dying, no need to rearm */
 			goto unlock;
 		}
-		cpu_timer_sample_group(timer->it_clock, p, &now);
+		cpu_clock_sample_group(timer->it_clock, p, &now, true);
 		bump_cpu_timer(timer, now);
 		/* Leave the sighand locked for the call below.  */
 	}
@@ -1211,7 +1192,7 @@ void set_process_cpu_timer(struct task_s
 	if (WARN_ON_ONCE(clock_idx >= CPUCLOCK_SCHED))
 		return;
 
-	ret = cpu_timer_sample_group(clock_idx, tsk, &now);
+	ret = cpu_clock_sample_group(clock_idx, tsk, &now, true);
 
 	if (oldval && ret != -EINVAL) {
 		/*


