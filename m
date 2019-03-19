Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E94C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 09:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF94620854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 09:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ivVZ6pzl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfCSJeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 05:34:17 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51961 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfCSJeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 05:34:17 -0400
Received: by mail-wm1-f65.google.com with SMTP id n19so15822789wmi.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 02:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1secG8grQnDRzOPQL9tPYAFq3zh/WVmWP3ZHLtk8oeQ=;
        b=ivVZ6pzlVyyc019tK8EgOr+wcslYmqPierr3nIm2a6YkftCCS3sj3/GbjWZ8CsYNTF
         eOLi+n4/Q8cuMAAZW1bHu//4+5kFwiSw3gBi8zZdii2Gu8F9/X4Fb+gtwi3gvT/rs3AG
         1VnL2cVuEUIcsS32pDWlAiP0PCbVpYQitW/MWtgaYTRR8X7V7sWxX4as5rpCVaX4Qwiu
         M4Pg+wsfVjBdQU5pq0mzhOSpQ8Dh+sCEvDhCLeZ/jSVEzTEAZ79r549tI7uAysuN+4vr
         N5nFfgyMUf8G8BApahOYWmyPFJjs3tV7g1zlUJCr4helVhVAuPGkvw5bnb9//lcU5fLS
         fqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1secG8grQnDRzOPQL9tPYAFq3zh/WVmWP3ZHLtk8oeQ=;
        b=b2YyHR1aDsRH6iwKcVjgfBOW4VdrTOkBoavQprINZ1OYTYYoGCS7xaYAG7YSgjs8PJ
         M66zDm42fmrRdHyBbe7T0tnjRU6sbniy2VPOeNNYTDGm/PvSC4dsMiL9LWQiJyU1GEx4
         YjVB4TghmPa5WBhS9f/GMvTNGCyI/ThLKEEotNmF+sypCzXl15FzqOoH67GR4awYffdN
         W6q6QgpcqKa61Rqm8zu3zjl6dqaOz55mUpm/yjSJT0MswWd2Mx8iRwfhK1HRtvpfNQWw
         XTTHzwZuQBSuVpitK2QII9d57aq7igLvnT6kX9l8ONOuodeeUCDjkLiWPu6g/0qm1Zhc
         KR+A==
X-Gm-Message-State: APjAAAWQUjLtBRnof/PEA7AKgS4MHYlnx5bWMluSCbHKih3hGF9j/UkA
        Ddo645ctXOvZbiwyrfMme5X3OMiW7K1meg+CvPqLgw==
X-Google-Smtp-Source: APXvYqwit9HuMrFvVxwlOC7XX16+R9K2iHAyLsDcVmomSfJ1yp2SMOUXxKT6+drqa8hXKPtkIc0z++fU+zTqNqCFslE=
X-Received: by 2002:a7b:c5c3:: with SMTP id n3mr1761678wmk.82.1552988054233;
 Tue, 19 Mar 2019 02:34:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190319085044.8581-1-mjourdan@baylibre.com> <20190319085044.8581-3-mjourdan@baylibre.com>
 <941196f5fe605d4ea10689129a70ee2900b759e7.camel@baylibre.com>
In-Reply-To: <941196f5fe605d4ea10689129a70ee2900b759e7.camel@baylibre.com>
From:   Maxime Jourdan <mjourdan@baylibre.com>
Date:   Tue, 19 Mar 2019 10:34:03 +0100
Message-ID: <CAMO6nayZzBb7jaN3-nkxqQT+9-h3+oAtAr=jnrvcDYhHGBKAeA@mail.gmail.com>
Subject: Re: [PATCH 2/2] clk: meson-g12a: add video decoder clocks
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,
On Tue, Mar 19, 2019 at 10:09 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> On Tue, 2019-03-19 at 09:50 +0100, Maxime Jourdan wrote:
>
> A complete sentence would have been nice ;)
>
> Add the video decoder clocks which are ...
>

Sorry about that, I'll apply myself in the future.

> > Mostly like meson-gx, except that the VDEC_HEVC clock is now split in two:
> > HEVC and HEVCF.
> >
> > Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
> > ---
> >  drivers/clk/meson/g12a.c | 160 +++++++++++++++++++++++++++++++++++++++
> >  drivers/clk/meson/g12a.h |   8 +-
> >  2 files changed, 167 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> > index 3a3134976534..cfb91df884cb 100644
> > --- a/drivers/clk/meson/g12a.c
> > +++ b/drivers/clk/meson/g12a.c
> > @@ -1495,6 +1495,148 @@ static struct clk_regmap g12a_vpu = {
> >       },
> >  };
> >
> > +/* VDEC clocks */
> > +
> > +static const char * const g12a_vdec_parent_names[] = {
> > +     "fclk_div2p5", "fclk_div3", "fclk_div4", "fclk_div5", "fclk_div7",
> > +     "hifi_pll", "gp0_pll",
> > +};
> > +
> > +static struct clk_regmap g12a_vdec_1_sel = {
> > +     .data = &(struct clk_regmap_mux_data){
> > +             .offset = HHI_VDEC_CLK_CNTL,
> > +             .mask = 0x7,
> > +             .shift = 9,
> > +             .flags = CLK_MUX_ROUND_CLOSEST,
> > +     },
> > +     .hw.init = &(struct clk_init_data){
> > +             .name = "vdec_1_sel",
> > +             .ops = &clk_regmap_mux_ops,
> > +             .parent_names = g12a_vdec_parent_names,
> > +             .num_parents = ARRAY_SIZE(g12a_vdec_parent_names),
> > +             .flags = CLK_SET_RATE_PARENT,
> > +     },
> > +};
> > +
> > +static struct clk_regmap g12a_vdec_1_div = {
> > +     .data = &(struct clk_regmap_div_data){
> > +             .offset = HHI_VDEC_CLK_CNTL,
> > +             .shift = 0,
> > +             .width = 7,
>
> Maxime, the parent mux has "ROUND_CLOSEST" but this div does not, which means
> it will round down. Is it on purpose ?
>
> * If you can't the allow vdec_1 to round above the request (for safety reason
> maybe) then none of the element should round closest.
> * If you want closest achievable frequency (even if higher) for vdec_1, then
> both element should round closest.
>
> Same comment applies below
>
> This is not a blocker but I'd like you to clarify.
>

The goal is indeed to always round closest, so I will add the divider
flags (all of the three divs need it, not just this one).

I based most of those clocks from the ones in GXBB, which do not
include the flags. I'll push a fix for this platform as well.

Cheers,
Maxime

> > +     },
> > +     .hw.init = &(struct clk_init_data){
> > +             .name = "vdec_1_div",
> > +             .ops = &clk_regmap_divider_ops,
> > +             .parent_names = (const char *[]){ "vdec_1_sel" },
> > +             .num_parents = 1,
> > +             .flags = CLK_SET_RATE_PARENT,
> > +     },
> > +};
> > +
> > +static struct clk_regmap g12a_vdec_1 = {
> > +     .data = &(struct clk_regmap_gate_data){
> > +             .offset = HHI_VDEC_CLK_CNTL,
> > +             .bit_idx = 8,
> > +     },
> > +     .hw.init = &(struct clk_init_data) {
> > +             .name = "vdec_1",
> > +             .ops = &clk_regmap_gate_ops,
> > +             .parent_names = (const char *[]){ "vdec_1_div" },
> > +             .num_parents = 1,
> > +             .flags = CLK_SET_RATE_PARENT,
> > +     },
> > +};
> > +
> > +static struct clk_regmap g12a_vdec_hevcf_sel = {
> > +     .data = &(struct clk_regmap_mux_data){
> > +             .offset = HHI_VDEC2_CLK_CNTL,
> > +             .mask = 0x7,
> > +             .shift = 9,
> > +             .flags = CLK_MUX_ROUND_CLOSEST,
> > +     },
> > +     .hw.init = &(struct clk_init_data){
> > +             .name = "vdec_hevcf_sel",
> > +             .ops = &clk_regmap_mux_ops,
> > +             .parent_names = g12a_vdec_parent_names,
> > +             .num_parents = ARRAY_SIZE(g12a_vdec_parent_names),
> > +             .flags = CLK_SET_RATE_PARENT,
> > +     },
> > +};
> > +
> > +static struct clk_regmap g12a_vdec_hevcf_div = {
> > +     .data = &(struct clk_regmap_div_data){
> > +             .offset = HHI_VDEC2_CLK_CNTL,
> > +             .shift = 0,
> > +             .width = 7,
> > +     },
> > +     .hw.init = &(struct clk_init_data){
> > +             .name = "vdec_hevcf_div",
> > +             .ops = &clk_regmap_divider_ops,
> > +             .parent_names = (const char *[]){ "vdec_hevcf_sel" },
> > +             .num_parents = 1,
> > +             .flags = CLK_SET_RATE_PARENT,
> > +     },
> > +};
> > +
> > +static struct clk_regmap g12a_vdec_hevcf = {
> > +     .data = &(struct clk_regmap_gate_data){
> > +             .offset = HHI_VDEC2_CLK_CNTL,
> > +             .bit_idx = 8,
> > +     },
> > +     .hw.init = &(struct clk_init_data) {
> > +             .name = "vdec_hevcf",
> > +             .ops = &clk_regmap_gate_ops,
> > +             .parent_names = (const char *[]){ "vdec_hevcf_div" },
> > +             .num_parents = 1,
> > +             .flags = CLK_SET_RATE_PARENT,
> > +     },
> > +};
> > +
> > +static struct clk_regmap g12a_vdec_hevc_sel = {
> > +     .data = &(struct clk_regmap_mux_data){
> > +             .offset = HHI_VDEC2_CLK_CNTL,
> > +             .mask = 0x7,
> > +             .shift = 25,
> > +             .flags = CLK_MUX_ROUND_CLOSEST,
> > +     },
> > +     .hw.init = &(struct clk_init_data){
> > +             .name = "vdec_hevc_sel",
> > +             .ops = &clk_regmap_mux_ops,
> > +             .parent_names = g12a_vdec_parent_names,
> > +             .num_parents = ARRAY_SIZE(g12a_vdec_parent_names),
> > +             .flags = CLK_SET_RATE_PARENT,
> > +     },
> > +};
> > +
> > +static struct clk_regmap g12a_vdec_hevc_div = {
> > +     .data = &(struct clk_regmap_div_data){
> > +             .offset = HHI_VDEC2_CLK_CNTL,
> > +             .shift = 16,
> > +             .width = 7,
> > +     },
> > +     .hw.init = &(struct clk_init_data){
> > +             .name = "vdec_hevc_div",
> > +             .ops = &clk_regmap_divider_ops,
> > +             .parent_names = (const char *[]){ "vdec_hevc_sel" },
> > +             .num_parents = 1,
> > +             .flags = CLK_SET_RATE_PARENT,
> > +     },
> > +};
> > +
> > +static struct clk_regmap g12a_vdec_hevc = {
> > +     .data = &(struct clk_regmap_gate_data){
> > +             .offset = HHI_VDEC2_CLK_CNTL,
> > +             .bit_idx = 24,
> > +     },
> > +     .hw.init = &(struct clk_init_data) {
> > +             .name = "vdec_hevc",
> > +             .ops = &clk_regmap_gate_ops,
> > +             .parent_names = (const char *[]){ "vdec_hevc_div" },
> > +             .num_parents = 1,
> > +             .flags = CLK_SET_RATE_PARENT,
> > +     },
> > +};
> > +
> >  /* VAPB Clock */
> >
> >  static const char * const g12a_vapb_parent_names[] = {
> > @@ -2615,6 +2757,15 @@ static struct clk_hw_onecell_data g12a_hw_onecell_data = {
> >               [CLKID_PCIE_PLL_DCO_DIV2]       = &g12a_pcie_pll_dco_div2.hw,
> >               [CLKID_PCIE_PLL_OD]             = &g12a_pcie_pll_od.hw,
> >               [CLKID_PCIE_PLL]                = &g12a_pcie_pll.hw,
> > +             [CLKID_VDEC_1_SEL]              = &g12a_vdec_1_sel.hw,
> > +             [CLKID_VDEC_1_DIV]              = &g12a_vdec_1_div.hw,
> > +             [CLKID_VDEC_1]                  = &g12a_vdec_1.hw,
> > +             [CLKID_VDEC_HEVC_SEL]           = &g12a_vdec_hevc_sel.hw,
> > +             [CLKID_VDEC_HEVC_DIV]           = &g12a_vdec_hevc_div.hw,
> > +             [CLKID_VDEC_HEVC]               = &g12a_vdec_hevc.hw,
> > +             [CLKID_VDEC_HEVCF_SEL]          = &g12a_vdec_hevcf_sel.hw,
> > +             [CLKID_VDEC_HEVCF_DIV]          = &g12a_vdec_hevcf_div.hw,
> > +             [CLKID_VDEC_HEVCF]              = &g12a_vdec_hevcf.hw,
> >               [NR_CLKS]                       = NULL,
> >       },
> >       .num = NR_CLKS,
> > @@ -2803,6 +2954,15 @@ static struct clk_regmap *const g12a_clk_regmaps[] = {
> >       &g12a_cpu_clk_trace,
> >       &g12a_pcie_pll_od,
> >       &g12a_pcie_pll_dco,
> > +     &g12a_vdec_1_sel,
> > +     &g12a_vdec_1_div,
> > +     &g12a_vdec_1,
> > +     &g12a_vdec_hevc_sel,
> > +     &g12a_vdec_hevc_div,
> > +     &g12a_vdec_hevc,
> > +     &g12a_vdec_hevcf_sel,
> > +     &g12a_vdec_hevcf_div,
> > +     &g12a_vdec_hevcf,
> >  };
> >
> >  static const struct meson_eeclkc_data g12a_clkc_data = {
> > diff --git a/drivers/clk/meson/g12a.h b/drivers/clk/meson/g12a.h
> > index 1393a09730a6..39c41af70804 100644
> > --- a/drivers/clk/meson/g12a.h
> > +++ b/drivers/clk/meson/g12a.h
> > @@ -189,8 +189,14 @@
> >  #define CLKID_PCIE_PLL_DCO                   198
> >  #define CLKID_PCIE_PLL_DCO_DIV2                      199
> >  #define CLKID_PCIE_PLL_OD                    200
> > +#define CLKID_VDEC_1_SEL                     202
> > +#define CLKID_VDEC_1_DIV                     203
> > +#define CLKID_VDEC_HEVC_SEL                  205
> > +#define CLKID_VDEC_HEVC_DIV                  206
> > +#define CLKID_VDEC_HEVCF_SEL                 208
> > +#define CLKID_VDEC_HEVCF_DIV                 209
> >
> > -#define NR_CLKS                                      202
> > +#define NR_CLKS                                      211
> >
> >  /* include the CLKIDs that have been made part of the DT binding */
> >  #include <dt-bindings/clock/g12a-clkc.h>
>
>
