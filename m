Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E84C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BECE2070E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfKUPVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 10:21:06 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:56447 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfKUPVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:21:06 -0500
X-Originating-IP: 153.3.140.100
Received: from localhost.localdomain.localdomain (unknown [153.3.140.100])
        (Authenticated sender: fly@kernel.page)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 164201C0003;
        Thu, 21 Nov 2019 15:20:57 +0000 (UTC)
From:   Pengfei Li <fly@kernel.page>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, mhocko@kernel.org, vbabka@suse.cz,
        cl@linux.com, iamjoonsoo.kim@lge.com, guro@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Pengfei Li <fly@kernel.page>
Subject: [RFC v1 09/19] mm, vmscan: use for_each_node in shrink_zones()
Date:   Thu, 21 Nov 2019 23:18:01 +0800
Message-Id: <20191121151811.49742-10-fly@kernel.page>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191121151811.49742-1-fly@kernel.page>
References: <20191121151811.49742-1-fly@kernel.page>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In shrink_zones(), we want to traverse node instead of zone, so
use for_each_node instead of for_each_zone.

Signed-off-by: Pengfei Li <fly@kernel.page>
---
 mm/vmscan.c | 53 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index b5256ef682c2..2b0e51525c3a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2910,6 +2910,25 @@ static inline bool compaction_ready(struct zone *zone, struct scan_control *sc)
 	return zone_watermark_ok_safe(zone, 0, watermark, sc->reclaim_idx);
 }
 
+static bool
+node_compaction_ready(struct nlist_traverser *t, struct scan_control *sc)
+{
+	bool node_ready = true;
+	struct zone *zone;
+
+	do {
+		zone = traverser_zone(t);
+
+		if (compaction_ready(zone, sc))
+			sc->compaction_ready = true;
+		else
+			node_ready = false;
+
+	} while (t->usable_zones);
+
+	return node_ready;
+}
+
 /*
  * This is the direct reclaim path, for page-allocating processes.  We only
  * try to reclaim pages from zones which will satisfy the caller's allocation
@@ -2920,12 +2939,12 @@ static inline bool compaction_ready(struct zone *zone, struct scan_control *sc)
  */
 static void shrink_zones(struct nodelist *nodelist, struct scan_control *sc)
 {
-	struct nlist_traverser t;
-	struct zone *zone;
 	unsigned long nr_soft_reclaimed;
 	unsigned long nr_soft_scanned;
 	gfp_t orig_mask;
-	pg_data_t *last_pgdat = NULL;
+	pg_data_t *pgdat;
+	struct nlist_traverser t;
+	int node;
 
 	/*
 	 * If the number of buffer_heads in the machine exceeds the maximum
@@ -2938,14 +2957,17 @@ static void shrink_zones(struct nodelist *nodelist, struct scan_control *sc)
 		sc->reclaim_idx = gfp_zone(sc->gfp_mask);
 	}
 
-	for_each_zone_nlist_nodemask(zone, &t, nodelist,
+	for_each_node_nlist_nodemask(node, &t, nodelist,
 					sc->reclaim_idx, sc->nodemask) {
+
+		pgdat = NODE_DATA(node);
+
 		/*
 		 * Take care memory controller reclaiming has small influence
 		 * to global LRU.
 		 */
 		if (!cgroup_reclaim(sc)) {
-			if (!cpuset_zone_allowed(zone,
+			if (!cpuset_node_allowed(node,
 						 GFP_KERNEL | __GFP_HARDWALL))
 				continue;
 
@@ -2960,18 +2982,7 @@ static void shrink_zones(struct nodelist *nodelist, struct scan_control *sc)
 			 */
 			if (IS_ENABLED(CONFIG_COMPACTION) &&
 			    sc->order > PAGE_ALLOC_COSTLY_ORDER &&
-			    compaction_ready(zone, sc)) {
-				sc->compaction_ready = true;
-				continue;
-			}
-
-			/*
-			 * Shrink each node in the zonelist once. If the
-			 * zonelist is ordered by zone (not the default) then a
-			 * node may be shrunk multiple times but in that case
-			 * the user prefers lower zones being preserved.
-			 */
-			if (zone->zone_pgdat == last_pgdat)
+			    node_compaction_ready(&t, sc))
 				continue;
 
 			/*
@@ -2981,7 +2992,7 @@ static void shrink_zones(struct nodelist *nodelist, struct scan_control *sc)
 			 * and balancing, not for a memcg's limit.
 			 */
 			nr_soft_scanned = 0;
-			nr_soft_reclaimed = mem_cgroup_soft_limit_reclaim(zone->zone_pgdat,
+			nr_soft_reclaimed = mem_cgroup_soft_limit_reclaim(pgdat,
 						sc->order, sc->gfp_mask,
 						&nr_soft_scanned);
 			sc->nr_reclaimed += nr_soft_reclaimed;
@@ -2989,11 +3000,7 @@ static void shrink_zones(struct nodelist *nodelist, struct scan_control *sc)
 			/* need some check for avoid more shrink_zone() */
 		}
 
-		/* See comment about same check for global reclaim above */
-		if (zone->zone_pgdat == last_pgdat)
-			continue;
-		last_pgdat = zone->zone_pgdat;
-		shrink_node(zone->zone_pgdat, sc);
+		shrink_node(pgdat, sc);
 	}
 
 	/*
-- 
2.23.0

