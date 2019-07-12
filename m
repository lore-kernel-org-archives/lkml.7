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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFB1C742D6
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 17:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86900205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 17:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dx2+eI7n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfGLR4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 13:56:53 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37111 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfGLR4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 13:56:52 -0400
Received: by mail-wm1-f66.google.com with SMTP id f17so9698749wme.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 10:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DJSixh5eUA7ZuYLo3zM8xEkgRu/s1ZTrnfSXH7ypmHc=;
        b=Dx2+eI7nrYFsu9WMMxg8yMFuBZCeS3Z8SDdEnAG2fI9uXr1hpZquU0LMGuhLHKFWp+
         lupWa4P3CCXbmTiTze1gzXb4OTXE4sXWsvELGlbwIVS7yayPfzQkb/QiXARO6hgk1ylI
         PmZL8W9iApy+tMgfkzA8Rg9r/YWk7li7y5NxNNFnS3Hgk+FluZn0hK71KL/I0rJk986F
         axWFd0GW2ONPhvlpTWYCWYRXORANKaKKOX39LPIB1bUXhkhHngomOBZxH86KtjvrkQkJ
         GZBx6DEiY0OPofKJKw72IjuYJyaoOc9jJUOsZqbZfeWykQo+3tT8UdhJioWeXkVMAvSm
         vCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DJSixh5eUA7ZuYLo3zM8xEkgRu/s1ZTrnfSXH7ypmHc=;
        b=XNQio5jtsC8QpHijvLlnOcUV+OwwMtU3jZHS9AntId6WE9OH55AehwSq9D8z4XxTn8
         N0nBnm/JBway7CNNCFlJTcOatB9ipypEpbV3kSfrSOqTkXnUWtnZVCDQ09hNJpId5GdB
         W7k2gQvrQqATO9Q6OBQuhIHFCuD4SOZZKrqR8cHbxwPUfG1oP1hGqLvy0QPL8H7X5viJ
         e0ol5cGbF/51rvXVyEHUNBnm//nP038BaKN+6nol2jekc6afKI5kpzUKyS6Jo6YQr0Iy
         EnZ6kv6nSabc/h5GvEGBUAyM+igcG9WoQRyj1awLe+lks88xCxxIYTPb31uUTmSkx3im
         ZBKw==
X-Gm-Message-State: APjAAAUNr1mUHitZ5L8gbQ+dRun4vetI7/s302315cYSbCxCfvcFPm1C
        hI18oSFU2DSHI3IzvuOUoqSHV1FgofiDeGl/fpw=
X-Google-Smtp-Source: APXvYqyML4Lk6QCxD99I7qZEOiSKP9iDUkViZ1UmbngxvdSyqiF0OLh89O057bWk3ccYp26LS7x3xlkj6sjYmoeIG2I=
X-Received: by 2002:a1c:a1c5:: with SMTP id k188mr10769220wme.102.1562954210408;
 Fri, 12 Jul 2019 10:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190712094009.1535662-1-arnd@arndb.de>
In-Reply-To: <20190712094009.1535662-1-arnd@arndb.de>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 12 Jul 2019 13:56:39 -0400
Message-ID: <CADnq5_O-LJHnHg_yw0jVxy9yT8ZqNq4s-U_surFXTcL=fPA21Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: return 'NULL' instead of 'false' from dcn20_acquire_idle_pipe_for_layer
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Charlene Liu <charlene.liu@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Nikola Cornij <nikola.cornij@amd.com>,
        clang-built-linux@googlegroups.com,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Jun Lei <Jun.Lei@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 5:40 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> clang complains that 'false' is a not a pointer:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:2428:10: error: expression which evaluates to zero treated as a null pointer constant of type 'struct pipe_ctx *' [-Werror,-Wnon-literal-null-conversion]
>                 return false;
>
> Changing it to 'NULL' looks like the right thing that will shut up
> the warning and make it easier to read, while not changing behavior.
>
> Fixes: 7ed4e6352c16 ("drm/amd/display: Add DCN2 HW Sequencer and Resource")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> index 70ac8a95d2db..66aa414ad38f 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> @@ -2425,7 +2425,7 @@ struct pipe_ctx *dcn20_acquire_idle_pipe_for_layer(
>                 ASSERT(0);
>
>         if (!idle_pipe)
> -               return false;
> +               return NULL;
>
>         idle_pipe->stream = head_pipe->stream;
>         idle_pipe->stream_res.tg = head_pipe->stream_res.tg;
> --
> 2.20.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
