Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D0DC2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B56A20725
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PnIe3uhI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfLPKEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 05:04:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52711 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727183AbfLPKET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 05:04:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576490657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n+nZD1wou0OdHK/v70K0ax5pBsibiIqbXcWva3aSMH0=;
        b=PnIe3uhIZfPsJPfzsKSugpovO78zKKIlCJTlkS3Ln9G3WI0vZ7lz3Hb+hZ0nmMRVyxACWd
        lVT51GC7KsNKZZEH0sLEB+2HEnYHxpZA+NqoWzjonz20S0BnGYS+Tu7dhb3gARF+oQMwht
        IZnUDnYwJc/kTUK6sVWX0Ti91/YneOY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-C_4B6hISPvufF0lPCjmMAg-1; Mon, 16 Dec 2019 05:04:16 -0500
X-MC-Unique: C_4B6hISPvufF0lPCjmMAg-1
Received: by mail-wm1-f69.google.com with SMTP id l13so856742wmj.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 02:04:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n+nZD1wou0OdHK/v70K0ax5pBsibiIqbXcWva3aSMH0=;
        b=kJHCQD/jSCo9TkjFdyzTuZ4cQlVmXRc5uKyBjwmdtlp6uTnJaJAHkJ8ABQXfSD6nUB
         TMdQdCUxXoAhrEUlnZdSqHJQfWiTnxya3M0pKOkFRglyVV2AfGmvZmuWw6zF3KyUj7H9
         twkEISyGMpbhNae7t+2DBSGm6pecmaqk8GA3BSFB5KzA+IYU1lyhAdDkPa0AeU5o8y/p
         AVvDTbO5YpZkKdWYaZj7lXHwjK6JmBBLIwaoTYF85Vw7IBCPDC/6u4a6GzwetREIxikl
         Couo/OiQZ+dOTll/7C/N4n4tv4ikEi8XrA91M7/SKlNAy/DYgrsfpuPRRN1XFWeTPs1m
         bLWQ==
X-Gm-Message-State: APjAAAV+AVp9pA/Ily23TWd8o5IFbsRntyB6zSNW4vltEh43yqM1zBhL
        40hhHgfFEWIiwh1oigRc4WXerzK/ucb2YUeXs0HDxm3nBac78+afEM0U7NnMp6SAe0LUl5ddhEm
        VmMBokKeexawyDNXQ28GQAKZ3
X-Received: by 2002:adf:8bde:: with SMTP id w30mr28551616wra.124.1576490654335;
        Mon, 16 Dec 2019 02:04:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqx3tP5/AEiAuh0S88I6e325W+U3qq3HdTrPJSVmsg//HMc1FewsjxxwOoJwwstxcOpKxXbu8w==
X-Received: by 2002:adf:8bde:: with SMTP id w30mr28551578wra.124.1576490653941;
        Mon, 16 Dec 2019 02:04:13 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id g9sm21332721wro.67.2019.12.16.02.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2019 02:04:13 -0800 (PST)
Subject: Re: [PATCH 2/3] mfd: intel_soc_pmic: Rename pwm_backlight pwm-lookup
 to pwm_pmic_backlight
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20191119151818.67531-1-hdegoede@redhat.com>
 <20191119151818.67531-3-hdegoede@redhat.com> <20191210085111.GQ3468@dell>
 <a05e5a2b-568e-2b0d-0293-aa937c590a74@redhat.com>
 <20191212084546.GA3468@dell>
 <d22e9a04-da09-0f41-a78e-ac17a947650a@redhat.com>
 <20191212155209.GC3468@dell>
 <4d07445d-98b1-f23c-0aac-07709b45df78@redhat.com>
 <20191213082734.GE3468@dell>
 <d648794d-4c76-cfa1-dcbd-16c34d409c51@redhat.com>
 <20191216093016.GE3648@dell>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <fc3c29da-528d-a6b6-d13b-92e6469eadea@redhat.com>
Date:   Mon, 16 Dec 2019 11:04:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216093016.GE3648@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 16-12-2019 10:30, Lee Jones wrote:
> [...]
> 
>>>>>>>>>> Which use a Crystal Cove PMIC, yet the LCD is connected to the SoC/LPSS
>>>>>>>>>> PWM controller (and the VBT correctly indicates this), so here our old
>>>>>>>>>> heuristics fail.
>>>>>>>>>>
>>>>>>>>>> Since only the i915 driver has access to the VBT, this commit renames
>>>>>>>>>> the "pwm_backlight" lookup entries for the Crystal Cove PMIC's PWM
>>>>>>>>>> controller to "pwm_pmic_backlight" so that the i915 driver can do a
>>>>>>>>>> pwm_get() for the right controller depending on the VBT bit, instead of
>>>>>>>>>> the i915 driver relying on a "pwm_backlight" lookup getting registered
>>>>>>>>>> which magically points to the right controller.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>>>>>>>> ---
>>>>>>>>>>       drivers/mfd/intel_soc_pmic_core.c | 2 +-
>>>>>>>>>>       1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> For my own reference:
>>>>>>>>>        Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
>>>>>>>>
>>>>>>>> As mentioned in the cover-letter, to avoid breaking bi-sectability
>>>>>>>> as well as to avoid breaking the intel-gfx CI we need to merge this series
>>>>>>>> in one go through one tree. Specifically through the drm-intel tree.
>>>>>>>> Is that ok with you ?
>>>>>>>>
>>>>>>>> If this is ok with you, then you do not have to do anything, I will just push
>>>>>>>> the entire series to drm-intel. drivers/mfd/intel_soc_pmic_core.c
>>>>>>>> does not see much changes so I do not expect this to lead to any conflicts.
>>>>>>>
>>>>>>> It's fine, so long as a minimal immutable pull-request is provided.
>>>>>>> Whether it's pulled or not will depend on a number of factors, but it
>>>>>>> needs to be an option.
>>>>>>
>>>>>> The way the drm subsys works that is not really a readily available
>>>>>> option. The struct definition which this patch changes a single line in
>>>>>> has not been touched since 2015-06-26 so I really doubt we will get a
>>>>>> conflict from this.
>>>>>
>>>>> Always with the exceptions ...
>>>>>
>>>>> OOI, why does this *have* to go through the DRM tree?
>>>>
>>>> This patch renames the name used to lookup the pwm controller from
>>>> "pwm_backlight" to "pwm_pmic_backlight" because there are 2 possible
>>>> pwm controllers which may be used, one in the SoC itself and one
>>>> in the PMIC. Which controller should be used is described in a table
>>>> in the Video BIOS, so another part of this series adds this code to
>>>> the i915 driver:
>>>>
>>>> -	panel->backlight.pwm = pwm_get(dev->dev, "pwm_backlight");
>>>> +	/* Get the right PWM chip for DSI backlight according to VBT */
>>>> +	if (dev_priv->vbt.dsi.config->pwm_blc == PPS_BLC_PMIC) {
>>>> +		panel->backlight.pwm = pwm_get(dev->dev, "pwm_pmic_backlight");
>>>> +		desc = "PMIC";
>>>> +	} else {
>>>> +		panel->backlight.pwm = pwm_get(dev->dev, "pwm_soc_backlight");
>>>> +		desc = "SoC";
>>>> +	}
>>>>
>>>> So both not to break bisectability, but also so as to not break the extensive
>>>> CI system which is used to test the i915 driver we need the MFD change doing
>>>> the rename to go upstrream through the same tree as the i915 change.
>>>>
>>>> I have even considered just squashing the 2 commits together as having only 1
>>>> present, but not the other breaks stuff left and right.
>>>
>>> That doesn't answer the question.
>>>
>>> Why do they all *have* to go in via the DRM tree specifically?
>>
>> 1. As explained these chanegs need to stay together
>> 2. This change is primarily a drm/i915 change. Also the i915 code sees lots
>> of changes every cycle, where as the change to the mfd code touches a block
>> of code which has not been touched since 2015-06-26, so the chance of conflicts
>> is much bigger if this goes on through another tree.
>>
>> I honestly do not see the problem here? Let me reverse the question why should this
>> NOT go in through the drm tree?
> 
> There isn't a problem with *this* patch.  I could say, "sure, take it"
> and the chances are everything could be fine from a technical
> perspective.
> 
> However, I'm taking exception to the fact you think this series is
> *special* enough to warrant circumventing the usual way in which we
> usually work when dealing with cross-subsystem patch-sets.  Something
> I personally deal with a lot due to the inherent hierarchical nature
> of Multi-Functional Devices.
> 
> I'm on the fence on this one.  Due to the circumstances surrounding
> *this* patch alone, it would be so much easier (for both of us!) to
> just Ack the patch and hope no further changes occur which could
> potentially cause someone else (you, me, Linus) more work later on.
> However, I'm very keen to prevent setting a precedent for this kind of
> action, as it's clearly not the right path to take in a vast majority
> of cases.
> 
>> 1. As explained these chanegs need to stay together
> 
> The patch-set would stay together regardless.  That's the point of an
> immutable branch, it can be taken in by all relevant parties and Git
> will just do-the-right-thing.
> 
>> 2. This change is primarily a drm/i915 change. Also the i915 code sees lots
>> of changes every cycle, where as the change to the mfd code touches a block
>> of code which has not been touched since 2015-06-26, so the chance of conflicts
>> is much bigger if this goes on through another tree.
> 
> This too is irrelevant, since the patch-set could/would go though
> both/all trees simultaneously.  The way in which we normally work with
> other subsystems doesn't involve a gamble over which subsystem is most
> likely going to be affected by a merge conflict as you suggest, it
> eradicates conflicts for all.

I'm well aware of using immutable branches and that those are
often used for patch-set's which touch multiple subsystems. But
although immutable branches are used often they are about as often
not used for various reasons, with people choosing to just merge
through a single tree.
> I'm not saying "no" by the way.  I just want to find out your
> reasons/motivation as to why you're insisting this needs go through
> a) a specific tree and b) just one tree.  Questions which I am yet to
> see a compelling answer.

Doing immutable branches assumes that there is a base point,
e.g. 5.5-rc1 where the immutable branch can then be based on and
that the branch can then be merged without issues into both subsystems.

drm is constantly evolving to deal with and mostly catch up with new
hardware as both GPUs and display-pipelines are evolving quite rapidly
atm drm-intel-next has about 400 commits on top of 5.5-rc1 so for an
immutable branch I can either base it on drm-intel-next which
violates your request for a clean minimal branch to merge; or I can
base it on 5.5-rc1 which leads to a big chance of problems when
merging it given to large amount of churn in drm-intel-next.

So instead of the normal case of 2 subsystems seeing some changes
on both side the case we have here is a part of a file which has
not changed since 2015-06-26 in one subsys (and changing only
a single line there!) and OTOH we have bigger changes to a subsys
which see 400 patches land in the first week since rc1 .

I hope that you agree that in this case given the large amount of
churn in drm-intel-next it makes since to just straight forward
apply these patches on top of drm-intel-next.

Regards,

Hans

