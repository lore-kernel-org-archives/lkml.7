Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B8DC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 09:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672B12084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 09:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q//okcr2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfHNJDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 05:03:53 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41178 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfHNJDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 05:03:53 -0400
Received: by mail-lj1-f194.google.com with SMTP id m24so1649002ljg.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 02:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GeeM10QL+PlKdTTdajiUgNYKAysRWONknFw7/BXOzz8=;
        b=Q//okcr2qvIkPG7ZD9aY3pbMgMVby5WdUQloYY1Xo43qDpVOucUGR0elIoYXwKkL9j
         8Yktm6lev1ny9/U/0FYHfCO/3YeyggCJJzF/4LZfk1HfL3nk6YnK4StBEiSyCzyl3bGh
         cDj3CSfET2Z0euj5yT286HsXxwzXvdcRjXdJyCIKQ/lh+bM+Rj3onYGoqU3ZsQGka74/
         UqY4mCmgxQGxA7UavNxwPWkP38MG7iQkcoF4K1WvL3s2HogOD4zwT6f2ZKZMLZAkISIs
         2nl0+9XRC+noMVbCpLsadUjWuCYTIAYTcpwLDMS23T5ypWwzcTE7KlIfHoTdqxJW4gsF
         gLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GeeM10QL+PlKdTTdajiUgNYKAysRWONknFw7/BXOzz8=;
        b=jHPcFgXhvtmMmaa5hBkCCL7bdPXw4i8PUpquz9dx/r1DzZ1XBYGkcc2Vv+Tqqv6MMs
         7QifJy9eFnSzZMPrwjehx5RU2HUhftjCpoA+jpJ3X7ctiEp8s25mnSQ4GunHBxetU+Xz
         dvFdF2FLAj2gRR+GkODFjptKXdjNwI8286aseJxG1Ep4UQQOO3JVFhmTpsUZfnp3Z0Li
         cDksC2/hiiifMV4Wp+oyJKWYxRAGGV/X49Rp0YD8wKaz3T+o3vjheZ8D3Ap80DWZ40dI
         leXhuRmx+5DgQPn2e7dY9STxaDSHWcGJFrmkn+QGPecuBEwPb5WKgs/XznGdNHQMWz6P
         Whtg==
X-Gm-Message-State: APjAAAUlrHua8Iw+FLNzRAlFkI2JROBG+oGU+gYg6o1CoSr5RIDCPF2H
        +hhJ0BmSfGY+SvLjMu3j513HO/s8f6Vy54EaGnc=
X-Google-Smtp-Source: APXvYqxZs4VpjO4Q/Y9NDFC8T6oU4FSnVEUWvGpuAB/Ra4r8IZP549jer0SM/xv1p3Gtrkbn3Q4Bb+PJb1sRPXpCRv8=
X-Received: by 2002:a2e:720c:: with SMTP id n12mr656662ljc.53.1565773430959;
 Wed, 14 Aug 2019 02:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190814060854.26345-1-codekipper@gmail.com> <20190814060854.26345-15-codekipper@gmail.com>
 <4297791.2mJM636zur@jernej-laptop>
In-Reply-To: <4297791.2mJM636zur@jernej-laptop>
From:   Code Kipper <codekipper@gmail.com>
Date:   Wed, 14 Aug 2019 11:03:39 +0200
Message-ID: <CAEKpxBmsLKt_mKFC3=wR9n+hK9njhh7drLV2EMrzKahv=s4dTw@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v5 14/15] ASoc: sun4i-i2s: Add 20, 24 and 32
 bit support
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

On Wed, 14 Aug 2019 at 10:28, Jernej =C5=A0krabec <jernej.skrabec@gmail.com=
> wrote:
>
> Hi!
>
> Dne sreda, 14. avgust 2019 ob 08:08:53 CEST je codekipper@gmail.com
> napisal(a):
> > From: Marcus Cooper <codekipper@gmail.com>
> >
> > Extend the functionality of the driver to include support of 20 and
> > 24 bits per sample for the earlier SoCs.
> >
> > Newer SoCs can also handle 32bit samples.
> >
> > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > ---
> >  sound/soc/sunxi/sun4i-i2s.c | 21 +++++++++++++++++++--
> >  1 file changed, 19 insertions(+), 2 deletions(-)
> >
> > diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> > index a71969167053..d3c8789f70bb 100644
> > --- a/sound/soc/sunxi/sun4i-i2s.c
> > +++ b/sound/soc/sunxi/sun4i-i2s.c
> > @@ -690,6 +690,11 @@ static int sun4i_i2s_hw_params(struct snd_pcm_subs=
tream
> > *substream, case 16:
> >               width =3D DMA_SLAVE_BUSWIDTH_2_BYTES;
> >               break;
> > +     case 20:
> > +     case 24:
> > +     case 32:
>
> params_physical_width() returns 32 also for 20 and 24-bit formats, so dro=
p 20
> and 24.
ACK
>
> Best regards,
> Jernej
>
> > +             width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
> > +             break;
> >       default:
> >               dev_err(dai->dev, "Unsupported physical sample width:
> %d\n",
> >                       params_physical_width(params));
> > @@ -1015,6 +1020,13 @@ static int sun4i_i2s_dai_probe(struct snd_soc_da=
i
> > *dai) return 0;
> >  }
> >
> > +#define SUN4I_FORMATS        (SNDRV_PCM_FMTBIT_S16_LE | \
> > +                      SNDRV_PCM_FMTBIT_S20_LE | \
> > +                      SNDRV_PCM_FMTBIT_S24_LE)
> > +
> > +#define SUN8I_FORMATS        (SUN4I_FORMATS | \
> > +                      SNDRV_PCM_FMTBIT_S32_LE)
> > +
> >  static struct snd_soc_dai_driver sun4i_i2s_dai =3D {
> >       .probe =3D sun4i_i2s_dai_probe,
> >       .capture =3D {
> > @@ -1022,14 +1034,14 @@ static struct snd_soc_dai_driver sun4i_i2s_dai =
=3D {
> >               .channels_min =3D 2,
> >               .channels_max =3D 2,
> >               .rates =3D SNDRV_PCM_RATE_8000_192000,
> > -             .formats =3D SNDRV_PCM_FMTBIT_S16_LE,
> > +             .formats =3D SUN4I_FORMATS,
> >       },
> >       .playback =3D {
> >               .stream_name =3D "Playback",
> >               .channels_min =3D 2,
> >               .channels_max =3D 2,
> >               .rates =3D SNDRV_PCM_RATE_8000_192000,
> > -             .formats =3D SNDRV_PCM_FMTBIT_S16_LE,
> > +             .formats =3D SUN4I_FORMATS,
> >       },
> >       .ops =3D &sun4i_i2s_dai_ops,
> >       .symmetric_rates =3D 1,
> > @@ -1505,6 +1517,11 @@ static int sun4i_i2s_probe(struct platform_devic=
e
> > *pdev) goto err_pm_disable;
> >       }
> >
> > +     if (i2s->variant->has_fmt_set_lrck_period) {
> > +             soc_dai->playback.formats =3D SUN8I_FORMATS;
> > +             soc_dai->capture.formats =3D SUN8I_FORMATS;
> > +     }
> > +
> >       if (!of_property_read_u32(pdev->dev.of_node,
> >                                 "allwinner,playback-channels",
> &val)) {
> >               if (val >=3D 2 && val <=3D 8)
>
>
>
>
