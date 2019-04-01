Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2560C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6758720850
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="deBfx0XL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfDAJHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 05:07:38 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35425 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfDAJHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 05:07:37 -0400
Received: by mail-qt1-f194.google.com with SMTP id h39so9898642qte.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 02:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gwkEnxY50j/1YGbELwBbJbwjNrXF8tE5m/9cLS3eRVI=;
        b=deBfx0XLBZHrBggY+pUkmmSJSQ1fqQqAe0Pb4qkoS12hSD121BIx7EJmfuhvr7DA2t
         nd06YxdET2If28lvAHIKkMzStfAfktWEU80BLtCY3QCVHG/LXUMVsrnMv7jNq5wZgX0D
         L8O37/ki4530lp70DJbXdaBqGIOO+yoNkz/LSWKjb9S4LKSaNCEofAmWzkGlm4wxZfOh
         F68l1IwOUHZXRvZ6TYCN6wj/m7bro9esX+7lYaDqP15HiNryhpOCJixsc67J7vROIUI0
         Jc4mLApEpDFiPU/HbU5amETEhKeKfb9PM1GhYp8UfVIAS76RiJMnsNBiUGyiHo5uFVjc
         Fv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gwkEnxY50j/1YGbELwBbJbwjNrXF8tE5m/9cLS3eRVI=;
        b=n9c/pNyLZspVrnexiygvxPQJT1oTP0lL0n548swK2Zp2lJr7SZ+0qh9MScarNGxLTy
         vLx/uEWIOdqn9WX1dadI7gtfaHn3XjVR3O/uiM5skWRkfiqaWxPSVUlzWBF2alHLh9qC
         7IPw7lYjCyGrUuA3J1QpqmTqbrczlZB68Ggi9Q7IpnT0gJkAtH22qOwHiIbkCcBtck5S
         sNUvKiY4Ve/qNOZHTxElWZbcZU2h/r6zzGwRSngW3tA4nKftRaeB+vG1/fbzkQyk2LPU
         As9IS8wibSADUoM93dnM2AxkrbzxuIvfsX6zBDYzs1CiQIXTYeP/2LieJZpudzuXfmka
         j6Ig==
X-Gm-Message-State: APjAAAWIcIWRwXaD7wfHn1Y3Kqoy5U/cUegOa5iwsSC5lntX1q9woWUT
        P4NwP2jFi4kt65HZ56I5+U4ABnNOQ2ERj2GinZrOaQ==
X-Google-Smtp-Source: APXvYqyEqd8qSp026+v2c7kA2fAauBQ1qAeXztMlCh6fkMcA7WJ6KWzvNpQS0Sp49J7g7zczWtjAhZCR0eoNC8+N3Fk=
X-Received: by 2002:a0c:b92c:: with SMTP id u44mr50508059qvf.222.1554109656206;
 Mon, 01 Apr 2019 02:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <1553156120-13851-1-git-send-email-yannick.fertre@st.com> <2ebfb124-08dc-4d5f-9e12-2afc5295c0f6@st.com>
In-Reply-To: <2ebfb124-08dc-4d5f-9e12-2afc5295c0f6@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Mon, 1 Apr 2019 11:07:25 +0200
Message-ID: <CA+M3ks6Pz2z7OLFDRa4BCFqYLtqo3o5h0+bCS+L45UzgnuM_qw@mail.gmail.com>
Subject: Re: [PATCH] drm/stm: add sleep power management
To:     Philippe CORNU <philippe.cornu@st.com>
Cc:     Yannick FERTRE <yannick.fertre@st.com>,
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

Le mar. 26 mars 2019 =C3=A0 14:02, Philippe CORNU <philippe.cornu@st.com> a=
 =C3=A9crit :
>
> (+ Benjamin)
>
> Dear Yannick,
> Many thanks for your patch.
> Acked-by: Philippe Cornu <philippe.cornu@st.com>
>
> Dear Benjamin,
> May I ask you please to merge this patch + "drm/stm: dw_mipi_dsi-stm:
> add sleep power management" on drm-misc, if you agree of course and when
> you think it is the right time (next week?)
> Big thanks,

Applied on drm-misc-next.

Benjamin

>
> Philippe :-)
>
>
> On 3/21/19 9:15 AM, Yannick Fertr=C3=A9 wrote:
> > Implements system sleep power management ops.
> >
> > Signed-off-by: Yannick Fertr=C3=A9 <yannick.fertre@st.com>
> > ---
> >   drivers/gpu/drm/stm/drv.c  | 35 +++++++++++++++++++++++++++++++++++
> >   drivers/gpu/drm/stm/ltdc.c | 24 ++++++++++++++++++++++++
> >   drivers/gpu/drm/stm/ltdc.h |  3 +++
> >   3 files changed, 62 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
> > index 0a7f933..5834ef5 100644
> > --- a/drivers/gpu/drm/stm/drv.c
> > +++ b/drivers/gpu/drm/stm/drv.c
> > @@ -129,6 +129,40 @@ static void drv_unload(struct drm_device *ddev)
> >       drm_mode_config_cleanup(ddev);
> >   }
> >
> > +static __maybe_unused int drv_suspend(struct device *dev)
> > +{
> > +     struct drm_device *ddev =3D dev_get_drvdata(dev);
> > +     struct ltdc_device *ldev =3D ddev->dev_private;
> > +     struct drm_atomic_state *state;
> > +
> > +     drm_kms_helper_poll_disable(ddev);
> > +     state =3D drm_atomic_helper_suspend(ddev);
> > +     if (IS_ERR(state)) {
> > +             drm_kms_helper_poll_enable(ddev);
> > +             return PTR_ERR(state);
> > +     }
> > +     ldev->suspend_state =3D state;
> > +     ltdc_suspend(ddev);
> > +
> > +     return 0;
> > +}
> > +
> > +static __maybe_unused int drv_resume(struct device *dev)
> > +{
> > +     struct drm_device *ddev =3D dev_get_drvdata(dev);
> > +     struct ltdc_device *ldev =3D ddev->dev_private;
> > +
> > +     ltdc_resume(ddev);
> > +     drm_atomic_helper_resume(ddev, ldev->suspend_state);
> > +     drm_kms_helper_poll_enable(ddev);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct dev_pm_ops drv_pm_ops =3D {
> > +     SET_SYSTEM_SLEEP_PM_OPS(drv_suspend, drv_resume)
> > +};
> > +
> >   static int stm_drm_platform_probe(struct platform_device *pdev)
> >   {
> >       struct device *dev =3D &pdev->dev;
> > @@ -186,6 +220,7 @@ static struct platform_driver stm_drm_platform_driv=
er =3D {
> >       .driver =3D {
> >               .name =3D "stm32-display",
> >               .of_match_table =3D drv_dt_ids,
> > +             .pm =3D &drv_pm_ops,
> >       },
> >   };
> >
> > diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> > index b1741a9..32fd6a3 100644
> > --- a/drivers/gpu/drm/stm/ltdc.c
> > +++ b/drivers/gpu/drm/stm/ltdc.c
> > @@ -1062,6 +1062,30 @@ static int ltdc_get_caps(struct drm_device *ddev=
)
> >       return 0;
> >   }
> >
> > +void ltdc_suspend(struct drm_device *ddev)
> > +{
> > +     struct ltdc_device *ldev =3D ddev->dev_private;
> > +
> > +     DRM_DEBUG_DRIVER("\n");
> > +     clk_disable_unprepare(ldev->pixel_clk);
> > +}
> > +
> > +int ltdc_resume(struct drm_device *ddev)
> > +{
> > +     struct ltdc_device *ldev =3D ddev->dev_private;
> > +     int ret;
> > +
> > +     DRM_DEBUG_DRIVER("\n");
> > +
> > +     ret =3D clk_prepare_enable(ldev->pixel_clk);
> > +     if (ret) {
> > +             DRM_ERROR("failed to enable pixel clock (%d)\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >   int ltdc_load(struct drm_device *ddev)
> >   {
> >       struct platform_device *pdev =3D to_platform_device(ddev->dev);
> > diff --git a/drivers/gpu/drm/stm/ltdc.h b/drivers/gpu/drm/stm/ltdc.h
> > index e46f477..a1ad0ae 100644
> > --- a/drivers/gpu/drm/stm/ltdc.h
> > +++ b/drivers/gpu/drm/stm/ltdc.h
> > @@ -36,6 +36,7 @@ struct ltdc_device {
> >       u32 error_status;
> >       u32 irq_status;
> >       struct fps_info plane_fpsi[LTDC_MAX_LAYER];
> > +     struct drm_atomic_state *suspend_state;
> >   };
> >
> >   bool ltdc_crtc_scanoutpos(struct drm_device *dev, unsigned int pipe,
> > @@ -45,5 +46,7 @@ bool ltdc_crtc_scanoutpos(struct drm_device *dev, uns=
igned int pipe,
> >
> >   int ltdc_load(struct drm_device *ddev);
> >   void ltdc_unload(struct drm_device *ddev);
> > +void ltdc_suspend(struct drm_device *ddev);
> > +int ltdc_resume(struct drm_device *ddev);
> >
> >   #endif
> >
