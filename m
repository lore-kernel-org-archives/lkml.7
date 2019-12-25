Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF34C2D0DA
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 09:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 236742077B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 09:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfLYJEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 04:04:48 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:53127 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726106AbfLYJEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 04:04:47 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0TltSdOF_1577264682;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TltSdOF_1577264682)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 25 Dec 2019 17:04:42 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        shakeelb@google.com, hannes@cmpxchg.org
Subject: [PATCH v7 05/10] mm/mlock: optimize munlock_pagevec by relocking
Date:   Wed, 25 Dec 2019 17:04:21 +0800
Message-Id: <1577264666-246071-6-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1577264666-246071-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1577264666-246071-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the pagevec locking, a new page's lruvec is may same as
previous one. Thus we could save a re-locking, and only
change lock iff lruvec is newer.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: linux-kernel@vger.kernel.org
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 mm/mlock.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 10d15f58b061..050f999eadb1 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -289,6 +289,7 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
 {
 	int i;
 	int nr = pagevec_count(pvec);
+	int delta_munlocked = -nr;
 	struct pagevec pvec_putback;
 	struct lruvec *lruvec = NULL;
 	int pgrescued = 0;
@@ -299,20 +300,19 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
 	for (i = 0; i < nr; i++) {
 		struct page *page = pvec->pages[i];
 
-		lruvec = lock_page_lruvec_irq(page);
+		lruvec = relock_page_lruvec_irq(page, lruvec);
 
 		if (TestClearPageMlocked(page)) {
 			/*
 			 * We already have pin from follow_page_mask()
 			 * so we can spare the get_page() here.
 			 */
-			if (__munlock_isolate_lru_page(page, lruvec, false)) {
-				__mod_zone_page_state(zone, NR_MLOCK,  -1);
-				unlock_page_lruvec_irq(lruvec);
+			if (__munlock_isolate_lru_page(page, lruvec, false))
 				continue;
-			} else
+			else
 				__munlock_isolation_failed(page);
-		}
+		} else
+			delta_munlocked++;
 
 		/*
 		 * We won't be munlocking this page in the next phase
@@ -322,8 +322,10 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
 		 */
 		pagevec_add(&pvec_putback, pvec->pages[i]);
 		pvec->pages[i] = NULL;
-		unlock_page_lruvec_irq(lruvec);
 	}
+	__mod_zone_page_state(zone, NR_MLOCK, delta_munlocked);
+	if (lruvec)
+		unlock_page_lruvec_irq(lruvec);
 
 	/* Now we can release pins of pages that we are not munlocking */
 	pagevec_release(&pvec_putback);
-- 
1.8.3.1

