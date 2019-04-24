Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86C6C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 977F321773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l4AFDOlC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbfDXMZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:25:53 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37384 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbfDXMZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:25:53 -0400
Received: by mail-qk1-f196.google.com with SMTP id c1so10678207qkk.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 05:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=clPB49k5bUNWi1l9QLb30EX4SpuEGDe/C4dN/7k8mBs=;
        b=l4AFDOlCisAsBDJKMyKqJkIulWY5JOkKmxfzXD6I1tcgfe2nUxJ4JuS4bu+lIVMgk4
         tF7arAKFnlTKSShbrbOju7vRQzJZVylYT/dc9yo7JDSIORgD2EcqjgxnDij0vASxQk6k
         JUF9Le0nqTfLemixWBLl8rfxPF8lREjEGyL4SUvcCrplDcqYyw1BSuMS/AOn4HOUh6oi
         xbN2As/9VpO331UXOhh9X/S8pNFVP7reu0e+OnK/Setf1vN5GdKJOt9sZ7KNuCDuWmWX
         v5O/RvhekPiMOFeXoaP9RoZT5mo3teJNj5JhlQ7qTSIWabZPYdtOtkAht2M/VI3xp/sw
         682w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=clPB49k5bUNWi1l9QLb30EX4SpuEGDe/C4dN/7k8mBs=;
        b=KZ2Tq+en8QiAlghg+llfPs5Ifm51FNXxCBp4nl6OX6cNeH0QGZ7Nr2JJBIcUc4HMYh
         ATu1aGPoiEn3KeNwZ6gEiZQUuo8HUXiy4ESjH0XWMi6mCx5rCuyY7jqxLXi/2W9/KAIx
         aVXzpHEkNzrpV7Hc0sHMGK1rw/rE8s7mcpigvJ+RExkN1OdDIIg/9OvHa1VukYTw4528
         0ORec+SgvSFowEFWHBm4oPfUNRl/UL3VPvTb8QviUdx2ZlhKP0lzgyYt7ICy3koERXWP
         7udnea9pIctYTafDphyYigWFp7qJq4YMEGpwfczA16xT2R9rb4ynkSoD9V1drmCkYsx4
         2itA==
X-Gm-Message-State: APjAAAVEPp/CeDQ6j2+CWRH20vZmGUQGc1lfrdvp9zk7SqyJK4XTbGcB
        NMvHPBtkEyO+lKPJgbfhot4GeBOZUHkXprhqXpdSbQ==
X-Google-Smtp-Source: APXvYqy7Uewn6zAItC+GMZ2f+WVeC8UEfgRobvwYN8v4AOXUExQH05Z60wiC5OEIaOPaPKeaii445bccQwSUS+J5gW8=
X-Received: by 2002:a37:274a:: with SMTP id n71mr19416460qkn.228.1556108752170;
 Wed, 24 Apr 2019 05:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <1554103457-29595-1-git-send-email-yannick.fertre@st.com> <7ff86999-02e5-ef48-221c-a5e0e61eb2fd@st.com>
In-Reply-To: <7ff86999-02e5-ef48-221c-a5e0e61eb2fd@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Wed, 24 Apr 2019 14:25:41 +0200
Message-ID: <CA+M3ks5M1NXWj1dew9DcNfOhYeFbWZ6iVYDcvQr6auVAKUnVyA@mail.gmail.com>
Subject: Re: [PATCH] drm/stm: ltdc: update planes at next vblank to avoid
 partial refresh
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

Le lun. 1 avr. 2019 =C3=A0 11:22, Philippe CORNU <philippe.cornu@st.com> a =
=C3=A9crit :
>
> Dear Yannick,
> Thank you for your patch, works fine,
>
> Acked-by: Philippe Cornu <philippe.cornu@st.com>
>
Applied on drm-misc-next,
Thanks,
Benjamin

> Philippe :-)
>
> On 4/1/19 9:24 AM, Yannick Fertr=C3=A9 wrote:
> > Plane updates must be synchronized on vblank with the shadow register m=
echanism
> > to avoid partial refresh on screen.
> >
> > Signed-off-by: Yannick Fertr=C3=A9 <yannick.fertre@st.com>
> > ---
> >   drivers/gpu/drm/stm/ltdc.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> > index b1741a9..c2d0800 100644
> > --- a/drivers/gpu/drm/stm/ltdc.c
> > +++ b/drivers/gpu/drm/stm/ltdc.c
> > @@ -426,8 +426,8 @@ static void ltdc_crtc_atomic_enable(struct drm_crtc=
 *crtc,
> >       /* Enable IRQ */
> >       reg_set(ldev->regs, LTDC_IER, IER_RRIE | IER_FUIE | IER_TERRIE);
> >
> > -     /* Immediately commit the planes */
> > -     reg_set(ldev->regs, LTDC_SRCR, SRCR_IMR);
> > +     /* Commit shadow registers =3D update planes at next vblank */
> > +     reg_set(ldev->regs, LTDC_SRCR, SRCR_VBR);
> >
> >       /* Enable LTDC */
> >       reg_set(ldev->regs, LTDC_GCR, GCR_LTDCEN);
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
