Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC90ECE58E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 07:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A8402064A
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 07:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qoSwh1Gb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfJKHjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 03:39:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41400 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbfJKHjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 03:39:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id q9so10680709wrm.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 00:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=s8kB1H/RCiKP/8rYX+uBSdKgCLAKul3EqkpfP4fa+2Q=;
        b=qoSwh1Gb94xeJS8NWXd4a6ynqBsZ+rc06ehTl8GTCWOJcB9DveC++GpODROfrYECR+
         nfsTuzGlWX82vuxfgWaY//plZsYyudzejaXA4bwASnKFE3e4El1hR95t/Krmvar/n8Aq
         XOvF1A2biTY7T9POZYAke7iwVZ9YBRkaEVwQW58rE/gRcQ1vzc52QgicwFxH+rUBhEMJ
         +fPAFmWFJR+TVKor65JEPN0ID8pW609N5LOGlNJ6anQH3dGsgoqh3YP0dTsg/uyYz1vc
         KbP8v3oKVFT61op/cmycrVarXGaGKbQT6aOKa9QSB6ri6/zHdL1hdNJQ6GgZphL6gIDf
         otcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=s8kB1H/RCiKP/8rYX+uBSdKgCLAKul3EqkpfP4fa+2Q=;
        b=M4aUzzBGU/O7GV/8SC3+7poWAEYh58z7L0z1fVFCzkSbGOXvL3Em0wfo7bqAeeVOZk
         LWv8MosfueUBq0ZqnVNwieUXwwvEYtG2k+9/COKEQ0vJh1koxJt/8DB4pk8Q/hDz8+TI
         rUkoCnZ4mO+2c2Pf0oLeFfq2ydiJFEGMqTTuwLtMw5NxC1x+iFAoR+NMVznxLt5GNcZ4
         SRwaDA9+bOSC0yjsukxgHf6cOnX7B/gjdytKfFDYn7GZJWHaEqmUVIymcD2DsD2JYOfV
         3eOKE43JM5WeBn45VtkEB9ffzH3Tk4xEk63hgTAYElyK/7k0J2Tf7hcVFeUAtTmRqjYt
         73HA==
X-Gm-Message-State: APjAAAXqm4a6odOo2PUhe7L3hZhqQ6EwOmPDqBREGJIw/7sPCuYL6JIZ
        F0j1i/3pHd0/0ehIUpKdFLQiNg==
X-Google-Smtp-Source: APXvYqyc3E4HGVspguxU9+Vjw8mVZFHaBRZ19yygA1Wa+WQTjVJzfULQ9qfUc4cXw49ZwQC/XdwH6w==
X-Received: by 2002:adf:f9ca:: with SMTP id w10mr1158346wrr.259.1570779579567;
        Fri, 11 Oct 2019 00:39:39 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j11sm9452449wrw.86.2019.10.11.00.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 00:39:38 -0700 (PDT)
References: <1569411888-98116-1-git-send-email-jian.hu@amlogic.com> <1569411888-98116-3-git-send-email-jian.hu@amlogic.com> <1j1rw4mmzw.fsf@starbuckisacylon.baylibre.com> <a830a0d1-680c-86ec-e858-4470c67865e2@amlogic.com> <1jimpd27cb.fsf@starbuckisacylon.baylibre.com> <5fd57563-0c34-be14-132a-74fd2c5a5275@amlogic.com> <052b0a5c-c913-a9ff-65b9-5b7eb0aecd6e@amlogic.com>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Jian Hu <jian.hu@amlogic.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] clk: meson: a1: add support for Amlogic A1 clock driver
In-reply-to: <052b0a5c-c913-a9ff-65b9-5b7eb0aecd6e@amlogic.com>
Date:   Fri, 11 Oct 2019 09:39:37 +0200
Message-ID: <1jsgnz20jq.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 08 Oct 2019 at 10:03, Jian Hu <jian.hu@amlogic.com> wrote:

> Hi, Jerome
>
> PLL clocks and peripheral clocks rely on each other.
>
> for fixed_pll, we can describe its parent like this:
>
> xtal-->xtal_fixpll-->fixed_dco-->fixed_pll
>
> xtal fixpll is belong to peripheral region.
> fixed_pll/fclk_div2/fclk_div3 is belong to PLL region.
>
> if PLL clocks probe first, it will fail to get xtal_fixpll.
> we can not get fixed_dco's parent clock.
>
> if peripheral clocks probe first, it will fail to get
> fixed_pll clocks. A lot of peripheral clocks parent are fclk_div2/3/5/7.
> and we can not get fclk_div2/3/5/7 clocks.

What does "fail" mean ?

>
> I can think of two solutions:
> 1) Do not describe xtal_fixpll, xtal_hifipll.
>    that is to say, do not decribe the SYS_OSCIN_CTRL register.
>
> 2) Put peripheral and pll clock driver in one driver.

Those are work arounds. Actually fixing the problem is usually
preferable.

 So if rephrase your problem:

 * We have 2 clock controllers (A and B)
 * Clock are passed between the controllers using DT
 * We have a PLL in controller B which is used by clocks in
   controller A.
 * the PLL parent clock is in controller A.

=3D> So if I understand correctly you are saying that it will "fail"
because there is a circular dependency between controller A and B, right
?

Do you have evidence that your problem comes from this circular
dependency ?

AFAIK, CCF will orphan the clock and continue if the parent is not
available. Later, when the parent comes up, the orphan will be
reparented.

IOW, the problem you are reporting should already be covered by CCF.

>
> And  which sulution is better above two?

Neither, I'm afraid

>
> Or maybe other good ideas for it?

My bet would be that an important clocks (maybe more than 1) is being
gated during the init process.

Maybe you should try the command line parameter "clk_ignore_unused"
until you get things running with your 2 controllers.

>
> On 2019/9/29 17:38, Jian Hu wrote:
>>
>>
>> On 2019/9/27 21:32, Jerome Brunet wrote:
>>>
>>> On Fri 27 Sep 2019 at 11:52, Jian Hu <jian.hu@amlogic.com> wrote:
>>>
>>>> Hi, Jerome
>>>>
>>>> Thank you for review.
>>>>
>>>> On 2019/9/25 23:09, Jerome Brunet wrote:
>>>>> On Wed 25 Sep 2019 at 19:44, Jian Hu <jian.hu@amlogic.com> wrote:
>>>>>
>>>>>> The Amlogic A1 clock includes three parts:
>>>>>> peripheral clocks, pll clocks, CPU clocks.
>>>>>> sys pll and CPU clocks will be sent in next patch.
>>>>>>
>>>>>> Unlike the previous series, there is no EE/AO domain
>>>>>> in A1 CLK controllers.
>>>>>>
>>>>>> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
>>>>>> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
>>>>>> ---
>>>>>>    arch/arm64/Kconfig.platforms |    1 +
>>>>>>    drivers/clk/meson/Kconfig    |   10 +
>>>>>>    drivers/clk/meson/Makefile   |    1 +
>>>>>>    drivers/clk/meson/a1.c       | 2617
>>>>>> ++++++++++++++++++++++++++++++++++++++++++
>>>>>>    drivers/clk/meson/a1.h       |  172 +++
>>>>>>    5 files changed, 2801 insertions(+)
>>>>>>    create mode 100644 drivers/clk/meson/a1.c
>>>>>>    create mode 100644 drivers/clk/meson/a1.h
>>>>>>
> [...]
>>>>>> diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
>>>>>> new file mode 100644
>>>>>> index 0000000..26edae0f
>>>>>> --- /dev/null
>>>>>> +++ b/drivers/clk/meson/a1.c
>>>>>> @@ -0,0 +1,2617 @@
>>>>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>>>>> +/*
>>>>>> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
>>>>>> + */
>>>>>> +
>>>>>> +#include <linux/clk-provider.h>
>>>>>> +#include <linux/init.h>
>>>>>> +#include <linux/of_device.h>
>>>>>> +#include <linux/platform_device.h>
>>>>>> +#include <linux/of_address.h>
>>>>>> +#include "clk-mpll.h"
>>>>>> +#include "clk-pll.h"
>>>>>> +#include "clk-regmap.h"
>>>>>> +#include "vid-pll-div.h"
>>>>>> +#include "clk-dualdiv.h"
>>>>>> +#include "meson-eeclk.h"
>>>>>> +#include "a1.h"
>>>>>> +
>>>>>> +/* PLLs clock in gates, its parent is xtal */
>>>>>> +static struct clk_regmap a1_xtal_clktree =3D {
>>>>>> +    .data =3D &(struct clk_regmap_gate_data){
>>>>>> +        .offset =3D SYS_OSCIN_CTRL,
>>>>>> +        .bit_idx =3D 0,
>>>>>> +    },
>>>>>> +    .hw.init =3D &(struct clk_init_data) {
>>>>>> +        .name =3D "xtal_clktree",
>>>>>> +        .ops =3D &clk_regmap_gate_ops,
>>>>>> +        .parent_data =3D &(const struct clk_parent_data) {
>>>>>> +            .fw_name =3D "xtal",
>>>>>> +        },
>>>>>> +        .num_parents =3D 1,
>>>>>> +        .flags =3D CLK_IS_CRITICAL,
>>>>>
>>>>> Is CCF even expected to touch this ever ? what about RO ops ?
>>>>> Please review your other clocks with this in mind
>>>>>
>>>> the clock should not be changed at runtime.clk_regmap_gate_ro_ops
>>>> is a good idea. Set RO ops and remove the CLK_IS_CRITICAL flag.
>>>>>> +    },
>>>>>> +};
>>>>>> +
>>>>>> +static struct clk_regmap a1_xtal_fixpll =3D {
>>>>>> +    .data =3D &(struct clk_regmap_gate_data){
>>>>>> +        .offset =3D SYS_OSCIN_CTRL,
>>>>>> +        .bit_idx =3D 1,
>>>>>> +    },
>>>>>> +    .hw.init =3D &(struct clk_init_data) {
>>>>>> +        .name =3D "xtal_fixpll",
>>>>>> +        .ops =3D &clk_regmap_gate_ops,
>>>>>> +        .parent_data =3D &(const struct clk_parent_data) {
>>>>>> +            .fw_name =3D "xtal",
>>>>>> +        },
>>>>>> +        .num_parents =3D 1,
>>>>>> +        .flags =3D CLK_IS_CRITICAL,
>>>>>> +    },
>>>>>> +};
>>>>>> +
>>>>>> +static struct clk_regmap a1_xtal_usb_phy =3D {
>>>>>> +    .data =3D &(struct clk_regmap_gate_data){
>>>>>> +        .offset =3D SYS_OSCIN_CTRL,
>>>>>> +        .bit_idx =3D 2,
>>>>>> +    },
>>>>>> +    .hw.init =3D &(struct clk_init_data) {
>>>>>> +        .name =3D "xtal_usb_phy",
>>>>>> +        .ops =3D &clk_regmap_gate_ops,
>>>>>> +        .parent_data =3D &(const struct clk_parent_data) {
>>>>>> +            .fw_name =3D "xtal",
>>>>>> +        },
>>>>>> +        .num_parents =3D 1,
>>>>>> +        .flags =3D CLK_IS_CRITICAL,
>>>>>
>>>>> How is an USB clock critical to the system ?
>>>>> Please review your other clocks with comment in mind ...
>>>> the usb clock does not affect the system,
>>>> remove the CLK_IS_CRITICAL flag
>>>>>
>>>>>> +    },
>>>>>> +};
>>>>>> +
>>>>>> +static struct clk_regmap a1_xtal_usb_ctrl =3D {
>>>>>> +    .data =3D &(struct clk_regmap_gate_data){
>>>>>> +        .offset =3D SYS_OSCIN_CTRL,
>>>>>> +        .bit_idx =3D 3,
>>>>>> +    },
>>>>>> +    .hw.init =3D &(struct clk_init_data) {
>>>>>> +        .name =3D "xtal_usb_ctrl",
>>>>>> +        .ops =3D &clk_regmap_gate_ops,
>>>>>> +        .parent_data =3D &(const struct clk_parent_data) {
>>>>>> +            .fw_name =3D "xtal",
>>>>>> +        },
>>>>>> +        .num_parents =3D 1,
>>>>>> +        .flags =3D CLK_IS_CRITICAL,
>>>>>> +    },
>>>>>> +};
>>>> the usb clock does not affect the system,
>>>> remove the CLK_IS_CRITICAL flag
>>>>>> +
>>>>>> +static struct clk_regmap a1_xtal_hifipll =3D {
>>>>>> +    .data =3D &(struct clk_regmap_gate_data){
>>>>>> +        .offset =3D SYS_OSCIN_CTRL,
>>>>>> +        .bit_idx =3D 4,
>>>>>> +    },
>>>>>> +    .hw.init =3D &(struct clk_init_data) {
>>>>>> +        .name =3D "xtal_hifipll",
>>>>>> +        .ops =3D &clk_regmap_gate_ops,
>>>>>> +        .parent_data =3D &(const struct clk_parent_data) {
>>>>>> +            .fw_name =3D "xtal",
>>>>>> +        },
>>>>>> +        .num_parents =3D 1,
>>>>>> +        .flags =3D CLK_IS_CRITICAL,
>>>>>> +    },
>>>>>> +};
>>>> CLK_IS_CRITICAL is need to lock hifi pll.
>>>
>>> That's not how CCF works, this falg is not ok here.
>>> CCF will enable this clock before calling enable on your hifi pll
>>>
>> ok=EF=BC=8C I will remove it.
>>>>>> +
>>>>>> +static struct clk_regmap a1_xtal_syspll =3D {
>>>>>> +    .data =3D &(struct clk_regmap_gate_data){
>>>>>> +        .offset =3D SYS_OSCIN_CTRL,
>>>>>> +        .bit_idx =3D 5,
>>>>>> +    },
>>>>>> +    .hw.init =3D &(struct clk_init_data) {
>>>>>> +        .name =3D "xtal_syspll",
>>>>>> +        .ops =3D &clk_regmap_gate_ops,
>>>>>> +        .parent_data =3D &(const struct clk_parent_data) {
>>>>>> +            .fw_name =3D "xtal",
>>>>>> +        },
>>>>>> +        .num_parents =3D 1,
>>>>>> +        .flags =3D CLK_IS_CRITICAL,
>>>>>> +    },
>>>>>> +};
>>>>>> +
>>>> when CPU clock is at fixed clock, sys pll
>>>> will be disabled, xtal_syspll will be disabled too.
>>>> when setting sys pll, call clk_set_rate to lock
>>>> sys pll, add RO ops to avoid disabling the clock
>>>
>>> Again not Ok.
>>> If you mechanism to lock the PLL is properly implemented in the enable
>>> callback of the sys pll, still kind of work around are not needed
>>>
>>> This has worked on the pll we had so far.
>>>
>> ok, I will remove it.
>>>>
>>>>>> +static struct clk_regmap a1_xtal_dds =3D {
>>>>>> +    .data =3D &(struct clk_regmap_gate_data){
>>>>>> +        .offset =3D SYS_OSCIN_CTRL,
>>>>>> +        .bit_idx =3D 6,
>>>>>> +    },
>>>>>> +    .hw.init =3D &(struct clk_init_data) {
>>>>>> +        .name =3D "xtal_dds",
>>>>>> +        .ops =3D &clk_regmap_gate_ops,
>>>>>> +        .parent_data =3D &(const struct clk_parent_data) {
>>>>>> +            .fw_name =3D "xtal",
>>>>>> +        },
>>>>>> +        .num_parents =3D 1,
>>>>>> +        .flags =3D CLK_IS_CRITICAL,
>>>>>> +    },
>>>>>> +};
>>>> CLK_IS_CRITICAL is need to lock dds
>>>>>> +
>>>>>> +/* fixed pll =3D 1536M
>>>>>> + *
>>>>>> + * fixed pll ----- fclk_div2 =3D 768M
>>>>>> + *           |
>>>>>> + *           ----- fclk_div3 =3D 512M
>>>>>> + *           |
>>>>>> + *           ----- fclk_div5 =3D 307.2M
>>>>>> + *           |
>>>>>> + *           ----- fclk_div7 =3D 219.4M
>>>>>> + */
>>>>>
>>>>> The framework will make those calculation ... you can remove this
>>>>>
>>>> ok, I will remote the comment.
>>>>>> +static struct clk_regmap a1_fixed_pll_dco =3D {
>>>>>> +    .data =3D &(struct meson_clk_pll_data){
>>>>>> +        .en =3D {
>>>>>> +            .reg_off =3D ANACTRL_FIXPLL_CTRL0,
>>>>>> +            .shift   =3D 28,
>>>>>> +            .width   =3D 1,
>>>>>> +        },
>>>>>> +        .m =3D {
>>>>>> +            .reg_off =3D ANACTRL_FIXPLL_CTRL0,
>>>>>> +            .shift   =3D 0,
>>>>>> +            .width   =3D 8,
>>>>>> +        },
>>>>>> +        .n =3D {
>>>>>> +            .reg_off =3D ANACTRL_FIXPLL_CTRL0,
>>>>>> +            .shift   =3D 10,
>>>>>> +            .width   =3D 5,
>>>>>> +        },
>>>>>> +        .frac =3D {
>>>>>> +            .reg_off =3D ANACTRL_FIXPLL_CTRL1,
>>>>>> +            .shift   =3D 0,
>>>>>> +            .width   =3D 19,
>>>>>> +        },
>>>>>> +        .l =3D {
>>>>>> +            .reg_off =3D ANACTRL_FIXPLL_CTRL0,
>>>>>> +            .shift   =3D 31,
>>>>>> +            .width   =3D 1,
>>>>>> +        },
>>>>>> +        .rst =3D {
>>>>>> +            .reg_off =3D ANACTRL_FIXPLL_CTRL0,
>>>>>> +            .shift   =3D 29,
>>>>>> +            .width   =3D 1,
>>>>>> +        },
>>>>>> +    },
>>>>>> +    .hw.init =3D &(struct clk_init_data){
>>>>>> +        .name =3D "fixed_pll_dco",
>>>>>> +        .ops =3D &meson_clk_pll_ro_ops,
>>>>>> +        .parent_hws =3D (const struct clk_hw *[]) {
>>>>>> +            &a1_xtal_fixpll.hw
>>>>>> +        },
>>>>>> +        .num_parents =3D 1,
>>>>>> +    },
>>>>>> +};
>>>>>> +
>>>>>> +static struct clk_regmap a1_fixed_pll =3D {
>>>>>> +    .data =3D &(struct clk_regmap_gate_data){
>>>>>> +        .offset =3D ANACTRL_FIXPLL_CTRL0,
>>>>>> +        .bit_idx =3D 20,
>>>>>> +    },
>>>>>> +    .hw.init =3D &(struct clk_init_data) {
>>>>>> +        .name =3D "fixed_pll",
>>>>>> +        .ops =3D &clk_regmap_gate_ops,
>>>>>> +        .parent_hws =3D (const struct clk_hw *[]) {
>>>>>> +            &a1_fixed_pll_dco.hw
>>>>>> +        },
>>>>>> +        .num_parents =3D 1,
>>>>>> +        .flags =3D CLK_IGNORE_UNUSED,
>>>>>> +    },
>>>>>> +};
>>>>>> +
>>>>>> +static const struct pll_params_table a1_hifi_pll_params_table[] =3D=
 {
>>>>>> +    PLL_PARAMS(128, 5), /* DCO =3D 614.4M */
>>>>>> +};
>>>>>> +
>>>>>> +static const struct reg_sequence a1_hifi_init_regs[] =3D {
>>>>>> +    { .reg =3D ANACTRL_HIFIPLL_CTRL1,    .def =3D 0x01800000 },
>>>>>> +    { .reg =3D ANACTRL_HIFIPLL_CTRL2,    .def =3D 0x00001100 },
>>>>>> +    { .reg =3D ANACTRL_HIFIPLL_CTRL3,    .def =3D 0x10022200 },
>>>>>> +    { .reg =3D ANACTRL_HIFIPLL_CTRL4,    .def =3D 0x00301000 },
>>>>>> +    { .reg =3D ANACTRL_HIFIPLL_CTRL0, .def =3D 0x01f19480 },
>>>>>> +    { .reg =3D ANACTRL_HIFIPLL_CTRL0, .def =3D 0x11f19480, .delay_u=
s =3D
>>>>>> 10 },
>>>>>> +    { .reg =3D ANACTRL_HIFIPLL_CTRL0,    .def =3D 0x15f11480, .dela=
y_us
>>>>>> =3D 40 },
>>>>>> +    { .reg =3D ANACTRL_HIFIPLL_CTRL2,    .def =3D 0x00001140 },
>>>>>> +    { .reg =3D ANACTRL_HIFIPLL_CTRL2,    .def =3D 0x00001100 },
>>>>>> +};
>>>>>> +
>>>>>> +/*
>>>>>> + * The Meson A1 HIFI PLL is 614.4M, it requires
>>>>>> + * a strict register sequence to enable the PLL.
>>>>>> + * set meson_clk_pcie_pll_ops as its ops
>>>>>> + */
>>>>>
>>>>> Could you elaborate on this ? What need to be done to enable the clock
>>>>> ?
>>>>> Also the HIFI PLL used to be able to do a *LOT* of different rate whi=
ch
>>>>> might be desirable for audio use case. Why is this one restricted to
>>>>> one
>>>>> particular rate ?
>>>>>
>>>> The audio working frequency are 44.1khz, 48khz and 192khz.
>>>>
>>>> 614.4M can meet the three frequency.
>>>>
>>>> after the hifi pll, there are two dividers in Audio clock.
>>>>
>>>> 614.4M/3200 =3D 192khz
>>>>
>>>> 614.4M/12800 =3D 48khz
>>>>
>>>> 614,4M/13932 =3D 44.0999khz
>>>
>>> It does not really answer my question though.
>>> You are locking a use case here, which is 32 bit sample width
>>>
>>> We have other constraint with the upstream audio driver, and we usually
>>> looking for base frequency that a multiple of 768 (24*32).
>>>
>>> If you need your PLL to be set to a particular rate for a use case, the
>>> correct way is "assigned-rate" in DT
>>>
>>> so the question still stands, the HIFI pll before was pretty easy to set
>>> at a wide variety of rate (same as GP0) ... is it not the case anymore ?
>>> If yes, could you decribe the constraints.
>>>
>>> All this took us a long time to figure out on our own, which is why I'd
>>> prefer to get the proper constraints in from the beginning this time
>>>
>> ok, I will verify it and  describe the constraints about it
>>>
>>>>
>>>>>> +static struct clk_regmap a1_hifi_pll =3D {
>>>>>> +    .data =3D &(struct meson_clk_pll_data){
>>>>>> +        .en =3D {
>>>>>> +            .reg_off =3D ANACTRL_HIFIPLL_CTRL0,
>>>>>> +            .shift   =3D 28,
>>>>>> +            .width   =3D 1,
>>>>>> +        },
>>>>>> +        .m =3D {
>>>>>> +            .reg_off =3D ANACTRL_HIFIPLL_CTRL0,
>>>>>> +            .shift   =3D 0,
>>>>>> +            .width   =3D 8,
>>>>>> +        },
>>>>>> +        .n =3D {
>>>>>> +            .reg_off =3D ANACTRL_HIFIPLL_CTRL0,
>>>>>> +            .shift   =3D 10,
>>>>>> +            .width   =3D 5,
>>>>>> +        },
>>>>>> +        .frac =3D {
>>>>>> +            .reg_off =3D ANACTRL_HIFIPLL_CTRL1,
>>>>>> +            .shift   =3D 0,
>>>>>> +            .width   =3D 19,
>>>>>> +        },
>>>>>> +        .l =3D {
>>>>>> +            .reg_off =3D ANACTRL_HIFIPLL_STS,
>>>>>> +            .shift   =3D 31,
>>>>>> +            .width   =3D 1,
>>>>>> +        },
>>>>>> +        .table =3D a1_hifi_pll_params_table,
>>>>>> +        .init_regs =3D a1_hifi_init_regs,
>>>>>> +        .init_count =3D ARRAY_SIZE(a1_hifi_init_regs),
>>>>>> +    },
>>>>>> +    .hw.init =3D &(struct clk_init_data){
>>>>>> +        .name =3D "hifi_pll",
>>>>>> +        .ops =3D &meson_clk_pcie_pll_ops,
>>>>>> +        .parent_hws =3D (const struct clk_hw *[]) {
>>>>>> +            &a1_xtal_hifipll.hw
>>>>>> +        },
>>>>>> +        .num_parents =3D 1,
>>>>>> +    },
>>>>>> +};
>>>>>> +
>>>>>> +static struct clk_fixed_factor a1_fclk_div2_div =3D {
>>>>>> +    .mult =3D 1,
>>>>>> +    .div =3D 2,
>>>>>> +    .hw.init =3D &(struct clk_init_data){
>>>>>> +        .name =3D "fclk_div2_div",
>>>>>> +        .ops =3D &clk_fixed_factor_ops,
>>>>>> +        .parent_hws =3D (const struct clk_hw *[]) {
>>>>>> +            &a1_fixed_pll.hw
>>>>>> +        },
>>>>>> +        .num_parents =3D 1,
>>>>>> +    },
>>>>>> +};
>>>>>> +
>>>>>> +static struct clk_regmap a1_fclk_div2 =3D {
>>>>>> +    .data =3D &(struct clk_regmap_gate_data){
>>>>>> +        .offset =3D ANACTRL_FIXPLL_CTRL0,
>>>>>> +        .bit_idx =3D 21,
>>>>>> +    },
>>>>>> +    .hw.init =3D &(struct clk_init_data){
>>>>>> +        .name =3D "fclk_div2",
>>>>>> +        .ops =3D &clk_regmap_gate_ops,
>>>>>> +        .parent_hws =3D (const struct clk_hw *[]) {
>>>>>> +            &a1_fclk_div2_div.hw
>>>>>> +        },
>>>>>> +        .num_parents =3D 1,
>>>>>> +        /*
>>>>>> +         * add CLK_IS_CRITICAL flag to avoid being disabled by clk
>>>>>> core
>>>>>> +         * or its children clocks.
>>>>>> +         */
>>>>>
>>>>> The meaning of this flag is already documented in clk-provider.h
>>>>> The reason why you need this flag is lot more interesting here ...
>>>>>
>>>>> Same below
>>>> ok, I will replace new comments here.
>>>>>
>>>>>> +        .flags =3D CLK_IS_CRITICAL,
>>>>>> +    },
>>>>>> +};
>>>>>> +
>>>>>> +static struct clk_fixed_factor a1_fclk_div3_div =3D {
>>>>>> +    .mult =3D 1,
>>>>>> +    .div =3D 3,
>>>>>> +    .hw.init =3D &(struct clk_init_data){
>>>>>> +        .name =3D "fclk_div3_div",
>>>>>> +        .ops =3D &clk_fixed_factor_ops,
>>>>>> +        .parent_hws =3D (const struct clk_hw *[]) {
>>>>>> +            &a1_fixed_pll.hw
>>>>>> +        },
>>>>>> +        .num_parents =3D 1,
>>>>>> +    },
>>>>>> +};
>>>>>> +
>>>>>> +static struct clk_regmap a1_fclk_div3 =3D {
>>>>>> +    .data =3D &(struct clk_regmap_gate_data){
>>>>>> +        .offset =3D ANACTRL_FIXPLL_CTRL0,
>>>>>> +        .bit_idx =3D 22,
>>>>>> +    },
>>>>>> +    .hw.init =3D &(struct clk_init_data){
>>>>>> +        .name =3D "fclk_div3",
>>>>>> +        .ops =3D &clk_regmap_gate_ops,
>>>>>> +        .parent_hws =3D (const struct clk_hw *[]) {
>>>>>> +            &a1_fclk_div3_div.hw
>>>>>> +        },
>>>>>> +        .num_parents =3D 1,
>>>>>> +        /*
>>>>>> +         * add CLK_IS_CRITICAL flag to avoid being disabled by clk
>>>>>> core
>>>>>> +         * its children clocks.
>>>>>> +         */
>>>>>> +        .flags =3D CLK_IS_CRITICAL,
>>>>>> +    },
>>>>>> +};
>>>>>> +
>>>>>> +static struct clk_fixed_factor a1_fclk_div5_div =3D {
>>>>>> +    .mult =3D 1,
>>>>>> +    .div =3D 5,
>>>>>> +    .hw.init =3D &(struct clk_init_data){
>>>>>> +        .name =3D "fclk_div5_div",
>>>>>> +        .ops =3D &clk_fixed_factor_ops,
>>>>>> +        .parent_hws =3D (const struct clk_hw *[]) {
>>>>>> +            &a1_fixed_pll.hw
>>>>>> +        },
>>>>>> +        .num_parents =3D 1,
>>>>>> +    },
>>>>>> +};
>>>>>> +
>>>>>> +static struct clk_regmap a1_fclk_div5 =3D {
>>>>>> +    .data =3D &(struct clk_regmap_gate_data){
>>>>>> +        .offset =3D ANACTRL_FIXPLL_CTRL0,
>>>>>> +        .bit_idx =3D 23,
>>>>>> +    },
>>>>>> +    .hw.init =3D &(struct clk_init_data){
>>>>>> +        .name =3D "fclk_div5",
>>>>>> +        .ops =3D &clk_regmap_gate_ops,
>>>>>> +        .parent_hws =3D (const struct clk_hw *[]) {
>>>>>> +            &a1_fclk_div5_div.hw
>>>>>> +        },
>>>>>> +        .num_parents =3D 1,
>>>>>> +        /*
>>>>>> +         * add CLK_IS_CRITICAL flag to avoid being disabled by clk
>>>>>> core
>>>>>> +         * its children clocks.
>>>>>> +         */
>>>>>> +        .flags =3D CLK_IS_CRITICAL,
>>>>>> +    },
>>>>>> +};
>>>>>> +
>>>>>> +static struct clk_fixed_factor a1_fclk_div7_div =3D {
>>>>>> +    .mult =3D 1,
>>>>>> +    .div =3D 7,
>>>>>> +    .hw.init =3D &(struct clk_init_data){
>>>>>> +        .name =3D "fclk_div7_div",
>>>>>> +        .ops =3D &clk_fixed_factor_ops,
>>>>>> +        .parent_hws =3D (const struct clk_hw *[]) {
>>>>>> +            &a1_fixed_pll.hw
>>>>>> +        },
>>>>>> +        .num_parents =3D 1,
>>>>>> +    },
>>>>>> +};
>>>>>> +
>>>>>> +static struct clk_regmap a1_fclk_div7 =3D {
>>>>>> +    .data =3D &(struct clk_regmap_gate_data){
>>>>>> +        .offset =3D ANACTRL_FIXPLL_CTRL0,
>>>>>> +        .bit_idx =3D 23,
>>>>>> +    },
>>>>>> +    .hw.init =3D &(struct clk_init_data){
>>>>>> +        .name =3D "fclk_div7",
>>>>>> +        .ops =3D &clk_regmap_gate_ops,
>>>>>> +        .parent_hws =3D (const struct clk_hw *[]) {
>>>>>> +            &a1_fclk_div7_div.hw
>>>>>> +        },
>>>>>> +        .num_parents =3D 1,
>>>>>> +        /*
>>>>>> +         * add CLK_IS_CRITICAL flag to avoid being disabled by clk
>>>>>> core
>>>>>> +         * or its children clock.
>>>>>> +         */
>>>>>> +        .flags =3D CLK_IS_CRITICAL,
>>>>>> +    },
>>>>>> +};
>>>>>> +
> [...]
>>>>>> --=20
>>>>>> 1.9.1
>>>>>
>>>>> .
>>>>>
>>>
>>> .
>>>

