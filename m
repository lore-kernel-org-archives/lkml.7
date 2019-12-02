Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DA8C43141
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 21:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A2BE20717
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 21:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="tSiIJNtM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbfLBVqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 16:46:11 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:38745 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfLBVqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 16:46:11 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 962A422FFC;
        Mon,  2 Dec 2019 22:46:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1575323168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m+nj1jRanRXxMkP/ZRh8eHol3AJEVEabZDRkx7FrSxg=;
        b=tSiIJNtMoNkz3pwn1ZHsJyeYifvEre5j45nOOKa9zFKwpHWltVm5gn/jWXZEjZIcXhPhHJ
        jGLtKPWwAOzfGBycMZrd6owWcX6trAaYhaGOWaAdXjJAVSMROOz1ad/hDKOkjRj6ukD2VD
        0BPYc2lNz6geyxXDOKTgEkcWdsUCZw0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 02 Dec 2019 22:46:08 +0100
From:   Michael Walle <michael@walle.cc>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/2] clk: fsl-sai: new driver
In-Reply-To: <20191122235622.8818-2-michael@walle.cc>
References: <20191122235622.8818-1-michael@walle.cc>
 <20191122235622.8818-2-michael@walle.cc>
Message-ID: <314896a8848fb00063cea1d04637378e@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.8
X-Spamd-Bar: +
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 962A422FFC
X-Spamd-Result: default: False [1.40 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[7];
         NEURAL_HAM(-0.00)[-0.687];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2019-11-23 00:56, schrieb Michael Walle:
> With this driver it is possible to use the BCLK pin of the SAI module 
> as
> a generic clock output. This is esp. useful if you want to drive a 
> clock
> to an audio codec. Because the output only allows integer divider 
> values
> the audio codec needs an integrated PLL.

ping :)

will someone pull this driver? Or have any remarks?

Here is the board what would use this driver:
https://lore.kernel.org/linux-devicetree/20191123201317.25861-5-michael@walle.cc/

-michael


> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/clk/Kconfig       | 12 ++++++
>  drivers/clk/Makefile      |  1 +
>  drivers/clk/clk-fsl-sai.c | 84 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 97 insertions(+)
>  create mode 100644 drivers/clk/clk-fsl-sai.c
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index c44247d0b83e..d3bd43e8a912 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -167,6 +167,18 @@ config COMMON_CLK_CS2000_CP
>  	help
>  	  If you say yes here you get support for the CS2000 clock 
> multiplier.
> 
> +config COMMON_CLK_FSL_SAI
> +	bool "Clock driver for BCLK of Freescale SAI cores"
> +	depends on ARCH_LAYERSCAPE || COMPILE_TEST
> +	help
> +	  This driver supports the Freescale SAI (Synchronous Audio 
> Interface)
> +	  to be used as a generic clock output. Some SoCs have restrictions
> +	  regarding the possible pin multiplexer settings. Eg. on some SoCs
> +	  two SAI interfaces can only be enabled together. If just one is
> +	  needed, the BCLK pin of the second one can be used as general
> +	  purpose clock output. Ideally, it can be used to drive an audio
> +	  codec (sometimes known as MCLK).
> +
>  config COMMON_CLK_GEMINI
>  	bool "Clock driver for Cortina Systems Gemini SoC"
>  	depends on ARCH_GEMINI || COMPILE_TEST
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index 0138fb14e6f8..139f55e544a8 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_ARCH_CLPS711X)		+= clk-clps711x.o
>  obj-$(CONFIG_COMMON_CLK_CS2000_CP)	+= clk-cs2000-cp.o
>  obj-$(CONFIG_ARCH_EFM32)		+= clk-efm32gg.o
>  obj-$(CONFIG_COMMON_CLK_FIXED_MMIO)	+= clk-fixed-mmio.o
> +obj-$(CONFIG_COMMON_CLK_FSL_SAI)	+= clk-fsl-sai.o
>  obj-$(CONFIG_COMMON_CLK_GEMINI)		+= clk-gemini.o
>  obj-$(CONFIG_COMMON_CLK_ASPEED)		+= clk-aspeed.o
>  obj-$(CONFIG_MACH_ASPEED_G6)		+= clk-ast2600.o
> diff --git a/drivers/clk/clk-fsl-sai.c b/drivers/clk/clk-fsl-sai.c
> new file mode 100644
> index 000000000000..b92054d15ab1
> --- /dev/null
> +++ b/drivers/clk/clk-fsl-sai.c
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Freescale SAI BCLK as a generic clock driver
> + *
> + * Copyright 2019 Kontron Europe GmbH
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/slab.h>
> +
> +#define I2S_CSR		0x00
> +#define I2S_CR2		0x08
> +#define CSR_BCE_BIT	28
> +#define CR2_BCD		BIT(24)
> +#define CR2_DIV_SHIFT	0
> +#define CR2_DIV_WIDTH	8
> +
> +struct fsl_sai_clk {
> +	struct clk_divider div;
> +	struct clk_gate gate;
> +	spinlock_t lock;
> +};
> +
> +static void __init fsl_sai_clk_setup(struct device_node *node)
> +{
> +	const char *clk_name = node->name;
> +	struct fsl_sai_clk *sai_clk;
> +	unsigned int num_parents;
> +	const char *parent_name;
> +	void __iomem *base;
> +	struct clk_hw *hw;
> +
> +	num_parents = of_clk_get_parent_count(node);
> +	if (!num_parents) {
> +		pr_err("%s: no parent found", clk_name);
> +		return;
> +	}
> +
> +	parent_name = of_clk_get_parent_name(node, 0);
> +
> +	sai_clk = kzalloc(sizeof(*sai_clk), GFP_KERNEL);
> +	if (!sai_clk)
> +		return;
> +
> +	base = of_iomap(node, 0);
> +	if (base == NULL) {
> +		pr_err("%s: failed to map register space", clk_name);
> +		goto err;
> +	}
> +
> +	spin_lock_init(&sai_clk->lock);
> +
> +	sai_clk->gate.reg = base + I2S_CSR;
> +	sai_clk->gate.bit_idx = CSR_BCE_BIT;
> +	sai_clk->gate.lock = &sai_clk->lock;
> +
> +	sai_clk->div.reg = base + I2S_CR2;
> +	sai_clk->div.shift = CR2_DIV_SHIFT;
> +	sai_clk->div.width = CR2_DIV_WIDTH;
> +	sai_clk->div.lock = &sai_clk->lock;
> +
> +	/* set clock direction, we are the BCLK master */
> +	writel(CR2_BCD, base + I2S_CR2);
> +
> +	hw = clk_hw_register_composite(NULL, clk_name, &parent_name, 1,
> +				       NULL, NULL,
> +				       &sai_clk->div.hw, &clk_divider_ops,
> +				       &sai_clk->gate.hw, &clk_gate_ops,
> +				       CLK_SET_RATE_GATE);
> +	if (IS_ERR(hw))
> +		goto err;
> +
> +	of_clk_add_hw_provider(node, of_clk_hw_simple_get, hw);
> +
> +	return;
> +
> +err:
> +	kfree(sai_clk);
> +}
> +
> +CLK_OF_DECLARE(fsl_sai_clk, "fsl,vf610-sai-clock", fsl_sai_clk_setup);
