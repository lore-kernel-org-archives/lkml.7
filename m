Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE672C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B842133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfDKD5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 23:57:34 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:50213 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726632AbfDKD5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 23:57:31 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0TP0I5rB_1554955031;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TP0I5rB_1554955031)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 11 Apr 2019 11:57:22 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@suse.com, mgorman@techsingularity.net, riel@surriel.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, keith.busch@intel.com,
        dan.j.williams@intel.com, fengguang.wu@intel.com, fan.du@intel.com,
        ying.huang@intel.com, ziy@nvidia.com
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH 3/9] mm: numa: promote pages to DRAM when it gets accessed twice
Date:   Thu, 11 Apr 2019 11:56:53 +0800
Message-Id: <1554955019-29472-4-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1554955019-29472-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1554955019-29472-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NUMA balancing would promote the pages to DRAM once it is accessed, but
it might be just one off access.  To reduce migration thrashing and
memory bandwidth pressure, just promote the page which gets accessed
twice by extending page_check_references() to support second reference
algorithm for anonymous page.

The page_check_reference() would walk all mapped pte or pmd to check if
the page is referenced or not, but such walk sounds unnecessary to NUMA
balancing since NUMA balancing would have pte or pmd referenced bit set
all the time, so anonymous page would have at least one referenced pte
or pmd.  And, distinguish with page reclaim path via scan_control,
scan_control would be NULL in NUMA balancing path.

This approach is not definitely the optimal one to distinguish the
hot or cold pages accurately.  It may need much more sophisticated
algorithm to distinguish hot or cold pages accurately.

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/huge_memory.c |  11 ++++++
 mm/internal.h    |  80 ++++++++++++++++++++++++++++++++++++++
 mm/memory.c      |  21 ++++++++++
 mm/vmscan.c      | 116 ++++++++++++++++---------------------------------------
 4 files changed, 146 insertions(+), 82 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 404acdc..0b18ac45 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1590,6 +1590,17 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t pmd)
 	}
 
 	/*
+	 * Promote the page when it gets NUMA fault twice.
+	 * It is safe to set page flag since the page is locked now.
+	 */
+	if (!node_state(page_nid, N_CPU_MEM) &&
+	    page_check_references(page, NULL) != PAGEREF_PROMOTE) {
+		put_page(page);
+		page_nid = NUMA_NO_NODE;
+		goto clear_pmdnuma;
+	}
+
+	/*
 	 * Migrate the THP to the requested node, returns with page unlocked
 	 * and access rights restored.
 	 */
diff --git a/mm/internal.h b/mm/internal.h
index a514808..bee4d6c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -89,8 +89,88 @@ static inline void set_page_refcounted(struct page *page)
 /*
  * in mm/vmscan.c:
  */
+struct scan_control {
+	/* How many pages shrink_list() should reclaim */
+	unsigned long nr_to_reclaim;
+
+	/*
+	 * Nodemask of nodes allowed by the caller. If NULL, all nodes
+	 * are scanned.
+	 */
+	nodemask_t	*nodemask;
+
+	/*
+	 * The memory cgroup that hit its limit and as a result is the
+	 * primary target of this reclaim invocation.
+	 */
+	struct mem_cgroup *target_mem_cgroup;
+
+	/* Writepage batching in laptop mode; RECLAIM_WRITE */
+	unsigned int may_writepage:1;
+
+	/* Can mapped pages be reclaimed? */
+	unsigned int may_unmap:1;
+
+	/* Can pages be swapped as part of reclaim? */
+	unsigned int may_swap:1;
+
+	/* e.g. boosted watermark reclaim leaves slabs alone */
+	unsigned int may_shrinkslab:1;
+
+	/*
+	 * Cgroups are not reclaimed below their configured memory.low,
+	 * unless we threaten to OOM. If any cgroups are skipped due to
+	 * memory.low and nothing was reclaimed, go back for memory.low.
+	 */
+	unsigned int memcg_low_reclaim:1;
+	unsigned int memcg_low_skipped:1;
+
+	unsigned int hibernation_mode:1;
+
+	/* One of the zones is ready for compaction */
+	unsigned int compaction_ready:1;
+
+	/* Allocation order */
+	s8 order;
+
+	/* Scan (total_size >> priority) pages at once */
+	s8 priority;
+
+	/* The highest zone to isolate pages for reclaim from */
+	s8 reclaim_idx;
+
+	/* This context's GFP mask */
+	gfp_t gfp_mask;
+
+	/* Incremented by the number of inactive pages that were scanned */
+	unsigned long nr_scanned;
+
+	/* Number of pages freed so far during a call to shrink_zones() */
+	unsigned long nr_reclaimed;
+
+	struct {
+		unsigned int dirty;
+		unsigned int unqueued_dirty;
+		unsigned int congested;
+		unsigned int writeback;
+		unsigned int immediate;
+		unsigned int file_taken;
+		unsigned int taken;
+	} nr;
+};
+
+enum page_references {
+	PAGEREF_RECLAIM,
+	PAGEREF_RECLAIM_CLEAN,
+	PAGEREF_KEEP,
+	PAGEREF_ACTIVATE,
+	PAGEREF_PROMOTE = PAGEREF_ACTIVATE,
+};
+
 extern int isolate_lru_page(struct page *page);
 extern void putback_lru_page(struct page *page);
+enum page_references page_check_references(struct page *page,
+					   struct scan_control *sc);
 
 /*
  * in mm/rmap.c:
diff --git a/mm/memory.c b/mm/memory.c
index 47fe250..01c1ead 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3680,6 +3680,27 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 		goto out;
 	}
 
+	/*
+	 * Promote the page when it gets NUMA fault twice.
+	 * Need lock the page before check its references.
+	 */
+	if (!node_state(page_nid, N_CPU_MEM)) {
+		if (!trylock_page(page)) {
+			put_page(page);
+			target_nid = NUMA_NO_NODE;
+			goto out;
+		}
+
+		if (page_check_references(page, NULL) != PAGEREF_PROMOTE) {
+			unlock_page(page);
+			put_page(page);
+			target_nid = NUMA_NO_NODE;
+			goto out;
+		}
+
+		unlock_page(page);
+	}
+
 	/* Migrate to the requested node */
 	migrated = migrate_misplaced_page(page, vma, target_nid);
 	if (migrated) {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index a5ad0b3..0504845 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -63,76 +63,6 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/vmscan.h>
 
-struct scan_control {
-	/* How many pages shrink_list() should reclaim */
-	unsigned long nr_to_reclaim;
-
-	/*
-	 * Nodemask of nodes allowed by the caller. If NULL, all nodes
-	 * are scanned.
-	 */
-	nodemask_t	*nodemask;
-
-	/*
-	 * The memory cgroup that hit its limit and as a result is the
-	 * primary target of this reclaim invocation.
-	 */
-	struct mem_cgroup *target_mem_cgroup;
-
-	/* Writepage batching in laptop mode; RECLAIM_WRITE */
-	unsigned int may_writepage:1;
-
-	/* Can mapped pages be reclaimed? */
-	unsigned int may_unmap:1;
-
-	/* Can pages be swapped as part of reclaim? */
-	unsigned int may_swap:1;
-
-	/* e.g. boosted watermark reclaim leaves slabs alone */
-	unsigned int may_shrinkslab:1;
-
-	/*
-	 * Cgroups are not reclaimed below their configured memory.low,
-	 * unless we threaten to OOM. If any cgroups are skipped due to
-	 * memory.low and nothing was reclaimed, go back for memory.low.
-	 */
-	unsigned int memcg_low_reclaim:1;
-	unsigned int memcg_low_skipped:1;
-
-	unsigned int hibernation_mode:1;
-
-	/* One of the zones is ready for compaction */
-	unsigned int compaction_ready:1;
-
-	/* Allocation order */
-	s8 order;
-
-	/* Scan (total_size >> priority) pages at once */
-	s8 priority;
-
-	/* The highest zone to isolate pages for reclaim from */
-	s8 reclaim_idx;
-
-	/* This context's GFP mask */
-	gfp_t gfp_mask;
-
-	/* Incremented by the number of inactive pages that were scanned */
-	unsigned long nr_scanned;
-
-	/* Number of pages freed so far during a call to shrink_zones() */
-	unsigned long nr_reclaimed;
-
-	struct {
-		unsigned int dirty;
-		unsigned int unqueued_dirty;
-		unsigned int congested;
-		unsigned int writeback;
-		unsigned int immediate;
-		unsigned int file_taken;
-		unsigned int taken;
-	} nr;
-};
-
 #ifdef ARCH_HAS_PREFETCH
 #define prefetch_prev_lru_page(_page, _base, _field)			\
 	do {								\
@@ -1002,21 +932,32 @@ void putback_lru_page(struct page *page)
 	put_page(page);		/* drop ref from isolate */
 }
 
-enum page_references {
-	PAGEREF_RECLAIM,
-	PAGEREF_RECLAIM_CLEAN,
-	PAGEREF_KEEP,
-	PAGEREF_ACTIVATE,
-};
-
-static enum page_references page_check_references(struct page *page,
-						  struct scan_control *sc)
+/*
+ * Called by NUMA balancing to implement access twice check for
+ * promoting pages from cpuless nodes.
+ *
+ * The sc would be NULL in NUMA balancing path.
+ */
+enum page_references page_check_references(struct page *page,
+					   struct scan_control *sc)
 {
 	int referenced_ptes, referenced_page;
 	unsigned long vm_flags;
+	struct mem_cgroup *memcg = sc ? sc->target_mem_cgroup : NULL;
+
+	if (sc)
+		referenced_ptes = page_referenced(page, 1, memcg, &vm_flags);
+	else
+		/*
+		 * The page should always has at least one referenced pte
+		 * in NUMA balancing path since NUMA balancing set referenced
+		 * bit by default in PAGE_NONE.
+		 * So, it sounds unnecessary to walk rmap to get the number of
+		 * referenced ptes.  This also help avoid potential ptl
+		 * deadlock for huge pmd.
+		 */
+		referenced_ptes = 1;
 
-	referenced_ptes = page_referenced(page, 1, sc->target_mem_cgroup,
-					  &vm_flags);
 	referenced_page = TestClearPageReferenced(page);
 
 	/*
@@ -1027,8 +968,19 @@ static enum page_references page_check_references(struct page *page,
 		return PAGEREF_RECLAIM;
 
 	if (referenced_ptes) {
-		if (PageSwapBacked(page))
+		if (PageSwapBacked(page)) {
+			if (!sc) {
+				if (referenced_page)
+					return PAGEREF_ACTIVATE;
+
+				SetPageReferenced(page);
+
+				return PAGEREF_KEEP;
+			}
+
 			return PAGEREF_ACTIVATE;
+		}
+
 		/*
 		 * All mapped pages start out with page table
 		 * references from the instantiating fault, so we need
-- 
1.8.3.1

