Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9474C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B676020811
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y1o8YwgU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730049AbfDXM2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:28:06 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45056 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfDXM2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:28:06 -0400
Received: by mail-qt1-f195.google.com with SMTP id b3so5078382qtc.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 05:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JK835SmutkiSI02d9K73JY94LjFulDtPz60W5BA7hrc=;
        b=y1o8YwgUQ8h69hsxi0LAzl4q21vVwmnMJlKubeLWPJ/aJruYyu9BeploZUnnWyk1ef
         140Al9/FDLWIZps/bQRti9lmwgoxCnyz4WgmH7u4TP/d+IWvzxYayrmus8Up9ie6T3Ym
         MlY70jBjRTakdg1A3bqwJU3w5nxgrHe6j8dFPwgLg+JDJbPCEBFVdcJhfAUgsdI6U7Xx
         sGUBzAC28fveplXEhYwK1JpLO1VZF8mPiDaKGFexgmqvAYyvVJR7irAKkQGNDMqfewOo
         g1EgpLTJwvX8tFzqPLwWjQjV9zS3qkiGVJxS2H44WmaxLfZmVMgl+LzoJw4QPAvGcOIi
         EWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JK835SmutkiSI02d9K73JY94LjFulDtPz60W5BA7hrc=;
        b=InegWFpmn2LFAKJi3TcbW0F25/gjtbq5vCz3RL2TpMWK04R1fsgvAFNh5YQzxQfLnZ
         mCbhEjt+bZiqT6NC8YtzDUsadzRtW5kZQvPwP4jQqgpuSZbEjUSIECfcjokRMsNDHHwG
         DXuLwASBQZOpDV/O6sc+6+1c+Exqan92zai7msOvRGeAFslq8pNOqsfeG33IB08itBDQ
         4tOpmJhnI0chH053R7eBJA9VN/InuArGnei72cOM4KNnaOWLLPo2CAHf5HVPoDK4F3Vu
         6b1Jc1eWWmlGJdua7/HnKS9+s0J7Z5JAVKmUAz10kN3Jpk8obWBc0tct/EPf6OhSRMbu
         J34g==
X-Gm-Message-State: APjAAAUWvOZriUGxrVfhxcDZvBl+h7wIfUW7uGg5YOS7AzhlxWaqB0ky
        ifiYDPth7z/PEEBCX3zOmEk7x5OKWfg3Z5OThs15tw==
X-Google-Smtp-Source: APXvYqx7MjNqvN3YHTDygvexCbX3BdCimOV9XINVMlTty19/KBTkOh2pC4cBrH0dQ5k6kpZygpbiiSQ4xk17oNXVYrQ=
X-Received: by 2002:a0c:b0a5:: with SMTP id o34mr24152323qvc.42.1556108885068;
 Wed, 24 Apr 2019 05:28:05 -0700 (PDT)
MIME-Version: 1.0
References: <1553874485-31259-1-git-send-email-yannick.fertre@st.com> <d63b7a3e-3162-7823-fa42-81a1aeccb5ff@st.com>
In-Reply-To: <d63b7a3e-3162-7823-fa42-81a1aeccb5ff@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Wed, 24 Apr 2019 14:27:54 +0200
Message-ID: <CA+M3ks7RP5Ay367rL+Upcr-og-E35nGoiMbkSNP7N7XYeOUCOw@mail.gmail.com>
Subject: Re: [PATCH] drm/stm: ltdc: disable hw interrupts before its handler init
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

Le lun. 1 avr. 2019 =C3=A0 11:19, Philippe CORNU <philippe.cornu@st.com> a =
=C3=A9crit :
>
>
> On 3/29/19 4:48 PM, Yannick Fertr=C3=A9 wrote:
> > Interrupt register must be disabled before call of
> > devm_request_threaded_irq function to avoid dummy interruption.
> >
> > Signed-off-by: Yannick Fertr=C3=A9 <yannick.fertre@st.com>
> > ---
> >   drivers/gpu/drm/stm/ltdc.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> > index b1741a9..ef5b4d6 100644
> > --- a/drivers/gpu/drm/stm/ltdc.c
> > +++ b/drivers/gpu/drm/stm/ltdc.c
> > @@ -1118,6 +1118,10 @@ int ltdc_load(struct drm_device *ddev)
> >               goto err;
> >       }
> >
> > +     /* Disable interrupts */
> > +     reg_clear(ldev->regs, LTDC_IER,
> > +               IER_LIE | IER_RRIE | IER_FUIE | IER_TERRIE);
> > +
> >       for (i =3D 0; i < MAX_IRQ; i++) {
> >               irq =3D platform_get_irq(pdev, i);
> >               if (irq < 0)
> > @@ -1138,10 +1142,6 @@ int ltdc_load(struct drm_device *ddev)
> >               reset_control_deassert(rstc);
> >       }
> >
> > -     /* Disable interrupts */
> > -     reg_clear(ldev->regs, LTDC_IER,
> > -               IER_LIE | IER_RRIE | IER_FUIE | IER_TERRIE);
> > -
>
> Dear Yannick,
> Thank you for your patch,
>
> Acked-by: Philippe Cornu <philippe.cornu@st.com>
>

Applied on drm-misc-next,
Thanks,
Benjamin

> Philippe :-)
>
> >       ret =3D ltdc_get_caps(ddev);
> >       if (ret) {
> >               DRM_ERROR("hardware identifier (0x%08x) not supported!\n"=
,
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
