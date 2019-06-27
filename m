Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197C6C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 05:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C88ED218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 05:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLjGSXHQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfF0FQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 01:16:21 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42065 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfF0FQV (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 01:16:21 -0400
Received: by mail-pl1-f194.google.com with SMTP id ay6so595128plb.9
        for <Linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 22:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dLHMpSvXQSD083tckUaqr5lCc43yf6mebuGn+jSw2ow=;
        b=hLjGSXHQ3ZySmpg9L0hRhXitIUKUzmq5ycHBXmG8iserze4xv8lurnOhm95Qx/T8+0
         TrfKvR4p7nH6HbcWLxlQULke+4Muh+7TxjjsXB5cUtr61SaAsy4RczXGK/vLuRj8HHWQ
         XGBJTBwp+7kLH4CxfebhqThEtaPZnnG4C7caDEkq+lCUAINs0hP4ZDyxiHqy/0Q1R1Xm
         mLaOU6xmRlcFBlqyyWww7OKiCbbMQSPtX4sFrK+aUht9grjZMeNNp9WPjnr3Up8arurO
         IA5V9kSJUJRHNtLPAA0FhRFxJ2qaenwf9uXIxmsktgVde0aBfje4RNAV+NRwLKomINdu
         R9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dLHMpSvXQSD083tckUaqr5lCc43yf6mebuGn+jSw2ow=;
        b=ZMKLvxzkO1KXpv3a5RXrRQ8tgHc8/a5kr4V9YzOeHxQzrFVAxfTU5HpZ8RUC8/Ky6R
         QR2CU54nZGLoCcECSFuO0zpKU+ipGkNhqQONtKCfn+u48QDHVHJN5X+UKaDgUfyc2Zov
         LV6nkEHMK7DltCNvVSPF0bG1QuMfPDmOjLPu4mr78eZv8MK6p2pNb0cP/QricvoTAhnI
         kT6mQEOCsW/7bwLJOEV7GZtsW+XxI7Tmr8Oj3mAVQFF9N6aEz7jCTNwwhMfh6jvQE40P
         ud8Qd+hdvTONH7WZnnNPRtL1Ha+GZP47gkyvW9NpqR9GzCOOcokK04Op82V8K+MuXE1h
         Hbmg==
X-Gm-Message-State: APjAAAUBjW1YMMI6vrQM7aWQ4jiVPreDLjASCaP2RRyZIPTpEG2B1jcu
        +tF+uwZwwWWYX3KSvJlwGQ==
X-Google-Smtp-Source: APXvYqykoHphjYKkFLbMk8cRKv9nNo4OG3LontM4l5mWgAo0zB4rw4ZWsU/+nRm5s9kiLMS7f8GAwg==
X-Received: by 2002:a17:902:2a27:: with SMTP id i36mr2307823plb.161.1561612580340;
        Wed, 26 Jun 2019 22:16:20 -0700 (PDT)
Received: from mylaptop.redhat.com ([2408:8207:7820:4fb0:dc47:8733:627e:cd6d])
        by smtp.gmail.com with ESMTPSA id k3sm812688pgo.81.2019.06.26.22.16.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 22:16:19 -0700 (PDT)
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
Subject: [PATCHv5] mm/gup: speed up check_and_migrate_cma_pages() on huge page
Date:   Thu, 27 Jun 2019 13:15:45 +0800
Message-Id: <1561612545-28997-1-git-send-email-kernelfans@gmail.com>
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
v4 -> v5: drop the check PageCompound() and improve notes
 mm/gup.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index ddde097..1deaad2 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1336,25 +1336,30 @@ static long check_and_migrate_cma_pages(struct task_struct *tsk,
 					struct vm_area_struct **vmas,
 					unsigned int gup_flags)
 {
-	long i;
+	long i, step;
 	bool drain_allow = true;
 	bool migrate_allow = true;
 	LIST_HEAD(cma_page_list);
 
 check_again:
-	for (i = 0; i < nr_pages; i++) {
+	for (i = 0; i < nr_pages;) {
+
+		struct page *head = compound_head(pages[i]);
+
+		/*
+		 * gup may start from a tail page. Advance step by the left
+		 * part.
+		 */
+		step = (1 << compound_order(head)) - (pages[i] - head);
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
@@ -1369,6 +1374,8 @@ static long check_and_migrate_cma_pages(struct task_struct *tsk,
 				}
 			}
 		}
+
+		i += step;
 	}
 
 	if (!list_empty(&cma_page_list)) {
-- 
2.7.5

