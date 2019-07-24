Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E7CC76191
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F1F229ED
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfGXI3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 04:29:38 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2746 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725870AbfGXI3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 04:29:38 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 58B05B3F612EF878FD0E;
        Wed, 24 Jul 2019 16:29:35 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Wed, 24 Jul 2019
 16:29:32 +0800
Subject: Re: [PATCH v12 1/2] mm: page_alloc: introduce
 memblock_next_valid_pfn() (again) for arm64
To:     Mike Rapoport <rppt@linux.ibm.com>
CC:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Jia He" <hejianet@gmail.com>, Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <1563861073-47071-1-git-send-email-guohanjun@huawei.com>
 <1563861073-47071-2-git-send-email-guohanjun@huawei.com>
 <20190723083027.GB4896@rapoport-lnx>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <e4668d2a-23d9-c089-c713-a4a0495e8c9e@huawei.com>
Date:   Wed, 24 Jul 2019 16:29:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20190723083027.GB4896@rapoport-lnx>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/7/23 16:30, Mike Rapoport wrote:
> On Tue, Jul 23, 2019 at 01:51:12PM +0800, Hanjun Guo wrote:
>> From: Jia He <hejianet@gmail.com>
>>
>> Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
>> where possible") optimized the loop in memmap_init_zone(). But it causes
>> possible panic on x86 due to specific memory mapping on x86_64 which will
>> skip valid pfns as well, so Daniel Vacek reverted it later.
>>
>> But as suggested by Daniel Vacek, it is fine to using memblock to skip
>> gaps and finding next valid frame with CONFIG_HAVE_ARCH_PFN_VALID.
>>
>> Daniel said:
>> "On arm and arm64, memblock is used by default. But generic version of
>> pfn_valid() is based on mem sections and memblock_next_valid_pfn() does
>> not always return the next valid one but skips more resulting in some
>> valid frames to be skipped (as if they were invalid). And that's why
>> kernel was eventually crashing on some !arm machines."
> 
> I think that the crash on x86 was not related to CONFIG_HAVE_ARCH_PFN_VALID
> but rather to the x86 way to setup memblock.  Some of the x86 reserved
> memory areas were never added to memblock.memory, which makes memblock's
> view of the physical memory incomplete and that's why
> memblock_next_valid_pfn() could skip valid PFNs on x86.

Thank you for kindly clarify, I will update the patch with your comments
in next version.

> 
>> Introduce a new config option CONFIG_HAVE_MEMBLOCK_PFN_VALID and only
>> selected for arm64, using the new config option to guard the
>> memblock_next_valid_pfn().
>  
> As far as I can tell, the memblock_next_valid_pfn() should work on most
> architectures and not only on ARM. For sure there is should be no
> dependency between CONFIG_HAVE_ARCH_PFN_VALID and memblock_next_valid_pfn().
> 
> I believe that the configuration option to guard memblock_next_valid_pfn()
> should be opt-out and that only x86 will require it.

So how about introduce a configuration option, say, CONFIG_HAVE_ARCH_PFN_INVALID,
selected by x86 and keep it default unselected for all other architecture?

> 
>> This was tested on a HiSilicon Kunpeng920 based ARM64 server, the speedup
>> is pretty impressive for bootmem_init() at boot:
>>
>> with 384G memory,
>> before: 13310ms
>> after:  1415ms
>>
>> with 1T memory,
>> before: 20s
>> after:  2s
>>
>> Suggested-by: Daniel Vacek <neelx@redhat.com>
>> Signed-off-by: Jia He <hejianet@gmail.com>
>> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
>> ---
>>  arch/arm64/Kconfig     |  1 +
>>  include/linux/mmzone.h |  9 +++++++++
>>  mm/Kconfig             |  3 +++
>>  mm/memblock.c          | 31 +++++++++++++++++++++++++++++++
>>  mm/page_alloc.c        |  4 +++-
>>  5 files changed, 47 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 697ea0510729..058eb26579be 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -893,6 +893,7 @@ config ARCH_FLATMEM_ENABLE
>>  
>>  config HAVE_ARCH_PFN_VALID
>>  	def_bool y
>> +	select HAVE_MEMBLOCK_PFN_VALID
>>
>>  config HW_PERF_EVENTS
>>  	def_bool y
>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>> index 70394cabaf4e..24cb6bdb1759 100644
>> --- a/include/linux/mmzone.h
>> +++ b/include/linux/mmzone.h
>> @@ -1325,6 +1325,10 @@ static inline int pfn_present(unsigned long pfn)
>>  #endif
>>  
>>  #define early_pfn_valid(pfn)	pfn_valid(pfn)
>> +#ifdef CONFIG_HAVE_MEMBLOCK_PFN_VALID
>> +extern unsigned long memblock_next_valid_pfn(unsigned long pfn);
>> +#define next_valid_pfn(pfn)	memblock_next_valid_pfn(pfn)
> 
> Please make it 'static inline' and move out of '#ifdef CONFIG_SPARSEMEM'

Will do.

> 
>> +#endif
>>  void sparse_init(void);
>>  #else
>>  #define sparse_init()	do {} while (0)
>> @@ -1347,6 +1351,11 @@ struct mminit_pfnnid_cache {
>>  #define early_pfn_valid(pfn)	(1)
>>  #endif
>>  
>> +/* fallback to default definitions */
>> +#ifndef next_valid_pfn
>> +#define next_valid_pfn(pfn)	(pfn + 1)
> 
> static inline as well.

OK.

> 
>> +#endif
>> +
>>  void memory_present(int nid, unsigned long start, unsigned long end);
>>  
>>  /*
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index f0c76ba47695..c578374b6413 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -132,6 +132,9 @@ config HAVE_MEMBLOCK_NODE_MAP
>>  config HAVE_MEMBLOCK_PHYS_MAP
>>  	bool
>>  
>> +config HAVE_MEMBLOCK_PFN_VALID
>> +	bool
>> +
>>  config HAVE_GENERIC_GUP
>>  	bool
>>  
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index 7d4f61ae666a..d57ba51bb9cd 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -1251,6 +1251,37 @@ int __init_memblock memblock_set_node(phys_addr_t base, phys_addr_t size,
>>  	return 0;
>>  }
>>  #endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
>> +
>> +#ifdef CONFIG_HAVE_MEMBLOCK_PFN_VALID
>> +unsigned long __init_memblock memblock_next_valid_pfn(unsigned long pfn)
>> +{
>> +	struct memblock_type *type = &memblock.memory;
>> +	unsigned int right = type->cnt;
>> +	unsigned int mid, left = 0;
>> +	phys_addr_t addr = PFN_PHYS(++pfn);
>> +
>> +	do {
>> +		mid = (right + left) / 2;
>> +
>> +		if (addr < type->regions[mid].base)
>> +			right = mid;
>> +		else if (addr >= (type->regions[mid].base +
>> +				  type->regions[mid].size))
>> +			left = mid + 1;
>> +		else {
>> +			/* addr is within the region, so pfn is valid */
>> +			return pfn;
>> +		}
>> +	} while (left < right);
>> +
> 
> We have memblock_search() for this.

I will update my patch as you suggested.

Thanks
Hanjun

