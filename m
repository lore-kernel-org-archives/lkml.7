Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44A7C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00612075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387731AbfDDJPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:15:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:35652 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387931AbfDDJPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:15:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4A327AD0A;
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
Subject: [RFC 1/2] mm, slub: introduce static key for slub_debug
Date:   Thu,  4 Apr 2019 11:15:30 +0200
Message-Id: <20190404091531.9815-2-vbabka@suse.cz>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404091531.9815-1-vbabka@suse.cz>
References: <20190404091531.9815-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One advantage of CONFIG_SLUB_DEBUG is that a generic distro kernel can be built
with it, but it's inactive until enabled on boot or at runtime, without
rebuilding the kernel. With a static key, we can minimize the overhead of
checking whether slub_debug is enabled, as we do for e.g. page_owner.

For now and for simplicity, the static key stays enabled for the whole uptime
once activated for any cache, although some per-cache debugging options can be
also disabled at runtime. This can be improved if there's interest.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index d30ede89f4a6..398e53e16e2e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -115,10 +115,21 @@
  * 			the fast path and disables lockless freelists.
  */
 
+#ifdef CONFIG_SLUB_DEBUG
+#ifdef CONFIG_SLUB_DEBUG_ON
+DEFINE_STATIC_KEY_TRUE(slub_debug_enabled);
+#else
+DEFINE_STATIC_KEY_FALSE(slub_debug_enabled);
+#endif
+#endif
+
 static inline int kmem_cache_debug(struct kmem_cache *s)
 {
 #ifdef CONFIG_SLUB_DEBUG
-	return unlikely(s->flags & SLAB_DEBUG_FLAGS);
+	if (static_branch_unlikely(&slub_debug_enabled))
+		return s->flags & SLAB_DEBUG_FLAGS;
+	else
+		return 0;
 #else
 	return 0;
 #endif
@@ -1287,6 +1298,9 @@ static int __init setup_slub_debug(char *str)
 	if (*str == ',')
 		slub_debug_slabs = str + 1;
 out:
+	if (slub_debug)
+		static_branch_enable(&slub_debug_enabled);
+
 	return 1;
 }
 
@@ -5193,6 +5207,7 @@ static ssize_t red_zone_store(struct kmem_cache *s,
 	s->flags &= ~SLAB_RED_ZONE;
 	if (buf[0] == '1') {
 		s->flags |= SLAB_RED_ZONE;
+		static_branch_enable(&slub_debug_enabled);
 	}
 	calculate_sizes(s, -1);
 	return length;
@@ -5213,6 +5228,7 @@ static ssize_t poison_store(struct kmem_cache *s,
 	s->flags &= ~SLAB_POISON;
 	if (buf[0] == '1') {
 		s->flags |= SLAB_POISON;
+		static_branch_enable(&slub_debug_enabled);
 	}
 	calculate_sizes(s, -1);
 	return length;
@@ -5234,6 +5250,7 @@ static ssize_t store_user_store(struct kmem_cache *s,
 	if (buf[0] == '1') {
 		s->flags &= ~__CMPXCHG_DOUBLE;
 		s->flags |= SLAB_STORE_USER;
+		static_branch_enable(&slub_debug_enabled);
 	}
 	calculate_sizes(s, -1);
 	return length;
-- 
2.21.0

