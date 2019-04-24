Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DE1C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E6020811
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="df1woK7d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbfDXM2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:28:37 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43987 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbfDXM2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:28:36 -0400
Received: by mail-qt1-f195.google.com with SMTP id g4so572547qtq.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 05:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IVYQXDOV3sPZ9q7TXCkb8aXmL1azsO033o4XZQeD7ik=;
        b=df1woK7doX8rbf7SGvJmnRA7hdZgR6ezmy5D9UJ0UJYKo+/Em8gwOTREV0YMhuT3ho
         iKoTn4cyVQwVhyHWgTsuBFDA+Iagmu5iFFE7KwNi75lF/aE23WY2dvRh9N0jNiFbs125
         eNon7hHdt/fSa+humgcYMC878WpwI3Z6JzSlqnqELa6DaKnH76od6plSDPxcB6zMGwRL
         /KJ7Z84bUJ1fqWA7w2/u5bLYPf41LMjRMVgI/7bttA+YQvBkcq/GDjxbGAek8GThbMF4
         kPb1dBSEJrpW+leZ9ybHedCXUcmBR34IiPL7unOutNMe9SIPk2j2EvGULgZxR0y4I/aT
         iXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IVYQXDOV3sPZ9q7TXCkb8aXmL1azsO033o4XZQeD7ik=;
        b=Ccx7vWi/02mPFmsyVeEFnBtRcoB9W5PRNtIct88JRnroCH0BYOQQ87XfEYI3QX595g
         dJofUtvpoOlNnAyUX+fTypj3ltBJOZJVmaALne5QzSLb4xuMhMlyIs+542kCUzu45eQc
         ncwkV7N/+UX6xM6f0bzPcJkU+igSShQ1ilBb13XSwdvQQ+eyFP6+ETUMWBBHGdkss9m9
         C4zSGTwnEjtdDGnVp5NGkp4qqyKZs4VX/LrU3U37pqqbws0E5U1mSmutgNQE9ripWiyR
         Bj1gB6Ntqlj/jUPN51u5Py6F6JokXNkmnJE/P10Tjjsrj0RD/Bl6G1ogFZxwkNOSmtTf
         VAUg==
X-Gm-Message-State: APjAAAX6wu0dWDyioRFa00kKlAVxwlbqfX4FRtPwAaculmG36vlAQsuQ
        gD6c9qafe/zMhZKj7LHIZ0NeucYHVS/wCC14iAT7eQ==
X-Google-Smtp-Source: APXvYqx/wxp3RJwatvRHxpk9y3ArN9Nk53j3qyNvIZ6dd/GpRDljP5wts9dvynBaJCvIN9AHQtUw3Rv3C9P+6+pQ/UM=
X-Received: by 2002:a0c:c686:: with SMTP id d6mr16021999qvj.179.1556108916015;
 Wed, 24 Apr 2019 05:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <1554283216-2700-1-git-send-email-yannick.fertre@st.com> <51100130-dfe9-ae21-6efb-b1394f607bdd@st.com>
In-Reply-To: <51100130-dfe9-ae21-6efb-b1394f607bdd@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Wed, 24 Apr 2019 14:28:25 +0200
Message-ID: <CA+M3ks4h1uMY=jFQDJZceWi7udhiKQPLLr-3KqbDDjf17hmzSw@mail.gmail.com>
Subject: Re: [PATCH] drm/stm: ltdc: limit number of layer to avoid memory overflow
To:     Philippe CORNU <philippe.cornu@st.com>
Cc:     Yannick FERTRE <yannick.fertre@st.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le ven. 5 avr. 2019 =C3=A0 18:30, Philippe CORNU <philippe.cornu@st.com> a =
=C3=A9crit :
>
> Dear Yannick,
> Thank you for your patch,
>
> Acked-by: Philippe Cornu <philippe.cornu@st.com>
>

Applied on drm-misc-next,
Thanks,
Benjamin

> Philippe :)
>
> On 4/3/19 11:20 AM, Yannick Fertr=C3=A9 wrote:
> > If the number of layer is greater than LTDC_MAX_LAYER, we can have
> > memory overflow when reading plane_fpsi[].
> >
> > Signed-off-by: Yannick Fertr=C3=A9 <yannick.fertre@st.com>
> > ---
> >   drivers/gpu/drm/stm/ltdc.c | 7 +++++--
> >   1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> > index 32fd6a3..05bd4b6 100644
> > --- a/drivers/gpu/drm/stm/ltdc.c
> > +++ b/drivers/gpu/drm/stm/ltdc.c
> > @@ -1021,10 +1021,13 @@ static int ltdc_get_caps(struct drm_device *dde=
v)
> >       struct ltdc_device *ldev =3D ddev->dev_private;
> >       u32 bus_width_log2, lcr, gc2r;
> >
> > -     /* at least 1 layer must be managed */
> > +     /*
> > +      * at least 1 layer must be managed & the number of layers
> > +      * must not exceed LTDC_MAX_LAYER
> > +      */
> >       lcr =3D reg_read(ldev->regs, LTDC_LCR);
> >
> > -     ldev->caps.nb_layers =3D max_t(int, lcr, 1);
> > +     ldev->caps.nb_layers =3D clamp((int)lcr, 1, LTDC_MAX_LAYER);
> >
> >       /* set data bus width */
> >       gc2r =3D reg_read(ldev->regs, LTDC_GC2R);
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
