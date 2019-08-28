Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BA2C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F002342D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfH1KQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:16:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46370 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfH1KQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:16:26 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2v02-0000Ck-Kr; Wed, 28 Aug 2019 12:16:22 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4E1B21C0DE2;
        Wed, 28 Aug 2019 12:16:22 +0200 (CEST)
Date:   Wed, 28 Aug 2019 10:16:22 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Consolidate thread group sample code
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190821192919.960966884@linutronix.de>
References: <20190821192919.960966884@linutronix.de>
MIME-Version: 1.0
Message-ID: <156698738224.5708.670269170773692455.tip-bot2@tip-bot2>
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

Commit-ID:     24ab7f5a7b2c917e89fc6a87252f18faff91d6ce
Gitweb:        https://git.kernel.org/tip/24ab7f5a7b2c917e89fc6a87252f18faff91d6ce
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 21 Aug 2019 21:08:55 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Aug 2019 11:50:28 +02:00

posix-cpu-timers: Consolidate thread group sample code

cpu_clock_sample_group() and cpu_timer_sample_group() are almost the
same. Before the rename one called thread_group_cputimer() and the other
thread_group_cputime(). Really intuitive function names.

Consolidate the functions and also avoid the thread traversal when
the thread group's accounting is already active.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lkml.kernel.org/r/20190821192919.960966884@linutronix.de

---
 kernel/time/posix-cpu-timers.c | 59 +++++++++++----------------------
 1 file changed, 20 insertions(+), 39 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index def225a..a9003b2 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -294,29 +294,37 @@ thread_group_start_cputime(struct task_struct *tsk, struct task_cputime *times)
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
@@ -336,7 +344,7 @@ static int posix_cpu_clock_get(const clockid_t clock, struct timespec64 *tp)
 	if (CPUCLOCK_PERTHREAD(clock))
 		cpu_clock_sample(clkid, tsk, &t);
 	else
-		cpu_clock_sample_group(clkid, tsk, &t);
+		cpu_clock_sample_group(clkid, tsk, &t, false);
 	put_task_struct(tsk);
 
 	*tp = ns_to_timespec64(t);
@@ -540,33 +548,6 @@ static void cpu_timer_fire(struct k_itimer *timer)
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
@@ -627,7 +608,7 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 	if (CPUCLOCK_PERTHREAD(timer->it_clock)) {
 		cpu_clock_sample(timer->it_clock, p, &val);
 	} else {
-		cpu_timer_sample_group(timer->it_clock, p, &val);
+		cpu_clock_sample_group(timer->it_clock, p, &val, true);
 	}
 
 	if (old) {
@@ -755,7 +736,7 @@ static void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp
 			timer->it.cpu.expires = 0;
 			return;
 		} else {
-			cpu_timer_sample_group(timer->it_clock, p, &now);
+			cpu_clock_sample_group(timer->it_clock, p, &now, false);
 			unlock_task_sighand(p, &flags);
 		}
 	}
@@ -1042,7 +1023,7 @@ static void posix_cpu_timer_rearm(struct k_itimer *timer)
 			/* If the process is dying, no need to rearm */
 			goto unlock;
 		}
-		cpu_timer_sample_group(timer->it_clock, p, &now);
+		cpu_clock_sample_group(timer->it_clock, p, &now, true);
 		bump_cpu_timer(timer, now);
 		/* Leave the sighand locked for the call below.  */
 	}
@@ -1211,7 +1192,7 @@ void set_process_cpu_timer(struct task_struct *tsk, unsigned int clock_idx,
 	if (WARN_ON_ONCE(clock_idx >= CPUCLOCK_SCHED))
 		return;
 
-	ret = cpu_timer_sample_group(clock_idx, tsk, &now);
+	ret = cpu_clock_sample_group(clock_idx, tsk, &now, true);
 
 	if (oldval && ret != -EINVAL) {
 		/*
