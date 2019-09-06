Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B383DC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97EC021670
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404469AbfIFMGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 08:06:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:60650 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726626AbfIFMGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 08:06:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1754FABE3;
        Fri,  6 Sep 2019 12:06:28 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     catalin.marinas@arm.com, hch@lst.de, wahrenst@gmx.net,
        marc.zyngier@arm.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     f.fainelli@gmail.com, will@kernel.org, robin.murphy@arm.com,
        nsaenzjulienne@suse.de, mbrugger@suse.com,
        linux-rpi-kernel@lists.infradead.org, phill@raspberrypi.org,
        m.szyprowski@samsung.com
Subject: [PATCH v4 2/4] arm64: rename variables used to calculate ZONE_DMA32's size
Date:   Fri,  6 Sep 2019 14:06:13 +0200
Message-Id: <20190906120617.18836-3-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190906120617.18836-1-nsaenzjulienne@suse.de>
References: <20190906120617.18836-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let the name indicate that they are used to calculate ZONE_DMA32's size
as opposed to ZONE_DMA.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/mm/init.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 098c0f5bedf6..8e9bc64c5878 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -56,7 +56,7 @@ EXPORT_SYMBOL(physvirt_offset);
 struct page *vmemmap __ro_after_init;
 EXPORT_SYMBOL(vmemmap);
 
-phys_addr_t arm64_dma_phys_limit __ro_after_init;
+phys_addr_t arm64_dma32_phys_limit __ro_after_init;
 
 #ifdef CONFIG_KEXEC_CORE
 /*
@@ -174,7 +174,7 @@ static void __init reserve_elfcorehdr(void)
  * currently assumes that for memory starting above 4G, 32-bit devices will
  * use a DMA offset.
  */
-static phys_addr_t __init max_zone_dma_phys(void)
+static phys_addr_t __init max_zone_dma32_phys(void)
 {
 	phys_addr_t offset = memblock_start_of_DRAM() & GENMASK_ULL(63, 32);
 	return min(offset + (1ULL << 32), memblock_end_of_DRAM());
@@ -187,7 +187,7 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
 	unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};
 
 #ifdef CONFIG_ZONE_DMA32
-	max_zone_pfns[ZONE_DMA32] = PFN_DOWN(arm64_dma_phys_limit);
+	max_zone_pfns[ZONE_DMA32] = PFN_DOWN(arm64_dma32_phys_limit);
 #endif
 	max_zone_pfns[ZONE_NORMAL] = max;
 
@@ -200,16 +200,16 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
 {
 	struct memblock_region *reg;
 	unsigned long zone_size[MAX_NR_ZONES], zhole_size[MAX_NR_ZONES];
-	unsigned long max_dma = min;
+	unsigned long max_dma32 = min;
 
 	memset(zone_size, 0, sizeof(zone_size));
 
 	/* 4GB maximum for 32-bit only capable devices */
 #ifdef CONFIG_ZONE_DMA32
-	max_dma = PFN_DOWN(arm64_dma_phys_limit);
-	zone_size[ZONE_DMA32] = max_dma - min;
+	max_dma32 = PFN_DOWN(arm64_dma32_phys_limit);
+	zone_size[ZONE_DMA32] = max_dma32 - min;
 #endif
-	zone_size[ZONE_NORMAL] = max - max_dma;
+	zone_size[ZONE_NORMAL] = max - max_dma32;
 
 	memcpy(zhole_size, zone_size, sizeof(zhole_size));
 
@@ -221,14 +221,14 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
 			continue;
 
 #ifdef CONFIG_ZONE_DMA32
-		if (start < max_dma) {
-			unsigned long dma_end = min(end, max_dma);
+		if (start < max_dma32) {
+			unsigned long dma_end = min(end, max_dma32);
 			zhole_size[ZONE_DMA32] -= dma_end - start;
 		}
 #endif
-		if (end > max_dma) {
+		if (end > max_dma32) {
 			unsigned long normal_end = min(end, max);
-			unsigned long normal_start = max(start, max_dma);
+			unsigned long normal_start = max(start, max_dma32);
 			zhole_size[ZONE_NORMAL] -= normal_end - normal_start;
 		}
 	}
@@ -420,9 +420,9 @@ void __init arm64_memblock_init(void)
 
 	/* 4GB maximum for 32-bit only capable devices */
 	if (IS_ENABLED(CONFIG_ZONE_DMA32))
-		arm64_dma_phys_limit = max_zone_dma_phys();
+		arm64_dma32_phys_limit = max_zone_dma32_phys();
 	else
-		arm64_dma_phys_limit = PHYS_MASK + 1;
+		arm64_dma32_phys_limit = PHYS_MASK + 1;
 
 	reserve_crashkernel();
 
@@ -430,7 +430,7 @@ void __init arm64_memblock_init(void)
 
 	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
 
-	dma_contiguous_reserve(arm64_dma_phys_limit);
+	dma_contiguous_reserve(arm64_dma32_phys_limit);
 }
 
 void __init bootmem_init(void)
@@ -534,7 +534,7 @@ static void __init free_unused_memmap(void)
 void __init mem_init(void)
 {
 	if (swiotlb_force == SWIOTLB_FORCE ||
-	    max_pfn > (arm64_dma_phys_limit >> PAGE_SHIFT))
+	    max_pfn > (arm64_dma32_phys_limit >> PAGE_SHIFT))
 		swiotlb_init(1);
 	else
 		swiotlb_force = SWIOTLB_NO_FORCE;
-- 
2.23.0

