Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7823DC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A3CA206C1
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tHSxGQVt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbfHSX5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 19:57:07 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46143 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728526AbfHSX5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 19:57:06 -0400
Received: by mail-pf1-f195.google.com with SMTP id q139so2141937pfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 16:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=rz5flzgwGak4NNzNVSfLJ5qh9oyJuRgNqH+DgyR69y0=;
        b=tHSxGQVtPdwNCbdBlr3EUeet2KzcghwAx5OLJmU1osGsm5s7ayUadXIPOZAdRSrAM2
         HnhD0t5RLFE6J+MeJ/5YdgsBe2xzaMdKD93BkYDFjuJkP8FCHX0Mn3AJnYsmjaK5Hda9
         wW7Vm6kRMV4LLduRWAgj4hqH1cGX8AKgt+1VrdgebZ10JgUmc8nNOx0BQZ3ER/yhkNXH
         shVJsQ+vVSdRtcAvZc7Wxp00stxPl/8jwdzUkFoQE2EoQX9U5OGNZqj0cUauczTLmqdH
         PlrQi83nFCcDfHNvDeyk4G0EntDzf3mZJp4kWdvZsPGovrEza3/HrmnU2BIJ25OXLF4S
         61/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=rz5flzgwGak4NNzNVSfLJ5qh9oyJuRgNqH+DgyR69y0=;
        b=YDveOaaW1Rq7uvRQwFgKNHkFlzESE7Acj++ljruEQ1Y6Ust9n3JzC2cZ1DK3GXxO4F
         TCOQq3n0eVqw0AYfz3wpGJo+Xf0kGhyOYN2BIDMXFOdyqVTOwXY4XH5iCjoaYwd0OXUz
         yT9N8ul91i8goGCCssLjqXzcb9Zc/OCdvkblZa/1r4CYTfR2TBYrFVv68SuF7fNxJ4N5
         SupIAEw9dmgQYBUQH98Xn0YZ/II9DNvkDPktafhDrLdrdWyL5QGI5NsRISChTdo6VMJJ
         QJz9XSxfku0b7vzZRiZAG/gL+yoDYGgSn7UO7rzAob/Csv4tEmcf+jhx8y12843NnXpK
         3kEw==
X-Gm-Message-State: APjAAAVKmbxKjcdEhgQVGlRSBiL4l9K4HOf7Nyt6NfD1swpeAr4JgTqL
        IFRT9QZ/bxwzxrKK9XPPR2rF5w==
X-Google-Smtp-Source: APXvYqyG2CFR6aRg5YaSP/aZOjNzo2KmtAnC64ArOTdPKTGyLWnsgG+SwjMw2iOl5rS7+z69nBAy7w==
X-Received: by 2002:a65:4b89:: with SMTP id t9mr21830331pgq.55.1566259025209;
        Mon, 19 Aug 2019 16:57:05 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:35:cf9b:bad:702c])
        by smtp.gmail.com with ESMTPSA id c199sm21383170pfb.28.2019.08.19.16.57.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Aug 2019 16:57:04 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [RFC 04/11] soc: amlogic: Add support for SM1 power controller
In-Reply-To: <20190701104705.18271-5-narmstrong@baylibre.com>
References: <20190701104705.18271-1-narmstrong@baylibre.com> <20190701104705.18271-5-narmstrong@baylibre.com>
Date:   Mon, 19 Aug 2019 16:56:55 -0700
Message-ID: <7hftlwvhdk.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Add support for the General Purpose Amlogic SM1 Power controller,
> dedicated to the PCIe, USB, NNA and GE2D Power Domains.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

I like this driver in general, but as I look at all the EE power domains
for GX, G12 and SM1 they are really very similar.  I had started to
generalize the gx-pwrc-vpu driver and it ends up looking just like this.

I think this driver could be generalized just a little bit more and then
replace the the GX-specific VPU one, and AFAICT, then be used across all
the 64-bit SoCs, and be called "meson-pwrc-ee" or something like that...

> ---
>  drivers/soc/amlogic/Kconfig          |  11 ++
>  drivers/soc/amlogic/Makefile         |   1 +
>  drivers/soc/amlogic/meson-sm1-pwrc.c | 245 +++++++++++++++++++++++++++
>  3 files changed, 257 insertions(+)
>  create mode 100644 drivers/soc/amlogic/meson-sm1-pwrc.c
>
> diff --git a/drivers/soc/amlogic/Kconfig b/drivers/soc/amlogic/Kconfig
> index 5501ad5650b2..596f1afef1a7 100644
> --- a/drivers/soc/amlogic/Kconfig
> +++ b/drivers/soc/amlogic/Kconfig
> @@ -36,6 +36,17 @@ config MESON_GX_PM_DOMAINS
>  	  Say yes to expose Amlogic Meson GX Power Domains as
>  	  Generic Power Domains.
>  
> +config MESON_SM1_PM_DOMAINS
> +	bool "Amlogic Meson SM1 Power Domains driver"
> +	depends on ARCH_MESON || COMPILE_TEST
> +	depends on PM && OF
> +	default ARCH_MESON
> +	select PM_GENERIC_DOMAINS
> +	select PM_GENERIC_DOMAINS_OF
> +	help
> +	  Say yes to expose Amlogic Meson SM1 Power Domains as
> +	  Generic Power Domains.
> +
>  config MESON_MX_SOCINFO
>  	bool "Amlogic Meson MX SoC Information driver"
>  	depends on ARCH_MESON || COMPILE_TEST
> diff --git a/drivers/soc/amlogic/Makefile b/drivers/soc/amlogic/Makefile
> index bf2d109f61e9..f99935499ee6 100644
> --- a/drivers/soc/amlogic/Makefile
> +++ b/drivers/soc/amlogic/Makefile
> @@ -3,3 +3,4 @@ obj-$(CONFIG_MESON_CLK_MEASURE) += meson-clk-measure.o
>  obj-$(CONFIG_MESON_GX_SOCINFO) += meson-gx-socinfo.o
>  obj-$(CONFIG_MESON_GX_PM_DOMAINS) += meson-gx-pwrc-vpu.o
>  obj-$(CONFIG_MESON_MX_SOCINFO) += meson-mx-socinfo.o
> +obj-$(CONFIG_MESON_SM1_PM_DOMAINS) += meson-sm1-pwrc.o
> diff --git a/drivers/soc/amlogic/meson-sm1-pwrc.c b/drivers/soc/amlogic/meson-sm1-pwrc.c
> new file mode 100644
> index 000000000000..9ece1d06f417
> --- /dev/null
> +++ b/drivers/soc/amlogic/meson-sm1-pwrc.c
> @@ -0,0 +1,245 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2017 BayLibre, SAS
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + */
> +
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/bitfield.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of_device.h>
> +#include <dt-bindings/power/meson-sm1-power.h>
> +
> +/* AO Offsets */
> +
> +#define AO_RTI_GEN_PWR_SLEEP0		(0x3a << 2)
> +#define AO_RTI_GEN_PWR_ISO0		(0x3b << 2)
> +
> +/* HHI Offsets */
> +
> +#define HHI_MEM_PD_REG0			(0x40 << 2)
> +#define HHI_NANOQ_MEM_PD_REG0		(0x46 << 2)
> +#define HHI_NANOQ_MEM_PD_REG1		(0x47 << 2)
> +
> +struct meson_sm1_pwrc;
> +
> +struct meson_sm1_pwrc_mem_domain {
> +	unsigned int reg;
> +	unsigned int mask;
> +};
> +
> +struct meson_sm1_pwrc_domain_desc {
> +	char *name;
> +	unsigned int sleep_reg;
> +	unsigned int sleep_bit;
> +	unsigned int iso_reg;
> +	unsigned int iso_bit;
> +	unsigned int mem_pd_count;
> +	struct meson_sm1_pwrc_mem_domain *mem_pd;
> +};

If you add resets and clocks (using clk bulk like my other proposed
patch to gx-pwrc-vpu) then this could be used for VPU also.  We could
ignore my clk bulk patch and then just deprecate the old driver and use
this one for everything.

We would just need SoC-specific tables selected by compatible-string to
select the memory pds, and the clocks and resets could (optionaly) come
from the DT.

Kevin
