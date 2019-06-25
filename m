Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E17CC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071062146E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r80m0NId"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbfFYONq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 10:13:46 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42763 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbfFYONq (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 10:13:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so9551099pff.9
        for <Linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 07:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nqUjvEpbHa4bmVVbiNY3TsSLDN/ESHjmI3nWhtZpm64=;
        b=r80m0NIdXLhEvaCqjUKhJX37qFh2W1g6cDf7weUm9jbNptPWp80pEUI9opw6H9gm50
         dNmhZXvCVB7xW0waafhq+LNBKV0JsgcA+qJLihBKEqAxTl87fkXs4vfs5m1RU6Ny1EUw
         xzHPIbBFyf5f0niEY2MbY1DGMxmKWiAaYEZLHWvQXKC6NDcTNZnPWnviqEIe2vTnY2I8
         v71WGhMfREL1Z5sxRTnGFOLtHP+T7LaFHL+uUCVZ+eGH8HuKVjbuAh7ZTJAEM7He/MYd
         r3R2cpD5S2eqqQPrPqIOM5OJ1ikTC7a4MnE9EfCIyVJrY8VYTEmwMnScWHDiyGbLNS/r
         46eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nqUjvEpbHa4bmVVbiNY3TsSLDN/ESHjmI3nWhtZpm64=;
        b=HmV2L4tYuumFEcT+I51LuVBkbymCEJbFmhaP6AjdHPpEx+7puMvRtIVVoN6C7zKGvV
         qYn5+BGmF33dtU3Ti/pgeU2OcN+IglYY03RmlR0kvrUeBlWGeY5mX+9SJNT3EW0o7SWG
         rcFn3B8PCQeHk0XHYkaRn5bmuwLPC+gExVm18okiI24hIivYjzqGWMlZ5h7S2CFs+FNh
         yBbQVlUaiXYFkYrcUdFKHNUZlI5JWSM1aDIXJ+O1GBVlUJhDloYQ+Rn5X3AKJQC2wUls
         wOv/joMw7hqhQ1RKMk6NFypwXtmXHmbNIYVfsrBnUrZhLZ6xpbxancQOfHdU8kTetW47
         gukA==
X-Gm-Message-State: APjAAAUis4OBBSoR0RI+woPU+QrckTK87+caCHcB/LK1BWG0r1zHmy3P
        hkCec2cPETq2/UKnLZvOZg==
X-Google-Smtp-Source: APXvYqwBAkDTfGiLDfKt1+XLvKyU+gy/E6/TGdVcHhUhqGlY5n9j0/Z2+O2ED2nwS5zoHJYeucBMew==
X-Received: by 2002:a63:4f46:: with SMTP id p6mr7708849pgl.268.1561472025302;
        Tue, 25 Jun 2019 07:13:45 -0700 (PDT)
Received: from mylaptop.redhat.com ([2408:8207:7826:5c10:8935:c645:2c30:74ef])
        by smtp.gmail.com with ESMTPSA id d9sm15953790pgj.34.2019.06.25.07.13.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 07:13:44 -0700 (PDT)
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
Subject: [PATCHv3] mm/gup: speed up check_and_migrate_cma_pages() on huge page
Date:   Tue, 25 Jun 2019 22:13:19 +0800
Message-Id: <1561471999-6688-1-git-send-email-kernelfans@gmail.com>
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
v2 -> v3: fix page order to size convertion

 mm/gup.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index ddde097..03cc1f4 100644
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
+			step = 1 << compound_order(head) - (pages[i] - head);
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

