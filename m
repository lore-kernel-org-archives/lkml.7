Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF19C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F4920692
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfKUPUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 10:20:16 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:44239 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbfKUPUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:20:16 -0500
X-Originating-IP: 153.3.140.100
Received: from localhost.localdomain.localdomain (unknown [153.3.140.100])
        (Authenticated sender: fly@kernel.page)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 5A4B91C0024;
        Thu, 21 Nov 2019 15:20:07 +0000 (UTC)
From:   Pengfei Li <fly@kernel.page>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, mhocko@kernel.org, vbabka@suse.cz,
        cl@linux.com, iamjoonsoo.kim@lge.com, guro@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Pengfei Li <fly@kernel.page>
Subject: [RFC v1 04/19] mm, slub: use for_each_node in get_any_partial()
Date:   Thu, 21 Nov 2019 23:17:56 +0800
Message-Id: <20191121151811.49742-5-fly@kernel.page>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191121151811.49742-1-fly@kernel.page>
References: <20191121151811.49742-1-fly@kernel.page>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In get_any_partial(), we want to traverse node instead of zone, so
use for_each_node instead of for_each_zone.

Signed-off-by: Pengfei Li <fly@kernel.page>
---
 mm/slub.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index ad1abfbc57b1..2fe3edbcf296 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1905,10 +1905,10 @@ static void *get_any_partial(struct kmem_cache *s, gfp_t flags,
 		struct kmem_cache_cpu *c)
 {
 #ifdef CONFIG_NUMA
+	enum zone_type high_zoneidx = gfp_zone(flags);
 	struct nodelist *nodelist;
 	struct nlist_traverser t;
-	struct zone *zone;
-	enum zone_type high_zoneidx = gfp_zone(flags);
+	int node;
 	void *object;
 	unsigned int cpuset_mems_cookie;
 
@@ -1937,12 +1937,12 @@ static void *get_any_partial(struct kmem_cache *s, gfp_t flags,
 	do {
 		cpuset_mems_cookie = read_mems_allowed_begin();
 		nodelist = node_nodelist(mempolicy_slab_node(), flags);
-		for_each_zone_nlist(zone, &t, nodelist, high_zoneidx) {
+		for_each_node_nlist(node, &t, nodelist, high_zoneidx) {
 			struct kmem_cache_node *n;
 
-			n = get_node(s, zone_to_nid(zone));
+			n = get_node(s, node);
 
-			if (n && cpuset_zone_allowed(zone, flags) &&
+			if (n && cpuset_node_allowed(node, flags) &&
 					n->nr_partial > s->min_partial) {
 				object = get_partial_node(s, n, c, flags);
 				if (object) {
-- 
2.23.0

