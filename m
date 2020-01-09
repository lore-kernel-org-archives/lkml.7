Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEB2C33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 11:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E79320656
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 11:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbgAILLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 06:11:37 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:11158 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729108AbgAILLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 06:11:37 -0500
Received: from [10.28.39.63] (10.28.39.63) by mail-sz.amlogic.com (10.28.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Thu, 9 Jan
 2020 19:11:59 +0800
Subject: Re: [PATCH v5 5/5] clk: meson: a1: add support for Amlogic A1
 Peripheral clock driver
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
 <20191227094606.143637-6-jian.hu@amlogic.com>
 <CAFBinCB_0+k6rGxChpB77rPUrb-0mzxt_nQWXbiztCJnJq8XnQ@mail.gmail.com>
From:   Jian Hu <jian.hu@amlogic.com>
Message-ID: <5fc8e620-3d0d-c982-d506-f7234537ff0c@amlogic.com>
Date:   Thu, 9 Jan 2020 19:11:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAFBinCB_0+k6rGxChpB77rPUrb-0mzxt_nQWXbiztCJnJq8XnQ@mail.gmail.com>
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



On 2019/12/28 1:22, Martin Blumenstingl wrote:
>   Hi Jian,
> 
> my comments and questions below
> please keep in mind that I don't have access to the A1 datasheets, so
> I may ask stupid questions :)
> 
> On Fri, Dec 27, 2019 at 10:47 AM Jian Hu <jian.hu@amlogic.com> wrote:
> [...]
>> +/* PLLs clock in gates, its parent is xtal */
> yes. doesn't the code below describe exactly this (what is so special
> about it that we need an extra comment)?
It is a useless comment actually. I will remove it.
There is a gate clock between the xtal clock and PLL clocks(and other 
clocks)
> 
> [...]
>> +static const struct clk_parent_data sys_clk_parents[] = {
>> +       { .fw_name = "xtal" },
>> +       { .fw_name = "fclk_div2"},
>> +       { .fw_name = "fclk_div3"},
>> +       { .fw_name = "fclk_div5"},
> the last three values are missing a space before "}"
> 
OK, I will fix it.
> [...]
>> +       .hw.init = &(struct clk_init_data){
>> +               .name = "sys_clk",
>> +               .ops = &clk_regmap_mux_ro_ops,
>> +               .parent_hws = (const struct clk_hw *[]) {
>> +                       &a1_sys_a.hw, &a1_sys_b.hw,
>> +               },
>> +               .num_parents = 2,
>> +               /*
>> +                * This clock is used by APB bus which setted in Romcode
> like in the PLL clkc patch:
> - setted -> "is set"
> - Romcode == boot ROM ?
Yes, same with the PLL driver. Romcode is boot ROM.
> 
> [...]
>> +static struct clk_regmap a1_rtc_32k_sel = {
>> +       .data = &(struct clk_regmap_mux_data) {
>> +               .offset = RTC_CTRL,
>> +               .mask = 0x3,
>> +               .shift = 0,
>> +               .flags = CLK_MUX_ROUND_CLOSEST,
> CLK_MUX_ROUND_CLOSEST means the common clock framework will also
> accept rates greater than 32kHz.
> is that fine for this case?
Here is a reference to g12a-aoclkc.c
The g12a_aoclk_32k_by_oscin_sel has the same flag.
I am confused about the flag here.

The ceca and cecb clocks' parent is rtc_clk. It
can be set to 32k, and it has been verified by
clock measurement.

> 
> [...]
>> +/*
>> + * the second parent is sys_pll_div16, it will complete in the CPU clock,
> I was confused by this but I assume you mean the parent with index 2?
Yes, it is index 2, it is the third parent in datasheet. I will change it
> 
>> + * the forth parent is the clock measurement source, it relies on
>> + * the clock measurement register configuration.
> ...and parent with index 4 here
Yes, it is index 4 .
> 
> [...]
>> +static struct clk_regmap a1_pwm_a = {
>> +       .data = &(struct clk_regmap_gate_data){
>> +               .offset = PWM_CLK_AB_CTRL,
>> +               .bit_idx = 8,
>> +       },
>> +       .hw.init = &(struct clk_init_data) {
>> +               .name = "pwm_a",
>> +               .ops = &clk_regmap_gate_ops,
>> +               .parent_hws = (const struct clk_hw *[]) {
>> +                       &a1_pwm_a_div.hw
>> +               },
>> +               .num_parents = 1,
>> +               /*
>> +                * The CPU working voltage is controlled by pwm_a
>> +                * in BL2 firmware. add the CLK_IS_CRITICAL flag
>> +                * to avoid changing at runtime.
> on G12A and G12B Linux has to manage the CPU voltage regulator
> can you confirm that for the A1 SoC this is really done by BL2? (I'm
> wondering since A1 is newer than G12)
For A1 ad401 board, the cpu voltage is controlled by PMU regulator. And 
for A1 ad409 board, the cpu voltage is controlled by PWM regulator, The 
PWM A channel feeds the cpu voltage, it is initialized in BL2. So it is 
necessary to add critical flag.

In G12A board, (arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts +194)
the regulator is PWM regulator too.

Compared with G12A, the PWM clock is in A1 periphs clock controller.
However, the PWM clock is in PWM controller in G12A.
We enable the clock by setting pwm register directly , it has not been 
registered to the CCF.

> 
>> +/*
>> + * spicc clk
>> + *    div2   |\         |\       _____
>> + *  ---------| |---DIV--| |     |     |    spicc out
>> + *  ---------| |        | |-----|GATE |---------
>> + *     ..... |/         | /     |_____|
>> + *  --------------------|/
>> + *                 24M
> does that "div2" stand for fclk_div2?
Yes, it is fclk_div2. I will replace it as fdiv2 for short
> 
> [...]
>> +static const struct meson_eeclkc_data a1_periphs_data = {
>> +               .regmap_clks = a1_periphs_regmaps,
>> +               .regmap_clk_num = ARRAY_SIZE(a1_periphs_regmaps),
>> +               .hw_onecell_data = &a1_periphs_hw_onecell_data,
>> +};
> same comment as for the PLL clkc: please drop this and use the
> variables directly inside _probe to get rid of the struct
> meson_eeclkc_data (so I won't be confused about "EE clocks" on A1,
> while according to your description there's no "EE" domain)
> 
OK, I will remove meson_eeclkc_data here. And use the variables directly.
> 
> Martin
> 
> .
> 
