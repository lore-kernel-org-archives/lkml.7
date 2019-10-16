Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB15BECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0372082C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbfJPHMv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:12:51 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:41591 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfJPHMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:12:51 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x9G7CXb3003239
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 16 Oct 2019 16:12:33 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9G7CXi3009686;
        Wed, 16 Oct 2019 16:12:33 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9G7BSmS020645;
        Wed, 16 Oct 2019 16:12:33 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.152] [10.38.151.152]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-9539196; Wed, 16 Oct 2019 16:09:26 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC24GP.gisp.nec.co.jp ([10.38.151.152]) with mapi id 14.03.0439.000; Wed,
 16 Oct 2019 16:09:25 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] mm, soft-offline: convert parameter to pfn
Thread-Topic: [PATCH] mm, soft-offline: convert parameter to pfn
Thread-Index: AQHVg/CjSPbKnBteSU6QJtzEs3jIHA==
Date:   Wed, 16 Oct 2019 07:09:24 +0000
Message-ID: <20191016070924.GA10178@hori.linux.bs1.fc.nec.co.jp>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.150]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <5974334D3EC89443ADA33ACB060FCF0D@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I wrote a simple cleanup for parameter of soft_offline_page(),
based on thread https://lkml.org/lkml/2019/10/11/57.

I know that we need more cleanup on hwpoison-inject, but I think
that will be mentioned in re-write patchset Oscar is preparing now.
So let me shared only this part as a separate one now.

Thanks,
Naoya Horiguchi
---
From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Date: Wed, 16 Oct 2019 15:49:00 +0900
Subject: [PATCH] mm, soft-offline: convert parameter to pfn

Currently soft_offline_page() receives struct page, and its sibling
memory_failure() receives pfn. This discrepancy looks weird and makes
precheck on pfn validity tricky. So let's align them.

Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
---
 drivers/base/memory.c | 2 +-
 include/linux/mm.h    | 2 +-
 mm/madvise.c          | 2 +-
 mm/memory-failure.c   | 8 ++++----
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index e5485c22ef77..04e469c82852 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -540,7 +540,7 @@ static ssize_t soft_offline_page_store(struct device *dev,
 	pfn >>= PAGE_SHIFT;
 	if (!pfn_valid(pfn))
 		return -ENXIO;
-	ret = soft_offline_page(pfn_to_page(pfn));
+	ret = soft_offline_page(pfn);
 	return ret == 0 ? count : ret;
 }
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3eba26324ff1..0a452020edf5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2783,7 +2783,7 @@ extern int sysctl_memory_failure_early_kill;
 extern int sysctl_memory_failure_recovery;
 extern void shake_page(struct page *p, int access);
 extern atomic_long_t num_poisoned_pages __read_mostly;
-extern int soft_offline_page(struct page *page);
+extern int soft_offline_page(unsigned long pfn);
 
 
 /*
diff --git a/mm/madvise.c b/mm/madvise.c
index fd221b610b52..df198d1e5e2e 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -893,7 +893,7 @@ static int madvise_inject_error(int behavior,
 		if (behavior == MADV_SOFT_OFFLINE) {
 			pr_info("Soft offlining pfn %#lx at process virtual address %#lx\n",
 				 pfn, start);
-			ret = soft_offline_page(page);
+			ret = soft_offline_page(pfn);
 			if (ret)
 				return ret;
 		} else {
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 4f16e0a7e7cc..eb4fd5e8d5e1 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1514,7 +1514,7 @@ static void memory_failure_work_func(struct work_struct *work)
 		if (!gotten)
 			break;
 		if (entry.flags & MF_SOFT_OFFLINE)
-			soft_offline_page(pfn_to_page(entry.pfn));
+			soft_offline_page(entry.pfn);
 		else
 			memory_failure(entry.pfn, entry.flags);
 	}
@@ -1822,7 +1822,7 @@ static int soft_offline_free_page(struct page *page)
 
 /**
  * soft_offline_page - Soft offline a page.
- * @page: page to offline
+ * @pfn: pfn to soft-offline
  *
  * Returns 0 on success, otherwise negated errno.
  *
@@ -1841,10 +1841,10 @@ static int soft_offline_free_page(struct page *page)
  * This is not a 100% solution for all memory, but tries to be
  * ``good enough'' for the majority of memory.
  */
-int soft_offline_page(struct page *page)
+int soft_offline_page(unsigned long pfn)
 {
 	int ret;
-	unsigned long pfn = page_to_pfn(page);
+	struct page *page = pfn_to_page(pfn);
 
 	if (is_zone_device_page(page)) {
 		pr_debug_ratelimited("soft_offline: %#lx page is device page\n",
-- 
2.17.1

