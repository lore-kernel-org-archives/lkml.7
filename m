Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536BFC2D0CA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 19:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2405F2073B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 19:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FkJsvhDC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730655AbfLLTDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 14:03:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48951 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730168AbfLLTDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 14:03:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576177378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2g3fZhcsSrRGHzfeL8zuc2n1XDVEZgXCmHzHbk4+Fz4=;
        b=FkJsvhDCyfBjs6N7AvR2iUvb03PH5dU1Zb0xQH4HDLdB8DpF90VkDfBykbx3jrVXfhfq23
        rw1qLc0Qo39QWvg0b3HYXBqZzdb7CZGGxlR9MmrYK+O9779RKd3gnAqcIk0B4HlzjJfRdH
        LQMBIcbkyGEbW0iqGu65yVArqCVzztA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-D0eTH4I3O8mh5bQBanr7ng-1; Thu, 12 Dec 2019 14:02:55 -0500
X-MC-Unique: D0eTH4I3O8mh5bQBanr7ng-1
Received: by mail-wr1-f70.google.com with SMTP id u12so1378792wrt.15
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 11:02:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2g3fZhcsSrRGHzfeL8zuc2n1XDVEZgXCmHzHbk4+Fz4=;
        b=noan5ayGupbLAs6lsHTLTijnMtCShKEX/KfYMY33VP/iZtbpHEmcs8zk1hS1z2QpRx
         sdhNLzn1vTQ6vZB8+Ax+mcgaOtjM/mlLwX6/Y9uAWtU/6TE29+LFtH5+AxrEiDwl4UY/
         lNs63DSD9tkaKxRvjKpi3HePuC2yeG+mrB2vmgk8+Yw1hIeZB0vzc2TiWoGmLnveHSvc
         tR4CLGZVbutvYCsv19jPZGlR25TxRYZZISxEfDTQUh8F20JzeCw18MixhxgOyj5ronPx
         jNrEc6kkkJTqQkej53mv9ah/ibBhL3mVo6XruRfA1I1BvvFkQBSmO7SK24GyOprWJTj2
         6TKA==
X-Gm-Message-State: APjAAAWmy8qbB4BZ1mhfpxPL442ZtpZzIUZxSNyMV9v7MjeY41S3YXZt
        tYhegEWd3DkQV1BbwByKtuJxl5q4bB4jw93Xgy7lwXEkAb2c23quYyk2EGn6R16JCkwFfRqF7aL
        IpZkqyJHaR3eEzcpsdmGOPLv4
X-Received: by 2002:a1c:ab85:: with SMTP id u127mr8067546wme.40.1576177374209;
        Thu, 12 Dec 2019 11:02:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqzQukJStmxmoEoaxXikD5ciYQ5z/yOZy47VSl9amElYeQjqTK2KA5kfBGOBwBV7OX3cgJ0QIw==
X-Received: by 2002:a1c:ab85:: with SMTP id u127mr8067516wme.40.1576177373951;
        Thu, 12 Dec 2019 11:02:53 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id e18sm7016654wrr.95.2019.12.12.11.02.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 11:02:53 -0800 (PST)
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
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4d07445d-98b1-f23c-0aac-07709b45df78@redhat.com>
Date:   Thu, 12 Dec 2019 20:02:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212155209.GC3468@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12-12-2019 16:52, Lee Jones wrote:
> On Thu, 12 Dec 2019, Hans de Goede wrote:
> 
>> Hi,
>>
>> On 12-12-2019 09:45, Lee Jones wrote:
>>> On Wed, 11 Dec 2019, Hans de Goede wrote:
>>>
>>>> Hi Lee,
>>>>
>>>> On 10-12-2019 09:51, Lee Jones wrote:
>>>>> On Tue, 19 Nov 2019, Hans de Goede wrote:
>>>>>
>>>>>> At least Bay Trail (BYT) and Cherry Trail (CHT) devices can use 1 of 2
>>>>>> different PWM controllers for controlling the LCD's backlight brightness.
>>>>>>
>>>>>> Either the one integrated into the PMIC or the one integrated into the
>>>>>> SoC (the 1st LPSS PWM controller).
>>>>>>
>>>>>> So far in the LPSS code on BYT we have skipped registering the LPSS PWM
>>>>>> controller "pwm_backlight" lookup entry when a Crystal Cove PMIC is
>>>>>> present, assuming that in this case the PMIC PWM controller will be used.
>>>>>>
>>>>>> On CHT we have been relying on only 1 of the 2 PWM controllers being
>>>>>> enabled in the DSDT at the same time; and always registered the lookup.
>>>>>>
>>>>>> So far this has been working, but the correct way to determine which PWM
>>>>>> controller needs to be used is by checking a bit in the VBT table and
>>>>>> recently I've learned about 2 different BYT devices:
>>>>>> Point of View MOBII TAB-P800W
>>>>>> Acer Switch 10 SW5-012
>>>>>>
>>>>>> Which use a Crystal Cove PMIC, yet the LCD is connected to the SoC/LPSS
>>>>>> PWM controller (and the VBT correctly indicates this), so here our old
>>>>>> heuristics fail.
>>>>>>
>>>>>> Since only the i915 driver has access to the VBT, this commit renames
>>>>>> the "pwm_backlight" lookup entries for the Crystal Cove PMIC's PWM
>>>>>> controller to "pwm_pmic_backlight" so that the i915 driver can do a
>>>>>> pwm_get() for the right controller depending on the VBT bit, instead of
>>>>>> the i915 driver relying on a "pwm_backlight" lookup getting registered
>>>>>> which magically points to the right controller.
>>>>>>
>>>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>>>> ---
>>>>>>     drivers/mfd/intel_soc_pmic_core.c | 2 +-
>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> For my own reference:
>>>>>      Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
>>>>
>>>> As mentioned in the cover-letter, to avoid breaking bi-sectability
>>>> as well as to avoid breaking the intel-gfx CI we need to merge this series
>>>> in one go through one tree. Specifically through the drm-intel tree.
>>>> Is that ok with you ?
>>>>
>>>> If this is ok with you, then you do not have to do anything, I will just push
>>>> the entire series to drm-intel. drivers/mfd/intel_soc_pmic_core.c
>>>> does not see much changes so I do not expect this to lead to any conflicts.
>>>
>>> It's fine, so long as a minimal immutable pull-request is provided.
>>> Whether it's pulled or not will depend on a number of factors, but it
>>> needs to be an option.
>>
>> The way the drm subsys works that is not really a readily available
>> option. The struct definition which this patch changes a single line in
>> has not been touched since 2015-06-26 so I really doubt we will get a
>> conflict from this.
> 
> Always with the exceptions ...
> 
> OOI, why does this *have* to go through the DRM tree?

This patch renames the name used to lookup the pwm controller from
"pwm_backlight" to "pwm_pmic_backlight" because there are 2 possible
pwm controllers which may be used, one in the SoC itself and one
in the PMIC. Which controller should be used is described in a table
in the Video BIOS, so another part of this series adds this code to
the i915 driver:

-	panel->backlight.pwm = pwm_get(dev->dev, "pwm_backlight");
+	/* Get the right PWM chip for DSI backlight according to VBT */
+	if (dev_priv->vbt.dsi.config->pwm_blc == PPS_BLC_PMIC) {
+		panel->backlight.pwm = pwm_get(dev->dev, "pwm_pmic_backlight");
+		desc = "PMIC";
+	} else {
+		panel->backlight.pwm = pwm_get(dev->dev, "pwm_soc_backlight");
+		desc = "SoC";
+	}

So both not to break bisectability, but also so as to not break the extensive
CI system which is used to test the i915 driver we need the MFD change doing
the rename to go upstrream through the same tree as the i915 change.

I have even considered just squashing the 2 commits together as having only 1
present, but not the other breaks stuff left and right.

Regards,

Hans

