Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E732C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204FA20863
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ulb+cJum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730712AbfB1Cl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 21:41:56 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:42037 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730263AbfB1Clz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 21:41:55 -0500
Received: by mail-wr1-f52.google.com with SMTP id r5so20186366wrg.9;
        Wed, 27 Feb 2019 18:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KQa/9adRmnJoLBztwY/NmnrupIXgG9fp0O8vF8S2pzU=;
        b=Ulb+cJumNOyg784ZyCQKgdXSz1UZ2gEpvrIqwmT8dPu1ChhXI9WrTNlwf+5oTYqvbB
         5gC3iROH0fn7H3aW/Vo084fvIfIdlkKwkITkm4XS1RnsK5rVtQcogxjpRbIvBEEsXPed
         bO5gMa/XrnWhnoL++3KgIWsJsJOmoKzQ25XEGfmQslddqTzWz1ZanQOmGcugRd/B6o0F
         jc3P4DOiJHf8r3Le936RNhRCdDb2eBvKQUOmPnsqmpWE9FR58eBjycY/9IUnRS46GiDT
         FtFX8fqREP6R5K2trf74hqmJbFOpGoINMz6M/gllvooToFuX+1l5KKKuHjObmGJgOHr4
         AXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KQa/9adRmnJoLBztwY/NmnrupIXgG9fp0O8vF8S2pzU=;
        b=dehh7K3GxgzwDoEFGIwBxBZrKPFNhKmdkIDIFufL+xxtb69A3Isa/YhD2og0Yvdbhz
         GclggRcLgKcCbUk67w40raRJKDjeMX77fO6Ikxui2Y3TJ4YJ7RO3hFdJRNUjsi4qRjuU
         9Ec/THOSAQAlOY5TW4Ygfk9uxQaq6k7/Hix6UQtZXRAWZKSlA4DIst3RfhhGCFNf6epv
         RKVRQK4yVHelZz6PTIsTLqklpACDz1ZRBlikAmjjz0WyLtZU6mQiUZZoBx/PQx5t05RM
         +6iDJX/WH4qskkVGOWhfZCZ6aPABgcuAHtIDhVQmvy1aIe7goJrzC6fydgZZGhT1LEh1
         Syyg==
X-Gm-Message-State: APjAAAVHtSM4iJ4V7OdVqex8FMW/yOEwr+O9l/6h5yidICY5uUhw6Mbx
        rhRmtHBwdt5dZnQF6/9NmwzUy6AtEj+iBSIHTAI=
X-Google-Smtp-Source: APXvYqy0+OwVlBW4RW0hQVM7TpHMoho6OpOpYA8Yg14pjhjZd7vxlH5qVnYLl3xs8TW0Dr0dMTpBYzzcqt9GsCLEoF4=
X-Received: by 2002:adf:f102:: with SMTP id r2mr4423429wro.288.1551321713915;
 Wed, 27 Feb 2019 18:41:53 -0800 (PST)
MIME-Version: 1.0
References: <20190218135935.132773-1-yuehaibing@huawei.com>
In-Reply-To: <20190218135935.132773-1-yuehaibing@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 27 Feb 2019 21:41:41 -0500
Message-ID: <CADnq5_OJnArPi3FvGO_a_q8_qQu2uSLaBA=SqZKH0HkvVdLJLA@mail.gmail.com>
Subject: Re: [PATCH -next] drm/ttm: remove set but not used variable 'bdev'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Tue, Feb 19, 2019 at 3:22 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/gpu/drm/ttm/ttm_execbuf_util.c: In function 'ttm_eu_fence_buffer_objects':
> drivers/gpu/drm/ttm/ttm_execbuf_util.c:191:24: warning:
>  variable 'bdev' set but not used [-Wunused-but-set-variable]
>
> It's not used any more and can be removed.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpu/drm/ttm/ttm_execbuf_util.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_execbuf_util.c b/drivers/gpu/drm/ttm/ttm_execbuf_util.c
> index 93860346c426..0075eb9a0b52 100644
> --- a/drivers/gpu/drm/ttm/ttm_execbuf_util.c
> +++ b/drivers/gpu/drm/ttm/ttm_execbuf_util.c
> @@ -188,13 +188,11 @@ void ttm_eu_fence_buffer_objects(struct ww_acquire_ctx *ticket,
>         struct ttm_validate_buffer *entry;
>         struct ttm_buffer_object *bo;
>         struct ttm_bo_global *glob;
> -       struct ttm_bo_device *bdev;
>
>         if (list_empty(list))
>                 return;
>
>         bo = list_first_entry(list, struct ttm_validate_buffer, head)->bo;
> -       bdev = bo->bdev;
>         glob = bo->bdev->glob;
>
>         spin_lock(&glob->lru_lock);
>
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
