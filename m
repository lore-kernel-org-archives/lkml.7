Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97695C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 07:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE9820717
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 07:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xof57xMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfE1Hal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 03:30:41 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44687 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbfE1Hak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 03:30:40 -0400
Received: by mail-qk1-f194.google.com with SMTP id w187so10775581qkb.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 00:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=liX278HTgn3dzodp7H0O3yv5Xch4o5IxEkhO3Idcuvw=;
        b=Xof57xMef9rhMVvwdzWqgl8c8PWB/Qq5WaAyj1db7xil+fDCj2i2m2YnoW8pKwTFyW
         2fV5WVtAWhMVaj64Iuj3Xg8EqCSIHF9C1lbxhu3ktohEZLkh788n0+WGOtLwsRx5rSSB
         idqXNx8jf21nLRjVkPZziJlecnNAnwLPmW96STeBbUTLipuKTqsP7RhQL0Ob3lS65mkx
         UfHomb1WgXBlgs+mcjx1y7MMHVGLMi62Y+rgLWH1eZYzKN7d8r65fCXeTVeX7ZVuzXCK
         RD9+LjBiqfsMx6BBjE4DmFkIMgoU4pUkbXkfAC55Nl4lss1Qn+wXSgeO8/o6OXFjcjzP
         qjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=liX278HTgn3dzodp7H0O3yv5Xch4o5IxEkhO3Idcuvw=;
        b=j2sTHYpUkxjWgCFnfdZuT4vrp3SgqHkpw/Csh6SvTrGTA8WC5bD+XQhbktQky8VVS9
         lbe/0Ih8HiwBQ4y2i1ht6zfSmMR8I3+dhYXOoMYOVWxuaps9sNmk8wPGFl3Zy8JUk+d3
         JNI312o7l6D9vrOjz9hDioTH5BlQw9CPH+gclca6o9UzNALvlH9h6KP87h2pe2OopiLr
         6VM5Gb3SXNZ3iOQ2qyx0hyWP6mbFcjPp3I2aR0STE401hBnToOyQvyLC7/LOJnyh1JRE
         mDH4zDm2ijnxMvs/g01iisyl5wIeAzck8tLg06kByqFpBn0BdlU+b8HxDyYOOpbWLLbU
         AcAw==
X-Gm-Message-State: APjAAAVdQLafXTbfcZuXPyLoBa4qsLJQvlKziB+Wh2BwYaCbCsrA8ZBV
        oxa2j3oN2EhASjbOSfhQa9uAAY/AGnhDIatTj+ctGA==
X-Google-Smtp-Source: APXvYqw/o9g3j0+8QuWo1gdBVqYhqsgNj/cyEh5sq/3CNJ6H80Oh+b9UbNvS2HHUMZy5yppiywgVa8gezanxUHTOGjg=
X-Received: by 2002:a37:502:: with SMTP id 2mr3621845qkf.93.1559028639303;
 Tue, 28 May 2019 00:30:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190527115830.15836-1-benjamin.gaignard@st.com> <1e4c4cbf-869e-8b6a-a1d6-cc7dccb2515a@st.com>
In-Reply-To: <1e4c4cbf-869e-8b6a-a1d6-cc7dccb2515a@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Tue, 28 May 2019 09:30:28 +0200
Message-ID: <CA+M3ks5UxZ0iugtR_zJPshtC=HAjoAzTPmu6oxt7BQWTuj203Q@mail.gmail.com>
Subject: Re: [PATCH] drm/stm: ltdc: restore calls to clk_{enable/disable}
To:     Philippe CORNU <philippe.cornu@st.com>
Cc:     Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Yannick FERTRE <yannick.fertre@st.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lun. 27 mai 2019 =C3=A0 14:28, Philippe CORNU <philippe.cornu@st.com> a =
=C3=A9crit :
>
> Hi Benjamin,
>
> Many thanks for this fix (and more generally for pushing STM patches on
> misc :-)
>
> Acked-by: Philippe Cornu <philippe.cornu@st.com>

Applied on drm-misc-next,
sorry for the mistake.

Benjamin
>
> Philippe :-)
>
> On 5/27/19 1:58 PM, Benjamin Gaignard wrote:
> > From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> >
> > Restore calls to clk_{enable/disable} deleted after applying the wrong
> > version of the patch
> >
> > Fixes: fd6905fca4f0 ("drm/stm: ltdc: remove clk_round_rate comment")
> >
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> > ---
> >   drivers/gpu/drm/stm/ltdc.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> > index ae2aaf2a62ee..ac29890edeb6 100644
> > --- a/drivers/gpu/drm/stm/ltdc.c
> > +++ b/drivers/gpu/drm/stm/ltdc.c
> > @@ -507,10 +507,12 @@ static bool ltdc_crtc_mode_fixup(struct drm_crtc =
*crtc,
> >       struct ltdc_device *ldev =3D crtc_to_ltdc(crtc);
> >       int rate =3D mode->clock * 1000;
> >
> > +     clk_disable(ldev->pixel_clk);
> >       if (clk_set_rate(ldev->pixel_clk, rate) < 0) {
> >               DRM_ERROR("Cannot set rate (%dHz) for pixel clk\n", rate)=
;
> >               return false;
> >       }
> > +     clk_enable(ldev->pixel_clk);
> >
> >       adjusted_mode->clock =3D clk_get_rate(ldev->pixel_clk) / 1000;
> >
> >
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
