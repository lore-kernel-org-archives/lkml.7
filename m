Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2D2C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463FB206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XszFQacS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbfJGSy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 14:54:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45107 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbfJGSy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 14:54:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id r5so16498490wrm.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 11:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MQcOGUTHfO/bHwXtRoACnVGMfWQ7WlONlR3KblVpn3I=;
        b=XszFQacSBW4ktTMc6TvptZPfwjJCzK9C16AwItg41HgWbI8R4mCw0qrQVum2W02ywO
         4vrQbaR/aX5Anv77ybANXeuPdJwFt5XWJOq17xCRHVbBDtcPT0eamMG1DBiwa7/EMZxk
         nGW21Ys/3OIAMKezIA4HuASy+f9PKIS4GLS6z32nVoC6RARkjix5TvT5ZZXesY0zusZS
         mz+0ZbPZNabeiLdOcNQ7qvsKRplT06+VPlGSAjz0q/GGTaeJe6+MwxyX/mzTJVXjNz87
         CRKH1nKJ3Jg1NIfGPK7izd0mW3wPqve6DTo6mnNNu/F5ZR+DOC6hbUl33D/81OVBdMJC
         EAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MQcOGUTHfO/bHwXtRoACnVGMfWQ7WlONlR3KblVpn3I=;
        b=i/xBV0vEfuOO87JSoyX9ijCvWRXMscVjp0AfAAQ9q6GYENqwTIcoyjABb3vANKBTGm
         DiIH8rODwtyQzf3VbycB+Je+/AxvyFI3/mz+OEYr7K7a1she8PA6nXId+MMhfR150lWp
         0CnTyiUMNyZ9b8bm28DqXQl87OY/dv5UX6r3asx8t8BIW6s8UjVqEbG65g+VsLIFLHmr
         rupWp7VmRXE5WJQ9VG3ktgNjj4mQwv17Fxj06OaTi8DaozwH09wHqLgK4GaqCTSwvSH+
         nOTB8yIIxRa26TTmF3lQIzGuV+CIQnDT8/sCu+izwN0ImlquLaTVd50ZU3rB6OoGi/no
         Oy2g==
X-Gm-Message-State: APjAAAWDfCqpGWSWoAzP+X1Nfe+ISTjV6ivPiiOGDADMK0QzuOjD7Fdc
        xhaUFlyZKX4zbxrmy4E/poHThOxik7LVSAKt0+b7T0he
X-Google-Smtp-Source: APXvYqzON7sOsPzp1Tk+w4HqTa/WQrWkfVsembsWxklnM+yW7t2zngU61jGW9q83KCDxVjYgsyHvvoztig7e4/bxL4s=
X-Received: by 2002:adf:f287:: with SMTP id k7mr24800437wro.206.1570474465219;
 Mon, 07 Oct 2019 11:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <20191007173322.9306-1-krzk@kernel.org>
In-Reply-To: <20191007173322.9306-1-krzk@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Oct 2019 14:54:13 -0400
Message-ID: <CADnq5_MpRZKTKLbJhzKOS=boP8RwvXPzkk0vBnJeRPgTHxStJQ@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amd: Fix Kconfig indentation
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 7, 2019 at 1:33 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
>     $ sed -e 's/^        /\t/' -i */Kconfig
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied.  Thanks!

Alex

>
> ---
>
> Changes since v2:
> 1. Split AMD and i915 to separate patches.
> ---
>  drivers/gpu/drm/Kconfig             |  4 ++--
>  drivers/gpu/drm/amd/display/Kconfig | 32 ++++++++++++++---------------
>  2 files changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 108e1b7f4564..7cb6e4eb99e8 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -226,9 +226,9 @@ config DRM_AMDGPU
>         tristate "AMD GPU"
>         depends on DRM && PCI && MMU
>         select FW_LOADER
> -        select DRM_KMS_HELPER
> +       select DRM_KMS_HELPER
>         select DRM_SCHED
> -        select DRM_TTM
> +       select DRM_TTM
>         select POWER_SUPPLY
>         select HWMON
>         select BACKLIGHT_CLASS_DEVICE
> diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
> index 1bbe762ee6ba..313183b80032 100644
> --- a/drivers/gpu/drm/amd/display/Kconfig
> +++ b/drivers/gpu/drm/amd/display/Kconfig
> @@ -23,16 +23,16 @@ config DRM_AMD_DC_DCN2_0
>         depends on DRM_AMD_DC && X86
>         depends on DRM_AMD_DC_DCN1_0
>         help
> -           Choose this option if you want to have
> -           Navi support for display engine
> +         Choose this option if you want to have
> +         Navi support for display engine
>
>  config DRM_AMD_DC_DCN2_1
> -        bool "DCN 2.1 family"
> -        depends on DRM_AMD_DC && X86
> -        depends on DRM_AMD_DC_DCN2_0
> -        help
> -            Choose this option if you want to have
> -            Renoir support for display engine
> +       bool "DCN 2.1 family"
> +       depends on DRM_AMD_DC && X86
> +       depends on DRM_AMD_DC_DCN2_0
> +       help
> +         Choose this option if you want to have
> +         Renoir support for display engine
>
>  config DRM_AMD_DC_DSC_SUPPORT
>         bool "DSC support"
> @@ -41,16 +41,16 @@ config DRM_AMD_DC_DSC_SUPPORT
>         depends on DRM_AMD_DC_DCN1_0
>         depends on DRM_AMD_DC_DCN2_0
>         help
> -           Choose this option if you want to have
> -           Dynamic Stream Compression support
> +         Choose this option if you want to have
> +         Dynamic Stream Compression support
>
>  config DRM_AMD_DC_HDCP
> -        bool "Enable HDCP support in DC"
> -        depends on DRM_AMD_DC
> -        help
> -         Choose this option
> -         if you want to support
> -         HDCP authentication
> +       bool "Enable HDCP support in DC"
> +       depends on DRM_AMD_DC
> +       help
> +        Choose this option
> +        if you want to support
> +        HDCP authentication
>
>  config DEBUG_KERNEL_DC
>         bool "Enable kgdb break in DC"
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
