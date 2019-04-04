Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C62CC10F05
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA392177E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387734AbfDDJPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:15:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:35644 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387523AbfDDJPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:15:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 49E73ACFA;
        Thu,  4 Apr 2019 09:15:43 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
Subject: [RFC 2/2] mm, slub: add missing kmem_cache_debug() checks
Date:   Thu,  4 Apr 2019 11:15:31 +0200
Message-Id: <20190404091531.9815-3-vbabka@suse.cz>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404091531.9815-1-vbabka@suse.cz>
References: <20190404091531.9815-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some debugging checks in SLUB are not hidden behind kmem_cache_debug() check.
Add the check so that those places can also benefit from reduced overhead
thanks to the the static key added by the previous patch.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 398e53e16e2e..9d1b0e5e8593 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1086,6 +1086,13 @@ static inline void dec_slabs_node(struct kmem_cache *s, int node, int objects)
 static void setup_object_debug(struct kmem_cache *s, struct page *page,
 								void *object)
 {
+	/*
+	 * __OBJECT_POISON implies SLAB_POISON which is covered by
+	 * kmem_cache_debug()
+	 */
+	if (!kmem_cache_debug(s))
+		return;
+
 	if (!(s->flags & (SLAB_STORE_USER|SLAB_RED_ZONE|__OBJECT_POISON)))
 		return;
 
@@ -1095,6 +1102,9 @@ static void setup_object_debug(struct kmem_cache *s, struct page *page,
 
 static void setup_page_debug(struct kmem_cache *s, void *addr, int order)
 {
+	if (!kmem_cache_debug(s))
+		return;
+
 	if (!(s->flags & SLAB_POISON))
 		return;
 
@@ -1734,7 +1744,7 @@ static void __free_slab(struct kmem_cache *s, struct page *page)
 	int order = compound_order(page);
 	int pages = 1 << order;
 
-	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
+	if (kmem_cache_debug(s) && s->flags & SLAB_CONSISTENCY_CHECKS) {
 		void *p;
 
 		slab_pad_check(s, page);
-- 
2.21.0

