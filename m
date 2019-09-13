Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DFFC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 20:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 667F220717
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 20:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tm/zd6+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389255AbfIMU3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 16:29:13 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54447 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387637AbfIMU3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 16:29:13 -0400
Received: by mail-wm1-f68.google.com with SMTP id p7so3999722wmp.4;
        Fri, 13 Sep 2019 13:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BwnRj7PJq/SSAsVSbXgfwpYXCFA29Cu8FrdaeblUNaY=;
        b=Tm/zd6+los5t4+AELALzP5pfwfBhKBcHKteH6R/c7Nu9nPt0meOqPrYNxlxwSnxldc
         sj4rLEyShvwUzwCkJC8uiAvJYmhXxAFFH8heSHfKGyC1Z0WwGjmM0uw8C13rR4/IwESW
         1S+3IqfjoUInrqRbKw2wBdZeI612npcV0eHqk4T5jvuO3Bhf6QZ93PoYwCNvBvQM0yiU
         6vWJR7tzUAWPHSCn/BL4N2+qloDw8QwFzUMV61hEQv8L5b/bwxSz6kuHbXi51RLhc7Dg
         wm3prHOgOPxDYLDOEed+r7O2bZvpnM4NayliF+z5N2VIgA3uRTAbTGBhGBPjZ7IuPGwb
         dHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BwnRj7PJq/SSAsVSbXgfwpYXCFA29Cu8FrdaeblUNaY=;
        b=QLcLvVKRxSIfPvYPXVCQtFZ0gxl+MTPCqym8+FY/jBwyFf6NTE2jWJJQMfP2NG9euQ
         rq2kkAFvqoFxJbqeTrKGYuXs6fzxwWkWmpHUU72i0zwQurO6c2dSomslfHrclWHwxRK9
         dmsjaVbc1KDcyKS12a9ObHdxedX2gC6x5nIc1dMQ8f54y4R3JV9yIsm3vhB+qxQOzaPE
         adsnIhf5kEwlvIXBr2fWiXPJzmyVumQ32AihNofA93F1VOR53w6Kxjpk7/Q4e2oBETJ0
         +E48o2ZmBhtBi+hkc0aW0nZyC/8LZjpyIfCSHUr7BDyZV+10pJWmr7iNMOHQXsakifmj
         Ra9A==
X-Gm-Message-State: APjAAAVL5Yb7xKxNgv/jLKGM5YT4d+c918j/24MvcOj6novtCb0p/sCU
        9r+RA1g8d6PfQiWlBFkEaD64W/ypR+gWake3QOIQGw==
X-Google-Smtp-Source: APXvYqybKucIudJAu7egTjDbJuVeu1SDruW9ZLV4m+SqmtqqxTpYMT8KJGaBUCDH4rcNUxo1IB45fuUuDiTa66dDaY0=
X-Received: by 2002:a1c:ca0f:: with SMTP id a15mr4832349wmg.102.1568406551112;
 Fri, 13 Sep 2019 13:29:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190913080248.28695-1-colin.king@canonical.com>
In-Reply-To: <20190913080248.28695-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 13 Sep 2019 16:28:58 -0400
Message-ID: <CADnq5_P+G9bRLvFAZht+LzjwmquO5guAHFAeWFO2DTi-mTasTw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: rename variable eanble -> enable
To:     Colin King <colin.king@canonical.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
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

On Fri, Sep 13, 2019 at 4:02 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in the variable name eanble,
> rename it to enable.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
> index 1488ffddf4e3..5944524faab9 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
> @@ -606,11 +606,11 @@ static void dce_mi_allocate_dmif(
>         }
>
>         if (dce_mi->wa.single_head_rdreq_dmif_limit) {
> -               uint32_t eanble =  (total_stream_num > 1) ? 0 :
> +               uint32_t enable =  (total_stream_num > 1) ? 0 :
>                                 dce_mi->wa.single_head_rdreq_dmif_limit;
>
>                 REG_UPDATE(MC_HUB_RDREQ_DMIF_LIMIT,
> -                               ENABLE, eanble);
> +                               ENABLE, enable);
>         }
>  }
>
> @@ -636,11 +636,11 @@ static void dce_mi_free_dmif(
>                         10, 3500);
>
>         if (dce_mi->wa.single_head_rdreq_dmif_limit) {
> -               uint32_t eanble =  (total_stream_num > 1) ? 0 :
> +               uint32_t enable =  (total_stream_num > 1) ? 0 :
>                                 dce_mi->wa.single_head_rdreq_dmif_limit;
>
>                 REG_UPDATE(MC_HUB_RDREQ_DMIF_LIMIT,
> -                               ENABLE, eanble);
> +                               ENABLE, enable);
>         }
>  }
>
> --
> 2.20.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
