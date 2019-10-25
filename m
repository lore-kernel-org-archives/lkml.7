Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC172CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A68F421D7B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsufC0hS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440261AbfJYMfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 08:35:45 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34932 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfJYMfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:35:45 -0400
Received: by mail-lf1-f68.google.com with SMTP id y6so1620981lfj.2;
        Fri, 25 Oct 2019 05:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PomJSu88oAM/InsbDfpWT/TME8LiJnEhQOT5up53LUI=;
        b=jsufC0hSNthn278IkO6IsBe71LWLWjv/KndsR+ST8r9virkRBAiY8kPPkIGT4QzWoq
         kAyvqkmw9QZma0SVjTkL1MTgxkDnML+gzppia+DtfE8fo5vQzi/EbdaIJqueFk0dHKJ+
         jR2kQjzPSBqhD3RjwQkibW0/nAhR0lcf1xXm2Jp+aOEta+BHJR3kwJOa2MTm5Lg6q+ng
         m9bUbHyuKeRFq/hbuOoJGXqCk3shzcPMb9O19WV4VgMvlMJ9LgTies2cKvFTEITA1icC
         +rbTtPwm2fl5m9/nfFWVFO6mzZS9dpnqkx7GSQ8KChDoabLEBT2i7fyJSxqB20npNkzT
         uGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PomJSu88oAM/InsbDfpWT/TME8LiJnEhQOT5up53LUI=;
        b=fNL1d7ZNnQ/l39JMXjsE7knDMQx+tjzL1Gd0VdeJPOq+dOtXgF5YPt4CgJD8+qc3tz
         NVGCYMYxQl9RZf9Vfn1Mq1TuZHrYaxV4IRuvCSAcodj9WPD4ir/81GLe4utZB1u4/m6Y
         ahIk2SxVFbUuLYKDWH/3JE07y39lR32zhUW47clme9ZtX0zche1VF/7fCDYUTdcorBfE
         mCokGzAcx4bJcXtfRnJL5dy8avcAFu42t/J8jAC8S39+alncVsnjXfPa6XX9DRHgry1s
         4lycdRWD/bk8s+CFf0pj+9VDHIdzbkjEQNxh1HsCukV9o7X6muImOl5dtZ1NNIcRiYWi
         WoDg==
X-Gm-Message-State: APjAAAW/ukhpdA/2RO48TiXqKKAFNus/stGldqDxKRIwp9sDRX533+fT
        DzmbUIbeq0nGmcOyC8dnA+bVN9cG
X-Google-Smtp-Source: APXvYqxSQZi3jsL9rAPAOj7utfa4wA9WyyfR6KSR+LbseBh1XDIw70+GZSU/N922BrIfi5tFrSRVAA==
X-Received: by 2002:ac2:4c29:: with SMTP id u9mr2590232lfq.90.1572006942006;
        Fri, 25 Oct 2019 05:35:42 -0700 (PDT)
Received: from [192.168.2.145] (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id c21sm850415lfh.33.2019.10.25.05.35.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2019 05:35:39 -0700 (PDT)
Subject: Re: [PATCH v1 2/3] drm/tegra: Fix 2d and 3d clients detaching from
 IOMMU domain
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <45926d95-3e7a-c56b-402a-2b2c6475c5db@gmail.com>
 <20191024135018.GD2924027@ulmo>
 <38a67df0-2ede-e7fe-8eca-6c4491cdcc7b@gmail.com>
 <20191024155620.GG2924027@ulmo>
 <bfc6c17d-f2df-32d0-67d6-2f763c81d7fc@gmail.com>
 <7f7ecf90-531c-69ae-9011-684666ed8743@gmail.com>
 <ef2ccc90-be93-3cfb-6b8b-2a406dd8d362@gmail.com>
 <026bbeb0-1539-2b62-a447-60c1bc041f5a@gmail.com>
 <20191024172813.GA281291@ulmo>
 <a3be52ac-6cb2-81f8-f1f5-1d6440cdbfba@gmail.com>
 <20191025114828.GA937752@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c3c614aa-4b99-e4eb-658e-1a71a17cb574@gmail.com>
Date:   Fri, 25 Oct 2019 15:35:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191025114828.GA937752@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

25.10.2019 14:48, Thierry Reding пишет:
> On Thu, Oct 24, 2019 at 09:46:58PM +0300, Dmitry Osipenko wrote:
>> 24.10.2019 20:28, Thierry Reding пишет:
>>> On Thu, Oct 24, 2019 at 07:31:19PM +0300, Dmitry Osipenko wrote:
>>>> 24.10.2019 19:21, Dmitry Osipenko пишет:
>>>>> 24.10.2019 19:09, Dmitry Osipenko пишет:
>>>>>> 24.10.2019 18:57, Dmitry Osipenko пишет:
>>>>>>> 24.10.2019 18:56, Thierry Reding пишет:
>>>>>>>> On Thu, Oct 24, 2019 at 06:47:23PM +0300, Dmitry Osipenko wrote:
>>>>>>>>> 24.10.2019 16:50, Thierry Reding пишет:
>>>>>>>>>> On Thu, Oct 24, 2019 at 04:28:41PM +0300, Dmitry Osipenko wrote:
>>>>>>>>>>> 24.10.2019 14:58, Thierry Reding пишет:
>>>>>>>>>>>> On Sun, Jun 23, 2019 at 08:37:42PM +0300, Dmitry Osipenko wrote:
>>>>>>>>>>>>> This should should fire up on the DRM's driver module re-loader because
>>>>>>>>>>>>> there won't be enough available domains on older Tegra SoCs.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Cc: stable <stable@vger.kernel.org>
>>>>>>>>>>>>> Fixes: 0c407de5ed1a ("drm/tegra: Refactor IOMMU attach/detach")
>>>>>>>>>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>>>>>>>>>> ---
>>>>>>>>>>>>>  drivers/gpu/drm/tegra/dc.c   | 4 ++--
>>>>>>>>>>>>>  drivers/gpu/drm/tegra/drm.c  | 9 ++++++---
>>>>>>>>>>>>>  drivers/gpu/drm/tegra/drm.h  | 3 ++-
>>>>>>>>>>>>>  drivers/gpu/drm/tegra/gr2d.c | 4 ++--
>>>>>>>>>>>>>  drivers/gpu/drm/tegra/gr3d.c | 4 ++--
>>>>>>>>>>>>>  5 files changed, 14 insertions(+), 10 deletions(-)
>>>>>>>>>>>>
>>>>>>>>>>>> I think I understand what this is trying to do, but the commit message
>>>>>>>>>>>> does not help at all. So what's really going on here is that we need to
>>>>>>>>>>>> detach the device from the group regardless of whether we're sharing the
>>>>>>>>>>>> group or not, just like we attach groups to the shared domain whether
>>>>>>>>>>>> they share the same group or not.
>>>>>>>>>>>
>>>>>>>>>>> Yes, the commit's message could be improved.
>>>>>>>>>>>
>>>>>>>>>>>> But in that case, I wonder if it's even worth splitting groups the way
>>>>>>>>>>>> we are right now. Wouldn't it be better to just put all the devices into
>>>>>>>>>>>> the same group and be done with it?
>>>>>>>>>>>>
>>>>>>>>>>>> The current code gives me headaches every time I read it, so if we can
>>>>>>>>>>>> just make it so that all the devices under the DRM device share the same
>>>>>>>>>>>> group, this would become a lot easier to deal with. I'm not really
>>>>>>>>>>>> convinced that it makes much sense to keep them on separate domains,
>>>>>>>>>>>> especially given the constraints on the number of domains available on
>>>>>>>>>>>> earlier Tegra devices.
>>>>>>>>>>>>
>>>>>>>>>>>> Note that sharing a group will also make it much easier for these to use
>>>>>>>>>>>> the DMA API if it is backed by an IOMMU.
>>>>>>>>>>>
>>>>>>>>>>> Probably I'm blanking on everything about IOMMU now.. could you please
>>>>>>>>>>> remind me what "IOMMU group" is?
>>>>>>>>>>>
>>>>>>>>>>> Isn't it that each IOMMU group relates to the HW ID (SWGROUP)? But then
>>>>>>>>>>> each display controller has its own SWGROUP.. and thus that sharing just
>>>>>>>>>>> doesn't make any sense, hm.
>>>>>>>>>>
>>>>>>>>>> IOMMU groups are not directly related to SWGROUPs. But by default the
>>>>>>>>>> IOMMU framework will share a domain between members of the same IOMMU
>>>>>>>>>> group.
>>>>>>>>>
>>>>>>>>> Ah, I re-figured out that again. The memory controller drivers are
>>>>>>>>> defining a single "IOMMU group" for both of the display controllers.
>>>>>>>>>
>>>>>>>>>> Seems like that's really what we want here, so that when we do
>>>>>>>>>> use the DMA API, all the devices part of the DRM device get attached to
>>>>>>>>>> the same IOMMU domain, yet if we don't want to use the DMA API we only
>>>>>>>>>> need to detach the one group from the backing.
>>>>>>>>>
>>>>>>>>> Yes, it should be okay to put all DRM devices into the same group, like
>>>>>>>>> it is done now for the displays. It also should resolve problem with the
>>>>>>>>> domains shortage on T30 since now there are maximum 3 domains in use:
>>>>>>>>> host1x, drm and vde.
>>>>>>>>>
>>>>>>>>> I actually just checked that the original problem still exists
>>>>>>>>> and this change solves it as well:
>>>>>>>>>
>>>>>>>>> ---
>>>>>>>>> diff --git a/drivers/memory/tegra/tegra30.c b/drivers/memory/tegra/tegra30.c
>>>>>>>>> index 5a0f6e0a1643..e71096498436 100644
>>>>>>>>> --- a/drivers/memory/tegra/tegra30.c
>>>>>>>>> +++ b/drivers/memory/tegra/tegra30.c
>>>>>>>>> @@ -1021,6 +1021,9 @@ static const struct tegra_smmu_swgroup
>>>>>>>>> tegra30_swgroups[] = {
>>>>>>>>>  static const unsigned int tegra30_group_display[] = {
>>>>>>>>>  	TEGRA_SWGROUP_DC,
>>>>>>>>>  	TEGRA_SWGROUP_DCB,
>>>>>>>>> +	TEGRA_SWGROUP_G2,
>>>>>>>>> +	TEGRA_SWGROUP_NV,
>>>>>>>>> +	TEGRA_SWGROUP_NV2,
>>>>>>>>>  };
>>>>>>>>>
>>>>>>>>>  static const struct tegra_smmu_group_soc tegra30_groups[] = {
>>>>>>>>> ---
>>>>>>>>>
>>>>>>>>> Please let me know whether you're going to make a patch or if I should
>>>>>>>>> do it.
>>>>>>>>
>>>>>>>> I've been testing with a similar change and couldn't find any
>>>>>>>> regressions. I've also made the same modifications for Tegra114 and
>>>>>>>> Tegra124.
>>>>>>>>
>>>>>>>> Are you saying that none of these patches are needed anymore? Or do we
>>>>>>>> still need a patch to fix detaching? I'm thinking that maybe we can
>>>>>>>> drastrically simplify the detachment now by dropping the shared
>>>>>>>> parameter altogether.
>>>>>>>>
>>>>>>>> Let me draft a patch and send out the whole set for testing.
>>>>>>>
>>>>>>> Seems it's still not ideal because I noticed this in KMSG:
>>>>>>>
>>>>>>> [    0.703185] Failed to attached device 54200000.dc to IOMMU_mapping
>>>>>>> [    0.710404] Failed to attached device 54240000.dc to IOMMU_mapping
>>>>>>> [    0.719347] Failed to attached device 54140000.gr2d to IOMMU_mapping
>>>>>>> [    0.719569] Failed to attached device 54180000.gr3d to IOMMU_mapping
>>>>>>>
>>>>>>> which comes from the implicit IOMMU backing.
>>>>>>
>>>>>> And the error comes from here:
>>>>>>
>>>>>> https://elixir.bootlin.com/linux/v5.4-rc2/source/drivers/iommu/iommu.c#L1655
>>>>>
>>>>> So the detaching still should be needed, but at the moment the ARM32
>>>>> DMA-mapping code is simply not suitable for the case of having multiple
>>>>> devices in the same group. I'm wondering whether there are any real
>>>>> users for the implicit IOMMU backing on ARM32 at all :/
>>>>>
>>>>
>>>> Apparently the "Failed to attached device 54200000.dc" was always in the
>>>> log (I rarely testing the default multi-platform config), it's just the
>>>> message is a pr_warn that I wasn't paying attention because it is
>>>> colored like pr_info in dmesg :)
>>>
>>> Yeah, so the above isn't a complete solution. In order to actually use
>>> the DMA API backed by an IOMMU, some additional patches are needed. I
>>> have all of those in a local tree and I've already sent out a couple of
>>> them. It's taking a while because they all need to be applied in small
>>> iterations to make sure things don't break midway.
>>
>> I'd like to have an immediate interim solution.
> 
> To clarify: when I said "isn't a complete solution", what I meant is
> that it's not a complete solution to make the implicit IOMMU backing
> work with the DMA API. That's what I've got a patch set ready for.

Okay.

> But you said earlier that this change (i.e. putting all DRM devices into
> the same IOMMU group) fixes the issue that you were seeing, right? So
> that would be an immediate, interim solution, wouldn't it?

Yes, it would.
