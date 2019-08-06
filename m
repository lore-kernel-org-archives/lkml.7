Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437EFC32751
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156CF20717
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLHNTNtd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732801AbfHFPRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 11:17:10 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34238 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfHFPRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 11:17:09 -0400
Received: by mail-pf1-f194.google.com with SMTP id b13so41676616pfo.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 08:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lXgJn1gEuR2HESTa1ndelxSYh8xdRTY96+2aKnOkV4E=;
        b=WLHNTNtdvYZnGps9OKP2aN43a4ST6cZGZOzKvDY82EUdEZiXShDnHzLjPviIjHaCQq
         j/zAqk7SmwONd+9FeIAM1eASQE0RKO8jBTjCHCeI5eKmP1drc2JM6+2/QsZhH/3ctL6v
         oV8pwoqflV4QZpiaqoxtny/FIkf75tD1dFH/kTUOwee9YF4NWA7xakHdG15RhFesxO6L
         zQ5magnirFxDDxBr+jnRfQSGWVJYJryBbQP9MY9XcVBFLZU6rLAbCDUYAUDb7u2fRU1g
         U372AsWFP1bA+PfiXCCQ2hxhp80+oxjwt3M1Y1IhcwKMyZOqlLizz7jK06Aw7RzBTmH0
         fXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lXgJn1gEuR2HESTa1ndelxSYh8xdRTY96+2aKnOkV4E=;
        b=jePiULIBSGtZLW1mwbXgFYvvv6vDxbgyRtGR6o8oFNYGhhhuEC27j0MY8fhI38QBd/
         /yEE2jA2PpiDQSWT9C03suYNa1FOUR0XSkv37Cj/3paR3C3XYJhndkmOYGX/8dk8jjZF
         lClHNpZjENtkh4umz/kT7Ci87L0S3uzmEW3B3RYfpvOGw/AHiqUgxHCaHXP1MTg2WkNH
         WTqD2BcSZt9OVKJgT6ocDsWkwiP7u0rbj2FYQYS5+aJEVGjfZU5anWtPi1m52uvgz3MH
         9bN8v5Lh/DDXGhC5nN8ccKKvvlg6f/wbwY82HHS9AjNyyGEHTHT0s2ilhtkiewmQZXuM
         Hwaw==
X-Gm-Message-State: APjAAAXieoSZLnkhiWNM6lf8lKyZWz9J24eqbG+VQtCQu2XlIAZghO1/
        xwwIUZFtB9MGcyRcVTF+kvI=
X-Google-Smtp-Source: APXvYqz6qPpUBClfeUoDRXj64wGcHBWfUs13obdwHRyXXmB71VN2YMQAJUzpw1nU1ef6aAc/KNytfg==
X-Received: by 2002:a17:90a:b011:: with SMTP id x17mr3765254pjq.113.1565104629076;
        Tue, 06 Aug 2019 08:17:09 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:4c4:b8c3:8577:bf2f:2])
        by smtp.gmail.com with ESMTPSA id b14sm22500814pga.20.2019.08.06.08.17.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 08:17:08 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, vbabka@suse.cz, cai@lca.pw,
        aryabinin@virtuozzo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH] mm/compaction: remove unnecessary zone parameter in isolate_migratepages()
Date:   Tue,  6 Aug 2019 23:16:16 +0800
Message-Id: <20190806151616.21107-1-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like commit 40cacbcb3240 ("mm, compaction: remove unnecessary zone
parameter in some instances"), remove unnecessary zone parameter.

No functional change.

Signed-off-by: Pengfei Li <lpf.vector@gmail.com>
---
 mm/compaction.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 952dc2fb24e5..685c3e3d0a0f 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1737,8 +1737,7 @@ static unsigned long fast_find_migrateblock(struct compact_control *cc)
  * starting at the block pointed to by the migrate scanner pfn within
  * compact_control.
  */
-static isolate_migrate_t isolate_migratepages(struct zone *zone,
-					struct compact_control *cc)
+static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
 {
 	unsigned long block_start_pfn;
 	unsigned long block_end_pfn;
@@ -1756,8 +1755,8 @@ static isolate_migrate_t isolate_migratepages(struct zone *zone,
 	 */
 	low_pfn = fast_find_migrateblock(cc);
 	block_start_pfn = pageblock_start_pfn(low_pfn);
-	if (block_start_pfn < zone->zone_start_pfn)
-		block_start_pfn = zone->zone_start_pfn;
+	if (block_start_pfn < cc->zone->zone_start_pfn)
+		block_start_pfn = cc->zone->zone_start_pfn;
 
 	/*
 	 * fast_find_migrateblock marks a pageblock skipped so to avoid
@@ -1787,8 +1786,8 @@ static isolate_migrate_t isolate_migratepages(struct zone *zone,
 		if (!(low_pfn % (SWAP_CLUSTER_MAX * pageblock_nr_pages)))
 			cond_resched();
 
-		page = pageblock_pfn_to_page(block_start_pfn, block_end_pfn,
-									zone);
+		page = pageblock_pfn_to_page(block_start_pfn,
+						block_end_pfn, cc->zone);
 		if (!page)
 			continue;
 
@@ -2158,7 +2157,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 			cc->rescan = true;
 		}
 
-		switch (isolate_migratepages(cc->zone, cc)) {
+		switch (isolate_migratepages(cc)) {
 		case ISOLATE_ABORT:
 			ret = COMPACT_CONTENDED;
 			putback_movable_pages(&cc->migratepages);
-- 
2.21.0

