Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13807C2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 17:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E42C621835
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 17:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730194AbfLERoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 12:44:23 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:56561 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729396AbfLERoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 12:44:22 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Tk3FZYF_1575567848;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Tk3FZYF_1575567848)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 06 Dec 2019 01:44:16 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     ktkhai@virtuozzo.com, hannes@cmpxchg.org, mhocko@suse.com,
        shakeelb@google.com, guro@fb.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [v2 PATCH] mm: vmscan: protect shrinker idr replace with CONFIG_MEMCG
Date:   Fri,  6 Dec 2019 01:44:08 +0800
Message-Id: <1575567848-54425-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 0a432dcbeb32edcd211a5d8f7847d0da7642a8b4 ("mm: shrinker:
make shrinker not depend on memcg kmem"), shrinkers' idr is protected by
CONFIG_MEMCG instead of CONFIG_MEMCG_KMEM, so it makes no sense to
protect shrinker idr replace with CONFIG_MEMCG_KMEM.

And, in CONFIG_MEMCG && CONFIG_SLOB case, shrinker_idr contains only
shrinker, and it is deferred_split_shrinker.  But it is never actually
called, since idr_replace() is never compiled due to the wrong #ifdef.
The deferred_split_shrinker all the time is staying in half-registered
state, and it's never called for subordinate mem cgroups.

Fixes: 0a432dcbeb32 ("mm: shrinker: make shrinker not depend on memcg kmem")
Reviewed-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Roman Gushchin <guro@fb.com>
Cc: <stable@vger.kernel.org> 5.4+
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index ee4eecc..e7f10c4 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -422,7 +422,7 @@ void register_shrinker_prepared(struct shrinker *shrinker)
 {
 	down_write(&shrinker_rwsem);
 	list_add_tail(&shrinker->list, &shrinker_list);
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
 		idr_replace(&shrinker_idr, shrinker, shrinker->id);
 #endif
-- 
1.8.3.1

