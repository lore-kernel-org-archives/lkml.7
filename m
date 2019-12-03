Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB08C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61CDE206EC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W+ZWlwnw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfLCQuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 11:50:12 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33393 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfLCQuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 11:50:11 -0500
Received: by mail-qk1-f193.google.com with SMTP id c124so4133252qkg.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 08:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a9/PBomxUuzf05dVa0qKQjlWzeKSr/09qta+lJxPwCo=;
        b=W+ZWlwnwP8+cRP6PtLMf9H9SyirlbdAZ6JnCoz9a4ikMgXcfKrMmOP6g0nedHY+NHS
         hD6BM99v4GDrfxxsEUDE2K5Z7yDS883J3EzLLoCx38I1pcXiWmC+FeAhTKDuQiChYcL0
         VS5e3EPlPZHcawDb0kJ2d++QzTVz4PsCiHEQpg16kOMhm8DlemOxp4MgrqjSD/odc6Oe
         5HG/2QSKWFi7QZcTxNnaiMbIu2aCbbGz4ZxGMiDfGxGi3B9bxBOeZoI+n1Q4Y61+I/ME
         b+KbU19jcWEGxTnDo862eoaaXCvaAMvgWX76bbuV7hJUgs6dduuxywcZ5KibsmrYlnyy
         YgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a9/PBomxUuzf05dVa0qKQjlWzeKSr/09qta+lJxPwCo=;
        b=SwhiRO4j9TR9J46nQzYwHz4B44Ov4ZRQMD3CcXx7+GfqO8A2ePyg+uqfLsBn3oT2bg
         d1+4+7MLxy0tX+qarJQAEyKfiIwZJYlZDVHeJCkkmJ7bLxpeOFvRfiF3pdm+RzVWCjgV
         amYh0B0uPF3nIFe883KnEN6DF2IYHAB3DUum5NwRlkmYlSTOhA/ei8c/ZMB3eJei0f1c
         frRisejopZU2LLaTD34g8cPfrfgtaJ7DMXLOGE7mOZGueB2EUnN25DVBoLO5TOOlbbrA
         epHgCacfXN/c1VeLjb5QdVONcDG/zU7D5VZcyLWgVuFexrVhX6sbdByGVYIgMALXjTn6
         BSzA==
X-Gm-Message-State: APjAAAXAx6mVUQY4+w3TNBbjkK3kppas04xy/eLIQz+SCHhmH6euIEme
        vlp0GLpf8KjKA8ESQR6cGKQBfS08gwtkUwhR/oGxiA==
X-Google-Smtp-Source: APXvYqyyMSapp57PMKRK9e7v/eq30nlueUFP+6Kk+2LK/nnTcOGxgsOUzP7MRoCBv1l3I+FaZJfyM1xV+rQ9cjpaRAQ=
X-Received: by 2002:a37:6087:: with SMTP id u129mr5948252qkb.219.1575391810641;
 Tue, 03 Dec 2019 08:50:10 -0800 (PST)
MIME-Version: 1.0
References: <20191119134706.10893-1-benjamin.gaignard@st.com>
In-Reply-To: <20191119134706.10893-1-benjamin.gaignard@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Tue, 3 Dec 2019 17:50:00 +0100
Message-ID: <CA+M3ks7gN7kpau1hN94vq0nhOfdc=9KFoSrM4TJE_2diyMMiRA@mail.gmail.com>
Subject: Re: [PATCH] drm/modes: remove unused variables
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer. 20 nov. 2019 =C3=A0 00:29, Benjamin Gaignard
<benjamin.gaignard@st.com> a =C3=A9crit :
>
> When compiling with W=3D1 few warnings about unused variables show up.
> This patch removes all the involved variables.
>

Gentle ping to reviewers.
Thanks,
Benjamin

> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  drivers/gpu/drm/drm_modes.c | 22 +++-------------------
>  1 file changed, 3 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
> index 88232698d7a0..aca901aff042 100644
> --- a/drivers/gpu/drm/drm_modes.c
> +++ b/drivers/gpu/drm/drm_modes.c
> @@ -233,7 +233,7 @@ struct drm_display_mode *drm_cvt_mode(struct drm_devi=
ce *dev, int hdisplay,
>                 /* 3) Nominal HSync width (% of line period) - default 8 =
*/
>  #define CVT_HSYNC_PERCENTAGE   8
>                 unsigned int hblank_percentage;
> -               int vsyncandback_porch, vback_porch, hblank;
> +               int vsyncandback_porch, hblank;
>
>                 /* estimated the horizontal period */
>                 tmp1 =3D HV_FACTOR * 1000000  -
> @@ -249,7 +249,6 @@ struct drm_display_mode *drm_cvt_mode(struct drm_devi=
ce *dev, int hdisplay,
>                 else
>                         vsyncandback_porch =3D tmp1;
>                 /* 10. Find number of lines in back porch */
> -               vback_porch =3D vsyncandback_porch - vsync;
>                 drm_mode->vtotal =3D vdisplay_rnd + 2 * vmargin +
>                                 vsyncandback_porch + CVT_MIN_V_PORCH;
>                 /* 5) Definition of Horizontal blanking time limitation *=
/
> @@ -386,9 +385,8 @@ drm_gtf_mode_complex(struct drm_device *dev, int hdis=
play, int vdisplay,
>         int top_margin, bottom_margin;
>         int interlace;
>         unsigned int hfreq_est;
> -       int vsync_plus_bp, vback_porch;
> -       unsigned int vtotal_lines, vfieldrate_est, hperiod;
> -       unsigned int vfield_rate, vframe_rate;
> +       int vsync_plus_bp;
> +       unsigned int vtotal_lines;
>         int left_margin, right_margin;
>         unsigned int total_active_pixels, ideal_duty_cycle;
>         unsigned int hblank, total_pixels, pixel_freq;
> @@ -451,23 +449,9 @@ drm_gtf_mode_complex(struct drm_device *dev, int hdi=
splay, int vdisplay,
>         /* [V SYNC+BP] =3D RINT(([MIN VSYNC+BP] * hfreq_est / 1000000)) *=
/
>         vsync_plus_bp =3D MIN_VSYNC_PLUS_BP * hfreq_est / 1000;
>         vsync_plus_bp =3D (vsync_plus_bp + 500) / 1000;
> -       /*  9. Find the number of lines in V back porch alone: */
> -       vback_porch =3D vsync_plus_bp - V_SYNC_RQD;
>         /*  10. Find the total number of lines in Vertical field period: =
*/
>         vtotal_lines =3D vdisplay_rnd + top_margin + bottom_margin +
>                         vsync_plus_bp + GTF_MIN_V_PORCH;
> -       /*  11. Estimate the Vertical field frequency: */
> -       vfieldrate_est =3D hfreq_est / vtotal_lines;
> -       /*  12. Find the actual horizontal period: */
> -       hperiod =3D 1000000 / (vfieldrate_rqd * vtotal_lines);
> -
> -       /*  13. Find the actual Vertical field frequency: */
> -       vfield_rate =3D hfreq_est / vtotal_lines;
> -       /*  14. Find the Vertical frame frequency: */
> -       if (interlaced)
> -               vframe_rate =3D vfield_rate / 2;
> -       else
> -               vframe_rate =3D vfield_rate;
>         /*  15. Find number of pixels in left margin: */
>         if (margins)
>                 left_margin =3D (hdisplay_rnd * GTF_MARGIN_PERCENTAGE + 5=
00) /
> --
> 2.15.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
