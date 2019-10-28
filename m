Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D418ECA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 17:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23CA21479
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 17:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeR8JMji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404155AbfJ1Riq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 13:38:46 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:44443 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfJ1Riq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 13:38:46 -0400
Received: by mail-wr1-f50.google.com with SMTP id z11so10782190wro.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 10:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/abdfMeh69JGd4VbtyIiDE9TdqwHC99pC3PmG4mB0mM=;
        b=GeR8JMjiSUF7m8r1MKUax3fCHeqthfouXEYEWz5WsEdfFvaiWAnICzAA35OtNXpruS
         JT/J34izCxkastgRcpKQ+Lb++HdOHK/gS7f18TY/zIVSNZTi/oL/k3+YqCeK+asnhvo8
         slDVdzdtZYK95yQusxFzGeF1q+3BG+9iKu5WQncL6ON2b23YbL1Le6wkbOJIu24Tciau
         hKDHqibxYAUAONFBbeh4uH/mMhMEP01ST298lhS/CKYv4jj7k/VXcVGGfRJMwVCBWO5D
         ZThIsbtmimj7IX53m6lkBiLiHNX+rL+XpkTlzdF6maFjuM9RB/8WjbfUZWtRP3vLAae5
         tfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/abdfMeh69JGd4VbtyIiDE9TdqwHC99pC3PmG4mB0mM=;
        b=HzjXEfhQCd24N+c0XnuI/sscQsrIdAEZzA3xuLZDLI6BdT3GQnKbemDew3KSDMAu83
         y4XUFNPLoZqzOSamJSF/MaAJz0tWlekPlps56oBPy2lzAKD4FUR5CoC39ig+jvwAliRd
         A4u7nG27eDZ9Bb7e6y3lpQIPctBTQv0oPy96DGHnmBchq0+5FdMZoNuLOuunVUyWbr9v
         rCTuyFw8PrQmOUI9wi0w/u/e1RGOmRezTbY9OPhGOYN7Yamgk+D7zN02SST1Yz7PQAyN
         nWwh4V5JDKauZOMJzMj9LrPWnwGIKeXNn7qNVE5XfSIHW3WOYCLSsGr7gdiE1m0GNxLA
         XCIg==
X-Gm-Message-State: APjAAAUqDD3XLRFga5Sd4Tu9m/5LYayenXHsWk3hpDYQeZj9YTS3bTN3
        a8CfHt34AIq4kBvFJqgd0mAUtHDE8eSzOhStsds=
X-Google-Smtp-Source: APXvYqzNVtJKGE9q81/oRf5ZwQumvlLTJEqW1bel2VkuWj7p2Up2WDnp6z7jwoabvfpAicTQNz60RJ782dusFNfdH3E=
X-Received: by 2002:adf:fb0b:: with SMTP id c11mr16644596wrr.50.1572284323451;
 Mon, 28 Oct 2019 10:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <20191023075831.33636-1-yuehaibing@huawei.com>
In-Reply-To: <20191023075831.33636-1-yuehaibing@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 28 Oct 2019 13:38:30 -0400
Message-ID: <CADnq5_PPCFLZzMCUxW4Ofd5+A=N5s-iMURrSEj8C6V1NJhS68A@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amdgpu: remove set but not used variable 'adev'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "Yang, Philip" <Philip.Yang@amd.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        tiancyin <tianci.yin@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 4:10 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:1221:24: warning: variable adev set but not used [-Wunused-but-set-variable]
> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:488:24: warning: variable adev set but not used [-Wunused-but-set-variable]
> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:547:24: warning: variable adev set but not used [-Wunused-but-set-variable]
>
> It is never used, so can removed it.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index a61b0d9..ba00262 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -485,15 +485,12 @@ static int amdgpu_move_vram_ram(struct ttm_buffer_object *bo, bool evict,
>                                 struct ttm_operation_ctx *ctx,
>                                 struct ttm_mem_reg *new_mem)
>  {
> -       struct amdgpu_device *adev;
>         struct ttm_mem_reg *old_mem = &bo->mem;
>         struct ttm_mem_reg tmp_mem;
>         struct ttm_place placements;
>         struct ttm_placement placement;
>         int r;
>
> -       adev = amdgpu_ttm_adev(bo->bdev);
> -
>         /* create space/pages for new_mem in GTT space */
>         tmp_mem = *new_mem;
>         tmp_mem.mm_node = NULL;
> @@ -544,15 +541,12 @@ static int amdgpu_move_ram_vram(struct ttm_buffer_object *bo, bool evict,
>                                 struct ttm_operation_ctx *ctx,
>                                 struct ttm_mem_reg *new_mem)
>  {
> -       struct amdgpu_device *adev;
>         struct ttm_mem_reg *old_mem = &bo->mem;
>         struct ttm_mem_reg tmp_mem;
>         struct ttm_placement placement;
>         struct ttm_place placements;
>         int r;
>
> -       adev = amdgpu_ttm_adev(bo->bdev);
> -
>         /* make space in GTT for old_mem buffer */
>         tmp_mem = *new_mem;
>         tmp_mem.mm_node = NULL;
> @@ -1218,11 +1212,8 @@ static struct ttm_backend_func amdgpu_backend_func = {
>  static struct ttm_tt *amdgpu_ttm_tt_create(struct ttm_buffer_object *bo,
>                                            uint32_t page_flags)
>  {
> -       struct amdgpu_device *adev;
>         struct amdgpu_ttm_tt *gtt;
>
> -       adev = amdgpu_ttm_adev(bo->bdev);
> -
>         gtt = kzalloc(sizeof(struct amdgpu_ttm_tt), GFP_KERNEL);
>         if (gtt == NULL) {
>                 return NULL;
> --
> 2.7.4
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
