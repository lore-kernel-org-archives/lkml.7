Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99349C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 14:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE0B21D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 14:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436733AbfIYOQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 10:16:11 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:50702 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407539AbfIYOQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 10:16:10 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iD85O-0000DA-Sg; Wed, 25 Sep 2019 15:16:06 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iD85O-00065b-74; Wed, 25 Sep 2019 15:16:06 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 1/4] arm: make unexported items static
Date:   Wed, 25 Sep 2019 15:16:01 +0100
Message-Id: <20190925141604.23364-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixup the following sparse warnings by making the functions and structures
static.

arch/arm/mm/dma-mapping.c:1562:6: warning: symbol '__arm_iommu_free_attrs' was not declared. Should it be static?
arch/arm/mm/dma-mapping.c:1586:6: warning: symbol 'arm_iommu_free_attrs' was not declared. Should it be static?
arch/arm/mm/dma-mapping.c:1592:6: warning: symbol 'arm_coherent_iommu_free_attrs' was not declared. Should it be static?
arch/arm/mm/dma-mapping.c:1716:5: warning: symbol 'arm_coherent_iommu_map_sg' was not declared. Should it be static?
arch/arm/mm/dma-mapping.c:1734:5: warning: symbol 'arm_iommu_map_sg' was not declared. Should it be static?
arch/arm/mm/dma-mapping.c:1767:6: warning: symbol 'arm_coherent_iommu_unmap_sg' was not declared. Should it be static?
arch/arm/mm/dma-mapping.c:1784:6: warning: symbol 'arm_iommu_unmap_sg' was not declared. Should it be static?
arch/arm/mm/dma-mapping.c:1798:6: warning: symbol 'arm_iommu_sync_sg_for_cpu' was not declared. Should it be static?
arch/arm/mm/dma-mapping.c:1816:6: warning: symbol 'arm_iommu_sync_sg_for_device' was not declared. Should it be static?
arch/arm/mm/dma-mapping.c:2018:26: warning: symbol 'iommu_ops' was not declared. Should it be static?
arch/arm/mm/dma-mapping.c:2040:26: warning: symbol 'iommu_coherent_ops' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/mm/dma-mapping.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 7d042d5c43e3..54d2dd55363a 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1559,7 +1559,7 @@ static int arm_coherent_iommu_mmap_attrs(struct device *dev,
  * free a page as defined by the above mapping.
  * Must not be called with IRQs disabled.
  */
-void __arm_iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
+static void __arm_iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 	dma_addr_t handle, unsigned long attrs, int coherent_flag)
 {
 	struct page **pages;
@@ -1583,13 +1583,14 @@ void __arm_iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 	__iommu_free_buffer(dev, pages, size, attrs);
 }
 
-void arm_iommu_free_attrs(struct device *dev, size_t size,
-		    void *cpu_addr, dma_addr_t handle, unsigned long attrs)
+static void arm_iommu_free_attrs(struct device *dev, size_t size,
+				 void *cpu_addr, dma_addr_t handle,
+				 unsigned long attrs)
 {
 	__arm_iommu_free_attrs(dev, size, cpu_addr, handle, attrs, NORMAL);
 }
 
-void arm_coherent_iommu_free_attrs(struct device *dev, size_t size,
+static void arm_coherent_iommu_free_attrs(struct device *dev, size_t size,
 		    void *cpu_addr, dma_addr_t handle, unsigned long attrs)
 {
 	__arm_iommu_free_attrs(dev, size, cpu_addr, handle, attrs, COHERENT);
@@ -1713,7 +1714,7 @@ static int __iommu_map_sg(struct device *dev, struct scatterlist *sg, int nents,
  * possible) and tagged with the appropriate dma address and length. They are
  * obtained via sg_dma_{address,length}.
  */
-int arm_coherent_iommu_map_sg(struct device *dev, struct scatterlist *sg,
+static int arm_coherent_iommu_map_sg(struct device *dev, struct scatterlist *sg,
 		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
 	return __iommu_map_sg(dev, sg, nents, dir, attrs, true);
@@ -1731,7 +1732,7 @@ int arm_coherent_iommu_map_sg(struct device *dev, struct scatterlist *sg,
  * tagged with the appropriate dma address and length. They are obtained via
  * sg_dma_{address,length}.
  */
-int arm_iommu_map_sg(struct device *dev, struct scatterlist *sg,
+static int arm_iommu_map_sg(struct device *dev, struct scatterlist *sg,
 		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
 	return __iommu_map_sg(dev, sg, nents, dir, attrs, false);
@@ -1764,8 +1765,8 @@ static void __iommu_unmap_sg(struct device *dev, struct scatterlist *sg,
  * Unmap a set of streaming mode DMA translations.  Again, CPU access
  * rules concerning calls here are the same as for dma_unmap_single().
  */
-void arm_coherent_iommu_unmap_sg(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir,
+static void arm_coherent_iommu_unmap_sg(struct device *dev,
+		struct scatterlist *sg, int nents, enum dma_data_direction dir,
 		unsigned long attrs)
 {
 	__iommu_unmap_sg(dev, sg, nents, dir, attrs, true);
@@ -1781,9 +1782,10 @@ void arm_coherent_iommu_unmap_sg(struct device *dev, struct scatterlist *sg,
  * Unmap a set of streaming mode DMA translations.  Again, CPU access
  * rules concerning calls here are the same as for dma_unmap_single().
  */
-void arm_iommu_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
-			enum dma_data_direction dir,
-			unsigned long attrs)
+static void arm_iommu_unmap_sg(struct device *dev,
+			       struct scatterlist *sg, int nents,
+			       enum dma_data_direction dir,
+			       unsigned long attrs)
 {
 	__iommu_unmap_sg(dev, sg, nents, dir, attrs, false);
 }
@@ -1795,7 +1797,8 @@ void arm_iommu_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
  * @nents: number of buffers to map (returned from dma_map_sg)
  * @dir: DMA transfer direction (same as was passed to dma_map_sg)
  */
-void arm_iommu_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
+static void arm_iommu_sync_sg_for_cpu(struct device *dev,
+			struct scatterlist *sg,
 			int nents, enum dma_data_direction dir)
 {
 	struct scatterlist *s;
@@ -1813,7 +1816,8 @@ void arm_iommu_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
  * @nents: number of buffers to map (returned from dma_map_sg)
  * @dir: DMA transfer direction (same as was passed to dma_map_sg)
  */
-void arm_iommu_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
+static void arm_iommu_sync_sg_for_device(struct device *dev,
+			struct scatterlist *sg,
 			int nents, enum dma_data_direction dir)
 {
 	struct scatterlist *s;
@@ -2015,7 +2019,7 @@ static void arm_iommu_sync_single_for_device(struct device *dev,
 	__dma_page_cpu_to_dev(page, offset, size, dir);
 }
 
-const struct dma_map_ops iommu_ops = {
+static const struct dma_map_ops iommu_ops = {
 	.alloc		= arm_iommu_alloc_attrs,
 	.free		= arm_iommu_free_attrs,
 	.mmap		= arm_iommu_mmap_attrs,
@@ -2037,7 +2041,7 @@ const struct dma_map_ops iommu_ops = {
 	.dma_supported		= arm_dma_supported,
 };
 
-const struct dma_map_ops iommu_coherent_ops = {
+static const struct dma_map_ops iommu_coherent_ops = {
 	.alloc		= arm_coherent_iommu_alloc_attrs,
 	.free		= arm_coherent_iommu_free_attrs,
 	.mmap		= arm_coherent_iommu_mmap_attrs,
-- 
2.23.0

