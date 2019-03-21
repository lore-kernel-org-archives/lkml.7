Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74976C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45377218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sykq9NtP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbfCUOAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:00:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46102 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfCUOAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:00:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id o1so6695730wrs.13;
        Thu, 21 Mar 2019 07:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=77rmCIk4/Z5BGaWdafBUOTQSfdknlM3klzpVKA754Zg=;
        b=Sykq9NtPaYz0fzI1NBbgSIKkK16iz+zb7QJ8PDxRAnNWpRoHihyX7ZKcWk+Xf22I7g
         TdX+MBMwhvGAxcrR6FInojPqRkPo0Kl5lagD6PrM1SRsWIkErhV6nBRBPOIdRFmB+psq
         vo7FBVr9rvuU0WE97IUmCrhb4AZde+qxfxEcct/xrBLqzeeNUNJEFa2pZY04d3AiatJH
         rEvYYyRao2v8d8unsK2QfH8DH/1enjHpQAST+19bCJ1Ce9lyHsCmcYy2YLZ6f+bzXeQU
         +5GllugukOYmGOWJj0qXLW6ZD5c5tgJyuS9Yf9LD2tE3ZKBvsAptwwN4+Fq1TSiA4Usb
         v3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=77rmCIk4/Z5BGaWdafBUOTQSfdknlM3klzpVKA754Zg=;
        b=D1wx3EaAHON0YdGMiEhxQWA0qXRSyc8pAFAVlk1RJQmp5V1uUcBOVxNav53F+qnUzP
         8gVr6adGxwwmcH+VPKaIpSBAhTRF0ALzJdGATpHKff4HQHH+Sl2YY5NfYyyAWhMCQD1L
         jqap8VquWxD6KcIy9/k9cLBASd7LZilSTpCeUUrK7fvNf3qEpNct9W4r8mgDl//SQkVa
         o4PiAEMbwwM6/hzSO3CoKR4MHhuV51VI74axhyUzHYvNkPJfObPnkJygYXVoGmzEOV9W
         1N9PvrNT2RNa7v+BK/R0mm6lHGnREIswlbMj0OvX6TI98jkBUQIFuTcBHD6X6OaSsfvs
         4W0A==
X-Gm-Message-State: APjAAAUf9gzrMXx/sbLbrMO6HTXHyqaf7SMwmbN9G/e5Z0DEd16DU799
        vlgzDLIT8hSvB1T+6brmqAQlGL1GuZNQKAOcjMo=
X-Google-Smtp-Source: APXvYqxl8dUpIAXm9yAo49AhNIVctnBtiT7RBKIMck23fCQJp8hSLvO4qfrdjXOumffQ4SsIzMGjEWewY5kPZ1mPhXk=
X-Received: by 2002:adf:eb46:: with SMTP id u6mr2700599wrn.288.1553176813416;
 Thu, 21 Mar 2019 07:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190320125939.74347-1-yuehaibing@huawei.com>
In-Reply-To: <20190320125939.74347-1-yuehaibing@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 21 Mar 2019 10:00:02 -0400
Message-ID: <CADnq5_OS8SkHxFp41u_BwQRMZAr+3KHACRndSn+bROnMPQE9JA@mail.gmail.com>
Subject: Re: [PATCH -next] drm/ttm: remove set but not used variable 'rdev'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        kernel-janitors@vger.kernel.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 9:25 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/gpu/drm/radeon/radeon_ttm.c: In function 'radeon_move_vram_ram':
> drivers/gpu/drm/radeon/radeon_ttm.c:254:24: warning:
>  variable 'rdev' set but not used [-Wunused-but-set-variable]
>
> drivers/gpu/drm/radeon/radeon_ttm.c: In function 'radeon_move_ram_vram':
> drivers/gpu/drm/radeon/radeon_ttm.c:301:24: warning:
>  variable 'rdev' set but not used [-Wunused-but-set-variable]
>
> It's not used since a987fcaa805f ("ttm: Make parts of a struct ttm_bo_device
> global.")
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>


Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/radeon/radeon_ttm.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
> index 557bdd7a2fc8..5d42f8d8e68d 100644
> --- a/drivers/gpu/drm/radeon/radeon_ttm.c
> +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
> @@ -251,14 +251,12 @@ static int radeon_move_vram_ram(struct ttm_buffer_object *bo,
>                                 struct ttm_mem_reg *new_mem)
>  {
>         struct ttm_operation_ctx ctx = { interruptible, no_wait_gpu };
> -       struct radeon_device *rdev;
>         struct ttm_mem_reg *old_mem = &bo->mem;
>         struct ttm_mem_reg tmp_mem;
>         struct ttm_place placements;
>         struct ttm_placement placement;
>         int r;
>
> -       rdev = radeon_get_rdev(bo->bdev);
>         tmp_mem = *new_mem;
>         tmp_mem.mm_node = NULL;
>         placement.num_placement = 1;
> @@ -298,14 +296,12 @@ static int radeon_move_ram_vram(struct ttm_buffer_object *bo,
>                                 struct ttm_mem_reg *new_mem)
>  {
>         struct ttm_operation_ctx ctx = { interruptible, no_wait_gpu };
> -       struct radeon_device *rdev;
>         struct ttm_mem_reg *old_mem = &bo->mem;
>         struct ttm_mem_reg tmp_mem;
>         struct ttm_placement placement;
>         struct ttm_place placements;
>         int r;
>
> -       rdev = radeon_get_rdev(bo->bdev);
>         tmp_mem = *new_mem;
>         tmp_mem.mm_node = NULL;
>         placement.num_placement = 1;
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
