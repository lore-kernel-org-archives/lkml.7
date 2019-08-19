Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0409C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF85A22CE5
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbfHSPsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 11:48:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47577 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfHSPpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:45:41 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzjqk-0006u6-NW; Mon, 19 Aug 2019 17:45:38 +0200
Message-Id: <20190819143802.144101420@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 19 Aug 2019 16:31:49 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [patch 08/44] posix-cpu-timers: Provide task validation functions
References: <20190819143141.221906747@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code contains three slightly different copies of validating whether a
given clock resolves to a valid task and whether the current caller has
permissions to access it.

Create central functions. Replace check_clock() as a first step and rename
it to something sensible.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-cpu-timers.c |   65 +++++++++++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 21 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -35,27 +35,52 @@ void update_rlimit_cpu(struct task_struc
 	spin_unlock_irq(&task->sighand->siglock);
 }
 
-static int check_clock(const clockid_t which_clock)
+/*
+ * Functions for validating access to tasks.
+ */
+static struct task_struct *lookup_task(const pid_t pid, bool thread)
 {
-	int error = 0;
 	struct task_struct *p;
-	const pid_t pid = CPUCLOCK_PID(which_clock);
 
-	if (CPUCLOCK_WHICH(which_clock) >= CPUCLOCK_MAX)
-		return -EINVAL;
+	if (!pid)
+		return thread ? current : current->group_leader;
 
-	if (pid == 0)
-		return 0;
+	p = find_task_by_vpid(pid);
+	if (!p || p == current)
+		return p;
+	if (thread)
+		return same_thread_group(p, current) ? p : NULL;
+	if (p == current)
+		return p;
+	return has_group_leader_pid(p) ? p : NULL;
+}
+
+static struct task_struct *__get_task_for_clock(const clockid_t clock,
+						bool getref)
+{
+	const bool thread = !!CPUCLOCK_PERTHREAD(clock);
+	const pid_t pid = CPUCLOCK_PID(clock);
+	struct task_struct *p;
+
+	if (CPUCLOCK_WHICH(clock) >= CPUCLOCK_MAX)
+		return NULL;
 
 	rcu_read_lock();
-	p = find_task_by_vpid(pid);
-	if (!p || !(CPUCLOCK_PERTHREAD(which_clock) ?
-		   same_thread_group(p, current) : has_group_leader_pid(p))) {
-		error = -EINVAL;
-	}
+	p = lookup_task(pid, thread);
+	if (p && getref)
+		get_task_struct(p);
 	rcu_read_unlock();
+	return p;
+}
 
-	return error;
+static inline struct task_struct *get_task_for_clock(const clockid_t clock)
+{
+	return __get_task_for_clock(clock, true);
+}
+
+static inline int validate_clock_permissions(const clockid_t clock)
+{
+	return __get_task_for_clock(clock, false) ? 0 : -EINVAL;
 }
 
 /*
@@ -125,7 +150,8 @@ static inline u64 virt_ticks(struct task
 static int
 posix_cpu_clock_getres(const clockid_t which_clock, struct timespec64 *tp)
 {
-	int error = check_clock(which_clock);
+	int error = validate_clock_permissions(which_clock);
+
 	if (!error) {
 		tp->tv_sec = 0;
 		tp->tv_nsec = ((NSEC_PER_SEC + HZ - 1) / HZ);
@@ -142,20 +168,17 @@ posix_cpu_clock_getres(const clockid_t w
 }
 
 static int
-posix_cpu_clock_set(const clockid_t which_clock, const struct timespec64 *tp)
+posix_cpu_clock_set(const clockid_t clock, const struct timespec64 *tp)
 {
+	int error = validate_clock_permissions(clock);
+
 	/*
 	 * You can never reset a CPU clock, but we check for other errors
 	 * in the call before failing with EPERM.
 	 */
-	int error = check_clock(which_clock);
-	if (error == 0) {
-		error = -EPERM;
-	}
-	return error;
+	return error ? : -EPERM;
 }
 
-
 /*
  * Sample a per-thread clock for the given task.
  */


