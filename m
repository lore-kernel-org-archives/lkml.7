Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B59C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ECB02072C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnYEUaKD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgAFBHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 20:07:20 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:41862 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbgAFBHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 20:07:20 -0500
Received: by mail-vk1-f193.google.com with SMTP id p191so2042464vkf.8
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jan 2020 17:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ElS7ZOmpSKrdCm7uJX1DyA5ncafvJhJQJML81jsQF4I=;
        b=gnYEUaKDiD6DbHGdxozEh1WbM42Q/i8ybniobCIAaAZO1tg7F4lUXw15SJZChajuVB
         D9nNP7kgngPKbIRDckphmMhjZIMvhNvfMVJd4lMiKBmRwU76qFC3f42JcsmeJlr0IYPx
         uMcxaHcUMGLX+E3WrUdHiks2E0L4LJ2noStfBljNT4CfmSP/QsDDEZbIQsdjfnnkaPIv
         O29z3edRLj9E/tcCz89R79LUgHkILfQ7TD15vF41J8PgocyIMpalxoZ60sLeQWb18zd6
         M7zT327VmpQZoEhsWi3lo5Ny5+7kTkgj55zzMFvowUAd9i6WrjkniAY5bSP9PQhnpBYw
         MVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ElS7ZOmpSKrdCm7uJX1DyA5ncafvJhJQJML81jsQF4I=;
        b=tZEgZdi+ljG0AS785pUU+lkt0l3wmyigM+Z4cwBEW8uWnR0QlXwliIMYwAGPuVbpJc
         N6it2WZ4MGJJ8X6MwC8hDKddmrncgwSXqGqCEze9kpzjqKEs71QXCKIFPYFASsqj27pZ
         tt09Xpj0nq0jEYwhYTQwh/7mKz1RTndiW6GiaRQnjkBFBSj9Cn6MH5iU7XeF+MVHRkuv
         u597AjixNeKegtZWjoLFxnY/oCtWlzbTUnrsXsXYrKz+BCRMh+c6qvDj1wqDdaC6TK7i
         0gutuIjBGOic+cvLXdBQiDZ+GcfG1pbzvTfDGPMxw2NPgE4hG4/ISIn+rTg7oCaB0q9I
         NHEw==
X-Gm-Message-State: APjAAAUSuhGMuf3t8zVO1SM4lLI9jCWqOxA5Ta3y5ajFjO+QyzJ4V+Tr
        62YVZVh1bLf4i79sPNgoWAI4YcTYxWsEH2rECXM=
X-Google-Smtp-Source: APXvYqxTXcWZAGbkeeZaAlQ005iYKR5vsbpEC8+a2LikQL1PAXrbSaBiiuhVHhen9BeqNUj8eZP5xyqf/iX47zu9L/U=
X-Received: by 2002:a1f:2910:: with SMTP id p16mr57213135vkp.71.1578272839058;
 Sun, 05 Jan 2020 17:07:19 -0800 (PST)
MIME-Version: 1.0
References: <20200102122548.25696-1-wambui.karugax@gmail.com>
In-Reply-To: <20200102122548.25696-1-wambui.karugax@gmail.com>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Mon, 6 Jan 2020 11:07:08 +1000
Message-ID: <CACAvsv7ESe6r-qK2s7o=fRygumo986J0vySnYFVJYZDkuraGaQ@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH v2] drm/nouveau: declare constants as unsigned
 long long.
To:     Wambui Karuga <wambui.karugax@gmail.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        ML nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jan 2020 at 05:29, Wambui Karuga <wambui.karugax@gmail.com> wrote:
>
> Explicitly declare constants as unsigned long long to address the
> following sparse warnings:
> warning: constant is so big it is long
>
> v2: convert to unsigned long long for compatibility with 32-bit
> architectures.
>
> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
> Suggested by: lia Mirkin <imirkin@alum.mit.edu>
Thanks!

> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgf100.c | 2 +-
>  drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgf108.c | 2 +-
>  drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgk104.c | 2 +-
>  drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgm107.c | 2 +-
>  drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgm200.c | 2 +-
>  drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgp100.c | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgf100.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgf100.c
> index ac87a3b6b7c9..ba43fe158b22 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgf100.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgf100.c
> @@ -655,7 +655,7 @@ gf100_ram_new_(const struct nvkm_ram_func *func,
>
>  static const struct nvkm_ram_func
>  gf100_ram = {
> -       .upper = 0x0200000000,
> +       .upper = 0x0200000000ULL,
>         .probe_fbp = gf100_ram_probe_fbp,
>         .probe_fbp_amount = gf100_ram_probe_fbp_amount,
>         .probe_fbpa_amount = gf100_ram_probe_fbpa_amount,
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgf108.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgf108.c
> index 70a06e3cd55a..d97fa43efb91 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgf108.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgf108.c
> @@ -43,7 +43,7 @@ gf108_ram_probe_fbp_amount(const struct nvkm_ram_func *func, u32 fbpao,
>
>  static const struct nvkm_ram_func
>  gf108_ram = {
> -       .upper = 0x0200000000,
> +       .upper = 0x0200000000ULL,
>         .probe_fbp = gf100_ram_probe_fbp,
>         .probe_fbp_amount = gf108_ram_probe_fbp_amount,
>         .probe_fbpa_amount = gf100_ram_probe_fbpa_amount,
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgk104.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgk104.c
> index 456aed1f2a02..d350d92852d2 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgk104.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgk104.c
> @@ -1698,7 +1698,7 @@ gk104_ram_new_(const struct nvkm_ram_func *func, struct nvkm_fb *fb,
>
>  static const struct nvkm_ram_func
>  gk104_ram = {
> -       .upper = 0x0200000000,
> +       .upper = 0x0200000000ULL,
>         .probe_fbp = gf100_ram_probe_fbp,
>         .probe_fbp_amount = gf108_ram_probe_fbp_amount,
>         .probe_fbpa_amount = gf100_ram_probe_fbpa_amount,
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgm107.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgm107.c
> index 27c68e3f9772..be91da854dca 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgm107.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgm107.c
> @@ -33,7 +33,7 @@ gm107_ram_probe_fbp(const struct nvkm_ram_func *func,
>
>  static const struct nvkm_ram_func
>  gm107_ram = {
> -       .upper = 0x1000000000,
> +       .upper = 0x1000000000ULL,
>         .probe_fbp = gm107_ram_probe_fbp,
>         .probe_fbp_amount = gf108_ram_probe_fbp_amount,
>         .probe_fbpa_amount = gf100_ram_probe_fbpa_amount,
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgm200.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgm200.c
> index 6b0cac1fe7b4..8f91ea91ee25 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgm200.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgm200.c
> @@ -48,7 +48,7 @@ gm200_ram_probe_fbp_amount(const struct nvkm_ram_func *func, u32 fbpao,
>
>  static const struct nvkm_ram_func
>  gm200_ram = {
> -       .upper = 0x1000000000,
> +       .upper = 0x1000000000ULL,
>         .probe_fbp = gm107_ram_probe_fbp,
>         .probe_fbp_amount = gm200_ram_probe_fbp_amount,
>         .probe_fbpa_amount = gf100_ram_probe_fbpa_amount,
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgp100.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgp100.c
> index adb62a6beb63..378f6fb70990 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgp100.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgp100.c
> @@ -79,7 +79,7 @@ gp100_ram_probe_fbpa(struct nvkm_device *device, int fbpa)
>
>  static const struct nvkm_ram_func
>  gp100_ram = {
> -       .upper = 0x1000000000,
> +       .upper = 0x1000000000ULL,
>         .probe_fbp = gm107_ram_probe_fbp,
>         .probe_fbp_amount = gm200_ram_probe_fbp_amount,
>         .probe_fbpa_amount = gp100_ram_probe_fbpa,
> --
> 2.17.1
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
