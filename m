Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B18C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 09:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A929C20857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 09:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="H/Dv2loz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfCSJ6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 05:58:50 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55920 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfCSJ6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 05:58:49 -0400
Received: by mail-wm1-f68.google.com with SMTP id 4so15874832wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 02:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=O9kxU5BknRLXX2jAA8c+9ZcaS/iyjSYoBXNOkyw4XGc=;
        b=H/Dv2lozMENWG/7yxomMN+AYzm0seizeaLq3niCWJpgH6SjgchY5oJZOV1UlHcoqM9
         HIaBvmkq5E1eDUstvMWI9NJ3rG4UtsJhBLBpwupnEyvR9wKnwLYJ0t7BpJikqHvAsGOR
         k9G0PhsDfWQwGE6PYJozcTpqwvNUyjoSlvbPD5ToaHuqvSJ4sq/nxmxc79ayN3keWb3Q
         LBpRs2b5r29UjDkVXsrWFr9e2JJHg5MV0HB5DHwnMaw1VcEh9JRjZhvbg8moLprcokON
         5O2+FORbSmTBBmxRlQ7y9J3WVRZq2PeM+8oDJPZBRvla5OYU5FQmeM3boDWHUe8R68aH
         AtuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=O9kxU5BknRLXX2jAA8c+9ZcaS/iyjSYoBXNOkyw4XGc=;
        b=sYPjPGGSYy0quMNBghdr5bTvNTHSB0cjgoq/B0n59rBgUuDQz7Y2f8QKiHcnIOKnQY
         58nZomgtNfNOwH0+WhCImPZHOcFroAgTVWhSYzOZXwZBM65SOqIRidUzo2w5vu+cpKxb
         vg2zvz1kOFmUuE0YFalRzx6U9IU66m8Nxq53gDmAI1MEitYDKPozUwPB/dvindDa4VJ7
         hGag3g9/znLZVdj7eraa09e6b5KoS9aU0WWl+43JG17WbBwz4SklWNGmvHxQSN/twzHp
         UDp6i85ZNuvxajjWl5EEPDh+Cv5wo4UMhKBynMqxlt6iihwU4bEW08xL8pMSVK6Z0ypl
         hvIg==
X-Gm-Message-State: APjAAAU1lFSrBIzAN/jvtaMFT/ZvnZX9OkX6MS4oSTEXZA5YLJE3JDlQ
        J1x9yhZ6jwWL5cWv6uniljt2KsolC9le0g==
X-Google-Smtp-Source: APXvYqy/Cbo3EbAMsfmcaNk5K0xgtgf667HR8kiUQfVtOBhX1TemMHNLd14eY+K8wCwLJiHcyGsgXA==
X-Received: by 2002:a1c:7ec2:: with SMTP id z185mr2932300wmc.69.1552989526498;
        Tue, 19 Mar 2019 02:58:46 -0700 (PDT)
Received: from [192.168.1.62] (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id c202sm3154034wme.38.2019.03.19.02.58.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 02:58:45 -0700 (PDT)
Subject: Re: [PATCH 3/3] clk: meson-g12a: add PCIE PLL clocks
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190307141455.23879-1-narmstrong@baylibre.com>
 <20190307141455.23879-4-narmstrong@baylibre.com>
 <f160590677d4eb03c31c7cb81fbca20d8916c460.camel@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <9e2a4785-2bd5-c0a2-a5d7-73326b8b417f@baylibre.com>
Date:   Tue, 19 Mar 2019 10:58:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <f160590677d4eb03c31c7cb81fbca20d8916c460.camel@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/2019 10:55, Jerome Brunet wrote:
> On Thu, 2019-03-07 at 15:14 +0100, Neil Armstrong wrote:
>> Add the PCIe reference clock feeding the USB3 + PCIE combo PHY.
>>
>> This PLL needs a very precise register sequence to permit to be locked,
>> thus using the specific clk-pll pcie ops.
>>
>> The PLL is then followed by :
>> - a fixed /2 divider
>> - a 5-bit 1-based divider
>> - a final /2 divider
>>
>> This reference clock is fixed to 100MHz, thus only a single PLL setup
>> is added.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/clk/meson/g12a.c | 118 +++++++++++++++++++++++++++++++++++++++
>>  drivers/clk/meson/g12a.h |   5 +-
>>  2 files changed, 122 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
>> index 80a7172df2a6..d382c21a29e5 100644
>> --- a/drivers/clk/meson/g12a.c
>> +++ b/drivers/clk/meson/g12a.c
>> @@ -614,6 +614,118 @@ static struct clk_regmap g12a_hifi_pll = {
>>  	},
>>  };
>>  
>> +/*
>> + * The Meson G12A PCIE PLL is fined tuned to deliver a very precise
>> + * 100MHz reference clock for the PCIe Analog PHY, and thus requires
>> + * a strict register sequence to enable the PLL.
>> + */
>> +static const struct reg_sequence g12a_pcie_pll_init_regs[] = {
>> +	{ .reg = HHI_PCIE_PLL_CNTL0,	.def = 0x20090496 },
>> +	{ .reg = HHI_PCIE_PLL_CNTL0,	.def = 0x30090496 },
>> +	{ .reg = HHI_PCIE_PLL_CNTL1,	.def = 0x00000000 },
>> +	{ .reg = HHI_PCIE_PLL_CNTL2,	.def = 0x00001100 },
>> +	{ .reg = HHI_PCIE_PLL_CNTL3,	.def = 0x10058e00 },
>> +	{ .reg = HHI_PCIE_PLL_CNTL4,	.def = 0x000100c0 },
>> +	{ .reg = HHI_PCIE_PLL_CNTL5,	.def = 0x68000048 },
>> +	{ .reg = HHI_PCIE_PLL_CNTL5,	.def = 0x68000068, .delay_us = 20 },
>> +	{ .reg = HHI_PCIE_PLL_CNTL4,	.def = 0x008100c0, .delay_us = 10 },
>> +	{ .reg = HHI_PCIE_PLL_CNTL0,	.def = 0x34090496 },
>> +	{ .reg = HHI_PCIE_PLL_CNTL0,	.def = 0x14090496, .delay_us = 10 },
>> +	{ .reg = HHI_PCIE_PLL_CNTL2,	.def = 0x00001000 },
>> +};
>> +
>> +/* Keep a single entry table for recalc/round_rate() ops */
>> +static const struct pll_params_table g12a_pcie_pll_table[] = {
>> +	PLL_PARAMS(150, 1),
>> +	{0, 0},
>> +};
>> +
>> +static struct clk_regmap g12a_pcie_pll_dco = {
>> +	.data = &(struct meson_clk_pll_data){
>> +		.en = {
>> +			.reg_off = HHI_PCIE_PLL_CNTL0,
>> +			.shift   = 28,
>> +			.width   = 1,
>> +		},
>> +		.m = {
>> +			.reg_off = HHI_PCIE_PLL_CNTL0,
>> +			.shift   = 0,
>> +			.width   = 8,
>> +		},
>> +		.n = {
>> +			.reg_off = HHI_PCIE_PLL_CNTL0,
>> +			.shift   = 10,
>> +			.width   = 5,
>> +		},
>> +		.frac = {
>> +			.reg_off = HHI_PCIE_PLL_CNTL1,
>> +			.shift   = 0,
>> +			.width   = 12,
>> +		},
>> +		.l = {
>> +			.reg_off = HHI_PCIE_PLL_CNTL0,
>> +			.shift   = 31,
>> +			.width   = 1,
>> +		},
>> +		.rst = {
>> +			.reg_off = HHI_PCIE_PLL_CNTL0,
>> +			.shift   = 29,
>> +			.width   = 1,
>> +		},
>> +		.table = g12a_pcie_pll_table,
>> +		.init_regs = g12a_pcie_pll_init_regs,
>> +		.init_count = ARRAY_SIZE(g12a_pcie_pll_init_regs),
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pcie_pll_dco",
>> +		.ops = &meson_clk_pcie_pll_ops,
>> +		.parent_names = (const char *[]){ IN_PREFIX "xtal" },
>> +		.num_parents = 1,
>> +	},
>> +};
>> +
>> +static struct clk_fixed_factor g12a_pcie_pll_dco_div2 = {
>> +	.mult = 1,
>> +	.div = 2,
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pcie_pll_dco_div2",
>> +		.ops = &clk_fixed_factor_ops,
>> +		.parent_names = (const char *[]){ "pcie_pll_dco" },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap g12a_pcie_pll_od = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = HHI_PCIE_PLL_CNTL0,
>> +		.shift = 16,
>> +		.width = 5,
>> +		.flags = CLK_DIVIDER_ROUND_CLOSEST |
>> +			 CLK_DIVIDER_ONE_BASED |
>> +			 CLK_DIVIDER_ALLOW_ZERO,
> 
> That's unusual !
> Ods have always been power of two divider so far. I suppose you have noticed
> and checked this as well ?
>

Yes, I've checked and validated it. Without CLK_DIVIDER_ONE_BASED,
the divider is off by 1. And CLK_DIVIDER_ALLOW_ZERO since at reset,
0 is the default register value.

> That being said, the doc seems to imply that the global post divider will
> divide by 36, which seems difficult to reach with powers of two.
> 
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pcie_pll_od",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_names = (const char *[]){ "pcie_pll_dco_div2" },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_fixed_factor g12a_pcie_pll = {
>> +	.mult = 1,
>> +	.div = 2,
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pcie_pll_pll",
>> +		.ops = &clk_fixed_factor_ops,
>> +		.parent_names = (const char *[]){ "pcie_pll_od" },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>>  static struct clk_regmap g12a_hdmi_pll_dco = {
>>  	.data = &(struct meson_clk_pll_data){
>>  		.en = {
>> @@ -2499,6 +2611,10 @@ static struct clk_hw_onecell_data g12a_hw_onecell_data = {
>>  		[CLKID_CPU_CLK_AXI]		= &g12a_cpu_clk_axi.hw,
>>  		[CLKID_CPU_CLK_TRACE_DIV]	= &g12a_cpu_clk_trace_div.hw,
>>  		[CLKID_CPU_CLK_TRACE]		= &g12a_cpu_clk_trace.hw,
>> +		[CLKID_PCIE_PLL_DCO]		= &g12a_pcie_pll_dco.hw,
>> +		[CLKID_PCIE_PLL_DCO_DIV2]	= &g12a_pcie_pll_dco_div2.hw,
>> +		[CLKID_PCIE_PLL_OD]		= &g12a_pcie_pll_od.hw,
>> +		[CLKID_PCIE_PLL]		= &g12a_pcie_pll.hw,
>>  		[NR_CLKS]			= NULL,
>>  	},
>>  	.num = NR_CLKS,
>> @@ -2685,6 +2801,8 @@ static struct clk_regmap *const g12a_clk_regmaps[] = {
>>  	&g12a_cpu_clk_axi,
>>  	&g12a_cpu_clk_trace_div,
>>  	&g12a_cpu_clk_trace,
>> +	&g12a_pcie_pll_od,
>> +	&g12a_pcie_pll_dco,
>>  };
>>  
>>  static const struct meson_eeclkc_data g12a_clkc_data = {
>> diff --git a/drivers/clk/meson/g12a.h b/drivers/clk/meson/g12a.h
>> index 70aa469ca1cf..1393a09730a6 100644
>> --- a/drivers/clk/meson/g12a.h
>> +++ b/drivers/clk/meson/g12a.h
>> @@ -186,8 +186,11 @@
>>  #define CLKID_CPU_CLK_AXI			195
>>  #define CLKID_CPU_CLK_TRACE_DIV			196
>>  #define CLKID_CPU_CLK_TRACE			197
>> +#define CLKID_PCIE_PLL_DCO			198
>> +#define CLKID_PCIE_PLL_DCO_DIV2			199
>> +#define CLKID_PCIE_PLL_OD			200
>>  
>> -#define NR_CLKS					198
>> +#define NR_CLKS					202
>>  
>>  /* include the CLKIDs that have been made part of the DT binding */
>>  #include <dt-bindings/clock/g12a-clkc.h>
> 
> 

