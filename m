Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8973DCA9EBA
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 14:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1B121783
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 14:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="po3EgEl1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387831AbfJVOsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 10:48:16 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39744 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732056AbfJVOsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 10:48:16 -0400
Received: by mail-qt1-f195.google.com with SMTP id t8so9603812qtc.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 07:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iFBKqmL/4fnTvQgxpmecsW4xlCLftKHwTd8yhraPD9Y=;
        b=po3EgEl1Mfcj8YgbJhdpnDMRmpW8tzAaBeWPxhTAU12MmtccZL11JGUkwiGCxgb3xA
         QjdEo7R/vlHoX3wx55XWp85atLxaGk+SyRuTtJRtL93CNS+tRpuJrui+/9PKaa7yN3ii
         JLNR+sQ8cffNhgL+fm6oIOASPG2kRusL/cs1itJ4EqXdId40uJ9ocUAIThgUAPxylvbj
         MObUpe5nqGUYyuW0YRa7+wCtibgztGJg5dkHeW5ZpttdFZ1zN86nHgyeiLiVBtPJvEU2
         rNzOnZd29An6Kf7sEkGGYMYqrq9BBDH/jts3v2801jiVF9o7199dTnfCZ1scCLknemwz
         ViqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iFBKqmL/4fnTvQgxpmecsW4xlCLftKHwTd8yhraPD9Y=;
        b=IKYjWvHQYNoZeIkbnf71uCsIWlJsn7EEfYmlOuRVvVtYJZhT17dSducyUD4/VSQF5Y
         FirTGAPUNJ8tww/jrBis/IAd1EPwjugttZFrtALfEM4SpZvY9isuPUSIviinYi+bSZny
         zwBpIgWTVL8NmLI7g805WO9sN6uW/S2oayH5XyL0/KUyRE4pYc6231hUO1a7Mp0m8JqL
         6BGIA8dW3J9PnpMvVQS+r3osDRAcS7zjbwWdkEJdIRL3kkA2MrgD8JWc0gKu6omLCHo+
         R6/iBRqpMzZYwk7/hhdn7m9/kLZk1YcKFbjZKX1m2wwFmKsuYTpcfEr/zV+LQzKog0hC
         i/lQ==
X-Gm-Message-State: APjAAAXRP8boFIIHmnJuE4L0HVNm5RqtnCdhcU4f6+CmoO+p7xuLzGNb
        d4xYzwOd93andWYvxyO01gh7vQ==
X-Google-Smtp-Source: APXvYqy986Sb7waIgJjeFtAwugsVpL846YOA+EY68E+Fbe+rKmh3XrhkBV/xTbPGtzHtIcBkSwwq1w==
X-Received: by 2002:ac8:29a5:: with SMTP id 34mr3679282qts.56.1571755694979;
        Tue, 22 Oct 2019 07:48:14 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:10ad])
        by smtp.gmail.com with ESMTPSA id m186sm9298409qkd.119.2019.10.22.07.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 07:48:14 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 1/8] mm: vmscan: simplify lruvec_lru_size()
Date:   Tue, 22 Oct 2019 10:47:56 -0400
Message-Id: <20191022144803.302233-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191022144803.302233-1-hannes@cmpxchg.org>
References: <20191022144803.302233-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function currently takes the node or lruvec size and subtracts
the zones that are excluded by the classzone index of the
allocation. It uses four different types of counters to do this.

Just add up the eligible zones.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/vmscan.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 1154b3a2b637..57f533b808f2 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -351,32 +351,21 @@ unsigned long zone_reclaimable_pages(struct zone *zone)
  */
 unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone_idx)
 {
-	unsigned long lru_size = 0;
+	unsigned long size = 0;
 	int zid;
 
-	if (!mem_cgroup_disabled()) {
-		for (zid = 0; zid < MAX_NR_ZONES; zid++)
-			lru_size += mem_cgroup_get_zone_lru_size(lruvec, lru, zid);
-	} else
-		lru_size = node_page_state(lruvec_pgdat(lruvec), NR_LRU_BASE + lru);
-
-	for (zid = zone_idx + 1; zid < MAX_NR_ZONES; zid++) {
+	for (zid = 0; zid <= zone_idx; zid++) {
 		struct zone *zone = &lruvec_pgdat(lruvec)->node_zones[zid];
-		unsigned long size;
 
 		if (!managed_zone(zone))
 			continue;
 
 		if (!mem_cgroup_disabled())
-			size = mem_cgroup_get_zone_lru_size(lruvec, lru, zid);
+			size += mem_cgroup_get_zone_lru_size(lruvec, lru, zid);
 		else
-			size = zone_page_state(&lruvec_pgdat(lruvec)->node_zones[zid],
-				       NR_ZONE_LRU_BASE + lru);
-		lru_size -= min(size, lru_size);
+			size += zone_page_state(zone, NR_ZONE_LRU_BASE + lru);
 	}
-
-	return lru_size;
-
+	return size;
 }
 
 /*
-- 
2.23.0

