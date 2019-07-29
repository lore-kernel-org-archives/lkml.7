Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9AFC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 03:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5091F2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 03:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkFqqDGb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfG2DUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 23:20:22 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33622 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfG2DUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 23:20:21 -0400
Received: by mail-io1-f67.google.com with SMTP id z3so7211671iog.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 20:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UPN1yujIvAL+R2moraIVgDPevPOVxeYGIIWK1IArOqg=;
        b=IkFqqDGb6C9v35uw1uRjy2TidfD2hnLlI1Qs1FvBivI3QhilRXIyQ3p6oX8P/BjPCA
         dvK1S8eKPk9nuZefOvOrfT/afNpziiKiuR+oCxudamq5WahGXA0dMRMDBXzvXlEingzw
         78Ll3dO7SeF48f/ScCZwxX0pMux7TLIuIFSaCIhlVjVOy5wCgS20hYliC9hts6Uls/qs
         qlv9uqhF1/N3nQbUanTmz9Tn3QtCKEP5H6fB65v0l1d29pmF9ynAh4yhkaFeC6eShi3c
         sEk3j07CjKOVezdbQQqzNhtEiMux0Sg4rE36Xb1n5CbMtN1j6DvlgU8PSnWZMXePU8ve
         0uVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UPN1yujIvAL+R2moraIVgDPevPOVxeYGIIWK1IArOqg=;
        b=WhrJQ5t89WlaKF1XGY1IhC/SWWSOsFJ1U4rSQgyaZDld7HcDagQDE9nKGO+K7K6/aT
         gAT6HmbpfG2+Fah7+6/Qag3x8wuAD20jjkfULJ8XyJ+dG/trwi8y5FckKX2xXKYvlxo8
         B+Ka5pDzLB0qM9T3nObp+0rxgHr60JMTf4x/Tc5Ty5NsjQWxQ80GR/ELFKit7LsPMOa/
         Pr7m1i4gzRX0f+LzEwXTZ2hM7nR2WMCb0YtVczEl+Y1+A5gNZlBT+eW1UPTd8lhWOOHY
         hxNDZkfBhSuV1bWJJf5FuGqlXAkzPUVp6d4KF9kG0cUTwCMveFHMoNfwimehvJgdTadS
         qK4A==
X-Gm-Message-State: APjAAAXTwxx+M/C4BjPhIH8cMwX2N7plBAOOoTWcqbeFMhUsLUCj7nef
        /siuk4n1j091Bzzyqzj3SpcAGdmrmuir0gidsWc=
X-Google-Smtp-Source: APXvYqzFMWMaAb9WJPNVt+xKDI7r5l6Ypce3JksSRsg7cMO+3SSsOkfRxik78eas+MzoZywJCe5d0RJQBqb4I0xYj8A=
X-Received: by 2002:a02:ac03:: with SMTP id a3mr113762457jao.132.1564370420498;
 Sun, 28 Jul 2019 20:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <1564366440-10970-1-git-send-email-hongxing.zhu@nxp.com>
 <CAA+hA=Qg9uu+m3iTnbu2_+s4UN=kGpSNHsoKtjUggXnvLy4hbw@mail.gmail.com> <AM0PR0402MB3570521B715B6DD092B6DA768CDD0@AM0PR0402MB3570.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR0402MB3570521B715B6DD092B6DA768CDD0@AM0PR0402MB3570.eurprd04.prod.outlook.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Mon, 29 Jul 2019 11:11:07 +0800
Message-ID: <CAA+hA=QnNE2q9z9YJeu5bedBFjV6QmxkUDayqZ25NqdCQ1k0uw@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH] mailbox: imx: add support for imx v1 mu
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 11:03 AM Richard Zhu <hongxing.zhu@nxp.com> wrote:
>
> Hi Aisheng:
> Thanks for your comments.
>
> > -----Original Message-----
> > From: Dong Aisheng <dongas86@gmail.com>
> > Sent: 2019=E5=B9=B47=E6=9C=8829=E6=97=A5 10:35
> > To: Richard Zhu <hongxing.zhu@nxp.com>
> > Cc: jassisinghbrar@gmail.com; Oleksij Rempel <o.rempel@pengutronix.de>;
> > Aisheng Dong <aisheng.dong@nxp.com>; open list
> > <linux-kernel@vger.kernel.org>; moderated list:ARM/FREESCALE IMX / MXC
> > ARM ARCHITECTURE <linux-arm-kernel@lists.infradead.org>
> > Subject: [EXT] Re: [PATCH] mailbox: imx: add support for imx v1 mu
> >
> > On Mon, Jul 29, 2019 at 10:36 AM Richard Zhu <hongxing.zhu@nxp.com>
> > wrote:
> > >
> > > There is a version1.0 MU on i.MX7ULP platform.
> > > One new version ID register is added, and it's offset is 0.
> > > TRn registers are defined at the offset 0x20 ~ 0x2C.
> > > RRn registers are defined at the offset 0x40 ~ 0x4C.
> > > SR/CR registers are defined at 0x60/0x64.
> > > Extend this driver to support it.
> > >
> >
> > If only the register base offset is different, there's probably a more =
simple way.
> > Please refer to:
> >
> [Richard Zhu] TRx, RRx and the CR/SR have the different offset addresses.
> That means three different offset addresses should be manipulated if the =
solution listed above is used.
> It seems that it's a little complex, and maybe introduce bugs when differ=
ent offset address is manipulated.
> According, the current method suggested by Oleksij is much clear, and eas=
y to extend for future extension.
>

I missed that.
Maybe the patch title should be V2 and add Suggested-by: tag to
reminder reviewer
it's a new version?

If there're multiple offset differences. I'm fine with this way.
Feel free to add my tag.
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Aisheng

> Hi Olekiji:
> How do you think about?
>
> Best Regards
> Richard Zhu
>
> > Regards
> > Aisheng
> >
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > ---
> > >  drivers/mailbox/imx-mailbox.c | 67
> > > ++++++++++++++++++++++++++++++++-----------
> > >  1 file changed, 50 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/drivers/mailbox/imx-mailbox.c
> > > b/drivers/mailbox/imx-mailbox.c index 25be8bb..8423a38 100644
> > > --- a/drivers/mailbox/imx-mailbox.c
> > > +++ b/drivers/mailbox/imx-mailbox.c
> > > @@ -12,19 +12,11 @@
> > >  #include <linux/of_device.h>
> > >  #include <linux/slab.h>
> > >
> > > -/* Transmit Register */
> > > -#define IMX_MU_xTRn(x)         (0x00 + 4 * (x))
> > > -/* Receive Register */
> > > -#define IMX_MU_xRRn(x)         (0x10 + 4 * (x))
> > > -/* Status Register */
> > > -#define IMX_MU_xSR             0x20
> > >  #define IMX_MU_xSR_GIPn(x)     BIT(28 + (3 - (x)))
> > >  #define IMX_MU_xSR_RFn(x)      BIT(24 + (3 - (x)))
> > >  #define IMX_MU_xSR_TEn(x)      BIT(20 + (3 - (x)))
> > >  #define IMX_MU_xSR_BRDIP       BIT(9)
> > >
> > > -/* Control Register */
> > > -#define IMX_MU_xCR             0x24
> > >  /* General Purpose Interrupt Enable */
> > >  #define IMX_MU_xCR_GIEn(x)     BIT(28 + (3 - (x)))
> > >  /* Receive Interrupt Enable */
> > > @@ -44,6 +36,13 @@ enum imx_mu_chan_type {
> > >         IMX_MU_TYPE_RXDB,       /* Rx doorbell */
> > >  };
> > >
> > > +struct imx_mu_dcfg {
> > > +       u32     xTR[4];         /* Transmit Registers */
> > > +       u32     xRR[4];         /* Receive Registers */
> > > +       u32     xSR;            /* Status Register */
> > > +       u32     xCR;            /* Control Register */
> > > +};
> > > +
> > >  struct imx_mu_con_priv {
> > >         unsigned int            idx;
> > >         char
> > irq_desc[IMX_MU_CHAN_NAME_SIZE];
> > > @@ -61,12 +60,39 @@ struct imx_mu_priv {
> > >         struct mbox_chan        mbox_chans[IMX_MU_CHANS];
> > >
> > >         struct imx_mu_con_priv  con_priv[IMX_MU_CHANS];
> > > +       const struct imx_mu_dcfg        *dcfg;
> > >         struct clk              *clk;
> > >         int                     irq;
> > >
> > >         bool                    side_b;
> > >  };
> > >
> > > +static const struct imx_mu_dcfg imx_mu_cfg_imx6sx =3D {
> > > +       .xTR[0] =3D 0x0,
> > > +       .xTR[1] =3D 0x4,
> > > +       .xTR[2] =3D 0x8,
> > > +       .xTR[3] =3D 0xC,
> > > +       .xRR[0] =3D 0x10,
> > > +       .xRR[1] =3D 0x14,
> > > +       .xRR[2] =3D 0x18,
> > > +       .xRR[3] =3D 0x1C,
> > > +       .xSR    =3D 0x20,
> > > +       .xCR    =3D 0x24,
> > > +};
> > > +
> > > +static const struct imx_mu_dcfg imx_mu_cfg_imx7ulp =3D {
> > > +       .xTR[0] =3D 0x20,
> > > +       .xTR[1] =3D 0x24,
> > > +       .xTR[2] =3D 0x28,
> > > +       .xTR[3] =3D 0x2C,
> > > +       .xRR[0] =3D 0x40,
> > > +       .xRR[1] =3D 0x44,
> > > +       .xRR[2] =3D 0x48,
> > > +       .xRR[3] =3D 0x4C,
> > > +       .xSR    =3D 0x60,
> > > +       .xCR    =3D 0x64,
> > > +};
> > > +
> > >  static struct imx_mu_priv *to_imx_mu_priv(struct mbox_controller
> > > *mbox)  {
> > >         return container_of(mbox, struct imx_mu_priv, mbox); @@ -88,1=
0
> > > +114,10 @@ static u32 imx_mu_xcr_rmw(struct imx_mu_priv *priv, u32 se=
t,
> > u32 clr)
> > >         u32 val;
> > >
> > >         spin_lock_irqsave(&priv->xcr_lock, flags);
> > > -       val =3D imx_mu_read(priv, IMX_MU_xCR);
> > > +       val =3D imx_mu_read(priv, priv->dcfg->xCR);
> > >         val &=3D ~clr;
> > >         val |=3D set;
> > > -       imx_mu_write(priv, val, IMX_MU_xCR);
> > > +       imx_mu_write(priv, val, priv->dcfg->xCR);
> > >         spin_unlock_irqrestore(&priv->xcr_lock, flags);
> > >
> > >         return val;
> > > @@ -111,8 +137,8 @@ static irqreturn_t imx_mu_isr(int irq, void *p)
> > >         struct imx_mu_con_priv *cp =3D chan->con_priv;
> > >         u32 val, ctrl, dat;
> > >
> > > -       ctrl =3D imx_mu_read(priv, IMX_MU_xCR);
> > > -       val =3D imx_mu_read(priv, IMX_MU_xSR);
> > > +       ctrl =3D imx_mu_read(priv, priv->dcfg->xCR);
> > > +       val =3D imx_mu_read(priv, priv->dcfg->xSR);
> > >
> > >         switch (cp->type) {
> > >         case IMX_MU_TYPE_TX:
> > > @@ -138,10 +164,10 @@ static irqreturn_t imx_mu_isr(int irq, void *p)
> > >                 imx_mu_xcr_rmw(priv, 0, IMX_MU_xCR_TIEn(cp->idx));
> > >                 mbox_chan_txdone(chan, 0);
> > >         } else if (val =3D=3D IMX_MU_xSR_RFn(cp->idx)) {
> > > -               dat =3D imx_mu_read(priv, IMX_MU_xRRn(cp->idx));
> > > +               dat =3D imx_mu_read(priv, priv->dcfg->xRR[cp->idx]);
> > >                 mbox_chan_received_data(chan, (void *)&dat);
> > >         } else if (val =3D=3D IMX_MU_xSR_GIPn(cp->idx)) {
> > > -               imx_mu_write(priv, IMX_MU_xSR_GIPn(cp->idx),
> > IMX_MU_xSR);
> > > +               imx_mu_write(priv, IMX_MU_xSR_GIPn(cp->idx),
> > > + priv->dcfg->xSR);
> > >                 mbox_chan_received_data(chan, NULL);
> > >         } else {
> > >                 dev_warn_ratelimited(priv->dev, "Not handled
> > > interrupt\n"); @@ -159,7 +185,7 @@ static int imx_mu_send_data(struct
> > > mbox_chan *chan, void *data)
> > >
> > >         switch (cp->type) {
> > >         case IMX_MU_TYPE_TX:
> > > -               imx_mu_write(priv, *arg, IMX_MU_xTRn(cp->idx));
> > > +               imx_mu_write(priv, *arg, priv->dcfg->xTR[cp->idx]);
> > >                 imx_mu_xcr_rmw(priv, IMX_MU_xCR_TIEn(cp->idx), 0);
> > >                 break;
> > >         case IMX_MU_TYPE_TXDB:
> > > @@ -257,7 +283,7 @@ static void imx_mu_init_generic(struct imx_mu_pri=
v
> > *priv)
> > >                 return;
> > >
> > >         /* Set default MU configuration */
> > > -       imx_mu_write(priv, 0, IMX_MU_xCR);
> > > +       imx_mu_write(priv, 0, priv->dcfg->xCR);
> > >  }
> > >
> > >  static int imx_mu_probe(struct platform_device *pdev) @@ -265,6
> > > +291,7 @@ static int imx_mu_probe(struct platform_device *pdev)
> > >         struct device *dev =3D &pdev->dev;
> > >         struct device_node *np =3D dev->of_node;
> > >         struct imx_mu_priv *priv;
> > > +       const struct imx_mu_dcfg *dcfg;
> > >         unsigned int i;
> > >         int ret;
> > >
> > > @@ -282,6 +309,11 @@ static int imx_mu_probe(struct platform_device
> > *pdev)
> > >         if (priv->irq < 0)
> > >                 return priv->irq;
> > >
> > > +       dcfg =3D of_device_get_match_data(dev);
> > > +       if (!dcfg)
> > > +               return -EINVAL;
> > > +       priv->dcfg =3D dcfg;
> > > +
> > >         priv->clk =3D devm_clk_get(dev, NULL);
> > >         if (IS_ERR(priv->clk)) {
> > >                 if (PTR_ERR(priv->clk) !=3D -ENOENT) @@ -335,7 +367,8
> > @@
> > > static int imx_mu_remove(struct platform_device *pdev)  }
> > >
> > >  static const struct of_device_id imx_mu_dt_ids[] =3D {
> > > -       { .compatible =3D "fsl,imx6sx-mu" },
> > > +       { .compatible =3D "fsl,imx7ulp-mu", .data =3D &imx_mu_cfg_imx=
7ulp },
> > > +       { .compatible =3D "fsl,imx6sx-mu", .data =3D &imx_mu_cfg_imx6=
sx },
> > >         { },
> > >  };
> > >  MODULE_DEVICE_TABLE(of, imx_mu_dt_ids);
> > > --
> > > 2.7.4
> > >
