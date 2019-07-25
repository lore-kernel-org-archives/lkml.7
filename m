Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1426C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B5C22C7B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oyGpE2Md"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387787AbfGYMbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 08:31:37 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40118 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbfGYMbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 08:31:36 -0400
Received: by mail-qk1-f194.google.com with SMTP id s145so36244089qke.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 05:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3vOhJr4R9IHXs2ns1CQPNi9tups8zk+9lQf/RJAnA0w=;
        b=oyGpE2Mdzy7CUufchd8ehSD43VuTFwk8fz2D/ftoUm+otR7MhqugXIeS0KEE3Y2HvZ
         y8Ur6mOC9Ux+nbHqhK5HwulszZ7kC9jZe+6ctmJpl83GjOrr6ngsFAHfCtnmeBr30L9i
         HIbouEFLFnWjGWiYVh6RcUsSKFNhhscC1Wv2Skt+AT2xCaBZvNr2Mc4Xfl3f8FMy+axk
         Ytx39Mgh9a3bzcryxeAEPDFMahDuRnO6Q6lhJFoOVQko81LaCcchwFiwLFJ23i6LJ/7H
         yCrbyaIRSyTEFGh7IY+eROAyPHPH2hjL8Bv2PSRyfDdwYUnlUwqmBnvxtmSclgsHCCd+
         fPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3vOhJr4R9IHXs2ns1CQPNi9tups8zk+9lQf/RJAnA0w=;
        b=fBUKK4arkG6WfaWCL8fj3uEPAXE6RxchVjK+JiTgzqL8pQg+xxiJPSFnWFik59Zt2j
         TZy5arb8qEV1sFu5U6gGkWcLJEE+NlYe+RrxTyadY/mDgAK6zIFo/WWxSp0mAZjmN/Gv
         Qetjpwl5pjsV0jHvcPDFw/0bJT2stPo7CPNc8Hq7hyTr5m8Ae6el1M5JH28k327N63ro
         4lKPmAqRdZPkLJ4AXClW1y15qSxcGjcHHG4ClZlpFO6q7B8LzWu9I2GuDBfrIIHJ1Tfb
         xX4mEN9H8URR1a7JnDOchhMWKB4725/rRLLGXfj86bqosQTNZLbMzlKXAO9ylT+CQ6GA
         rS8w==
X-Gm-Message-State: APjAAAVVplPYlGYrc/FjOZGK5FktbZxL0XmStKATk3jeHWDhazzC11Rp
        8PzdyMJ/tp5+WbJfVIFV9Dy+rKdqR/tIKRUf/JMvYQ==
X-Google-Smtp-Source: APXvYqzw0OOD7qxJ+qp3p00p/2GWwD3VFv4Bn031dtzHiYXsJAGBNbun3scyLD1DLCPkYYTMixPKN3qbD+BIOKe+yV4=
X-Received: by 2002:a05:620a:1286:: with SMTP id w6mr56787652qki.219.1564057895419;
 Thu, 25 Jul 2019 05:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <1562141052-26221-1-git-send-email-olivier.moysan@st.com> <129ffc9a-0bfc-354e-c4a1-9043260832c0@ti.com>
In-Reply-To: <129ffc9a-0bfc-354e-c4a1-9043260832c0@ti.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Thu, 25 Jul 2019 14:31:24 +0200
Message-ID: <CA+M3ks6H4OC0SUUj=34OxCq-chA-W_YxO_xs_0hkJAuxQv12JQ@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: sii902x: add audio graph card support
To:     Jyri Sarha <jsarha@ti.com>
Cc:     Olivier Moysan <olivier.moysan@st.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>, jernej.skrabec@siol.net,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu. 11 juil. 2019 =C3=A0 13:09, Jyri Sarha <jsarha@ti.com> a =C3=A9crit=
 :
>
> On 03/07/2019 11:04, Olivier Moysan wrote:
> > Implement get_dai_id callback of audio HDMI codec
> > to support ASoC audio graph card.
> > HDMI audio output has to be connected to sii902x port 3.
> > get_dai_id callback maps this port to ASoC DAI index 0.
> >
> > Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
>
> I have not used audio graph binding, but compared to the other
> get_dai_id() implementations, this looks identical. So:
>
> Reviewed-by: Jyri Sarha <jsarha@ti.com>

Applied on drm-misc-next,
Thanks,
Benjamin

>
> > ---
> >  drivers/gpu/drm/bridge/sii902x.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/=
sii902x.c
> > index dd7aa466b280..daf9ef3cd817 100644
> > --- a/drivers/gpu/drm/bridge/sii902x.c
> > +++ b/drivers/gpu/drm/bridge/sii902x.c
> > @@ -158,6 +158,8 @@
> >
> >  #define SII902X_I2C_BUS_ACQUISITION_TIMEOUT_MS       500
> >
> > +#define SII902X_AUDIO_PORT_INDEX             3
> > +
> >  struct sii902x {
> >       struct i2c_client *i2c;
> >       struct regmap *regmap;
> > @@ -690,11 +692,32 @@ static int sii902x_audio_get_eld(struct device *d=
ev, void *data,
> >       return 0;
> >  }
> >
> > +static int sii902x_audio_get_dai_id(struct snd_soc_component *componen=
t,
> > +                                 struct device_node *endpoint)
> > +{
> > +     struct of_endpoint of_ep;
> > +     int ret;
> > +
> > +     ret =3D of_graph_parse_endpoint(endpoint, &of_ep);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     /*
> > +      * HDMI sound should be located at reg =3D <3>
> > +      * Return expected DAI index 0.
> > +      */
> > +     if (of_ep.port =3D=3D SII902X_AUDIO_PORT_INDEX)
> > +             return 0;
> > +
> > +     return -EINVAL;
> > +}
> > +
> >  static const struct hdmi_codec_ops sii902x_audio_codec_ops =3D {
> >       .hw_params =3D sii902x_audio_hw_params,
> >       .audio_shutdown =3D sii902x_audio_shutdown,
> >       .digital_mute =3D sii902x_audio_digital_mute,
> >       .get_eld =3D sii902x_audio_get_eld,
> > +     .get_dai_id =3D sii902x_audio_get_dai_id,
> >  };
> >
> >  static int sii902x_audio_codec_init(struct sii902x *sii902x,
> >
>
>
> --
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
