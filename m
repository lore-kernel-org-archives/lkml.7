Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B0DCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92DB520873
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfJUJN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 05:13:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33969 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbfJUJN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:13:26 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMTk5-0005Je-Ai; Mon, 21 Oct 2019 11:12:45 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E13E11C0092;
        Mon, 21 Oct 2019 11:12:43 +0200 (CEST)
Date:   Mon, 21 Oct 2019 09:12:43 -0000
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Remove meaningless imbalance calculation
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Rik van Riel <riel@surriel.com>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Mike Galbraith <efault@gmx.de>,
        Morten.Rasmussen@arm.com, Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, hdanton@sina.com,
        parth@linux.ibm.com, pauld@redhat.com, quentin.perret@arm.com,
        srikar@linux.vnet.ibm.com, valentin.schneider@arm.com,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1571405198-27570-4-git-send-email-vincent.guittot@linaro.org>
References: <1571405198-27570-4-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <157164916372.29376.15935956843178525422.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     fcf0553db6f4c79387864f6e4ab4a891601f395e
Gitweb:        https://git.kernel.org/tip/fcf0553db6f4c79387864f6e4ab4a891601f395e
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Fri, 18 Oct 2019 15:26:30 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 21 Oct 2019 09:40:53 +02:00

sched/fair: Remove meaningless imbalance calculation

Clean up load_balance() and remove meaningless calculation and fields before
adding a new algorithm.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Acked-by: Rik van Riel <riel@surriel.com>
Cc: Ben Segall <bsegall@google.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Morten.Rasmussen@arm.com
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: hdanton@sina.com
Cc: parth@linux.ibm.com
Cc: pauld@redhat.com
Cc: quentin.perret@arm.com
Cc: srikar@linux.vnet.ibm.com
Cc: valentin.schneider@arm.com
Link: https://lkml.kernel.org/r/1571405198-27570-4-git-send-email-vincent.guittot@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 105 +-------------------------------------------
 1 file changed, 1 insertion(+), 104 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ad8f16a..a1bc04f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5380,18 +5380,6 @@ static unsigned long capacity_of(int cpu)
 	return cpu_rq(cpu)->cpu_capacity;
 }
 
-static unsigned long cpu_avg_load_per_task(int cpu)
-{
-	struct rq *rq = cpu_rq(cpu);
-	unsigned long nr_running = READ_ONCE(rq->cfs.h_nr_running);
-	unsigned long load_avg = cpu_runnable_load(rq);
-
-	if (nr_running)
-		return load_avg / nr_running;
-
-	return 0;
-}
-
 static void record_wakee(struct task_struct *p)
 {
 	/*
@@ -7657,7 +7645,6 @@ static unsigned long task_h_load(struct task_struct *p)
 struct sg_lb_stats {
 	unsigned long avg_load; /*Avg load across the CPUs of the group */
 	unsigned long group_load; /* Total load over the CPUs of the group */
-	unsigned long load_per_task;
 	unsigned long group_capacity;
 	unsigned long group_util; /* Total utilization of the group */
 	unsigned int sum_h_nr_running; /* Nr of CFS tasks running in the group */
@@ -8039,9 +8026,6 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	sgs->group_capacity = group->sgc->capacity;
 	sgs->avg_load = (sgs->group_load*SCHED_CAPACITY_SCALE) / sgs->group_capacity;
 
-	if (sgs->sum_h_nr_running)
-		sgs->load_per_task = sgs->group_load / sgs->sum_h_nr_running;
-
 	sgs->group_weight = group->group_weight;
 
 	sgs->group_no_capacity = group_is_overloaded(env, sgs);
@@ -8272,76 +8256,6 @@ next_group:
 }
 
 /**
- * fix_small_imbalance - Calculate the minor imbalance that exists
- *			amongst the groups of a sched_domain, during
- *			load balancing.
- * @env: The load balancing environment.
- * @sds: Statistics of the sched_domain whose imbalance is to be calculated.
- */
-static inline
-void fix_small_imbalance(struct lb_env *env, struct sd_lb_stats *sds)
-{
-	unsigned long tmp, capa_now = 0, capa_move = 0;
-	unsigned int imbn = 2;
-	unsigned long scaled_busy_load_per_task;
-	struct sg_lb_stats *local, *busiest;
-
-	local = &sds->local_stat;
-	busiest = &sds->busiest_stat;
-
-	if (!local->sum_h_nr_running)
-		local->load_per_task = cpu_avg_load_per_task(env->dst_cpu);
-	else if (busiest->load_per_task > local->load_per_task)
-		imbn = 1;
-
-	scaled_busy_load_per_task =
-		(busiest->load_per_task * SCHED_CAPACITY_SCALE) /
-		busiest->group_capacity;
-
-	if (busiest->avg_load + scaled_busy_load_per_task >=
-	    local->avg_load + (scaled_busy_load_per_task * imbn)) {
-		env->imbalance = busiest->load_per_task;
-		return;
-	}
-
-	/*
-	 * OK, we don't have enough imbalance to justify moving tasks,
-	 * however we may be able to increase total CPU capacity used by
-	 * moving them.
-	 */
-
-	capa_now += busiest->group_capacity *
-			min(busiest->load_per_task, busiest->avg_load);
-	capa_now += local->group_capacity *
-			min(local->load_per_task, local->avg_load);
-	capa_now /= SCHED_CAPACITY_SCALE;
-
-	/* Amount of load we'd subtract */
-	if (busiest->avg_load > scaled_busy_load_per_task) {
-		capa_move += busiest->group_capacity *
-			    min(busiest->load_per_task,
-				busiest->avg_load - scaled_busy_load_per_task);
-	}
-
-	/* Amount of load we'd add */
-	if (busiest->avg_load * busiest->group_capacity <
-	    busiest->load_per_task * SCHED_CAPACITY_SCALE) {
-		tmp = (busiest->avg_load * busiest->group_capacity) /
-		      local->group_capacity;
-	} else {
-		tmp = (busiest->load_per_task * SCHED_CAPACITY_SCALE) /
-		      local->group_capacity;
-	}
-	capa_move += local->group_capacity *
-		    min(local->load_per_task, local->avg_load + tmp);
-	capa_move /= SCHED_CAPACITY_SCALE;
-
-	/* Move if we gain throughput */
-	if (capa_move > capa_now)
-		env->imbalance = busiest->load_per_task;
-}
-
-/**
  * calculate_imbalance - Calculate the amount of imbalance present within the
  *			 groups of a given sched_domain during load balance.
  * @env: load balance environment
@@ -8360,15 +8274,6 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 		return;
 	}
 
-	if (busiest->group_type == group_imbalanced) {
-		/*
-		 * In the group_imb case we cannot rely on group-wide averages
-		 * to ensure CPU-load equilibrium, look at wider averages. XXX
-		 */
-		busiest->load_per_task =
-			min(busiest->load_per_task, sds->avg_load);
-	}
-
 	/*
 	 * Avg load of busiest sg can be less and avg load of local sg can
 	 * be greater than avg load across all sgs of sd because avg load
@@ -8379,7 +8284,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 	    (busiest->avg_load <= sds->avg_load ||
 	     local->avg_load >= sds->avg_load)) {
 		env->imbalance = 0;
-		return fix_small_imbalance(env, sds);
+		return;
 	}
 
 	/*
@@ -8417,14 +8322,6 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 				       busiest->group_misfit_task_load);
 	}
 
-	/*
-	 * if *imbalance is less than the average load per runnable task
-	 * there is no guarantee that any tasks will be moved so we'll have
-	 * a think about bumping its value to force at least one task to be
-	 * moved
-	 */
-	if (env->imbalance < busiest->load_per_task)
-		return fix_small_imbalance(env, sds);
 }
 
 /******* find_busiest_group() helpers end here *********************/
