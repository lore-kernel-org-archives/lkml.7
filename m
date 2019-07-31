Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2272C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C411F208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730286AbfGaPsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:48:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:50094 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730240AbfGaPsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:48:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 01F74AFE4;
        Wed, 31 Jul 2019 15:48:04 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     catalin.marinas@arm.com, hch@lst.de, wahrenst@gmx.net,
        marc.zyngier@arm.com, Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-mm@kvack.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     phill@raspberryi.org, f.fainelli@gmail.com, will@kernel.org,
        linux-kernel@vger.kernel.org, eric@anholt.net, mbrugger@suse.com,
        nsaenzjulienne@suse.de, akpm@linux-foundation.org,
        m.szyprowski@samsung.com, linux-rpi-kernel@lists.infradead.org
Subject: [PATCH 3/8] of/fdt: add function to get the SoC wide DMA addressable memory size
Date:   Wed, 31 Jul 2019 17:47:46 +0200
Message-Id: <20190731154752.16557-4-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731154752.16557-1-nsaenzjulienne@suse.de>
References: <20190731154752.16557-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SoCs might have multiple interconnects each with their own DMA
addressing limitations. This function parses the 'dma-ranges' on each of
them and tries to guess the maximum SoC wide DMA addressable memory
size.

This is specially useful for arch code in order to properly setup CMA
and memory zones.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

 drivers/of/fdt.c       | 72 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/of_fdt.h |  2 ++
 2 files changed, 74 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 9cdf14b9aaab..f2444c61a136 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -953,6 +953,78 @@ int __init early_init_dt_scan_chosen_stdout(void)
 }
 #endif
 
+/**
+ * early_init_dt_dma_zone_size - Look at all 'dma-ranges' and provide the
+ * maximum common dmable memory size.
+ *
+ * Some devices might have multiple interconnects each with their own DMA
+ * addressing limitations. For example the Raspberry Pi 4 has the following:
+ *
+ * soc {
+ *	dma-ranges = <0xc0000000  0x0 0x00000000  0x3c000000>;
+ *	[...]
+ * }
+ *
+ * v3dbus {
+ *	dma-ranges = <0x00000000  0x0 0x00000000  0x3c000000>;
+ *	[...]
+ * }
+ *
+ * scb {
+ *	dma-ranges = <0x0 0x00000000  0x0 0x00000000  0xfc000000>;
+ *	[...]
+ * }
+ *
+ * Here the area addressable by all devices is [0x00000000-0x3bffffff]. Hence
+ * the function will write in 'data' a size of 0x3c000000.
+ *
+ * Note that the implementation assumes all interconnects have the same physical
+ * memory view and that the mapping always start at the beginning of RAM.
+ */
+int __init early_init_dt_dma_zone_size(unsigned long node, const char *uname,
+				       int depth, void *data)
+{
+	const char *type = of_get_flat_dt_prop(node, "device_type", NULL);
+	u64 phys_addr, dma_addr, size;
+	u64 *dma_zone_size = data;
+	int dma_addr_cells;
+	const __be32 *reg;
+	const void *prop;
+	int len;
+
+	if (depth == 0)
+		*dma_zone_size = 0;
+
+	/*
+	 * We avoid pci host controllers as they have their own way of using
+	 * 'dma-ranges'.
+	 */
+	if (type && !strcmp(type, "pci"))
+		return 0;
+
+	reg = of_get_flat_dt_prop(node, "dma-ranges", &len);
+	if (!reg)
+		return 0;
+
+	prop = of_get_flat_dt_prop(node, "#address-cells", NULL);
+	if (prop)
+		dma_addr_cells = be32_to_cpup(prop);
+	else
+		dma_addr_cells = 1; /* arm64's default addr_cell size */
+
+	if (len < (dma_addr_cells + dt_root_addr_cells + dt_root_size_cells))
+		return 0;
+
+	dma_addr = dt_mem_next_cell(dma_addr_cells, &reg);
+	phys_addr = dt_mem_next_cell(dt_root_addr_cells, &reg);
+	size = dt_mem_next_cell(dt_root_size_cells, &reg);
+
+	if (!*dma_zone_size || *dma_zone_size > size)
+		*dma_zone_size = size;
+
+	return 0;
+}
+
 /**
  * early_init_dt_scan_root - fetch the top level address and size cells
  */
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index acf820e88952..2ad36b7bd4fa 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -72,6 +72,8 @@ extern int early_init_dt_reserve_memory_arch(phys_addr_t base, phys_addr_t size,
 					     bool no_map);
 extern u64 dt_mem_next_cell(int s, const __be32 **cellp);
 
+extern int early_init_dt_dma_zone_size(unsigned long node, const char *uname,
+				       int depth, void *data);
 /* Early flat tree scan hooks */
 extern int early_init_dt_scan_root(unsigned long node, const char *uname,
 				   int depth, void *data);
-- 
2.22.0

