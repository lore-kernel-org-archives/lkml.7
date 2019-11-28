Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8F1C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 01:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC5E2158A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 01:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfK1BDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 20:03:48 -0500
Received: from mga06.intel.com ([134.134.136.31]:2536 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727071AbfK1BDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 20:03:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2019 17:03:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,251,1571727600"; 
   d="scan'208";a="217486814"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga001.fm.intel.com with ESMTP; 27 Nov 2019 17:03:46 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org
Cc:     kirill.shutemov@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH 2/2] mm/page_vma_mapped: page table boundary is already guaranteed
Date:   Thu, 28 Nov 2019 09:03:21 +0800
Message-Id: <20191128010321.21730-2-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191128010321.21730-1-richardw.yang@linux.intel.com>
References: <20191128010321.21730-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check here is to guarantee pvmw->address iteration is limited in one
page table boundary. To be specific, here the address range should be in
one PMD_SIZE.

If my understanding is correct, this check is already done in the above
check:

    address >= __vma_address(page, vma) + PMD_SIZE

The boundary check here seems not necessary.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

---
Test:
   more than 48 hours kernel build test shows this code is not touched.
---
 mm/page_vma_mapped.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 76e03650a3ab..25aada8a1271 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -163,7 +163,6 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			return not_found(pvmw);
 		return true;
 	}
-restart:
 	pgd = pgd_offset(mm, pvmw->address);
 	if (!pgd_present(*pgd))
 		return false;
@@ -225,17 +224,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 					__vma_address(pvmw->page, pvmw->vma) +
 					PMD_SIZE)
 				return not_found(pvmw);
-			/* Did we cross page table boundary? */
-			if (pvmw->address % PMD_SIZE == 0) {
-				pte_unmap(pvmw->pte);
-				if (pvmw->ptl) {
-					spin_unlock(pvmw->ptl);
-					pvmw->ptl = NULL;
-				}
-				goto restart;
-			} else {
-				pvmw->pte++;
-			}
+			pvmw->pte++;
 		} while (pte_none(*pvmw->pte));
 
 		if (!pvmw->ptl) {
-- 
2.17.1

