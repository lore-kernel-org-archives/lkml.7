Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC0CC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 20:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BCCB20818
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 20:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QeUIN/c7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfEOU5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 16:57:41 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55995 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfEOU5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 16:57:41 -0400
Received: by mail-wm1-f68.google.com with SMTP id x64so1391727wmb.5;
        Wed, 15 May 2019 13:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9QC3JYnFQfQeHTD5SCXfr2i6Pl6XhnaYs2JDAFIiQBI=;
        b=QeUIN/c7/YlIejWIwDt9XpSOZFjPytX3cqV93/cmYyOrRFBjhoggdWvA1mF7Egm8tA
         DzhN/Cuw+ZLuErtfNYEZB4jo5O5FGD11ZnB605idA/y+STjc2189YFgIK2HEzr9rFBDT
         poNNvgRRz21DX81CL83xAYOF+/vJjiUXxSxQr9pP5+fff8oLf7ImO+U2U5MeqsE+E+Wt
         lf8sBzUthaSu6G8+2cMrbJ3tqpLLhxUTe1opNv45y00rmsBbJrx3t/XeoKMEu28ODADF
         qa3479sDLLiyKNhFVOfpTaXR7i+NS10ln4juNbQQaQ4wfmnZ0S/GL8Dp7+EQK7/fgTFc
         BWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9QC3JYnFQfQeHTD5SCXfr2i6Pl6XhnaYs2JDAFIiQBI=;
        b=WjPyZPQ2vdEFQAKXmIe04oa61xv9BH/zXl/2xWp4LXT10pSrVsq27n20lBH68aMkmM
         7yCxjyhjMBmBLAshWrklteb8KCJqdmof8NtS7QGMcGYNIZERsu6gAnk6rEWO7cs0vTOr
         e4yErFEAlMPIPm4v1z9d/m6ztKbdpcAvx/adHo7f58FfVrnfu2WtWgX7u/JF63DLRwBV
         XTTZLqAP5qQpBSgmbNot3zJDfW5pHUZduOXRCz/RLDKfah+J1fWKBVj6FZsTgqgLDg2F
         e69FUl3hBBH3hfmmk725kTjynDjNgv6xkd7MXK/WEHiX9bc1ZLugGCn65Pz9V8Tn1dra
         dfrQ==
X-Gm-Message-State: APjAAAUlnb+Qg5OOEMxUo1Hjv4eH/V0dbxft/FaQTRzAWJAdDHuR2AH9
        j0mmgvUsDOLJP/nk66CD1+bHGt8Z4bnfUBsu7+I=
X-Google-Smtp-Source: APXvYqxGtShHVqgtKX28zrE0zDc8LxPX+LlBig2BJi7/d6r7rjEHXXcdI8xJ5BM9S3hf8gdE6Mu12kvBDP6zlo+c+i8=
X-Received: by 2002:a1c:a755:: with SMTP id q82mr4208430wme.82.1557953858913;
 Wed, 15 May 2019 13:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190510070734.20625-1-colin.king@canonical.com>
In-Reply-To: <20190510070734.20625-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 15 May 2019 16:57:22 -0400
Message-ID: <CADnq5_PPv42iXCad7HqgG-3zbE307bPrMSsXCdYCNpgrHi4iRA@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amdgpu: fix spelling mistake "retrived" -> "retrieved"
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

On Fri, May 10, 2019 at 3:07 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a DRM_ERROR error message. Fix this.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/df_v3_6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> index 7d375f8dcce6..a5c3558869fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> +++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> @@ -194,7 +194,7 @@ static void df_v3_6_pmc_get_ctrl_settings(struct amdgpu_device *adev,
>                 return;
>
>         if ((*lo_base_addr == 0) || (*hi_base_addr == 0)) {
> -               DRM_ERROR("DF PMC addressing not retrived! Lo: %x, Hi: %x",
> +               DRM_ERROR("DF PMC addressing not retrieved! Lo: %x, Hi: %x",
>                                 *lo_base_addr, *hi_base_addr);
>                 return;
>         }
> --
> 2.20.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
