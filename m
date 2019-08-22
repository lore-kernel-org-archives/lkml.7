Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD91C3A59E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 02:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60AB022CF7
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 02:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTSUneOs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfHVChk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 22:37:40 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:35511 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbfHVChk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 22:37:40 -0400
Received: by mail-wm1-f51.google.com with SMTP id l2so4124916wmg.0;
        Wed, 21 Aug 2019 19:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FnJXlWkYTImrZ648hhe3Q+F34mtsiF3thL6otpcC1pg=;
        b=ZTSUneOsoNDwJqBUVGQ6y9p4QAVbDXIEigOZHHNRzQV9YZnmv/Ap2WPnFoeiaigESJ
         Io/dRVe538Au1IGYFxmVwAjEpNpX+04la9qaHRAlVK3TL9tArl2Ah20M/2n3TqgrqRNq
         FCHEu7ZyQEdL/zQkG+ZhdVoUmVQsQGyRS3yvwCjh9kmTDGzaZrHX78+wsFuWTvZ2/3UV
         ihouujRlDyZ/HOcJLhj2Ckp0YAUCQFiRecSoqZ+uHjamfSO9/UmPp9dQH+s9FlCLpZgX
         cncAl6xgVZUo4AWg5bjaRdyzGC5s36x1F4G+aOPzyLyEJebMd2HNMThGZNCMzuEPtQ/O
         wD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FnJXlWkYTImrZ648hhe3Q+F34mtsiF3thL6otpcC1pg=;
        b=EJbpoy5K+D6RL1HsBi3jz68VJJwId3o6SxPkEruhPXIjBd9Rd9eqJwwlTjm+I3SLp5
         IL+D1dL/HRv3z8q2+gg/5150u61Xi1aXGLunseCsVl+V9UpmnoQq3yjgTq/EGx0aFmZ5
         roKvNgImoIUvWGysJmMUFmyk6VuENVHCAJfasx+a4j/kdKg8+fex9eAENftFIaWeCz3h
         ob9iAP4jCUOZq9o/lVHCwFH/SeYqoEjlEIObZUq4wG8l8ydrFM5u+FqAD+W9ZSMisRpn
         z4WaDqcWF2jvH/kg72bvBu2ROSdkKxfCOX8QygBNGiOfAoVPjIlbn4N8uMTYXyZlOuy6
         PE5w==
X-Gm-Message-State: APjAAAUBDj3saDucpGnRItTs0WV24A0+96yTAAQaxz0Und/S9+bteB03
        c7cBYPwn8nD5wY/56azdslqVnRgzeR9zQfAP1qnoHw==
X-Google-Smtp-Source: APXvYqzLSen9+2Ns3bu+kBmfqQDECPwm5ebLUwETew2hhJHQ3IVaaPRqtbUBq/phve0FdPRxGU4Ya23E6UtBJf+eykI=
X-Received: by 2002:a1c:1d42:: with SMTP id d63mr3018156wmd.34.1566441458066;
 Wed, 21 Aug 2019 19:37:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190627075350.86800-1-yuehaibing@huawei.com>
In-Reply-To: <20190627075350.86800-1-yuehaibing@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 21 Aug 2019 22:37:26 -0400
Message-ID: <CADnq5_PE3r+4ZrUmc7o0_ah4wZpBi5jhR-yBHA_F+9gzX7Os5Q@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amdgpu: remove set but not used variable 'psp_enabled'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Wentland, Harry" <harry.wentland@amd.com>,
        tiancyin <tianci.yin@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
        Leo Liu <leo.liu@amd.com>, Huang Rui <ray.huang@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Kenneth Feng <kenneth.feng@amd.com>,
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

Applied.  thanks!

Alex

On Thu, Jun 27, 2019 at 10:29 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/gpu/drm/amd/amdgpu/nv.c: In function 'nv_common_early_init':
> drivers/gpu/drm/amd/amdgpu/nv.c:471:7: warning:
>  variable 'psp_enabled' set but not used [-Wunused-but-set-variable]
>
> It's not used since inroduction in
> commit c6b6a42175f5 ("drm/amdgpu: add navi10 common ip block (v3)")
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/nv.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index af20ffb55c54..8b9fa3db8daa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -468,7 +468,6 @@ static const struct amdgpu_asic_funcs nv_asic_funcs =
>
>  static int nv_common_early_init(void *handle)
>  {
> -       bool psp_enabled = false;
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>
>         adev->smc_rreg = NULL;
> @@ -485,10 +484,6 @@ static int nv_common_early_init(void *handle)
>
>         adev->asic_funcs = &nv_asic_funcs;
>
> -       if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP) &&
> -           (amdgpu_ip_block_mask & (1 << AMD_IP_BLOCK_TYPE_PSP)))
> -               psp_enabled = true;
> -
>         adev->rev_id = nv_get_rev_id(adev);
>         adev->external_rev_id = 0xff;
>         switch (adev->asic_type) {
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
