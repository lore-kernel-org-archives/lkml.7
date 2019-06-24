Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BAFC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 04:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A689720679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 04:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WST0UPSx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfFXEM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 00:12:59 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39148 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfFXEM6 (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 00:12:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id 196so6373088pgc.6
        for <Linux-kernel@vger.kernel.org>; Sun, 23 Jun 2019 21:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=liAXSrzZADosAkb1YtXWhzyzZ/3HP+JE3hlQPzLjKmY=;
        b=WST0UPSxHFggzVaicksTgzQyGB6/nIpepqasB5OKMlpX3rsja1TvHJxR4lrdMAUVAP
         2H9C11DwrkI0aHug/+cSUmz9S0HXv+3TALy9ePTW3w4BIR2m8KAqaE7oQ9zYzmzvTGJN
         /eyeYAHj0LXDLaL4hOA0vL2otu3b4cvecV0skqxcIydsgvCsXQqRTz71Vpb5lCGneuxN
         v/XTodbFVZtWYeQQKMdLhBgY9oZTSxyiprXdlKmDs/LDHGGs6p7AfvyzGCGcjNKukKd6
         vLeZRkn8/rwhQWtIZkFh8o+7vJ3P/tbhv3PpWdVAxL2lNhqM062UInNj02QkdxLCt6gx
         /v9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=liAXSrzZADosAkb1YtXWhzyzZ/3HP+JE3hlQPzLjKmY=;
        b=JctfDYruKA8rD6JOdcPjLirJdEJxq2jaKDrNV/Z9/DKh0fcTH7unUqh2RqNguLmC1m
         2ffsJcOVSjwdx9DLpw2HYytmL8pDIkYfKgzD/WUGy5CwL3CbOWqA7E7VIAD8s8MaPqnA
         7NYen5rDb/SvR/PH5km8hdirAvBchCE5zS9LN31kO8tn4Xa2jD3j2O85dkonGLtIfoyN
         QrTlm9CHaDxRHBh/vm+jJoQ9jvA3NVbl+bZ49CAX9aGsKvuwtYyK7p43e995l2F5mN+B
         N0jx09VQ1pS8gsIpoLHTKOtZvkzePDH2K7w+094jQ1ASq+SUQgjk3HfCwBlQe/ocIhZ3
         dUdw==
X-Gm-Message-State: APjAAAXWn/KkzRvuZyvAvtju6DJwbDfksVF0nRnZzK/arMm6tTaghYOZ
        BZWi6a89rC9m33nEYsd35A==
X-Google-Smtp-Source: APXvYqz73zX9Cj8GqKXGuUimsv0v8MW6gNnWWORYAHs3K7IDVHnrZrBvSf0VxXsWmAA5jNXiyXaccg==
X-Received: by 2002:a63:5a4b:: with SMTP id k11mr13446294pgm.143.1561349578165;
        Sun, 23 Jun 2019 21:12:58 -0700 (PDT)
Received: from mylaptop.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j14sm10202116pfn.120.2019.06.23.21.12.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 21:12:57 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Linux-mm@kvack.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Hubbard <jhubbard@nvidia.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Linux-kernel@vger.kernel.org
Subject: [PATCHv2] mm/gup: speed up check_and_migrate_cma_pages() on huge page
Date:   Mon, 24 Jun 2019 12:12:41 +0800
Message-Id: <1561349561-8302-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both hugetlb and thp locate on the same migration type of pageblock, since
they are allocated from a free_list[]. Based on this fact, it is enough to
check on a single subpage to decide the migration type of the whole huge
page. By this way, it saves (2M/4K - 1) times loop for pmd_huge on x86,
similar on other archs.

Furthermore, when executing isolate_huge_page(), it avoid taking global
hugetlb_lock many times, and meanless remove/add to the local link list
cma_page_list.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Linux-kernel@vger.kernel.org
---
 mm/gup.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index ddde097..544f5de 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1342,19 +1342,22 @@ static long check_and_migrate_cma_pages(struct task_struct *tsk,
 	LIST_HEAD(cma_page_list);
 
 check_again:
-	for (i = 0; i < nr_pages; i++) {
+	for (i = 0; i < nr_pages;) {
+
+		struct page *head = compound_head(pages[i]);
+		long step = 1;
+
+		if (PageCompound(head))
+			step = compound_order(head) - (pages[i] - head);
 		/*
 		 * If we get a page from the CMA zone, since we are going to
 		 * be pinning these entries, we might as well move them out
 		 * of the CMA zone if possible.
 		 */
-		if (is_migrate_cma_page(pages[i])) {
-
-			struct page *head = compound_head(pages[i]);
-
-			if (PageHuge(head)) {
+		if (is_migrate_cma_page(head)) {
+			if (PageHuge(head))
 				isolate_huge_page(head, &cma_page_list);
-			} else {
+			else {
 				if (!PageLRU(head) && drain_allow) {
 					lru_add_drain_all();
 					drain_allow = false;
@@ -1369,6 +1372,8 @@ static long check_and_migrate_cma_pages(struct task_struct *tsk,
 				}
 			}
 		}
+
+		i += step;
 	}
 
 	if (!list_empty(&cma_page_list)) {
-- 
2.7.5

