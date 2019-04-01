Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F7CC10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63100213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VOkX2W4Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbfDAJHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 05:07:17 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33980 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfDAJHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 05:07:16 -0400
Received: by mail-qk1-f194.google.com with SMTP id n68so5139632qka.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 02:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BZ8WrltWqPP4tMPfMPp9A9mpGjzS4IaF8AKTpCw9yWU=;
        b=VOkX2W4QSvYLSencPw5mhAOJ/JAf/cp7EM812bYSqHZqS0FErvoFeBw/m4j8bvXb7L
         Lq+dbTWqtzKU01LM+JfagK9P9r3akQPW9gqkwi1ma2XNqjpVct+qqzOdG579W0lkDKWj
         EtdvQ4K/F5TGT0rOrbndSq0GbHIkNEygg5VunoMnw+zZ9kDZ5cQzQxjTQS0V7I6nVw7J
         6LN/uxlbyRHXCG7Ys7BaZRKusXOPPHh48xHOXBxPMYCFr7f0rSpzGN3We/VvBli8j3+0
         QA5apJ4RnOwKiNAGUIEJXWYF8O7q0CWOvnNOQaGXvbJMAE8WVWvb2xYZ4hW9T1AxaG0o
         8tJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BZ8WrltWqPP4tMPfMPp9A9mpGjzS4IaF8AKTpCw9yWU=;
        b=E+/csgRO6noe/qvShNDZI1g3SUaHW3bXQeC37H5kBGrw+o1eYqJauTQKOTGZw6dknq
         Ovxd+Q5xS3PxKAE/pAym0Sg+NUMFhyOFOxGwiX2ZU3GP0ExjlK5r0x8hY1/tht8Ll7h+
         ZvzCluH51gfQECUijjrq5qwdTfePZsdC86f2b84M2mYmsMzRfqcmzaaWzqtjkWoY/9rJ
         7UdXlrUbncX65jyiKAIxS/f6ddf+KOcVuGBD5JTthRr7UKG+VtIQKrcxAHQf+F2Gk55M
         YIGDj/0VwrJD25WV+qD+sv5kzUaf0IJDrUYwln4dwiTTwQKNwjHcYVBY4Yb1AAQBXySz
         xqDg==
X-Gm-Message-State: APjAAAXp+kZKiQZsgWN94RXpPN8hDB7+68Z4RlypCbhQK81bBwcvCM3v
        qrNKza/B3HXG/1Xhclj8uV6R1XnjkY2ZD6NJMDPL7g==
X-Google-Smtp-Source: APXvYqxx1QFMXD0b61FDs/b18KmpcjDON8C4EYSSMw/tm74ZaI3CQqWvKkkxwM5O8X1G3j+67pjtXZDnTmbrEfdXt3c=
X-Received: by 2002:ae9:c310:: with SMTP id n16mr48821996qkg.8.1554109635837;
 Mon, 01 Apr 2019 02:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <1553156033-13792-1-git-send-email-yannick.fertre@st.com> <8dc548ed-fc71-dd04-83b9-ee07faeb16ea@st.com>
In-Reply-To: <8dc548ed-fc71-dd04-83b9-ee07faeb16ea@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Mon, 1 Apr 2019 11:07:04 +0200
Message-ID: <CA+M3ks5uQOSW8Jf4PLSQONNL=BS_SGLcX_eC=MuK539Bebh47g@mail.gmail.com>
Subject: Re: [PATCH] drm/stm: dw_mipi_dsi-stm: add sleep power management
To:     Philippe CORNU <philippe.cornu@st.com>
Cc:     Yannick FERTRE <yannick.fertre@st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mar. 26 mars 2019 =C3=A0 13:57, Philippe CORNU <philippe.cornu@st.com> a=
 =C3=A9crit :
>
> Dear Yannick,
> Many thanks for your patch.
>
> Acked-by: Philippe Cornu <philippe.cornu@st.com>

Applied on drm-misc-next.

Benjamin

>
> Philippe :-)
>
>
> On 3/21/19 9:13 AM, Yannick Fertr=C3=A9 wrote:
> > Implements system sleep power management ops.
> >
> > Signed-off-by: Yannick Fertr=C3=A9 <yannick.fertre@st.com>
> > ---
> >   drivers/gpu/drm/stm/dw_mipi_dsi-stm.c | 28 ++++++++++++++++++++++++++=
++
> >   1 file changed, 28 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c b/drivers/gpu/drm/st=
m/dw_mipi_dsi-stm.c
> > index a672b59..1bef73e 100644
> > --- a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
> > +++ b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
> > @@ -356,12 +356,40 @@ static int dw_mipi_dsi_stm_remove(struct platform=
_device *pdev)
> >       return 0;
> >   }
> >
> > +static int __maybe_unused dw_mipi_dsi_stm_suspend(struct device *dev)
> > +{
> > +     struct dw_mipi_dsi_stm *dsi =3D dw_mipi_dsi_stm_plat_data.priv_da=
ta;
> > +
> > +     DRM_DEBUG_DRIVER("\n");
> > +
> > +     clk_disable_unprepare(dsi->pllref_clk);
> > +
> > +     return 0;
> > +}
> > +
> > +static int __maybe_unused dw_mipi_dsi_stm_resume(struct device *dev)
> > +{
> > +     struct dw_mipi_dsi_stm *dsi =3D dw_mipi_dsi_stm_plat_data.priv_da=
ta;
> > +
> > +     DRM_DEBUG_DRIVER("\n");
> > +
> > +     clk_prepare_enable(dsi->pllref_clk);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct dev_pm_ops dw_mipi_dsi_stm_pm_ops =3D {
> > +     SET_SYSTEM_SLEEP_PM_OPS(dw_mipi_dsi_stm_suspend,
> > +                             dw_mipi_dsi_stm_resume)
> > +};
> > +
> >   static struct platform_driver dw_mipi_dsi_stm_driver =3D {
> >       .probe          =3D dw_mipi_dsi_stm_probe,
> >       .remove         =3D dw_mipi_dsi_stm_remove,
> >       .driver         =3D {
> >               .of_match_table =3D dw_mipi_dsi_stm_dt_ids,
> >               .name   =3D "stm32-display-dsi",
> > +             .pm =3D &dw_mipi_dsi_stm_pm_ops,
> >       },
> >   };
> >
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
