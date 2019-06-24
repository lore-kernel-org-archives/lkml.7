Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A5CC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 08:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 978FE208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 08:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TByelL3R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfFXITj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 04:19:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35640 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfFXITi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 04:19:38 -0400
Received: by mail-wm1-f66.google.com with SMTP id c6so12364097wml.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 01:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:openpgp:autocrypt:organization:cc
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BDUDJmmYI2Pab9tzc7MP465gaAGDUdW/YMr7922hE4A=;
        b=TByelL3RukIzsJZIz/BprSVoRLQjs4xqaX3VNLsdyOismzivNCq8P06VGIAVc1izHe
         w4cDc9Q0zSHgAL67iz3W6hlNZnuYCbkPLrAAacre14jPZQLM0C+pdnBhyE6bdfmvKylz
         MGT7jcyZBotrsrHhvcwi3eJ8x5RQhedZ4LqgLj66g1FlIq56x+GYaJnaxRyQvh5Hgf+F
         y6Sad8IryCxb1gQQMUSqQSy6lpLbycnXqwgJwhoiXHtcnG1Mk3jfX19HI42hRzH87fXt
         9tk53EisVq+VG4kdbAjBkBO4RBIczcOBRrmXZdsADvLqvPDs86qHqwk+pWHKwhWp7Z4+
         WDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :organization:cc:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BDUDJmmYI2Pab9tzc7MP465gaAGDUdW/YMr7922hE4A=;
        b=tUA6P0abNThZTXmHmXaHP4KuqiKFIMJw2rDGoJfmKqo434W4rfxW7qDwi1HmqzWytC
         8fPPDpUBPQathHgqgAUMkLwqtyfDHlOW0heMw1noI++gMG8bYPqNnOZiC2wb7HdtUmjl
         lLDEl8f7FYEhf8uaHRrACeVQa9ezTCFrQatAGSixjM9vemkOOaOVJV2DeKJUuP0UAwaI
         e6ONeh2gSFfnZKikUm5yNy1IEFMj9HqHzZ+35apHK4wyuZ5ea5ffBhtpCn9sMm4gNcg7
         evs5VqZR2uaMgdRBDAR0+yXZD2gl17HWpxuZlq2Lu6MfHwo7CYOUOmE+OBDluxDEXH4n
         6WMQ==
X-Gm-Message-State: APjAAAU+DRnRyrAis/8v2FwihjtqoBI76oJX42d0ULFS6NfdAmrRI+1J
        TLHWDchT7NrlJkrnA0rAPAM/4A==
X-Google-Smtp-Source: APXvYqx0r6B0Y660N/siL1L3zCL5qGI3XMl9b5fx/kUtv0nUGUfkLA/hOmCfzp3uDlUAHSyJZhPpjw==
X-Received: by 2002:a1c:343:: with SMTP id 64mr15435364wmd.116.1561364375664;
        Mon, 24 Jun 2019 01:19:35 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h6sm7035422wre.82.2019.06.24.01.19.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 01:19:35 -0700 (PDT)
Subject: Re: [PATCH 0/4] drm/bridge: dw-hdmi: Add support for HDR metadata
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        "a.hajda@samsung.com" <a.hajda@samsung.com>,
        "jernej.skrabec@siol.net" <jernej.skrabec@siol.net>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Jernej Skrabec@siol.net" <jernej.skrabec@siol.net>
References: <VI1PR03MB420621617DDEAB3596700DE0AC1C0@VI1PR03MB4206.eurprd03.prod.outlook.com>
 <085dc3be-20e5-b2fe-4c02-bf4a4d1473da@baylibre.com>
 <20190621090125.GX12905@phenom.ffwll.local>
 <20190623233017.GI6124@pendragon.ideasonboard.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Cc:     "khilman@baylibre.com" <khilman@baylibre.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wens@csie.org" <wens@csie.org>,
        "zhengyang@rock-chips.com" <zhengyang@rock-chips.com>
Message-ID: <58243243-fbd8-e67b-a050-baa9757be43e@baylibre.com>
Date:   Mon, 24 Jun 2019 10:19:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190623233017.GI6124@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel, Laurent, Andrzej,

On 24/06/2019 01:30, Laurent Pinchart wrote:
> On Fri, Jun 21, 2019 at 11:01:25AM +0200, Daniel Vetter wrote:
>> On Thu, Jun 20, 2019 at 04:40:12PM +0200, Neil Armstrong wrote:
>>> Hi Andrzej,
>>>
>>> Gentle ping, could you review the dw-hdmi changes here ?
>>
>> btw not sure you absolutely need review from Andrzej, we're currently a
>> bit undersupplied with bridge reviewers I think ... Better to ramp up
>> more.
> 
> I try to review DRM bridge patches when possible, but dw-hdmi is a
> special case. I was told by the supplier of an SoC datasheet that
> contains the HDMI encoder IP core documentation that Synopsys required
> them to route all contributions made based on that documentation through
> Synopsys' internal legal review before publishing them. I thus decided
> to not contribute to the driver anymore, at least for areas that require
> access to documentation.

I'd like to propose myself as co-maintainer of the DRM bridge subsystem if
everybody agrees, following the excellent work Laurent and Andrzej did.
I have a very little knowledge of DSI, & other bridge drivers, but I'll do
my best.

For the dw-hdmi driver, we have a big roadmap including :
- HDR (this patchset)
- HDCP 1/2
- YUV420, YUV422, YUV44, 10bit/12bit/16bit HDMI output
- Enhanced audio support and ELD notification to ASoC
...

Having a more active maintainer/reviewer team would be needed, at least for
the dw-hdmi bridge.

I'll also propose Jonas Karlman <jonas@kwiboo.se> as reviewer since he is very
active for the multimedia support on RockChip, Allwinner and Amlogic SoCs.
I'll also propose Jernej Skrabec@siol.net <jernej.skrabec@siol.net>, if he wants,
as reviewer since he is very active on the Allwinner SoCs side.

Neil

> 
>>> On 26/05/2019 23:18, Jonas Karlman wrote:
>>>> Add support for HDR metadata using the hdr_output_metadata connector property,
>>>> configure Dynamic Range and Mastering InfoFrame accordingly.
>>>>
>>>> A drm_infoframe flag is added to dw_hdmi_plat_data that platform drivers
>>>> can use to signal when Dynamic Range and Mastering infoframes is supported.
>>>> This flag is needed because Amlogic GXBB and GXL report same DW-HDMI version,
>>>> and only GXL support DRM InfoFrame.
>>>>
>>>> The first patch add functionality to configure DRM InfoFrame based on the
>>>> hdr_output_metadata connector property.
>>>>
>>>> The remaining patches sets the drm_infoframe flag on some SoCs supporting
>>>> Dynamic Range and Mastering InfoFrame.
>>>>
>>>> Note that this was based on top of drm-misc-next and Neil Armstrong's
>>>> "drm/meson: Add support for HDMI2.0 YUV420 4k60" series at [1]
>>>>
>>>> [1] https://patchwork.freedesktop.org/series/58725/#rev2
>>>>
>>>> Jonas Karlman (4):
>>>>   drm/bridge: dw-hdmi: Add Dynamic Range and Mastering InfoFrame support
>>>>   drm/rockchip: Enable DRM InfoFrame support on RK3328 and RK3399
>>>>   drm/meson: Enable DRM InfoFrame support on GXL, GXM and G12A
>>>>   drm/sun4i: Enable DRM InfoFrame support on H6
>>>>
>>>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c   | 109 ++++++++++++++++++++
>>>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.h   |  37 +++++++
>>>>  drivers/gpu/drm/meson/meson_dw_hdmi.c       |   5 +
>>>>  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c |   2 +
>>>>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c       |   2 +
>>>>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h       |   1 +
>>>>  include/drm/bridge/dw_hdmi.h                |   1 +
>>>>  7 files changed, 157 insertions(+)
> 

