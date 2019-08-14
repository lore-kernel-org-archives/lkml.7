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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F93EC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD8FE2063F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkjU82I1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfHNLYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 07:24:42 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42500 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfHNLYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 07:24:42 -0400
Received: by mail-lj1-f195.google.com with SMTP id l14so1771488ljj.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 04:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HUGbXBrBjsmS+Ai2+iPeBZiJZJaEtCScpBr1KbEOROc=;
        b=PkjU82I1Mi3dtcdhxyT5h+6hb39AQ7Nnc5myOYqUYUr53jt48ZbCascD3VQOPe2Smj
         I/9PI6CJfvkk2WhoN0gcrFQoW/LQM79KlXTQH+E+F1QCeDUggRHsl7nX2i9l3S/4MB2k
         OOw7gEQJZVJbWzTrNTaXGt31ef7zKCW5v9CUgEGFask9fTpgdMR0zEbCNF1BIFifTA7U
         xsaHsj8IHNtg+3SfpY/6bYIBAlgFWC1ovm+4vKdPYZ5NQp0OeK5kuO/cIzgqB7W3rFA9
         bFALrkGAmT8rc70l4IPUENm/VIr9YHIIldmT8r4ZTST4D8oF/DzX0+fU6TLOY6Cm3wZ5
         9yFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HUGbXBrBjsmS+Ai2+iPeBZiJZJaEtCScpBr1KbEOROc=;
        b=Zk7rZOzxSq3YEk+9MzZDippu0cBl6H6+ipOrYvnkTuX1OJgbvzLeYTNHkioLwECnE6
         K9CBLFFpMZJDxIo1+Vz03k32SI0KUDRI1D8QIYCNzKzHwrrpDA14NztXkjeuBhMsNJCu
         wmYaA2s3TSyh1bsTsjqYaG0jgnPBZJieX1MrotfhVmoyEj6v1CXr83/sctVR48/We2WZ
         2+LQKfcfdU6a6KGIwFouCLwE0C1iuwkx/aiH/7WOXnReJ6nkG20CcsoCKy8nJITW4Die
         IFsaGPgmTEjrMYNWEkkIowbIsDQDRs4S7rhklJTH2ZjNDl2RLyXHOiI0HFj9V4cb9zcu
         eA6A==
X-Gm-Message-State: APjAAAUinpRpbBVSyTNvHDlCk1dQEIybf187VpJAbUxlIQasTRMTkWO+
        8Tig40efknVC1ATz3CV2V2SmVnudJfF1/iQKSpo=
X-Google-Smtp-Source: APXvYqxgpEOi0jWRp6ACiKPS+q5uwzg9P1kAtJ9h5fBMJgydx1ovY5LAQpvUapPlQtRQlyypTZYcDEFB68Ahw1aBhyo=
X-Received: by 2002:a2e:720c:: with SMTP id n12mr997564ljc.53.1565781877676;
 Wed, 14 Aug 2019 04:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190814060854.26345-1-codekipper@gmail.com> <20190814060854.26345-2-codekipper@gmail.com>
 <20190814064339.lgfngdkiaalygolk@flea>
In-Reply-To: <20190814064339.lgfngdkiaalygolk@flea>
From:   Code Kipper <codekipper@gmail.com>
Date:   Wed, 14 Aug 2019 13:24:26 +0200
Message-ID: <CAEKpxBkDGFUQTZXKUda71P02n2f4eDHJS0D4DdgbQN_JJE10cQ@mail.gmail.com>
Subject: Re: [PATCH v5 01/15] ASoC: sun4i-i2s: Add regmap field to sign extend sample
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
> Hi,
>
> On Wed, Aug 14, 2019 at 08:08:40AM +0200, codekipper@gmail.com wrote:
> > From: Marcus Cooper <codekipper@gmail.com>
> >
> > On the newer SoCs such as the H3 and A64 this is set by default
> > to transfer a 0 after each sample in each slot. However the A10
> > and A20 SoCs that this driver was developed on had a default
> > setting where it padded the audio gain with zeros.
> >
> > This isn't a problem whilst we have only support for 16bit audio
> > but with larger sample resolution rates in the pipeline then SEXT
> > bits should be cleared so that they also pad at the LSB. Without
> > this the audio gets distorted.
> >
> > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > ---
> >  sound/soc/sunxi/sun4i-i2s.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> > index 793457394efe..8201334a059b 100644
> > --- a/sound/soc/sunxi/sun4i-i2s.c
> > +++ b/sound/soc/sunxi/sun4i-i2s.c
> > @@ -135,6 +135,7 @@ struct sun4i_i2s;
> >   * @field_fmt_bclk: regmap field to set clk polarity.
> >   * @field_fmt_lrclk: regmap field to set frame polarity.
> >   * @field_fmt_mode: regmap field to set the operational mode.
> > + * @field_fmt_sext: regmap field to set the sign extension.
> >   * @field_txchanmap: location of the tx channel mapping register.
> >   * @field_rxchanmap: location of the rx channel mapping register.
> >   * @field_txchansel: location of the tx channel select bit fields.
> > @@ -159,6 +160,7 @@ struct sun4i_i2s_quirks {
> >       struct reg_field                field_fmt_bclk;
> >       struct reg_field                field_fmt_lrclk;
> >       struct reg_field                field_fmt_mode;
> > +     struct reg_field                field_fmt_sext;
> >       struct reg_field                field_txchanmap;
> >       struct reg_field                field_rxchanmap;
> >       struct reg_field                field_txchansel;
> > @@ -186,6 +188,7 @@ struct sun4i_i2s {
> >       struct regmap_field     *field_fmt_bclk;
> >       struct regmap_field     *field_fmt_lrclk;
> >       struct regmap_field     *field_fmt_mode;
> > +     struct regmap_field     *field_fmt_sext;
> >       struct regmap_field     *field_txchanmap;
> >       struct regmap_field     *field_rxchanmap;
> >       struct regmap_field     *field_txchansel;
> > @@ -345,6 +348,9 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
> >                                  SUN8I_I2S_FMT0_LRCK_PERIOD_MASK,
> >                                  SUN8I_I2S_FMT0_LRCK_PERIOD(32));
> >
> > +     /* Set sign extension to pad out LSB with 0 */
> > +     regmap_field_write(i2s->field_fmt_sext, 0);
> > +
> >       return 0;
> >  }
> >
> > @@ -917,6 +923,7 @@ static const struct sun4i_i2s_quirks sun4i_a10_i2s_quirks = {
> >       .field_fmt_lrclk        = REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
> >       .has_slave_select_bit   = true,
> >       .field_fmt_mode         = REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 1),
> > +     .field_fmt_sext         = REG_FIELD(SUN4I_I2S_FMT1_REG, 8, 8),
> >       .field_txchanmap        = REG_FIELD(SUN4I_I2S_TX_CHAN_MAP_REG, 0, 31),
> >       .field_rxchanmap        = REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
> >       .field_txchansel        = REG_FIELD(SUN4I_I2S_TX_CHAN_SEL_REG, 0, 2),
> > @@ -936,6 +943,7 @@ static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
> >       .field_fmt_lrclk        = REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
> >       .has_slave_select_bit   = true,
> >       .field_fmt_mode         = REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 1),
> > +     .field_fmt_sext         = REG_FIELD(SUN4I_I2S_FMT1_REG, 8, 8),
> >       .field_txchanmap        = REG_FIELD(SUN4I_I2S_TX_CHAN_MAP_REG, 0, 31),
> >       .field_rxchanmap        = REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
> >       .field_txchansel        = REG_FIELD(SUN4I_I2S_TX_CHAN_SEL_REG, 0, 2),
> > @@ -979,6 +987,7 @@ static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
> >       .field_fmt_bclk         = REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
> >       .field_fmt_lrclk        = REG_FIELD(SUN4I_I2S_FMT0_REG, 19, 19),
> >       .field_fmt_mode         = REG_FIELD(SUN4I_I2S_CTRL_REG, 4, 5),
> > +     .field_fmt_sext         = REG_FIELD(SUN4I_I2S_FMT1_REG, 4, 5),
> >       .field_txchanmap        = REG_FIELD(SUN8I_I2S_TX_CHAN_MAP_REG, 0, 31),
> >       .field_rxchanmap        = REG_FIELD(SUN8I_I2S_RX_CHAN_MAP_REG, 0, 31),
> >       .field_txchansel        = REG_FIELD(SUN8I_I2S_TX_CHAN_SEL_REG, 0, 2),
> > @@ -998,6 +1007,7 @@ static const struct sun4i_i2s_quirks sun50i_a64_codec_i2s_quirks = {
> >       .field_fmt_bclk         = REG_FIELD(SUN4I_I2S_FMT0_REG, 6, 6),
> >       .field_fmt_lrclk        = REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
> >       .field_fmt_mode         = REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 1),
> > +     .field_fmt_sext         = REG_FIELD(SUN4I_I2S_FMT1_REG, 8, 8),
> >       .field_txchanmap        = REG_FIELD(SUN4I_I2S_TX_CHAN_MAP_REG, 0, 31),
> >       .field_rxchanmap        = REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
> >       .field_txchansel        = REG_FIELD(SUN4I_I2S_TX_CHAN_SEL_REG, 0, 2),
>
> You're missing the A83t here

ARRGGGHHHHH...ACK...thanks,
CK
>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
