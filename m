Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F239C5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 18:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 478A820863
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 18:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbfIKS0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 14:26:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:59982 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728198AbfIKSZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 14:25:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2E1EFACB7;
        Wed, 11 Sep 2019 18:25:53 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     catalin.marinas@arm.com, hch@lst.de, wahrenst@gmx.net,
        marc.zyngier@arm.com, robh+dt@kernel.org
Cc:     f.fainelli@gmail.com, will@kernel.org, linux-mm@kvack.org,
        robin.murphy@arm.com, nsaenzjulienne@suse.de,
        linux-kernel@vger.kernel.org, mbrugger@suse.com,
        linux-rpi-kernel@lists.infradead.org, phill@raspberrypi.org,
        linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Subject: [PATCH v6 3/4] arm64: use both ZONE_DMA and ZONE_DMA32
Date:   Wed, 11 Sep 2019 20:25:45 +0200
Message-Id: <20190911182546.17094-4-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190911182546.17094-1-nsaenzjulienne@suse.de>
References: <20190911182546.17094-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far all arm64 devices have supported 32 bit DMA masks for their
peripherals. This is not true anymore for the Raspberry Pi 4 as most of
it's peripherals can only address the first GB of memory on a total of
up to 4 GB.

This goes against ZONE_DMA32's intent, as it's expected for ZONE_DMA32
to be addressable with a 32 bit mask. So it was decided to re-introduce
ZONE_DMA in arm64.

ZONE_DMA will contain the lower 1G of memory, which is currently the
memory area addressable by any peripheral on an arm64 device.
ZONE_DMA32 will contain the rest of the 32 bit addressable memory.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

---

I kept the Reviewed-by as the last bug solution was proposed by Catalin

Changes in v6:
- Fixed bug in max_zone_phys

Changes in v5:
- Fixed swiotlb initialization

Changes in v4:
- Fixed issue when NUMA=n and ZONE_DMA=n
- Merged two max_zone_dma*_phys() functions

Changes in v3:
- Used fixed size ZONE_DMA
- Fix check befor swiotlb_init()

Changes in v2:
- Update comment to reflect new zones split
- ZONE_DMA will never be left empty

 arch/arm64/Kconfig            |  4 +++
 arch/arm64/include/asm/page.h |  2 ++
 arch/arm64/mm/init.c          | 54 +++++++++++++++++++++++++----------
 3 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6b6362b83004..2dbe0165bd15 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -267,6 +267,10 @@ config GENERIC_CSUM
 config GENERIC_CALIBRATE_DELAY
 	def_bool y
 
+config ZONE_DMA
+	bool "Support DMA zone" if EXPERT
+	default y
+
 config ZONE_DMA32
 	bool "Support DMA32 zone" if EXPERT
 	default y
diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index d39ddb258a04..7b8c98830101 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -38,4 +38,6 @@ extern int pfn_valid(unsigned long);
 
 #include <asm-generic/getorder.h>
 
+#define ARCH_ZONE_DMA_BITS 30
+
 #endif
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 8e9bc64c5878..44f07fdf7a59 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -56,6 +56,13 @@ EXPORT_SYMBOL(physvirt_offset);
 struct page *vmemmap __ro_after_init;
 EXPORT_SYMBOL(vmemmap);
 
+/*
+ * We create both ZONE_DMA and ZONE_DMA32. ZONE_DMA covers the first 1G of
+ * memory as some devices, namely the Raspberry Pi 4, have peripherals with
+ * this limited view of the memory. ZONE_DMA32 will cover the rest of the 32
+ * bit addressable memory area.
+ */
+phys_addr_t arm64_dma_phys_limit __ro_after_init;
 phys_addr_t arm64_dma32_phys_limit __ro_after_init;
 
 #ifdef CONFIG_KEXEC_CORE
@@ -169,15 +176,16 @@ static void __init reserve_elfcorehdr(void)
 {
 }
 #endif /* CONFIG_CRASH_DUMP */
+
 /*
- * Return the maximum physical address for ZONE_DMA32 (DMA_BIT_MASK(32)). It
- * currently assumes that for memory starting above 4G, 32-bit devices will
- * use a DMA offset.
+ * Return the maximum physical address for a zone with a given address size
+ * limit. It currently assumes that for memory starting above 4G, 32-bit
+ * devices will use a DMA offset.
  */
-static phys_addr_t __init max_zone_dma32_phys(void)
+static phys_addr_t __init max_zone_phys(unsigned int zone_bits)
 {
-	phys_addr_t offset = memblock_start_of_DRAM() & GENMASK_ULL(63, 32);
-	return min(offset + (1ULL << 32), memblock_end_of_DRAM());
+	phys_addr_t offset = memblock_start_of_DRAM() & GENMASK_ULL(63, zone_bits);
+	return min(offset + (1ULL << zone_bits), memblock_end_of_DRAM());
 }
 
 #ifdef CONFIG_NUMA
@@ -186,6 +194,9 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
 {
 	unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};
 
+#ifdef CONFIG_ZONE_DMA
+	max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
+#endif
 #ifdef CONFIG_ZONE_DMA32
 	max_zone_pfns[ZONE_DMA32] = PFN_DOWN(arm64_dma32_phys_limit);
 #endif
@@ -201,13 +212,18 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
 	struct memblock_region *reg;
 	unsigned long zone_size[MAX_NR_ZONES], zhole_size[MAX_NR_ZONES];
 	unsigned long max_dma32 = min;
+	unsigned long max_dma = min;
 
 	memset(zone_size, 0, sizeof(zone_size));
 
-	/* 4GB maximum for 32-bit only capable devices */
+#ifdef CONFIG_ZONE_DMA
+	max_dma = PFN_DOWN(arm64_dma_phys_limit);
+	zone_size[ZONE_DMA] = max_dma - min;
+	max_dma32 = max_dma;
+#endif
 #ifdef CONFIG_ZONE_DMA32
 	max_dma32 = PFN_DOWN(arm64_dma32_phys_limit);
-	zone_size[ZONE_DMA32] = max_dma32 - min;
+	zone_size[ZONE_DMA32] = max_dma32 - max_dma;
 #endif
 	zone_size[ZONE_NORMAL] = max - max_dma32;
 
@@ -219,11 +235,17 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
 
 		if (start >= max)
 			continue;
-
+#ifdef CONFIG_ZONE_DMA
+		if (start < max_dma) {
+			unsigned long dma_end = min_not_zero(end, max_dma);
+			zhole_size[ZONE_DMA] -= dma_end - start;
+		}
+#endif
 #ifdef CONFIG_ZONE_DMA32
 		if (start < max_dma32) {
-			unsigned long dma_end = min(end, max_dma32);
-			zhole_size[ZONE_DMA32] -= dma_end - start;
+			unsigned long dma32_end = min(end, max_dma32);
+			unsigned long dma32_start = max(start, max_dma);
+			zhole_size[ZONE_DMA32] -= dma32_end - dma32_start;
 		}
 #endif
 		if (end > max_dma32) {
@@ -418,9 +440,11 @@ void __init arm64_memblock_init(void)
 
 	early_init_fdt_scan_reserved_mem();
 
-	/* 4GB maximum for 32-bit only capable devices */
+	if (IS_ENABLED(CONFIG_ZONE_DMA))
+		arm64_dma_phys_limit = max_zone_phys(ARCH_ZONE_DMA_BITS);
+
 	if (IS_ENABLED(CONFIG_ZONE_DMA32))
-		arm64_dma32_phys_limit = max_zone_dma32_phys();
+		arm64_dma32_phys_limit = max_zone_phys(32);
 	else
 		arm64_dma32_phys_limit = PHYS_MASK + 1;
 
@@ -430,7 +454,7 @@ void __init arm64_memblock_init(void)
 
 	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
 
-	dma_contiguous_reserve(arm64_dma32_phys_limit);
+	dma_contiguous_reserve(arm64_dma_phys_limit ? : arm64_dma32_phys_limit);
 }
 
 void __init bootmem_init(void)
@@ -534,7 +558,7 @@ static void __init free_unused_memmap(void)
 void __init mem_init(void)
 {
 	if (swiotlb_force == SWIOTLB_FORCE ||
-	    max_pfn > (arm64_dma32_phys_limit >> PAGE_SHIFT))
+	    max_pfn > PFN_DOWN(arm64_dma_phys_limit ? : arm64_dma32_phys_limit))
 		swiotlb_init(1);
 	else
 		swiotlb_force = SWIOTLB_NO_FORCE;
-- 
2.23.0

