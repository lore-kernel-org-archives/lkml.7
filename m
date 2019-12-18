Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2D0C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 07:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8801421582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 07:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfLRHbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 02:31:34 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:61988 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfLRHbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 02:31:34 -0500
Received: from [10.28.39.99] (10.28.39.99) by mail-sz.amlogic.com (10.28.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Wed, 18 Dec
 2019 15:20:49 +0800
Subject: Re: [PATCH v4 6/6] clk: meson: a1: add support for Amlogic A1
 Peripheral clock driver
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
References: <20191206074052.15557-1-jian.hu@amlogic.com>
 <20191206074052.15557-7-jian.hu@amlogic.com>
 <1j36dplsec.fsf@starbuckisacylon.baylibre.com>
From:   Jian Hu <jian.hu@amlogic.com>
Message-ID: <fc5ab1b2-d4ee-0ebd-4788-4f0ae6d375bf@amlogic.com>
Date:   Wed, 18 Dec 2019 15:20:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <1j36dplsec.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.39.99]
X-ClientProxiedBy: mail-sz.amlogic.com (10.28.11.5) To mail-sz.amlogic.com
 (10.28.11.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/12/12 19:01, Jerome Brunet wrote:
> 
> On Fri 06 Dec 2019 at 08:40, Jian Hu <jian.hu@amlogic.com> wrote:
> 
>> Add Amlogic Meson A1 peripheral clock driver, it depends
>> on the A1 PLL driver.
>>
>> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
>> ---
>>   drivers/clk/meson/Kconfig  |   10 +
>>   drivers/clk/meson/Makefile |    1 +
>>   drivers/clk/meson/a1.c     | 2246 ++++++++++++++++++++++++++++++++++++
>>   drivers/clk/meson/a1.h     |  120 ++
>>   4 files changed, 2377 insertions(+)
>>   create mode 100644 drivers/clk/meson/a1.c
>>   create mode 100644 drivers/clk/meson/a1.h
>>
>> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
>> index 14e7936ae18e..d6b2b51316b7 100644
>> --- a/drivers/clk/meson/Kconfig
>> +++ b/drivers/clk/meson/Kconfig
>> @@ -103,6 +103,16 @@ config COMMON_CLK_A1_PLL
>>   	  Support for the PLL clock controller on Amlogic A113L device,
>>   	  aka a1. Say Y if you want PLL to work.
>>   
>> +config COMMON_CLK_A1
>> +	bool
>> +	depends on ARCH_MESON
>> +	select COMMON_CLK_MESON_EE_CLKC
>> +	select COMMON_CLK_MESON_DUALDIV
>> +	select COMMON_CLK_MESON_REGMAP
>> +	help
>> +	  Support for the Peripheral clock controller on Amlogic A113L device,
>> +	  aka a1. Say Y if you want Peripherals to work.
>> +
>>   config COMMON_CLK_G12A
>>   	bool
>>   	depends on ARCH_MESON
>> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
>> index 71d3b8e6fb8a..0f3890030118 100644
>> --- a/drivers/clk/meson/Makefile
>> +++ b/drivers/clk/meson/Makefile
>> @@ -17,6 +17,7 @@ obj-$(CONFIG_COMMON_CLK_MESON_VID_PLL_DIV) += vid-pll-div.o
>>   obj-$(CONFIG_COMMON_CLK_AXG) += axg.o axg-aoclk.o
>>   obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
>>   obj-$(CONFIG_COMMON_CLK_A1_PLL) += a1-pll.o
>> +obj-$(CONFIG_COMMON_CLK_A1) += a1.o
>>   obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
>>   obj-$(CONFIG_COMMON_CLK_G12A) += g12a.o g12a-aoclk.o
>>   obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
>> diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
>> new file mode 100644
>> index 000000000000..76fa5a9e74a5
>> --- /dev/null
>> +++ b/drivers/clk/meson/a1.c
>> @@ -0,0 +1,2246 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
>> + * Author: Jian Hu <jian.hu@amlogic.com>
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include "a1.h"
>> +#include "clk-dualdiv.h"
>> +#include "meson-eeclk.h"
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
>> +		.ops = &clk_regmap_gate_ro_ops,
>> +		.parent_data = &(const struct clk_parent_data) {
>> +			.fw_name = "xtal",
>> +		},
>> +		.num_parents = 1,
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_xtal_usb_phy = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = SYS_OSCIN_CTRL,
>> +		.bit_idx = 2,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "xtal_usb_phy",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_data = &(const struct clk_parent_data) {
>> +			.fw_name = "xtal",
>> +		},
>> +		.num_parents = 1,
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_xtal_usb_ctrl = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = SYS_OSCIN_CTRL,
>> +		.bit_idx = 3,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "xtal_usb_ctrl",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_data = &(const struct clk_parent_data) {
>> +			.fw_name = "xtal",
>> +		},
>> +		.num_parents = 1,
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_xtal_hifipll = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = SYS_OSCIN_CTRL,
>> +		.bit_idx = 4,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "xtal_hifipll",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_data = &(const struct clk_parent_data) {
>> +			.fw_name = "xtal",
>> +		},
>> +		.num_parents = 1,
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_xtal_syspll = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = SYS_OSCIN_CTRL,
>> +		.bit_idx = 5,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "xtal_syspll",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_data = &(const struct clk_parent_data) {
>> +			.fw_name = "xtal",
>> +		},
>> +		.num_parents = 1,
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_xtal_dds = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = SYS_OSCIN_CTRL,
>> +		.bit_idx = 6,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "xtal_dds",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_data = &(const struct clk_parent_data) {
>> +			.fw_name = "xtal",
>> +		},
>> +		.num_parents = 1,
>> +	},
>> +};
>> +
>> +static const struct clk_parent_data sys_clk_parents[] = {
>> +	{ .fw_name = "xtal" },
>> +	{ .fw_name = "fclk_div2"},
>> +	{ .fw_name = "fclk_div3"},
>> +	{ .fw_name = "fclk_div5"},
>> +};
>> +
>> +static struct clk_regmap a1_sys_b_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = SYS_CLK_CTRL0,
>> +		.mask = 0x7,
>> +		.shift = 26,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "sys_b_sel",
>> +		.ops = &clk_regmap_mux_ro_ops,
>> +		.parent_data = sys_clk_parents,
>> +		.num_parents = ARRAY_SIZE(sys_clk_parents),
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_sys_b_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = SYS_CLK_CTRL0,
>> +		.shift = 16,
>> +		.width = 10,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "sys_b_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&a1_sys_b_sel.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_sys_b = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = SYS_CLK_CTRL0,
>> +		.bit_idx = 29,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "sys_b",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&a1_sys_b_div.hw
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
>> +		.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_sys_a_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = SYS_CLK_CTRL0,
>> +		.mask = 0x7,
>> +		.shift = 10,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "sys_a_sel",
>> +		.ops = &clk_regmap_mux_ro_ops,
>> +		.parent_data = sys_clk_parents,
>> +		.num_parents = ARRAY_SIZE(sys_clk_parents),
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_sys_a_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = SYS_CLK_CTRL0,
>> +		.shift = 0,
>> +		.width = 10,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "sys_a_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&a1_sys_a_sel.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_sys_a = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = SYS_CLK_CTRL0,
>> +		.bit_idx = 13,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "sys_a",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&a1_sys_a_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		/*
>> +		 * This clock is used by APB bus which setted in Romcode
>> +		 * and is required by the platform to operate correctly.
> 
> #1 It weird that both sys_a and sys_b are critical, Only the leaf needs
>   to be critical which, AFAICT, is a1_sys_clk.
> 
> #2 Like on the other controller: What the clock is needed for needs is
>   needed for for each critical clock, but the explanation below needs to
>   appear only once and can be refered to afterward.
> 
OK, I will remove the flag CLK_IS_CRITICAL for a1_sys_a and a1_sys_b.
And add it for a1_sys_clk.
>> +		 * Until the following condition are met, we need this clock to
>> +		 * be marked as critical:
>> +		 * a) Mark the clock used by a firmware resource, if possible
>> +		 * b) CCF has a clock hand-off mechanism to make the sure the
>> +		 *    clock stays on until the proper driver comes along
>> +		 */
>> +		.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
>> +	},
>> +};
>> +
>> +static struct clk_regmap a1_sys_clk = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = SYS_CLK_CTRL0,
>> +		.mask = 0x1,
>> +		.shift = 31,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "sys_clk",
>> +		.ops = &clk_regmap_mux_ro_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&a1_sys_a.hw, &a1_sys_b.hw,
>> +		},
>> +		.num_parents = 2,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
[...]
> .
> 
