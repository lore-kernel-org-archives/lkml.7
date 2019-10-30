Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9159ACA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67FB120578
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="qwVsaT6C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfJ3OVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 10:21:20 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33818 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfJ3OVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 10:21:20 -0400
Received: by mail-pl1-f193.google.com with SMTP id k7so1070992pll.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 07:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=lLBDwfjg5YnQXNE+xQ4JmNR71OHaPXxKWZ+MT4DW3/A=;
        b=qwVsaT6Cw4Ycn/P/j7rzKjSzfApSkeaGvKWAkHM/AoJ0x7w8gndNK3s7Etg8RRAxdM
         dJrZ61KmDDSt6pgTwvga1te1T0yseF+wo8rR0CZAnXvXPZmyS0ogKROK46Oehne5rc//
         DMWh8+9qmkJfrb4qW2K18Bcyf+/n6OHl40DOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=lLBDwfjg5YnQXNE+xQ4JmNR71OHaPXxKWZ+MT4DW3/A=;
        b=uoU5VgBDPG4tqjScrhB3KJbOqzXJwezzMb534Ghtt8AFeKpMW3EEWtr/dokfxzl6vo
         i/0KkaB6pOCTzge56324L9pOR68gNBCcXOgmjo/GGHl/VQj1t+uUGJ2dQle+OHNUSjlZ
         57QDqVaJAm5ssapxkrTDYWVzL9me20Sk9jM7X1WKJ6HUeSPeCr/w3m35igvuTZs+u0lr
         QfLKT6up9exP4JbhmViy3aAP/8SzERCbQ9U4XqGuO000TsleRhQDIsgQkSq1rseYoQ2k
         Mxxv+7jAowM8g2f9hU7l1lR0pi+Cumds8z2LZCVqoyqaNOJZ2l6NyUYzOSMYE4YkVfvW
         nldA==
X-Gm-Message-State: APjAAAVfOJdBsQ+Uko+1XKIpF6ekTL56gdD40mTrsoeSzmVU68hTtouc
        ayjzHmEhbPe0q9AcFsI2EUF/frwKn10=
X-Google-Smtp-Source: APXvYqwMC7s8c7Hz5nvb/Nz/tGRMlobeX2sZ75mjj1c4WbVrvDU+HedG/Uqdzo2fEk41IYyK90rWig==
X-Received: by 2002:a17:902:44d:: with SMTP id 71mr241216ple.274.1572445277919;
        Wed, 30 Oct 2019 07:21:17 -0700 (PDT)
Received: from localhost (2001-44b8-1113-6700-783a-2bb9-f7cb-7c3c.static.ipv6.internode.on.net. [2001:44b8:1113:6700:783a:2bb9:f7cb:7c3c])
        by smtp.gmail.com with ESMTPSA id q6sm75232pgn.44.2019.10.30.07.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 07:21:17 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        glider@google.com, luto@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, dvyukov@google.com, christophe.leroy@c-s.fr
Cc:     linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v10 4/5] x86/kasan: support KASAN_VMALLOC
In-Reply-To: <ff1c2089-9404-21f6-dac6-661917e47181@virtuozzo.com>
References: <20191029042059.28541-1-dja@axtens.net> <20191029042059.28541-5-dja@axtens.net> <a144eaca-d7e1-1a18-5975-bd0bfdb9450e@virtuozzo.com> <87sgnamjg2.fsf@dja-thinkpad.axtens.net> <ff1c2089-9404-21f6-dac6-661917e47181@virtuozzo.com>
Date:   Thu, 31 Oct 2019 01:21:13 +1100
Message-ID: <87mudimi06.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Ryabinin <aryabinin@virtuozzo.com> writes:

> On 10/30/19 4:50 PM, Daniel Axtens wrote:
>> Andrey Ryabinin <aryabinin@virtuozzo.com> writes:
>> 
>>> On 10/29/19 7:20 AM, Daniel Axtens wrote:
>>>> In the case where KASAN directly allocates memory to back vmalloc
>>>> space, don't map the early shadow page over it.
>>>>
>>>> We prepopulate pgds/p4ds for the range that would otherwise be empty.
>>>> This is required to get it synced to hardware on boot, allowing the
>>>> lower levels of the page tables to be filled dynamically.
>>>>
>>>> Acked-by: Dmitry Vyukov <dvyukov@google.com>
>>>> Signed-off-by: Daniel Axtens <dja@axtens.net>
>>>>
>>>> ---
>>>
>>>> +static void __init kasan_shallow_populate_pgds(void *start, void *end)
>>>> +{
>>>> +	unsigned long addr, next;
>>>> +	pgd_t *pgd;
>>>> +	void *p;
>>>> +	int nid = early_pfn_to_nid((unsigned long)start);
>>>
>>> This doesn't make sense. start is not even a pfn. With linear mapping 
>>> we try to identify nid to have the shadow on the same node as memory. But 
>>> in this case we don't have memory or the corresponding shadow (yet),
>>> we only install pgd/p4d.
>>> I guess we could just use NUMA_NO_NODE.
>> 
>> Ah wow, that's quite the clanger on my part.
>> 
>> There are a couple of other invocations of early_pfn_to_nid in that file
>> that use an address directly, but at least they reference actual memory.
>> I'll send a separate patch to fix those up.
>
> I see only one incorrect, in kasan_init(): early_pfn_to_nid(__pa(_stext))
> It should be wrapped with PFN_DOWN().
> Other usages in map_range() seems to be correct, range->start,end is pfns.
>

Oh, right, I didn't realise map_range was already using pfns.

>
>> 
>>> The rest looks ok, so with that fixed:
>>>
>>> Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
>> 
>> Thanks heaps! I've fixed up the nit you identifed in the first patch,
>> and I agree that the last patch probably isn't needed. I'll respin the
>> series shortly.
>> 
>
> Hold on a sec, just spotted another thing to fix.
>
>> @@ -352,9 +397,24 @@ void __init kasan_init(void)
>>  	shadow_cpu_entry_end = (void *)round_up(
>>  			(unsigned long)shadow_cpu_entry_end, PAGE_SIZE);
>>  
>> +	/*
>> +	 * If we're in full vmalloc mode, don't back vmalloc space with early
>> +	 * shadow pages. Instead, prepopulate pgds/p4ds so they are synced to
>> +	 * the global table and we can populate the lower levels on demand.
>> +	 */
>> +#ifdef CONFIG_KASAN_VMALLOC
>> +	kasan_shallow_populate_pgds(
>> +		kasan_mem_to_shadow((void *)PAGE_OFFSET + MAXMEM),
>
> This should be VMALLOC_START, there is no point to allocate pgds for the hole between linear mapping
> and vmalloc, just waste of memory. It make sense to map early shadow for that hole, because if code
> dereferences address in that hole we will see the page fault on that address instead of fault on the shadow.
>
> So something like this might work:
>
> 	kasan_populate_early_shadow(
> 		kasan_mem_to_shadow((void *)PAGE_OFFSET + MAXMEM),
> 		kasan_mem_to_shadow((void *)VMALLOC_START));
>
> 	if (IS_ENABLED(CONFIG_KASAN_VMALLOC)
> 		kasan_shallow_populate_pgds(kasan_mem_to_shadow(VMALLOC_START), kasan_mem_to_shadow((void *)VMALLOC_END))
> 	else
> 		kasan_populate_early_shadow(kasan_mem_to_shadow(VMALLOC_START), kasan_mem_to_shadow((void *)VMALLOC_END));
>
> 	kasan_populate_early_shadow(
> 		kasan_mem_to_shadow((void *)VMALLOC_END + 1),
> 		shadow_cpu_entry_begin);

Sounds good. It's getting late for me so I'll change and test that and
send a respin tomorrow my time.

Regards,
Daniel
