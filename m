Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9854AC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726C220674
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfKUPU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 10:20:57 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:57107 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfKUPU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:20:57 -0500
X-Originating-IP: 153.3.140.100
Received: from localhost.localdomain.localdomain (unknown [153.3.140.100])
        (Authenticated sender: fly@kernel.page)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 9FCBF1C000B;
        Thu, 21 Nov 2019 15:20:45 +0000 (UTC)
From:   Pengfei Li <fly@kernel.page>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, mhocko@kernel.org, vbabka@suse.cz,
        cl@linux.com, iamjoonsoo.kim@lge.com, guro@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Pengfei Li <fly@kernel.page>
Subject: [RFC v1 08/19] mm, vmscan: pass pgdat to wakeup_kswapd()
Date:   Thu, 21 Nov 2019 23:18:00 +0800
Message-Id: <20191121151811.49742-9-fly@kernel.page>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191121151811.49742-1-fly@kernel.page>
References: <20191121151811.49742-1-fly@kernel.page>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparation patch. Passing pgdat to wakeup_kswapd() and
avoiding indirect access to pgdat via zone->zone_pgdat.

Signed-off-by: Pengfei Li <fly@kernel.page>
---
 include/linux/mmzone.h |  2 +-
 mm/page_alloc.c        |  4 ++--
 mm/vmscan.c            | 12 ++++--------
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index dd493239b8b2..599b30620aa1 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -814,7 +814,7 @@ static inline bool pgdat_is_empty(pg_data_t *pgdat)
 #include <linux/memory_hotplug.h>
 
 void build_all_zonelists(pg_data_t *pgdat);
-void wakeup_kswapd(struct zone *zone, gfp_t gfp_mask, int order,
+void wakeup_kswapd(pg_data_t *pgdat, gfp_t gfp_mask, int order,
 		   enum zone_type classzone_idx);
 bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 			 int classzone_idx, unsigned int alloc_flags,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ec5f48b755ff..2dcf2a21c578 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3306,7 +3306,7 @@ struct page *rmqueue(struct zone *preferred_zone,
 	/* Separate test+clear to avoid unnecessary atomics */
 	if (test_bit(ZONE_BOOSTED_WATERMARK, &zone->flags)) {
 		clear_bit(ZONE_BOOSTED_WATERMARK, &zone->flags);
-		wakeup_kswapd(zone, 0, 0, zone_idx(zone));
+		wakeup_kswapd(zone->zone_pgdat, 0, 0, zone_idx(zone));
 	}
 
 	VM_BUG_ON_PAGE(page && bad_range(zone, page), page);
@@ -4173,7 +4173,7 @@ static void wake_all_kswapds(unsigned int order, gfp_t gfp_mask,
 	for_each_zone_nlist_nodemask(zone, &t, ac->nodelist, high_zoneidx,
 					ac->nodemask) {
 		if (last_pgdat != zone->zone_pgdat)
-			wakeup_kswapd(zone, gfp_mask, order, high_zoneidx);
+			wakeup_kswapd(zone->zone_pgdat, gfp_mask, order, high_zoneidx);
 		last_pgdat = zone->zone_pgdat;
 	}
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7554c8ba0841..b5256ef682c2 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3964,17 +3964,13 @@ static int kswapd(void *p)
  * has failed or is not needed, still wake up kcompactd if only compaction is
  * needed.
  */
-void wakeup_kswapd(struct zone *zone, gfp_t gfp_flags, int order,
+void wakeup_kswapd(pg_data_t *pgdat, gfp_t gfp_flags, int order,
 		   enum zone_type classzone_idx)
 {
-	pg_data_t *pgdat;
-
-	if (!managed_zone(zone))
-		return;
+	int node = pgdat->node_id;
 
-	if (!cpuset_zone_allowed(zone, gfp_flags))
+	if (!cpuset_node_allowed(node, gfp_flags))
 		return;
-	pgdat = zone->zone_pgdat;
 
 	if (pgdat->kswapd_classzone_idx == MAX_NR_ZONES)
 		pgdat->kswapd_classzone_idx = classzone_idx;
@@ -4001,7 +3997,7 @@ void wakeup_kswapd(struct zone *zone, gfp_t gfp_flags, int order,
 		return;
 	}
 
-	trace_mm_vmscan_wakeup_kswapd(pgdat->node_id, classzone_idx, order,
+	trace_mm_vmscan_wakeup_kswapd(node, classzone_idx, order,
 				      gfp_flags);
 	wake_up_interruptible(&pgdat->kswapd_wait);
 }
-- 
2.23.0

