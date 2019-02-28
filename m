Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D73C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3DAF21850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMSuqQ07"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730779AbfB1Cnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 21:43:55 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33925 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730535AbfB1Cny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 21:43:54 -0500
Received: by mail-wr1-f68.google.com with SMTP id f14so20225953wrg.1;
        Wed, 27 Feb 2019 18:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5rky/eQs6hz4HAwnrL2G3oVhwl5GPybsZCeiwsNiSEY=;
        b=iMSuqQ07dpV0U6yN9ayFqOVY9DMY4o2oG0zszgg5oqZLgztitjvHVh1o15LyiwTVwM
         54c2bO3bI5XClb7PG9G7JIwGHnbrl/eaJ33dW9XKG2/+3/Vx+hIfFMtCP/6tofiROzIG
         todDkfH7jzHB6BeOWrsvfHzxvRdSgrBzn52jLxfEGZcAWZGWtULszKX8KAxqTcHHP9HO
         mZUNUVa+6b93Pxz42453PU3beLWuAajNAOz7hijoosn3g2dtnQ0xlgrLNgPrGaYxSLRG
         UBbCiAspgqtJugKgcedlWtkGlDS2LocjEGOdW0VYXf8yS5hA0evOYeZuaBYoZ0bwz9Lc
         LEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5rky/eQs6hz4HAwnrL2G3oVhwl5GPybsZCeiwsNiSEY=;
        b=ZWduQteBhQEkUJt97pa2e38aXdlg08gsqkrKWc2OaeCCuKSAKaWheXJVeYNLTX9KVX
         utQqKOFrb1KbO1F7XdYPjbei25RipTbl8qYZTQ2P8H+MVKxZwFFnvB9vojfzsdqKWk+w
         mfjZKjDQ3tLqKKLdRv3NPkKdSCfjDjmQ6wTHsYKCQ3QNP4QHPEjn8J0pSLuzWcGx1MfR
         Uhx1aDNJk+VIsGupKA9Gz7XO9ordh2vJJrN9TAKq351DaqLSem6Ae/Sk+3LJQwlXJ2MK
         gHsL6ozenSIzCNzqlNSnHhRQQb/mSVyAEbzxxmCNmOUW+H5hbSDCLu8KXCB6R/zcrpxD
         oTLg==
X-Gm-Message-State: APjAAAXhNAXkVe6x6LQyFBLXbG+VuQ3SA595VmOYz7V1Sx2SIGpVheEo
        9TUtykJDitVEtMc7BGElDUMN4G0SQ3PI8GM7/1A=
X-Google-Smtp-Source: APXvYqwIRz6J1Pqj7FFFt0EeXjYY4ueZehSjYsgRr/L53OvOrJy//NXsAEPqIq1Q4yrqpySibMmNHSMDMLllW1pKLRE=
X-Received: by 2002:adf:f102:: with SMTP id r2mr4426937wro.288.1551321833012;
 Wed, 27 Feb 2019 18:43:53 -0800 (PST)
MIME-Version: 1.0
References: <20190220033150.163019-1-yuehaibing@huawei.com>
In-Reply-To: <20190220033150.163019-1-yuehaibing@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 27 Feb 2019 21:43:41 -0500
Message-ID: <CADnq5_PVY+m7eTVSZU2kHxE5FiVSgfGccVyshCcQoagj1UWG1A@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amdgpu: remove set but not used variables 'vm, bo'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Oded Gabbay <oded.gabbay@gmail.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        kernel-janitors@vger.kernel.org,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  thanks!

On Wed, Feb 20, 2019 at 3:05 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c: In function 'update_gpuvm_pte':
> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:840:20: warning:
>  variable 'bo' set but not used [-Wunused-but-set-variable]
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:838:20: warning:
>  variable 'vm' set but not used [-Wunused-but-set-variable]
>
> They're never used since introduction in a46a2cd103a8 ("drm/amdgpu: Add GPUVM
> memory management functions for KFD")
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index d7b10d79f1de..63daf758cd03 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -837,13 +837,7 @@ static int update_gpuvm_pte(struct amdgpu_device *adev,
>                 struct amdgpu_sync *sync)
>  {
>         int ret;
> -       struct amdgpu_vm *vm;
> -       struct amdgpu_bo_va *bo_va;
> -       struct amdgpu_bo *bo;
> -
> -       bo_va = entry->bo_va;
> -       vm = bo_va->base.vm;
> -       bo = bo_va->base.bo;
> +       struct amdgpu_bo_va *bo_va = entry->bo_va;
>
>         /* Update the page tables  */
>         ret = amdgpu_vm_bo_update(adev, bo_va, false);
>
>
>
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
