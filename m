Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE76CA9EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B832070B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439723AbfJYLdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 07:33:07 -0400
Received: from mail-sz.amlogic.com ([211.162.65.117]:7993 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfJYLdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:33:06 -0400
Received: from [10.28.19.114] (10.28.19.114) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Fri, 25 Oct
 2019 19:32:07 +0800
Subject: Re: [PATCH v2 3/3] clk: meson: a1: add support for Amlogic A1 clock
 driver
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Kevin Hilman <khilman@baylibre.com>, Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Chandle Zou <chandle.zou@amlogic.com>,
        <linux-clk@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1571382865-41978-1-git-send-email-jian.hu@amlogic.com>
 <1571382865-41978-4-git-send-email-jian.hu@amlogic.com>
 <1jsgnmba1a.fsf@starbuckisacylon.baylibre.com>
From:   Jian Hu <jian.hu@amlogic.com>
Message-ID: <49b33e94-910b-3fd9-4da1-050742d07e93@amlogic.com>
Date:   Fri, 25 Oct 2019 19:32:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1jsgnmba1a.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.28.19.114]
X-ClientProxiedBy: mail-sz.amlogic.com (10.28.11.5) To mail-sz.amlogic.com
 (10.28.11.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jerome

Thanks for your review

On 2019/10/21 19:41, Jerome Brunet wrote:
> 
> On Fri 18 Oct 2019 at 09:14, Jian Hu <jian.hu@amlogic.com> wrote:
> 
>> The Amlogic A1 clock includes three drivers:
>> peripheral clocks, pll clocks, CPU clocks.
>> sys pll and CPU clocks will be sent in next patch.
>>
>> Unlike the previous series, there is no EE/AO domain
>> in A1 CLK controllers.
>>
>> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
>> ---
>>   drivers/clk/meson/Kconfig  |   10 +
>>   drivers/clk/meson/Makefile |    1 +
>>   drivers/clk/meson/a1-pll.c |  345 +++++++
>>   drivers/clk/meson/a1-pll.h |   56 ++
>>   drivers/clk/meson/a1.c     | 2264 ++++++++++++++++++++++++++++++++++++++++++++
>>   drivers/clk/meson/a1.h     |  120 +++
>>   6 files changed, 2796 insertions(+)
>>   create mode 100644 drivers/clk/meson/a1-pll.c
>>   create mode 100644 drivers/clk/meson/a1-pll.h
>>   create mode 100644 drivers/clk/meson/a1.c
>>   create mode 100644 drivers/clk/meson/a1.h
> 
> In the next version, one
OK, I will send a1 peripheral and pll driver in two patch.
> 
>>
>> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
>> index dabeb43..c2809b2 100644
>> --- a/drivers/clk/meson/Kconfig
>> +++ b/drivers/clk/meson/Kconfig
>> @@ -93,6 +93,16 @@ config COMMON_CLK_AXG_AUDIO
>>   	  Support for the audio clock controller on AmLogic A113D devices,
>>   	  aka axg, Say Y if you want audio subsystem to work.
>>   
>> +config COMMON_CLK_A1
>> +	bool
>> +	depends on ARCH_MESON
>> +	select COMMON_CLK_MESON_REGMAP
>> +	select COMMON_CLK_MESON_DUALDIV
>> +	select COMMON_CLK_MESON_PLL
>> +	help
>> +	  Support for the clock controller on Amlogic A113L device,
>> +	  aka a1. Say Y if you want peripherals to work.
>> +
>>   config COMMON_CLK_G12A
>>   	bool
>>   	depends on ARCH_MESON
>> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
>> index 3939f21..28cbae1 100644
>> --- a/drivers/clk/meson/Makefile
>> +++ b/drivers/clk/meson/Makefile
>> @@ -16,6 +16,7 @@ obj-$(CONFIG_COMMON_CLK_MESON_VID_PLL_DIV) += vid-pll-div.o
>>   
>>   obj-$(CONFIG_COMMON_CLK_AXG) += axg.o axg-aoclk.o
>>   obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
>> +obj-$(CONFIG_COMMON_CLK_A1) += a1-pll.o a1.o
> 
> So far, all the controller had there own option, I don't see why it
> should be different here.
> 
OK, I will add the other option CONFIG_COMMON_CLK_A1_PLL for pll driver
>>   obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
>>   obj-$(CONFIG_COMMON_CLK_G12A) += g12a.o g12a-aoclk.o
>>   obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
>> diff --git a/drivers/clk/meson/a1-pll.c b/drivers/clk/meson/a1-pll.c
>> new file mode 100644
>> index 0000000..486d964
>> --- /dev/null
>> +++ b/drivers/clk/meson/a1-pll.c
>> @@ -0,0 +1,345 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
>> + * Author: Jian Hu <jian.hu@amlogic.com>
>> + */
>> +
>> +#include <linux/platform_device.h>
> 
> Hum ... looks like some things are missing here
> 
> #include <linux/of_device.h>
> #include <linux/clk-provider.h>
> 
> ?
#1
There is <linux/clk-provider.h> in meson-eeclk.h file,

and for A1 driver(a1.c/a1-pll.c) the head file is not requied.

#2
For A1 driver, the file "linux/of_device.h" is not required.
It is required by meson-eeclk.c in fact.
> 
>> +#include "clk-pll.h"
>> +#include "meson-eeclk.h"
>> +#include "a1-pll.h"
> 
> Alphanumeric order please
>
OK, I will change it in the next version.

>> +
>> +static struct clk_regmap a1_fixed_pll_dco = {
>> +	.data = &(struct meson_clk_pll_data){
>> +		.en = {
>> +			.reg_off = ANACTRL_FIXPLL_CTRL0,
>> +			.shift   = 28,
>> +			.width   = 1,
>> +		},
>> +		.m = {
>> +			.reg_off = ANACTRL_FIXPLL_CTRL0,
>> +			.shift   = 0,
>> +			.width   = 8,
>> +		},
>> +		.n = {
>> +			.reg_off = ANACTRL_FIXPLL_CTRL0,
>> +			.shift   = 10,
>> +			.width   = 5,
>> +		},
>> +		.frac = {
>> +			.reg_off = ANACTRL_FIXPLL_CTRL1,
>> +			.shift   = 0,
>> +			.width   = 19,
>> +		},
>> +		.l = {
>> +			.reg_off = ANACTRL_FIXPLL_CTRL0,
>> +			.shift   = 31,
>> +			.width   = 1,
>> +		},
>> +		.rst = {
>> +			.reg_off = ANACTRL_FIXPLL_CTRL0,
>> +			.shift   = 29,
>> +			.width   = 1,
>> +		},
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "fixed_pll_dco",
>> +		.ops = &meson_clk_pll_ro_ops,
>> +		.parent_data = &(const struct clk_parent_data){
>> +			.fw_name = "xtal_fixpll",
>> +			.name = "xtal_fixpll",
>> +		},
>> +		.num_parents = 1,
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_fixed_pll = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = ANACTRL_FIXPLL_CTRL0,
>> +		.bit_idx = 20,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "fixed_pll",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&a1_fixed_pll_dco.hw
>> +		},
>> +		.num_parents = 1,
>> +		/*
>> +		 * This clock is fclk_div2/3/4's parent,
>> +		 * However, fclk_div2/3/5 feeds AXI/APB/DDR.
> 
> is it fclk_div2/3/4 or fclk_div2/3/5 ?
> 
>> +		 * It is required by the platform to operate correctly.
>> +		 * Until the following condition are met, we need this clock to
>> +		 * be marked as critical:
>> +		 * a) Mark the clock used by a firmware resource, if possible
>> +		 * b) CCF has a clock hand-off mechanism to make the sure the
>> +		 *    clock stays on until the proper driver comes along
>> +		 */
> 
> Don't blindly copy/paste comments from other drivers. There is no driver
> for the devices you are mentionning so the end of the comment is
> confusing. The 3 first lines were enough
> 
OK, I will remove the confusing comments

>> +		.flags = CLK_IS_CRITICAL,
> 
>>From your comment, I understand that some child are critical, not this
> particular (or at least, not directly). So this can be removed AFAICT
> 
> You should even need CLK_IGNORE_UNUSED for this one since the clock will
> already be enabled before the late_init() kicks in
> 
OK, I will replace it as CLK_IGNORE_UNUSED.
>> +	},
>> +};
>> +
>> +static const struct pll_mult_range a1_hifi_pll_mult_range = {
>> +	.min = 32,
>> +	.max = 64,
>> +};
>> +
>> +static const struct reg_sequence a1_hifi_init_regs[] = {
>> +	{ .reg = ANACTRL_HIFIPLL_CTRL1, .def = 0x01800000 },
>> +	{ .reg = ANACTRL_HIFIPLL_CTRL2, .def = 0x00001100 },
>> +	{ .reg = ANACTRL_HIFIPLL_CTRL3, .def = 0x100a1100 },
>> +	{ .reg = ANACTRL_HIFIPLL_CTRL4, .def = 0x00302000 },
>> +	{ .reg = ANACTRL_HIFIPLL_CTRL0, .def = 0x01f18440 },
>> +	{ .reg = ANACTRL_HIFIPLL_CTRL0, .def = 0x11f18440, .delay_us = 10 },
>> +	{ .reg = ANACTRL_HIFIPLL_CTRL0, .def = 0x15f18440, .delay_us = 40 },
>> +	{ .reg = ANACTRL_HIFIPLL_CTRL2, .def = 0x00001140 },
>> +	{ .reg = ANACTRL_HIFIPLL_CTRL2, .def = 0x00001100 },
>> +};
>> +
>> +static struct clk_regmap a1_hifi_pll = {
>> +	.data = &(struct meson_clk_pll_data){
>> +		.en = {
>> +			.reg_off = ANACTRL_HIFIPLL_CTRL0,
>> +			.shift   = 28,
>> +			.width   = 1,
>> +		},
>> +		.m = {
>> +			.reg_off = ANACTRL_HIFIPLL_CTRL0,
>> +			.shift   = 0,
>> +			.width   = 8,
>> +		},
>> +		.n = {
>> +			.reg_off = ANACTRL_HIFIPLL_CTRL0,
>> +			.shift   = 10,
>> +			.width   = 5,
>> +		},
>> +		.frac = {
>> +			.reg_off = ANACTRL_HIFIPLL_CTRL1,
>> +			.shift   = 0,
>> +			.width   = 19,
>> +		},
>> +		.l = {
>> +			.reg_off = ANACTRL_HIFIPLL_STS,
>> +			.shift   = 31,
>> +			.width   = 1,
>> +		},
>> +		.range = &a1_hifi_pll_mult_range,
>> +		.init_regs = a1_hifi_init_regs,
>> +		.init_count = ARRAY_SIZE(a1_hifi_init_regs),
>> +		.strict_sequence = true,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "hifi_pll",
>> +		.ops = &meson_clk_pll_ops,
>> +		.parent_data = &(const struct clk_parent_data){
>> +			.fw_name = "xtal_fixpll",
>> +			.name = "xtal_fixpll",
> 
> Both should provided when a controller transition from the old way of
> describing parent to the new way. This is a new controller so it does
> not apply.
I do not understand why it does not apply, could you explain more?

The xtal_fixpll clock is registered in another peripheral driver, If do 
not desribe the "name" member in parent_data, "fw_name" does not work 
because it has not been registered. the hifi_pll parent will be null in 
/sys/kernel/debug/clk/hifi_pll/clk_parent.

HIFI PLL will be a orphan clock, but its parent should be xtal_fixpll.

So both of "fw_name" of "name" should be described.

> 
> Same for the other occurences.
> 
> Also, I think you meant xtal_hifipll
Yes,I will correct it.
> 
>> +		},
>> +		.num_parents = 1,
>> +	},
>> +};
>> +
>> +static struct clk_fixed_factor a1_fclk_div2_div = {
>> +	.mult = 1,
>> +	.div = 2,
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "fclk_div2_div",
>> +		.ops = &clk_fixed_factor_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&a1_fixed_pll.hw
>> +		},
>> +		.num_parents = 1,
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_fclk_div2 = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = ANACTRL_FIXPLL_CTRL0,
>> +		.bit_idx = 21,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "fclk_div2",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&a1_fclk_div2_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		/*
>> +		 * This clock is used by DDR clock in BL2 firmware
>> +		 * and is required by the platform to operate correctly.
>> +		 * Until the following condition are met, we need this clock to
>> +		 * be marked as critical:
>> +		 * a) Mark the clock used by a firmware resource, if possible
>> +		 * b) CCF has a clock hand-off mechanism to make the sure the
>> +		 *    clock stays on until the proper driver comes along
>> +		 */
>> +		.flags = CLK_IS_CRITICAL,
>> +	},
>> +};
>> +
>> +static struct clk_fixed_factor a1_fclk_div3_div = {
>> +	.mult = 1,
>> +	.div = 3,
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "fclk_div3_div",
>> +		.ops = &clk_fixed_factor_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&a1_fixed_pll.hw
>> +		},
>> +		.num_parents = 1,
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_fclk_div3 = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = ANACTRL_FIXPLL_CTRL0,
>> +		.bit_idx = 22,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "fclk_div3",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&a1_fclk_div3_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		/*
>> +		 * This clock is used by APB bus which setted in Romcode
>> +		 * and is required by the platform to operate correctly.
>> +		 * Until the following condition are met, we need this clock to
>> +		 * be marked as critical:
>> +		 * a) Mark the clock used by a firmware resource, if possible
>> +		 * b) CCF has a clock hand-off mechanism to make the sure the
>> +		 *    clock stays on until the proper driver comes along
>> +		 */
>> +		.flags = CLK_IS_CRITICAL,
>> +	},
>> +};
>> +
>> +static struct clk_fixed_factor a1_fclk_div5_div = {
>> +	.mult = 1,
>> +	.div = 5,
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "fclk_div5_div",
>> +		.ops = &clk_fixed_factor_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&a1_fixed_pll.hw
>> +		},
>> +		.num_parents = 1,
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_fclk_div5 = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = ANACTRL_FIXPLL_CTRL0,
>> +		.bit_idx = 23,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "fclk_div5",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&a1_fclk_div5_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		/*
>> +		 * This clock is used by AXI bus which setted in Romcode
>> +		 * and is required by the platform to operate correctly.
>> +		 * Until the following condition are met, we need this clock to
>> +		 * be marked as critical:
>> +		 * a) Mark the clock used by a firmware resource, if possible
>> +		 * b) CCF has a clock hand-off mechanism to make the sure the
>> +		 *    clock stays on until the proper driver comes along
>> +		 */
>> +		.flags = CLK_IS_CRITICAL,
>> +	},
>> +};
>> +
>> +static struct clk_fixed_factor a1_fclk_div7_div = {
>> +	.mult = 1,
>> +	.div = 7,
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "fclk_div7_div",
>> +		.ops = &clk_fixed_factor_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&a1_fixed_pll.hw
>> +		},
>> +		.num_parents = 1,
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_fclk_div7 = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = ANACTRL_FIXPLL_CTRL0,
>> +		.bit_idx = 24,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "fclk_div7",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&a1_fclk_div7_div.hw
>> +		},
>> +		.num_parents = 1,
>> +	},
>> +};
>> +
>> +/* Array of all clocks provided by this provider */
>> +static struct clk_hw_onecell_data a1_pll_hw_onecell_data = {
>> +	.hws = {
>> +		[CLKID_FIXED_PLL_DCO]		= &a1_fixed_pll_dco.hw,
>> +		[CLKID_FIXED_PLL]		= &a1_fixed_pll.hw,
>> +		[CLKID_HIFI_PLL]		= &a1_hifi_pll.hw,
>> +		[CLKID_FCLK_DIV2]		= &a1_fclk_div2.hw,
>> +		[CLKID_FCLK_DIV3]		= &a1_fclk_div3.hw,
>> +		[CLKID_FCLK_DIV5]		= &a1_fclk_div5.hw,
>> +		[CLKID_FCLK_DIV7]		= &a1_fclk_div7.hw,
>> +		[CLKID_FCLK_DIV2_DIV]		= &a1_fclk_div2_div.hw,
>> +		[CLKID_FCLK_DIV3_DIV]		= &a1_fclk_div3_div.hw,
>> +		[CLKID_FCLK_DIV5_DIV]		= &a1_fclk_div5_div.hw,
>> +		[CLKID_FCLK_DIV7_DIV]		= &a1_fclk_div7_div.hw,
>> +		[NR_PLL_CLKS]			= NULL,
>> +	},
>> +	.num = NR_PLL_CLKS,
>> +};
>> +
>> +static struct clk_regmap *const a1_pll_regmaps[] = {
>> +	&a1_fixed_pll_dco,
>> +	&a1_fixed_pll,
>> +	&a1_hifi_pll,
>> +	&a1_fclk_div2,
>> +	&a1_fclk_div3,
>> +	&a1_fclk_div5,
>> +	&a1_fclk_div7,
>> +};
>> +
>> +static int meson_a1_pll_probe(struct platform_device *pdev)
>> +{
>> +	int ret;
>> +
>> +	ret = meson_eeclkc_probe(pdev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
>> +}
> 
> This function is useless.
> 
OK, I will use meson_eeclkc_probe derectly.
>> +
>> +static const struct meson_eeclkc_data a1_pll_data = {
>> +		.regmap_clks = a1_pll_regmaps,
>> +		.regmap_clk_num = ARRAY_SIZE(a1_pll_regmaps),
>> +		.hw_onecell_data = &a1_pll_hw_onecell_data,
>> +};
>> +static const struct of_device_id clkc_match_table[] = {
>> +	{
>> +		.compatible = "amlogic,a1-pll-clkc",
>> +		.data = &a1_pll_data
>> +	},
>> +	{ /* sentinel */ }
> 
> Nitpick: don't need to write this, just write the line like this
> 
OK, remove it.
> ' }, {}'
> 
>> +};
>> +
>> +static struct platform_driver a1_driver = {
>> +	.probe		= meson_a1_pll_probe,
>> +	.driver		= {
>> +		.name	= "a1-pll-clkc",
>> +		.of_match_table = clkc_match_table,
>> +	},
>> +};
>> +
>> +builtin_platform_driver(a1_driver);
>> diff --git a/drivers/clk/meson/a1-pll.h b/drivers/clk/meson/a1-pll.h
>> new file mode 100644
>> index 0000000..99ee2a9
>> --- /dev/null
>> +++ b/drivers/clk/meson/a1-pll.h
>> @@ -0,0 +1,56 @@
>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
>> +/*
>> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
>> + */
>> +
>> +#ifndef __A1_PLL_H
>> +#define __A1_PLL_H
>> +
>> +/* PLL register offset */
>> +#define ANACTRL_FIXPLL_CTRL0		0x80
>> +#define ANACTRL_FIXPLL_CTRL1		0x84
>> +#define ANACTRL_FIXPLL_CTRL2		0x88
>> +#define ANACTRL_FIXPLL_CTRL3		0x8c
>> +#define ANACTRL_FIXPLL_CTRL4		0x90
>> +#define ANACTRL_FIXPLL_STS		0x94
>> +#define ANACTRL_SYSPLL_CTRL0		0x100
>> +#define ANACTRL_SYSPLL_CTRL1		0x104
>> +#define ANACTRL_SYSPLL_CTRL2		0x108
>> +#define ANACTRL_SYSPLL_CTRL3		0x10c
>> +#define ANACTRL_SYSPLL_CTRL4		0x110
>> +#define ANACTRL_SYSPLL_STS		0x114
>> +#define ANACTRL_HIFIPLL_CTRL0		0x140
>> +#define ANACTRL_HIFIPLL_CTRL1		0x144
>> +#define ANACTRL_HIFIPLL_CTRL2		0x148
>> +#define ANACTRL_HIFIPLL_CTRL3		0x14c
>> +#define ANACTRL_HIFIPLL_CTRL4		0x150
>> +#define ANACTRL_HIFIPLL_STS		0x154
>> +#define ANACTRL_AUDDDS_CTRL0		0x180
>> +#define ANACTRL_AUDDDS_CTRL1		0x184
>> +#define ANACTRL_AUDDDS_CTRL2		0x188
>> +#define ANACTRL_AUDDDS_CTRL3		0x18c
>> +#define ANACTRL_AUDDDS_CTRL4		0x190
>> +#define ANACTRL_AUDDDS_STS		0x194
>> +#define ANACTRL_MISCTOP_CTRL0		0x1c0
>> +#define ANACTRL_POR_CNTL		0x208
>> +
>> +/*
>> + * CLKID index values
>> + *
>> + * These indices are entirely contrived and do not map onto the hardware.
>> + * It has now been decided to expose everything by default in the DT header:
>> + * include/dt-bindings/clock/a1-pll-clkc.h. Only the clocks ids we don't want
>> + * to expose, such as the internal muxes and dividers of composite clocks,
>> + * will remain defined here.
>> + */
>> +#define CLKID_FIXED_PLL_DCO		0
>> +#define CLKID_FCLK_DIV2_DIV		2
>> +#define CLKID_FCLK_DIV3_DIV		3
>> +#define CLKID_FCLK_DIV5_DIV		4
>> +#define CLKID_FCLK_DIV7_DIV		5
>> +#define NR_PLL_CLKS			11
>> +
>> +/* include the CLKIDs that have been made part of the DT binding */
>> +#include <dt-bindings/clock/a1-pll-clkc.h>
>> +
>> +#endif /* __A1_PLL_H */
>> diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
>> new file mode 100644
>> index 0000000..86a4733
>> --- /dev/null
>> +++ b/drivers/clk/meson/a1.c
>> @@ -0,0 +1,2264 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
>> + * Author: Jian Hu <jian.hu@amlogic.com>
>> + */
>> +
>> +#include <linux/platform_device.h>
>> +#include "clk-pll.h"
>> +#include "clk-dualdiv.h"
>> +#include "meson-eeclk.h"
>> +#include "a1.h"
> 
> Same as above
OK, I will change the order.
In fact, the clk-pll.h is not used in the current driver.
I will remove it.
> 
>> +
>> +/* PLLs clock in gates, its parent is xtal */
>> +static struct clk_regmap a1_xtal_clktree = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = SYS_OSCIN_CTRL,
>> +		.bit_idx = 0,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "xtal_clktree",
>> +		.ops = &clk_regmap_gate_ro_ops,
>> +		.parent_data = &(const struct clk_parent_data) {
>> +			.fw_name = "xtal",
>> +		},
>> +		.num_parents = 1,
>> +		/*
>> +		 * switch for xtal clock
>> +		 * Linux should not change it at runtime
>> +		 */
> 
> Comment not useful: it uses the Ro ops
> 
OK,  remove the comments
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_xtal_fixpll = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = SYS_OSCIN_CTRL,
>> +		.bit_idx = 1,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "xtal_fixpll",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_data = &(const struct clk_parent_data) {
>> +			.fw_name = "xtal",
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_IS_CRITICAL,
>> +		/*
>> +		 * it feeds DDR,AXI,APB bus
>> +		 * Linux should not change it at runtime
>> +		 */
> 
> Again, the child are critical, not directly this clock from your
> comment.
> 
> Remove CRITICAL, put RO is linux is not supposed to touch it.
> 
repace as clk_regmap_gate_ro_ops
>> +	},
>> +};
>> +

[ ... ]

>> +
>> +/* dsp a clk */
>> +static u32 mux_table_dsp_ab[] = { 0, 1, 2, 3, 4, 7 };
>> +static const struct clk_parent_data dsp_ab_clk_parent_data[] = {
>> +	{ .fw_name = "xtal", },
>> +	{ .fw_name = "fclk_div2", },
>> +	{ .fw_name = "fclk_div3", },
>> +	{ .fw_name = "fclk_div5", },
>> +	{ .fw_name = "hifi_pll", },
>> +	{ .hw = &a1_rtc_clk.hw },
>> +};
>> +
>> +static struct clk_regmap a1_dspa_a_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = DSPA_CLK_CTRL0,
>> +		.mask = 0x7,
>> +		.shift = 10,
>> +		.table = mux_table_dsp_ab,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "dspa_a_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = dsp_ab_clk_parent_data,
>> +		.num_parents = ARRAY_SIZE(dsp_ab_clk_parent_data),
> 
> .flags = CLK_SET_RATE_PARENT ?
Yes, I miss the flag.
> 
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_dspa_a_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = DSPA_CLK_CTRL0,
>> +		.shift = 0,
>> +		.width = 10,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "dspa_a_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&a1_dspa_a_sel.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_dspa_a = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = DSPA_CLK_CTRL0,
>> +		.bit_idx = 13,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "dspa_a",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&a1_dspa_a_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_dspa_b_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = DSPA_CLK_CTRL0,
>> +		.mask = 0x7,
>> +		.shift = 26,
>> +		.table = mux_table_dsp_ab,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "dspa_b_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = dsp_ab_clk_parent_data,
>> +		.num_parents = ARRAY_SIZE(dsp_ab_clk_parent_data),
> 
> .flags = CLK_SET_RATE_PARENT ?
> 
Yes, I will add it.
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_dspa_b_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = DSPA_CLK_CTRL0,
>> +		.shift = 16,
>> +		.width = 10,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "dspa_b_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&a1_dspa_b_sel.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_dspa_b = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = DSPA_CLK_CTRL0,
>> +		.bit_idx = 29,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "dspa_b",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&a1_dspa_b_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_dspa_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = DSPA_CLK_CTRL0,
>> +		.mask = 0x1,
>> +		.shift = 15,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "dspa_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = (const struct clk_parent_data []) {
>> +			{ .hw = &a1_dspa_a.hw },
>> +			{ .hw = &a1_dspa_b.hw },
>> +		},
>> +		.num_parents = 2,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_dspa_en_dspa = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = DSPA_CLK_EN,
>> +		.bit_idx = 1,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "dspa_en_dspa",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&a1_dspa_sel.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> 
> Why do you need CLK_IGNORE_UNUSED ?
> 
I should remove it
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_dspa_en_nic = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = DSPA_CLK_EN,
>> +		.bit_idx = 0,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "dspa_en_nic",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&a1_dspa_sel.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> 
> Why do you need CLK_IGNORE_UNUSED ?
> 
I should remove it
>> +	},
>> +};
>> +
> 
> Same question and remarks applies to DSP B
> 
got it
>> +/* dsp b clk */
>> +static struct clk_regmap a1_dspb_a_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = DSPB_CLK_CTRL0,
>> +		.mask = 0x7,
>> +		.shift = 10,
>> +		.table = mux_table_dsp_ab,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "dspb_a_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = dsp_ab_clk_parent_data,
>> +		.num_parents = ARRAY_SIZE(dsp_ab_clk_parent_data),
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_dspb_a_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = DSPB_CLK_CTRL0,
>> +		.shift = 0,
>> +		.width = 10,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "dspb_a_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&a1_dspb_a_sel.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_dspb_a = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = DSPB_CLK_CTRL0,
>> +		.bit_idx = 13,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "dspb_a",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&a1_dspb_a_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_dspb_b_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = DSPB_CLK_CTRL0,
>> +		.mask = 0x7,
>> +		.shift = 26,
>> +		.table = mux_table_dsp_ab,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "dspb_b_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = dsp_ab_clk_parent_data,
>> +		.num_parents = ARRAY_SIZE(dsp_ab_clk_parent_data),
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_dspb_b_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = DSPB_CLK_CTRL0,
>> +		.shift = 16,
>> +		.width = 10,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "dspb_b_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&a1_dspb_b_sel.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_dspb_b = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = DSPB_CLK_CTRL0,
>> +		.bit_idx = 29,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "dspb_b",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&a1_dspb_b_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_dspb_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = DSPB_CLK_CTRL0,
>> +		.mask = 0x1,
>> +		.shift = 15,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "dspb_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&a1_dspb_a.hw, &a1_dspb_b.hw,
>> +		},
>> +		.num_parents = 2,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_dspb_en_dspb = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = DSPB_CLK_EN,
>> +		.bit_idx = 1,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "dspb_en_dspb",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&a1_dspb_sel.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_dspb_en_nic = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = DSPB_CLK_EN,
>> +		.bit_idx = 0,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "dspb_en_nic",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&a1_dspb_sel.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +	},
>> +};
>> +
>> +/* 12M/24M clock */
>> +static struct clk_regmap a1_24m = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLK12_24_CTRL,
>> +		.bit_idx = 11,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "24m",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_data = &(const struct clk_parent_data) {
>> +			.fw_name = "xtal",
>> +		},
>> +		.num_parents = 1,
>> +	},
>> +};
>> +

[ ... ]

>> +static struct clk_regmap a1_saradc_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = SAR_ADC_CLK_CTRL,
>> +		.mask = 0x1,
>> +		.shift = 9,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "saradc_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = (const struct clk_parent_data []) {
>> +			{ .fw_name = "xtal", },
>> +			{ .hw = &a1_sys_clk.hw, },
>> +		},
>> +		.num_parents = 2,
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_saradc_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = SAR_ADC_CLK_CTRL,
>> +		.shift = 0,
>> +		.width = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "saradc_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&a1_saradc_sel.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_saradc_clk = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = SAR_ADC_CLK_CTRL,
>> +		.bit_idx = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "saradc_clk",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&a1_saradc_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +/* pwm a/b/c/d parent data */
>> +static const struct clk_parent_data pwm_parent_data[] = {
>> +	{ .fw_name = "xtal", },
>> +	{ .hw = &a1_sys_clk.hw },
>> +};
> 
> Looks like the same as SAR ADC
> 
OK, I will describe it like SAR ADC for pwm a/b/c/d
>> +
>> +/* pwm a clk */
>> +static struct clk_regmap a1_pwm_a_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = PWM_CLK_AB_CTRL,
>> +		.mask = 0x1,
>> +		.shift = 9,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pwm_a_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = pwm_parent_data,
>> +		.num_parents = ARRAY_SIZE(pwm_parent_data),
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_pwm_a_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = PWM_CLK_AB_CTRL,
>> +		.shift = 0,
>> +		.width = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pwm_a_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&a1_pwm_a_sel.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_pwm_a = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = PWM_CLK_AB_CTRL,
>> +		.bit_idx = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "pwm_a",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&a1_pwm_a_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		/*
>> +		 * The CPU working voltage is controlled by pwm_a
>> +		 * in BL2 firmware. add the CLK_IGNORE_UNUSED flag
>> +		 * to avoid changing at runtime.
>                                      ^ it
> 
>> +		 * and is required by the platform to operate correctly.
>                     "blabla. And" is strange
> 
>> +		 * Until the following condition are met, we need this clock to
>> +		 * be marked as critical:
>> +		 * a) Mark the clock used by a firmware resource, if possible
>> +		 * b) CCF has a clock hand-off mechanism to make the sure the
>> +		 *    clock stays on until the proper driver comes along
>> +		 */
>> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> 
> This only skips the late_init() disable of unused clocks
> 
> Be aware that this is not fool-proof. If at any time a driver enable
> then disable the clock, the clock will be disable and I guess your
> platform will die if this provides the CPU voltage.
OK, CLK_IS_CRITICAL is better.
> 
>> +	},
>> +};
>> +
>> +/* pwm b clk */
>> +static struct clk_regmap a1_pwm_b_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = PWM_CLK_AB_CTRL,
>> +		.mask = 0x1,
>> +		.shift = 25,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pwm_b_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = pwm_parent_data,
>> +		.num_parents = ARRAY_SIZE(pwm_parent_data),
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_pwm_b_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = PWM_CLK_AB_CTRL,
>> +		.shift = 16,
>> +		.width = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pwm_b_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&a1_pwm_b_sel.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_pwm_b = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = PWM_CLK_AB_CTRL,
>> +		.bit_idx = 24,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "pwm_b",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&a1_pwm_b_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +/* pwm c clk */
>> +static struct clk_regmap a1_pwm_c_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = PWM_CLK_CD_CTRL,
>> +		.mask = 0x1,
>> +		.shift = 9,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pwm_c_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = pwm_parent_data,
>> +		.num_parents = ARRAY_SIZE(pwm_parent_data),
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_pwm_c_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = PWM_CLK_CD_CTRL,
>> +		.shift = 0,
>> +		.width = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pwm_c_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&a1_pwm_c_sel.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_pwm_c = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = PWM_CLK_CD_CTRL,
>> +		.bit_idx = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "pwm_c",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&a1_pwm_c_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +/* pwm d clk */
>> +static struct clk_regmap a1_pwm_d_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = PWM_CLK_CD_CTRL,
>> +		.mask = 0x1,
>> +		.shift = 25,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pwm_d_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = pwm_parent_data,
>> +		.num_parents = ARRAY_SIZE(pwm_parent_data),
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_pwm_d_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = PWM_CLK_CD_CTRL,
>> +		.shift = 16,
>> +		.width = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pwm_d_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&a1_pwm_d_sel.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_pwm_d = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = PWM_CLK_CD_CTRL,
>> +		.bit_idx = 24,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "pwm_d",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&a1_pwm_d_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static const struct clk_parent_data pwm_ef_parent_data[] = {
>> +	{ .fw_name = "xtal", },
>> +	{ .hw = &a1_sys_clk.hw },
>> +	{ .fw_name = "fclk_div5", },
>> +	{ .hw = &a1_rtc_clk.hw },
>> +};
>> +
>> +/* pwm e clk */
>> +static struct clk_regmap a1_pwm_e_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = PWM_CLK_EF_CTRL,
>> +		.mask = 0x3,
>> +		.shift = 9,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pwm_e_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = pwm_ef_parent_data,
>> +		.num_parents = ARRAY_SIZE(pwm_ef_parent_data),
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_pwm_e_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = PWM_CLK_EF_CTRL,
>> +		.shift = 0,
>> +		.width = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pwm_e_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&a1_pwm_e_sel.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_pwm_e = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = PWM_CLK_EF_CTRL,
>> +		.bit_idx = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "pwm_e",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&a1_pwm_e_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +/* pwm f clk */
>> +static struct clk_regmap a1_pwm_f_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = PWM_CLK_EF_CTRL,
>> +		.mask = 0x3,
>> +		.shift = 25,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pwm_f_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = pwm_ef_parent_data,
>> +		.num_parents = ARRAY_SIZE(pwm_ef_parent_data),
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_pwm_f_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = PWM_CLK_EF_CTRL,
>> +		.shift = 16,
>> +		.width = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pwm_f_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&a1_pwm_f_sel.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_pwm_f = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = PWM_CLK_EF_CTRL,
>> +		.bit_idx = 24,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "pwm_f",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&a1_pwm_f_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +

[ ... ]

>> +
>> +/* dmc clk */
>> +static struct clk_regmap a1_dmc_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = DMC_CLK_CTRL,
>> +		.mask = 0x3,
>> +		.shift = 9,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "dmc_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = sd_emmc_parents,
>> +		.num_parents = 4,
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_dmc_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = DMC_CLK_CTRL,
>> +		.shift = 0,
>> +		.width = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "dmc_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&a1_dmc_sel.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_dmc_sel2 = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = DMC_CLK_CTRL,
>> +		.mask = 0x1,
>> +		.shift = 15,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "dmc_sel2",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = (const struct clk_parent_data []) {
>> +			{ .hw = &a1_dmc_div.hw },
>> +			{ .fw_name = "xtal", },
>> +		},
>> +		.num_parents = 2,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_dmc = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = DMC_CLK_CTRL,
>> +		.bit_idx = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "dmc",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&a1_dmc_sel2.hw
>> +		},
>> +		.num_parents = 1,
>> +		/*
>> +		 * This clock is used by DDR clock which setted in BL2
>> +		 * and is required by the platform to operate correctly.
>> +		 * Until the following condition are met, we need this clock to
>> +		 * be marked as critical:
>> +		 * a) Mark the clock used by a firmware resource, if possible
>> +		 * b) CCF has a clock hand-off mechanism to make the sure the
>> +		 *    clock stays on until the proper driver comes along
>> +		 */
>> +		.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
>> +	},
>> +};
> 
> Should you put all this DMC stuff in RO until you got a driver for it ?
OK, replace as clk_regmap_gate_ro_ops
> 
[ ... ]
>> +
>> +static int meson_a1_periphs_probe(struct platform_device *pdev)
>> +{
>> +	int ret;
>> +
>> +	ret = meson_eeclkc_probe(pdev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
>> +}
> 
> Again this function is function is useless and it makes me wonder if you
> should really be using meson_eeclkc_probe()
> 
> This makes you use syscon which is not correct unless you have a good
> reason ?
> 
If it can not use the meson_eeclkc_probe(), I will realize a probe 
function which is mostly duplicate with meson_eeclkc_probe() except 
"syscon_node_to_regmap"

Maybe another common probe function and a new file are required for A1 
three drivers? （include the CPU clock driver）

Or using meson_eeclkc_probe is more easier?

> Is there anything but clocks and resets in these register region ?
No, there is only clocks in the register region.
the same does the PLL register region.
> 
>> +
>> +static const struct meson_eeclkc_data a1_periphs_data = {
>> +		.regmap_clks = a1_periphs_regmaps,
>> +		.regmap_clk_num = ARRAY_SIZE(a1_periphs_regmaps),
>> +		.hw_onecell_data = &a1_periphs_hw_onecell_data,
>> +};
>> +static const struct of_device_id clkc_match_table[] = {
>> +	{
>> +		.compatible = "amlogic,a1-periphs-clkc",
>> +		.data = &a1_periphs_data
>> +	},
>> +	{ /* sentinel */ }
>> +};
>> +
>> +static struct platform_driver a1_driver = {
>> +	.probe		= meson_a1_periphs_probe,
>> +	.driver		= {
>> +		.name	= "a1-periphs-clkc",
>> +		.of_match_table = clkc_match_table,
>> +	},
>> +};
>> +
>> +builtin_platform_driver(a1_driver);
>> diff --git a/drivers/clk/meson/a1.h b/drivers/clk/meson/a1.h
>> new file mode 100644
>> index 0000000..1ae5e04
>> --- /dev/null
>> +++ b/drivers/clk/meson/a1.h
>> @@ -0,0 +1,120 @@
>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
>> +/*
>> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
>> + */
>> +
>> +#ifndef __A1_H
>> +#define __A1_H
>> +
>> +/* peripheral clock controller register offset */
>> +#define SYS_OSCIN_CTRL			0x0
>> +#define RTC_BY_OSCIN_CTRL0		0x4
>> +#define RTC_BY_OSCIN_CTRL1		0x8
>> +#define RTC_CTRL			0xc
>> +#define SYS_CLK_CTRL0			0x10
>> +#define AXI_CLK_CTRL0			0x14
>> +#define SYS_CLK_EN0			0x1c
>> +#define SYS_CLK_EN1			0x20
>> +#define AXI_CLK_EN			0x24
>> +#define DSPA_CLK_EN			0x28
>> +#define DSPB_CLK_EN			0x2c
>> +#define DSPA_CLK_CTRL0			0x30
>> +#define DSPB_CLK_CTRL0			0x34
>> +#define CLK12_24_CTRL			0x38
>> +#define GEN_CLK_CTRL			0x3c
>> +#define TIMESTAMP_CTRL0			0x40
>> +#define TIMESTAMP_CTRL1			0x44
>> +#define TIMESTAMP_CTRL2			0x48
>> +#define TIMESTAMP_VAL0			0x4c
>> +#define TIMESTAMP_VAL1			0x50
>> +#define TIMEBASE_CTRL0			0x54
>> +#define TIMEBASE_CTRL1			0x58
>> +#define SAR_ADC_CLK_CTRL		0xc0
>> +#define PWM_CLK_AB_CTRL			0xc4
>> +#define PWM_CLK_CD_CTRL			0xc8
>> +#define PWM_CLK_EF_CTRL			0xcc
>> +#define SPICC_CLK_CTRL			0xd0
>> +#define TS_CLK_CTRL			0xd4
>> +#define SPIFC_CLK_CTRL			0xd8
>> +#define USB_BUSCLK_CTRL			0xdc
>> +#define SD_EMMC_CLK_CTRL		0xe0
>> +#define CECA_CLK_CTRL0			0xe4
>> +#define CECA_CLK_CTRL1			0xe8
>> +#define CECB_CLK_CTRL0			0xec
>> +#define CECB_CLK_CTRL1			0xf0
>> +#define PSRAM_CLK_CTRL			0xf4
>> +#define DMC_CLK_CTRL			0xf8
>> +#define FCLK_DIV1_SEL			0xfc
>> +#define TST_CTRL			0x100
>> +
>> +#define CLKID_XTAL_CLKTREE		0
>> +#define CLKID_SYS_A_SEL			89
>> +#define CLKID_SYS_A_DIV			90
>> +#define CLKID_SYS_A			91
>> +#define CLKID_SYS_B_SEL			92
>> +#define CLKID_SYS_B_DIV			93
>> +#define CLKID_SYS_B			94
>> +#define CLKID_DSPA_A_SEL		95
>> +#define CLKID_DSPA_A_DIV		96
>> +#define CLKID_DSPA_A			97
>> +#define CLKID_DSPA_B_SEL		98
>> +#define CLKID_DSPA_B_DIV		99
>> +#define CLKID_DSPA_B			100
>> +#define CLKID_DSPB_A_SEL		101
>> +#define CLKID_DSPB_A_DIV		102
>> +#define CLKID_DSPB_A			103
>> +#define CLKID_DSPB_B_SEL		104
>> +#define CLKID_DSPB_B_DIV		105
>> +#define CLKID_DSPB_B			106
>> +#define CLKID_RTC_32K_CLKIN		107
>> +#define CLKID_RTC_32K_DIV		108
>> +#define CLKID_RTC_32K_XTAL		109
>> +#define CLKID_RTC_32K_SEL		110
>> +#define CLKID_CECB_32K_CLKIN		111
>> +#define CLKID_CECB_32K_DIV		112
>> +#define CLKID_CECB_32K_SEL_PRE		113
>> +#define CLKID_CECB_32K_SEL		114
>> +#define CLKID_CECA_32K_CLKIN		115
>> +#define CLKID_CECA_32K_DIV		116
>> +#define CLKID_CECA_32K_SEL_PRE		117
>> +#define CLKID_CECA_32K_SEL		118
>> +#define CLKID_DIV2_PRE			119
>> +#define CLKID_24M_DIV2			120
>> +#define CLKID_GEN_SEL			121
>> +#define CLKID_GEN_DIV			122
>> +#define CLKID_SARADC_DIV		123
>> +#define CLKID_PWM_A_SEL			124
>> +#define CLKID_PWM_A_DIV			125
>> +#define CLKID_PWM_B_SEL			126
>> +#define CLKID_PWM_B_DIV			127
>> +#define CLKID_PWM_C_SEL			128
>> +#define CLKID_PWM_C_DIV			129
>> +#define CLKID_PWM_D_SEL			130
>> +#define CLKID_PWM_D_DIV			131
>> +#define CLKID_PWM_E_SEL			132
>> +#define CLKID_PWM_E_DIV			133
>> +#define CLKID_PWM_F_SEL			134
>> +#define CLKID_PWM_F_DIV			135
>> +#define CLKID_SPICC_SEL			136
>> +#define CLKID_SPICC_DIV			137
>> +#define CLKID_SPICC_SEL2		138
>> +#define CLKID_TS_DIV			139
>> +#define CLKID_SPIFC_SEL			140
>> +#define CLKID_SPIFC_DIV			141
>> +#define CLKID_SPIFC_SEL2		142
>> +#define CLKID_USB_BUS_SEL		143
>> +#define CLKID_USB_BUS_DIV		144
>> +#define CLKID_SD_EMMC_SEL		145
>> +#define CLKID_SD_EMMC_DIV		146
>> +#define CLKID_SD_EMMC_SEL2		147
>> +#define CLKID_PSRAM_SEL			148
>> +#define CLKID_PSRAM_DIV			149
>> +#define CLKID_PSRAM_SEL2		150
>> +#define CLKID_DMC_SEL			151
>> +#define CLKID_DMC_DIV			152
>> +#define CLKID_DMC_SEL2			153
>> +#define NR_CLKS				154
>> +
>> +#include <dt-bindings/clock/a1-clkc.h>
>> +
>> +#endif /* __A1_H */
> 
> .
> 
