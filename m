Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B015C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 15:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B432067B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 15:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OF0C4tId"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfKLPwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 10:52:55 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35320 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbfKLPwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 10:52:54 -0500
Received: by mail-wr1-f65.google.com with SMTP id s5so7998961wrw.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 07:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KlI/w4iGgmfxEIzjQGA0tOMY3tGzHSo0L7rc1WR4Tww=;
        b=OF0C4tIdXYsl972TNJBl4pbhsNz/CCpB9n3zKmIKIeN4Agp0gIi0Mv93g/oEwmXfkt
         yVNReAZorkkGUdzT4gksywjD3mO+XCdyVKKoNVSkEsyeqKHGwbYmmOMZ5sezTcgpN/iH
         MFdtx75mctG3r6cEeQQcA0p6CAdnq5YDK16GMNrMoW/IUYAB29zgVz2Idm/toCecmgtu
         EFOBTG8Niyhk6shHZg7yvfC0VkYAhz8nfhViYAFaXuYDBZT4eCdt5fM8RL9d5QzUYYHY
         pU3eBwzub0BbvGGC23BM5QR9Iv/Ga6NsTscO0mHHNMhQILQapZsMm+GS9sXY37x2TQJN
         AlrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KlI/w4iGgmfxEIzjQGA0tOMY3tGzHSo0L7rc1WR4Tww=;
        b=kM4jwCjfZ63lbqv2xUCQgyUzF/yfY/bvVMgjDa39/elT8TJy4UCdk7QXdyRsn2pgFQ
         GpRTgSmo4qdDFe5XleQatXYvN+HA/S1g2r6pH2t5GWJh4SFb26kAy5uLZJl0/IjJV09S
         n2u7XcrnjfpkyhZUH/GRid0D+MydALoOjEMNZEWy/R/rL9OW7dGog2kcP6EZ6RtnJJQJ
         eMhfF/GMTS0SlxQHYfitoJEveQXhqDAFyqJqrRmkrRsjm+eSMFEKUHdVNYtAsOIlapKE
         5Ce1q0PKNXtrHYIeIVcch+EXtz3tedtqBjahMfT8IdIsimG3GU34HypiwJ3vzCi3Vfj7
         XKEA==
X-Gm-Message-State: APjAAAW4HlKhC2UzT/NNgLJdEUbBEk882xaFFpzeAo+rCWyBc9+866q0
        8lBC9WZjxusANIXPxIyGkGOu7DxWgigkl9hcqk9Z0A==
X-Google-Smtp-Source: APXvYqyR51zNVFTxc2XNo24rGAzDgHRLqcTcjPjLyL0l3uVC46ncoQjb2rfwmQfKNuaS/+Pq9thzuxvlUF9ZNE0wh4I=
X-Received: by 2002:adf:9d87:: with SMTP id p7mr25597794wre.11.1573573972656;
 Tue, 12 Nov 2019 07:52:52 -0800 (PST)
MIME-Version: 1.0
References: <20191109093538.23964-1-yuehaibing@huawei.com> <20191112021050.13128-1-yuehaibing@huawei.com>
In-Reply-To: <20191112021050.13128-1-yuehaibing@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 Nov 2019 10:52:40 -0500
Message-ID: <CADnq5_Mj5vHSrXq-tkwoRQ+fejfosSnRpia54MpsTddvKzothA@mail.gmail.com>
Subject: Re: [PATCH v2 -next] drm/amd/display: remove set but not used
 variable 'bpc'
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

On Tue, Nov 12, 2019 at 3:13 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c: In function get_pbn_from_timing:
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:2364:11: warning:
>  variable bpc set but not used [-Wunused-but-set-variable]
>
> It is not used since commit e49f69363adf ("drm/amd/display: use
> proper formula to calculate bandwidth from timing"), this also
> remove get_color_depth(), which is only used here.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.  Thanks!

Alex

> ---
> v2: also remove unused get_color_depth()
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c | 15 ---------------
>  1 file changed, 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> index bdc8be3..1be4277 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -2638,28 +2638,13 @@ static struct fixed31_32 get_pbn_per_slot(struct dc_stream_state *stream)
>         return dc_fixpt_div_int(mbytes_per_sec, 54);
>  }
>
> -static int get_color_depth(enum dc_color_depth color_depth)
> -{
> -       switch (color_depth) {
> -       case COLOR_DEPTH_666: return 6;
> -       case COLOR_DEPTH_888: return 8;
> -       case COLOR_DEPTH_101010: return 10;
> -       case COLOR_DEPTH_121212: return 12;
> -       case COLOR_DEPTH_141414: return 14;
> -       case COLOR_DEPTH_161616: return 16;
> -       default: return 0;
> -       }
> -}
> -
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
