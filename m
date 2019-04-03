Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C00C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D958206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqEZJmem"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfDCR1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:27:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34964 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfDCR1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 13:27:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id w1so22541647wrp.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 10:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T7D/wXifS4iP+hB98gknk99uF7IV76FeYJBlRn4gwjA=;
        b=YqEZJmem4g0Cndk6gVnCSLj+0H9Cfv6OSwPcUAXADipMPpsyGnvukr75sv1L8V+kEA
         6xKdgF/rqkbqigIhiMCKcDveXckkb3OdVMu1qxHO68HaYhQrJ7YpWWUa+0NnX2ipI4NC
         VfuJcOnmCakiQUXxAHm0g1XRrBBy3B4MfTUS4gmpCwWdmjrKiMWxvXoVYLNkkodQTEfI
         eL67NgNtWp0dWptIrO3u4RZjFOs2m2/NN88UR/y3K55ZvVMVO2IGYrZNagWXaiU8sGzu
         eAXOK9jMhn727B3SdshUW0qrO24EcUPgClEYZIwe1G/xnXnidpgmPNdisj4Q8DZOGtlR
         0e9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=T7D/wXifS4iP+hB98gknk99uF7IV76FeYJBlRn4gwjA=;
        b=YFrI1/EB4RYH6ZUCkmS7D+hUUb3KT/JLbmPfTuaENr/RFebUiwFvWKXEplzgifsOrU
         UMbJ0drd7TEI9bEQpYtbqKqzcJmd/XcdUxt2RJj5rKL2NnU94TKO+B4ACrXvoBWIOq77
         P5l0HexH4qEor3uKz4aNM+aKBA99XieIEWNCWNAwxez5hZAcA0NCIXknodnxuxw0EVnW
         UyeAKzX+MyIWtqlqBaAZykDtsXIctz4+fSfu/2Q4Rjm7EAYnO4vSRFtU0AE6uejQ7OLp
         zL7p+EvTJsBMDgD8LMjrUygVeO1JyC+xGctiIqXf4ZlkLLevRZkftKyRE3kdvc2+NVN8
         LJfA==
X-Gm-Message-State: APjAAAXXFfNi5vLAfmaPK8tGiuS0dTu65Pl33KvdRq2fttBn1nrUy2+Z
        WolclW4WzVniI/ALAGQSQQ2Mx6+q
X-Google-Smtp-Source: APXvYqxN4XOwnXi057BC/6gTYdvPoXgD0ZsKd22WQ/a5pxxVBE2IGsq7VvJDyLoN9nl3JrPfNAlH5w==
X-Received: by 2002:adf:eac9:: with SMTP id o9mr518335wrn.85.1554312455740;
        Wed, 03 Apr 2019 10:27:35 -0700 (PDT)
Received: from [10.67.49.126] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id v16sm31649802wro.48.2019.04.03.10.27.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 10:27:34 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] initrd: move initrd_start calculate within linear
 mapping range check
To:     Will Deacon <will.deacon@arm.com>, pierre kuo <vichy.kuo@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Steven Price <steven.price@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ard.biesheuvel@linaro.org
References: <20190314032047.15790-1-vichy.kuo@gmail.com>
 <20190319153114.GI59586@arrakis.emea.arm.com>
 <CAOVJa8HSB34ggku=96KAb6qju3G5-uGYFxCE6O2eQRMwU4bd1A@mail.gmail.com>
 <CAOVJa8Eefs7cEneNwV0VCrr8GLVb0AweJEb0Qo4TucgXTNuNWg@mail.gmail.com>
 <20190401153810.GC6884@fuggles.cambridge.arm.com>
 <CAOVJa8EcjQO2GuojwBxfFG25+T-z6BR6ytZBdcV2W2XusyW08g@mail.gmail.com>
 <20190403172429.GE17500@fuggles.cambridge.arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <a05d8116-4363-ed3d-d457-b0f363882995@gmail.com>
Date:   Wed, 3 Apr 2019 10:27:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190403172429.GE17500@fuggles.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/19 10:24 AM, Will Deacon wrote:
> On Thu, Apr 04, 2019 at 12:44:25AM +0800, pierre kuo wrote:
>>> On Mon, Apr 01, 2019 at 10:59:53PM +0800, pierre kuo wrote:
>>>>>> With CONFIG_RANDOMIZE_BASE we can get a further change to memstart_addr
>>>>>> after the place where you moved the initrd_{start,end} setting, which
>>>>>> would result in a different value for __phys_to_virt(phys_initrd_start).
>>>>>
>>>>> I found what you mean, since __phys_to_virt will use PHYS_OFFSET
>>>>> (memstart_addr) for calculating.
>>>>> How about moving CONFIG_RANDOMIZE_BASE part of code ahead of
>>>>> CONFIG_BLK_DEV_INITRD checking?
>>>>>
>>>>> That means below (d) moving ahead of (c)
>>>>> prvious:
>>>>> if (memstart_addr + linear_region_size < memblock_end_of_DRAM()) {} ---(a)
>>>>> if (memory_limit != PHYS_ADDR_MAX) {}            ---(b)
>>>>> if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {} ---(c)
>>>>> if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {} ---(d)
>>>>>
>>>>> now:
>>>>> if (memstart_addr + linear_region_size < memblock_end_of_DRAM()) { ---(a)
>>>>> if (memory_limit != PHYS_ADDR_MAX) {}              ----------------(b)
>>>>> if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {}  --------------(d)
>>>>> if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {}  ---(c)
>>>>>
>>>>
>>>> After tracing the kernel code,
>>>> is it even possible to move CONFIG_RANDOMIZE_BASE part of code ahead
>>>> of memory_limit?
>>>>
>>>> that mean the flow may look like below:
>>>> now2:
>>>> if (memstart_addr + linear_region_size < memblock_end_of_DRAM()) {} ---(a)
>>>> if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {} ---(d)
>>>> if (memory_limit != PHYS_ADDR_MAX) {}            ---(b)
>>>> if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {} ---(c)
>>>>
>>>> in (b), the result of __pa_symbol(_text), memory_limit,
>>>> memblock_mem_limit_remove_map and  memblock_add
>>>> are not depended on memsart_addr.
>>>> So the now2 flow can grouping modification of memstart_address, put
>>>> (a) and (d) together.
>>>
>>> I'm afraid that you've lost me with this.
>> welcome for ur kind suggestion ^^
>>
>>> Why isn't it just as simple as
>>> the diff below?
>>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>>> index c29b17b520cd..ec3487c94b10 100644
>>> --- a/arch/arm64/mm/init.c
>>> +++ b/arch/arm64/mm/init.c
>>> @@ -377,7 +377,7 @@ void __init arm64_memblock_init(void)
>>>                          base + size > memblock_start_of_DRAM() +
>>>                                        linear_region_size,
>>>                         "initrd not fully accessible via the linear mapping -- please check your bootloader ...\n")) {
>>> -                       initrd_start = 0;
>>> +                       phys_initrd_size = 0;
>>>                 } else {
>>>                         memblock_remove(base, size); /* clear MEMBLOCK_ flags */
>>>                         memblock_add(base, size);
>>
>> This patch will also fix the issue, but it still needs 2 "if
>> comparisions" for getting initrd_start/initrd_end.
>> By possible grouping modification of memstart_address, and put
>> initrd_start/initrd_end to be calculated only when linear mapping check
>> pass. Maybe (just if) can let the code be more concise.
> 
> Maybe, but I don't think we've seen a patch which accomplishes that. I think
> I'll go ahead and commit the basic one-liner, then we can always improve it
> afterwards if somebody sends a patch. It's not like this is a fastpath.

Sorry for the slow response and introducing the bug in the first place,
yes, I agree here, an one-liner is a better way to get that fixed:

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
