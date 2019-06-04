Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BE9C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C932245BC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxfJmMNa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfFDLqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 07:46:32 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44886 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbfFDLqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 07:46:32 -0400
Received: by mail-lj1-f196.google.com with SMTP id p67so2887462ljp.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 04:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tAJHzdtoUHBGcl/ayUBAfIA8bNQX6pMqdoZW2RgjLw8=;
        b=MxfJmMNaRkzihyUPNF6atM911sUNuCUizSvuv0oNDUFV9WWwPX5jZbwllidOdbgwqn
         hOHRyselYkHjWCb/JyFMvF7EqwgpFXr8lIgi7xJfZHfoe9YWACUt8sGeE0puDLvSMKlE
         WHFUVnSDjfz0ftC5hCi/mA61LuFFITvuBoe2Zc4BZx/w1zGQ4+bgjyVhdYTnHjYnEY6o
         Ef0w1M+5NW7rWY/ziXa2+JlNNUhOMnozExj0lTimQGQPkMV7qKREFbl1+P0LUO8JwiVl
         WuOWgEOGza80fOa0AATy0POyWYX/pbm9CPz1gBqjz6r9bKAZYMBUte/5EKE3SM3cResT
         riBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tAJHzdtoUHBGcl/ayUBAfIA8bNQX6pMqdoZW2RgjLw8=;
        b=tsJMckalhP+voRB8703+UWPJWBJMTLGxSSV4+qRQAuQ1yapgF7GL0UUOtYyXNq74g3
         iE+Wt9PntgEWL0vtLyDk2HknbxPCbH70icVWIjkzYF/ymfSOLd84eFoQQfv6gZTgFW84
         Z4fbIkiKcrXTP5Y+gIGNmVprQ2DvlQB137jw3WSATVQkE8IHbOQQydhbBntNxqNpqqUx
         /ilja7z2Lj5duNJIOOEZpsbU/JQfw1bOFRc9G11Aq3pHk6hMk/mMLLE7/YTfEYp+JI0z
         VnI6N7MdCLAETL81WdvuKlwRcR9/m+WQasV20osWl/1hJ11Ob6eb+YtmueqHe+bYr0Dx
         VXZQ==
X-Gm-Message-State: APjAAAVg1W2dGWwx1jWIjtwTlvXw+0Uuq7xrWBxzIR2l5k+lFZHWg/Ga
        pfrsKXIIROVp1UkJ7Eny7bTizac58ZACsv/pRKg=
X-Google-Smtp-Source: APXvYqxETLRosCoZ7Yw7GzrbRjReXddCRP3sa4I467L9SGwoKgWaLtcI36oqbAY+jJUssD7dP9zolGJjPLweS4I39JM=
X-Received: by 2002:a2e:5b1b:: with SMTP id p27mr7121973ljb.97.1559648789873;
 Tue, 04 Jun 2019 04:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190603174735.21002-1-codekipper@gmail.com> <20190603174735.21002-4-codekipper@gmail.com>
 <CAGb2v65vfQEiXYN6rvdfP6rAvXRVTAnCzxEgpjsJAkDJ16Y+rg@mail.gmail.com>
In-Reply-To: <CAGb2v65vfQEiXYN6rvdfP6rAvXRVTAnCzxEgpjsJAkDJ16Y+rg@mail.gmail.com>
From:   Code Kipper <codekipper@gmail.com>
Date:   Tue, 4 Jun 2019 13:46:17 +0200
Message-ID: <CAEKpxBme2KTNrtb3GpB+UPF5LHbj=iqngu5jrYpFecCZ9d8Whw@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v4 3/9] ASoC: sun4i-i2s: Add regmap field to
 sign extend sample
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@free-electrons.com>,
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

On Tue, 4 Jun 2019 at 09:53, Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Tue, Jun 4, 2019 at 1:47 AM <codekipper@gmail.com> wrote:
> >
> > From: Marcus Cooper <codekipper@gmail.com>
> >
> > On the newer SoCs this is set by default to transfer a 0 after
> > each sample in each slot. However the platform that this driver
> > was developed on had the default setting where it padded the
> > audio gain with zeros. This isn't a problem whilst we have only
> > support for 16bit audio but with larger sample resolution rates
> > in the pipeline then it should be fixed to also pad. Without this
> > the audio gets distorted.
>
> Curious, both the A10 and A20 manuals say the default value for this
> field is 0, which means 0 padding.
>
> sun4i_i2s_reg_defaults[] also has that field set to 0.
>
> You're saying you are seeing the field set to 1?

On the newer SoCs (H3 onwards) this setting defaults to 3 which is
"Transfer 0 after each sample in each slot" which resulted in distortion.
Setting SEXT to 0 "Zeros or audio gain padding at LSB" alligns the
setup with that of the earlier block and fixed the issue we were hearing.
It's really noticeable with HDMI audio.
BR,
CK
>
> ChenYu
>
> > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > ---
> >  sound/soc/sunxi/sun4i-i2s.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> > index fd7c37596f21..e2961d8f6e8c 100644
> > --- a/sound/soc/sunxi/sun4i-i2s.c
> > +++ b/sound/soc/sunxi/sun4i-i2s.c
> > @@ -134,6 +134,7 @@
> >   * @field_fmt_bclk: regmap field to set clk polarity.
> >   * @field_fmt_lrclk: regmap field to set frame polarity.
> >   * @field_fmt_mode: regmap field to set the operational mode.
> > + * @field_fmt_sext: regmap field to set the sign extension.
> >   * @field_txchanmap: location of the tx channel mapping register.
> >   * @field_rxchanmap: location of the rx channel mapping register.
> >   * @field_txchansel: location of the tx channel select bit fields.
> > @@ -159,6 +160,7 @@ struct sun4i_i2s_quirks {
> >         struct reg_field                field_fmt_bclk;
> >         struct reg_field                field_fmt_lrclk;
> >         struct reg_field                field_fmt_mode;
> > +       struct reg_field                field_fmt_sext;
> >         struct reg_field                field_txchanmap;
> >         struct reg_field                field_rxchanmap;
> >         struct reg_field                field_txchansel;
> > @@ -183,6 +185,7 @@ struct sun4i_i2s {
> >         struct regmap_field     *field_fmt_bclk;
> >         struct regmap_field     *field_fmt_lrclk;
> >         struct regmap_field     *field_fmt_mode;
> > +       struct regmap_field     *field_fmt_sext;
> >         struct regmap_field     *field_txchanmap;
> >         struct regmap_field     *field_rxchanmap;
> >         struct regmap_field     *field_txchansel;
> > @@ -342,6 +345,9 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
> >                                    SUN8I_I2S_FMT0_LRCK_PERIOD_MASK,
> >                                    SUN8I_I2S_FMT0_LRCK_PERIOD(32));
> >
> > +       /* Set sign extension to pad out LSB with 0 */
> > +       regmap_field_write(i2s->field_fmt_sext, 0);
> > +
> >         return 0;
> >  }
> >
> > @@ -887,6 +893,7 @@ static const struct sun4i_i2s_quirks sun4i_a10_i2s_quirks = {
> >         .field_fmt_lrclk        = REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
> >         .has_slave_select_bit   = true,
> >         .field_fmt_mode         = REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 1),
> > +       .field_fmt_sext         = REG_FIELD(SUN4I_I2S_FMT1_REG, 8, 8),
> >         .field_txchanmap        = REG_FIELD(SUN4I_I2S_TX_CHAN_MAP_REG, 0, 31),
> >         .field_rxchanmap        = REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
> >         .field_txchansel        = REG_FIELD(SUN4I_I2S_TX_CHAN_SEL_REG, 0, 2),
> > @@ -904,6 +911,7 @@ static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
> >         .field_fmt_lrclk        = REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
> >         .has_slave_select_bit   = true,
> >         .field_fmt_mode         = REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 1),
> > +       .field_fmt_sext         = REG_FIELD(SUN4I_I2S_FMT1_REG, 8, 8),
> >         .field_txchanmap        = REG_FIELD(SUN4I_I2S_TX_CHAN_MAP_REG, 0, 31),
> >         .field_rxchanmap        = REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
> >         .field_txchansel        = REG_FIELD(SUN4I_I2S_TX_CHAN_SEL_REG, 0, 2),
> > @@ -944,6 +952,7 @@ static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
> >         .field_fmt_bclk         = REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
> >         .field_fmt_lrclk        = REG_FIELD(SUN4I_I2S_FMT0_REG, 19, 19),
> >         .field_fmt_mode         = REG_FIELD(SUN4I_I2S_CTRL_REG, 4, 5),
> > +       .field_fmt_sext         = REG_FIELD(SUN4I_I2S_FMT1_REG, 4, 5),
> >         .field_txchanmap        = REG_FIELD(SUN8I_I2S_TX_CHAN_MAP_REG, 0, 31),
> >         .field_rxchanmap        = REG_FIELD(SUN8I_I2S_RX_CHAN_MAP_REG, 0, 31),
> >         .field_txchansel        = REG_FIELD(SUN8I_I2S_TX_CHAN_SEL_REG, 0, 2),
> > @@ -1006,6 +1015,12 @@ static int sun4i_i2s_init_regmap_fields(struct device *dev,
> >         if (IS_ERR(i2s->field_fmt_mode))
> >                 return PTR_ERR(i2s->field_fmt_mode);
> >
> > +       i2s->field_fmt_sext =
> > +                       devm_regmap_field_alloc(dev, i2s->regmap,
> > +                                               i2s->variant->field_fmt_sext);
> > +       if (IS_ERR(i2s->field_fmt_sext))
> > +               return PTR_ERR(i2s->field_fmt_sext);
> > +
> >         i2s->field_txchanmap =
> >                         devm_regmap_field_alloc(dev, i2s->regmap,
> >                                                 i2s->variant->field_txchanmap);
> > --
> > 2.21.0
> >
> > --
> > You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> > To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/20190603174735.21002-4-codekipper%40gmail.com.
> > For more options, visit https://groups.google.com/d/optout.
