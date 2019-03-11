Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405D4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D3020643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GTu/XCj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfCKI2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 04:28:39 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46587 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfCKI2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 04:28:39 -0400
Received: by mail-qt1-f193.google.com with SMTP id z25so4062939qti.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 01:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u/g68vjKtnqkumh5ZxD32tljZq9+3YSH18gcmZETy8Q=;
        b=GTu/XCj8NRFw3YGg/JjiV2JU8xxkHaL36MHcUvn2ZMrxqNX+GVwuUHuBZMIochQCa2
         ehG5+GWvW3WfFQDjSC4wjaFRL98/IrZnijO+zD2ofI8kspaDkkc/hM/qTITdjIjSfGxA
         wltw9Rfx5W9+zhx4fzSe6C65ctSiAz8nYbm0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u/g68vjKtnqkumh5ZxD32tljZq9+3YSH18gcmZETy8Q=;
        b=UKOHBA1jHUqLHoVj93MpsdmmUD8PINak3+A1ABBIMydOhND0q6OXip00TlkUgNUgnt
         qhrl+YyCRCp/E3HHBYbEo2mPlXSrJ3basDxyq9nfIMenmNXRDyew3wknFTeM9EpAIu4G
         VIfhTczKxW1Xbt4PEg+avkZza/Sa0TrMlIqhYm2tQ1CW6Ky2nW3OyjnPO9inFxeUfsNw
         5e8uDetBhrHTcCN7rHMDrPTp1VL2IIGGqbjvHHUhqwop1LFPsH/r5ZXp0YjoSlIRGAKg
         F3udnssGZsPe4UHRGiG4rMCRZRT/pDCHAUxi0iX1qA0cnhxEBjNYYMZ9BCubGdn9LQ3W
         C+3A==
X-Gm-Message-State: APjAAAX8mk+Ts1N5OvGTzzBrkI5QtJjp52vWI3h3tyjv8LAx7pxBa3mq
        K/lNj8L4KTvmEKvQcc7qOpz+GTGdlc9zKZGbv1icsA==
X-Google-Smtp-Source: APXvYqzJrHIyJVDSQMCZmpc0fCbdydIiT5Tk8MH7UTZD8+XGXab9diQOjH2o5mTS+3ryNMTgnR5XtB1FSrGNBUSLIN0=
X-Received: by 2002:ac8:2805:: with SMTP id 5mr24938833qtq.75.1552292917856;
 Mon, 11 Mar 2019 01:28:37 -0700 (PDT)
MIME-Version: 1.0
References: <1552282840-12778-1-git-send-email-qii.wang@mediatek.com> <1552282840-12778-4-git-send-email-qii.wang@mediatek.com>
In-Reply-To: <1552282840-12778-4-git-send-email-qii.wang@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 11 Mar 2019 16:28:26 +0800
Message-ID: <CANMq1KBKbGUgDGKp=vHq9g-46sN+4_CjPh-7Tc4NzfKk+ckpsQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] i2c: mediatek: Add arb clock in i2c driver
To:     Qii Wang <qii.wang@mediatek.com>
Cc:     wsa@the-dreams.de, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Leilk Liu <leilk.liu@mediatek.com>, xinping.qian@mediatek.com,
        liguo.zhang@mediatek.com, Rob Herring <robh@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 1:41 PM Qii Wang <qii.wang@mediatek.com> wrote:
>
> When two i2c controllers are internally connected to the same
> GPIO pins, the arb clock is needed to ensure that the waveforms
> do not interfere with each other. And we also need to enable
> the interrupt to find arb lost, old i2c controllers also have
> the bit.
>
> Signed-off-by: Qii Wang <qii.wang@mediatek.com>

I'll let Matthias comment too (I think the comment above is just
enough), but otherwise:

Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

> ---
>  drivers/i2c/busses/i2c-mt65xx.c |   25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
> index be36018..1a7235e 100644
> --- a/drivers/i2c/busses/i2c-mt65xx.c
> +++ b/drivers/i2c/busses/i2c-mt65xx.c
> @@ -35,6 +35,7 @@
>  #include <linux/slab.h>
>
>  #define I2C_RS_TRANSFER                        (1 << 4)
> +#define I2C_ARB_LOST                   (1 << 3)
>  #define I2C_HS_NACKERR                 (1 << 2)
>  #define I2C_ACKERR                     (1 << 1)
>  #define I2C_TRANSAC_COMP               (1 << 0)
> @@ -181,6 +182,7 @@ struct mtk_i2c {
>         struct clk *clk_main;           /* main clock for i2c bus */
>         struct clk *clk_dma;            /* DMA clock for i2c via DMA */
>         struct clk *clk_pmic;           /* PMIC clock for i2c from PMIC */
> +       struct clk *clk_arb;            /* Arbitrator clock for i2c */
>         bool have_pmic;                 /* can use i2c pins from PMIC */
>         bool use_push_pull;             /* IO config push-pull mode */
>
> @@ -299,8 +301,18 @@ static int mtk_i2c_clock_enable(struct mtk_i2c *i2c)
>                 if (ret)
>                         goto err_pmic;
>         }
> +
> +       if (i2c->clk_arb) {
> +               ret = clk_prepare_enable(i2c->clk_arb);
> +               if (ret)
> +                       goto err_arb;
> +       }
> +
>         return 0;
>
> +err_arb:
> +       if (i2c->have_pmic)
> +               clk_disable_unprepare(i2c->clk_pmic);
>  err_pmic:
>         clk_disable_unprepare(i2c->clk_main);
>  err_main:
> @@ -311,6 +323,9 @@ static int mtk_i2c_clock_enable(struct mtk_i2c *i2c)
>
>  static void mtk_i2c_clock_disable(struct mtk_i2c *i2c)
>  {
> +       if (i2c->clk_arb)
> +               clk_disable_unprepare(i2c->clk_arb);
> +
>         if (i2c->have_pmic)
>                 clk_disable_unprepare(i2c->clk_pmic);
>
> @@ -519,13 +534,13 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
>
>         /* Clear interrupt status */
>         mtk_i2c_writew(i2c, restart_flag | I2C_HS_NACKERR | I2C_ACKERR |
> -              I2C_TRANSAC_COMP, OFFSET_INTR_STAT);
> +                           I2C_ARB_LOST | I2C_TRANSAC_COMP, OFFSET_INTR_STAT);
>
>         mtk_i2c_writew(i2c, I2C_FIFO_ADDR_CLR, OFFSET_FIFO_ADDR_CLR);
>
>         /* Enable interrupt */
>         mtk_i2c_writew(i2c, restart_flag | I2C_HS_NACKERR | I2C_ACKERR |
> -              I2C_TRANSAC_COMP, OFFSET_INTR_MASK);
> +                           I2C_ARB_LOST | I2C_TRANSAC_COMP, OFFSET_INTR_MASK);
>
>         /* Set transfer and transaction len */
>         if (i2c->op == I2C_MASTER_WRRD) {
> @@ -659,7 +674,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
>
>         /* Clear interrupt mask */
>         mtk_i2c_writew(i2c, ~(restart_flag | I2C_HS_NACKERR | I2C_ACKERR |
> -              I2C_TRANSAC_COMP), OFFSET_INTR_MASK);
> +                           I2C_ARB_LOST | I2C_TRANSAC_COMP), OFFSET_INTR_MASK);
>
>         if (i2c->op == I2C_MASTER_WR) {
>                 dma_unmap_single(i2c->dev, wpaddr,
> @@ -884,6 +899,10 @@ static int mtk_i2c_probe(struct platform_device *pdev)
>                 return PTR_ERR(i2c->clk_dma);
>         }
>
> +       i2c->clk_arb = devm_clk_get(&pdev->dev, "arb");
> +       if (IS_ERR(i2c->clk_arb))
> +               i2c->clk_arb = NULL;
> +
>         clk = i2c->clk_main;
>         if (i2c->have_pmic) {
>                 i2c->clk_pmic = devm_clk_get(&pdev->dev, "pmic");
> --
> 1.7.9.5
>
