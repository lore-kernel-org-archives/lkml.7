Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2444EC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D30E120870
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NbfjTgja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbfCXRFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 13:05:11 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36682 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728710AbfCXRFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 13:05:11 -0400
Received: by mail-pf1-f195.google.com with SMTP id p10so4724608pff.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 10:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=exmI8tNjMqdDCoJIPQHS7CNOuHAuSaDbbtoPKMc4kVY=;
        b=NbfjTgjaF5tjqrgXxaXFuTqnNLmT4MphelNnWDLXi2EaAc8RFkpjkKWv/HpZp92OZw
         jgHM580MG5dif0K7zmbSd5/HX/Sk52Fp7iQsMImhoXaAvPHlkhQZldu5L7PpxlToWdwW
         3DB1nA1gN/Y836B5zzSG+Oc8QW7yxKM/66iGu9b5UfWVu9jWWwne/Eb1ToK00TgDCCe0
         ZszKM6mfvwypQ87FoFoLhHg8UWHgPy7OZHjaKeP7GJfboE7hz9FhOutHUahNDfIisdYh
         0TJx00upZireRo/fTIy90wj3fDtlXYvBu27eitKuuDjWkCzf0hB81YMSB/k9mkvPeulu
         zQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=exmI8tNjMqdDCoJIPQHS7CNOuHAuSaDbbtoPKMc4kVY=;
        b=OF5OgcvcZol3RX3FDoePGvPwWcFusDrnbnzAAS9II5YvAZvc8X/H+XZ3kS9j7W4avT
         2D7TPc7hRACgzPjQDPqd44AThQvJOn0T+aw6SR/fdcI6qjVG+XRYwK2VQcviQyW0bKGf
         AsesT3UllW/T2lEXI27qc6xfKzZltPWC3n01Fb1R3LEcN4GjJXZVi3T7zcSvDpAwh9RO
         ++kyTdqRPueHTZv7mHS6DWDlaUiDlUJuMxRp8lPXrDPdMreaVECHSx8qKgr14cemPyRJ
         597qhL348uUCgAABCSBCtBe97GLKSWBY0p+MQ18LnUFgPAaQ+p6eHp4O1XEiMjVEnr5/
         mdTg==
X-Gm-Message-State: APjAAAUw/HDM7Pc39qY5vvVTzsq7pXoISmBG9xWsQJ/JqYRV3Gu6Asgz
        6ioAnSb8oMHLbzFOYpbfuYor/w==
X-Google-Smtp-Source: APXvYqyXYTNYVjNWUhPiAT4NQpG3+iK6MD2ucGOQDLkKCYchpzd3IQNGr2JuLaQYRdODbBGQijkclQ==
X-Received: by 2002:aa7:8005:: with SMTP id j5mr19639100pfi.211.1553447110100;
        Sun, 24 Mar 2019 10:05:10 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id r66sm16004275pfr.131.2019.03.24.10.05.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Mar 2019 10:05:09 -0700 (PDT)
Date:   Sun, 24 Mar 2019 10:05:07 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: gcc-qcs404: Add CDSP related clocks and resets
Message-ID: <20190324170507.GK27005@builder>
References: <20190306055148.10823-1-bjorn.andersson@linaro.org>
 <6277b6cf-e1ad-3994-b788-9aeca52bfebb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6277b6cf-e1ad-3994-b788-9aeca52bfebb@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 07 Mar 02:14 PST 2019, Taniya Das wrote:

> Hello Bjorn,
> 

Hi Taniya,

> I believe on few board variants these clocks could be protected and would be
> added to protected-clocks list?
> 

I was expecting this, but these are not locked down in the LE METAs
we're testing with at least.

Regards,
Bjorn

> On 3/6/2019 11:21 AM, Bjorn Andersson wrote:
> > Add the clocks and resets need in order to control the Turing
> > remoteproc.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >   drivers/clk/qcom/gcc-qcs404.c               | 90 +++++++++++++++++++++
> >   include/dt-bindings/clock/qcom,gcc-qcs404.h |  5 ++
> >   2 files changed, 95 insertions(+)
> > 
> > diff --git a/drivers/clk/qcom/gcc-qcs404.c b/drivers/clk/qcom/gcc-qcs404.c
> > index 5a62f64ada93..a54807eb3b28 100644
> > --- a/drivers/clk/qcom/gcc-qcs404.c
> > +++ b/drivers/clk/qcom/gcc-qcs404.c
> > @@ -260,6 +260,20 @@ static const char * const gcc_parent_names_15[] = {
> >   	"core_bi_pll_test_se",
> >   };
> > +static const struct parent_map gcc_parent_map_16[] = {
> > +	{ P_XO, 0 },
> > +	{ P_GPLL0_OUT_MAIN, 1 },
> > +	{ P_GPLL0_OUT_AUX, 2 },
> > +	{ P_CORE_BI_PLL_TEST_SE, 7 },
> > +};
> > +
> > +static const char * const gcc_parent_names_16[] = {
> > +	"cxo",
> > +	"gpll0_out_main",
> > +	"gpll0_out_aux",
> > +	"core_bi_pll_test_se",
> > +};
> > +
> >   static struct clk_fixed_factor cxo = {
> >   	.mult = 1,
> >   	.div = 1,
> > @@ -1194,6 +1208,28 @@ static struct clk_rcg2 vsync_clk_src = {
> >   	},
> >   };
> > +static const struct freq_tbl ftbl_cdsp_bimc_clk_src[] = {
> > +	F(19200000, P_XO, 1, 0, 0),
> > +	F(133333333, P_GPLL0_OUT_MAIN, 6, 0, 0),
> > +	F(266666667, P_GPLL0_OUT_MAIN, 3, 0, 0),
> > +	F(320000000, P_GPLL0_OUT_MAIN, 2.5, 0, 0),
> > +	{ }
> > +};
> > +
> > +static struct clk_rcg2 cdsp_bimc_clk_src = {
> > +	.cmd_rcgr = 0x5e010,
> > +	.mnd_width = 0,
> > +	.hid_width = 5,
> > +	.parent_map = gcc_parent_map_16,
> > +	.freq_tbl = ftbl_cdsp_bimc_clk_src,
> > +	.clkr.hw.init = &(struct clk_init_data) {
> > +		.name = "cdsp_bimc_clk_src",
> > +		.parent_names = gcc_parent_names_16,
> > +		.num_parents = 4,
> > +		.ops = &clk_rcg2_ops,
> > +	},
> > +};
> > +
> >   static struct clk_branch gcc_apss_ahb_clk = {
> >   	.halt_reg = 0x4601c,
> >   	.halt_check = BRANCH_HALT_VOTED,
> > @@ -1255,6 +1291,24 @@ static struct clk_branch gcc_bimc_gpu_clk = {
> >   	},
> >   };
> > +static struct clk_branch gcc_bimc_cdsp_clk = {
> > +	.halt_reg = 0x31030,
> > +	.halt_check = BRANCH_HALT,
> > +	.clkr = {
> > +		.enable_reg = 0x31030,
> > +		.enable_mask = BIT(0),
> > +		.hw.init = &(struct clk_init_data) {
> > +			.name = "gcc_bimc_cdsp_clk",
> > +			.parent_names = (const char *[]) {
> > +				"cdsp_bimc_clk_src",
> > +			},
> > +			.num_parents = 1,
> > +			.flags = CLK_SET_RATE_PARENT,
> > +			.ops = &clk_branch2_ops,
> > +		},
> > +	},
> > +};
> > +
> >   static struct clk_branch gcc_bimc_mdss_clk = {
> >   	.halt_reg = 0x31038,
> >   	.halt_check = BRANCH_HALT,
> > @@ -1792,6 +1846,24 @@ static struct clk_branch gcc_gfx_tbu_clk = {
> >   	},
> >   };
> > +static struct clk_branch gcc_cdsp_tbu_clk = {
> > +	.halt_reg = 0x1203c,
> > +	.halt_check = BRANCH_VOTED,
> > +	.clkr = {
> > +		.enable_reg = 0x13020,
> > +		.enable_mask = BIT(9),
> > +		.hw.init = &(struct clk_init_data) {
> > +			.name = "gcc_cdsp_tbu_clk",
> > +			.parent_names = (const char *[]) {
> > +				"cdsp_bimc_clk_src",
> > +			},
> > +			.num_parents = 1,
> > +			.flags = CLK_SET_RATE_PARENT,
> > +			.ops = &clk_branch2_ops,
> > +		},
> > +	},
> > +};
> > +
> >   static struct clk_branch gcc_gp1_clk = {
> >   	.halt_reg = 0x8000,
> >   	.halt_check = BRANCH_HALT,
> > @@ -2304,6 +2376,19 @@ static struct clk_branch gcc_sdcc1_ice_core_clk = {
> >   	},
> >   };
> > +static struct clk_branch gcc_cdsp_cfg_ahb_clk = {
> > +	.halt_reg = 0x5e004,
> > +	.halt_check = BRANCH_HALT,
> > +	.clkr = {
> > +		.enable_reg = 0x5e004,
> > +		.enable_mask = BIT(0),
> > +		.hw.init = &(struct clk_init_data) {
> > +			.name = "gcc_cdsp_cfg_ahb_cbcr",
> > +			.ops = &clk_branch2_ops,
> > +		},
> > +	},
> > +};
> > +
> >   static struct clk_branch gcc_sdcc2_ahb_clk = {
> >   	.halt_reg = 0x4301c,
> >   	.halt_check = BRANCH_HALT,
> > @@ -2548,6 +2633,7 @@ static struct clk_regmap *gcc_qcs404_clocks[] = {
> >   	[GCC_ESC0_CLK_SRC] = &esc0_clk_src.clkr,
> >   	[GCC_APSS_AHB_CLK] = &gcc_apss_ahb_clk.clkr,
> >   	[GCC_BIMC_GFX_CLK] = &gcc_bimc_gfx_clk.clkr,
> > +	[GCC_BIMC_CDSP_CLK] = &gcc_bimc_cdsp_clk.clkr,
> >   	[GCC_BIMC_MDSS_CLK] = &gcc_bimc_mdss_clk.clkr,
> >   	[GCC_BLSP1_AHB_CLK] = &gcc_blsp1_ahb_clk.clkr,
> >   	[GCC_BLSP1_QUP0_I2C_APPS_CLK] = &gcc_blsp1_qup0_i2c_apps_clk.clkr,
> > @@ -2605,6 +2691,7 @@ static struct clk_regmap *gcc_qcs404_clocks[] = {
> >   	[GCC_SDCC1_AHB_CLK] = &gcc_sdcc1_ahb_clk.clkr,
> >   	[GCC_SDCC1_APPS_CLK] = &gcc_sdcc1_apps_clk.clkr,
> >   	[GCC_SDCC1_ICE_CORE_CLK] = &gcc_sdcc1_ice_core_clk.clkr,
> > +	[GCC_CDSP_CFG_AHB_CLK] = &gcc_cdsp_cfg_ahb_clk.clkr,
> >   	[GCC_SDCC2_AHB_CLK] = &gcc_sdcc2_ahb_clk.clkr,
> >   	[GCC_SDCC2_APPS_CLK] = &gcc_sdcc2_apps_clk.clkr,
> >   	[GCC_SYS_NOC_USB3_CLK] = &gcc_sys_noc_usb3_clk.clkr,
> > @@ -2645,6 +2732,7 @@ static struct clk_regmap *gcc_qcs404_clocks[] = {
> >   	[GCC_USB3_PHY_AUX_CLK_SRC] = &usb3_phy_aux_clk_src.clkr,
> >   	[GCC_USB_HS_SYSTEM_CLK_SRC] = &usb_hs_system_clk_src.clkr,
> >   	[GCC_VSYNC_CLK_SRC] = &vsync_clk_src.clkr,
> > +	[GCC_CDSP_BIMC_CLK_SRC] = &cdsp_bimc_clk_src.clkr,
> >   	[GCC_USB_HS_INACTIVITY_TIMERS_CLK] =
> >   			&gcc_usb_hs_inactivity_timers_clk.clkr,
> >   	[GCC_BIMC_GPU_CLK] = &gcc_bimc_gpu_clk.clkr,
> > @@ -2653,6 +2741,7 @@ static struct clk_regmap *gcc_qcs404_clocks[] = {
> >   	[GCC_GFX_TBU_CLK] = &gcc_gfx_tbu_clk.clkr,
> >   	[GCC_SMMU_CFG_CLK] = &gcc_smmu_cfg_clk.clkr,
> >   	[GCC_APSS_TCU_CLK] = &gcc_apss_tcu_clk.clkr,
> > +	[GCC_CDSP_TBU_CLK] = &gcc_cdsp_tbu_clk.clkr,
> >   	[GCC_CRYPTO_AHB_CLK] = &gcc_crypto_ahb_clk.clkr,
> >   	[GCC_CRYPTO_AXI_CLK] = &gcc_crypto_axi_clk.clkr,
> >   	[GCC_CRYPTO_CLK] = &gcc_crypto_clk.clkr,
> > @@ -2664,6 +2753,7 @@ static struct clk_regmap *gcc_qcs404_clocks[] = {
> >   static const struct qcom_reset_map gcc_qcs404_resets[] = {
> >   	[GCC_GENI_IR_BCR] = { 0x0F000 },
> > +	[GCC_CDSP_RESTART] = { 0x18000 },
> >   	[GCC_USB_HS_BCR] = { 0x41000 },
> >   	[GCC_USB2_HS_PHY_ONLY_BCR] = { 0x41034 },
> >   	[GCC_QUSB2_PHY_BCR] = { 0x4103c },
> > diff --git a/include/dt-bindings/clock/qcom,gcc-qcs404.h b/include/dt-bindings/clock/qcom,gcc-qcs404.h
> > index 6ceb55ed72c6..454b3f43f538 100644
> > --- a/include/dt-bindings/clock/qcom,gcc-qcs404.h
> > +++ b/include/dt-bindings/clock/qcom,gcc-qcs404.h
> > @@ -146,6 +146,10 @@
> >   #define GCC_MDP_TBU_CLK					138
> >   #define GCC_QDSS_DAP_CLK				139
> >   #define GCC_DCC_XO_CLK					140
> > +#define GCC_CDSP_CFG_AHB_CLK				143
> > +#define GCC_BIMC_CDSP_CLK				144
> > +#define GCC_CDSP_TBU_CLK				145
> > +#define GCC_CDSP_BIMC_CLK_SRC				146
> >   #define GCC_GENI_IR_BCR					0
> >   #define GCC_USB_HS_BCR					1
> > @@ -161,5 +165,6 @@
> >   #define GCC_PCIE_0_LINK_DOWN_BCR			11
> >   #define GCC_PCIEPHY_0_PHY_BCR				12
> >   #define GCC_EMAC_BCR					13
> > +#define GCC_CDSP_RESTART				14
> >   #endif
> > 
> 
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation.
> 
> --
