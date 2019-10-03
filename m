Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABD7C4360C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 03:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC4F222BE
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 03:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbfJCDtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 23:49:49 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:53530 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728693AbfJCDtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 23:49:49 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=luoben@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Te-tQQX_1570074582;
Received: from localhost(mailfrom:luoben@linux.alibaba.com fp:SMTPD_---0Te-tQQX_1570074582)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 03 Oct 2019 11:49:46 +0800
From:   Ben Luo <luoben@linux.alibaba.com>
To:     alex.williamson@redhat.com, aarcange@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] vfio/type1: remove hugepage checks in is_invalid_reserved_pfn()
Date:   Thu,  3 Oct 2019 11:49:42 +0800
Message-Id: <1d6b7e1c40783f2db4c6cb15bf679a94222ec6a3.1570073993.git.luoben@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, no hugepage split code can transfer the reserved bit
from head to tail during the split, so checking the head can't make
a difference in a racing condition with hugepage spliting.

The buddy wouldn't allow a driver to allocate an hugepage if any
subpage is reserved in the e820 map at boot, if any driver sets the
reserved bit of head page before mapping the hugepage in userland,
it needs to set the reserved bit in all subpages to be safe.

Signed-off-by: Ben Luo <luoben@linux.alibaba.com>
---
 drivers/vfio/vfio_iommu_type1.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 054391f..e2019ba 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -287,31 +287,13 @@ static int vfio_lock_acct(struct vfio_dma *dma, long npage, bool async)
  * Some mappings aren't backed by a struct page, for example an mmap'd
  * MMIO range for our own or another device.  These use a different
  * pfn conversion and shouldn't be tracked as locked pages.
+ * For compound pages, any driver that sets the reserved bit in head
+ * page needs to set the reserved bit in all subpages to be safe.
  */
 static bool is_invalid_reserved_pfn(unsigned long pfn)
 {
-	if (pfn_valid(pfn)) {
-		bool reserved;
-		struct page *tail = pfn_to_page(pfn);
-		struct page *head = compound_head(tail);
-		reserved = !!(PageReserved(head));
-		if (head != tail) {
-			/*
-			 * "head" is not a dangling pointer
-			 * (compound_head takes care of that)
-			 * but the hugepage may have been split
-			 * from under us (and we may not hold a
-			 * reference count on the head page so it can
-			 * be reused before we run PageReferenced), so
-			 * we've to check PageTail before returning
-			 * what we just read.
-			 */
-			smp_rmb();
-			if (PageTail(tail))
-				return reserved;
-		}
-		return PageReserved(tail);
-	}
+	if (pfn_valid(pfn))
+		return PageReserved(pfn_to_page(pfn));
 
 	return true;
 }
-- 
1.8.3.1

