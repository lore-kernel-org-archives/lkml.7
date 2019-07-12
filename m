Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E592C742D2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 18:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7473F205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 18:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSqm1Ltn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfGLSCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 14:02:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46072 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbfGLSCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 14:02:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id f9so10787160wre.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 11:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1KGfkWXQEB4DpNuxrw2Ty2JDtJAoJ1RvfNqKFWK4TmA=;
        b=jSqm1LtnSvPzjsEt3Vm0O1vNGwSwHmI0yx63fhSHLkuYxhZ5z9qmHWioZIgaScrqeR
         etUMH8wAhEv2dyR+4cu8JZWOlJSA69URvDJsccJpw2L2VVaI8I/CxatTLZJEFmtnDS5x
         yTx6821ZqeKE/r67dpU3wAKXBMTPmR3JGBlm6wprm6SWTyROE+2VZ72oDI/jta6aIVT3
         d0Gw+oc4kXxjL7jkNap/mPbG9qYuRLooCq8Pi0eN5guhVXbPez5ycnH9Ftm0afPSdwLK
         6TroVa8wgcDnXqi2lBHeVzOH9OykYjIamQs1F8IBh3+5cI51mJEP0flcXy1o4MD6Wfhc
         RrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1KGfkWXQEB4DpNuxrw2Ty2JDtJAoJ1RvfNqKFWK4TmA=;
        b=k4vDKY+fDuSl1UrOtIOljNCSKPavQLT/Z2nQZ5T5V8sMD2I7ivwSgDRc4ucdB0FvbI
         dDQFGRJ37E9RcSZr//y5xg/tdxZirlQLNUZRffEKHLyqAaLDiQCfEAq5OdaBXJZAmNFH
         XqGuquK00V/WM7RScI/iywq+y1C7lzrArJ9Kvjt4QVZTOj5DKaQzluoy6CsSWcHUm3Mh
         GkZQY+aBJqPlKcmYFEfhTQ2GmhjzFFAe2RHQ4O2mYHTUZA8kLHbJKWzWhQjbgBaGbxk4
         UFJP3Ud5yXtpZdtiXZKzlYrzj55mhoWPfULCGSLqAeqNySE8O6aKl3WSKDuMCSzAs3BF
         G54Q==
X-Gm-Message-State: APjAAAW+2WWpc1ZPRSKZSnBSxxUEFPpv5coH70C8IQpVUHPH3yaxJszA
        +0NH7WMED+tv/yPrVnoUCpm/QJRGwX3LiUJis1lQdQ==
X-Google-Smtp-Source: APXvYqwss/WvLjL/LGiOM8mHDUS8Lv25N53N+kxrEQ5ijpXyO7RwUkDOJ7LCTtzdDh/UYPw/K3XQuWp7G/oNIyvp/EE=
X-Received: by 2002:a5d:6b11:: with SMTP id v17mr12513676wrw.323.1562954518109;
 Fri, 12 Jul 2019 11:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190712094118.1559434-1-arnd@arndb.de>
In-Reply-To: <20190712094118.1559434-1-arnd@arndb.de>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 12 Jul 2019 14:01:46 -0400
Message-ID: <CADnq5_McVegix-m87OwHUvk80NdsFZPQ7d0X8qQtUf84h+Fg1A@mail.gmail.com>
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

Is there some sort of informational message we could use instead?
Unless you are a server user, most end users want this option enabled.

Alex

>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
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
