Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE90C31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 23:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DFF720896
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 23:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfFMXai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 19:30:38 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:46326 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727515AbfFMXah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 19:30:37 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0TU6DYEz_1560468591;
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
Subject: [v3 PATCH 7/9] mm: vmscan: check if the demote target node is contended or not
Date:   Fri, 14 Jun 2019 07:29:35 +0800
Message-Id: <1560468577-101178-8-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1560468577-101178-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1560468577-101178-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When demoting to the migration target node, the target node may have
memory pressure, then the memory pressure may cause migrate_pages()
fail.

If the failure is caused by memory pressure (i.e. returning -ENOMEM),
tag the node with PGDAT_CONTENDED.  The tag would be cleared once the
target node is balanced again.

Check if the target node is PGDAT_CONTENDED or not, if it is just skip
demotion.

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 include/linux/mmzone.h |  3 +++
 mm/vmscan.c            | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 70394ca..d4e05c5 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -573,6 +573,9 @@ enum pgdat_flags {
 					 * many pages under writeback
 					 */
 	PGDAT_RECLAIM_LOCKED,		/* prevents concurrent reclaim */
+	PGDAT_CONTENDED,		/* the node has not enough free memory
+					 * available
+					 */
 };
 
 enum zone_flags {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index fb931ded..9ec55d7 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1126,6 +1126,21 @@ static inline struct page *alloc_demote_page(struct page *page,
 }
 #endif
 
+static inline bool is_migration_target_contended(int nid)
+{
+	int node;
+	nodemask_t used_mask;
+
+
+	nodes_clear(used_mask);
+	node = find_next_best_node(nid, &used_mask, true);
+
+	if (test_bit(PGDAT_CONTENDED, &NODE_DATA(node)->flags))
+		return true;
+
+	return false;
+}
+
 static inline bool is_demote_ok(int nid, struct scan_control *sc)
 {
 	/* Just do demotion with migrate mode of node reclaim */
@@ -1144,6 +1159,10 @@ static inline bool is_demote_ok(int nid, struct scan_control *sc)
 	if (!has_migration_target_node_online())
 		return false;
 
+	/* Check if the demote target node is contended or not */
+	if (is_migration_target_contended(nid))
+		return false;
+
 	return true;
 }
 
@@ -1564,6 +1583,10 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 		nr_reclaimed += nr_succeeded;
 
 		if (err) {
+			if (err == -ENOMEM)
+				set_bit(PGDAT_CONTENDED,
+					&NODE_DATA(target_nid)->flags);
+
 			putback_movable_pages(&demote_pages);
 
 			list_splice(&ret_pages, &demote_pages);
@@ -2597,6 +2620,19 @@ static void shrink_node_memcg(struct pglist_data *pgdat, struct mem_cgroup *memc
 		 * scan target and the percentage scanning already complete
 		 */
 		lru = (lru == LRU_FILE) ? LRU_BASE : LRU_FILE;
+
+		/*
+		 * The shrink_page_list() may find the demote target node is
+		 * contended, if so it doesn't make sense to scan anonymous
+		 * LRU again.
+		 *
+		 * Need check if swap is available or not too since demotion
+		 * may happen on swapless system.
+		 */
+		if (!is_demote_ok(pgdat->node_id, sc) &&
+		    (!sc->may_swap || mem_cgroup_get_nr_swap_pages(memcg) <= 0))
+			lru = LRU_FILE;
+
 		nr_scanned = targets[lru] - nr[lru];
 		nr[lru] = targets[lru] * (100 - percentage) / 100;
 		nr[lru] -= min(nr[lru], nr_scanned);
@@ -3447,6 +3483,7 @@ static void clear_pgdat_congested(pg_data_t *pgdat)
 	clear_bit(PGDAT_CONGESTED, &pgdat->flags);
 	clear_bit(PGDAT_DIRTY, &pgdat->flags);
 	clear_bit(PGDAT_WRITEBACK, &pgdat->flags);
+	clear_bit(PGDAT_CONTENDED, &pgdat->flags);
 }
 
 /*
-- 
1.8.3.1

