Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE3DC28EB4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 16:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B0920868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 16:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qETdpu1f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbfFFQaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 12:30:55 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38314 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbfFFQaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 12:30:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id v11so1655289pgl.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 09:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=HUlzUdoZEuwBcIsFcfZEEwizXh8qoMoVTwGXgk651gw=;
        b=qETdpu1fq3YKAf+PIZM1StDrgV04HFfNxDbOwFwICih/0OGyExQlCsDvVUOYGpik2Y
         2gjJfDYHyR1f73PJKlKkPLUz0l0GTn/HYutjpmDgQis3C/fLVHDiMPAHQWe5abO1CxR5
         gzEYFYbOrID4vQAzWHjf9Km7CDWQ+YgyDk6XU59IjAjlriBoJDBeFpD1qYriONA0b96g
         as+fClyo/e/mPDsvW3CinLUXehamtCIGCz+GWe39ZTYfBfsTJCpXWi5sbo6KcpZH4vfU
         65XNfvzv4dThucKEFN8kGfxpVv32WFy2ilzisbYA6jRwPLAp4Ty+WQbW+p7s0mzzxyfP
         PCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=HUlzUdoZEuwBcIsFcfZEEwizXh8qoMoVTwGXgk651gw=;
        b=stFt/BA650tMARcfM5U4Q0stSxNNxn82segxLPm+YX6uFN1U3IZWdyamkTcCFLPxJA
         wtiW8NaOI07gZRg4pdOMsZ6KjpLH8C/43T6X25h4DFdv81KgvLdvmQ/4OfHTxlNL9jNC
         kF1PC+ztQeabULJKhvGGu+3AJTjfnuknsLtoFhJc1daSjww5Kv3SOPy4g3beXlfRdquK
         ZXoXgwZIiSJUnTMFZAYFMzKVilSkzdj6rdStIGgm/BygCrAd2sQ9wY1diaX0emwDLSy/
         jiOH9JdYvrXifGlTEGxmxlVReeUrdrmo2sy3LSSFhiBYTnqSPOS2cqJbFZWI9kvHgwgD
         8Ang==
X-Gm-Message-State: APjAAAWKEQMqYyZiSZQcUnU4epMdZmCqZjBSKn0JL32G7av3gtttqS1+
        cR1eSkHAMperKIq161RSNuvfhg==
X-Google-Smtp-Source: APXvYqwWK98UYLF0wDJKBybt9Rv8pjx46kTpnSnQ3dBiL60FgKPLRXlPXhLbIuisO9V+PN/eTZZzkQ==
X-Received: by 2002:a62:2983:: with SMTP id p125mr13170922pfp.154.1559838654627;
        Thu, 06 Jun 2019 09:30:54 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id g8sm2370035pgd.29.2019.06.06.09.30.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 09:30:53 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/meson: fix G12A HDMI PLL settings for 4K60 1000/1001 variations
In-Reply-To: <20190605125320.8708-1-narmstrong@baylibre.com>
References: <20190605125320.8708-1-narmstrong@baylibre.com>
Date:   Thu, 06 Jun 2019 09:30:52 -0700
Message-ID: <7hh892fzgj.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> The Amlogic G12A HDMI PLL needs some specific settings to lock with
> different fractional values for the 5,4GHz mode.
>
> Handle the 1000/1001 variation fractional case here to avoid having
> the PLL in an non lockable state.
>
> Fixes: 202b9808f8ed ("drm/meson: Add G12A Video Clock setup")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/meson/meson_vclk.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/meson/meson_vclk.c b/drivers/gpu/drm/meson/meson_vclk.c
> index 44250eff8a3f..83fc2fc82001 100644
> --- a/drivers/gpu/drm/meson/meson_vclk.c
> +++ b/drivers/gpu/drm/meson/meson_vclk.c
> @@ -553,8 +553,17 @@ void meson_hdmi_pll_set_params(struct meson_drm *priv, unsigned int m,
>  
>  		/* G12A HDMI PLL Needs specific parameters for 5.4GHz */
>  		if (m >= 0xf7) {
> -			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL4, 0xea68dc00);
> -			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL5, 0x65771290);
> +			if (frac < 0x10000) {
> +				regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL4,
> +							0x6a685c00);
> +				regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL5,
> +							0x11551293);
> +			} else {
> +				regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL4,
> +							0xea68dc00);
> +				regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL5,
> +							0x65771290);
> +			}
>  			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL6, 0x39272000);
>  			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL7, 0x55540000);
>  		} else {

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

nit: this is continuing with more magic constants, and it would be nice
to have them converted to #define'd bitfields.  But since that isn't a
new problem in this patch, it's fine to cleanup later.

Kevin
