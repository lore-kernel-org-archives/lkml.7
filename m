Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02071C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C75102067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OguXM/3J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbfLLOel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:34:41 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33494 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729724AbfLLOel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 09:34:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576161279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8L0wh57USWeg4kwDbaH2LaCzisTmsJPLc/9WAOqxji8=;
        b=OguXM/3J8LGWIicHGD40uEHW5+9RlEj7anvHDGN5dszY5qvpRfCTf4DVdyWZ6JLmG4maxY
        s50+p22i/xY/WilnnIePcY+kiEpfMA7dRKTrSP4AAmwlNwz5OwHiQdiFYNmYYuneT90qPg
        BLwyjtAOrCrTHOmQ3R5tFDh7cuRmyQM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-N-tHyj3oOHuolITknj_asw-1; Thu, 12 Dec 2019 09:34:38 -0500
X-MC-Unique: N-tHyj3oOHuolITknj_asw-1
Received: by mail-wm1-f71.google.com with SMTP id l11so1734031wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 06:34:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8L0wh57USWeg4kwDbaH2LaCzisTmsJPLc/9WAOqxji8=;
        b=BQOAdG9Shg+XDTGF3VHRf2Pqbh/m5LJMcUZUrl8lPYwUcVl2ewlG4rUYOLRm8vC8FX
         Fq0DUWs5RMR0aysCloYMfQbXji1wVAKHZ3yNQ1xtXaiwYNlPICGws+cGAYNqy5BzwgGR
         qoK1pw2aj+B73EkX1n8Rk6Tfw3slWrqz/FrQE6xVtiWlxGkFmws7ILXijJEG5ffQlLCk
         pqoijHIAlWI9d7A67fWsDnA8UJvmrvoMaapcb2LWdt2QQmYjNV1I9KtR0FTWmQfYYV55
         W7/7fX72kPuo+vF02OBvmpoHWd/wTLAPvz7itPIRq6XQJTr6KAOKlFluu5Fhbk9ANiB/
         m2mw==
X-Gm-Message-State: APjAAAWmWGYmcZbv3UhUym7KkMp5okdkiZ+ZAE07kYS+N0maKu1GxnXA
        ihu92lWuwUORBlpSzBlrRFTBA2Eryvx5kJKo4mEVd30o5a2Qk7QgicD9wMCfiiEvDwqKsLdmnYM
        dfllJIdsM5j1YuLisVw24esWe
X-Received: by 2002:a1c:a9c6:: with SMTP id s189mr7132901wme.151.1576161276516;
        Thu, 12 Dec 2019 06:34:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqwkMCbj3Al3W02aKWsSaIJItyyUbz24oMkL+40mFm8mAw2FfNeYRrpFtQxw5vg9q9Dyq+2PYg==
X-Received: by 2002:a1c:a9c6:: with SMTP id s189mr7132870wme.151.1576161276268;
        Thu, 12 Dec 2019 06:34:36 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id y20sm6009145wmi.25.2019.12.12.06.34.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 06:34:35 -0800 (PST)
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
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d22e9a04-da09-0f41-a78e-ac17a947650a@redhat.com>
Date:   Thu, 12 Dec 2019 15:34:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212084546.GA3468@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12-12-2019 09:45, Lee Jones wrote:
> On Wed, 11 Dec 2019, Hans de Goede wrote:
> 
>> Hi Lee,
>>
>> On 10-12-2019 09:51, Lee Jones wrote:
>>> On Tue, 19 Nov 2019, Hans de Goede wrote:
>>>
>>>> At least Bay Trail (BYT) and Cherry Trail (CHT) devices can use 1 of 2
>>>> different PWM controllers for controlling the LCD's backlight brightness.
>>>>
>>>> Either the one integrated into the PMIC or the one integrated into the
>>>> SoC (the 1st LPSS PWM controller).
>>>>
>>>> So far in the LPSS code on BYT we have skipped registering the LPSS PWM
>>>> controller "pwm_backlight" lookup entry when a Crystal Cove PMIC is
>>>> present, assuming that in this case the PMIC PWM controller will be used.
>>>>
>>>> On CHT we have been relying on only 1 of the 2 PWM controllers being
>>>> enabled in the DSDT at the same time; and always registered the lookup.
>>>>
>>>> So far this has been working, but the correct way to determine which PWM
>>>> controller needs to be used is by checking a bit in the VBT table and
>>>> recently I've learned about 2 different BYT devices:
>>>> Point of View MOBII TAB-P800W
>>>> Acer Switch 10 SW5-012
>>>>
>>>> Which use a Crystal Cove PMIC, yet the LCD is connected to the SoC/LPSS
>>>> PWM controller (and the VBT correctly indicates this), so here our old
>>>> heuristics fail.
>>>>
>>>> Since only the i915 driver has access to the VBT, this commit renames
>>>> the "pwm_backlight" lookup entries for the Crystal Cove PMIC's PWM
>>>> controller to "pwm_pmic_backlight" so that the i915 driver can do a
>>>> pwm_get() for the right controller depending on the VBT bit, instead of
>>>> the i915 driver relying on a "pwm_backlight" lookup getting registered
>>>> which magically points to the right controller.
>>>>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>> ---
>>>>    drivers/mfd/intel_soc_pmic_core.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> For my own reference:
>>>     Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
>>
>> As mentioned in the cover-letter, to avoid breaking bi-sectability
>> as well as to avoid breaking the intel-gfx CI we need to merge this series
>> in one go through one tree. Specifically through the drm-intel tree.
>> Is that ok with you ?
>>
>> If this is ok with you, then you do not have to do anything, I will just push
>> the entire series to drm-intel. drivers/mfd/intel_soc_pmic_core.c
>> does not see much changes so I do not expect this to lead to any conflicts.
> 
> It's fine, so long as a minimal immutable pull-request is provided.
> Whether it's pulled or not will depend on a number of factors, but it
> needs to be an option.

The way the drm subsys works that is not really a readily available
option. The struct definition which this patch changes a single line in
has not been touched since 2015-06-26 so I really doubt we will get a
conflict from this.

Regards,

Hans

