Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76623CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4289D20650
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="Y95oQ188"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404369AbfJWKXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 06:23:19 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55246 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404104AbfJWKXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 06:23:18 -0400
Received: by mail-wm1-f68.google.com with SMTP id g7so2520896wmk.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 03:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZqJp5QwTHeIfd54hVsbdTrPly7o1sW/Jce3j5kYMOAQ=;
        b=Y95oQ188QQJadaABHsdBlC4b+Z+qqdbz8Wymda4ai2n+ry3KZN4972cwzuAPT6vO3t
         Yw5ti/CEODV09yx7rdBrqNPM8OcKZBP80LV31IxcPR3SxVUEGmwQNTHuCZKSBjIR1uNb
         UOY0pbyu+ZznY7INdRfuknnEpF1AhGcyCXcn7qJwm0F3rZLdMmZXmORqcsKMS6gNyQv7
         6KUM7/b8AczQ7Su3cvdn3aKH/bpiHXFRLBkD2aNehaHGSGNAaKBraayIpHuhPjlD8uLL
         y1XSenvznpbPxKOq/iQwRobu5wxpKjEoSbY3LAye0iNQKkkjwbkOlL5Lpbm23A81q13N
         WlZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZqJp5QwTHeIfd54hVsbdTrPly7o1sW/Jce3j5kYMOAQ=;
        b=gM4toCWBLlOAf4Sj6o1UujwioT5EO7W48i4VS2444RZCMvg4SBVZU9LAbKDuJNooVf
         ig58j2k0fsSKsX+ZkxAD012VgoouQ3czyD0YU9pKGJOqgxRI6QyTR73Uwo4qrgaPwpQh
         99dBj3RI7HeyjTeFj0rft3VGfCaYZ0WSLne/A5Qze3Fn+25iY22TYpikjOVT5DZHjNbx
         u8F8UanreR2zDRrvul3GwUcAb4TpjdqjWeFTuZaob7gi/glijA4tCqANKilOTtCuSQZ+
         L/40K0BMbU17hPggxmJFY4xjmvs7STAxEWz2UB4O+jz742SsjFUmzDLOqqa2p2vvIcTv
         ImTA==
X-Gm-Message-State: APjAAAUYl2gHuvZXbZE6y7p9jN1IrbArgnsudwp27FOlahfvtgxyi4nt
        LQbxqLA7sHXmuSxvXEKLrkajUbSuIWk2DA==
X-Google-Smtp-Source: APXvYqwrN6yz7u6PoJUCsOJmve7u4PBqA9Op4RDhXDI0ZB+SjuDBau7ej2Vq1zHMxykDxvPlnRHG4w==
X-Received: by 2002:a1c:4c02:: with SMTP id z2mr5331863wmf.78.1571826196348;
        Wed, 23 Oct 2019 03:23:16 -0700 (PDT)
Received: from [173.194.76.108] ([149.199.62.130])
        by smtp.gmail.com with ESMTPSA id 126sm23678206wma.48.2019.10.23.03.23.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 03:23:15 -0700 (PDT)
Subject: Re: [PATCH] arch: microblaze: support for reserved-memory entries in
 DT
To:     Alvaro Gamez Machado <alvaro.gamez@hazent.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20191022081929.10602-1-alvaro.gamez@hazent.com>
 <64db9f22-2e24-23f8-bf64-c4a972fa50c1@monstr.eu>
 <20191023081728.GA17517@salem.gmr.ssr.upm.es>
From:   Michal Simek <monstr@monstr.eu>
Message-ID: <741d5f8b-439f-5d03-b279-d8844da55e4a@monstr.eu>
Date:   Wed, 23 Oct 2019 12:23:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191023081728.GA17517@salem.gmr.ssr.upm.es>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 10. 19 10:17, Alvaro Gamez Machado wrote:
> Hi Michal
> 
> On Wed, Oct 23, 2019 at 09:59:40AM +0200, Michal Simek wrote:
>> Hi,
>>
>>
>> On 22. 10. 19 10:19, Alvaro Gamez Machado wrote:
>>> Signed-off-by: Alvaro Gamez Machado <alvaro.gamez@hazent.com>
>>
>> please put there reasonable description to commit message.
> 
> Ok, will use those below as template.
>  
>>> ---
>>>  arch/microblaze/mm/init.c | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
>>> index a015a951c8b7..928c5c2816e4 100644
>>> --- a/arch/microblaze/mm/init.c
>>> +++ b/arch/microblaze/mm/init.c
>>> @@ -17,6 +17,8 @@
>>>  #include <linux/slab.h>
>>>  #include <linux/swap.h>
>>>  #include <linux/export.h>
>>> +#include <linux/of_fdt.h>
>>> +#include <linux/of.h>
>>
>> of_fdt.h should be enough.
> 
> Ok
> 
>>>  
>>>  #include <asm/page.h>
>>>  #include <asm/mmu_context.h>
>>> @@ -188,6 +190,9 @@ void __init setup_memory(void)
>>>  
>>>  void __init mem_init(void)
>>>  {
>>> +	early_init_fdt_reserve_self();
>>> +	early_init_fdt_scan_reserved_mem();
>>> +
>>>  	high_memory = (void *)__va(memory_start + lowmem_size - 1);
>>>  
>>>  	/* this will put all memory onto the freelists */
>>>
>>
>>
>> Also I have looked at others arch and take a look at
>>
>> 1b10cb21d888c021bedbe678f7c26aee1bf04ffa
>> ARC: add support for reserved memory defined by device tree
>>
>> where they also enable OF_RESERVED_MEM to call fdt_init_reserve_mem()
>>
>> The same here
>> 4e7c84ec045921dacc78d36295e2e61390249665
>>  xtensa: support reserved-memory DT node
>>
>> and here
>> 9bf14b7c540ae9ca7747af3a0c0d8470ef77b6ce
>> arm64: add support for reserved memory defined by device tree
>>
> 
> They did that at the time, but it seems it's not needed anymore:
> 
> 34e04eedd1cf1be714abb0e5976338cc72ccc05f
>   of: select OF_RESERVED_MEM automatically
> 
> This commit removed those select OF_RESERVED_MEM lines. Is it needed
> specifically for microblaze? I didn't need to do that in order for
> reserved-memory entries to work on my platform.

Ok. Even better. It is not needed if it is built already.

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

