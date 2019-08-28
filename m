Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D3BC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23896217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfH1KQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:16:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46343 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfH1KQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:16:23 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2uzz-0000AP-EV; Wed, 28 Aug 2019 12:16:19 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 173901C07D2;
        Wed, 28 Aug 2019 12:16:19 +0200 (CEST)
Date:   Wed, 28 Aug 2019 10:16:18 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Provide task validation functions
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190821192919.326097175@linutronix.de>
References: <20190821192919.326097175@linutronix.de>
MIME-Version: 1.0
Message-ID: <156698737894.5680.10697132030534215507.tip-bot2@tip-bot2>
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

Commit-ID:     6ae40e3fdcd33a6ff3c490b9302d6a1861093f65
Gitweb:        https://git.kernel.org/tip/6ae40e3fdcd33a6ff3c490b9302d6a1861093f65
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 21 Aug 2019 21:08:48 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Aug 2019 11:50:24 +02:00

posix-cpu-timers: Provide task validation functions

The code contains three slightly different copies of validating whether a
given clock resolves to a valid task and whether the current caller has
permissions to access it.

Create central functions. Replace check_clock() as a first step and rename
it to something sensible.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190821192919.326097175@linutronix.de

---
 kernel/time/posix-cpu-timers.c | 65 ++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 21 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 387e0e8..b06ed8b 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -35,27 +35,52 @@ void update_rlimit_cpu(struct task_struct *task, unsigned long rlim_new)
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
+
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
 
-	if (pid == 0)
-		return 0;
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
@@ -125,7 +150,8 @@ static inline u64 virt_ticks(struct task_struct *p)
 static int
 posix_cpu_clock_getres(const clockid_t which_clock, struct timespec64 *tp)
 {
-	int error = check_clock(which_clock);
+	int error = validate_clock_permissions(which_clock);
+
 	if (!error) {
 		tp->tv_sec = 0;
 		tp->tv_nsec = ((NSEC_PER_SEC + HZ - 1) / HZ);
@@ -142,20 +168,17 @@ posix_cpu_clock_getres(const clockid_t which_clock, struct timespec64 *tp)
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
