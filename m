Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370FDC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13EB620866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbfFEQ31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 12:29:27 -0400
Received: from foss.arm.com ([217.140.101.70]:34516 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfFEQ30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 12:29:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DFE2374;
        Wed,  5 Jun 2019 09:29:26 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FBED3F5AF;
        Wed,  5 Jun 2019 09:29:22 -0700 (PDT)
Subject: Re: [PATCH 1/4] x86: kdump: move reserve_crashkernel_low() into
 kexec_core.c
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        akpm@linux-foundation.org, ard.biesheuvel@linaro.org,
        rppt@linux.ibm.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, ebiederm@xmission.com, horms@verge.net.au,
        takahiro.akashi@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-mm@kvack.org, wangkefeng.wang@huawei.com
References: <20190507035058.63992-1-chenzhou10@huawei.com>
 <20190507035058.63992-2-chenzhou10@huawei.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <6585f047-063c-6d6c-4967-1d8a472f30f4@arm.com>
Date:   Wed, 5 Jun 2019 17:29:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190507035058.63992-2-chenzhou10@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 07/05/2019 04:50, Chen Zhou wrote:
> In preparation for supporting reserving crashkernel above 4G
> in arm64 as x86_64 does, move reserve_crashkernel_low() into
> kexec/kexec_core.c.


> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 905dae8..9ee33b6 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -463,59 +460,6 @@ static void __init memblock_x86_reserve_range_setup_data(void)
>  # define CRASH_ADDR_HIGH_MAX	MAXMEM
>  #endif
>  
> -static int __init reserve_crashkernel_low(void)
> -{
> -#ifdef CONFIG_X86_64

The behaviour of this #ifdef has disappeared, won't 32bit x86 now try and reserve a chunk
of unnecessary 'low' memory?

[...]


> @@ -579,9 +523,13 @@ static void __init reserve_crashkernel(void)
>  		return;
>  	}
>  
> -	if (crash_base >= (1ULL << 32) && reserve_crashkernel_low()) {
> -		memblock_free(crash_base, crash_size);
> -		return;
> +	if (crash_base >= (1ULL << 32)) {
> +		if (reserve_crashkernel_low()) {
> +			memblock_free(crash_base, crash_size);
> +			return;
> +		}
> +
> +		insert_resource(&iomem_resource, &crashk_low_res);


Previously reserve_crashkernel_low() was #ifdefed to do nothing if !CONFIG_X86_64, I don't
see how 32bit is skipping this reservation...


>  	}
>  
>  	pr_info("Reserving %ldMB of memory at %ldMB for crashkernel (System RAM: %ldMB)\n",
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index b9b1bc5..096ad63 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -63,6 +63,10 @@
>  
>  #define KEXEC_CORE_NOTE_NAME	CRASH_CORE_NOTE_NAME
>  
> +#ifndef CRASH_ALIGN
> +#define CRASH_ALIGN SZ_128M
> +#endif

Why 128M? Wouldn't we rather each architecture tells us its minimum alignment?


> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index d714044..3492abd 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -39,6 +39,8 @@
>  #include <linux/compiler.h>
>  #include <linux/hugetlb.h>
>  #include <linux/frame.h>
> +#include <linux/memblock.h>
> +#include <linux/swiotlb.h>
>  
>  #include <asm/page.h>
>  #include <asm/sections.h>
> @@ -96,6 +98,60 @@ int kexec_crash_loaded(void)
>  }
>  EXPORT_SYMBOL_GPL(kexec_crash_loaded);
>  
> +int __init reserve_crashkernel_low(void)
> +{
> +	unsigned long long base, low_base = 0, low_size = 0;
> +	unsigned long total_low_mem;
> +	int ret;
> +
> +	total_low_mem = memblock_mem_size(1UL << (32 - PAGE_SHIFT));
> +
> +	/* crashkernel=Y,low */
> +	ret = parse_crashkernel_low(boot_command_line, total_low_mem,
> +			&low_size, &base);
> +	if (ret) {
> +		/*
> +		 * two parts from lib/swiotlb.c:
> +		 * -swiotlb size: user-specified with swiotlb= or default.
> +		 *
> +		 * -swiotlb overflow buffer: now hardcoded to 32k. We round it
> +		 * to 8M for other buffers that may need to stay low too. Also
> +		 * make sure we allocate enough extra low memory so that we
> +		 * don't run out of DMA buffers for 32-bit devices.
> +		 */
> +		low_size = max(swiotlb_size_or_default() + (8UL << 20),

SZ_8M?

> +				256UL << 20);

SZ_256M?


> +	} else {
> +		/* passed with crashkernel=0,low ? */
> +		if (!low_size)
> +			return 0;
> +	}
> +
> +	low_base = memblock_find_in_range(0, 1ULL << 32, low_size, CRASH_ALIGN);
> +	if (!low_base) {
> +		pr_err("Cannot reserve %ldMB crashkernel low memory, please try smaller size.\n",
> +		       (unsigned long)(low_size >> 20));
> +		return -ENOMEM;
> +	}
> +
> +	ret = memblock_reserve(low_base, low_size);
> +	if (ret) {
> +		pr_err("%s: Error reserving crashkernel low memblock.\n",
> +				__func__);
> +		return ret;
> +	}
> +
> +	pr_info("Reserving %ldMB of low memory at %ldMB for crashkernel (System low RAM: %ldMB)\n",
> +		(unsigned long)(low_size >> 20),
> +		(unsigned long)(low_base >> 20),
> +		(unsigned long)(total_low_mem >> 20));
> +
> +	crashk_low_res.start = low_base;
> +	crashk_low_res.end   = low_base + low_size - 1;
> +
> +	return 0;
> +}


Thanks,

James
