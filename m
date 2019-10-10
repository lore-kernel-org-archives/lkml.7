Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A22DC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 11:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE69208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 11:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qDTO3/w7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733103AbfJJL7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 07:59:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34849 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfJJL7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 07:59:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id v8so7553226wrt.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 04:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=PJZr84+VWbsWIjXLii4Or5cL9nSL6s5rcELJwr9d/D8=;
        b=qDTO3/w7ASqdBzyV4GajpJuGZ28qdRHgYPKhSjEgbMiHbLJC3tZTDI4JGjITkaxRNd
         xD9EbXNQM+OLe2ovF1r+3hKPBRHauMaspkKTjtZdFU8E/uDhUeqx9IboqUxioIU8Kbsb
         um5bvQ1szFJA1MNTN3cLHWBhEeZ5LW0ZIYMMwQwkdsM7+T6nhLJ0aGVNi+Xqkl47sv5t
         lxuEOOJeUXyj1LgWtMzawugA0HNRL2uXFkTlJoMRn44+zcmw1FiTEyVga3nVZRHMy0gT
         cgiqkozTZCdJkgto1xOB/fvZLL9buk9REPJu9VQuuSIsHASeAhvEuf/NZhY/QOHm1tnP
         nIvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=PJZr84+VWbsWIjXLii4Or5cL9nSL6s5rcELJwr9d/D8=;
        b=A4FQJnVJjO/rSRCNyQR3zH9HTLlOJ+Du+lys7q1cgpqrrez0wYLSFFZQcre6W64c6d
         /6hLXh5XmePoCdt9ESnkPi/4RHho0NIp6n720VpJcGA0nqn3M8/Evr/bhGSu87M5qOvc
         GMv657+veM/Sdd+Km0EolWwOPq2HwgxUs3qXiraHnyjEP3MFcAY8od9bCMikU816976V
         yWyeRkK1c1ZhqXaZj5f10CLCuBPEZ1TwkqUU4rtSSxGdr1L1u61CzDF+MOZqWixHY/N6
         HXdPo41uH7lykNVrclk8UB+iezErtJfI5d9UJnAlg1MMr6oriMQoXBEpNCvEmD8uB33y
         0mZA==
X-Gm-Message-State: APjAAAXQHWyqmpVUPRWTeAqSzYjHyqFukVbEJEbiL+DuyaqAaQnPcXoh
        rMhHII48eL2CfkCmzpEtgwkvHh41Zge6Qw==
X-Google-Smtp-Source: APXvYqyWiaeO/zLQuFUGupvyPhy9Um/jfOMVPRooKc1FIiqgVcdz4J3ZYRzJTzUnlAV7FTuxANrASA==
X-Received: by 2002:a5d:514c:: with SMTP id u12mr8225996wrt.147.1570708776846;
        Thu, 10 Oct 2019 04:59:36 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e17sm4257938wma.15.2019.10.10.04.59.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 04:59:36 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] drm/bridge: dw-hdmi: Add support for HDR metadata
To:     Jonas Karlman <jonas@kwiboo.se>,
        Andrzej Hajda <a.hajda@samsung.com>
Cc:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Kevin Hilman <khilman@baylibre.com>,
        Sandy Huang <hjc@rock-chips.com>,
        Heiko Stubner <heiko@sntech.de>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        "zhengyang@rock-chips.com" <zhengyang@rock-chips.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <HE1PR06MB401113BF395C06E96503344FAC9B0@HE1PR06MB4011.eurprd06.prod.outlook.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <8aa67433-d956-4faf-f038-b6b365349ac0@baylibre.com>
Date:   Thu, 10 Oct 2019 13:59:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <HE1PR06MB401113BF395C06E96503344FAC9B0@HE1PR06MB4011.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2019 21:19, Jonas Karlman wrote:
> Add support for HDR metadata using the hdr_output_metadata connector property,
> configure Dynamic Range and Mastering InfoFrame accordingly.
> 
> A use_drm_infoframe flag is added to dw_hdmi_plat_data that platform drivers
> can use to signal when Dynamic Range and Mastering infoframes is supported.
> This flag is needed because Amlogic GXBB and GXL report same DW-HDMI version,
> and only GXL support DRM InfoFrame.
> 
> The first patch add functionality to configure DRM InfoFrame based on the
> hdr_output_metadata connector property.
> 
> The remaining patches sets the use_drm_infoframe flag on some SoCs supporting
> Dynamic Range and Mastering InfoFrame.
> 
> v2 has been runtime tested on a Rock64 (RK3328) and Rock Pi 4 (RK3399),
> only build tested for Amlogic and Allwinner.
> 
> Changes in v2:
>   * address comments from Andrzej Hajda
>   - renamed blob_equal to hdr_metadata_equal
>   - renamed drm_infoframe flag to use_drm_infoframe
>   - use hdmi_drm_infoframe_pack and a loop to write regs
>   - remove hdmi version check in hdmi_config_drm_infoframe
> 
> Jonas Karlman (4):
>   drm/bridge: dw-hdmi: Add Dynamic Range and Mastering InfoFrame support
>   drm/rockchip: Enable DRM InfoFrame support on RK3328 and RK3399
>   drm/meson: Enable DRM InfoFrame support on GXL, GXM and G12A
>   drm/sun4i: Enable DRM InfoFrame support on H6
> 
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c   | 81 +++++++++++++++++++++
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.h   | 37 ++++++++++
>  drivers/gpu/drm/meson/meson_dw_hdmi.c       |  5 ++
>  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c |  2 +
>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c       |  2 +
>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h       |  1 +
>  include/drm/bridge/dw_hdmi.h                |  1 +
>  7 files changed, 129 insertions(+)
> 

Applied to drm-misc-next,

Thanks,
Neil
