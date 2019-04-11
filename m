Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60817C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B12217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfDKD6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 23:58:04 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:38048 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726801AbfDKD6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 23:58:03 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0TP0I5rB_1554955031;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TP0I5rB_1554955031)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 11 Apr 2019 11:57:23 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@suse.com, mgorman@techsingularity.net, riel@surriel.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, keith.busch@intel.com,
        dan.j.williams@intel.com, fengguang.wu@intel.com, fan.du@intel.com,
        ying.huang@intel.com, ziy@nvidia.com
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH 6/9] mm: vmscan: don't demote for memcg reclaim
Date:   Thu, 11 Apr 2019 11:56:56 +0800
Message-Id: <1554955019-29472-7-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1554955019-29472-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1554955019-29472-1-git-send-email-yang.shi@linux.alibaba.com>
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
index 2a96609..80cd624 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1046,8 +1046,12 @@ static void page_check_dirty_writeback(struct page *page,
 		mapping->a_ops->is_dirty_writeback(page, dirty, writeback);
 }
 
-static inline bool is_demote_ok(int nid)
+static inline bool is_demote_ok(int nid, struct scan_control *sc)
 {
+	/* It is pointless to do demotion in memcg reclaim */
+	if (!global_reclaim(sc))
+		return false;
+
 	/* Current node is cpuless node */
 	if (!node_state(nid, N_CPU_MEM))
 		return false;
@@ -1267,7 +1271,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 				 * Demotion only happen from primary nodes
 				 * to cpuless nodes.
 				 */
-				if (is_demote_ok(page_to_nid(page))) {
+				if (is_demote_ok(page_to_nid(page), sc)) {
 					list_add(&page->lru, &demote_pages);
 					unlock_page(page);
 					continue;
@@ -2219,7 +2223,7 @@ static bool inactive_list_is_low(struct lruvec *lruvec, bool file,
 	 * deactivation is pointless.
 	 */
 	if (!file && !total_swap_pages &&
-	    !is_demote_ok(pgdat->node_id))
+	    !is_demote_ok(pgdat->node_id, sc))
 		return false;
 
 	inactive = lruvec_lru_size(lruvec, inactive_lru, sc->reclaim_idx);
@@ -2306,7 +2310,7 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
 	 *
 	 * If current node is already PMEM node, demotion is not applicable.
 	 */
-	if (!is_demote_ok(pgdat->node_id)) {
+	if (!is_demote_ok(pgdat->node_id, sc)) {
 		/*
 		 * If we have no swap space, do not bother scanning
 		 * anon pages.
@@ -2315,18 +2319,18 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
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
@@ -2675,7 +2679,7 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
 	 */
 	pages_for_compaction = compact_gap(sc->order);
 	inactive_lru_pages = node_page_state(pgdat, NR_INACTIVE_FILE);
-	if (get_nr_swap_pages() > 0 || is_demote_ok(pgdat->node_id))
+	if (get_nr_swap_pages() > 0 || is_demote_ok(pgdat->node_id, sc))
 		inactive_lru_pages += node_page_state(pgdat, NR_INACTIVE_ANON);
 	if (sc->nr_reclaimed < pages_for_compaction &&
 			inactive_lru_pages > pages_for_compaction)
@@ -3373,7 +3377,7 @@ static void age_active_anon(struct pglist_data *pgdat,
 	struct mem_cgroup *memcg;
 
 	/* Aging anon page as long as demotion is fine */
-	if (!total_swap_pages && !is_demote_ok(pgdat->node_id))
+	if (!total_swap_pages && !is_demote_ok(pgdat->node_id, sc))
 		return;
 
 	memcg = mem_cgroup_iter(NULL, NULL, NULL);
-- 
1.8.3.1

