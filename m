Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D674FC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 06:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A050E2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 06:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDQS3E3w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfHPG1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 02:27:18 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42625 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfHPG1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 02:27:18 -0400
Received: by mail-lf1-f65.google.com with SMTP id s19so3295346lfb.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 23:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+lm26ypr1HFcyJ7hZ74u9revSRfSoVfoTCtYpt3Woco=;
        b=GDQS3E3wgsOcpEmUdh/7FrM+PIwG363gn6bd/2WcIDTYecvOS6uKIzzZah8q/y++LL
         JAPEsMUEGYHVt/cJCJ5RH4/KRZVEZ5zHs1HjqBD4Lh8P+yeCfaGzm/qZNWcwRr5klPFP
         gXkGm26epRrNG7drbO05XPe6GKCVNb2zU9wlzDMI/y2bi0BCxZvj4P4PKKQO/e4Yq1cj
         PL/z1F1uN+BlT8QbNG3TZ35AKbl35qDVdizIf6yQ8DE5/3XDtXBHeQ/NulYnxZt288Su
         +3D9HTDceHmk6mPD/4ZZXrjPfd/p2H5DtdIGAfhXjLoiv0yPkL3TGoclyQgG0hDjF5l7
         6lbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+lm26ypr1HFcyJ7hZ74u9revSRfSoVfoTCtYpt3Woco=;
        b=sEDfMb9znplQ6VI2PWaRRoNCWPuu+fdT2T+cimKNFK7W0GQ/2h1ZljVauUX2aJKYTU
         HeJA2Cyzgy1Ps3sZTaHK5UmAEEqZ/WxYEnFlVftUi0iU2xPoM71nl4h0PyCoFDGE+gjs
         YtczgXCkZaU67XrBq/7GcE27m57u5DRB0goPWzjdfMItYTBD59LWniCagYGBB1wAeFA6
         SzBVXHxDHf1sfQWBMQM7QtvAhqGuWe77fpl2eyUHUgmQJ0YHH4lcQsQkmCcArw8X8cO2
         Wt4kbw7T/bndE1JLlh/uDiTNRbegQJvDUd5leiu2KpMCxqIfS2vwWQ/m7Gxj86lM/mva
         0S5w==
X-Gm-Message-State: APjAAAWY7Tkx4TAdqoFhT21Dt2jkvhP7pw4oqyEDFeOYEUagTNrE2SZF
        rCKhYvMb18WzbWjXqiUiaMPke3fntSD1LOiXXc8=
X-Google-Smtp-Source: APXvYqw/pzogfFsM3txv21J7mmVAMuAg5bLpt1moRRMwMAytRKI/2ywz6QY1qaZduB8tnnRHj850nAkh/ETZxUwIOXg=
X-Received: by 2002:ac2:465e:: with SMTP id s30mr4431231lfo.19.1565936836466;
 Thu, 15 Aug 2019 23:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190814060854.26345-1-codekipper@gmail.com> <20190814060854.26345-3-codekipper@gmail.com>
 <20190814070923.wwkw7hybjvy3p4br@flea>
In-Reply-To: <20190814070923.wwkw7hybjvy3p4br@flea>
From:   Code Kipper <codekipper@gmail.com>
Date:   Fri, 16 Aug 2019 08:27:05 +0200
Message-ID: <CAEKpxBkOu0+zek9f=4grNEhyPS=Ly3nweCUCgaz6y8M61xvpaQ@mail.gmail.com>
Subject: Re: [PATCH v5 02/15] ASoC: sun4i-i2s: Add set_tdm_slot functionality
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
> On Wed, Aug 14, 2019 at 08:08:41AM +0200, codekipper@gmail.com wrote:
> > From: Marcus Cooper <codekipper@gmail.com>
> >
> > Codecs without a control connection such as i2s based HDMI audio and
> > the Pine64 DAC require a different amount of bit clocks per frame than
> > what is calculated by the sample width. Use the tdm slot bindings to
> > provide this mechanism.
> >
> > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > ---
> >  sound/soc/sunxi/sun4i-i2s.c | 23 +++++++++++++++++++++--
> >  1 file changed, 21 insertions(+), 2 deletions(-)
> >
> > diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> > index 8201334a059b..7c37b6291df0 100644
> > --- a/sound/soc/sunxi/sun4i-i2s.c
> > +++ b/sound/soc/sunxi/sun4i-i2s.c
> > @@ -195,6 +195,9 @@ struct sun4i_i2s {
> >       struct regmap_field     *field_rxchansel;
> >
> >       const struct sun4i_i2s_quirks   *variant;
> > +
> > +     unsigned int    tdm_slots;
> > +     unsigned int    slot_width;
> >  };
> >
> >  struct sun4i_i2s_clk_div {
> > @@ -346,7 +349,7 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
> >       if (i2s->variant->has_fmt_set_lrck_period)
> >               regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
> >                                  SUN8I_I2S_FMT0_LRCK_PERIOD_MASK,
> > -                                SUN8I_I2S_FMT0_LRCK_PERIOD(32));
> > +                                SUN8I_I2S_FMT0_LRCK_PERIOD(word_size));
> >
> >
> >       /* Set sign extension to pad out LSB with 0 */
> >       regmap_field_write(i2s->field_fmt_sext, 0);
> > @@ -450,7 +453,8 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
> >       regmap_field_write(i2s->field_fmt_sr, sr);
> >
> >       return sun4i_i2s_set_clk_rate(dai, params_rate(params),
> > -                                   params_width(params));
> > +                                   i2s->tdm_slots ?
> > +                                   i2s->slot_width : params_width(params));
>
> This is slightly more complicated than that.

At this point we're only supporting 2 channels with fixed slot
settings. I've added a comment to state
that we're using the tdm_slot at the moment as an indicator to
override the slot width. Do you think
that is enough for now?.

Thanks,
CK
>
> On the H3 (and all related ones), the CHAN_CFG_TX_SLOT_NUM and
> _RX_SLOT_NUM fields in the CHAN_CFG register need to be set to the
> number of slots as well.
>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
