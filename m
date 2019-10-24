Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	TVD_PH_BODY_ACCOUNTS_PRE,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F19CA9EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 03:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D452084B
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 03:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408318AbfJXDIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 23:08:07 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:34218 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2408284AbfJXDIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 23:08:06 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Tg13mWi_1571886481;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0Tg13mWi_1571886481)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 24 Oct 2019 11:08:02 +0800
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Subject: [PATCH] sched/numa: advanced per-cgroup numa statistic
Message-ID: <46b0fd25-7b73-aa80-372a-9fcd025154cb@linux.alibaba.com>
Date:   Thu, 24 Oct 2019 11:08:01 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there are no good approach to monitoring the per-cgroup
numa efficiency, this could be a trouble especially when groups
are sharing CPUs, it's impossible to tell which one caused the
remote-memory access by reading hardware counter since multiple
workloads could sharing the same CPU, which make it painful when
one want to find out the root cause and fix the issue.

In order to address this, we introduced new per-cgroup statistic
for numa:
  * the numa locality to imply the numa balancing efficiency
  * the numa execution time on each node

The task locality is the local page accessing ratio traced on numa
balancing PF, and the group locality is the topology of task execution
time, sectioned by the locality into 8 regions.

For example the new entry 'cpu.numa_stat' show:
  locality 15393 21259 13023 44461 21247 17012 28496 145402
  exectime 311900 407166

Here we know the workloads executed 311900ms on node_0 and 407166ms
on node_1, tasks with locality around 0~12% executed for 15393 ms, and
tasks with locality around 88~100% executed for 145402 ms, which imply
most of the memory access is local access, for the workloads of this
group.

By monitoring the new statistic, we will be able to know the numa
efficiency of each per-cgroup workloads on machine, whatever they
sharing the CPUs or not, we will be able to find out which one
introduced the remote access mostly.

Besides, per-node memory topology from 'memory.numa_stat' become
more useful when we have the per-node execution time, workloads
always executing on node_0 while it's memory is all on node_1 is
usually a bad case.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
---
 include/linux/sched.h |  8 ++++++-
 kernel/sched/core.c   | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/debug.c  |  7 ++++++
 kernel/sched/fair.c   | 51 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h  | 29 +++++++++++++++++++++++++
 5 files changed, 153 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 263cf089d1b3..46995be622c1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1114,8 +1114,14 @@ struct task_struct {
 	 * scan window were remote/local or failed to migrate. The task scan
 	 * period is adapted based on the locality of the faults with different
 	 * weights depending on whether they were shared or private faults
+	 *
+	 * 0 -- remote faults
+	 * 1 -- local faults
+	 * 2 -- page migration failure
+	 * 3 -- remote page accessing
+	 * 4 -- local page accessing
 	 */
-	unsigned long			numa_faults_locality[3];
+	unsigned long			numa_faults_locality[5];

 	unsigned long			numa_pages_migrated;
 #endif /* CONFIG_NUMA_BALANCING */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index eb42b71faab9..4364da279f04 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6544,6 +6544,10 @@ static struct kmem_cache *task_group_cache __read_mostly;
 DECLARE_PER_CPU(cpumask_var_t, load_balance_mask);
 DECLARE_PER_CPU(cpumask_var_t, select_idle_mask);

+#ifdef CONFIG_NUMA_BALANCING
+DECLARE_PER_CPU(struct numa_stat, root_numa_stat);
+#endif
+
 void __init sched_init(void)
 {
 	unsigned long ptr = 0;
@@ -6593,6 +6597,10 @@ void __init sched_init(void)
 	init_defrootdomain();
 #endif

+#ifdef CONFIG_NUMA_BALANCING
+	root_task_group.numa_stat = &root_numa_stat;
+#endif
+
 #ifdef CONFIG_RT_GROUP_SCHED
 	init_rt_bandwidth(&root_task_group.rt_bandwidth,
 			global_rt_period(), global_rt_runtime());
@@ -6918,6 +6926,7 @@ static inline void alloc_uclamp_sched_group(struct task_group *tg,

 static void sched_free_group(struct task_group *tg)
 {
+	free_tg_numa_stat(tg);
 	free_fair_sched_group(tg);
 	free_rt_sched_group(tg);
 	autogroup_free(tg);
@@ -6933,6 +6942,9 @@ struct task_group *sched_create_group(struct task_group *parent)
 	if (!tg)
 		return ERR_PTR(-ENOMEM);

+	if (!alloc_tg_numa_stat(tg))
+		goto err;
+
 	if (!alloc_fair_sched_group(tg, parent))
 		goto err;

@@ -7638,6 +7650,40 @@ static u64 cpu_rt_period_read_uint(struct cgroup_subsys_state *css,
 }
 #endif /* CONFIG_RT_GROUP_SCHED */

+#ifdef CONFIG_NUMA_BALANCING
+static int cpu_numa_stat_show(struct seq_file *sf, void *v)
+{
+	int nr;
+	struct task_group *tg = css_tg(seq_css(sf));
+
+	seq_puts(sf, "locality");
+	for (nr = 0; nr < NR_NL_INTERVAL; nr++) {
+		int cpu;
+		u64 sum = 0;
+
+		for_each_possible_cpu(cpu)
+			sum += per_cpu(tg->numa_stat->locality[nr], cpu);
+
+		seq_printf(sf, " %u", jiffies_to_msecs(sum));
+	}
+	seq_putc(sf, '\n');
+
+	seq_puts(sf, "exectime");
+	for_each_online_node(nr) {
+		int cpu;
+		u64 sum = 0;
+
+		for_each_cpu(cpu, cpumask_of_node(nr))
+			sum += per_cpu(tg->numa_stat->jiffies, cpu);
+
+		seq_printf(sf, " %u", jiffies_to_msecs(sum));
+	}
+	seq_putc(sf, '\n');
+
+	return 0;
+}
+#endif
+
 static struct cftype cpu_legacy_files[] = {
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	{
@@ -7687,6 +7733,12 @@ static struct cftype cpu_legacy_files[] = {
 		.seq_show = cpu_uclamp_max_show,
 		.write = cpu_uclamp_max_write,
 	},
+#endif
+#ifdef CONFIG_NUMA_BALANCING
+	{
+		.name = "numa_stat",
+		.seq_show = cpu_numa_stat_show,
+	},
 #endif
 	{ }	/* Terminate */
 };
@@ -7868,6 +7920,13 @@ static struct cftype cpu_files[] = {
 		.seq_show = cpu_uclamp_max_show,
 		.write = cpu_uclamp_max_write,
 	},
+#endif
+#ifdef CONFIG_NUMA_BALANCING
+	{
+		.name = "numa_stat",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = cpu_numa_stat_show,
+	},
 #endif
 	{ }	/* terminate */
 };
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index f7e4579e746c..a22b2a62aee2 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -848,6 +848,13 @@ static void sched_show_numa(struct task_struct *p, struct seq_file *m)
 	P(total_numa_faults);
 	SEQ_printf(m, "current_node=%d, numa_group_id=%d\n",
 			task_node(p), task_numa_group_id(p));
+	SEQ_printf(m, "faults_locality local=%lu remote=%lu failed=%lu ",
+			p->numa_faults_locality[1],
+			p->numa_faults_locality[0],
+			p->numa_faults_locality[2]);
+	SEQ_printf(m, "lhit=%lu rhit=%lu\n",
+			p->numa_faults_locality[4],
+			p->numa_faults_locality[3]);
 	show_numa_stats(p, m);
 	mpol_put(pol);
 #endif
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a81c36472822..4ba3a41cdca3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2466,6 +2466,12 @@ void task_numa_fault(int last_cpupid, int mem_node, int pages, int flags)
 	p->numa_faults[task_faults_idx(NUMA_MEMBUF, mem_node, priv)] += pages;
 	p->numa_faults[task_faults_idx(NUMA_CPUBUF, cpu_node, priv)] += pages;
 	p->numa_faults_locality[local] += pages;
+	/*
+	 * We want to have the real local/remote page access statistic
+	 * here, so use 'mem_node' which is the real residential node of
+	 * page after migrate_misplaced_page().
+	 */
+	p->numa_faults_locality[3 + !!(mem_node == numa_node_id())] += pages;
 }

 static void reset_ptenuma_scan(struct task_struct *p)
@@ -2672,6 +2678,49 @@ void init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 	}
 }

+DEFINE_PER_CPU(struct numa_stat, root_numa_stat);
+
+int alloc_tg_numa_stat(struct task_group *tg)
+{
+	tg->numa_stat = alloc_percpu(struct numa_stat);
+	if (!tg->numa_stat)
+		return 0;
+
+	return 1;
+}
+
+void free_tg_numa_stat(struct task_group *tg)
+{
+	free_percpu(tg->numa_stat);
+}
+
+static void update_tg_numa_stat(struct task_struct *p)
+{
+	struct task_group *tg;
+	unsigned long remote = p->numa_faults_locality[3];
+	unsigned long local = p->numa_faults_locality[4];
+	int idx = -1;
+
+	/* Tobe scaled? */
+	if (remote || local)
+		idx = NR_NL_INTERVAL * local / (remote + local + 1);
+
+	rcu_read_lock();
+
+	tg = task_group(p);
+	while (tg) {
+		/* skip account when there are no faults records */
+		if (idx != -1)
+			this_cpu_inc(tg->numa_stat->locality[idx]);
+
+		this_cpu_inc(tg->numa_stat->jiffies);
+
+		tg = tg->parent;
+	}
+
+	rcu_read_unlock();
+}
+
 /*
  * Drive the periodic memory faults..
  */
@@ -2686,6 +2735,8 @@ static void task_tick_numa(struct rq *rq, struct task_struct *curr)
 	if (!curr->mm || (curr->flags & PF_EXITING) || work->next != work)
 		return;

+	update_tg_numa_stat(curr);
+
 	/*
 	 * Using runtime rather than walltime has the dual advantage that
 	 * we (mostly) drive the selection from busy threads and that the
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0db2c1b3361e..fd1ea597e349 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -351,6 +351,18 @@ struct cfs_bandwidth {
 #endif
 };

+#ifdef CONFIG_NUMA_BALANCING
+
+/* NUMA Locality Interval, 8 bucket for cache align */
+#define NR_NL_INTERVAL	8
+
+struct numa_stat {
+	u64 locality[NR_NL_INTERVAL];
+	u64 jiffies;
+};
+
+#endif
+
 /* Task group related information */
 struct task_group {
 	struct cgroup_subsys_state css;
@@ -401,8 +413,25 @@ struct task_group {
 	struct uclamp_se	uclamp[UCLAMP_CNT];
 #endif

+#ifdef CONFIG_NUMA_BALANCING
+	struct numa_stat __percpu *numa_stat;
+#endif
 };

+#ifdef CONFIG_NUMA_BALANCING
+int alloc_tg_numa_stat(struct task_group *tg);
+void free_tg_numa_stat(struct task_group *tg);
+#else
+static int alloc_tg_numa_stat(struct task_group *tg)
+{
+	return 1;
+}
+
+static void free_tg_numa_stat(struct task_group *tg)
+{
+}
+#endif
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 #define ROOT_TASK_GROUP_LOAD	NICE_0_LOAD

-- 
2.14.4.44.g2045bb6

