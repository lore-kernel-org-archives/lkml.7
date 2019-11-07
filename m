Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760FAC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 03:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A5E20673
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 03:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bz3+znqk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733156AbfKGDj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 22:39:28 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41640 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbfKGDj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 22:39:27 -0500
Received: by mail-ed1-f67.google.com with SMTP id a21so671807edj.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 19:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4QNlRTLGQr37mhizIFRLl8TgY9SBjAFUyhyF2JeZyVA=;
        b=Bz3+znqk7TnIZHoZzBYIEZeHa1gUhSjnWdchWVDNXV5CRRegeHogkTvHi39lad8Gde
         +AMSXXKWIiBiFwAEAJKqT1UDffdQSrskvm9w+5o8hjOGVEeFLYyCKwhNOZyaJyOHlMmF
         97U6Blkq786w6QCPKD5KWleQKeLEKx/N//Po8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4QNlRTLGQr37mhizIFRLl8TgY9SBjAFUyhyF2JeZyVA=;
        b=K221PG1k2kIExPgNZRebqBgU/JzAaB6aoZjzM0CaKjHit0JqbTM8zhuPPQdE0qQPa3
         hGwYoW3MwhGrfQ9fp8lrrIsxz4ijsHPw6QS12PQc+FYMGMgLGnC4MMSfMF0orIAPOu9a
         o65X/lV8fxFv11ZQFIZs9iW/lIJB5qil8ARIUpuPU83WCu0hiy7TlVuSqk0yylOLvffX
         MR/nisPJdNieBLgEBBWqHn2BiHwQptGPU0wfsuDwb6YXUAPlbRsC9bwmZgONbItTnIyt
         4q4FoOdUSQYRl22t1vTDrfFUYrEfvgxA6MS8dlwlFMhU02VO7EfJu+/0zHZNgTFloMeC
         TG9w==
X-Gm-Message-State: APjAAAXtTxeytiDR+5O4gWcSKNa90lpEBwHh7w39uxcAdoUnhuEhgPxZ
        CoNvxYgaXcrvSa5bnAFmLG78k/xmZPFfBw==
X-Google-Smtp-Source: APXvYqzEoSVA6x4MbGG4iurGD+4UPPe09ugi2189c5gnGFeLnQ0MKb1BIBe+3oy+621/R2s2s0k32g==
X-Received: by 2002:a17:906:448:: with SMTP id e8mr979839eja.326.1573097965040;
        Wed, 06 Nov 2019 19:39:25 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id z4sm22518edx.7.2019.11.06.19.39.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2019 19:39:24 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id t26so743319wmi.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 19:39:24 -0800 (PST)
X-Received: by 2002:a7b:cbd9:: with SMTP id n25mr816484wmi.64.1573097963552;
 Wed, 06 Nov 2019 19:39:23 -0800 (PST)
MIME-Version: 1.0
References: <20191107033057.238603-1-hiroh@chromium.org>
In-Reply-To: <20191107033057.238603-1-hiroh@chromium.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 7 Nov 2019 12:39:12 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Buphd-1Z7+AjQ8fpdvMYY7QWPJBAYRTFF-46KM1LZ4GQ@mail.gmail.com>
Message-ID: <CAAFQd5Buphd-1Z7+AjQ8fpdvMYY7QWPJBAYRTFF-46KM1LZ4GQ@mail.gmail.com>
Subject: Re: [PATCH] media: mtk-vcodec: Remove extra area allocation in an
 input buffer on encoding
To:     Hirokazu Honda <hiroh@chromium.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 7, 2019 at 12:31 PM Hirokazu Honda <hiroh@chromium.org> wrote:
>
> MediaTek encoder allocates non pixel data area for an input buffer every
> plane. As the input buffer should be read-only, the driver should not write
> anything in the buffer. Therefore, the extra data should be unnecessary.
>
> Signed-off-by: Hirokazu Honda <hiroh@chromium.org>
> ---
>  drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
> index fd8de027e83e..6aad53d97d74 100644
> --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
> +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
> @@ -332,14 +332,12 @@ static int vidioc_try_fmt(struct v4l2_format *f,
>
>                 pix_fmt_mp->num_planes = fmt->num_planes;
>                 pix_fmt_mp->plane_fmt[0].sizeimage =
> -                               pix_fmt_mp->width * pix_fmt_mp->height +
> -                               ((ALIGN(pix_fmt_mp->width, 16) * 2) * 16);
> +                       pix_fmt_mp->width * pix_fmt_mp->height;
>                 pix_fmt_mp->plane_fmt[0].bytesperline = pix_fmt_mp->width;
>
>                 if (pix_fmt_mp->num_planes == 2) {
>                         pix_fmt_mp->plane_fmt[1].sizeimage =
> -                               (pix_fmt_mp->width * pix_fmt_mp->height) / 2 +
> -                               (ALIGN(pix_fmt_mp->width, 16) * 16);
> +                               (pix_fmt_mp->width * pix_fmt_mp->height) / 2;
>                         pix_fmt_mp->plane_fmt[2].sizeimage = 0;
>                         pix_fmt_mp->plane_fmt[1].bytesperline =
>                                                         pix_fmt_mp->width;
> @@ -347,8 +345,7 @@ static int vidioc_try_fmt(struct v4l2_format *f,
>                 } else if (pix_fmt_mp->num_planes == 3) {
>                         pix_fmt_mp->plane_fmt[1].sizeimage =
>                         pix_fmt_mp->plane_fmt[2].sizeimage =
> -                               (pix_fmt_mp->width * pix_fmt_mp->height) / 4 +
> -                               ((ALIGN(pix_fmt_mp->width, 16) / 2) * 16);
> +                               (pix_fmt_mp->width * pix_fmt_mp->height) / 4;
>                         pix_fmt_mp->plane_fmt[1].bytesperline =
>                                 pix_fmt_mp->plane_fmt[2].bytesperline =
>                                 pix_fmt_mp->width / 2;
> --
> 2.24.0.rc1.363.gb1bccd3e3d-goog
>

Thanks for the patch!

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Now I'd also appreciate if there is anyone who could help testing this
further, especially on a platform that is not a Chromebook.

Best regards,
Tomasz
