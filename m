Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDF6C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A714206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731660AbfHAQH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 12:07:59 -0400
Received: from foss.arm.com ([217.140.110.172]:38504 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727403AbfHAQH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 12:07:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEF84337;
        Thu,  1 Aug 2019 09:07:58 -0700 (PDT)
Received: from [10.32.8.205] (unknown [10.32.8.205])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B6A23F694;
        Thu,  1 Aug 2019 09:07:55 -0700 (PDT)
Subject: Re: [PATCH 5/8] arm64: use ZONE_DMA on DMA addressing limited devices
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     phill@raspberryi.org, devicetree@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, f.fainelli@gmail.com,
        frowand.list@gmail.com, eric@anholt.net, marc.zyngier@arm.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        robh+dt@kernel.org, wahrenst@gmx.net, mbrugger@suse.com,
        akpm@linux-foundation.org, hch@lst.de,
        linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
References: <20190731154752.16557-1-nsaenzjulienne@suse.de>
 <20190731154752.16557-6-nsaenzjulienne@suse.de>
 <20190731170742.GC17773@arrakis.emea.arm.com>
 <d8b4a7cb9c06824ca88a0602a5bf38b6324b43c0.camel@suse.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <e35dd4a5-281b-d281-59c9-3fc7108eb8be@arm.com>
Date:   Thu, 1 Aug 2019 17:07:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <d8b4a7cb9c06824ca88a0602a5bf38b6324b43c0.camel@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-01 4:44 pm, Nicolas Saenz Julienne wrote:
> On Wed, 2019-07-31 at 18:07 +0100, Catalin Marinas wrote:
>> On Wed, Jul 31, 2019 at 05:47:48PM +0200, Nicolas Saenz Julienne wrote:
>>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>>> index 1c4ffabbe1cb..f5279ef85756 100644
>>> --- a/arch/arm64/mm/init.c
>>> +++ b/arch/arm64/mm/init.c
>>> @@ -50,6 +50,13 @@
>>>   s64 memstart_addr __ro_after_init = -1;
>>>   EXPORT_SYMBOL(memstart_addr);
>>>   
>>> +/*
>>> + * We might create both a ZONE_DMA and ZONE_DMA32. ZONE_DMA is needed if
>>> there
>>> + * are periferals unable to address the first naturally aligned 4GB of ram.
>>> + * ZONE_DMA32 will be expanded to cover the rest of that memory. If such
>>> + * limitations doesn't exist only ZONE_DMA32 is created.
>>> + */
>>
>> Shouldn't we instead only create ZONE_DMA to cover the whole 32-bit
>> range and leave ZONE_DMA32 empty? Can__GFP_DMA allocations fall back
>> onto ZONE_DMA32?
> 
> Hi Catalin, thanks for the review.
> 
> You're right, the GFP_DMA page allocation will fail with a nasty dmesg error if
> ZONE_DMA is configured but empty. Unsurprisingly the opposite situation is fine
> (GFP_DMA32 with an empty ZONE_DMA32).

Was that tested on something other than RPi4 with more than 4GB of RAM? 
(i.e. with a non-empty ZONE_NORMAL either way)

Robin.

> I switched to the scheme you're suggesting for the next version of the series.
> The comment will be something the likes of this:
> 
> /*
>   * We create both a ZONE_DMA and ZONE_DMA32. ZONE_DMA's size is decided based
>   * on whether the SoC's peripherals are able to address the first naturally
>   * aligned 4 GB of ram.
>   *
>   * If limited, ZONE_DMA covers that area and ZONE_DMA32 the rest of that 32 bit
>   * addressable memory.
>   *
>   * If not ZONE_DMA is expanded to cover the whole 32 bit addressable memory and
>   * ZONE_DMA32 is left empty.
>   */
> 
>   Regards,
>   Nicolas
> 
> 
