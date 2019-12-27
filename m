Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B735DC2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C2220882
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="iUba+NWN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfL0RXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 12:23:05 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34563 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfL0RXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 12:23:05 -0500
Received: by mail-ed1-f65.google.com with SMTP id l8so25866051edw.1;
        Fri, 27 Dec 2019 09:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0UU+ysXx+Shc0uhfL0eYU+6BwpIeAsm7S9P/UHU0eAg=;
        b=iUba+NWNA3cOXpD5+r04DSS11HD3AciHWRXYHS97zSESLqL4y0CXv4NzzuOaX99bzt
         ijCXSOhYV7ucxVIFQWm5EEk/PHpCHm262LIdFhKd3Rj0m8MgP13uJJMMPxutIF12TVyt
         NeWqHxRT6MtNP4fmJIauTMBXbxKxEjttj5+94a23FLWXoIAoodB+HyGqa6S8lOrIe75v
         i60FDLNZzZLYOIW5tvr+PcsslPbLLmKqP+wm0iZRMRi6GIy9xPTVDyI4MDcgS98s5Z5k
         0s44aKJRenjj9Cfz02DFsvOurf9rWc/4pyIoPOH42pX6++sh94sq7PqyE2MsZ3kWiC4a
         Fk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0UU+ysXx+Shc0uhfL0eYU+6BwpIeAsm7S9P/UHU0eAg=;
        b=b6ZUDnFx4I6w5s/M132PXjmdrSw61Kw9qdjNctyk2SWWPCNscHWEDNPacJ+AKG9T4B
         DQmEtkVlT7q1m1jhJSekGolrrTi1pX1zEgxlQcY7AuuguLjoOM8JVS9xRgUuMw9GMt2a
         VrJPRktVprQHYLC2OBDa/MozsZXNPFAZ5QjBXXuUO0+W2SV6nx0s1tOI8FkYNvYrRlso
         NzEevGfslypRMF6cla+4Vy+SDjWc9DTyTARVIM/SzjKZmMYB4UCBdVTtaYlmRglTrMux
         QSHQoyq2NXzP3YTwoYFrBIAhXPeyjVabsFqWMP81pYy6y5fVCK/k80kXdMtWtX7PsKGp
         LYfg==
X-Gm-Message-State: APjAAAX08T4qCdm8K8vbLlDFp6+zRYYdeUG7rKB6BSnxQxfOcwOW8+Ol
        QWzl2EaBe6KdWnRyNXbQYh+q471KjvNhUooZs2ZEdDFo
X-Google-Smtp-Source: APXvYqygztpCwMZ2tOw2bt5blxVcse049EWJn1V8ypi9uRoEfMAWYxJV7H8W3FniudLtvI6csg6ZP2n5//ATD5ueUVI=
X-Received: by 2002:a50:bae1:: with SMTP id x88mr39175305ede.10.1577467383228;
 Fri, 27 Dec 2019 09:23:03 -0800 (PST)
MIME-Version: 1.0
References: <20191227094606.143637-1-jian.hu@amlogic.com> <20191227094606.143637-6-jian.hu@amlogic.com>
In-Reply-To: <20191227094606.143637-6-jian.hu@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 27 Dec 2019 18:22:52 +0100
Message-ID: <CAFBinCB_0+k6rGxChpB77rPUrb-0mzxt_nQWXbiztCJnJq8XnQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] clk: meson: a1: add support for Amlogic A1
 Peripheral clock driver
To:     Jian Hu <jian.hu@amlogic.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Chandle Zou <chandle.zou@amlogic.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi Jian,

my comments and questions below
please keep in mind that I don't have access to the A1 datasheets, so
I may ask stupid questions :)

On Fri, Dec 27, 2019 at 10:47 AM Jian Hu <jian.hu@amlogic.com> wrote:
[...]
> +/* PLLs clock in gates, its parent is xtal */
yes. doesn't the code below describe exactly this (what is so special
about it that we need an extra comment)?

[...]
> +static const struct clk_parent_data sys_clk_parents[] = {
> +       { .fw_name = "xtal" },
> +       { .fw_name = "fclk_div2"},
> +       { .fw_name = "fclk_div3"},
> +       { .fw_name = "fclk_div5"},
the last three values are missing a space before "}"

[...]
> +       .hw.init = &(struct clk_init_data){
> +               .name = "sys_clk",
> +               .ops = &clk_regmap_mux_ro_ops,
> +               .parent_hws = (const struct clk_hw *[]) {
> +                       &a1_sys_a.hw, &a1_sys_b.hw,
> +               },
> +               .num_parents = 2,
> +               /*
> +                * This clock is used by APB bus which setted in Romcode
like in the PLL clkc patch:
- setted -> "is set"
- Romcode == boot ROM ?

[...]
> +static struct clk_regmap a1_rtc_32k_sel = {
> +       .data = &(struct clk_regmap_mux_data) {
> +               .offset = RTC_CTRL,
> +               .mask = 0x3,
> +               .shift = 0,
> +               .flags = CLK_MUX_ROUND_CLOSEST,
CLK_MUX_ROUND_CLOSEST means the common clock framework will also
accept rates greater than 32kHz.
is that fine for this case?

[...]
> +/*
> + * the second parent is sys_pll_div16, it will complete in the CPU clock,
I was confused by this but I assume you mean the parent with index 2?

> + * the forth parent is the clock measurement source, it relies on
> + * the clock measurement register configuration.
...and parent with index 4 here

[...]
> +static struct clk_regmap a1_pwm_a = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = PWM_CLK_AB_CTRL,
> +               .bit_idx = 8,
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "pwm_a",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_hws = (const struct clk_hw *[]) {
> +                       &a1_pwm_a_div.hw
> +               },
> +               .num_parents = 1,
> +               /*
> +                * The CPU working voltage is controlled by pwm_a
> +                * in BL2 firmware. add the CLK_IS_CRITICAL flag
> +                * to avoid changing at runtime.
on G12A and G12B Linux has to manage the CPU voltage regulator
can you confirm that for the A1 SoC this is really done by BL2? (I'm
wondering since A1 is newer than G12)

> +/*
> + * spicc clk
> + *    div2   |\         |\       _____
> + *  ---------| |---DIV--| |     |     |    spicc out
> + *  ---------| |        | |-----|GATE |---------
> + *     ..... |/         | /     |_____|
> + *  --------------------|/
> + *                 24M
does that "div2" stand for fclk_div2?

[...]
> +static const struct meson_eeclkc_data a1_periphs_data = {
> +               .regmap_clks = a1_periphs_regmaps,
> +               .regmap_clk_num = ARRAY_SIZE(a1_periphs_regmaps),
> +               .hw_onecell_data = &a1_periphs_hw_onecell_data,
> +};
same comment as for the PLL clkc: please drop this and use the
variables directly inside _probe to get rid of the struct
meson_eeclkc_data (so I won't be confused about "EE clocks" on A1,
while according to your description there's no "EE" domain)


Martin
