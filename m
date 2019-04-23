Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EA2C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC872177B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbfDWMHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 08:07:44 -0400
Received: from relay.sw.ru ([185.231.240.75]:56342 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfDWMHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 08:07:44 -0400
Received: from [172.16.25.12] (helo=i7.sw.ru)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1hIuD5-0000jI-Hi; Tue, 23 Apr 2019 15:07:39 +0300
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: [PATCH 1/2] mm/page_alloc: avoid potential NULL pointer dereference
Date:   Tue, 23 Apr 2019 15:08:05 +0300
Message-Id: <20190423120806.3503-1-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ac.preferred_zoneref->zone passed to alloc_flags_nofragment() can be NULL.
'zone' pointer unconditionally derefernced in alloc_flags_nofragment().
Bail out on NULL zone to avoid potential crash.
Currently we don't see any crashes only because alloc_flags_nofragment()
has another bug which allows compiler to optimize away all accesses to
'zone'.

Fixes: 6bb154504f8b ("mm, page_alloc: spread allocations across zones before introducing fragmentation")
Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
 mm/page_alloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 933bd42899e8..2b2c7065102f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3461,6 +3461,9 @@ alloc_flags_nofragment(struct zone *zone, gfp_t gfp_mask)
 		alloc_flags |= ALLOC_KSWAPD;
 
 #ifdef CONFIG_ZONE_DMA32
+	if (!zone)
+		return alloc_flags;
+
 	if (zone_idx(zone) != ZONE_NORMAL)
 		goto out;
 
-- 
2.21.0

