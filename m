Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3CEC31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 05:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D1A12133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 05:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfFNFqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 01:46:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:44204 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725843AbfFNFqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 01:46:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 038FEAEB8;
        Fri, 14 Jun 2019 05:46:07 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH v3 2/3] xen/swiotlb: simplify range_straddles_page_boundary()
Date:   Fri, 14 Jun 2019 07:46:03 +0200
Message-Id: <20190614054604.30101-3-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190614054604.30101-1-jgross@suse.com>
References: <20190614054604.30101-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

range_straddles_page_boundary() is open coding several macros from
include/xen/page.h. Use those instead. Additionally there is no need
to have check_pages_physically_contiguous() as a separate function as
it is used only once, so merge it into range_straddles_page_boundary().

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 drivers/xen/swiotlb-xen.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 50fd7de54969..37ddcfcfbb21 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -83,34 +83,18 @@ static inline dma_addr_t xen_virt_to_bus(void *address)
 	return xen_phys_to_bus(virt_to_phys(address));
 }
 
-static int check_pages_physically_contiguous(unsigned long xen_pfn,
-					     unsigned int offset,
-					     size_t length)
+static inline int range_straddles_page_boundary(phys_addr_t p, size_t size)
 {
-	unsigned long next_bfn;
-	int i;
-	int nr_pages;
+	unsigned long next_bfn, xen_pfn = XEN_PFN_DOWN(p);
+	unsigned int i, nr_pages = XEN_PFN_UP(xen_offset_in_page(p) + size);
 
 	next_bfn = pfn_to_bfn(xen_pfn);
-	nr_pages = (offset + length + XEN_PAGE_SIZE-1) >> XEN_PAGE_SHIFT;
 
-	for (i = 1; i < nr_pages; i++) {
+	for (i = 1; i < nr_pages; i++)
 		if (pfn_to_bfn(++xen_pfn) != ++next_bfn)
-			return 0;
-	}
-	return 1;
-}
+			return 1;
 
-static inline int range_straddles_page_boundary(phys_addr_t p, size_t size)
-{
-	unsigned long xen_pfn = XEN_PFN_DOWN(p);
-	unsigned int offset = p & ~XEN_PAGE_MASK;
-
-	if (offset + size <= XEN_PAGE_SIZE)
-		return 0;
-	if (check_pages_physically_contiguous(xen_pfn, offset, size))
-		return 0;
-	return 1;
+	return 0;
 }
 
 static int is_xen_swiotlb_buffer(dma_addr_t dma_addr)
-- 
2.16.4

