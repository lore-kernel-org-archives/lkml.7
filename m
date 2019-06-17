Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10529C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D727E2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o2gr9d3F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbfFQPD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:03:28 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53446 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfFQPD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:03:27 -0400
Received: by mail-wm1-f66.google.com with SMTP id x15so9664214wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 08:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OzFdi5FA53sk7r/J78O4Hf8Scc6tKC9H8PAY8JmuySc=;
        b=o2gr9d3FYl6FromvO4dGq2q7MDqhh1JM36ApiWaU6Qz6TJk8IfWXhLnmmzeCZvjdZl
         oFa9mbDnKPJ7ggAFEDejpk6IfR/7+cyXn1TyKAgAq0U6WTyT2zi1YWHsVDRyokCRjebR
         nVpIw3+4qV+gojidQYF4VY9CUIZquD1BgnnITrIHOEThgex+csiGylIgXdNeJ2CrI0r8
         sqiUd/XFV6HCPtSWOOOyk/5Ivsod1rqPDI3kAokoZhpNXa9GiABfSxpno+JrbMrRM4Z1
         CfLaYPa4r6twmoPvIgiCXO1g9mmjXcob9AU6Ogtkf0GcMMooJjMuVDGD40nAOh54RxKM
         PUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OzFdi5FA53sk7r/J78O4Hf8Scc6tKC9H8PAY8JmuySc=;
        b=A3idDgWkFwDlM7B78Kwj+mS7OJLPoUazjjjpo2HPVfKyZsJ1RSJSyXvT0f+OFtnDXL
         YfspGRTqeLIH/BuVblr+7667ZlhSefoqukPB8aMZ3s6MYYKFt2yiPH14h0zqjR8rfo0y
         tTOxaG/CJVern/cguqLiXQ/Kn6V+hsGB7HOtOwr6A+Wx2f1zddzPZKzlEPQoRlQwhTF8
         2oujOGBriD5CTFJsGommLdtRudFp4LgspsEQNupL9m/4sUhC7KNa9tyZ7RInIo+jbiam
         T+ENmk9MPcavgt7sxTyU6orddIvr8vFwnoL7t8BPjl5AJmG2YgmQy75XY//TpIH4G4So
         JKxA==
X-Gm-Message-State: APjAAAUgF6dBuwXodUJZXPb4m18MAESxCMrl1fcEzv1a5sIDWGBs3mk7
        xg9WQk0BTr5OdiSDFLVvy14jHt1C0IZ7YxqhW8fWopAS
X-Google-Smtp-Source: APXvYqwkQD3IHYB235QRVnPLSDc0R5AJFY+mAE0Y4N+QbgGWm4paBPug7aCAkNhEoTeVtrcHmrV718BAPonSYrdKKzo=
X-Received: by 2002:a7b:c751:: with SMTP id w17mr20353364wmk.127.1560783806243;
 Mon, 17 Jun 2019 08:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190617143728.4949-1-geert+renesas@glider.be>
In-Reply-To: <20190617143728.4949-1-geert+renesas@glider.be>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 17 Jun 2019 11:03:14 -0400
Message-ID: <CADnq5_PaTnL-_kzbGquQbomy+31ArFcvBke+R_yZyXn39cCQyQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Add missing newline at end of file
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 10:45 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> "git diff" says:
>
>     \ No newline at end of file
>
> after modifying the file.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/modules/power/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/modules/power/Makefile b/drivers/gpu/drm/amd/display/modules/power/Makefile
> index 87851f892a52d372..9d1b22d35ece9136 100644
> --- a/drivers/gpu/drm/amd/display/modules/power/Makefile
> +++ b/drivers/gpu/drm/amd/display/modules/power/Makefile
> @@ -28,4 +28,4 @@ MOD_POWER = power_helpers.o
>  AMD_DAL_MOD_POWER = $(addprefix $(AMDDALPATH)/modules/power/,$(MOD_POWER))
>  #$(info ************  DAL POWER MODULE MAKEFILE ************)
>
> -AMD_DISPLAY_FILES += $(AMD_DAL_MOD_POWER)
> \ No newline at end of file
> +AMD_DISPLAY_FILES += $(AMD_DAL_MOD_POWER)
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
