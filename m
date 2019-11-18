Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBDAC432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 966C821934
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcScLZd4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfKRRsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 12:48:04 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42733 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfKRRsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 12:48:04 -0500
Received: by mail-wr1-f68.google.com with SMTP id a15so20579853wrf.9;
        Mon, 18 Nov 2019 09:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=piNHro+ZEjxTlVQYbgYFct0MWJy6Nfv3mhGBZxaqWEI=;
        b=UcScLZd47Ox+WvIdRLwBXlvs7qK537HzRtbKDchwlW+qVieV2yoxduZiS/8bKA7ZZC
         L1uY3ELur64yoob3gNfgGBqlVgbUWKVfrXWMTw1kE95SPQxB6i77lBTuV5OuoYL8YM5v
         HGQsUHoVlMgfW/aM5HqdZWzChr3zx39uMDlrcRTqkHK/h7a+OWKQE6I2QKz+acfPqyDB
         WTcv7aBh31zUuBi9K6azzO2WBylVe++dkigF4YDD8EuQ37ZPiF/KWpbyqi+EA0j+gxdN
         bkkX1tMAeHRuRHVJhTAweZFBBDuz/9zk+KckxOUXrng7mCnpS2IuJNz5IcOGR6Djz1Qp
         X5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=piNHro+ZEjxTlVQYbgYFct0MWJy6Nfv3mhGBZxaqWEI=;
        b=D16bMPRTg9vV+liYwXSorHlQW13m8pfZOOkcNUFgMHTxzeX3lgZreyGU3BLJWK33OL
         SJgUc1X0M4PE1ToK9oR5MUUF3zxNtVIEzMXCrCQt3+u3TxJntQn2YGaw8DQH4E7OMnQv
         fBEt+IiJbBc50ij4FNswfn91T4ofbfrRIhW+XtTmmuDdSym3msnsn3r/1uyUkDuQsdUv
         51IHuoVKDGHDiZRyIdhqlyMiw0ONC/CbNcGr4OrXcrL2szdWZltRnCLzjVjj+5Dd0oca
         Ks5eEAsn/oKth1SvlKptwxQwhf3LqrnNRXbSmfJzCfttcMwy0Oa4rcvz85qW65YZqanG
         awDQ==
X-Gm-Message-State: APjAAAVtGn6pcUPW/P3HT5ebBwfU9xEh7Kbd6x3Qfs1J4/N4lSIT1FBV
        6HqI1M4bJSmD8UDNzr6KvQrtfRL5edq75Y58a9I=
X-Google-Smtp-Source: APXvYqyGywWdEXXMqyuzeVwYL9crbS3T81rogaadiKCASpSKYQ4z/YHdFapsZ0h0gIEfDTYiyLAMQrdillBqOPi1WYs=
X-Received: by 2002:adf:9d87:: with SMTP id p7mr31061751wre.11.1574099281432;
 Mon, 18 Nov 2019 09:48:01 -0800 (PST)
MIME-Version: 1.0
References: <20191115094754.40920-1-colin.king@canonical.com> <MN2PR12MB3344F8D7498FC9DA8302AD05E44D0@MN2PR12MB3344.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3344F8D7498FC9DA8302AD05E44D0@MN2PR12MB3344.namprd12.prod.outlook.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 18 Nov 2019 12:47:49 -0500
Message-ID: <CADnq5_ODJOk3vV1QBQRQkMxZTa5reBqsPy-Q+1rrEBw4dJEtoQ@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amdgpu/powerplay: fix dereference before null
 check of pointer hwmgr
To:     "Quan, Evan" <Evan.Quan@amd.com>
Cc:     Colin King <colin.king@canonical.com>, Rex Zhu <rex.zhu@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Nov 18, 2019 at 1:56 AM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> Reviewed-by: Evan Quan <evan.quan@amd.com>
>
> -----Original Message-----
> From: Colin King <colin.king@canonical.com>
> Sent: Friday, November 15, 2019 5:48 PM
> To: Rex Zhu <rex.zhu@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Deucher, A=
lexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@a=
md.com>; Zhou, David(ChunMing) <David1.Zhou@amd.com>; David Airlie <airlied=
@linux.ie>; Daniel Vetter <daniel@ffwll.ch>; amd-gfx@lists.freedesktop.org;=
 dri-devel@lists.freedesktop.org
> Cc: kernel-janitors@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH][next] drm/amdgpu/powerplay: fix dereference before null =
check of pointer hwmgr
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The assignment of adev dereferences pointer hwmgr before hwmgr is null ch=
ecked, hence there is a potential null pointer deference issue. Fix this by=
 assigning adev after the null check.
>
> Addresses-Coverity: ("Dereference before null check")
> Fixes: 0896d2f7ba4d ("drm/amdgpu/powerplay: properly set PP_GFXOFF_MASK")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c b/drivers/gpu/dr=
m/amd/powerplay/hwmgr/hwmgr.c
> index 443625c83ec9..d2909c91d65b 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
> @@ -81,7 +81,7 @@ static void hwmgr_init_workload_prority(struct pp_hwmgr=
 *hwmgr)
>
>  int hwmgr_early_init(struct pp_hwmgr *hwmgr)  {
> -       struct amdgpu_device *adev =3D hwmgr->adev;
> +       struct amdgpu_device *adev;
>
>         if (!hwmgr)
>                 return -EINVAL;
> @@ -96,6 +96,8 @@ int hwmgr_early_init(struct pp_hwmgr *hwmgr)
>         hwmgr_init_workload_prority(hwmgr);
>         hwmgr->gfxoff_state_changed_by_workload =3D false;
>
> +       adev =3D hwmgr->adev;
> +
>         switch (hwmgr->chip_family) {
>         case AMDGPU_FAMILY_CI:
>                 adev->pm.pp_feature &=3D ~PP_GFXOFF_MASK;
> --
> 2.20.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
