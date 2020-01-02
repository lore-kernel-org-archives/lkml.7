Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3D4C2D0DE
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 03:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 960CC215A4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 03:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbgABDEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 22:04:25 -0500
Received: from mga14.intel.com ([192.55.52.115]:54253 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727526AbgABDEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 22:04:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jan 2020 19:04:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,385,1571727600"; 
   d="scan'208";a="252112736"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga002.fm.intel.com with ESMTP; 01 Jan 2020 19:04:23 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org, kirill.shutemov@linux.intel.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        richard.weiyang@gmail.com, Wei Yang <richardw.yang@linux.intel.com>
Subject: [RFC PATCH] mm/rmap.c: finer hwpoison granularity for PTE-mapped THP
Date:   Thu,  2 Jan 2020 11:04:21 +0800
Message-Id: <20200102030421.30799-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we behave differently between PMD-mapped THP and PTE-mapped
THP on memory_failure.

User detected difference:

    For PTE-mapped THP, the whole 2M range will trigger MCE after
    memory_failure(), while only 4K range for PMD-mapped THP will.

Direct reason:

    All the 512 PTE entry will be marked as hwpoison entry for a PTE-mapped
    THP while only one PTE will be marked for a PMD-mapped THP.

Root reason:

    The root cause is PTE-mapped page doesn't need to split pmd which skip
    the SPLIT_FREEZE process. This makes try_to_unmap_one() do its job when
    the THP is not splited. And since page is HWPOISON, all the entries in
    THP is marked as hwpoison entry.

    While for the PMD-mapped THP, SPLIT_FREEZE will save migration entry to
    pte and this skip try_to_unmap_one() before THP splited. And then only
    the affected 4k page is marked as hwpoison entry.

This patch tries to provide a finer granularity for PTE-mapped THP by
only mark the affected subpage as hwpoison entry when THP is not
split.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

---
This complicates the picture a little, while I don't find a better way to
improve. 

Also I may miss some case or not handle this properly.

Look forward your comments.
---
 mm/rmap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index b3e381919835..90229917dd64 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1554,10 +1554,11 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 				set_huge_swap_pte_at(mm, address,
 						     pvmw.pte, pteval,
 						     vma_mmu_pagesize(vma));
-			} else {
+			} else if (!PageAnon(page) || page == subpage) {
 				dec_mm_counter(mm, mm_counter(page));
 				set_pte_at(mm, address, pvmw.pte, pteval);
-			}
+			} else
+				goto freeze;
 
 		} else if (pte_unused(pteval) && !userfaultfd_armed(vma)) {
 			/*
@@ -1579,6 +1580,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 			swp_entry_t entry;
 			pte_t swp_pte;
 
+freeze:
 			if (arch_unmap_one(mm, vma, address, pteval) < 0) {
 				set_pte_at(mm, address, pvmw.pte, pteval);
 				ret = false;
-- 
2.17.1

