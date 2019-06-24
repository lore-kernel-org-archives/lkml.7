Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDB5C4646C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 23:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A0FE20674
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 23:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dLg/cSRk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbfFXXUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 19:20:32 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33523 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbfFXXUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 19:20:31 -0400
Received: by mail-pf1-f194.google.com with SMTP id x15so8384231pfq.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 16:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=CLMq9SkPZ0LrpMbu6uM6UrnywucO78/fC+4xJdWuUjU=;
        b=dLg/cSRkJPUZwFWpsP5zrU6X5hseY4oEeFd0LoCR7LGMnXqC0nzPoFAzqz9Y7u/41c
         PVqSleEbaPIgcPu0aCXcvA8ErwL0FqzRVDuGb0m2YwMJ9cLF7LbUaVxZP6q/2kesoXRK
         /jWxwhBmthWot8HMFhTMtiLMF/eWvtwCGW/6JkkiTuKr3iAewjAgK3i9kIFHThWf575k
         4wEOAr5iRNfUAvL3Xq4eB6rRA+mjQFjipz3E7czZd/g0cvHAaH3Btayr9Z60UV90p37m
         CkV51ozzeK7L+hUT1HzMKJCGHN2tVbrbHL8lyYsoK6oeRmrOC9eKXS9fiv1ZYUi9XD+Z
         9m5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=CLMq9SkPZ0LrpMbu6uM6UrnywucO78/fC+4xJdWuUjU=;
        b=TqLyG04M/wHZNP6rXT9a4JjX31SwRrBV/LaImQGlUs8XDfqDxMFrB2PhjdfXOeFVcv
         0jhGG6Cgs0oG1CWGTik16sdfGT3J5cjEweXfsWDvWZbxezkv8Ft5gi1WFXCLzpvIazzP
         qmmMhzjPDv/faq0r0VHeWNYyN8CMp8iZtshNIw0a3Q+A6JXWEclqsc92hK6bfmaASiTV
         vrCffHsJYwZEVni6KGcGGLdYQgwE4IlLOXsVcOSMV7NxsGA5qUGkpNu7Pp8yRsv9+neK
         tceSnhAAH4a+l38ldzux1LnYGWshVDmZuaBe0rElGXv02Z2a4urNwU/NRHQDbB9nKC/t
         HXMA==
X-Gm-Message-State: APjAAAXknBMWrCBqMMjXh5Zf5fAE3IAWdrm7MUYiwGysKdT8XtpDi/fk
        2M/LGzFJHoOpuSHCx0nTdAmb33WU7tmM1w==
X-Google-Smtp-Source: APXvYqw0AZKgg6EjKTiDXtbpUIU8qcxoTXpR5EwI5qJzAJRAtq9DzupQa5ZaWWS4hAxfXE0scVi4uw==
X-Received: by 2002:a63:c60:: with SMTP id 32mr13363428pgm.42.1561418431055;
        Mon, 24 Jun 2019 16:20:31 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:559b:6f10:667f:4354])
        by smtp.googlemail.com with ESMTPSA id m19sm1137712pjn.3.2019.06.24.16.20.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jun 2019 16:20:30 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     86zhm782g5.fsf@baylibre.com,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Julien Masson <jmasson@baylibre.com>
Subject: Re: [PATCH 8/9] drm: meson: add macro used to enable HDMI PLL
In-Reply-To: <86o92n82e1.fsf@baylibre.com>
References: <86zhm782g5.fsf@baylibre.com> <86o92n82e1.fsf@baylibre.com>
Date:   Mon, 24 Jun 2019 16:20:29 -0700
Message-ID: <7hwohawoxu.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Julien Masson <jmasson@baylibre.com> writes:

> This patch add new macro HHI_HDMI_PLL_CNTL_EN which is used to enable
> HDMI PLL.
>
> Signed-off-by: Julien Masson <jmasson@baylibre.com>
> ---
>  drivers/gpu/drm/meson/meson_vclk.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/meson/meson_vclk.c b/drivers/gpu/drm/meson/meson_vclk.c
> index e7c2b439d0f7..be6e152fc75a 100644
> --- a/drivers/gpu/drm/meson/meson_vclk.c
> +++ b/drivers/gpu/drm/meson/meson_vclk.c
> @@ -96,6 +96,7 @@
>  #define HHI_VDAC_CNTL1		0x2F8 /* 0xbe offset in data sheet */
>  
>  #define HHI_HDMI_PLL_CNTL	0x320 /* 0xc8 offset in data sheet */
> +#define HHI_HDMI_PLL_CNTL_EN	BIT(30)
>  #define HHI_HDMI_PLL_CNTL2	0x324 /* 0xc9 offset in data sheet */
>  #define HHI_HDMI_PLL_CNTL3	0x328 /* 0xca offset in data sheet */
>  #define HHI_HDMI_PLL_CNTL4	0x32C /* 0xcb offset in data sheet */
> @@ -468,7 +469,7 @@ void meson_hdmi_pll_set_params(struct meson_drm *priv, unsigned int m,
>  
>  		/* Enable and unreset */
>  		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL,
> -				   0x7 << 28, 0x4 << 28);
> +				   0x7 << 28, HHI_HDMI_PLL_CNTL_EN);

still using a magic const for the mask.  Can use GENMASK() for this?

Kevin
