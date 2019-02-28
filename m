Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E115C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D544F218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731943AbfB1Ifz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:35:55 -0500
Received: from relay.sw.ru ([185.231.240.75]:57914 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731829AbfB1Ift (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:35:49 -0500
Received: from [172.16.25.12] (helo=i7.sw.ru)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1gzHAK-0008R2-BB; Thu, 28 Feb 2019 11:35:40 +0300
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH v2 4/4] mm/vmscan: remove unused lru_pages argument
Date:   Thu, 28 Feb 2019 11:33:29 +0300
Message-Id: <20190228083329.31892-4-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190228083329.31892-1-aryabinin@virtuozzo.com>
References: <20190228083329.31892-1-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 9092c71bb724 ("mm: use sc->priority for slab shrink targets")
the argument 'unsigned long *lru_pages' passed around with no purpose.
Remove it.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
---

Changes since v1:
 - Changelog update
 - Added acks

 mm/vmscan.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2d081a32c6a8..07f74e9507b6 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2257,8 +2257,7 @@ enum scan_balance {
  * nr[2] = file inactive pages to scan; nr[3] = file active pages to scan
  */
 static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
-			   struct scan_control *sc, unsigned long *nr,
-			   unsigned long *lru_pages)
+			   struct scan_control *sc, unsigned long *nr)
 {
 	int swappiness = mem_cgroup_swappiness(memcg);
 	struct zone_reclaim_stat *reclaim_stat = &lruvec->reclaim_stat;
@@ -2409,7 +2408,6 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
 	fraction[1] = fp;
 	denominator = ap + fp + 1;
 out:
-	*lru_pages = 0;
 	for_each_evictable_lru(lru) {
 		int file = is_file_lru(lru);
 		unsigned long lruvec_size;
@@ -2525,7 +2523,6 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
 			BUG();
 		}
 
-		*lru_pages += lruvec_size;
 		nr[lru] = scan;
 	}
 }
@@ -2534,7 +2531,7 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
  * This is a basic per-node page freer.  Used by both kswapd and direct reclaim.
  */
 static void shrink_node_memcg(struct pglist_data *pgdat, struct mem_cgroup *memcg,
-			      struct scan_control *sc, unsigned long *lru_pages)
+			      struct scan_control *sc)
 {
 	struct lruvec *lruvec = mem_cgroup_lruvec(pgdat, memcg);
 	unsigned long nr[NR_LRU_LISTS];
@@ -2546,7 +2543,7 @@ static void shrink_node_memcg(struct pglist_data *pgdat, struct mem_cgroup *memc
 	struct blk_plug plug;
 	bool scan_adjusted;
 
-	get_scan_count(lruvec, memcg, sc, nr, lru_pages);
+	get_scan_count(lruvec, memcg, sc, nr);
 
 	/* Record the original scan target for proportional adjustments later */
 	memcpy(targets, nr, sizeof(nr));
@@ -2751,7 +2748,6 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 			.pgdat = pgdat,
 			.priority = sc->priority,
 		};
-		unsigned long node_lru_pages = 0;
 		struct mem_cgroup *memcg;
 
 		memset(&sc->nr, 0, sizeof(sc->nr));
@@ -2761,7 +2757,6 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 
 		memcg = mem_cgroup_iter(root, NULL, &reclaim);
 		do {
-			unsigned long lru_pages;
 			unsigned long reclaimed;
 			unsigned long scanned;
 
@@ -2798,8 +2793,7 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 
 			reclaimed = sc->nr_reclaimed;
 			scanned = sc->nr_scanned;
-			shrink_node_memcg(pgdat, memcg, sc, &lru_pages);
-			node_lru_pages += lru_pages;
+			shrink_node_memcg(pgdat, memcg, sc);
 
 			if (sc->may_shrinkslab) {
 				shrink_slab(sc->gfp_mask, pgdat->node_id,
@@ -3332,7 +3326,6 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
 		.may_swap = !noswap,
 		.may_shrinkslab = 1,
 	};
-	unsigned long lru_pages;
 
 	sc.gfp_mask = (gfp_mask & GFP_RECLAIM_MASK) |
 			(GFP_HIGHUSER_MOVABLE & ~GFP_RECLAIM_MASK);
@@ -3349,7 +3342,7 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
 	 * will pick up pages from other mem cgroup's as well. We hack
 	 * the priority and make it zero.
 	 */
-	shrink_node_memcg(pgdat, memcg, &sc, &lru_pages);
+	shrink_node_memcg(pgdat, memcg, &sc);
 
 	trace_mm_vmscan_memcg_softlimit_reclaim_end(sc.nr_reclaimed);
 
-- 
2.19.2

