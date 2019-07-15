Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E13C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 16:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41BA42080A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 16:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uEOxNlok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbfGOQKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 12:10:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52303 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729533AbfGOQKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 12:10:01 -0400
Received: by mail-wm1-f66.google.com with SMTP id s3so15776234wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 09:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6fQPkaUZ+jePctAUjhVKB6gKSHt2QRsUl6ltTQzAvk4=;
        b=uEOxNlokRMoceBmAqR5uFDO0QSBwIupTiHkT9Fz+VFxSksiyFFwSvd6cHOuNfFVcQ0
         eGJ8d5U4Sa1xS+gYEhzp5aM3Kg0jpp4BkPzcKyr3IY/+nB2YJ9oDHaurstQZrmsGYrgW
         ZmGm53Dta+vbqQY3wRZayyEhaPY3vfd4+CUcJ238kiPSEhprYJv1HCItJFKzOkHzZmMp
         UkaKixk16rwg+FAVT0E/KTzKOTdiKhL7YjR679c7zEo6UjekfO1oq1ceg0FUC1dm9bSQ
         TjlecO4bU+cXUBAMV8Ts7X25jGOTOWWBx3r4+6cv/NuVvamGKpzGqbLe5kgNblW/MvMZ
         Aglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6fQPkaUZ+jePctAUjhVKB6gKSHt2QRsUl6ltTQzAvk4=;
        b=iZCNmJDbYtW7P0UncJkRoauCPA89xPvGPhUwxy3km3tJjKBZapQbraj+qlIPOx+Kru
         jZbovl1PSFLsK2S/XuENtY2cHqSDZ+m0MZZVWOjt4YlM5bEUdxKNCX+RFbQk7U8NYa76
         xFdoIL9YMpaDh3v8dcDrobdbgQ7SQAvWaiQkGGUju404q4/5BEgE+hTtUP5ewyrGZeeS
         pIR1AMpXUMVpYi72nPAdWBCsxQz6WQ3tPXKDiq7HTkvnTqsqdUPOJI4MZa5DYNhMLu/9
         xsxjuqLXUt8RPrWUCSYLawHLRZ0Ckv6bYntA0rYaKT70/Mf9w71GbXgOjNEe2rGLjLee
         KyNw==
X-Gm-Message-State: APjAAAWYy+73krnBtJ8t5+sSKuXi+bTSYre3+NJQnoiVgN7EVjlDohnp
        9D5bGbqhQVlaS/5DnxqF6E7qvxcshCGLbUY1sI+VFg==
X-Google-Smtp-Source: APXvYqxs8hoWL7cmGqBiTkXz0ym5JhcT5zStF3uo6vpPbmfu9/xOFQMs+ujD5jvvM8aSCLT0Yp/V7Qwb6pVEzNIjEMg=
X-Received: by 2002:a05:600c:20d:: with SMTP id 13mr25449956wmi.141.1563206998088;
 Mon, 15 Jul 2019 09:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190712094118.1559434-1-arnd@arndb.de>
In-Reply-To: <20190712094118.1559434-1-arnd@arndb.de>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 15 Jul 2019 12:09:45 -0400
Message-ID: <CADnq5_NX+eGdsK20_Cn_+5WDbJpyPukqhyXhgEoce4UagAncrA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: hide #warning for missing DC config
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Jack Xiao <Jack.Xiao@amd.com>,
        Kevin Wang <kevin1.wang@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Huang Rui <ray.huang@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Xiaojie Yuan <xiaojie.yuan@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 5:41 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> It is annoying to have #warnings that trigger in randconfig
> builds like
>
> drivers/gpu/drm/amd/amdgpu/soc15.c:653:3: error: "Enable CONFIG_DRM_AMD_DC for display support on SOC15."
> drivers/gpu/drm/amd/amdgpu/nv.c:400:3: error: "Enable CONFIG_DRM_AMD_DC for display support on navi."
>
> Remove these and rely on the users to turn these on.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/nv.c    | 2 --
>  drivers/gpu/drm/amd/amdgpu/soc15.c | 4 ----
>  2 files changed, 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 9253c03d387a..10ec0e81ee58 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -396,8 +396,6 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
>  #if defined(CONFIG_DRM_AMD_DC)
>                 else if (amdgpu_device_has_dc_support(adev))
>                         amdgpu_device_ip_block_add(adev, &dm_ip_block);
> -#else
> -#      warning "Enable CONFIG_DRM_AMD_DC for display support on navi."
>  #endif
>                 amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
>                 amdgpu_device_ip_block_add(adev, &sdma_v5_0_ip_block);
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 87152d8ef0df..90fb0149fbea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -649,8 +649,6 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
>  #if defined(CONFIG_DRM_AMD_DC)
>                 else if (amdgpu_device_has_dc_support(adev))
>                         amdgpu_device_ip_block_add(adev, &dm_ip_block);
> -#else
> -#      warning "Enable CONFIG_DRM_AMD_DC for display support on SOC15."
>  #endif
>                 if (!(adev->asic_type == CHIP_VEGA20 && amdgpu_sriov_vf(adev))) {
>                         amdgpu_device_ip_block_add(adev, &uvd_v7_0_ip_block);
> @@ -671,8 +669,6 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
>  #if defined(CONFIG_DRM_AMD_DC)
>                 else if (amdgpu_device_has_dc_support(adev))
>                         amdgpu_device_ip_block_add(adev, &dm_ip_block);
> -#else
> -#      warning "Enable CONFIG_DRM_AMD_DC for display support on SOC15."
>  #endif
>                 amdgpu_device_ip_block_add(adev, &vcn_v1_0_ip_block);
>                 break;
> --
> 2.20.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
