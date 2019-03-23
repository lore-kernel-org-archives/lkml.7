Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C907C10F05
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 04:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7E27218E2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 04:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfCWEpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 00:45:14 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:59318 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725818AbfCWEpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 00:45:09 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0TNPuxAM_1553316293;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TNPuxAM_1553316293)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 23 Mar 2019 12:45:02 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@suse.com, mgorman@techsingularity.net, riel@surriel.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, keith.busch@intel.com,
        dan.j.williams@intel.com, fengguang.wu@intel.com, fan.du@intel.com,
        ying.huang@intel.com
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] mm: mempolicy: promote page to DRAM for MPOL_HYBRID
Date:   Sat, 23 Mar 2019 12:44:28 +0800
Message-Id: <1553316275-21985-4-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1553316275-21985-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1553316275-21985-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With MPOL_HYBRID the memory allocation may end up on non-DRAM node, this
may be not optimal for performance.  Promote pages to DRAM with NUMA
balancing for MPOL_HYBRID.

If DRAM nodes are specified, migrate to the specified nodes.  If no DRAM
node is specified, migrate to the local DRAM node.

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/mempolicy.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 7d0a432..87bc691 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2339,6 +2339,7 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 	struct zoneref *z;
 	int curnid = page_to_nid(page);
 	unsigned long pgoff;
+	nodemask_t nmask;
 	int thiscpu = raw_smp_processor_id();
 	int thisnid = cpu_to_node(thiscpu);
 	int polnid = NUMA_NO_NODE;
@@ -2363,7 +2364,24 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 		break;
 
 	case MPOL_HYBRID:
-		/* Fall through */
+		if (node_isset(curnid, pol->v.nodes) &&
+		    node_isset(curnid, def_alloc_nodemask))
+			/* The page is already on DRAM node */
+			goto out;
+
+		/*
+		 * Promote to the DRAM node specified by the policy, or
+		 * the local DRAM node if no DRAM node is specified.
+		 */
+		nodes_and(nmask, pol->v.nodes, def_alloc_nodemask);
+
+		z = first_zones_zonelist(
+			node_zonelist(numa_node_id(), GFP_HIGHUSER),
+			gfp_zone(GFP_HIGHUSER),
+			nodes_empty(nmask) ? &def_alloc_nodemask : &nmask);
+		polnid = z->zone->node;
+
+		break;
 
 	case MPOL_BIND:
 
-- 
1.8.3.1

