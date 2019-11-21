Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1088FC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E499020674
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfKUPT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 10:19:59 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:60415 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfKUPT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:19:59 -0500
X-Originating-IP: 153.3.140.100
Received: from localhost.localdomain.localdomain (unknown [153.3.140.100])
        (Authenticated sender: fly@kernel.page)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 390EE1C000A;
        Thu, 21 Nov 2019 15:19:47 +0000 (UTC)
From:   Pengfei Li <fly@kernel.page>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, mhocko@kernel.org, vbabka@suse.cz,
        cl@linux.com, iamjoonsoo.kim@lge.com, guro@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Pengfei Li <fly@kernel.page>
Subject: [RFC v1 02/19] mm, hugetlb: use for_each_node in dequeue_huge_page_nodemask()
Date:   Thu, 21 Nov 2019 23:17:54 +0800
Message-Id: <20191121151811.49742-3-fly@kernel.page>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191121151811.49742-1-fly@kernel.page>
References: <20191121151811.49742-1-fly@kernel.page>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In dequeue_huge_page_nodemask(), we want to traverse node instead of
zone, so use for_each_node instead of for_each_zone.

Signed-off-by: Pengfei Li <fly@kernel.page>
---
 mm/hugetlb.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2e55ec5dc84d..287b90c7ab36 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -850,25 +850,18 @@ static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask,
 	unsigned int cpuset_mems_cookie;
 	struct nodelist *nodelist;
 	struct nlist_traverser t;
-	struct zone *zone;
-	int node = NUMA_NO_NODE;
+	int node;
 
 	nodelist = node_nodelist(nid, gfp_mask);
 
 retry_cpuset:
 	cpuset_mems_cookie = read_mems_allowed_begin();
-	for_each_zone_nlist_nodemask(zone, &t, nodelist, gfp_zone(gfp_mask), nmask) {
+	for_each_node_nlist_nodemask(node, &t, nodelist,
+					gfp_zone(gfp_mask), nmask) {
 		struct page *page;
 
-		if (!cpuset_zone_allowed(zone, gfp_mask))
-			continue;
-		/*
-		 * no need to ask again on the same node. Pool is node rather than
-		 * zone aware
-		 */
-		if (zone_to_nid(zone) == node)
+		if (!cpuset_node_allowed(node, gfp_mask))
 			continue;
-		node = zone_to_nid(zone);
 
 		page = dequeue_huge_page_node_exact(h, node);
 		if (page)
-- 
2.23.0

