Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA9CC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 05:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BEC12087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 05:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfEFFtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 01:49:08 -0400
Received: from ms01.santannapisa.it ([193.205.80.98]:57922 "EHLO
        mail.santannapisa.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfEFFtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 01:49:04 -0400
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 May 2019 01:48:55 EDT
Received: from [151.41.47.232] (account l.abeni@santannapisa.it HELO sweethome.home-life.hub)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 138841009; Mon, 06 May 2019 06:48:59 +0200
From:   Luca Abeni <luca.abeni@santannapisa.it>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        luca abeni <luca.abeni@santannapisa.it>
Subject: [RFC PATCH 3/6] sched/dl: Try better placement even for deadline tasks that do not block
Date:   Mon,  6 May 2019 06:48:33 +0200
Message-Id: <20190506044836.2914-4-luca.abeni@santannapisa.it>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190506044836.2914-1-luca.abeni@santannapisa.it>
References: <20190506044836.2914-1-luca.abeni@santannapisa.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: luca abeni <luca.abeni@santannapisa.it>

Currently, the scheduler tries to find a proper placement for
SCHED_DEADLINE tasks when they are pushed out of a core or when
they wake up. Hence, if there is a single SCHED_DEADLINE task
that never blocks and wakes up, such a task is never migrated to
an appropriate CPU core, but continues to execute on its original
core.

This commit addresses the issue by trying to migrate a SCHED_DEADLINE
task (searching for an appropriate CPU core) the first time it is
throttled.

Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
---
 include/linux/sched.h   |  1 +
 kernel/sched/deadline.c | 53 ++++++++++++++++++++++++++++++++++++-----
 kernel/sched/sched.h    |  2 ++
 3 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 863f70843875..5e322c8a94e0 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -560,6 +560,7 @@ struct sched_dl_entity {
 	unsigned int			dl_yielded        : 1;
 	unsigned int			dl_non_contending : 1;
 	unsigned int			dl_overrun	  : 1;
+	unsigned int			dl_adjust	  : 1;
 
 	/*
 	 * Bandwidth enforcement timer. Each -deadline task has its
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 3436f3d8fa8f..db471889196b 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -515,6 +515,7 @@ static inline bool need_pull_dl_task(struct rq *rq, struct task_struct *prev)
 	return dl_task(prev);
 }
 
+static DEFINE_PER_CPU(struct callback_head, dl_migrate_head);
 static DEFINE_PER_CPU(struct callback_head, dl_push_head);
 static DEFINE_PER_CPU(struct callback_head, dl_pull_head);
 
@@ -1149,6 +1150,32 @@ static u64 grub_reclaim(u64 delta, struct rq *rq, struct sched_dl_entity *dl_se)
 	return (delta * u_act) >> BW_SHIFT;
 }
 
+#ifdef CONFIG_SMP
+static int find_later_rq(struct task_struct *task);
+
+static void migrate_dl_task(struct rq *rq)
+{
+	struct task_struct *t = rq->migrating_task;
+	struct sched_dl_entity *dl_se = &t->dl;
+	int cpu = find_later_rq(t);
+
+	if ((cpu != -1) && (cpu != rq->cpu)) {
+		struct rq *later_rq;
+
+		later_rq = cpu_rq(cpu);
+
+		double_lock_balance(rq, later_rq);
+		sub_running_bw(&t->dl, &rq->dl);
+		sub_rq_bw(&t->dl, &rq->dl);
+		set_task_cpu(t, later_rq->cpu);
+		add_rq_bw(&t->dl, &later_rq->dl);
+		add_running_bw(&t->dl, &later_rq->dl);
+		double_unlock_balance(rq, later_rq);
+	}
+	rq->migrating_task = NULL;
+	dl_se->dl_adjust = 0;
+}
+#endif
 /*
  * Update the current task's runtime statistics (provided it is still
  * a -deadline task and has not been removed from the dl_rq).
@@ -1223,8 +1250,17 @@ static void update_curr_dl(struct rq *rq)
 			dl_se->dl_overrun = 1;
 
 		__dequeue_task_dl(rq, curr, 0);
-		if (unlikely(dl_se->dl_boosted || !start_dl_timer(curr)))
+		if (unlikely(dl_se->dl_boosted || !start_dl_timer(curr))) {
 			enqueue_task_dl(rq, curr, ENQUEUE_REPLENISH);
+#ifdef CONFIG_SMP
+		} else if (dl_se->dl_adjust) {
+			if (rq->migrating_task == NULL) {
+				queue_balance_callback(rq, &per_cpu(dl_migrate_head, rq->cpu), migrate_dl_task);
+				rq->migrating_task = current;
+			} else
+				printk_deferred("Throttled task before migratin g the previous one???\n");
+#endif
+		}
 
 		if (!is_leftmost(curr, &rq->dl))
 			resched_curr(rq);
@@ -1573,13 +1609,12 @@ static void yield_task_dl(struct rq *rq)
 
 #ifdef CONFIG_SMP
 
-static int find_later_rq(struct task_struct *task);
-
 static int
 select_task_rq_dl(struct task_struct *p, int cpu, int sd_flag, int flags)
 {
 	struct task_struct *curr;
 	struct rq *rq;
+	bool het;
 
 	if (sd_flag != SD_BALANCE_WAKE)
 		goto out;
@@ -1591,6 +1626,7 @@ select_task_rq_dl(struct task_struct *p, int cpu, int sd_flag, int flags)
 
 	rcu_read_lock();
 	curr = READ_ONCE(rq->curr); /* unlocked access */
+	het = static_branch_unlikely(&sched_asym_cpucapacity);
 
 	/*
 	 * If we are dealing with a -deadline task, we must
@@ -1604,15 +1640,17 @@ select_task_rq_dl(struct task_struct *p, int cpu, int sd_flag, int flags)
 	if ((unlikely(dl_task(curr)) &&
 	    (curr->nr_cpus_allowed < 2 ||
 	     !dl_entity_preempt(&p->dl, &curr->dl)) &&
-	    (p->nr_cpus_allowed > 1)) ||
-	    static_branch_unlikely(&sched_asym_cpucapacity)) {
+	    (p->nr_cpus_allowed > 1)) || het) {
 		int target = find_later_rq(p);
 
 		if (target != -1 &&
 				(dl_time_before(p->dl.deadline,
 					cpu_rq(target)->dl.earliest_dl.curr) ||
-				(cpu_rq(target)->dl.dl_nr_running == 0)))
+				(cpu_rq(target)->dl.dl_nr_running == 0))) {
+			if (het && (target != cpu))
+				p->dl.dl_adjust = 1;
 			cpu = target;
+		}
 	}
 	rcu_read_unlock();
 
@@ -2369,6 +2407,9 @@ static void switched_to_dl(struct rq *rq, struct task_struct *p)
 		else
 			resched_curr(rq);
 	}
+
+	if (static_branch_unlikely(&sched_asym_cpucapacity))
+		p->dl.dl_adjust = 1;
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e5f9fd3aee80..1a8f75338ac2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -963,6 +963,8 @@ struct rq {
 
 	/* This is used to determine avg_idle's max value */
 	u64			max_idle_balance_cost;
+
+	struct task_struct	*migrating_task;
 #endif
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
-- 
2.20.1

