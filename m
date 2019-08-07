Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906CFC32754
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B3821E6E
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389211AbfHGRlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 13:41:14 -0400
Received: from foss.arm.com ([217.140.110.172]:52516 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388369AbfHGRlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 13:41:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFB211570;
        Wed,  7 Aug 2019 10:41:12 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1DC183F575;
        Wed,  7 Aug 2019 10:41:12 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org
Subject: [PATCH 1/3] sched/fair: Move active balance logic to its own function
Date:   Wed,  7 Aug 2019 18:40:24 +0100
Message-Id: <20190807174026.31242-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190807174026.31242-1-valentin.schneider@arm.com>
References: <20190807174026.31242-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The logic to trigger an active balance is already quite lengthy, and
as I'm about to add yet another unlock condition it's probably better
to give it its own corner.

The only annoying requirement is that we need to branch to
out_one_pinned when the active balance is cancelled due to the running
task's affinity. Something like < 0, == 0 and > 0 return values could
suffice, but I went for an enum for clarity.

No change in functionality intended, but do note I had to move the
nr_balance_failed in the same if block as the stop_one_cpu_nowait()
call to not have it on the task pinned path.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 122 ++++++++++++++++++++++++++------------------
 1 file changed, 73 insertions(+), 49 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 52834cba8ca8..b56b8edee3d3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8804,6 +8804,72 @@ static int need_active_balance(struct lb_env *env)
 
 static int active_load_balance_cpu_stop(void *data);
 
+/* Active load balance */
+enum alb_status {
+	cancelled = 0,
+	cancelled_affinity,
+	started
+};
+
+/* Attempt to move a remote rq's running task to env's dst_cpu */
+static inline enum alb_status active_load_balance(struct lb_env *env)
+{
+	enum alb_status status = cancelled;
+	struct sched_domain *sd = env->sd;
+	struct rq *busiest = env->src_rq;
+	unsigned long flags;
+
+	schedstat_inc(sd->lb_failed[env->idle]);
+	/*
+	 * Increment the failure counter only on periodic balance.
+	 * We do not want newidle balance, which can be very frequent, pollute
+	 * the failure counter causing excessive cache_hot migrations and
+	 * active balances.
+	 */
+	if (env->idle != CPU_NEWLY_IDLE)
+		sd->nr_balance_failed++;
+
+	if (!need_active_balance(env))
+		goto out;
+
+	raw_spin_lock_irqsave(&busiest->lock, flags);
+
+	/*
+	 * Don't kick the active_load_balance_cpu_stop, if the curr task on
+	 * busiest CPU can't be moved to dst_cpu:
+	 */
+	if (!cpumask_test_cpu(env->dst_cpu, busiest->curr->cpus_ptr)) {
+		env->flags |= LBF_ALL_PINNED;
+		status = cancelled_affinity;
+		goto unlock;
+	}
+
+	/*
+	 * ->active_balance synchronizes accesses to ->active_balance_work.
+	 * Once set, it's cleared only after active load balance is finished.
+	 */
+	if (!busiest->active_balance) {
+		busiest->active_balance = 1;
+		busiest->push_cpu = env->dst_cpu;
+		status = started;
+	}
+
+unlock:
+	raw_spin_unlock_irqrestore(&busiest->lock, flags);
+
+	if (status == started) {
+		stop_one_cpu_nowait(cpu_of(busiest),
+				    active_load_balance_cpu_stop, busiest,
+				    &busiest->active_balance_work);
+
+		/* We've kicked active balancing, force task migration. */
+		sd->nr_balance_failed = sd->cache_nice_tries+1;
+	}
+
+out:
+	return status;
+}
+
 static int should_we_balance(struct lb_env *env)
 {
 	struct sched_group *sg = env->sd->groups;
@@ -8850,7 +8916,8 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 			struct sched_domain *sd, enum cpu_idle_type idle,
 			int *continue_balancing)
 {
-	int ld_moved, cur_ld_moved, active_balance = 0;
+	enum alb_status active_balance;
+	int ld_moved, cur_ld_moved;
 	struct sched_domain *sd_parent = sd->parent;
 	struct sched_group *group;
 	struct rq *busiest;
@@ -9009,56 +9076,13 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 	}
 
 	if (!ld_moved) {
-		schedstat_inc(sd->lb_failed[idle]);
-		/*
-		 * Increment the failure counter only on periodic balance.
-		 * We do not want newidle balance, which can be very
-		 * frequent, pollute the failure counter causing
-		 * excessive cache_hot migrations and active balances.
-		 */
-		if (idle != CPU_NEWLY_IDLE)
-			sd->nr_balance_failed++;
-
-		if (need_active_balance(&env)) {
-			unsigned long flags;
-
-			raw_spin_lock_irqsave(&busiest->lock, flags);
+		active_balance = active_load_balance(&env);
+		if (active_balance == cancelled_affinity)
+			goto out_one_pinned;
 
-			/*
-			 * Don't kick the active_load_balance_cpu_stop,
-			 * if the curr task on busiest CPU can't be
-			 * moved to this_cpu:
-			 */
-			if (!cpumask_test_cpu(this_cpu, busiest->curr->cpus_ptr)) {
-				raw_spin_unlock_irqrestore(&busiest->lock,
-							    flags);
-				env.flags |= LBF_ALL_PINNED;
-				goto out_one_pinned;
-			}
-
-			/*
-			 * ->active_balance synchronizes accesses to
-			 * ->active_balance_work.  Once set, it's cleared
-			 * only after active load balance is finished.
-			 */
-			if (!busiest->active_balance) {
-				busiest->active_balance = 1;
-				busiest->push_cpu = this_cpu;
-				active_balance = 1;
-			}
-			raw_spin_unlock_irqrestore(&busiest->lock, flags);
-
-			if (active_balance) {
-				stop_one_cpu_nowait(cpu_of(busiest),
-					active_load_balance_cpu_stop, busiest,
-					&busiest->active_balance_work);
-			}
-
-			/* We've kicked active balancing, force task migration. */
-			sd->nr_balance_failed = sd->cache_nice_tries+1;
-		}
-	} else
+	} else {
 		sd->nr_balance_failed = 0;
+	}
 
 	if (likely(!active_balance) || voluntary_active_balance(&env)) {
 		/* We were unbalanced, so reset the balancing interval */
-- 
2.22.0

