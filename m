Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731CCC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 23:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B23222C3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 23:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbfJAX5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 19:57:00 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:55170 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726207AbfJAX5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 19:57:00 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0TdwevRd_1569974210;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TdwevRd_1569974210)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 02 Oct 2019 07:56:56 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     kirill.shutemov@linux.intel.com, ktkhai@virtuozzo.com,
        hannes@cmpxchg.org, mhocko@suse.com, hughd@google.com,
        shakeelb@google.com, rientjes@google.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm thp: shrink deferred split THPs harder
Date:   Wed,  2 Oct 2019 07:56:50 +0800
Message-Id: <1569974210-55366-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The deferred split THPs may get accumulated with some workloads, they
would get shrunk when memory pressure is hit.  Now we use DEFAULT_SEEKS
to determine how many objects would get scanned then split if possible,
but actually they are not like other system cache objects, i.e. inode
cache which would incur extra I/O if over reclaimed, the unmapped pages
will not be accessed anymore, so we could shrink them more aggressively.

We could shrink THPs more pro-actively even though memory pressure is not
hit, however, IMHO waiting for memory pressure is still a good
compromise and trade-off.  And, we do have simpler ways to shrink these
objects harder until we have to take other means do pro-actively drain.

Change shrinker->seeks to 0 to shrink deferred split THPs harder.

Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: David Rientjes <rientjes@google.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/huge_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 3b78910..1d6b1f1 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2955,7 +2955,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 static struct shrinker deferred_split_shrinker = {
 	.count_objects = deferred_split_count,
 	.scan_objects = deferred_split_scan,
-	.seeks = DEFAULT_SEEKS,
+	.seeks = 0,
 	.flags = SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE |
 		 SHRINKER_NONSLAB,
 };
-- 
1.8.3.1

