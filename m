Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F534CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C47205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyUtAmgk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436625AbfJXQJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 12:09:50 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40258 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405863AbfJXQJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:09:49 -0400
Received: by mail-lf1-f68.google.com with SMTP id i15so12166419lfo.7;
        Thu, 24 Oct 2019 09:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ILSPEu3zasWelHFleg/P/DFzyM2p7kDhqlV45EgnhRM=;
        b=JyUtAmgkbxY2iZOdUWoZuBeWEaC3Z27bi0Mwcmfe+s3Gzmvt7ii9nMNxtdDbWa1CMh
         TM2WjF0yX6EykQqsG+SDnSsA9/vZIe7loDAmZ++fHSCgGS3h6R34mRlPdgp9f667fa3b
         aKdNHDs3MI2zcwjGtGjiaxgJkjhHqaAGOISH3vVT7zydqOoIxgZDZIg6ZuSxGU3xloHD
         gAFzFWfxJzv0MG3LaeOM6Iuj8+vWpBUg+78VBuyx3iw030thNMJjyAL4YpC0QH8jr3jI
         QAq/l8REfjSgazG9ajCz46lp9FRqRV9T/eAX6Zah7GXOdzGXeQJ4jY1knW5YOglgt3Mr
         jhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ILSPEu3zasWelHFleg/P/DFzyM2p7kDhqlV45EgnhRM=;
        b=m04rK2p/K+ozVCt0ItFn8rYFzD7T4AAvO0igKYwPx5rBoREqvdCAtoEo848oVSHgdF
         K5dQbji4GauMMNbKbqVxGUdm4IJRav3CFr5U6xadLz88jE8XdCFDT6unbXOMa2j0jzvW
         lE2PA2kTjF58KcPIFNV27OxNiY+PsxXJbGRKsh62gEbMq4VHpMUpax/IbHda0xsSMJEP
         roaNwOu9scLUDhGGKuxb0C6tFIIB21hm0Axx/I9Lu4ALcwoprBAfDG8BvjcQpsbc4ZUp
         Rcg0VcTmlEQxm+db3xk4X02UJNAI+WBzagAlJciRVBCxoAgpltLipQddnIF82cCwWyOZ
         hMrQ==
X-Gm-Message-State: APjAAAWpa8gtyip3rlIM4KYEoOWIHbZvNS30l225Y3R/hT5p7kr63ADo
        nGMDtr5W640EOiy832zK0OPMyenp
X-Google-Smtp-Source: APXvYqyz+TYuMgOO/xQiByr2Y3n/shb2DQKh8jTahTRyY0nRqpkYXnyA+vWeDlk5PE9YoFwMATu9RA==
X-Received: by 2002:a05:6512:25c:: with SMTP id b28mr28049097lfo.35.1571933386522;
        Thu, 24 Oct 2019 09:09:46 -0700 (PDT)
Received: from [192.168.2.145] (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id h21sm4153059ljl.20.2019.10.24.09.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2019 09:09:46 -0700 (PDT)
Subject: Re: [PATCH v1 2/3] drm/tegra: Fix 2d and 3d clients detaching from
 IOMMU domain
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190623173743.24088-1-digetx@gmail.com>
 <20190623173743.24088-2-digetx@gmail.com> <20191024115804.GB2924027@ulmo>
 <45926d95-3e7a-c56b-402a-2b2c6475c5db@gmail.com>
 <20191024135018.GD2924027@ulmo>
 <38a67df0-2ede-e7fe-8eca-6c4491cdcc7b@gmail.com>
 <20191024155620.GG2924027@ulmo>
 <bfc6c17d-f2df-32d0-67d6-2f763c81d7fc@gmail.com>
Message-ID: <7f7ecf90-531c-69ae-9011-684666ed8743@gmail.com>
Date:   Thu, 24 Oct 2019 19:09:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <bfc6c17d-f2df-32d0-67d6-2f763c81d7fc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

24.10.2019 18:57, Dmitry Osipenko пишет:
> 24.10.2019 18:56, Thierry Reding пишет:
>> On Thu, Oct 24, 2019 at 06:47:23PM +0300, Dmitry Osipenko wrote:
>>> 24.10.2019 16:50, Thierry Reding пишет:
>>>> On Thu, Oct 24, 2019 at 04:28:41PM +0300, Dmitry Osipenko wrote:
>>>>> 24.10.2019 14:58, Thierry Reding пишет:
>>>>>> On Sun, Jun 23, 2019 at 08:37:42PM +0300, Dmitry Osipenko wrote:
>>>>>>> This should should fire up on the DRM's driver module re-loader because
>>>>>>> there won't be enough available domains on older Tegra SoCs.
>>>>>>>
>>>>>>> Cc: stable <stable@vger.kernel.org>
>>>>>>> Fixes: 0c407de5ed1a ("drm/tegra: Refactor IOMMU attach/detach")
>>>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>>>> ---
>>>>>>>  drivers/gpu/drm/tegra/dc.c   | 4 ++--
>>>>>>>  drivers/gpu/drm/tegra/drm.c  | 9 ++++++---
>>>>>>>  drivers/gpu/drm/tegra/drm.h  | 3 ++-
>>>>>>>  drivers/gpu/drm/tegra/gr2d.c | 4 ++--
>>>>>>>  drivers/gpu/drm/tegra/gr3d.c | 4 ++--
>>>>>>>  5 files changed, 14 insertions(+), 10 deletions(-)
>>>>>>
>>>>>> I think I understand what this is trying to do, but the commit message
>>>>>> does not help at all. So what's really going on here is that we need to
>>>>>> detach the device from the group regardless of whether we're sharing the
>>>>>> group or not, just like we attach groups to the shared domain whether
>>>>>> they share the same group or not.
>>>>>
>>>>> Yes, the commit's message could be improved.
>>>>>
>>>>>> But in that case, I wonder if it's even worth splitting groups the way
>>>>>> we are right now. Wouldn't it be better to just put all the devices into
>>>>>> the same group and be done with it?
>>>>>>
>>>>>> The current code gives me headaches every time I read it, so if we can
>>>>>> just make it so that all the devices under the DRM device share the same
>>>>>> group, this would become a lot easier to deal with. I'm not really
>>>>>> convinced that it makes much sense to keep them on separate domains,
>>>>>> especially given the constraints on the number of domains available on
>>>>>> earlier Tegra devices.
>>>>>>
>>>>>> Note that sharing a group will also make it much easier for these to use
>>>>>> the DMA API if it is backed by an IOMMU.
>>>>>
>>>>> Probably I'm blanking on everything about IOMMU now.. could you please
>>>>> remind me what "IOMMU group" is?
>>>>>
>>>>> Isn't it that each IOMMU group relates to the HW ID (SWGROUP)? But then
>>>>> each display controller has its own SWGROUP.. and thus that sharing just
>>>>> doesn't make any sense, hm.
>>>>
>>>> IOMMU groups are not directly related to SWGROUPs. But by default the
>>>> IOMMU framework will share a domain between members of the same IOMMU
>>>> group.
>>>
>>> Ah, I re-figured out that again. The memory controller drivers are
>>> defining a single "IOMMU group" for both of the display controllers.
>>>
>>>> Seems like that's really what we want here, so that when we do
>>>> use the DMA API, all the devices part of the DRM device get attached to
>>>> the same IOMMU domain, yet if we don't want to use the DMA API we only
>>>> need to detach the one group from the backing.
>>>
>>> Yes, it should be okay to put all DRM devices into the same group, like
>>> it is done now for the displays. It also should resolve problem with the
>>> domains shortage on T30 since now there are maximum 3 domains in use:
>>> host1x, drm and vde.
>>>
>>> I actually just checked that the original problem still exists
>>> and this change solves it as well:
>>>
>>> ---
>>> diff --git a/drivers/memory/tegra/tegra30.c b/drivers/memory/tegra/tegra30.c
>>> index 5a0f6e0a1643..e71096498436 100644
>>> --- a/drivers/memory/tegra/tegra30.c
>>> +++ b/drivers/memory/tegra/tegra30.c
>>> @@ -1021,6 +1021,9 @@ static const struct tegra_smmu_swgroup
>>> tegra30_swgroups[] = {
>>>  static const unsigned int tegra30_group_display[] = {
>>>  	TEGRA_SWGROUP_DC,
>>>  	TEGRA_SWGROUP_DCB,
>>> +	TEGRA_SWGROUP_G2,
>>> +	TEGRA_SWGROUP_NV,
>>> +	TEGRA_SWGROUP_NV2,
>>>  };
>>>
>>>  static const struct tegra_smmu_group_soc tegra30_groups[] = {
>>> ---
>>>
>>> Please let me know whether you're going to make a patch or if I should
>>> do it.
>>
>> I've been testing with a similar change and couldn't find any
>> regressions. I've also made the same modifications for Tegra114 and
>> Tegra124.
>>
>> Are you saying that none of these patches are needed anymore? Or do we
>> still need a patch to fix detaching? I'm thinking that maybe we can
>> drastrically simplify the detachment now by dropping the shared
>> parameter altogether.
>>
>> Let me draft a patch and send out the whole set for testing.
> 
> Seems it's still not ideal because I noticed this in KMSG:
> 
> [    0.703185] Failed to attached device 54200000.dc to IOMMU_mapping
> [    0.710404] Failed to attached device 54240000.dc to IOMMU_mapping
> [    0.719347] Failed to attached device 54140000.gr2d to IOMMU_mapping
> [    0.719569] Failed to attached device 54180000.gr3d to IOMMU_mapping
> 
> which comes from the implicit IOMMU backing.

And the error comes from here:

https://elixir.bootlin.com/linux/v5.4-rc2/source/drivers/iommu/iommu.c#L1655

