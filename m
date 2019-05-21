Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D340C04E87
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 17:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE4D21479
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 17:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="VkVn705o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbfEURti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 13:49:38 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34861 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfEURth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 13:49:37 -0400
Received: by mail-oi1-f196.google.com with SMTP id a132so13515932oib.2;
        Tue, 21 May 2019 10:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yy3oYPWdeUlJWNni35uRANPHnH/KZjqT8e9g9rhiirM=;
        b=VkVn705o7OpQFHF9HbuH2HaFLohjO9EUw3hhXGLr+u/78N8WUwIm/rBJBHffrztZdq
         D+sXQCuVSRDH8pUldl/f0ZVTDRpQf16pGmtJHwNT7TcHo/IcHQbZVzCMnfrDHZOD/7py
         pwTIgpIwHGr5iEI+LGIGeDsKUUZWMGqmw4ffn/Ct7W7tblfJYpcA2CPdw8zDQAHuPehe
         jobcU4jXoITVfWwSOIgahxhHRlHyxWdop5/2bO9cWpV/KnacspWfewatTh/EJVMJUC7S
         p5oca3a4lldAjZSJRVKoC7GXU9HZDyZAqKR1GgO2TT08WomiUPOoVB0V9hgSxBL6PZUh
         4+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yy3oYPWdeUlJWNni35uRANPHnH/KZjqT8e9g9rhiirM=;
        b=NE0upqXc7ChF3cdUNp86mCszzYlQAMy32DSVCyR5JnhJbZRFr8q2rJ/65GAbW8pWjW
         LkfuAhCar7SkX1ivQ6IEVBqASnvdKE9nBqT85PqLG53jYXGPpzEx4SApPK5c6mas1FU6
         TDy6168yN00XHR+rZ3R7AnWvecwZACyGPU4TsAyNEkvdnNfKPRjUj/Q5Uz97hDyK5IFM
         +znUM9eJrsVZdbuEPGmTyB0uYw/tET4MUJLszHW7OhUx6wQOSzw0hzPkq5v9rCbZN5Zq
         e1shKqtR/8eU6/Nlc10aWGpQIS4vKD8Def50N3XmiosU8RCPk4cEUY3ophUAGtNkxlYp
         h4zw==
X-Gm-Message-State: APjAAAXySGI4zwVJX0hjtNpWHSnrmOuUmKfqPyzpciP0YBE5UORg0ujq
        enxMKlgs1351loBA5tlub0CfRc3CuR6qgO1v3pI=
X-Google-Smtp-Source: APXvYqwsTyLWRVtVJGzYLFw570+vGq26/BU5Rlh7Kr1b1kBkg18irFOUv0iHFMKBHXzmvtcX9F3LescfHwPspCkkezo=
X-Received: by 2002:aca:ed0a:: with SMTP id l10mr4510948oih.39.1558460976843;
 Tue, 21 May 2019 10:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190521150130.31684-1-narmstrong@baylibre.com> <20190521150130.31684-3-narmstrong@baylibre.com>
In-Reply-To: <20190521150130.31684-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 21 May 2019 19:49:25 +0200
Message-ID: <CAFBinCB+DD=hssuswV6M4i1Buv7bs0-6TfPTRVdUrhaprLMb0w@mail.gmail.com>
Subject: Re: [PATCH 2/3] clk: meson: g12a: Add support for G12B CPUB clocks
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Tue, May 21, 2019 at 5:02 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Update the Meson G12A Clock driver to support the Amlogic G12B SoC.
>
> G12B clock driver is very close, the main differences are :
> - the clock tree is duplicated for the both clusters, and the
>   SYS_PLL are swapped between the clusters
> - G12A has additional clocks like for CSI an other components
should this also be G12B?

[...]
> +static struct clk_regmap g12b_cpub_clk_apb_div = {
if you also think that it's worth it then please add a comment stating
that this is called "PCLK_mux" in the datasheet
same goes for the ATB and AXI clocks below as the naming in the driver
and datasheet differs

> +       .data = &(struct clk_regmap_div_data){
> +               .offset = HHI_SYS_CPUB_CLK_CNTL1,
> +               .shift = 3,
> +               .width = 3,
> +               .flags = CLK_DIVIDER_POWER_OF_TWO,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "cpub_clk_apb_div",
> +               .ops = &clk_regmap_divider_ro_ops,
> +               .parent_names = (const char *[]){ "cpub_clk" },
> +               .num_parents = 1,
> +       },
> +};
I'm assuming you checked that this is really a power of two divider,
on the Meson8/8b/8m2 SoCs this is a mux between div[2..8]
(the same goes for the ATB, AXI and trace div clocks below)

> +
> +static struct clk_regmap g12b_cpub_clk_apb = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = HHI_SYS_CPUB_CLK_CNTL1,
> +               .bit_idx = 16,
the public S922X datasheet calls this "PCLK_dis", does this mean you
need a flag here?
  .flags = CLK_GATE_SET_TO_DISABLE,

[...]
> +static struct clk_regmap g12b_cpub_clk_atb = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = HHI_SYS_CPUB_CLK_CNTL1,
> +               .bit_idx = 17,
the public S922X datasheet calls this "ATCLK_clk_dis", does this mean
you need a flag here?
  .flags = CLK_GATE_SET_TO_DISABLE,

[...]
> +static struct clk_regmap g12b_cpub_clk_axi = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = HHI_SYS_CPUB_CLK_CNTL1,
> +               .bit_idx = 18,
the public S922X datasheet calls this "ACLKM_clk_dis", does this mean
you need a flag here?
  .flags = CLK_GATE_SET_TO_DISABLE,

[...]
> +static struct clk_regmap g12b_cpub_clk_trace = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = HHI_SYS_CPUB_CLK_CNTL1,
> +               .bit_idx = 23,
the public S922X datasheet calls this "Trace_clk_dis", does this mean
you need a flag here?
  .flags = CLK_GATE_SET_TO_DISABLE,


Regards
Martin
