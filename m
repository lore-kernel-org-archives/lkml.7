Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22E3C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 03:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB3622084B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 03:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SvMeaJm+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbfDBDP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 23:15:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43572 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfDBDP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 23:15:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id c8so5583641pfd.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 20:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UfqouMuuuw5kB5uax34hd187WToaCCDig9yHbtHk8h8=;
        b=SvMeaJm+HYw2SIOAyPrLNXS/+twXqfvbVnHmqwr+QlZbwPg9yVwUVBMySsKXuISufW
         sAhlLx3TDbjcAF/GrsoK11AeZc/vVFcUGdqnFUyHiwLLMWEnDWv8Mdvg5kGETBcVYslD
         XL8aPJ4HnjcRsiCQmNjmhR2rV+ZdPLEwnN/ivpzI4MBLhNfHh/ENtFK8G4LVwySoYT+O
         xDY0BJpQNqpGHqHnKKgiT/Z+flmXW4sm5ihSeNd/95KmmFimqyUcHkeYP/i3AznpCwGL
         XYmfEyGT+v+m0c4iMnIaVqPLm4CdJvrvyODCasez/GzxGHyRpJI9ajw8HEDGzYroMi8S
         +FDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UfqouMuuuw5kB5uax34hd187WToaCCDig9yHbtHk8h8=;
        b=KQT712yL92Tx2+S8ofWPYyREtAMrBBQWuvfqc9Ih/CbEj4DOvl9WdagGJf6Hv5xTmR
         k4xoS2HAHQjzTWBkARjG30drXnw9YbbMGK7pUhSt6IXZmJwINQoOJadPopf9d4eXTQI2
         i36hgSRrWTpKdBcLlFRVXF5WgPC63J3K0y/8hJoFiMioKfGYjxB86zzBievQSDh4MuiK
         qiwAR70XNzZ5FC1JBLhJ0reRITVhw3Ij4acz8+JrpGNLju0nNHWCdGU10sQqh3unUQrJ
         lUFp4Lif77cSKU+OZXMvGV3HJSuP3IYpqgWGz1yiJuv1WMrql39aE+Kauw6EcY6wDEKh
         Tofw==
X-Gm-Message-State: APjAAAVnmV9l/Y2XBqmGbrbTavot2IbXt4ZQxMI6L3SPuQmpYiSHLIIu
        N07VzAum/oil1tAh+0p3LWj/Kg==
X-Google-Smtp-Source: APXvYqzhcGRBuJ2xFYHCKtoxyvJW3yxgtZzY/MGJUcK1gO4QaM8uU/wqQxOzUwGmbgs2Vq+ASjIUTw==
X-Received: by 2002:a62:1b03:: with SMTP id b3mr62214651pfb.150.1554174955943;
        Mon, 01 Apr 2019 20:15:55 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id d69sm26081915pfg.26.2019.04.01.20.15.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 20:15:54 -0700 (PDT)
Date:   Tue, 2 Apr 2019 04:15:48 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Hans de Goede <hdegoede@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v3 7/9] mfd: axp20x: add USB power supply mfd cell to
 AXP813
Message-ID: <20190402031548.GF4187@dell>
References: <20190321084850.20769-1-wens@kernel.org>
 <20190321084850.20769-8-wens@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190321084850.20769-8-wens@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019, Chen-Yu Tsai wrote:

> From: Quentin Schulz <quentin.schulz@bootlin.com>
> 
> The AXP813 has a VBUS power input. Now that the axp20x_usb_power driver
> supports this variant, we can add an mfd cell for it to use it.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> [wens@csie.org: add commit message]
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

This patch looks orthogonal.

Unless anyone screams, I'm going to apply it.

> ---
> 
> Changes since v1:
>   - Made axp803_usb_power_supply_resources[] constant
>   - Added Lee's acked-by
> ---
>  drivers/mfd/axp20x.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 3c97f2c0fdfe..902f9f27e748 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -198,6 +198,12 @@ static const struct resource axp22x_usb_power_supply_resources[] = {
>  	DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_VBUS_REMOVAL, "VBUS_REMOVAL"),
>  };
>  
> +/* AXP803 and AXP813/AXP818 share the same interrupts */
> +static const struct resource axp803_usb_power_supply_resources[] = {
> +	DEFINE_RES_IRQ_NAMED(AXP803_IRQ_VBUS_PLUGIN, "VBUS_PLUGIN"),
> +	DEFINE_RES_IRQ_NAMED(AXP803_IRQ_VBUS_REMOVAL, "VBUS_REMOVAL"),
> +};
> +
>  static const struct resource axp22x_pek_resources[] = {
>  	DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_PEK_RIS_EDGE, "PEK_DBR"),
>  	DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_PEK_FAL_EDGE, "PEK_DBF"),
> @@ -793,6 +799,11 @@ static const struct mfd_cell axp813_cells[] = {
>  		.of_compatible	= "x-powers,axp813-ac-power-supply",
>  		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
>  		.resources	= axp20x_ac_power_supply_resources,
> +	}, {
> +		.name		= "axp20x-usb-power-supply",
> +		.num_resources	= ARRAY_SIZE(axp803_usb_power_supply_resources),
> +		.resources	= axp803_usb_power_supply_resources,
> +		.of_compatible	= "x-powers,axp813-usb-power-supply",
>  	},
>  };
>  

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
