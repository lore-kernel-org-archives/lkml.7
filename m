Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AEFC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 04:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 426C6218E2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 04:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbfCWEpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 00:45:21 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:58092 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727183AbfCWEpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 00:45:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0TNPuxAM_1553316293;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TNPuxAM_1553316293)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 23 Mar 2019 12:45:01 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@suse.com, mgorman@techsingularity.net, riel@surriel.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, keith.busch@intel.com,
        dan.j.williams@intel.com, fengguang.wu@intel.com, fan.du@intel.com,
        ying.huang@intel.com
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] mm: mempolicy: introduce MPOL_HYBRID policy
Date:   Sat, 23 Mar 2019 12:44:27 +0800
Message-Id: <1553316275-21985-3-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1553316275-21985-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1553316275-21985-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new NUMA policy, MPOL_HYBRID.  It behaves like MPOL_BIND,
but since we need migrate pages from non-DRAM node (i.e. PMEM node) to
DRAM node on demand, MPOL_HYBRID would do page migration on numa fault,
so it would have MPOL_F_MOF set by default.

The NUMA balancing stuff will be enabled in the following patch.

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 include/uapi/linux/mempolicy.h |  1 +
 mm/mempolicy.c                 | 56 +++++++++++++++++++++++++++++++++++++-----
 2 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
index 3354774..0fdc73d 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -22,6 +22,7 @@ enum {
 	MPOL_BIND,
 	MPOL_INTERLEAVE,
 	MPOL_LOCAL,
+	MPOL_HYBRID,
 	MPOL_MAX,	/* always last member of enum */
 };
 
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index af171cc..7d0a432 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -31,6 +31,10 @@
  *                but useful to set in a VMA when you have a non default
  *                process policy.
  *
+ * hybrid         Only allocate memory on specific set of nodes. If the set of
+ *                nodes include non-DRAM nodes, NUMA balancing would promote
+ *                the page to DRAM node.
+ *
  * default        Allocate on the local node first, or when on a VMA
  *                use the process policy. This is what Linux always did
  *		  in a NUMA aware kernel and still does by, ahem, default.
@@ -191,6 +195,17 @@ static int mpol_new_bind(struct mempolicy *pol, const nodemask_t *nodes)
 	return 0;
 }
 
+static int mpol_new_hybrid(struct mempolicy *pol, const nodemask_t *nodes)
+{
+	if (nodes_empty(*nodes))
+		return -EINVAL;
+
+	/* Hybrid policy would promote pages in page fault */
+	pol->flags |= MPOL_F_MOF;
+	pol->v.nodes = *nodes;
+	return 0;
+}
+
 /*
  * mpol_set_nodemask is called after mpol_new() to set up the nodemask, if
  * any, for the new policy.  mpol_new() has already validated the nodes
@@ -401,6 +416,10 @@ void mpol_rebind_mm(struct mm_struct *mm, nodemask_t *new)
 		.create = mpol_new_bind,
 		.rebind = mpol_rebind_nodemask,
 	},
+	[MPOL_HYBRID] = {
+		.create = mpol_new_hybrid,
+		.rebind = mpol_rebind_nodemask,
+	},
 };
 
 static void migrate_page_add(struct page *page, struct list_head *pagelist,
@@ -782,6 +801,8 @@ static void get_policy_nodemask(struct mempolicy *p, nodemask_t *nodes)
 		return;
 
 	switch (p->mode) {
+	case MPOL_HYBRID:
+		/* Fall through */
 	case MPOL_BIND:
 		/* Fall through */
 	case MPOL_INTERLEAVE:
@@ -1721,8 +1742,12 @@ static int apply_policy_zone(struct mempolicy *policy, enum zone_type zone)
  */
 static nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
 {
-	/* Lower zones don't get a nodemask applied for MPOL_BIND */
-	if (unlikely(policy->mode == MPOL_BIND) &&
+	/*
+	 * Lower zones don't get a nodemask applied for MPOL_BIND
+	 * or MPOL_HYBRID.
+	 */
+	if (unlikely((policy->mode == MPOL_BIND) ||
+			(policy->mode == MPOL_HYBRID)) &&
 			apply_policy_zone(policy, gfp_zone(gfp)) &&
 			cpuset_nodemask_valid_mems_allowed(&policy->v.nodes))
 		return &policy->v.nodes;
@@ -1742,7 +1767,9 @@ static int policy_node(gfp_t gfp, struct mempolicy *policy,
 		 * because we might easily break the expectation to stay on the
 		 * requested node and not break the policy.
 		 */
-		WARN_ON_ONCE(policy->mode == MPOL_BIND && (gfp & __GFP_THISNODE));
+		WARN_ON_ONCE((policy->mode == MPOL_BIND ||
+			     policy->mode == MPOL_HYBRID) &&
+			     (gfp & __GFP_THISNODE));
 	}
 
 	return nd;
@@ -1786,6 +1813,8 @@ unsigned int mempolicy_slab_node(void)
 	case MPOL_INTERLEAVE:
 		return interleave_nodes(policy);
 
+	case MPOL_HYBRID:
+		/* Fall through */
 	case MPOL_BIND: {
 		struct zoneref *z;
 
@@ -1856,7 +1885,8 @@ static inline unsigned interleave_nid(struct mempolicy *pol,
  * @addr: address in @vma for shared policy lookup and interleave policy
  * @gfp_flags: for requested zone
  * @mpol: pointer to mempolicy pointer for reference counted mempolicy
- * @nodemask: pointer to nodemask pointer for MPOL_BIND nodemask
+ * @nodemask: pointer to nodemask pointer for MPOL_BIND or MPOL_HYBRID
+ * nodemask
  *
  * Returns a nid suitable for a huge page allocation and a pointer
  * to the struct mempolicy for conditional unref after allocation.
@@ -1871,14 +1901,16 @@ int huge_node(struct vm_area_struct *vma, unsigned long addr, gfp_t gfp_flags,
 	int nid;
 
 	*mpol = get_vma_policy(vma, addr);
-	*nodemask = NULL;	/* assume !MPOL_BIND */
+	/* assume !MPOL_BIND || !MPOL_HYBRID */
+	*nodemask = NULL;
 
 	if (unlikely((*mpol)->mode == MPOL_INTERLEAVE)) {
 		nid = interleave_nid(*mpol, vma, addr,
 					huge_page_shift(hstate_vma(vma)));
 	} else {
 		nid = policy_node(gfp_flags, *mpol, numa_node_id());
-		if ((*mpol)->mode == MPOL_BIND)
+		if ((*mpol)->mode == MPOL_BIND ||
+		    (*mpol)->mode == MPOL_HYBRID)
 			*nodemask = &(*mpol)->v.nodes;
 	}
 	return nid;
@@ -1919,6 +1951,8 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
 		init_nodemask_of_node(mask, nid);
 		break;
 
+	case MPOL_HYBRID:
+		/* Fall through */
 	case MPOL_BIND:
 		/* Fall through */
 	case MPOL_INTERLEAVE:
@@ -1966,6 +2000,7 @@ bool mempolicy_nodemask_intersects(struct task_struct *tsk,
 		 * nodes in mask.
 		 */
 		break;
+	case MPOL_HYBRID:
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
 		ret = nodes_intersects(mempolicy->v.nodes, *mask);
@@ -2170,6 +2205,8 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
 			return false;
 
 	switch (a->mode) {
+	case MPOL_HYBRID:
+		/* Fall through */
 	case MPOL_BIND:
 		/* Fall through */
 	case MPOL_INTERLEAVE:
@@ -2325,6 +2362,9 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 			polnid = pol->v.preferred_node;
 		break;
 
+	case MPOL_HYBRID:
+		/* Fall through */
+
 	case MPOL_BIND:
 
 		/*
@@ -2693,6 +2733,7 @@ void numa_default_policy(void)
 	[MPOL_BIND]       = "bind",
 	[MPOL_INTERLEAVE] = "interleave",
 	[MPOL_LOCAL]      = "local",
+	[MPOL_HYBRID]     = "hybrid",
 };
 
 
@@ -2768,6 +2809,8 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
 		if (!nodelist)
 			err = 0;
 		goto out;
+	case MPOL_HYBRID:
+		/* Fall through */
 	case MPOL_BIND:
 		/*
 		 * Insist on a nodelist
@@ -2856,6 +2899,7 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 		else
 			node_set(pol->v.preferred_node, nodes);
 		break;
+	case MPOL_HYBRID:
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
 		nodes = pol->v.nodes;
-- 
1.8.3.1

