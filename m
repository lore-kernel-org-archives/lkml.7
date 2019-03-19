Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA6FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC192085A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfCSLNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 07:13:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53031 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfCSLNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 07:13:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2JBD8xw3396056
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 19 Mar 2019 04:13:08 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2JBD7YQ3396053;
        Tue, 19 Mar 2019 04:13:07 -0700
Date:   Tue, 19 Mar 2019 04:13:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Valentin Schneider <tipbot@zytor.com>
Message-ID: <tip-a0fe2cf086aef213d1b4bca1b1291a3dee8357c9@git.kernel.org>
Cc:     valentin.schneider@arm.com, torvalds@linux-foundation.org,
        mingo@kernel.org, riel@surriel.com, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, peterz@infradead.org
Reply-To: tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
          luto@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
          peterz@infradead.org, valentin.schneider@arm.com,
          torvalds@linux-foundation.org, mingo@kernel.org, riel@surriel.com
In-Reply-To: <20190211175946.4961-3-valentin.schneider@arm.com>
References: <20190211175946.4961-3-valentin.schneider@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/fair: Tune down misfit NOHZ kicks
Git-Commit-ID: a0fe2cf086aef213d1b4bca1b1291a3dee8357c9
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

Commit-ID:  a0fe2cf086aef213d1b4bca1b1291a3dee8357c9
Gitweb:     https://git.kernel.org/tip/a0fe2cf086aef213d1b4bca1b1291a3dee8357c9
Author:     Valentin Schneider <valentin.schneider@arm.com>
AuthorDate: Mon, 11 Feb 2019 17:59:45 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 19 Mar 2019 12:06:15 +0100

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
