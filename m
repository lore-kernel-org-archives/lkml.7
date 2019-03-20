Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2D8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35D3C2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LUTjayQS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbfCTISd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 04:18:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43511 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfCTISc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 04:18:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id d17so1621682wre.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 01:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=zNSEjT5R1wgFC31DWWn380G0jbuTgx5ZPt4C6o89+Po=;
        b=LUTjayQSyQFaw+u03MiWndNtuCiDM3+S1tWRq8Logugkywc31EVAkpVb2j5sCAq4i1
         e8JVVw4h7cadDdAidI9/MIDYj6GX0io7Ztsroknvi3B9OM3IRXJScirkrKBPsPFXby2Y
         mfB3gzpnax80ObEwCFsKC7J2DX3F9L7uzdAVMUZwR6ReLfEWuU1Js7A+oBEoedMZFMWi
         BI9duAXWSdbJZi8Wli43n2a+7siMBsD1JlypzGpoh0OK/gCx71XxNFdPA7jokPGUZ3uE
         HMGsYxWF7PJiuB87TX5JFJsG6trwonyvF53P7lApnn8FTqzxX30Vl2NdlPk/d7NoJ51n
         Oohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=zNSEjT5R1wgFC31DWWn380G0jbuTgx5ZPt4C6o89+Po=;
        b=PfymV3NtiNkxVFIW1kNRv5cBy4B6qGPgPigz2hlsTK5o14HFYmHULpyR1A6ADa1XgT
         zNVogXKyVD/FAry9wQmnK7MZao3XvULXUM9ucEckEu0b1n8Utt/d5g/s74cWW+jPm7rN
         JoUwXsIg/YHzU0ab7m+spHm8u/+rY/ffmcddPCYaAQ2Jt3p0bdvub8bg3n5tBjLds8wc
         f58jUr6bSYvWJcLpZcMwtuxUPCDqaQ79FGTz5ZWLpzMqRFH7QWnOSHnthb7QPyakQidG
         Yry4UWRgZdS6FZkSE0j5+K7NPtOYzivPZKK+KsUz4xUTQ8PAVJw95nVsaZBwBfdf05qR
         3dKw==
X-Gm-Message-State: APjAAAWpASBje346VDR0MG0FHtkS5pNVAsOnkOzhaihoi9HL3mOQk8JG
        d5Vq/XZpIqmxIlSt3uWsoRAbhRWiO1IfJVl6
X-Google-Smtp-Source: APXvYqyiUIai+eALfU7Xl435xIlJQAoCA41cJbKYw0JkZq0D4sW/LUnQox+kKZ7DvgVjb/2mqissYw==
X-Received: by 2002:a5d:54c4:: with SMTP id x4mr7853794wrv.296.1553069909445;
        Wed, 20 Mar 2019 01:18:29 -0700 (PDT)
Received: from [192.168.1.62] (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id u7sm1201862wrn.44.2019.03.20.01.18.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 01:18:28 -0700 (PDT)
Subject: Re: [PATCH 4/4] clk: meson: meson8b: add the VPU clock trees
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        jbrunet@baylibre.com, linux-amlogic@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190319215121.29340-1-martin.blumenstingl@googlemail.com>
 <20190319215121.29340-5-martin.blumenstingl@googlemail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <0439a93e-8338-efca-9a7d-8285710400fb@baylibre.com>
Date:   Wed, 20 Mar 2019 09:18:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190319215121.29340-5-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/2019 22:51, Martin Blumenstingl wrote:
> The VPU clock tree is slightly different on all three supported SoCs:
> 
> Meson8 only has an input mux (which chooses between "fclk_div4",
> "fclk_div3", "fclk_div5" and "fclk_div7"), a divider and a gate.
> 
> Meson8b has two VPU clock trees, each with an input mux (using the same
> parents as the input mux on Meson8), divider and a gates. The final VPU
> clock is a glitch-free mux which chooses between VPU_1 and VPU_2.
> 
> Meson8m2 uses a similar clock tree as Meson8b but the last input clock
> is different: instead of using "fclk_div7" as input Meson8m2 uses
> "gp_pll". This was probably done in hardware to improve the accuracy of
> the clock because fclk_div7 gives us 2550MHz / 7 = 364.286MHz while
> GP_PLL can achieve 364.0MHz.

This could be a reason, but they only implement frequency scaling for the VPU
in the recent 4.9 kernel releases... but we should also implement it upstream
once we solve how to switch these dual clocks in a clean fashion.

> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/clk/meson/meson8b.c | 167 ++++++++++++++++++++++++++++++++++++
>  drivers/clk/meson/meson8b.h |   9 +-
>  2 files changed, 175 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
> index 0d08f1ef7af8..8e091c2d10e6 100644
> --- a/drivers/clk/meson/meson8b.c
> +++ b/drivers/clk/meson/meson8b.c
> @@ -1761,6 +1761,147 @@ static struct clk_regmap meson8m2_gp_pll = {
>  	},
>  };
>  
> +static const char * const mmeson8b_vpu_0_1_parent_names[] = {
> +	"fclk_div4", "fclk_div3", "fclk_div5", "fclk_div7"
> +};
> +
> +static const char * const mmeson8m2_vpu_0_1_parent_names[] = {
> +	"fclk_div4", "fclk_div3", "fclk_div5", "gp_pll"
> +};
> +
> +static struct clk_regmap meson8b_vpu_0_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = HHI_VPU_CLK_CNTL,
> +		.mask = 0x3,
> +		.shift = 9,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vpu_0_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_names = mmeson8b_vpu_0_1_parent_names,
> +		.num_parents = ARRAY_SIZE(mmeson8b_vpu_0_1_parent_names),
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap meson8m2_vpu_0_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = HHI_VPU_CLK_CNTL,
> +		.mask = 0x3,
> +		.shift = 9,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vpu_0_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_names = mmeson8m2_vpu_0_1_parent_names,
> +		.num_parents = ARRAY_SIZE(mmeson8m2_vpu_0_1_parent_names),
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap meson8b_vpu_0_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = HHI_VPU_CLK_CNTL,
> +		.shift = 0,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vpu_0_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_names = (const char *[]){ "vpu_0_sel" },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap meson8b_vpu_0 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = HHI_VPU_CLK_CNTL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vpu_0",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_names = (const char *[]){ "vpu_0_div" },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap meson8b_vpu_1_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = HHI_VPU_CLK_CNTL,
> +		.mask = 0x3,
> +		.shift = 25,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vpu_1_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_names = mmeson8b_vpu_0_1_parent_names,
> +		.num_parents = ARRAY_SIZE(mmeson8b_vpu_0_1_parent_names),
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap meson8m2_vpu_1_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = HHI_VPU_CLK_CNTL,
> +		.mask = 0x3,
> +		.shift = 25,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vpu_1_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_names = mmeson8m2_vpu_0_1_parent_names,
> +		.num_parents = ARRAY_SIZE(mmeson8m2_vpu_0_1_parent_names),
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap meson8b_vpu_1_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = HHI_VPU_CLK_CNTL,
> +		.shift = 16,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vpu_1_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_names = (const char *[]){ "vpu_1_sel" },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap meson8b_vpu_1 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = HHI_VPU_CLK_CNTL,
> +		.bit_idx = 24,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vpu_1",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_names = (const char *[]){ "vpu_1_div" },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap meson8b_vpu = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = HHI_VPU_CLK_CNTL,
> +		.mask = 1,
> +		.shift = 31,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vpu",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_names = (const char *[]){ "vpu_0", "vpu_1" },
> +		.num_parents = 2,
> +		.flags = CLK_SET_RATE_NO_REPARENT,
> +	},
> +};
> +
>  /* Everything Else (EE) domain gates */
>  
>  static MESON_GATE(meson8b_ddr, HHI_GCLK_MPEG0, 0);
> @@ -2024,6 +2165,9 @@ static struct clk_hw_onecell_data meson8_hw_onecell_data = {
>  		[CLKID_MALI_0_SEL]	    = &meson8b_mali_0_sel.hw,
>  		[CLKID_MALI_0_DIV]	    = &meson8b_mali_0_div.hw,
>  		[CLKID_MALI]		    = &meson8b_mali_0.hw,
> +		[CLKID_VPU_0_SEL]	    = &meson8b_vpu_0_sel.hw,
> +		[CLKID_VPU_0_DIV]	    = &meson8b_vpu_0_div.hw,
> +		[CLKID_VPU]		    = &meson8b_vpu_0.hw,
>  		[CLK_NR_CLKS]		    = NULL,
>  	},
>  	.num = CLK_NR_CLKS,
> @@ -2210,6 +2354,13 @@ static struct clk_hw_onecell_data meson8b_hw_onecell_data = {
>  		[CLKID_MALI_1_DIV]	    = &meson8b_mali_1_div.hw,
>  		[CLKID_MALI_1]		    = &meson8b_mali_1.hw,
>  		[CLKID_MALI]		    = &meson8b_mali.hw,
> +		[CLKID_VPU_0_SEL]	    = &meson8b_vpu_0_sel.hw,
> +		[CLKID_VPU_0_DIV]	    = &meson8b_vpu_0_div.hw,
> +		[CLKID_VPU_0]		    = &meson8b_vpu_0.hw,
> +		[CLKID_VPU_1_SEL]	    = &meson8b_vpu_1_sel.hw,
> +		[CLKID_VPU_1_DIV]	    = &meson8b_vpu_1_div.hw,
> +		[CLKID_VPU_1]		    = &meson8b_vpu_1.hw,
> +		[CLKID_VPU]		    = &meson8b_vpu.hw,
>  		[CLK_NR_CLKS]		    = NULL,
>  	},
>  	.num = CLK_NR_CLKS,
> @@ -2398,6 +2549,13 @@ static struct clk_hw_onecell_data meson8m2_hw_onecell_data = {
>  		[CLKID_MALI]		    = &meson8b_mali.hw,
>  		[CLKID_GP_PLL_DCO]	    = &meson8m2_gp_pll_dco.hw,
>  		[CLKID_GP_PLL]		    = &meson8m2_gp_pll.hw,
> +		[CLKID_VPU_0_SEL]	    = &meson8m2_vpu_0_sel.hw,
> +		[CLKID_VPU_0_DIV]	    = &meson8b_vpu_0_div.hw,
> +		[CLKID_VPU_0]		    = &meson8b_vpu_0.hw,
> +		[CLKID_VPU_1_SEL]	    = &meson8m2_vpu_1_sel.hw,
> +		[CLKID_VPU_1_DIV]	    = &meson8b_vpu_1_div.hw,
> +		[CLKID_VPU_1]		    = &meson8b_vpu_1.hw,
> +		[CLKID_VPU]		    = &meson8b_vpu.hw,
>  		[CLK_NR_CLKS]		    = NULL,
>  	},
>  	.num = CLK_NR_CLKS,
> @@ -2562,6 +2720,15 @@ static struct clk_regmap *const meson8b_clk_regmaps[] = {
>  	&meson8b_mali,
>  	&meson8m2_gp_pll_dco,
>  	&meson8m2_gp_pll,
> +	&meson8b_vpu_0_sel,
> +	&meson8m2_vpu_0_sel,
> +	&meson8b_vpu_0_div,
> +	&meson8b_vpu_0,
> +	&meson8b_vpu_1_sel,
> +	&meson8m2_vpu_1_sel,
> +	&meson8b_vpu_1_div,
> +	&meson8b_vpu_1,
> +	&meson8b_vpu,
>  };
>  
>  static const struct meson8b_clk_reset_line {
> diff --git a/drivers/clk/meson/meson8b.h b/drivers/clk/meson/meson8b.h
> index a45f7102c558..e775f91ccce9 100644
> --- a/drivers/clk/meson/meson8b.h
> +++ b/drivers/clk/meson/meson8b.h
> @@ -35,6 +35,7 @@
>  #define HHI_VID_DIVIDER_CNTL		0x198 /* 0x66 offset in data sheet */
>  #define HHI_SYS_CPU_CLK_CNTL0		0x19c /* 0x67 offset in data sheet */
>  #define HHI_MALI_CLK_CNTL		0x1b0 /* 0x6c offset in data sheet */
> +#define HHI_VPU_CLK_CNTL		0x1bc /* 0x6f offset in data sheet */
>  #define HHI_HDMI_CLK_CNTL		0x1cc /* 0x73 offset in data sheet */
>  #define HHI_NAND_CLK_CNTL		0x25c /* 0x97 offset in data sheet */
>  #define HHI_MPLL_CNTL			0x280 /* 0xa0 offset in data sheet */
> @@ -149,8 +150,14 @@
>  #define CLKID_MALI_1		180
>  #define CLKID_GP_PLL_DCO	181
>  #define CLKID_GP_PLL		182
> +#define CLKID_VPU_0_SEL		183
> +#define CLKID_VPU_0_DIV		184
> +#define CLKID_VPU_0		185
> +#define CLKID_VPU_1_SEL		186
> +#define CLKID_VPU_1_DIV		187
> +#define CLKID_VPU_1		189
>  
> -#define CLK_NR_CLKS		183
> +#define CLK_NR_CLKS		191
>  
>  /*
>   * include the CLKID and RESETID that have
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
