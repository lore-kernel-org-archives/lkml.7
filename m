Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656CEC3A5AB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 426C321848
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389295AbfIEMMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 08:12:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42705 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387775AbfIEMMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 08:12:05 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i5qcN-0007tE-56; Thu, 05 Sep 2019 14:12:03 +0200
Message-Id: <20190905120539.797994508@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 05 Sep 2019 14:03:41 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: [patch 2/6] posix-cpu-timers: Fix permission check regression
References: <20190905120339.561100423@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent consolidation of the three permission checks introduced a subtle
regression. For timer_create() with a process wide timer it returns the
current task if the lookup through the PID which is encoded into the
clockid results in returning current.

That's broken because it does not validate whether the current task is the
group leader.

That was caused by the two different variants of permission checks:

  - posix_cpu_timer_get() allowed access to the process wide clock when the
    looked up task is current. That's not an issue because the process wide
    clock is in the shared sighand.

  - posix_cpu_timer_create() made sure that the looked up task is the group
    leader.

Restore the previous state.

Note, that these permission checks are more than questionable, but that's
subject to follow up changes.

Fixes: 6ae40e3fdcd3 ("posix-cpu-timers: Provide task validation functions")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-cpu-timers.c |   40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -47,25 +47,42 @@ void update_rlimit_cpu(struct task_struc
 /*
  * Functions for validating access to tasks.
  */
-static struct task_struct *lookup_task(const pid_t pid, bool thread)
+static struct task_struct *lookup_task(const pid_t pid, bool thread,
+				       bool gettime)
 {
 	struct task_struct *p;
 
+	/*
+	 * If the encoded PID is 0, then the timer is targeted at current
+	 * or the process to which current belongs.
+	 */
 	if (!pid)
 		return thread ? current : current->group_leader;
 
 	p = find_task_by_vpid(pid);
-	if (!p || p == current)
+	if (!p)
 		return p;
+
 	if (thread)
 		return same_thread_group(p, current) ? p : NULL;
-	if (p == current)
-		return p;
+
+	if (gettime) {
+		/*
+		 * For clock_gettime() the task does not need to be the
+		 * actual group leader. tsk->sighand gives access to the
+		 * group's clock.
+		 */
+		return (p == current || thread_group_leader(p)) ? p : NULL;
+	}
+
+	/*
+	 * For processes require that p is group leader.
+	 */
 	return has_group_leader_pid(p) ? p : NULL;
 }
 
 static struct task_struct *__get_task_for_clock(const clockid_t clock,
-						bool getref)
+						bool getref, bool gettime)
 {
 	const bool thread = !!CPUCLOCK_PERTHREAD(clock);
 	const pid_t pid = CPUCLOCK_PID(clock);
@@ -75,7 +92,7 @@ static struct task_struct *__get_task_fo
 		return NULL;
 
 	rcu_read_lock();
-	p = lookup_task(pid, thread);
+	p = lookup_task(pid, thread, gettime);
 	if (p && getref)
 		get_task_struct(p);
 	rcu_read_unlock();
@@ -84,12 +101,17 @@ static struct task_struct *__get_task_fo
 
 static inline struct task_struct *get_task_for_clock(const clockid_t clock)
 {
-	return __get_task_for_clock(clock, true);
+	return __get_task_for_clock(clock, true, false);
+}
+
+static inline struct task_struct *get_task_for_clock_get(const clockid_t clock)
+{
+	return __get_task_for_clock(clock, true, true);
 }
 
 static inline int validate_clock_permissions(const clockid_t clock)
 {
-	return __get_task_for_clock(clock, false) ? 0 : -EINVAL;
+	return __get_task_for_clock(clock, false, false) ? 0 : -EINVAL;
 }
 
 /*
@@ -339,7 +361,7 @@ static int posix_cpu_clock_get(const clo
 	struct task_struct *tsk;
 	u64 t;
 
-	tsk = get_task_for_clock(clock);
+	tsk = get_task_for_clock_get(clock);
 	if (!tsk)
 		return -EINVAL;
 


