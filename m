Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2411C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C164C20811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfDWKzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:55:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:52968 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726443AbfDWKzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 06:55:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DF68FAE64;
        Tue, 23 Apr 2019 10:55:01 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        sstabellini@kernel.org, Juergen Gross <jgross@suse.com>
Subject: [PATCH 3/3] xen/swiotlb: remember having called xen_create_contiguous_region()
Date:   Tue, 23 Apr 2019 12:54:57 +0200
Message-Id: <20190423105457.17502-4-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190423105457.17502-1-jgross@suse.com>
References: <20190423105457.17502-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of always calling xen_destroy_contiguous_region() in case the
memory is DMA-able for the used device, do so only in case it has been
made DMA-able via xen_create_contiguous_region() before.

This will avoid a lot of xen_destroy_contiguous_region() calls for
64-bit capable devices.

As the memory in question is owned by swiotlb-xen the PG_owner_priv_1
flag of the first allocated page can be used for remembering.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/swiotlb-xen.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 43b6e65ae256..a72f181d8e20 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -321,6 +321,7 @@ xen_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 			xen_free_coherent_pages(hwdev, size, ret, (dma_addr_t)phys, attrs);
 			return NULL;
 		}
+		SetPageOwnerPriv1(virt_to_page(ret));
 	}
 	memset(ret, 0, size);
 	return ret;
@@ -344,9 +345,11 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
 	/* Convert the size to actually allocated. */
 	size = 1UL << (order + XEN_PAGE_SHIFT);
 
-	if ((dev_addr + size - 1 <= dma_mask) &&
-	    !WARN_ON(range_straddles_page_boundary(phys, size)))
-		xen_destroy_contiguous_region(phys, order);
+	if (PageOwnerPriv1(virt_to_page(vaddr))) {
+		if (!WARN_ON(range_straddles_page_boundary(phys, size)))
+			xen_destroy_contiguous_region(phys, order);
+		ClearPageOwnerPriv1(virt_to_page(vaddr));
+	}
 
 	xen_free_coherent_pages(hwdev, size, vaddr, (dma_addr_t)phys, attrs);
 }
-- 
2.16.4

