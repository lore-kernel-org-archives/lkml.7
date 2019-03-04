Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E684EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46D120823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rrXWrJwB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfCDTAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:00:03 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41004 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfCDTAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:00:02 -0500
Received: by mail-wr1-f68.google.com with SMTP id n2so6751079wrw.8;
        Mon, 04 Mar 2019 11:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UG3I6JBITlngMOBfsEHDKjrnHAyPf9dFPaa1eTl4jIQ=;
        b=rrXWrJwBRgrcBrJLuMLK/VpHeSn+vnS6YmZ0lEAocFTqoPl2gbFjbk49DObQ3JmBR6
         6TBwdh4/3SDHQDEZsf4VCt/s9hWLKiB5RpNLdFiWKvzwLxp7b2uxW20OibSg4ClD8MMd
         ovwDeebgi09aMCetIraZMHVhzTIiYfciA54rcrvTHM2UMw5S157CLUoL+iQCDWDKZtMG
         OZs06GQayitrhtg4iRnb/VRPBzC2RPQxTfoosyh2Dgp+ypyhxOoczHuG5PSp3zINeZjX
         ECdmJaOgquXQyxd4JY6lyNfW8FQaBELfYBs/o1e4NyY8JlA681NS1OLqXA/CSmh+nnKY
         u5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UG3I6JBITlngMOBfsEHDKjrnHAyPf9dFPaa1eTl4jIQ=;
        b=rbM8jooTGdpWWoEdbpL+tfWhjS3yi5rpeyu3WQz9oBGMnU9l2LXTjRjCuwTM6lqrMn
         68/4LhIutDmCf4AcWdYl/NnOfQVUvIkZR0pInZSv9o0KtWTNHFQzAHJ4Ltvl0f0RoXYv
         7lLUE8Hdsreq0XWqnwPKpzrjWOabCmjvxGGJftpbg05HKCm2HWTotxkOznH8Yx/QWb2D
         71GHvIWEOXBedB6pUWFJbiYRMM7akARDu5roV892cvmwoeg1dR263Gmrhi/cLOn92wUU
         oDLhQnyRH+COkTey8RYGcNOd+t5RzRHMA2qoMWJgRxxoEA8donxsWqv/MqEQu9hn/sq1
         AK+w==
X-Gm-Message-State: APjAAAWEhkT839X/RxEt99ziY/duTKJwf2VIt4EErXBcVwAtJbX9tCSc
        BNdtqrvqft/O50LqdqufZejodX6Rzxf13p2R3gc=
X-Google-Smtp-Source: APXvYqw/jPoEZP2r9psqo56cjS5CcX9ihjieCUUddhfNUvrg8+qjSt2EA1IQtXnq+8aqaMirl0UmbPJruVkRM/q2Omg=
X-Received: by 2002:adf:b3d1:: with SMTP id x17mr13843762wrd.15.1551726000313;
 Mon, 04 Mar 2019 11:00:00 -0800 (PST)
MIME-Version: 1.0
References: <20190302221658.7536-1-colin.king@canonical.com>
In-Reply-To: <20190302221658.7536-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 4 Mar 2019 13:59:47 -0500
Message-ID: <CADnq5_O9MQY1T=_3NiuDsVbvGR+5Twyyh53WMt=uOuBz327g0Q@mail.gmail.com>
Subject: Re: [PATCH][drm-next] drm/amdgpu: fix missing assignment of error
 return code to variable ret
To:     Colin King <colin.king@canonical.com>
Cc:     Oded Gabbay <oded.gabbay@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 2, 2019 at 5:17 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> An earlier commit replaced ttm_bo_wait with amdgpu_bo_sync_wait and
> removed the error return assignment to variable ret. Fix this by adding
> the assignment back. Also break line to clean up checkpatch overly
> long line warning.
>
> Detected by CoverityScan, CID#1477327 ("Logically dead code")
>
> Fixes: c60cd590cb7d ("drm/amdgpu: Replace ttm_bo_wait with amdgpu_bo_sync_wait")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 1921dec3df7a..92993baac91a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -906,7 +906,8 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
>                 pr_err("validate_pt_pd_bos() failed\n");
>                 goto validate_pd_fail;
>         }
> -       amdgpu_bo_sync_wait(vm->root.base.bo, AMDGPU_FENCE_OWNER_KFD, false);
> +       ret = amdgpu_bo_sync_wait(vm->root.base.bo,
> +                                 AMDGPU_FENCE_OWNER_KFD, false);
>         if (ret)
>                 goto wait_pd_fail;
>         amdgpu_bo_fence(vm->root.base.bo,
> --
> 2.20.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
