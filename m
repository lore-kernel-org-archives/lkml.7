Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831BFC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 09:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF9F2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 09:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfGSJgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 05:36:11 -0400
Received: from inva021.nxp.com ([92.121.34.21]:42360 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfGSJgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 05:36:10 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CCB58200158;
        Fri, 19 Jul 2019 11:36:08 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 71BEB200153;
        Fri, 19 Jul 2019 11:36:04 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C92B4402B5;
        Fri, 19 Jul 2019 17:35:58 +0800 (SGT)
From:   fugang.duan@nxp.com
To:     hch@lst.de, m.szyprowski@samsung.com
Cc:     festevam@gmail.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        aisheng.dong@nxp.com, Fugang Duan <fugang.duan@nxp.com>
Subject: [PATCH dma  1/1] dma-direct: correct the physical addr in dma_direct_sync_sg_for_cpu/device
Date:   Fri, 19 Jul 2019 17:26:48 +0800
Message-Id: <20190719092648.11085-1-fugang.duan@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fugang Duan <fugang.duan@nxp.com>

dma_map_sg() may use swiotlb buffer when kernel parameter include
"swiotlb=force" or the dma_addr is out of dev->dma_mask range. After
DMA complete the memory moving from device to memory, then user call
dma_sync_sg_for_cpu() to sync with DMA buffer, and copy the original
virtual buffer to other space.

So dma_direct_sync_sg_for_cpu() should use swiotlb physical addr, not
the original physical addr from sg_phys(sg).

dma_direct_sync_sg_for_device() also has the similar issue, correct it.

Fixes: 55897af63091("dma-direct: merge swiotlb_dma_ops into the dma_direct code")
Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
---
 kernel/dma/direct.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index b90e1ae..0e87f86 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -242,12 +242,14 @@ void dma_direct_sync_sg_for_device(struct device *dev,
 	int i;
 
 	for_each_sg(sgl, sg, nents, i) {
-		if (unlikely(is_swiotlb_buffer(sg_phys(sg))))
-			swiotlb_tbl_sync_single(dev, sg_phys(sg), sg->length,
+		phys_addr_t paddr = dma_to_phys(dev, sg_dma_address(sg));
+
+		if (unlikely(is_swiotlb_buffer(paddr)))
+			swiotlb_tbl_sync_single(dev, paddr, sg->length,
 					dir, SYNC_FOR_DEVICE);
 
 		if (!dev_is_dma_coherent(dev))
-			arch_sync_dma_for_device(dev, sg_phys(sg), sg->length,
+			arch_sync_dma_for_device(dev, paddr, sg->length,
 					dir);
 	}
 }
@@ -279,11 +281,13 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
 	int i;
 
 	for_each_sg(sgl, sg, nents, i) {
+		phys_addr_t paddr = dma_to_phys(dev, sg_dma_address(sg));
+
 		if (!dev_is_dma_coherent(dev))
-			arch_sync_dma_for_cpu(dev, sg_phys(sg), sg->length, dir);
-	
-		if (unlikely(is_swiotlb_buffer(sg_phys(sg))))
-			swiotlb_tbl_sync_single(dev, sg_phys(sg), sg->length, dir,
+			arch_sync_dma_for_cpu(dev, paddr, sg->length, dir);
+
+		if (unlikely(is_swiotlb_buffer(paddr)))
+			swiotlb_tbl_sync_single(dev, paddr, sg->length, dir,
 					SYNC_FOR_CPU);
 	}
 
-- 
2.7.4

