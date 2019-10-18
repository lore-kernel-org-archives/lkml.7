Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D569CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 20:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B6F62054F
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 20:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7mjE8tu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406216AbfJRUaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 16:30:19 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:34702 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390076AbfJRU3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 16:29:35 -0400
Received: by mail-wm1-f54.google.com with SMTP id y135so10089652wmc.1;
        Fri, 18 Oct 2019 13:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ba9RrRbkLJnLGttS3tqY6uEIGZIveq6h2QQOGVun8HE=;
        b=J7mjE8tuxxDn7+f/2dmZuzmjyVufQc43Y/oUQ4Hki3fyAfOKmoMkbpgQRZcPLHhVoR
         29xxtFLLQCJX6vxiw0Pquh61D0zAfL5Dr2TiiX15E4kg9lwpnH6GQdeeCeXxVPyJv2iL
         4LF0YMaBRikKmN7Pu6ZdfEo7TU+zKHFpwSZCHj2fVySkg6Q74eyYUziS3aZC3IswOSUe
         1e+86YXklPCz3EbvhJ1CKeQXBbhPYQi60f8H/w7jcZbifM2BhviocXf5Xj9/4AYyN1f4
         IbjUzdACzQzU7UcDjFqcKXIY0nqxjH6GPqGufSSzHVlFK5QKnRBXxfr6ACBGfffNgHGs
         ftIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ba9RrRbkLJnLGttS3tqY6uEIGZIveq6h2QQOGVun8HE=;
        b=JqehOrHg+qo5a2u8Zde0GcZ/A+ZjQa8+DJbzvfYbwQ+JL9eSzF7tpD7YOByNKbDixT
         +iOlH5DBDF1lWY4nN3NHYdzhVGPIGqXNExcGxcGFYFzys3w/tpXAeyPcLT/hvIahi+GJ
         q8UUw8AZM5kX9R8vvieE6hLmnPxqaor2xUoiEErmk66RKDGvzq+d/5RjmB0fhn5PpLOh
         g6BtrRR0AxCv7MbLEXRsj035Rkw/dFb0nW0b0OZpQteBsbmg+IMserR2O8NK9j/Kyej/
         C0JpvX/mZLgBoD+qah3UbgfjTFiKiR9IWPj3WMSq7z3teqy8xEZl6TT4UPeyhxb3kput
         /ZVQ==
X-Gm-Message-State: APjAAAXvG9UOx4SJEyj6RpxhVVDeQTQGCGLsQ/HPX1RZNI4lkqlK/Bcg
        CSgvc1dbcpKvfpDtPsjs4zkorZEkkUIY+1dQ+sg=
X-Google-Smtp-Source: APXvYqydu7tjGRS+9xHS/6nmdzlot6xGzdm702IYYBjChFYo3Ba935zPg0y/isfGBQU1q32AZ6rmmzMC8gX7ecdecDE=
X-Received: by 2002:a1c:968b:: with SMTP id y133mr9000951wmd.141.1571430542263;
 Fri, 18 Oct 2019 13:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191018081508.11028-1-colin.king@canonical.com>
In-Reply-To: <20191018081508.11028-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 18 Oct 2019 16:28:50 -0400
Message-ID: <CADnq5_OfwU2yuxrkW0EjqSjxeYBRA4kw1gksDEmE+pcSOuSwAg@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amdgpu/psp: fix spelling mistake "initliaze" -> "initialize"
To:     Colin King <colin.king@canonical.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 4:15 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a DRM_ERROR error message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index b996b5bc5804..fd7a73f4fa70 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -90,7 +90,7 @@ static int psp_sw_init(void *handle)
>
>         ret = psp_mem_training_init(psp);
>         if (ret) {
> -               DRM_ERROR("Failed to initliaze memory training!\n");
> +               DRM_ERROR("Failed to initialize memory training!\n");
>                 return ret;
>         }
>         ret = psp_mem_training(psp, PSP_MEM_TRAIN_COLD_BOOT);
> --
> 2.20.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
