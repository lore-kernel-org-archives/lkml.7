Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B5BC33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 01:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D21214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 01:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKpyIDZp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgAHBAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 20:00:34 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44708 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgAHBAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 20:00:33 -0500
Received: by mail-lf1-f67.google.com with SMTP id v201so1106220lfa.11;
        Tue, 07 Jan 2020 17:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K1WP8Nt9IQPQl2KOhe2wpI7M9tBqcPCV3SoKWveA2gE=;
        b=CKpyIDZpy9/X1XRZGg+g94Jld+ZA92gxz+9G5S0NWC/QTg6laZM8Pbax1fUCnmyUic
         9Fos/Ai6ZQeBxm6kzQjhUugfBSaPakMfJnkB7eVChYX8kdE+cPpFCXwK1q9ll8GUA9fH
         cwlsx4THXXCviFb0E/AdfzaGyqn3/8mbbpkPp2XpiCGG/S3+Ssw0tbaeJ5/T7E4Du+PK
         ej+8788RJtDWfvenUfbYGEoG5HI/a77UCS8x28oCNy2wQyrLqmZ56mrPNKbYyFTxo6fh
         2uVhudc+3esSMxBZ/vaQOjLVRnEkqVq4pUCUZEUPKaIDk9EpHl21dVU9sZ3dhn9+N5Ca
         /+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K1WP8Nt9IQPQl2KOhe2wpI7M9tBqcPCV3SoKWveA2gE=;
        b=h5+IyIfprpDwfOhrbYGh3/kvY6cyTjJtnf1xD1ter1YIdSigLd7dhG+Xmp0dHD6djE
         nN+H48HN+2HGOuq6FdEbnE1n0q9vEKaNT9AyGMvg5u1NZCKl3ogEGbwOUi406cp/89qq
         X0iYp/12Gm/BoH+oGCkJEIpPg6KtaiCH2DxaDRsExS/jSGF1mJFwMx11RZ0AE4K4EQgJ
         TRDSKo0De1/z51p6epcOuK17XFsnorkAgz15BO5NQJlQ5qjS9ivf6TnQvvmcOOP7Oy2T
         pyhS93bhwnRsJZhZN6Zo+DKpoTS8Gpa/GOmKXiu1GeWWcclEYP7sPLRUY255enuj4Aqo
         GElQ==
X-Gm-Message-State: APjAAAWkB1tNv6caPVYlB0ILekcAcrCulmCKRN+5ZPrrWD9sqbmJH4UY
        qYICIc4q//lGwr5N8xK0Jn2kzYK9
X-Google-Smtp-Source: APXvYqxlFIc5MZjr1WvkXMENKUiPp2po17tVllNb4RZz7CwvgpAUwjW0i6K3x+iiWURfcON05bQQ0w==
X-Received: by 2002:ac2:5549:: with SMTP id l9mr1246026lfk.53.1578445230650;
        Tue, 07 Jan 2020 17:00:30 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id f22sm451040ljh.74.2020.01.07.17.00.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 17:00:29 -0800 (PST)
Subject: Re: [PATCH v6 06/19] soc: tegra: Add Tegra PMC clocks registration
 into PMC driver
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, broonie@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com, spujar@nvidia.com,
        josephl@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1578370458-3686-1-git-send-email-skomatineni@nvidia.com>
 <1578370458-3686-7-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b37d1be0-affc-a0c7-157a-140b141ca155@gmail.com>
Date:   Wed, 8 Jan 2020 04:00:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1578370458-3686-7-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

07.01.2020 07:14, Sowjanya Komatineni пишет:
> Tegra PMC has clk_out_1, clk_out_2, and clk_out_3 clocks and currently
> these PMC clocks are registered by Tegra clock driver with each clock as
> separate mux and gate clocks using clk_register_mux and clk_register_gate
> by passing PMC base address and register offsets and PMC programming for
> these clocks happens through direct PMC access by the clock driver.
> 
> With this, when PMC is in secure mode any direct PMC access from the
> non-secure world does not go through and these clocks will not be
> functional.
> 
> This patch adds these PMC clocks registration to pmc driver with PMC as
> a clock provider and registers each clock as single clock.
> 
> clk_ops callback implementations for these clocks uses tegra_pmc_readl and
> tegra_pmc_writel which supports PMC programming in both secure mode and
> non-secure mode.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 242 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 242 insertions(+)
> 
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index 1699dda6b393..2b1a709c3cb7 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -13,9 +13,13 @@
>  
>  #include <linux/arm-smccc.h>
>  #include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk/clk-conf.h>
>  #include <linux/clk/tegra.h>
>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
> +#include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/export.h>
>  #include <linux/init.h>
> @@ -48,6 +52,7 @@
>  #include <dt-bindings/pinctrl/pinctrl-tegra-io-pad.h>
>  #include <dt-bindings/gpio/tegra186-gpio.h>
>  #include <dt-bindings/gpio/tegra194-gpio.h>
> +#include <dt-bindings/soc/tegra-pmc.h>
>  
>  #define PMC_CNTRL			0x0
>  #define  PMC_CNTRL_INTR_POLARITY	BIT(17) /* inverts INTR polarity */
> @@ -100,6 +105,8 @@
>  #define PMC_WAKE2_STATUS		0x168
>  #define PMC_SW_WAKE2_STATUS		0x16c
>  
> +#define PMC_CLK_OUT_CNTRL		0x1a8
> +#define  PMC_CLK_OUT_MUX_MASK		GENMASK(1, 0)
>  #define PMC_SENSOR_CTRL			0x1b0
>  #define  PMC_SENSOR_CTRL_SCRATCH_WRITE	BIT(2)
>  #define  PMC_SENSOR_CTRL_ENABLE_RST	BIT(1)
> @@ -155,6 +162,63 @@
>  #define  TEGRA_SMC_PMC_READ	0xaa
>  #define  TEGRA_SMC_PMC_WRITE	0xbb
>  
> +struct pmc_clk {
> +	struct clk_hw	hw;
> +	unsigned long	offs;
> +	u32		mux_shift;
> +	u32		force_en_shift;
> +};
> +
> +#define to_pmc_clk(_hw) container_of(_hw, struct pmc_clk, hw)
> +
> +struct pmc_clk_init_data {
> +	char *name;
> +	const char *const *parents;
> +	int num_parents;
> +	int clk_id;
> +	u8 mux_shift;
> +	u8 force_en_shift;
> +};
> +
> +static const char * const clk_out1_parents[] = { "osc", "osc_div2",
> +	"osc_div4", "extern1",
> +};
> +
> +static const char * const clk_out2_parents[] = { "osc", "osc_div2",
> +	"osc_div4", "extern2",
> +};
> +
> +static const char * const clk_out3_parents[] = { "osc", "osc_div2",
> +	"osc_div4", "extern3",
> +};

There is no way to specify "osc" as a parent clock in a device-tree
because there is no DT ID assigned to the OSC in the CaR driver, should
this be fixed?
