Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDB7C10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CCA720700
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfDCNvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:51:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6227 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725959AbfDCNvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:51:52 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [10.3.19.207])
        by Forcepoint Email with ESMTP id 7F3A75F44857EBFD6F91;
        Wed,  3 Apr 2019 21:51:38 +0800 (CST)
Received: from [127.0.0.1] (10.177.131.64) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Wed, 3 Apr 2019
 21:51:29 +0800
Subject: Re: [PATCH 2/3] arm64: kdump: support more than one crash kernel
 regions
To:     Mike Rapoport <rppt@linux.ibm.com>
References: <20190403030546.23718-1-chenzhou10@huawei.com>
 <20190403030546.23718-3-chenzhou10@huawei.com>
 <20190403112929.GA7715@rapoport-lnx>
CC:     <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <akpm@linux-foundation.org>, <ard.biesheuvel@linaro.org>,
        <takahiro.akashi@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
        <linux-mm@kvack.org>, <wangkefeng.wang@huawei.com>
From:   Chen Zhou <chenzhou10@huawei.com>
Message-ID: <f98a5559-3659-fb35-3765-15861e70a796@huawei.com>
Date:   Wed, 3 Apr 2019 21:51:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20190403112929.GA7715@rapoport-lnx>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.131.64]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 2019/4/3 19:29, Mike Rapoport wrote:
> On Wed, Apr 03, 2019 at 11:05:45AM +0800, Chen Zhou wrote:
>> After commit (arm64: kdump: support reserving crashkernel above 4G),
>> there may be two crash kernel regions, one is below 4G, the other is
>> above 4G.
>>
>> Crash dump kernel reads more than one crash kernel regions via a dtb
>> property under node /chosen,
>> linux,usable-memory-range = <BASE1 SIZE1 [BASE2 SIZE2]>
>>
>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>> ---
>>  arch/arm64/mm/init.c     | 37 +++++++++++++++++++++++++------------
>>  include/linux/memblock.h |  1 +
>>  mm/memblock.c            | 40 ++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 66 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index ceb2a25..769c77a 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -64,6 +64,8 @@ EXPORT_SYMBOL(memstart_addr);
>>  phys_addr_t arm64_dma_phys_limit __ro_after_init;
>>  
>>  #ifdef CONFIG_KEXEC_CORE
>> +# define CRASH_MAX_USABLE_RANGES        2
>> +
>>  static int __init reserve_crashkernel_low(void)
>>  {
>>  	unsigned long long base, low_base = 0, low_size = 0;
>> @@ -346,8 +348,8 @@ static int __init early_init_dt_scan_usablemem(unsigned long node,
>>  		const char *uname, int depth, void *data)
>>  {
>>  	struct memblock_region *usablemem = data;
>> -	const __be32 *reg;
>> -	int len;
>> +	const __be32 *reg, *endp;
>> +	int len, nr = 0;
>>  
>>  	if (depth != 1 || strcmp(uname, "chosen") != 0)
>>  		return 0;
>> @@ -356,22 +358,33 @@ static int __init early_init_dt_scan_usablemem(unsigned long node,
>>  	if (!reg || (len < (dt_root_addr_cells + dt_root_size_cells)))
>>  		return 1;
>>  
>> -	usablemem->base = dt_mem_next_cell(dt_root_addr_cells, &reg);
>> -	usablemem->size = dt_mem_next_cell(dt_root_size_cells, &reg);
>> +	endp = reg + (len / sizeof(__be32));
>> +	while ((endp - reg) >= (dt_root_addr_cells + dt_root_size_cells)) {
>> +		usablemem[nr].base = dt_mem_next_cell(dt_root_addr_cells, &reg);
>> +		usablemem[nr].size = dt_mem_next_cell(dt_root_size_cells, &reg);
>> +
>> +		if (++nr >= CRASH_MAX_USABLE_RANGES)
>> +			break;
>> +	}
>>  
>>  	return 1;
>>  }
>>  
>>  static void __init fdt_enforce_memory_region(void)
>>  {
>> -	struct memblock_region reg = {
>> -		.size = 0,
>> -	};
>> -
>> -	of_scan_flat_dt(early_init_dt_scan_usablemem, &reg);
>> -
>> -	if (reg.size)
>> -		memblock_cap_memory_range(reg.base, reg.size);
>> +	int i, cnt = 0;
>> +	struct memblock_region regs[CRASH_MAX_USABLE_RANGES];
>> +
>> +	memset(regs, 0, sizeof(regs));
>> +	of_scan_flat_dt(early_init_dt_scan_usablemem, regs);
>> +
>> +	for (i = 0; i < CRASH_MAX_USABLE_RANGES; i++)
>> +		if (regs[i].size)
>> +			cnt++;
>> +		else
>> +			break;
>> +	if (cnt)
>> +		memblock_cap_memory_ranges(regs, cnt);
> 
> Why not simply call memblock_cap_memory_range() for each region?

Function memblock_cap_memory_range() removes all memory type ranges except specified range.
So if we call memblock_cap_memory_range() for each region simply, there will be no usable-memory
on kdump capture kernel.

Thanks,
Chen Zhou

> 
>>  }
>>  
>>  void __init arm64_memblock_init(void)
>> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>> index 47e3c06..aeade34 100644
>> --- a/include/linux/memblock.h
>> +++ b/include/linux/memblock.h
>> @@ -446,6 +446,7 @@ phys_addr_t memblock_start_of_DRAM(void);
>>  phys_addr_t memblock_end_of_DRAM(void);
>>  void memblock_enforce_memory_limit(phys_addr_t memory_limit);
>>  void memblock_cap_memory_range(phys_addr_t base, phys_addr_t size);
>> +void memblock_cap_memory_ranges(struct memblock_region *regs, int cnt);
>>  void memblock_mem_limit_remove_map(phys_addr_t limit);
>>  bool memblock_is_memory(phys_addr_t addr);
>>  bool memblock_is_map_memory(phys_addr_t addr);
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index 28fa8926..1a7f4ee7c 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -1697,6 +1697,46 @@ void __init memblock_cap_memory_range(phys_addr_t base, phys_addr_t size)
>>  			base + size, PHYS_ADDR_MAX);
>>  }
>>  
>> +void __init memblock_cap_memory_ranges(struct memblock_region *regs, int cnt)
>> +{
>> +	int start_rgn[INIT_MEMBLOCK_REGIONS], end_rgn[INIT_MEMBLOCK_REGIONS];
>> +	int i, j, ret, nr = 0;
>> +
>> +	for (i = 0; i < cnt; i++) {
>> +		ret = memblock_isolate_range(&memblock.memory, regs[i].base,
>> +				regs[i].size, &start_rgn[i], &end_rgn[i]);
>> +		if (ret)
>> +			break;
>> +		nr++;
>> +	}
>> +	if (!nr)
>> +		return;
>> +
>> +	/* remove all the MAP regions */
>> +	for (i = memblock.memory.cnt - 1; i >= end_rgn[nr - 1]; i--)
>> +		if (!memblock_is_nomap(&memblock.memory.regions[i]))
>> +			memblock_remove_region(&memblock.memory, i);
>> +
>> +	for (i = nr - 1; i > 0; i--)
>> +		for (j = start_rgn[i] - 1; j >= end_rgn[i - 1]; j--)
>> +			if (!memblock_is_nomap(&memblock.memory.regions[j]))
>> +				memblock_remove_region(&memblock.memory, j);
>> +
>> +	for (i = start_rgn[0] - 1; i >= 0; i--)
>> +		if (!memblock_is_nomap(&memblock.memory.regions[i]))
>> +			memblock_remove_region(&memblock.memory, i);
>> +
>> +	/* truncate the reserved regions */
>> +	memblock_remove_range(&memblock.reserved, 0, regs[0].base);
>> +
>> +	for (i = nr - 1; i > 0; i--)
>> +		memblock_remove_range(&memblock.reserved,
>> +				regs[i].base, regs[i - 1].base + regs[i - 1].size);
>> +
>> +	memblock_remove_range(&memblock.reserved,
>> +			regs[nr - 1].base + regs[nr - 1].size, PHYS_ADDR_MAX);
>> +}
>> +
>>  void __init memblock_mem_limit_remove_map(phys_addr_t limit)
>>  {
>>  	phys_addr_t max_addr;
>> -- 
>> 2.7.4
>>
> 

