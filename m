Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EB4C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC87A2087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="rpkIuibh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388454AbfCAPWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 10:22:05 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45347 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfCAPWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 10:22:04 -0500
Received: by mail-ot1-f66.google.com with SMTP id i12so73856otp.12;
        Fri, 01 Mar 2019 07:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nEWhoqG0yy8oRKJUv2b+odXl1HSbpLmKNQS3HAfw1Ek=;
        b=rpkIuibhDdls/tVRj0vjGnGMhbMtxBNfEWAPK/a1cOj7SF3HOEudQgHfyL8IfaykRc
         IkPuBrYuv8Rm5JONxAYuBbGFCKmOfqIKBkOLE33MUIaK2AK4pkroj+NpmULNaUIsYQ0g
         /RRZSXdZS86MnwTrKGpzV41yT1k+KPV+cg/UtfHavZC2FX5W5nASPPDHt3LTB/PD0DJ/
         ObC7eLnDTpnG9wFaezkJgolxkWnEFbUkMHMzb/5edqWaH2PzOS7F/dudkpo5eXDSsyJW
         gjI8KJ/pQkwZoL41mWTxTxsO5JmFq0ilvMTd+vAgelMF8o65jjTq47HIK+tIIWfV7wEr
         vM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nEWhoqG0yy8oRKJUv2b+odXl1HSbpLmKNQS3HAfw1Ek=;
        b=j81xvN8/kUouP6q8vqqrRTPlDLtSZ6zMbTRr4rwQtVmEFr1p1RpNKOacy7GIoAxUb3
         5/xI2cSMjCJ/XO4D8oTnaafMPlCOi3Wa3A+q9p2oxO2+C8CJwDGza0Jiulw9gObDJzmJ
         snmIocE3qy7gvban9D4OWAcf0uFNLCYvHYit+OugqqzYkWjiA7c6vq12n46b1iAxoVo3
         rIAnz5Cs0PN3b+/jnjSwh+8doD4naw2lWHyRFGJnmIiBthJXvifwoc4YsoKEhKAi6Xva
         cnTsAcf2oJxo3kXRoANSoOzSMYIrUObZ5wByiaDPKn0U+KqgXJBrGjf7+N0hCseKJRru
         /ofw==
X-Gm-Message-State: APjAAAWRD1KAMa/MrABoLoQRxs103L/x9oDKwIL7pKyZBlSoPe7fIJhF
        wrkP3jSIvdp4L7NJnYC7kO1t6eV9M35tPo1aXY1Oka26
X-Google-Smtp-Source: APXvYqwPhK4Xk646kSfdMMeXRFy5v3XMVzjVFrEsJ2InqePIn07FhUvk0Jv7QQc3DAifRAbrNrTPTvdhW3o4QVe+Aks=
X-Received: by 2002:a9d:5906:: with SMTP id t6mr3726435oth.308.1551453723428;
 Fri, 01 Mar 2019 07:22:03 -0800 (PST)
MIME-Version: 1.0
References: <20190301102140.7181-1-narmstrong@baylibre.com> <20190301102140.7181-3-narmstrong@baylibre.com>
In-Reply-To: <20190301102140.7181-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 1 Mar 2019 16:21:52 +0100
Message-ID: <CAFBinCC1b5Q8Y=5qXKJ+B1XBhpo8PGFYHwTEeVTgbXwz7ge3-A@mail.gmail.com>
Subject: Re: [PATCH 2/2] clk: meson: g12a: add cpu clocks
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

it's great to see the progress on G12A!

On Fri, Mar 1, 2019 at 11:22 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add the Amlogic G12A Family CPU Clock tree in read/only for now.
>
> The CPU clock can either use the SYS_PLL for > 1GHz frequencies or
> use a couple of div+mux from 1GHz/667MHz/24MHz source with 2 non-glitch
> muxes.
>
> Proper DVFS support will come in a second time.
can you please also mention that this adds various CPU clock
post-dividers (APB, ATB, AXI and CPU trace)?
I don't mind them being int his patchset

disclaimer for my code-review:
- I don't have access to the datasheet so I can't verify if the clock
tree from this patch is correct
- the latest buildroot code with G12A support
(buildroot_openlinux_kernel_4.9_fbdev_20180706) doesn't have proper
names for all clocks
- based on my experience with Meson8* this looks good overall, some
questions and comments below

> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>
> ---
>  drivers/clk/meson/g12a.c | 348 +++++++++++++++++++++++++++++++++++++++
>  drivers/clk/meson/g12a.h |   1 +
>  2 files changed, 349 insertions(+)
>
> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> index 0e1ce8c03259..4c938f1b8421 100644
> --- a/drivers/clk/meson/g12a.c
> +++ b/drivers/clk/meson/g12a.c
> @@ -150,6 +150,316 @@ static struct clk_regmap g12a_sys_pll = {
>         },
>  };
>
> +static struct clk_regmap g12a_sys_pll_div16_en = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = HHI_SYS_CPU_CLK_CNTL1,
> +               .bit_idx = 24,
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "sys_pll_div16_en",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_names = (const char *[]){ "sys_pll" },
> +               .num_parents = 1,
> +               /*
> +                * This clock is used to debug the sys_pll range
> +                * Linux should not change it at runtime
> +                */
if we're not supposed to touch this the enable bit, can you switch to
clk_regmap_gate_ro_ops ?

> +               .flags = CLK_IGNORE_UNUSED,
> +       },
> +};
> +
> +static struct clk_fixed_factor g12a_sys_pll_div16 = {
> +       .mult = 1,
> +       .div = 16,
> +       .hw.init = &(struct clk_init_data){
> +               .name = "sys_pll_div16",
> +               .ops = &clk_fixed_factor_ops,
> +               .parent_names = (const char *[]){ "sys_pll_div16_en" },
> +               .num_parents = 1,
> +       },
> +};
> +
> +static struct clk_regmap g12a_cpu_clk_dyn0_sel = {
> +       .data = &(struct clk_regmap_mux_data){
> +               .offset = HHI_SYS_CPU_CLK_CNTL0,
> +               .mask = 0x3,
> +               .shift = 0,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "cpu_clk_dyn0_sel",
the buildroot code has a variable with the name "p_premux"
I'm not sure what the datasheet states, but maybe this should be
cpu_clk_dyn0_pre_sel
same applies to the corresponding dyn1 clock below

> +               .ops = &clk_regmap_mux_ro_ops,
> +               .parent_names = (const char *[]){ IN_PREFIX "xtal",
> +                                                 "fclk_div2",
> +                                                 "fclk_div3" },
> +               .num_parents = 3,
> +       },
> +};
> +
> +static struct clk_regmap g12a_cpu_clk_dyn0_div = {
> +       .data = &(struct clk_regmap_div_data){
> +               .offset = HHI_SYS_CPU_CLK_CNTL0,
> +               .shift = 4,
> +               .width = 6,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "cpu_clk_dyn0_div",
> +               .ops = &clk_regmap_divider_ro_ops,
> +               .parent_names = (const char *[]){ "cpu_clk_dyn0_sel" },
> +               .num_parents = 1,
> +       },
> +};
> +
> +static struct clk_regmap g12a_cpu_clk_dyn0 = {
> +       .data = &(struct clk_regmap_mux_data){
> +               .offset = HHI_SYS_CPU_CLK_CNTL0,
> +               .mask = 0x1,
> +               .shift = 2,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "cpu_clk_dyn0",
the buildroot code has a variable with the name "p_postmux". in this
case I would leave the name "cpu_clk_dyn0" because it's the "output"
of this specific "clock tree/branch".
same applies to the corresponding dyn1 clock below

> +               .ops = &clk_regmap_mux_ro_ops,
> +               .parent_names = (const char *[]){ "cpu_clk_dyn0_sel",
> +                                                 "cpu_clk_dyn0_div" },
> +               .num_parents = 2,
> +       },
> +};
> +
> +static struct clk_regmap g12a_cpu_clk_dyn1_sel = {
> +       .data = &(struct clk_regmap_mux_data){
> +               .offset = HHI_SYS_CPU_CLK_CNTL0,
> +               .mask = 0x3,
> +               .shift = 16,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "cpu_clk_dyn1_sel",
> +               .ops = &clk_regmap_mux_ro_ops,
> +               .parent_names = (const char *[]){ IN_PREFIX "xtal",
> +                                                 "fclk_div2",
> +                                                 "fclk_div3" },
> +               .num_parents = 3,
> +       },
> +};
> +
> +static struct clk_regmap g12a_cpu_clk_dyn1_div = {
> +       .data = &(struct clk_regmap_div_data){
> +               .offset = HHI_SYS_CPU_CLK_CNTL0,
> +               .shift = 20,
> +               .width = 6,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "cpu_clk_dyn1_div",
> +               .ops = &clk_regmap_divider_ro_ops,
> +               .parent_names = (const char *[]){ "cpu_clk_dyn1_sel" },
> +               .num_parents = 1,
> +       },
> +};
> +
> +static struct clk_regmap g12a_cpu_clk_dyn1 = {
> +       .data = &(struct clk_regmap_mux_data){
> +               .offset = HHI_SYS_CPU_CLK_CNTL0,
> +               .mask = 0x1,
> +               .shift = 18,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "cpu_clk_dyn1",
> +               .ops = &clk_regmap_mux_ro_ops,
> +               .parent_names = (const char *[]){ "cpu_clk_dyn1_sel",
> +                                                 "cpu_clk_dyn1_div" },
> +               .num_parents = 2,
> +       },
> +};
> +
> +static struct clk_regmap g12a_cpu_clk_dyn = {
> +       .data = &(struct clk_regmap_mux_data){
> +               .offset = HHI_SYS_CPU_CLK_CNTL0,
> +               .mask = 0x1,
> +               .shift = 10,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "cpu_clk_dyn",
> +               .ops = &clk_regmap_mux_ro_ops,
> +               .parent_names = (const char *[]){ "cpu_clk_dyn0",
> +                                                 "cpu_clk_dyn1" },
> +               .num_parents = 2,
> +       },
> +};
> +
> +static struct clk_regmap g12a_cpu_clk = {
> +       .data = &(struct clk_regmap_mux_data){
> +               .offset = HHI_SYS_CPU_CLK_CNTL0,
> +               .mask = 0x1,
> +               .shift = 11,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "cpu_clk",
> +               .ops = &clk_regmap_mux_ro_ops,
> +               .parent_names = (const char *[]){ "cpu_clk_dyn",
> +                                                 "sys_pll" },
> +               .num_parents = 2,
> +       },
> +};
> +
> +static struct clk_regmap g12a_cpu_clk_div16_en = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = HHI_SYS_CPU_CLK_CNTL1,
> +               .bit_idx = 1,
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "cpu_clk_div16_en",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_names = (const char *[]){ "cpu_clk" },
> +               .num_parents = 1,
> +               /*
> +                * This clock is used to debug the cpu_clk range
> +                * Linux should not change it at runtime
> +                */
same as above: if we're not supposed to touch this the enable bit, can
you switch to clk_regmap_gate_ro_ops ?

> +               .flags = CLK_IGNORE_UNUSED,
> +       },
> +};
> +
> +static struct clk_fixed_factor g12a_cpu_clk_div16 = {
> +       .mult = 1,
> +       .div = 16,
> +       .hw.init = &(struct clk_init_data){
> +               .name = "cpu_clk_div16",
> +               .ops = &clk_fixed_factor_ops,
> +               .parent_names = (const char *[]){ "cpu_clk_div16_en" },
> +               .num_parents = 1,
> +       },
> +};
> +
> +static struct clk_regmap g12a_cpu_clk_apb_div = {
> +       .data = &(struct clk_regmap_div_data){
> +               .offset = HHI_SYS_CPU_CLK_CNTL1,
> +               .shift = 3,
> +               .width = 3,
> +               .flags = CLK_DIVIDER_POWER_OF_TWO,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "cpu_clk_apb_div",
> +               .ops = &clk_regmap_divider_ro_ops,
> +               .parent_names = (const char *[]){ "cpu_clk" },
> +               .num_parents = 1,
> +       },
> +};
> +
> +static struct clk_regmap g12a_cpu_clk_apb = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = HHI_SYS_CPU_CLK_CNTL1,
> +               .bit_idx = 1,
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "cpu_clk_apb",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_names = (const char *[]){ "cpu_clk_apb_div" },
> +               .num_parents = 1,
> +               /*
> +                * This clock is set by the ROM monitor code,
> +                * Linux should not change it at runtime
> +                */
same as above: if we're not supposed to touch this the enable bit, can
you switch to clk_regmap_gate_ro_ops ?

> +               .flags = CLK_IGNORE_UNUSED,
> +       },
> +};
> +
> +static struct clk_regmap g12a_cpu_clk_atb_div = {
> +       .data = &(struct clk_regmap_div_data){
> +               .offset = HHI_SYS_CPU_CLK_CNTL1,
> +               .shift = 6,
> +               .width = 3,
> +               .flags = CLK_DIVIDER_POWER_OF_TWO,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "cpu_clk_atb_div",
> +               .ops = &clk_regmap_divider_ro_ops,
> +               .parent_names = (const char *[]){ "cpu_clk" },
> +               .num_parents = 1,
> +       },
> +};
> +
> +static struct clk_regmap g12a_cpu_clk_atb = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = HHI_SYS_CPU_CLK_CNTL1,
> +               .bit_idx = 17,
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "cpu_clk_atb",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_names = (const char *[]){ "cpu_clk_atb_div" },
> +               .num_parents = 1,
> +               /*
> +                * This clock is set by the ROM monitor code,
> +                * Linux should not change it at runtime
> +                */
same as above: if we're not supposed to touch this the enable bit, can
you switch to clk_regmap_gate_ro_ops ?

> +               .flags = CLK_IGNORE_UNUSED,
> +       },
> +};
> +
> +static struct clk_regmap g12a_cpu_clk_axi_div = {
> +       .data = &(struct clk_regmap_div_data){
> +               .offset = HHI_SYS_CPU_CLK_CNTL1,
> +               .shift = 9,
> +               .width = 3,
> +               .flags = CLK_DIVIDER_POWER_OF_TWO,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "cpu_clk_axi_div",
> +               .ops = &clk_regmap_divider_ro_ops,
out of curiosity (this applies to all CPU clock post-dividers):
did you check whether CLK_DIVIDER_POWER_OF_TWO is correct on G12A?
I'm asking because on Meson8b the post-dividers select between one of:
"cpu_clk divided by 2, 3, 4, 5, 6, 7 or 8". also some of the
post-dividers use register value 0 for cpu_clk_div2 while others use
register value 1 for cpu_clk_div2.

> +               .parent_names = (const char *[]){ "cpu_clk" },
> +               .num_parents = 1,
> +       },
> +};
> +
> +static struct clk_regmap g12a_cpu_clk_axi = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = HHI_SYS_CPU_CLK_CNTL1,
> +               .bit_idx = 18,
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "cpu_clk_axi",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_names = (const char *[]){ "cpu_clk_axi_div" },
> +               .num_parents = 1,
> +               /*
> +                * This clock is set by the ROM monitor code,
> +                * Linux should not change it at runtime
> +                */
same as above: if we're not supposed to touch this the enable bit, can
you switch to clk_regmap_gate_ro_ops ?

> +               .flags = CLK_IGNORE_UNUSED,
> +       },
> +};
> +
> +static struct clk_regmap g12a_cpu_clk_trace_div = {
> +       .data = &(struct clk_regmap_div_data){
> +               .offset = HHI_SYS_CPU_CLK_CNTL1,
> +               .shift = 20,
> +               .width = 3,
> +               .flags = CLK_DIVIDER_POWER_OF_TWO,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "cpu_clk_trace_div",
> +               .ops = &clk_regmap_divider_ro_ops,
> +               .parent_names = (const char *[]){ "cpu_clk" },
> +               .num_parents = 1,
> +       },
> +};
> +
> +static struct clk_regmap g12a_cpu_clk_trace = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = HHI_SYS_CPU_CLK_CNTL1,
> +               .bit_idx = 23,
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "cpu_clk_trace",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_names = (const char *[]){ "cpu_clk_trace_div" },
> +               .num_parents = 1,
> +               /*
> +                * This clock is set by the ROM monitor code,
> +                * Linux should not change it at runtime
> +                */
same as above: if we're not supposed to touch this the enable bit, can
you switch to clk_regmap_gate_ro_ops ?

> +               .flags = CLK_IGNORE_UNUSED,
> +       },
> +};
> +
>  static const struct pll_mult_range g12a_gp0_pll_mult_range = {
>         .min = 55,
>         .max = 255,
> @@ -2167,6 +2477,26 @@ static struct clk_hw_onecell_data g12a_hw_onecell_data = {
>                 [CLKID_MALI]                    = &g12a_mali.hw,
>                 [CLKID_MPLL_5OM_DIV]            = &g12a_mpll_50m_div.hw,
>                 [CLKID_MPLL_5OM]                = &g12a_mpll_50m.hw,
> +               [CLKID_SYS_PLL_DIV16_EN]        = &g12a_sys_pll_div16_en.hw,
> +               [CLKID_SYS_PLL_DIV16]           = &g12a_sys_pll_div16.hw,
> +               [CLKID_CPU_CLK_DYN0_SEL]        = &g12a_cpu_clk_dyn0_sel.hw,
> +               [CLKID_CPU_CLK_DYN0_DIV]        = &g12a_cpu_clk_dyn0_div.hw,
> +               [CLKID_CPU_CLK_DYN0]            = &g12a_cpu_clk_dyn0.hw,
> +               [CLKID_CPU_CLK_DYN1_SEL]        = &g12a_cpu_clk_dyn1_sel.hw,
> +               [CLKID_CPU_CLK_DYN1_DIV]        = &g12a_cpu_clk_dyn1_div.hw,
> +               [CLKID_CPU_CLK_DYN1]            = &g12a_cpu_clk_dyn1.hw,
> +               [CLKID_CPU_CLK_DYN]             = &g12a_cpu_clk_dyn.hw,
> +               [CLKID_CPU_CLK]                 = &g12a_cpu_clk.hw,
> +               [CLKID_CPU_CLK_DIV16_EN]        = &g12a_cpu_clk_div16_en.hw,
> +               [CLKID_CPU_CLK_DIV16]           = &g12a_cpu_clk_div16.hw,
> +               [CLKID_CPU_CLK_APB_DIV]         = &g12a_cpu_clk_apb_div.hw,
> +               [CLKID_CPU_CLK_APB]             = &g12a_cpu_clk_apb.hw,
> +               [CLKID_CPU_CLK_ATB_DIV]         = &g12a_cpu_clk_atb_div.hw,
> +               [CLKID_CPU_CLK_ATB]             = &g12a_cpu_clk_atb.hw,
> +               [CLKID_CPU_CLK_AXI_DIV]         = &g12a_cpu_clk_axi_div.hw,
> +               [CLKID_CPU_CLK_AXI]             = &g12a_cpu_clk_axi.hw,
> +               [CLKID_CPU_CLK_TRACE_DIV]       = &g12a_cpu_clk_trace_div.hw,
> +               [CLKID_CPU_CLK_TRACE]           = &g12a_cpu_clk_trace.hw,
>                 [NR_CLKS]                       = NULL,
>         },
>         .num = NR_CLKS,
> @@ -2335,6 +2665,24 @@ static struct clk_regmap *const g12a_clk_regmaps[] = {
>         &g12a_mali_1,
>         &g12a_mali,
>         &g12a_mpll_50m,
> +       &g12a_sys_pll_div16_en,
> +       &g12a_cpu_clk_dyn0_sel,
> +       &g12a_cpu_clk_dyn0_div,
> +       &g12a_cpu_clk_dyn0,
> +       &g12a_cpu_clk_dyn1_sel,
> +       &g12a_cpu_clk_dyn1_div,
> +       &g12a_cpu_clk_dyn1,
> +       &g12a_cpu_clk_dyn,
> +       &g12a_cpu_clk,
> +       &g12a_cpu_clk_div16_en,
> +       &g12a_cpu_clk_apb_div,
> +       &g12a_cpu_clk_apb,
> +       &g12a_cpu_clk_atb_div,
> +       &g12a_cpu_clk_atb,
> +       &g12a_cpu_clk_axi_div,
> +       &g12a_cpu_clk_axi,
> +       &g12a_cpu_clk_trace_div,
> +       &g12a_cpu_clk_trace,
>  };
>
>  static const struct meson_eeclkc_data g12a_clkc_data = {
> diff --git a/drivers/clk/meson/g12a.h b/drivers/clk/meson/g12a.h
> index 4854750df902..0ba3bfe4d46d 100644
> --- a/drivers/clk/meson/g12a.h
> +++ b/drivers/clk/meson/g12a.h
> @@ -50,6 +50,7 @@
>  #define HHI_GCLK_MPEG2                 0x148
>  #define HHI_GCLK_OTHER                 0x150
>  #define HHI_GCLK_OTHER2                        0x154
> +#define HHI_SYS_CPU_CLK_CNTL1          0x15c
>  #define HHI_VID_CLK_DIV                        0x164
>  #define HHI_MPEG_CLK_CNTL              0x174
>  #define HHI_AUD_CLK_CNTL               0x178
> --
> 2.20.1
>
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
