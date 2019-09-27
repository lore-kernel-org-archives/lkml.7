Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31A1C352A9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 03:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C034207FF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 03:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbfI0DLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 23:11:42 -0400
Received: from mail-sz.amlogic.com ([211.162.65.117]:45651 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbfI0DLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 23:11:41 -0400
Received: from [10.28.19.114] (10.28.19.114) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Fri, 27 Sep
 2019 11:11:37 +0800
Subject: Re: [PATCH 2/2] clk: meson: a1: add support for Amlogic A1 clock
 driver
To:     Stephen Boyd <sboyd@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Rob Herring <robh@kernel.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        <devicetree@vger.kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        <linux-kernel@vger.kernel.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <1569411888-98116-1-git-send-email-jian.hu@amlogic.com>
 <1569411888-98116-3-git-send-email-jian.hu@amlogic.com>
 <20190925131232.4751020640@mail.kernel.org>
From:   Jian Hu <jian.hu@amlogic.com>
Message-ID: <8351489a-f91e-be08-7fcc-e2a90c6e87f0@amlogic.com>
Date:   Fri, 27 Sep 2019 11:11:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190925131232.4751020640@mail.kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.19.114]
X-ClientProxiedBy: mail-sz.amlogic.com (10.28.11.5) To mail-sz.amlogic.com
 (10.28.11.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Stephen

Thank you for review

On 2019/9/25 21:12, Stephen Boyd wrote:
> Quoting Jian Hu (2019-09-25 04:44:48)
>> The Amlogic A1 clock includes three parts:
>> peripheral clocks, pll clocks, CPU clocks.
>> sys pll and CPU clocks will be sent in next patch.
>>
>> Unlike the previous series, there is no EE/AO domain
>> in A1 CLK controllers.
>>
>> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
>> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> 
> This second name didn't send the patch. Please follow the signoff
> procedures documented in Documentation/process/submitting-patches.rst
> 
>> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
>> index 16d7614..a48f67d 100644
>> --- a/arch/arm64/Kconfig.platforms
>> +++ b/arch/arm64/Kconfig.platforms
>> @@ -138,6 +138,7 @@ config ARCH_MESON
>>          select COMMON_CLK_AXG
>>          select COMMON_CLK_G12A
>>          select MESON_IRQ_GPIO
>> +       select COMMON_CLK_A1
> 
> Sort?
ok, I will put it behind COMMON_CLK_AXG
> 
>>          help
>>            This enables support for the arm64 based Amlogic SoCs
>>            such as the s905, S905X/D, S912, A113X/D or S905X/D2
>> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
>> index dabeb43..e6cb4c3 100644
>> --- a/drivers/clk/meson/Kconfig
>> +++ b/drivers/clk/meson/Kconfig
>> @@ -107,3 +107,13 @@ config COMMON_CLK_G12A
>>          help
>>            Support for the clock controller on Amlogic S905D2, S905X2 and S905Y2
>>            devices, aka g12a. Say Y if you want peripherals to work.
>> +
>> +config COMMON_CLK_A1
> 
> Probably should be placed somewhere alphabetically in this file?
ok, I will put it behind COMMON_CLK_AXG_AUDIO
> 
>> +       bool
>> +       depends on ARCH_MESON
>> +       select COMMON_CLK_MESON_REGMAP
>> +       select COMMON_CLK_MESON_DUALDIV
>> +       select COMMON_CLK_MESON_PLL
>> +       help
>> +         Support for the clock controller on Amlogic A113L device,
>> +         aka a1. Say Y if you want peripherals to work.
>> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
>> index 3939f21..6be3a8f 100644
>> --- a/drivers/clk/meson/Makefile
>> +++ b/drivers/clk/meson/Makefile
>> @@ -19,3 +19,4 @@ obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
>>   obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
>>   obj-$(CONFIG_COMMON_CLK_G12A) += g12a.o g12a-aoclk.o
>>   obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
>> +obj-$(CONFIG_COMMON_CLK_A1) += a1.o
> 
> I would guess this should be sorted on Kconfig name in this file?
ok, I will put it behind COMMON_CLK_AXG_AUDIO
> 
>> diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
>> new file mode 100644
>> index 0000000..26edae0f
>> --- /dev/null
>> +++ b/drivers/clk/meson/a1.c
>> @@ -0,0 +1,2617 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/init.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/of_address.h>
>> +#include "clk-mpll.h"
>> +#include "clk-pll.h"
>> +#include "clk-regmap.h"
>> +#include "vid-pll-div.h"
>> +#include "clk-dualdiv.h"
>> +#include "meson-eeclk.h"
>> +#include "a1.h"
>> +
> [...]
>> +
>> +/*
>> + * The Meson A1 HIFI PLL is 614.4M, it requires
>> + * a strict register sequence to enable the PLL.
>> + * set meson_clk_pcie_pll_ops as its ops
> 
> Please remove this last line as it's obvious from the code what ops are
> used.
> 
ok, I will remove it.
>> + */
>> +static struct clk_regmap a1_hifi_pll = {
>> +       .data = &(struct meson_clk_pll_data){
>> +               .en = {
>> +                       .reg_off = ANACTRL_HIFIPLL_CTRL0,
>> +                       .shift   = 28,
>> +                       .width   = 1,
>> +               },
>> +               .m = {
>> +                       .reg_off = ANACTRL_HIFIPLL_CTRL0,
>> +                       .shift   = 0,
>> +                       .width   = 8,
>> +               },
>> +               .n = {
>> +                       .reg_off = ANACTRL_HIFIPLL_CTRL0,
>> +                       .shift   = 10,
>> +                       .width   = 5,
>> +               },
>> +               .frac = {
>> +                       .reg_off = ANACTRL_HIFIPLL_CTRL1,
>> +                       .shift   = 0,
>> +                       .width   = 19,
>> +               },
>> +               .l = {
>> +                       .reg_off = ANACTRL_HIFIPLL_STS,
>> +                       .shift   = 31,
>> +                       .width   = 1,
>> +               },
>> +               .table = a1_hifi_pll_params_table,
>> +               .init_regs = a1_hifi_init_regs,
>> +               .init_count = ARRAY_SIZE(a1_hifi_init_regs),
>> +       },
>> +       .hw.init = &(struct clk_init_data){
>> +               .name = "hifi_pll",
>> +               .ops = &meson_clk_pcie_pll_ops,
>> +               .parent_hws = (const struct clk_hw *[]) {
>> +                       &a1_xtal_hifipll.hw
>> +               },
>> +               .num_parents = 1,
>> +       },
>> +};
>> +
> [..]
>> +
>> +static struct clk_regmap a1_fclk_div2 = {
>> +       .data = &(struct clk_regmap_gate_data){
>> +               .offset = ANACTRL_FIXPLL_CTRL0,
>> +               .bit_idx = 21,
>> +       },
>> +       .hw.init = &(struct clk_init_data){
>> +               .name = "fclk_div2",
>> +               .ops = &clk_regmap_gate_ops,
>> +               .parent_hws = (const struct clk_hw *[]) {
>> +                       &a1_fclk_div2_div.hw
>> +               },
>> +               .num_parents = 1,
>> +               /*
>> +                * add CLK_IS_CRITICAL flag to avoid being disabled by clk core
>> +                * or its children clocks.
> 
> This comment is useless. Please replace it with an actual reason for
> keeping the clk on instead of describing what the flag does.
> 
ok, The actual reason is it should not change at runtime.
>> +                */
>> +               .flags = CLK_IS_CRITICAL,
>> +       },
>> +};
>> +
> [..]
>> +static struct clk_regmap a1_dmc = {
>> +       .data = &(struct clk_regmap_gate_data){
>> +               .offset = DMC_CLK_CTRL,
>> +               .bit_idx = 8,
>> +       },
>> +       .hw.init = &(struct clk_init_data) {
>> +               .name = "dmc",
>> +               .ops = &clk_regmap_gate_ops,
>> +               .parent_hws = (const struct clk_hw *[]) {
>> +                       &a1_dmc_sel2.hw
>> +               },
>> +               .num_parents = 1,
>> +               /*
>> +                * add CLK_IGNORE_UNUSED to avoid hangup
>> +                * DDR clock should not change at runtime
>> +                */
>> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> 
> So not CLK_IS_CRITICAL?
Yes, CLK_IS_CRITICAL is better, I will change it.
> 
>> +       },
>> +};
>> +
> [...]
>> +
>> +/*
>> + * cpu clock register base address is 0xfd000080
>> + */
>> +static struct clk_regmap *const a1_cpu_clk_regmaps[] = {
>> +       /* TODO */
> 
> Can it be done?
I plan to compelte cpu clock with the DVFS verified. And  Some 
peripheral devices rely on this patch to send. I prefer to do it in the 
next patch.
> 
>> +};
> 
> .
> 
