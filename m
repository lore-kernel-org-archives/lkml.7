Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1E2C76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2193C206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kDPaigz0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbfGYKGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 06:06:22 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33894 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfGYKGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 06:06:22 -0400
Received: by mail-qt1-f196.google.com with SMTP id k10so48541574qtq.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 03:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zQMVxe3WoXIZNphAhnksatgFc1GF8rTdTdgr2SLV9iE=;
        b=kDPaigz0G8Pu7nH11KHGXyzXzcWIGm8p48us4Zolu2noXTfmgTxNEGRY9ENB0JwjaL
         GAuiJMo3VWyDGeJ8iaGqgT7ou/XAFWXqi4J7XyA3YnPE2QbNirtXBhWdIiQ3j0sJGPL+
         55c+K3owfz2iMnuXKKivBARspjVkdOjLySJyyNiiNhiEY0yHomFtSMJp6HDRLu5fnQrg
         iNLM1w9zDj/QxyOFNkat6bw50e6EP0NMzk6p3cBmi5UGRM4XhEXiRpCCienLXFg6+RJB
         lgjO869eVfc0mfQSTuuUSAJxC0LmLbDN9AfP4IqsCCvOOtPrjuZVxSZ75f3PRtPV4oXj
         9KVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zQMVxe3WoXIZNphAhnksatgFc1GF8rTdTdgr2SLV9iE=;
        b=rot2V+sadTrsiuP/zugxhTfMymEV0o7WV0Al6rmXKNHunuz8KKcSSxkDz1icBN4QAg
         Dx2HgHMN5+qjS12uF2SS2DzjUdYO4Fh8NGcz39LWe4g6PZZ5K9BL+8eDG+OUwlyxUbLV
         Hm5hDqDdN5NDKOIYB1DXetjk4wCBezvMO7tRTkBE8gUeDMxaDLjFCVj5V9DrvqQMAOpa
         rkWtExWKU/6+Zkmi6lWqEJlovCRO6tLbVeTy3BYSOBv+hm3gbHWXwlSq2G/GOF+jrr8F
         JiRnF9Msjm6qOoJuyo5h3DbwAKfxRuNnX7xE3BhlbVA5dJuI9Sd+Xs31vA+4ZloIN46c
         ydcw==
X-Gm-Message-State: APjAAAUWtr3ts78KbvxfcwvgtTi3+hcmJOeh9Fo1SdIQGuQ6e53791SU
        z497F6jG89BZEMp0BHANFyzBAqg5xvLpq/ZM19oZ1A==
X-Google-Smtp-Source: APXvYqxiUgtD1Oqp5s64OPc9Tv6xDA0YAOE0HLwM37Elo/1REVFSdGgH6ZMP+A2uMINEanG0dwqemHajRYVCdHtY8NM=
X-Received: by 2002:ac8:7402:: with SMTP id p2mr59799351qtq.250.1564049181185;
 Thu, 25 Jul 2019 03:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <1563811560-29589-1-git-send-email-olivier.moysan@st.com> <1563811560-29589-4-git-send-email-olivier.moysan@st.com>
In-Reply-To: <1563811560-29589-4-git-send-email-olivier.moysan@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Thu, 25 Jul 2019 12:06:10 +0200
Message-ID: <CA+M3ks6ZRrLAa=xMPi5UfdLEzMCBCjeovUei2O9m8V4PW3bh-Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/bridge: sii902x: make audio mclk optional
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
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
        linux-stm32@st-md-mailman.stormreply.com,
        Jyri Sarha <jsarha@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lun. 22 juil. 2019 =C3=A0 18:06, Olivier Moysan <olivier.moysan@st.com> =
a =C3=A9crit :
>
> The master clock on i2s bus is not mandatory,
> as sii902X internal PLL can be used instead.
> Make use of mclk optional.

Applied on drm-misc-next.
Thanks,
Benjamin

>
> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
> Reviewed-by: Jyri Sarha <jsarha@ti.com>
> Acked-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
>  drivers/gpu/drm/bridge/sii902x.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/si=
i902x.c
> index 962931c20efe..a323815aa9b6 100644
> --- a/drivers/gpu/drm/bridge/sii902x.c
> +++ b/drivers/gpu/drm/bridge/sii902x.c
> @@ -568,13 +568,14 @@ static int sii902x_audio_hw_params(struct device *d=
ev, void *data,
>                 return ret;
>         }
>
> -       mclk_rate =3D clk_get_rate(sii902x->audio.mclk);
> -
> -       ret =3D sii902x_select_mclk_div(&i2s_config_reg, params->sample_r=
ate,
> -                                     mclk_rate);
> -       if (mclk_rate !=3D ret * params->sample_rate)
> -               dev_dbg(dev, "Inaccurate reference clock (%ld/%d !=3D %u)=
\n",
> -                       mclk_rate, ret, params->sample_rate);
> +       if (sii902x->audio.mclk) {
> +               mclk_rate =3D clk_get_rate(sii902x->audio.mclk);
> +               ret =3D sii902x_select_mclk_div(&i2s_config_reg,
> +                                             params->sample_rate, mclk_r=
ate);
> +               if (mclk_rate !=3D ret * params->sample_rate)
> +                       dev_dbg(dev, "Inaccurate reference clock (%ld/%d =
!=3D %u)\n",
> +                               mclk_rate, ret, params->sample_rate);
> +       }
>
>         mutex_lock(&sii902x->mutex);
>
> @@ -751,11 +752,11 @@ static int sii902x_audio_codec_init(struct sii902x =
*sii902x,
>                 sii902x->audio.i2s_fifo_sequence[i] |=3D audio_fifo_id[i]=
 |
>                         i2s_lane_id[lanes[i]] | SII902X_TPI_I2S_FIFO_ENAB=
LE;
>
> -       sii902x->audio.mclk =3D devm_clk_get(dev, "mclk");
> +       sii902x->audio.mclk =3D devm_clk_get_optional(dev, "mclk");
>         if (IS_ERR(sii902x->audio.mclk)) {
>                 dev_err(dev, "%s: No clock (audio mclk) found: %ld\n",
>                         __func__, PTR_ERR(sii902x->audio.mclk));
> -               return 0;
> +               return PTR_ERR(sii902x->audio.mclk);
>         }
>
>         sii902x->audio.pdev =3D platform_device_register_data(
> --
> 2.7.4
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
