Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DB1C76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 15:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D6D2173B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 15:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbfGQPbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 11:31:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:43418 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726620AbfGQPbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 11:31:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DEE36B039;
        Wed, 17 Jul 2019 15:31:45 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, robin.murphy@arm.com,
        m.szyprowski@samsung.com, hch@lst.de, phil@raspberrypi.org,
        stefan.wahren@i2se.com, f.fainelli@gmail.com, mbrugger@suse.com,
        Jisheng.Zhang@synaptics.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [RFC 2/4] arm64: mm: parse dma-ranges in order to better estimate arm64_dma_phys_limit
Date:   Wed, 17 Jul 2019 17:31:33 +0200
Message-Id: <20190717153135.15507-3-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190717153135.15507-1-nsaenzjulienne@suse.de>
References: <20190717153135.15507-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dma physical limit has so far been calculated based on the memory
size and the assumption that dma would be at least able to address the
first 4 GB. This turned out no to be true with the Raspberry Pi 4
which, on it's main interconnect, can only address the first GB of
memory, even though it might have up to 4 GB.

With the current miscalculated dma physical limit the contiguous memory
reserve is located in an inaccessible area for most of the board's
devices.

To solve this we now scan the device tree for the 'dma-ranges' property
on the root or interconnect nodes, which allows us to calculate the
lowest common denominator dma physical limit. If no dma-ranges is
available, we'll default to the old scheme.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 arch/arm64/mm/init.c | 61 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 6112d6c90fa8..5708adf0db52 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -163,14 +163,67 @@ static void __init reserve_elfcorehdr(void)
 {
 }
 #endif /* CONFIG_CRASH_DUMP */
+
+static int __init early_init_dt_scan_dma_ranges(unsigned long node,
+		const char *uname, int depth, void *data)
+{
+	phys_addr_t *dma_phys_limit = data;
+	u64 phys_addr, dma_addr, size;
+	int dma_addr_cells;
+	const __be32 *reg;
+	const void *prop;
+	int len;
+
+	/* We keep looking if this isn't the root node or an interconnect */
+	if (!(depth == 0 ||
+	    (depth == 1 && of_flat_dt_is_compatible(node, "simple-bus"))))
+		return 0;
+
+	prop = of_get_flat_dt_prop(node, "#address-cells", NULL);
+	if (prop)
+		dma_addr_cells = be32_to_cpup(prop);
+	else
+		dma_addr_cells = 1; /* arm64's default addr_cell size */
+
+	reg = of_get_flat_dt_prop(node, "dma-ranges", &len);
+	if (!reg ||
+	    len < (dma_addr_cells + dt_root_addr_cells + dt_root_size_cells))
+		return 0;
+
+	dma_addr = dt_mem_next_cell(dma_addr_cells, &reg);
+	phys_addr = dt_mem_next_cell(dt_root_addr_cells, &reg);
+	size = dt_mem_next_cell(dt_root_size_cells, &reg);
+
+	/* We're in ZONE_DMA32 */
+	if (size > (1ULL << 32))
+		size = 1ULL << 32;
+
+	if (*dma_phys_limit > (phys_addr + size))
+		*dma_phys_limit = phys_addr + size;
+
+	return 0;
+}
+
 /*
- * Return the maximum physical address for ZONE_DMA32 (DMA_BIT_MASK(32)). It
- * currently assumes that for memory starting above 4G, 32-bit devices will
- * use a DMA offset.
+ * Return the maximum physical address for ZONE_DMA32. It currently assumes
+ * that for memory starting above 4G, 32-bit devices will use a DMA offset.
  */
 static phys_addr_t __init max_zone_dma_phys(void)
 {
-	phys_addr_t offset = memblock_start_of_DRAM() & GENMASK_ULL(63, 32);
+	phys_addr_t dma_phys_limit = ~0;
+	phys_addr_t offset;
+
+	/*
+	 * We walk the whole fdt looking for nodes with dma-ranges, calculate
+	 * the max_zone_dma_phys for them and keep going. We end-up getting the
+	 * lowest common denominator of all the matches.
+	 */
+	of_scan_flat_dt(early_init_dt_scan_dma_ranges, &dma_phys_limit);
+	if (dma_phys_limit != ~0)
+		return dma_phys_limit;
+
+	/* If no dma-ranges property was found we try to infer the value */
+	offset = memblock_start_of_DRAM() & GENMASK_ULL(63, 32);
 	return min(offset + (1ULL << 32), memblock_end_of_DRAM());
 }
 
-- 
2.22.0

