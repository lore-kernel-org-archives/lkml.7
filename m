Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0247CC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 08:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B72C420882
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 08:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0oGM72JH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbfIRIGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 04:06:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45124 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfIRIGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 04:06:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id r5so5764307wrm.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 01:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mkevZOJdirTQP4xQqxJPu+cG5U0Qi6JXJ58oWHiS7jY=;
        b=0oGM72JHBtj4SsrDd+/66QL5WNll1jKgjfuLpSku4r/zFsJb0VR6RPCtmSS7Hzlred
         CLBL75OrUE1z/phSaz4xYbd9r2r19ej6q17CJ6ihZHLHhBMQHLlytDh4DgmtdCjcuBbn
         ifMMud+XjN2goxdpJ2IBvu0y0E8Ig2eZF+GtDMXonGfHO2MljBcFHDSRabBByFC6ebSO
         orfPFczsp4a9d9AUH4uapBEpJ0RyaK1bCzs/Vc6DZkN9uqapU8H4gFRGrln0n9BxruZM
         uG2QC7Oeug6eLsQQze9RFNTD3GdGkljgdDQNmNlECAIVsa+VJJ//lezYdBLhGp4CeP9N
         gJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mkevZOJdirTQP4xQqxJPu+cG5U0Qi6JXJ58oWHiS7jY=;
        b=U7DiyspwLPlutiGpS97WrHC1O5GoVIx7cXVMLAQ4dtsmAdsNE4vHy4E5SbDYfILV4R
         TUMCmlYNmaV288BHJsbXyKqKiSDLd7lD+od0TNvuMr5YfX2lqc1EZXsSI0NWeJEjSL/u
         PSSRw98VfQCS6vSIfHDT3u3SbkYHCN5968oOPeoLaaiUqodlEPk7u3W3NKbW9Lof5GJl
         Vkw8ueabHd9FJPrXJ2G/4SUW1RRKaJ+E7uBTlZUscjkXChEW0w534MAyl8dcHqhByD4h
         U4bnjnU7A7ShXlx3PYXgeQsFO55w5UMSGPLTB4dwrl+IVDuSD0eANloaQffmjzQ4I6XN
         dOVw==
X-Gm-Message-State: APjAAAUAnvqcaLJ73AtaqBn0vrh+f5a+2UD4uo72KBvbKdVIUTY8w9Qc
        08A9wymZTAHjA/XuRFyL3LLsCQvdSoaJ0w==
X-Google-Smtp-Source: APXvYqzf+jbiZIZY04a4tatGEYB10DwI4zcoZXZbfMN4ghff6iEVlZJZSSKlnXoFJ1ga6yb2zAh6Dw==
X-Received: by 2002:adf:e603:: with SMTP id p3mr1876527wrm.102.1568793957886;
        Wed, 18 Sep 2019 01:05:57 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e20sm7998269wrc.34.2019.09.18.01.05.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2019 01:05:57 -0700 (PDT)
Subject: Re: [PATCH 0/4] drm/bridge: dw-hdmi: Add support for HDR metadata
To:     Jonas Karlman <jonas@kwiboo.se>,
        "a.hajda@samsung.com" <a.hajda@samsung.com>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>
Cc:     "jernej.skrabec@siol.net" <jernej.skrabec@siol.net>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "zhengyang@rock-chips.com" <zhengyang@rock-chips.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "wens@csie.org" <wens@csie.org>,
        "hjc@rock-chips.com" <hjc@rock-chips.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <VI1PR03MB420621617DDEAB3596700DE0AC1C0@VI1PR03MB4206.eurprd03.prod.outlook.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <4bfa909e-eff1-1514-48f0-c5cd9bb612b9@baylibre.com>
Date:   Wed, 18 Sep 2019 10:05:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <VI1PR03MB420621617DDEAB3596700DE0AC1C0@VI1PR03MB4206.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonas,

On 26/05/2019 23:18, Jonas Karlman wrote:
> Add support for HDR metadata using the hdr_output_metadata connector property,
> configure Dynamic Range and Mastering InfoFrame accordingly.
> 
> A drm_infoframe flag is added to dw_hdmi_plat_data that platform drivers
> can use to signal when Dynamic Range and Mastering infoframes is supported.
> This flag is needed because Amlogic GXBB and GXL report same DW-HDMI version,
> and only GXL support DRM InfoFrame.
> 
> The first patch add functionality to configure DRM InfoFrame based on the
> hdr_output_metadata connector property.
> 
> The remaining patches sets the drm_infoframe flag on some SoCs supporting
> Dynamic Range and Mastering InfoFrame.
> 
> Note that this was based on top of drm-misc-next and Neil Armstrong's
> "drm/meson: Add support for HDMI2.0 YUV420 4k60" series at [1]

Do you plan to resend this serie ?

The "drm/meson: Add support for HDMI2.0 YUV420 4k60" serie is no more
valid with the format negociation work from boris, so you should rebase
on drm-misc-next !

Thanks,

Neil

> 
> [1] https://patchwork.freedesktop.org/series/58725/#rev2
> 
> Jonas Karlman (4):
>   drm/bridge: dw-hdmi: Add Dynamic Range and Mastering InfoFrame support
>   drm/rockchip: Enable DRM InfoFrame support on RK3328 and RK3399
>   drm/meson: Enable DRM InfoFrame support on GXL, GXM and G12A
>   drm/sun4i: Enable DRM InfoFrame support on H6
> 
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c   | 109 ++++++++++++++++++++
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.h   |  37 +++++++
>  drivers/gpu/drm/meson/meson_dw_hdmi.c       |   5 +
>  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c |   2 +
>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c       |   2 +
>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h       |   1 +
>  include/drm/bridge/dw_hdmi.h                |   1 +
>  7 files changed, 157 insertions(+)
> 

