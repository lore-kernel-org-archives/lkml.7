Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED177C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE4B926D60
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="CfO5Ti2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfFCWAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 18:00:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37118 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfFCWAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 18:00:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id a23so11389925pff.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 15:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TqYkozLWwlwjh5tlY84d20KyoxNGzeaiPZCNbBAwhx4=;
        b=CfO5Ti2iu2mKkyrYwQLDB8QQe+3afMqMfaNa/wJWa+mXj+X31SmaTgT+uw/gY/rdTf
         jyGegdzwHQpljpHWA2wVsG+b+pBVziQt1WX1xTIGjq8MuGjOuPpGwAopHMkHZqKp3+Ui
         tIjfvPdEXyrjLHGUp3YnhPfJubq1kFYnfoDUBGlOpXwawLoXGpyTrhQT4Z9tXoIbW1ou
         FA5RvsNPdN/E2REMNh3zWT5ebiR0nab16veulDQZkupuNnzCdYJtcdh5eyxzTO6LIVCK
         7VRPrTbECquvW9jgMxA0+O34IrqMJjOL2ObDNuSMq/SrUHZlwsk4bT5BfEeNMBlTPcMO
         wkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TqYkozLWwlwjh5tlY84d20KyoxNGzeaiPZCNbBAwhx4=;
        b=Y5obV+SaSVsAVhhymyUqOaO/rAiizvVtXncSbQ0NUXoA3abUwCcmZdNZXB1qbJ3QeY
         xIghsHDV8/xctRI1FrCL6IR1fVMZ7qMNJ80WzirFkWqSC8eMpv5wDKE9fhkcJxChJjZS
         fJYLB+UdSsW7Tv50tCYOtApLeUx/03xCdOlXsUBhkxpxfmGiJv4Bc5Ah/9OIkPFvSTFl
         LPUtH859IVA7J3LueS5E5EsFXsWvlY97I6kQN+ErsuDvDBWWUA+3VTqKOXOSFp7djD93
         Ex7ETnKFqXnBJ19khOsvfOVoppHqkCK9knEhtFgV2FAZ6nzewnaFZNzBMwZ723ctIaXh
         1yZg==
X-Gm-Message-State: APjAAAU9aIkEXAIFCX+CeReL45DYHgFsD5klYSg59KkN6zesTtCkExmj
        UiAFBTwEFS90uENen0BSkjXgrqiT/FI=
X-Google-Smtp-Source: APXvYqzH0EJ92OjOv5FwdHpAISabNaN9/8D6YdAXlhN10L2LyvWxDpYUP+V6sT0plAQOTb0Hmr9Pgg==
X-Received: by 2002:a17:90a:192:: with SMTP id 18mr33065596pjc.107.1559596117989;
        Mon, 03 Jun 2019 14:08:37 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:9fa4])
        by smtp.gmail.com with ESMTPSA id i25sm16343173pfr.73.2019.06.03.14.08.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 14:08:37 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 07/11] mm: vmscan: split shrink_node() into node part and memcgs part
Date:   Mon,  3 Jun 2019 17:07:42 -0400
Message-Id: <20190603210746.15800-8-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603210746.15800-1-hannes@cmpxchg.org>
References: <20190603210746.15800-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is getting long and unwieldy. The new shrink_node()
handles the generic (node) reclaim aspects:
  - global vmpressure notifications
  - writeback and congestion throttling
  - reclaim/compaction management
  - kswapd giving up on unreclaimable nodes

It then calls shrink_node_memcgs() which handles cgroup specifics:
  - the cgroup tree traversal
  - memory.low considerations
  - per-cgroup slab shrinking callbacks
  - per-cgroup vmpressure notifications

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/vmscan.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index b85111474ee2..ee79b39d0538 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2665,24 +2665,15 @@ static bool pgdat_memcg_congested(pg_data_t *pgdat, struct mem_cgroup *memcg)
 		(memcg && memcg_congested(pgdat, memcg));
 }
 
-static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
+static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 {
-	struct reclaim_state *reclaim_state = current->reclaim_state;
 	struct mem_cgroup *root = sc->target_mem_cgroup;
 	struct mem_cgroup_reclaim_cookie reclaim = {
 		.pgdat = pgdat,
 		.priority = sc->priority,
 	};
-	unsigned long nr_reclaimed, nr_scanned;
-	bool reclaimable = false;
 	struct mem_cgroup *memcg;
 
-again:
-	memset(&sc->nr, 0, sizeof(sc->nr));
-
-	nr_reclaimed = sc->nr_reclaimed;
-	nr_scanned = sc->nr_scanned;
-
 	memcg = mem_cgroup_iter(root, NULL, &reclaim);
 	do {
 		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
@@ -2750,6 +2741,22 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 			break;
 		}
 	} while ((memcg = mem_cgroup_iter(root, memcg, &reclaim)));
+}
+
+static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
+{
+	struct reclaim_state *reclaim_state = current->reclaim_state;
+	struct mem_cgroup *root = sc->target_mem_cgroup;
+	unsigned long nr_reclaimed, nr_scanned;
+	bool reclaimable = false;
+
+again:
+	memset(&sc->nr, 0, sizeof(sc->nr));
+
+	nr_reclaimed = sc->nr_reclaimed;
+	nr_scanned = sc->nr_scanned;
+
+	shrink_node_memcgs(pgdat, sc);
 
 	if (reclaim_state) {
 		sc->nr_reclaimed += reclaim_state->reclaimed_slab;
@@ -2757,7 +2764,7 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	}
 
 	/* Record the subtree's reclaim efficiency */
-	vmpressure(sc->gfp_mask, sc->target_mem_cgroup, true,
+	vmpressure(sc->gfp_mask, root, true,
 		   sc->nr_scanned - nr_scanned,
 		   sc->nr_reclaimed - nr_reclaimed);
 
-- 
2.21.0

