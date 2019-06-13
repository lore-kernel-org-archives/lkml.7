Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F1FC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A78B206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730947AbfFMP2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:28:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33758 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727014AbfFML1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 07:27:12 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3EE9C84A0E22CFC1DCFB;
        Thu, 13 Jun 2019 19:27:10 +0800 (CST)
Received: from [127.0.0.1] (10.177.131.64) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Thu, 13 Jun 2019
 19:26:59 +0800
Subject: Re: [PATCH 1/4] x86: kdump: move reserve_crashkernel_low() into
 kexec_core.c
To:     James Morse <james.morse@arm.com>
References: <20190507035058.63992-1-chenzhou10@huawei.com>
 <20190507035058.63992-2-chenzhou10@huawei.com>
 <6585f047-063c-6d6c-4967-1d8a472f30f4@arm.com>
CC:     <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <akpm@linux-foundation.org>, <ard.biesheuvel@linaro.org>,
        <rppt@linux.ibm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <ebiederm@xmission.com>, <horms@verge.net.au>,
        <takahiro.akashi@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
        <linux-mm@kvack.org>, <wangkefeng.wang@huawei.com>
From:   Chen Zhou <chenzhou10@huawei.com>
Message-ID: <4716a864-9560-f198-5899-9a5dee1fac20@huawei.com>
Date:   Thu, 13 Jun 2019 19:26:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <6585f047-063c-6d6c-4967-1d8a472f30f4@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.131.64]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Thanks for your review.

On 2019/6/6 0:29, James Morse wrote:
> Hello,
> 
> On 07/05/2019 04:50, Chen Zhou wrote:
>> In preparation for supporting reserving crashkernel above 4G
>> in arm64 as x86_64 does, move reserve_crashkernel_low() into
>> kexec/kexec_core.c.
> 
> 
>> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
>> index 905dae8..9ee33b6 100644
>> --- a/arch/x86/kernel/setup.c
>> +++ b/arch/x86/kernel/setup.c
>> @@ -463,59 +460,6 @@ static void __init memblock_x86_reserve_range_setup_data(void)
>>  # define CRASH_ADDR_HIGH_MAX	MAXMEM
>>  #endif
>>  
>> -static int __init reserve_crashkernel_low(void)
>> -{
>> -#ifdef CONFIG_X86_64
> 
> The behaviour of this #ifdef has disappeared, won't 32bit x86 now try and reserve a chunk
> of unnecessary 'low' memory?
> 
> [...]

At present, reserve_crashkernel_low() is called only when reserving crashkernel above 4G, so i deleted
this #ifdef.
If we called reserve_crashkernel_low() at the beginning of reserve_crashkernel(), i need to add it back.

> 
> 
>> @@ -579,9 +523,13 @@ static void __init reserve_crashkernel(void)
>>  		return;
>>  	}
>>  
>> -	if (crash_base >= (1ULL << 32) && reserve_crashkernel_low()) {
>> -		memblock_free(crash_base, crash_size);
>> -		return;
>> +	if (crash_base >= (1ULL << 32)) {
>> +		if (reserve_crashkernel_low()) {
>> +			memblock_free(crash_base, crash_size);
>> +			return;
>> +		}
>> +
>> +		insert_resource(&iomem_resource, &crashk_low_res);
> 
> 
> Previously reserve_crashkernel_low() was #ifdefed to do nothing if !CONFIG_X86_64, I don't
> see how 32bit is skipping this reservation...
> 
> 
>>  	}
>>  
>>  	pr_info("Reserving %ldMB of memory at %ldMB for crashkernel (System RAM: %ldMB)\n",
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index b9b1bc5..096ad63 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -63,6 +63,10 @@
>>  
>>  #define KEXEC_CORE_NOTE_NAME	CRASH_CORE_NOTE_NAME
>>  
>> +#ifndef CRASH_ALIGN
>> +#define CRASH_ALIGN SZ_128M
>> +#endif
> 
> Why 128M? Wouldn't we rather each architecture tells us its minimum alignment?

Yeah, each architecture should tells us its minimum alignment. I added this default size to
fix compiling error on some architecture which didn't define it. I will add x86_64 and arm64
restriction on reserve_crashkernel_low() and delete this define.

> 
> 
>> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
>> index d714044..3492abd 100644
>> --- a/kernel/kexec_core.c
>> +++ b/kernel/kexec_core.c
>> @@ -39,6 +39,8 @@
>>  #include <linux/compiler.h>
>>  #include <linux/hugetlb.h>
>>  #include <linux/frame.h>
>> +#include <linux/memblock.h>
>> +#include <linux/swiotlb.h>
>>  
>>  #include <asm/page.h>
>>  #include <asm/sections.h>
>> @@ -96,6 +98,60 @@ int kexec_crash_loaded(void)
>>  }
>>  EXPORT_SYMBOL_GPL(kexec_crash_loaded);
>>  
>> +int __init reserve_crashkernel_low(void)
>> +{
>> +	unsigned long long base, low_base = 0, low_size = 0;
>> +	unsigned long total_low_mem;
>> +	int ret;
>> +
>> +	total_low_mem = memblock_mem_size(1UL << (32 - PAGE_SHIFT));
>> +
>> +	/* crashkernel=Y,low */
>> +	ret = parse_crashkernel_low(boot_command_line, total_low_mem,
>> +			&low_size, &base);
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
>> +		low_size = max(swiotlb_size_or_default() + (8UL << 20),
> 
> SZ_8M?
> 
>> +				256UL << 20);
> 
> SZ_256M?
> 

There is compiling warning "warning: comparison of distinct pointer types lacks a cast" if just use
SZ_8M or SZ_256M. We need cast swiotlb_size_or_default() to type int,so i kept the old as in x86_64.

> 
>> +	} else {
>> +		/* passed with crashkernel=0,low ? */
>> +		if (!low_size)
>> +			return 0;
>> +	}
>> +
>> +	low_base = memblock_find_in_range(0, 1ULL << 32, low_size, CRASH_ALIGN);
>> +	if (!low_base) {
>> +		pr_err("Cannot reserve %ldMB crashkernel low memory, please try smaller size.\n",
>> +		       (unsigned long)(low_size >> 20));
>> +		return -ENOMEM;
>> +	}
>> +
>> +	ret = memblock_reserve(low_base, low_size);
>> +	if (ret) {
>> +		pr_err("%s: Error reserving crashkernel low memblock.\n",
>> +				__func__);
>> +		return ret;
>> +	}
>> +
>> +	pr_info("Reserving %ldMB of low memory at %ldMB for crashkernel (System low RAM: %ldMB)\n",
>> +		(unsigned long)(low_size >> 20),
>> +		(unsigned long)(low_base >> 20),
>> +		(unsigned long)(total_low_mem >> 20));
>> +
>> +	crashk_low_res.start = low_base;
>> +	crashk_low_res.end   = low_base + low_size - 1;
>> +
>> +	return 0;
>> +}
> 
> 
> Thanks,
> 
> James
> 
> .
> 

Thanks,
Chen Zhou

