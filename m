Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F970C76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 17:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F8F2217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 17:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388394AbfGQRpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 13:45:39 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:45366 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727255AbfGQRpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 13:45:39 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0TX8wp0U_1563385527;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TX8wp0U_1563385527)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 18 Jul 2019 01:45:33 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     shakeelb@google.com, vdavydov.dev@gmail.com, hannes@cmpxchg.org,
        mhocko@suse.com, ktkhai@virtuozzo.com, guro@fb.com,
        hughd@google.com, cai@lca.pw, kirill.shutemov@linux.intel.com,
        akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, stable@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: vmscan: check if mem cgroup is disabled or not before calling memcg slab shrinker
Date:   Thu, 18 Jul 2019 01:45:26 +0800
Message-Id: <1563385526-20805-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shakeel Butt reported premature oom on kernel with
"cgroup_disable=memory" since mem_cgroup_is_root() returns false even
though memcg is actually NULL.  The drop_caches is also broken.

It is because commit aeed1d325d42 ("mm/vmscan.c: generalize shrink_slab()
calls in shrink_node()") removed the !memcg check before
!mem_cgroup_is_root().  And, surprisingly root memcg is allocated even
though memory cgroup is disabled by kernel boot parameter.

Add mem_cgroup_disabled() check to make reclaimer work as expected.

Fixes: aeed1d325d42 ("mm/vmscan.c: generalize shrink_slab() calls in shrink_node()")
Reported-by: Shakeel Butt <shakeelb@google.com>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Roman Gushchin <guro@fb.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Qian Cai <cai@lca.pw>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: stable@vger.kernel.org  4.19+
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/vmscan.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index f8e3dcd..c10dc02 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -684,7 +684,14 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 	unsigned long ret, freed = 0;
 	struct shrinker *shrinker;
 
-	if (!mem_cgroup_is_root(memcg))
+	/*
+	 * The root memcg might be allocated even though memcg is disabled
+	 * via "cgroup_disable=memory" boot parameter.  This could make
+	 * mem_cgroup_is_root() return false, then just run memcg slab
+	 * shrink, but skip global shrink.  This may result in premature
+	 * oom.
+	 */
+	if (!mem_cgroup_disabled() && !mem_cgroup_is_root(memcg))
 		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
 
 	if (!down_read_trylock(&shrinker_rwsem))
-- 
1.8.3.1

