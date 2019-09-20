Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE340C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 20:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9447420B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 20:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="liCM9nAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbfITUW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 16:22:58 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39338 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729943AbfITUW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 16:22:58 -0400
Received: by mail-ed1-f67.google.com with SMTP id a15so4914597edt.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 13:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h7BiFEPr6i2z1i+pS9YVOr9uD6I+CcNi47gOZAMaFAE=;
        b=liCM9nAEDr7Gr8QClveC6J+S79HCWVXIGBasnLKSVkdl+APVU2MCw2m8v1CzztgsSB
         jV8amWhYyF85BndLq6ycNdOVYhEKnDdxnISMMcjWcyPgmyg3+ei0CkJ9rDYP2iLFGBr+
         ugwotT82GAMMg6hf1X2VTCua1p63E28ZZZMDsp0HND2NfbKd3Qjnz+EyRsC5CmfuDFet
         N8vNNfc8afp+ZyUc2kxRrAA1JIuWerjr/o6qbGIEAh/ww6itLhAqRTw4LmUGNiS7HFsX
         vTP3C4oksB3bvgUwomMjiIj7ivIhW0RLGWtk09OxGBaldN926WUdbhVw89XBNwTqUXRj
         1kPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h7BiFEPr6i2z1i+pS9YVOr9uD6I+CcNi47gOZAMaFAE=;
        b=XaShinl8qb0k2BNcMTnB0l6QJsTfGA9ksUY/Pmz+kjzGMjoudu+pBvfFiI+RWCuYRN
         +eYNYfNCu9knXfTQtaY4eLfUKjAdpjpayGkDVwzF535xhk5TVBAS1UnXITw5m0odqfk4
         57gHzLgIZdHSdI+B0PhW0NyU1E7UVNOxSafV1tML9BrlruMIHVwaHPg35TsryHFPITi7
         lcMvXFubcV+QrjfgEeR4CG5mXTxHlpXkta1DcBo1dycC0yMPVoRs1KBl27rf1qirpcgR
         nx9G2CnYIESHnAKRkOO/5E30YqyJFaHm8ZxbqmLj7FSUB/xuxGE6s6a+3vGOHlYmS3QE
         JymA==
X-Gm-Message-State: APjAAAXQl2sKRnNsHseFxlcjEhyw7f5fJPW+f/junqKWf93RdOp9UQO3
        I5IQeiWX2GRzrcRppr2gJ4n+Y2AYhreeY8WW/xDHXg==
X-Google-Smtp-Source: APXvYqyZ6XcE8G2zZNhRFLWq4H1A60w6Pa1SLGVXlR9A6Djwejt0ptIcJHhDbV4C+IRf0Ac+43I9tOdzbXtBRRJvkOM=
X-Received: by 2002:a05:6402:1a45:: with SMTP id bf5mr23501603edb.275.1569010975439;
 Fri, 20 Sep 2019 13:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190918110541.38124-1-roman.stratiienko@globallogic.com> <9229663.7SG9YZCNdo@jernej-laptop>
In-Reply-To: <9229663.7SG9YZCNdo@jernej-laptop>
From:   Roman Stratiienko <roman.stratiienko@globallogic.com>
Date:   Fri, 20 Sep 2019 23:22:44 +0300
Message-ID: <CAODwZ7uonAyhJAwZ+NFm_aHzC1Rzp=NyhQCu1h_85ecRxZ50cw@mail.gmail.com>
Subject: Re: drm/sun4i: Add missing pixel formats to the vi layer
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 9:53 PM Jernej =C5=A0krabec <jernej.skrabec@siol.ne=
t> wrote:
>
> Hi!
>
> Dne sreda, 18. september 2019 ob 13:05:41 CEST je
> roman.stratiienko@globallogic.com napisal(a):
> > From: Roman Stratiienko <roman.stratiienko@globallogic.com>
> >
> > According to Allwinner DE2.0 Specification REV 1.0, vi layer supports t=
he
> > following pixel formats:  ABGR_8888, ARGB_8888, BGRA_8888, RGBA_8888
>
> It's true that DE2 VI layers support those formats, but it wouldn't chang=
e
> anything because alpha blending is not supported by those planes. These
> formats were deliberately left out because their counterparts without alp=
ha
> exist, for example ABGR8888 <-> XBGR8888. It would also confuse user, whi=
ch
> would expect that alpha blending works if format with alpha channel is
> selected.
>
> Admittedly some formats with alpha are still reported as supported due to=
 lack
> of their counterparts without alpha, but I'm fine with removing them for
> consistency.

Why not to replace 'A' with 'X' on all relevant formats and map them
to corresponding index marked with 'A' (that behaves as true 'X' for
vi)

>
> Best regards,
> Jernej
>
> >
> > Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
> > ---
> >  drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> > b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c index bd0e6a52d1d8..07c27e6a4b=
77
> > 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> > +++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> > @@ -404,17 +404,21 @@ static const struct drm_plane_funcs
> > sun8i_vi_layer_funcs =3D { static const u32 sun8i_vi_layer_formats[] =
=3D {
> >       DRM_FORMAT_ABGR1555,
> >       DRM_FORMAT_ABGR4444,
> > +     DRM_FORMAT_ABGR8888,
> >       DRM_FORMAT_ARGB1555,
> >       DRM_FORMAT_ARGB4444,
> > +     DRM_FORMAT_ARGB8888,
> >       DRM_FORMAT_BGR565,
> >       DRM_FORMAT_BGR888,
> >       DRM_FORMAT_BGRA5551,
> >       DRM_FORMAT_BGRA4444,
> > +     DRM_FORMAT_BGRA8888,
> >       DRM_FORMAT_BGRX8888,
> >       DRM_FORMAT_RGB565,
> >       DRM_FORMAT_RGB888,
> >       DRM_FORMAT_RGBA4444,
> >       DRM_FORMAT_RGBA5551,
> > +     DRM_FORMAT_RGBA8888,
> >       DRM_FORMAT_RGBX8888,
> >       DRM_FORMAT_XBGR8888,
> >       DRM_FORMAT_XRGB8888,
>
>
>
>


--=20
Best regards,
Roman Stratiienko
Global Logic Inc.
