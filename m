Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0ACC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 07:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D8F6205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 07:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKrLehZ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbfJHHZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 03:25:57 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41106 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729740AbfJHHZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 03:25:57 -0400
Received: by mail-wr1-f68.google.com with SMTP id q9so18056765wrm.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 00:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4kal6lzen4CHLw+JnccRumaFnnhCb00ynZNLABryreg=;
        b=NKrLehZ/TKt+1PDXDjQmfWItHIAFJHrd9cn7LjgSUerCYGJJJXU3ia1ruT44v1swZP
         4HDluTnag7GekQh2DrgH4MAU0FK3/+3oe6OSoHjoQU1k9iBbOtDJKO2KKCrKc1v8F8zL
         nXE2SniQOcMm+hoZyfAszTnzS8VnHI8Vj6OrTPMbJMvnUaqbbdg/CdCjp9O0QcHpGU4P
         mJqrhBxWc3JD/DnDoNFI+haZ/iyG9jWTDi7ZTGKvHccmrBpQrYiseuxhucJTOS7uJq+8
         rb3IimCY9i8o1EkJxKQr+L92XDcr4eae8BxNCkrMtY06VF4mnB45BL6UV6K4xl0K4h9R
         l2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4kal6lzen4CHLw+JnccRumaFnnhCb00ynZNLABryreg=;
        b=pJZzTTI7jgQ9awrGXXgJCj1GuoC+s1nb0LlPCkuSPtx8Q3Kmzi4bEWzUpK2xwpIq7C
         646RfItaNsbQgMbiYKOwS2U/JHsizzZHp7osNUiTBY34iyQPBU96nJa1uPZ7IIvnT8SX
         gL9H7hx+XsouFjV6ezQ70/cZ/8ltKatjf5CSB2um6AJgRTxgZ0wxm/DSchqmltyRlkBT
         0C2Cse4SrKW/TtHG8yOsQDafSeyIft2QPfLZYzZ3mKTYHa5EjPPqj1eBJtrlX6mfSY2N
         /7qaaU5Z7AnXqhlaG4ctYLv2kYpyADCRbZKV7EUyJKL1uOarN77SeB/7U48wDGjpjH6W
         aI5w==
X-Gm-Message-State: APjAAAXlRi91rFjzpBqUiEQEVv/pQ/WViYoWMIkruL1AwF7RiGvosmeb
        r9Qg/FktjyYsNRbjviIzdzhVfHT1Y91VfCvgtE8=
X-Google-Smtp-Source: APXvYqxTIv3FYsobIxPqWB6cREu1LXDS7Puo8zQve+mUHnO0mJm3+k2OON2tEHH3/JBbLM8gt+FzZbcr+b9H3HnBwlU=
X-Received: by 2002:a5d:630d:: with SMTP id i13mr4533668wru.230.1570519553425;
 Tue, 08 Oct 2019 00:25:53 -0700 (PDT)
MIME-Version: 1.0
References: <1564980742-19124-1-git-send-email-hongxing.zhu@nxp.com>
 <1564980742-19124-5-git-send-email-hongxing.zhu@nxp.com> <CAEnQRZBoLw5pfZ10STGMRfmR7=6hFjYNFOmXiMAnbM+-8Q4uLg@mail.gmail.com>
In-Reply-To: <CAEnQRZBoLw5pfZ10STGMRfmR7=6hFjYNFOmXiMAnbM+-8Q4uLg@mail.gmail.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 8 Oct 2019 10:25:41 +0300
Message-ID: <CAEnQRZCkoA-q=C6nU0L_i33W8iTPY2RC4Cvb-aWuExA8VEqM4g@mail.gmail.com>
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

Hi Richard,

Can you please rebase and resend this patch series?

On Mon, Aug 5, 2019 at 10:21 PM Daniel Baluta <daniel.baluta@gmail.com> wrote:
>
> On Mon, Aug 5, 2019 at 8:16 AM Richard Zhu <hongxing.zhu@nxp.com> wrote:
> >
> > There is a version 1.0 MU on i.MX7ULP platform.
> > One new version ID register is added, and it's offset is 0.
> > TRn registers are defined at the offset 0x20 ~ 0x2C.
> > RRn registers are defined at the offset 0x40 ~ 0x4C.
> > SR/CR registers are defined at 0x60/0x64.
> > Extend this driver to support it.
> >
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > Suggested-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> > Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
>
> Very clean solution. Thanks Richard!
>
> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
>
> > ---
> >  drivers/mailbox/imx-mailbox.c | 55 ++++++++++++++++++++++++++++++-------------
> >  1 file changed, 38 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
> > index afe625e..2cdcdc5 100644
> > --- a/drivers/mailbox/imx-mailbox.c
> > +++ b/drivers/mailbox/imx-mailbox.c
> > @@ -12,19 +12,11 @@
> >  #include <linux/of_device.h>
> >  #include <linux/slab.h>
> >
> > -/* Transmit Register */
> > -#define IMX_MU_xTRn(x)         (0x00 + 4 * (x))
> > -/* Receive Register */
> > -#define IMX_MU_xRRn(x)         (0x10 + 4 * (x))
> > -/* Status Register */
> > -#define IMX_MU_xSR             0x20
> >  #define IMX_MU_xSR_GIPn(x)     BIT(28 + (3 - (x)))
> >  #define IMX_MU_xSR_RFn(x)      BIT(24 + (3 - (x)))
> >  #define IMX_MU_xSR_TEn(x)      BIT(20 + (3 - (x)))
> >  #define IMX_MU_xSR_BRDIP       BIT(9)
> >
> > -/* Control Register */
> > -#define IMX_MU_xCR             0x24
> >  /* General Purpose Interrupt Enable */
> >  #define IMX_MU_xCR_GIEn(x)     BIT(28 + (3 - (x)))
> >  /* Receive Interrupt Enable */
> > @@ -44,6 +36,13 @@ enum imx_mu_chan_type {
> >         IMX_MU_TYPE_RXDB,       /* Rx doorbell */
> >  };
> >
> > +struct imx_mu_dcfg {
> > +       u32     xTR[4];         /* Transmit Registers */
> > +       u32     xRR[4];         /* Receive Registers */
> > +       u32     xSR;            /* Status Register */
> > +       u32     xCR;            /* Control Register */
> > +};
> > +
> >  struct imx_mu_con_priv {
> >         unsigned int            idx;
> >         char                    irq_desc[IMX_MU_CHAN_NAME_SIZE];
> > @@ -61,12 +60,27 @@ struct imx_mu_priv {
> >         struct mbox_chan        mbox_chans[IMX_MU_CHANS];
> >
> >         struct imx_mu_con_priv  con_priv[IMX_MU_CHANS];
> > +       const struct imx_mu_dcfg        *dcfg;
> >         struct clk              *clk;
> >         int                     irq;
> >
> >         bool                    side_b;
> >  };
> >
> > +static const struct imx_mu_dcfg imx_mu_cfg_imx6sx = {
> > +       .xTR    = {0x0, 0x4, 0x8, 0xc},
> > +       .xRR    = {0x10, 0x14, 0x18, 0x1c},
> > +       .xSR    = 0x20,
> > +       .xCR    = 0x24,
> > +};
> > +
> > +static const struct imx_mu_dcfg imx_mu_cfg_imx7ulp = {
> > +       .xTR    = {0x20, 0x24, 0x28, 0x2c},
> > +       .xRR    = {0x40, 0x44, 0x48, 0x4c},
> > +       .xSR    = 0x60,
> > +       .xCR    = 0x64,
> > +};
> > +
> >  static struct imx_mu_priv *to_imx_mu_priv(struct mbox_controller *mbox)
> >  {
> >         return container_of(mbox, struct imx_mu_priv, mbox);
> > @@ -88,10 +102,10 @@ static u32 imx_mu_xcr_rmw(struct imx_mu_priv *priv, u32 set, u32 clr)
> >         u32 val;
> >
> >         spin_lock_irqsave(&priv->xcr_lock, flags);
> > -       val = imx_mu_read(priv, IMX_MU_xCR);
> > +       val = imx_mu_read(priv, priv->dcfg->xCR);
> >         val &= ~clr;
> >         val |= set;
> > -       imx_mu_write(priv, val, IMX_MU_xCR);
> > +       imx_mu_write(priv, val, priv->dcfg->xCR);
> >         spin_unlock_irqrestore(&priv->xcr_lock, flags);
> >
> >         return val;
> > @@ -111,8 +125,8 @@ static irqreturn_t imx_mu_isr(int irq, void *p)
> >         struct imx_mu_con_priv *cp = chan->con_priv;
> >         u32 val, ctrl, dat;
> >
> > -       ctrl = imx_mu_read(priv, IMX_MU_xCR);
> > -       val = imx_mu_read(priv, IMX_MU_xSR);
> > +       ctrl = imx_mu_read(priv, priv->dcfg->xCR);
> > +       val = imx_mu_read(priv, priv->dcfg->xSR);
> >
> >         switch (cp->type) {
> >         case IMX_MU_TYPE_TX:
> > @@ -138,10 +152,10 @@ static irqreturn_t imx_mu_isr(int irq, void *p)
> >                 imx_mu_xcr_rmw(priv, 0, IMX_MU_xCR_TIEn(cp->idx));
> >                 mbox_chan_txdone(chan, 0);
> >         } else if (val == IMX_MU_xSR_RFn(cp->idx)) {
> > -               dat = imx_mu_read(priv, IMX_MU_xRRn(cp->idx));
> > +               dat = imx_mu_read(priv, priv->dcfg->xRR[cp->idx]);
> >                 mbox_chan_received_data(chan, (void *)&dat);
> >         } else if (val == IMX_MU_xSR_GIPn(cp->idx)) {
> > -               imx_mu_write(priv, IMX_MU_xSR_GIPn(cp->idx), IMX_MU_xSR);
> > +               imx_mu_write(priv, IMX_MU_xSR_GIPn(cp->idx), priv->dcfg->xSR);
> >                 mbox_chan_received_data(chan, NULL);
> >         } else {
> >                 dev_warn_ratelimited(priv->dev, "Not handled interrupt\n");
> > @@ -159,7 +173,7 @@ static int imx_mu_send_data(struct mbox_chan *chan, void *data)
> >
> >         switch (cp->type) {
> >         case IMX_MU_TYPE_TX:
> > -               imx_mu_write(priv, *arg, IMX_MU_xTRn(cp->idx));
> > +               imx_mu_write(priv, *arg, priv->dcfg->xTR[cp->idx]);
> >                 imx_mu_xcr_rmw(priv, IMX_MU_xCR_TIEn(cp->idx), 0);
> >                 break;
> >         case IMX_MU_TYPE_TXDB:
> > @@ -270,7 +284,7 @@ static void imx_mu_init_generic(struct imx_mu_priv *priv)
> >                 return;
> >
> >         /* Set default MU configuration */
> > -       imx_mu_write(priv, 0, IMX_MU_xCR);
> > +       imx_mu_write(priv, 0, priv->dcfg->xCR);
> >  }
> >
> >  static int imx_mu_probe(struct platform_device *pdev)
> > @@ -278,6 +292,7 @@ static int imx_mu_probe(struct platform_device *pdev)
> >         struct device *dev = &pdev->dev;
> >         struct device_node *np = dev->of_node;
> >         struct imx_mu_priv *priv;
> > +       const struct imx_mu_dcfg *dcfg;
> >         unsigned int i;
> >         int ret;
> >
> > @@ -295,6 +310,11 @@ static int imx_mu_probe(struct platform_device *pdev)
> >         if (priv->irq < 0)
> >                 return priv->irq;
> >
> > +       dcfg = of_device_get_match_data(dev);
> > +       if (!dcfg)
> > +               return -EINVAL;
> > +       priv->dcfg = dcfg;
> > +
> >         priv->clk = devm_clk_get(dev, NULL);
> >         if (IS_ERR(priv->clk)) {
> >                 if (PTR_ERR(priv->clk) != -ENOENT)
> > @@ -348,7 +368,8 @@ static int imx_mu_remove(struct platform_device *pdev)
> >  }
> >
> >  static const struct of_device_id imx_mu_dt_ids[] = {
> > -       { .compatible = "fsl,imx6sx-mu" },
> > +       { .compatible = "fsl,imx7ulp-mu", .data = &imx_mu_cfg_imx7ulp },
> > +       { .compatible = "fsl,imx6sx-mu", .data = &imx_mu_cfg_imx6sx },
> >         { },
> >  };
> >  MODULE_DEVICE_TABLE(of, imx_mu_dt_ids);
> > --
> > 2.7.4
> >
