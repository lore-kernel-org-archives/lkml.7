Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78042C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E54206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfKNAyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 19:54:25 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:41320 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726393AbfKNAyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 19:54:24 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=shile.zhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Ti0NhcR_1573692861;
Received: from ali-6c96cfdd1403.local(mailfrom:shile.zhang@linux.alibaba.com fp:SMTPD_---0Ti0NhcR_1573692861)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 14 Nov 2019 08:54:22 +0800
Subject: Re: [PATCH] mm/vmalloc: Fix regression caused by needless
 vmalloc_sync_all()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Joerg Roedel <jroedel@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>, Qian Cai <cai@lca.pw>
References: <20191113095530.228959-1-shile.zhang@linux.alibaba.com>
 <20191113131237.1757241fb0c458484c2b19aa@linux-foundation.org>
From:   Shile Zhang <shile.zhang@linux.alibaba.com>
Message-ID: <84cb4721-bb8c-f45b-37d5-95a06ceea2aa@linux.alibaba.com>
Date:   Thu, 14 Nov 2019 08:54:21 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113131237.1757241fb0c458484c2b19aa@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix wrong cc list.

On 2019/11/14 05:12, Andrew Morton wrote:
> On Wed, 13 Nov 2019 17:55:30 +0800 Shile Zhang <shile.zhang@linux.alibaba.com> wrote:
>
>> vmalloc_sync_all() was put in the common path in
>> __purge_vmap_area_lazy(), for one sync issue only happened on X86_32
>> with PTI enabled. It is needless for X86_64, which caused a big regression
>> in UnixBench Shell8 testing on X86_64.
>> Similar regression also reported by 0-day kernel test robot in reaim
>> benchmarking:
>> https://lists.01.org/hyperkitty/list/lkp@lists.01.org/thread/4D3JPPHBNOSPFK2KEPC6KGKS6J25AIDB/
> That is indeed a large performance regression.
>
>> Fix it by adding more conditions.
>>
>> Fixes: 3f8fd02b1bf1 ("mm/vmalloc: Sync unmappings in __purge_vmap_area_lazy()")
>>
>> ...
>>
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -1255,11 +1255,17 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
>>   	if (unlikely(valist == NULL))
>>   		return false;
>>   
>> +#if defined(CONFIG_X86_32) && defined(CONFIG_X86_PAE)
> Are we sure that x86_32 is the only architecture whcih is (or ever will
> be) affected?
>
>>   	/*
>>   	 * First make sure the mappings are removed from all page-tables
>>   	 * before they are freed.
>> +	 *
>> +	 * This is only needed on x86-32 with !SHARED_KERNEL_PMD, which is
>> +	 * the case on a PAE kernel with PTI enabled.
>>   	 */
>> -	vmalloc_sync_all();
>> +	if (!SHARED_KERNEL_PMD && boot_cpu_has(X86_FEATURE_PTI))
>> +		vmalloc_sync_all();
>> +#endif
>>   
>>   	/*
>>   	 * TODO: to calculate a flush range without looping.
> CONFIG_X86_PAE depends on CONFIG_X86_32 so no need to check
> CONFIG_X86_32?

Yes, Thanks for your review and kindly refactoring!

> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: mm-vmalloc-fix-regression-caused-by-needless-vmalloc_sync_all-fix
>
> simplify config expression, use IS_ENABLED()
>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Shile Zhang <shile.zhang@linux.alibaba.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
>   mm/vmalloc.c |   21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)
>
> --- a/mm/vmalloc.c~mm-vmalloc-fix-regression-caused-by-needless-vmalloc_sync_all-fix
> +++ a/mm/vmalloc.c
> @@ -1255,16 +1255,17 @@ static bool __purge_vmap_area_lazy(unsig
>   	if (unlikely(valist == NULL))
>   		return false;
>   
> -#if defined(CONFIG_X86_32) && defined(CONFIG_X86_PAE)
> -	/*
> -	 * First make sure the mappings are removed from all page-tables
> -	 * before they are freed.
> -	 *
> -	 * This is only needed on x86-32 with !SHARED_KERNEL_PMD, which is
> -	 * the case on a PAE kernel with PTI enabled.
> -	 */
> -	if (!SHARED_KERNEL_PMD && boot_cpu_has(X86_FEATURE_PTI))
> -		vmalloc_sync_all();
> +	if (IS_ENABLED(CONFIG_X86_PAE)) {
> +		/*
> +		 * First make sure the mappings are removed from all page-tables
> +		 * before they are freed.
> +		 *
> +		 * This is only needed on x86-32 with !SHARED_KERNEL_PMD, which
> +		 * is the case on a PAE kernel with PTI enabled.
> +		 */
> +		if (!SHARED_KERNEL_PMD && boot_cpu_has(X86_FEATURE_PTI))
> +			vmalloc_sync_all();
> +	}
>   #endif
>   
>   	/*
> _

