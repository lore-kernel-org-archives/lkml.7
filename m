Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADBBC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 01:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 318BA215F1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 01:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfK1BDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 20:03:48 -0500
Received: from mga04.intel.com ([192.55.52.120]:27439 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727071AbfK1BDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 20:03:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2019 17:03:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,251,1571727600"; 
   d="scan'208";a="221159840"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga002.jf.intel.com with ESMTP; 27 Nov 2019 17:03:44 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org
Cc:     kirill.shutemov@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH 1/2] mm/page_vma_mapped: use PMD_SIZE instead of calculating it
Date:   Thu, 28 Nov 2019 09:03:20 +0800
Message-Id: <20191128010321.21730-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At this point, we are sure page is PageTransHuge, which means
hpage_nr_pages is HPAGE_PMD_NR.

This is safe to use PMD_SIZE instead of calculating it.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 mm/page_vma_mapped.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index eff4b4520c8d..76e03650a3ab 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -223,7 +223,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			if (pvmw->address >= pvmw->vma->vm_end ||
 			    pvmw->address >=
 					__vma_address(pvmw->page, pvmw->vma) +
-					hpage_nr_pages(pvmw->page) * PAGE_SIZE)
+					PMD_SIZE)
 				return not_found(pvmw);
 			/* Did we cross page table boundary? */
 			if (pvmw->address % PMD_SIZE == 0) {
-- 
2.17.1

