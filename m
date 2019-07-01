Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E89CC5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 20:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412582089C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 20:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yzh8zXOg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfGAUTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 16:19:07 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:39560 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbfGAUTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 16:19:06 -0400
Received: by mail-qk1-f201.google.com with SMTP id j17so6999852qki.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 13:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=84Sypx6YzXutjLG+Fp6OjQQKLXcewv+p2Q4pHRZlwKQ=;
        b=Yzh8zXOgoTh4Y2y35gsVwjBlsL0iq7DO4vxOPQH8K09FIwWF1jnMchYv0r6j0H16s4
         9wtvapiUeosaEMHNaL1sM7Ov6Lug0M0DjBlcmMF/mn0LaA1Nu7fzpWkocnqhJBkt5wKt
         Fdwxgvm85Q+v9kZVG3P3Ou1Px01nTkz1bZiM4abTqk2sOB8ME6qGyDaJv3qGBKS7SWjQ
         L0GX29PtLl0HdCaJcZFWFpQe5HkVYOtt5x3/rLhidAqnuCCfMUvY8r7vbyw7+4qpHHLs
         4GfgA2yeS3jNMRVTDBMrtLj65GE+eQB7PgKncqI9WzyCiWJlTCl3spVU8NU7GQqWqQI6
         lLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=84Sypx6YzXutjLG+Fp6OjQQKLXcewv+p2Q4pHRZlwKQ=;
        b=iSclEreiePmL4G6UT52WNTj7bMWfJGMgV+3P5RShp+yu2MO85FMIi+nE4CwsKxGKm8
         8xSXLhNb420+JCN2OuUVMGN2Y+Z67+gzKBxEd1y2mDBE2LQmI6ZzfsHCsy9N9xB8cTQL
         ruqEAw5Qol38fEXkrJ1uPn1caL2QYZHMM+WRYDcV3Y3l7IVUT83G6C0HAVIz90B1IPgV
         UiS6i2AH0QUXxCKVs+qjiZVFaUBlJBDIweV+7wOi4Ws/bs4bDoy0MJXgbsRQSsQPTltj
         /pxbzHWJYY8hc34HyJdMGEhFuJfoHaKelEF3UcNBNW+DghcGqr3PsRONhcz+9n1kQ6YI
         KHPA==
X-Gm-Message-State: APjAAAUSdle44iRxglWf6U0gQelBgCPgSrOtnKy2P11aRy28oGZIHaNl
        LVEsDoxE+HG8bpbYDODqnf3i20dxEf62/A==
X-Google-Smtp-Source: APXvYqxgkZaZJswmwq58VQ35alxZ0OR3QeVTdZvsFMBJgWz22qUGoVuP+TUM22fz60QpBxL4jOzsYZ+Z4XRRHw==
X-Received: by 2002:a0c:9895:: with SMTP id f21mr22633081qvd.123.1562012345435;
 Mon, 01 Jul 2019 13:19:05 -0700 (PDT)
Date:   Mon,  1 Jul 2019 13:18:47 -0700
Message-Id: <20190701201847.251028-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v2] mm, vmscan: prevent useless kswapd loops
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hillf Danton <hdanton@sina.com>, Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On production we have noticed hard lockups on large machines running
large jobs due to kswaps hoarding lru lock within isolate_lru_pages when
sc->reclaim_idx is 0 which is a small zone. The lru was couple hundred
GiBs and the condition (page_zonenum(page) > sc->reclaim_idx) in
isolate_lru_pages was basically skipping GiBs of pages while holding the
LRU spinlock with interrupt disabled.

On further inspection, it seems like there are two issues:

1) If the kswapd on the return from balance_pgdat() could not sleep
(i.e. node is still unbalanced), the classzone_idx is unintentionally
set to 0  and the whole reclaim cycle of kswapd will try to reclaim
only the lowest and smallest zone while traversing the whole memory.

2) Fundamentally isolate_lru_pages() is really bad when the allocation
has woken kswapd for a smaller zone on a very large machine running very
large jobs. It can hoard the LRU spinlock while skipping over 100s of
GiBs of pages.

This patch only fixes the (1). The (2) needs a more fundamental solution.
To fix (1), in the kswapd context, if pgdat->kswapd_classzone_idx is
invalid use the classzone_idx of the previous kswapd loop otherwise use
the one the waker has requested.

Fixes: e716f2eb24de ("mm, vmscan: prevent kswapd sleeping prematurely
due to mismatched classzone_idx")

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
Changelog since v1:
- fixed the patch based on Yang Shi's comment.

 mm/vmscan.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9e3292ee5c7c..eacf87f07afe 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3760,19 +3760,18 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int classzone_idx)
 }
 
 /*
- * pgdat->kswapd_classzone_idx is the highest zone index that a recent
- * allocation request woke kswapd for. When kswapd has not woken recently,
- * the value is MAX_NR_ZONES which is not a valid index. This compares a
- * given classzone and returns it or the highest classzone index kswapd
- * was recently woke for.
+ * The pgdat->kswapd_classzone_idx is used to pass the highest zone index to be
+ * reclaimed by kswapd from the waker. If the value is MAX_NR_ZONES which is not
+ * a valid index then either kswapd runs for first time or kswapd couldn't sleep
+ * after previous reclaim attempt (node is still unbalanced). In that case
+ * return the zone index of the previous kswapd reclaim cycle.
  */
 static enum zone_type kswapd_classzone_idx(pg_data_t *pgdat,
-					   enum zone_type classzone_idx)
+					   enum zone_type prev_classzone_idx)
 {
 	if (pgdat->kswapd_classzone_idx == MAX_NR_ZONES)
-		return classzone_idx;
-
-	return max(pgdat->kswapd_classzone_idx, classzone_idx);
+		return prev_classzone_idx;
+	return pgdat->kswapd_classzone_idx;
 }
 
 static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_order,
@@ -3908,7 +3907,7 @@ static int kswapd(void *p)
 
 		/* Read the new order and classzone_idx */
 		alloc_order = reclaim_order = pgdat->kswapd_order;
-		classzone_idx = kswapd_classzone_idx(pgdat, 0);
+		classzone_idx = kswapd_classzone_idx(pgdat, classzone_idx);
 		pgdat->kswapd_order = 0;
 		pgdat->kswapd_classzone_idx = MAX_NR_ZONES;
 
@@ -3961,8 +3960,12 @@ void wakeup_kswapd(struct zone *zone, gfp_t gfp_flags, int order,
 	if (!cpuset_zone_allowed(zone, gfp_flags))
 		return;
 	pgdat = zone->zone_pgdat;
-	pgdat->kswapd_classzone_idx = kswapd_classzone_idx(pgdat,
-							   classzone_idx);
+
+	if (pgdat->kswapd_classzone_idx == MAX_NR_ZONES)
+		pgdat->kswapd_classzone_idx = classzone_idx;
+	else
+		pgdat->kswapd_classzone_idx = max(pgdat->kswapd_classzone_idx,
+						  classzone_idx);
 	pgdat->kswapd_order = max(pgdat->kswapd_order, order);
 	if (!waitqueue_active(&pgdat->kswapd_wait))
 		return;
-- 
2.22.0.410.gd8fdbe21b5-goog

