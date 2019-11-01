Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5704C47E49
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8454421855
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbfKAH6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 03:58:44 -0400
Received: from mga17.intel.com ([192.55.52.151]:16169 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730250AbfKAH6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 03:58:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2019 00:58:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,254,1569308400"; 
   d="scan'208";a="225962510"
Received: from yhuang-dev.sh.intel.com ([10.239.159.29])
  by fmsmga004.fm.intel.com with ESMTP; 01 Nov 2019 00:58:39 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>
Subject: [RFC 08/10] autonuma, memory tiering: Select hotter pages to promote to fast memory node
Date:   Fri,  1 Nov 2019 15:57:25 +0800
Message-Id: <20191101075727.26683-9-ying.huang@intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191101075727.26683-1-ying.huang@intel.com>
References: <20191101075727.26683-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Ying <ying.huang@intel.com>

In memory tiering system, to maximize the overall system performance,
the hot pages should be put in the fast memory node while the cold
pages should be put in the slow memory node.  In original memory
tiering autonuma implementation, we will try to promote almost all
recently accessed pages, and use the LRU algorithm in page reclaiming
to keep the hot pages in the fast memory node and demote the cold
pages to the slow memory node.  The problem of this solution is that
the cold pages with a low access frequency may be promoted then
demoted too.  So that the memory bandwidth is wasted.  And because
migration is rate-limited, the hot pages need to compete with the cold
pages for the limited migration bandwidth.

If we could select the hotter pages to promote to the fast memory node
in the first place, then the wasted migration bandwidth would be
reduced and the hot pages would be promoted more quickly.

The patch "autonuma, memory tiering: Only promote page if accessed
twice" in the series will prevent the really cold pages that are not
accessed in the last scan period from being promoted.  But the scan
period could be as long as tens seconds, so it doesn't work well
enough on selecting the hotter pages.

To identify the hotter pages, in this patch we implemented a method
based on autonuma page table scanning and hint page fault as follow,

- When a range of the page table is scanned in autonuma, the timestamp
  and the address range is recorded in a ring buffer in struct
  mm_struct.  So we have information of recent N scans.

- When the autonuma hint page fault occurs, the fault address is
  searched in the ring buffer to get its scanning timestamp.  The hint
  page fault latency is defined as

    hint page fault timestamp - scan timestamp

  If the access frequency of the hotter pages is higher, the
  probability for their hint page fault latency to be shorter is
  higher too.  So the hint page fault latency is a good estimation of
  the page heat.

The remaining problem is how to determine the hot threshold.  It's not
easy to be done automatically.  So we provide a sysctl knob:
kernel.numa_balancing_hot_threshold_ms.  All pages with hint page
fault latency < the threshold will be considered hot.  The system
administrator can determine the hot threshold via various information,
such as PMEM bandwidth limit, the average number of the pages pass the
hot threshold, etc.  The default hot threshold is 1 second, which
works well in our performance test.

The patch improves the score of pmbench memory accessing benchmark
with 80:20 read/write ratio and normal access address distribution by
9.2% with 50.3% fewer NUMA page migrations on a 2 socket Intel server
with Optance DC Persistent Memory.  That is, the cost of autonuma page
migration reduces considerably.

The downside of the patch is that the response time to the workload
hot spot changing may be much longer.  For example,

- A previous cold memory area becomes hot

- The hint page fault will be triggered.  But the hint page fault
  latency may not be shorter than the hot threshold.  So the pages may
  not be promoted.

- When the memory area is scanned again, maybe after a scan period,
  the hint page fault latency measured will be shorter than the hot
  threshold and the pages will be promoted.

To mitigate this,

- If there are enough free space in the fast memory node (> high
  watermark + 2 * promotion rate limit), the hot threshold will not be
  used, all pages will be promoted upon the hint page fault for fast
  response.

- If fast response is more important for system performance, the
  administrator can set a higher hot threshold.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Fengguang Wu <fengguang.wu@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/mempolicy.h            |  5 +-
 include/linux/mm_types.h             |  5 ++
 include/linux/sched/numa_balancing.h |  8 ++-
 include/linux/sched/sysctl.h         |  1 +
 kernel/sched/fair.c                  | 83 +++++++++++++++++++++++++---
 kernel/sysctl.c                      |  7 +++
 mm/huge_memory.c                     |  6 +-
 mm/memory.c                          |  7 +--
 mm/mempolicy.c                       |  7 ++-
 9 files changed, 109 insertions(+), 20 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 5228c62af416..674aaa7614ed 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -202,7 +202,8 @@ static inline bool vma_migratable(struct vm_area_struct *vma)
 	return true;
 }
 
-extern int mpol_misplaced(struct page *, struct vm_area_struct *, unsigned long);
+extern int mpol_misplaced(struct page *, struct vm_area_struct *, unsigned long,
+			  int flags);
 extern void mpol_put_task_policy(struct task_struct *);
 
 #else
@@ -300,7 +301,7 @@ static inline int mpol_parse_str(char *str, struct mempolicy **mpol)
 #endif
 
 static inline int mpol_misplaced(struct page *page, struct vm_area_struct *vma,
-				 unsigned long address)
+				 unsigned long address, int flags)
 {
 	return -1; /* no node preference */
 }
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 8ec38b11b361..59e2151734ab 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -484,6 +484,11 @@ struct mm_struct {
 
 		/* numa_scan_seq prevents two threads setting pte_numa */
 		int numa_scan_seq;
+
+#define NUMA_SCAN_NR_HIST	16
+		int numa_scan_idx;
+		unsigned long numa_scan_jiffies[NUMA_SCAN_NR_HIST];
+		unsigned long numa_scan_starts[NUMA_SCAN_NR_HIST];
 #endif
 		/*
 		 * An operation with batched TLB flushing is going on. Anything
diff --git a/include/linux/sched/numa_balancing.h b/include/linux/sched/numa_balancing.h
index e7dd04a84ba8..e1c2728d5bb2 100644
--- a/include/linux/sched/numa_balancing.h
+++ b/include/linux/sched/numa_balancing.h
@@ -14,6 +14,7 @@
 #define TNF_SHARED	0x04
 #define TNF_FAULT_LOCAL	0x08
 #define TNF_MIGRATE_FAIL 0x10
+#define TNF_YOUNG	0x20
 
 #ifdef CONFIG_NUMA_BALANCING
 extern void task_numa_fault(int last_node, int node, int pages, int flags);
@@ -21,7 +22,8 @@ extern pid_t task_numa_group_id(struct task_struct *p);
 extern void set_numabalancing_state(bool enabled);
 extern void task_numa_free(struct task_struct *p);
 extern bool should_numa_migrate_memory(struct task_struct *p, struct page *page,
-					int src_nid, int dst_cpu);
+				       int src_nid, int dst_cpu,
+				       unsigned long addr, int flags);
 #else
 static inline void task_numa_fault(int last_node, int node, int pages,
 				   int flags)
@@ -38,7 +40,9 @@ static inline void task_numa_free(struct task_struct *p)
 {
 }
 static inline bool should_numa_migrate_memory(struct task_struct *p,
-				struct page *page, int src_nid, int dst_cpu)
+					      struct page *page, int src_nid,
+					      int dst_cpu, unsigned long addr,
+					      int flags)
 {
 	return true;
 }
diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index e3616889a91c..5fc444024ec6 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -43,6 +43,7 @@ extern unsigned int sysctl_numa_balancing_scan_period_min;
 extern unsigned int sysctl_numa_balancing_scan_period_max;
 extern unsigned int sysctl_numa_balancing_scan_size;
 extern unsigned int sysctl_numa_balancing_rate_limit;
+extern unsigned int sysctl_numa_balancing_hot_threshold;
 
 #ifdef CONFIG_SCHED_DEBUG
 extern __read_mostly unsigned int sysctl_sched_migration_cost;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 489e2e21bb5d..d6cf5832556e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1053,6 +1053,9 @@ unsigned int sysctl_numa_balancing_scan_delay = 1000;
  */
 unsigned int sysctl_numa_balancing_rate_limit;
 
+/* The page with hint page fault latency < threshold in ms is considered hot */
+unsigned int sysctl_numa_balancing_hot_threshold = 1000;
+
 struct numa_group {
 	refcount_t refcount;
 
@@ -1158,7 +1161,7 @@ static unsigned int task_scan_max(struct task_struct *p)
 
 void init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 {
-	int mm_users = 0;
+	int mm_users = 0, i;
 	struct mm_struct *mm = p->mm;
 
 	if (mm) {
@@ -1166,6 +1169,11 @@ void init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 		if (mm_users == 1) {
 			mm->numa_next_scan = jiffies + msecs_to_jiffies(sysctl_numa_balancing_scan_delay);
 			mm->numa_scan_seq = 0;
+			mm->numa_scan_idx = 0;
+			for (i = 0; i < NUMA_SCAN_NR_HIST; i++) {
+				mm->numa_scan_jiffies[i] = 0;
+				mm->numa_scan_starts[i] = 0;
+			}
 		}
 	}
 	p->node_stamp			= 0;
@@ -1423,6 +1431,43 @@ static bool pgdat_free_space_enough(struct pglist_data *pgdat)
 	return false;
 }
 
+static long numa_hint_fault_latency(struct task_struct *p, unsigned long addr)
+{
+	struct mm_struct *mm = p->mm;
+	unsigned long now = jiffies;
+	unsigned long start, end;
+	int i, j;
+	long latency = 0;
+
+	i = READ_ONCE(mm->numa_scan_idx);
+	i = i ? i - 1 : NUMA_SCAN_NR_HIST - 1;
+	/*
+	 * Paired with smp_wmb() in task_numa_work() to check
+	 * scan range buffer after get current index
+	 */
+	smp_rmb();
+	end = READ_ONCE(mm->numa_scan_offset);
+	start = READ_ONCE(mm->numa_scan_starts[i]);
+	if (start == end)
+		end = start + MAX_SCAN_WINDOW * (1UL << 22);
+	for (j = 0; j < NUMA_SCAN_NR_HIST; j++) {
+		latency = now - READ_ONCE(mm->numa_scan_jiffies[i]);
+		start = READ_ONCE(mm->numa_scan_starts[i]);
+		/* Scan pass the end of address space */
+		if (end < start)
+			end = TASK_SIZE;
+		if (addr >= start && addr < end)
+			return latency;
+		end = start;
+		i = i ? i - 1 : NUMA_SCAN_NR_HIST - 1;
+	}
+	/*
+	 * The tracking window isn't large enough, approximate to the
+	 * max latency in the tracking window.
+	 */
+	return latency;
+}
+
 static bool numa_migration_check_rate_limit(struct pglist_data *pgdat,
 					    unsigned long rate_limit, int nr)
 {
@@ -1442,7 +1487,8 @@ static bool numa_migration_check_rate_limit(struct pglist_data *pgdat,
 }
 
 bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
-				int src_nid, int dst_cpu)
+				int src_nid, int dst_cpu, unsigned long addr,
+				int flags)
 {
 	struct numa_group *ng = p->numa_group;
 	int dst_nid = cpu_to_node(dst_cpu);
@@ -1455,12 +1501,22 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 	if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
 	    next_promotion_node(src_nid) != -1) {
 		struct pglist_data *pgdat;
-		unsigned long rate_limit;
+		unsigned long rate_limit, latency, threshold;
 
 		pgdat = NODE_DATA(dst_nid);
 		if (pgdat_free_space_enough(pgdat))
 			return true;
 
+		/* The page hasn't been accessed in the last scan period */
+		if (!(flags & TNF_YOUNG))
+			return false;
+
+		threshold = msecs_to_jiffies(
+			sysctl_numa_balancing_hot_threshold);
+		latency = numa_hint_fault_latency(p, addr);
+		if (latency > threshold)
+			return false;
+
 		rate_limit = sysctl_numa_balancing_rate_limit <<
 			(20 - PAGE_SHIFT);
 		return numa_migration_check_rate_limit(pgdat, rate_limit,
@@ -2508,7 +2564,7 @@ static void reset_ptenuma_scan(struct task_struct *p)
 	 * expensive, to avoid any form of compiler optimizations:
 	 */
 	WRITE_ONCE(p->mm->numa_scan_seq, READ_ONCE(p->mm->numa_scan_seq) + 1);
-	p->mm->numa_scan_offset = 0;
+	WRITE_ONCE(p->mm->numa_scan_offset, 0);
 }
 
 /*
@@ -2525,6 +2581,7 @@ void task_numa_work(struct callback_head *work)
 	unsigned long start, end;
 	unsigned long nr_pte_updates = 0;
 	long pages, virtpages;
+	int idx;
 
 	SCHED_WARN_ON(p != container_of(work, struct task_struct, numa_work));
 
@@ -2583,6 +2640,19 @@ void task_numa_work(struct callback_head *work)
 		start = 0;
 		vma = mm->mmap;
 	}
+	idx = mm->numa_scan_idx;
+	WRITE_ONCE(mm->numa_scan_starts[idx], start);
+	WRITE_ONCE(mm->numa_scan_jiffies[idx], jiffies);
+	/*
+	 * Paired with smp_rmb() in should_numa_migrate_memory() to
+	 * update scan range buffer index after update the buffer
+	 * contents.
+	 */
+	smp_wmb();
+	if (idx + 1 >= NUMA_SCAN_NR_HIST)
+		WRITE_ONCE(mm->numa_scan_idx, 0);
+	else
+		WRITE_ONCE(mm->numa_scan_idx, idx + 1);
 	for (; vma; vma = vma->vm_next) {
 		if (!vma_migratable(vma) || !vma_policy_mof(vma) ||
 			is_vm_hugetlb_page(vma) || (vma->vm_flags & VM_MIXEDMAP)) {
@@ -2610,6 +2680,7 @@ void task_numa_work(struct callback_head *work)
 			start = max(start, vma->vm_start);
 			end = ALIGN(start + (pages << PAGE_SHIFT), HPAGE_SIZE);
 			end = min(end, vma->vm_end);
+			WRITE_ONCE(mm->numa_scan_offset, end);
 			nr_pte_updates = change_prot_numa(vma, start, end);
 
 			/*
@@ -2639,9 +2710,7 @@ void task_numa_work(struct callback_head *work)
 	 * would find the !migratable VMA on the next scan but not reset the
 	 * scanner to the start so check it now.
 	 */
-	if (vma)
-		mm->numa_scan_offset = start;
-	else
+	if (!vma)
 		reset_ptenuma_scan(p);
 	up_read(&mm->mmap_sem);
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index c455ff404436..b7c2e15d322d 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -429,6 +429,13 @@ static struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= &zero,
 	},
+	{
+		.procname	= "numa_balancing_hot_threshold_ms",
+		.data		= &sysctl_numa_balancing_hot_threshold,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
 	{
 		.procname	= "numa_balancing",
 		.data		= &sysctl_numa_balancing_mode,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 7634fb22931b..9177cc2febd4 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1529,8 +1529,8 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t pmd)
 		goto out_unlock;
 
 	/* Only migrate if accessed twice */
-	if (!pmd_young(*vmf->pmd))
-		goto out_unlock;
+	if (pmd_young(*vmf->pmd))
+		flags |= TNF_YOUNG;
 
 	/*
 	 * If there are potential migrations, wait for completion and retry
@@ -1565,7 +1565,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t pmd)
 	 * page_table_lock if at all possible
 	 */
 	page_locked = trylock_page(page);
-	target_nid = mpol_misplaced(page, vma, haddr);
+	target_nid = mpol_misplaced(page, vma, haddr, flags);
 	if (target_nid == NUMA_NO_NODE) {
 		/* If the page was locked, there are no parallel migrations */
 		if (page_locked)
diff --git a/mm/memory.c b/mm/memory.c
index e5da50eca36f..80902ff7f5de 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3689,7 +3689,7 @@ static int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
 		*flags |= TNF_FAULT_LOCAL;
 	}
 
-	return mpol_misplaced(page, vma, addr);
+	return mpol_misplaced(page, vma, addr, *flags);
 }
 
 static vm_fault_t do_numa_page(struct vm_fault *vmf)
@@ -3726,9 +3726,8 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	ptep_modify_prot_commit(vma, vmf->address, vmf->pte, old_pte, pte);
 	update_mmu_cache(vma, vmf->address, vmf->pte);
 
-	/* Only migrate if accessed twice */
-	if (!pte_young(old_pte))
-		goto unmap_out;
+	if (pte_young(old_pte))
+		flags |= TNF_YOUNG;
 
 	page = vm_normal_page(vma, vmf->address, pte);
 	if (!page)
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 5a13bc52172f..28f803fabf5d 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2315,6 +2315,7 @@ static void sp_free(struct sp_node *n)
  * @page: page to be checked
  * @vma: vm area where page mapped
  * @addr: virtual address where page mapped
+ * @flags: numa balancing flags
  *
  * Lookup current policy node id for vma,addr and "compare to" page's
  * node id.
@@ -2326,7 +2327,8 @@ static void sp_free(struct sp_node *n)
  * Policy determination "mimics" alloc_page_vma().
  * Called from fault path where we know the vma and faulting address.
  */
-int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long addr)
+int mpol_misplaced(struct page *page, struct vm_area_struct *vma,
+		   unsigned long addr, int flags)
 {
 	struct mempolicy *pol;
 	struct zoneref *z;
@@ -2380,7 +2382,8 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 	if (pol->flags & MPOL_F_MORON) {
 		polnid = thisnid;
 
-		if (!should_numa_migrate_memory(current, page, curnid, thiscpu))
+		if (!should_numa_migrate_memory(current, page, curnid,
+						thiscpu, addr, flags))
 			goto out;
 	}
 
-- 
2.23.0

