Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04C7C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 11:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF5722CF5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 11:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kPwXiUXJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfH1L2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 07:28:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33576 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfH1L2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 07:28:11 -0400
Received: by mail-wm1-f68.google.com with SMTP id r17so1534359wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 04:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=HBe9uhXsvc42/D9IbsN1QjJ/vNtE9JFruELezUW/IVE=;
        b=kPwXiUXJEkwfVmv68JI5YMEOIgHCa9fmH+SN1kL8U5dpuHprEAYDwDGSVYsXK0WDJL
         7LSFT1u19tj+Uy/6L2r6rvGxJ6PmUd+/RpUi3UZDaos4I7s7uqf2dV8H95uVVo8dxklB
         AP2Z+fRoEgC+3svvTqUQ/YpsXhnN2GrtN6HcOIA9w0Okmyw9GHM+pZjdhCPm4WGWeT5y
         cttGD+luQLibwh2khYMijEVbho4qWih+bDJM7ycO38BbXEBpbUXRgXxEv//zELSHco9Q
         q+xCx6bKl697AlRBMozv8SQXkQqqjbXqZU4l362DVsGp5kthwVXqnveuJwDXwmsxw/WE
         61JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=HBe9uhXsvc42/D9IbsN1QjJ/vNtE9JFruELezUW/IVE=;
        b=nlwhJdUTdUGIcHDY5ljQPosJB2UppPZMUKbXhNHXKgjjFAY5HzZA8si/0XH+tseFqO
         UflKo24/4NvVu/jbHgUYaCBTvU+To3WzVNtHW1poeh6XIIuNvVkSV0YEW8CpqK5UAFDS
         p7UfYbZaef64VR5vHli7ZoqLEJTbdmnpNVAn7K5Tv/TcZqIKFiWa3wTRV9LOmkf3N9kU
         uu+omwVoD1hXp0J5/8WIfFkh395s6h0m1RF3orafVWhBnU2uWar2WB8eXUyQoMVUcnAk
         TJrcqenysmLqV+ywN9viXk0JEBC59HgT8bJFvqk+LqGM7f6ZLGJ/1/EpPHL3T2RpM7sG
         u1CA==
X-Gm-Message-State: APjAAAVfJ8nmh7CrojjkEwW2lXZMlATw7Ho7ijoUIbD/0ApTof/ZjIWq
        WAgIyOur01ZRvNsjTfB/B5FhPQ==
X-Google-Smtp-Source: APXvYqy+yYg4LvcInHrUQUoZ3zEtYh/4aIWJ9YMJHeUth1FYpOMaPofGk8nU5kXu2ZaTmt4vUL+tvA==
X-Received: by 2002:a05:600c:296:: with SMTP id 22mr4013088wmk.148.1566991686860;
        Wed, 28 Aug 2019 04:28:06 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a26sm2751226wmg.45.2019.08.28.04.28.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 04:28:05 -0700 (PDT)
Subject: Re: [PATCH v6 0/6] Allwinner H6 Mali GPU support
To:     Robin Murphy <robin.murphy@arm.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, David Airlie <airlied@linux.ie>,
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
 <dc3872a4-8cd9-462b-9f73-0d69a810d985@arm.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <92e9b697-ea0d-9b13-5512-b0a16a39df20@baylibre.com>
Date:   Wed, 28 Aug 2019 13:28:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <dc3872a4-8cd9-462b-9f73-0d69a810d985@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robyn,

On 31/05/2019 15:47, Robin Murphy wrote:
> On 31/05/2019 13:04, Tomeu Vizoso wrote:
>> On Wed, 29 May 2019 at 19:38, Robin Murphy <robin.murphy@arm.com> wrote:
>>>
>>> On 29/05/2019 16:09, Tomeu Vizoso wrote:
>>>> On Tue, 21 May 2019 at 18:11, Clément Péron <peron.clem@gmail.com> wrote:
>>>>>
>>>> [snip]
>>>>> [  345.204813] panfrost 1800000.gpu: mmu irq status=1
>>>>> [  345.209617] panfrost 1800000.gpu: Unhandled Page fault in AS0 at VA
>>>>> 0x0000000002400400
>>>>
>>>>   From what I can see here, 0x0000000002400400 points to the first byte
>>>> of the first submitted job descriptor.
>>>>
>>>> So mapping buffers for the GPU doesn't seem to be working at all on
>>>> 64-bit T-760.
>>>>
>>>> Steven, Robin, do you have any idea of why this could be?
>>>
>>> I tried rolling back to the old panfrost/nondrm shim, and it works fine
>>> with kbase, and I also found that T-820 falls over in the exact same
>>> manner, so the fact that it seemed to be common to the smaller 33-bit
>>> designs rather than anything to do with the other
>>> job_descriptor_size/v4/v5 complication turned out to be telling.
>>
>> Is this complication something you can explain? I don't know what v4
>> and v5 are meant here.
> 
> I was alluding to BASE_HW_FEATURE_V4, which I believe refers to the Midgard architecture version - the older versions implemented by T6xx and T720 seem to be collectively treated as "v4", while T760 and T8xx would effectively be "v5".
> 
>>> [ as an aside, are 64-bit jobs actually known not to work on v4 GPUs, or
>>> is it just that nobody's yet observed a 64-bit blob driving one? ]
>>
>> I'm looking right now at getting Panfrost working on T720 with 64-bit
>> descriptors, with the ultimate goal of making Panfrost
>> 64-bit-descriptor only so we can have a single build of Mesa in
>> distros.
> 
> Cool, I'll keep an eye out, and hope that it might be enough for T620 on Juno, too :)
> 
>>> Long story short, it appears that 'Mali LPAE' is also lacking the start
>>> level notion of VMSA, and expects a full 4-level table even for <40 bits
>>> when level 0 effectively redundant. Thus walking the 3-level table that
>>> io-pgtable comes back with ends up going wildly wrong. The hack below
>>> seems to do the job for me; if Clément can confirm (on T-720 you'll
>>> still need the userspace hack to force 32-bit jobs as well) then I think
>>> I'll cook up a proper refactoring of the allocator to put things right.
>>
>> Mmaps seem to work with this patch, thanks.
>>
>> The main complication I'm facing right now seems to be that the SFBD
>> descriptor on T720 seems to be different from the one we already had
>> (tested on T6xx?).
> 
> OK - with the 32-bit hack pointed to up-thread, a quick kmscube test gave me the impression that T720 works fine, but on closer inspection some parts of glmark2 do seem to go a bit wonky (although I suspect at least some of it is just down to the FPGA setup being both very slow and lacking in memory bandwidth), and the "nv12-1img" mode of kmscube turns out to render in some delightfully wrong colours.
> 
> I'll try to get a 'proper' version of the io-pgtable patch posted soon.

I'm trying to collect all the fixes needed to make T820 work again, and
I was wondering if you finally have a proper patch for this and "cfg->ias > 48"
hack ? Or one I can test ?

Thanks,
Neil

> 
> Thanks,
> Robin.
> 
>>
>> Cheers,
>>
>> Tomeu
>>
>>> Robin.
>>>
>>>
>>> ----->8-----
>>> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
>>> index 546968d8a349..f29da6e8dc08 100644
>>> --- a/drivers/iommu/io-pgtable-arm.c
>>> +++ b/drivers/iommu/io-pgtable-arm.c
>>> @@ -1023,12 +1023,14 @@ arm_mali_lpae_alloc_pgtable(struct
>>> io_pgtable_cfg *cfg, void *cookie)
>>>          iop = arm_64_lpae_alloc_pgtable_s1(cfg, cookie);
>>>          if (iop) {
>>>                  u64 mair, ttbr;
>>> +               struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(&iop->ops);
>>>
>>> +               data->levels = 4;
>>>                  /* Copy values as union fields overlap */
>>>                  mair = cfg->arm_lpae_s1_cfg.mair[0];
>>>                  ttbr = cfg->arm_lpae_s1_cfg.ttbr[0];
>>>
>>> _______________________________________________
>>> dri-devel mailing list
>>> dri-devel@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel

