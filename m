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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE73DC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 813852063F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="suWxv8GW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfHNLX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 07:23:28 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34455 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfHNLX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 07:23:28 -0400
Received: by mail-lj1-f196.google.com with SMTP id x18so7987260ljh.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 04:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Hun0W4JYfFAPrSkp45isBz4yx0/DZ2zAS0iOxzO7EM=;
        b=suWxv8GWDTBmU5Xk5e3LWyUJlLUtY80UHPldQGlpSTJeoHqDpsxBzoy2wUAjqbVlfz
         bRfEeM95aPUA3oBquR/dZuy26/NkTEDJQTagJ466LJ6rOf83CDxzAQq+dkVQOcpFYU20
         ZoRpDVWSPVJJ7eAd8+H8HkxtkNNowgrxcgLGvaBJqqOG+NPM18n1M04Jh0eMpvjY0BSp
         1yWFD0wzgFHKo67q9f4piuJ7XuYiVIFwmsyjykWYl2Hw6MRs5w4FKUTsGxhEcgD++I93
         VJLW0RQ+EPYvLzkuvIstq4DAbA6a0a85TjlcPDrOWO88Qs3QKC2Z4gJUXTpX2ZchRemF
         xb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Hun0W4JYfFAPrSkp45isBz4yx0/DZ2zAS0iOxzO7EM=;
        b=Vt2aXq1lyfqTKeyXEoWNeh8nWz2DJbjfW7UV7FXVfSR2vVBluMdBqbzgXqgD5FqkvQ
         wtiGaaARIWN8+rX5iZar9DvJQiPjuiHXT9NYIr5x5o0yk1tuRd/GSouiho0xzu4sdUIc
         UyjOfnnlKpStMdavBrFzDb2cQyxCp3NdEyFxqDnAUdWubA3yrs/07FglLbQPPiBhdkZb
         lDdUY1KHJ7+Bp57yaHEKpAfknHB0mAS2QH991f+Z/wotsqCINzEoy/7MmnE7n+EoD3m2
         XW5ZCyY9CZH/pm+0c+zmzDM4EBw480ePMaUj2rdpX8x+nOk/Kb+qCP/GqIr6Wye5fD/q
         Zwpg==
X-Gm-Message-State: APjAAAXX757Ln7Zv0a+Vz3EtnnJrZpxt1uVPh1mXmn60N3e0l/E9ozpS
        FyLNC//zfEHA49ZwYEw3CtH9d80htvkL+VWW57I=
X-Google-Smtp-Source: APXvYqwdBrVqk5ITzZY8yEzMrPYd5+3xZUnvw0GyTGzRQ239iMMf/1PQgEcsGNselnMTD5/6zdoYOK/LEP3uR3XKjxE=
X-Received: by 2002:a2e:8510:: with SMTP id j16mr8164931lji.174.1565781805273;
 Wed, 14 Aug 2019 04:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190814060854.26345-1-codekipper@gmail.com> <20190814060854.26345-5-codekipper@gmail.com>
 <20190814071645.33qe7bvwpbakjg2e@flea>
In-Reply-To: <20190814071645.33qe7bvwpbakjg2e@flea>
From:   Code Kipper <codekipper@gmail.com>
Date:   Wed, 14 Aug 2019 13:23:14 +0200
Message-ID: <CAEKpxBn8sN_4HFYTsG5JTtGuFP-jb733wKLaSHU_0UPvmF3GKA@mail.gmail.com>
Subject: Re: [PATCH v5 04/15] ASoC: sun4i-i2s: Support more formats on newer SoCs
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "Andrea Venturi (pers)" <be17068@iperbole.bo.it>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Aug 2019 at 13:08, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Wed, Aug 14, 2019 at 08:08:43AM +0200, codekipper@gmail.com wrote:
> > From: Marcus Cooper <codekipper@gmail.com>
> >
> > There is a need to support more formats on the newer SoCs(H3 and later).
> > Extend the formats supported to include DSP_A and DSP_B modes.
> >
> > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > ---
> >  sound/soc/sunxi/sun4i-i2s.c | 87 +++++++++++++++++++++++++++----------
> >  1 file changed, 63 insertions(+), 24 deletions(-)
> >
> > diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> > index 34f31439ae7b..3553c17318b0 100644
> > --- a/sound/soc/sunxi/sun4i-i2s.c
> > +++ b/sound/soc/sunxi/sun4i-i2s.c
> > @@ -27,6 +27,8 @@
> >  #define SUN4I_I2S_CTRL_MODE_MASK             BIT(5)
> >  #define SUN4I_I2S_CTRL_MODE_SLAVE                    (1 << 5)
> >  #define SUN4I_I2S_CTRL_MODE_MASTER                   (0 << 5)
> > +#define SUN4I_I2S_CTRL_PCM                   BIT(4)
> > +#define SUN4I_I2S_CTRL_LOOP                  BIT(3)
> >  #define SUN4I_I2S_CTRL_TX_EN                 BIT(2)
> >  #define SUN4I_I2S_CTRL_RX_EN                 BIT(1)
> >  #define SUN4I_I2S_CTRL_GL_EN                 BIT(0)
> > @@ -91,6 +93,9 @@
> >  /* Defines required for sun8i-h3 support */
> >  #define SUN8I_I2S_CTRL_BCLK_OUT                      BIT(18)
> >  #define SUN8I_I2S_CTRL_LRCK_OUT                      BIT(17)
> > +#define SUN8I_I2S_CTRL_MODE_RIGHT_J                  (2 << 0)
> > +#define SUN8I_I2S_CTRL_MODE_I2S_LEFT_J                       (1 << 0)
> > +#define SUN8I_I2S_CTRL_MODE_PCM                              (0 << 0)
> >
> >  #define SUN8I_I2S_FMT0_LRCK_PERIOD_MASK              GENMASK(17, 8)
> >  #define SUN8I_I2S_FMT0_LRCK_PERIOD(period)   ((period - 1) << 8)
> > @@ -164,6 +169,7 @@ struct sun4i_i2s_quirks {
> >
> >       s8      (*get_sr)(const struct sun4i_i2s *, int);
> >       s8      (*get_wss)(const struct sun4i_i2s *, int);
> > +     int     (*set_format)(struct sun4i_i2s *, unsigned int);
> >  };
> >
> >  struct sun4i_i2s {
> > @@ -194,6 +200,7 @@ struct sun4i_i2s {
> >
> >       unsigned int    tdm_slots;
> >       unsigned int    slot_width;
> > +     unsigned int    offset;
> >  };
> >
> >  struct sun4i_i2s_clk_div {
> > @@ -484,19 +491,14 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
> >                                     i2s->slot_width : params_width(params));
> >  }
> >
> > -static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
> > +static int sun4i_i2s_set_format(struct sun4i_i2s *i2s, unsigned int fmt)
> >  {
> > -     struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
> >       u32 val;
> > -     u32 offset = 0;
> > -     u32 bclk_polarity = SUN4I_I2S_FMT0_POLARITY_NORMAL;
> > -     u32 lrclk_polarity = SUN4I_I2S_FMT0_POLARITY_NORMAL;
> >
> >       /* DAI Mode */
> >       switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> >       case SND_SOC_DAIFMT_I2S:
> >               val = SUN4I_I2S_FMT0_FMT_I2S;
> > -             offset = 1;
> >               break;
> >       case SND_SOC_DAIFMT_LEFT_J:
> >               val = SUN4I_I2S_FMT0_FMT_LEFT_J;
> > @@ -505,32 +507,64 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
> >               val = SUN4I_I2S_FMT0_FMT_RIGHT_J;
> >               break;
> >       default:
> > -             dev_err(dai->dev, "Unsupported format: %d\n",
> > -                     fmt & SND_SOC_DAIFMT_FORMAT_MASK);
> >               return -EINVAL;
> >       }
> >
> > -     if (i2s->variant->has_chsel_offset) {
> > -             /*
> > -              * offset being set indicates that we're connected to an i2s
> > -              * device, however offset is only used on the sun8i block and
> > -              * i2s shares the same setting with the LJ format. Increment
> > -              * val so that the bit to value to write is correct.
> > -              */
> > -             if (offset > 0)
> > -                     val++;
> > -             /* blck offset determines whether i2s or LJ */
> > -             regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
> > -                                SUN8I_I2S_TX_CHAN_OFFSET_MASK,
> > -                                SUN8I_I2S_TX_CHAN_OFFSET(offset));
> > +     regmap_field_write(i2s->field_fmt_mode, val);
> > +
> > +     return 0;
> > +}
> > +
> > +static int sun8i_i2s_set_format(struct sun4i_i2s *i2s, unsigned int fmt)
> > +{
> > +     u32 val;
> >
> > -             regmap_update_bits(i2s->regmap, SUN8I_I2S_RX_CHAN_SEL_REG,
> > -                                SUN8I_I2S_TX_CHAN_OFFSET_MASK,
> > -                                SUN8I_I2S_TX_CHAN_OFFSET(offset));
> > +     /* DAI Mode */
> > +     switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> > +     case SND_SOC_DAIFMT_I2S:
> > +             i2s->offset = 1;
> > +     case SND_SOC_DAIFMT_LEFT_J:
> > +             val = SUN8I_I2S_CTRL_MODE_I2S_LEFT_J;
> > +             break;
> > +     case SND_SOC_DAIFMT_RIGHT_J:
> > +             val = SUN8I_I2S_CTRL_MODE_RIGHT_J;
> > +             break;
> > +     case SND_SOC_DAIFMT_DSP_A:
> > +             i2s->offset = 1;
> > +     case SND_SOC_DAIFMT_DSP_B:
> > +             val = SUN8I_I2S_CTRL_MODE_PCM;
> > +             break;
> > +
> > +     default:
> > +             return -EINVAL;
> >       }
> >
> > +     /*
> > +      * bclk offset determines whether i2s or LJ if in i2s mode and
> > +      * DSP_A or DSP_B if in PCM mode.
> > +      */
> > +     i2s->variant->set_txchanoffset(i2s, 0);
> > +     i2s->variant->set_rxchanoffset(i2s);
> > +
> >       regmap_field_write(i2s->field_fmt_mode, val);
>
> It's a bit more complicated in the sun8i case. The LRCK period also
> needs to be changed when in PCM / DSP_* mode since it changes from a
> number of periods for one channel to a number of periods for all the
> channels.
Yeah I was thinking that but I don't have any hardware to test this with (been
helping out someone trying to connect to a modem).
>
> I have patches that still need a bit of rework and take care of all of
> that, I'll try to post them by the end of the week

This patch could be dropped for now or at least we just keep the
offset parts in.
BR,
CK

>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
