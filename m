Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FF9C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2449520678
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jGVE6epl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733023AbfIPNPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 09:15:31 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33106 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732802AbfIPNPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 09:15:30 -0400
Received: by mail-qt1-f195.google.com with SMTP id r5so43212040qtd.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 06:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+fV1kEmfM8cVIpyb9XMeB/4+z5VrvBSg3jb/39zi3bA=;
        b=jGVE6eplE7FjWUdSKuZIu9TLMcAcpzQszMWLi+CCMLNK/Y26NoDgKDuyPfIdmNiQuC
         VtNi2vlIfT6fDB5+LqA5d5RTFxzRYVBGSAWnYgk5N7lpronpxT0tNyDF6wsC8FmVw27f
         f3MvbxbL3Ot8Tzx7JAPlRDgC33RUtsqfV8yN75x7xTcOt3olhW9P3/vcLwa2E75q69ik
         A7w1dDY4hF5ltTqEoJlGbRsdzghD4hag6ej16j9VXddnRa3OdaZHMFZQXApyIQrmoMym
         vG7oSQudGh3LqdN5TKcow+uP2pZaWzOZSyaRHqTMDMFwKBLaklxiYHXwKHwwShRE3WmN
         Rr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+fV1kEmfM8cVIpyb9XMeB/4+z5VrvBSg3jb/39zi3bA=;
        b=Q1yJmBxEiYtRf8jd+Ga149/HrzIM3ZfwKNKzJcE3iC0Zm65oCtLVK5wfJ+iiA0sO4z
         a5eDsjHQzto3HxviNHCgfk12f0SCuQYDhSFpivMel7iTzsyF+H9ykEWEofI2o3AlFtbb
         04oV4gt1LGzpAY0mIcYTp/gKYJGSA1Le5W8UeeBPZaSSY/OXZ/cAf9pNPYmjRblEnn8J
         nmHNEtT3cyALNlgGzIMo6yKFCtow/sBPjFCcKIPqXcKutyg5NGPWJDjCF9gXfe5IqIID
         UA76l82A1ZirgojIbfDL1I1WdvnoUROkAmM7yWZuTaALeDp8LcpyNRo0b+JX+HVAK+Jm
         E8/w==
X-Gm-Message-State: APjAAAU+feYoDTGedpQtRchG3sGtJT7QrsB9u42xmcb6CA0M/5GqTaAU
        i7b302J1keonZAgn7Jw3bkqBo1e3FTUouJ7qLR1/eg==
X-Google-Smtp-Source: APXvYqxtKYMb78EesGF1ldt6P+E8nLIICCaPO5lad+W++K7ZDdSqS3r3ZKDChi98RmuHxDrGblaZaUN4r0zIVYB20mI=
X-Received: by 2002:ac8:60d6:: with SMTP id i22mr17110622qtm.250.1568639729842;
 Mon, 16 Sep 2019 06:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190911084759.6946-1-benjamin.gaignard@st.com> <8235afe0-1796-1647-8a39-84ab354e290a@amd.com>
In-Reply-To: <8235afe0-1796-1647-8a39-84ab354e290a@amd.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Mon, 16 Sep 2019 15:15:18 +0200
Message-ID: <CA+M3ks7kUjQB0ZkHmugWZt6fUA7ytQcjXu8G9pDFejQpdyNxcw@mail.gmail.com>
Subject: Re: [PATCH] drm: fix warnings in DSC
To:     Harry Wentland <hwentlan@amd.com>
Cc:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "manasi.d.navare@intel.com" <manasi.d.navare@intel.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer. 11 sept. 2019 =C3=A0 15:41, Harry Wentland <hwentlan@amd.com> a =C3=
=A9crit :
>
> On 2019-09-11 4:47 a.m., Benjamin Gaignard wrote:
> > Remove always false comparisons due to limited range of nfl_bpg_offset
> > and scale_increment_interval fields.
> > Warnings detected when compiling with W=3D1.
> >
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Applied on drm-misc-next
Thanks,
Benjamin

>
> Harry
>
> > ---
> >  drivers/gpu/drm/drm_dsc.c | 11 -----------
> >  1 file changed, 11 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_dsc.c b/drivers/gpu/drm/drm_dsc.c
> > index 77f4e5ae4197..27e5c6036658 100644
> > --- a/drivers/gpu/drm/drm_dsc.c
> > +++ b/drivers/gpu/drm/drm_dsc.c
> > @@ -336,12 +336,6 @@ int drm_dsc_compute_rc_parameters(struct drm_dsc_c=
onfig *vdsc_cfg)
> >       else
> >               vdsc_cfg->nfl_bpg_offset =3D 0;
> >
> > -     /* 2^16 - 1 */
> > -     if (vdsc_cfg->nfl_bpg_offset > 65535) {
> > -             DRM_DEBUG_KMS("NflBpgOffset is too large for this slice h=
eight\n");
> > -             return -ERANGE;
> > -     }
> > -
> >       /* Number of groups used to code the entire slice */
> >       groups_total =3D groups_per_line * vdsc_cfg->slice_height;
> >
> > @@ -371,11 +365,6 @@ int drm_dsc_compute_rc_parameters(struct drm_dsc_c=
onfig *vdsc_cfg)
> >               vdsc_cfg->scale_increment_interval =3D 0;
> >       }
> >
> > -     if (vdsc_cfg->scale_increment_interval > 65535) {
> > -             DRM_DEBUG_KMS("ScaleIncrementInterval is large for slice =
height\n");
> > -             return -ERANGE;
> > -     }
> > -
> >       /*
> >        * DSC spec mentions that bits_per_pixel specifies the target
> >        * bits/pixel (bpp) rate that is used by the encoder,
> >
