Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA86C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 22:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E7C6206E5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 22:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573683597;
	bh=Yg8Qebo9izY8TK0EtQ21fImR31WjEOIvbcOUHuOnMGU=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=SNXGxEIRhduoaJRlxI3Jkaa4QhWXIgE4D6kBZUavsz7oHWaiucBKvq+DM+6tdVvEd
	 oJ61JQsaKG0nOz3DHN18Q1tgNveUwPcwjtsoxemYi1Er+EFjH4ZUkX4+1hEsIEnre9
	 fRHeBOyt12vxhuoq8+dYWE50wWtdxlOs7q7uImcc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfKMWTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 17:19:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:49856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbfKMWTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 17:19:53 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD925206E3;
        Wed, 13 Nov 2019 22:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573683592;
        bh=Yg8Qebo9izY8TK0EtQ21fImR31WjEOIvbcOUHuOnMGU=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=l1q0RaWVu5uEzbtxnHCzDSFnoWRN+G1jbY2l1V7xsyXFi4ryzYwTv/nWUCtqwadsx
         kVFQmiPBGsqvCpEgH1f8L6NPpU+WZnv1topWoEwwJ9316LTzFmWnX5ffsAOHDBQOQ4
         GF/aojSNYz0kOdye0HLFxR1msWc+0M27I2I6gCHI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191025111338.27324-6-chunyan.zhang@unisoc.com>
References: <20191025111338.27324-1-chunyan.zhang@unisoc.com> <20191025111338.27324-6-chunyan.zhang@unisoc.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 5/5] clk: sprd: add clocks support for SC9863A
User-Agent: alot/0.8.1
Date:   Wed, 13 Nov 2019 14:19:50 -0800
Message-Id: <20191113221952.AD925206E3@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chunyan Zhang (2019-10-25 04:13:38)
>=20
> Add the list of clocks for the Unisoc SC9863A, alone with clock

s/alone/along/?

> initialization.
>=20
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> diff --git a/drivers/clk/sprd/sc9863a-clk.c b/drivers/clk/sprd/sc9863a-cl=
k.c
> new file mode 100644
> index 000000000000..5369db1090f0
> --- /dev/null
> +++ b/drivers/clk/sprd/sc9863a-clk.c
> @@ -0,0 +1,1711 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Unisoc SC9863A clock driver
> + *
> + * Copyright (C) 2019 Unisoc, Inc.
> + * Author: Chunyan Zhang <chunyan.zhang@unisoc.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include <dt-bindings/clock/sprd,sc9863a-clk.h>
> +
> +#include "common.h"
> +#include "composite.h"
> +#include "div.h"
> +#include "gate.h"
> +#include "mux.h"
> +#include "pll.h"
> +
> +SPRD_PLL_SC_GATE_CLK(mpll0_gate, "mpll0-gate", "ext-26m", 0x94,
> +                               0x1000, BIT(0), CLK_IGNORE_UNUSED, 0, 240=
);
> +SPRD_PLL_SC_GATE_CLK(dpll0_gate, "dpll0-gate", "ext-26m", 0x98,
> +                               0x1000, BIT(0), CLK_IGNORE_UNUSED, 0, 240=
);
> +SPRD_PLL_SC_GATE_CLK(lpll_gate, "lpll-gate", "ext-26m", 0x9c,
> +                               0x1000, BIT(0), CLK_IGNORE_UNUSED, 0, 240=
);
> +SPRD_PLL_SC_GATE_CLK(gpll_gate, "gpll-gate", "ext-26m", 0xa8,
> +                               0x1000, BIT(0), CLK_IGNORE_UNUSED, 0, 240=
);
> +SPRD_PLL_SC_GATE_CLK(dpll1_gate, "dpll1-gate", "ext-26m", 0x1dc,
> +                               0x1000, BIT(0), CLK_IGNORE_UNUSED, 0, 240=
);
> +SPRD_PLL_SC_GATE_CLK(mpll1_gate, "mpll1-gate", "ext-26m", 0x1e0,
> +                               0x1000, BIT(0), CLK_IGNORE_UNUSED, 0, 240=
);
> +SPRD_PLL_SC_GATE_CLK(mpll2_gate, "mpll2-gate", "ext-26m", 0x1e4,
> +                               0x1000, BIT(0), CLK_IGNORE_UNUSED, 0, 240=
);
> +SPRD_PLL_SC_GATE_CLK(isppll_gate, "isppll-gate", "ext-26m", 0x1e8,
> +                               0x1000, BIT(0), CLK_IGNORE_UNUSED, 0, 240=
);
> +
> +static struct sprd_clk_common *sc9863a_pmu_gate_clks[] =3D {
> +       /* address base is 0x402b0000 */
> +       &mpll0_gate.common,
> +       &dpll0_gate.common,
> +       &lpll_gate.common,
> +       &gpll_gate.common,
> +       &dpll1_gate.common,
> +       &mpll1_gate.common,
> +       &mpll2_gate.common,
> +       &isppll_gate.common,
> +};
> +
> +static struct clk_hw_onecell_data sc9863a_pmu_gate_hws =3D {
> +       .hws    =3D {
> +               [CLK_MPLL0_GATE]        =3D &mpll0_gate.common.hw,
> +               [CLK_DPLL0_GATE]        =3D &dpll0_gate.common.hw,
> +               [CLK_LPLL_GATE]         =3D &lpll_gate.common.hw,
> +               [CLK_GPLL_GATE]         =3D &gpll_gate.common.hw,
> +               [CLK_DPLL1_GATE]        =3D &dpll1_gate.common.hw,
> +               [CLK_MPLL1_GATE]        =3D &mpll1_gate.common.hw,
> +               [CLK_MPLL2_GATE]        =3D &mpll2_gate.common.hw,
> +               [CLK_ISPPLL_GATE]       =3D &isppll_gate.common.hw,
> +       },
> +       .num    =3D CLK_PMU_APB_NUM,
> +};
> +
> +static const struct sprd_clk_desc sc9863a_pmu_gate_desc =3D {
> +       .clk_clks       =3D sc9863a_pmu_gate_clks,
> +       .num_clk_clks   =3D ARRAY_SIZE(sc9863a_pmu_gate_clks),
> +       .hw_clks        =3D &sc9863a_pmu_gate_hws,
> +};
> +
> +static const u64 itable[5] =3D {4, 1000000000, 1200000000,
> +                             1400000000, 1600000000};
> +
> +static const struct clk_bit_field f_twpll[PLL_FACT_MAX] =3D {
> +       { .shift =3D 95,  .width =3D 1 },   /* lock_done    */
> +       { .shift =3D 0,   .width =3D 1 },   /* div_s        */
> +       { .shift =3D 1,   .width =3D 1 },   /* mod_en       */
> +       { .shift =3D 2,   .width =3D 1 },   /* sdm_en       */
> +       { .shift =3D 0,   .width =3D 0 },   /* refin        */
> +       { .shift =3D 3,   .width =3D 3 },   /* ibias        */
> +       { .shift =3D 8,   .width =3D 11 },  /* n            */
> +       { .shift =3D 55,  .width =3D 7 },   /* nint         */
> +       { .shift =3D 32,  .width =3D 23},   /* kint         */
> +       { .shift =3D 0,   .width =3D 0 },   /* prediv       */
> +       { .shift =3D 0,   .width =3D 0 },   /* postdiv      */
> +};
> +static SPRD_PLL_WITH_ITABLE_1K(twpll_clk, "twpll", "ext-26m", 0x4,
> +                                  3, itable, f_twpll, 240);
> +static CLK_FIXED_FACTOR(twpll_768m, "twpll-768m", "twpll", 2, 1, 0);
> +static CLK_FIXED_FACTOR(twpll_384m, "twpll-384m", "twpll", 4, 1, 0);
> +static CLK_FIXED_FACTOR(twpll_192m, "twpll-192m", "twpll", 8, 1, 0);
> +static CLK_FIXED_FACTOR(twpll_96m, "twpll-96m", "twpll", 16, 1, 0);
> +static CLK_FIXED_FACTOR(twpll_48m, "twpll-48m", "twpll", 32, 1, 0);
> +static CLK_FIXED_FACTOR(twpll_24m, "twpll-24m", "twpll", 64, 1, 0);
> +static CLK_FIXED_FACTOR(twpll_12m, "twpll-12m", "twpll", 128, 1, 0);
> +static CLK_FIXED_FACTOR(twpll_512m, "twpll-512m", "twpll", 3, 1, 0);
> +static CLK_FIXED_FACTOR(twpll_256m, "twpll-256m", "twpll", 6, 1, 0);
> +static CLK_FIXED_FACTOR(twpll_128m, "twpll-128m", "twpll", 12, 1, 0);
> +static CLK_FIXED_FACTOR(twpll_64m, "twpll-64m", "twpll", 24, 1, 0);
> +static CLK_FIXED_FACTOR(twpll_307m2, "twpll-307m2", "twpll", 5, 1, 0);
> +static CLK_FIXED_FACTOR(twpll_219m4, "twpll-219m4", "twpll", 7, 1, 0);
> +static CLK_FIXED_FACTOR(twpll_170m6, "twpll-170m6", "twpll", 9, 1, 0);
> +static CLK_FIXED_FACTOR(twpll_153m6, "twpll-153m6", "twpll", 10, 1, 0);
> +static CLK_FIXED_FACTOR(twpll_76m8, "twpll-76m8", "twpll", 20, 1, 0);
> +static CLK_FIXED_FACTOR(twpll_51m2, "twpll-51m2", "twpll", 30, 1, 0);
> +static CLK_FIXED_FACTOR(twpll_38m4, "twpll-38m4", "twpll", 40, 1, 0);
> +static CLK_FIXED_FACTOR(twpll_19m2, "twpll-19m2", "twpll", 80, 1, 0);
> +
> +static const struct clk_bit_field f_lpll[PLL_FACT_MAX] =3D {
> +       { .shift =3D 95,  .width =3D 1 },   /* lock_done    */
> +       { .shift =3D 0,   .width =3D 1 },   /* div_s        */
> +       { .shift =3D 1,   .width =3D 1 },   /* mod_en       */
> +       { .shift =3D 2,   .width =3D 1 },   /* sdm_en       */
> +       { .shift =3D 0,   .width =3D 0 },   /* refin        */
> +       { .shift =3D 6,   .width =3D 2 },   /* ibias        */
> +       { .shift =3D 8,   .width =3D 11 },  /* n            */
> +       { .shift =3D 55,  .width =3D 7 },   /* nint         */
> +       { .shift =3D 32,  .width =3D 23},   /* kint         */
> +       { .shift =3D 0,   .width =3D 0 },   /* prediv       */
> +       { .shift =3D 0,   .width =3D 0 },   /* postdiv      */
> +};
> +static SPRD_PLL_WITH_ITABLE_1K(lpll_clk, "lpll", "lpll-gate", 0x20,
> +                                  3, itable, f_lpll, 240);
> +static CLK_FIXED_FACTOR(lpll_409m6, "lpll-409m6", "lpll", 3, 1, 0);
> +static CLK_FIXED_FACTOR(lpll_245m76, "lpll-245m76", "lpll", 5, 1, 0);
> +
> +static const struct clk_bit_field f_gpll[PLL_FACT_MAX] =3D {
> +       { .shift =3D 95,  .width =3D 1 },   /* lock_done    */
> +       { .shift =3D 0,   .width =3D 1 },   /* div_s        */
> +       { .shift =3D 1,   .width =3D 1 },   /* mod_en       */
> +       { .shift =3D 2,   .width =3D 1 },   /* sdm_en       */
> +       { .shift =3D 0,   .width =3D 0 },   /* refin        */
> +       { .shift =3D 6,   .width =3D 2 },   /* ibias        */
> +       { .shift =3D 8,   .width =3D 11 },  /* n            */
> +       { .shift =3D 55,  .width =3D 7 },   /* nint         */
> +       { .shift =3D 32,  .width =3D 23},   /* kint         */
> +       { .shift =3D 0,   .width =3D 0 },   /* prediv       */
> +       { .shift =3D 80,  .width =3D 1 },   /* postdiv      */
> +};
> +static SPRD_PLL_WITH_ITABLE_K_FVCO(gpll_clk, "gpll", "gpll-gate", 0x38,
> +                                  3, itable, f_gpll, 240,
> +                                  1000, 1000, 1, 400000000);
> +
> +#define f_isppll f_gpll

Why redefine? Please use the actual variable name where it is used.

> +static SPRD_PLL_WITH_ITABLE_1K(isppll_clk, "isppll", "isppll-gate", 0x50,
> +                                  3, itable, f_isppll, 240);
> +static CLK_FIXED_FACTOR(isppll_468m, "isppll-468m", "isppll", 2, 1, 0);
> +
> +static struct sprd_clk_common *sc9863a_pll_clks[] =3D {
> +       /* address base is 0x40353000 */
> +       &twpll_clk.common,
> +       &lpll_clk.common,
> +       &gpll_clk.common,
> +       &isppll_clk.common,
> +};
> +
> +static struct clk_hw_onecell_data sc9863a_pll_hws =3D {
> +       .hws    =3D {
> +               [CLK_TWPLL]             =3D &twpll_clk.common.hw,
> +               [CLK_TWPLL_768M]        =3D &twpll_768m.hw,
> +               [CLK_TWPLL_384M]        =3D &twpll_384m.hw,
> +               [CLK_TWPLL_192M]        =3D &twpll_192m.hw,
> +               [CLK_TWPLL_96M]         =3D &twpll_96m.hw,
> +               [CLK_TWPLL_48M]         =3D &twpll_48m.hw,
> +               [CLK_TWPLL_24M]         =3D &twpll_24m.hw,
> +               [CLK_TWPLL_12M]         =3D &twpll_12m.hw,
> +               [CLK_TWPLL_512M]        =3D &twpll_512m.hw,
> +               [CLK_TWPLL_256M]        =3D &twpll_256m.hw,
> +               [CLK_TWPLL_128M]        =3D &twpll_128m.hw,
> +               [CLK_TWPLL_64M]         =3D &twpll_64m.hw,
> +               [CLK_TWPLL_307M2]       =3D &twpll_307m2.hw,
> +               [CLK_TWPLL_219M4]       =3D &twpll_219m4.hw,
> +               [CLK_TWPLL_170M6]       =3D &twpll_170m6.hw,
> +               [CLK_TWPLL_153M6]       =3D &twpll_153m6.hw,
> +               [CLK_TWPLL_76M8]        =3D &twpll_76m8.hw,
> +               [CLK_TWPLL_51M2]        =3D &twpll_51m2.hw,
> +               [CLK_TWPLL_38M4]        =3D &twpll_38m4.hw,
> +               [CLK_TWPLL_19M2]        =3D &twpll_19m2.hw,
> +               [CLK_LPLL]              =3D &lpll_clk.common.hw,
> +               [CLK_LPLL_409M6]        =3D &lpll_409m6.hw,
> +               [CLK_LPLL_245M76]       =3D &lpll_245m76.hw,
> +               [CLK_GPLL]              =3D &gpll_clk.common.hw,
> +               [CLK_ISPPLL]            =3D &isppll_clk.common.hw,
> +               [CLK_ISPPLL_468M]       =3D &isppll_468m.hw,
> +
> +       },
> +       .num    =3D CLK_ANLG_PHY_G1_NUM,
> +};
> +
> +static const struct sprd_clk_desc sc9863a_pll_desc =3D {
> +       .clk_clks       =3D sc9863a_pll_clks,
> +       .num_clk_clks   =3D ARRAY_SIZE(sc9863a_pll_clks),
> +       .hw_clks        =3D &sc9863a_pll_hws,
> +};
> +
> +#define f_mpll f_gpll

Same comment.

> +static const u64 itable_mpll[6] =3D {5, 1000000000, 1200000000, 14000000=
00,
> +                                  1600000000, 1800000000};
> +static SPRD_PLL_WITH_ITABLE_K_FVCO(mpll0_clk, "mpll0", "mpll0-gate", 0x0,
> +                                  3, itable_mpll, f_mpll, 240,
> +                                  1000, 1000, 1, 1000000000);
> +static SPRD_PLL_WITH_ITABLE_K_FVCO(mpll1_clk, "mpll1", "mpll1-gate", 0x1=
8,
> +                                  3, itable_mpll, f_mpll, 240,
> +                                  1000, 1000, 1, 1000000000);
> +static SPRD_PLL_WITH_ITABLE_K_FVCO(mpll2_clk, "mpll2", "mpll2-gate", 0x3=
0,
> +                                  3, itable_mpll, f_mpll, 240,
> +                                  1000, 1000, 1, 1000000000);
> +static CLK_FIXED_FACTOR(mpll2_675m, "mpll2-675m", "mpll2", 2, 1, 0);
> +
> +static struct sprd_clk_common *sc9863a_mpll_clks[] =3D {
> +       /* address base is 0x40359000 */
> +       &mpll0_clk.common,
> +       &mpll1_clk.common,
> +       &mpll2_clk.common,
> +};
> +
> +static struct clk_hw_onecell_data sc9863a_mpll_hws =3D {
> +       .hws    =3D {
> +               [CLK_MPLL0]             =3D &mpll0_clk.common.hw,
> +               [CLK_MPLL1]             =3D &mpll1_clk.common.hw,
> +               [CLK_MPLL2]             =3D &mpll2_clk.common.hw,
> +               [CLK_MPLL2_675M]        =3D &mpll2_675m.hw,
> +
> +       },
> +       .num    =3D CLK_ANLG_PHY_G4_NUM,
> +};
> +
> +static const struct sprd_clk_desc sc9863a_mpll_desc =3D {
> +       .clk_clks       =3D sc9863a_mpll_clks,
> +       .num_clk_clks   =3D ARRAY_SIZE(sc9863a_mpll_clks),
> +       .hw_clks        =3D &sc9863a_mpll_hws,
> +};
> +
> +static SPRD_SC_GATE_CLK(audio_gate,    "audio-gate",   "ext-26m", 0x4,
> +                    0x1000, BIT(8), CLK_IGNORE_UNUSED, 0);
> +
> +#define f_rpll f_lpll

Same comment.

> +static SPRD_PLL_WITH_ITABLE_1K(rpll_clk, "rpll", "ext-26m", 0x10,
> +                                  3, itable, f_rpll, 240);
> +
> +static CLK_FIXED_FACTOR(rpll_390m, "rpll-390m", "rpll", 2, 1, 0);
> +static CLK_FIXED_FACTOR(rpll_260m, "rpll-260m", "rpll", 3, 1, 0);
> +static CLK_FIXED_FACTOR(rpll_195m, "rpll-195m", "rpll", 4, 1, 0);
> +static CLK_FIXED_FACTOR(rpll_26m, "rpll-26m", "rpll", 30, 1, 0);
> +
> +static struct sprd_clk_common *sc9863a_rpll_clks[] =3D {
> +       /* address base is 0x4035c000 */
> +       &audio_gate.common,
> +       &rpll_clk.common,
> +};
> +
> +static struct clk_hw_onecell_data sc9863a_rpll_hws =3D {
> +       .hws    =3D {
> +               [CLK_AUDIO_GATE]        =3D &audio_gate.common.hw,
> +               [CLK_RPLL]              =3D &rpll_clk.common.hw,
> +               [CLK_RPLL_390M]         =3D &rpll_390m.hw,
> +               [CLK_RPLL_260M]         =3D &rpll_260m.hw,
> +               [CLK_RPLL_195M]         =3D &rpll_195m.hw,
> +               [CLK_RPLL_26M]          =3D &rpll_26m.hw,
> +       },
> +       .num    =3D CLK_ANLG_PHY_G5_NUM,
> +};
> +
> +static const struct sprd_clk_desc sc9863a_rpll_desc =3D {
> +       .clk_clks       =3D sc9863a_rpll_clks,
> +       .num_clk_clks   =3D ARRAY_SIZE(sc9863a_rpll_clks),
> +       .hw_clks        =3D &sc9863a_rpll_hws,
> +};
> +
> +#define f_dpll f_lpll

Same comment.

> +static const u64 itable_dpll[5] =3D {4, 1211000000, 1320000000, 15700000=
00,
> +                                  1866000000};
> +static SPRD_PLL_WITH_ITABLE_1K(dpll0_clk, "dpll0", "dpll0-gate", 0x0,
> +                                  3, itable_dpll, f_dpll, 240);
> +static SPRD_PLL_WITH_ITABLE_1K(dpll1_clk, "dpll1", "dpll1-gate", 0x18,
> +                                  3, itable_dpll, f_dpll, 240);
> +
> +static CLK_FIXED_FACTOR(dpll0_933m, "dpll0-933m", "dpll0", 2, 1, 0);
> +static CLK_FIXED_FACTOR(dpll0_622m3, "dpll0-622m3", "dpll0", 3, 1, 0);
> +static CLK_FIXED_FACTOR(dpll1_400m, "dpll1-400m", "dpll1", 4, 1, 0);
> +static CLK_FIXED_FACTOR(dpll1_266m7, "dpll1-266m7", "dpll1", 6, 1, 0);
> +static CLK_FIXED_FACTOR(dpll1_123m1, "dpll1-123m1", "dpll1", 13, 1, 0);
> +static CLK_FIXED_FACTOR(dpll1_50m, "dpll1-50m", "dpll1", 32, 1, 0);
> +
> +static struct sprd_clk_common *sc9863a_dpll_clks[] =3D {
[...]
> +static SPRD_COMP_CLK(core0_clk, "core0-clk", core_parents, 0xa20,
> +                    0, 3, 8, 3, 0);
> +static SPRD_COMP_CLK(core1_clk, "core1-clk", core_parents, 0xa24,
> +                    0, 3, 8, 3, 0);
> +static SPRD_COMP_CLK(core2_clk, "core2-clk", core_parents, 0xa28,
> +                    0, 3, 8, 3, 0);
> +static SPRD_COMP_CLK(core3_clk, "core3-clk", core_parents, 0xa2c,
> +                    0, 3, 8, 3, 0);
> +static SPRD_COMP_CLK(core4_clk, "core4-clk", core_parents, 0xa30,
> +                    0, 3, 8, 3, 0);
> +static SPRD_COMP_CLK(core5_clk, "core5-clk", core_parents, 0xa34,
> +                    0, 3, 8, 3, 0);
> +static SPRD_COMP_CLK(core6_clk, "core6-clk", core_parents, 0xa38,
> +                    0, 3, 8, 3, 0);
> +static SPRD_COMP_CLK(core7_clk, "core7-clk", core_parents, 0xa3c,
> +                    0, 3, 8, 3, 0);
> +static SPRD_COMP_CLK(scu_clk, "scu-clk", core_parents, 0xa40,
> +                    0, 3, 8, 3, 0);
> +static SPRD_DIV_CLK(ace_clk, "ace-clk", "scu-clk", 0xa44,
> +                   8, 3, 0);
> +static SPRD_DIV_CLK(axi_periph_clk, "axi-periph-clk", "scu-clk", 0xa48,
> +                   8, 3, 0);
> +static SPRD_DIV_CLK(axi_acp_clk, "axi-acp-clk", "scu-clk", 0xa4c,
> +                   8, 3, 0);
> +
> +static const char * const atb_parents[] =3D { "ext-26m", "twpll-384m",
> +                                           "twpll-512m", "mpll2" };
> +static SPRD_COMP_CLK(atb_clk, "atb-clk", atb_parents, 0xa50,
> +                    0, 2, 8, 3, 0);
> +static SPRD_DIV_CLK(debug_apb_clk, "debug-apb-clk", "atb-clk", 0xa54,
> +                   8, 3, 0);
> +
> +static const char * const gic_parents[] =3D { "ext-26m", "twpll-153m6",
> +                                           "twpll-384m", "twpll-512m" };

Can you use the new way of specifying clk parents instead of using these
big string lists? That will hopefully cut down on the size of this code
by reducing all these string lists.

> +static SPRD_COMP_CLK(gic_clk, "gic-clk", gic_parents, 0xa58,
> +                    0, 2, 8, 3, 0);
> +static SPRD_COMP_CLK(periph_clk, "periph-clk", gic_parents, 0xa5c,
> +                    0, 2, 8, 3, 0);
> +
> +static struct sprd_clk_common *sc9863a_aon_clks[] =3D {
> +       /* address base is 0x402d0000 */
> +       &emc_clk.common,
> +       &aon_apb.common,
> +       &adi_clk.common,
> +       &aux0_clk.common,
> +       &aux1_clk.common,
> +       &aux2_clk.common,
> +       &probe_clk.common,
> +       &pwm0_clk.common,
> +       &pwm1_clk.common,
> +       &pwm2_clk.common,
> +       &aon_thm_clk.common,
> +       &audif_clk.common,
> +       &cpu_dap_clk.common,
> +       &cpu_ts_clk.common,
> +       &djtag_tck_clk.common,
> +       &emc_ref_clk.common,
> +       &cssys_clk.common,
> +       &aon_pmu_clk.common,
> +       &pmu_26m_clk.common,
> +       &aon_tmr_clk.common,
> +       &power_cpu_clk.common,
> +       &ap_axi.common,
> +       &sdio0_2x.common,
> +       &sdio1_2x.common,
> +       &sdio2_2x.common,
> +       &emmc_2x.common,
> +       &dpu_clk.common,
> +       &dpu_dpi.common,
> +       &otg_ref_clk.common,
> +       &sdphy_apb_clk.common,
> +       &alg_io_apb_clk.common,
> +       &gpu_core.common,
> +       &gpu_soc.common,
> +       &mm_emc.common,
> +       &mm_ahb.common,
> +       &bpc_clk.common,
> +       &dcam_if_clk.common,
> +       &isp_clk.common,
> +       &jpg_clk.common,
> +       &cpp_clk.common,
> +       &sensor0_clk.common,
> +       &sensor1_clk.common,
> +       &sensor2_clk.common,
> +       &mm_vemc.common,
> +       &mm_vahb.common,
> +       &clk_vsp.common,
> +       &core0_clk.common,
> +       &core1_clk.common,
> +       &core2_clk.common,
> +       &core3_clk.common,
> +       &core4_clk.common,
> +       &core5_clk.common,
> +       &core6_clk.common,
> +       &core7_clk.common,
> +       &scu_clk.common,
> +       &ace_clk.common,
> +       &axi_periph_clk.common,
> +       &axi_acp_clk.common,
> +       &atb_clk.common,
> +       &debug_apb_clk.common,
> +       &gic_clk.common,
> +       &periph_clk.common,
> +};
> +
> +static struct clk_hw_onecell_data sc9863a_aon_clk_hws =3D {
> +       .hws    =3D {
> +               [CLK_13M]               =3D &clk_13m.hw,
> +               [CLK_6M5]               =3D &clk_6m5.hw,
> +               [CLK_4M3]               =3D &clk_4m3.hw,
> +               [CLK_2M]                =3D &clk_2m.hw,
> +               [CLK_250K]              =3D &clk_250k.hw,
> +               [CLK_RCO_25M]           =3D &rco_25m.hw,
> +               [CLK_RCO_4M]            =3D &rco_4m.hw,
> +               [CLK_RCO_2M]            =3D &rco_2m.hw,
> +               [CLK_EMC]               =3D &emc_clk.common.hw,
> +               [CLK_AON_APB]           =3D &aon_apb.common.hw,
> +               [CLK_ADI]               =3D &adi_clk.common.hw,
> +               [CLK_AUX0]              =3D &aux0_clk.common.hw,
> +               [CLK_AUX1]              =3D &aux1_clk.common.hw,
> +               [CLK_AUX2]              =3D &aux2_clk.common.hw,
> +               [CLK_PROBE]             =3D &probe_clk.common.hw,
> +               [CLK_PWM0]              =3D &pwm0_clk.common.hw,
> +               [CLK_PWM1]              =3D &pwm1_clk.common.hw,
> +               [CLK_PWM2]              =3D &pwm2_clk.common.hw,
> +               [CLK_AON_THM]           =3D &aon_thm_clk.common.hw,
> +               [CLK_AUDIF]             =3D &audif_clk.common.hw,
> +               [CLK_CPU_DAP]           =3D &cpu_dap_clk.common.hw,
> +               [CLK_CPU_TS]            =3D &cpu_ts_clk.common.hw,
> +               [CLK_DJTAG_TCK]         =3D &djtag_tck_clk.common.hw,
> +               [CLK_EMC_REF]           =3D &emc_ref_clk.common.hw,
> +               [CLK_CSSYS]             =3D &cssys_clk.common.hw,
> +               [CLK_AON_PMU]           =3D &aon_pmu_clk.common.hw,
> +               [CLK_PMU_26M]           =3D &pmu_26m_clk.common.hw,
> +               [CLK_AON_TMR]           =3D &aon_tmr_clk.common.hw,
> +               [CLK_POWER_CPU]         =3D &power_cpu_clk.common.hw,
> +               [CLK_AP_AXI]            =3D &ap_axi.common.hw,
> +               [CLK_SDIO0_2X]          =3D &sdio0_2x.common.hw,
> +               [CLK_SDIO1_2X]          =3D &sdio1_2x.common.hw,
> +               [CLK_SDIO2_2X]          =3D &sdio2_2x.common.hw,
> +               [CLK_EMMC_2X]           =3D &emmc_2x.common.hw,
> +               [CLK_DPU]               =3D &dpu_clk.common.hw,
> +               [CLK_DPU_DPI]           =3D &dpu_dpi.common.hw,
> +               [CLK_OTG_REF]           =3D &otg_ref_clk.common.hw,
> +               [CLK_SDPHY_APB]         =3D &sdphy_apb_clk.common.hw,
> +               [CLK_ALG_IO_APB]        =3D &alg_io_apb_clk.common.hw,
> +               [CLK_GPU_CORE]          =3D &gpu_core.common.hw,
> +               [CLK_GPU_SOC]           =3D &gpu_soc.common.hw,
> +               [CLK_MM_EMC]            =3D &mm_emc.common.hw,
> +               [CLK_MM_AHB]            =3D &mm_ahb.common.hw,
> +               [CLK_BPC]               =3D &bpc_clk.common.hw,
> +               [CLK_DCAM_IF]           =3D &dcam_if_clk.common.hw,
> +               [CLK_ISP]               =3D &isp_clk.common.hw,
> +               [CLK_JPG]               =3D &jpg_clk.common.hw,
> +               [CLK_CPP]               =3D &cpp_clk.common.hw,
> +               [CLK_SENSOR0]           =3D &sensor0_clk.common.hw,
> +               [CLK_SENSOR1]           =3D &sensor1_clk.common.hw,
> +               [CLK_SENSOR2]           =3D &sensor2_clk.common.hw,
> +               [CLK_MM_VEMC]           =3D &mm_vemc.common.hw,
> +               [CLK_MM_VAHB]           =3D &mm_vahb.common.hw,
> +               [CLK_VSP]               =3D &clk_vsp.common.hw,
> +               [CLK_CORE0]             =3D &core0_clk.common.hw,
> +               [CLK_CORE1]             =3D &core1_clk.common.hw,
> +               [CLK_CORE2]             =3D &core2_clk.common.hw,
> +               [CLK_CORE3]             =3D &core3_clk.common.hw,
> +               [CLK_CORE4]             =3D &core4_clk.common.hw,
> +               [CLK_CORE5]             =3D &core5_clk.common.hw,
> +               [CLK_CORE6]             =3D &core6_clk.common.hw,
> +               [CLK_CORE7]             =3D &core7_clk.common.hw,
> +               [CLK_SCU]               =3D &scu_clk.common.hw,
> +               [CLK_ACE]               =3D &ace_clk.common.hw,
> +               [CLK_AXI_PERIPH]        =3D &axi_periph_clk.common.hw,
> +               [CLK_AXI_ACP]           =3D &axi_acp_clk.common.hw,
> +               [CLK_ATB]               =3D &atb_clk.common.hw,
> +               [CLK_DEBUG_APB]         =3D &debug_apb_clk.common.hw,
> +               [CLK_GIC]               =3D &gic_clk.common.hw,
> +               [CLK_PERIPH]            =3D &periph_clk.common.hw,
> +       },
> +       .num    =3D CLK_AON_CLK_NUM,
> +};
> +
> +static const struct sprd_clk_desc sc9863a_aon_clk_desc =3D {
> +       .clk_clks       =3D sc9863a_aon_clks,
> +       .num_clk_clks   =3D ARRAY_SIZE(sc9863a_aon_clks),
> +       .hw_clks        =3D &sc9863a_aon_clk_hws,
> +};
> +
> +static SPRD_SC_GATE_CLK(otg_eb, "otg-eb", "ap-axi", 0x0, 0x1000,
> +                       BIT(4), CLK_IGNORE_UNUSED, 0);
> +static SPRD_SC_GATE_CLK(dma_eb, "dma-eb", "ap-axi", 0x0, 0x1000,
> +                       BIT(5), CLK_IGNORE_UNUSED, 0);
> +static SPRD_SC_GATE_CLK(ce_eb, "ce-eb", "ap-axi", 0x0, 0x1000,
> +                       BIT(6), CLK_IGNORE_UNUSED, 0);
> +static SPRD_SC_GATE_CLK(nandc_eb, "nandc-eb", "ap-axi", 0x0, 0x1000,
> +                       BIT(7), CLK_IGNORE_UNUSED, 0);
> +static SPRD_SC_GATE_CLK(sdio0_eb, "sdio0-eb", "ap-axi", 0x0, 0x1000,
> +                       BIT(8), CLK_IGNORE_UNUSED, 0);
> +static SPRD_SC_GATE_CLK(sdio1_eb, "sdio1-eb", "ap-axi", 0x0, 0x1000,
> +                       BIT(9), CLK_IGNORE_UNUSED, 0);
> +static SPRD_SC_GATE_CLK(sdio2_eb, "sdio2-eb", "ap-axi", 0x0, 0x1000,
> +                       BIT(10), CLK_IGNORE_UNUSED, 0);
> +static SPRD_SC_GATE_CLK(emmc_eb, "emmc-eb", "ap-axi", 0x0, 0x1000,
> +                       BIT(11), CLK_IGNORE_UNUSED, 0);
> +static SPRD_SC_GATE_CLK(emmc_32k_eb, "emmc-32k-eb", "ap-axi", 0x0, 0x100=
0,
> +                       BIT(27), CLK_IGNORE_UNUSED, 0);
> +static SPRD_SC_GATE_CLK(sdio0_32k_eb, "sdio0-32k-eb", "ap-axi", 0x0, 0x1=
000,
> +                       BIT(28), CLK_IGNORE_UNUSED, 0);
> +static SPRD_SC_GATE_CLK(sdio1_32k_eb, "sdio1-32k-eb", "ap-axi", 0x0, 0x1=
000,
> +                       BIT(29), CLK_IGNORE_UNUSED, 0);
> +static SPRD_SC_GATE_CLK(sdio2_32k_eb, "sdio2-32k-eb", "ap-axi", 0x0, 0x1=
000,
> +                       BIT(30), CLK_IGNORE_UNUSED, 0);
> +static SPRD_SC_GATE_CLK(nandc_26m_eb, "nandc-26m-eb", "ap-axi", 0x0, 0x1=
000,
> +                       BIT(31), CLK_IGNORE_UNUSED, 0);
> +static SPRD_SC_GATE_CLK(dma_eb2, "dma-eb2", "ap-axi", 0x18, 0x1000,
> +                       BIT(0), CLK_IGNORE_UNUSED, 0);
> +static SPRD_SC_GATE_CLK(ce_eb2, "ce-eb2", "ap-axi", 0x18, 0x1000,
> +                       BIT(1), CLK_IGNORE_UNUSED, 0);
> +
> +static struct sprd_clk_common *sc9863a_apahb_gate_clks[] =3D {
> +       /* address base is 0x20e00000 */
> +       &otg_eb.common,
> +       &dma_eb.common,
> +       &ce_eb.common,
> +       &nandc_eb.common,
> +       &sdio0_eb.common,
> +       &sdio1_eb.common,
> +       &sdio2_eb.common,
> +       &emmc_eb.common,
> +       &emmc_32k_eb.common,
> +       &sdio0_32k_eb.common,
> +       &sdio1_32k_eb.common,
> +       &sdio2_32k_eb.common,
> +       &nandc_26m_eb.common,
> +       &dma_eb2.common,
> +       &ce_eb2.common,
> +};
> +
> +static struct clk_hw_onecell_data sc9863a_apahb_gate_hws =3D {
> +       .hws    =3D {
> +               [CLK_OTG_EB]            =3D &otg_eb.common.hw,
> +               [CLK_DMA_EB]            =3D &dma_eb.common.hw,
> +               [CLK_CE_EB]             =3D &ce_eb.common.hw,
> +               [CLK_NANDC_EB]          =3D &nandc_eb.common.hw,
> +               [CLK_SDIO0_EB]          =3D &sdio0_eb.common.hw,
> +               [CLK_SDIO1_EB]          =3D &sdio1_eb.common.hw,
> +               [CLK_SDIO2_EB]          =3D &sdio2_eb.common.hw,
> +               [CLK_EMMC_EB]           =3D &emmc_eb.common.hw,
> +               [CLK_EMMC_32K_EB]       =3D &emmc_32k_eb.common.hw,
> +               [CLK_SDIO0_32K_EB]      =3D &sdio0_32k_eb.common.hw,
> +               [CLK_SDIO1_32K_EB]      =3D &sdio1_32k_eb.common.hw,
> +               [CLK_SDIO2_32K_EB]      =3D &sdio2_32k_eb.common.hw,
> +               [CLK_NANDC_26M_EB]      =3D &nandc_26m_eb.common.hw,
> +               [CLK_DMA_EB2]           =3D &dma_eb2.common.hw,
> +               [CLK_CE_EB2]            =3D &ce_eb2.common.hw,
> +       },
> +       .num    =3D CLK_AP_AHB_GATE_NUM,
> +};
> +
> +static const struct sprd_clk_desc sc9863a_apahb_gate_desc =3D {
> +       .clk_clks       =3D sc9863a_apahb_gate_clks,
> +       .num_clk_clks   =3D ARRAY_SIZE(sc9863a_apahb_gate_clks),
> +       .hw_clks        =3D &sc9863a_apahb_gate_hws,
> +};
> +
> +/* aon gate clocks */
> +static SPRD_SC_GATE_CLK(adc_eb,        "adc-eb",       "aon-apb", 0x0,
> +                    0x1000, BIT(0), CLK_IGNORE_UNUSED, 0);

There's a lot of CLK_IGNORE_UNUSED. Why? Can you please add a comment in
the code about why we need this flag or remove the flag?

> +static SPRD_SC_GATE_CLK(fm_eb, "fm-eb",        "aon-apb", 0x0,
> +                    0x1000, BIT(1), CLK_IGNORE_UNUSED, 0);
> +static SPRD_SC_GATE_CLK(tpc_eb,        "tpc-eb",       "aon-apb", 0x0,
> +                    0x1000, BIT(2), CLK_IGNORE_UNUSED, 0);
> +static SPRD_SC_GATE_CLK(gpio_eb, "gpio-eb",    "aon-apb", 0x0,
> +                    0x1000, BIT(3), CLK_IGNORE_UNUSED, 0);
[...]
> +
> +static const struct sprd_clk_desc sc9863a_apapb_gate_desc =3D {
> +       .clk_clks       =3D sc9863a_apapb_gate,
> +       .num_clk_clks   =3D ARRAY_SIZE(sc9863a_apapb_gate),
> +       .hw_clks        =3D &sc9863a_apapb_gate_hws,
> +};
> +
> +static const struct of_device_id sprd_sc9863a_clk_ids[] =3D {
> +       { .compatible =3D "sprd,sc9863a-ap-clk",  /* 0x21500000 */

What are the comments? Register addresses?

> +         .data =3D &sc9863a_ap_clk_desc },
> +       { .compatible =3D "sprd,sc9863a-pmu-gate",        /* 0x402b0000 */
> +         .data =3D &sc9863a_pmu_gate_desc },
> +       { .compatible =3D "sprd,sc9863a-pll",     /* 0x40353000 */
> +         .data =3D &sc9863a_pll_desc },
> +       { .compatible =3D "sprd,sc9863a-mpll",    /* 0x40359000 */
> +         .data =3D &sc9863a_mpll_desc },
> +       { .compatible =3D "sprd,sc9863a-rpll",    /* 0x4035c000 */
> +         .data =3D &sc9863a_rpll_desc },
> +       { .compatible =3D "sprd,sc9863a-dpll",    /* 0x40363000 */
> +         .data =3D &sc9863a_dpll_desc },
> +       { .compatible =3D "sprd,sc9863a-aon-clk", /* 0x402d0000 */
> +         .data =3D &sc9863a_aon_clk_desc },
> +       { .compatible =3D "sprd,sc9863a-apahb-gate",      /* 0x20e00000 */
> +         .data =3D &sc9863a_apahb_gate_desc },
> +       { .compatible =3D "sprd,sc9863a-aonapb-gate",     /* 0x402e0000 */
> +         .data =3D &sc9863a_aonapb_gate_desc },
> +       { .compatible =3D "sprd,sc9863a-mm-gate", /* 0x60800000 */
> +         .data =3D &sc9863a_mm_gate_desc },
> +       { .compatible =3D "sprd,sc9863a-mm-clk",  /* 0x60900000 */
> +         .data =3D &sc9863a_mm_clk_desc },
> +       { .compatible =3D "sprd,sc9863a-vspahb-gate",     /* 0x62000000 */
> +         .data =3D &sc9863a_vspahb_gate_desc },
> +       { .compatible =3D "sprd,sc9863a-apapb-gate",      /* 0x71300000 */
> +         .data =3D &sc9863a_apapb_gate_desc },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, sprd_sc9863a_clk_ids);
> +
> +static int sc9863a_clk_probe(struct platform_device *pdev)
> +{
> +       const struct of_device_id *match;
> +       const struct sprd_clk_desc *desc;
> +
> +       match =3D of_match_node(sprd_sc9863a_clk_ids, pdev->dev.of_node);
> +       if (!match) {
> +               pr_err("%s: of_match_node() failed", __func__);
> +               return -ENODEV;
> +       }

Use device_get_match_data() instead.

> +
> +       desc =3D match->data;
> +       sprd_clk_regmap_init(pdev, desc);
> +
> +       return sprd_clk_probe(&pdev->dev, desc->hw_clks);
> +}
> +
> +static struct platform_driver sc9863a_clk_driver =3D {
> +       .probe  =3D sc9863a_clk_probe,
> +       .driver =3D {
> +               .name   =3D "sc9863a-clk",
> +               .of_match_table =3D sprd_sc9863a_clk_ids,
> +       },
> +};
> +module_platform_driver(sc9863a_clk_driver);
> +
> +MODULE_DESCRIPTION("Spreadtrum SC9863A Clock Driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:sc9863a-clk");

Drop the module alias, it doesn't help from what I can recall.

