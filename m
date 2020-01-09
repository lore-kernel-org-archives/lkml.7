Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E65C33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 07:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C39D2072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 07:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbgAIHyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 02:54:55 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:58274 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbgAIHyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 02:54:54 -0500
Received: from [10.28.39.63] (10.28.39.63) by mail-sz.amlogic.com (10.28.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Thu, 9 Jan
 2020 15:55:17 +0800
Subject: Re: [PATCH v5 3/5] clk: meson: a1: add support for Amlogic A1 PLL
 clock driver
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Chandle Zou <chandle.zou@amlogic.com>,
        <linux-clk@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20191227094606.143637-1-jian.hu@amlogic.com>
 <20191227094606.143637-4-jian.hu@amlogic.com>
 <CAFBinCB2XF1unfEGbApuoXR3ZBRMwgc4EuqSjgKWKm_2G16S5g@mail.gmail.com>
From:   Jian Hu <jian.hu@amlogic.com>
Message-ID: <6d8b7bd4-87ea-46ad-0909-9803032580e4@amlogic.com>
Date:   Thu, 9 Jan 2020 15:55:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAFBinCB2XF1unfEGbApuoXR3ZBRMwgc4EuqSjgKWKm_2G16S5g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.39.63]
X-ClientProxiedBy: mail-sz.amlogic.com (10.28.11.5) To mail-sz.amlogic.com
 (10.28.11.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/12/28 1:04, Martin Blumenstingl wrote:
> Hi Jian,
> 
> On Fri, Dec 27, 2019 at 10:46 AM Jian Hu <jian.hu@amlogic.com> wrote:
> [...]
>> +               .parent_data = &(const struct clk_parent_data){
>> +                       .fw_name = "xtal_fixpll",
>> +               },
> in the Meson8b and G12A (I assume it's the same on GXBB, I didn't
> check it) we have a space between " clk_parent_data)" and "{"
> this applies to at least one more occurrence below
> 
I have checked G12A and Meson8b, there is a space.The space is missing 
here, the same as other place. I will fix it in next version.
> [...]
>> +               /*
>> +                * This clock is used by APB bus which setted in Romcode
> nit-pick: I'm not sure about the grammar here: setted -> "is set"?
> and to make sure I understand this correctly: do you mean the "boot
> ROM" with "Romcode"?
You are right, it is a mistake here. 'is set' is right.
Yes, Romcode means boot ROM. I will change it to 'boot ROM code'
> 
> [...]
>> +static int meson_a1_pll_probe(struct platform_device *pdev)
>> +{
>> +       const struct meson_eeclkc_data *data;
> what do you need this "data" variable for?
> 
>> +       struct device *dev = &pdev->dev;
>> +       struct resource *res;
>> +       void __iomem *base;
>> +       struct regmap *map;
>> +       int ret, i;
>> +
>> +       data = of_device_get_match_data(dev);
>> +       if (!data)
>> +               return -EINVAL;
>> +
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +
>> +       base = devm_ioremap_resource(dev, res);
>> +       if (IS_ERR(base))
>> +               return PTR_ERR(base);
>> +
>> +       map = devm_regmap_init_mmio(dev, base, &clkc_regmap_config);
>> +       if (IS_ERR(map))
>> +              return PTR_ERR(map);
>> +
>> +       /* Populate regmap for the regmap backed clocks */
>> +       for (i = 0; i < data->regmap_clk_num; i++)
>> +               data->regmap_clks[i]->map = map;
> why can't we use a1_pll_regmaps directly here?
> 
OK, I will use it directly .
>> +
>> +       for (i = 0; i < data->hw_onecell_data->num; i++) {
>> +               /* array might be sparse */
>> +               if (!data->hw_onecell_data->hws[i])
>> +                       continue;
>> +
>> +               ret = devm_clk_hw_register(dev, data->hw_onecell_data->hws[i]);
> and why can't we use a1_pll_hw_onecell_data directly here?
> 
OK, I will use it directly.
> [...]
>> +static const struct meson_eeclkc_data a1_pll_data = {
>> +               .regmap_clks = a1_pll_regmaps,
>> +               .regmap_clk_num = ARRAY_SIZE(a1_pll_regmaps),
>> +               .hw_onecell_data = &a1_pll_hw_onecell_data,
>> +};
> if _probe would access these directly then you can drop meson_eeclkc_data
> that is a good thing in my opinion because I was confused by the
> "eeclk" since the patch description says that there's no EE or AO
> domain on the A1 SoCs
> 
OK, I will remove it and verify it.
> 
> Martin
> 
> .
> 
