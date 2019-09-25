Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F253DC432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 11:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD54C214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 11:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="TS084Krp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404491AbfIYLVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 07:21:11 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37071 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391119AbfIYLVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 07:21:10 -0400
Received: by mail-oi1-f193.google.com with SMTP id i16so4552135oie.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 04:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gQHzvyS6EJxoL4j+qCclsV80YoQNUUmza3XQdlaApmM=;
        b=TS084Krp2efQncyVb9Zerk6sz/BTjxW1eFyIJSe1g9KKvAhHZUXuZGMnEhreu3p2IT
         5qV4U1EWKdkVpkbrNFwd5klTpZCxL+emOT/3tEk2ytcNd8306oB3x+6LjT9arYrXwILA
         Ecr3j9v8tfpX+HqvFKitQSOtctH4YtN9T3C7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gQHzvyS6EJxoL4j+qCclsV80YoQNUUmza3XQdlaApmM=;
        b=XdNCuZFidNLVXvThsBsZMALBpw0cqqIIvjnlGtMc/8+78fvrQmkp0UpReimKqinUfF
         B7Dicbc9BHGMtlGkDvO1oOJL5+nadi3ewFPXaCEwWUKhssvNiypfUWi7bMFzQioCHh9J
         FJzlFUTM4D0qVS9imIOSCfiIv5CPQa2KHceAmfZNRffN+Z9CI1MmeEB4rVVwAAZNoUlF
         Vg1JJ04G6TSNRKvljslXUxsMZbUHEXXwzIupBkecgwt7t3PYtsi/ObmUQ27GHL0aDpU3
         3kcWSERazhIw+wDbu28meJO/RBlUHVbycW/TTZ+MRU/DXqG4UVE297qmcnLxGl7SkdFr
         PZPQ==
X-Gm-Message-State: APjAAAXmEMzkatv14KyqPShYJHXwp9CEh7JL9mIzn3lb+Zjugw+Ljq/p
        raYliiMsqP1D1xHzo/DS4Eoqen2VYc0yCV8DFBZuCw==
X-Google-Smtp-Source: APXvYqyWp880N+vlHBJoT5N/RtsimU4fHoeEeca4Hwq8OcCH+sfCTkFNCjrHfb4fVbPSP86ArlkmpfhTvRGgk/t6SK0=
X-Received: by 2002:aca:578a:: with SMTP id l132mr4190595oib.14.1569410469263;
 Wed, 25 Sep 2019 04:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <1569398801-92201-1-git-send-email-hjc@rock-chips.com> <1569398801-92201-2-git-send-email-hjc@rock-chips.com>
In-Reply-To: <1569398801-92201-2-git-send-email-hjc@rock-chips.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 25 Sep 2019 13:20:58 +0200
Message-ID: <CAKMK7uFn7JqqjQPwuEA=SvoCQ5GxB148ZA3zKSTuj7Gareu7Tw@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm: Add some new format DRM_FORMAT_NVXX_10
To:     Sandy Huang <hjc@rock-chips.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Ayan Kumar Halder <Ayan.Halder@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 10:07 AM Sandy Huang <hjc@rock-chips.com> wrote:
>
> These new format is supported by some rockchip socs:
>
> DRM_FORMAT_NV12_10/DRM_FORMAT_NV21_10
> DRM_FORMAT_NV16_10/DRM_FORMAT_NV61_10
> DRM_FORMAT_NV24_10/DRM_FORMAT_NV42_10
>
> Signed-off-by: Sandy Huang <hjc@rock-chips.com>

Again, please use the block formats to describe these, plus proper
comments as Maarten also asked for.
-Daniel

> ---
>  drivers/gpu/drm/drm_fourcc.c  | 18 ++++++++++++++++++
>  include/uapi/drm/drm_fourcc.h | 14 ++++++++++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
> index c630064..f25fa81 100644
> --- a/drivers/gpu/drm/drm_fourcc.c
> +++ b/drivers/gpu/drm/drm_fourcc.c
> @@ -274,6 +274,24 @@ const struct drm_format_info *__drm_format_info(u32 format)
>                 { .format = DRM_FORMAT_YUV420_10BIT,    .depth = 0,
>                   .num_planes = 1, .cpp = { 0, 0, 0 }, .hsub = 2, .vsub = 2,
>                   .is_yuv = true },
> +               { .format = DRM_FORMAT_NV12_10,         .depth = 0,
> +                 .num_planes = 2, .cpp = { 0, 0, 0 }, .hsub = 2, .vsub = 2,
> +                 .is_yuv = true },
> +               { .format = DRM_FORMAT_NV21_10,         .depth = 0,
> +                 .num_planes = 2, .cpp = { 0, 0, 0 }, .hsub = 2, .vsub = 2,
> +                 .is_yuv = true },
> +               { .format = DRM_FORMAT_NV16_10,         .depth = 0,
> +                 .num_planes = 2, .cpp = { 0, 0, 0 }, .hsub = 2, .vsub = 1,
> +                 .is_yuv = true },
> +               { .format = DRM_FORMAT_NV61_10,         .depth = 0,
> +                 .num_planes = 2, .cpp = { 0, 0, 0 }, .hsub = 2, .vsub = 1,
> +                 .is_yuv = true },
> +               { .format = DRM_FORMAT_NV24_10,         .depth = 0,
> +                 .num_planes = 2, .cpp = { 0, 0, 0 }, .hsub = 1, .vsub = 1,
> +                 .is_yuv = true },
> +               { .format = DRM_FORMAT_NV42_10,         .depth = 0,
> +                 .num_planes = 2, .cpp = { 0, 0, 0 }, .hsub = 1, .vsub = 1,
> +                 .is_yuv = true },
>         };
>
>         unsigned int i;
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index 3feeaa3..0479f47 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -238,6 +238,20 @@ extern "C" {
>  #define DRM_FORMAT_NV42                fourcc_code('N', 'V', '4', '2') /* non-subsampled Cb:Cr plane */
>
>  /*
> + * 2 plane YCbCr 10bit
> + * index 0 = Y plane, [9:0] Y
> + * index 1 = Cr:Cb plane, [19:0]
> + * or
> + * index 1 = Cb:Cr plane, [19:0]
> + */
> +#define DRM_FORMAT_NV12_10     fourcc_code('N', 'A', '1', '2') /* 2x2 subsampled Cr:Cb plane */
> +#define DRM_FORMAT_NV21_10     fourcc_code('N', 'A', '2', '1') /* 2x2 subsampled Cb:Cr plane */
> +#define DRM_FORMAT_NV16_10     fourcc_code('N', 'A', '1', '6') /* 2x1 subsampled Cr:Cb plane */
> +#define DRM_FORMAT_NV61_10     fourcc_code('N', 'A', '6', '1') /* 2x1 subsampled Cb:Cr plane */
> +#define DRM_FORMAT_NV24_10     fourcc_code('N', 'A', '2', '4') /* non-subsampled Cr:Cb plane */
> +#define DRM_FORMAT_NV42_10     fourcc_code('N', 'A', '4', '2') /* non-subsampled Cb:Cr plane */
> +
> +/*
>   * 2 plane YCbCr MSB aligned
>   * index 0 = Y plane, [15:0] Y:x [10:6] little endian
>   * index 1 = Cr:Cb plane, [31:0] Cr:x:Cb:x [10:6:10:6] little endian
> --
> 2.7.4
>
>
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
