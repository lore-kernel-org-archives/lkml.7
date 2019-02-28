Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E9DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E74D5218CD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="x12aerec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732875AbfB1Qaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 11:30:52 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33620 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731153AbfB1Qas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 11:30:48 -0500
Received: by mail-yw1-f68.google.com with SMTP id i204so9043162ywb.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 08:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+fTCozRbLMGgETAnd6XOzTuCoFNGxxYSxApGaKudEvQ=;
        b=x12aerecO+G2Qi8DCMF2xSNAdXP6sBfvJQFyXJRVQZzC59w0Li6KJcU2pImtwibxdU
         jf1dSlSsVetoPQrYlc7ADovX4Z9ahMPqkLwaA10S6bLaHVLA0w9hGYX7L83qslBlCUmp
         yQyO2YHvfGJbtpNNJp4Jt1rHJvl3Pr7QmtLNylzcYOSY+44ehQkUBWAdlWVslNo6ftDg
         LJM1d+pyrMy9ErHzmV1drh8f3anJphXWFWrNeCPNNAOiRhhiNIVgIEMRO0MCXqL/o+wv
         tTccoxWk0I9ROwOYBJAZIuuupIO4nyL1sRD41Cfz+2izzbY8daIyH18gtRXknFFHxHoI
         6Gpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+fTCozRbLMGgETAnd6XOzTuCoFNGxxYSxApGaKudEvQ=;
        b=h3s4ciSDuC/O1qsJpGom2aAybDKgg8Hmtl6veF/oZ/kGWC9yRV8k8l6lH1AxEXNg2R
         5unxmoUoc/E0zj1BIfp60FhkEQ/eNUwHkwrjc7YahwwFZ6WK9DDtVFjmlx0DrXhhQBIz
         B5gPSZGhaUA5YfjhAPB6q0nkoQ33zpjAL12meY8MvElOchGGQummH5ZjVaIsFfT/v6cl
         PspkEgFimnvTkvpGV9dnESCnbpk/OUFPrLK5EEEKPz4mUMOqN4ClfvTCj3v7qQcS5Zz7
         nMKVLW2/6unmgojFZ5y/EFoty+HatlOFIskSm6RFK3tGIwY3AjD0RkVGi2UgPhUlv5Uq
         bn9w==
X-Gm-Message-State: AHQUAuZ1WklC1lu7tBCy7AC5McauEw3kUcu4/FDQbRySQblljyWtVESB
        BUoUl5PhBS0Q524YromPtJ3yZg==
X-Google-Smtp-Source: AHgI3IbZrnHxcUzT2L+UlPG1PKqQVD2XJnyr/V/FAeHt3brx1OJMu+HCyA0UNInzg65K9j7PHaJQ2Q==
X-Received: by 2002:a0d:d3c3:: with SMTP id v186mr6413209ywd.15.1551371446919;
        Thu, 28 Feb 2019 08:30:46 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::3:da64])
        by smtp.gmail.com with ESMTPSA id e21sm1132279ywe.77.2019.02.28.08.30.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 08:30:46 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/6] mm: memcontrol: push down mem_cgroup_node_nr_lru_pages()
Date:   Thu, 28 Feb 2019 11:30:18 -0500
Message-Id: <20190228163020.24100-5-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190228163020.24100-1-hannes@cmpxchg.org>
References: <20190228163020.24100-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mem_cgroup_node_nr_lru_pages() is just a convenience wrapper around
lruvec_page_state() that takes bitmasks of lru indexes and aggregates
the counts for those.

Replace callsites where the bitmask is simple enough with direct
lruvec_page_state() calls.

This removes the last extern user of mem_cgroup_node_nr_lru_pages(),
so make that function private again, too.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/memcontrol.h | 10 ----------
 mm/memcontrol.c            | 10 +++++++---
 mm/workingset.c            |  5 +++--
 3 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 5050d281f67d..57029eefd225 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -514,9 +514,6 @@ int mem_cgroup_select_victim_node(struct mem_cgroup *memcg);
 void mem_cgroup_update_lru_size(struct lruvec *lruvec, enum lru_list lru,
 		int zid, int nr_pages);
 
-unsigned long mem_cgroup_node_nr_lru_pages(struct mem_cgroup *memcg,
-					   int nid, unsigned int lru_mask);
-
 static inline
 unsigned long mem_cgroup_get_zone_lru_size(struct lruvec *lruvec,
 		enum lru_list lru, int zone_idx)
@@ -979,13 +976,6 @@ unsigned long mem_cgroup_get_zone_lru_size(struct lruvec *lruvec,
 	return 0;
 }
 
-static inline unsigned long
-mem_cgroup_node_nr_lru_pages(struct mem_cgroup *memcg,
-			     int nid, unsigned int lru_mask)
-{
-	return 0;
-}
-
 static inline unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg)
 {
 	return 0;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e702b67cde41..ad6214b3d20b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -725,7 +725,7 @@ static void mem_cgroup_charge_statistics(struct mem_cgroup *memcg,
 	__this_cpu_add(memcg->vmstats_percpu->nr_page_events, nr_pages);
 }
 
-unsigned long mem_cgroup_node_nr_lru_pages(struct mem_cgroup *memcg,
+static unsigned long mem_cgroup_node_nr_lru_pages(struct mem_cgroup *memcg,
 					   int nid, unsigned int lru_mask)
 {
 	struct lruvec *lruvec = mem_cgroup_lruvec(NODE_DATA(nid), memcg);
@@ -1430,11 +1430,15 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
 static bool test_mem_cgroup_node_reclaimable(struct mem_cgroup *memcg,
 		int nid, bool noswap)
 {
-	if (mem_cgroup_node_nr_lru_pages(memcg, nid, LRU_ALL_FILE))
+	struct lruvec *lruvec = mem_cgroup_lruvec(NODE_DATA(nid), memcg);
+
+	if (lruvec_page_state(lruvec, NR_INACTIVE_FILE) ||
+	    lruvec_page_state(lruvec, NR_ACTIVE_FILE))
 		return true;
 	if (noswap || !total_swap_pages)
 		return false;
-	if (mem_cgroup_node_nr_lru_pages(memcg, nid, LRU_ALL_ANON))
+	if (lruvec_page_state(lruvec, NR_INACTIVE_ANON) ||
+	    lruvec_page_state(lruvec, NR_ACTIVE_ANON))
 		return true;
 	return false;
 
diff --git a/mm/workingset.c b/mm/workingset.c
index dcb994f2acc2..dbc333a21254 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -427,10 +427,11 @@ static unsigned long count_shadow_nodes(struct shrinker *shrinker,
 #ifdef CONFIG_MEMCG
 	if (sc->memcg) {
 		struct lruvec *lruvec;
+		int i;
 
-		pages = mem_cgroup_node_nr_lru_pages(sc->memcg, sc->nid,
-						     LRU_ALL);
 		lruvec = mem_cgroup_lruvec(NODE_DATA(sc->nid), sc->memcg);
+		for (pages = 0, i = 0; i < NR_LRU_LISTS; i++)
+			pages += lruvec_page_state(lruvec, NR_LRU_BASE + i);
 		pages += lruvec_page_state(lruvec, NR_SLAB_RECLAIMABLE);
 		pages += lruvec_page_state(lruvec, NR_SLAB_UNRECLAIMABLE);
 	} else
-- 
2.20.1

