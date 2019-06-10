Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DD2C468C1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 669B520861
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyT9+FXV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388678AbfFJISS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 04:18:18 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36426 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387825AbfFJISQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 04:18:16 -0400
Received: by mail-pf1-f196.google.com with SMTP id u22so4846609pfm.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 01:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AUEXYFdzqEkxEy/SrRksCebP4SkLARCEQIzpXvm3TGE=;
        b=cyT9+FXVxPoRnYYM8NvG7UpT1wnkiyplF8ecf3XPY/u/iqmkqnAAnZdWqNjLriS4zz
         DUdqN/LhfFSR8pCUIZfJo3MtBe9cBnLzQLwOKqZNmC+R1uzGgA0p0x3M6lmox17kn8Pu
         yLw+iT04RtIlyY/CwHAO+BI0jY/bNRZzg5683q5N717NtzHnBxUtDRRRGZEK9W3+kcNg
         QB3bMXVVpC2s5RuTVAETr1E5R7YdWUqROVDoZTFil92c5xHZSHAP5fM6aOMluEw9nUyI
         zpAur0kHuMojjNVkk6i+wRivdxWSYnTyOG4FjIZsXSCXzEu+xXGrUSOa8ghSoVG65hTL
         I/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=AUEXYFdzqEkxEy/SrRksCebP4SkLARCEQIzpXvm3TGE=;
        b=rp2Bqc3RZ4Hn1xTTOzBHyUB38n3gnKRyhtfsrOi13gVG1txmktEt8nWi3Vau8dQiIO
         Cm3vFbGu8eBEjuKJRzHIyixGdrn2iDBw/Q6S/m6FyNLQhOP0Z0b0gmtRceObKyEEU/Hs
         AMg3bYm21JeGPRmnsoV7fz/giIQbacrEcr5FflR8IgXaqkUQz1joLO08OORbEOYNWGBy
         s+V6SeDUkmVq1q3lYIWbuMfYhwz/urlH1sKXdAj4E9jRv53tsTYvHQA9abQL5br3I5yd
         TiFn/ZReYIzjmhOILmL986UpVesU1NK7Vu91toNyc0kSRl+esd/RwP4/X4nzAu5cEWFu
         J68A==
X-Gm-Message-State: APjAAAXveMhnMPSyce5rfkHYNo+adclR8sFKGU333cbzqzlVyo6yA45M
        H3mHK2spVqLWpu92njeotQ==
X-Google-Smtp-Source: APXvYqyTdzkDJdmW8uNKjt3L6e7/xcwf7fBS/5gUCPV86PSF7LWpuZOi0KDU65PjDXzRwVj6GfgwHQ==
X-Received: by 2002:a17:90a:8982:: with SMTP id v2mr19823294pjn.136.1560154695802;
        Mon, 10 Jun 2019 01:18:15 -0700 (PDT)
Received: from www9186uo.sakura.ne.jp (www9186uo.sakura.ne.jp. [153.121.56.200])
        by smtp.gmail.com with ESMTPSA id j7sm9525014pfa.184.2019.06.10.01.18.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 01:18:15 -0700 (PDT)
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        xishi.qiuxishi@alibaba-inc.com,
        "Chen, Jerry T" <jerry.t.chen@intel.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] mm: hugetlb: soft-offline: dissolve_free_huge_page() return zero on !PageHuge
Date:   Mon, 10 Jun 2019 17:18:06 +0900
Message-Id: <1560154686-18497-3-git-send-email-n-horiguchi@ah.jp.nec.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1560154686-18497-1-git-send-email-n-horiguchi@ah.jp.nec.com>
References: <1560154686-18497-1-git-send-email-n-horiguchi@ah.jp.nec.com>
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
 mm/hugetlb.c        | 15 +++++++++------
 mm/memory-failure.c |  5 +----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git v5.2-rc3/mm/hugetlb.c v5.2-rc3_patched/mm/hugetlb.c
index ac843d3..048d071 100644
--- v5.2-rc3/mm/hugetlb.c
+++ v5.2-rc3_patched/mm/hugetlb.c
@@ -1519,7 +1519,12 @@ int dissolve_free_huge_page(struct page *page)
 	int rc = -EBUSY;
 
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
@@ -1564,11 +1569,9 @@ int dissolve_free_huge_pages(unsigned long start_pfn, unsigned long end_pfn)
 
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
diff --git v5.2-rc3/mm/memory-failure.c v5.2-rc3_patched/mm/memory-failure.c
index 7ea485e..3a83e27 100644
--- v5.2-rc3/mm/memory-failure.c
+++ v5.2-rc3_patched/mm/memory-failure.c
@@ -1859,11 +1859,8 @@ static int soft_offline_in_use_page(struct page *page, int flags)
 
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

