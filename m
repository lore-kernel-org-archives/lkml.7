Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8045C10F13
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 02:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC424206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 02:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfDOC1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 22:27:43 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35776 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725789AbfDOC1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 22:27:42 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 470ACB05A20EA7ED8FC5;
        Mon, 15 Apr 2019 10:27:40 +0800 (CST)
Received: from [127.0.0.1] (10.177.131.64) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Mon, 15 Apr 2019
 10:27:33 +0800
Subject: Re: [PATCH v3 3/4] arm64: kdump: support more than one crash kernel
 regions
To:     Mike Rapoport <rppt@linux.ibm.com>
References: <20190409102819.121335-1-chenzhou10@huawei.com>
 <20190409102819.121335-4-chenzhou10@huawei.com>
 <20190414121315.GD20947@rapoport-lnx>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <ebiederm@xmission.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <akpm@linux-foundation.org>,
        <ard.biesheuvel@linaro.org>, <horms@verge.net.au>,
        <takahiro.akashi@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
        <linux-mm@kvack.org>, <wangkefeng.wang@huawei.com>
From:   Chen Zhou <chenzhou10@huawei.com>
Message-ID: <b43e586c-219c-2911-c8c8-ba66ff7ce926@huawei.com>
Date:   Mon, 15 Apr 2019 10:27:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20190414121315.GD20947@rapoport-lnx>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.131.64]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 2019/4/14 20:13, Mike Rapoport wrote:
> Hi,
> 
> On Tue, Apr 09, 2019 at 06:28:18PM +0800, Chen Zhou wrote:
>> After commit (arm64: kdump: support reserving crashkernel above 4G),
>> there may be two crash kernel regions, one is below 4G, the other is
>> above 4G.
>>
>> Crash dump kernel reads more than one crash kernel regions via a dtb
>> property under node /chosen,
>> linux,usable-memory-range = <BASE1 SIZE1 [BASE2 SIZE2]>
> 
> Somehow I've missed that previously, but how is this supposed to work on
> EFI systems?

Whatever the way in which the systems work, there is FDT pointer(__fdt_pointer)
in arm64 kernel and file /sys/firmware/fdt will be created in late_initcall.

Kexec-tools read and update file /sys/firmware/fdt in EFI systems to support kdump to
boot capture kernel.

For supporting more than one crash kernel regions, kexec-tools make changes accordingly.
Details are in below:
http://lists.infradead.org/pipermail/kexec/2019-April/022792.html

Thanks,
Chen Zhou

>  
>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>> ---
>>  arch/arm64/mm/init.c     | 66 ++++++++++++++++++++++++++++++++++++++++--------
>>  include/linux/memblock.h |  6 +++++
>>  mm/memblock.c            |  7 ++---
>>  3 files changed, 66 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index 3bebddf..0f18665 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -65,6 +65,11 @@ phys_addr_t arm64_dma_phys_limit __ro_after_init;
>>  
>>  #ifdef CONFIG_KEXEC_CORE
>>  
>> +/* at most two crash kernel regions, low_region and high_region */
>> +#define CRASH_MAX_USABLE_RANGES	2
>> +#define LOW_REGION_IDX			0
>> +#define HIGH_REGION_IDX			1
>> +
>>  /*
>>   * reserve_crashkernel() - reserves memory for crash kernel
>>   *
>> @@ -297,8 +302,8 @@ static int __init early_init_dt_scan_usablemem(unsigned long node,
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
>> @@ -307,22 +312,63 @@ static int __init early_init_dt_scan_usablemem(unsigned long node,
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
>> +
>> +	if (cnt - 1 == LOW_REGION_IDX)
>> +		memblock_cap_memory_range(regs[LOW_REGION_IDX].base,
>> +				regs[LOW_REGION_IDX].size);
>> +	else if (cnt - 1 == HIGH_REGION_IDX) {
>> +		/*
>> +		 * Two crash kernel regions, cap the memory range
>> +		 * [regs[LOW_REGION_IDX].base, regs[HIGH_REGION_IDX].end]
>> +		 * and then remove the memory range in the middle.
>> +		 */
>> +		int start_rgn, end_rgn, i, ret;
>> +		phys_addr_t mid_base, mid_size;
>> +
>> +		mid_base = regs[LOW_REGION_IDX].base + regs[LOW_REGION_IDX].size;
>> +		mid_size = regs[HIGH_REGION_IDX].base - mid_base;
>> +		ret = memblock_isolate_range(&memblock.memory, mid_base,
>> +				mid_size, &start_rgn, &end_rgn);
>>  
>> -	of_scan_flat_dt(early_init_dt_scan_usablemem, &reg);
>> +		if (ret)
>> +			return;
>>  
>> -	if (reg.size)
>> -		memblock_cap_memory_range(reg.base, reg.size);
>> +		memblock_cap_memory_range(regs[LOW_REGION_IDX].base,
>> +				regs[HIGH_REGION_IDX].base -
>> +				regs[LOW_REGION_IDX].base +
>> +				regs[HIGH_REGION_IDX].size);
>> +		for (i = end_rgn - 1; i >= start_rgn; i--) {
>> +			if (!memblock_is_nomap(&memblock.memory.regions[i]))
>> +				memblock_remove_region(&memblock.memory, i);
>> +		}
>> +		memblock_remove_range(&memblock.reserved, mid_base,
>> +				mid_base + mid_size);
>> +	}
>>  }
>>  
>>  void __init arm64_memblock_init(void)
>> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>> index 294d5d8..787d252 100644
>> --- a/include/linux/memblock.h
>> +++ b/include/linux/memblock.h
>> @@ -110,9 +110,15 @@ void memblock_discard(void);
>>  
>>  phys_addr_t memblock_find_in_range(phys_addr_t start, phys_addr_t end,
>>  				   phys_addr_t size, phys_addr_t align);
>> +void memblock_remove_region(struct memblock_type *type, unsigned long r);
>>  void memblock_allow_resize(void);
>>  int memblock_add_node(phys_addr_t base, phys_addr_t size, int nid);
>>  int memblock_add(phys_addr_t base, phys_addr_t size);
>> +int memblock_isolate_range(struct memblock_type *type,
>> +					phys_addr_t base, phys_addr_t size,
>> +					int *start_rgn, int *end_rgn);
>> +int memblock_remove_range(struct memblock_type *type,
>> +					phys_addr_t base, phys_addr_t size);
>>  int memblock_remove(phys_addr_t base, phys_addr_t size);
>>  int memblock_free(phys_addr_t base, phys_addr_t size);
>>  int memblock_reserve(phys_addr_t base, phys_addr_t size);
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index e7665cf..1846e2d 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -357,7 +357,8 @@ phys_addr_t __init_memblock memblock_find_in_range(phys_addr_t start,
>>  	return ret;
>>  }
>>  
>> -static void __init_memblock memblock_remove_region(struct memblock_type *type, unsigned long r)
>> +void __init_memblock memblock_remove_region(struct memblock_type *type,
>> +					unsigned long r)
>>  {
>>  	type->total_size -= type->regions[r].size;
>>  	memmove(&type->regions[r], &type->regions[r + 1],
>> @@ -724,7 +725,7 @@ int __init_memblock memblock_add(phys_addr_t base, phys_addr_t size)
>>   * Return:
>>   * 0 on success, -errno on failure.
>>   */
>> -static int __init_memblock memblock_isolate_range(struct memblock_type *type,
>> +int __init_memblock memblock_isolate_range(struct memblock_type *type,
>>  					phys_addr_t base, phys_addr_t size,
>>  					int *start_rgn, int *end_rgn)
>>  {
>> @@ -784,7 +785,7 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
>>  	return 0;
>>  }
>>  
>> -static int __init_memblock memblock_remove_range(struct memblock_type *type,
>> +int __init_memblock memblock_remove_range(struct memblock_type *type,
>>  					  phys_addr_t base, phys_addr_t size)
>>  {
>>  	int start_rgn, end_rgn;
>> -- 
>> 2.7.4
>>
> 

