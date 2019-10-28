Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F046CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 13:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5563B217D6
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 13:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBIYIyYo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389735AbfJ1N72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 09:59:28 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:37831 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389712AbfJ1N70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 09:59:26 -0400
Received: by mail-wm1-f48.google.com with SMTP id q130so9256425wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 06:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Epuh0LHyo5E1PcR7w0+WUob9Z/yP2vynavOw5oUf4/c=;
        b=QBIYIyYoGcYa3jo8c5+ov/rVPeuL+6GQN+52vm8NB3NS6etmbREn2GD8lexjjBAxZ7
         1JRHzSCbfwGEvMqLbWBTokoYrPkCqbxwQKQGCF0vqyDp0oGATyL+Uj8nPawQi/vKmRGL
         sVaqwCjeo8R9d8nlzUTARFBhWjzYWo5Bf4h8oSb52L4XpVQJkbGxRlKCiBJqm5hPqnBn
         C4yplxDikJ+1iyoU+rCNh+YUR1vUoXo5dEcwWmK6AU+gatifXL93RFzFPgdQ22Xuur7+
         MclWTZFPSjbfXietlwbpCNZ+GEpHLt3J4waHkBO0xMZ5NAnCINy7ehLotdrX54fpD37m
         TN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Epuh0LHyo5E1PcR7w0+WUob9Z/yP2vynavOw5oUf4/c=;
        b=QByldoGJXfcYL811131SuXnZtUrMdXCb3Wrnm4fsakZ/167736IwmroXz9i9/ce7RX
         50O+qDVLpDi/7z2Vk9EC88A7JybH9P87oUWjxRZ3eZZ6f6Q+83W5IJhZlVwAVx6pW/5x
         hL1Fx8meVqliBz5AqQmHhkHfwdaM2h9woth9ZQRMXjGdD1fUF5e572Kwij1fMYuOVk0U
         i6PJpK6zy8ygoh/Y0QTKZ3nIUWj4WPhnuwFhSgJ8ZBkTQHXUJinqlQ12Rd0xIya8soma
         gB0J3evXkC+tw9JKI7KQQmdhRSE+r6Rs8FdJzaATQEckCJn2vOyB04sdIOIAT64B8cnd
         7L7g==
X-Gm-Message-State: APjAAAUYekI3eI7c3hlMduqzv06ehUkoO0DVAwubLlf+OZq80Y8gzA5m
        1flweZ4yWMyotZMAOj4q+87ZDqT4KwXQCaA4QPioiw==
X-Google-Smtp-Source: APXvYqyw5UtXQzVT9itPlyAx1eqR4HO6pq5cZguj7I/ZMP22holSQoobOmFx8TWW7cHP8ML1HZ07F//NeLk7saYWNKA=
X-Received: by 2002:a1c:2008:: with SMTP id g8mr139878wmg.34.1572271164178;
 Mon, 28 Oct 2019 06:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20191028133436.30608-1-yuehaibing@huawei.com>
In-Reply-To: <20191028133436.30608-1-yuehaibing@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 28 Oct 2019 09:59:11 -0400
Message-ID: <CADnq5_MrrJkDVC_yRkNTem7MQ3shcmwHt_ZMDyKd5AxJhR84Mw@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: Make calculate_integer_scaling static
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Charlene Liu <charlene.liu@amd.com>,
        Eric Bernstein <eric.bernstein@amd.com>,
        Jun Lei <Jun.Lei@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
        "Amini, Reza" <Reza.Amini@amd.com>,
        "Tatla, Harmanprit" <Harmanprit.Tatla@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 9:36 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fix sparse warning:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:963:6:
>  warning: symbol 'calculate_integer_scaling' was not declared. Should it be static?
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> index 70e601a..3769830 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -960,7 +960,7 @@ static bool are_rects_integer_multiples(struct rect src, struct rect dest)
>         return false;
>  }
>
> -void calculate_integer_scaling(struct pipe_ctx *pipe_ctx)
> +static void calculate_integer_scaling(struct pipe_ctx *pipe_ctx)
>  {
>         if (!pipe_ctx->plane_state->scaling_quality.integer_scaling)
>                 return;
> --
> 2.7.4
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
