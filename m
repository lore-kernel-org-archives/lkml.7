Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779C6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 09:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301F6217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 09:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="cYKbcMhC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfCSJJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 05:09:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40456 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfCSJJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 05:09:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id u10so13111483wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 02:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=+mraZVcK8W8k1Ys6gUeDXV2nyq5RYNnllPGLk5tojv0=;
        b=cYKbcMhCFs8Dw+VaXuX6DU+Daf8sWyGsfswKk7iabqQd8c8KR6oT4QPYrgb6gtvLn2
         DSEGmXcy3RDZBjgCkJIsDtV9z3uHIuvn/18qRVUydgqlvpiJo+uVdaMk6ksK+yqH0WHz
         AoLcejuA6ICgXp+pqYAbYtP0hIre+TnVh37a5gEEKz4Bs/WwDJHl4fuOGKFrzTJ5JcZ8
         2A+Aa7bzJRkYrg+N50j4bhQk06Tw6wAlKX3yI7ZCwIrxB/PbYnCGWaydNa93NqDOHzHP
         fJkYtCBaCDiB5PI5Y/GZFuD/A0k68Y+WmDgGxV5+HtvG1yqBlPWJo30OT88Atk3eLXMM
         OHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=+mraZVcK8W8k1Ys6gUeDXV2nyq5RYNnllPGLk5tojv0=;
        b=VL2jy44XQRROXyCPkgQbaxrDTfvmyBlsvuJtD0N6KuRrvyRtqAlDi/Xh4KGT32FPjJ
         SbbvnGaUZw1jCU3dz46CMrJmZY+HphrSef5FyvLbTE8IvqE5+MRs79Gf+1Xblabo39z0
         6ypnf/CwsDa7pik+CkRIBaPmPDyBdHxy7fsWbdeqfsBUr0xM0auHUVJOXmTunBG4GFRa
         M8dXiGYbzEPq11t6iIZFHG5rhHGzChfb2i6d4t4dVWAHPzRTYBeD56SSUZmG8eatyYrh
         EFitqJZlyt/Va4aE62xEnxkomUUJJnlUzsa6ErnV8eiGBJo44gqyDjsBDGR+D6l5zV2U
         LKww==
X-Gm-Message-State: APjAAAUgsPaFU6W7OTZoY/gxDLrcbw/2hqvfzLZmN94ro0VuG1CK78V4
        +inCARobCH9/qBJ3lMLIOdt6og==
X-Google-Smtp-Source: APXvYqy6vWFdpG2Qxbc+KS5yE9C1ixzowrwQvTf/7vF3DtGkLWgMmO9RV67AmZ/Fy29kaPMWhoPS9w==
X-Received: by 2002:a1c:f606:: with SMTP id w6mr777471wmc.130.1552986580517;
        Tue, 19 Mar 2019 02:09:40 -0700 (PDT)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id q5sm13657639wrn.43.2019.03.19.02.09.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 19 Mar 2019 02:09:39 -0700 (PDT)
Message-ID: <941196f5fe605d4ea10689129a70ee2900b759e7.camel@baylibre.com>
Subject: Re: [PATCH 2/2] clk: meson-g12a: add video decoder clocks
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Maxime Jourdan <mjourdan@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 19 Mar 2019 10:09:37 +0100
In-Reply-To: <20190319085044.8581-3-mjourdan@baylibre.com>
References: <20190319085044.8581-1-mjourdan@baylibre.com>
         <20190319085044.8581-3-mjourdan@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-19 at 09:50 +0100, Maxime Jourdan wrote:

A complete sentence would have been nice ;)

Add the video decoder clocks which are ...

> Mostly like meson-gx, except that the VDEC_HEVC clock is now split in two:
> HEVC and HEVCF.
> 
> Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
> ---
>  drivers/clk/meson/g12a.c | 160 +++++++++++++++++++++++++++++++++++++++
>  drivers/clk/meson/g12a.h |   8 +-
>  2 files changed, 167 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> index 3a3134976534..cfb91df884cb 100644
> --- a/drivers/clk/meson/g12a.c
> +++ b/drivers/clk/meson/g12a.c
> @@ -1495,6 +1495,148 @@ static struct clk_regmap g12a_vpu = {
>  	},
>  };
>  
> +/* VDEC clocks */
> +
> +static const char * const g12a_vdec_parent_names[] = {
> +	"fclk_div2p5", "fclk_div3", "fclk_div4", "fclk_div5", "fclk_div7",
> +	"hifi_pll", "gp0_pll",
> +};
> +
> +static struct clk_regmap g12a_vdec_1_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = HHI_VDEC_CLK_CNTL,
> +		.mask = 0x7,
> +		.shift = 9,
> +		.flags = CLK_MUX_ROUND_CLOSEST,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vdec_1_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_names = g12a_vdec_parent_names,
> +		.num_parents = ARRAY_SIZE(g12a_vdec_parent_names),
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap g12a_vdec_1_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = HHI_VDEC_CLK_CNTL,
> +		.shift = 0,
> +		.width = 7,

Maxime, the parent mux has "ROUND_CLOSEST" but this div does not, which means
it will round down. Is it on purpose ?

* If you can't the allow vdec_1 to round above the request (for safety reason
maybe) then none of the element should round closest.
* If you want closest achievable frequency (even if higher) for vdec_1, then
both element should round closest.

Same comment applies below

This is not a blocker but I'd like you to clarify.

> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vdec_1_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_names = (const char *[]){ "vdec_1_sel" },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap g12a_vdec_1 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = HHI_VDEC_CLK_CNTL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vdec_1",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_names = (const char *[]){ "vdec_1_div" },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap g12a_vdec_hevcf_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = HHI_VDEC2_CLK_CNTL,
> +		.mask = 0x7,
> +		.shift = 9,
> +		.flags = CLK_MUX_ROUND_CLOSEST,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vdec_hevcf_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_names = g12a_vdec_parent_names,
> +		.num_parents = ARRAY_SIZE(g12a_vdec_parent_names),
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap g12a_vdec_hevcf_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = HHI_VDEC2_CLK_CNTL,
> +		.shift = 0,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vdec_hevcf_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_names = (const char *[]){ "vdec_hevcf_sel" },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap g12a_vdec_hevcf = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = HHI_VDEC2_CLK_CNTL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vdec_hevcf",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_names = (const char *[]){ "vdec_hevcf_div" },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap g12a_vdec_hevc_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = HHI_VDEC2_CLK_CNTL,
> +		.mask = 0x7,
> +		.shift = 25,
> +		.flags = CLK_MUX_ROUND_CLOSEST,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vdec_hevc_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_names = g12a_vdec_parent_names,
> +		.num_parents = ARRAY_SIZE(g12a_vdec_parent_names),
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap g12a_vdec_hevc_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = HHI_VDEC2_CLK_CNTL,
> +		.shift = 16,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vdec_hevc_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_names = (const char *[]){ "vdec_hevc_sel" },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap g12a_vdec_hevc = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = HHI_VDEC2_CLK_CNTL,
> +		.bit_idx = 24,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vdec_hevc",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_names = (const char *[]){ "vdec_hevc_div" },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
>  /* VAPB Clock */
>  
>  static const char * const g12a_vapb_parent_names[] = {
> @@ -2615,6 +2757,15 @@ static struct clk_hw_onecell_data g12a_hw_onecell_data = {
>  		[CLKID_PCIE_PLL_DCO_DIV2]	= &g12a_pcie_pll_dco_div2.hw,
>  		[CLKID_PCIE_PLL_OD]		= &g12a_pcie_pll_od.hw,
>  		[CLKID_PCIE_PLL]		= &g12a_pcie_pll.hw,
> +		[CLKID_VDEC_1_SEL]		= &g12a_vdec_1_sel.hw,
> +		[CLKID_VDEC_1_DIV]		= &g12a_vdec_1_div.hw,
> +		[CLKID_VDEC_1]			= &g12a_vdec_1.hw,
> +		[CLKID_VDEC_HEVC_SEL]		= &g12a_vdec_hevc_sel.hw,
> +		[CLKID_VDEC_HEVC_DIV]		= &g12a_vdec_hevc_div.hw,
> +		[CLKID_VDEC_HEVC]		= &g12a_vdec_hevc.hw,
> +		[CLKID_VDEC_HEVCF_SEL]		= &g12a_vdec_hevcf_sel.hw,
> +		[CLKID_VDEC_HEVCF_DIV]		= &g12a_vdec_hevcf_div.hw,
> +		[CLKID_VDEC_HEVCF]		= &g12a_vdec_hevcf.hw,
>  		[NR_CLKS]			= NULL,
>  	},
>  	.num = NR_CLKS,
> @@ -2803,6 +2954,15 @@ static struct clk_regmap *const g12a_clk_regmaps[] = {
>  	&g12a_cpu_clk_trace,
>  	&g12a_pcie_pll_od,
>  	&g12a_pcie_pll_dco,
> +	&g12a_vdec_1_sel,
> +	&g12a_vdec_1_div,
> +	&g12a_vdec_1,
> +	&g12a_vdec_hevc_sel,
> +	&g12a_vdec_hevc_div,
> +	&g12a_vdec_hevc,
> +	&g12a_vdec_hevcf_sel,
> +	&g12a_vdec_hevcf_div,
> +	&g12a_vdec_hevcf,
>  };
>  
>  static const struct meson_eeclkc_data g12a_clkc_data = {
> diff --git a/drivers/clk/meson/g12a.h b/drivers/clk/meson/g12a.h
> index 1393a09730a6..39c41af70804 100644
> --- a/drivers/clk/meson/g12a.h
> +++ b/drivers/clk/meson/g12a.h
> @@ -189,8 +189,14 @@
>  #define CLKID_PCIE_PLL_DCO			198
>  #define CLKID_PCIE_PLL_DCO_DIV2			199
>  #define CLKID_PCIE_PLL_OD			200
> +#define CLKID_VDEC_1_SEL			202
> +#define CLKID_VDEC_1_DIV			203
> +#define CLKID_VDEC_HEVC_SEL			205
> +#define CLKID_VDEC_HEVC_DIV			206
> +#define CLKID_VDEC_HEVCF_SEL			208
> +#define CLKID_VDEC_HEVCF_DIV			209
>  
> -#define NR_CLKS					202
> +#define NR_CLKS					211
>  
>  /* include the CLKIDs that have been made part of the DT binding */
>  #include <dt-bindings/clock/g12a-clkc.h>


