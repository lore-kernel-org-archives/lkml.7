Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5309CC282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 02:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195742087F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 02:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfDVCNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 22:13:42 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:54389 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726054AbfDVCNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 22:13:42 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TPtrPj4_1555899216;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TPtrPj4_1555899216)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 22 Apr 2019 10:13:36 +0800
Subject: [RFC PATCH 3/5] numa: introduce per-cgroup preferred numa node
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
To:     Peter Zijlstra <peterz@infradead.org>, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <209d247e-c1b2-3235-2722-dd7c1f896483@linux.alibaba.com>
Message-ID: <77452c03-bc4c-7aed-e605-d5351f868586@linux.alibaba.com>
Date:   Mon, 22 Apr 2019 10:13:36 +0800
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

This patch add a new entry 'numa_preferred' for each memory cgroup,
by which we can now override the memory policy of the tasks inside
a particular cgroup, combined with numa balancing, we now be able to
migrate the workloads of a cgroup to the specified numa node, in gentle
way.

The load balancing and numa prefer against each other on CPU locations,
which lead into the situation that although a particular node is capable
enough to hold all the workloads, tasks will still spread.

In order to acquire the numa benifit in this situation,  load balancing
should respect the prefer decision as long as the balancing won't be
broken.

This patch try to forbid workloads leave memcg preferred node, when
and only when numa preferred node configured, in case if load balancing
can't find other tasks to move and keep failing, we will then giveup
and allow the migration to happen.

Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
---
 include/linux/memcontrol.h | 34 +++++++++++++++++++
 include/linux/sched.h      |  1 +
 kernel/sched/debug.c       |  1 +
 kernel/sched/fair.c        | 33 +++++++++++++++++++
 mm/huge_memory.c           |  3 ++
 mm/memcontrol.c            | 82 ++++++++++++++++++++++++++++++++++++++++++++++
 mm/memory.c                |  4 +++
 mm/mempolicy.c             |  4 +++
 8 files changed, 162 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e784d6252d5e..0fd5eeb27c4f 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -335,6 +335,8 @@ struct mem_cgroup {

 #ifdef CONFIG_NUMA_BALANCING
 	struct memcg_stat_numa __percpu *stat_numa;
+	s64 numa_preferred;
+	struct mutex numa_mutex;
 #endif

 	struct mem_cgroup_per_node *nodeinfo[0];
@@ -846,10 +848,26 @@ void mem_cgroup_split_huge_fixup(struct page *head);

 #ifdef CONFIG_NUMA_BALANCING
 extern void memcg_stat_numa_update(struct task_struct *p);
+extern int memcg_migrate_prep(int target_nid, int page_nid);
+extern int memcg_preferred_nid(struct task_struct *p, gfp_t gfp);
+extern struct page *alloc_page_numa_preferred(gfp_t gfp, unsigned int order);
 #else
 static inline void memcg_stat_numa_update(struct task_struct *p)
 {
 }
+static inline int memcg_migrate_prep(int target_nid, int page_nid)
+{
+	return target_nid;
+}
+static inline int memcg_preferred_nid(struct task_struct *p, gfp_t gfp)
+{
+	return -1;
+}
+static inline struct page *alloc_page_numa_preferred(gfp_t gfp,
+						     unsigned int order)
+{
+	return NULL;
+}
 #endif

 #else /* CONFIG_MEMCG */
@@ -1195,6 +1213,22 @@ static inline void memcg_stat_numa_update(struct task_struct *p)
 {
 }

+static inline int memcg_migrate_prep(int target_nid, int page_nid)
+{
+	return target_nid;
+}
+
+static inline int memcg_preferred_nid(struct task_struct *p, gfp_t gfp)
+{
+	return -1;
+}
+
+static inline struct page *alloc_page_numa_preferred(gfp_t gfp,
+						     unsigned int order)
+{
+	return NULL;
+}
+
 #endif /* CONFIG_MEMCG */

 /* idx can be of type enum memcg_stat_item or node_stat_item */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 0b01262d110d..9f931db1d31f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -422,6 +422,7 @@ struct sched_statistics {
 	u64				nr_migrations_cold;
 	u64				nr_failed_migrations_affine;
 	u64				nr_failed_migrations_running;
+	u64				nr_failed_migrations_memcg;
 	u64				nr_failed_migrations_hot;
 	u64				nr_forced_migrations;

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 2898f5fa4fba..32f5fd66f0fe 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -934,6 +934,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 		P_SCHEDSTAT(se.statistics.nr_migrations_cold);
 		P_SCHEDSTAT(se.statistics.nr_failed_migrations_affine);
 		P_SCHEDSTAT(se.statistics.nr_failed_migrations_running);
+		P_SCHEDSTAT(se.statistics.nr_failed_migrations_memcg);
 		P_SCHEDSTAT(se.statistics.nr_failed_migrations_hot);
 		P_SCHEDSTAT(se.statistics.nr_forced_migrations);
 		P_SCHEDSTAT(se.statistics.nr_wakeups);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ba5a67139d57..5d0758e78b96 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6701,6 +6701,10 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 		new_cpu = find_idlest_cpu(sd, p, cpu, prev_cpu, sd_flag);
 	} else if (sd_flag & SD_BALANCE_WAKE) { /* XXX always ? */
 		/* Fast path */
+		int pnid = memcg_preferred_nid(p, 0);
+
+		if (pnid != NUMA_NO_NODE && pnid != cpu_to_node(new_cpu))
+			new_cpu = prev_cpu;

 		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);

@@ -7404,12 +7408,36 @@ static int migrate_degrades_locality(struct task_struct *p, struct lb_env *env)
 	return dst_weight < src_weight;
 }

+static inline bool memcg_migrate_allow(struct task_struct *p,
+					struct lb_env *env)
+{
+	int src_nid, dst_nid, pnid;
+
+	/* failed too much could imply balancing broken, now be a good boy */
+	if (env->sd->nr_balance_failed > env->sd->cache_nice_tries)
+		return true;
+
+	src_nid = cpu_to_node(env->src_cpu);
+	dst_nid = cpu_to_node(env->dst_cpu);
+
+	pnid = memcg_preferred_nid(p, 0);
+	if (pnid != dst_nid && pnid == src_nid)
+		return false;
+
+	return true;
+}
 #else
 static inline int migrate_degrades_locality(struct task_struct *p,
 					     struct lb_env *env)
 {
 	return -1;
 }
+
+static inline bool memcg_migrate_allow(struct task_struct *p,
+					struct lb_env *env)
+{
+	return true;
+}
 #endif

 /*
@@ -7470,6 +7498,11 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 		return 0;
 	}

+	if (!memcg_migrate_allow(p, env)) {
+		schedstat_inc(p->se.statistics.nr_failed_migrations_memcg);
+		return 0;
+	}
+
 	/*
 	 * Aggressive migration if:
 	 * 1) destination numa is preferred
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2614ce725a63..c01e1bb22477 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1523,6 +1523,9 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t pmd)
 	 */
 	page_locked = trylock_page(page);
 	target_nid = mpol_misplaced(page, vma, haddr);
+
+	target_nid = memcg_migrate_prep(target_nid, page_nid);
+
 	if (target_nid == NUMA_NO_NODE) {
 		/* If the page was locked, there are no parallel migrations */
 		if (page_locked)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 91bcd71fc38a..f1cb1e726430 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3452,6 +3452,79 @@ void memcg_stat_numa_update(struct task_struct *p)
 	this_cpu_inc(memcg->stat_numa->exectime);
 	rcu_read_unlock();
 }
+
+static s64 memcg_numa_preferred_read_s64(struct cgroup_subsys_state *css,
+				struct cftype *cft)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
+
+	return memcg->numa_preferred;
+}
+
+static int memcg_numa_preferred_write_s64(struct cgroup_subsys_state *css,
+				struct cftype *cft, s64 val)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
+
+	if (val != NUMA_NO_NODE && !node_isset(val, node_possible_map))
+		return -EINVAL;
+
+	mutex_lock(&memcg->numa_mutex);
+	memcg->numa_preferred = val;
+	mutex_unlock(&memcg->numa_mutex);
+
+	return 0;
+}
+
+int memcg_preferred_nid(struct task_struct *p, gfp_t gfp)
+{
+	int preferred_nid = NUMA_NO_NODE;
+
+	if (!mem_cgroup_disabled() &&
+	    !in_interrupt() &&
+	    !(gfp & __GFP_THISNODE)) {
+		struct mem_cgroup *memcg;
+
+		rcu_read_lock();
+		memcg = mem_cgroup_from_task(p);
+		if (memcg)
+			preferred_nid = memcg->numa_preferred;
+		rcu_read_unlock();
+	}
+
+	return preferred_nid;
+}
+
+int memcg_migrate_prep(int target_nid, int page_nid)
+{
+	bool ret = false;
+	unsigned int cookie;
+	int preferred_nid = memcg_preferred_nid(current, 0);
+
+	if (preferred_nid == NUMA_NO_NODE)
+		return target_nid;
+
+	do {
+		cookie = read_mems_allowed_begin();
+		ret = node_isset(preferred_nid, current->mems_allowed);
+	} while (read_mems_allowed_retry(cookie));
+
+	if (ret)
+		return page_nid == preferred_nid ? NUMA_NO_NODE : preferred_nid;
+
+	return target_nid;
+}
+
+struct page *alloc_page_numa_preferred(gfp_t gfp, unsigned int order)
+{
+	int pnid = memcg_preferred_nid(current, gfp);
+
+	if (pnid == NUMA_NO_NODE || !node_isset(pnid, current->mems_allowed))
+		return NULL;
+
+	return __alloc_pages_node(pnid, gfp, order);
+}
+
 #endif

 /* Universal VM events cgroup1 shows, original sort order */
@@ -4309,6 +4382,13 @@ static struct cftype mem_cgroup_legacy_files[] = {
 		.name = "numa_stat",
 		.seq_show = memcg_numa_stat_show,
 	},
+#endif
+#ifdef CONFIG_NUMA_BALANCING
+	{
+		.name = "numa_preferred",
+		.read_s64 = memcg_numa_preferred_read_s64,
+		.write_s64 = memcg_numa_preferred_write_s64,
+	},
 #endif
 	{
 		.name = "kmem.limit_in_bytes",
@@ -4529,6 +4609,8 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	memcg->stat_numa = alloc_percpu(struct memcg_stat_numa);
 	if (!memcg->stat_numa)
 		goto fail;
+	mutex_init(&memcg->numa_mutex);
+	memcg->numa_preferred = NUMA_NO_NODE;
 #endif

 	for_each_node(node)
diff --git a/mm/memory.c b/mm/memory.c
index fb0c1d940d36..98d988ca717c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -70,6 +70,7 @@
 #include <linux/dax.h>
 #include <linux/oom.h>
 #include <linux/numa.h>
+#include <linux/memcontrol.h>

 #include <asm/io.h>
 #include <asm/mmu_context.h>
@@ -3675,6 +3676,9 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	target_nid = numa_migrate_prep(page, vma, vmf->address, page_nid,
 			&flags);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
+
+	target_nid = memcg_migrate_prep(target_nid, page_nid);
+
 	if (target_nid == NUMA_NO_NODE) {
 		put_page(page);
 		goto out;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index af171ccb56a2..6513504373b4 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2031,6 +2031,10 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,

 	pol = get_vma_policy(vma, addr);

+	page = alloc_page_numa_preferred(gfp, order);
+	if (page)
+		goto out;
+
 	if (pol->mode == MPOL_INTERLEAVE) {
 		unsigned nid;

-- 
2.14.4.44.g2045bb6

