Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E598DCA9EC2
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 07:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE6C20862
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 07:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbfJ2H51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 03:57:27 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:37206 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727177AbfJ2H51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 03:57:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TgcHmlE_1572335840;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TgcHmlE_1572335840)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 29 Oct 2019 15:57:21 +0800
Subject: [PATCH v2] sched/numa: advanced per-cgroup numa statistic
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
References: <46b0fd25-7b73-aa80-372a-9fcd025154cb@linux.alibaba.com>
Message-ID: <682ed1d4-abf1-92f6-851f-567ff9b9a841@linux.alibaba.com>
Date:   Tue, 29 Oct 2019 15:57:20 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <46b0fd25-7b73-aa80-372a-9fcd025154cb@linux.alibaba.com>
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
time, sectioned by the locality into 7 regions.

For example the new entry 'cpu.numa_stat' show:
  locality 39541 60962 36842 72519 118605 721778 946553
  exectime 1220127 1458684

Here we know the workloads in hierarchy executed 1220127ms on node_0
and 1458684ms on node_1 in total, tasks with locality around 0~13%
executed for 39541 ms, and tasks with locality around 87~100% executed
for 946553 ms, which imply most of the memory access are local access.

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
Since v1:
  * reform the implementation based on per-cfs_rq accounting (Suggest by Peter)
    now update the cache-aligned numa_stat in entity_tick() for each cfs_rq
  * fix the calculation issue when number is too small

 include/linux/sched.h |  8 +++++++-
 kernel/sched/core.c   | 52 +++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/debug.c  |  7 +++++++
 kernel/sched/fair.c   | 25 +++++++++++++++++++++++++
 kernel/sched/sched.h  | 13 +++++++++++++
 5 files changed, 104 insertions(+), 1 deletion(-)

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
index eb42b71faab9..c87673f746b7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7638,6 +7638,45 @@ static u64 cpu_rt_period_read_uint(struct cgroup_subsys_state *css,
 }
 #endif /* CONFIG_RT_GROUP_SCHED */

+#ifdef CONFIG_NUMA_BALANCING
+static inline struct cfs_rq *tg_cfs_rq(struct task_group *tg, int cpu)
+{
+	return tg == &root_task_group ? &cpu_rq(cpu)->cfs : tg->cfs_rq[cpu];
+}
+
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
+			sum += tg_cfs_rq(tg, cpu)->nstat.locality[nr];
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
+			sum += tg_cfs_rq(tg, cpu)->nstat.jiffies;
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
@@ -7687,6 +7726,12 @@ static struct cftype cpu_legacy_files[] = {
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
@@ -7868,6 +7913,13 @@ static struct cftype cpu_files[] = {
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
index a81c36472822..9d4db18da548 100644
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
@@ -2739,6 +2745,20 @@ static void update_scan_period(struct task_struct *p, int new_cpu)
 	p->numa_scan_period = task_scan_start(p);
 }

+static void update_numa_statistics(struct cfs_rq *cfs_rq)
+{
+	int idx;
+	unsigned long remote = current->numa_faults_locality[3];
+	unsigned long local = current->numa_faults_locality[4];
+
+	cfs_rq->nstat.jiffies++;
+
+	if (!remote && !local)
+		return;
+
+	idx = (NR_NL_INTERVAL - 1) * local / (remote + local);
+	cfs_rq->nstat.locality[idx]++;
+}
 #else
 static void task_tick_numa(struct rq *rq, struct task_struct *curr)
 {
@@ -2756,6 +2776,9 @@ static inline void update_scan_period(struct task_struct *p, int new_cpu)
 {
 }

+static void update_numa_statistics(struct cfs_rq *cfs_rq)
+{
+}
 #endif /* CONFIG_NUMA_BALANCING */

 static void
@@ -4288,6 +4311,8 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
 	update_load_avg(cfs_rq, curr, UPDATE_TG);
 	update_cfs_group(curr);

+	update_numa_statistics(cfs_rq);
+
 #ifdef CONFIG_SCHED_HRTICK
 	/*
 	 * queued ticks are scheduled to match the slice, so don't bother
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0db2c1b3361e..6579a5499154 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -486,6 +486,16 @@ struct cfs_bandwidth { };

 #endif	/* CONFIG_CGROUP_SCHED */

+#ifdef CONFIG_NUMA_BALANCING
+/* NUMA Locality Interval, 7 buckets for cache align */
+#define NR_NL_INTERVAL	7
+
+struct numa_statistics {
+	u64 jiffies;
+	u64 locality[NR_NL_INTERVAL];
+};
+#endif
+
 /* CFS-related fields in a runqueue */
 struct cfs_rq {
 	struct load_weight	load;
@@ -575,6 +585,9 @@ struct cfs_rq {
 	struct list_head	throttled_list;
 #endif /* CONFIG_CFS_BANDWIDTH */
 #endif /* CONFIG_FAIR_GROUP_SCHED */
+#ifdef CONFIG_NUMA_BALANCING
+	struct numa_statistics	nstat ____cacheline_aligned;
+#endif
 };

 static inline int rt_bandwidth_enabled(void)
-- 
2.14.4.44.g2045bb6

