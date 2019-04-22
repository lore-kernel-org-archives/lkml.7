Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4A0C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 02:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D842A2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 02:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfDVCLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 22:11:32 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:54760 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725961AbfDVCLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 22:11:32 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TPtsXaT_1555899084;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TPtsXaT_1555899084)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 22 Apr 2019 10:11:25 +0800
Subject: [RFC PATCH 1/5] numa: introduce per-cgroup numa balancing locality,
 statistic
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
To:     Peter Zijlstra <peterz@infradead.org>, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <209d247e-c1b2-3235-2722-dd7c1f896483@linux.alibaba.com>
Message-ID: <c0ec8861-2387-e73b-e450-2d636557a3dd@linux.alibaba.com>
Date:   Mon, 22 Apr 2019 10:11:24 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <209d247e-c1b2-3235-2722-dd7c1f896483@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduced numa locality statistic, which try to imply
the numa balancing efficiency per memory cgroup.

By doing 'cat /sys/fs/cgroup/memory/CGROUP_PATH/memory.numa_stat', we
see new output line heading with 'locality', the format is:

  locality 0~9% 10%~19% 20%~29% 30%~39% 40%~49% 50%~59% 60%~69% 70%~79%
80%~89% 90%~100%

interval means that on a task's last numa balancing, the percentage
of accessing local pages, which we called numa balancing locality.

And the number means inside the cgroup, how many ticks we hit tasks with
such locality are running, for example:

  locality 7260278 54860 90493 209327 295801 462784 558897 667242
2786324 7399308

the 7260278 means that this cgroup have some tasks with 0~9% locality
executed 7260278 ticks.

By monitoring the increment, we can check if the workload of a particular
cgroup is doing well with numa, when most of the tasks are running with
locality 0~9%, then something is wrong with your numa policy.

Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
---
 include/linux/memcontrol.h | 38 +++++++++++++++++++++++++++++++++++
 include/linux/sched.h      |  8 +++++++-
 kernel/sched/debug.c       |  7 +++++++
 kernel/sched/fair.c        |  8 ++++++++
 mm/huge_memory.c           |  4 +---
 mm/memcontrol.c            | 50 ++++++++++++++++++++++++++++++++++++++++++++++
 mm/memory.c                |  5 ++---
 7 files changed, 113 insertions(+), 7 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 534267947664..bb62e6294484 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -179,6 +179,27 @@ enum memcg_kmem_state {
 	KMEM_ONLINE,
 };

+#ifdef CONFIG_NUMA_BALANCING
+
+enum memcg_numa_locality_interval {
+	PERCENT_0_9,
+	PERCENT_10_19,
+	PERCENT_20_29,
+	PERCENT_30_39,
+	PERCENT_40_49,
+	PERCENT_50_59,
+	PERCENT_60_69,
+	PERCENT_70_79,
+	PERCENT_80_89,
+	PERCENT_90_100,
+	NR_NL_INTERVAL,
+};
+
+struct memcg_stat_numa {
+	u64 locality[NR_NL_INTERVAL];
+};
+
+#endif
 #if defined(CONFIG_SMP)
 struct memcg_padding {
 	char x[0];
@@ -311,6 +332,10 @@ struct mem_cgroup {
 	struct list_head event_list;
 	spinlock_t event_list_lock;

+#ifdef CONFIG_NUMA_BALANCING
+	struct memcg_stat_numa __percpu *stat_numa;
+#endif
+
 	struct mem_cgroup_per_node *nodeinfo[0];
 	/* WARNING: nodeinfo must be the last member here */
 };
@@ -818,6 +843,14 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
 void mem_cgroup_split_huge_fixup(struct page *head);
 #endif

+#ifdef CONFIG_NUMA_BALANCING
+extern void memcg_stat_numa_update(struct task_struct *p);
+#else
+static inline void memcg_stat_numa_update(struct task_struct *p)
+{
+}
+#endif
+
 #else /* CONFIG_MEMCG */

 #define MEM_CGROUP_ID_SHIFT	0
@@ -1156,6 +1189,11 @@ static inline
 void count_memcg_event_mm(struct mm_struct *mm, enum vm_event_item idx)
 {
 }
+
+static inline void memcg_stat_numa_update(struct task_struct *p)
+{
+}
+
 #endif /* CONFIG_MEMCG */

 /* idx can be of type enum memcg_stat_item or node_stat_item */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1a3c28d997d4..0b01262d110d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1049,8 +1049,14 @@ struct task_struct {
 	 * scan window were remote/local or failed to migrate. The task scan
 	 * period is adapted based on the locality of the faults with different
 	 * weights depending on whether they were shared or private faults
+	 *
+	 * 0 -- remote faults
+	 * 1 -- local faults
+	 * 2 -- page migration failure
+	 * 3 -- remote page accessing after page migration
+	 * 4 -- local page accessing after page migration
 	 */
-	unsigned long			numa_faults_locality[3];
+	unsigned long			numa_faults_locality[5];

 	unsigned long			numa_pages_migrated;
 #endif /* CONFIG_NUMA_BALANCING */
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 8039d62ae36e..2898f5fa4fba 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -873,6 +873,13 @@ static void sched_show_numa(struct task_struct *p, struct seq_file *m)
 	SEQ_printf(m, "current_node=%d, numa_group_id=%d\n",
 			task_node(p), task_numa_group_id(p));
 	show_numa_stats(p, m);
+	SEQ_printf(m, "faults_locality local=%lu remote=%lu failed=%lu ",
+			p->numa_faults_locality[1],
+			p->numa_faults_locality[0],
+			p->numa_faults_locality[2]);
+	SEQ_printf(m, "lhit=%lu rhit=%lu\n",
+			p->numa_faults_locality[4],
+			p->numa_faults_locality[3]);
 	mpol_put(pol);
 #endif
 }
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fdab7eb6f351..ba5a67139d57 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -23,6 +23,7 @@
 #include "sched.h"

 #include <trace/events/sched.h>
+#include <linux/memcontrol.h>

 /*
  * Targeted preemption latency for CPU-bound tasks:
@@ -2387,6 +2388,11 @@ void task_numa_fault(int last_cpupid, int mem_node, int pages, int flags)
 		memset(p->numa_faults_locality, 0, sizeof(p->numa_faults_locality));
 	}

+	p->numa_faults_locality[mem_node == numa_node_id() ? 4 : 3] += pages;
+
+	if (mem_node == NUMA_NO_NODE)
+		return;
+
 	/*
 	 * First accesses are treated as private, otherwise consider accesses
 	 * to be private if the accessing pid has not changed
@@ -2604,6 +2610,8 @@ void task_tick_numa(struct rq *rq, struct task_struct *curr)
 	if (!curr->mm || (curr->flags & PF_EXITING) || work->next != work)
 		return;

+	memcg_stat_numa_update(curr);
+
 	/*
 	 * Using runtime rather than walltime has the dual advantage that
 	 * we (mostly) drive the selection from busy threads and that the
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 404acdcd0455..2614ce725a63 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1621,9 +1621,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t pmd)
 	if (anon_vma)
 		page_unlock_anon_vma_read(anon_vma);

-	if (page_nid != NUMA_NO_NODE)
-		task_numa_fault(last_cpupid, page_nid, HPAGE_PMD_NR,
-				flags);
+	task_numa_fault(last_cpupid, page_nid, HPAGE_PMD_NR, flags);

 	return 0;
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c532f8685aa3..b810d4e9c906 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -66,6 +66,7 @@
 #include <linux/lockdep.h>
 #include <linux/file.h>
 #include <linux/tracehook.h>
+#include <linux/cpuset.h>
 #include "internal.h"
 #include <net/sock.h>
 #include <net/ip.h>
@@ -3396,10 +3397,50 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
 		seq_putc(m, '\n');
 	}

+#ifdef CONFIG_NUMA_BALANCING
+	seq_puts(m, "locality");
+	for (nr = 0; nr < NR_NL_INTERVAL; nr++) {
+		int cpu;
+		u64 sum = 0;
+
+		for_each_possible_cpu(cpu)
+			sum += per_cpu(memcg->stat_numa->locality[nr], cpu);
+
+		seq_printf(m, " %llu", sum);
+	}
+	seq_putc(m, '\n');
+#endif
+
 	return 0;
 }
 #endif /* CONFIG_NUMA */

+#ifdef CONFIG_NUMA_BALANCING
+
+void memcg_stat_numa_update(struct task_struct *p)
+{
+	struct mem_cgroup *memcg;
+	unsigned long remote = p->numa_faults_locality[3];
+	unsigned long local = p->numa_faults_locality[4];
+	unsigned long idx = -1;
+
+	if (mem_cgroup_disabled())
+		return;
+
+	if (remote || local) {
+		idx = (local * 10) / (remote + local);
+		if (idx >= NR_NL_INTERVAL)
+			idx = NR_NL_INTERVAL - 1;
+	}
+
+	rcu_read_lock();
+	memcg = mem_cgroup_from_task(p);
+	if (idx != -1)
+		this_cpu_inc(memcg->stat_numa->locality[idx]);
+	rcu_read_unlock();
+}
+#endif
+
 /* Universal VM events cgroup1 shows, original sort order */
 static const unsigned int memcg1_events[] = {
 	PGPGIN,
@@ -4435,6 +4476,9 @@ static void __mem_cgroup_free(struct mem_cgroup *memcg)

 	for_each_node(node)
 		free_mem_cgroup_per_node_info(memcg, node);
+#ifdef CONFIG_NUMA_BALANCING
+	free_percpu(memcg->stat_numa);
+#endif
 	free_percpu(memcg->vmstats_percpu);
 	kfree(memcg);
 }
@@ -4468,6 +4512,12 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	if (!memcg->vmstats_percpu)
 		goto fail;

+#ifdef CONFIG_NUMA_BALANCING
+	memcg->stat_numa = alloc_percpu(struct memcg_stat_numa);
+	if (!memcg->stat_numa)
+		goto fail;
+#endif
+
 	for_each_node(node)
 		if (alloc_mem_cgroup_per_node_info(memcg, node))
 			goto fail;
diff --git a/mm/memory.c b/mm/memory.c
index c0391a9f18b8..fb0c1d940d36 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3609,7 +3609,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	struct vm_area_struct *vma = vmf->vma;
 	struct page *page = NULL;
 	int page_nid = NUMA_NO_NODE;
-	int last_cpupid;
+	int last_cpupid = 0;
 	int target_nid;
 	bool migrated = false;
 	pte_t pte, old_pte;
@@ -3689,8 +3689,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 		flags |= TNF_MIGRATE_FAIL;

 out:
-	if (page_nid != NUMA_NO_NODE)
-		task_numa_fault(last_cpupid, page_nid, 1, flags);
+	task_numa_fault(last_cpupid, page_nid, 1, flags);
 	return 0;
 }

-- 
2.14.4.44.g2045bb6

