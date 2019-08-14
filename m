Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2A0C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 09:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5162205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 09:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W96oK3cp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfHNJDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 05:03:08 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39135 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfHNJDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 05:03:08 -0400
Received: by mail-lj1-f195.google.com with SMTP id x4so11961847ljj.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 02:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HGGsA7jJbuHeLKCTTStxYTVLGBd6wnCss83qHowgbjU=;
        b=W96oK3cplk+LETGgfrUx025DuWIVN07yy7YAIfAoynHMDXa6+xVaV/sYZjvar/1zKv
         XFAzJLyCpaXbHaI0Jj7zDzkRdxJ9/+ygX+T0rBz87g8xxWGYlIkKq2NYMFeVDw01G0yI
         GtiPNL8KjexuBM4mZ/qYmpZhQdRnXw7yFImlxTSJC9eRa/u2mQSnfcyFBtPfu/PFh+wO
         9aBxFRZnTIvpV4ukI+9FPT1Xpjn66WdT7Ht3WpXpkcscVYLynKrBWSVpNMMU6H4T9EP9
         2Hy1ufq+tqognp6wU0Z6Y9XMYtJB+zBv4k8uPklw2vIhTD6XRwUS2gkgak2pKssb7fQ0
         BZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HGGsA7jJbuHeLKCTTStxYTVLGBd6wnCss83qHowgbjU=;
        b=K9RG6TxkDVhBTagsc3WaB2W7kzbU9NVNxQPY7ih9OBjoli63t4MukEi89j0wYKaJdV
         3LawRWcg2P+1df7hw7LdiSpsYQCxbVOs/0AV4Oar6szSLAKqqF5by176QQ119Jsz1z1n
         DQiudm4O8kaW1jZRdeXWGM3gmUFsO1rcAI8TRo9tBr2QCR4EDDPiDbcv+2N3F4IRf/tg
         j7EMwXRkZzLAGRLxBFVy58VhJ4zDioIAO1L8pBxNTcLuSqx7bHVlFG77Jrv9xk87WMvR
         7EPew5H3zabMTKPHfkDJDWYxdKwAaThj87GyCWQmkroEt52l/YXIyn72hxwywQcEc6Tc
         pMzw==
X-Gm-Message-State: APjAAAWGg6JWF0gbhGGiHhn2Us34JfphVoxnyOW3jJWp3jRrfcBtIlNx
        TXHLpFRmPcRabPxoq2N+yh6Nehl0QP870JoiN4ATjA==
X-Google-Smtp-Source: APXvYqyW1xPosjpGG4nDcVQ4sN08u61lmr1tOzbLSoAlD3n5ZJrmw1nQj2fpjXRQgr8vSPVXMkST0bIshq4hM+ESxOg=
X-Received: by 2002:a2e:3c12:: with SMTP id j18mr8727511lja.50.1565773385844;
 Wed, 14 Aug 2019 02:03:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190814060854.26345-1-codekipper@gmail.com> <20190814060854.26345-16-codekipper@gmail.com>
 <3741744.8c7tOhJ1tT@jernej-laptop>
In-Reply-To: <3741744.8c7tOhJ1tT@jernej-laptop>
From:   Code Kipper <codekipper@gmail.com>
Date:   Wed, 14 Aug 2019 11:02:54 +0200
Message-ID: <CAEKpxBnNzH3KANfaY7p0qv=XTAyHAk3YSWqFbt_hpWat+xSBxw@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v5 15/15] ASoC: sun4i-i2s: Adjust regmap settings
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     linux-sunxi <linux-sunxi@googlegroups.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
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

On Wed, 14 Aug 2019 at 10:38, Jernej =C5=A0krabec <jernej.skrabec@gmail.com=
> wrote:
>
> Hi!
>
> Dne sreda, 14. avgust 2019 ob 08:08:54 CEST je codekipper@gmail.com
> napisal(a):
> > From: Marcus Cooper <codekipper@gmail.com>
> >
> > Bypass the regmap cache when flushing the i2s FIFOs and modify the tabl=
es
> > to reflect this.
> >
> > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > ---
> >  sound/soc/sunxi/sun4i-i2s.c | 31 ++++++++++---------------------
> >  1 file changed, 10 insertions(+), 21 deletions(-)
> >
> > diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> > index d3c8789f70bb..ecfc1ed79379 100644
> > --- a/sound/soc/sunxi/sun4i-i2s.c
> > +++ b/sound/soc/sunxi/sun4i-i2s.c
> > @@ -876,9 +876,11 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *d=
ai,
> > unsigned int fmt) static void sun4i_i2s_start_capture(struct sun4i_i2s
> > *i2s)
> >  {
> >       /* Flush RX FIFO */
> > +     regcache_cache_bypass(i2s->regmap, true);
> >       regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
> >                          SUN4I_I2S_FIFO_CTRL_FLUSH_RX,
> >                          SUN4I_I2S_FIFO_CTRL_FLUSH_RX);
> > +     regcache_cache_bypass(i2s->regmap, false);
>
> Did you try with regmap_write_bits() instead? This function will
> unconditionally write bits so it's nicer solution, because you don't have=
 to
> use regcache_cache_bypass().

I didn't....with all the rework I've avoided messing with this change.
Now that the dust
has settled, I can go back to look at this.
Thanks,
CK
>
> >
> >       /* Clear RX counter */
> >       regmap_write(i2s->regmap, SUN4I_I2S_RX_CNT_REG, 0);
> > @@ -897,9 +899,11 @@ static void sun4i_i2s_start_capture(struct sun4i_i=
2s
> > *i2s) static void sun4i_i2s_start_playback(struct sun4i_i2s *i2s)
> >  {
> >       /* Flush TX FIFO */
> > +     regcache_cache_bypass(i2s->regmap, true);
> >       regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
> >                          SUN4I_I2S_FIFO_CTRL_FLUSH_TX,
> >                          SUN4I_I2S_FIFO_CTRL_FLUSH_TX);
> > +     regcache_cache_bypass(i2s->regmap, false);
>
> Ditto.
>
> >
> >       /* Clear TX counter */
> >       regmap_write(i2s->regmap, SUN4I_I2S_TX_CNT_REG, 0);
> > @@ -1053,13 +1057,7 @@ static const struct snd_soc_component_driver
> > sun4i_i2s_component =3D {
> >
> >  static bool sun4i_i2s_rd_reg(struct device *dev, unsigned int reg)
> >  {
> > -     switch (reg) {
> > -     case SUN4I_I2S_FIFO_TX_REG:
> > -             return false;
> > -
> > -     default:
> > -             return true;
> > -     }
> > +     return true;
>
> Why did you change this? Manual mentions that SUN4I_I2S_FIFO_TX_REG is wr=
ite-
> only register. Even if it can be read, then it's better to remove whole
> function, which will automatically mean that all registers can be read.
>
>
> >  }
> >
> >  static bool sun4i_i2s_wr_reg(struct device *dev, unsigned int reg)
> > @@ -1078,6 +1076,8 @@ static bool sun4i_i2s_volatile_reg(struct device =
*dev,
> > unsigned int reg) {
> >       switch (reg) {
> >       case SUN4I_I2S_FIFO_RX_REG:
> > +     case SUN4I_I2S_FIFO_TX_REG:
> > +     case SUN4I_I2S_FIFO_STA_REG:
> >       case SUN4I_I2S_INT_STA_REG:
> >       case SUN4I_I2S_RX_CNT_REG:
> >       case SUN4I_I2S_TX_CNT_REG:
>
> SUN4I_I2S_FIFO_CTRL_REG should be put here, because it has two bits which
> returns to 0 immediately after they are set to 1.
>
> Best regards,
> Jernej
>
> > @@ -1088,23 +1088,12 @@ static bool sun4i_i2s_volatile_reg(struct devic=
e
> > *dev, unsigned int reg) }
> >  }
> >
> > -static bool sun8i_i2s_rd_reg(struct device *dev, unsigned int reg)
> > -{
> > -     switch (reg) {
> > -     case SUN8I_I2S_FIFO_TX_REG:
> > -             return false;
> > -
> > -     default:
> > -             return true;
> > -     }
> > -}
> > -
> >  static bool sun8i_i2s_volatile_reg(struct device *dev, unsigned int re=
g)
> >  {
> >       if (reg =3D=3D SUN8I_I2S_INT_STA_REG)
> >               return true;
> >       if (reg =3D=3D SUN8I_I2S_FIFO_TX_REG)
> > -             return false;
> > +             return true;
> >
> >       return sun4i_i2s_volatile_reg(dev, reg);
> >  }
> > @@ -1175,7 +1164,7 @@ static const struct regmap_config
> > sun8i_i2s_regmap_config =3D { .reg_defaults     =3D sun8i_i2s_reg_defau=
lts,
> >       .num_reg_defaults       =3D ARRAY_SIZE(sun8i_i2s_reg_defaults),
> >       .writeable_reg  =3D sun4i_i2s_wr_reg,
> > -     .readable_reg   =3D sun8i_i2s_rd_reg,
> > +     .readable_reg   =3D sun4i_i2s_rd_reg,
> >       .volatile_reg   =3D sun8i_i2s_volatile_reg,
> >  };
> >
> > @@ -1188,7 +1177,7 @@ static const struct regmap_config
> > sun50i_i2s_regmap_config =3D { .reg_defaults    =3D sun50i_i2s_reg_defa=
ults,
> >       .num_reg_defaults       =3D ARRAY_SIZE(sun50i_i2s_reg_defaults),
> >       .writeable_reg  =3D sun4i_i2s_wr_reg,
> > -     .readable_reg   =3D sun8i_i2s_rd_reg,
> > +     .readable_reg   =3D sun4i_i2s_rd_reg,
> >       .volatile_reg   =3D sun8i_i2s_volatile_reg,
> >  };
>
>
>
>
