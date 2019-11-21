Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28DDC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD4820692
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfKUPVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 10:21:16 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:40119 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfKUPVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:21:16 -0500
X-Originating-IP: 153.3.140.100
Received: from localhost.localdomain.localdomain (unknown [153.3.140.100])
        (Authenticated sender: fly@kernel.page)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id A3E1E1C000F;
        Thu, 21 Nov 2019 15:21:05 +0000 (UTC)
From:   Pengfei Li <fly@kernel.page>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, mhocko@kernel.org, vbabka@suse.cz,
        cl@linux.com, iamjoonsoo.kim@lge.com, guro@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Pengfei Li <fly@kernel.page>
Subject: [RFC v1 10/19] mm, page_alloc: use for_each_node in wake_all_kswapds()
Date:   Thu, 21 Nov 2019 23:18:02 +0800
Message-Id: <20191121151811.49742-11-fly@kernel.page>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191121151811.49742-1-fly@kernel.page>
References: <20191121151811.49742-1-fly@kernel.page>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In wake_all_kswapds(), we want to traverse node instead of zone, so
use for_each_node instead of for_each_zone.

Signed-off-by: Pengfei Li <fly@kernel.page>
---
 mm/page_alloc.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2dcf2a21c578..aa5c2ef4f8ec 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4166,15 +4166,12 @@ static void wake_all_kswapds(unsigned int order, gfp_t gfp_mask,
 			     const struct alloc_context *ac)
 {
 	enum zone_type high_zoneidx = ac->high_zoneidx;
-	pg_data_t *last_pgdat = NULL;
 	struct nlist_traverser t;
-	struct zone *zone;
+	int node;
 
-	for_each_zone_nlist_nodemask(zone, &t, ac->nodelist, high_zoneidx,
-					ac->nodemask) {
-		if (last_pgdat != zone->zone_pgdat)
-			wakeup_kswapd(zone->zone_pgdat, gfp_mask, order, high_zoneidx);
-		last_pgdat = zone->zone_pgdat;
+	for_each_node_nlist_nodemask(node, &t, ac->nodelist,
+					high_zoneidx, ac->nodemask) {
+		wakeup_kswapd(NODE_DATA(node), gfp_mask, order, high_zoneidx);
 	}
 }
 
-- 
2.23.0

