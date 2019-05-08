Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DA7C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 23:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E6D21530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 23:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0rKvv/Xt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbfEHXFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 19:05:47 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39957 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfEHXFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 19:05:46 -0400
Received: by mail-pl1-f194.google.com with SMTP id b3so124125plr.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 16:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=JVzET3Mp0wgIwXsop3AibeqFnQBKBmeFUsVe5B/2igU=;
        b=0rKvv/XtDafNC0HLsREuhHbQX3sZZdgl1ohKulh+yUeFrb3euPGdSWBs7/l+ot9V3V
         VqiCWj20+FRqtwNZjVhj+DlDPTnhYqhtbYOBuaGnTN7n5/ecNAer8W9o+F+ll0OeQJGj
         9za44ADWNvtCwycjOYleO1AsOP0tz8SVcGG5Ma7LT/bcmCLRI6w+MRk9ELoQ4wNNuHnx
         FDOoqgfPTIf7N9IPIHs8razwrXAsUEKkm2fSSmZuOywQY5DjxB1w8xxqnB+DBESJld1g
         Vn6K5/48kfvmfTjE3ExudhRgUx3LfAUsrV9zFk0kuxcA9wOU0KI7Joa6G1JMZ0iGqaYK
         38xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=JVzET3Mp0wgIwXsop3AibeqFnQBKBmeFUsVe5B/2igU=;
        b=Iv2LEcMZxOsHamz8HGvVe8RGnOD0as6+oAWJbl/EHn4qfWIMlsWoJ/zNrFiH8LeRsF
         VP+/sU1JSFvgIOART7v+7KZCfuKc295bBZhM/hB1lckARnhFavIuAHiP5sWsZ9YAGddk
         7GuVjqeLei2wyc1aa+Y2aOeGuzoOUfDNf8UuExfS7NP3Cb2r4apd+u4cqUmMhN1Acyub
         OPNjf5UrQChktxYO0j70posUpIoOG9xcSsTyLj28p64Nf5qf/b5syYJM2AcfG209AzBW
         opyzS7wNvWZNujz3cuFQn8Vmq+tBUc9kZCOdDW3cmF/sHbM+JvryHSgAszsQ461iRBSl
         xHow==
X-Gm-Message-State: APjAAAXkBGtE7y3Y0oeN3zZTR/eFtxtoRB6GaIyoq/uwMfyfdVZzvlNN
        T6BGV4WFiAvTQWjY1fy1iHwW6A==
X-Google-Smtp-Source: APXvYqwzdLUIHtYovZPfiHC/rWX5PqOCpFvFETb+gOoJv6lyxwhlz3SYwF7UrkgeTr1V49rNHOuKxQ==
X-Received: by 2002:a17:902:b20f:: with SMTP id t15mr446060plr.341.1557356745584;
        Wed, 08 May 2019 16:05:45 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:a864:57af:5348:a6ea])
        by smtp.googlemail.com with ESMTPSA id i65sm339785pgc.3.2019.05.08.16.05.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 16:05:44 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     baylibre-upstreaming@groups.io,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: meson-g12a: Add IR nodes
In-Reply-To: <20190412100518.24470-2-narmstrong@baylibre.com>
References: <20190412100518.24470-1-narmstrong@baylibre.com> <20190412100518.24470-2-narmstrong@baylibre.com>
Date:   Wed, 08 May 2019 16:05:44 -0700
Message-ID: <7h1s18im2f.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Amlogic G12A SoCs uses the exact same IR decoder as previous
> families, add the IR node and the pintctrl setting.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> index 734c5ee60efa..9cb76d325bb7 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> @@ -559,6 +559,13 @@
>  						mux {
>  							groups = "pwm_ao_d_e";
>  							function = "pwm_ao_d";
> +						};
> +					};

nit: you had applied this based on top of the PWM series, but didn't
mention that in the cover letter.

Kevin

> +					remote_input_ao_pins: remote-input-ao {
> +						mux {
> +							groups = "remote_ao_input";
> +							function = "remote_ao_input";
>  							bias-disable;
>  						};
>  					};
> @@ -623,6 +630,13 @@
>  				status = "disabled";
>  			};
>  
> +			ir: ir@8000 {
> +				compatible = "amlogic,meson-gxbb-ir";
> +				reg = <0x0 0x8000 0x0 0x20>;
> +				interrupts = <GIC_SPI 196 IRQ_TYPE_EDGE_RISING>;
> +				status = "disabled";
> +			};
> +
>  			saradc: adc@9000 {
>  				compatible = "amlogic,meson-g12a-saradc",
>  					     "amlogic,meson-saradc";
> -- 
> 2.21.0
