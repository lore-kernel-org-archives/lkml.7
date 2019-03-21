Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE2BC10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95EF218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbfCUUDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:03:05 -0400
Received: from mga06.intel.com ([134.134.136.31]:5168 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728839AbfCUUC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 16:02:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 13:02:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,254,1549958400"; 
   d="scan'208";a="309246245"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by orsmga005.jf.intel.com with ESMTP; 21 Mar 2019 13:02:58 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 4/5] mm: Consider anonymous pages without swap
Date:   Thu, 21 Mar 2019 14:01:56 -0600
Message-Id: <20190321200157.29678-5-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190321200157.29678-1-keith.busch@intel.com>
References: <20190321200157.29678-1-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Age and reclaim anonymous pages from nodes that have an online migration node even
if swap is not enabled.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 include/linux/swap.h | 20 ++++++++++++++++++++
 mm/vmscan.c          | 10 +++++-----
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 4bfb5c4ac108..91b405a3b44f 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -680,5 +680,25 @@ static inline bool mem_cgroup_swap_full(struct page *page)
 }
 #endif
 
+static inline bool reclaim_anon_pages(struct mem_cgroup *memcg,
+				      int node_id)
+{
+	/* Always age anon pages when we have swap */
+	if (memcg == NULL) {
+		if (get_nr_swap_pages() > 0)
+			return true;
+	} else {
+		if (mem_cgroup_get_nr_swap_pages(memcg) > 0)
+			return true;
+	}
+
+	/* Also age anon pages if we can auto-migrate them */
+	if (next_migration_node(node_id) >= 0)
+		return true;
+
+	/* No way to reclaim anon pages */
+	return false;
+}
+
 #endif /* __KERNEL__*/
 #endif /* _LINUX_SWAP_H */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 0a95804e946a..226c4c838947 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -327,7 +327,7 @@ unsigned long zone_reclaimable_pages(struct zone *zone)
 
 	nr = zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_FILE) +
 		zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_FILE);
-	if (get_nr_swap_pages() > 0)
+	if (reclaim_anon_pages(NULL, zone_to_nid(zone)))
 		nr += zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_ANON) +
 			zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_ANON);
 
@@ -2206,7 +2206,7 @@ static bool inactive_list_is_low(struct lruvec *lruvec, bool file,
 	 * If we don't have swap space, anonymous page deactivation
 	 * is pointless.
 	 */
-	if (!file && !total_swap_pages)
+	if (!file && !reclaim_anon_pages(NULL, pgdat->node_id))
 		return false;
 
 	inactive = lruvec_lru_size(lruvec, inactive_lru, sc->reclaim_idx);
@@ -2287,7 +2287,7 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
 	enum lru_list lru;
 
 	/* If we have no swap space, do not bother scanning anon pages. */
-	if (!sc->may_swap || mem_cgroup_get_nr_swap_pages(memcg) <= 0) {
+	if (!sc->may_swap || !reclaim_anon_pages(memcg, pgdat->node_id)) {
 		scan_balance = SCAN_FILE;
 		goto out;
 	}
@@ -2650,7 +2650,7 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
 	 */
 	pages_for_compaction = compact_gap(sc->order);
 	inactive_lru_pages = node_page_state(pgdat, NR_INACTIVE_FILE);
-	if (get_nr_swap_pages() > 0)
+	if (!reclaim_anon_pages(NULL, pgdat->node_id))
 		inactive_lru_pages += node_page_state(pgdat, NR_INACTIVE_ANON);
 	if (sc->nr_reclaimed < pages_for_compaction &&
 			inactive_lru_pages > pages_for_compaction)
@@ -3347,7 +3347,7 @@ static void age_active_anon(struct pglist_data *pgdat,
 {
 	struct mem_cgroup *memcg;
 
-	if (!total_swap_pages)
+	if (!reclaim_anon_pages(NULL, pgdat->node_id))
 		return;
 
 	memcg = mem_cgroup_iter(NULL, NULL, NULL);
-- 
2.14.4

