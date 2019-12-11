Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D30C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A9F8208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HaaSvcaK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730823AbfLKR3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 12:29:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35811 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726368AbfLKR3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 12:29:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576085381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vI8I5D2EV8LAbTP9+6YHyR2VwUD8YON5WoS15ZKn6BU=;
        b=HaaSvcaKqVglSaW15qBsNGQoCH7lvnCQR5ncNBbvc04sEHGaW2nYzbn/uU83WD6FKdFkRZ
        MrM7FgWme+GfwoRLnPbwLa4KrjVUB/B7Z34aVOl2oHWrnABHCJlnnwDENGtnrGLTK3gyfh
        7p1s0e3DCUzSusG9m0vNzGkN79IUfT0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-zEF3QoXFPrCkSKUTosHqfw-1; Wed, 11 Dec 2019 12:29:39 -0500
X-MC-Unique: zEF3QoXFPrCkSKUTosHqfw-1
Received: by mail-wr1-f71.google.com with SMTP id u12so10693260wrt.15
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 09:29:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vI8I5D2EV8LAbTP9+6YHyR2VwUD8YON5WoS15ZKn6BU=;
        b=W8rnRslGDJteJE29xJgDP2OAhcUlmkiOnbE7nrIztvofavWaKXZ4SsK8+erN81y4xA
         72yHuOogLnESCoVDsqcPdIIbzlINkfg1+x3IJIpMBeOL03QfZEfBcSvI28tgfcAfT6hV
         UUmAAmVTsJE3jbI9pMJajmyrLtC4TUijfS3A1G/3jLf1KBM5VrUbTYUg8iaAGN6H5u2u
         1A5RQecpgZ7lcKIO1ZSbnWnYKI4jMaVjoXGq0tXuywhRK0SLlk5BKLii7g7N5EKVSp14
         wspEdvoSAK/NzBd1iESrD0l1/oDT9bjgMCD2nMmrbSmaSIXz2z6OnEeBFP9ZbaBvgUrI
         vUXw==
X-Gm-Message-State: APjAAAWj6M5fOUKpLvQVHnYb3gxEg0OdcJ4BnAYCVxSNOxjYWrTfd/47
        3jrbu2dFbUbKjxt4JmwXarpgBMAgO2RP6zrrIcVWpgKDslZZfQRLZTFZZaze6gNKcUHpQcd5eUO
        FkdYmW3W12FKpVcNHMpLwnFt9
X-Received: by 2002:a05:600c:1009:: with SMTP id c9mr1085116wmc.162.1576085374768;
        Wed, 11 Dec 2019 09:29:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqwFyxoSJsKNCNIv6f3WTGZdy9wp3MAZBIA3/ejS8RZrpH+PBacqBplsEXpPCpmEEkcb9GT0/Q==
X-Received: by 2002:a05:600c:1009:: with SMTP id c9mr1085091wmc.162.1576085374559;
        Wed, 11 Dec 2019 09:29:34 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id p5sm2875224wrt.79.2019.12.11.09.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 09:29:33 -0800 (PST)
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
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a05e5a2b-568e-2b0d-0293-aa937c590a74@redhat.com>
Date:   Wed, 11 Dec 2019 18:29:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191210085111.GQ3468@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 10-12-2019 09:51, Lee Jones wrote:
> On Tue, 19 Nov 2019, Hans de Goede wrote:
> 
>> At least Bay Trail (BYT) and Cherry Trail (CHT) devices can use 1 of 2
>> different PWM controllers for controlling the LCD's backlight brightness.
>>
>> Either the one integrated into the PMIC or the one integrated into the
>> SoC (the 1st LPSS PWM controller).
>>
>> So far in the LPSS code on BYT we have skipped registering the LPSS PWM
>> controller "pwm_backlight" lookup entry when a Crystal Cove PMIC is
>> present, assuming that in this case the PMIC PWM controller will be used.
>>
>> On CHT we have been relying on only 1 of the 2 PWM controllers being
>> enabled in the DSDT at the same time; and always registered the lookup.
>>
>> So far this has been working, but the correct way to determine which PWM
>> controller needs to be used is by checking a bit in the VBT table and
>> recently I've learned about 2 different BYT devices:
>> Point of View MOBII TAB-P800W
>> Acer Switch 10 SW5-012
>>
>> Which use a Crystal Cove PMIC, yet the LCD is connected to the SoC/LPSS
>> PWM controller (and the VBT correctly indicates this), so here our old
>> heuristics fail.
>>
>> Since only the i915 driver has access to the VBT, this commit renames
>> the "pwm_backlight" lookup entries for the Crystal Cove PMIC's PWM
>> controller to "pwm_pmic_backlight" so that the i915 driver can do a
>> pwm_get() for the right controller depending on the VBT bit, instead of
>> the i915 driver relying on a "pwm_backlight" lookup getting registered
>> which magically points to the right controller.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/mfd/intel_soc_pmic_core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> For my own reference:
>    Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

As mentioned in the cover-letter, to avoid breaking bi-sectability
as well as to avoid breaking the intel-gfx CI we need to merge this series
in one go through one tree. Specifically through the drm-intel tree.
Is that ok with you ?

If this is ok with you, then you do not have to do anything, I will just push
the entire series to drm-intel. drivers/mfd/intel_soc_pmic_core.c
does not see much changes so I do not expect this to lead to any conflicts.

Regards,

Hans

