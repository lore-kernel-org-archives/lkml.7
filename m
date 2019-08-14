Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEA9C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4C7208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kElqKQBV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfHNLJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 07:09:13 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46688 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfHNLJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 07:09:13 -0400
Received: by mail-lj1-f196.google.com with SMTP id f9so5871973ljc.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 04:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3dv3b99Hy2Xyxj9GiynSK24D1VsCVw66oVAGEMPYy2w=;
        b=kElqKQBVqmVhlYT4jAbn7O4tiAQrKlBEjOVKYkQbJsdOlWzYRc3BMChJ9w3gTjx7Vl
         h3TcDnEJTn7p2hcvbbhG6hn5+9Cy1iMypbXFZOvTjwZhJrnBhzsqlAKh66iVW2CXHF6W
         eOC//yVM5B3Qscykjy+TH1Yu7vpQ96oLw4T7D7NeFPK2/OpwJlhYiyQbJR/nxkFMH76f
         7UmDduIdWsyLmm54s/n4b4oeFpBzihVtv7dFwWhkUWimRKgmjH72B1U+/5RpMootiIRc
         2FXUnDt9vk4K+95Ad16zEC3MQOxNTMoPUo05lnhMyAloUzMwXWRgZYPpqI8Xgw1emtZs
         Rfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3dv3b99Hy2Xyxj9GiynSK24D1VsCVw66oVAGEMPYy2w=;
        b=CJQeqJl01/3Gdm/iTSu9JSlR2Dm99auWtYr88kUYoq4KgEJ+hwl4D5EFyu1nUv1Gqe
         u01T1ZVV8sZsgPdC/7IQRw780DmWJ9AY4DFU/9aGKMWli3iaTYbsqtUA6opxQxQ3AOhA
         hwR/OHxSQow5u4cuGKPW2iDJLgljqpYw1NcHPb07ooFIKGrJibwUYuXhTzghTRbQ7k4R
         JIDpPjQ/fv1YoLjbiCva3GebTrI2ovh7cWLezdhQnl4f8o7OYmbaTu/ir3ozO73eG0Gx
         Dj01jdzSSOuCXLPvK3cbzJ4X2oX51B95HAyb+JqaZuteLVsN/HzU7sQOnrj8aHySXbJr
         3toQ==
X-Gm-Message-State: APjAAAXjzKrSiqXYPkxqPOYoJamsT9Zw7vuia3Hs9545MrYI1OChWDsC
        Wm09Zw3BeGpY5uucIo6/+AcWLIH/HR+mJ3jeYn0=
X-Google-Smtp-Source: APXvYqxZ1SK+MhQi0KpHjbL1d9GcGg2f+ePXEyRIfkmmPY8Qwk4BA6zN/SMw4V0yr5Fno94IkHZaRgveZnkJttEqVe8=
X-Received: by 2002:a2e:9582:: with SMTP id w2mr2007403ljh.194.1565780950904;
 Wed, 14 Aug 2019 04:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190814060854.26345-1-codekipper@gmail.com> <20190814060854.26345-12-codekipper@gmail.com>
 <13079463.kjevBeenX1@jernej-laptop>
In-Reply-To: <13079463.kjevBeenX1@jernej-laptop>
From:   Code Kipper <codekipper@gmail.com>
Date:   Wed, 14 Aug 2019 13:08:59 +0200
Message-ID: <CAEKpxBnLfpUdnksxVVrJt7TESsLq=fnkezBnRZsC1kHRrDrSOQ@mail.gmail.com>
Subject: Re: [PATCH v5 11/15] ASoC: sun4i-i2s: Add support for H6 I2S
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "Andrea Venturi (pers)" <be17068@iperbole.bo.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Aug 2019 at 09:57, Jernej =C5=A0krabec <jernej.skrabec@siol.net>=
 wrote:
>
> Hi!
>
> Dne sreda, 14. avgust 2019 ob 08:08:50 CEST je codekipper@gmail.com
> napisal(a):
> > From: Jernej Skrabec <jernej.skrabec@siol.net>
> >
> > H6 I2S is very similar to that in H3, except it supports up to 16
> > channels.
> >
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
>
> Your Signed-off-by is missing here and on all other patches made original=
ly by
> me.
ACK
>
> Best regards,
> Jernej
>
> > ---
> >  sound/soc/sunxi/sun4i-i2s.c | 148 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 148 insertions(+)
> >
> > diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> > index 6de3cb41aaf6..a8d98696fe7c 100644
> > --- a/sound/soc/sunxi/sun4i-i2s.c
> > +++ b/sound/soc/sunxi/sun4i-i2s.c
> > @@ -121,6 +121,21 @@
> >  #define SUN8I_I2S_RX_CHAN_SEL_REG    0x54
> >  #define SUN8I_I2S_RX_CHAN_MAP_REG    0x58
> >
> > +/* Defines required for sun50i-h6 support */
> > +#define SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET_MASK        GENMASK(21, 20)
> > +#define SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET(offset)     ((offset) << 20)
> > +#define SUN50I_H6_I2S_TX_CHAN_SEL_MASK               GENMASK(19, 16)
> > +#define SUN50I_H6_I2S_TX_CHAN_SEL(chan)              ((chan - 1) << 16=
)
> > +#define SUN50I_H6_I2S_TX_CHAN_EN_MASK                GENMASK(15, 0)
> > +#define SUN50I_H6_I2S_TX_CHAN_EN(num_chan)   (((1 << num_chan) - 1))
> > +
> > +#define SUN50I_H6_I2S_TX_CHAN_MAP0_REG       0x44
> > +#define SUN50I_H6_I2S_TX_CHAN_MAP1_REG       0x48
> > +
> > +#define SUN50I_H6_I2S_RX_CHAN_SEL_REG        0x64
> > +#define SUN50I_H6_I2S_RX_CHAN_MAP0_REG       0x68
> > +#define SUN50I_H6_I2S_RX_CHAN_MAP1_REG       0x6C
> > +
> >  struct sun4i_i2s;
> >
> >  /**
> > @@ -440,6 +455,25 @@ static void sun8i_i2s_set_rxchanoffset(const struc=
t
> > sun4i_i2s *i2s) SUN8I_I2S_TX_CHAN_OFFSET(i2s->offset));
> >  }
> >
> > +static void sun50i_h6_i2s_set_txchanoffset(const struct sun4i_i2s *i2s=
, int
> > output) +{
> > +     if (output >=3D 0 && output < 4) {
> > +             regmap_update_bits(i2s->regmap,
> > +                                SUN8I_I2S_TX_CHAN_SEL_REG +
> (output * 4),
> > +
> SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET_MASK,
> > +
> SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET(i2s->offset));
> > +     }
> > +
> > +}
> > +
> > +static void sun50i_h6_i2s_set_rxchanoffset(const struct sun4i_i2s *i2s=
)
> > +{
> > +     regmap_update_bits(i2s->regmap,
> > +                        SUN50I_H6_I2S_RX_CHAN_SEL_REG,
> > +                        SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET_MASK,
> > +                        SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET(i2s-
> >offset));
> > +}
> > +
> >  static void sun8i_i2s_set_txchanen(const struct sun4i_i2s *i2s, int ou=
tput,
> > int channel)
> >  {
> > @@ -459,6 +493,26 @@ static void sun8i_i2s_set_rxchanen(const struct
> > sun4i_i2s *i2s, int channel) SUN8I_I2S_TX_CHAN_EN(channel));
> >  }
> >
> > +
> > +static void sun50i_h6_i2s_set_txchanen(const struct sun4i_i2s *i2s, in=
t
> > output, +                                    int channel)
> > +{
> > +     if (output >=3D 0 && output < 4) {
> > +             regmap_update_bits(i2s->regmap,
> > +                                SUN8I_I2S_TX_CHAN_SEL_REG +
> (output * 4),
> > +                                SUN50I_H6_I2S_TX_CHAN_EN_MASK,
> > +
> SUN50I_H6_I2S_TX_CHAN_EN(channel));
> > +     }
> > +}
> > +
> > +static void sun50i_h6_i2s_set_rxchanen(const struct sun4i_i2s *i2s, in=
t
> > channel) +{
> > +     regmap_update_bits(i2s->regmap,
> > +                        SUN50I_H6_I2S_RX_CHAN_SEL_REG,
> > +                        SUN50I_H6_I2S_TX_CHAN_EN_MASK,
> > +                        SUN50I_H6_I2S_TX_CHAN_EN(channel));
> > +}
> > +
> >  static void sun4i_i2s_set_txchansel(const struct sun4i_i2s *i2s, int
> > output, int channel)
> >  {
> > @@ -495,6 +549,25 @@ static void sun8i_i2s_set_rxchansel(const struct
> > sun4i_i2s *i2s, int channel) SUN8I_I2S_TX_CHAN_SEL(channel));
> >  }
> >
> > +static void sun50i_h6_i2s_set_txchansel(const struct sun4i_i2s *i2s, i=
nt
> > output, +                                    int channel)
> > +{
> > +     if (output >=3D 0 && output < 4) {
> > +             regmap_update_bits(i2s->regmap,
> > +                                SUN8I_I2S_TX_CHAN_SEL_REG +
> (output * 4),
> > +                                SUN50I_H6_I2S_TX_CHAN_SEL_MASK,
> > +
> SUN50I_H6_I2S_TX_CHAN_SEL(channel));
> > +     }
> > +}
> > +
> > +static void sun50i_h6_i2s_set_rxchansel(const struct sun4i_i2s *i2s, i=
nt
> > channel) +{
> > +     regmap_update_bits(i2s->regmap,
> > +                        SUN50I_H6_I2S_RX_CHAN_SEL_REG,
> > +                        SUN50I_H6_I2S_TX_CHAN_SEL_MASK,
> > +                        SUN50I_H6_I2S_TX_CHAN_SEL(channel));
> > +}
> > +
> >  static void sun4i_i2s_set_txchanmap(const struct sun4i_i2s *i2s, int
> > output, int channel)
> >  {
> > @@ -520,6 +593,20 @@ static void sun8i_i2s_set_rxchanmap(const struct
> > sun4i_i2s *i2s, int channel) regmap_write(i2s->regmap,
> > SUN8I_I2S_RX_CHAN_MAP_REG, channel);
> >  }
> >
> > +static void sun50i_h6_i2s_set_txchanmap(const struct sun4i_i2s *i2s, i=
nt
> > output, +                                    int channel)
> > +{
> > +     if (output >=3D 0 && output < 4) {
> > +             regmap_write(i2s->regmap,
> > +                          SUN50I_H6_I2S_TX_CHAN_MAP1_REG + (output
> * 8), channel);
> > +     }
> > +}
> > +
> > +static void sun50i_h6_i2s_set_rxchanmap(const struct sun4i_i2s *i2s, i=
nt
> > channel) +{
> > +     regmap_write(i2s->regmap, SUN50I_H6_I2S_RX_CHAN_MAP1_REG, channel=
);
> > +}
> > +
> >  static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
> >                              struct snd_pcm_hw_params *params,
> >                              struct snd_soc_dai *dai)
> > @@ -996,6 +1083,22 @@ static const struct reg_default
> > sun8i_i2s_reg_defaults[] =3D { { SUN8I_I2S_RX_CHAN_MAP_REG, 0x00000000 =
},
> >  };
> >
> > +static const struct reg_default sun50i_i2s_reg_defaults[] =3D {
> > +     { SUN4I_I2S_CTRL_REG, 0x00060000 },
> > +     { SUN4I_I2S_FMT0_REG, 0x00000033 },
> > +     { SUN4I_I2S_FMT1_REG, 0x00000030 },
> > +     { SUN4I_I2S_FIFO_CTRL_REG, 0x000400f0 },
> > +     { SUN4I_I2S_DMA_INT_CTRL_REG, 0x00000000 },
> > +     { SUN4I_I2S_CLK_DIV_REG, 0x00000000 },
> > +     { SUN8I_I2S_CHAN_CFG_REG, 0x00000000 },
> > +     { SUN8I_I2S_TX_CHAN_SEL_REG, 0x00000000 },
> > +     { SUN50I_H6_I2S_TX_CHAN_MAP0_REG, 0x00000000 },
> > +     { SUN50I_H6_I2S_TX_CHAN_MAP1_REG, 0x00000000 },
> > +     { SUN50I_H6_I2S_RX_CHAN_SEL_REG, 0x00000000 },
> > +     { SUN50I_H6_I2S_RX_CHAN_MAP0_REG, 0x00000000 },
> > +     { SUN50I_H6_I2S_RX_CHAN_MAP1_REG, 0x00000000 },
> > +};
> > +
> >  static const struct regmap_config sun4i_i2s_regmap_config =3D {
> >       .reg_bits       =3D 32,
> >       .reg_stride     =3D 4,
> > @@ -1023,6 +1126,19 @@ static const struct regmap_config
> > sun8i_i2s_regmap_config =3D { .volatile_reg     =3D sun8i_i2s_volatile_=
reg,
> >  };
> >
> > +static const struct regmap_config sun50i_i2s_regmap_config =3D {
> > +     .reg_bits       =3D 32,
> > +     .reg_stride     =3D 4,
> > +     .val_bits       =3D 32,
> > +     .max_register   =3D SUN50I_H6_I2S_RX_CHAN_MAP1_REG,
> > +     .cache_type     =3D REGCACHE_FLAT,
> > +     .reg_defaults   =3D sun50i_i2s_reg_defaults,
> > +     .num_reg_defaults       =3D ARRAY_SIZE(sun50i_i2s_reg_defaults),
> > +     .writeable_reg  =3D sun4i_i2s_wr_reg,
> > +     .readable_reg   =3D sun8i_i2s_rd_reg,
> > +     .volatile_reg   =3D sun8i_i2s_volatile_reg,
> > +};
> > +
> >  static int sun4i_i2s_runtime_resume(struct device *dev)
> >  {
> >       struct sun4i_i2s *i2s =3D dev_get_drvdata(dev);
> > @@ -1197,6 +1313,34 @@ static const struct sun4i_i2s_quirks
> > sun50i_a64_codec_i2s_quirks =3D { .set_rxchanmap                =3D
> sun4i_i2s_set_rxchanmap,
> >  };
> >
> > +static const struct sun4i_i2s_quirks sun50i_h6_i2s_quirks =3D {
> > +     .has_reset              =3D true,
> > +     .reg_offset_txdata      =3D SUN8I_I2S_FIFO_TX_REG,
> > +     .sun4i_i2s_regmap       =3D &sun50i_i2s_regmap_config,
> > +     .has_fmt_set_lrck_period =3D true,
> > +     .has_chcfg              =3D true,
> > +     .has_chsel_tx_chen      =3D true,
> > +     .has_chsel_offset       =3D true,
> > +     .field_clkdiv_mclk_en   =3D REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 8, 8=
),
> > +     .field_fmt_wss          =3D REG_FIELD(SUN4I_I2S_FMT0_REG,
> 0, 2),
> > +     .field_fmt_sr           =3D REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 6),
> > +     .field_fmt_bclk         =3D REG_FIELD(SUN4I_I2S_FMT0_REG,
> 7, 7),
> > +     .field_fmt_lrclk        =3D REG_FIELD(SUN4I_I2S_FMT0_REG, 19, 19)=
,
> > +     .field_fmt_mode         =3D REG_FIELD(SUN4I_I2S_CTRL_REG, 4,
> 5),
> > +     .field_fmt_sext         =3D REG_FIELD(SUN4I_I2S_FMT1_REG,
> 4, 5),
> > +     .get_sr                 =3D sun8i_i2s_get_sr_wss,
> > +     .get_wss                =3D sun8i_i2s_get_sr_wss,
> > +     .set_format             =3D sun8i_i2s_set_format,
> > +     .set_txchanoffset       =3D sun50i_h6_i2s_set_txchanoffset,
> > +     .set_rxchanoffset       =3D sun50i_h6_i2s_set_rxchanoffset,
> > +     .set_txchanen           =3D sun50i_h6_i2s_set_txchanen,
> > +     .set_rxchanen           =3D sun50i_h6_i2s_set_rxchanen,
> > +     .set_txchansel          =3D sun50i_h6_i2s_set_txchansel,
> > +     .set_rxchansel          =3D sun50i_h6_i2s_set_rxchansel,
> > +     .set_txchanmap          =3D sun50i_h6_i2s_set_txchanmap,
> > +     .set_rxchanmap          =3D sun50i_h6_i2s_set_rxchanmap,
> > +};
> > +
> >  static int sun4i_i2s_init_regmap_fields(struct device *dev,
> >                                       struct sun4i_i2s *i2s)
> >  {
> > @@ -1389,6 +1533,10 @@ static const struct of_device_id sun4i_i2s_match=
[] =3D
> > { .compatible =3D "allwinner,sun50i-a64-codec-i2s",
> >               .data =3D &sun50i_a64_codec_i2s_quirks,
> >       },
> > +     {
> > +             .compatible =3D "allwinner,sun50i-h6-i2s",
> > +             .data =3D &sun50i_h6_i2s_quirks,
> > +     },
> >       {}
> >  };
> >  MODULE_DEVICE_TABLE(of, sun4i_i2s_match);
>
>
>
>
