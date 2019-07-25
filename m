Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6787CC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ABBE22BED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ce3BfUeG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfGYSoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 14:44:13 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33837 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfGYSoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 14:44:13 -0400
Received: by mail-pf1-f196.google.com with SMTP id b13so23192031pfo.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 11:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GxVVw+uo+vFwM7PZaI+aVqiAbCOjCI60HaAqMSq8WWY=;
        b=ce3BfUeGr5RpaaJuxLzqnTv6kfjovpk0RpJi4XkdjoZ09kuLbjLfifBWwVxGtr0P5N
         c+JPAyQXIvDXOJlb8TvzZesIbMhQ7Q+VOb8kgcEyU4Q1BFWJGFXEA7egGcpgDf4k25t6
         rL1lu1W8Z6v1z/wBXGWZMYXGq43yAzT2Yq4JtFYJ/lwBZx6kb+0iTGtQ4PjaH3dvB1fS
         W/P3nEbQGwu4Yo+D2rivw270jqdSfiAZTgEfvb90A2vbyE2o3M3FRqO5DsPhVUTW92Jp
         xQv77ACbAaizSP+KRVeCYrxET/NyCdZWrl/ImYs95iLb8fDR5EVn2Bd+SYgw7i9PeLq6
         SB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GxVVw+uo+vFwM7PZaI+aVqiAbCOjCI60HaAqMSq8WWY=;
        b=aYACvGprygnxgMWpGb89eAF4tUtmq/3E3nWsBanK1oEOPlTZ6YyWIVxWTyLKhkTw99
         jst/SV5SurzITLRKcZly0YXmXyy6eS6DVGTI/RX+kiAfg0KEbGUZaIa3Zy8Ld3Uy+t6s
         8TBaTxekea5gm8pU13j17aLaiYiix7YCWPKZ/isKgKKkI2UYJmkyKbKLQlbjuiX5BYOx
         TiAy4xfrM6ax+zcKKLeeblehw3EdovSBbNoLGrI4yv967R3kksQBdRMaJtuXSixArGaI
         AuzS4tbEX/qLUD+bbwGyLnoXDsiou5J6oktyx5OaHlV9CwVIU8itQUSBD2dGCUnmKe9v
         N0zQ==
X-Gm-Message-State: APjAAAWBivjB8izj2atkVBJT2VPazacbOcqO0gDMBMOqQ4vSfyXyqPvh
        lWYH3EtBoQNddvDsrkE0SG0=
X-Google-Smtp-Source: APXvYqyXEVRoC4diyAozk4NBAOKJzOBURSN/nlzqvND8mGjSVxSBPVf6BuR77GbLQICsMucmgFRs0w==
X-Received: by 2002:a63:d415:: with SMTP id a21mr85176650pgh.229.1564080252386;
        Thu, 25 Jul 2019 11:44:12 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:624:b8c3:8577:bf2f:3])
        by smtp.gmail.com with ESMTPSA id w3sm43818257pgl.31.2019.07.25.11.44.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 11:44:11 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, mhocko@suse.com, vbabka@suse.cz,
        cai@lca.pw, aryabinin@virtuozzo.com, osalvador@suse.de,
        rostedt@goodmis.org, mingo@redhat.com,
        pavel.tatashin@microsoft.com, rppt@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH 05/10] mm/compaction: make "order" and "search_order" unsigned int in struct compact_control
Date:   Fri, 26 Jul 2019 02:42:48 +0800
Message-Id: <20190725184253.21160-6-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190725184253.21160-1-lpf.vector@gmail.com>
References: <20190725184253.21160-1-lpf.vector@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Objective
----
The "order"and "search_order" is int in struct compact_control. This
commit is aim to make "order" is unsigned int like other mm subsystem.

Change
----
1) Change "order" and "search_order" to unsigned int

2) Make is_via_compact_memory() return true when "order" is equal to
MAX_ORDER instead of -1, and rename it to is_manual_compaction() for
a clearer meaning.

3) Modify next_search_order() to fit unsigned order.

4) Restore fast_search_fail to unsigned int.
This is ok because search_order is already unsigned int, and after
reverting fast_search_fail to unsigned int, compact_control is still
within two cache lines.

Signed-off-by: Pengfei Li <lpf.vector@gmail.com>
---
 mm/compaction.c | 96 +++++++++++++++++++++++++------------------------
 mm/internal.h   |  6 ++--
 2 files changed, 53 insertions(+), 49 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 952dc2fb24e5..e47d8fa943a6 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -75,7 +75,7 @@ static void split_map_pages(struct list_head *list)
 	list_for_each_entry_safe(page, next, list, lru) {
 		list_del(&page->lru);
 
-		order = page_private(page);
+		order = page_order(page);
 		nr_pages = 1 << order;
 
 		post_alloc_hook(page, order, __GFP_MOVABLE);
@@ -879,7 +879,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		 * potential isolation targets.
 		 */
 		if (PageBuddy(page)) {
-			unsigned long freepage_order = page_order_unsafe(page);
+			unsigned int freepage_order = page_order_unsafe(page);
 
 			/*
 			 * Without lock, we cannot be sure that what we got is
@@ -1119,6 +1119,15 @@ isolate_migratepages_range(struct compact_control *cc, unsigned long start_pfn,
 #endif /* CONFIG_COMPACTION || CONFIG_CMA */
 #ifdef CONFIG_COMPACTION
 
+/*
+ * order == MAX_ORDER is expected when compacting via
+ * /proc/sys/vm/compact_memory
+ */
+static inline bool is_manual_compaction(struct compact_control *cc)
+{
+	return cc->order == MAX_ORDER;
+}
+
 static bool suitable_migration_source(struct compact_control *cc,
 							struct page *page)
 {
@@ -1167,7 +1176,7 @@ static bool suitable_migration_target(struct compact_control *cc,
 static inline unsigned int
 freelist_scan_limit(struct compact_control *cc)
 {
-	unsigned short shift = BITS_PER_LONG - 1;
+	unsigned int shift = BITS_PER_LONG - 1;
 
 	return (COMPACT_CLUSTER_MAX >> min(shift, cc->fast_search_fail)) + 1;
 }
@@ -1253,21 +1262,24 @@ fast_isolate_around(struct compact_control *cc, unsigned long pfn, unsigned long
 }
 
 /* Search orders in round-robin fashion */
-static int next_search_order(struct compact_control *cc, int order)
+static unsigned int
+next_search_order(struct compact_control *cc, unsigned int order)
 {
-	order--;
-	if (order < 0)
-		order = cc->order - 1;
+	unsigned int next_order = order - 1;
 
-	/* Search wrapped around? */
-	if (order == cc->search_order) {
-		cc->search_order--;
-		if (cc->search_order < 0)
+	if (order == 0)
+		next_order = cc->order - 1;
+
+	if (next_order == cc->search_order) {
+		next_order = UINT_MAX;
+
+		order = cc->search_order;
+		cc->search_order -= 1;
+		if (order == 0)
 			cc->search_order = cc->order - 1;
-		return -1;
 	}
 
-	return order;
+	return next_order;
 }
 
 static unsigned long
@@ -1280,10 +1292,10 @@ fast_isolate_freepages(struct compact_control *cc)
 	unsigned long distance;
 	struct page *page = NULL;
 	bool scan_start = false;
-	int order;
+	unsigned int order;
 
-	/* Full compaction passes in a negative order */
-	if (cc->order <= 0)
+	/* Full compaction when manual compaction */
+	if (is_manual_compaction(cc))
 		return cc->free_pfn;
 
 	/*
@@ -1310,10 +1322,10 @@ fast_isolate_freepages(struct compact_control *cc)
 	 * Search starts from the last successful isolation order or the next
 	 * order to search after a previous failure
 	 */
-	cc->search_order = min_t(unsigned int, cc->order - 1, cc->search_order);
+	cc->search_order = min(cc->order - 1, cc->search_order);
 
 	for (order = cc->search_order;
-	     !page && order >= 0;
+	     !page && order < MAX_ORDER;
 	     order = next_search_order(cc, order)) {
 		struct free_area *area = &cc->zone->free_area[order];
 		struct list_head *freelist;
@@ -1837,15 +1849,6 @@ static isolate_migrate_t isolate_migratepages(struct zone *zone,
 	return cc->nr_migratepages ? ISOLATE_SUCCESS : ISOLATE_NONE;
 }
 
-/*
- * order == -1 is expected when compacting via
- * /proc/sys/vm/compact_memory
- */
-static inline bool is_via_compact_memory(int order)
-{
-	return order == -1;
-}
-
 static enum compact_result __compact_finished(struct compact_control *cc)
 {
 	unsigned int order;
@@ -1872,7 +1875,7 @@ static enum compact_result __compact_finished(struct compact_control *cc)
 			return COMPACT_PARTIAL_SKIPPED;
 	}
 
-	if (is_via_compact_memory(cc->order))
+	if (is_manual_compaction(cc))
 		return COMPACT_CONTINUE;
 
 	/*
@@ -1962,9 +1965,6 @@ static enum compact_result __compaction_suitable(struct zone *zone, int order,
 {
 	unsigned long watermark;
 
-	if (is_via_compact_memory(order))
-		return COMPACT_CONTINUE;
-
 	watermark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
 	/*
 	 * If watermarks for high-order allocation are already met, there
@@ -2071,7 +2071,7 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 static enum compact_result
 compact_zone(struct compact_control *cc, struct capture_control *capc)
 {
-	enum compact_result ret;
+	enum compact_result ret = COMPACT_CONTINUE;
 	unsigned long start_pfn = cc->zone->zone_start_pfn;
 	unsigned long end_pfn = zone_end_pfn(cc->zone);
 	unsigned long last_migrated_pfn;
@@ -2079,21 +2079,25 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 	bool update_cached;
 
 	cc->migratetype = gfpflags_to_migratetype(cc->gfp_mask);
-	ret = compaction_suitable(cc->zone, cc->order, cc->alloc_flags,
-							cc->classzone_idx);
-	/* Compaction is likely to fail */
-	if (ret == COMPACT_SUCCESS || ret == COMPACT_SKIPPED)
-		return ret;
 
-	/* huh, compaction_suitable is returning something unexpected */
-	VM_BUG_ON(ret != COMPACT_CONTINUE);
+	if (!is_manual_compaction(cc)) {
+		ret = compaction_suitable(cc->zone, cc->order,
+					cc->alloc_flags, cc->classzone_idx);
 
-	/*
-	 * Clear pageblock skip if there were failures recently and compaction
-	 * is about to be retried after being deferred.
-	 */
-	if (compaction_restarting(cc->zone, cc->order))
-		__reset_isolation_suitable(cc->zone);
+		/* Compaction is likely to fail */
+		if (ret == COMPACT_SUCCESS || ret == COMPACT_SKIPPED)
+			return ret;
+
+		/* huh, compaction_suitable is returning something unexpected */
+		VM_BUG_ON(ret != COMPACT_CONTINUE);
+
+		/*
+		 * Clear pageblock skip if there were failures recently and
+		 * compaction is about to be retried after being deferred.
+		 */
+		if (compaction_restarting(cc->zone, cc->order))
+			__reset_isolation_suitable(cc->zone);
+	}
 
 	/*
 	 * Setup to move all movable pages to the end of the zone. Used cached
@@ -2407,7 +2411,7 @@ static void compact_node(int nid)
 	int zoneid;
 	struct zone *zone;
 	struct compact_control cc = {
-		.order = -1,
+		.order = MAX_ORDER, /* is manual compaction */
 		.total_migrate_scanned = 0,
 		.total_free_scanned = 0,
 		.mode = MIGRATE_SYNC,
diff --git a/mm/internal.h b/mm/internal.h
index e32390802fd3..4e0ab641fb6c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -188,10 +188,10 @@ struct compact_control {
 	struct zone *zone;
 	unsigned long total_migrate_scanned;
 	unsigned long total_free_scanned;
-	unsigned short fast_search_fail;/* failures to use free list searches */
-	short search_order;		/* order to start a fast search at */
+	unsigned int fast_search_fail;	/* failures to use free list searches */
 	const gfp_t gfp_mask;		/* gfp mask of a direct compactor */
-	int order;			/* order a direct compactor needs */
+	unsigned int order;		/* order a direct compactor needs */
+	unsigned int search_order;	/* order to start a fast search at */
 	int migratetype;		/* migratetype of direct compactor */
 	const unsigned int alloc_flags;	/* alloc flags of a direct compactor */
 	const int classzone_idx;	/* zone index of a direct compactor */
-- 
2.21.0

