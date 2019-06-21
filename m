Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90561C48BE3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 10:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69FD2208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 10:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ro5qRdsO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfFUKPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 06:15:46 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39708 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfFUKPq (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 06:15:46 -0400
Received: by mail-pl1-f193.google.com with SMTP id b7so2781298pls.6
        for <Linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 03:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iaAWHMgj40YUiiiLdOSCUs5wONEm8RdZ1pbQZb103Mw=;
        b=ro5qRdsOCcr007KyKnX0TdinBmxigmD6oO7ryvNgpYVDDhu6jym2pDqNFvcAvWTkxy
         xeSaO+LtF7D8jsbSKMsI0gVezGfsUxlZfDtyS+HJ+B9VlRP1VfRlkYKbV5W5inXuxzkc
         Pi0ESkw8ePLr2jvzD+roWvLRtYG4RTvC04QODSVen/AiH7MNkFuzaLkqG4vvfUVSOadD
         7oj9FGlTVMvneDDWAzmbQaKbxaxLUd50KhdQnoAmsmaQ4G0WRHN02tAeWivB6D9gX+/0
         ZITP6k8kRN2P/qtbI5tc2jIMJVnv7lXOj/tbG54yNtfD5+XL5CWygfbxjqD1OiGYGo+o
         ERZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iaAWHMgj40YUiiiLdOSCUs5wONEm8RdZ1pbQZb103Mw=;
        b=tGM/KgK0zjSn9U7nT0Ux7HGNjhVIC9X0+b8leTV/cVsW6fXaljNoUUb0bLvO7prHsg
         NtjcQOUwCk0lKyYLGmZgpBZQ8R1M93LGr9N38S62g2VB8EYuuboqVieWDYhw/rHepAoD
         MNhRKRAGtVDUoeqFJy3FlkN4rBKTH+cNxC6XHhncOwltyeKYlJtkdw+osT8u8GW8/Ykx
         LjkHMQx3hsF3DZ5mNZ5Jd0LC7QVtj0OK3d5QGM/jLKoE4TzZh3/UFBM/SuA2uQOHZiCq
         8SVnT3hWyBJB5c5eHbNcubupeqnZ9BP6gNLHy9gR695kM9bz2tggXK89KS9WmMGZp2yA
         StCA==
X-Gm-Message-State: APjAAAXTmGv4qAjGBoGRhmuJQzBzL8p0tUOj2b5XPaRjiqI7feVu/22J
        Dx72KzYVZrPvo4V1NOhIog==
X-Google-Smtp-Source: APXvYqw64NArSYS+J2I2yZXnXVHQVwWJYFrAOUvBebEJQsxNVmcK50h/mJX7bfSLMNNQ+7aDRCY5hg==
X-Received: by 2002:a17:902:e211:: with SMTP id ce17mr48686801plb.193.1561112145655;
        Fri, 21 Jun 2019 03:15:45 -0700 (PDT)
Received: from mylaptop.redhat.com ([2408:8207:7826:5c10:8935:c645:2c30:74ef])
        by smtp.gmail.com with ESMTPSA id x14sm3040681pfq.158.2019.06.21.03.15.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 03:15:44 -0700 (PDT)
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
Subject: [PATCH] mm/gup: speed up check_and_migrate_cma_pages() on huge page
Date:   Fri, 21 Jun 2019 18:15:16 +0800
Message-Id: <1561112116-23072-1-git-send-email-kernelfans@gmail.com>
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
 mm/gup.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index ddde097..2eecb16 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1342,16 +1342,19 @@ static long check_and_migrate_cma_pages(struct task_struct *tsk,
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
 		if (is_migrate_cma_page(pages[i])) {
-
-			struct page *head = compound_head(pages[i]);
-
 			if (PageHuge(head)) {
 				isolate_huge_page(head, &cma_page_list);
 			} else {
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

