Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97D5C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916BF2187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U80+8TTY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387880AbfKGKK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 05:10:58 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46198 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbfKGKK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 05:10:58 -0500
Received: by mail-qk1-f194.google.com with SMTP id h15so1408393qka.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 02:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Ns688Up2hd4d1aAqhD9KmzeBd9oma7gtdEecIkU5Nlw=;
        b=U80+8TTY38GfaDf+u89n1ZYcfmrIt2g/pyRBOjOpWfoAArS63FnYbhCvQeCAC5b3HN
         7UN6OPk6fng+hxcfD6fZJrSbdWe7kQ6JSogqIMd0lJ3ofOU67tBKdSpnBOKyxtxXugrx
         hGaUZCJjT8xsehhpTm5n48vohWN1G/uttUvg5W9VHv8+HlD0A6xm4RX35Idxfr9uC3gB
         SqtoK+2aZBChATeOA8f4ZV9FzxAkS11Aw/369P8HfUMUHuioSxvxQlDX/6VIcsndoG/p
         E9mk7y8uPNBms02whwzWtU+BZs0Y311n3ZyvlXqykXbT4iCxGw56npbrmZwrnSeZ553O
         Hdmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=Ns688Up2hd4d1aAqhD9KmzeBd9oma7gtdEecIkU5Nlw=;
        b=Hor1Ppr76W0ch46wp1dr7uEsrn77+EmBhJ+T/KHFzlBf0ghq/7IeEpqDkqwF/2lnHe
         Zjp0vIJcZXL9S0ZyxZW7mruXjUzdKiRRXUOmHboANGLYiFII6tlUm2PNX+Hg2FzOXsE2
         ap3vGSGS9OfrY2o2zd3paW+bLMQONtOq0vAdcrR4PBc5KCF8tpmEvEx67zbxKRGmj5y5
         0D5h9uBY1UREer7Ox427GmW/QrdD6/R6pEiZUXbqr32ZNrpQy521z8ZNNnvubNRu9w+/
         C9vn34bzu9W44fRs5dVsDI6f6PpIM6sPIcuKwgrxivWXM6uiUR7dIJzbsJqIGYcwRziE
         q3UA==
X-Gm-Message-State: APjAAAV1i5MuVpI2/bMPKxEmXiWwppOp6ezq2Hd/4+x3Hr57zCKTgSy2
        svYz/f7ztrdtXzmGlremaC4V1Dp3+JvvBYcsh1/t7w==
X-Google-Smtp-Source: APXvYqwPp+8m52hiC7BBCUplEIwCNWeBzfemku9J7M7HfLLNBJS9JJdfoPOP4dl7Cv/thpF1DKi61pvPWm6iENFVcn4=
X-Received: by 2002:a37:6087:: with SMTP id u129mr1912331qkb.219.1573121455541;
 Thu, 07 Nov 2019 02:10:55 -0800 (PST)
MIME-Version: 1.0
References: <20191008124254.2144-1-benjamin.gaignard@st.com> <20191022083725.GW11828@phenom.ffwll.local>
In-Reply-To: <20191022083725.GW11828@phenom.ffwll.local>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Thu, 7 Nov 2019 11:10:44 +0100
Message-ID: <CA+M3ks7u7SOzYc-qgiefcG-Lvj6eP=VpJt2-h2JzGmd4K-ZqdQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm: atomic helper: fix W=1 warnings
To:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        David Airlie <airlied@linux.ie>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mar. 22 oct. 2019 =C3=A0 10:37, Daniel Vetter <daniel@ffwll.ch> a =C3=A9=
crit :
>
> On Tue, Oct 08, 2019 at 02:42:54PM +0200, Benjamin Gaignard wrote:
> > Few for_each macro set variables that are never used later which led
> > to generate unused-but-set-variable warnings.
> > Add (void)(foo) inside the macros to remove these warnings
> >
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>
> OCD in me would lean towards annotating all of them, unconditionally, and
> be done. But I guess this works too. Either way:
>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Thanks,

Applied to drm-misc-next
Benjamin

> > ---
> >  include/drm/drm_atomic.h | 17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
> > index 927e1205d7aa..b6c73fd9f55a 100644
> > --- a/include/drm/drm_atomic.h
> > +++ b/include/drm/drm_atomic.h
> > @@ -693,6 +693,7 @@ void drm_state_dump(struct drm_device *dev, struct =
drm_printer *p);
> >            (__i)++)                                                    =
       \
> >               for_each_if ((__state)->connectors[__i].ptr &&           =
       \
> >                            ((connector) =3D (__state)->connectors[__i].=
ptr,     \
> > +                          (void)(connector) /* Only to avoid unused-bu=
t-set-variable warning */, \
> >                            (old_connector_state) =3D (__state)->connect=
ors[__i].old_state,      \
> >                            (new_connector_state) =3D (__state)->connect=
ors[__i].new_state, 1))
> >
> > @@ -714,6 +715,7 @@ void drm_state_dump(struct drm_device *dev, struct =
drm_printer *p);
> >            (__i)++)                                                    =
       \
> >               for_each_if ((__state)->connectors[__i].ptr &&           =
       \
> >                            ((connector) =3D (__state)->connectors[__i].=
ptr,     \
> > +                          (void)(connector) /* Only to avoid unused-bu=
t-set-variable warning */, \
> >                            (old_connector_state) =3D (__state)->connect=
ors[__i].old_state, 1))
> >
> >  /**
> > @@ -734,7 +736,9 @@ void drm_state_dump(struct drm_device *dev, struct =
drm_printer *p);
> >            (__i)++)                                                    =
       \
> >               for_each_if ((__state)->connectors[__i].ptr &&           =
       \
> >                            ((connector) =3D (__state)->connectors[__i].=
ptr,     \
> > -                          (new_connector_state) =3D (__state)->connect=
ors[__i].new_state, 1))
> > +                          (void)(connector) /* Only to avoid unused-bu=
t-set-variable warning */, \
> > +                          (new_connector_state) =3D (__state)->connect=
ors[__i].new_state, \
> > +                          (void)(new_connector_state) /* Only to avoid=
 unused-but-set-variable warning */, 1))
> >
> >  /**
> >   * for_each_oldnew_crtc_in_state - iterate over all CRTCs in an atomic=
 update
> > @@ -754,7 +758,9 @@ void drm_state_dump(struct drm_device *dev, struct =
drm_printer *p);
> >            (__i)++)                                                   \
> >               for_each_if ((__state)->crtcs[__i].ptr &&               \
> >                            ((crtc) =3D (__state)->crtcs[__i].ptr,      =
 \
> > +                           (void)(crtc) /* Only to avoid unused-but-se=
t-variable warning */, \
> >                            (old_crtc_state) =3D (__state)->crtcs[__i].o=
ld_state, \
> > +                          (void)(old_crtc_state) /* Only to avoid unus=
ed-but-set-variable warning */, \
> >                            (new_crtc_state) =3D (__state)->crtcs[__i].n=
ew_state, 1))
> >
> >  /**
> > @@ -793,7 +799,9 @@ void drm_state_dump(struct drm_device *dev, struct =
drm_printer *p);
> >            (__i)++)                                                   \
> >               for_each_if ((__state)->crtcs[__i].ptr &&               \
> >                            ((crtc) =3D (__state)->crtcs[__i].ptr,      =
 \
> > -                          (new_crtc_state) =3D (__state)->crtcs[__i].n=
ew_state, 1))
> > +                          (void)(crtc) /* Only to avoid unused-but-set=
-variable warning */, \
> > +                          (new_crtc_state) =3D (__state)->crtcs[__i].n=
ew_state, \
> > +                          (void)(new_crtc_state) /* Only to avoid unus=
ed-but-set-variable warning */, 1))
> >
> >  /**
> >   * for_each_oldnew_plane_in_state - iterate over all planes in an atom=
ic update
> > @@ -813,6 +821,7 @@ void drm_state_dump(struct drm_device *dev, struct =
drm_printer *p);
> >            (__i)++)                                                   \
> >               for_each_if ((__state)->planes[__i].ptr &&              \
> >                            ((plane) =3D (__state)->planes[__i].ptr,    =
 \
> > +                           (void)(plane) /* Only to avoid unused-but-s=
et-variable warning */, \
> >                             (old_plane_state) =3D (__state)->planes[__i=
].old_state,\
> >                             (new_plane_state) =3D (__state)->planes[__i=
].new_state, 1))
> >
> > @@ -873,7 +882,9 @@ void drm_state_dump(struct drm_device *dev, struct =
drm_printer *p);
> >            (__i)++)                                                   \
> >               for_each_if ((__state)->planes[__i].ptr &&              \
> >                            ((plane) =3D (__state)->planes[__i].ptr,    =
 \
> > -                           (new_plane_state) =3D (__state)->planes[__i=
].new_state, 1))
> > +                           (void)(plane) /* Only to avoid unused-but-s=
et-variable warning */, \
> > +                           (new_plane_state) =3D (__state)->planes[__i=
].new_state, \
> > +                           (void)(new_plane_state) /* Only to avoid un=
used-but-set-variable warning */, 1))
> >
> >  /**
> >   * for_each_oldnew_private_obj_in_state - iterate over all private obj=
ects in an atomic update
> > --
> > 2.15.0
> >
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
