Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D779BC76194
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 05:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA02F2238E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 05:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732693AbfGWFxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 01:53:52 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2700 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732403AbfGWFxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 01:53:52 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DB94EAB89D521717DF39;
        Tue, 23 Jul 2019 13:53:49 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Tue, 23 Jul 2019 13:53:44 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Jia He" <hejianet@gmail.com>, Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v12 2/2] mm: page_alloc: reduce unnecessary binary search in memblock_next_valid_pfn
Date:   Tue, 23 Jul 2019 13:51:13 +0800
Message-ID: <1563861073-47071-3-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1563861073-47071-1-git-send-email-guohanjun@huawei.com>
References: <1563861073-47071-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia He <hejianet@gmail.com>

After skipping some invalid pfns in memmap_init_zone(), there is still
some room for improvement.

E.g. if pfn and pfn+1 are in the same memblock region, we can simply pfn++
instead of doing the binary search in memblock_next_valid_pfn.

Furthermore, if the pfn is in a gap of two memory region, skip to next
region directly to speedup the binary search.

Signed-off-by: Jia He <hejianet@gmail.com>
Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 mm/memblock.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index d57ba51bb9cd..95d5916716a0 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1256,28 +1256,53 @@ int __init_memblock memblock_set_node(phys_addr_t base, phys_addr_t size,
 unsigned long __init_memblock memblock_next_valid_pfn(unsigned long pfn)
 {
 	struct memblock_type *type = &memblock.memory;
+	struct memblock_region *regions = type->regions;
 	unsigned int right = type->cnt;
 	unsigned int mid, left = 0;
+	unsigned long start_pfn, end_pfn, next_start_pfn;
 	phys_addr_t addr = PFN_PHYS(++pfn);
+	static int early_region_idx __initdata_memblock = -1;
 
+	/* fast path, return pfn+1 if next pfn is in the same region */
+	if (early_region_idx != -1) {
+		start_pfn = PFN_DOWN(regions[early_region_idx].base);
+		end_pfn = PFN_DOWN(regions[early_region_idx].base +
+				regions[early_region_idx].size);
+
+		if (pfn >= start_pfn && pfn < end_pfn)
+			return pfn;
+
+		/* try slow path */
+		if (++early_region_idx == type->cnt)
+			goto slow_path;
+
+		next_start_pfn = PFN_DOWN(regions[early_region_idx].base);
+
+		if (pfn >= end_pfn && pfn <= next_start_pfn)
+			return next_start_pfn;
+	}
+
+slow_path:
+	/* slow path, do the binary searching */
 	do {
 		mid = (right + left) / 2;
 
-		if (addr < type->regions[mid].base)
+		if (addr < regions[mid].base)
 			right = mid;
-		else if (addr >= (type->regions[mid].base +
-				  type->regions[mid].size))
+		else if (addr >= (regions[mid].base + regions[mid].size))
 			left = mid + 1;
 		else {
-			/* addr is within the region, so pfn is valid */
+			early_region_idx = mid;
 			return pfn;
 		}
 	} while (left < right);
 
 	if (right == type->cnt)
 		return -1UL;
-	else
-		return PHYS_PFN(type->regions[right].base);
+
+	early_region_idx = right;
+
+	return PHYS_PFN(regions[early_region_idx].base);
 }
 EXPORT_SYMBOL(memblock_next_valid_pfn);
 #endif /* CONFIG_HAVE_MEMBLOCK_PFN_VALID */
-- 
2.19.1

