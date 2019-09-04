Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE48CC3A5AA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 19:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94AF62339D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 19:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="frdgxIlY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730391AbfIDTyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 15:54:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33005 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbfIDTyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 15:54:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so8916513pfl.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 12:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=5m9yEJkwMGkTsleZ21Dj3LjbDk1nJJBNL55KpYfxVrA=;
        b=frdgxIlY4Nc86Dt2nE92haaUYpAauut2Kk/7VOTuR0X0NOLbmkUttvop6zDwkQ1zpz
         rWR5qOdNkmSMArIGyuxg6zNUORvF5hXOV/iwwsQ77LKvVOpfYIbSSDDtEQZ5cTTNXDXr
         NO/AsH8t19vzIK4O+xi/xAQJylAg4BYIUndEFQfwitQSdkpxL99I5fzf4iylQXlSQnIg
         YN7CvfXkoTfiK0djxw8oo29ScoFuwpMX5EzWmm7+J1llbtX+2vXlHT6cgYfCLy32AJOK
         5cB0afoAnvdT+D+FDUyF2bxwsT3p3oXy4FD/0sqhDk/lMsky7Sql+rwsMZFXoVqOM4Qv
         RpaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=5m9yEJkwMGkTsleZ21Dj3LjbDk1nJJBNL55KpYfxVrA=;
        b=HbtrqvELGmfhuE7Cp/G7ueuSWnHyzvZxVEgYE8hf68vcP2SseRJyEFBbcYy4VjBPCF
         ozMTy0+vIWwsGygXsEUHjshF4Qkwpudun9bBQ62Iiq5KHOtJboM+VPuN6WOp3+ofZquW
         So4oPme29LjbtMjqO38gtDGsIBrzuTTHPiyhqMSQ/AQ1+Y49Ut2ebstfzY3VkLBdxKRW
         U+vYjtuJLzDE/7+xr3NelIus5LDgWk0nb3An+JLRuee4+ttMuUPhCx4MUuxlYU2NNIEQ
         OPRA5ctRQM/VoZzacs6dl4fV+AJEq5SYn53M6non431gC7nW048MI9gtw5GTAy9bJgJo
         zFJA==
X-Gm-Message-State: APjAAAWeoY2nou8qPFjj64EmtqXJjgBeGTX5AxNkSnYnXAHXqq4L4gwd
        vWtEHP6x/0V8FDf/bdZLvWyN0w==
X-Google-Smtp-Source: APXvYqwrCvnGc3SA4RjOmcxVI4Fez+CswtbUXEr6d/jsncxuWzmiXpLxRs+5DBwOx/kpLU6ny3/mYQ==
X-Received: by 2002:a65:62cd:: with SMTP id m13mr36300315pgv.437.1567626861960;
        Wed, 04 Sep 2019 12:54:21 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id y194sm619808pfg.186.2019.09.04.12.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 12:54:21 -0700 (PDT)
Date:   Wed, 4 Sep 2019 12:54:20 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [patch for-5.3 2/4] Revert "Revert "Revert "mm, thp: consolidate
 THP gfp handling into alloc_hugepage_direct_gfpmask""
Message-ID: <alpine.DEB.2.21.1909041253180.94813@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 92717d429b38e4f9f934eed7e605cc42858f1839.

Since commit a8282608c88e ("Revert "mm, thp: restore node-local hugepage
allocations"") is reverted in this series, it is better to restore the
previous 5.2 behavior between the thp allocation and the page allocator
rather than to attempt any consolidation or cleanup for a policy that is
now reverted.  It's less risky during an rc cycle and subsequent patches
in this series further modify the same policy that the pre-5.3 behavior
implements.

Consolidation and cleanup can be done subsequent to a sane default page
allocation strategy, so this patch reverts a cleanup done on a strategy
that is now reverted and thus is the least risky option for 5.3.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 include/linux/gfp.h | 12 ++++++++----
 mm/huge_memory.c    | 27 +++++++++++++--------------
 mm/mempolicy.c      | 32 +++++++++++++++++++++++++++++---
 mm/shmem.c          |  2 +-
 4 files changed, 51 insertions(+), 22 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -510,18 +510,22 @@ alloc_pages(gfp_t gfp_mask, unsigned int order)
 }
 extern struct page *alloc_pages_vma(gfp_t gfp_mask, int order,
 			struct vm_area_struct *vma, unsigned long addr,
-			int node);
+			int node, bool hugepage);
+#define alloc_hugepage_vma(gfp_mask, vma, addr, order) \
+	alloc_pages_vma(gfp_mask, order, vma, addr, numa_node_id(), true)
 #else
 #define alloc_pages(gfp_mask, order) \
 		alloc_pages_node(numa_node_id(), gfp_mask, order)
-#define alloc_pages_vma(gfp_mask, order, vma, addr, node)\
+#define alloc_pages_vma(gfp_mask, order, vma, addr, node, false)\
+	alloc_pages(gfp_mask, order)
+#define alloc_hugepage_vma(gfp_mask, vma, addr, order) \
 	alloc_pages(gfp_mask, order)
 #endif
 #define alloc_page(gfp_mask) alloc_pages(gfp_mask, 0)
 #define alloc_page_vma(gfp_mask, vma, addr)			\
-	alloc_pages_vma(gfp_mask, 0, vma, addr, numa_node_id())
+	alloc_pages_vma(gfp_mask, 0, vma, addr, numa_node_id(), false)
 #define alloc_page_vma_node(gfp_mask, vma, addr, node)		\
-	alloc_pages_vma(gfp_mask, 0, vma, addr, node)
+	alloc_pages_vma(gfp_mask, 0, vma, addr, node, false)
 
 extern unsigned long __get_free_pages(gfp_t gfp_mask, unsigned int order);
 extern unsigned long get_zeroed_page(gfp_t gfp_mask);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -645,30 +645,30 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
  *	    available
  * never: never stall for any thp allocation
  */
-static inline gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma, unsigned long addr)
+static inline gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma)
 {
 	const bool vma_madvised = !!(vma->vm_flags & VM_HUGEPAGE);
-	const gfp_t gfp_mask = GFP_TRANSHUGE_LIGHT | __GFP_THISNODE;
 
 	/* Always do synchronous compaction */
 	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags))
-		return GFP_TRANSHUGE | __GFP_THISNODE |
-		       (vma_madvised ? 0 : __GFP_NORETRY);
+		return GFP_TRANSHUGE | (vma_madvised ? 0 : __GFP_NORETRY);
 
 	/* Kick kcompactd and fail quickly */
 	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG, &transparent_hugepage_flags))
-		return gfp_mask | __GFP_KSWAPD_RECLAIM;
+		return GFP_TRANSHUGE_LIGHT | __GFP_KSWAPD_RECLAIM;
 
 	/* Synchronous compaction if madvised, otherwise kick kcompactd */
 	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG, &transparent_hugepage_flags))
-		return gfp_mask | (vma_madvised ? __GFP_DIRECT_RECLAIM :
-						  __GFP_KSWAPD_RECLAIM);
+		return GFP_TRANSHUGE_LIGHT |
+			(vma_madvised ? __GFP_DIRECT_RECLAIM :
+					__GFP_KSWAPD_RECLAIM);
 
 	/* Only do synchronous compaction if madvised */
 	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG, &transparent_hugepage_flags))
-		return gfp_mask | (vma_madvised ? __GFP_DIRECT_RECLAIM : 0);
+		return GFP_TRANSHUGE_LIGHT |
+		       (vma_madvised ? __GFP_DIRECT_RECLAIM : 0);
 
-	return gfp_mask;
+	return GFP_TRANSHUGE_LIGHT;
 }
 
 /* Caller must hold page table lock. */
@@ -740,8 +740,8 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 			pte_free(vma->vm_mm, pgtable);
 		return ret;
 	}
-	gfp = alloc_hugepage_direct_gfpmask(vma, haddr);
-	page = alloc_pages_vma(gfp, HPAGE_PMD_ORDER, vma, haddr, numa_node_id());
+	gfp = alloc_hugepage_direct_gfpmask(vma);
+	page = alloc_hugepage_vma(gfp, vma, haddr, HPAGE_PMD_ORDER);
 	if (unlikely(!page)) {
 		count_vm_event(THP_FAULT_FALLBACK);
 		return VM_FAULT_FALLBACK;
@@ -1348,9 +1348,8 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
 alloc:
 	if (__transparent_hugepage_enabled(vma) &&
 	    !transparent_hugepage_debug_cow()) {
-		huge_gfp = alloc_hugepage_direct_gfpmask(vma, haddr);
-		new_page = alloc_pages_vma(huge_gfp, HPAGE_PMD_ORDER, vma,
-				haddr, numa_node_id());
+		huge_gfp = alloc_hugepage_direct_gfpmask(vma);
+		new_page = alloc_hugepage_vma(huge_gfp, vma, haddr, HPAGE_PMD_ORDER);
 	} else
 		new_page = NULL;
 
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1180,8 +1180,8 @@ static struct page *new_page(struct page *page, unsigned long start)
 	} else if (PageTransHuge(page)) {
 		struct page *thp;
 
-		thp = alloc_pages_vma(GFP_TRANSHUGE, HPAGE_PMD_ORDER, vma,
-				address, numa_node_id());
+		thp = alloc_hugepage_vma(GFP_TRANSHUGE, vma, address,
+					 HPAGE_PMD_ORDER);
 		if (!thp)
 			return NULL;
 		prep_transhuge_page(thp);
@@ -2083,6 +2083,7 @@ static struct page *alloc_page_interleave(gfp_t gfp, unsigned order,
  * 	@vma:  Pointer to VMA or NULL if not available.
  *	@addr: Virtual Address of the allocation. Must be inside the VMA.
  *	@node: Which node to prefer for allocation (modulo policy).
+ *	@hugepage: for hugepages try only the preferred node if possible
  *
  * 	This function allocates a page from the kernel page pool and applies
  *	a NUMA policy associated with the VMA or the current process.
@@ -2093,7 +2094,7 @@ static struct page *alloc_page_interleave(gfp_t gfp, unsigned order,
  */
 struct page *
 alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
-		unsigned long addr, int node)
+		unsigned long addr, int node, bool hugepage)
 {
 	struct mempolicy *pol;
 	struct page *page;
@@ -2111,6 +2112,31 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 		goto out;
 	}
 
+	if (unlikely(IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && hugepage)) {
+		int hpage_node = node;
+
+		/*
+		 * For hugepage allocation and non-interleave policy which
+		 * allows the current node (or other explicitly preferred
+		 * node) we only try to allocate from the current/preferred
+		 * node and don't fall back to other nodes, as the cost of
+		 * remote accesses would likely offset THP benefits.
+		 *
+		 * If the policy is interleave, or does not allow the current
+		 * node in its nodemask, we allocate the standard way.
+		 */
+		if (pol->mode == MPOL_PREFERRED && !(pol->flags & MPOL_F_LOCAL))
+			hpage_node = pol->v.preferred_node;
+
+		nmask = policy_nodemask(gfp, pol);
+		if (!nmask || node_isset(hpage_node, *nmask)) {
+			mpol_cond_put(pol);
+			page = __alloc_pages_node(hpage_node,
+						gfp | __GFP_THISNODE, order);
+			goto out;
+		}
+	}
+
 	nmask = policy_nodemask(gfp, pol);
 	preferred_nid = policy_node(gfp, pol, node);
 	page = __alloc_pages_nodemask(gfp, order, preferred_nid, nmask);
diff --git a/mm/shmem.c b/mm/shmem.c
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1466,7 +1466,7 @@ static struct page *shmem_alloc_hugepage(gfp_t gfp,
 
 	shmem_pseudo_vma_init(&pvma, info, hindex);
 	page = alloc_pages_vma(gfp | __GFP_COMP | __GFP_NORETRY | __GFP_NOWARN,
-			HPAGE_PMD_ORDER, &pvma, 0, numa_node_id());
+			HPAGE_PMD_ORDER, &pvma, 0, numa_node_id(), true);
 	shmem_pseudo_vma_destroy(&pvma);
 	if (page)
 		prep_transhuge_page(page);
