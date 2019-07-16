Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FC8C76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 21:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65D1217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 21:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eAyFUgUu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388914AbfGPVYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 17:24:48 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:36275 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728405AbfGPVYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 17:24:48 -0400
Received: by mail-qt1-f202.google.com with SMTP id q26so19373299qtr.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 14:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2wgQ6fTRz8YVKlsgVYdX5VKS/93WfCC6IDxOgquvAIU=;
        b=eAyFUgUuhZtkGf735osAhmhEOFvr3JINPaEutas0ADwVueaiB44EIy1B1MwHy11cK9
         AI1n6V9SXRhvQnDpsUlL+hC884VzfZ+3tyiWjrW7YnBgWlWVHtyyBE4TxoZjXWDYZYjm
         p78rN0UOy/ft76DhLFL+oaCZTdrlcW41XPaNdpNhi5Cira/vfd0jfbVk+80oVrbqgT28
         makPjbEDLZNg0s0AF4Dej0l4JiX9eMkEc07DNLilO3Uw26CoMEHSt+CIKzrojmW1TBYd
         0eGcJ4qok9OAk2AkcENuCT95km6BwOGiMrb2zhQIq7RIj+CbptOxahEyZcUPn2ykINAR
         QepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2wgQ6fTRz8YVKlsgVYdX5VKS/93WfCC6IDxOgquvAIU=;
        b=GlrrwxC9w6Vnd/StsgmSKNWiwegPegF5gfocqr6x3KbDt2vKDsqKgy8FTrOJPw9Bmq
         y/HYyJUAB5UbCvAbo7VdkDeDvJEDZixNlJ8fCqxRNrEzkMG7XpMqOWQZK+sHltx9kb9N
         mEo/NFSH6uEWsnCAM8w4UOy811qid+Z5tJhMhDAPo8bSaDLKIyJyYBFRUqfG+OeTSYY4
         /iFk5XF3frT7YmOFgohrrvLUkQ6U2I9OiA3Z4F6Tz/MdjsOJhh4KH97Q/J/QbiT2PkuO
         MaRo9E5CvHDHfP3fgi1Wl303nUA8wTC9nYzhi9QeqKGki5q/TKCwv/H1Hst2ToZK8zAF
         icGA==
X-Gm-Message-State: APjAAAWVqpxgiIP63j5J/STHW9y3gdfgfwhVnjLbd08Z0A99qXr+0EV/
        CPwGKyMoG50egM+X8dh0U1XTEdJgnMI=
X-Google-Smtp-Source: APXvYqxWSZMAIjSYZTED5PDBoHzrS/JaWeubuVN7NgOTm8ki1Xt/BMtbMdWV8FD3ncWZnn00SKBIe2ebHiI=
X-Received: by 2002:a37:b741:: with SMTP id h62mr23551088qkf.490.1563312286773;
 Tue, 16 Jul 2019 14:24:46 -0700 (PDT)
Date:   Tue, 16 Jul 2019 15:24:36 -0600
Message-Id: <20190716212436.7137-1-yuzhao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH] mm: replace list_move_tail() with add_page_to_lru_list_tail()
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peng Fan <peng.fan@nxp.com>, Ira Weiny <ira.weiny@intel.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cleanup patch that replaces two historical uses of
list_move_tail() with relatively recent add_page_to_lru_list_tail().

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/swap.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index ae300397dfda..0226c5346560 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -515,7 +515,6 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
 	del_page_from_lru_list(page, lruvec, lru + active);
 	ClearPageActive(page);
 	ClearPageReferenced(page);
-	add_page_to_lru_list(page, lruvec, lru);
 
 	if (PageWriteback(page) || PageDirty(page)) {
 		/*
@@ -523,13 +522,14 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
 		 * It can make readahead confusing.  But race window
 		 * is _really_ small and  it's non-critical problem.
 		 */
+		add_page_to_lru_list(page, lruvec, lru);
 		SetPageReclaim(page);
 	} else {
 		/*
 		 * The page's writeback ends up during pagevec
 		 * We moves tha page into tail of inactive.
 		 */
-		list_move_tail(&page->lru, &lruvec->lists[lru]);
+		add_page_to_lru_list_tail(page, lruvec, lru);
 		__count_vm_event(PGROTATED);
 	}
 
@@ -844,17 +844,15 @@ void lru_add_page_tail(struct page *page, struct page *page_tail,
 		get_page(page_tail);
 		list_add_tail(&page_tail->lru, list);
 	} else {
-		struct list_head *list_head;
 		/*
 		 * Head page has not yet been counted, as an hpage,
 		 * so we must account for each subpage individually.
 		 *
-		 * Use the standard add function to put page_tail on the list,
-		 * but then correct its position so they all end up in order.
+		 * Put page_tail on the list at the correct position
+		 * so they all end up in order.
 		 */
-		add_page_to_lru_list(page_tail, lruvec, page_lru(page_tail));
-		list_head = page_tail->lru.prev;
-		list_move_tail(&page_tail->lru, list_head);
+		add_page_to_lru_list_tail(page_tail, lruvec,
+					  page_lru(page_tail));
 	}
 
 	if (!PageUnevictable(page))
-- 
2.22.0.510.g264f2c817a-goog

