Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6322C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E68C20674
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfKUPU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 10:20:27 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:50781 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbfKUPU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:20:27 -0500
X-Originating-IP: 153.3.140.100
Received: from localhost.localdomain.localdomain (unknown [153.3.140.100])
        (Authenticated sender: fly@kernel.page)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id E922A1C000F;
        Thu, 21 Nov 2019 15:20:15 +0000 (UTC)
From:   Pengfei Li <fly@kernel.page>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, mhocko@kernel.org, vbabka@suse.cz,
        cl@linux.com, iamjoonsoo.kim@lge.com, guro@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Pengfei Li <fly@kernel.page>
Subject: [RFC v1 05/19] mm, slab: use for_each_node in fallback_alloc()
Date:   Thu, 21 Nov 2019 23:17:57 +0800
Message-Id: <20191121151811.49742-6-fly@kernel.page>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191121151811.49742-1-fly@kernel.page>
References: <20191121151811.49742-1-fly@kernel.page>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In fallback_alloc(), we want to traverse node instead of zone, so
use for_each_node instead of for_each_zone.

Signed-off-by: Pengfei Li <fly@kernel.page>
---
 mm/slab.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index b9a1353cf2ab..b94c06934459 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3103,12 +3103,11 @@ static void *alternate_node_alloc(struct kmem_cache *cachep, gfp_t flags)
  */
 static void *fallback_alloc(struct kmem_cache *cache, gfp_t flags)
 {
-	struct nodelist *nodelist;
-	struct nlist_traverser t;
-	struct zone *zone;
 	enum zone_type high_zoneidx = gfp_zone(flags);
 	void *obj = NULL;
 	struct page *page;
+	struct nodelist *nodelist;
+	struct nlist_traverser t;
 	int nid;
 	unsigned int cpuset_mems_cookie;
 
@@ -3124,10 +3123,8 @@ static void *fallback_alloc(struct kmem_cache *cache, gfp_t flags)
 	 * Look through allowed nodes for objects available
 	 * from existing per node queues.
 	 */
-	for_each_zone_nlist(zone, &t, nodelist, high_zoneidx) {
-		nid = zone_to_nid(zone);
-
-		if (cpuset_zone_allowed(zone, flags) &&
+	for_each_node_nlist(nid, &t, nodelist, high_zoneidx) {
+		if (cpuset_node_allowed(nid, flags) &&
 			get_node(cache, nid) &&
 			get_node(cache, nid)->free_objects) {
 				obj = ____cache_alloc_node(cache,
-- 
2.23.0

