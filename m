Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC81C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 01:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86DE3206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 01:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388352AbfDYBnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 21:43:01 -0400
Received: from mga11.intel.com ([192.55.52.93]:25341 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388256AbfDYBmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 21:42:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 18:42:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,391,1549958400"; 
   d="scan'208";a="152134261"
Received: from zz23f_aep_wp03.sh.intel.com ([10.239.85.39])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Apr 2019 18:42:48 -0700
From:   Fan Du <fan.du@intel.com>
To:     akpm@linux-foundation.org, mhocko@suse.com, fengguang.wu@intel.com,
        dan.j.williams@intel.com, dave.hansen@intel.com,
        xishi.qiuxishi@alibaba-inc.com, ying.huang@intel.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Fan Du <fan.du@intel.com>
Subject: [RFC PATCH 5/5] mm, page_alloc: Introduce ZONELIST_FALLBACK_SAME_TYPE fallback list
Date:   Thu, 25 Apr 2019 09:21:35 +0800
Message-Id: <1556155295-77723-6-git-send-email-fan.du@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1556155295-77723-1-git-send-email-fan.du@intel.com>
References: <1556155295-77723-1-git-send-email-fan.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On system with heterogeneous memory, reasonable fall back lists woul be:
a. No fall back, stick to current running node.
b. Fall back to other nodes of the same type or different type
   e.g. DRAM node 0 -> DRAM node 1 -> PMEM node 2 -> PMEM node 3
c. Fall back to other nodes of the same type only.
   e.g. DRAM node 0 -> DRAM node 1

a. is already in place, previous patch implement b. providing way to
satisfy memory request as best effort by default. And this patch of
writing build c. to fallback to the same node type when user specify
GFP_SAME_NODE_TYPE only.

Signed-off-by: Fan Du <fan.du@intel.com>
---
 include/linux/gfp.h    |  7 +++++++
 include/linux/mmzone.h |  1 +
 mm/page_alloc.c        | 15 +++++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index fdab7de..ca5fdfc 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -44,6 +44,8 @@
 #else
 #define ___GFP_NOLOCKDEP	0
 #endif
+#define ___GFP_SAME_NODE_TYPE	0x1000000u
+
 /* If the above are modified, __GFP_BITS_SHIFT may need updating */
 
 /*
@@ -215,6 +217,7 @@
 
 /* Disable lockdep for GFP context tracking */
 #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
+#define __GFP_SAME_NODE_TYPE ((__force gfp_t)___GFP_SAME_NODE_TYPE)
 
 /* Room for N __GFP_FOO bits */
 #define __GFP_BITS_SHIFT (23 + IS_ENABLED(CONFIG_LOCKDEP))
@@ -301,6 +304,8 @@
 			 __GFP_NOMEMALLOC | __GFP_NOWARN) & ~__GFP_RECLAIM)
 #define GFP_TRANSHUGE	(GFP_TRANSHUGE_LIGHT | __GFP_DIRECT_RECLAIM)
 
+#define GFP_SAME_NODE_TYPE (__GFP_SAME_NODE_TYPE)
+
 /* Convert GFP flags to their corresponding migrate type */
 #define GFP_MOVABLE_MASK (__GFP_RECLAIMABLE|__GFP_MOVABLE)
 #define GFP_MOVABLE_SHIFT 3
@@ -438,6 +443,8 @@ static inline int gfp_zonelist(gfp_t flags)
 #ifdef CONFIG_NUMA
 	if (unlikely(flags & __GFP_THISNODE))
 		return ZONELIST_NOFALLBACK;
+	if (unlikely(flags & __GFP_SAME_NODE_TYPE))
+		return ZONELIST_FALLBACK_SAME_TYPE;
 #endif
 	return ZONELIST_FALLBACK;
 }
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 8c37e1c..2f8603e 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -583,6 +583,7 @@ static inline bool zone_intersects(struct zone *zone,
 
 enum {
 	ZONELIST_FALLBACK,	/* zonelist with fallback */
+	ZONELIST_FALLBACK_SAME_TYPE,	/* zonelist with fallback to the same type node */
 #ifdef CONFIG_NUMA
 	/*
 	 * The NUMA zonelists are doubled because we need zonelists that
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a408a91..de797921 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5448,6 +5448,21 @@ static void build_zonelists_in_node_order(pg_data_t *pgdat, int *node_order,
 	}
 	zonerefs->zone = NULL;
 	zonerefs->zone_idx = 0;
+
+	zonerefs = pgdat->node_zonelists[ZONELIST_FALLBACK_SAME_TYPE]._zonerefs;
+
+	for (i = 0; i < nr_nodes; i++) {
+		int nr_zones;
+
+		pg_data_t *node = NODE_DATA(node_order[i]);
+
+		if (!is_node_same_type(node->node_id, pgdat->node_id))
+			continue;
+		nr_zones = build_zonerefs_node(node, zonerefs);
+		zonerefs += nr_zones;
+	}
+	zonerefs->zone = NULL;
+	zonerefs->zone_idx = 0;
 }
 
 /*
-- 
1.8.3.1

