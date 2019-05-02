Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352C0C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 09:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D94E8206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 09:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/QvTJIE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfEBJjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 05:39:37 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46788 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfEBJjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 05:39:37 -0400
Received: by mail-yw1-f67.google.com with SMTP id v15so1051693ywe.13;
        Thu, 02 May 2019 02:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xdth6z7sqKu/asM4+DC73vTGpHLCXQAmob0Qaa/8YnM=;
        b=o/QvTJIE8PitYxkh4yvYEP7Tlz9YaO+C3yH6EjG0InghIxds93jyqsBTvd52ICXN9/
         GrsEFXSoSFhBiKoP4lgs43Hyd+cApUzno5wzvBlSlVRc17HFgBdUeUCqkiFKLM3zryEM
         3ww+v/AQN2i8rwinnsnyvLywB9TAc6JhEuP1XTMaFp397P1A/y1eS8hqZJz/9eCGek1j
         xGi0wf/jWQRIu1krKaeL3h6+yi/bDCwuMYNCXkvjnn8yJhuqN8P/5se0UN+kynzp+7qW
         xSpBXd9xbPfFTxWtze6TWkl/13g0pLSVUZQTskfULsKHeXUWmtlqcbPWB+Dtd0mydcb7
         k9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xdth6z7sqKu/asM4+DC73vTGpHLCXQAmob0Qaa/8YnM=;
        b=K21JHir6w5cOnbhuwiLm2iw8MFw5qWx9L/9FsNE9TjiST961nllpD7J2/qgZ2BrMZ6
         Bb9NzSVc863kof3RMPORJPF+edUENo/UgLK/O//wZBZ7wyU9dkxuHakQN0wLniTKtP9Z
         j6E3Brk6HHt2FuRNz/vwmVTf712MbOOy1D+TY413Xu/JcmDrT+rYJpAZohHn2BqUxVkk
         KY/2lRM1SwEFrUdOGv4iB5ioVo5ol2IeYpC8JG8u9ajOkOlaTqzdfSoQkyr8f0OFx2XB
         ixVmptuzj+gg9225sRuDqdj+78rV1kPXyQ/ptq6dTAwxkZzKp78FNaqI3dZID22/dl8p
         eb+Q==
X-Gm-Message-State: APjAAAUJKDH46q2aa8D4y3h/tur2Ldf7m70LBl6CTLuGb+Gcxu2zvtik
        dTKuKg8js/tgVMDnFpF1xuetOgS/nOiP3tkLU+8=
X-Google-Smtp-Source: APXvYqy9UVNsnJk0s5cEO6VZ63moEbd8k1NJDxozXOq8MMQz8L/1qN9gkjVoDMSbQ5Zo2h1ORNtu8+kTCWPcECUeFqY=
X-Received: by 2002:a81:b653:: with SMTP id h19mr2129914ywk.253.1556789975500;
 Thu, 02 May 2019 02:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190419191730.9437-1-peron.clem@gmail.com> <20190419191730.9437-3-peron.clem@gmail.com>
 <20190502082526.c5zo4uzceqzizbxo@flea>
In-Reply-To: <20190502082526.c5zo4uzceqzizbxo@flea>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Thu, 2 May 2019 11:39:24 +0200
Message-ID: <CAJiuCcdFUPBsXfKtDLt-p6Edx-7JrST9d0C=ofCU4CL8ZxwcsA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] ASoC: sun4i-spdif: Add support for H6 SoC
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Thu, 2 May 2019 at 10:25, Maxime Ripard <maxime.ripard@bootlin.com> wrot=
e:
>
> On Fri, Apr 19, 2019 at 09:17:27PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > Allwinner H6 has a different mapping for the fifo register controller.
> >
> > Actually only the fifo tx flush bit is used.
> >
> > Add a new quirk to know the correct fifo tx flush bit.
> >
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  sound/soc/sunxi/sun4i-spdif.c | 42 ++++++++++++++++++++++++++++++-----
> >  1 file changed, 36 insertions(+), 6 deletions(-)
> >
> > diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdi=
f.c
> > index b4af4aabead1..19e4bf9caa24 100644
> > --- a/sound/soc/sunxi/sun4i-spdif.c
> > +++ b/sound/soc/sunxi/sun4i-spdif.c
> > @@ -75,6 +75,18 @@
> >       #define SUN4I_SPDIF_FCTL_RXOM(v)                ((v) << 0)
> >       #define SUN4I_SPDIF_FCTL_RXOM_MASK              GENMASK(1, 0)
> >
> > +#define SUN50I_H6_SPDIF_FCTL (0x14)
> > +     #define SUN50I_H6_SPDIF_FCTL_HUB_EN             BIT(31)
> > +     #define SUN50I_H6_SPDIF_FCTL_FTX                BIT(30)
> > +     #define SUN50I_H6_SPDIF_FCTL_FRX                BIT(29)
> > +     #define SUN50I_H6_SPDIF_FCTL_TXTL(v)            ((v) << 12)
> > +     #define SUN50I_H6_SPDIF_FCTL_TXTL_MASK          GENMASK(19, 12)
> > +     #define SUN50I_H6_SPDIF_FCTL_RXTL(v)            ((v) << 4)
> > +     #define SUN50I_H6_SPDIF_FCTL_RXTL_MASK          GENMASK(10, 4)
> > +     #define SUN50I_H6_SPDIF_FCTL_TXIM               BIT(2)
> > +     #define SUN50I_H6_SPDIF_FCTL_RXOM(v)            ((v) << 0)
> > +     #define SUN50I_H6_SPDIF_FCTL_RXOM_MASK          GENMASK(1, 0)
> > +
> >  #define SUN4I_SPDIF_FSTA     (0x18)
> >       #define SUN4I_SPDIF_FSTA_TXE                    BIT(14)
> >       #define SUN4I_SPDIF_FSTA_TXECNTSHT              (8)
> > @@ -169,16 +181,25 @@ struct sun4i_spdif_dev {
> >       struct snd_soc_dai_driver cpu_dai_drv;
> >       struct regmap *regmap;
> >       struct snd_dmaengine_dai_dma_data dma_params_tx;
> > +     const struct sun4i_spdif_quirks *quirks;
>
> I guess this will generate a warning since the structure hasn't been
> defined yet?

It's a pointer to a structure so no warning from the compiler.

>
> > +};
> > +
> > +struct sun4i_spdif_quirks {
> > +     unsigned int reg_dac_txdata;    /* TX FIFO offset for DMA config =
*/
> > +     unsigned int reg_fctl_ftx;      /* TX FIFO flush bitmask */
> > +     bool has_reset;
>
> You don't really need to move it around, you can just add the
> structure prototype.
>
> If you do want to move it around, then please do so in a separate patch

I have choose to move it to follow what is done in the sun4i-i2s.
I will put it in a separate patch and make the comment a bit more proper.

>
> >  };
> >
> >  static void sun4i_spdif_configure(struct sun4i_spdif_dev *host)
> >  {
> > +     const struct sun4i_spdif_quirks *quirks =3D host->quirks;
> > +
> >       /* soft reset SPDIF */
> >       regmap_write(host->regmap, SUN4I_SPDIF_CTL, SUN4I_SPDIF_CTL_RESET=
);
> >
> >       /* flush TX FIFO */
> >       regmap_update_bits(host->regmap, SUN4I_SPDIF_FCTL,
> > -                        SUN4I_SPDIF_FCTL_FTX, SUN4I_SPDIF_FCTL_FTX);
> > +                        quirks->reg_fctl_ftx, quirks->reg_fctl_ftx);
> >
> >       /* clear TX counter */
> >       regmap_write(host->regmap, SUN4I_SPDIF_TXCNT, 0);
> > @@ -405,22 +426,26 @@ static struct snd_soc_dai_driver sun4i_spdif_dai =
=3D {
> >       .name =3D "spdif",
> >  };
> >
> > -struct sun4i_spdif_quirks {
> > -     unsigned int reg_dac_txdata;    /* TX FIFO offset for DMA config =
*/
> > -     bool has_reset;
> > -};
> > -
> >  static const struct sun4i_spdif_quirks sun4i_a10_spdif_quirks =3D {
> >       .reg_dac_txdata =3D SUN4I_SPDIF_TXFIFO,
> > +     .reg_fctl_ftx   =3D SUN4I_SPDIF_FCTL_FTX,
> >  };
> >
> >  static const struct sun4i_spdif_quirks sun6i_a31_spdif_quirks =3D {
> >       .reg_dac_txdata =3D SUN4I_SPDIF_TXFIFO,
> > +     .reg_fctl_ftx   =3D SUN4I_SPDIF_FCTL_FTX,
> >       .has_reset      =3D true,
> >  };
> >
> >  static const struct sun4i_spdif_quirks sun8i_h3_spdif_quirks =3D {
> >       .reg_dac_txdata =3D SUN8I_SPDIF_TXFIFO,
> > +     .reg_fctl_ftx   =3D SUN4I_SPDIF_FCTL_FTX,
> > +     .has_reset      =3D true,
> > +};
> >
> > +static const struct sun4i_spdif_quirks sun50i_h6_spdif_quirks =3D {
> > +     .reg_dac_txdata =3D SUN8I_SPDIF_TXFIFO,
> > +     .reg_fctl_ftx   =3D SUN50I_H6_SPDIF_FCTL_FTX,
> >       .has_reset      =3D true,
>
> The reg_dac_txdata and reg_fctl_ftx changes here should also be part
> of a separate patch.

You mean the reg_fctl_ftx quirk and the H6 introduction should be split ?

Thanks for the review,
Clement

>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
