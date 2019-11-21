Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1B4C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1BF020674
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfKUPUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 10:20:46 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:58933 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfKUPUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:20:46 -0500
X-Originating-IP: 153.3.140.100
Received: from localhost.localdomain.localdomain (unknown [153.3.140.100])
        (Authenticated sender: fly@kernel.page)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 85FE91C0002;
        Thu, 21 Nov 2019 15:20:33 +0000 (UTC)
From:   Pengfei Li <fly@kernel.page>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, mhocko@kernel.org, vbabka@suse.cz,
        cl@linux.com, iamjoonsoo.kim@lge.com, guro@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Pengfei Li <fly@kernel.page>
Subject: [RFC v1 07/19] mm, vmscan: use first_node in throttle_direct_reclaim()
Date:   Thu, 21 Nov 2019 23:17:59 +0800
Message-Id: <20191121151811.49742-8-fly@kernel.page>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191121151811.49742-1-fly@kernel.page>
References: <20191121151811.49742-1-fly@kernel.page>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In throttle_direct_reclaim(), we want to access first node instead of
first zone, so use first_node_nlist instead of first_zone_zonelist.

Signed-off-by: Pengfei Li <fly@kernel.page>
---
 mm/vmscan.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 159a2aaa8db1..7554c8ba0841 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3166,9 +3166,9 @@ static bool allow_direct_reclaim(pg_data_t *pgdat)
 static bool throttle_direct_reclaim(gfp_t gfp_mask, struct nodelist *nodelist,
 					nodemask_t *nodemask)
 {
-	struct nlist_traverser t;
-	struct zone *zone;
-	pg_data_t *pgdat = NULL;
+	pg_data_t *pgdat;
+	enum zone_type high_idx;
+	int node;
 
 	/*
 	 * Kernel threads should not be throttled as they may be indirectly
@@ -3178,21 +3178,24 @@ static bool throttle_direct_reclaim(gfp_t gfp_mask, struct nodelist *nodelist,
 	 * processes to block on log_wait_commit().
 	 */
 	if (current->flags & PF_KTHREAD)
-		goto out;
+		return false;
 
 	/*
 	 * If a fatal signal is pending, this process should not throttle.
 	 * It should return quickly so it can exit and free its memory
 	 */
 	if (fatal_signal_pending(current))
-		goto out;
+		return false;
 
 	/*
 	 * Check if the pfmemalloc reserves are ok by finding the first node
 	 * with a usable ZONE_NORMAL or lower zone. The expectation is that
 	 * GFP_KERNEL will be required for allocating network buffers when
 	 * swapping over the network so ZONE_HIGHMEM is unusable.
-	 *
+	 */
+	high_idx = min_t(enum zone_type, ZONE_NORMAL, gfp_zone(gfp_mask));
+
+	/*
 	 * Throttling is based on the first usable node and throttled processes
 	 * wait on a queue until kswapd makes progress and wakes them. There
 	 * is an affinity then between processes waking up and where reclaim
@@ -3201,21 +3204,16 @@ static bool throttle_direct_reclaim(gfp_t gfp_mask, struct nodelist *nodelist,
 	 * for remote pfmemalloc reserves and processes on different nodes
 	 * should make reasonable progress.
 	 */
-	for_each_zone_nlist_nodemask(zone, &t, nodelist,
-					gfp_zone(gfp_mask), nodemask) {
-		if (zone_idx(zone) > ZONE_NORMAL)
-			continue;
-
-		/* Throttle based on the first usable node */
-		pgdat = zone->zone_pgdat;
-		if (allow_direct_reclaim(pgdat))
-			goto out;
-		break;
-	}
+	node = first_node_nlist_nodemask(nodelist, high_idx, nodemask);
 
 	/* If no zone was usable by the allocation flags then do not throttle */
-	if (!pgdat)
-		goto out;
+	if (node == NUMA_NO_NODE)
+		return false;
+
+	pgdat = NODE_DATA(node);
+	/* Throttle based on the first usable node */
+	if (allow_direct_reclaim(pgdat))
+		return false;
 
 	/* Account for the throttling */
 	count_vm_event(PGSCAN_DIRECT_THROTTLE);
@@ -3236,14 +3234,13 @@ static bool throttle_direct_reclaim(gfp_t gfp_mask, struct nodelist *nodelist,
 	}
 
 	/* Throttle until kswapd wakes the process */
-	wait_event_killable(zone->zone_pgdat->pfmemalloc_wait,
-		allow_direct_reclaim(pgdat));
+	wait_event_killable(pgdat->pfmemalloc_wait,
+				allow_direct_reclaim(pgdat));
 
 check_pending:
 	if (fatal_signal_pending(current))
 		return true;
 
-out:
 	return false;
 }
 
-- 
2.23.0

