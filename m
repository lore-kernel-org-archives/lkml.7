Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF873ECE58B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB3C320830
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390322AbfJCRmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:42:02 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:39776 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731045AbfJCRl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 13:41:59 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Te19PA9_1570124498;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Te19PA9_1570124498)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 04 Oct 2019 01:41:56 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mgorman@techsingularity.net, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: vmscan: remove unused scan_control parameter from pageout()
Date:   Fri,  4 Oct 2019 01:41:38 +0800
Message-Id: <1570124498-19300-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since lumpy reclaim was removed in v3.5 scan_control is not used by
may_write_to_{queue|inode} and pageout() anymore, remove the unused
parameter.

Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/vmscan.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index e5d52d6..17489b8 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -774,7 +774,7 @@ static inline int is_page_cache_freeable(struct page *page)
 	return page_count(page) - page_has_private(page) == 1 + page_cache_pins;
 }
 
-static int may_write_to_inode(struct inode *inode, struct scan_control *sc)
+static int may_write_to_inode(struct inode *inode)
 {
 	if (current->flags & PF_SWAPWRITE)
 		return 1;
@@ -822,8 +822,7 @@ static void handle_write_error(struct address_space *mapping,
  * pageout is called by shrink_page_list() for each dirty page.
  * Calls ->writepage().
  */
-static pageout_t pageout(struct page *page, struct address_space *mapping,
-			 struct scan_control *sc)
+static pageout_t pageout(struct page *page, struct address_space *mapping)
 {
 	/*
 	 * If the page is dirty, only perform writeback if that write
@@ -859,7 +858,7 @@ static pageout_t pageout(struct page *page, struct address_space *mapping,
 	}
 	if (mapping->a_ops->writepage == NULL)
 		return PAGE_ACTIVATE;
-	if (!may_write_to_inode(mapping->host, sc))
+	if (!may_write_to_inode(mapping->host))
 		return PAGE_KEEP;
 
 	if (clear_page_dirty_for_io(page)) {
@@ -1396,7 +1395,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 			 * starts and then write it out here.
 			 */
 			try_to_unmap_flush_dirty();
-			switch (pageout(page, mapping, sc)) {
+			switch (pageout(page, mapping)) {
 			case PAGE_KEEP:
 				goto keep_locked;
 			case PAGE_ACTIVATE:
-- 
1.8.3.1

