Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F18BC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 014E220663
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1xCaqXat"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfDIInL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 04:43:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32859 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfDIInL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 04:43:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id q1so19763531wrp.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 01:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=KAZxw+3mOFVwbslpEdHkWVoUlhDM2ubwqAkMagRw97E=;
        b=1xCaqXatmKFPyJXfGBXDjJ1e1XWRSLnrb7VpGmKew7uBjpdMfNqUXEl7LwDTrjaUti
         RVEMEKu8kWtxYo2CGPfC1nWYAgCCsjMUku1ZB4eoLy/E0QyjNvY1nR3J7aFK8Qwvuxlz
         Z0r07xADbQdYJbBfpYoZ30U8AX2//zyGw1969wj/GOwzx/vcHMR7KU4RCBySA2OWqMFr
         RdeZENQzMybkSYGRQQ3g6CxF/BFrturs3B1zNjHLgysLkEJwqbi5OulnSjw5SoHPGQxo
         mRMYHeVbrTGRrEjLt1KMqilQjsMGqgmtd2DWN2D+cKOcqkJBCPRiqGy+egyGopAT9ejS
         BAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=KAZxw+3mOFVwbslpEdHkWVoUlhDM2ubwqAkMagRw97E=;
        b=EWyi6xDecqBW3ADwgNj3cKQWpWZJFX7ZBAWqfAJA+IuHtP52zy/k2z8afN4pagt55C
         kZ7ZhqjxDp7TdbUvTkaRQ9yOruTHTnkMG5S1WlnUjB0qlmxe74Ow1TUPkL1XZYHysSvw
         i7L+bbHEpCpERmtOR2zgM1H8OC/LAsIRYeohonI3TaGHu7KTAsF/bZty60+Nyhl2F0a0
         2OjrcVepUNMA+VcUd3Hafn/RrfF7e6MQ6d5MBltiCcV6l1iY+3POZ4u7NlDy0rlqJR5z
         ts6qsxH2REXFVs/FurCJnBRwOkoMrEQi1hZnVs1h/5Eg4GcaPskyWWYFr5X8Ly0w1vs+
         UgvQ==
X-Gm-Message-State: APjAAAXusM9y5MxNuhhQ4oejqgoNoa63or/idLfeo/46UMuZvuNpo1sF
        YKs78NcgsnqYfYNmWAzo9pusTA==
X-Google-Smtp-Source: APXvYqyVVNJbXKW6iCvbL43NrgEMaRl3RcrJGfAs90s9HE81BilJhEohbQ/3sGcGn5RWjXClnLZ37Q==
X-Received: by 2002:adf:f78c:: with SMTP id q12mr450173wrp.172.1554799388599;
        Tue, 09 Apr 2019 01:43:08 -0700 (PDT)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id c20sm60034366wre.28.2019.04.09.01.43.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Apr 2019 01:43:07 -0700 (PDT)
Message-ID: <e5199bf4ff4a125414a8843ab4be0eb641ac5d91.camel@baylibre.com>
Subject: Re: [PATCH 08/11] drm/meson: Add G12A support for CVBS Encoer
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 09 Apr 2019 10:43:06 +0200
In-Reply-To: <20190325141824.21259-9-narmstrong@baylibre.com>
References: <20190325141824.21259-1-narmstrong@baylibre.com>
         <20190325141824.21259-9-narmstrong@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-25 at 15:18 +0100, Neil Armstrong wrote:
> The Meson G12A SoCs uses the exact same CVBS encoder except a simple
> CVBS DAC register offset and settings delta.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/meson/meson_venc.c      | 11 +++++++++--
>  drivers/gpu/drm/meson/meson_venc_cvbs.c | 25 ++++++++++++++++++-------
>  2 files changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
> index 66d73a932d19..6faca7313339 100644
> --- a/drivers/gpu/drm/meson/meson_venc.c
> +++ b/drivers/gpu/drm/meson/meson_venc.c
> @@ -73,7 +73,9 @@
>  /* HHI Registers */
>  #define HHI_GCLK_MPEG2		0x148 /* 0x52 offset in data sheet */
>  #define HHI_VDAC_CNTL0		0x2F4 /* 0xbd offset in data sheet */
> +#define HHI_VDAC_CNTL0_G12A	0x2EC /* 0xbd offset in data sheet */
>  #define HHI_VDAC_CNTL1		0x2F8 /* 0xbe offset in data sheet */
> +#define HHI_VDAC_CNTL1_G12A	0x2F0 /* 0xbe offset in data sheet */
>  #define HHI_HDMI_PHY_CNTL0	0x3a0 /* 0xe8 offset in data sheet */
>  
>  struct meson_cvbs_enci_mode meson_cvbs_enci_pal = {
> @@ -1675,8 +1677,13 @@ void meson_venc_disable_vsync(struct meson_drm *priv)
>  void meson_venc_init(struct meson_drm *priv)
>  {
>  	/* Disable CVBS VDAC */
> -	regmap_write(priv->hhi, HHI_VDAC_CNTL0, 0);
> -	regmap_write(priv->hhi, HHI_VDAC_CNTL1, 8);
> +	if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu")) {
> +		regmap_write(priv->hhi, HHI_VDAC_CNTL0_G12A, 0);
> +		regmap_write(priv->hhi, HHI_VDAC_CNTL1_G12A, 8);
> +	} else {
> +		regmap_write(priv->hhi, HHI_VDAC_CNTL0, 0);
> +		regmap_write(priv->hhi, HHI_VDAC_CNTL1, 8);
> +	}
>  
>  	/* Power Down Dacs */
>  	writel_relaxed(0xff, priv->io_base + _REG(VENC_VDAC_SETTING));
> diff --git a/drivers/gpu/drm/meson/meson_venc_cvbs.c b/drivers/gpu/drm/meson/meson_venc_cvbs.c
> index d622d817b6df..2c5341c881c4 100644
> --- a/drivers/gpu/drm/meson/meson_venc_cvbs.c
> +++ b/drivers/gpu/drm/meson/meson_venc_cvbs.c
> @@ -37,7 +37,9 @@
>  
>  /* HHI VDAC Registers */
>  #define HHI_VDAC_CNTL0		0x2F4 /* 0xbd offset in data sheet */
> +#define HHI_VDAC_CNTL0_G12A	0x2EC /* 0xbd offset in data sheet */
>  #define HHI_VDAC_CNTL1		0x2F8 /* 0xbe offset in data sheet */
> +#define HHI_VDAC_CNTL1_G12A	0x2F0 /* 0xbe offset in data sheet */
>  
>  struct meson_venc_cvbs {
>  	struct drm_encoder	encoder;
> @@ -166,8 +168,13 @@ static void meson_venc_cvbs_encoder_disable(struct drm_encoder *encoder)
>  	struct meson_drm *priv = meson_venc_cvbs->priv;
>  
>  	/* Disable CVBS VDAC */
> -	regmap_write(priv->hhi, HHI_VDAC_CNTL0, 0);
> -	regmap_write(priv->hhi, HHI_VDAC_CNTL1, 8);
> +	if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu")) {
> +		regmap_write(priv->hhi, HHI_VDAC_CNTL0_G12A, 0);
> +		regmap_write(priv->hhi, HHI_VDAC_CNTL1_G12A, 0);
> +	} else {
> +		regmap_write(priv->hhi, HHI_VDAC_CNTL0, 0);
> +		regmap_write(priv->hhi, HHI_VDAC_CNTL1, 8);

I imagine 8 stands for BIT(3) ? Could you add a define to explain (quickly)
what it is ?

> +	}
>  }
>  
>  static void meson_venc_cvbs_encoder_enable(struct drm_encoder *encoder)
> @@ -179,13 +186,17 @@ static void meson_venc_cvbs_encoder_enable(struct drm_encoder *encoder)
>  	/* VDAC0 source is not from ATV */
>  	writel_bits_relaxed(BIT(5), 0, priv->io_base + _REG(VENC_VDAC_DACSEL0));
>  
> -	if (meson_vpu_is_compatible(priv, "amlogic,meson-gxbb-vpu"))
> +	if (meson_vpu_is_compatible(priv, "amlogic,meson-gxbb-vpu")) {
>  		regmap_write(priv->hhi, HHI_VDAC_CNTL0, 1);
> -	else if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu") ||
> -		 meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu"))
> +		regmap_write(priv->hhi, HHI_VDAC_CNTL1, 0);
> +	} else if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu") ||
> +		 meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu")) {
>  		regmap_write(priv->hhi, HHI_VDAC_CNTL0, 0xf0001);
> -
> -	regmap_write(priv->hhi, HHI_VDAC_CNTL1, 0);
> +		regmap_write(priv->hhi, HHI_VDAC_CNTL1, 0);
> +	} else if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu")) {
> +		regmap_write(priv->hhi, HHI_VDAC_CNTL0_G12A, 0x906001);
> +		regmap_write(priv->hhi, HHI_VDAC_CNTL1_G12A, 0);
> +	}

Maybe the values above are just magics taken from the vendor kernel, but if
you can, it would be nice to break them down to help us understand what is
controlled in these CTNL registers.

>  }
>  
>  static void meson_venc_cvbs_encoder_mode_set(struct drm_encoder *encoder,


