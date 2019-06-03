Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CDDC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C6E26BFB
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="WQm7ItMw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfFCWHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 18:07:14 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41625 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfFCWHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 18:07:13 -0400
Received: by mail-pg1-f194.google.com with SMTP id 83so2233179pgg.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 15:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TZYaz3eXPzGxVmhv3HMCDwJQRLheeIorOMAlH7HJ9WE=;
        b=WQm7ItMwHktG69xBNCOEpRK0igijLT4KjtCpBChKUtJC8aBS9I40wEtrTmWdpuarBT
         EckEfBxI/uccO9dAsIBtIyhtxBfgqHV0832w0TwgkUwpZ7L5A7gL+qjqAq5+n37IDIcL
         QOnCWjesoJnT4Ik5GCuPeO/EyCm9kSCpcQ26IFQLfuLJY5XXNcXM+pfT84cIDT5o+y6o
         +MhC8h281MnBe0uI2y+qvuR2asCG9iNhPDsNn9dwW9QRXVOtO8309ZMSiP9qFEiRH84p
         fQJBUtGGkOa0hmoDQAgB3Q9oqONyoSWSGmot04Ty0joMo26ffwXfKHDAmgMunBMEa7eZ
         vQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TZYaz3eXPzGxVmhv3HMCDwJQRLheeIorOMAlH7HJ9WE=;
        b=gnNZauc6hYQl5ZJjCt+umZJXrSf+NU56zuixEpV4jUQAJVDA045e4kSv+IH1KnJ1Ug
         AIrZQ3opzuKf4+UbiJ5VAI7QFRw2ViCNtMVXMfpiO0XZi2MnDN8/yn8BE43m3uvwfe0E
         i8vXKhK4trLwqzolDE9fjJZrqvTAjkbDAli4DkEWTjPSkmQcow+CB0XXSgwlh+8VHI+q
         HaAB360ugjqm0L7niIYraHcbstEYxSCbl2tTFjKxuog2+t5p1OfVgyfdHSbZkNy3gtcY
         V6O1xMPrAa69VmkoxQwq+x2aDFMoKYoP8Ni03dqcj4b+Api9YLrKmgK9Pkp0TxKIQErV
         lmuw==
X-Gm-Message-State: APjAAAW01Ni37dgcMJLyiUneGPS3JccO3BmyrxsKscvHwR9fLJwk93tE
        yyrKIdp3/Np8Iv5GTBJo9QbTLRwXCjY=
X-Google-Smtp-Source: APXvYqyUI6JZB6XXqVKgsi+gR5x7wSmX1jg48nP5ImJujjIGhoL+bC3ILJjIPqmTRQB1s7taN2/0gw==
X-Received: by 2002:a65:494a:: with SMTP id q10mr30911726pgs.201.1559596115744;
        Mon, 03 Jun 2019 14:08:35 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:9fa4])
        by smtp.gmail.com with ESMTPSA id g8sm7238285pgd.29.2019.06.03.14.08.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 14:08:35 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 06/11] mm: vmscan: turn shrink_node_memcg() into shrink_lruvec()
Date:   Mon,  3 Jun 2019 17:07:41 -0400
Message-Id: <20190603210746.15800-7-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603210746.15800-1-hannes@cmpxchg.org>
References: <20190603210746.15800-1-hannes@cmpxchg.org>
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
index 304974481146..b85111474ee2 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2210,9 +2210,10 @@ enum scan_balance {
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
@@ -2460,13 +2461,8 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
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
@@ -2476,7 +2472,7 @@ static void shrink_node_memcg(struct pglist_data *pgdat, struct mem_cgroup *memc
 	struct blk_plug plug;
 	bool scan_adjusted;
 
-	get_scan_count(lruvec, memcg, sc, nr);
+	get_scan_count(lruvec, sc, nr);
 
 	/* Record the original scan target for proportional adjustments later */
 	memcpy(targets, nr, sizeof(nr));
@@ -2689,6 +2685,7 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 
 	memcg = mem_cgroup_iter(root, NULL, &reclaim);
 	do {
+		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
 		unsigned long reclaimed;
 		unsigned long scanned;
 
@@ -2725,7 +2722,8 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 
 		reclaimed = sc->nr_reclaimed;
 		scanned = sc->nr_scanned;
-		shrink_node_memcg(pgdat, memcg, sc);
+
+		shrink_lruvec(lruvec, sc);
 
 		if (sc->may_shrinkslab) {
 			shrink_slab(sc->gfp_mask, pgdat->node_id,
@@ -3243,6 +3241,7 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
 						pg_data_t *pgdat,
 						unsigned long *nr_scanned)
 {
+	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
 	struct scan_control sc = {
 		.nr_to_reclaim = SWAP_CLUSTER_MAX,
 		.target_mem_cgroup = memcg,
@@ -3268,7 +3267,7 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
 	 * will pick up pages from other mem cgroup's as well. We hack
 	 * the priority and make it zero.
 	 */
-	shrink_node_memcg(pgdat, memcg, &sc);
+	shrink_lruvec(lruvec, &sc);
 
 	trace_mm_vmscan_memcg_softlimit_reclaim_end(
 					cgroup_ino(memcg->css.cgroup),
-- 
2.21.0

