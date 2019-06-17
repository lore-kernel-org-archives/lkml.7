Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333BFC31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 08:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C192085A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 08:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BX24XRnD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbfFQIv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 04:51:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41298 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbfFQIv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 04:51:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id 83so5406866pgg.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 01:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L8mWMJ9jILM0VSdVVzcyHa6WZylZDmRmVi1FUCOSEVY=;
        b=BX24XRnD9mcuxU5y8Oa30zqFIc5pDvtwSfb7rZGmpl3imko20lYhU//Bls+Zloo2y5
         nxMjyClpkK8fjDyizpK7Jvcys6+zr4O7u1rsBPeQb9aC85PkA+qGhdTvSvqQ3yTnU8NQ
         MzDTKxJ3m5Bp4rKftQoCYUNPPoDv3hpaT5AlsaA8f6atLoo3HBA7of+OxJJj/xxTM6ii
         hyM7jJgRct8/DwZKm7UZp4PrQ8jHR3B4qHz9cnERywIvc+poTqpaGNeGpTJXL5j9Ezro
         MQSWz3P0qgJFYLArRvOO1ftRTcJ2sfw8G2mXj/+xgMJic0iYtQqU0Im4lg2swjBn+aRB
         uArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=L8mWMJ9jILM0VSdVVzcyHa6WZylZDmRmVi1FUCOSEVY=;
        b=ZCkQpbSNVu0hG40Uq801ykX4ptiwxFn6AVQAOHX7xHZqFJa2xkNH5+WaLZ7Lm184Dv
         TL4eq1Go9BsUzU30IF0rXDpqrDG6d6lDaZszyzkqDdYJCq3gnS1I4GNnbVuZUddOuWPM
         M2RnbChvow3bagO6fiAiKQHNUHT0pxOVpPTWK919yVLUUXYCCQfruJU8ibKbdfJN9CxO
         NsPvoi/oF0dmMjrYYCM4KieiDpxMjHJ3Oq/kEIq0LNqa1j5V2lv7JtTPqg+PEyzX7756
         j6Sh9dMnx0/1y/E7wpYpQDeprKsKwqhBv/g6bVLZh8xQ3CW31jIiaWNLWaq4KiMjleI/
         xshw==
X-Gm-Message-State: APjAAAViQlvJu58zJNOlOQn9b9OhJODl5BnKU1KQP+nLSYY1mrH5acYt
        Cr6WFgSNUCpsEJ179178uKvjL2zqUQ==
X-Google-Smtp-Source: APXvYqzHCOPshltv7hAFRfCkbOCP9mHhWYQ8Pjr/OptiujEWUn1vBUKUu0mplvCVt9MCeghIvwqnsg==
X-Received: by 2002:a17:90a:30e4:: with SMTP id h91mr24031628pjb.37.1560761486527;
        Mon, 17 Jun 2019 01:51:26 -0700 (PDT)
Received: from www9186uo.sakura.ne.jp (www9186uo.sakura.ne.jp. [153.121.56.200])
        by smtp.gmail.com with ESMTPSA id d4sm9443514pju.19.2019.06.17.01.51.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 01:51:26 -0700 (PDT)
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        xishi.qiuxishi@alibaba-inc.com,
        "Chen, Jerry T" <jerry.t.chen@intel.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v3 2/2] mm: hugetlb: soft-offline: dissolve_free_huge_page() return zero on !PageHuge
Date:   Mon, 17 Jun 2019 17:51:16 +0900
Message-Id: <1560761476-4651-3-git-send-email-n-horiguchi@ah.jp.nec.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1560761476-4651-1-git-send-email-n-horiguchi@ah.jp.nec.com>
References: <1560761476-4651-1-git-send-email-n-horiguchi@ah.jp.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

madvise(MADV_SOFT_OFFLINE) often returns -EBUSY when calling soft offline
for hugepages with overcommitting enabled. That was caused by the suboptimal
code in current soft-offline code. See the following part:

    ret = migrate_pages(&pagelist, new_page, NULL, MPOL_MF_MOVE_ALL,
                            MIGRATE_SYNC, MR_MEMORY_FAILURE);
    if (ret) {
            ...
    } else {
            /*
             * We set PG_hwpoison only when the migration source hugepage
             * was successfully dissolved, because otherwise hwpoisoned
             * hugepage remains on free hugepage list, then userspace will
             * find it as SIGBUS by allocation failure. That's not expected
             * in soft-offlining.
             */
            ret = dissolve_free_huge_page(page);
            if (!ret) {
                    if (set_hwpoison_free_buddy_page(page))
                            num_poisoned_pages_inc();
            }
    }
    return ret;

Here dissolve_free_huge_page() returns -EBUSY if the migration source page
was freed into buddy in migrate_pages(), but even in that case we actually
has a chance that set_hwpoison_free_buddy_page() succeeds. So that means
current code gives up offlining too early now.

dissolve_free_huge_page() checks that a given hugepage is suitable for
dissolving, where we should return success for !PageHuge() case because
the given hugepage is considered as already dissolved.

This change also affects other callers of dissolve_free_huge_page(),
which are cleaned up together.

Reported-by: Chen, Jerry T <jerry.t.chen@intel.com>
Tested-by: Chen, Jerry T <jerry.t.chen@intel.com>
Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Fixes: 6bc9b56433b76 ("mm: fix race on soft-offlining")
Cc: <stable@vger.kernel.org> # v4.19+
---
ChangeLog v2->v3:
- add PageHuge check in dissolve_free_huge_page() outside hugetlb_lock
- update comment on dissolve_free_huge_page() about return value
---
 mm/hugetlb.c        | 29 ++++++++++++++++++++---------
 mm/memory-failure.c |  5 +----
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git v5.2-rc4/mm/hugetlb.c v5.2-rc4_patched/mm/hugetlb.c
index ac843d3..ede7e7f 100644
--- v5.2-rc4/mm/hugetlb.c
+++ v5.2-rc4_patched/mm/hugetlb.c
@@ -1510,16 +1510,29 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
 
 /*
  * Dissolve a given free hugepage into free buddy pages. This function does
- * nothing for in-use (including surplus) hugepages. Returns -EBUSY if the
- * dissolution fails because a give page is not a free hugepage, or because
- * free hugepages are fully reserved.
+ * nothing for in-use hugepages and non-hugepages.
+ * This function returns values like below:
+ *
+ *  -EBUSY: failed to dissolved free hugepages or the hugepage is in-use
+ *          (allocated or reserved.)
+ *       0: successfully dissolved free hugepages or the page is not a
+ *          hugepage (considered as already dissolved)
  */
 int dissolve_free_huge_page(struct page *page)
 {
 	int rc = -EBUSY;
 
+	/* Not to disrupt normal path by vainly holding hugetlb_lock */
+	if (!PageHuge(page))
+		return 0;
+
 	spin_lock(&hugetlb_lock);
-	if (PageHuge(page) && !page_count(page)) {
+	if (!PageHuge(page)) {
+		rc = 0;
+		goto out;
+	}
+
+	if (!page_count(page)) {
 		struct page *head = compound_head(page);
 		struct hstate *h = page_hstate(head);
 		int nid = page_to_nid(head);
@@ -1564,11 +1577,9 @@ int dissolve_free_huge_pages(unsigned long start_pfn, unsigned long end_pfn)
 
 	for (pfn = start_pfn; pfn < end_pfn; pfn += 1 << minimum_order) {
 		page = pfn_to_page(pfn);
-		if (PageHuge(page) && !page_count(page)) {
-			rc = dissolve_free_huge_page(page);
-			if (rc)
-				break;
-		}
+		rc = dissolve_free_huge_page(page);
+		if (rc)
+			break;
 	}
 
 	return rc;
diff --git v5.2-rc4/mm/memory-failure.c v5.2-rc4_patched/mm/memory-failure.c
index 8ee7b16..d9cc660 100644
--- v5.2-rc4/mm/memory-failure.c
+++ v5.2-rc4_patched/mm/memory-failure.c
@@ -1856,11 +1856,8 @@ static int soft_offline_in_use_page(struct page *page, int flags)
 
 static int soft_offline_free_page(struct page *page)
 {
-	int rc = 0;
-	struct page *head = compound_head(page);
+	int rc = dissolve_free_huge_page(page);
 
-	if (PageHuge(head))
-		rc = dissolve_free_huge_page(page);
 	if (!rc) {
 		if (set_hwpoison_free_buddy_page(page))
 			num_poisoned_pages_inc();
-- 
2.7.0

