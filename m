Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7B3C28CC3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C6924B47
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfFDHyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 03:54:01 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34192 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfFDHyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:54:00 -0400
Received: by mail-ed1-f66.google.com with SMTP id c26so20498495edt.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 00:53:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aB9PHKPiyzkndYybRF10NmFg3rVLDNHgbfKcERc7zQk=;
        b=NxypKmpUE9nFsNzIRcplDL8fVYJ9DY7/jU8kiui47QwF76xiHAl460hUv6xGGxMBaG
         ohClMqN1e6EArOlvzD7VzdjyVI/JkA/lINOtsYCqK7BH7W9qLIG2JhKvo71IpunucESK
         +pmjtjbJPtMhh+KGnXVkhvBhZGtUa81W9+GJvbFeAvdYfjLZYdh550lY1ii2SsKqh3ib
         f/Uj5yzkxOWP3HEEWvOsLjVyZXa26NyNSYpWZmz8y4YUWPxI15epf2TRL3k0bDZt7kVK
         67eOv2S1fFFTBwd5SWshHaeKtqj+kT5hKXv54twtp5itAY4Bkg3KW6BURI4/A30Rb2xx
         V36w==
X-Gm-Message-State: APjAAAW+HSqDRTWfhzckgYj8wPlM4lFAYYsnxvysBIap8WoV0ZBiF76J
        LaHAnx3XaREolBPo4+JAMuyomVf5C+U=
X-Google-Smtp-Source: APXvYqwTGaGuZb4qur4IgYT4AUCZcrfpEXDcT//7kgh3ctJYorQNU5JS0Rqi9G14p74K1X6oP96gAA==
X-Received: by 2002:a17:907:20d0:: with SMTP id qq16mr16730581ejb.244.1559634838031;
        Tue, 04 Jun 2019 00:53:58 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id i45sm4678921eda.67.2019.06.04.00.53.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 00:53:57 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id g135so10548876wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 00:53:56 -0700 (PDT)
X-Received: by 2002:a1c:3942:: with SMTP id g63mr15671103wma.61.1559634836417;
 Tue, 04 Jun 2019 00:53:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190603174735.21002-1-codekipper@gmail.com> <20190603174735.21002-4-codekipper@gmail.com>
In-Reply-To: <20190603174735.21002-4-codekipper@gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 4 Jun 2019 15:53:46 +0800
X-Gmail-Original-Message-ID: <CAGb2v65vfQEiXYN6rvdfP6rAvXRVTAnCzxEgpjsJAkDJ16Y+rg@mail.gmail.com>
Message-ID: <CAGb2v65vfQEiXYN6rvdfP6rAvXRVTAnCzxEgpjsJAkDJ16Y+rg@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v4 3/9] ASoC: sun4i-i2s: Add regmap field to
 sign extend sample
To:     Code Kipper <codekipper@gmail.com>
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

On Tue, Jun 4, 2019 at 1:47 AM <codekipper@gmail.com> wrote:
>
> From: Marcus Cooper <codekipper@gmail.com>
>
> On the newer SoCs this is set by default to transfer a 0 after
> each sample in each slot. However the platform that this driver
> was developed on had the default setting where it padded the
> audio gain with zeros. This isn't a problem whilst we have only
> support for 16bit audio but with larger sample resolution rates
> in the pipeline then it should be fixed to also pad. Without this
> the audio gets distorted.

Curious, both the A10 and A20 manuals say the default value for this
field is 0, which means 0 padding.

sun4i_i2s_reg_defaults[] also has that field set to 0.

You're saying you are seeing the field set to 1?

ChenYu

> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index fd7c37596f21..e2961d8f6e8c 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -134,6 +134,7 @@
>   * @field_fmt_bclk: regmap field to set clk polarity.
>   * @field_fmt_lrclk: regmap field to set frame polarity.
>   * @field_fmt_mode: regmap field to set the operational mode.
> + * @field_fmt_sext: regmap field to set the sign extension.
>   * @field_txchanmap: location of the tx channel mapping register.
>   * @field_rxchanmap: location of the rx channel mapping register.
>   * @field_txchansel: location of the tx channel select bit fields.
> @@ -159,6 +160,7 @@ struct sun4i_i2s_quirks {
>         struct reg_field                field_fmt_bclk;
>         struct reg_field                field_fmt_lrclk;
>         struct reg_field                field_fmt_mode;
> +       struct reg_field                field_fmt_sext;
>         struct reg_field                field_txchanmap;
>         struct reg_field                field_rxchanmap;
>         struct reg_field                field_txchansel;
> @@ -183,6 +185,7 @@ struct sun4i_i2s {
>         struct regmap_field     *field_fmt_bclk;
>         struct regmap_field     *field_fmt_lrclk;
>         struct regmap_field     *field_fmt_mode;
> +       struct regmap_field     *field_fmt_sext;
>         struct regmap_field     *field_txchanmap;
>         struct regmap_field     *field_rxchanmap;
>         struct regmap_field     *field_txchansel;
> @@ -342,6 +345,9 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
>                                    SUN8I_I2S_FMT0_LRCK_PERIOD_MASK,
>                                    SUN8I_I2S_FMT0_LRCK_PERIOD(32));
>
> +       /* Set sign extension to pad out LSB with 0 */
> +       regmap_field_write(i2s->field_fmt_sext, 0);
> +
>         return 0;
>  }
>
> @@ -887,6 +893,7 @@ static const struct sun4i_i2s_quirks sun4i_a10_i2s_quirks = {
>         .field_fmt_lrclk        = REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
>         .has_slave_select_bit   = true,
>         .field_fmt_mode         = REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 1),
> +       .field_fmt_sext         = REG_FIELD(SUN4I_I2S_FMT1_REG, 8, 8),
>         .field_txchanmap        = REG_FIELD(SUN4I_I2S_TX_CHAN_MAP_REG, 0, 31),
>         .field_rxchanmap        = REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
>         .field_txchansel        = REG_FIELD(SUN4I_I2S_TX_CHAN_SEL_REG, 0, 2),
> @@ -904,6 +911,7 @@ static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
>         .field_fmt_lrclk        = REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
>         .has_slave_select_bit   = true,
>         .field_fmt_mode         = REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 1),
> +       .field_fmt_sext         = REG_FIELD(SUN4I_I2S_FMT1_REG, 8, 8),
>         .field_txchanmap        = REG_FIELD(SUN4I_I2S_TX_CHAN_MAP_REG, 0, 31),
>         .field_rxchanmap        = REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
>         .field_txchansel        = REG_FIELD(SUN4I_I2S_TX_CHAN_SEL_REG, 0, 2),
> @@ -944,6 +952,7 @@ static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
>         .field_fmt_bclk         = REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
>         .field_fmt_lrclk        = REG_FIELD(SUN4I_I2S_FMT0_REG, 19, 19),
>         .field_fmt_mode         = REG_FIELD(SUN4I_I2S_CTRL_REG, 4, 5),
> +       .field_fmt_sext         = REG_FIELD(SUN4I_I2S_FMT1_REG, 4, 5),
>         .field_txchanmap        = REG_FIELD(SUN8I_I2S_TX_CHAN_MAP_REG, 0, 31),
>         .field_rxchanmap        = REG_FIELD(SUN8I_I2S_RX_CHAN_MAP_REG, 0, 31),
>         .field_txchansel        = REG_FIELD(SUN8I_I2S_TX_CHAN_SEL_REG, 0, 2),
> @@ -1006,6 +1015,12 @@ static int sun4i_i2s_init_regmap_fields(struct device *dev,
>         if (IS_ERR(i2s->field_fmt_mode))
>                 return PTR_ERR(i2s->field_fmt_mode);
>
> +       i2s->field_fmt_sext =
> +                       devm_regmap_field_alloc(dev, i2s->regmap,
> +                                               i2s->variant->field_fmt_sext);
> +       if (IS_ERR(i2s->field_fmt_sext))
> +               return PTR_ERR(i2s->field_fmt_sext);
> +
>         i2s->field_txchanmap =
>                         devm_regmap_field_alloc(dev, i2s->regmap,
>                                                 i2s->variant->field_txchanmap);
> --
> 2.21.0
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/20190603174735.21002-4-codekipper%40gmail.com.
> For more options, visit https://groups.google.com/d/optout.
