Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4032C04AAD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 05:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A678E20830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 05:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfEFFtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 01:49:00 -0400
Received: from ms01.santannapisa.it ([193.205.80.98]:57922 "EHLO
        mail.santannapisa.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfEFFtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 01:49:00 -0400
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 May 2019 01:48:55 EDT
Received: from [151.41.47.232] (account l.abeni@santannapisa.it HELO sweethome.home-life.hub)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 138841007; Mon, 06 May 2019 06:48:55 +0200
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
Subject: [RFC PATCH 1/6] sched/dl: Improve deadline admission control for asymmetric CPU capacities
Date:   Mon,  6 May 2019 06:48:31 +0200
Message-Id: <20190506044836.2914-2-luca.abeni@santannapisa.it>
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

Currently, the SCHED_DEADLINE admission control ensures that the
sum of reserved CPU bandwidths is smaller than x * M, where the
reserved CPU bandwidth of a SCHED_DEADLINE task is defined as the
ratio between its runtime and its period, x is a user-definable
percentage (95% by default, can be controlled through
/proc/sys/kernel/sched_rt_{runtime,period}_us) and M is the number
of CPU cores.

This admission control works well (guaranteeing bounded tardiness
for SCHED_DEADLINE tasks and non-starvation of non SCHED_DEADLINE
tasks) for homogeneous systems (where all the CPU cores have the
same computing capacity), but ends up over-allocating the CPU time
in presence of less-powerful CPU cores.

It can be easily shown how on asymmetric CPU capacity architectures
(such as ARM big.LITTLE) SCHED_DEADLINE tasks can easily starve all the
other tasks, making the system unusable.

This commit fixes the issue by explicitly considering the cores'
capacities in the admission test (where "M" is replaced by the sum
of all the capacities of cores in the root domain).

Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
---
 drivers/base/arch_topology.c   |  1 +
 include/linux/sched/topology.h |  3 +++
 kernel/sched/core.c            |  2 ++
 kernel/sched/deadline.c        | 19 +++++++++++++------
 kernel/sched/sched.h           |  7 +++++--
 kernel/sched/topology.c        |  9 +++++++++
 6 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index edfcf8d982e4..646d6d349d53 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -36,6 +36,7 @@ DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
 
 void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity)
 {
+	topology_update_cpu_capacity(cpu, per_cpu(cpu_scale, cpu), capacity);
 	per_cpu(cpu_scale, cpu) = capacity;
 }
 
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 2bf680b42f3c..a4898e42f368 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -233,4 +233,7 @@ static inline int task_node(const struct task_struct *p)
 	return cpu_to_node(task_cpu(p));
 }
 
+void topology_update_cpu_capacity(unsigned int cpu, unsigned long old,
+				  unsigned long new);
+
 #endif /* _LINUX_SCHED_TOPOLOGY_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d8456801caa3..a37bbb246802 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6271,6 +6271,7 @@ void set_rq_online(struct rq *rq)
 			if (class->rq_online)
 				class->rq_online(rq);
 		}
+		rq->rd->rd_capacity += arch_scale_cpu_capacity(NULL, cpu_of(rq));
 	}
 }
 
@@ -6286,6 +6287,7 @@ void set_rq_offline(struct rq *rq)
 
 		cpumask_clear_cpu(rq->cpu, rq->rd->online);
 		rq->online = 0;
+		rq->rd->rd_capacity -= arch_scale_cpu_capacity(NULL, cpu_of(rq));
 	}
 }
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 6a73e41a2016..5b981eeeb944 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -63,6 +63,10 @@ static inline int dl_bw_cpus(int i)
 
 	return cpus;
 }
+static inline unsigned long rd_capacity(struct rq *rq)
+{
+	return rq->rd->rd_capacity;
+}
 #else
 static inline struct dl_bw *dl_bw_of(int i)
 {
@@ -73,6 +77,11 @@ static inline int dl_bw_cpus(int i)
 {
 	return 1;
 }
+
+static inline unsigned long rd_capacity(struct rq *rq)
+{
+	return SCHED_CAPACITY_SCALE;
+}
 #endif
 
 static inline
@@ -2535,13 +2544,13 @@ int sched_dl_overflow(struct task_struct *p, int policy,
 	raw_spin_lock(&dl_b->lock);
 	cpus = dl_bw_cpus(task_cpu(p));
 	if (dl_policy(policy) && !task_has_dl_policy(p) &&
-	    !__dl_overflow(dl_b, cpus, 0, new_bw)) {
+	    !__dl_overflow(dl_b, rd_capacity(task_rq(p)), 0, new_bw)) {
 		if (hrtimer_active(&p->dl.inactive_timer))
 			__dl_sub(dl_b, p->dl.dl_bw, cpus);
 		__dl_add(dl_b, new_bw, cpus);
 		err = 0;
 	} else if (dl_policy(policy) && task_has_dl_policy(p) &&
-		   !__dl_overflow(dl_b, cpus, p->dl.dl_bw, new_bw)) {
+		   !__dl_overflow(dl_b, rd_capacity(task_rq(p)), p->dl.dl_bw, new_bw)) {
 		/*
 		 * XXX this is slightly incorrect: when the task
 		 * utilization decreases, we should delay the total
@@ -2689,7 +2698,7 @@ int dl_task_can_attach(struct task_struct *p, const struct cpumask *cs_cpus_allo
 	dl_b = dl_bw_of(dest_cpu);
 	raw_spin_lock_irqsave(&dl_b->lock, flags);
 	cpus = dl_bw_cpus(dest_cpu);
-	overflow = __dl_overflow(dl_b, cpus, 0, p->dl.dl_bw);
+	overflow = __dl_overflow(dl_b, rd_capacity(cpu_rq(dest_cpu)), 0, p->dl.dl_bw);
 	if (overflow) {
 		ret = -EBUSY;
 	} else {
@@ -2734,13 +2743,11 @@ bool dl_cpu_busy(unsigned int cpu)
 	unsigned long flags;
 	struct dl_bw *dl_b;
 	bool overflow;
-	int cpus;
 
 	rcu_read_lock_sched();
 	dl_b = dl_bw_of(cpu);
 	raw_spin_lock_irqsave(&dl_b->lock, flags);
-	cpus = dl_bw_cpus(cpu);
-	overflow = __dl_overflow(dl_b, cpus, 0, 0);
+	overflow = __dl_overflow(dl_b, rd_capacity(cpu_rq(cpu)), 0, 0);
 	raw_spin_unlock_irqrestore(&dl_b->lock, flags);
 	rcu_read_unlock_sched();
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 69114842d640..32d242694863 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -305,10 +305,11 @@ void __dl_add(struct dl_bw *dl_b, u64 tsk_bw, int cpus)
 }
 
 static inline
-bool __dl_overflow(struct dl_bw *dl_b, int cpus, u64 old_bw, u64 new_bw)
+bool __dl_overflow(struct dl_bw *dl_b, unsigned long cap, u64 old_bw, u64 new_bw)
 {
 	return dl_b->bw != -1 &&
-	       dl_b->bw * cpus < dl_b->total_bw - old_bw + new_bw;
+	       (dl_b->bw * cap) >> SCHED_CAPACITY_SHIFT <
+	       dl_b->total_bw - old_bw + new_bw;
 }
 
 extern void dl_change_utilization(struct task_struct *p, u64 new_bw);
@@ -785,6 +786,8 @@ struct root_domain {
 	unsigned long		max_cpu_capacity;
 	unsigned long		min_cpu_capacity;
 
+	unsigned long           rd_capacity;
+
 	/*
 	 * NULL-terminated list of performance domains intersecting with the
 	 * CPUs of the rd. Protected by RCU.
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index b1c4b68a4d17..1cd20a2e5bc8 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2255,3 +2255,12 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 
 	mutex_unlock(&sched_domains_mutex);
 }
+
+void topology_update_cpu_capacity(unsigned int cpu, unsigned long old,
+				  unsigned long new)
+{
+	struct rq *rq = cpu_rq(cpu);
+
+	rq->rd->rd_capacity -= old;
+	rq->rd->rd_capacity += new;
+}
-- 
2.20.1

