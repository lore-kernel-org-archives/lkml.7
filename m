Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D626C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 14:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5E7207E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 14:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfCIOhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 09:37:51 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38867 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfCIOhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 09:37:51 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x29EbXhB3108947
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Mar 2019 06:37:33 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x29EbVRN3108942;
        Sat, 9 Mar 2019 06:37:31 -0800
Date:   Sat, 9 Mar 2019 06:37:31 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Valentin Schneider <tipbot@zytor.com>
Message-ID: <tip-88a2f7ffd19245a75143a8180f75c0972cff0350@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        riel@surriel.com, dave.hansen@linux.intel.com,
        peterz@infradead.org, hpa@zytor.com, valentin.schneider@arm.com,
        bp@alien8.de, luto@kernel.org, torvalds@linux-foundation.org
Reply-To: torvalds@linux-foundation.org, luto@kernel.org, bp@alien8.de,
          valentin.schneider@arm.com, peterz@infradead.org, hpa@zytor.com,
          dave.hansen@linux.intel.com, riel@surriel.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          mingo@kernel.org
In-Reply-To: <20190211175946.4961-3-valentin.schneider@arm.com>
References: <20190211175946.4961-3-valentin.schneider@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/fair: Tune down misfit NOHZ kicks
Git-Commit-ID: 88a2f7ffd19245a75143a8180f75c0972cff0350
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  88a2f7ffd19245a75143a8180f75c0972cff0350
Gitweb:     https://git.kernel.org/tip/88a2f7ffd19245a75143a8180f75c0972cff0350
Author:     Valentin Schneider <valentin.schneider@arm.com>
AuthorDate: Mon, 11 Feb 2019 17:59:45 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 9 Mar 2019 14:03:53 +0100

sched/fair: Tune down misfit NOHZ kicks

In this commit:

  3b1baa6496e6 ("sched/fair: Add 'group_misfit_task' load-balance type")

we set rq->misfit_task_load whenever the current running task has a
utilization greater than 80% of rq->cpu_capacity. A non-zero value in
this field enables misfit load balancing.

However, if the task being looked at is already running on a CPU of
highest capacity, there's nothing more we can do for it. We can
currently spot this in update_sd_pick_busiest(), which prevents us
from selecting a sched_group of group_type == group_misfit_task as the
busiest group, but we don't do any of that in nohz_balancer_kick().

This means that we could repeatedly kick NOHZ CPUs when there's no
improvements in terms of load balance to be done.

Introduce a check_misfit_status() helper that returns true iff there
is a CPU in the system that could give more CPU capacity to a rq's
misfit task - IOW, there exists a CPU of higher capacity_orig or the
rq's CPU is severely pressured by rt/IRQ.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dietmar.Eggemann@arm.com
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: morten.rasmussen@arm.com
Cc: vincent.guittot@linaro.org
Link: https://lkml.kernel.org/r/20190211175946.4961-3-valentin.schneider@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e6f7d39d4d45..f0d2f8a352bf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8058,6 +8058,18 @@ check_cpu_capacity(struct rq *rq, struct sched_domain *sd)
 				(rq->cpu_capacity_orig * 100));
 }
 
+/*
+ * Check whether a rq has a misfit task and if it looks like we can actually
+ * help that task: we can migrate the task to a CPU of higher capacity, or
+ * the task's current CPU is heavily pressured.
+ */
+static inline int check_misfit_status(struct rq *rq, struct sched_domain *sd)
+{
+	return rq->misfit_task_load &&
+		(rq->cpu_capacity_orig < rq->rd->max_cpu_capacity ||
+		 check_cpu_capacity(rq, sd));
+}
+
 /*
  * Group imbalance indicates (and tries to solve) the problem where balancing
  * groups is inadequate due to ->cpus_allowed constraints.
@@ -9585,7 +9597,7 @@ static void nohz_balancer_kick(struct rq *rq)
 	if (time_before(now, nohz.next_balance))
 		goto out;
 
-	if (rq->nr_running >= 2 || rq->misfit_task_load) {
+	if (rq->nr_running >= 2) {
 		flags = NOHZ_KICK_MASK;
 		goto out;
 	}
@@ -9623,6 +9635,18 @@ static void nohz_balancer_kick(struct rq *rq)
 		}
 	}
 
+	sd = rcu_dereference(per_cpu(sd_asym_cpucapacity, cpu));
+	if (sd) {
+		/*
+		 * When ASYM_CPUCAPACITY; see if there's a higher capacity CPU
+		 * to run the misfit task on.
+		 */
+		if (check_misfit_status(rq, sd)) {
+			flags = NOHZ_KICK_MASK;
+			goto unlock;
+		}
+	}
+
 	sd = rcu_dereference(per_cpu(sd_asym_packing, cpu));
 	if (sd) {
 		/*
