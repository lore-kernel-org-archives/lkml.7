Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A26C2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B86206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfLPJ1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 04:27:40 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:39484 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726955AbfLPJ1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 04:27:38 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Tl3mBrd_1576488441;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0Tl3mBrd_1576488441)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 16 Dec 2019 17:27:22 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        shakeelb@google.com, hannes@cmpxchg.org
Cc:     Alex Shi <alex.shi@linux.alibaba.com>
Subject: [PATCH v6 10/10] mm: revise the comments of mem_cgroup_page_lruvec
Date:   Mon, 16 Dec 2019 17:26:26 +0800
Message-Id: <1576488386-32544-11-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576488386-32544-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1576488386-32544-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Weiner <hannes@cmpxchg.org>

Better document the mem_cgroup_page_lruvec() caller requirements.

Suggested-by: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/memcontrol.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f8e279487e1d..552de2e7da0e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1202,9 +1202,18 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
  * @page: the page
  * @pgdat: pgdat of the page
  *
- * This function is only safe when following the LRU page isolation
- * and putback protocol: the LRU lock must be held, and the page must
- * either be PageLRU() or the caller must have isolated/allocated it.
+ * NOTE: The returned lruvec is only stable if the calling context has
+ * the page->mem_cgroup pinned! This is accomplished by satisfying one
+ * of the following criteria:
+ *
+ *    a) have the @page locked
+ *    b) have an exclusive reference to @page (e.g. refcount 0)
+ *    c) hold the lru_lock and "own" the PageLRU (meaning either ensure
+ *       it's set, or be the one to hold the page in isolation)
+ *
+ * Otherwise, the page could be freed or moved out of the memcg,
+ * thereby releasing its reference on the memcg and potentially
+ * freeing it and its lruvecs in the process.
  */
 struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgdat)
 {
-- 
1.8.3.1

