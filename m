Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D3CCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 18:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F95C2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 18:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sHOtziOe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbfJUS4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 14:56:38 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41842 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727767AbfJUS4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 14:56:37 -0400
Received: by mail-qt1-f193.google.com with SMTP id c17so19676324qtn.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 11:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9ggfZg5m+e/SKbdKVaz+2EJBpB6gy314A1ofRgLtyC4=;
        b=sHOtziOe/uYeffiWLpBcm7UFdDSyJU2iROHk4d5TPT77JdZC6ulTQIEeVd0IDAK+Mj
         v6f/dPanvhHNVtVPC0wwBka+LfgPxGul2n/EBp3q1+IpRNizaC5YNYFQl0CYNDVtiKuP
         78KsdtL9pi78NWPEnU8Yg7nbR9FLIjwCa3ufgb9ifVXVmXMDVRiMc5s3Iqqc/NHL+Num
         YF18eiS2QbMEJ21MPHyzw0ltO1k47Q7NZLSNbvd9N7ho71er69pIdAuA6ikOn0tIAEOi
         IGVTKRkA8vL1qYj5ODQJ80XjvifpSOtlWaHnsVN7QkB8/9cP7aPE/UgKlThYKm2EY3cF
         HPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9ggfZg5m+e/SKbdKVaz+2EJBpB6gy314A1ofRgLtyC4=;
        b=MvRTKgCesAldBhpwoIC3tQcqzLt0O5MV0QtZxz/7YEoexj8ryXXGHgPqr6sN2ykRfM
         eeX1tOCmw3PvTn3t/nK2PobXA4Fq1fNb05fcemWQl5U/XPuJ4ShPYeSIkmNnezwfLrW1
         BPXJ105vvksmgS2yN46YOK+oaFfgg2GY5lFQ8wRmeuz4SKKtGu3tHYHgIWkw1mnoWp/i
         mfROTZAnG8vC+W6j9FhCxMW4LPJS00ylnulGgeZSNuQgPAa5p7SvE/V1Nxv5RwQ+Ii4m
         l2+Si1pIcz3AtcwsxmvK00J4GzGJN3y8FgnOcXZBgmr62Cf85n4PwrPPjG+sL2S3m871
         OEGA==
X-Gm-Message-State: APjAAAXELFEoiOYv5BkagooFJmQAZkbA2wzUvF3y6KRFCgHifELJRAnu
        mEAzr3gwekkKEH6yIAFXzoGNU0fJqpCcTC2xYjz9kQ==
X-Google-Smtp-Source: APXvYqzM2ht6aQS8b98R/FdtvSwcASrmwF7qVZr0vWqwm0jLseX90zX2dbFhJDcHxZFUpOSC9qxx/b5KNY8AotkEAXs=
X-Received: by 2002:a0c:f702:: with SMTP id w2mr24375953qvn.111.1571684196628;
 Mon, 21 Oct 2019 11:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <20191008124254.2144-1-benjamin.gaignard@st.com>
In-Reply-To: <20191008124254.2144-1-benjamin.gaignard@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Mon, 21 Oct 2019 20:56:25 +0200
Message-ID: <CA+M3ks6TxRH4XOSn6=m16-f1RVHPuXeXtanruqEmRq2KmmCJuw@mail.gmail.com>
Subject: Re: [PATCH v2] drm: atomic helper: fix W=1 warnings
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer. 9 oct. 2019 =C3=A0 09:13, Benjamin Gaignard
<benjamin.gaignard@st.com> a =C3=A9crit :
>
> Few for_each macro set variables that are never used later which led
> to generate unused-but-set-variable warnings.
> Add (void)(foo) inside the macros to remove these warnings
>

Gentle ping,
Thanks,
Benjamin

> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  include/drm/drm_atomic.h | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
> index 927e1205d7aa..b6c73fd9f55a 100644
> --- a/include/drm/drm_atomic.h
> +++ b/include/drm/drm_atomic.h
> @@ -693,6 +693,7 @@ void drm_state_dump(struct drm_device *dev, struct dr=
m_printer *p);
>              (__i)++)                                                    =
       \
>                 for_each_if ((__state)->connectors[__i].ptr &&           =
       \
>                              ((connector) =3D (__state)->connectors[__i].=
ptr,     \
> +                            (void)(connector) /* Only to avoid unused-bu=
t-set-variable warning */, \
>                              (old_connector_state) =3D (__state)->connect=
ors[__i].old_state,      \
>                              (new_connector_state) =3D (__state)->connect=
ors[__i].new_state, 1))
>
> @@ -714,6 +715,7 @@ void drm_state_dump(struct drm_device *dev, struct dr=
m_printer *p);
>              (__i)++)                                                    =
       \
>                 for_each_if ((__state)->connectors[__i].ptr &&           =
       \
>                              ((connector) =3D (__state)->connectors[__i].=
ptr,     \
> +                            (void)(connector) /* Only to avoid unused-bu=
t-set-variable warning */, \
>                              (old_connector_state) =3D (__state)->connect=
ors[__i].old_state, 1))
>
>  /**
> @@ -734,7 +736,9 @@ void drm_state_dump(struct drm_device *dev, struct dr=
m_printer *p);
>              (__i)++)                                                    =
       \
>                 for_each_if ((__state)->connectors[__i].ptr &&           =
       \
>                              ((connector) =3D (__state)->connectors[__i].=
ptr,     \
> -                            (new_connector_state) =3D (__state)->connect=
ors[__i].new_state, 1))
> +                            (void)(connector) /* Only to avoid unused-bu=
t-set-variable warning */, \
> +                            (new_connector_state) =3D (__state)->connect=
ors[__i].new_state, \
> +                            (void)(new_connector_state) /* Only to avoid=
 unused-but-set-variable warning */, 1))
>
>  /**
>   * for_each_oldnew_crtc_in_state - iterate over all CRTCs in an atomic u=
pdate
> @@ -754,7 +758,9 @@ void drm_state_dump(struct drm_device *dev, struct dr=
m_printer *p);
>              (__i)++)                                                   \
>                 for_each_if ((__state)->crtcs[__i].ptr &&               \
>                              ((crtc) =3D (__state)->crtcs[__i].ptr,      =
 \
> +                             (void)(crtc) /* Only to avoid unused-but-se=
t-variable warning */, \
>                              (old_crtc_state) =3D (__state)->crtcs[__i].o=
ld_state, \
> +                            (void)(old_crtc_state) /* Only to avoid unus=
ed-but-set-variable warning */, \
>                              (new_crtc_state) =3D (__state)->crtcs[__i].n=
ew_state, 1))
>
>  /**
> @@ -793,7 +799,9 @@ void drm_state_dump(struct drm_device *dev, struct dr=
m_printer *p);
>              (__i)++)                                                   \
>                 for_each_if ((__state)->crtcs[__i].ptr &&               \
>                              ((crtc) =3D (__state)->crtcs[__i].ptr,      =
 \
> -                            (new_crtc_state) =3D (__state)->crtcs[__i].n=
ew_state, 1))
> +                            (void)(crtc) /* Only to avoid unused-but-set=
-variable warning */, \
> +                            (new_crtc_state) =3D (__state)->crtcs[__i].n=
ew_state, \
> +                            (void)(new_crtc_state) /* Only to avoid unus=
ed-but-set-variable warning */, 1))
>
>  /**
>   * for_each_oldnew_plane_in_state - iterate over all planes in an atomic=
 update
> @@ -813,6 +821,7 @@ void drm_state_dump(struct drm_device *dev, struct dr=
m_printer *p);
>              (__i)++)                                                   \
>                 for_each_if ((__state)->planes[__i].ptr &&              \
>                              ((plane) =3D (__state)->planes[__i].ptr,    =
 \
> +                             (void)(plane) /* Only to avoid unused-but-s=
et-variable warning */, \
>                               (old_plane_state) =3D (__state)->planes[__i=
].old_state,\
>                               (new_plane_state) =3D (__state)->planes[__i=
].new_state, 1))
>
> @@ -873,7 +882,9 @@ void drm_state_dump(struct drm_device *dev, struct dr=
m_printer *p);
>              (__i)++)                                                   \
>                 for_each_if ((__state)->planes[__i].ptr &&              \
>                              ((plane) =3D (__state)->planes[__i].ptr,    =
 \
> -                             (new_plane_state) =3D (__state)->planes[__i=
].new_state, 1))
> +                             (void)(plane) /* Only to avoid unused-but-s=
et-variable warning */, \
> +                             (new_plane_state) =3D (__state)->planes[__i=
].new_state, \
> +                             (void)(new_plane_state) /* Only to avoid un=
used-but-set-variable warning */, 1))
>
>  /**
>   * for_each_oldnew_private_obj_in_state - iterate over all private objec=
ts in an atomic update
> --
> 2.15.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
