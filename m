Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB53C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 11:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAD662089F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 11:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403935AbfIJLSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 07:18:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54089 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392848AbfIJLSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 07:18:11 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i7e9v-0004IW-Dt; Tue, 10 Sep 2019 13:18:07 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7A6F41C0714;
        Tue, 10 Sep 2019 13:18:06 +0200 (CEST)
Date:   Tue, 10 Sep 2019 11:18:06 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Fix permission check regression
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.1909052314110.1902@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1909052314110.1902@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID: <156811428632.24167.388244767927708510.tip-bot2@tip-bot2>
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

Commit-ID:     77b4b5420422fc037d00b8f3f0e89b2262e4ae29
Gitweb:        https://git.kernel.org/tip/77b4b5420422fc037d00b8f3f0e89b2262e4ae29
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 05 Sep 2019 23:15:08 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Sep 2019 12:13:07 +01:00

posix-cpu-timers: Fix permission check regression

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
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1909052314110.1902@nanos.tec.linutronix.de

---
 kernel/time/posix-cpu-timers.c | 44 ++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index c3a95b1..92a4319 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -47,25 +47,46 @@ void update_rlimit_cpu(struct task_struct *task, unsigned long rlim_new)
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
+		 * For clock_gettime(PROCESS) the task does not need to be
+		 * the actual group leader. tsk->sighand gives
+		 * access to the group's clock.
+		 *
+		 * Timers need the group leader because they take a
+		 * reference on it and store the task pointer until the
+		 * timer is destroyed.
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
@@ -75,7 +96,7 @@ static struct task_struct *__get_task_for_clock(const clockid_t clock,
 		return NULL;
 
 	rcu_read_lock();
-	p = lookup_task(pid, thread);
+	p = lookup_task(pid, thread, gettime);
 	if (p && getref)
 		get_task_struct(p);
 	rcu_read_unlock();
@@ -84,12 +105,17 @@ static struct task_struct *__get_task_for_clock(const clockid_t clock,
 
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
@@ -339,7 +365,7 @@ static int posix_cpu_clock_get(const clockid_t clock, struct timespec64 *tp)
 	struct task_struct *tsk;
 	u64 t;
 
-	tsk = get_task_for_clock(clock);
+	tsk = get_task_for_clock_get(clock);
 	if (!tsk)
 		return -EINVAL;
 
