Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262A8C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED24226D64
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="GiZl3I0/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfFCWBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 18:01:22 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46231 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfFCWBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 18:01:21 -0400
Received: by mail-pf1-f196.google.com with SMTP id y11so11352068pfm.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 15:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hW9XEaleHf0fxFzrzaLu3/5nxBFHbI/f8wU4NVTruL4=;
        b=GiZl3I0/1nrhXFLsEYVx8i8I4at3od658KebcT8wvAtJDzTnhyqemuN29q2/fcr3KW
         tDsgy9TzZFg8DTfH/bgCfQ9DMl4vc7J4plUg5mA9cty9aXI8rxvDidvnbUu121RWDy3r
         e1RxDwqqABcmlJXwZaGPTzP0keY1G2zSdow7H3XEkR3F49wcmjR9HuHqyQb5DFvxXdrE
         L+ebT5LxPIX7aGWwOApYSGaixnBATTA3AvWr+WjSjHJsz0lxIbyDxEPuHK3xJkUAPctk
         yP5msqE7q+xLnKa1SZBpeRAnKA5wg+rgZtDOy4sVffJyMyZx1w3RUzvp12AR2PMSm3mf
         jkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hW9XEaleHf0fxFzrzaLu3/5nxBFHbI/f8wU4NVTruL4=;
        b=A5zhMHqZ3cGT01B7iiA0NuW8SnJXU0ciCeCkVdYyrWxHH4/Eo1j93YtG+q4TLWJdf2
         s+knVjjG0/YklY29WuKXRkOtcWW4vReZwYQ4m8iFTSWP7pxQvcBMwTn4uHE/6Rcr/Ez7
         BSHdTBpvL5p4IMqjz800EQCsIy4SViWL8SK87g3F9Dw2ATLn0hiltXWjL0LBwUz0nMvm
         J2g3Xkjud5tpyPqVeJU86FON84eJYG5ZXBN9bco1b1YRpiJjxHVEfhmpTYyGqWQ1usHH
         AVVhJTF9Zo7xfSy7G0hPW21elZwfupq0cjtCAa6Jt7/SLfj0EokmYjnB4JMfWfJ4KGkO
         4zLQ==
X-Gm-Message-State: APjAAAXWdLJsx/DHqWNtpRzr/or46m17j015XVlYBEt/pa3gUpgviQbl
        I9yGOw30tZB6OzP1QU0GtNDDFw==
X-Google-Smtp-Source: APXvYqxRKIe7ZlIxfiZR5KZpvX0iyzwEdC5f5c2JCVHHT7fr7Ha6rZsuX4a/y9QMM1RAzJK5pY+vwA==
X-Received: by 2002:a17:90a:30a1:: with SMTP id h30mr33354770pjb.14.1559596109171;
        Mon, 03 Jun 2019 14:08:29 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:9fa4])
        by smtp.gmail.com with ESMTPSA id p18sm3454267pff.93.2019.06.03.14.08.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 14:08:28 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 03/11] mm: vmscan: simplify lruvec_lru_size()
Date:   Mon,  3 Jun 2019 17:07:38 -0400
Message-Id: <20190603210746.15800-4-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603210746.15800-1-hannes@cmpxchg.org>
References: <20190603210746.15800-1-hannes@cmpxchg.org>
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
 mm/vmscan.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 853be16ee5e2..69c4c82a9b5a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -342,30 +342,21 @@ unsigned long zone_reclaimable_pages(struct zone *zone)
  */
 unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone_idx)
 {
-	unsigned long lru_size;
+	unsigned long size = 0;
 	int zid;
 
-	if (!mem_cgroup_disabled())
-		lru_size = lruvec_page_state_local(lruvec, NR_LRU_BASE + lru);
-	else
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
+	return size;
 
 }
 
-- 
2.21.0

