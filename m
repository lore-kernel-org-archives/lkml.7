Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C5AC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 22:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ABD5206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 22:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfLWWbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 17:31:07 -0500
Received: from mga14.intel.com ([192.55.52.115]:52759 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbfLWWbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 17:31:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Dec 2019 14:30:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,349,1571727600"; 
   d="scan'208";a="207404142"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga007.jf.intel.com with ESMTP; 23 Dec 2019 14:30:51 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [Patch v2] mm/rmap.c: split huge pmd when it really is
Date:   Tue, 24 Dec 2019 06:28:56 +0800
Message-Id: <20191223222856.7189-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When page is not NULL, function is called by try_to_unmap_one() with
TTU_SPLIT_HUGE_PMD set. There are two cases to call try_to_unmap_one()
with TTU_SPLIT_HUGE_PMD set:

  * unmap_page()
  * shrink_page_list()

In both case, the page passed to try_to_unmap_one() is PageHead() of the
THP. If this page's mapping address in process is not HPAGE_PMD_SIZE
aligned, this means the THP is not mapped as PMD THP in this process.
This could happen when we do mremap() a PMD size range to an un-aligned
address.

Currently, this case is handled by following check in __split_huge_pmd()
luckily.

  page != pmd_page(*pmd)

This patch checks the address to skip some work.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

---
v2: move the check into split_huge_pmd_address().
---
 mm/huge_memory.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 893fecd5daa4..2b9c2f412b32 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2342,6 +2342,22 @@ void split_huge_pmd_address(struct vm_area_struct *vma, unsigned long address,
 	pud_t *pud;
 	pmd_t *pmd;
 
+	/*
+	 * When page is not NULL, function is called by try_to_unmap_one()
+	 * with TTU_SPLIT_HUGE_PMD set. There are two places set
+	 * TTU_SPLIT_HUGE_PMD
+	 *
+	 *     unmap_page()
+	 *     shrink_page_list()
+	 *
+	 * In both cases, the "page" here is the PageHead() of a THP.
+	 *
+	 * If the page is not a PMD mapped huge page, e.g. after mremap(), it
+	 * is not necessary to split it.
+	 */
+	if (page && !IS_ALIGNED(address, HPAGE_PMD_SIZE))
+		return;
+
 	pgd = pgd_offset(vma->vm_mm, address);
 	if (!pgd_present(*pgd))
 		return;
-- 
2.17.1

