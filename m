Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B98BC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 16:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30F8620842
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 16:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8w048S1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfHLQJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 12:09:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46125 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfHLQJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 12:09:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id z1so105061690wru.13;
        Mon, 12 Aug 2019 09:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wQDudG+kkcGbnnVsgirExeE5TJAvPH8BcoTOdSWcbpI=;
        b=S8w048S1FiKQE4kpcxrfsH1AMpFzduSfYRNTLKhJQ33pc5ebJvNltMcUkH0DUI2KUC
         GBpYcFZXNQAecONLobNZh0QOHG+SWeo8/o7i2ESVFGOdVT3KslXL3kji4+j/iPVF0VyK
         oTYq2yQONkIYbJqOa9idUujLRIXE6gn+fk6SbWcM9HZBu49I84Y3v7MNXmN8cEsgvfJQ
         OoUyyBUwEHP3jXMgBdbvxG3yJS6a/4CefRHgSYpUdJS/T5bmUTpHgh946lfyXiRxqHaZ
         41hAs9WPHvaV6FrF9K7DZ8Wqg7s4M60kVkfNjtCKoxTW2BccrWx1YzVp8dVpncDdV5Yx
         ZisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wQDudG+kkcGbnnVsgirExeE5TJAvPH8BcoTOdSWcbpI=;
        b=afcspCDHEvl32McV7G/dO1+xPnVsM+kyLHtIINm/6vRaA4Turome2FTdVU92refqqL
         7AAwpV0/Mk3r63y3laLaZ1tRpnIGyCCWd3u5YAYvnNjBTvRZMq2o8qwwS8EbV26E2OaY
         AwttXFfdxeAPLkqoL6QR/3lO3nhmMOQVvDCZeI3gzPWzx10ozHsMA7bq5i+uGzYqSJjR
         InmlOSq4z2LLtlUkUmjPsPU9g3dR/5FPIGZntsRL1G5rblZ11A+gFh820khJ4CY9Ymc/
         syNPU6gH2dvYPRIIo7ZcMMosT2Dmpy1qqRH8DAHDpDOKAaYR2SPmX0ECauP37A3xOKHr
         cWtw==
X-Gm-Message-State: APjAAAX/xOFysKfAa6QKLuaiSmXdQw3bAFh9OGoQh59M1vZSccT9UNy6
        JEC9+Jzz7hHUYr6JYFDvOXLW9zXQNY5YWgQy8T4=
X-Google-Smtp-Source: APXvYqwA2G8KxSDLIpB4nxWCDIea1NkkIuXIaaINWUZGHpReKkV/2DiRLL1Z+7KsLbL587UFZjosbhgZI5JlzwcNhts=
X-Received: by 2002:a5d:6b11:: with SMTP id v17mr41041362wrw.323.1565626167467;
 Mon, 12 Aug 2019 09:09:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190809201219.629-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20190809201219.629-1-christophe.jaillet@wanadoo.fr>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 12 Aug 2019 12:09:14 -0400
Message-ID: <CADnq5_MM+ojG+jmuW-FpdusYzsa2BW_pguGPoMYSQFo4d5z72g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix a typo - dce_aduio_mask --> dce_audio_mask
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        kernel-janitors@vger.kernel.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  thanks!

Alex

On Sat, Aug 10, 2019 at 9:55 AM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> This should be 'dce_audio_mask', not 'dce_aduio_mask'.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_audio.c          | 2 +-
>  drivers/gpu/drm/amd/display/dc/dce/dce_audio.h          | 6 +++---
>  drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c | 2 +-
>  drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c | 2 +-
>  drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c | 2 +-
>  drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c | 2 +-
>  drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c   | 2 +-
>  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c   | 2 +-
>  8 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
> index 549704998f84..1e88c5f46be7 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
> @@ -937,7 +937,7 @@ struct audio *dce_audio_create(
>                 unsigned int inst,
>                 const struct dce_audio_registers *reg,
>                 const struct dce_audio_shift *shifts,
> -               const struct dce_aduio_mask *masks
> +               const struct dce_audio_mask *masks
>                 )
>  {
>         struct dce_audio *audio = kzalloc(sizeof(*audio), GFP_KERNEL);
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.h b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.h
> index a0d5724aab31..1392fab0860b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.h
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.h
> @@ -101,7 +101,7 @@ struct dce_audio_shift {
>         uint32_t DCCG_AUDIO_DTO1_USE_512FBR_DTO;
>  };
>
> -struct dce_aduio_mask {
> +struct dce_audio_mask {
>         uint32_t AZALIA_ENDPOINT_REG_INDEX;
>         uint32_t AZALIA_ENDPOINT_REG_DATA;
>
> @@ -125,7 +125,7 @@ struct dce_audio {
>         struct audio base;
>         const struct dce_audio_registers *regs;
>         const struct dce_audio_shift *shifts;
> -       const struct dce_aduio_mask *masks;
> +       const struct dce_audio_mask *masks;
>  };
>
>  struct audio *dce_audio_create(
> @@ -133,7 +133,7 @@ struct audio *dce_audio_create(
>                 unsigned int inst,
>                 const struct dce_audio_registers *reg,
>                 const struct dce_audio_shift *shifts,
> -               const struct dce_aduio_mask *masks);
> +               const struct dce_audio_mask *masks);
>
>  void dce_aud_destroy(struct audio **audio);
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
> index 6248c8455314..81116286b15b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
> @@ -304,7 +304,7 @@ static const struct dce_audio_shift audio_shift = {
>                 AUD_COMMON_MASK_SH_LIST(__SHIFT)
>  };
>
> -static const struct dce_aduio_mask audio_mask = {
> +static const struct dce_audio_mask audio_mask = {
>                 AUD_COMMON_MASK_SH_LIST(_MASK)
>  };
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
> index 764329264c3b..765e26454a18 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
> @@ -331,7 +331,7 @@ static const struct dce_audio_shift audio_shift = {
>                 AUD_COMMON_MASK_SH_LIST(__SHIFT)
>  };
>
> -static const struct dce_aduio_mask audio_mask = {
> +static const struct dce_audio_mask audio_mask = {
>                 AUD_COMMON_MASK_SH_LIST(_MASK)
>  };
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> index c6136e0ed1a4..3ac4c7e73050 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> @@ -337,7 +337,7 @@ static const struct dce_audio_shift audio_shift = {
>                 AUD_COMMON_MASK_SH_LIST(__SHIFT)
>  };
>
> -static const struct dce_aduio_mask audio_mask = {
> +static const struct dce_audio_mask audio_mask = {
>                 AUD_COMMON_MASK_SH_LIST(_MASK)
>  };
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> index 54be7ab370df..9a922cd39cf2 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> @@ -352,7 +352,7 @@ static const struct dce_audio_shift audio_shift = {
>                 DCE120_AUD_COMMON_MASK_SH_LIST(__SHIFT)
>  };
>
> -static const struct dce_aduio_mask audio_mask = {
> +static const struct dce_audio_mask audio_mask = {
>                 DCE120_AUD_COMMON_MASK_SH_LIST(_MASK)
>  };
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
> index 860a524ebcfa..2a1ce9ecc66e 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
> @@ -322,7 +322,7 @@ static const struct dce_audio_shift audio_shift = {
>                 AUD_COMMON_MASK_SH_LIST(__SHIFT)
>  };
>
> -static const struct dce_aduio_mask audio_mask = {
> +static const struct dce_audio_mask audio_mask = {
>                 AUD_COMMON_MASK_SH_LIST(_MASK)
>  };
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
> index 1a20461c2937..1c5835975935 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
> @@ -270,7 +270,7 @@ static const struct dce_audio_shift audio_shift = {
>                 DCE120_AUD_COMMON_MASK_SH_LIST(__SHIFT)
>  };
>
> -static const struct dce_aduio_mask audio_mask = {
> +static const struct dce_audio_mask audio_mask = {
>                 DCE120_AUD_COMMON_MASK_SH_LIST(_MASK)
>  };
>
> --
> 2.20.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
