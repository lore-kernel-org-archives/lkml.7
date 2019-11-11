Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DDAC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F25206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Csn/2IzC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfKKSB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:01:26 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:53811 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKKSB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:01:26 -0500
Received: by mail-wm1-f54.google.com with SMTP id u18so250859wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 10:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LZm0O+9adBfpx+ovnSPJOcOY1JX1dPWpztVmEz4llkE=;
        b=Csn/2IzCJ6MEF+fyZKlzifXzPAy8ny1P4ICBVPnPsRGKuub7/rNPpw/Qn3CGNuuxy5
         WtxeQ+DpHHi1LRluKoais2+875spWmUBYjiSIqIbluzGGNliVcglPlVSR46ebYq76qAc
         BcyVjUlIWB9KPVe5mWhY8rRxEIG2ZD/KiSvIBmEGVxQBqa1koidTmQ6V3yXmH0aigPSF
         Jq+AY0MRvqSBxIW8ZOSGQLOWNbhMcnW1i/SlF47dc4bnPvjvFGMPOG0wdcuUa71RLpGF
         oMqKEmjNCin2r9u4BYC2Gorsi/pDfgPb2JCpbApUeu2+KOJ1tHcbXk4M/fUGmWNgauDO
         FbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LZm0O+9adBfpx+ovnSPJOcOY1JX1dPWpztVmEz4llkE=;
        b=osTVksQXQUaEzPwMeMcJZWMIEO0AkPE7b+6f0esiNtS61RaMm7YaGAF/HCkDJcrghg
         85NJbLmbXA770wD1JVYKbyNJQvC/dD2nOS0+28Xd6F//b9YNwqvTh0QY0BFlOcl9HsdU
         9ItTq6BhUgm9rsddW4YevwIIQT4pn5hESJdtKpTP61fREluaH2TaMiXUWSozVXc8rI3+
         inNd2AFcZi2TW8l+66CBriAkgHO4xriY20Kw9OfVwFCwEAGvtUUJRZJqnSHDitYANkMS
         CxRXdOckWJuoLWqUPsPFX7ds1dUZjVEo6d/sJUzlUOfBkDQj9g50svyTNAbmhF2RUw0Q
         tHaw==
X-Gm-Message-State: APjAAAUtmsxzEcb/lzX1C6MUy04p4sU6bYhYl27kbhpDQ1SUVxneC4Cu
        /U9BFPmHjwgX1NKbCWhy7j8zZj4JqfE4hiA0TI0=
X-Google-Smtp-Source: APXvYqx3F2xEQnEwJIJbF32491P4OsB8Wm3WOoRDkOVtWpzT+0v4cABkBIFm0/KZ3L3bKl0dq1GLJiYXU85t9P2VkwI=
X-Received: by 2002:a1c:790b:: with SMTP id l11mr200549wme.127.1573495284364;
 Mon, 11 Nov 2019 10:01:24 -0800 (PST)
MIME-Version: 1.0
References: <20191109093538.23964-1-yuehaibing@huawei.com>
In-Reply-To: <20191109093538.23964-1-yuehaibing@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 11 Nov 2019 13:01:11 -0500
Message-ID: <CADnq5_O7JwQd4+ncEe+KusqNqPBGXgkcUBX6VHP5OjhNwUseWg@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: remove set but not used variable 'bpc'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Jun Lei <Jun.Lei@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
        Zhan Liu <Zhan.Liu@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Sun, Nov 10, 2019 at 9:30 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c: In function get_pbn_from_timing:
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:2364:11: warning:
>  variable bpc set but not used [-Wunused-but-set-variable]
>
> It is not used since commit e49f69363adf ("drm/amd/display: use
> proper formula to calculate bandwidth from timing")
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> index bdc8be3..53394e2 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -2653,13 +2653,11 @@ static int get_color_depth(enum dc_color_depth color_depth)
>
>  static struct fixed31_32 get_pbn_from_timing(struct pipe_ctx *pipe_ctx)
>  {
> -       uint32_t bpc;
>         uint64_t kbps;
>         struct fixed31_32 peak_kbps;
>         uint32_t numerator;
>         uint32_t denominator;
>
> -       bpc = get_color_depth(pipe_ctx->stream_res.pix_clk_params.color_depth);
>         kbps = dc_bandwidth_in_kbps_from_timing(&pipe_ctx->stream->timing);
>
>         /*
> --
> 2.7.4
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
