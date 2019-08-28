Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F488C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DADD217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfH1KQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:16:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46384 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfH1KQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:16:29 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2v04-0000EO-PB; Wed, 28 Aug 2019 12:16:24 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 750781C07D2;
        Wed, 28 Aug 2019 12:16:24 +0200 (CEST)
Date:   Wed, 28 Aug 2019 10:16:24 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Simplify sample functions
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190821192920.430475832@linutronix.de>
References: <20190821192920.430475832@linutronix.de>
MIME-Version: 1.0
Message-ID: <156698738437.5724.14497593407499032131.tip-bot2@tip-bot2>
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

Commit-ID:     2092c1d4fed9f279d10600b4c1b5167dd8486a2a
Gitweb:        https://git.kernel.org/tip/2092c1d4fed9f279d10600b4c1b5167dd8486a2a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 21 Aug 2019 21:09:00 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Aug 2019 11:50:31 +02:00

posix-cpu-timers: Simplify sample functions

All callers hand in a valdiated clock id. Remove the return value which was
unchecked in most places anyway.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lkml.kernel.org/r/20190821192920.430475832@linutronix.de

---
 kernel/time/posix-cpu-timers.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 5944b74..cc3d148 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -180,14 +180,12 @@ posix_cpu_clock_set(const clockid_t clock, const struct timespec64 *tp)
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
@@ -197,8 +195,9 @@ static int cpu_clock_sample(const clockid_t which_clock,
 	case CPUCLOCK_SCHED:
 		*sample = task_sched_runtime(p);
 		break;
+	default:
+		WARN_ON_ONCE(1);
 	}
-	return 0;
 }
 
 /*
@@ -297,11 +296,11 @@ thread_group_start_cputime(struct task_struct *tsk, struct task_cputime *times)
  * Sample a process (thread group) clock for the given task clkid. If the
  * group's cputime accounting is already enabled, read the atomic
  * store. Otherwise a full update is required.  Task's sighand lock must be
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
@@ -315,9 +314,7 @@ static int cpu_clock_sample_group(const clockid_t which_clock,
 		sample_cputime_atomic(&cputime, &cputimer->cputime_atomic);
 	}
 
-	switch (CPUCLOCK_WHICH(which_clock)) {
-	default:
-		return -EINVAL;
+	switch (clkid) {
 	case CPUCLOCK_PROF:
 		*sample = cputime.utime + cputime.stime;
 		break;
@@ -327,8 +324,9 @@ static int cpu_clock_sample_group(const clockid_t which_clock,
 	case CPUCLOCK_SCHED:
 		*sample = cputime.sum_exec_runtime;
 		break;
+	default:
+		WARN_ON_ONCE(1);
 	}
-	return 0;
 }
 
 static int posix_cpu_clock_get(const clockid_t clock, struct timespec64 *tp)
