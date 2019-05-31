Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC9AC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 13:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA4424AF0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 13:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfEaNr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 09:47:29 -0400
Received: from foss.arm.com ([217.140.101.70]:51842 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbfEaNr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 09:47:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73245A78;
        Fri, 31 May 2019 06:47:28 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 111CC3F5AF;
        Fri, 31 May 2019 06:47:25 -0700 (PDT)
Subject: Re: [PATCH v6 0/6] Allwinner H6 Mali GPU support
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Will Deacon <will.deacon@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Steven Price <steven.price@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190521161102.29620-1-peron.clem@gmail.com>
 <CAAObsKD8bij1ANLqX6y11Y6mDEXiymNjrDkmHmvGWiFLKWu_FA@mail.gmail.com>
 <4ff02295-6c34-791b-49f4-6558a92ad7a3@arm.com>
 <CAAObsKBt1tPw9RKGi_Xey=1zy9Tu3N+A=1te2R8=NuJ5tDBqVg@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <dc3872a4-8cd9-462b-9f73-0d69a810d985@arm.com>
Date:   Fri, 31 May 2019 14:47:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAAObsKBt1tPw9RKGi_Xey=1zy9Tu3N+A=1te2R8=NuJ5tDBqVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2019 13:04, Tomeu Vizoso wrote:
> On Wed, 29 May 2019 at 19:38, Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 29/05/2019 16:09, Tomeu Vizoso wrote:
>>> On Tue, 21 May 2019 at 18:11, Clément Péron <peron.clem@gmail.com> wrote:
>>>>
>>> [snip]
>>>> [  345.204813] panfrost 1800000.gpu: mmu irq status=1
>>>> [  345.209617] panfrost 1800000.gpu: Unhandled Page fault in AS0 at VA
>>>> 0x0000000002400400
>>>
>>>   From what I can see here, 0x0000000002400400 points to the first byte
>>> of the first submitted job descriptor.
>>>
>>> So mapping buffers for the GPU doesn't seem to be working at all on
>>> 64-bit T-760.
>>>
>>> Steven, Robin, do you have any idea of why this could be?
>>
>> I tried rolling back to the old panfrost/nondrm shim, and it works fine
>> with kbase, and I also found that T-820 falls over in the exact same
>> manner, so the fact that it seemed to be common to the smaller 33-bit
>> designs rather than anything to do with the other
>> job_descriptor_size/v4/v5 complication turned out to be telling.
> 
> Is this complication something you can explain? I don't know what v4
> and v5 are meant here.

I was alluding to BASE_HW_FEATURE_V4, which I believe refers to the 
Midgard architecture version - the older versions implemented by T6xx 
and T720 seem to be collectively treated as "v4", while T760 and T8xx 
would effectively be "v5".

>> [ as an aside, are 64-bit jobs actually known not to work on v4 GPUs, or
>> is it just that nobody's yet observed a 64-bit blob driving one? ]
> 
> I'm looking right now at getting Panfrost working on T720 with 64-bit
> descriptors, with the ultimate goal of making Panfrost
> 64-bit-descriptor only so we can have a single build of Mesa in
> distros.

Cool, I'll keep an eye out, and hope that it might be enough for T620 on 
Juno, too :)

>> Long story short, it appears that 'Mali LPAE' is also lacking the start
>> level notion of VMSA, and expects a full 4-level table even for <40 bits
>> when level 0 effectively redundant. Thus walking the 3-level table that
>> io-pgtable comes back with ends up going wildly wrong. The hack below
>> seems to do the job for me; if Clément can confirm (on T-720 you'll
>> still need the userspace hack to force 32-bit jobs as well) then I think
>> I'll cook up a proper refactoring of the allocator to put things right.
> 
> Mmaps seem to work with this patch, thanks.
> 
> The main complication I'm facing right now seems to be that the SFBD
> descriptor on T720 seems to be different from the one we already had
> (tested on T6xx?).

OK - with the 32-bit hack pointed to up-thread, a quick kmscube test 
gave me the impression that T720 works fine, but on closer inspection 
some parts of glmark2 do seem to go a bit wonky (although I suspect at 
least some of it is just down to the FPGA setup being both very slow and 
lacking in memory bandwidth), and the "nv12-1img" mode of kmscube turns 
out to render in some delightfully wrong colours.

I'll try to get a 'proper' version of the io-pgtable patch posted soon.

Thanks,
Robin.

> 
> Cheers,
> 
> Tomeu
> 
>> Robin.
>>
>>
>> ----->8-----
>> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
>> index 546968d8a349..f29da6e8dc08 100644
>> --- a/drivers/iommu/io-pgtable-arm.c
>> +++ b/drivers/iommu/io-pgtable-arm.c
>> @@ -1023,12 +1023,14 @@ arm_mali_lpae_alloc_pgtable(struct
>> io_pgtable_cfg *cfg, void *cookie)
>>          iop = arm_64_lpae_alloc_pgtable_s1(cfg, cookie);
>>          if (iop) {
>>                  u64 mair, ttbr;
>> +               struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(&iop->ops);
>>
>> +               data->levels = 4;
>>                  /* Copy values as union fields overlap */
>>                  mair = cfg->arm_lpae_s1_cfg.mair[0];
>>                  ttbr = cfg->arm_lpae_s1_cfg.ttbr[0];
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
