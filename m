Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503ACC10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 02:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F519217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 02:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="N9fRWUze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfDKCua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 22:50:30 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46095 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbfDKCu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 22:50:29 -0400
Received: by mail-qt1-f193.google.com with SMTP id z17so5383602qts.13;
        Wed, 10 Apr 2019 19:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vKhvsPVgCcxXIxsz01bKVtesiZyiRRHxCxEUnsV1cHk=;
        b=N9fRWUzeQnronKSXsMpW6DAtGqHaiX2tI8SMEj8v4Oa5TrUio17nRoARfWH6J+u6QB
         JJNkbCR8FGr2T2P+wFXBYQfsg1rrS/DhvN3JHN/vqjvYBxoIr11GZrih+opFUfCXId+l
         QrnRrg9JbUsOz0vaEA2JDtYacndJKFt+G4apw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vKhvsPVgCcxXIxsz01bKVtesiZyiRRHxCxEUnsV1cHk=;
        b=cVJ6MJW3cxO2cv5Q/W7Go8IO/NpFW6idZUmfxvppKRAHxFkwOHSMlXvicl+hUGJM79
         b9+zpBszIKUgxztg5eHFmZ1GVw+M3uKM+ck0+1ZJPZA6Yf4Q1ZeYsQPcS4QDuklZTaJW
         daWkyiylxKAUkYdWPQttnPEbBYhwugZQYNHl7Nz7k6uqqMRQX7ogabVoXVvVcaE3wmMD
         OjrP8qszQr3De5NTGMcMjXfTzGQbutnA27DJoqAPpwwIAe5IxhXqcyvtHKKiJ9KnZwTD
         heFWs5hIO9K01RNXAGzsCMnZY7yrO/BwctQxiDCp4E8diH4icASoeM3j+O/PbM59ZTC7
         T8Kw==
X-Gm-Message-State: APjAAAXWC+2AHXhGPhoyWRGleM5hlsPhdypd2XamjvNGdPv8mmud8bju
        4MO7/Twb6XPWgo2qdevgIF+oGGsg+w0+WObsJ5Q=
X-Google-Smtp-Source: APXvYqxkYHlnVcJ4WEGBITOVq0MvsVZQFRImR64C1x1DeGLqYTpwYdQpkycvlry2cHPA6AhzN/MTc6tpPBfsO8Vnjqw=
X-Received: by 2002:ac8:2f85:: with SMTP id l5mr40161814qta.269.1554951028130;
 Wed, 10 Apr 2019 19:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <1554229504-5661-1-git-send-email-eajames@linux.ibm.com> <1554229504-5661-5-git-send-email-eajames@linux.ibm.com>
In-Reply-To: <1554229504-5661-5-git-send-email-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 11 Apr 2019 02:50:16 +0000
Message-ID: <CACPK8Xc5vA6M06QgXMAm9angZMdobxNOqFMNwzq30_GQNaBT9A@mail.gmail.com>
Subject: Re: [PATCH 4/5] clk: Aspeed: Setup video engine clocking
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-media@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-aspeed@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, mchehab@kernel.org,
        linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Apr 2019 at 18:25, Eddie James <eajames@linux.ibm.com> wrote:
>
> Add eclk mux and clock divider table. Also change the video engine reset
> to the correct clock; it was previously on the video capture but needs
> to be on the video engine clock.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

Stephen, Eddie and I have worked together on this change and I am
happy with it now.

Cheers,

Joel

> ---
>  drivers/clk/clk-aspeed.c | 42 +++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 39 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
> index 5961367..42b4df6 100644
> --- a/drivers/clk/clk-aspeed.c
> +++ b/drivers/clk/clk-aspeed.c
> @@ -87,10 +87,10 @@ struct aspeed_clk_gate {
>  /* TODO: ask Aspeed about the actual parent data */
>  static const struct aspeed_gate_data aspeed_gates[] = {
>         /*                               clk rst   name                 parent  flags */
> -       [ASPEED_CLK_GATE_ECLK] =        {  0, -1, "eclk-gate",          "eclk", 0 }, /* Video Engine */
> +       [ASPEED_CLK_GATE_ECLK] =        {  0,  6, "eclk-gate",          "eclk", 0 }, /* Video Engine */
>         [ASPEED_CLK_GATE_GCLK] =        {  1,  7, "gclk-gate",          NULL,   0 }, /* 2D engine */
>         [ASPEED_CLK_GATE_MCLK] =        {  2, -1, "mclk-gate",          "mpll", CLK_IS_CRITICAL }, /* SDRAM */
> -       [ASPEED_CLK_GATE_VCLK] =        {  3,  6, "vclk-gate",          NULL,   0 }, /* Video Capture */
> +       [ASPEED_CLK_GATE_VCLK] =        {  3, -1, "vclk-gate",          NULL,   0 }, /* Video Capture */
>         [ASPEED_CLK_GATE_BCLK] =        {  4,  8, "bclk-gate",          "bclk", CLK_IS_CRITICAL }, /* PCIe/PCI */
>         [ASPEED_CLK_GATE_DCLK] =        {  5, -1, "dclk-gate",          NULL,   CLK_IS_CRITICAL }, /* DAC */
>         [ASPEED_CLK_GATE_REFCLK] =      {  6, -1, "refclk-gate",        "clkin", CLK_IS_CRITICAL },
> @@ -113,6 +113,24 @@ struct aspeed_clk_gate {
>         [ASPEED_CLK_GATE_LHCCLK] =      { 28, -1, "lhclk-gate",         "lhclk", 0 }, /* LPC master/LPC+ */
>  };
>
> +static const char * const eclk_parent_names[] = {
> +       "mpll",
> +       "hpll",
> +       "dpll",
> +};
> +
> +static const struct clk_div_table ast2500_eclk_div_table[] = {
> +       { 0x0, 2 },
> +       { 0x1, 2 },
> +       { 0x2, 3 },
> +       { 0x3, 4 },
> +       { 0x4, 5 },
> +       { 0x5, 6 },
> +       { 0x6, 7 },
> +       { 0x7, 8 },
> +       { 0 }
> +};
> +
>  static const struct clk_div_table ast2500_mac_div_table[] = {
>         { 0x0, 4 }, /* Yep, really. Aspeed confirmed this is correct */
>         { 0x1, 4 },
> @@ -192,18 +210,21 @@ static struct clk_hw *aspeed_ast2500_calc_pll(const char *name, u32 val)
>
>  struct aspeed_clk_soc_data {
>         const struct clk_div_table *div_table;
> +       const struct clk_div_table *eclk_div_table;
>         const struct clk_div_table *mac_div_table;
>         struct clk_hw *(*calc_pll)(const char *name, u32 val);
>  };
>
>  static const struct aspeed_clk_soc_data ast2500_data = {
>         .div_table = ast2500_div_table,
> +       .eclk_div_table = ast2500_eclk_div_table,
>         .mac_div_table = ast2500_mac_div_table,
>         .calc_pll = aspeed_ast2500_calc_pll,
>  };
>
>  static const struct aspeed_clk_soc_data ast2400_data = {
>         .div_table = ast2400_div_table,
> +       .eclk_div_table = ast2400_div_table,
>         .mac_div_table = ast2400_div_table,
>         .calc_pll = aspeed_ast2400_calc_pll,
>  };
> @@ -522,6 +543,22 @@ static int aspeed_clk_probe(struct platform_device *pdev)
>                 return PTR_ERR(hw);
>         aspeed_clk_data->hws[ASPEED_CLK_24M] = hw;
>
> +       hw = clk_hw_register_mux(dev, "eclk-mux", eclk_parent_names,
> +                                ARRAY_SIZE(eclk_parent_names), 0,
> +                                scu_base + ASPEED_CLK_SELECTION, 2, 0x3, 0,
> +                                &aspeed_clk_lock);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +       aspeed_clk_data->hws[ASPEED_CLK_ECLK_MUX] = hw;
> +
> +       hw = clk_hw_register_divider_table(dev, "eclk", "eclk-mux", 0,
> +                                          scu_base + ASPEED_CLK_SELECTION, 28,
> +                                          3, 0, soc_data->eclk_div_table,
> +                                          &aspeed_clk_lock);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +       aspeed_clk_data->hws[ASPEED_CLK_ECLK] = hw;
> +
>         /*
>          * TODO: There are a number of clocks that not included in this driver
>          * as more information is required:
> @@ -531,7 +568,6 @@ static int aspeed_clk_probe(struct platform_device *pdev)
>          *   RGMII
>          *   RMII
>          *   UART[1..5] clock source mux
> -        *   Video Engine (ECLK) mux and clock divider
>          */
>
>         for (i = 0; i < ARRAY_SIZE(aspeed_gates); i++) {
> --
> 1.8.3.1
>
