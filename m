Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DAACA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D5482166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ez00wIRE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393923AbfJXQbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 12:31:24 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37891 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391179AbfJXQbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:31:23 -0400
Received: by mail-lf1-f68.google.com with SMTP id q28so16416885lfa.5;
        Thu, 24 Oct 2019 09:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=na+oXNXNyUDNjWdJTcuVx69ApJOXtahZ0nvI2lP1fwc=;
        b=Ez00wIREtTHgs9Iwnh3PyJ4tWnCNBIGJaey8DnYe3chYJdmtRD8sMhi47PUby1lDUf
         4qPYLDm7SK+WL6jCuipkPqWP+760v3tSwnYoN65eZ8k838mmAzNenhwDZoCfm/Ke5/D2
         kDILsOhm3RWYexG5P2pH7AAmQY98gvGArDBHX+fHKPc/jSl98QH8jmNuiDl/uznNIBxg
         2v84Nfuj0UIJDK9e54zu+E5ocFBo+cEmMbXcsyj1hRfqae8CP+tG65mVSyeh9Z5B3c51
         bbTUG4FNiWYZ/35G7JSSrgDd+hKC7merwfVeOFsvw43Ssh7FC8TS/+kKKkcoJgelugb+
         a89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=na+oXNXNyUDNjWdJTcuVx69ApJOXtahZ0nvI2lP1fwc=;
        b=Gn/L0lfbBk+VoNyP0tLJcZG549R3eQKRKVqd4LI2KGH4xkMNif8qrhFI51zr6LWGI5
         /7qj47zwgdmCrBA724AqDrBnHH6PIOZ1RlY2fviXgfit2MrrCiOG3HpyRuyHajrY7IWi
         JvLFaG06dLiqq3xg2wWGcgOH/qXDK6RVHazEjlFg4JgAE/yzuIxrcxzrYraKn2ZXbIAM
         h3vV+GGJk9snkzXJBbLgFqSGfE07+ZCP2qh7q9D4YUBpcDh8ZBUmoUKShVxiF8kwejmA
         lak9AZDENh+na4ICYNHB49KLvWn5BVw76/AxMSJNpSlR88Lnbui9No7ZeADLIKyv4D7l
         GC8Q==
X-Gm-Message-State: APjAAAUS5P80j2ZXX+fj2asI1DzJRxFarenu8yKRAjcPKqIfx3Xw299c
        RDMJH3PijblDOS3w2rvG66hWBHoy
X-Google-Smtp-Source: APXvYqyDcsQqXLdNCUkKqDZBMjytxYXG/ewmWKyeitUd1x3wYEH391e0zGP7Yz354lfShGKbtmD41Q==
X-Received: by 2002:a19:f707:: with SMTP id z7mr16558599lfe.0.1571934680637;
        Thu, 24 Oct 2019 09:31:20 -0700 (PDT)
Received: from [192.168.2.145] (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id 10sm7066153lfy.57.2019.10.24.09.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2019 09:31:20 -0700 (PDT)
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
 <7f7ecf90-531c-69ae-9011-684666ed8743@gmail.com>
 <ef2ccc90-be93-3cfb-6b8b-2a406dd8d362@gmail.com>
Message-ID: <026bbeb0-1539-2b62-a447-60c1bc041f5a@gmail.com>
Date:   Thu, 24 Oct 2019 19:31:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <ef2ccc90-be93-3cfb-6b8b-2a406dd8d362@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

24.10.2019 19:21, Dmitry Osipenko пишет:
> 24.10.2019 19:09, Dmitry Osipenko пишет:
>> 24.10.2019 18:57, Dmitry Osipenko пишет:
>>> 24.10.2019 18:56, Thierry Reding пишет:
>>>> On Thu, Oct 24, 2019 at 06:47:23PM +0300, Dmitry Osipenko wrote:
>>>>> 24.10.2019 16:50, Thierry Reding пишет:
>>>>>> On Thu, Oct 24, 2019 at 04:28:41PM +0300, Dmitry Osipenko wrote:
>>>>>>> 24.10.2019 14:58, Thierry Reding пишет:
>>>>>>>> On Sun, Jun 23, 2019 at 08:37:42PM +0300, Dmitry Osipenko wrote:
>>>>>>>>> This should should fire up on the DRM's driver module re-loader because
>>>>>>>>> there won't be enough available domains on older Tegra SoCs.
>>>>>>>>>
>>>>>>>>> Cc: stable <stable@vger.kernel.org>
>>>>>>>>> Fixes: 0c407de5ed1a ("drm/tegra: Refactor IOMMU attach/detach")
>>>>>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>>>>>> ---
>>>>>>>>>  drivers/gpu/drm/tegra/dc.c   | 4 ++--
>>>>>>>>>  drivers/gpu/drm/tegra/drm.c  | 9 ++++++---
>>>>>>>>>  drivers/gpu/drm/tegra/drm.h  | 3 ++-
>>>>>>>>>  drivers/gpu/drm/tegra/gr2d.c | 4 ++--
>>>>>>>>>  drivers/gpu/drm/tegra/gr3d.c | 4 ++--
>>>>>>>>>  5 files changed, 14 insertions(+), 10 deletions(-)
>>>>>>>>
>>>>>>>> I think I understand what this is trying to do, but the commit message
>>>>>>>> does not help at all. So what's really going on here is that we need to
>>>>>>>> detach the device from the group regardless of whether we're sharing the
>>>>>>>> group or not, just like we attach groups to the shared domain whether
>>>>>>>> they share the same group or not.
>>>>>>>
>>>>>>> Yes, the commit's message could be improved.
>>>>>>>
>>>>>>>> But in that case, I wonder if it's even worth splitting groups the way
>>>>>>>> we are right now. Wouldn't it be better to just put all the devices into
>>>>>>>> the same group and be done with it?
>>>>>>>>
>>>>>>>> The current code gives me headaches every time I read it, so if we can
>>>>>>>> just make it so that all the devices under the DRM device share the same
>>>>>>>> group, this would become a lot easier to deal with. I'm not really
>>>>>>>> convinced that it makes much sense to keep them on separate domains,
>>>>>>>> especially given the constraints on the number of domains available on
>>>>>>>> earlier Tegra devices.
>>>>>>>>
>>>>>>>> Note that sharing a group will also make it much easier for these to use
>>>>>>>> the DMA API if it is backed by an IOMMU.
>>>>>>>
>>>>>>> Probably I'm blanking on everything about IOMMU now.. could you please
>>>>>>> remind me what "IOMMU group" is?
>>>>>>>
>>>>>>> Isn't it that each IOMMU group relates to the HW ID (SWGROUP)? But then
>>>>>>> each display controller has its own SWGROUP.. and thus that sharing just
>>>>>>> doesn't make any sense, hm.
>>>>>>
>>>>>> IOMMU groups are not directly related to SWGROUPs. But by default the
>>>>>> IOMMU framework will share a domain between members of the same IOMMU
>>>>>> group.
>>>>>
>>>>> Ah, I re-figured out that again. The memory controller drivers are
>>>>> defining a single "IOMMU group" for both of the display controllers.
>>>>>
>>>>>> Seems like that's really what we want here, so that when we do
>>>>>> use the DMA API, all the devices part of the DRM device get attached to
>>>>>> the same IOMMU domain, yet if we don't want to use the DMA API we only
>>>>>> need to detach the one group from the backing.
>>>>>
>>>>> Yes, it should be okay to put all DRM devices into the same group, like
>>>>> it is done now for the displays. It also should resolve problem with the
>>>>> domains shortage on T30 since now there are maximum 3 domains in use:
>>>>> host1x, drm and vde.
>>>>>
>>>>> I actually just checked that the original problem still exists
>>>>> and this change solves it as well:
>>>>>
>>>>> ---
>>>>> diff --git a/drivers/memory/tegra/tegra30.c b/drivers/memory/tegra/tegra30.c
>>>>> index 5a0f6e0a1643..e71096498436 100644
>>>>> --- a/drivers/memory/tegra/tegra30.c
>>>>> +++ b/drivers/memory/tegra/tegra30.c
>>>>> @@ -1021,6 +1021,9 @@ static const struct tegra_smmu_swgroup
>>>>> tegra30_swgroups[] = {
>>>>>  static const unsigned int tegra30_group_display[] = {
>>>>>  	TEGRA_SWGROUP_DC,
>>>>>  	TEGRA_SWGROUP_DCB,
>>>>> +	TEGRA_SWGROUP_G2,
>>>>> +	TEGRA_SWGROUP_NV,
>>>>> +	TEGRA_SWGROUP_NV2,
>>>>>  };
>>>>>
>>>>>  static const struct tegra_smmu_group_soc tegra30_groups[] = {
>>>>> ---
>>>>>
>>>>> Please let me know whether you're going to make a patch or if I should
>>>>> do it.
>>>>
>>>> I've been testing with a similar change and couldn't find any
>>>> regressions. I've also made the same modifications for Tegra114 and
>>>> Tegra124.
>>>>
>>>> Are you saying that none of these patches are needed anymore? Or do we
>>>> still need a patch to fix detaching? I'm thinking that maybe we can
>>>> drastrically simplify the detachment now by dropping the shared
>>>> parameter altogether.
>>>>
>>>> Let me draft a patch and send out the whole set for testing.
>>>
>>> Seems it's still not ideal because I noticed this in KMSG:
>>>
>>> [    0.703185] Failed to attached device 54200000.dc to IOMMU_mapping
>>> [    0.710404] Failed to attached device 54240000.dc to IOMMU_mapping
>>> [    0.719347] Failed to attached device 54140000.gr2d to IOMMU_mapping
>>> [    0.719569] Failed to attached device 54180000.gr3d to IOMMU_mapping
>>>
>>> which comes from the implicit IOMMU backing.
>>
>> And the error comes from here:
>>
>> https://elixir.bootlin.com/linux/v5.4-rc2/source/drivers/iommu/iommu.c#L1655
> 
> So the detaching still should be needed, but at the moment the ARM32
> DMA-mapping code is simply not suitable for the case of having multiple
> devices in the same group. I'm wondering whether there are any real
> users for the implicit IOMMU backing on ARM32 at all :/
> 

Apparently the "Failed to attached device 54200000.dc" was always in the
log (I rarely testing the default multi-platform config), it's just the
message is a pr_warn that I wasn't paying attention because it is
colored like pr_info in dmesg :)
