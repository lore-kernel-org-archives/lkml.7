Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4783DC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E8821738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfDWMHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 08:07:45 -0400
Received: from relay.sw.ru ([185.231.240.75]:56344 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727649AbfDWMHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 08:07:44 -0400
Received: from [172.16.25.12] (helo=i7.sw.ru)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1hIuD5-0000jI-Pt; Tue, 23 Apr 2019 15:07:39 +0300
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: [PATCH 2/2] mm/page_alloc: fix never set ALLOC_NOFRAGMENT flag
Date:   Tue, 23 Apr 2019 15:08:06 +0300
Message-Id: <20190423120806.3503-2-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190423120806.3503-1-aryabinin@virtuozzo.com>
References: <20190423120806.3503-1-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0a79cdad5eb2 ("mm: use alloc_flags to record if kswapd can wake")
removed setting of the ALLOC_NOFRAGMENT flag. Bring it back.

Fixes: 0a79cdad5eb2 ("mm: use alloc_flags to record if kswapd can wake")
Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
 mm/page_alloc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2b2c7065102f..a85b8252c5ad 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3465,7 +3465,7 @@ alloc_flags_nofragment(struct zone *zone, gfp_t gfp_mask)
 		return alloc_flags;
 
 	if (zone_idx(zone) != ZONE_NORMAL)
-		goto out;
+		return alloc_flags;
 
 	/*
 	 * If ZONE_DMA32 exists, assume it is the one after ZONE_NORMAL and
@@ -3474,9 +3474,9 @@ alloc_flags_nofragment(struct zone *zone, gfp_t gfp_mask)
 	 */
 	BUILD_BUG_ON(ZONE_NORMAL - ZONE_DMA32 != 1);
 	if (nr_online_nodes > 1 && !populated_zone(--zone))
-		goto out;
+		return alloc_flags;
 
-out:
+	alloc_flags |= ALLOC_NOFRAGMENT;
 #endif /* CONFIG_ZONE_DMA32 */
 	return alloc_flags;
 }
-- 
2.21.0

