Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97307C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FE1220693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="UJrbJpse"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbfG3Mr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 08:47:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38452 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729182AbfG3MrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 08:47:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id g17so65639476wrr.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 05:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=bSZz5mC3NL+jHfLKKOC1rysQgaaHT/7HL4y8TM1Gf0Y=;
        b=UJrbJpseCW7M3SiKvNHufHErf5cAuofn9rXHSh3Na43P2tFFgOQtrE0fFT+3OqFT4R
         a2yhrnU3b+xjMs28/X6sMwTNJqFZ653L5ovAE5573zXtySJNNKmA071uWTc8NX/vTmIz
         S9JRYy0MSl6SZhHp/lgsQykwM0yggpSi2Cbtic4p7W5U0K93IbJXJUhZnB3XEp7NInz8
         j6/4Qb9/3fpL/djrCvGyfaThrDPoeqGMqPkFjzETMBqRy5HSO0gbA7WtBSLltGlaDJtk
         MWiIxDoJRc7AeAzdH1BgifRk3/i40iX6DdobuK6bkSitRDnzrV1JhXTKlkMtxW7bEcq0
         ahMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=bSZz5mC3NL+jHfLKKOC1rysQgaaHT/7HL4y8TM1Gf0Y=;
        b=Xj4uW8xT6NSiI9zCuh/3PLq9Vo48sz2MnxBOXCdh3gBxE6bNGhS8OFUdgJhcuyNNV7
         uETGIc7JYxessiDmOd5r3VAbY1uHwgR7qir0zo4pdzRy0sPMR2yEx/XQ4wcJUnMq2IF2
         kD2fdepXVts1FyaJzkJU0yjqQt/YIW15JsHMFnoR64Vu3zLyPUdh0csPjCFj9Yp5GYdz
         VGK+OZdk7WQC943BHTmbaJAah8FNNxYWd1igVQGguuDI5Kg9szt2cGIgykxrgvET8KlS
         YAowxPiLJmXnlfG0WLKtdoRAVvcYDo0t4dnnRugezgj4iXoNbgE4+OtxvvOfLKiYjlGE
         uZIw==
X-Gm-Message-State: APjAAAXpLgqYa7ztv5gIq/kK33klx1j9X7zmT+fNY9RNT9vnny4SMcI+
        gRHiVb+HBve3ABf6B+33/GwkMA==
X-Google-Smtp-Source: APXvYqztp0DW4bHGPitSybEzR6Ftpra1waSwNBm/c6gr00vdvWh5rRHHJpg2/3fYgqiBCZH1F7rc2Q==
X-Received: by 2002:a5d:54c7:: with SMTP id x7mr98320238wrv.39.1564490842732;
        Tue, 30 Jul 2019 05:47:22 -0700 (PDT)
Received: from [10.1.3.173] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s2sm52300196wmj.33.2019.07.30.05.47.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 05:47:22 -0700 (PDT)
Subject: Re: [PATCH] drm/bridge: tc358764: Fix build error
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     YueHaibing <yuehaibing@huawei.com>, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20190729090520.25968-1-yuehaibing@huawei.com>
 <a7fb2600-2add-8769-f8dc-6679680974c1@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <bc3fab4a-8fb2-f800-1ec7-5a98700b52d9@baylibre.com>
Date:   Tue, 30 Jul 2019 14:47:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a7fb2600-2add-8769-f8dc-6679680974c1@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2019 14:32, Neil Armstrong wrote:
> On 29/07/2019 11:05, YueHaibing wrote:
>> If CONFIG_DRM_TOSHIBA_TC358764=y but CONFIG_DRM_KMS_HELPER=m,
>> building fails:
>>
>> drivers/gpu/drm/bridge/tc358764.o:(.rodata+0x228): undefined reference to `drm_atomic_helper_connector_reset'
>> drivers/gpu/drm/bridge/tc358764.o:(.rodata+0x240): undefined reference to `drm_helper_probe_single_connector_modes'
>> drivers/gpu/drm/bridge/tc358764.o:(.rodata+0x268): undefined reference to `drm_atomic_helper_connector_duplicate_state'
>> drivers/gpu/drm/bridge/tc358764.o:(.rodata+0x270): undefined reference to `drm_atomic_helper_connector_destroy_state'
>>
>> Like TC358767, select DRM_KMS_HELPER to fix this, and
>> change to select DRM_PANEL to avoid recursive dependency.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Fixes: f38b7cca6d0e ("drm/bridge: tc358764: Add DSI to LVDS bridge driver")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/gpu/drm/bridge/Kconfig | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
>> index a6eec90..323f72d 100644
>> --- a/drivers/gpu/drm/bridge/Kconfig
>> +++ b/drivers/gpu/drm/bridge/Kconfig
>> @@ -116,9 +116,10 @@ config DRM_THINE_THC63LVD1024
>>  
>>  config DRM_TOSHIBA_TC358764
>>  	tristate "TC358764 DSI/LVDS bridge"
>> -	depends on DRM && DRM_PANEL
>>  	depends on OF
>>  	select DRM_MIPI_DSI
>> +	select DRM_KMS_HELPER
>> +	select DRM_PANEL
>>  	help
>>  	  Toshiba TC358764 DSI/LVDS bridge driver.
>>  
>>
> 
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> 

Applying to drm-misc-fixes

Thanks,
Neil
