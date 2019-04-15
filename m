Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741B9C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324C1218D3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730908AbfDOTKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:10:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54712 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730874AbfDOTKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:10:06 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3FJ8mLd045234
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 15:10:05 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rvvxsfuw5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 15:10:04 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Mon, 15 Apr 2019 20:10:02 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 15 Apr 2019 20:09:56 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3FJ9tXr48889976
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 19:09:55 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2D87A406B;
        Mon, 15 Apr 2019 19:09:55 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14190A405B;
        Mon, 15 Apr 2019 19:09:54 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.207.92])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 15 Apr 2019 19:09:53 +0000 (GMT)
Date:   Mon, 15 Apr 2019 22:09:42 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        ebiederm@xmission.com, catalin.marinas@arm.com,
        will.deacon@arm.com, akpm@linux-foundation.org,
        ard.biesheuvel@linaro.org, horms@verge.net.au,
        takahiro.akashi@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-mm@kvack.org, wangkefeng.wang@huawei.com
Subject: Re: [PATCH v4 3/5] memblock: add memblock_cap_memory_ranges for
 multiple ranges
References: <20190415105725.22088-1-chenzhou10@huawei.com>
 <20190415105725.22088-4-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415105725.22088-4-chenzhou10@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19041519-4275-0000-0000-0000032820DB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041519-4276-0000-0000-000038374DC9
Message-Id: <20190415190940.GA6081@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-15_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904150133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 15, 2019 at 06:57:23PM +0800, Chen Zhou wrote:
> The memblock_cap_memory_range() removes all the memory except the
> range passed to it. Extend this function to receive memblock_type
> with the regions that should be kept.
> 
> Enable this function in arm64 for reservation of multiple regions
> for the crash kernel.
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

I didn't work on this version, please drop the signed-off.

> ---
>  include/linux/memblock.h |  1 +
>  mm/memblock.c            | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 47e3c06..180877c 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -446,6 +446,7 @@ phys_addr_t memblock_start_of_DRAM(void);
>  phys_addr_t memblock_end_of_DRAM(void);
>  void memblock_enforce_memory_limit(phys_addr_t memory_limit);
>  void memblock_cap_memory_range(phys_addr_t base, phys_addr_t size);
> +void memblock_cap_memory_ranges(struct memblock_type *regions_to_keep);
>  void memblock_mem_limit_remove_map(phys_addr_t limit);
>  bool memblock_is_memory(phys_addr_t addr);
>  bool memblock_is_map_memory(phys_addr_t addr);
> diff --git a/mm/memblock.c b/mm/memblock.c
> index f315eca..9661807 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1697,6 +1697,51 @@ void __init memblock_cap_memory_range(phys_addr_t base, phys_addr_t size)
>  			base + size, PHYS_ADDR_MAX);
>  }
>  
> +void __init memblock_cap_memory_ranges(struct memblock_type *regions_to_keep)
> +{
> +	int start_rgn[INIT_MEMBLOCK_REGIONS], end_rgn[INIT_MEMBLOCK_REGIONS];
> +	int i, j, ret, nr = 0;
> +	struct memblock_region *regs = regions_to_keep->regions;
> +
> +	for (i = 0; i < regions_to_keep->cnt; i++) {
> +		ret = memblock_isolate_range(&memblock.memory, regs[i].base,
> +				regs[i].size, &start_rgn[i], &end_rgn[i]);
> +		if (ret)
> +			break;
> +		nr++;
> +	}
> +	if (!nr)
> +		return;
> +
> +	/* remove all the MAP regions */
> +	for (i = memblock.memory.cnt - 1; i >= end_rgn[nr - 1]; i--)
> +		if (!memblock_is_nomap(&memblock.memory.regions[i]))
> +			memblock_remove_region(&memblock.memory, i);
> +
> +	for (i = nr - 1; i > 0; i--)
> +		for (j = start_rgn[i] - 1; j >= end_rgn[i - 1]; j--)
> +			if (!memblock_is_nomap(&memblock.memory.regions[j]))
> +				memblock_remove_region(&memblock.memory, j);
> +
> +	for (i = start_rgn[0] - 1; i >= 0; i--)
> +		if (!memblock_is_nomap(&memblock.memory.regions[i]))
> +			memblock_remove_region(&memblock.memory, i);
> +
> +	/* truncate the reserved regions */
> +	memblock_remove_range(&memblock.reserved, 0, regs[0].base);
> +
> +	for (i = nr - 1; i > 0; i--) {
> +		phys_addr_t remove_base = regs[i - 1].base + regs[i - 1].size;
> +		phys_addr_t remove_size = regs[i].base - remove_base;
> +
> +		memblock_remove_range(&memblock.reserved, remove_base,
> +				remove_size);
> +	}
> +
> +	memblock_remove_range(&memblock.reserved,
> +			regs[nr - 1].base + regs[nr - 1].size, PHYS_ADDR_MAX);
> +}
> +

I've double-checked and I see no problem with using
for_each_mem_range_rev() iterators for removing some ranges. And with them
this functions becomes much clearer and more efficient.

Can you please check if the below patch works for you?

From e25e6c9cd94a01abac124deacc66e5d258fdbf7c Mon Sep 17 00:00:00 2001
From: Mike Rapoport <rppt@linux.ibm.com>
Date: Wed, 10 Apr 2019 16:02:32 +0300
Subject: [PATCH] memblock: extend memblock_cap_memory_range to multiple ranges

The memblock_cap_memory_range() removes all the memory except the range
passed to it. Extend this function to receive an array of memblock_regions
that should be kept. This allows switching to simple iteration over
memblock arrays with 'for_each_mem_range_rev' to remove the unneeded memory.

Enable use of this function in arm64 for reservation of multiple regions for
the crash kernel.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm64/mm/init.c     | 34 ++++++++++++++++++++++++----------
 include/linux/memblock.h |  2 +-
 mm/memblock.c            | 44 ++++++++++++++++++++------------------------
 3 files changed, 45 insertions(+), 35 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 6bc1350..8665d29 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -64,6 +64,10 @@ EXPORT_SYMBOL(memstart_addr);
 phys_addr_t arm64_dma_phys_limit __ro_after_init;
 
 #ifdef CONFIG_KEXEC_CORE
+
+/* at most two crash kernel regions, low_region and high_region */
+#define CRASH_MAX_USABLE_RANGES	2
+
 /*
  * reserve_crashkernel() - reserves memory for crash kernel
  *
@@ -280,9 +284,9 @@ early_param("mem", early_mem);
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
@@ -291,22 +295,32 @@ static int __init early_init_dt_scan_usablemem(unsigned long node,
 	if (!reg || (len < (dt_root_addr_cells + dt_root_size_cells)))
 		return 1;
 
-	usablemem->base = dt_mem_next_cell(dt_root_addr_cells, &reg);
-	usablemem->size = dt_mem_next_cell(dt_root_size_cells, &reg);
+	endp = reg + (len / sizeof(__be32));
+	while ((endp - reg) >= (dt_root_addr_cells + dt_root_size_cells)) {
+		unsigned long base = dt_mem_next_cell(dt_root_addr_cells, &reg);
+		unsigned long size = dt_mem_next_cell(dt_root_size_cells, &reg);
 
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
+		memblock_cap_memory_ranges(usablemem.regions, usablemem.cnt);
 }
 
 void __init arm64_memblock_init(void)
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 294d5d8..f5c029b 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -404,7 +404,7 @@ phys_addr_t memblock_mem_size(unsigned long limit_pfn);
 phys_addr_t memblock_start_of_DRAM(void);
 phys_addr_t memblock_end_of_DRAM(void);
 void memblock_enforce_memory_limit(phys_addr_t memory_limit);
-void memblock_cap_memory_range(phys_addr_t base, phys_addr_t size);
+void memblock_cap_memory_ranges(struct memblock_region *regions, int count);
 void memblock_mem_limit_remove_map(phys_addr_t limit);
 bool memblock_is_memory(phys_addr_t addr);
 bool memblock_is_map_memory(phys_addr_t addr);
diff --git a/mm/memblock.c b/mm/memblock.c
index e7665cf..8d4d060 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1605,36 +1605,31 @@ void __init memblock_enforce_memory_limit(phys_addr_t limit)
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
+void __init memblock_cap_memory_ranges(struct memblock_region *regions,
+				       int count)
+{
+	struct memblock_type regions_to_keep = {
+		.max = count,
+		.cnt = count,
+		.regions = regions,
+	};
+	phys_addr_t start, end;
+	u64 i;
 
-	for (i = start_rgn - 1; i >= 0; i--)
-		if (!memblock_is_nomap(&memblock.memory.regions[i]))
-			memblock_remove_region(&memblock.memory, i);
+	/* truncate memory while skipping NOMAP regions */
+	for_each_mem_range_rev(i, &memblock.memory, &regions_to_keep,
+			       NUMA_NO_NODE, MEMBLOCK_NONE, &start, &end, NULL)
+		memblock_remove(start, end);
 
 	/* truncate the reserved regions */
-	memblock_remove_range(&memblock.reserved, 0, base);
-	memblock_remove_range(&memblock.reserved,
-			base + size, PHYS_ADDR_MAX);
+	for_each_mem_range_rev(i, &memblock.reserved, &regions_to_keep,
+			       NUMA_NO_NODE, MEMBLOCK_NONE, &start, &end, NULL)
+		memblock_remove_range(&memblock.reserved, start, end);
 }
 
 void __init memblock_mem_limit_remove_map(phys_addr_t limit)
 {
+	struct memblock_region region = { 0 };
 	phys_addr_t max_addr;
 
 	if (!limit)
@@ -1646,7 +1641,8 @@ void __init memblock_mem_limit_remove_map(phys_addr_t limit)
 	if (max_addr == PHYS_ADDR_MAX)
 		return;
 
-	memblock_cap_memory_range(0, max_addr);
+	region.size = max_addr;
+	memblock_cap_memory_ranges(&region, 1);
 }
 
 static int __init_memblock memblock_search(struct memblock_type *type, phys_addr_t addr)
-- 
2.7.4


-- 
Sincerely yours,
Mike.

