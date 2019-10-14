Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2896ECE58E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BAA220854
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732238AbfJNNms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 09:42:48 -0400
Received: from mail-sz.amlogic.com ([211.162.65.117]:29712 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbfJNNms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:42:48 -0400
Received: from [10.28.19.114] (10.28.19.114) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 14 Oct
 2019 21:42:32 +0800
Subject: Re: [PATCH 2/2] clk: meson: a1: add support for Amlogic A1 clock
 driver
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Neil Armstrong <narmstrong@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        <linux-clk@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1569411888-98116-1-git-send-email-jian.hu@amlogic.com>
 <1569411888-98116-3-git-send-email-jian.hu@amlogic.com>
 <1j1rw4mmzw.fsf@starbuckisacylon.baylibre.com>
 <a830a0d1-680c-86ec-e858-4470c67865e2@amlogic.com>
 <1jimpd27cb.fsf@starbuckisacylon.baylibre.com>
 <5fd57563-0c34-be14-132a-74fd2c5a5275@amlogic.com>
 <052b0a5c-c913-a9ff-65b9-5b7eb0aecd6e@amlogic.com>
 <1jsgnz20jq.fsf@starbuckisacylon.baylibre.com>
From:   Jian Hu <jian.hu@amlogic.com>
Message-ID: <8ae988c2-68f5-603e-843b-9cd70e4d4349@amlogic.com>
Date:   Mon, 14 Oct 2019 21:42:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1jsgnz20jq.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
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

sorry, it's my problem.

I did not discribe clearly the issue.

On 2019/10/11 15:39, Jerome Brunet wrote:
> 
> On Tue 08 Oct 2019 at 10:03, Jian Hu <jian.hu@amlogic.com> wrote:
> 
>> Hi, Jerome
>>
>> PLL clocks and peripheral clocks rely on each other.
>>
>> for fixed_pll, we can describe its parent like this:
>>
>> xtal-->xtal_fixpll-->fixed_dco-->fixed_pll
>>
>> xtal fixpll is belong to peripheral region.
>> fixed_pll/fclk_div2/fclk_div3 is belong to PLL region.
>>
>> if PLL clocks probe first, it will fail to get xtal_fixpll.
>> we can not get fixed_dco's parent clock.
>>
>> if peripheral clocks probe first, it will fail to get
>> fixed_pll clocks. A lot of peripheral clocks parent are fclk_div2/3/5/7.
>> and we can not get fclk_div2/3/5/7 clocks.
> 
> What does "fail" mean ?
> I intended to get clock using devm_clk_get API in each driver, In this 
scene，it will get failed because of the clock not being reigstered. In 
fact, we could not use devm_clk_get.
>>
>> I can think of two solutions:
>> 1) Do not describe xtal_fixpll, xtal_hifipll.
>>     that is to say, do not decribe the SYS_OSCIN_CTRL register.
>>
>> 2) Put peripheral and pll clock driver in one driver.
> 
> Those are work arounds. Actually fixing the problem is usually
> preferable.
> 
>   So if rephrase your problem:
> 
>   * We have 2 clock controllers (A and B)
>   * Clock are passed between the controllers using DT
>   * We have a PLL in controller B which is used by clocks in
>     controller A.
>   * the PLL parent clock is in controller A.
> 
Yeah, it is the scene.
> => So if I understand correctly you are saying that it will "fail"
> because there is a circular dependency between controller A and B, right
> ?
> 
> Do you have evidence that your problem comes from this circular
> dependency ?
> 
I have realized the peripheral driver and PLL drivers,

PLL driver probes first, Peripheral clock driver is the second.

In addition，for A1 SoC， it will not work using meson_clk_pll_ops,

it needs strictly sequence，so maybe another ops is required.hifi pll 
will be sent with sys pll and CPU clock driver.
> AFAIK, CCF will orphan the clock and continue if the parent is not
> available. Later, when the parent comes up, the orphan will be
> reparented.
> 
> IOW, the problem you are reporting should already be covered by CCF.
> 
>>
>> And  which sulution is better above two?
> 
> Neither, I'm afraid
> 
>>
>> Or maybe other good ideas for it?
> 
> My bet would be that an important clocks (maybe more than 1) is being
> gated during the init process.
> 
> Maybe you should try the command line parameter "clk_ignore_unused"
> until you get things running with your 2 controllers.
> 
>>
>> On 2019/9/29 17:38, Jian Hu wrote:
>>>
>>>
>>> On 2019/9/27 21:32, Jerome Brunet wrote:
>>>>
>>>> On Fri 27 Sep 2019 at 11:52, Jian Hu <jian.hu@amlogic.com> wrote:
>>>>
>>>>> Hi, Jerome
>>>>>
>>>>> Thank you for review.
>>>>>
>>>>> On 2019/9/25 23:09, Jerome Brunet wrote:
>>>>>> On Wed 25 Sep 2019 at 19:44, Jian Hu <jian.hu@amlogic.com> wrote:
>>>>>>
>>>>>>> The Amlogic A1 clock includes three parts:
>>>>>>> peripheral clocks, pll clocks, CPU clocks.
>>>>>>> sys pll and CPU clocks will be sent in next patch.
>>>>>>>
>>>>>>> Unlike the previous series, there is no EE/AO domain
>>>>>>> in A1 CLK controllers.
>>>>>>>
>>>>>>> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
>>>>>>> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
>>>>>>> ---
>>>>>>>     arch/arm64/Kconfig.platforms |    1 +
>>>>>>>     drivers/clk/meson/Kconfig    |   10 +
>>>>>>>     drivers/clk/meson/Makefile   |    1 +
>>>>>>>     drivers/clk/meson/a1.c       | 2617
>>>>>>> ++++++++++++++++++++++++++++++++++++++++++
>>>>>>>     drivers/clk/meson/a1.h       |  172 +++
>>>>>>>     5 files changed, 2801 insertions(+)
>>>>>>>     create mode 100644 drivers/clk/meson/a1.c
>>>>>>>     create mode 100644 drivers/clk/meson/a1.h
>>>>>>>
>> [...]
>>>>>>> diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
>>>>>>> new file mode 100644
>>>>>>> index 0000000..26edae0f
>>>>>>> --- /dev/null
>>>>>>> +++ b/drivers/clk/meson/a1.c
>>>>>>> @@ -0,0 +1,2617 @@
>>>>>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>>>>>> +/*
>>>>>>> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
>>>>>>> + */
>>>>>>> +
>>>>>>> +#include <linux/clk-provider.h>
>>>>>>> +#include <linux/init.h>
>>>>>>> +#include <linux/of_device.h>
>>>>>>> +#include <linux/platform_device.h>
>>>>>>> +#include <linux/of_address.h>
>>>>>>> +#include "clk-mpll.h"
>>>>>>> +#include "clk-pll.h"
>>>>>>> +#include "clk-regmap.h"
>>>>>>> +#include "vid-pll-div.h"
>>>>>>> +#include "clk-dualdiv.h"
>>>>>>> +#include "meson-eeclk.h"
>>>>>>> +#include "a1.h"
>>>>>>> +
>>>>>>> +/* PLLs clock in gates, its parent is xtal */
>>>>>>> +static struct clk_regmap a1_xtal_clktree = {
>>>>>>> +    .data = &(struct clk_regmap_gate_data){
>>>>>>> +        .offset = SYS_OSCIN_CTRL,
>>>>>>> +        .bit_idx = 0,
>>>>>>> +    },
>>>>>>> +    .hw.init = &(struct clk_init_data) {
>>>>>>> +        .name = "xtal_clktree",
>>>>>>> +        .ops = &clk_regmap_gate_ops,
>>>>>>> +        .parent_data = &(const struct clk_parent_data) {
>>>>>>> +            .fw_name = "xtal",
>>>>>>> +        },
>>>>>>> +        .num_parents = 1,
>>>>>>> +        .flags = CLK_IS_CRITICAL,
>>>>>>
>>>>>> Is CCF even expected to touch this ever ? what about RO ops ?
>>>>>> Please review your other clocks with this in mind
>>>>>>
>>>>> the clock should not be changed at runtime.clk_regmap_gate_ro_ops
>>>>> is a good idea. Set RO ops and remove the CLK_IS_CRITICAL flag.
>>>>>>> +    },
>>>>>>> +};
>>>>>>> +
>>>>>>> +static struct clk_regmap a1_xtal_fixpll = {
>>>>>>> +    .data = &(struct clk_regmap_gate_data){
>>>>>>> +        .offset = SYS_OSCIN_CTRL,
>>>>>>> +        .bit_idx = 1,
>>>>>>> +    },
>>>>>>> +    .hw.init = &(struct clk_init_data) {
>>>>>>> +        .name = "xtal_fixpll",
>>>>>>> +        .ops = &clk_regmap_gate_ops,
>>>>>>> +        .parent_data = &(const struct clk_parent_data) {
>>>>>>> +            .fw_name = "xtal",
>>>>>>> +        },
>>>>>>> +        .num_parents = 1,
>>>>>>> +        .flags = CLK_IS_CRITICAL,
>>>>>>> +    },
>>>>>>> +};
>>>>>>> +
>>>>>>> +static struct clk_regmap a1_xtal_usb_phy = {
>>>>>>> +    .data = &(struct clk_regmap_gate_data){
>>>>>>> +        .offset = SYS_OSCIN_CTRL,
>>>>>>> +        .bit_idx = 2,
>>>>>>> +    },
>>>>>>> +    .hw.init = &(struct clk_init_data) {
>>>>>>> +        .name = "xtal_usb_phy",
>>>>>>> +        .ops = &clk_regmap_gate_ops,
>>>>>>> +        .parent_data = &(const struct clk_parent_data) {
>>>>>>> +            .fw_name = "xtal",
>>>>>>> +        },
>>>>>>> +        .num_parents = 1,
>>>>>>> +        .flags = CLK_IS_CRITICAL,
>>>>>>
>>>>>> How is an USB clock critical to the system ?
>>>>>> Please review your other clocks with comment in mind ...
>>>>> the usb clock does not affect the system,
>>>>> remove the CLK_IS_CRITICAL flag
>>>>>>
>>>>>>> +    },
>>>>>>> +};
>>>>>>> +
>>>>>>> +static struct clk_regmap a1_xtal_usb_ctrl = {
>>>>>>> +    .data = &(struct clk_regmap_gate_data){
>>>>>>> +        .offset = SYS_OSCIN_CTRL,
>>>>>>> +        .bit_idx = 3,
>>>>>>> +    },
>>>>>>> +    .hw.init = &(struct clk_init_data) {
>>>>>>> +        .name = "xtal_usb_ctrl",
>>>>>>> +        .ops = &clk_regmap_gate_ops,
>>>>>>> +        .parent_data = &(const struct clk_parent_data) {
>>>>>>> +            .fw_name = "xtal",
>>>>>>> +        },
>>>>>>> +        .num_parents = 1,
>>>>>>> +        .flags = CLK_IS_CRITICAL,
>>>>>>> +    },
>>>>>>> +};
>>>>> the usb clock does not affect the system,
>>>>> remove the CLK_IS_CRITICAL flag
>>>>>>> +
>>>>>>> +static struct clk_regmap a1_xtal_hifipll = {
>>>>>>> +    .data = &(struct clk_regmap_gate_data){
>>>>>>> +        .offset = SYS_OSCIN_CTRL,
>>>>>>> +        .bit_idx = 4,
>>>>>>> +    },
>>>>>>> +    .hw.init = &(struct clk_init_data) {
>>>>>>> +        .name = "xtal_hifipll",
>>>>>>> +        .ops = &clk_regmap_gate_ops,
>>>>>>> +        .parent_data = &(const struct clk_parent_data) {
>>>>>>> +            .fw_name = "xtal",
>>>>>>> +        },
>>>>>>> +        .num_parents = 1,
>>>>>>> +        .flags = CLK_IS_CRITICAL,
>>>>>>> +    },
>>>>>>> +};
>>>>> CLK_IS_CRITICAL is need to lock hifi pll.
>>>>
>>>> That's not how CCF works, this falg is not ok here.
>>>> CCF will enable this clock before calling enable on your hifi pll
>>>>
>>> ok， I will remove it.
>>>>>>> +
>>>>>>> +static struct clk_regmap a1_xtal_syspll = {
>>>>>>> +    .data = &(struct clk_regmap_gate_data){
>>>>>>> +        .offset = SYS_OSCIN_CTRL,
>>>>>>> +        .bit_idx = 5,
>>>>>>> +    },
>>>>>>> +    .hw.init = &(struct clk_init_data) {
>>>>>>> +        .name = "xtal_syspll",
>>>>>>> +        .ops = &clk_regmap_gate_ops,
>>>>>>> +        .parent_data = &(const struct clk_parent_data) {
>>>>>>> +            .fw_name = "xtal",
>>>>>>> +        },
>>>>>>> +        .num_parents = 1,
>>>>>>> +        .flags = CLK_IS_CRITICAL,
>>>>>>> +    },
>>>>>>> +};
>>>>>>> +
>>>>> when CPU clock is at fixed clock, sys pll
>>>>> will be disabled, xtal_syspll will be disabled too.
>>>>> when setting sys pll, call clk_set_rate to lock
>>>>> sys pll, add RO ops to avoid disabling the clock
>>>>
>>>> Again not Ok.
>>>> If you mechanism to lock the PLL is properly implemented in the enable
>>>> callback of the sys pll, still kind of work around are not needed
>>>>
>>>> This has worked on the pll we had so far.
>>>>
>>> ok, I will remove it.
>>>>>
>>>>>>> +static struct clk_regmap a1_xtal_dds = {
>>>>>>> +    .data = &(struct clk_regmap_gate_data){
>>>>>>> +        .offset = SYS_OSCIN_CTRL,
>>>>>>> +        .bit_idx = 6,
>>>>>>> +    },
>>>>>>> +    .hw.init = &(struct clk_init_data) {
>>>>>>> +        .name = "xtal_dds",
>>>>>>> +        .ops = &clk_regmap_gate_ops,
>>>>>>> +        .parent_data = &(const struct clk_parent_data) {
>>>>>>> +            .fw_name = "xtal",
>>>>>>> +        },
>>>>>>> +        .num_parents = 1,
>>>>>>> +        .flags = CLK_IS_CRITICAL,
>>>>>>> +    },
>>>>>>> +};
>>>>> CLK_IS_CRITICAL is need to lock dds
>>>>>>> +
>>>>>>> +/* fixed pll = 1536M
>>>>>>> + *
>>>>>>> + * fixed pll ----- fclk_div2 = 768M
>>>>>>> + *           |
>>>>>>> + *           ----- fclk_div3 = 512M
>>>>>>> + *           |
>>>>>>> + *           ----- fclk_div5 = 307.2M
>>>>>>> + *           |
>>>>>>> + *           ----- fclk_div7 = 219.4M
>>>>>>> + */
>>>>>>
>>>>>> The framework will make those calculation ... you can remove this
>>>>>>
>>>>> ok, I will remote the comment.
>>>>>>> +static struct clk_regmap a1_fixed_pll_dco = {
>>>>>>> +    .data = &(struct meson_clk_pll_data){
>>>>>>> +        .en = {
>>>>>>> +            .reg_off = ANACTRL_FIXPLL_CTRL0,
>>>>>>> +            .shift   = 28,
>>>>>>> +            .width   = 1,
>>>>>>> +        },
>>>>>>> +        .m = {
>>>>>>> +            .reg_off = ANACTRL_FIXPLL_CTRL0,
>>>>>>> +            .shift   = 0,
>>>>>>> +            .width   = 8,
>>>>>>> +        },
>>>>>>> +        .n = {
>>>>>>> +            .reg_off = ANACTRL_FIXPLL_CTRL0,
>>>>>>> +            .shift   = 10,
>>>>>>> +            .width   = 5,
>>>>>>> +        },
>>>>>>> +        .frac = {
>>>>>>> +            .reg_off = ANACTRL_FIXPLL_CTRL1,
>>>>>>> +            .shift   = 0,
>>>>>>> +            .width   = 19,
>>>>>>> +        },
>>>>>>> +        .l = {
>>>>>>> +            .reg_off = ANACTRL_FIXPLL_CTRL0,
>>>>>>> +            .shift   = 31,
>>>>>>> +            .width   = 1,
>>>>>>> +        },
>>>>>>> +        .rst = {
>>>>>>> +            .reg_off = ANACTRL_FIXPLL_CTRL0,
>>>>>>> +            .shift   = 29,
>>>>>>> +            .width   = 1,
>>>>>>> +        },
>>>>>>> +    },
>>>>>>> +    .hw.init = &(struct clk_init_data){
>>>>>>> +        .name = "fixed_pll_dco",
>>>>>>> +        .ops = &meson_clk_pll_ro_ops,
>>>>>>> +        .parent_hws = (const struct clk_hw *[]) {
>>>>>>> +            &a1_xtal_fixpll.hw
>>>>>>> +        },
>>>>>>> +        .num_parents = 1,
>>>>>>> +    },
>>>>>>> +};
>>>>>>> +
>>>>>>> +static struct clk_regmap a1_fixed_pll = {
>>>>>>> +    .data = &(struct clk_regmap_gate_data){
>>>>>>> +        .offset = ANACTRL_FIXPLL_CTRL0,
>>>>>>> +        .bit_idx = 20,
>>>>>>> +    },
>>>>>>> +    .hw.init = &(struct clk_init_data) {
>>>>>>> +        .name = "fixed_pll",
>>>>>>> +        .ops = &clk_regmap_gate_ops,
>>>>>>> +        .parent_hws = (const struct clk_hw *[]) {
>>>>>>> +            &a1_fixed_pll_dco.hw
>>>>>>> +        },
>>>>>>> +        .num_parents = 1,
>>>>>>> +        .flags = CLK_IGNORE_UNUSED,
>>>>>>> +    },
>>>>>>> +};
>>>>>>> +
>>>>>>> +static const struct pll_params_table a1_hifi_pll_params_table[] = {
>>>>>>> +    PLL_PARAMS(128, 5), /* DCO = 614.4M */
>>>>>>> +};
>>>>>>> +
>>>>>>> +static const struct reg_sequence a1_hifi_init_regs[] = {
>>>>>>> +    { .reg = ANACTRL_HIFIPLL_CTRL1,    .def = 0x01800000 },
>>>>>>> +    { .reg = ANACTRL_HIFIPLL_CTRL2,    .def = 0x00001100 },
>>>>>>> +    { .reg = ANACTRL_HIFIPLL_CTRL3,    .def = 0x10022200 },
>>>>>>> +    { .reg = ANACTRL_HIFIPLL_CTRL4,    .def = 0x00301000 },
>>>>>>> +    { .reg = ANACTRL_HIFIPLL_CTRL0, .def = 0x01f19480 },
>>>>>>> +    { .reg = ANACTRL_HIFIPLL_CTRL0, .def = 0x11f19480, .delay_us =
>>>>>>> 10 },
>>>>>>> +    { .reg = ANACTRL_HIFIPLL_CTRL0,    .def = 0x15f11480, .delay_us
>>>>>>> = 40 },
>>>>>>> +    { .reg = ANACTRL_HIFIPLL_CTRL2,    .def = 0x00001140 },
>>>>>>> +    { .reg = ANACTRL_HIFIPLL_CTRL2,    .def = 0x00001100 },
>>>>>>> +};
>>>>>>> +
>>>>>>> +/*
>>>>>>> + * The Meson A1 HIFI PLL is 614.4M, it requires
>>>>>>> + * a strict register sequence to enable the PLL.
>>>>>>> + * set meson_clk_pcie_pll_ops as its ops
>>>>>>> + */
>>>>>>
>>>>>> Could you elaborate on this ? What need to be done to enable the clock
>>>>>> ?
>>>>>> Also the HIFI PLL used to be able to do a *LOT* of different rate which
>>>>>> might be desirable for audio use case. Why is this one restricted to
>>>>>> one
>>>>>> particular rate ?
>>>>>>
>>>>> The audio working frequency are 44.1khz, 48khz and 192khz.
>>>>>
>>>>> 614.4M can meet the three frequency.
>>>>>
>>>>> after the hifi pll, there are two dividers in Audio clock.
>>>>>
>>>>> 614.4M/3200 = 192khz
>>>>>
>>>>> 614.4M/12800 = 48khz
>>>>>
>>>>> 614,4M/13932 = 44.0999khz
>>>>
>>>> It does not really answer my question though.
>>>> You are locking a use case here, which is 32 bit sample width
>>>>
>>>> We have other constraint with the upstream audio driver, and we usually
>>>> looking for base frequency that a multiple of 768 (24*32).
>>>>
>>>> If you need your PLL to be set to a particular rate for a use case, the
>>>> correct way is "assigned-rate" in DT
>>>>
>>>> so the question still stands, the HIFI pll before was pretty easy to set
>>>> at a wide variety of rate (same as GP0) ... is it not the case anymore ?
>>>> If yes, could you decribe the constraints.
>>>>
>>>> All this took us a long time to figure out on our own, which is why I'd
>>>> prefer to get the proper constraints in from the beginning this time
>>>>
>>> ok, I will verify it and  describe the constraints about it
>>>>
>>>>>
>>>>>>> +static struct clk_regmap a1_hifi_pll = {
>>>>>>> +    .data = &(struct meson_clk_pll_data){
>>>>>>> +        .en = {
>>>>>>> +            .reg_off = ANACTRL_HIFIPLL_CTRL0,
>>>>>>> +            .shift   = 28,
>>>>>>> +            .width   = 1,
>>>>>>> +        },
>>>>>>> +        .m = {
>>>>>>> +            .reg_off = ANACTRL_HIFIPLL_CTRL0,
>>>>>>> +            .shift   = 0,
>>>>>>> +            .width   = 8,
>>>>>>> +        },
>>>>>>> +        .n = {
>>>>>>> +            .reg_off = ANACTRL_HIFIPLL_CTRL0,
>>>>>>> +            .shift   = 10,
>>>>>>> +            .width   = 5,
>>>>>>> +        },
>>>>>>> +        .frac = {
>>>>>>> +            .reg_off = ANACTRL_HIFIPLL_CTRL1,
>>>>>>> +            .shift   = 0,
>>>>>>> +            .width   = 19,
>>>>>>> +        },
>>>>>>> +        .l = {
>>>>>>> +            .reg_off = ANACTRL_HIFIPLL_STS,
>>>>>>> +            .shift   = 31,
>>>>>>> +            .width   = 1,
>>>>>>> +        },
>>>>>>> +        .table = a1_hifi_pll_params_table,
>>>>>>> +        .init_regs = a1_hifi_init_regs,
>>>>>>> +        .init_count = ARRAY_SIZE(a1_hifi_init_regs),
>>>>>>> +    },
>>>>>>> +    .hw.init = &(struct clk_init_data){
>>>>>>> +        .name = "hifi_pll",
>>>>>>> +        .ops = &meson_clk_pcie_pll_ops,
>>>>>>> +        .parent_hws = (const struct clk_hw *[]) {
>>>>>>> +            &a1_xtal_hifipll.hw
>>>>>>> +        },
>>>>>>> +        .num_parents = 1,
>>>>>>> +    },
>>>>>>> +};
>>>>>>> +
>>>>>>> +static struct clk_fixed_factor a1_fclk_div2_div = {
>>>>>>> +    .mult = 1,
>>>>>>> +    .div = 2,
>>>>>>> +    .hw.init = &(struct clk_init_data){
>>>>>>> +        .name = "fclk_div2_div",
>>>>>>> +        .ops = &clk_fixed_factor_ops,
>>>>>>> +        .parent_hws = (const struct clk_hw *[]) {
>>>>>>> +            &a1_fixed_pll.hw
>>>>>>> +        },
>>>>>>> +        .num_parents = 1,
>>>>>>> +    },
>>>>>>> +};
>>>>>>> +
>>>>>>> +static struct clk_regmap a1_fclk_div2 = {
>>>>>>> +    .data = &(struct clk_regmap_gate_data){
>>>>>>> +        .offset = ANACTRL_FIXPLL_CTRL0,
>>>>>>> +        .bit_idx = 21,
>>>>>>> +    },
>>>>>>> +    .hw.init = &(struct clk_init_data){
>>>>>>> +        .name = "fclk_div2",
>>>>>>> +        .ops = &clk_regmap_gate_ops,
>>>>>>> +        .parent_hws = (const struct clk_hw *[]) {
>>>>>>> +            &a1_fclk_div2_div.hw
>>>>>>> +        },
>>>>>>> +        .num_parents = 1,
>>>>>>> +        /*
>>>>>>> +         * add CLK_IS_CRITICAL flag to avoid being disabled by clk
>>>>>>> core
>>>>>>> +         * or its children clocks.
>>>>>>> +         */
>>>>>>
>>>>>> The meaning of this flag is already documented in clk-provider.h
>>>>>> The reason why you need this flag is lot more interesting here ...
>>>>>>
>>>>>> Same below
>>>>> ok, I will replace new comments here.
>>>>>>
>>>>>>> +        .flags = CLK_IS_CRITICAL,
>>>>>>> +    },
>>>>>>> +};
>>>>>>> +
>>>>>>> +static struct clk_fixed_factor a1_fclk_div3_div = {
>>>>>>> +    .mult = 1,
>>>>>>> +    .div = 3,
>>>>>>> +    .hw.init = &(struct clk_init_data){
>>>>>>> +        .name = "fclk_div3_div",
>>>>>>> +        .ops = &clk_fixed_factor_ops,
>>>>>>> +        .parent_hws = (const struct clk_hw *[]) {
>>>>>>> +            &a1_fixed_pll.hw
>>>>>>> +        },
>>>>>>> +        .num_parents = 1,
>>>>>>> +    },
>>>>>>> +};
>>>>>>> +
>>>>>>> +static struct clk_regmap a1_fclk_div3 = {
>>>>>>> +    .data = &(struct clk_regmap_gate_data){
>>>>>>> +        .offset = ANACTRL_FIXPLL_CTRL0,
>>>>>>> +        .bit_idx = 22,
>>>>>>> +    },
>>>>>>> +    .hw.init = &(struct clk_init_data){
>>>>>>> +        .name = "fclk_div3",
>>>>>>> +        .ops = &clk_regmap_gate_ops,
>>>>>>> +        .parent_hws = (const struct clk_hw *[]) {
>>>>>>> +            &a1_fclk_div3_div.hw
>>>>>>> +        },
>>>>>>> +        .num_parents = 1,
>>>>>>> +        /*
>>>>>>> +         * add CLK_IS_CRITICAL flag to avoid being disabled by clk
>>>>>>> core
>>>>>>> +         * its children clocks.
>>>>>>> +         */
>>>>>>> +        .flags = CLK_IS_CRITICAL,
>>>>>>> +    },
>>>>>>> +};
>>>>>>> +
>>>>>>> +static struct clk_fixed_factor a1_fclk_div5_div = {
>>>>>>> +    .mult = 1,
>>>>>>> +    .div = 5,
>>>>>>> +    .hw.init = &(struct clk_init_data){
>>>>>>> +        .name = "fclk_div5_div",
>>>>>>> +        .ops = &clk_fixed_factor_ops,
>>>>>>> +        .parent_hws = (const struct clk_hw *[]) {
>>>>>>> +            &a1_fixed_pll.hw
>>>>>>> +        },
>>>>>>> +        .num_parents = 1,
>>>>>>> +    },
>>>>>>> +};
>>>>>>> +
>>>>>>> +static struct clk_regmap a1_fclk_div5 = {
>>>>>>> +    .data = &(struct clk_regmap_gate_data){
>>>>>>> +        .offset = ANACTRL_FIXPLL_CTRL0,
>>>>>>> +        .bit_idx = 23,
>>>>>>> +    },
>>>>>>> +    .hw.init = &(struct clk_init_data){
>>>>>>> +        .name = "fclk_div5",
>>>>>>> +        .ops = &clk_regmap_gate_ops,
>>>>>>> +        .parent_hws = (const struct clk_hw *[]) {
>>>>>>> +            &a1_fclk_div5_div.hw
>>>>>>> +        },
>>>>>>> +        .num_parents = 1,
>>>>>>> +        /*
>>>>>>> +         * add CLK_IS_CRITICAL flag to avoid being disabled by clk
>>>>>>> core
>>>>>>> +         * its children clocks.
>>>>>>> +         */
>>>>>>> +        .flags = CLK_IS_CRITICAL,
>>>>>>> +    },
>>>>>>> +};
>>>>>>> +
>>>>>>> +static struct clk_fixed_factor a1_fclk_div7_div = {
>>>>>>> +    .mult = 1,
>>>>>>> +    .div = 7,
>>>>>>> +    .hw.init = &(struct clk_init_data){
>>>>>>> +        .name = "fclk_div7_div",
>>>>>>> +        .ops = &clk_fixed_factor_ops,
>>>>>>> +        .parent_hws = (const struct clk_hw *[]) {
>>>>>>> +            &a1_fixed_pll.hw
>>>>>>> +        },
>>>>>>> +        .num_parents = 1,
>>>>>>> +    },
>>>>>>> +};
>>>>>>> +
>>>>>>> +static struct clk_regmap a1_fclk_div7 = {
>>>>>>> +    .data = &(struct clk_regmap_gate_data){
>>>>>>> +        .offset = ANACTRL_FIXPLL_CTRL0,
>>>>>>> +        .bit_idx = 23,
>>>>>>> +    },
>>>>>>> +    .hw.init = &(struct clk_init_data){
>>>>>>> +        .name = "fclk_div7",
>>>>>>> +        .ops = &clk_regmap_gate_ops,
>>>>>>> +        .parent_hws = (const struct clk_hw *[]) {
>>>>>>> +            &a1_fclk_div7_div.hw
>>>>>>> +        },
>>>>>>> +        .num_parents = 1,
>>>>>>> +        /*
>>>>>>> +         * add CLK_IS_CRITICAL flag to avoid being disabled by clk
>>>>>>> core
>>>>>>> +         * or its children clock.
>>>>>>> +         */
>>>>>>> +        .flags = CLK_IS_CRITICAL,
>>>>>>> +    },
>>>>>>> +};
>>>>>>> +
>> [...]
>>>>>>> -- 
>>>>>>> 1.9.1
>>>>>>
>>>>>> .
>>>>>>
>>>>
>>>> .
>>>>
> 
> .
> 
