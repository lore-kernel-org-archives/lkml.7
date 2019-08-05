Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A23BC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 19:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30BA92054F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 19:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwHvedwU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730425AbfHETVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 15:21:23 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33529 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfHETVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 15:21:23 -0400
Received: by mail-wm1-f68.google.com with SMTP id h19so7319876wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 12:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d/QPU2oHFa2Ho1S1u38hXjGyl5aDEeD7TzQnoABqEf8=;
        b=SwHvedwU9g6nA48S5GDPPoRmtIuPB6HVKguEwN51Eqau0hMLvokHWFkjgDclLT4WJ9
         ZRvtdR1OMl3pDsxeHammDyWTZCV7+pl755zIO26Q6KHFjQ3e/gLCYtfTt/CDuEhl9B89
         GzO3i9QMkksXWwWTLmaWgoIJQJsnZvBoSZtu5hDq0oVnoafBUSkYMFVcgnaK6cy2pwPH
         TxzDBdKCB2U3WYsv7E/YVck4skGcHSx1IjNQMnPlRP5Ac+ea13jFQc8xMsPGn0rBCWik
         Q7M645Zr53ABB8n3lL7+F70QLPeg4uOsu4tRI414AG4hSgTAeO17Zw6WbUebtwNLYWJn
         qKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d/QPU2oHFa2Ho1S1u38hXjGyl5aDEeD7TzQnoABqEf8=;
        b=ETq6yfehJzCqlLbJIv2zlNjwgI47XJNKhcSCK0nyhTAX/FJdtBsj9ysMyRAIA6e66h
         w9++hlzndEvNnpD34Over5v/A8P1aDw4vKpf0LKOH+RN7xbMswdLHoZeP/GuIeXcJUKC
         h6wcEhiptXmo3wS7B2dY9iBS49tSiIkIxbmbUZA0UudR18C8MESOIxeps/xaZM4oqcKr
         +EHCTe/pKDEhmBP8A/H6dKzLCWJDk1X4NYGjtKPw3GSNQtEFmPCKmCmVTsHiRj2A2kyx
         9OCGtQ89SaWyX6lTemkDlZ5m8xQwDiOm2v3XUvqyiBl7RjpVUcYjYnIbeHL7vF7TSefw
         oj8w==
X-Gm-Message-State: APjAAAWImVsnpL2+D84Xtlfpch07O7SHRn6sCOPTMshwN/tx5xCgxAZT
        xk7zYwkCPF1qaQhZHlXkIvrwM0DYHogD0NthkVg5DA==
X-Google-Smtp-Source: APXvYqwJAi8fBMrA9JxX1gG/spoyp/2JsRd6mnSAibX5oq4oYYIfQZGjDkqlnIZdIIGU+PrKfA9ja1590/VFMJ38aa0=
X-Received: by 2002:a1c:96c7:: with SMTP id y190mr18272908wmd.87.1565032881088;
 Mon, 05 Aug 2019 12:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <1564980742-19124-1-git-send-email-hongxing.zhu@nxp.com> <1564980742-19124-5-git-send-email-hongxing.zhu@nxp.com>
In-Reply-To: <1564980742-19124-5-git-send-email-hongxing.zhu@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Mon, 5 Aug 2019 22:21:09 +0300
Message-ID: <CAEnQRZBoLw5pfZ10STGMRfmR7=6hFjYNFOmXiMAnbM+-8Q4uLg@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 4/4] mailbox: imx: add support for imx v1 mu
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     jassisinghbrar@gmail.com, Oleksij Rempel <o.rempel@pengutronix.de>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 5, 2019 at 8:16 AM Richard Zhu <hongxing.zhu@nxp.com> wrote:
>
> There is a version 1.0 MU on i.MX7ULP platform.
> One new version ID register is added, and it's offset is 0.
> TRn registers are defined at the offset 0x20 ~ 0x2C.
> RRn registers are defined at the offset 0x40 ~ 0x4C.
> SR/CR registers are defined at 0x60/0x64.
> Extend this driver to support it.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Suggested-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

Very clean solution. Thanks Richard!

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

> ---
>  drivers/mailbox/imx-mailbox.c | 55 ++++++++++++++++++++++++++++++-------------
>  1 file changed, 38 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
> index afe625e..2cdcdc5 100644
> --- a/drivers/mailbox/imx-mailbox.c
> +++ b/drivers/mailbox/imx-mailbox.c
> @@ -12,19 +12,11 @@
>  #include <linux/of_device.h>
>  #include <linux/slab.h>
>
> -/* Transmit Register */
> -#define IMX_MU_xTRn(x)         (0x00 + 4 * (x))
> -/* Receive Register */
> -#define IMX_MU_xRRn(x)         (0x10 + 4 * (x))
> -/* Status Register */
> -#define IMX_MU_xSR             0x20
>  #define IMX_MU_xSR_GIPn(x)     BIT(28 + (3 - (x)))
>  #define IMX_MU_xSR_RFn(x)      BIT(24 + (3 - (x)))
>  #define IMX_MU_xSR_TEn(x)      BIT(20 + (3 - (x)))
>  #define IMX_MU_xSR_BRDIP       BIT(9)
>
> -/* Control Register */
> -#define IMX_MU_xCR             0x24
>  /* General Purpose Interrupt Enable */
>  #define IMX_MU_xCR_GIEn(x)     BIT(28 + (3 - (x)))
>  /* Receive Interrupt Enable */
> @@ -44,6 +36,13 @@ enum imx_mu_chan_type {
>         IMX_MU_TYPE_RXDB,       /* Rx doorbell */
>  };
>
> +struct imx_mu_dcfg {
> +       u32     xTR[4];         /* Transmit Registers */
> +       u32     xRR[4];         /* Receive Registers */
> +       u32     xSR;            /* Status Register */
> +       u32     xCR;            /* Control Register */
> +};
> +
>  struct imx_mu_con_priv {
>         unsigned int            idx;
>         char                    irq_desc[IMX_MU_CHAN_NAME_SIZE];
> @@ -61,12 +60,27 @@ struct imx_mu_priv {
>         struct mbox_chan        mbox_chans[IMX_MU_CHANS];
>
>         struct imx_mu_con_priv  con_priv[IMX_MU_CHANS];
> +       const struct imx_mu_dcfg        *dcfg;
>         struct clk              *clk;
>         int                     irq;
>
>         bool                    side_b;
>  };
>
> +static const struct imx_mu_dcfg imx_mu_cfg_imx6sx = {
> +       .xTR    = {0x0, 0x4, 0x8, 0xc},
> +       .xRR    = {0x10, 0x14, 0x18, 0x1c},
> +       .xSR    = 0x20,
> +       .xCR    = 0x24,
> +};
> +
> +static const struct imx_mu_dcfg imx_mu_cfg_imx7ulp = {
> +       .xTR    = {0x20, 0x24, 0x28, 0x2c},
> +       .xRR    = {0x40, 0x44, 0x48, 0x4c},
> +       .xSR    = 0x60,
> +       .xCR    = 0x64,
> +};
> +
>  static struct imx_mu_priv *to_imx_mu_priv(struct mbox_controller *mbox)
>  {
>         return container_of(mbox, struct imx_mu_priv, mbox);
> @@ -88,10 +102,10 @@ static u32 imx_mu_xcr_rmw(struct imx_mu_priv *priv, u32 set, u32 clr)
>         u32 val;
>
>         spin_lock_irqsave(&priv->xcr_lock, flags);
> -       val = imx_mu_read(priv, IMX_MU_xCR);
> +       val = imx_mu_read(priv, priv->dcfg->xCR);
>         val &= ~clr;
>         val |= set;
> -       imx_mu_write(priv, val, IMX_MU_xCR);
> +       imx_mu_write(priv, val, priv->dcfg->xCR);
>         spin_unlock_irqrestore(&priv->xcr_lock, flags);
>
>         return val;
> @@ -111,8 +125,8 @@ static irqreturn_t imx_mu_isr(int irq, void *p)
>         struct imx_mu_con_priv *cp = chan->con_priv;
>         u32 val, ctrl, dat;
>
> -       ctrl = imx_mu_read(priv, IMX_MU_xCR);
> -       val = imx_mu_read(priv, IMX_MU_xSR);
> +       ctrl = imx_mu_read(priv, priv->dcfg->xCR);
> +       val = imx_mu_read(priv, priv->dcfg->xSR);
>
>         switch (cp->type) {
>         case IMX_MU_TYPE_TX:
> @@ -138,10 +152,10 @@ static irqreturn_t imx_mu_isr(int irq, void *p)
>                 imx_mu_xcr_rmw(priv, 0, IMX_MU_xCR_TIEn(cp->idx));
>                 mbox_chan_txdone(chan, 0);
>         } else if (val == IMX_MU_xSR_RFn(cp->idx)) {
> -               dat = imx_mu_read(priv, IMX_MU_xRRn(cp->idx));
> +               dat = imx_mu_read(priv, priv->dcfg->xRR[cp->idx]);
>                 mbox_chan_received_data(chan, (void *)&dat);
>         } else if (val == IMX_MU_xSR_GIPn(cp->idx)) {
> -               imx_mu_write(priv, IMX_MU_xSR_GIPn(cp->idx), IMX_MU_xSR);
> +               imx_mu_write(priv, IMX_MU_xSR_GIPn(cp->idx), priv->dcfg->xSR);
>                 mbox_chan_received_data(chan, NULL);
>         } else {
>                 dev_warn_ratelimited(priv->dev, "Not handled interrupt\n");
> @@ -159,7 +173,7 @@ static int imx_mu_send_data(struct mbox_chan *chan, void *data)
>
>         switch (cp->type) {
>         case IMX_MU_TYPE_TX:
> -               imx_mu_write(priv, *arg, IMX_MU_xTRn(cp->idx));
> +               imx_mu_write(priv, *arg, priv->dcfg->xTR[cp->idx]);
>                 imx_mu_xcr_rmw(priv, IMX_MU_xCR_TIEn(cp->idx), 0);
>                 break;
>         case IMX_MU_TYPE_TXDB:
> @@ -270,7 +284,7 @@ static void imx_mu_init_generic(struct imx_mu_priv *priv)
>                 return;
>
>         /* Set default MU configuration */
> -       imx_mu_write(priv, 0, IMX_MU_xCR);
> +       imx_mu_write(priv, 0, priv->dcfg->xCR);
>  }
>
>  static int imx_mu_probe(struct platform_device *pdev)
> @@ -278,6 +292,7 @@ static int imx_mu_probe(struct platform_device *pdev)
>         struct device *dev = &pdev->dev;
>         struct device_node *np = dev->of_node;
>         struct imx_mu_priv *priv;
> +       const struct imx_mu_dcfg *dcfg;
>         unsigned int i;
>         int ret;
>
> @@ -295,6 +310,11 @@ static int imx_mu_probe(struct platform_device *pdev)
>         if (priv->irq < 0)
>                 return priv->irq;
>
> +       dcfg = of_device_get_match_data(dev);
> +       if (!dcfg)
> +               return -EINVAL;
> +       priv->dcfg = dcfg;
> +
>         priv->clk = devm_clk_get(dev, NULL);
>         if (IS_ERR(priv->clk)) {
>                 if (PTR_ERR(priv->clk) != -ENOENT)
> @@ -348,7 +368,8 @@ static int imx_mu_remove(struct platform_device *pdev)
>  }
>
>  static const struct of_device_id imx_mu_dt_ids[] = {
> -       { .compatible = "fsl,imx6sx-mu" },
> +       { .compatible = "fsl,imx7ulp-mu", .data = &imx_mu_cfg_imx7ulp },
> +       { .compatible = "fsl,imx6sx-mu", .data = &imx_mu_cfg_imx6sx },
>         { },
>  };
>  MODULE_DEVICE_TABLE(of, imx_mu_dt_ids);
> --
> 2.7.4
>
