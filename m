Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1893C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 23:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C57020896
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 23:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbfFMXa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 19:30:29 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:56663 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726535AbfFMXaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 19:30:02 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0TU6DYEz_1560468591;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TU6DYEz_1560468591)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 14 Jun 2019 07:30:00 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@suse.com, mgorman@techsingularity.net, riel@surriel.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, keith.busch@intel.com,
        dan.j.williams@intel.com, fengguang.wu@intel.com, fan.du@intel.com,
        ying.huang@intel.com, ziy@nvidia.com
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v3 PATCH 6/9] mm: vmscan: don't demote for memcg reclaim
Date:   Fri, 14 Jun 2019 07:29:34 +0800
Message-Id: <1560468577-101178-7-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1560468577-101178-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1560468577-101178-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memcg reclaim happens when the limit is breached, but demotion just
migrate pages to the other node instead of reclaiming them.  This sounds
pointless to memcg reclaim since the usage is not reduced at all.

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/vmscan.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 428a83b..fb931ded 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1126,12 +1126,16 @@ static inline struct page *alloc_demote_page(struct page *page,
 }
 #endif
 
-static inline bool is_demote_ok(int nid)
+static inline bool is_demote_ok(int nid, struct scan_control *sc)
 {
 	/* Just do demotion with migrate mode of node reclaim */
 	if (!(node_reclaim_mode & RECLAIM_MIGRATE))
 		return false;
 
+	/* It is pointless to do demotion in memcg reclaim */
+	if (!global_reclaim(sc))
+		return false;
+
 	/* Current node is cpuless node */
 	if (!node_state(nid, N_CPU_MEM))
 		return false;
@@ -1326,7 +1330,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 				 * Demotion only happen from primary nodes
 				 * to cpuless nodes.
 				 */
-				if (is_demote_ok(page_to_nid(page))) {
+				if (is_demote_ok(page_to_nid(page), sc)) {
 					list_add(&page->lru, &demote_pages);
 					unlock_page(page);
 					continue;
@@ -2226,7 +2230,7 @@ static bool inactive_list_is_low(struct lruvec *lruvec, bool file,
 	 * anonymous page deactivation is pointless.
 	 */
 	if (!file && !total_swap_pages &&
-	    !is_demote_ok(pgdat->node_id))
+	    !is_demote_ok(pgdat->node_id, sc))
 		return false;
 
 	inactive = lruvec_lru_size(lruvec, inactive_lru, sc->reclaim_idx);
@@ -2307,7 +2311,7 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
 	 *
 	 * If current node is already PMEM node, demotion is not applicable.
 	 */
-	if (!is_demote_ok(pgdat->node_id)) {
+	if (!is_demote_ok(pgdat->node_id, sc)) {
 		/*
 		 * If we have no swap space, do not bother scanning
 		 * anon pages.
@@ -2316,18 +2320,18 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
 			scan_balance = SCAN_FILE;
 			goto out;
 		}
+	}
 
-		/*
-		 * Global reclaim will swap to prevent OOM even with no
-		 * swappiness, but memcg users want to use this knob to
-		 * disable swapping for individual groups completely when
-		 * using the memory controller's swap limit feature would be
-		 * too expensive.
-		 */
-		if (!global_reclaim(sc) && !swappiness) {
-			scan_balance = SCAN_FILE;
-			goto out;
-		}
+	/*
+	 * Global reclaim will swap to prevent OOM even with no
+	 * swappiness, but memcg users want to use this knob to
+	 * disable swapping for individual groups completely when
+	 * using the memory controller's swap limit feature would be
+	 * too expensive.
+	 */
+	if (!global_reclaim(sc) && !swappiness) {
+		scan_balance = SCAN_FILE;
+		goto out;
 	}
 
 	/*
@@ -2676,7 +2680,7 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
 	 */
 	pages_for_compaction = compact_gap(sc->order);
 	inactive_lru_pages = node_page_state(pgdat, NR_INACTIVE_FILE);
-	if (get_nr_swap_pages() > 0 || is_demote_ok(pgdat->node_id))
+	if (get_nr_swap_pages() > 0 || is_demote_ok(pgdat->node_id, sc))
 		inactive_lru_pages += node_page_state(pgdat, NR_INACTIVE_ANON);
 	if (sc->nr_reclaimed < pages_for_compaction &&
 			inactive_lru_pages > pages_for_compaction)
@@ -3362,7 +3366,7 @@ static void age_active_anon(struct pglist_data *pgdat,
 	struct mem_cgroup *memcg;
 
 	/* Aging anon page as long as demotion is fine */
-	if (!total_swap_pages && !is_demote_ok(pgdat->node_id))
+	if (!total_swap_pages && !is_demote_ok(pgdat->node_id, sc))
 		return;
 
 	memcg = mem_cgroup_iter(NULL, NULL, NULL);
-- 
1.8.3.1

