Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CE8C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A005D218AC
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbfJHWTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 18:19:01 -0400
Received: from ale.deltatee.com ([207.54.116.67]:50810 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfJHWSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 18:18:49 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1iHxod-000552-C6; Tue, 08 Oct 2019 16:18:48 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1iHxoa-0003PZ-R0; Tue, 08 Oct 2019 16:18:44 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Joerg Roedel <joro@8bytes.org>
Cc:     Kit Chow <kchow@gigaio.com>, Logan Gunthorpe <logang@deltatee.com>
Date:   Tue,  8 Oct 2019 16:18:35 -0600
Message-Id: <20191008221837.13067-2-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191008221837.13067-1-logang@deltatee.com>
References: <20191008221837.13067-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, joro@8bytes.org, kchow@gigaio.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH 1/3] iommu/amd: Implement dma_[un]map_resource()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kit Chow <kchow@gigaio.com>

Currently the Intel IOMMU uses the default dma_[un]map_resource()
implementations does nothing and simply returns the physical address
unmodified.

However, this doesn't create the IOVA entries necessary for addresses
mapped this way to work when the IOMMU is enabled. Thus, when the
IOMMU is enabled, drivers relying on dma_map_resource() will not get the
propper mapping. We see this when running ntb_transport with the IOMMU
enabled, DMA, and switchtec hardware.

The implementation for the amd version of map_resource() is nearly
identical to map_page(), just with a phys_addr passed instead of a page.
dma_unmap_resource() uses unmap_page() directly as the functions are
identical.

Signed-off-by: Kit Chow <kchow@gigaio.com>
[logang@deltatee.com: Cleaned up into a propper commit and wrote the
    commit message]
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/iommu/amd_iommu.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 2369b8af81f3..aa3d9e705a45 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2553,6 +2553,23 @@ static void unmap_page(struct device *dev, dma_addr_t dma_addr, size_t size,
 	__unmap_single(dma_dom, dma_addr, size, dir);
 }
 
+static dma_addr_t map_resource(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+	struct protection_domain *domain;
+	struct dma_ops_domain *dma_dom;
+
+	domain = get_domain(dev);
+	if (PTR_ERR(domain) == -EINVAL)
+		return (dma_addr_t)paddr;
+	else if (IS_ERR(domain))
+		return DMA_MAPPING_ERROR;
+
+	dma_dom = to_dma_ops_domain(domain);
+
+	return __map_single(dev, dma_dom, paddr, size, dir, *dev->dma_mask);
+}
+
 static int sg_num_pages(struct device *dev,
 			struct scatterlist *sglist,
 			int nelems)
@@ -2795,6 +2812,8 @@ static const struct dma_map_ops amd_iommu_dma_ops = {
 	.unmap_page	= unmap_page,
 	.map_sg		= map_sg,
 	.unmap_sg	= unmap_sg,
+	.map_resource	= map_resource,
+	.unmap_resource	= unmap_page,
 	.dma_supported	= amd_iommu_dma_supported,
 	.mmap		= dma_common_mmap,
 	.get_sgtable	= dma_common_get_sgtable,
-- 
2.20.1

