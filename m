Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D70C282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 10:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 846AB20684
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 10:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfDOKrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 06:47:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6186 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727285AbfDOKrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 06:47:06 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8035E95E669BD9B289C4;
        Mon, 15 Apr 2019 18:47:03 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.408.0; Mon, 15 Apr 2019 18:46:55 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <ebiederm@xmission.com>, <rppt@linux.ibm.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <akpm@linux-foundation.org>, <ard.biesheuvel@linaro.org>
CC:     <horms@verge.net.au>, <takahiro.akashi@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
        <linux-mm@kvack.org>, <wangkefeng.wang@huawei.com>,
        Chen Zhou <chenzhou10@huawei.com>
Subject: [PATCH v4 4/5] arm64: kdump: support more than one crash kernel regions
Date:   Mon, 15 Apr 2019 18:57:24 +0800
Message-ID: <20190415105725.22088-5-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190415105725.22088-1-chenzhou10@huawei.com>
References: <20190415105725.22088-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit (arm64: kdump: support reserving crashkernel above 4G),
there may be two crash kernel regions, one is below 4G, the other is
above 4G. Use memblock_cap_memory_ranges() to support multiple crash
kernel regions.

Crash dump kernel reads more than one crash kernel regions via a dtb
property under node /chosen,
linux,usable-memory-range = <BASE1 SIZE1 [BASE2 SIZE2]>.

Besides, replace memblock_cap_memory_range() with
memblock_cap_memory_ranges().

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm64/mm/init.c     | 34 ++++++++++++++++++++++++----------
 include/linux/memblock.h |  1 -
 mm/memblock.c            | 41 ++++++++++++-----------------------------
 3 files changed, 36 insertions(+), 40 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index f5dde73..921953d 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -52,6 +52,9 @@
 #include <asm/tlb.h>
 #include <asm/alternative.h>
 
+/* at most two crash kernel regions, low_region and high_region */
+#define CRASH_MAX_USABLE_RANGES	2
+
 /*
  * We need to be able to catch inadvertent references to memstart_addr
  * that occur (potentially in generic code) before arm64_memblock_init()
@@ -295,9 +298,9 @@ early_param("mem", early_mem);
 static int __init early_init_dt_scan_usablemem(unsigned long node,
 		const char *uname, int depth, void *data)
 {
-	struct memblock_region *usablemem = data;
-	const __be32 *reg;
-	int len;
+	struct memblock_type *usablemem = data;
+	const __be32 *reg, *endp;
+	int len, nr = 0;
 
 	if (depth != 1 || strcmp(uname, "chosen") != 0)
 		return 0;
@@ -306,22 +309,33 @@ static int __init early_init_dt_scan_usablemem(unsigned long node,
 	if (!reg || (len < (dt_root_addr_cells + dt_root_size_cells)))
 		return 1;
 
-	usablemem->base = dt_mem_next_cell(dt_root_addr_cells, &reg);
-	usablemem->size = dt_mem_next_cell(dt_root_size_cells, &reg);
+	endp = reg + (len / sizeof(__be32));
+	while ((endp - reg) >= (dt_root_addr_cells + dt_root_size_cells)) {
+		unsigned long base = dt_mem_next_cell(dt_root_addr_cells, &reg);
+		unsigned long size = dt_mem_next_cell(dt_root_size_cells, &reg);
+
+		if (memblock_add_range(usablemem, base, size, NUMA_NO_NODE,
+				       MEMBLOCK_NONE))
+			return 0;
+		if (++nr >= CRASH_MAX_USABLE_RANGES)
+			break;
+	}
 
 	return 1;
 }
 
 static void __init fdt_enforce_memory_region(void)
 {
-	struct memblock_region reg = {
-		.size = 0,
+	struct memblock_region usable_regions[CRASH_MAX_USABLE_RANGES];
+	struct memblock_type usablemem = {
+		.max = CRASH_MAX_USABLE_RANGES,
+		.regions = usable_regions,
 	};
 
-	of_scan_flat_dt(early_init_dt_scan_usablemem, &reg);
+	of_scan_flat_dt(early_init_dt_scan_usablemem, &usablemem);
 
-	if (reg.size)
-		memblock_cap_memory_range(reg.base, reg.size);
+	if (usablemem.cnt)
+		memblock_cap_memory_ranges(&usablemem);
 }
 
 void __init arm64_memblock_init(void)
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 180877c..f04dfc1 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -445,7 +445,6 @@ phys_addr_t memblock_mem_size(unsigned long limit_pfn);
 phys_addr_t memblock_start_of_DRAM(void);
 phys_addr_t memblock_end_of_DRAM(void);
 void memblock_enforce_memory_limit(phys_addr_t memory_limit);
-void memblock_cap_memory_range(phys_addr_t base, phys_addr_t size);
 void memblock_cap_memory_ranges(struct memblock_type *regions_to_keep);
 void memblock_mem_limit_remove_map(phys_addr_t limit);
 bool memblock_is_memory(phys_addr_t addr);
diff --git a/mm/memblock.c b/mm/memblock.c
index 9661807..9b5cef4 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1669,34 +1669,6 @@ void __init memblock_enforce_memory_limit(phys_addr_t limit)
 			      PHYS_ADDR_MAX);
 }
 
-void __init memblock_cap_memory_range(phys_addr_t base, phys_addr_t size)
-{
-	int start_rgn, end_rgn;
-	int i, ret;
-
-	if (!size)
-		return;
-
-	ret = memblock_isolate_range(&memblock.memory, base, size,
-						&start_rgn, &end_rgn);
-	if (ret)
-		return;
-
-	/* remove all the MAP regions */
-	for (i = memblock.memory.cnt - 1; i >= end_rgn; i--)
-		if (!memblock_is_nomap(&memblock.memory.regions[i]))
-			memblock_remove_region(&memblock.memory, i);
-
-	for (i = start_rgn - 1; i >= 0; i--)
-		if (!memblock_is_nomap(&memblock.memory.regions[i]))
-			memblock_remove_region(&memblock.memory, i);
-
-	/* truncate the reserved regions */
-	memblock_remove_range(&memblock.reserved, 0, base);
-	memblock_remove_range(&memblock.reserved,
-			base + size, PHYS_ADDR_MAX);
-}
-
 void __init memblock_cap_memory_ranges(struct memblock_type *regions_to_keep)
 {
 	int start_rgn[INIT_MEMBLOCK_REGIONS], end_rgn[INIT_MEMBLOCK_REGIONS];
@@ -1744,6 +1716,16 @@ void __init memblock_cap_memory_ranges(struct memblock_type *regions_to_keep)
 
 void __init memblock_mem_limit_remove_map(phys_addr_t limit)
 {
+	struct memblock_region rgn = {
+		.base = 0,
+	};
+
+	struct memblock_type region_to_keep = {
+		.cnt = 1,
+		.max = 1,
+		.regions = &rgn,
+	};
+
 	phys_addr_t max_addr;
 
 	if (!limit)
@@ -1755,7 +1737,8 @@ void __init memblock_mem_limit_remove_map(phys_addr_t limit)
 	if (max_addr == PHYS_ADDR_MAX)
 		return;
 
-	memblock_cap_memory_range(0, max_addr);
+	region_to_keep.regions[0].size = max_addr;
+	memblock_cap_memory_ranges(&region_to_keep);
 }
 
 static int __init_memblock memblock_search(struct memblock_type *type, phys_addr_t addr)
-- 
2.7.4

