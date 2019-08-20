Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEBEC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC1822CF7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbfHTJu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 05:50:26 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:33857 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729333AbfHTJuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 05:50:24 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0Ta-BP32_1566294575;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0Ta-BP32_1566294575)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 20 Aug 2019 17:49:35 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: [PATCH 08/14] lru/swap: uer lruvec lock in activate_page
Date:   Tue, 20 Aug 2019 17:48:31 +0800
Message-Id: <1566294517-86418-9-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1566294517-86418-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1566294517-86418-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

to replace pgdat lru_lock.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Nikolay Borisov <nborisov@suse.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/swap.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 2a8fe6df08fc..d2dad08fcfd0 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -325,11 +325,14 @@ static inline void activate_page_drain(int cpu)
 void activate_page(struct page *page)
 {
 	pg_data_t *pgdat = page_pgdat(page);
+	struct lruvec *lruvec;
 
 	page = compound_head(page);
-	spin_lock_irq(&pgdat->lruvec.lru_lock);
+	lruvec = mem_cgroup_page_lruvec(page, pgdat);
+	spin_lock_irq(&lruvec->lru_lock);
+	sync_lruvec_pgdat(lruvec, pgdat);
 	__activate_page(page, mem_cgroup_page_lruvec(page, pgdat), NULL);
-	spin_unlock_irq(&pgdat->lruvec.lru_lock);
+	spin_unlock_irq(&lruvec->lru_lock);
 }
 #endif
 
-- 
1.8.3.1

