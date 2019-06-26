Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4124CC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E92A214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJBruFOk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbfFZNK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:10:28 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33866 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfFZNK2 (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:10:28 -0400
Received: by mail-pf1-f194.google.com with SMTP id c85so1359356pfc.1
        for <Linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 06:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=opO5RMkXYD+cDHitMAzTrap5fSpuloWy8AelrA+yk/o=;
        b=sJBruFOkU1pdY68j41Bmt5j3/69/hEkBrAX4Bp/SPQ6CqwEmjI51KZUNEziJRJmGmI
         E8vsukdW1rIBucMxnN+ym7qQai6Mtu2L4PKIzGzNpIs3ALajss1lnxvIS797IlEcocVy
         CB5SoYCSWJQAqcUwj/kukLpeWhO7TiA5YiMvRMSTVhO5C3ljUGriG/y53zuxCqil4i5t
         bYi9WglS8QScCREAjjCS3ixCsiacTwwfTOiRJ/c1ULq0KNSWc9s00o4VvYS3YoL/DiMt
         oSRSCGGS7cXtDlmIZGlb5ScX44Zoc3KoR5JQxVenDJ2C2WuuIZycPtS6gy6MwP8Y1bTD
         XlCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=opO5RMkXYD+cDHitMAzTrap5fSpuloWy8AelrA+yk/o=;
        b=JslWk9OGLByKCrzqLJ5/zTkhueFxfA6FVLJcCKNq62vGEW7YJWTw9EbKwJpf8xvob5
         0VNQ1DYGEHRnGoZg3Y9lvwE/ZGcrGb8oJjm68vhHZUQhFjyBacsQz7Wmz3C0zaUZhnda
         iCT/yyyLMv8jsX/aMdnnUYkh85WE6ueZfZbMKoPeoY9Qpqu7cQtvldcIEomeNNTD7B7a
         FFlf2SAVKiZvyRGIdhTITXMLDF0NLggpJ9lXX6LA5lBknGePq6heOCht7RGsecK6JfTa
         Cd3EX/D6uUyk25wGr4dCguMfe0rUIdI8Cq9mqoIGQvJ+WaZwwEv64/ZJ7z4ISzArIDjs
         6U6A==
X-Gm-Message-State: APjAAAWnlZ9zUrgAyRQjEStqGw5TVTvWTo7a0NjPoQDRO8WU+kI8Ed1K
        nysTlQdO9S6ExVo3AuPVuQ==
X-Google-Smtp-Source: APXvYqw5SVoQ7Z6nytDeDRYCYO28cK9DunjzJLV+rLqsiNAIPyNrv7UGLab3d/LLwAkh6fOmQEOWiQ==
X-Received: by 2002:a63:fe51:: with SMTP id x17mr3035587pgj.61.1561554627862;
        Wed, 26 Jun 2019 06:10:27 -0700 (PDT)
Received: from mylaptop.redhat.com ([2408:8207:7820:4fb0:dc47:8733:627e:cd6d])
        by smtp.gmail.com with ESMTPSA id i14sm27533585pfk.0.2019.06.26.06.10.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 06:10:26 -0700 (PDT)
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
Subject: [PATCHv4] mm/gup: speed up check_and_migrate_cma_pages() on huge page
Date:   Wed, 26 Jun 2019 21:10:00 +0800
Message-Id: <1561554600-5274-1-git-send-email-kernelfans@gmail.com>
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
v3 -> v4: fix C language precedence issue

 mm/gup.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index ddde097..ffca55b 100644
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
+			step = (1 << compound_order(head)) - (pages[i] - head);
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

