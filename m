Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A8EC43215
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 04:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A032220659
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 04:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfLDErl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 23:47:41 -0500
Received: from lgeamrelo11.lge.com ([156.147.23.51]:60500 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbfLDErl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 23:47:41 -0500
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.51 with ESMTP; 4 Dec 2019 13:47:39 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: chanho.min@lge.com
Received: from unknown (HELO localhost.localdomain) (10.178.31.96)
        by 156.147.1.126 with ESMTP; 4 Dec 2019 13:47:38 +0900
X-Original-SENDERIP: 10.178.31.96
X-Original-MAILFROM: chanho.min@lge.com
From:   Chanho Min <chanho.min@lge.com>
To:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        seungho1.park@lge.com, Inkyu Hwang <inkyu.hwang@lge.com>,
        Jinsuk Choi <jjinsuk.choi@lge.com>, stable@vger.kernel.org,
        Chanho Min <chanho.min@lge.com>
Subject: [PATCH RESEND] mm/zsmalloc.c: fix the migrated zspage statistics.
Date:   Wed,  4 Dec 2019 13:47:21 +0900
Message-Id: <1575434841-48009-1-git-send-email-chanho.min@lge.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When zspage is migrated to the other zone, the zone page state should
be updated as well, otherwise the NR_ZSPAGE for each zone shows wrong
counts including proc/zoneinfo in practice.

Cc: <stable@vger.kernel.org>        [4.9+]
Fixes: 91537fee0013 ("mm: add NR_ZSMALLOC to vmstat")
Signed-off-by: Chanho Min <chanho.min@lge.com>
Signed-off-by: Jinsuk Choi <jjinsuk.choi@lge.com>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Acked-by: Minchan Kim <minchan@kernel.org>
---
 mm/zsmalloc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 2b2b9aa..22d17ec 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -2069,6 +2069,11 @@ static int zs_page_migrate(struct address_space *mapping, struct page *newpage,
 		zs_pool_dec_isolated(pool);
 	}
 
+	if (page_zone(newpage) != page_zone(page)) {
+		dec_zone_page_state(page, NR_ZSPAGES);
+		inc_zone_page_state(newpage, NR_ZSPAGES);
+	}
+
 	reset_page(page);
 	put_page(page);
 	page = newpage;
-- 
2.7.4

