Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD00C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85DC520836
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlX9MLNx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfKYPQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 10:16:51 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:38401 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbfKYPQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 10:16:51 -0500
Received: by mail-wr1-f47.google.com with SMTP id i12so18593122wro.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 07:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jhdtl5esqr1oouba5Vga68joRb3d2BYdNhlaTCrtJsA=;
        b=NlX9MLNxTpMm9Sqq1Qz/KIsTMoyor6q15lCpYtrm/uv+ku5+OyGfw8NXABmUm9Ff3p
         PXKq9PgOs+Hfxx4xqTeM0b/9UYZOvpyZrFFh6yIEhq1aJIDoonsNO/2ndK38JALo0NXX
         FIZAC9pXTiw60X89/gGCepZCcK8hUG/LC+R7nSQm9/F5vpnc20ZSY5iyhgEVZQVyl4bJ
         HnRHeKd1GLP2hD7Uk+gjAUipQvBJs+5oXoaWGCRDxq7zRKP05mR53fRKrPd5w/r27n1l
         18wzKoP6lITqPzOjLybMYcyH8JMasyuQclChiyX6SZ0mVk6qE6V9V9gma5LDFP3hyaQO
         GBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jhdtl5esqr1oouba5Vga68joRb3d2BYdNhlaTCrtJsA=;
        b=Maoyxt/5twrcWJr9I62W65BLYRqWpD21wpT9OTC7yEFiqsfyxYErNWVsxILH0GtiJq
         ob6DunCE2QMd8gadpy9VraL+cP7UL6ZCj5RaO+C4emZNUGUMP4Tcs199bhBq75TKAdX7
         e3NYzQ9giSSjWaRiObqbJdFzmfybmfdvBUToBeybA4NbGpdZA0O136NVbY0O/IXCEyzA
         IFMk4dPTK1rFivm7yfPwFonXGTuuYxY3f3EUU3sRKnUhVrfVa6gF0BJ8ol+ODi+GiJYq
         LoDW0yWedCcbqrhl6IWsq72YB0oGBg8T8Oe3dS0ZucaRBNOdAqQckG7EKGui6HI5gAnW
         csdg==
X-Gm-Message-State: APjAAAUE29ZihrfudrAUyiuwGap5ygFian9aHIVOzTJUUTMwbSngIrRi
        usDG4r7SKNGeL4JvJpdf64xgz3LF4tPkY7N9vYU=
X-Google-Smtp-Source: APXvYqxf9OB4XuHYFRVgJ92qEJPWbONU8mJwgyOpfTO7ay9+u7JYIKVTyhh+/cE0yKpuQWgW1hddoZ+CHA1i1imHVUo=
X-Received: by 2002:adf:f010:: with SMTP id j16mr33077254wro.206.1574695009196;
 Mon, 25 Nov 2019 07:16:49 -0800 (PST)
MIME-Version: 1.0
References: <20191125145843.15764-1-yuehaibing@huawei.com>
In-Reply-To: <20191125145843.15764-1-yuehaibing@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 25 Nov 2019 10:16:37 -0500
Message-ID: <CADnq5_Mn1vsXzEGA254spvhaAaW+Q4y20orjWBbz2doVCvbYrw@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/powerplay: remove set but not used variable 'stretch_amount2'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     "Quan, Evan" <evan.quan@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Prike Liang <Prike.Liang@amd.com>,
        Chen Wandun <chenwandun@huawei.com>,
        yu kuai <yukuai3@huawei.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 10:00 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/vegam_smumgr.c:
>  In function vegam_populate_clock_stretcher_data_table:
> drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/vegam_smumgr.c:1489:29:
>  warning: variable stretch_amount2 set but not used [-Wunused-but-set-variable]
>
> It is never used, so can be removed.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
> index 50896e9..b0e0d67 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
> @@ -1486,7 +1486,7 @@ static int vegam_populate_clock_stretcher_data_table(struct pp_hwmgr *hwmgr)
>         struct vegam_smumgr *smu_data =
>                         (struct vegam_smumgr *)(hwmgr->smu_backend);
>
> -       uint8_t i, stretch_amount, stretch_amount2, volt_offset = 0;
> +       uint8_t i, stretch_amount, volt_offset = 0;
>         struct phm_ppt_v1_information *table_info =
>                         (struct phm_ppt_v1_information *)(hwmgr->pptable);
>         struct phm_ppt_v1_clock_voltage_dependency_table *sclk_table =
> @@ -1525,11 +1525,9 @@ static int vegam_populate_clock_stretcher_data_table(struct pp_hwmgr *hwmgr)
>                         (table_info->cac_dtp_table->ucCKS_LDO_REFSEL != 0) ?
>                         table_info->cac_dtp_table->ucCKS_LDO_REFSEL : 5;
>         /* Populate CKS Lookup Table */
> -       if (stretch_amount == 1 || stretch_amount == 2 || stretch_amount == 5)
> -               stretch_amount2 = 0;
> -       else if (stretch_amount == 3 || stretch_amount == 4)
> -               stretch_amount2 = 1;
> -       else {
> +       if (!(stretch_amount == 1 || stretch_amount == 2 ||
> +             stretch_amount == 5 || stretch_amount == 3 ||
> +             stretch_amount == 4)) {
>                 phm_cap_unset(hwmgr->platform_descriptor.platformCaps,
>                                 PHM_PlatformCaps_ClockStretcher);
>                 PP_ASSERT_WITH_CODE(false,
> --
> 2.7.4
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
