Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6D0C341D9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91091246AE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MRD3aRNI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfLMMkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 07:40:46 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51761 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727077AbfLMMkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 07:40:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576240843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DUragvfk5FVu6qjRne2AQU3xFq5etQTYcUAxceDIICQ=;
        b=MRD3aRNITRGFAuYSs7es6fHQKxOK3zfTxBiOqGdijSw66K9Sm1m5rO2idf8DYIv9IFPn1b
        z51QvsSPgMK3XnXwMOZQ5ora76Mh3KS4A56Sib1lL87gRPAF3rpjdyKBnz6EbqgSVMHcIY
        iCj87g09SMYlCkmSGlmS13eFWQLf54U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-TV-MizjLNu-17L3RDuHzuw-1; Fri, 13 Dec 2019 07:40:40 -0500
X-MC-Unique: TV-MizjLNu-17L3RDuHzuw-1
Received: by mail-wm1-f71.google.com with SMTP id p2so2302073wma.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 04:40:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DUragvfk5FVu6qjRne2AQU3xFq5etQTYcUAxceDIICQ=;
        b=PY7/3FTT0crSgDKUOmVV91IAIc6S6MY+nJRYj3lAFlwagm/NsRjrQ/6lHy3pyAvaUQ
         bMSMfhrDNepa5Y1SnW0MESN7OK7tvPM2vBPGmNerBgvf9lKM9c9MBg8Ty4ALiAj2duxH
         Om10FWjNiitYxIgwM45peJxlzvBZUr6PJ6ESm3G/7ZrlZ2VoRAeMx0Xhgn8CTH9EM4y9
         Na62NGq9EYPaS+uUdUcM/BIX5M0VbNwfFOrBqYwy70ev1Dyv1szlSYng7l7hc2WH/9yq
         i/77h74R2M6DOA51tmkj9o5ZTll87BSKnD1sFZP2EFN8RV2DfxoSvXVC+hxWCL6XrsUE
         6f8A==
X-Gm-Message-State: APjAAAX6iaZYRH5Kv3WgrOGZMJSOA2Rt88C3CQ3M7m6QqSHqJSnzqQ3z
        P611Ppp3JJNKcoRxtjGnLByYzjdUUPd2s8plNsqluyKLgBiQqtZvjmPiYwHRx7Yw8R6RAHW4Eg0
        kz9q9RCr0vs78Alq3cPWpquC7
X-Received: by 2002:a7b:cf01:: with SMTP id l1mr12587149wmg.86.1576240839205;
        Fri, 13 Dec 2019 04:40:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqzbRIcHY9orrZ4lf2zeld4ZX7W4hZ9ME2FvdqX7ky1NhoyqbFSoXWz8BRoTm7hDdHzOuVqAiA==
X-Received: by 2002:a7b:cf01:: with SMTP id l1mr12587108wmg.86.1576240838906;
        Fri, 13 Dec 2019 04:40:38 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id t81sm10032474wmg.6.2019.12.13.04.40.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2019 04:40:38 -0800 (PST)
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
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d648794d-4c76-cfa1-dcbd-16c34d409c51@redhat.com>
Date:   Fri, 13 Dec 2019 13:40:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191213082734.GE3468@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13-12-2019 09:27, Lee Jones wrote:
> On Thu, 12 Dec 2019, Hans de Goede wrote:
> 
>> Hi,
>>
>> On 12-12-2019 16:52, Lee Jones wrote:
>>> On Thu, 12 Dec 2019, Hans de Goede wrote:
>>>
>>>> Hi,
>>>>
>>>> On 12-12-2019 09:45, Lee Jones wrote:
>>>>> On Wed, 11 Dec 2019, Hans de Goede wrote:
>>>>>
>>>>>> Hi Lee,
>>>>>>
>>>>>> On 10-12-2019 09:51, Lee Jones wrote:
>>>>>>> On Tue, 19 Nov 2019, Hans de Goede wrote:
>>>>>>>
>>>>>>>> At least Bay Trail (BYT) and Cherry Trail (CHT) devices can use 1 of 2
>>>>>>>> different PWM controllers for controlling the LCD's backlight brightness.
>>>>>>>>
>>>>>>>> Either the one integrated into the PMIC or the one integrated into the
>>>>>>>> SoC (the 1st LPSS PWM controller).
>>>>>>>>
>>>>>>>> So far in the LPSS code on BYT we have skipped registering the LPSS PWM
>>>>>>>> controller "pwm_backlight" lookup entry when a Crystal Cove PMIC is
>>>>>>>> present, assuming that in this case the PMIC PWM controller will be used.
>>>>>>>>
>>>>>>>> On CHT we have been relying on only 1 of the 2 PWM controllers being
>>>>>>>> enabled in the DSDT at the same time; and always registered the lookup.
>>>>>>>>
>>>>>>>> So far this has been working, but the correct way to determine which PWM
>>>>>>>> controller needs to be used is by checking a bit in the VBT table and
>>>>>>>> recently I've learned about 2 different BYT devices:
>>>>>>>> Point of View MOBII TAB-P800W
>>>>>>>> Acer Switch 10 SW5-012
>>>>>>>>
>>>>>>>> Which use a Crystal Cove PMIC, yet the LCD is connected to the SoC/LPSS
>>>>>>>> PWM controller (and the VBT correctly indicates this), so here our old
>>>>>>>> heuristics fail.
>>>>>>>>
>>>>>>>> Since only the i915 driver has access to the VBT, this commit renames
>>>>>>>> the "pwm_backlight" lookup entries for the Crystal Cove PMIC's PWM
>>>>>>>> controller to "pwm_pmic_backlight" so that the i915 driver can do a
>>>>>>>> pwm_get() for the right controller depending on the VBT bit, instead of
>>>>>>>> the i915 driver relying on a "pwm_backlight" lookup getting registered
>>>>>>>> which magically points to the right controller.
>>>>>>>>
>>>>>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>>>>>> ---
>>>>>>>>      drivers/mfd/intel_soc_pmic_core.c | 2 +-
>>>>>>>>      1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> For my own reference:
>>>>>>>       Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
>>>>>>
>>>>>> As mentioned in the cover-letter, to avoid breaking bi-sectability
>>>>>> as well as to avoid breaking the intel-gfx CI we need to merge this series
>>>>>> in one go through one tree. Specifically through the drm-intel tree.
>>>>>> Is that ok with you ?
>>>>>>
>>>>>> If this is ok with you, then you do not have to do anything, I will just push
>>>>>> the entire series to drm-intel. drivers/mfd/intel_soc_pmic_core.c
>>>>>> does not see much changes so I do not expect this to lead to any conflicts.
>>>>>
>>>>> It's fine, so long as a minimal immutable pull-request is provided.
>>>>> Whether it's pulled or not will depend on a number of factors, but it
>>>>> needs to be an option.
>>>>
>>>> The way the drm subsys works that is not really a readily available
>>>> option. The struct definition which this patch changes a single line in
>>>> has not been touched since 2015-06-26 so I really doubt we will get a
>>>> conflict from this.
>>>
>>> Always with the exceptions ...
>>>
>>> OOI, why does this *have* to go through the DRM tree?
>>
>> This patch renames the name used to lookup the pwm controller from
>> "pwm_backlight" to "pwm_pmic_backlight" because there are 2 possible
>> pwm controllers which may be used, one in the SoC itself and one
>> in the PMIC. Which controller should be used is described in a table
>> in the Video BIOS, so another part of this series adds this code to
>> the i915 driver:
>>
>> -	panel->backlight.pwm = pwm_get(dev->dev, "pwm_backlight");
>> +	/* Get the right PWM chip for DSI backlight according to VBT */
>> +	if (dev_priv->vbt.dsi.config->pwm_blc == PPS_BLC_PMIC) {
>> +		panel->backlight.pwm = pwm_get(dev->dev, "pwm_pmic_backlight");
>> +		desc = "PMIC";
>> +	} else {
>> +		panel->backlight.pwm = pwm_get(dev->dev, "pwm_soc_backlight");
>> +		desc = "SoC";
>> +	}
>>
>> So both not to break bisectability, but also so as to not break the extensive
>> CI system which is used to test the i915 driver we need the MFD change doing
>> the rename to go upstrream through the same tree as the i915 change.
>>
>> I have even considered just squashing the 2 commits together as having only 1
>> present, but not the other breaks stuff left and right.
> 
> That doesn't answer the question.
> 
> Why do they all *have* to go in via the DRM tree specifically?

1. As explained these chanegs need to stay together
2. This change is primarily a drm/i915 change. Also the i915 code sees lots
of changes every cycle, where as the change to the mfd code touches a block
of code which has not been touched since 2015-06-26, so the chance of conflicts
is much bigger if this goes on through another tree.

I honestly do not see the problem here? Let me reverse the question why should this
NOT go in through the drm tree?

Regards,

Hans

