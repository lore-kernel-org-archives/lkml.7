Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B4FC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ECB322CE2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbfHSPp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 11:45:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47666 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727887AbfHSPpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:45:46 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzjqp-0006wh-Tu; Mon, 19 Aug 2019 17:45:44 +0200
Message-Id: <20190819143803.282565797@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 19 Aug 2019 16:32:01 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [patch 20/44] posix-cpu-timers: Simplify sample functions
References: <20190819143141.221906747@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All callers hand in a valdiated clock id. Remove the return value which was
unchecked in most places anyway.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-cpu-timers.c |   28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -180,14 +180,12 @@ posix_cpu_clock_set(const clockid_t cloc
 }
 
 /*
- * Sample a per-thread clock for the given task.
+ * Sample a per-thread clock for the given task. clkid is validated.
  */
-static int cpu_clock_sample(const clockid_t which_clock,
-			    struct task_struct *p, u64 *sample)
+static void cpu_clock_sample(const clockid_t clkid, struct task_struct *p,
+			     u64 *sample)
 {
-	switch (CPUCLOCK_WHICH(which_clock)) {
-	default:
-		return -EINVAL;
+	switch (clkid) {
 	case CPUCLOCK_PROF:
 		*sample = prof_ticks(p);
 		break;
@@ -197,8 +195,9 @@ static int cpu_clock_sample(const clocki
 	case CPUCLOCK_SCHED:
 		*sample = task_sched_runtime(p);
 		break;
+	default:
+		WARN_ON_ONCE(1);
 	}
-	return 0;
 }
 
 /*
@@ -297,11 +296,11 @@ thread_group_start_cputime(struct task_s
  * Sample a process (thread group) clock for the given task clkid. If the
  * groups cputime accounting is already enabled, read the atomic
  * store. Otherwise a full update is required.  task sighand lock must be
- * held to protect the task traversal on a full update.
+ * held to protect the task traversal on a full update. clkid is already
+ * validated.
  */
-static int cpu_clock_sample_group(const clockid_t which_clock,
-				  struct task_struct *p,
-				  u64 *sample, bool start)
+static void cpu_clock_sample_group(const clockid_t clkid, struct task_struct *p,
+				   u64 *sample, bool start)
 {
 	struct thread_group_cputimer *cputimer = &p->signal->cputimer;
 	struct task_cputime cputime;
@@ -315,9 +314,7 @@ static int cpu_clock_sample_group(const
 		sample_cputime_atomic(&cputime, &cputimer->cputime_atomic);
 	}
 
-	switch (CPUCLOCK_WHICH(which_clock)) {
-	default:
-		return -EINVAL;
+	switch (clkid) {
 	case CPUCLOCK_PROF:
 		*sample = cputime.utime + cputime.stime;
 		break;
@@ -327,8 +324,9 @@ static int cpu_clock_sample_group(const
 	case CPUCLOCK_SCHED:
 		*sample = cputime.sum_exec_runtime;
 		break;
+	default:
+		WARN_ON_ONCE(1);
 	}
-	return 0;
 }
 
 static int posix_cpu_clock_get(const clockid_t clock, struct timespec64 *tp)


