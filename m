Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E8EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340ED20811
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LwMF2YKn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730107AbfDXM3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:29:12 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34056 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDXM3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:29:12 -0400
Received: by mail-qt1-f195.google.com with SMTP id j6so724946qtq.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 05:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z24DRP0hu+AF8734B6RnxVXVQ9VaTNWeiJK0ZQ7QBjQ=;
        b=LwMF2YKnXGSbnesUJn2YrX6WGC4eP3MN+4NuhQidg0emu3f651VCuRBDvShsojV4pb
         1073hg4KCX24i+O4nz6c64N7lsvG7LSfW9F74wP5EcJaG/BtGOHZlHH6XO8juYjSgr17
         sxrEc9p3GWNaaGRILjFZrea/fDuYZiiqKinxJXMsG1o4uceAxrZwFIQNN5wfGpmSH6Wp
         V98zem6tWjtt1hHgV4CJAHFtKMtnG0Gt/2bBdQEXNbzfPclN7xmHY3OLSi1Kf1cj3Hdp
         B66m3Un4mOZqaRscJh/OvSyJ6RmEdsmm4Erk1NBVFe/YTthcy98GWBOuF7IxLDtuipB8
         tqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z24DRP0hu+AF8734B6RnxVXVQ9VaTNWeiJK0ZQ7QBjQ=;
        b=N9qRf99KNa8bGrDQFkb/aJfMXKAdaRtHFORgKsHpl43Y2fZiIWOF7jwbWpufTkr56U
         sCfPh+StFlbE0NxCRbdljM6AiCQPPt5MzrushheCpWxPWyts35EYJW9g1WBt57jFnUon
         GP978JruhdBQ9k90iXPUVUsgpkCm+VPHkSqrDh1Xn0YxI6wHLi0inPhA1DTS6RMX5WlV
         hGcEDi/0BdzETYrFK0oHvo5pW21JNzX/0ss3/oTQi66ExkYXqK4r0y4UIMqV0aGKQeYE
         7sqmqG2wTYcg3+AzPUbCuiIkR4Y/POEuIWMfSUOh36+26hr5nMDNNFAkRzuDtOIMfdDd
         iP9w==
X-Gm-Message-State: APjAAAVyj2IryZUVUWhmlOhQaDr0OeSv5AoQLMYr85AzJ0j4xDffJBPA
        BYpGH+fj3mglXQG7aQyKwBKrKYl8MxAPLEAsp7S6HA==
X-Google-Smtp-Source: APXvYqwf/VV9NcgxNsV8415cTpDqqavNDmLnguHza32bzkFEMZPcoiLaHmV+8Tij4RIOf59oIuMuS/FB2Srj2Ckj9Qc=
X-Received: by 2002:aed:3ac2:: with SMTP id o60mr26529879qte.158.1556108951312;
 Wed, 24 Apr 2019 05:29:11 -0700 (PDT)
MIME-Version: 1.0
References: <1554283453-2879-1-git-send-email-yannick.fertre@st.com> <1487ab3d-60f6-4c85-d021-8dec7f1a99c2@st.com>
In-Reply-To: <1487ab3d-60f6-4c85-d021-8dec7f1a99c2@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Wed, 24 Apr 2019 14:29:00 +0200
Message-ID: <CA+M3ks4kX6d1V5zfB=SC=71YZb8x0Sn8sMvQ9YGAqYc0-6FR2A@mail.gmail.com>
Subject: Re: [PATCH] drm/stm: ltdc: reset controller to avoid partial refresh
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

Le ven. 5 avr. 2019 =C3=A0 18:31, Philippe CORNU <philippe.cornu@st.com> a =
=C3=A9crit :
>
>
>
> On 4/3/19 11:24 AM, Yannick Fertr=C3=A9 wrote:
> > Display controller reset must be done as soon as possible after enable
> > the clock to avoid partial refresh on screen.
> >
> > Signed-off-by: Yannick Fertr=C3=A9 <yannick.fertre@st.com>
> > ---
> >   drivers/gpu/drm/stm/ltdc.c | 12 ++++++------
> >   1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> > index 32fd6a3..7bbe61c 100644
> > --- a/drivers/gpu/drm/stm/ltdc.c
> > +++ b/drivers/gpu/drm/stm/ltdc.c
> > @@ -1134,6 +1134,12 @@ int ltdc_load(struct drm_device *ddev)
> >               return -ENODEV;
> >       }
> >
> > +     if (!IS_ERR(rstc)) {
> > +             reset_control_assert(rstc);
> > +             usleep_range(10, 20);
> > +             reset_control_deassert(rstc);
> > +     }
> > +
> >       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >       ldev->regs =3D devm_ioremap_resource(dev, res);
> >       if (IS_ERR(ldev->regs)) {
> > @@ -1156,12 +1162,6 @@ int ltdc_load(struct drm_device *ddev)
> >               }
> >       }
> >
> > -     if (!IS_ERR(rstc)) {
> > -             reset_control_assert(rstc);
> > -             usleep_range(10, 20);
> > -             reset_control_deassert(rstc);
> > -     }
> > -
>
> Dear Yannick,
> Thank you for your patch,
>
> Acked-by: Philippe Cornu <philippe.cornu@st.com>

Applied on drm-misc-next after doing a rebase.
Thanks,
Benjamin
>
> Philippe :)
>
> >       /* Disable interrupts */
> >       reg_clear(ldev->regs, LTDC_IER,
> >                 IER_LIE | IER_RRIE | IER_FUIE | IER_TERRIE);
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
