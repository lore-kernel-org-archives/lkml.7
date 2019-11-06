Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569B6C5DF64
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2760221D6C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tMxNIDvA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732316AbfKFRPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 12:15:46 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52248 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728448AbfKFRPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:15:45 -0500
Received: by mail-wm1-f67.google.com with SMTP id c17so4515595wmk.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 09:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FqojnfYcPbpr6KlP+Ft2/Gak6vptdJZ9xOr44jOMXnA=;
        b=tMxNIDvAAP/3hNNmYb9dR65I23CNeDHFutYeUIj9UPBedZMtQzp3pYv5OUT+TvGVXK
         +be5HiG0r/qx+rEtzAVw+mNotoUdTmkLyldiFaLeag1CMBNl89KjljTBm2Kbv43R+IF1
         ljyerVW6mBUC5F/3GrLuHyBxjdl/oaEtJLseE5zDbssgIGmn18VnhADXluty/a/s6NNQ
         7hqapMvw//uieaJYjRfPZSG4Istnz/3w91Oj2cNmPemFqjzyOpnuWw3j8PSR+m+DNoMI
         hCwPvrK1VPwcOtfNx2lYJr9yuIm7nvhMNiM2KDL256WYI/HiqsNe8R2XrGj3QIkrLLgc
         ZaKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FqojnfYcPbpr6KlP+Ft2/Gak6vptdJZ9xOr44jOMXnA=;
        b=EyQ+e5tyuSQHuBQJhM/UUZOOw8GDcWIWa5xBIXT0wzcNoLzVQYQybk96IJWoka4h+4
         AcsHke7DMsXwe9juRiYwq5gEFwE4PBREOaX9PhiL3hnow0tHXNfDewoInDBoQJu0qAmr
         Fx2Gp48VIR2G2/jLrDuoRBQrbAHhP+WZBgXGbor+ZfxELZw2IOvZu9bod8bs+jaQL0qF
         Ev7OhwdQbo+RRLrCNJlFh4JM8JPjmDoi7DqUUZKPPsryi8jXoOoEidgFhJN80mkIDcH1
         syhvSiClsqNEpIkotD87LcFMitAIq/kjjBqendT7XHN2uVgruZbPpTnuZp80S3FlnlYD
         3qgQ==
X-Gm-Message-State: APjAAAXgepcMpg3X1ijazR9H9BATy4Y5Y8HAhMLPfS1oCwha7AjpxqsA
        /J/CoYwZFIuF9TKhECooAdKliO9U2msgbPz9gug=
X-Google-Smtp-Source: APXvYqxjPjEx3asqTpjp4vKsp2+A7S51N7f18TYCVywGXqWdqcC5r2midJFtjkDsHCgtr+/qe5CInKwpDXjoLN9dJy8=
X-Received: by 2002:a1c:790b:: with SMTP id l11mr3718261wme.127.1573060541884;
 Wed, 06 Nov 2019 09:15:41 -0800 (PST)
MIME-Version: 1.0
References: <1572874046-30996-1-git-send-email-yukuai3@huawei.com> <1572874046-30996-8-git-send-email-yukuai3@huawei.com>
In-Reply-To: <1572874046-30996-8-git-send-email-yukuai3@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 6 Nov 2019 12:15:30 -0500
Message-ID: <CADnq5_MjhnBA-mUwPgdHRuit+=CgZjs0HC+JHqeD_gmciaONFQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] drm/amdgpu: remove set but not used variable 'mc_shared_chmap'
To:     yu kuai <yukuai3@huawei.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Zhou, Jammy" <Jammy.Zhou@amd.com>, tiancyin <tianci.yin@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "Tuikov, Luben" <luben.tuikov@amd.com>, yi.zhang@huawei.com,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        zhengbin <zhengbin13@huawei.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 4, 2019 at 8:54 AM yu kuai <yukuai3@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c: In function
> =E2=80=98gfx_v8_0_gpu_early_init=E2=80=99:
> drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c:1713:6: warning: variable
> =E2=80=98mc_shared_chmap=E2=80=99 set but not used [-Wunused-but-set-vari=
able]
>
> Fixes: 0bde3a95eaa9 ("drm/amdgpu: split gfx8 gpu init into sw and hw part=
s")
> Signed-off-by: yu kuai <yukuai3@huawei.com>

Looks like gfx_v7_0.c and gfx_v6_0.c could have the same treatment.
Care to send patches?

Applied the series.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v8_0.c
> index e4c645d..80b7958 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -1710,7 +1710,7 @@ static int gfx_v8_0_do_edc_gpr_workarounds(struct a=
mdgpu_device *adev)
>  static int gfx_v8_0_gpu_early_init(struct amdgpu_device *adev)
>  {
>         u32 gb_addr_config;
> -       u32 mc_shared_chmap, mc_arb_ramcfg;
> +       u32 mc_arb_ramcfg;
>         u32 dimm00_addr_map, dimm01_addr_map, dimm10_addr_map, dimm11_add=
r_map;
>         u32 tmp;
>         int ret;
> @@ -1850,7 +1850,6 @@ static int gfx_v8_0_gpu_early_init(struct amdgpu_de=
vice *adev)
>                 break;
>         }
>
> -       mc_shared_chmap =3D RREG32(mmMC_SHARED_CHMAP);
>         adev->gfx.config.mc_arb_ramcfg =3D RREG32(mmMC_ARB_RAMCFG);
>         mc_arb_ramcfg =3D adev->gfx.config.mc_arb_ramcfg;
>
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
