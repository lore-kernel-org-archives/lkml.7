Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3851C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 22:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A497F2075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 22:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfECWbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 18:31:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48866 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfECWbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 18:31:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A7E56C05CDFC;
        Fri,  3 May 2019 22:31:47 +0000 (UTC)
Received: from ultra.random (ovpn-122-217.rdu2.redhat.com [10.10.122.217])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 474675C231;
        Fri,  3 May 2019 22:31:47 +0000 (UTC)
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Revert "mm, thp: restore node-local hugepage allocations"
Date:   Fri,  3 May 2019 18:31:46 -0400
Message-Id: <20190503223146.2312-3-aarcange@redhat.com>
In-Reply-To: <20190503223146.2312-1-aarcange@redhat.com>
References: <20190503223146.2312-1-aarcange@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 03 May 2019 22:31:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 2f0799a0ffc033bf3cc82d5032acc3ec633464c2.

commit 2f0799a0ffc033bf3cc82d5032acc3ec633464c2 was rightfully applied
to avoid the risk of a severe regression that was reported by the
kernel test robot at the end of the merge window. Now we understood
the regression was a false positive and was caused by a significant
increase in fairness during a swap trashing benchmark. So it's safe to
re-apply the fix and continue improving the code from there. The
benchmark that reported the regression is very useful, but it provides
a meaningful result only when there is no significant alteration in
fairness during the workload. The removal of __GFP_THISNODE increased
fairness.

__GFP_THISNODE cannot be used in the generic page faults path for new
memory allocations under the MPOL_DEFAULT mempolicy, or the allocation
behavior significantly deviates from what the MPOL_DEFAULT semantics
are supposed to be for THP and 4k allocations alike.

Setting THP defrag to "always" or using MADV_HUGEPAGE (with THP defrag
set to "madvise") has never meant to provide an implicit MPOL_BIND on
the "current" node the task is running on, causing swap storms and
providing a much more aggressive behavior than even zone_reclaim_node
= 3.

Any workload who could have benefited from __GFP_THISNODE has now to
enable zone_reclaim_mode=1||2||3. __GFP_THISNODE implicitly provided
the zone_reclaim_mode behavior, but it only did so if THP was enabled:
if THP was disabled, there would have been no chance to get any 4k
page from the current node if the current node was full of pagecache,
which further shows how this __GFP_THISNODE was misplaced in
MADV_HUGEPAGE. MADV_HUGEPAGE has never been intended to provide any
zone_reclaim_mode semantics, in fact the two are orthogonal,
zone_reclaim_mode = 1|2|3 must work exactly the same with
MADV_HUGEPAGE set or not.

The performance characteristic of memory depends on the hardware
details. The numbers below are obtained on Naples/EPYC architecture
and the N/A projection extends them to show what we should aim for in
the future as a good THP NUMA locality default. The benchmark used
exercises random memory seeks (note: the cost of the page faults is
not part of the measurement).

D0 THP | D0 4k | D1 THP | D1 4k | D2 THP | D2 4k | D3 THP | D3 4k | ...
0%     | +43%  | +45%   | +106% | +131%  | +224% | N/A    | N/A

D0 means distance zero (i.e. local memory), D1 means distance
one (i.e. intra socket memory), D2 means distance two (i.e. inter
socket memory), etc...

For the guest physical memory allocated by qemu and for guest mode kernel
the performance characteristic of RAM is more complex and an ideal
default could be:

D0 THP | D1 THP | D0 4k | D2 THP | D1 4k | D3 THP | D2 4k | D3 4k | ...
0%     | +58%   | +101% | N/A    | +222% | N/A    | N/A   | N/A

NOTE: the N/A are projections and haven't been measured yet, the
measurement in this case is done on a 1950x with only two NUMA nodes.
The THP case here means THP was used both in the host and in the
guest.

After applying this commit the THP NUMA locality order that we'll get
out of MADV_HUGEPAGE is this:

D0 THP | D1 THP | D2 THP | D3 THP | ... | D0 4k | D1 4k | D2 4k | D3 4k | ...

Before this commit it was:

D0 THP | D0 4k | D1 4k | D2 4k | D3 4k | ...

Even if we ignore the breakage of large workloads that can't fit in a
single node that the __GFP_THISNODE implicit "current node" mbind
caused, the THP NUMA locality order provided by __GFP_THISNODE was
still not the one we shall aim for in the long term (i.e. the first
one at the top).

After this commit is applied, we can introduce a new allocator multi
order API and to replace those two alloc_pages_vmas calls in the page
fault path, with a single multi order call:

	unsigned int order = (1 << HPAGE_PMD_ORDER) | (1 << 0);
	page = alloc_pages_multi_order(..., &order);
	if (!page)
		goto out;
	if (!(order & (1 << 0))) {
		VM_WARN_ON(order != 1 << HPAGE_PMD_ORDER);
		/* THP fault */
	} else {
		VM_WARN_ON(order != 1 << 0);
		/* 4k fallback */
	}

The page allocator logic has to be altered so that when it fails on
any zone with order 9, it has to try again with a order 0 before
falling back to the next zone in the zonelist.

After that we need to do more measurements and evaluate if adding an
opt-in feature for guest mode is worth it, to swap "DN 4k | DN+1 THP"
with "DN+1 THP | DN 4k" at every NUMA distance crossing.

Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
---
 include/linux/mempolicy.h |  2 ++
 mm/huge_memory.c          | 42 ++++++++++++++++++++++++---------------
 mm/mempolicy.c            |  2 +-
 3 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 5228c62af416..bac395f1d00a 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -139,6 +139,8 @@ struct mempolicy *mpol_shared_policy_lookup(struct shared_policy *sp,
 struct mempolicy *get_task_policy(struct task_struct *p);
 struct mempolicy *__get_vma_policy(struct vm_area_struct *vma,
 		unsigned long addr);
+struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
+						unsigned long addr);
 bool vma_policy_mof(struct vm_area_struct *vma);
 
 extern void numa_default_policy(void);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 7efe68ba052a..784fd63800a2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -644,27 +644,37 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 static inline gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma, unsigned long addr)
 {
 	const bool vma_madvised = !!(vma->vm_flags & VM_HUGEPAGE);
-	const gfp_t gfp_mask = GFP_TRANSHUGE_LIGHT | __GFP_THISNODE;
+	gfp_t this_node = 0;
 
-	/* Always do synchronous compaction */
-	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags))
-		return GFP_TRANSHUGE | __GFP_THISNODE |
-		       (vma_madvised ? 0 : __GFP_NORETRY);
+#ifdef CONFIG_NUMA
+	struct mempolicy *pol;
+	/*
+	 * __GFP_THISNODE is used only when __GFP_DIRECT_RECLAIM is not
+	 * specified, to express a general desire to stay on the current
+	 * node for optimistic allocation attempts. If the defrag mode
+	 * and/or madvise hint requires the direct reclaim then we prefer
+	 * to fallback to other node rather than node reclaim because that
+	 * can lead to excessive reclaim even though there is free memory
+	 * on other nodes. We expect that NUMA preferences are specified
+	 * by memory policies.
+	 */
+	pol = get_vma_policy(vma, addr);
+	if (pol->mode != MPOL_BIND)
+		this_node = __GFP_THISNODE;
+	mpol_cond_put(pol);
+#endif
 
-	/* Kick kcompactd and fail quickly */
+	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags))
+		return GFP_TRANSHUGE | (vma_madvised ? 0 : __GFP_NORETRY);
 	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG, &transparent_hugepage_flags))
-		return gfp_mask | __GFP_KSWAPD_RECLAIM;
-
-	/* Synchronous compaction if madvised, otherwise kick kcompactd */
+		return GFP_TRANSHUGE_LIGHT | __GFP_KSWAPD_RECLAIM | this_node;
 	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG, &transparent_hugepage_flags))
-		return gfp_mask | (vma_madvised ? __GFP_DIRECT_RECLAIM :
-						  __GFP_KSWAPD_RECLAIM);
-
-	/* Only do synchronous compaction if madvised */
+		return GFP_TRANSHUGE_LIGHT | (vma_madvised ? __GFP_DIRECT_RECLAIM :
+							     __GFP_KSWAPD_RECLAIM | this_node);
 	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG, &transparent_hugepage_flags))
-		return gfp_mask | (vma_madvised ? __GFP_DIRECT_RECLAIM : 0);
-
-	return gfp_mask;
+		return GFP_TRANSHUGE_LIGHT | (vma_madvised ? __GFP_DIRECT_RECLAIM :
+							     this_node);
+	return GFP_TRANSHUGE_LIGHT | this_node;
 }
 
 /* Caller must hold page table lock. */
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 74e44000ad61..341e3d56d0a6 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1688,7 +1688,7 @@ struct mempolicy *__get_vma_policy(struct vm_area_struct *vma,
  * freeing by another task.  It is the caller's responsibility to free the
  * extra reference for shared policies.
  */
-static struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
+struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
 						unsigned long addr)
 {
 	struct mempolicy *pol = __get_vma_policy(vma, addr);
