Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA0CC2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BBF624676
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bF6N2eZx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfLSOjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 09:39:17 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38676 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfLSOjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 09:39:17 -0500
Received: by mail-lj1-f196.google.com with SMTP id k8so6501196ljh.5;
        Thu, 19 Dec 2019 06:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ETYzlEK/SKBE9MSwRXzOWbDS35XqdxpOfczqaHg4TKc=;
        b=bF6N2eZx/MJp5NAY51e4sTEXMVHwISjjo0PKdetj3l1hlk8EBl5mFcOmJzXliHShr4
         Qv0rBP6jIhfLuA3CYg+1GAP89gytngUDyanU8HoX8Ep7UOqEEMcsywI4fI82j79oNZDC
         vIKrkImriDPp8C9uFKfr/6dSxwwy7pcKPHQmDAY8pzWNBwJrY/6xNGzB08dxLJtgqM5v
         Sb+wiyOfpSXx6nI1wORv2R5/1xNgnKBBcv/DOkq14SWK+BsssmTjxvZtRgVPGAbk3Hxk
         sOndlmLpSj0y9fidXN4WwG4jG9KByFjYzS4F7zzCP8Wh4dSoaFayAtRDQOcQB77kXXDZ
         Ti5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ETYzlEK/SKBE9MSwRXzOWbDS35XqdxpOfczqaHg4TKc=;
        b=PEtYRJxmmW0Hy3lUkW5t+faWgKN/3G2s93lBGWsgme5OopGu23xdZLPNyazUqMsI4m
         /Z34ZR6tuDwoNqBMhtBWwFi1pzY7oaT6Snb0SOuAGGclPU8in+rd0hwJ6BG+11n3cv0g
         YzBD1yRud5icL2wKgtaMH/3xSNzFqbOhTmZWstY8meUCcqMfobqZqXdXjhWFf/uZtSEB
         vw8dTIZVydCUesU9RmqMm9e4pdtD+BMSTUydly7rqOztVKvq7JF98eugn/TPQaFXs15Y
         IvcyMw3q4VQKDZhtm01iM2mK90jT+2DrB7geGBNESO6AKn3bKRC74YL7EHmWJsEXsH9O
         oK+A==
X-Gm-Message-State: APjAAAUSwo1ewANZLuILTmUhXRk3VO3HBCadvFb20SGSv8pAGwXOGWCB
        mDebFeS2LY5JbvVWr0VNf7wi6eTeX0fmdcT4orQ=
X-Google-Smtp-Source: APXvYqy/s+mw/ppdDLohJW+mt6r4UAY+bJ1lL980yaETjnVIH9hg0vqWdUTsurmxXhTnZAp4biAnBoy/zXdN4xmx5AI=
X-Received: by 2002:a05:651c:2046:: with SMTP id t6mr5483542ljo.180.1576766355054;
 Thu, 19 Dec 2019 06:39:15 -0800 (PST)
MIME-Version: 1.0
References: <20191216162136.270114-1-colin.king@canonical.com>
In-Reply-To: <20191216162136.270114-1-colin.king@canonical.com>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Thu, 19 Dec 2019 15:39:04 +0100
Message-ID: <CAMeQTsYmqJwYrAM1bGu2VyVop3sSFcp2fOMrxD4OvhH13jad9Q@mail.gmail.com>
Subject: Re: [PATCH][next] drm/gma500: fix null dereference of pointer fb
 before null check
To:     Colin King <colin.king@canonical.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 5:21 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Pointer fb is being dereferenced when assigning dev before it
> is null checked.  Fix this by only dereferencing dev after the
> null check.

Applied to drm-misc-next

Thanks
Patrik

>
> Fixes: 6b7ce2c4161a ("drm/gma500: Remove struct psb_fbdev")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/gma500/accel_2d.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/gma500/accel_2d.c b/drivers/gpu/drm/gma500/accel_2d.c
> index b9e5a38632f7..adc0507545bf 100644
> --- a/drivers/gpu/drm/gma500/accel_2d.c
> +++ b/drivers/gpu/drm/gma500/accel_2d.c
> @@ -228,8 +228,8 @@ static void psbfb_copyarea_accel(struct fb_info *info,
>  {
>         struct drm_fb_helper *fb_helper = info->par;
>         struct drm_framebuffer *fb = fb_helper->fb;
> -       struct drm_device *dev = fb->dev;
> -       struct drm_psb_private *dev_priv = dev->dev_private;
> +       struct drm_device *dev;
> +       struct drm_psb_private *dev_priv;
>         uint32_t offset;
>         uint32_t stride;
>         uint32_t src_format;
> @@ -238,6 +238,8 @@ static void psbfb_copyarea_accel(struct fb_info *info,
>         if (!fb)
>                 return;
>
> +       dev = fb->dev;
> +       dev_priv = dev->dev_private;
>         offset = to_gtt_range(fb->obj[0])->offset;
>         stride = fb->pitches[0];
>
> --
> 2.24.0
>
