Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5C1C74A23
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE79E2084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+U8F6c7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfGJODa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 10:03:30 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45211 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfGJODa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 10:03:30 -0400
Received: by mail-qt1-f196.google.com with SMTP id j19so2470298qtr.12;
        Wed, 10 Jul 2019 07:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2GPFpTiWfd8hx/L3TEHsm8trnZwkg18NUyiQIdlDfIM=;
        b=E+U8F6c7toIoLMK8dCSQ5NefkMuteVs7bE2v2Gxnz6xPcO/Nvtg9p7Yn1vytOTyal7
         Ax/o+vjgetf+EQlNX4U/QjKFNcBec2CVHPANsyN9Udply1mNbKSAOZuJ6S7r08tkJxT+
         FBEccbsgIz0tKkZTokXv0THhpVlHQdXViepthEHBzuLyW94YsJudoBlVEpXC8uXbCRLz
         Cnq+fu7EYI+RlF7+mqT0oykNRisIMDm2FpkeKErVrNdsfB435ArTw+Slnj5jZNLsnDI6
         iOUVRAGmF2IryPYBMu3vcyiW1iUEQ2/pkbgYZur9CH+LDrx3PhMmqANx86ntSQ9inepI
         YlvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2GPFpTiWfd8hx/L3TEHsm8trnZwkg18NUyiQIdlDfIM=;
        b=rlr6X0+xDs4bAIkfFoRgC6UnZRBk3reCmmVxGKsCUj9eSexL+9SHHSsmQo48lclYEv
         pZuyqHuIrceZB+eG64lSmF7+tR8mI3hVn6YpbC7FYiU9SAak2wsgddL95Q48ydYe89Du
         7y24EIdKo5B2uveeLxouEZeDx6gsq/RjitL7WXHKRAudoIuAUtw5pTEKMvdYiTD1sLDx
         vxq0H3GaV8gZiLtZyINoOjm8xyOlL814/qlV7gIznC4Iuzmf7OYF1Bf7MlY6W5tUlvMj
         Evqz08KbHiuF3bp9MqTFmFU3l2NO5nYC8XwV75fux35ode1cqR/hzyUyxFUInTMOXbeu
         PNrQ==
X-Gm-Message-State: APjAAAUI9IXAA+pLDkKvxdXoJHrKXAiofWbTTzoN3wz9NfznL9n4Dg/B
        90sBhmutayk/lIxEwqX6U4k=
X-Google-Smtp-Source: APXvYqzQpC4aLZcNmB7+pS57opovJp3kbrJxRuZRG2f9CISfAxiwIvf/tjLtNszRZUKk/r9pfawpvA==
X-Received: by 2002:ac8:25e7:: with SMTP id f36mr24084696qtf.139.1562767409534;
        Wed, 10 Jul 2019 07:03:29 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id r4sm1772193qta.93.2019.07.10.07.03.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 07:03:27 -0700 (PDT)
Subject: Re: [PATCH v1] drm/modes: Skip invalid cmdline mode
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20190709145151.23086-1-digetx@gmail.com>
 <20190710100000.GZ5942@intel.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <73d5dcd7-adef-8844-4e13-a68a0a5db98a@gmail.com>
Date:   Wed, 10 Jul 2019 17:03:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190710100000.GZ5942@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.07.2019 13:00, Ville Syrjälä пишет:
> On Tue, Jul 09, 2019 at 05:51:51PM +0300, Dmitry Osipenko wrote:
>> The named mode could be invalid and then cmdline parser misses to validate
>> mode's dimensions, happily adding 0x0 mode as a valid mode. One case where
>> this happens is NVIDIA Tegra devices that are using downstream bootloader
>> which adds "video=tegrafb" to the kernel's cmdline and thus upstream Tegra
>> DRM driver fails to probe because of the invalid mode.
>>
>> Fixes: 3aeeb13d8996 ("drm/modes: Support modes names on the command line")
> 
> Is that actually true? This problem has been in the code since forever AFAICS.

Yes, it's a problem now because named mode is marked as specified and
everything that do not match to a non-named mode is treated as named.

>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/gpu/drm/drm_client_modeset.c | 3 ++-
>>  drivers/gpu/drm/drm_modes.c          | 6 ++++++
>>  2 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
>> index e95fceac8f8b..56d36779d213 100644
>> --- a/drivers/gpu/drm/drm_client_modeset.c
>> +++ b/drivers/gpu/drm/drm_client_modeset.c
>> @@ -180,7 +180,8 @@ drm_connector_pick_cmdline_mode(struct drm_connector *connector)
>>  
>>  create_mode:
>>  	mode = drm_mode_create_from_cmdline_mode(connector->dev, cmdline_mode);
>> -	list_add(&mode->head, &connector->modes);
>> +	if (mode)
>> +		list_add(&mode->head, &connector->modes);
> 
> That's the same as what I did here
> https://patchwork.freedesktop.org/patch/309223/?series=61781&rev=1
> 
> But I'd have to rebase that so let's just go with your patch.
> 
>>  
>>  	return mode;
>>  }
>> diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
>> index 910561d4f071..74a5739df506 100644
>> --- a/drivers/gpu/drm/drm_modes.c
>> +++ b/drivers/gpu/drm/drm_modes.c
>> @@ -158,6 +158,9 @@ struct drm_display_mode *drm_cvt_mode(struct drm_device *dev, int hdisplay,
>>  	int interlace;
>>  	u64 tmp;
>>  
>> +	if (!hdisplay || !vdisplay)
>> +		return NULL;
>> +
>>  	/* allocate the drm_display_mode structure. If failure, we will
>>  	 * return directly
>>  	 */
>> @@ -392,6 +395,9 @@ drm_gtf_mode_complex(struct drm_device *dev, int hdisplay, int vdisplay,
>>  	int hsync, hfront_porch, vodd_front_porch_lines;
>>  	unsigned int tmp1, tmp2;
>>  
>> +	if (!hdisplay || !vdisplay)
>> +		return NULL;
>> +
> 
> These lgtm
> 
> Patch is
> Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

Thanks!

