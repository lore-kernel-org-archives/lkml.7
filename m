Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9899C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766D2206EC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BoozgF3o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfLCQtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 11:49:50 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:40950 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfLCQtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 11:49:49 -0500
Received: by mail-qv1-f67.google.com with SMTP id i3so1793751qvv.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 08:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=104Kfz5fD0oiM2Sm+DE5Ex5aiOvtQWaAUuITWsQPfe0=;
        b=BoozgF3oMa3hbp8E3+PrWRBCAnTGV/9mclA8n9N2uQ6CCpndb6XChQolCXQc8qX9Zc
         d7kh/uiilaB/ec8fZ6SEQ7ImGTwmOZLues3YqcycSa7EUZp4SyByXa0/66/rojimla1o
         Kli0p7F7i0ijhOLiDUmbPJvuFZYqYVTHAALrt/VCqF3FC/HRqctY7Jhkh8bcQkcWWhAW
         ExAaXaeqPsY1a+ngxtVgxlHNQjclaI/7+jCpTWJI2hYm35jUZLYjPyPUvHrwndsNc5F1
         53p5CXBVVoiIoNq5pIbXZasotRnIoVZcoXA3Pwvewi1Q4uGiPWwHaB6Vom72ZfvJuK7A
         5NWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=104Kfz5fD0oiM2Sm+DE5Ex5aiOvtQWaAUuITWsQPfe0=;
        b=Vw2KfiqiddSO0OipZu9+erAgTWI3kCovMVxyBDjLrGi5y9SB22RxE3bdrXXfjpOVjC
         X8fxJz9B0lCciOUWFKC1bATkTDD97HVpV0b23XQsb7QSggNrVyu4pUetr+ay2Kyb25Jc
         P8Sg25bS6LnBQW+OCgrTd7XfGNqKPPDcm/fG6yfrzoK0CdYOfer3cMkNhCx28R1rIQML
         yBmndruvDDH3vyxwBKNRks6wHYla7CGH5O48lUE2zUDlAbBIFFOnyirhXKe8fHuFPn2Y
         MtJB80ZBcH/NPOQDLZfruwFkwf4FiGXmOgS9tV64AYc1HAenB4Hko7u1sBly0O8zwsnE
         YLLA==
X-Gm-Message-State: APjAAAWPnST+JpKo1Ecw8mwZQLCO8SCNqikynAKLCxsms5eRKGh9XQeX
        OM/lEXweu3Cs0/uzsPAOouHEtHt2V9nYT4UmHbGKpA==
X-Google-Smtp-Source: APXvYqw789kzB7L+yI5BNbFst52LP0TMv05Fld0WPEiCmHmmiS5hGECTrBK2NxcJ75kkVtV98yHGdkULS4yGDX4RoI4=
X-Received: by 2002:a0c:e806:: with SMTP id y6mr5989614qvn.148.1575391788850;
 Tue, 03 Dec 2019 08:49:48 -0800 (PST)
MIME-Version: 1.0
References: <20191119105753.32363-1-benjamin.gaignard@st.com>
In-Reply-To: <20191119105753.32363-1-benjamin.gaignard@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Tue, 3 Dec 2019 17:49:37 +0100
Message-ID: <CA+M3ks7C+_B+4Jxy+55bFoWct7j=WseoPKxxh7KLOZ0LhEUL7Q@mail.gmail.com>
Subject: Re: [PATCH] drm/fb-cma-helpers: Fix include issue
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

Le mer. 20 nov. 2019 =C3=A0 00:28, Benjamin Gaignard
<benjamin.gaignard@st.com> a =C3=A9crit :
>
> Exported functions prototypes are missing in drm_fb_cma_helper.c
> Include drm_fb_cma_helper to fix that issue.
>

Gentle ping to reviewers.
Thanks,
Benjamin

> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  drivers/gpu/drm/drm_fb_cma_helper.c | 1 +
>  include/drm/drm_fb_cma_helper.h     | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_fb_cma_helper.c b/drivers/gpu/drm/drm_fb=
_cma_helper.c
> index c0b0f603af63..9801c0333eca 100644
> --- a/drivers/gpu/drm/drm_fb_cma_helper.c
> +++ b/drivers/gpu/drm/drm_fb_cma_helper.c
> @@ -9,6 +9,7 @@
>   *  Copyright (C) 2012 Red Hat
>   */
>
> +#include <drm/drm_fb_cma_helper.h>
>  #include <drm/drm_fourcc.h>
>  #include <drm/drm_framebuffer.h>
>  #include <drm/drm_gem_cma_helper.h>
> diff --git a/include/drm/drm_fb_cma_helper.h b/include/drm/drm_fb_cma_hel=
per.h
> index 4becb09975a4..795aea1d0a25 100644
> --- a/include/drm/drm_fb_cma_helper.h
> +++ b/include/drm/drm_fb_cma_helper.h
> @@ -2,6 +2,8 @@
>  #ifndef __DRM_FB_CMA_HELPER_H__
>  #define __DRM_FB_CMA_HELPER_H__
>
> +#include <linux/types.h>
> +
>  struct drm_framebuffer;
>  struct drm_plane_state;
>
> --
> 2.15.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
