Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2786CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 14:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C6421783
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 14:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="06y95Xcc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388814AbfJVOs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 10:48:28 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33287 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388354AbfJVOsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 10:48:23 -0400
Received: by mail-qk1-f193.google.com with SMTP id 71so12616785qkl.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 07:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hxh0IM0xlU3vTA2ZQpF8tyo6AUPcwm84qmU6yKeg7AE=;
        b=06y95XccQ47sNAPL8uhNFIISYVKYHbZBLHpvJ//HY7ED8ifACzizBBmrCeGvn7/4Zg
         +YEyppc3xQfaKFCGcZGNq7Cnhsw2R/CxzKDe4Z0cpUfaorTp8h+nilk9ExL4dkXX1eKG
         LioBdrUgywnZDq6EYMusUNOgI/QGFG052qREgRAU78aOQji59fTFPkF3PawYCXt03wZu
         5TG5pEPCsdOiwww9jnEJrkE4SxCF95zziI8twhfhs0vnzft25kpiI0nfscdVsvij1QUq
         6OnbyDY41FGYeL+V4lPOwsAo/+PDowshd1lLkMCXC6uycDjmx0+3I/MAyBvB46gto8kS
         yN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hxh0IM0xlU3vTA2ZQpF8tyo6AUPcwm84qmU6yKeg7AE=;
        b=CbOVS3JKJAvnAFbYKbJJPd961cWBbmsfOixy/237MGXC9S6kQ2yacsWduI6fw7gHfF
         ZN7ROP9D99zBAyF2wyz6+Q0H2ZQGw194mfK0hFKiTYCFFndUB3t9h78XgCTvLQdulKfL
         LVEN68j4TxxxPsyBvq/o/coalSoI4V8HuxPGEh24WgO0BSb07TnYU6ysEF/F0yYdeVVZ
         5gglAuJfvlJq5qvKp5zsvLasOK898gkTsr108MFIpeJO/qnP2UurdTToht3M1tqlZbRb
         Pq/SUxFz7aWOZ+8Ar1yy0guYvTBpBuJ0FxfvukGxvJRvuap9RvO8iA/K/j5ZE+qHkRuR
         ktig==
X-Gm-Message-State: APjAAAWqXWdAcFD3bKerbOQsF1UEzeYNxBu3/FKFfmSN2NevGK64C1ze
        D4LOy0hjcHTklU4QDXWdIFT6hw==
X-Google-Smtp-Source: APXvYqxRGyy7EdMQXI+J2blgh97/sGUFZVM/ZtaDfoFqFo8q3zdoWEmxTaMWpL4oHjNuZN4jtFu4pw==
X-Received: by 2002:a37:aac3:: with SMTP id t186mr3083773qke.221.1571755702048;
        Tue, 22 Oct 2019 07:48:22 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:10ad])
        by smtp.gmail.com with ESMTPSA id x133sm8682703qka.44.2019.10.22.07.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 07:48:21 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 6/8] mm: vmscan: turn shrink_node_memcg() into shrink_lruvec()
Date:   Tue, 22 Oct 2019 10:48:01 -0400
Message-Id: <20191022144803.302233-7-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191022144803.302233-1-hannes@cmpxchg.org>
References: <20191022144803.302233-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A lruvec holds LRU pages owned by a certain NUMA node and cgroup.
Instead of awkwardly passing around a combination of a pgdat and a
memcg pointer, pass down the lruvec as soon as we can look it up.

Nested callers that need to access node or cgroup properties can look
them them up if necessary, but there are only a few cases.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/vmscan.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 235d1fc72311..db073b40c432 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2280,9 +2280,10 @@ enum scan_balance {
  * nr[0] = anon inactive pages to scan; nr[1] = anon active pages to scan
  * nr[2] = file inactive pages to scan; nr[3] = file active pages to scan
  */
-static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
-			   struct scan_control *sc, unsigned long *nr)
+static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
+			   unsigned long *nr)
 {
+	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	int swappiness = mem_cgroup_swappiness(memcg);
 	struct zone_reclaim_stat *reclaim_stat = &lruvec->reclaim_stat;
 	u64 fraction[2];
@@ -2530,13 +2531,8 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
 	}
 }
 
-/*
- * This is a basic per-node page freer.  Used by both kswapd and direct reclaim.
- */
-static void shrink_node_memcg(struct pglist_data *pgdat, struct mem_cgroup *memcg,
-			      struct scan_control *sc)
+static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 {
-	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
 	unsigned long nr[NR_LRU_LISTS];
 	unsigned long targets[NR_LRU_LISTS];
 	unsigned long nr_to_scan;
@@ -2546,7 +2542,7 @@ static void shrink_node_memcg(struct pglist_data *pgdat, struct mem_cgroup *memc
 	struct blk_plug plug;
 	bool scan_adjusted;
 
-	get_scan_count(lruvec, memcg, sc, nr);
+	get_scan_count(lruvec, sc, nr);
 
 	/* Record the original scan target for proportional adjustments later */
 	memcpy(targets, nr, sizeof(nr));
@@ -2741,6 +2737,7 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 
 	memcg = mem_cgroup_iter(root, NULL, NULL);
 	do {
+		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
 		unsigned long reclaimed;
 		unsigned long scanned;
 
@@ -2777,7 +2774,8 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 
 		reclaimed = sc->nr_reclaimed;
 		scanned = sc->nr_scanned;
-		shrink_node_memcg(pgdat, memcg, sc);
+
+		shrink_lruvec(lruvec, sc);
 
 		shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
 			    sc->priority);
@@ -3281,6 +3279,7 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
 						pg_data_t *pgdat,
 						unsigned long *nr_scanned)
 {
+	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
 	struct scan_control sc = {
 		.nr_to_reclaim = SWAP_CLUSTER_MAX,
 		.target_mem_cgroup = memcg,
@@ -3307,7 +3306,7 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
 	 * will pick up pages from other mem cgroup's as well. We hack
 	 * the priority and make it zero.
 	 */
-	shrink_node_memcg(pgdat, memcg, &sc);
+	shrink_lruvec(lruvec, &sc);
 
 	trace_mm_vmscan_memcg_softlimit_reclaim_end(
 					cgroup_ino(memcg->css.cgroup),
-- 
2.23.0

