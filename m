Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593BFC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 08:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C53E214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 08:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="S2FCcJGd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbfIRIny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 04:43:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39719 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbfIRInx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 04:43:53 -0400
Received: by mail-wr1-f67.google.com with SMTP id r3so5946701wrj.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 01:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:references:user-agent:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=Es/bmU3c9XGaRtzCiMLIVrPNjr9MNI0eTxg3xMnbUYc=;
        b=S2FCcJGdZtO1gO4SQHnOHraw90NxGk+ySbB9OIxE1vfxheAusATdTaw/syxuwdGWQI
         92sF2Nr9TgHxs7w9AuZJMkw35AR0EvurNbRLvbFBj0IhXv8+CtvAmZEn4/1JRD/sQl+7
         tNMt7J5QEAw5awSGxUcQ8/C/fS2112pJR0ilZf81yL8vBnGNaugVKY9xmUmAErDUp2Sh
         VlGTEU7rvD1DW5sD4FehEg9RXAfUKfdQ8YV5iBOpMAeohp1oWwhAsgleYcPMPeSmZEgO
         sl+eIrDHwIH3Ei22m0zaGRvVaJHEvtf5PLgIY9dlvf0pyHhxZ0Kxb/8q3jOurf9y3lOh
         +X0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:user-agent:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=Es/bmU3c9XGaRtzCiMLIVrPNjr9MNI0eTxg3xMnbUYc=;
        b=NJVVo16RGh+/E4YsYRLkNMQIE/i5TeRzv/wq4kLwt2ru7SShjNcFwWYCyEoQRnAOxY
         g8HnuIty+2CU+w8OrD57BsHw9gxl94rGx7rtJM8+TJESK37/yG1rgrMQH8Aw+lGrPEaL
         u3SQA4oH99DmigdiJc7CI8RVSdAWYjU6aRy/7NDF9SKPJzEriIo7ZyX27RUv3lSEFgSI
         M0RFKL5IX8gwWe4OizxQwUn0ZTpyTd+ICYD4h6Lg8/5h43TpdS6IqeTi/p/f3Jqsni5c
         sUHUuhQ6CblNcb1OWde3xJ/rFS4RH2zQwR76GICg+tAFt8LtRFqGVpXgDfEUst7Jy2FW
         3kYg==
X-Gm-Message-State: APjAAAWEkU4bn+Gq/Jrgz+mfdlqAr7LXKV2Un/uZC9X6VSW28QXZYxnr
        ncuYJXlM7XWi0rRluzvlthWW/A==
X-Google-Smtp-Source: APXvYqz3Kpju44v9NdaCUS71dFKfNZ3q3V7oya0OqrnOC9uxnDdFSkv5zrOWWA/QCE/CJM9pIPUidg==
X-Received: by 2002:a5d:52c8:: with SMTP id r8mr2192409wrv.256.1568796231510;
        Wed, 18 Sep 2019 01:43:51 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q10sm9774982wrd.39.2019.09.18.01.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 01:43:50 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
X-Google-Original-From: Jerome Brunet <jbrunet@starbuckisacylon.baylibre.com>
References: <20190918082500.209281-1-cychiang@chromium.org> <20190918082500.209281-3-cychiang@chromium.org>
User-agent: mu4e 1.3.1; emacs 26.2
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v6 2/4] drm: dw-hdmi-i2s: Use fixed id for codec device
In-reply-to: <20190918082500.209281-3-cychiang@chromium.org>
Date:   Wed, 18 Sep 2019 10:43:49 +0200
Message-ID: <1j7e663sfu.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 18 Sep 2019 at 10:24, Cheng-Yi Chiang <cychiang@chromium.org> wrote:

> The problem of using auto ID is that the device name will be like
> hdmi-audio-codec.<id number>.auto.
>
> The number might be changed when there are other platform devices being
> created before hdmi-audio-codec device.
> Use a fixed name so machine driver can set codec name on the DAI link.
>
> Using the fixed name should be fine because there will only be one
> hdmi-audio-codec device.

While this is true all platforms we know of (I suppose), It might not be
the case later on. I wonder if making such assumption is really
desirable in a code which is used by quite a few different platforms.

Instead of trying to predict what the device name will be, can't you just
query it in your machine driver ? Using a device tree phandle maybe ?

It is quite usual to set the dai links this way, "simple-card" is a good
example of this.

>
> Fix the codec name in rockchip rk3288_hdmi_analog machine driver.
>
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c | 2 +-
>  sound/soc/rockchip/rk3288_hdmi_analog.c             | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> index d7e65c869415..86bd482b9f94 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> @@ -193,7 +193,7 @@ static int snd_dw_hdmi_probe(struct platform_device *pdev)
>  
>  	memset(&pdevinfo, 0, sizeof(pdevinfo));
>  	pdevinfo.parent		= pdev->dev.parent;
> -	pdevinfo.id		= PLATFORM_DEVID_AUTO;
> +	pdevinfo.id		= PLATFORM_DEVID_NONE;
>  	pdevinfo.name		= HDMI_CODEC_DRV_NAME;
>  	pdevinfo.data		= &pdata;
>  	pdevinfo.size_data	= sizeof(pdata);
> diff --git a/sound/soc/rockchip/rk3288_hdmi_analog.c b/sound/soc/rockchip/rk3288_hdmi_analog.c
> index 767700c34ee2..8286025a8747 100644
> --- a/sound/soc/rockchip/rk3288_hdmi_analog.c
> +++ b/sound/soc/rockchip/rk3288_hdmi_analog.c
> @@ -15,6 +15,7 @@
>  #include <linux/gpio.h>
>  #include <linux/of_gpio.h>
>  #include <sound/core.h>
> +#include <sound/hdmi-codec.h>
>  #include <sound/jack.h>
>  #include <sound/pcm.h>
>  #include <sound/pcm_params.h>
> @@ -142,7 +143,7 @@ static const struct snd_soc_ops rk_ops = {
>  SND_SOC_DAILINK_DEFS(audio,
>  	DAILINK_COMP_ARRAY(COMP_EMPTY()),
>  	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, NULL),
> -			   COMP_CODEC("hdmi-audio-codec.2.auto", "i2s-hifi")),
> +			   COMP_CODEC(HDMI_CODEC_DRV_NAME, "i2s-hifi")),
>  	DAILINK_COMP_ARRAY(COMP_EMPTY()));
>  
>  static struct snd_soc_dai_link rk_dailink = {

