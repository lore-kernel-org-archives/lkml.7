Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D506DC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 12:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0B020684
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 12:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="yaFsxj8c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfFEM71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 08:59:27 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36164 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbfFEM71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 08:59:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id u8so510386wmm.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 05:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+hIy5lz3bZE6/4kzO9THbc36Q37XAualXeaWZ2EfADA=;
        b=yaFsxj8cVltdMdMOm4VNDMwGqqVbV6ErdfwbnPTJBtqUaQbZD8Im/B8ofS6ylkFu7F
         BAIdnPGR73fkkg7hvy9dBA0QI3PsYzJim/+FaSnIfBnV7ImTnlwP/aa+D6ETrRebMYum
         p7N9/qJHNLmRQYu+uouQbI7SQy7VJ5WUFg6YuZDTPj2LBRoWtp9mGfKyXxoYn339p5B2
         MrYkChuKavCyNmLZiiPSbNWr7BG8/3f/6sAiRP6uvJRug3iW2uU4JOnz+wA1n9tjU1Py
         edH4RlRkFUUziKsl3PAiYw52XGeU3rCJCc4m3MRiCfkVcBbubQNZ+OFCcnQeoWfFWwNs
         2YQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+hIy5lz3bZE6/4kzO9THbc36Q37XAualXeaWZ2EfADA=;
        b=RUOTkTw6DB06425uBorvwgaskmsl7Ww9EyKtkfUHu7XeakttLQ/nZVoYyIJAlFcSl+
         3uf9LDxySvMAr0ovAk4063rkxEEKBbHp1k6zm+J5xf1Wl+hBSTp1l67bkee1pWBGdPX4
         Be/jgz5qwrVuVaaw+GN1hzINtZDbpT4EvXZVY4NHoENvgQhL+3DEy2Q3HsBoxz5TQiU8
         lgdOx5WR9t8dcNuQd27y4HoUe428raMGoINP/8UReLKDKtavp4w8N5b8Oi/ioz86C0V4
         ll8QVMJAjYLwjAGD5HyzpLe6oU1vA2mbLGffZjr7bI/8HAWvscwA5HsMB0tt4py2JWG3
         GGNw==
X-Gm-Message-State: APjAAAU6B01IlBfK725ZMZXLMC/uXANTDNj0Uo1WiHbwTSTrazEvUg8N
        P6DVx0YeBlYuLkx4RgpxekAU6XNgBjuzDg==
X-Google-Smtp-Source: APXvYqwdZDOCXe1vp00morQ7HQ4vgg8AuSLfNqYZs+v50KZbkBiR5LoZf5WJovfE26zO7Cz702XaOA==
X-Received: by 2002:a05:600c:c4:: with SMTP id u4mr10619368wmm.96.1559739564243;
        Wed, 05 Jun 2019 05:59:24 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e7sm3610569wmd.0.2019.06.05.05.59.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 05:59:23 -0700 (PDT)
Subject: Re: [PATCH 1/5] drm/bridge: dw-hdmi: allow ycbcr420 modes for >=
 0x200a
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent.pinchart@ideasonboard.com
Cc:     jonas@kwiboo.se, hverkuil@xs4all.nl,
        dri-devel@lists.freedesktop.org, jernej.skrabec@siol.net,
        heiko@sntech.de, maxime.ripard@bootlin.com, hjc@rock-chips.com,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190520133753.23871-1-narmstrong@baylibre.com>
 <CGME20190520133802epcas3p3e8d19d3c79e027362ac1e4cc3c09c10f@epcas3p3.samsung.com>
 <20190520133753.23871-2-narmstrong@baylibre.com>
 <020c82bc-15fd-6e23-a093-62abfa9b466d@samsung.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <956ecdbd-2ea3-6dc9-d2fa-dbba797dddc0@baylibre.com>
Date:   Wed, 5 Jun 2019 14:59:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <020c82bc-15fd-6e23-a093-62abfa9b466d@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/2019 08:07, Andrzej Hajda wrote:
> On 20.05.2019 15:37, Neil Armstrong wrote:
>> Now the DW-HDMI Controller supports the HDMI2.0 modes, enable support
>> for these modes in the connector if the platform supports them.
>> We limit these modes to DW-HDMI IP version >= 0x200a which
>> are designed to support HDMI2.0 display modes.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> Tested-by: Heiko Stuebner <heiko@sntech.de>
>> ---
>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 6 ++++++
>>  include/drm/bridge/dw_hdmi.h              | 1 +
>>  2 files changed, 7 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> index ab7968c8f6a2..b50c49caf7ae 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> @@ -2629,6 +2629,12 @@ __dw_hdmi_probe(struct platform_device *pdev,
>>  	if (hdmi->phy.ops->setup_hpd)
>>  		hdmi->phy.ops->setup_hpd(hdmi, hdmi->phy.data);
>>  
>> +	if (hdmi->version >= 0x200a)
>> +		hdmi->connector.ycbcr_420_allowed =
>> +			hdmi->plat_data->ycbcr_420_allowed;
>> +	else
>> +		hdmi->connector.ycbcr_420_allowed = false;
>> +
> 
> 
> I suspect else clause can be dropped.

You are right, thanks for the review.

Do you have comments on the patches 2, 3 & 4 of serie ?

Thanks,
Neil

> 
> Beside this:
> 
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> 
>  --
> Regards
> Andrzej
> 
> 
>>  	memset(&pdevinfo, 0, sizeof(pdevinfo));
>>  	pdevinfo.parent = dev;
>>  	pdevinfo.id = PLATFORM_DEVID_AUTO;
>> diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
>> index 66e70770cce5..0f0e82638fbe 100644
>> --- a/include/drm/bridge/dw_hdmi.h
>> +++ b/include/drm/bridge/dw_hdmi.h
>> @@ -130,6 +130,7 @@ struct dw_hdmi_plat_data {
>>  					   const struct drm_display_mode *mode);
>>  	unsigned long input_bus_format;
>>  	unsigned long input_bus_encoding;
>> +	bool ycbcr_420_allowed;
>>  
>>  	/* Vendor PHY support */
>>  	const struct dw_hdmi_phy_ops *phy_ops;
> 
> 

