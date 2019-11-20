Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44CAC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D832251F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="arwFzBSZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbfKTMoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 07:44:25 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35730 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728314AbfKTMoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 07:44:25 -0500
Received: by mail-ed1-f66.google.com with SMTP id r16so20172302edq.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 04:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HviZfN2k+Zd+emwLWrTA9g1CfuiJpYrc79Znlkyezqg=;
        b=arwFzBSZNJjQt0kefLROlBKMg+mng7y5GKdI5zvN0OlBIofxb3lFWA8mRhlROMiwq0
         bq+o2vP9tLQgVaGN4HqFRUG3Io0JKJm8afxoYL/BLyddunjpqiL1wTIZKPFR+zHp7C2o
         wfYhXWhUwQHbtDAR4TSyeUkQeN7E3E9nwDpTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HviZfN2k+Zd+emwLWrTA9g1CfuiJpYrc79Znlkyezqg=;
        b=FqbpOV1tmhSzEw3GBuA2KsCMH9JSZa+9Z7bmCjTVB05gdG2b6fs0QQ6mqjKM/JCTgK
         B3ZHh44aciOxXIAI+0N39oZi7JaFfxH/0KQVHA1naUsV2HLhG0FcvwUVbk48WFqH/BDp
         M7H8Z8fPDsZSfRUHd/lcb9eL0DtHBqof1aqYKLVAkqa7r8uCaTWrLra1It5C8x8DIq96
         l6G3LN9fa5cxiIuqy6r3L5jyAVzIc6gwLXcgh1ZWe+/Y9/fnQU7sIkwRNW7cfEV3PIWQ
         /7e9JsGLTlO3nXOLaB8Q3DNiIkOZlL8hbb/TiKyxkxIMJqJMWWvXi0/+k3EfIoD6iQSJ
         897A==
X-Gm-Message-State: APjAAAUkQu9bwNyj2a5CK4MMuTcwXQcovRjr6WS4pOGpCfPMz3zwAW3v
        ZAM1b86Ci0agWLicMt0Z9HOBT29zoN9myA==
X-Google-Smtp-Source: APXvYqx7+8sOONp0PyOnqpfchyA4hjLFD28cV7Od+wdSzJ0AsgR4qjCrAZNM6Gd/0n6sh4iEswqYDA==
X-Received: by 2002:a17:906:4697:: with SMTP id a23mr5211425ejr.322.1574253862819;
        Wed, 20 Nov 2019 04:44:22 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id q5sm1395682edg.66.2019.11.20.04.44.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2019 04:44:22 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id u18so6845885wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 04:44:21 -0800 (PST)
X-Received: by 2002:a1c:7fd8:: with SMTP id a207mr3051203wmd.10.1574253861317;
 Wed, 20 Nov 2019 04:44:21 -0800 (PST)
MIME-Version: 1.0
References: <HE1PR06MB4011EDD5F2686A05BC35F61CAC790@HE1PR06MB4011.eurprd06.prod.outlook.com>
 <20191106223408.2176-1-jonas@kwiboo.se> <HE1PR06MB4011FF930111A869E4645C8CAC790@HE1PR06MB4011.eurprd06.prod.outlook.com>
In-Reply-To: <HE1PR06MB4011FF930111A869E4645C8CAC790@HE1PR06MB4011.eurprd06.prod.outlook.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 20 Nov 2019 21:44:09 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CSWea=DNjySJxZmVi+2c5U4EKVPa1mf3vHh70+YrAQCA@mail.gmail.com>
Message-ID: <CAAFQd5CSWea=DNjySJxZmVi+2c5U4EKVPa1mf3vHh70+YrAQCA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] media: hantro: Reduce H264 extra space for motion vectors
To:     Jonas Karlman <jonas@kwiboo.se>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonas,

On Thu, Nov 7, 2019 at 7:34 AM Jonas Karlman <jonas@kwiboo.se> wrote:
>
> A decoded 8-bit 4:2:0 frame need memory for up to 448 bytes per
> macroblock with additional 32 bytes on multi-core variants.
>
> Memory layout is as follow:
>
> +---------------------------+
> | Y-plane   256 bytes x MBs |
> +---------------------------+
> | UV-plane  128 bytes x MBs |
> +---------------------------+
> | MV buffer  64 bytes x MBs |
> +---------------------------+
> | MC sync          32 bytes |
> +---------------------------+
>
> Reduce the extra space allocated now that motion vector buffer offset no
> longer is based on the extra space.
>
> Only allocate extra space for 64 bytes x MBs of motion vector buffer
> and 32 bytes for multi-core sync.
>
> Fixes: a9471e25629b ("media: hantro: Add core bits to support H264 decoding")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
> Changes in v3:
>   - add memory layout to code comment (Boris)
> Changes in v2:
>   - updated commit message
> ---
>  drivers/staging/media/hantro/hantro_v4l2.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>

Thanks for the patch!

What platform did you test it on and how? Was it tested with IOMMU enabled?

Best regards,
Tomasz

> diff --git a/drivers/staging/media/hantro/hantro_v4l2.c b/drivers/staging/media/hantro/hantro_v4l2.c
> index 3dae52abb96c..c8c896a06f58 100644
> --- a/drivers/staging/media/hantro/hantro_v4l2.c
> +++ b/drivers/staging/media/hantro/hantro_v4l2.c
> @@ -240,14 +240,30 @@ static int vidioc_try_fmt(struct file *file, void *priv, struct v4l2_format *f,
>                 v4l2_fill_pixfmt_mp(pix_mp, fmt->fourcc, pix_mp->width,
>                                     pix_mp->height);
>                 /*
> +                * A decoded 8-bit 4:2:0 NV12 frame may need memory for up to
> +                * 448 bytes per macroblock with additional 32 bytes on
> +                * multi-core variants.
> +                *
>                  * The H264 decoder needs extra space on the output buffers
>                  * to store motion vectors. This is needed for reference
>                  * frames.
> +                *
> +                * Memory layout is as follow:
> +                *
> +                * +---------------------------+
> +                * | Y-plane   256 bytes x MBs |
> +                * +---------------------------+
> +                * | UV-plane  128 bytes x MBs |
> +                * +---------------------------+
> +                * | MV buffer  64 bytes x MBs |
> +                * +---------------------------+
> +                * | MC sync          32 bytes |
> +                * +---------------------------+
>                  */
>                 if (ctx->vpu_src_fmt->fourcc == V4L2_PIX_FMT_H264_SLICE)
>                         pix_mp->plane_fmt[0].sizeimage +=
> -                               128 * DIV_ROUND_UP(pix_mp->width, 16) *
> -                                     DIV_ROUND_UP(pix_mp->height, 16);
> +                               64 * MB_WIDTH(pix_mp->width) *
> +                                    MB_WIDTH(pix_mp->height) + 32;
>         } else if (!pix_mp->plane_fmt[0].sizeimage) {
>                 /*
>                  * For coded formats the application can specify
> --
> 2.17.1
>
