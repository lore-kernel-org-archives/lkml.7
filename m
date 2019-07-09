Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4781CC73C41
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 13:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C04E2171F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 13:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoJ33hjw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfGINIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 09:08:52 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55060 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfGINIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 09:08:52 -0400
Received: by mail-wm1-f68.google.com with SMTP id p74so3028213wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 06:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5zNw7yOYRGRe3lmbESQC+BIywwsER5mP5dHtawRmtUg=;
        b=UoJ33hjw2DBUdQFoWS7L44YXRtnxWNnY7mi1ulDEHyxW3pYDsBu0z1m2o30P0n3fee
         kcoCCUI+RMcB1s2PORs1EB0sZRFPwv2hOCw+PSg/Qw29A/9+kELX6c5HVVMLkWS24w8d
         ImGM5PQX3xf52ZwWewIuxDpxOP0qya5ynIMcFDu5C7bDbabKNN5L9zX0JSw6HG+9NmP+
         Uqmkq1tQdlNz+DmfJEia90+qVAXC3h3ycmM0eu/Lvf4enGxKHRZH2/FH7z4EleDVulOf
         J83tBVT481Sc0wf+cguIss4ZeDPmHV4wWUgebavf/DPyEI23lDPaNyaoJ+AXodcgUMRH
         NQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5zNw7yOYRGRe3lmbESQC+BIywwsER5mP5dHtawRmtUg=;
        b=t4p1zzpl67KsAEAWAR/9ZxgeSVnHAOttrBtGB4OPEvoDTLYOHkWD6nAwbKWKiA22ZD
         ktOpN1qv/nAE1JPjRWRBvcVcD2/bl8c9cBKJ5GnMJyr0ZVw0qjjQ6qhdhYOfmzSrZj/t
         lHhZyto4YZb5rLp/mf5GAWpnOBjeJfx4NmlLItZaCdXTBNxj3PF8orfrgFmYIufHwy8O
         BS8bH2FobOt2eFwPV4dDRP2GcpyEHm4hFnfm29jIMSpv0hlU3nb9Q0x+mQgp6QtgUFY0
         OgU9d6faRbaY9gl/YfyZ58fnlFMA7aVN3AliqQPdBmjXKXBwmfc4W0Z3B2bVylR2zGPS
         6VGw==
X-Gm-Message-State: APjAAAUxR/nbRWiyTSfuNd1AJxA5MkbHOfCiX112xp+yqKU1CXQt+2TE
        yXQPt96auOZcdLRV7LxTotvC9tmW/Ks7P38FcJw=
X-Google-Smtp-Source: APXvYqyqC0d9hRgfT+ZieDiI7TjJUankW7mnEizvkt8y5jvweTTMyCC91zHfJhxUqmmygj4YFXdcPTHW4axFKWce+jU=
X-Received: by 2002:a1c:9e90:: with SMTP id h138mr23670087wme.67.1562677729889;
 Tue, 09 Jul 2019 06:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190709091048.35260-1-yuehaibing@huawei.com>
In-Reply-To: <20190709091048.35260-1-yuehaibing@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 9 Jul 2019 09:08:38 -0400
Message-ID: <CADnq5_OTri_FzBHUSzKDPrMMAx2fDj8Mx67qHSofo+Hx7Q+60Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix build without CONFIG_HMM_MIRROR
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Yang, Philip" <Philip.Yang@amd.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 9, 2019 at 8:55 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> If CONFIG_HMM_MIRROR is not set, building may fails:
>
> In file included from drivers/gpu/drm/amd/amdgpu/amdgpu.h:72:0,
>                  from drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:40:
> drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h:69:20: error: field mirror has incomplete type
>   struct hmm_mirror mirror;
>
> Fixes: 7590f6d211ec ("drm/amdgpu: Prepare for hmm_range_register API change")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

I already applied a similar patch from Arnd.

Thanks,

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
> index 281fd9f..b14f175 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
> @@ -65,8 +65,10 @@ struct amdgpu_mn {
>         struct rw_semaphore     lock;
>         struct rb_root_cached   objects;
>
> +#if defined(CONFIG_HMM_MIRROR)
>         /* HMM mirror */
>         struct hmm_mirror       mirror;
> +#endif
>  };
>
>  #if defined(CONFIG_HMM_MIRROR)
> --
> 2.7.4
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
