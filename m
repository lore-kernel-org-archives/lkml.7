Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1170C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 17:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2E621924
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 17:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwKDc87r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391157AbfISRsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 13:48:21 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51970 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389990AbfISRsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 13:48:20 -0400
Received: by mail-wm1-f68.google.com with SMTP id 7so5681589wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 10:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mCJxWV+T/vjZAkW9RLOGqcR/p13/ZsoE2pnzqrwefyM=;
        b=RwKDc87r24DJ6Y7GfJUFEk9L6ElwCNLK9Gl5JusgqDGR1VoMQUsYMKXQbtzSRGCDK8
         XAtyk6pQ9oq0RG+a+vd2qH9nJej/VjE+g1lEAPgPuPlB31Sj7PaWKBfhm/i2WK5CbAaM
         jt/GNaYrvt/1qUS/jkapk6EAueH4J+MZ89P9yH/kKJF53oLE0UnwTzY2jRso/mm7IlDQ
         qrzFDSloroX9I+LIqoL9ixaSXuVEXN1VEm7tDk3D+Qxj0uY8efB+sE+PwScK7JyumSRq
         FGRdNUWRBNK+8isR0jR7pKuVBOitWXheIL2UcwUA9YfswmuuM9OV/ik0p5n0wBleCTcw
         g23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mCJxWV+T/vjZAkW9RLOGqcR/p13/ZsoE2pnzqrwefyM=;
        b=fBzIk6mUxBnnkgWNUPJRMpAxDgujKT4KAy0w9iwynNaDEsYkNSU35EbpwskcVz9z7d
         g9m1hKJeozPiW593IvwMxV3VkksHrNm/sdzJzjajyCHkUyV3aIfl3gf6cxNgCi9vs512
         tZM9k7p5okV9wXaLasPhkckEEVmeX6n334aKq+ygd6FN85t1akWIRATXRlMtMYMFzDw6
         3+Lss+nOKXPybYWb3QZym/dlQaJI5+jag3BaYs6Hc8wSiK4U39FbDR/oDaVM6sYgx7CZ
         6bPLvKzgkjMdSmzR2O96o3DjJsrknsCay2HxDIx2IjoBOptoA8Th1uxfSaFl+4krpYUe
         9HfQ==
X-Gm-Message-State: APjAAAVMQS6jydxINMRJk8eR08n82y4vLAj8b2XNJM2y6mnx1GAF3c3C
        ZRW/AJNlF9V4+1WKcXhbhJRFfJWRewNqGvOf3i8iZg==
X-Google-Smtp-Source: APXvYqwm3MwPUu29S+PyJhKgcfKK9CwyzKAmTvvnC6MkPxf32vS8pD2QcP8WucowrzjF1uKErJ9EG25uKekDpyqYLQQ=
X-Received: by 2002:a05:600c:54a:: with SMTP id k10mr1223343wmc.127.1568915298712;
 Thu, 19 Sep 2019 10:48:18 -0700 (PDT)
MIME-Version: 1.0
References: <1568902149-70787-1-git-send-email-yukuai3@huawei.com>
In-Reply-To: <1568902149-70787-1-git-send-email-yukuai3@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 19 Sep 2019 13:48:06 -0400
Message-ID: <CADnq5_MFLy3zFXu39BaUb-7Y4rYqqFQt2B=_fVMOozh87Z2X1g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove excess function parameter description
To:     yu kuai <yukuai3@huawei.com>
Cc:     Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>, yi.zhang@huawei.com,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        zhengbin13@huawei.com,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 10:03 AM yu kuai <yukuai3@huawei.com> wrote:
>
> Fixes gcc warning:
>
> drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c:431: warning: Excess function
> parameter 'sw' description in 'vcn_v2_5_disable_clock_gating'
> drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c:550: warning: Excess function
> parameter 'sw' description in 'vcn_v2_5_enable_clock_gating'
>
> Fixes: cbead2bdfcf1 ("drm/amdgpu: add VCN2.5 VCPU start and stop")
> Signed-off-by: yu kuai <yukuai3@huawei.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 395c225..9d778a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -423,7 +423,6 @@ static void vcn_v2_5_mc_resume(struct amdgpu_device *adev)
>   * vcn_v2_5_disable_clock_gating - disable VCN clock gating
>   *
>   * @adev: amdgpu_device pointer
> - * @sw: enable SW clock gating
>   *
>   * Disable clock gating for VCN block
>   */
> @@ -542,7 +541,6 @@ static void vcn_v2_5_disable_clock_gating(struct amdgpu_device *adev)
>   * vcn_v2_5_enable_clock_gating - enable VCN clock gating
>   *
>   * @adev: amdgpu_device pointer
> - * @sw: enable SW clock gating
>   *
>   * Enable clock gating for VCN block
>   */
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
