Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A185CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D53DB20856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfJ3OMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 10:12:37 -0400
Received: from relay.sw.ru ([185.231.240.75]:39106 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbfJ3OMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 10:12:37 -0400
Received: from [172.16.25.5]
        by relay.sw.ru with esmtp (Exim 4.92.2)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1iPohu-0005hC-HE; Wed, 30 Oct 2019 17:12:18 +0300
Subject: Re: [PATCH v10 4/5] x86/kasan: support KASAN_VMALLOC
To:     Daniel Axtens <dja@axtens.net>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, x86@kernel.org, glider@google.com,
        luto@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, dvyukov@google.com, christophe.leroy@c-s.fr
Cc:     linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>
References: <20191029042059.28541-1-dja@axtens.net>
 <20191029042059.28541-5-dja@axtens.net>
 <a144eaca-d7e1-1a18-5975-bd0bfdb9450e@virtuozzo.com>
 <87sgnamjg2.fsf@dja-thinkpad.axtens.net>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <ff1c2089-9404-21f6-dac6-661917e47181@virtuozzo.com>
Date:   Wed, 30 Oct 2019 17:12:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87sgnamjg2.fsf@dja-thinkpad.axtens.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/30/19 4:50 PM, Daniel Axtens wrote:
> Andrey Ryabinin <aryabinin@virtuozzo.com> writes:
> 
>> On 10/29/19 7:20 AM, Daniel Axtens wrote:
>>> In the case where KASAN directly allocates memory to back vmalloc
>>> space, don't map the early shadow page over it.
>>>
>>> We prepopulate pgds/p4ds for the range that would otherwise be empty.
>>> This is required to get it synced to hardware on boot, allowing the
>>> lower levels of the page tables to be filled dynamically.
>>>
>>> Acked-by: Dmitry Vyukov <dvyukov@google.com>
>>> Signed-off-by: Daniel Axtens <dja@axtens.net>
>>>
>>> ---
>>
>>> +static void __init kasan_shallow_populate_pgds(void *start, void *end)
>>> +{
>>> +	unsigned long addr, next;
>>> +	pgd_t *pgd;
>>> +	void *p;
>>> +	int nid = early_pfn_to_nid((unsigned long)start);
>>
>> This doesn't make sense. start is not even a pfn. With linear mapping 
>> we try to identify nid to have the shadow on the same node as memory. But 
>> in this case we don't have memory or the corresponding shadow (yet),
>> we only install pgd/p4d.
>> I guess we could just use NUMA_NO_NODE.
> 
> Ah wow, that's quite the clanger on my part.
> 
> There are a couple of other invocations of early_pfn_to_nid in that file
> that use an address directly, but at least they reference actual memory.
> I'll send a separate patch to fix those up.

I see only one incorrect, in kasan_init(): early_pfn_to_nid(__pa(_stext))
It should be wrapped with PFN_DOWN().
Other usages in map_range() seems to be correct, range->start,end is pfns.


> 
>> The rest looks ok, so with that fixed:
>>
>> Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> 
> Thanks heaps! I've fixed up the nit you identifed in the first patch,
> and I agree that the last patch probably isn't needed. I'll respin the
> series shortly.
> 

Hold on a sec, just spotted another thing to fix.

> @@ -352,9 +397,24 @@ void __init kasan_init(void)
>  	shadow_cpu_entry_end = (void *)round_up(
>  			(unsigned long)shadow_cpu_entry_end, PAGE_SIZE);
>  
> +	/*
> +	 * If we're in full vmalloc mode, don't back vmalloc space with early
> +	 * shadow pages. Instead, prepopulate pgds/p4ds so they are synced to
> +	 * the global table and we can populate the lower levels on demand.
> +	 */
> +#ifdef CONFIG_KASAN_VMALLOC
> +	kasan_shallow_populate_pgds(
> +		kasan_mem_to_shadow((void *)PAGE_OFFSET + MAXMEM),

This should be VMALLOC_START, there is no point to allocate pgds for the hole between linear mapping
and vmalloc, just waste of memory. It make sense to map early shadow for that hole, because if code
dereferences address in that hole we will see the page fault on that address instead of fault on the shadow.

So something like this might work:

	kasan_populate_early_shadow(
		kasan_mem_to_shadow((void *)PAGE_OFFSET + MAXMEM),
		kasan_mem_to_shadow((void *)VMALLOC_START));

	if (IS_ENABLED(CONFIG_KASAN_VMALLOC)
		kasan_shallow_populate_pgds(kasan_mem_to_shadow(VMALLOC_START), kasan_mem_to_shadow((void *)VMALLOC_END))
	else
		kasan_populate_early_shadow(kasan_mem_to_shadow(VMALLOC_START), kasan_mem_to_shadow((void *)VMALLOC_END));

	kasan_populate_early_shadow(
		kasan_mem_to_shadow((void *)VMALLOC_END + 1),
		shadow_cpu_entry_begin);
