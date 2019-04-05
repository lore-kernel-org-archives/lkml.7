Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF0BC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 03:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08BA217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 03:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbfDEDDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 23:03:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6252 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727051AbfDEDDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 23:03:52 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 77E4C68E05D71F357661;
        Fri,  5 Apr 2019 11:03:49 +0800 (CST)
Received: from [127.0.0.1] (10.177.131.64) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Fri, 5 Apr 2019
 11:03:41 +0800
Subject: Re: [PATCH 1/3] arm64: kdump: support reserving crashkernel above 4G
To:     Mike Rapoport <rppt@linux.ibm.com>
References: <20190403030546.23718-1-chenzhou10@huawei.com>
 <20190403030546.23718-2-chenzhou10@huawei.com>
 <20190404144618.GB6433@rapoport-lnx>
CC:     <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <akpm@linux-foundation.org>, <ard.biesheuvel@linaro.org>,
        <takahiro.akashi@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
        <linux-mm@kvack.org>, <wangkefeng.wang@huawei.com>
From:   Chen Zhou <chenzhou10@huawei.com>
Message-ID: <59ef4532-2402-3887-2794-b503827fac5a@huawei.com>
Date:   Fri, 5 Apr 2019 11:03:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20190404144618.GB6433@rapoport-lnx>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.131.64]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Mike,

On 2019/4/4 22:46, Mike Rapoport wrote:
> Hi,
> 
> On Wed, Apr 03, 2019 at 11:05:44AM +0800, Chen Zhou wrote:
>> When crashkernel is reserved above 4G in memory, kernel should
>> reserve some amount of low memory for swiotlb and some DMA buffers.
>>
>> Kernel would try to allocate at least 256M below 4G automatically
>> as x86_64 if crashkernel is above 4G. Meanwhile, support
>> crashkernel=X,[high,low] in arm64.
>>
>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>> ---
>>  arch/arm64/kernel/setup.c |  3 ++
>>  arch/arm64/mm/init.c      | 71 +++++++++++++++++++++++++++++++++++++++++++++--
>>  2 files changed, 71 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>> index 413d566..82cd9a0 100644
>> --- a/arch/arm64/kernel/setup.c
>> +++ b/arch/arm64/kernel/setup.c
>> @@ -243,6 +243,9 @@ static void __init request_standard_resources(void)
>>  			request_resource(res, &kernel_data);
>>  #ifdef CONFIG_KEXEC_CORE
>>  		/* Userspace will find "Crash kernel" region in /proc/iomem. */
>> +		if (crashk_low_res.end && crashk_low_res.start >= res->start &&
>> +		    crashk_low_res.end <= res->end)
>> +			request_resource(res, &crashk_low_res);
>>  		if (crashk_res.end && crashk_res.start >= res->start &&
>>  		    crashk_res.end <= res->end)
>>  			request_resource(res, &crashk_res);
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index 6bc1350..ceb2a25 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -64,6 +64,57 @@ EXPORT_SYMBOL(memstart_addr);
>>  phys_addr_t arm64_dma_phys_limit __ro_after_init;
>>  
>>  #ifdef CONFIG_KEXEC_CORE
>> +static int __init reserve_crashkernel_low(void)
>> +{
>> +	unsigned long long base, low_base = 0, low_size = 0;
>> +	unsigned long total_low_mem;
>> +	int ret;
>> +
>> +	total_low_mem = memblock_mem_size(1UL << (32 - PAGE_SHIFT));
>> +
>> +	/* crashkernel=Y,low */
>> +	ret = parse_crashkernel_low(boot_command_line, total_low_mem, &low_size, &base);
>> +	if (ret) {
>> +		/*
>> +		 * two parts from lib/swiotlb.c:
>> +		 * -swiotlb size: user-specified with swiotlb= or default.
>> +		 *
>> +		 * -swiotlb overflow buffer: now hardcoded to 32k. We round it
>> +		 * to 8M for other buffers that may need to stay low too. Also
>> +		 * make sure we allocate enough extra low memory so that we
>> +		 * don't run out of DMA buffers for 32-bit devices.
>> +		 */
>> +		low_size = max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20);
>> +	} else {
>> +		/* passed with crashkernel=0,low ? */
>> +		if (!low_size)
>> +			return 0;
>> +	}
>> +
>> +	low_base = memblock_find_in_range(0, 1ULL << 32, low_size, SZ_2M);
>> +	if (!low_base) {
>> +		pr_err("Cannot reserve %ldMB crashkernel low memory, please try smaller size.\n",
>> +				(unsigned long)(low_size >> 20));
>> +		return -ENOMEM;
>> +	}
>> +
>> +	ret = memblock_reserve(low_base, low_size);
>> +	if (ret) {
>> +		pr_err("%s: Error reserving crashkernel low memblock.\n", __func__);
>> +		return ret;
>> +	}
>> +
>> +	pr_info("Reserving %ldMB of low memory at %ldMB for crashkernel (System RAM: %ldMB)\n",
>> +			(unsigned long)(low_size >> 20),
>> +			(unsigned long)(low_base >> 20),
>> +			(unsigned long)(total_low_mem >> 20));
>> +
>> +	crashk_low_res.start = low_base;
>> +	crashk_low_res.end   = low_base + low_size - 1;
>> +
>> +	return 0;
>> +}
>> +
>>  /*
>>   * reserve_crashkernel() - reserves memory for crash kernel
>>   *
>> @@ -74,19 +125,28 @@ phys_addr_t arm64_dma_phys_limit __ro_after_init;
>>  static void __init reserve_crashkernel(void)
>>  {
>>  	unsigned long long crash_base, crash_size;
>> +	bool high = false;
>>  	int ret;
>>  
>>  	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
>>  				&crash_size, &crash_base);
>>  	/* no crashkernel= or invalid value specified */
>> -	if (ret || !crash_size)
>> -		return;
>> +	if (ret || !crash_size) {
>> +		/* crashkernel=X,high */
>> +		ret = parse_crashkernel_high(boot_command_line, memblock_phys_mem_size(),
>> +				&crash_size, &crash_base);
>> +		if (ret || !crash_size)
>> +			return;
>> +		high = true;
>> +	}
>>  
>>  	crash_size = PAGE_ALIGN(crash_size);
>>  
>>  	if (crash_base == 0) {
>>  		/* Current arm64 boot protocol requires 2MB alignment */
>> -		crash_base = memblock_find_in_range(0, ARCH_LOW_ADDRESS_LIMIT,
>> +		crash_base = memblock_find_in_range(0,
>> +				high ? memblock_end_of_DRAM()
>> +				: ARCH_LOW_ADDRESS_LIMIT,
>>  				crash_size, SZ_2M);
>>  		if (crash_base == 0) {
>>  			pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
>> @@ -112,6 +172,11 @@ static void __init reserve_crashkernel(void)
>>  	}
>>  	memblock_reserve(crash_base, crash_size);
>>  
>> +	if (crash_base >= SZ_4G && reserve_crashkernel_low()) {
>> +		memblock_free(crash_base, crash_size);
>> +		return;
>> +	}
>> +
> 
> This very reminds what x86 does. Any chance some of the code can be reused
> rather than duplicated?

As i said in the comment, i transport reserve_crashkernel_low() from x86_64. There are minor
differences. In arm64, we don't need to do insert_resource(), we do request_resource()
in request_standard_resources() later.

How about doing like this:

move common reserve_crashkernel_low() code into kernel/kexec_core.c.
and do in x86 like this:
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -573,9 +573,12 @@ static void __init reserve_crashkernel(void)
                return;
        }

-       if (crash_base >= (1ULL << 32) && reserve_crashkernel_low()) {
-               memblock_free(crash_base, crash_size);
-               return;
+       if (crash_base >= (1ULL << 32)) {
+               if (reserve_crashkernel_low()) {
+                       memblock_free(crash_base, crash_size);
+                       return;
+               } else
+                       insert_resource(&iomem_resource, &crashk_low_res);
        }

> 
>>  	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
>>  		crash_base, crash_base + crash_size, crash_size >> 20);
>>  
>> -- 
>> 2.7.4
>>
> 

