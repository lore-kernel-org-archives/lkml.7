Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D94C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E044206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="fydorapL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731052AbfJHMkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:40:02 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37535 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730317AbfJHMkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:40:02 -0400
Received: by mail-qt1-f195.google.com with SMTP id e15so10144476qtr.4;
        Tue, 08 Oct 2019 05:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0jJTLY2axsts6GZT3PA6D788BPaMX3GUaWV0Vzd1RXM=;
        b=fydorapLglYueHDm9H8p4AT688wrHVmN/5BLYTckwzJV/hAERlr6H3K4qoiKBtFGyo
         Qqsz931IkrwgOJzNNIHLJ4B3AVscmOsqqQrfmBYgtSP2tKBChMznGpsmEugFmEbcT5KX
         SkpxY/1+OmNS7lpVyQHn1fjYhxCoKBBR8JLvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0jJTLY2axsts6GZT3PA6D788BPaMX3GUaWV0Vzd1RXM=;
        b=KPMBd+qnb284ewzbUtuHS8Dhf5l2uVNcA7//wAaXNETb2nxO+RpcBMvv/NqRapgrJf
         YUWJRB1zJ1IfH6/4xN9UVCLEUwbYIxyn/PJQk+4Cv26GUCBjFd5KKN50nGR7R/VnJZKp
         emgwTGAP7XNES/4O8jgiBxnOn5+GeLXkUee3YOn4gB8+sh/AdrCZ/AJHtpiafa0VAJuC
         HNPlsyETYXWS96SmzVVLagznaAocD43rUlA114J4R2B1bKW8ZH0oyVwjaIUlc4lfWMG5
         vXe2Ca6fFHmON93YV4aqy4TgMhm3jQ4V4PKjorgFV9myvO0s/+AFm/L9E0wP30ZbinVs
         A+eQ==
X-Gm-Message-State: APjAAAUxHebDwhPhcm2Uk+f5LAtjdGjhVko0B2pphs6qm5HGO2dos7XO
        cVgMQYddFkIVBXrqG+PdH6KtXoBeDb+U3QXPRTU=
X-Google-Smtp-Source: APXvYqyIRMp1F0ik7vkJep0KVirm5HNPl0oLZUOXJNQc+afvhAryjXpJ1n7wrnxW5Q1z+DRlElhn/MKulVSC3i9vSX0=
X-Received: by 2002:ac8:2e94:: with SMTP id h20mr36037220qta.234.1570538400593;
 Tue, 08 Oct 2019 05:40:00 -0700 (PDT)
MIME-Version: 1.0
References: <20191008113553.13662-1-andrew@aj.id.au> <20191008113553.13662-3-andrew@aj.id.au>
In-Reply-To: <20191008113553.13662-3-andrew@aj.id.au>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 8 Oct 2019 12:39:49 +0000
Message-ID: <CACPK8XfSrKym55eQ91Lhf3wXtzCD5AH7P8t19jow2K-5JRb0ZA@mail.gmail.com>
Subject: Re: [PATCH 2/2] clk: ast2600: Add RMII RCLK gates for all four MACs
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2019 at 11:35, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> RCLK is a fixed 50MHz clock derived from HPLL/HCLK that is described by a
> single gate for each MAC.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

We could have mac12rclk and mac34rclk described in the device tree, as
was mentioned in previous reviews of the aspeed driver, but I think we
can defer that
rework until we rework the rest of the driver. Importantly, that won't
change the MAC bindings or the code that the drivers need to use.

Reviewed-by: Joel Stanley <joel@jms.id.au>


> ---
>  drivers/clk/clk-ast2600.c | 47 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 46 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/clk-ast2600.c b/drivers/clk/clk-ast2600.c
> index 1c1bb39bb04e..3d6fc781fee0 100644
> --- a/drivers/clk/clk-ast2600.c
> +++ b/drivers/clk/clk-ast2600.c
> @@ -15,7 +15,7 @@
>
>  #include "clk-aspeed.h"
>
> -#define ASPEED_G6_NUM_CLKS             67
> +#define ASPEED_G6_NUM_CLKS             71
>
>  #define ASPEED_G6_SILICON_REV          0x004
>
> @@ -40,6 +40,9 @@
>
>  #define ASPEED_G6_STRAP1               0x500
>
> +#define ASPEED_MAC12_CLK_DLY           0x340
> +#define ASPEED_MAC34_CLK_DLY           0x350
> +
>  /* Globally visible clocks */
>  static DEFINE_SPINLOCK(aspeed_g6_clk_lock);
>
> @@ -485,6 +488,11 @@ static int aspeed_g6_clk_probe(struct platform_device *pdev)
>                 return PTR_ERR(hw);
>         aspeed_g6_clk_data->hws[ASPEED_CLK_SDIO] = hw;
>
> +       /* MAC1/2 RMII 50MHz RCLK */
> +       hw = clk_hw_register_fixed_rate(dev, "mac12rclk", "hpll", 0, 50000000);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +
>         /* MAC1/2 AHB bus clock divider */
>         hw = clk_hw_register_divider_table(dev, "mac12", "hpll", 0,
>                         scu_g6_base + ASPEED_G6_CLK_SELECTION1, 16, 3, 0,
> @@ -494,6 +502,27 @@ static int aspeed_g6_clk_probe(struct platform_device *pdev)
>                 return PTR_ERR(hw);
>         aspeed_g6_clk_data->hws[ASPEED_CLK_MAC12] = hw;
>
> +       /* RMII1 50MHz (RCLK) output enable */
> +       hw = clk_hw_register_gate(dev, "mac1rclk-gate", "mac12rclk", 0,
> +                       scu_g6_base + ASPEED_MAC12_CLK_DLY, 29, 0,
> +                       &aspeed_g6_clk_lock);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +       aspeed_g6_clk_data->hws[ASPEED_CLK_GATE_MAC1RCLK] = hw;
> +
> +       /* RMII2 50MHz (RCLK) output enable */
> +       hw = clk_hw_register_gate(dev, "mac2rclk-gate", "mac12rclk", 0,
> +                       scu_g6_base + ASPEED_MAC12_CLK_DLY, 30, 0,
> +                       &aspeed_g6_clk_lock);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +       aspeed_g6_clk_data->hws[ASPEED_CLK_GATE_MAC2RCLK] = hw;
> +
> +       /* MAC1/2 RMII 50MHz RCLK */
> +       hw = clk_hw_register_fixed_rate(dev, "mac34rclk", "hclk", 0, 50000000);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +
>         /* MAC3/4 AHB bus clock divider */
>         hw = clk_hw_register_divider_table(dev, "mac34", "hpll", 0,
>                         scu_g6_base + 0x310, 24, 3, 0,
> @@ -503,6 +532,22 @@ static int aspeed_g6_clk_probe(struct platform_device *pdev)
>                 return PTR_ERR(hw);
>         aspeed_g6_clk_data->hws[ASPEED_CLK_MAC34] = hw;
>
> +       /* RMII3 50MHz (RCLK) output enable */
> +       hw = clk_hw_register_gate(dev, "mac3rclk-gate", "mac34rclk", 0,
> +                       scu_g6_base + ASPEED_MAC34_CLK_DLY, 29, 0,
> +                       &aspeed_g6_clk_lock);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +       aspeed_g6_clk_data->hws[ASPEED_CLK_GATE_MAC3RCLK] = hw;
> +
> +       /* RMII4 50MHz (RCLK) output enable */
> +       hw = clk_hw_register_gate(dev, "mac4rclk-gate", "mac34rclk", 0,
> +                       scu_g6_base + ASPEED_MAC34_CLK_DLY, 30, 0,
> +                       &aspeed_g6_clk_lock);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +       aspeed_g6_clk_data->hws[ASPEED_CLK_GATE_MAC4RCLK] = hw;
> +
>         /* LPC Host (LHCLK) clock divider */
>         hw = clk_hw_register_divider_table(dev, "lhclk", "hpll", 0,
>                         scu_g6_base + ASPEED_G6_CLK_SELECTION1, 20, 3, 0,
> --
> 2.20.1
>
