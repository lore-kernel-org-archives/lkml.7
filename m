Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F6FC07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 902DE204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlkrPsci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfE0GGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 02:06:46 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41978 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfE0GGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 02:06:46 -0400
Received: by mail-pl1-f194.google.com with SMTP id d14so1082358pls.8
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 23:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=J+flJg4D+B292+R0mjnCGOvi2ClGFqVNzhwfO4APIzk=;
        b=OlkrPsciOkbhWZp3PP44UreYr8KL5SZwPqqMfrHRqMPhAIRFfzi8ZkB26S4HuYnWXf
         eL/2+2N+Ct1wjX1UiIPfIe29z48HiAE2LS0lX+Tv362vNKl/wkXZYhh4Ym5kTUK0YmiP
         Ht1PEIMm9bkr6Wd7JTRmdqTfGesPel0ffT/ILlMLbUBvKOVXFoWlXe+lRTMbJNwBmoZ0
         5HlvHblnBsRhv/7CxEKdnLRDjcNugmUknRqpexNkhwq8Q5H0+EFwbGhf7wVl2yzEnDds
         RTcGgj3AQRwXjhWuCqq9yGeQW7qlongtT5ABvk5WRKh8cMmv4++nywV0CY13wjDO20ki
         5bgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=J+flJg4D+B292+R0mjnCGOvi2ClGFqVNzhwfO4APIzk=;
        b=EpWaNuHMeCBVN5CGcAHtu57BiP19zEDoPI2CkilaN78B6nWVe7oIY3mKZBXiRGI/L8
         QTvYph7lUluKGVM6qm1kZFLdnJ1a1+Xv8FuqTG0KD9HNv6uwWHgSLl4PLW/1plngJgYq
         3DK+oQm1fGTYW0HLesYDcN0KorB3Gke6+J42RND6Dgl558x+zv+zGxy1jNyeOzaqHxs7
         +wpGMmI12+xXzMBdgoTtyV8CDhIfmJgUBqUzZ1qsOX8OhcGSY/f/XDiDEnd2xzFNLLnz
         P5dnFlA+hCSDYw82TQo/UIfISEFLafelwxzlpcSk4OA20bKs3FF+3CDrnGXiXlcngCIF
         zgQA==
X-Gm-Message-State: APjAAAXsm5m8F53mEibQytBA5CoaC/7NzfdplqgL6eN9DQcwbfE3owe9
        pKGkc505oAHYLpVQ4SXzug==
X-Google-Smtp-Source: APXvYqwcJ9eOvwbIDlqK3f4QPizo7yl9wzvO6W3lyPysMIRbzpS6HwEeDl/L8G/QTThaFCHQWOAOmg==
X-Received: by 2002:a17:902:2ba7:: with SMTP id l36mr29760193plb.334.1558937205300;
        Sun, 26 May 2019 23:06:45 -0700 (PDT)
Received: from www9186uo.sakura.ne.jp (www9186uo.sakura.ne.jp. [153.121.56.200])
        by smtp.gmail.com with ESMTPSA id b4sm9939550pfd.120.2019.05.26.23.06.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 23:06:44 -0700 (PDT)
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        xishi.qiuxishi@alibaba-inc.com,
        "Chen, Jerry T" <jerry.t.chen@intel.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v1] mm: hugetlb: soft-offline: fix wrong return value of soft offline
Date:   Mon, 27 May 2019 15:06:40 +0900
Message-Id: <1558937200-18544-1-git-send-email-n-horiguchi@ah.jp.nec.com>
X-Mailer: git-send-email 2.7.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Soft offline events for hugetlb pages return -EBUSY when page migration
succeeded and dissolve_free_huge_page() failed, which can happen when
there're surplus hugepages. We should judge pass/fail of soft offline by
checking whether the raw error page was finally contained or not (i.e.
the result of set_hwpoison_free_buddy_page()), so this behavior is wrong.

This problem was introduced by the following change of commit 6bc9b56433b76
("mm: fix race on soft-offlining"):

                    if (ret > 0)
                            ret = -EIO;
            } else {
    -               if (PageHuge(page))
    -                       dissolve_free_huge_page(page);
    +               /*
    +                * We set PG_hwpoison only when the migration source hugepage
    +                * was successfully dissolved, because otherwise hwpoisoned
    +                * hugepage remains on free hugepage list, then userspace will
    +                * find it as SIGBUS by allocation failure. That's not expected
    +                * in soft-offlining.
    +                */
    +               ret = dissolve_free_huge_page(page);
    +               if (!ret) {
    +                       if (set_hwpoison_free_buddy_page(page))
    +                               num_poisoned_pages_inc();
    +               }
            }
            return ret;
     }

, so a simple fix is to restore the PageHuge precheck, but my code
reading shows that we already have PageHuge check in
dissolve_free_huge_page() with hugetlb_lock, which is better place to
check it.  And currently dissolve_free_huge_page() returns -EBUSY for
!PageHuge but that's simply wrong because that that case should be
considered as success (meaning that "the given hugetlb was already
dissolved.")

This change affects other callers of dissolve_free_huge_page(),
which are also cleaned up by this patch.

Reported-by: Chen, Jerry T <jerry.t.chen@intel.com>
Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Fixes: 6bc9b56433b76 ("mm: fix race on soft-offlining")
Cc: <stable@vger.kernel.org> # v4.19+
---
 mm/hugetlb.c        | 15 +++++++++------
 mm/memory-failure.c |  7 +++----
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git v5.1-rc6-mmotm-2019-04-25-16-30/mm/hugetlb.c v5.1-rc6-mmotm-2019-04-25-16-30_patched/mm/hugetlb.c
index bf58cee..385899f 100644
--- v5.1-rc6-mmotm-2019-04-25-16-30/mm/hugetlb.c
+++ v5.1-rc6-mmotm-2019-04-25-16-30_patched/mm/hugetlb.c
@@ -1518,7 +1518,12 @@ int dissolve_free_huge_page(struct page *page)
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
@@ -1563,11 +1568,9 @@ int dissolve_free_huge_pages(unsigned long start_pfn, unsigned long end_pfn)
 
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
diff --git v5.1-rc6-mmotm-2019-04-25-16-30/mm/memory-failure.c v5.1-rc6-mmotm-2019-04-25-16-30_patched/mm/memory-failure.c
index fc8b517..3a83e27 100644
--- v5.1-rc6-mmotm-2019-04-25-16-30/mm/memory-failure.c
+++ v5.1-rc6-mmotm-2019-04-25-16-30_patched/mm/memory-failure.c
@@ -1733,6 +1733,8 @@ static int soft_offline_huge_page(struct page *page, int flags)
 		if (!ret) {
 			if (set_hwpoison_free_buddy_page(page))
 				num_poisoned_pages_inc();
+			else
+				ret = -EBUSY;
 		}
 	}
 	return ret;
@@ -1857,11 +1859,8 @@ static int soft_offline_in_use_page(struct page *page, int flags)
 
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

