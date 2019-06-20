Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28AAC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A5420673
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sy2yUH85"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731802AbfFTPFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 11:05:44 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45578 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfFTPFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 11:05:44 -0400
Received: by mail-qt1-f193.google.com with SMTP id j19so3468157qtr.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 08:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+SlWqt7mGdvs9AkWDoKN464Wi1itv44/ucax1MjY5Lc=;
        b=sy2yUH85O64yGVV1H0EJrjQcDOaj/CH5ejtqXd/eWKCNUQyDKLJ4Ox5EJnSlDquSXm
         SD8EasjV3UB1B5KBD4BJnBVokm+WRQoyVw89nAbRcPXDVbtLQlWLKqGtZ4VKNAIE+OPn
         oZDLcU3qBcF0A3LMaG/5XdlCcXF5Ba2qpye539vqcAVjLvl5CfKX5ey0UqOToFh2swiE
         KiXL6zKImj1xSO+JXDDiNFj4/bXj9QiS8Gf2Eh6SuPs3Z0YBFOxUIaJEAo/rbguyBbq8
         GaZJroCvZZk8cxlYXqtTx9MgwqhC9iVzV2T8mO6IRsQWKuNSzTapj4JuUQRDWb+n1Tdy
         W3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+SlWqt7mGdvs9AkWDoKN464Wi1itv44/ucax1MjY5Lc=;
        b=MZ0jyfC5YOfCl13TbpFbApdtr0ICPcmjjbhg8h9k0oIkTEhXfMbSsv3Cx+e4s/CkG9
         v+3fEYLB76fSi8b0SwpL/m/ZlKtSEHsXZW1NBsikKg1Uwj74av0aHELp3xEQzF7cgdRa
         s96uoR1jo8TJ3wwnjQFlxdf1Kd/+O4Qb7ywdPk1I3VAQ7MfzOCF2V4lAAlB5mSLlvj4z
         L51Mh/abcsBWNK++lvd3jFpafK7wDL+5ELWWK3izSf0Bsgd+CioTW3TD1BC7XaTCzCJ3
         yV3XgKx6haMG7Ik8vbjOJe+/bMV7jfVzSdceoNJgJwORMS4VrN4bJ4tWyqTZNXK4nHQ1
         YZPA==
X-Gm-Message-State: APjAAAXTfdzX4FzHF4sABP/RLqukXSOpZc5DVrkbguJLb/73sAKGErlp
        gawlRyaIyBs+bJbqh42OQiE+3rnmIk7hZRtPc+s8BQ==
X-Google-Smtp-Source: APXvYqwM0WwCghbi2ShrGdjVLvsTAcFo9iwOmgfOosK9RkDv6TnpEiQTqBaPRpsQc4gKzVQlXZXbkX5AW0qYeR6z2PE=
X-Received: by 2002:ac8:395b:: with SMTP id t27mr115053664qtb.115.1561043142986;
 Thu, 20 Jun 2019 08:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <1560755897-5002-1-git-send-email-yannick.fertre@st.com> <7e6a87b6-e442-20cb-0d4e-68eb40c56042@st.com>
In-Reply-To: <7e6a87b6-e442-20cb-0d4e-68eb40c56042@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Thu, 20 Jun 2019 17:05:32 +0200
Message-ID: <CA+M3ks7oNuNnH+0eD5TDLFR_0fFWYA4gGtf40HcbFK4SQ7O-EQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/stm: drv: fix suspend/resume
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

Le mar. 18 juin 2019 =C3=A0 11:57, Philippe CORNU <philippe.cornu@st.com> a=
 =C3=A9crit :
>
> Hi Yannick,
>
> Thank you for your patch.
>
> Acked-by: Philippe Cornu <philippe.cornu@st.com>

I have corrected Fixes sha1 (should be 12 digits)
Applied on drm-misc-next.

Benjamin

>
> Philippe :-)
>
> On 6/17/19 9:18 AM, Yannick Fertr=C3=A9 wrote:
> > Without this fix, the system can not go in "suspend" mode
> > due to an error in drv_suspend function.
> >
> > Fixes: 35ab6cf ("drm/stm: support runtime power management")
> >
> > Signed-off-by: Yannick Fertr=C3=A9 <yannick.fertre@st.com>
> > ---
> >   drivers/gpu/drm/stm/drv.c | 15 ++++++++-------
> >   1 file changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
> > index 5659572..9dee4e4 100644
> > --- a/drivers/gpu/drm/stm/drv.c
> > +++ b/drivers/gpu/drm/stm/drv.c
> > @@ -136,8 +136,7 @@ static __maybe_unused int drv_suspend(struct device=
 *dev)
> >       struct ltdc_device *ldev =3D ddev->dev_private;
> >       struct drm_atomic_state *state;
> >
> > -     if (WARN_ON(!ldev->suspend_state))
> > -             return -ENOENT;
> > +     WARN_ON(ldev->suspend_state);
> >
> >       state =3D drm_atomic_helper_suspend(ddev);
> >       if (IS_ERR(state))
> > @@ -155,15 +154,17 @@ static __maybe_unused int drv_resume(struct devic=
e *dev)
> >       struct ltdc_device *ldev =3D ddev->dev_private;
> >       int ret;
> >
> > +     if (WARN_ON(!ldev->suspend_state))
> > +             return -ENOENT;
> > +
> >       pm_runtime_force_resume(dev);
> >       ret =3D drm_atomic_helper_resume(ddev, ldev->suspend_state);
> > -     if (ret) {
> > +     if (ret)
> >               pm_runtime_force_suspend(dev);
> > -             ldev->suspend_state =3D NULL;
> > -             return ret;
> > -     }
> >
> > -     return 0;
> > +     ldev->suspend_state =3D NULL;
> > +
> > +     return ret;
> >   }
> >
> >   static __maybe_unused int drv_runtime_suspend(struct device *dev)
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
