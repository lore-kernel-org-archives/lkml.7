Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8963EC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51CD920850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="dhjIGj9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfDLOom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:44:42 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38745 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfDLOol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 10:44:41 -0400
Received: by mail-qt1-f194.google.com with SMTP id d13so11507916qth.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 07:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TpJORoHWMkN029iMtW7/72pORwZc7P01cwdjOx9UylM=;
        b=dhjIGj9GhnlUIw42QmSp6MHvSVLlCu6/A72GkymhOJ1S3wjd/dN17urp2QV0SAlwlo
         AwQwr86bgAy87FPEIYjdQBUK90nHPVdms2Gsk6G7qUOKpg5wj/jo9lb46sDapoIRzvwy
         T3V0zNZJl4I74l4wDv0wZicEmFF35/pHAAqUhE8cCGRCM/IZMlaAdCcZyhksBfUb6m1q
         c0JUuQBx88GqBraoMu0W8Ps11nbd9Wce4xNlJ+8FLUc0fIDBcEc3ZXGBcfboAbIzE/R/
         bOizgsBKHYr3nkBRJj6gTO+8CbjiYSwUGajlKPLOdBLIoJF5An0UZdvQyj+G1meD2gI6
         2bwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TpJORoHWMkN029iMtW7/72pORwZc7P01cwdjOx9UylM=;
        b=m/4RH/TdIuS0+kkvkII4vrquQ8wd+lLPE+J9LMK4jxuPOY8VeE78xvc2BuWkgVhFUs
         20LF1ufD9Vhz6Inv6Lofi2/gwGa+AfRaaIOXX61xvm86ydhkzypHlmdoNxFaaSnRMdRd
         EHSV0dEqAvC+sLl9uQW16Ci3sSzImN+Zrudy8QbDf2Gj/pxjYDz/GFiTPfBP86rPyqZl
         7qnkEKuQZGWazGJCQ3PkldwcQ5wFJ6pIGxFBJAXVJznrulETLWftjYfwuwPfWJT8MYxk
         bvRbIPCNsb2oXGG52uw0fsHWFEPqUi4XsasJt24iNM4awIGQoT5Mu9v+i2MGErK5ZMB9
         lojA==
X-Gm-Message-State: APjAAAURbzGUflmEHxkJ4TBMvOQiDsrGPn/Hvu7Yg+mULgiKI3T8Rgo5
        fOgt5pC1NqCHAyhZ+ztmoAkyIw==
X-Google-Smtp-Source: APXvYqy/JiV+mpq/lmqwaiYygCKW/w5T4iyoMKlKxGVcJ2MxHcoeWNRNkraAqnesgfBoBPLaRH1TUg==
X-Received: by 2002:a0c:b050:: with SMTP id l16mr46942814qvc.82.1555080280635;
        Fri, 12 Apr 2019 07:44:40 -0700 (PDT)
Received: from localhost (pool-108-27-252-85.nycmny.fios.verizon.net. [108.27.252.85])
        by smtp.gmail.com with ESMTPSA id r31sm24841599qtj.17.2019.04.12.07.44.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 07:44:39 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] mm: fix inactive list balancing between NUMA nodes and cgroups
Date:   Fri, 12 Apr 2019 10:44:38 -0400
Message-Id: <20190412144438.2645-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During !CONFIG_CGROUP reclaim, we expand the inactive list size if
it's thrashing on the node that is about to be reclaimed. But when
cgroups are enabled, we suddenly ignore the node scope and use the
cgroup scope only. The result is that pressure bleeds between NUMA
nodes depending on whether cgroups are merely compiled into Linux.
This behavioral difference is unexpected and undesirable.

When the refault adaptivity of the inactive list was first introduced,
there were no statistics at the lruvec level - the intersection of
node and memcg - so it was better than nothing.

But now that we have that infrastructure, use lruvec_page_state() to
make the list balancing decision always NUMA aware.

Fixes: 2a2e48854d70 ("mm: vmscan: fix IO/refault regression in cache workingset transition")
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/vmscan.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 347c9b3b29ac..c9f8afe61ae3 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2138,7 +2138,6 @@ static void shrink_active_list(unsigned long nr_to_scan,
  *   10TB     320        32GB
  */
 static bool inactive_list_is_low(struct lruvec *lruvec, bool file,
-				 struct mem_cgroup *memcg,
 				 struct scan_control *sc, bool actual_reclaim)
 {
 	enum lru_list active_lru = file * LRU_FILE + LRU_ACTIVE;
@@ -2159,16 +2158,12 @@ static bool inactive_list_is_low(struct lruvec *lruvec, bool file,
 	inactive = lruvec_lru_size(lruvec, inactive_lru, sc->reclaim_idx);
 	active = lruvec_lru_size(lruvec, active_lru, sc->reclaim_idx);
 
-	if (memcg)
-		refaults = memcg_page_state(memcg, WORKINGSET_ACTIVATE);
-	else
-		refaults = node_page_state(pgdat, WORKINGSET_ACTIVATE);
-
 	/*
 	 * When refaults are being observed, it means a new workingset
 	 * is being established. Disable active list protection to get
 	 * rid of the stale workingset quickly.
 	 */
+	refaults = lruvec_page_state(lruvec, WORKINGSET_ACTIVATE);
 	if (file && actual_reclaim && lruvec->refaults != refaults) {
 		inactive_ratio = 0;
 	} else {
@@ -2189,12 +2184,10 @@ static bool inactive_list_is_low(struct lruvec *lruvec, bool file,
 }
 
 static unsigned long shrink_list(enum lru_list lru, unsigned long nr_to_scan,
-				 struct lruvec *lruvec, struct mem_cgroup *memcg,
-				 struct scan_control *sc)
+				 struct lruvec *lruvec, struct scan_control *sc)
 {
 	if (is_active_lru(lru)) {
-		if (inactive_list_is_low(lruvec, is_file_lru(lru),
-					 memcg, sc, true))
+		if (inactive_list_is_low(lruvec, is_file_lru(lru), sc, true))
 			shrink_active_list(nr_to_scan, lruvec, sc, lru);
 		return 0;
 	}
@@ -2293,7 +2286,7 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
 			 * anonymous pages on the LRU in eligible zones.
 			 * Otherwise, the small LRU gets thrashed.
 			 */
-			if (!inactive_list_is_low(lruvec, false, memcg, sc, false) &&
+			if (!inactive_list_is_low(lruvec, false, sc, false) &&
 			    lruvec_lru_size(lruvec, LRU_INACTIVE_ANON, sc->reclaim_idx)
 					>> sc->priority) {
 				scan_balance = SCAN_ANON;
@@ -2311,7 +2304,7 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
 	 * lruvec even if it has plenty of old anonymous pages unless the
 	 * system is under heavy pressure.
 	 */
-	if (!inactive_list_is_low(lruvec, true, memcg, sc, false) &&
+	if (!inactive_list_is_low(lruvec, true, sc, false) &&
 	    lruvec_lru_size(lruvec, LRU_INACTIVE_FILE, sc->reclaim_idx) >> sc->priority) {
 		scan_balance = SCAN_FILE;
 		goto out;
@@ -2515,7 +2508,7 @@ static void shrink_node_memcg(struct pglist_data *pgdat, struct mem_cgroup *memc
 				nr[lru] -= nr_to_scan;
 
 				nr_reclaimed += shrink_list(lru, nr_to_scan,
-							    lruvec, memcg, sc);
+							    lruvec, sc);
 			}
 		}
 
@@ -2582,7 +2575,7 @@ static void shrink_node_memcg(struct pglist_data *pgdat, struct mem_cgroup *memc
 	 * Even if we did not try to evict anon pages at all, we want to
 	 * rebalance the anon lru active/inactive ratio.
 	 */
-	if (inactive_list_is_low(lruvec, false, memcg, sc, true))
+	if (inactive_list_is_low(lruvec, false, sc, true))
 		shrink_active_list(SWAP_CLUSTER_MAX, lruvec,
 				   sc, LRU_ACTIVE_ANON);
 }
@@ -2985,12 +2978,8 @@ static void snapshot_refaults(struct mem_cgroup *root_memcg, pg_data_t *pgdat)
 		unsigned long refaults;
 		struct lruvec *lruvec;
 
-		if (memcg)
-			refaults = memcg_page_state(memcg, WORKINGSET_ACTIVATE);
-		else
-			refaults = node_page_state(pgdat, WORKINGSET_ACTIVATE);
-
 		lruvec = mem_cgroup_lruvec(pgdat, memcg);
+		refaults = lruvec_page_state_local(lruvec, WORKINGSET_ACTIVATE);
 		lruvec->refaults = refaults;
 	} while ((memcg = mem_cgroup_iter(root_memcg, memcg, NULL)));
 }
@@ -3346,7 +3335,7 @@ static void age_active_anon(struct pglist_data *pgdat,
 	do {
 		struct lruvec *lruvec = mem_cgroup_lruvec(pgdat, memcg);
 
-		if (inactive_list_is_low(lruvec, false, memcg, sc, true))
+		if (inactive_list_is_low(lruvec, false, sc, true))
 			shrink_active_list(SWAP_CLUSTER_MAX, lruvec,
 					   sc, LRU_ACTIVE_ANON);
 
-- 
2.21.0

