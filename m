Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04007C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D032B20830
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfCDUAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:00:54 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:47069 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfCDUAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:00:53 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M2OEw-1gy9vZ29nS-003r1z; Mon, 04 Mar 2019 20:59:55 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>, xen-devel@lists.xenproject.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "swiotlb: remove SWIOTLB_MAP_ERROR"
Date:   Mon,  4 Mar 2019 20:59:03 +0100
Message-Id: <20190304195951.1118807-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:oKzDNU8DH2UnV62YSntTNjreQfXMO+Px9S/SDQxFFaCgzjoour3
 T1Ymdle+3p1Re9yaMA3kI7vy6LYlUiZ7aG67KLdH98LCm0w4HZPF86gWg02Q18xWTO4KCLW
 NcYjWfX6l0ZHbC9vqs2nzrCW3/ZktwED6vOFrdmh9uO3vHWSE9srEJ8aKaB1bNLsq/dQR4N
 myGSYE5Ke2sEeku88MNfg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pEc3eJfWFzI=:ZoKfOofzlwVpnLTyG7fwsJ
 Iifc2JeswfHJuEMwo6pX2jP2DgVfTgGOfBb8uqYtLupfau8l1sgNzLVCiAsJhIKdeAwfG8mze
 jtqB+Vnvfxwh+UX1EKqfEh8SG+vAlaZg7BnvDsg96NEPjwabYn6hZRB97+RGYbU0QF5cBzLqP
 gOwOCff/bHLi9YX/0nlydknS6SR1/216+aetb9Vj16zk44IzHpr0qgsvQVfhcejeReirGKzKD
 Luw1/nV0lEXoX7uDj6hSsp6MpbOA7ALoyy42Wiokzt0HcX5CToWKXJCY+lnfuvcecCgR0B7iO
 1E78EUlgphhHpTf7QO2ttWuPH8qftjpavm94X32wArj0U5l5rV0TNVriP4WYsbt3ABQwvp+Jk
 H/oiPB7UNeN6ypXcXLQ4CCM0bVYHBmfkYfRz3Zuuq02GPIj+7CFc1rNdl8JCrHnjkD+Bo2FFZ
 t74+vNMNy0vSONsHHTKzM1h0HijyXsCb048QiBr9uS7HgGGhGF1uZtPHfWTRNO3nvhDYEGt08
 /WXPBzTe2eZpTFzE4Mq3wDniECT8kJnWQWOR/Zzj/C/oEImlUJQoPipKp7NhEKib29PWSwPH8
 KaVOtiNzHmXfjHd7Z0oAXsDgkEjwz9aVfqgnV4Hq6F7Bu86xCDSdbUJ837UPmxuCcPWWQ+PHm
 MgP/9uBlBBJ0noUlR6oC+nBzlJrsar904VPdn6vHsnW0fhVXz9W7iqhdNJpmFrrul49TGAc8V
 mzbntpGlGoFQmxKln4ft1+6s7mDsw8TW5dej+Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit b907e20508d0 ("swiotlb: remove SWIOTLB_MAP_ERROR"), which
introduced an overflow warning in configurations that have a larger
dma_addr_t than phys_addr_t:

In file included from include/linux/dma-direct.h:5,
                 from kernel/dma/swiotlb.c:23:
kernel/dma/swiotlb.c: In function 'swiotlb_tbl_map_single':
include/linux/dma-mapping.h:136:28: error: conversion from 'long long unsigned int' to 'phys_addr_t' {aka 'unsigned int'} changes value from '18446744073709551615' to '4294967295' [-Werror=overflow]
 #define DMA_MAPPING_ERROR  (~(dma_addr_t)0)
                            ^
kernel/dma/swiotlb.c:544:9: note: in expansion of macro 'DMA_MAPPING_ERROR'
  return DMA_MAPPING_ERROR;

The configuration that caused this is on 32-bit ARM, where the DMA address
space depends on the enabled hardware platforms, while the physical
address space depends on the type of MMU chosen (classic vs LPAE).

I tried a couple of alternative approaches, but the previous version
seems as good as any other, so I went back to that.

Fixes: b907e20508d0 ("swiotlb: remove SWIOTLB_MAP_ERROR")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/xen/swiotlb-xen.c | 4 ++--
 include/linux/swiotlb.h   | 3 +++
 kernel/dma/swiotlb.c      | 4 ++--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 877baf2a94f4..57a98279bf4f 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -406,7 +406,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 
 	map = swiotlb_tbl_map_single(dev, start_dma_addr, phys, size, dir,
 				     attrs);
-	if (map == DMA_MAPPING_ERROR)
+	if (map == SWIOTLB_MAP_ERROR)
 		return DMA_MAPPING_ERROR;
 
 	dev_addr = xen_phys_to_bus(map);
@@ -557,7 +557,7 @@ xen_swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
 								 sg_phys(sg),
 								 sg->length,
 								 dir, attrs);
-			if (map == DMA_MAPPING_ERROR) {
+			if (map == SWIOTLB_MAP_ERROR) {
 				dev_warn(hwdev, "swiotlb buffer is full\n");
 				/* Don't panic here, we expect map_sg users
 				   to do proper error handling. */
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 361f62bb4a8e..a65a36551f58 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -44,6 +44,9 @@ enum dma_sync_target {
 	SYNC_FOR_DEVICE = 1,
 };
 
+/* define the last possible byte of physical address space as a mapping error */
+#define SWIOTLB_MAP_ERROR (~(phys_addr_t)0x0)
+
 extern phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 					  dma_addr_t tbl_dma_addr,
 					  phys_addr_t phys, size_t size,
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 12059b78b631..922880b84387 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -541,7 +541,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 	spin_unlock_irqrestore(&io_tlb_lock, flags);
 	if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())
 		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes)\n", size);
-	return DMA_MAPPING_ERROR;
+	return SWIOTLB_MAP_ERROR;
 found:
 	io_tlb_used += nslots;
 	spin_unlock_irqrestore(&io_tlb_lock, flags);
@@ -659,7 +659,7 @@ bool swiotlb_map(struct device *dev, phys_addr_t *phys, dma_addr_t *dma_addr,
 	/* Oh well, have to allocate and map a bounce buffer. */
 	*phys = swiotlb_tbl_map_single(dev, __phys_to_dma(dev, io_tlb_start),
 			*phys, size, dir, attrs);
-	if (*phys == DMA_MAPPING_ERROR)
+	if (*phys == SWIOTLB_MAP_ERROR)
 		return false;
 
 	/* Ensure that the address returned is DMA'ble */
-- 
2.20.0

