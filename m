Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE34C33C9B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD90C2075A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTKSdyzs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgAFW7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 17:59:05 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34819 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgAFW7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 17:59:04 -0500
Received: by mail-wr1-f65.google.com with SMTP id g17so51737111wro.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 14:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8vAbag40zsQCrmcVPzc57zPSUPwvwkh0dJEGfxu/U1Y=;
        b=kTKSdyzsCRaLRMgfxPyrYU+qAHSHjYUAuyA/d3DXfedQ2la8oNPknedyJrEGOq4Voq
         QQh1Cn6RfcfBJY2jd/MADPMZKYuCGIt3Tr2KEV66A8SJPmVIFs04E7yNdpv94IZAiF9K
         AbShQ4sxHzWA9i+1p0veXVdi45ICtTF2CDeLb32KN86J/D0RvEMNN1cvS4oP5PTDsQ9e
         fEWP5hmhljskkEHVCchzf0CnaRs230FsS/cPJwy/VrsTCwOvgo7flv4yIKZC6n3q1+oT
         8UzjZBB28Rmwqf6UtidJIpHR9f5qkg8H2xyGvZbbrEivuMH8QRieKhDwegKql44VwZ8O
         k78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8vAbag40zsQCrmcVPzc57zPSUPwvwkh0dJEGfxu/U1Y=;
        b=TkoenllMTGHxcKFBOwjV1OcEWHWQYi5ZVEiMlFjuUVekRyhnRPYP7O0pdjoYF1bBQb
         XnQcFX9gOaydS0qmztcgoMr78ho5xXODp1885d8w7Qej4VY26/YpDwFR6ipQpyWzMScW
         /+fzztC5ImptnXuOcxaHGRa1s6QQU3Xzti+p1yOHirGzwDp2fCp81EYpduQ+2VbOG4pC
         75yXQoEMeOHZZj2VI2+vTAJ6JCHKfFnmjsH4At6u/kcv9/erYGWLtFVVPZhy21DBT4rZ
         wHR7vULgnvO0+eHW4b6R+geO17I3O7Qvqk5/9N1mwAGyDJcVTiru9G54TQACKMo7sQ4p
         Dg4w==
X-Gm-Message-State: APjAAAV5lK4LGwq4nCal641OoqH4kJeYCJSCsON+rJ7/GDzNIYPP7NsZ
        odTURVn0xIA0UaeiydscnX+P1xTfU7DNeISNbpA=
X-Google-Smtp-Source: APXvYqyUQebrvLlbh0GkgSfcfoss85D42SwTknJXT1Zd/cd62hr/WDmy+YWSurTM+FaMJhMhdIgh2c1zkziSWNVeY10=
X-Received: by 2002:a5d:6886:: with SMTP id h6mr92441274wru.154.1578351541526;
 Mon, 06 Jan 2020 14:59:01 -0800 (PST)
MIME-Version: 1.0
References: <20200103131912.26681-1-wambui.karugax@gmail.com>
In-Reply-To: <20200103131912.26681-1-wambui.karugax@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 6 Jan 2020 17:58:49 -0500
Message-ID: <CADnq5_Mb6OPCunU2=fa_YL0Vj7cj6KWwqZ4hU8KrCUfsLi_nUg@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: remove boolean checks in if statements.
To:     Wambui Karuga <wambui.karugax@gmail.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 3, 2020 at 2:34 PM Wambui Karuga <wambui.karugax@gmail.com> wrote:
>
> Remove unnecessary variable comparisions to true/false in if statements
> and check the value of the variable directly.
>
> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/radeon/cik_sdma.c               |  2 +-
>  drivers/gpu/drm/radeon/r100.c                   |  2 +-
>  drivers/gpu/drm/radeon/r600.c                   |  2 +-
>  drivers/gpu/drm/radeon/radeon_bios.c            | 12 ++++++------
>  drivers/gpu/drm/radeon/radeon_connectors.c      |  4 ++--
>  drivers/gpu/drm/radeon/radeon_display.c         |  4 ++--
>  drivers/gpu/drm/radeon/radeon_legacy_encoders.c |  4 ++--
>  drivers/gpu/drm/radeon/radeon_pm.c              |  2 +-
>  8 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/cik_sdma.c b/drivers/gpu/drm/radeon/cik_sdma.c
> index 35b9dc6ce46a..68403e77756d 100644
> --- a/drivers/gpu/drm/radeon/cik_sdma.c
> +++ b/drivers/gpu/drm/radeon/cik_sdma.c
> @@ -333,7 +333,7 @@ void cik_sdma_enable(struct radeon_device *rdev, bool enable)
>         u32 me_cntl, reg_offset;
>         int i;
>
> -       if (enable == false) {
> +       if (!enable) {
>                 cik_sdma_gfx_stop(rdev);
>                 cik_sdma_rlc_stop(rdev);
>         }
> diff --git a/drivers/gpu/drm/radeon/r100.c b/drivers/gpu/drm/radeon/r100.c
> index 0017aa7a9f17..957994258860 100644
> --- a/drivers/gpu/drm/radeon/r100.c
> +++ b/drivers/gpu/drm/radeon/r100.c
> @@ -2815,7 +2815,7 @@ void r100_vga_set_state(struct radeon_device *rdev, bool state)
>         uint32_t temp;
>
>         temp = RREG32(RADEON_CONFIG_CNTL);
> -       if (state == false) {
> +       if (!state) {
>                 temp &= ~RADEON_CFG_VGA_RAM_EN;
>                 temp |= RADEON_CFG_VGA_IO_DIS;
>         } else {
> diff --git a/drivers/gpu/drm/radeon/r600.c b/drivers/gpu/drm/radeon/r600.c
> index 0d453aa09352..eb56fb48a6b7 100644
> --- a/drivers/gpu/drm/radeon/r600.c
> +++ b/drivers/gpu/drm/radeon/r600.c
> @@ -3191,7 +3191,7 @@ void r600_vga_set_state(struct radeon_device *rdev, bool state)
>         uint32_t temp;
>
>         temp = RREG32(CONFIG_CNTL);
> -       if (state == false) {
> +       if (!state) {
>                 temp &= ~(1<<0);
>                 temp |= (1<<1);
>         } else {
> diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeon/radeon_bios.c
> index c84d965c283e..c42f73fad3e3 100644
> --- a/drivers/gpu/drm/radeon/radeon_bios.c
> +++ b/drivers/gpu/drm/radeon/radeon_bios.c
> @@ -664,17 +664,17 @@ bool radeon_get_bios(struct radeon_device *rdev)
>         uint16_t tmp;
>
>         r = radeon_atrm_get_bios(rdev);
> -       if (r == false)
> +       if (!r)
>                 r = radeon_acpi_vfct_bios(rdev);
> -       if (r == false)
> +       if (!r)
>                 r = igp_read_bios_from_vram(rdev);
> -       if (r == false)
> +       if (!r)
>                 r = radeon_read_bios(rdev);
> -       if (r == false)
> +       if (!r)
>                 r = radeon_read_disabled_bios(rdev);
> -       if (r == false)
> +       if (!r)
>                 r = radeon_read_platform_bios(rdev);
> -       if (r == false || rdev->bios == NULL) {
> +       if (!r || rdev->bios == NULL) {
>                 DRM_ERROR("Unable to locate a BIOS ROM\n");
>                 rdev->bios = NULL;
>                 return false;
> diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
> index 0851e6817e57..90d2f732affb 100644
> --- a/drivers/gpu/drm/radeon/radeon_connectors.c
> +++ b/drivers/gpu/drm/radeon/radeon_connectors.c
> @@ -440,7 +440,7 @@ radeon_connector_analog_encoder_conflict_solve(struct drm_connector *connector,
>                                 if (radeon_conflict->use_digital)
>                                         continue;
>
> -                               if (priority == true) {
> +                               if (priority) {
>                                         DRM_DEBUG_KMS("1: conflicting encoders switching off %s\n",
>                                                       conflict->name);
>                                         DRM_DEBUG_KMS("in favor of %s\n",
> @@ -700,7 +700,7 @@ static int radeon_connector_set_property(struct drm_connector *connector, struct
>                         else
>                                 ret = radeon_legacy_get_tmds_info_from_combios(radeon_encoder, tmds);
>                 }
> -               if (val == 1 || ret == false) {
> +               if (val == 1 || !ret) {
>                         radeon_legacy_get_tmds_info_from_table(radeon_encoder, tmds);
>                 }
>                 radeon_property_change_mode(&radeon_encoder->base);
> diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
> index dfb921899853..e42d9e0a4b8c 100644
> --- a/drivers/gpu/drm/radeon/radeon_display.c
> +++ b/drivers/gpu/drm/radeon/radeon_display.c
> @@ -847,11 +847,11 @@ static bool radeon_setup_enc_conn(struct drm_device *dev)
>         if (rdev->bios) {
>                 if (rdev->is_atom_bios) {
>                         ret = radeon_get_atom_connector_info_from_supported_devices_table(dev);
> -                       if (ret == false)
> +                       if (!ret)
>                                 ret = radeon_get_atom_connector_info_from_object_table(dev);
>                 } else {
>                         ret = radeon_get_legacy_connector_info_from_bios(dev);
> -                       if (ret == false)
> +                       if (!ret)
>                                 ret = radeon_get_legacy_connector_info_from_table(dev);
>                 }
>         } else {
> diff --git a/drivers/gpu/drm/radeon/radeon_legacy_encoders.c b/drivers/gpu/drm/radeon/radeon_legacy_encoders.c
> index a33b19566b2d..44d060f75318 100644
> --- a/drivers/gpu/drm/radeon/radeon_legacy_encoders.c
> +++ b/drivers/gpu/drm/radeon/radeon_legacy_encoders.c
> @@ -1712,7 +1712,7 @@ static struct radeon_encoder_int_tmds *radeon_legacy_get_tmds_info(struct radeon
>         else
>                 ret = radeon_legacy_get_tmds_info_from_combios(encoder, tmds);
>
> -       if (ret == false)
> +       if (!ret)
>                 radeon_legacy_get_tmds_info_from_table(encoder, tmds);
>
>         return tmds;
> @@ -1735,7 +1735,7 @@ static struct radeon_encoder_ext_tmds *radeon_legacy_get_ext_tmds_info(struct ra
>
>         ret = radeon_legacy_get_ext_tmds_info_from_combios(encoder, tmds);
>
> -       if (ret == false)
> +       if (!ret)
>                 radeon_legacy_get_ext_tmds_info_from_table(encoder, tmds);
>
>         return tmds;
> diff --git a/drivers/gpu/drm/radeon/radeon_pm.c b/drivers/gpu/drm/radeon/radeon_pm.c
> index b37121f2631d..8c5d6fda0d75 100644
> --- a/drivers/gpu/drm/radeon/radeon_pm.c
> +++ b/drivers/gpu/drm/radeon/radeon_pm.c
> @@ -1789,7 +1789,7 @@ static bool radeon_pm_debug_check_in_vbl(struct radeon_device *rdev, bool finish
>         u32 stat_crtc = 0;
>         bool in_vbl = radeon_pm_in_vbl(rdev);
>
> -       if (in_vbl == false)
> +       if (!in_vbl)
>                 DRM_DEBUG_DRIVER("not in vbl for pm change %08x at %s\n", stat_crtc,
>                          finish ? "exit" : "entry");
>         return in_vbl;
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
