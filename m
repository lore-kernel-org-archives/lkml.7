Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97F2C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9738820684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VSVmBtDK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbfCFKoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:44:18 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43786 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729605AbfCFKoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:44:18 -0500
Received: by mail-qt1-f196.google.com with SMTP id y4so12244549qtc.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 02:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q0LFmcE09YMfyBgiDrvHfDxJYLJ9mk0yY5XqqNC/7Rk=;
        b=VSVmBtDK1/RF6bBKBKgH0aPbl1P1tcT+MWbwEWKFgbWHluboVvOJcLCPhLqQTtfJGE
         bauS4jza4hx1+CjAOCJHBX/R4TYDV3ckG6Dy8Jot4Jf7458MDMXVw6Ubk08iiDLiYYU8
         vSWPgNS9u7+AobwW4D2v3SA0iuzJvStdYvdc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q0LFmcE09YMfyBgiDrvHfDxJYLJ9mk0yY5XqqNC/7Rk=;
        b=VlOUXCtPTn84yz93mo6xPL9+SHSQnAk8fhitgz7gWbHp1jnfsSZ4Xkc3bpp+30VRK4
         JrICAJtaQAAHRbytngOuXIchBPxZvDgXjCZYrEwnf6bbf0E9HchUVPricLK/PygM9D/V
         OAowkv4qOR64su4U9CLdYVMJlgjeyg66PsPgPZmNrbW9gH6kW9FNlt1vLY9RFCVoEIFj
         OsJpD8JuEKdoZsdUV3+pUz9oSeoBvAXrHYIsnHpOglzxpF8Ys8IFlZUqketzDW3/aDHo
         pH0MV9M0Y6gSKbap40rUZQK3DelTwrS5u9HaM044RLo4wGkZiLVzLc/tQGnEgHYqXdB+
         UfIg==
X-Gm-Message-State: APjAAAUf2m69iWSqvWeK8SEBMb2uCYeDPDqHCBoz+5BdVs3i9k1mQETB
        Z6LXb5V0QnmPLrxk5Y7e7L/3efjRLSqR7pY9lcg5aw==
X-Google-Smtp-Source: APXvYqwBeIgILDTIhTtDcYNkts6U/FoOt+hGAovfAKvtak8t4vVXAYefl8a0rUbDT4Aef3SL8PxbIAVg7m6dGkFPIo0=
X-Received: by 2002:aed:253a:: with SMTP id v55mr5219606qtc.339.1551869056544;
 Wed, 06 Mar 2019 02:44:16 -0800 (PST)
MIME-Version: 1.0
References: <1551186660-16902-1-git-send-email-qii.wang@mediatek.com> <1551186660-16902-4-git-send-email-qii.wang@mediatek.com>
In-Reply-To: <1551186660-16902-4-git-send-email-qii.wang@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 6 Mar 2019 18:44:05 +0800
Message-ID: <CANMq1KArROL7F+KDWktg6vzZyXifZrKCO8khf_QGRoiLkfDegw@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] i2c: mediatek: Add arb clock in i2c driver
To:     Qii Wang <qii.wang@mediatek.com>
Cc:     wsa@the-dreams.de, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Leilk Liu <leilk.liu@mediatek.com>, xinping.qian@mediatek.com,
        liguo.zhang@mediatek.com, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 9:11 PM Qii Wang <qii.wang@mediatek.com> wrote:
>
> When two i2c controllers are internally connected to the same
> GPIO pins, the arb clock is needed to ensure that the waveforms
> do not interfere with each other.
>
> Signed-off-by: Qii Wang <qii.wang@mediatek.com>

Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

> ---
>  drivers/i2c/busses/i2c-mt65xx.c |   25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
> index 428ac99..14d6b38 100644
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
