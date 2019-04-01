Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E956C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D14D8214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mxw7wJ0m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732127AbfDAIb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:31:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36950 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731861AbfDAIb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:31:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id w10so10765636wrm.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 01:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=x2unXAsK07UQQFdXUKxEybeJF3/sJh/QWyczlPOFgsc=;
        b=mxw7wJ0mvbusrbl9Enq2ij5GzsqLQNPu41WRWNuusAQFWrsGnMsNGXVKy2YUeiZ24V
         LxpSFIblbO2SLp0mdmF4d27Ii+LREIwlOv0qVqCEnZuQkvxTmjDaYUIetprnhi6KMelv
         +idsarP/B73IrANnGUctbomIB6sx5b2x2337c1FJ1PFMs2PYuYrCZdCVa/OFfSF/lFqt
         BRt8prXfXzXxfWs290ZGsQv0KZSOsv8CTnpTg+fOQFV9JCBf2KTuy3vjWWmKwc850Ejz
         YZocOenTjrvaO74zHQ1VXe9NceYFYavLR+PAMCIbZa8ZMjXaof6LRbm7eUAhlqxkt5gm
         TB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=x2unXAsK07UQQFdXUKxEybeJF3/sJh/QWyczlPOFgsc=;
        b=HzjeXvItAP7updXVZVjRiquoWBiiGJTldhK88opIJ/CARNQiUn3vnYBn4vCSVdFNSD
         aZoKdvqvITLSXBtTMftJwValXZ9tAvEj5zQfdBnx1pAIsQ51Jp0hXTAknvOYhAZnxlbb
         3LRA9u9npDJzZah6W3DSRWLAoEH1G1GE48MUMGYq7KEhkJcnW728lAefnfmmaKLim8NS
         7eqf/X/g5x0r4QfWJWHwXCVpXcoHd6sCBvCqkVgT3M+/9JaevgBFv1/IZJAacUqSbKzI
         xS8FFS93BNFdRCFTxrgp1J4EToC7b3QULKWYc86mP275+HlFTJEfH+UFqe9vB3n0OnD9
         07DQ==
X-Gm-Message-State: APjAAAU0sHQoengDcpEoxpSxcQgFU/hwozciTSJridOQMq2u8hC4H9ce
        YZV/Oyz9SQZ85caIMqt3hlDwuEVRxC3h8g==
X-Google-Smtp-Source: APXvYqzN8N6sNtovIFxFGeFtNvmZkDrAM7fohb9wLfMVmJH2hyqT+uP912o87PyBR2UVnXbrLXhccA==
X-Received: by 2002:a5d:6947:: with SMTP id r7mr38053060wrw.167.1554107484482;
        Mon, 01 Apr 2019 01:31:24 -0700 (PDT)
Received: from [192.168.1.62] (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id w11sm30694983wre.15.2019.04.01.01.31.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 01:31:23 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] clk: meson-g12a: add video decoder clocks
To:     Maxime Jourdan <mjourdan@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190319101138.27520-1-mjourdan@baylibre.com>
 <20190319101138.27520-3-mjourdan@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <106e1a7e-9b0d-d071-5413-520a3b90034a@baylibre.com>
Date:   Mon, 1 Apr 2019 10:31:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190319101138.27520-3-mjourdan@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/2019 11:11, Maxime Jourdan wrote:
> Add the necessary clock parts for:
> 
>  - VDEC_1: used to feed VDEC_1
>  - VDEC_HEVC: the "back" part of the VDEC_HEVC block
>  - VDEC_HEVCF: the "front" part of the VDEC_HEVC block
> 
> In previous SoC generations (GXL, GXBB), there was only one VDEC_HEVC
> clock, which got split in two parts for G12A.
> 
> Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
> ---
>  drivers/clk/meson/g12a.c | 163 +++++++++++++++++++++++++++++++++++++++
>  drivers/clk/meson/g12a.h |   8 +-
>  2 files changed, 170 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> index 3a3134976534..6c762a8b32b9 100644
> --- a/drivers/clk/meson/g12a.c
> +++ b/drivers/clk/meson/g12a.c
> @@ -1495,6 +1495,151 @@ static struct clk_regmap g12a_vpu = {
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
> +		.flags = CLK_DIVIDER_ROUND_CLOSEST,
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
> +		.flags = CLK_DIVIDER_ROUND_CLOSEST,
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
> +		.flags = CLK_DIVIDER_ROUND_CLOSEST,
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
> @@ -2615,6 +2760,15 @@ static struct clk_hw_onecell_data g12a_hw_onecell_data = {
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
> @@ -2803,6 +2957,15 @@ static struct clk_regmap *const g12a_clk_regmaps[] = {
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
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
