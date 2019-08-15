Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3790EC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 14:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3BC120656
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 14:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731898AbfHOO4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 10:56:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48436 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728500AbfHOO4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 10:56:50 -0400
Received: from mail-pf1-f198.google.com ([209.85.210.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hyHBD-0000Ys-5F
        for linux-kernel@vger.kernel.org; Thu, 15 Aug 2019 14:56:43 +0000
Received: by mail-pf1-f198.google.com with SMTP id p16so1746221pfn.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 07:56:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nqbCBCPgQE0r3sJNvlonkOpOFQNIfMzqqzihLUnsk7A=;
        b=qrvFCGY4vzbyM10E/OJ64LTxpGOU4HH5cU0BRNzaqVBbvqn0P8BRXmMvAwlqeJ2xHY
         HyT44xtIPIDII7PyRomwN2TOcnXU32wb+l8FhkBgFqLRcjGhC5Wyfo6K6djZEbGJGmGl
         2YZvVQoRq7OxB95b5nX47ZTkELEm9K6bS07ThUoY8IalCn/nM5C0CFe0ORx/Iampp+1J
         +CGx1OpRBfi5UnLyEK2qeBUSjAk+heEMmHoQFs89HA8UNx1B71bjEJ6wMQYWIms0UePM
         LeDgp4bOQv9hk5ZDsqaQRFEVxUj6C3vLfCd6oOR4uZ+vvuYtfirO1r5veqDjrUHbHtGt
         5FPg==
X-Gm-Message-State: APjAAAWnjD4sqGbIuHR2ufM79I5k2Kz6Lm6d96WoxqgfwKBFmcfmaEDG
        pbLFBzEV5nxhW59Bo0BQxWcRZB0WX+YJvug96VFxuzXekxUxZHLMe97VkQXUedJ72toSHH84hEO
        WLyGb0WWINSdyaPuC0rKbl9CcEh/3cKKXin7/h2fZdA==
X-Received: by 2002:a17:902:b789:: with SMTP id e9mr4611504pls.294.1565881001741;
        Thu, 15 Aug 2019 07:56:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyQLu8pQOMue1uQyVuIyaOM9dgR7X+T/OhrRNBS0DeG9v6SH5iZiVXgu7c7aPhPauRC8b25gA==
X-Received: by 2002:a17:902:b789:: with SMTP id e9mr4611470pls.294.1565881001209;
        Thu, 15 Aug 2019 07:56:41 -0700 (PDT)
Received: from 2001-b011-380f-37d3-10c6-9270-79e1-2836.dynamic-ip6.hinet.net (2001-b011-380f-37d3-10c6-9270-79e1-2836.dynamic-ip6.hinet.net. [2001:b011:380f:37d3:10c6:9270:79e1:2836])
        by smtp.gmail.com with ESMTPSA id o14sm1309395pjp.29.2019.08.15.07.56.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Aug 2019 07:56:40 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] drm/amdgpu: Apply flags after amdgpu_device_ip_init()
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <BN6PR12MB180950AE744B37AAFADC2FEAF7AC0@BN6PR12MB1809.namprd12.prod.outlook.com>
Date:   Thu, 15 Aug 2019 22:56:37 +0800
Cc:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "anthony.wong@canonical.com" <anthony.wong@canonical.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8bit
Message-Id: <8D8229FF-933A-43CF-AE05-52E969E3B942@canonical.com>
References: <20190815051117.24003-1-kai.heng.feng@canonical.com>
 <BN6PR12MB180950AE744B37AAFADC2FEAF7AC0@BN6PR12MB1809.namprd12.prod.outlook.com>
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 21:33, Deucher, Alexander <Alexander.Deucher@amd.com> wrote:

> Thanks for finding this!  I think the attached patch should fix the issue  
> and it's much less invasive.

Yes it also fix the issue, please add by tested-by:
Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

I took this more or less future proof approach because I think this won’t  
be the last chip that needs firmware information, which isn’t available in  
early init, to decides its flags.

Yes it’s intrusive to carve out all flags from early init callbacks, but I  
don’t think it’s that ugly.

Kai-Heng

>
> Alex
> From: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Sent: Thursday, August 15, 2019 1:11 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian  
> <Christian.Koenig@amd.com>; Zhou, David(ChunMing) <David1.Zhou@amd.com>
> Cc: Huang, Ray <Ray.Huang@amd.com>; anthony.wong@canonical.com  
> <anthony.wong@canonical.com>; amd-gfx@lists.freedesktop.org  
> <amd-gfx@lists.freedesktop.org>; dri-devel@lists.freedesktop.org  
> <dri-devel@lists.freedesktop.org>; linux-kernel@vger.kernel.org  
> <linux-kernel@vger.kernel.org>; Kai-Heng Feng  
> <kai.heng.feng@canonical.com>
> Subject: [PATCH] drm/amdgpu: Apply flags after amdgpu_device_ip_init()
>
> After commit 005440066f92 ("drm/amdgpu: enable gfxoff again on raven
> series (v2)"), some Raven Ridge systems start to have rendering
> corruption in browser [1].
>
> Chip specific flags like cg_flags and pg_flags are applied in
> amdgpu_device_ip_early_init(). For Raven Ridge, the flags may depend on
> pp_feature's PP_GFXOFF_MASK bit, which can be negated in
> amdgpu_device_ip_init() based on firmware information. At that time it's
> already too late, since cg_flags and pg_flags are already set.
>
> Apply flags after amdgpu_device_ip_init() and consolidate all flags to
> one place, to solve the issue.
>
> [1]  
> https://lore.kernel.org/lkml/3EB0E920-31D7-4C91-A360-DBFB4417AC2F@canonical.com/
>
> Fixes: 005440066f92 ("drm/amdgpu: enable gfxoff again on raven series  
> (v2)")
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 589 +++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/cik.c           |  87 ---
>  drivers/gpu/drm/amd/amdgpu/nv.c            |  50 --
>  drivers/gpu/drm/amd/amdgpu/si.c            |  83 ---
>  drivers/gpu/drm/amd/amdgpu/soc15.c         | 140 -----
>  drivers/gpu/drm/amd/amdgpu/vi.c            | 162 ------
>  6 files changed, 589 insertions(+), 522 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 275277364a8a..10ea4899c338 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1852,6 +1852,591 @@ static int amdgpu_device_ip_init(struct  
> amdgpu_device *adev)
>          return r;
>  }
>
> +#define CZ_REV_BRISTOL(rev)     \
> +       ((rev >= 0xC8 && rev <= 0xCE) || (rev >= 0xE1 && rev <= 0xE6))
> +
> +static int amdgpu_device_apply_flags(struct amdgpu_device *adev)
> +{
> +       switch (adev->asic_type) {
> +       case CHIP_TAHITI:
> +               adev->cg_flags =
> +                       AMD_CG_SUPPORT_GFX_MGCG |
> +                       AMD_CG_SUPPORT_GFX_MGLS |
> +                       /*AMD_CG_SUPPORT_GFX_CGCG |*/
> +                       AMD_CG_SUPPORT_GFX_CGLS |
> +                       AMD_CG_SUPPORT_GFX_CGTS |
> +                       AMD_CG_SUPPORT_GFX_CP_LS |
> +                       AMD_CG_SUPPORT_MC_MGCG |
> +                       AMD_CG_SUPPORT_SDMA_MGCG |
> +                       AMD_CG_SUPPORT_BIF_LS |
> +                       AMD_CG_SUPPORT_VCE_MGCG |
> +                       AMD_CG_SUPPORT_UVD_MGCG |
> +                       AMD_CG_SUPPORT_HDP_LS |
> +                       AMD_CG_SUPPORT_HDP_MGCG;
> +               adev->pg_flags = 0;
> +               break;
> +       case CHIP_PITCAIRN:
> +               adev->cg_flags =
> +                       AMD_CG_SUPPORT_GFX_MGCG |
> +                       AMD_CG_SUPPORT_GFX_MGLS |
> +                       /*AMD_CG_SUPPORT_GFX_CGCG |*/
> +                       AMD_CG_SUPPORT_GFX_CGLS |
> +                       AMD_CG_SUPPORT_GFX_CGTS |
> +                       AMD_CG_SUPPORT_GFX_CP_LS |
> +                       AMD_CG_SUPPORT_GFX_RLC_LS |
> +                       AMD_CG_SUPPORT_MC_LS |
> +                       AMD_CG_SUPPORT_MC_MGCG |
> +                       AMD_CG_SUPPORT_SDMA_MGCG |
> +                       AMD_CG_SUPPORT_BIF_LS |
> +                       AMD_CG_SUPPORT_VCE_MGCG |
> +                       AMD_CG_SUPPORT_UVD_MGCG |
> +                       AMD_CG_SUPPORT_HDP_LS |
> +                       AMD_CG_SUPPORT_HDP_MGCG;
> +               adev->pg_flags = 0;
> +               break;
> +       case CHIP_VERDE:
> +               adev->cg_flags =
> +                       AMD_CG_SUPPORT_GFX_MGCG |
> +                       AMD_CG_SUPPORT_GFX_MGLS |
> +                       AMD_CG_SUPPORT_GFX_CGLS |
> +                       AMD_CG_SUPPORT_GFX_CGTS |
> +                       AMD_CG_SUPPORT_GFX_CGTS_LS |
> +                       AMD_CG_SUPPORT_GFX_CP_LS |
> +                       AMD_CG_SUPPORT_MC_LS |
> +                       AMD_CG_SUPPORT_MC_MGCG |
> +                       AMD_CG_SUPPORT_SDMA_MGCG |
> +                       AMD_CG_SUPPORT_SDMA_LS |
> +                       AMD_CG_SUPPORT_BIF_LS |
> +                       AMD_CG_SUPPORT_VCE_MGCG |
> +                       AMD_CG_SUPPORT_UVD_MGCG |
> +                       AMD_CG_SUPPORT_HDP_LS |
> +                       AMD_CG_SUPPORT_HDP_MGCG;
> +               adev->pg_flags = 0;
> +               //???
> +               break;
> +       case CHIP_OLAND:
> +               adev->cg_flags =
> +                       AMD_CG_SUPPORT_GFX_MGCG |
> +                       AMD_CG_SUPPORT_GFX_MGLS |
> +                       /*AMD_CG_SUPPORT_GFX_CGCG |*/
> +                       AMD_CG_SUPPORT_GFX_CGLS |
> +                       AMD_CG_SUPPORT_GFX_CGTS |
> +                       AMD_CG_SUPPORT_GFX_CP_LS |
> +                       AMD_CG_SUPPORT_GFX_RLC_LS |
> +                       AMD_CG_SUPPORT_MC_LS |
> +                       AMD_CG_SUPPORT_MC_MGCG |
> +                       AMD_CG_SUPPORT_SDMA_MGCG |
> +                       AMD_CG_SUPPORT_BIF_LS |
> +                       AMD_CG_SUPPORT_UVD_MGCG |
> +                       AMD_CG_SUPPORT_HDP_LS |
> +                       AMD_CG_SUPPORT_HDP_MGCG;
> +               adev->pg_flags = 0;
> +               break;
> +       case CHIP_HAINAN:
> +               adev->cg_flags =
> +                       AMD_CG_SUPPORT_GFX_MGCG |
> +                       AMD_CG_SUPPORT_GFX_MGLS |
> +                       /*AMD_CG_SUPPORT_GFX_CGCG |*/
> +                       AMD_CG_SUPPORT_GFX_CGLS |
> +                       AMD_CG_SUPPORT_GFX_CGTS |
> +                       AMD_CG_SUPPORT_GFX_CP_LS |
> +                       AMD_CG_SUPPORT_GFX_RLC_LS |
> +                       AMD_CG_SUPPORT_MC_LS |
> +                       AMD_CG_SUPPORT_MC_MGCG |
> +                       AMD_CG_SUPPORT_SDMA_MGCG |
> +                       AMD_CG_SUPPORT_BIF_LS |
> +                       AMD_CG_SUPPORT_HDP_LS |
> +                       AMD_CG_SUPPORT_HDP_MGCG;
> +               adev->pg_flags = 0;
> +               break;
> +       case CHIP_BONAIRE:
> +               adev->cg_flags =
> +                       AMD_CG_SUPPORT_GFX_MGCG |
> +                       AMD_CG_SUPPORT_GFX_MGLS |
> +                       /*AMD_CG_SUPPORT_GFX_CGCG |*/
> +                       AMD_CG_SUPPORT_GFX_CGLS |
> +                       AMD_CG_SUPPORT_GFX_CGTS |
> +                       AMD_CG_SUPPORT_GFX_CGTS_LS |
> +                       AMD_CG_SUPPORT_GFX_CP_LS |
> +                       AMD_CG_SUPPORT_MC_LS |
> +                       AMD_CG_SUPPORT_MC_MGCG |
> +                       AMD_CG_SUPPORT_SDMA_MGCG |
> +                       AMD_CG_SUPPORT_SDMA_LS |
> +                       AMD_CG_SUPPORT_BIF_LS |
> +                       AMD_CG_SUPPORT_VCE_MGCG |
> +                       AMD_CG_SUPPORT_UVD_MGCG |
> +                       AMD_CG_SUPPORT_HDP_LS |
> +                       AMD_CG_SUPPORT_HDP_MGCG;
> +               adev->pg_flags = 0;
> +               break;
> +       case CHIP_HAWAII:
> +               adev->cg_flags =
> +                       AMD_CG_SUPPORT_GFX_MGCG |
> +                       AMD_CG_SUPPORT_GFX_MGLS |
> +                       /*AMD_CG_SUPPORT_GFX_CGCG |*/
> +                       AMD_CG_SUPPORT_GFX_CGLS |
> +                       AMD_CG_SUPPORT_GFX_CGTS |
> +                       AMD_CG_SUPPORT_GFX_CP_LS |
> +                       AMD_CG_SUPPORT_MC_LS |
> +                       AMD_CG_SUPPORT_MC_MGCG |
> +                       AMD_CG_SUPPORT_SDMA_MGCG |
> +                       AMD_CG_SUPPORT_SDMA_LS |
> +                       AMD_CG_SUPPORT_BIF_LS |
> +                       AMD_CG_SUPPORT_VCE_MGCG |
> +                       AMD_CG_SUPPORT_UVD_MGCG |
> +                       AMD_CG_SUPPORT_HDP_LS |
> +                       AMD_CG_SUPPORT_HDP_MGCG;
> +               adev->pg_flags = 0;
> +               break;
> +       case CHIP_KAVERI:
> +               adev->cg_flags =
> +                       AMD_CG_SUPPORT_GFX_MGCG |
> +                       AMD_CG_SUPPORT_GFX_MGLS |
> +                       /*AMD_CG_SUPPORT_GFX_CGCG |*/
> +                       AMD_CG_SUPPORT_GFX_CGLS |
> +                       AMD_CG_SUPPORT_GFX_CGTS |
> +                       AMD_CG_SUPPORT_GFX_CGTS_LS |
> +                       AMD_CG_SUPPORT_GFX_CP_LS |
> +                       AMD_CG_SUPPORT_SDMA_MGCG |
> +                       AMD_CG_SUPPORT_SDMA_LS |
> +                       AMD_CG_SUPPORT_BIF_LS |
> +                       AMD_CG_SUPPORT_VCE_MGCG |
> +                       AMD_CG_SUPPORT_UVD_MGCG |
> +                       AMD_CG_SUPPORT_HDP_LS |
> +                       AMD_CG_SUPPORT_HDP_MGCG;
> +               adev->pg_flags =
> +                       /*AMD_PG_SUPPORT_GFX_PG |
> +                         AMD_PG_SUPPORT_GFX_SMG |
> +                         AMD_PG_SUPPORT_GFX_DMG |*/
> +                       AMD_PG_SUPPORT_UVD |
> +                       AMD_PG_SUPPORT_VCE |
> +                       /*  AMD_PG_SUPPORT_CP |
> +                         AMD_PG_SUPPORT_GDS |
> +                         AMD_PG_SUPPORT_RLC_SMU_HS |
> +                         AMD_PG_SUPPORT_ACP |
> +                         AMD_PG_SUPPORT_SAMU |*/
> +                       0;
> +               break;
> +       case CHIP_KABINI:
> +       case CHIP_MULLINS:
> +               adev->cg_flags =
> +                       AMD_CG_SUPPORT_GFX_MGCG |
> +                       AMD_CG_SUPPORT_GFX_MGLS |
> +                       /*AMD_CG_SUPPORT_GFX_CGCG |*/
> +                       AMD_CG_SUPPORT_GFX_CGLS |
> +                       AMD_CG_SUPPORT_GFX_CGTS |
> +                       AMD_CG_SUPPORT_GFX_CGTS_LS |
> +                       AMD_CG_SUPPORT_GFX_CP_LS |
> +                       AMD_CG_SUPPORT_SDMA_MGCG |
> +                       AMD_CG_SUPPORT_SDMA_LS |
> +                       AMD_CG_SUPPORT_BIF_LS |
> +                       AMD_CG_SUPPORT_VCE_MGCG |
> +                       AMD_CG_SUPPORT_UVD_MGCG |
> +                       AMD_CG_SUPPORT_HDP_LS |
> +                       AMD_CG_SUPPORT_HDP_MGCG;
> +               adev->pg_flags =
> +                       /*AMD_PG_SUPPORT_GFX_PG |
> +                         AMD_PG_SUPPORT_GFX_SMG | */
> +                       AMD_PG_SUPPORT_UVD |
> +                       /*AMD_PG_SUPPORT_VCE |
> +                         AMD_PG_SUPPORT_CP |
> +                         AMD_PG_SUPPORT_GDS |
> +                         AMD_PG_SUPPORT_RLC_SMU_HS |
> +                         AMD_PG_SUPPORT_SAMU |*/
> +                       0;
> +               break;
> +       case CHIP_TOPAZ:
> +               adev->cg_flags = 0;
> +               adev->pg_flags = 0;
> +               break;
> +       case CHIP_FIJI:
> +               adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> +                       AMD_CG_SUPPORT_GFX_MGLS |
> +                       AMD_CG_SUPPORT_GFX_RLC_LS |
> +                       AMD_CG_SUPPORT_GFX_CP_LS |
> +                       AMD_CG_SUPPORT_GFX_CGTS |
> +                       AMD_CG_SUPPORT_GFX_CGTS_LS |
> +                       AMD_CG_SUPPORT_GFX_CGCG |
> +                       AMD_CG_SUPPORT_GFX_CGLS |
> +                       AMD_CG_SUPPORT_SDMA_MGCG |
> +                       AMD_CG_SUPPORT_SDMA_LS |
> +                       AMD_CG_SUPPORT_BIF_LS |
> +                       AMD_CG_SUPPORT_HDP_MGCG |
> +                       AMD_CG_SUPPORT_HDP_LS |
> +                       AMD_CG_SUPPORT_ROM_MGCG |
> +                       AMD_CG_SUPPORT_MC_MGCG |
> +                       AMD_CG_SUPPORT_MC_LS |
> +                       AMD_CG_SUPPORT_UVD_MGCG;
> +               adev->pg_flags = 0;
> +               break;
> +       case CHIP_TONGA:
> +               adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> +                       AMD_CG_SUPPORT_GFX_CGCG |
> +                       AMD_CG_SUPPORT_GFX_CGLS |
> +                       AMD_CG_SUPPORT_SDMA_MGCG |
> +                       AMD_CG_SUPPORT_SDMA_LS |
> +                       AMD_CG_SUPPORT_BIF_LS |
> +                       AMD_CG_SUPPORT_HDP_MGCG |
> +                       AMD_CG_SUPPORT_HDP_LS |
> +                       AMD_CG_SUPPORT_ROM_MGCG |
> +                       AMD_CG_SUPPORT_MC_MGCG |
> +                       AMD_CG_SUPPORT_MC_LS |
> +                       AMD_CG_SUPPORT_DRM_LS |
> +                       AMD_CG_SUPPORT_UVD_MGCG;
> +               adev->pg_flags = 0;
> +               break;
> +       case CHIP_POLARIS11:
> +               adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> +                       AMD_CG_SUPPORT_GFX_RLC_LS |
> +                       AMD_CG_SUPPORT_GFX_CP_LS |
> +                       AMD_CG_SUPPORT_GFX_CGCG |
> +                       AMD_CG_SUPPORT_GFX_CGLS |
> +                       AMD_CG_SUPPORT_GFX_3D_CGCG |
> +                       AMD_CG_SUPPORT_GFX_3D_CGLS |
> +                       AMD_CG_SUPPORT_SDMA_MGCG |
> +                       AMD_CG_SUPPORT_SDMA_LS |
> +                       AMD_CG_SUPPORT_BIF_MGCG |
> +                       AMD_CG_SUPPORT_BIF_LS |
> +                       AMD_CG_SUPPORT_HDP_MGCG |
> +                       AMD_CG_SUPPORT_HDP_LS |
> +                       AMD_CG_SUPPORT_ROM_MGCG |
> +                       AMD_CG_SUPPORT_MC_MGCG |
> +                       AMD_CG_SUPPORT_MC_LS |
> +                       AMD_CG_SUPPORT_DRM_LS |
> +                       AMD_CG_SUPPORT_UVD_MGCG |
> +                       AMD_CG_SUPPORT_VCE_MGCG;
> +               adev->pg_flags = 0;
> +               break;
> +       case CHIP_POLARIS10:
> +               adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> +                       AMD_CG_SUPPORT_GFX_RLC_LS |
> +                       AMD_CG_SUPPORT_GFX_CP_LS |
> +                       AMD_CG_SUPPORT_GFX_CGCG |
> +                       AMD_CG_SUPPORT_GFX_CGLS |
> +                       AMD_CG_SUPPORT_GFX_3D_CGCG |
> +                       AMD_CG_SUPPORT_GFX_3D_CGLS |
> +                       AMD_CG_SUPPORT_SDMA_MGCG |
> +                       AMD_CG_SUPPORT_SDMA_LS |
> +                       AMD_CG_SUPPORT_BIF_MGCG |
> +                       AMD_CG_SUPPORT_BIF_LS |
> +                       AMD_CG_SUPPORT_HDP_MGCG |
> +                       AMD_CG_SUPPORT_HDP_LS |
> +                       AMD_CG_SUPPORT_ROM_MGCG |
> +                       AMD_CG_SUPPORT_MC_MGCG |
> +                       AMD_CG_SUPPORT_MC_LS |
> +                       AMD_CG_SUPPORT_DRM_LS |
> +                       AMD_CG_SUPPORT_UVD_MGCG |
> +                       AMD_CG_SUPPORT_VCE_MGCG;
> +               adev->pg_flags = 0;
> +               break;
> +       case CHIP_POLARIS12:
> +               adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> +                       AMD_CG_SUPPORT_GFX_RLC_LS |
> +                       AMD_CG_SUPPORT_GFX_CP_LS |
> +                       AMD_CG_SUPPORT_GFX_CGCG |
> +                       AMD_CG_SUPPORT_GFX_CGLS |
> +                       AMD_CG_SUPPORT_GFX_3D_CGCG |
> +                       AMD_CG_SUPPORT_GFX_3D_CGLS |
> +                       AMD_CG_SUPPORT_SDMA_MGCG |
> +                       AMD_CG_SUPPORT_SDMA_LS |
> +                       AMD_CG_SUPPORT_BIF_MGCG |
> +                       AMD_CG_SUPPORT_BIF_LS |
> +                       AMD_CG_SUPPORT_HDP_MGCG |
> +                       AMD_CG_SUPPORT_HDP_LS |
> +                       AMD_CG_SUPPORT_ROM_MGCG |
> +                       AMD_CG_SUPPORT_MC_MGCG |
> +                       AMD_CG_SUPPORT_MC_LS |
> +                       AMD_CG_SUPPORT_DRM_LS |
> +                       AMD_CG_SUPPORT_UVD_MGCG |
> +                       AMD_CG_SUPPORT_VCE_MGCG;
> +               adev->pg_flags = 0;
> +               break;
> +       case CHIP_VEGAM:
> +               adev->cg_flags = 0;
> +                       /*AMD_CG_SUPPORT_GFX_MGCG |
> +                       AMD_CG_SUPPORT_GFX_RLC_LS |
> +                       AMD_CG_SUPPORT_GFX_CP_LS |
> +                       AMD_CG_SUPPORT_GFX_CGCG |
> +                       AMD_CG_SUPPORT_GFX_CGLS |
> +                       AMD_CG_SUPPORT_GFX_3D_CGCG |
> +                       AMD_CG_SUPPORT_GFX_3D_CGLS |
> +                       AMD_CG_SUPPORT_SDMA_MGCG |
> +                       AMD_CG_SUPPORT_SDMA_LS |
> +                       AMD_CG_SUPPORT_BIF_MGCG |
> +                       AMD_CG_SUPPORT_BIF_LS |
> +                       AMD_CG_SUPPORT_HDP_MGCG |
> +                       AMD_CG_SUPPORT_HDP_LS |
> +                       AMD_CG_SUPPORT_ROM_MGCG |
> +                       AMD_CG_SUPPORT_MC_MGCG |
> +                       AMD_CG_SUPPORT_MC_LS |
> +                       AMD_CG_SUPPORT_DRM_LS |
> +                       AMD_CG_SUPPORT_UVD_MGCG |
> +                       AMD_CG_SUPPORT_VCE_MGCG;*/
> +               adev->pg_flags = 0;
> +               break;
> +       case CHIP_CARRIZO:
> +               adev->cg_flags = AMD_CG_SUPPORT_UVD_MGCG |
> +                       AMD_CG_SUPPORT_GFX_MGCG |
> +                       AMD_CG_SUPPORT_GFX_MGLS |
> +                       AMD_CG_SUPPORT_GFX_RLC_LS |
> +                       AMD_CG_SUPPORT_GFX_CP_LS |
> +                       AMD_CG_SUPPORT_GFX_CGTS |
> +                       AMD_CG_SUPPORT_GFX_CGTS_LS |
> +                       AMD_CG_SUPPORT_GFX_CGCG |
> +                       AMD_CG_SUPPORT_GFX_CGLS |
> +                       AMD_CG_SUPPORT_BIF_LS |
> +                       AMD_CG_SUPPORT_HDP_MGCG |
> +                       AMD_CG_SUPPORT_HDP_LS |
> +                       AMD_CG_SUPPORT_SDMA_MGCG |
> +                       AMD_CG_SUPPORT_SDMA_LS |
> +                       AMD_CG_SUPPORT_VCE_MGCG;
> +               /* rev0 hardware requires workarounds to support PG */
> +               adev->pg_flags = 0;
> +               if (adev->rev_id != 0x00 ||  
> CZ_REV_BRISTOL(adev->pdev->revision)) {
> +                       adev->pg_flags |= AMD_PG_SUPPORT_GFX_SMG |
> +                               AMD_PG_SUPPORT_GFX_PIPELINE |
> +                               AMD_PG_SUPPORT_CP |
> +                               AMD_PG_SUPPORT_UVD |
> +                               AMD_PG_SUPPORT_VCE;
> +               }
> +               break;
> +       case CHIP_STONEY:
> +               adev->cg_flags = AMD_CG_SUPPORT_UVD_MGCG |
> +                       AMD_CG_SUPPORT_GFX_MGCG |
> +                       AMD_CG_SUPPORT_GFX_MGLS |
> +                       AMD_CG_SUPPORT_GFX_RLC_LS |
> +                       AMD_CG_SUPPORT_GFX_CP_LS |
> +                       AMD_CG_SUPPORT_GFX_CGTS |
> +                       AMD_CG_SUPPORT_GFX_CGTS_LS |
> +                       AMD_CG_SUPPORT_GFX_CGLS |
> +                       AMD_CG_SUPPORT_BIF_LS |
> +                       AMD_CG_SUPPORT_HDP_MGCG |
> +                       AMD_CG_SUPPORT_HDP_LS |
> +                       AMD_CG_SUPPORT_SDMA_MGCG |
> +                       AMD_CG_SUPPORT_SDMA_LS |
> +                       AMD_CG_SUPPORT_VCE_MGCG;
> +               adev->pg_flags = AMD_PG_SUPPORT_GFX_PG |
> +                       AMD_PG_SUPPORT_GFX_SMG |
> +                       AMD_PG_SUPPORT_GFX_PIPELINE |
> +                       AMD_PG_SUPPORT_CP |
> +                       AMD_PG_SUPPORT_UVD |
> +                       AMD_PG_SUPPORT_VCE;
> +               break;
> +       case CHIP_VEGA10:
> +               adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> +                       AMD_CG_SUPPORT_GFX_MGLS |
> +                       AMD_CG_SUPPORT_GFX_RLC_LS |
> +                       AMD_CG_SUPPORT_GFX_CP_LS |
> +                       AMD_CG_SUPPORT_GFX_3D_CGCG |
> +                       AMD_CG_SUPPORT_GFX_3D_CGLS |
> +                       AMD_CG_SUPPORT_GFX_CGCG |
> +                       AMD_CG_SUPPORT_GFX_CGLS |
> +                       AMD_CG_SUPPORT_BIF_MGCG |
> +                       AMD_CG_SUPPORT_BIF_LS |
> +                       AMD_CG_SUPPORT_HDP_LS |
> +                       AMD_CG_SUPPORT_DRM_MGCG |
> +                       AMD_CG_SUPPORT_DRM_LS |
> +                       AMD_CG_SUPPORT_ROM_MGCG |
> +                       AMD_CG_SUPPORT_DF_MGCG |
> +                       AMD_CG_SUPPORT_SDMA_MGCG |
> +                       AMD_CG_SUPPORT_SDMA_LS |
> +                       AMD_CG_SUPPORT_MC_MGCG |
> +                       AMD_CG_SUPPORT_MC_LS;
> +               adev->pg_flags = 0;
> +               break;
> +       case CHIP_VEGA12:
> +               adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> +                       AMD_CG_SUPPORT_GFX_MGLS |
> +                       AMD_CG_SUPPORT_GFX_CGCG |
> +                       AMD_CG_SUPPORT_GFX_CGLS |
> +                       AMD_CG_SUPPORT_GFX_3D_CGCG |
> +                       AMD_CG_SUPPORT_GFX_3D_CGLS |
> +                       AMD_CG_SUPPORT_GFX_CP_LS |
> +                       AMD_CG_SUPPORT_MC_LS |
> +                       AMD_CG_SUPPORT_MC_MGCG |
> +                       AMD_CG_SUPPORT_SDMA_MGCG |
> +                       AMD_CG_SUPPORT_SDMA_LS |
> +                       AMD_CG_SUPPORT_BIF_MGCG |
> +                       AMD_CG_SUPPORT_BIF_LS |
> +                       AMD_CG_SUPPORT_HDP_MGCG |
> +                       AMD_CG_SUPPORT_HDP_LS |
> +                       AMD_CG_SUPPORT_ROM_MGCG |
> +                       AMD_CG_SUPPORT_VCE_MGCG |
> +                       AMD_CG_SUPPORT_UVD_MGCG;
> +               adev->pg_flags = 0;
> +               break;
> +       case CHIP_VEGA20:
> +               adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> +                       AMD_CG_SUPPORT_GFX_MGLS |
> +                       AMD_CG_SUPPORT_GFX_CGCG |
> +                       AMD_CG_SUPPORT_GFX_CGLS |
> +                       AMD_CG_SUPPORT_GFX_3D_CGCG |
> +                       AMD_CG_SUPPORT_GFX_3D_CGLS |
> +                       AMD_CG_SUPPORT_GFX_CP_LS |
> +                       AMD_CG_SUPPORT_MC_LS |
> +                       AMD_CG_SUPPORT_MC_MGCG |
> +                       AMD_CG_SUPPORT_SDMA_MGCG |
> +                       AMD_CG_SUPPORT_SDMA_LS |
> +                       AMD_CG_SUPPORT_BIF_MGCG |
> +                       AMD_CG_SUPPORT_BIF_LS |
> +                       AMD_CG_SUPPORT_HDP_MGCG |
> +                       AMD_CG_SUPPORT_HDP_LS |
> +                       AMD_CG_SUPPORT_ROM_MGCG |
> +                       AMD_CG_SUPPORT_VCE_MGCG |
> +                       AMD_CG_SUPPORT_UVD_MGCG;
> +               adev->pg_flags = 0;
> +               break;
> +       case CHIP_RAVEN:
> +               if (adev->rev_id >= 0x8) {
> +                       adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> +                               AMD_CG_SUPPORT_GFX_MGLS |
> +                               AMD_CG_SUPPORT_GFX_CP_LS |
> +                               AMD_CG_SUPPORT_GFX_3D_CGCG |
> +                               AMD_CG_SUPPORT_GFX_3D_CGLS |
> +                               AMD_CG_SUPPORT_GFX_CGCG |
> +                               AMD_CG_SUPPORT_GFX_CGLS |
> +                               AMD_CG_SUPPORT_BIF_LS |
> +                               AMD_CG_SUPPORT_HDP_LS |
> +                               AMD_CG_SUPPORT_ROM_MGCG |
> +                               AMD_CG_SUPPORT_MC_MGCG |
> +                               AMD_CG_SUPPORT_MC_LS |
> +                               AMD_CG_SUPPORT_SDMA_MGCG |
> +                               AMD_CG_SUPPORT_SDMA_LS |
> +                               AMD_CG_SUPPORT_VCN_MGCG;
> +
> +                       adev->pg_flags = AMD_PG_SUPPORT_SDMA |  
> AMD_PG_SUPPORT_VCN;
> +               } else if (adev->pdev->device == 0x15d8) {
> +                       adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> +                               AMD_CG_SUPPORT_GFX_MGLS |
> +                               AMD_CG_SUPPORT_GFX_CP_LS |
> +                               AMD_CG_SUPPORT_GFX_3D_CGCG |
> +                               AMD_CG_SUPPORT_GFX_3D_CGLS |
> +                               AMD_CG_SUPPORT_GFX_CGCG |
> +                               AMD_CG_SUPPORT_GFX_CGLS |
> +                               AMD_CG_SUPPORT_BIF_LS |
> +                               AMD_CG_SUPPORT_HDP_LS |
> +                               AMD_CG_SUPPORT_ROM_MGCG |
> +                               AMD_CG_SUPPORT_MC_MGCG |
> +                               AMD_CG_SUPPORT_MC_LS |
> +                               AMD_CG_SUPPORT_SDMA_MGCG |
> +                               AMD_CG_SUPPORT_SDMA_LS;
> +
> +                       adev->pg_flags = AMD_PG_SUPPORT_SDMA |
> +                               AMD_PG_SUPPORT_MMHUB |
> +                               AMD_PG_SUPPORT_VCN |
> +                               AMD_PG_SUPPORT_VCN_DPG;
> +               } else {
> +                       adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> +                               AMD_CG_SUPPORT_GFX_MGLS |
> +                               AMD_CG_SUPPORT_GFX_RLC_LS |
> +                               AMD_CG_SUPPORT_GFX_CP_LS |
> +                               AMD_CG_SUPPORT_GFX_3D_CGCG |
> +                               AMD_CG_SUPPORT_GFX_3D_CGLS |
> +                               AMD_CG_SUPPORT_GFX_CGCG |
> +                               AMD_CG_SUPPORT_GFX_CGLS |
> +                               AMD_CG_SUPPORT_BIF_MGCG |
> +                               AMD_CG_SUPPORT_BIF_LS |
> +                               AMD_CG_SUPPORT_HDP_MGCG |
> +                               AMD_CG_SUPPORT_HDP_LS |
> +                               AMD_CG_SUPPORT_DRM_MGCG |
> +                               AMD_CG_SUPPORT_DRM_LS |
> +                               AMD_CG_SUPPORT_ROM_MGCG |
> +                               AMD_CG_SUPPORT_MC_MGCG |
> +                               AMD_CG_SUPPORT_MC_LS |
> +                               AMD_CG_SUPPORT_SDMA_MGCG |
> +                               AMD_CG_SUPPORT_SDMA_LS |
> +                               AMD_CG_SUPPORT_VCN_MGCG;
> +
> +                       adev->pg_flags = AMD_PG_SUPPORT_SDMA |  
> AMD_PG_SUPPORT_VCN;
> +               }
> +
> +               if (adev->pm.pp_feature & PP_GFXOFF_MASK)
> +                       adev->pg_flags |= AMD_PG_SUPPORT_GFX_PG |
> +                               AMD_PG_SUPPORT_CP |
> +                               AMD_PG_SUPPORT_RLC_SMU_HS;
> +               break;
> +       case CHIP_ARCTURUS:
> +               adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> +                       AMD_CG_SUPPORT_GFX_MGLS |
> +                       AMD_CG_SUPPORT_GFX_CGCG |
> +                       AMD_CG_SUPPORT_GFX_CGLS |
> +                       AMD_CG_SUPPORT_GFX_CP_LS |
> +                       AMD_CG_SUPPORT_HDP_MGCG |
> +                       AMD_CG_SUPPORT_HDP_LS |
> +                       AMD_CG_SUPPORT_SDMA_MGCG |
> +                       AMD_CG_SUPPORT_SDMA_LS |
> +                       AMD_CG_SUPPORT_MC_MGCG |
> +                       AMD_CG_SUPPORT_MC_LS;
> +               adev->pg_flags = 0;
> +               break;
> +       case CHIP_RENOIR:
> +               adev->cg_flags = 0;
> +               adev->pg_flags = 0;
> +               break;
> +       case CHIP_NAVI10:
> +               adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> +                       AMD_CG_SUPPORT_GFX_CGCG |
> +                       AMD_CG_SUPPORT_IH_CG |
> +                       AMD_CG_SUPPORT_HDP_MGCG |
> +                       AMD_CG_SUPPORT_HDP_LS |
> +                       AMD_CG_SUPPORT_SDMA_MGCG |
> +                       AMD_CG_SUPPORT_SDMA_LS |
> +                       AMD_CG_SUPPORT_MC_MGCG |
> +                       AMD_CG_SUPPORT_MC_LS |
> +                       AMD_CG_SUPPORT_ATHUB_MGCG |
> +                       AMD_CG_SUPPORT_ATHUB_LS |
> +                       AMD_CG_SUPPORT_VCN_MGCG |
> +                       AMD_CG_SUPPORT_BIF_MGCG |
> +                       AMD_CG_SUPPORT_BIF_LS;
> +               adev->pg_flags = AMD_PG_SUPPORT_VCN |
> +                       AMD_PG_SUPPORT_VCN_DPG |
> +                       AMD_PG_SUPPORT_MMHUB |
> +                       AMD_PG_SUPPORT_ATHUB;
> +               break;
> +       case CHIP_NAVI14:
> +               adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> +                       AMD_CG_SUPPORT_GFX_CGCG |
> +                       AMD_CG_SUPPORT_IH_CG |
> +                       AMD_CG_SUPPORT_HDP_MGCG |
> +                       AMD_CG_SUPPORT_HDP_LS |
> +                       AMD_CG_SUPPORT_SDMA_MGCG |
> +                       AMD_CG_SUPPORT_SDMA_LS |
> +                       AMD_CG_SUPPORT_MC_MGCG |
> +                       AMD_CG_SUPPORT_MC_LS |
> +                       AMD_CG_SUPPORT_ATHUB_MGCG |
> +                       AMD_CG_SUPPORT_ATHUB_LS |
> +                       AMD_CG_SUPPORT_VCN_MGCG |
> +                       AMD_CG_SUPPORT_BIF_MGCG |
> +                       AMD_CG_SUPPORT_BIF_LS;
> +               adev->pg_flags = AMD_PG_SUPPORT_VCN |
> +                       AMD_PG_SUPPORT_VCN_DPG;
> +               break;
> +       case CHIP_NAVI12:
> +               adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> +                       AMD_CG_SUPPORT_GFX_MGLS |
> +                       AMD_CG_SUPPORT_GFX_CGCG |
> +                       AMD_CG_SUPPORT_GFX_CP_LS |
> +                       AMD_CG_SUPPORT_GFX_RLC_LS |
> +                       AMD_CG_SUPPORT_IH_CG |
> +                       AMD_CG_SUPPORT_HDP_MGCG |
> +                       AMD_CG_SUPPORT_HDP_LS |
> +                       AMD_CG_SUPPORT_SDMA_MGCG |
> +                       AMD_CG_SUPPORT_SDMA_LS |
> +                       AMD_CG_SUPPORT_MC_MGCG |
> +                       AMD_CG_SUPPORT_MC_LS |
> +                       AMD_CG_SUPPORT_ATHUB_MGCG |
> +                       AMD_CG_SUPPORT_ATHUB_LS |
> +                       AMD_CG_SUPPORT_VCN_MGCG;
> +               adev->pg_flags = AMD_PG_SUPPORT_VCN_DPG;
> +               break;
> +       default:
> +               /* FIXME: not supported yet */
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
>  /**
>   * amdgpu_device_fill_reset_magic - writes reset magic to gart pointer
>   *
> @@ -2827,6 +3412,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>                  goto failed;
>          }
>
> +       r = amdgpu_device_apply_flags(adev);
> +       if (r)
> +               goto failed;
> +
>          adev->accel_working = true;
>
>          amdgpu_vm_check_compute_bug(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c  
> b/drivers/gpu/drm/amd/amdgpu/cik.c
> index 7b63d7a8298a..01e2211e251d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik.c
> @@ -1862,74 +1862,12 @@ static int cik_common_early_init(void *handle)
>          adev->external_rev_id = 0xFF;
>          switch (adev->asic_type) {
>          case CHIP_BONAIRE:
> -               adev->cg_flags =
> -                       AMD_CG_SUPPORT_GFX_MGCG |
> -                       AMD_CG_SUPPORT_GFX_MGLS |
> -                       /*AMD_CG_SUPPORT_GFX_CGCG |*/
> -                       AMD_CG_SUPPORT_GFX_CGLS |
> -                       AMD_CG_SUPPORT_GFX_CGTS |
> -                       AMD_CG_SUPPORT_GFX_CGTS_LS |
> -                       AMD_CG_SUPPORT_GFX_CP_LS |
> -                       AMD_CG_SUPPORT_MC_LS |
> -                       AMD_CG_SUPPORT_MC_MGCG |
> -                       AMD_CG_SUPPORT_SDMA_MGCG |
> -                       AMD_CG_SUPPORT_SDMA_LS |
> -                       AMD_CG_SUPPORT_BIF_LS |
> -                       AMD_CG_SUPPORT_VCE_MGCG |
> -                       AMD_CG_SUPPORT_UVD_MGCG |
> -                       AMD_CG_SUPPORT_HDP_LS |
> -                       AMD_CG_SUPPORT_HDP_MGCG;
> -               adev->pg_flags = 0;
>                  adev->external_rev_id = adev->rev_id + 0x14;
>                  break;
>          case CHIP_HAWAII:
> -               adev->cg_flags =
> -                       AMD_CG_SUPPORT_GFX_MGCG |
> -                       AMD_CG_SUPPORT_GFX_MGLS |
> -                       /*AMD_CG_SUPPORT_GFX_CGCG |*/
> -                       AMD_CG_SUPPORT_GFX_CGLS |
> -                       AMD_CG_SUPPORT_GFX_CGTS |
> -                       AMD_CG_SUPPORT_GFX_CP_LS |
> -                       AMD_CG_SUPPORT_MC_LS |
> -                       AMD_CG_SUPPORT_MC_MGCG |
> -                       AMD_CG_SUPPORT_SDMA_MGCG |
> -                       AMD_CG_SUPPORT_SDMA_LS |
> -                       AMD_CG_SUPPORT_BIF_LS |
> -                       AMD_CG_SUPPORT_VCE_MGCG |
> -                       AMD_CG_SUPPORT_UVD_MGCG |
> -                       AMD_CG_SUPPORT_HDP_LS |
> -                       AMD_CG_SUPPORT_HDP_MGCG;
> -               adev->pg_flags = 0;
>                  adev->external_rev_id = 0x28;
>                  break;
>          case CHIP_KAVERI:
> -               adev->cg_flags =
> -                       AMD_CG_SUPPORT_GFX_MGCG |
> -                       AMD_CG_SUPPORT_GFX_MGLS |
> -                       /*AMD_CG_SUPPORT_GFX_CGCG |*/
> -                       AMD_CG_SUPPORT_GFX_CGLS |
> -                       AMD_CG_SUPPORT_GFX_CGTS |
> -                       AMD_CG_SUPPORT_GFX_CGTS_LS |
> -                       AMD_CG_SUPPORT_GFX_CP_LS |
> -                       AMD_CG_SUPPORT_SDMA_MGCG |
> -                       AMD_CG_SUPPORT_SDMA_LS |
> -                       AMD_CG_SUPPORT_BIF_LS |
> -                       AMD_CG_SUPPORT_VCE_MGCG |
> -                       AMD_CG_SUPPORT_UVD_MGCG |
> -                       AMD_CG_SUPPORT_HDP_LS |
> -                       AMD_CG_SUPPORT_HDP_MGCG;
> -               adev->pg_flags =
> -                       /*AMD_PG_SUPPORT_GFX_PG |
> -                         AMD_PG_SUPPORT_GFX_SMG |
> -                         AMD_PG_SUPPORT_GFX_DMG |*/
> -                       AMD_PG_SUPPORT_UVD |
> -                       AMD_PG_SUPPORT_VCE |
> -                       /*  AMD_PG_SUPPORT_CP |
> -                         AMD_PG_SUPPORT_GDS |
> -                         AMD_PG_SUPPORT_RLC_SMU_HS |
> -                         AMD_PG_SUPPORT_ACP |
> -                         AMD_PG_SUPPORT_SAMU |*/
> -                       0;
>                  if (adev->pdev->device == 0x1312 ||
>                          adev->pdev->device == 0x1316 ||
>                          adev->pdev->device == 0x1317)
> @@ -1939,31 +1877,6 @@ static int cik_common_early_init(void *handle)
>                  break;
>          case CHIP_KABINI:
>          case CHIP_MULLINS:
> -               adev->cg_flags =
> -                       AMD_CG_SUPPORT_GFX_MGCG |
> -                       AMD_CG_SUPPORT_GFX_MGLS |
> -                       /*AMD_CG_SUPPORT_GFX_CGCG |*/
> -                       AMD_CG_SUPPORT_GFX_CGLS |
> -                       AMD_CG_SUPPORT_GFX_CGTS |
> -                       AMD_CG_SUPPORT_GFX_CGTS_LS |
> -                       AMD_CG_SUPPORT_GFX_CP_LS |
> -                       AMD_CG_SUPPORT_SDMA_MGCG |
> -                       AMD_CG_SUPPORT_SDMA_LS |
> -                       AMD_CG_SUPPORT_BIF_LS |
> -                       AMD_CG_SUPPORT_VCE_MGCG |
> -                       AMD_CG_SUPPORT_UVD_MGCG |
> -                       AMD_CG_SUPPORT_HDP_LS |
> -                       AMD_CG_SUPPORT_HDP_MGCG;
> -               adev->pg_flags =
> -                       /*AMD_PG_SUPPORT_GFX_PG |
> -                         AMD_PG_SUPPORT_GFX_SMG | */
> -                       AMD_PG_SUPPORT_UVD |
> -                       /*AMD_PG_SUPPORT_VCE |
> -                         AMD_PG_SUPPORT_CP |
> -                         AMD_PG_SUPPORT_GDS |
> -                         AMD_PG_SUPPORT_RLC_SMU_HS |
> -                         AMD_PG_SUPPORT_SAMU |*/
> -                       0;
>                  if (adev->asic_type == CHIP_KABINI) {
>                          if (adev->rev_id == 0)
>                                  adev->external_rev_id = 0x81;
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c  
> b/drivers/gpu/drm/amd/amdgpu/nv.c
> index d4a2012b4832..30d100dc7b29 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -600,62 +600,12 @@ static int nv_common_early_init(void *handle)
>          adev->external_rev_id = 0xff;
>          switch (adev->asic_type) {
>          case CHIP_NAVI10:
> -               adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> -                       AMD_CG_SUPPORT_GFX_CGCG |
> -                       AMD_CG_SUPPORT_IH_CG |
> -                       AMD_CG_SUPPORT_HDP_MGCG |
> -                       AMD_CG_SUPPORT_HDP_LS |
> -                       AMD_CG_SUPPORT_SDMA_MGCG |
> -                       AMD_CG_SUPPORT_SDMA_LS |
> -                       AMD_CG_SUPPORT_MC_MGCG |
> -                       AMD_CG_SUPPORT_MC_LS |
> -                       AMD_CG_SUPPORT_ATHUB_MGCG |
> -                       AMD_CG_SUPPORT_ATHUB_LS |
> -                       AMD_CG_SUPPORT_VCN_MGCG |
> -                       AMD_CG_SUPPORT_BIF_MGCG |
> -                       AMD_CG_SUPPORT_BIF_LS;
> -               adev->pg_flags = AMD_PG_SUPPORT_VCN |
> -                       AMD_PG_SUPPORT_VCN_DPG |
> -                       AMD_PG_SUPPORT_MMHUB |
> -                       AMD_PG_SUPPORT_ATHUB;
>                  adev->external_rev_id = adev->rev_id + 0x1;
>                  break;
>          case CHIP_NAVI14:
> -               adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> -                       AMD_CG_SUPPORT_GFX_CGCG |
> -                       AMD_CG_SUPPORT_IH_CG |
> -                       AMD_CG_SUPPORT_HDP_MGCG |
> -                       AMD_CG_SUPPORT_HDP_LS |
> -                       AMD_CG_SUPPORT_SDMA_MGCG |
> -                       AMD_CG_SUPPORT_SDMA_LS |
> -                       AMD_CG_SUPPORT_MC_MGCG |
> -                       AMD_CG_SUPPORT_MC_LS |
> -                       AMD_CG_SUPPORT_ATHUB_MGCG |
> -                       AMD_CG_SUPPORT_ATHUB_LS |
> -                       AMD_CG_SUPPORT_VCN_MGCG |
> -                       AMD_CG_SUPPORT_BIF_MGCG |
> -                       AMD_CG_SUPPORT_BIF_LS;
> -               adev->pg_flags = AMD_PG_SUPPORT_VCN |
> -                       AMD_PG_SUPPORT_VCN_DPG;
>                  adev->external_rev_id = adev->rev_id + 20;
>                  break;
>          case CHIP_NAVI12:
> -               adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> -                       AMD_CG_SUPPORT_GFX_MGLS |
> -                       AMD_CG_SUPPORT_GFX_CGCG |
> -                       AMD_CG_SUPPORT_GFX_CP_LS |
> -                       AMD_CG_SUPPORT_GFX_RLC_LS |
> -                       AMD_CG_SUPPORT_IH_CG |
> -                       AMD_CG_SUPPORT_HDP_MGCG |
> -                       AMD_CG_SUPPORT_HDP_LS |
> -                       AMD_CG_SUPPORT_SDMA_MGCG |
> -                       AMD_CG_SUPPORT_SDMA_LS |
> -                       AMD_CG_SUPPORT_MC_MGCG |
> -                       AMD_CG_SUPPORT_MC_LS |
> -                       AMD_CG_SUPPORT_ATHUB_MGCG |
> -                       AMD_CG_SUPPORT_ATHUB_LS |
> -                       AMD_CG_SUPPORT_VCN_MGCG;
> -               adev->pg_flags = AMD_PG_SUPPORT_VCN_DPG;
>                  adev->external_rev_id = adev->rev_id + 0xa;
>                  break;
>          default:
> diff --git a/drivers/gpu/drm/amd/amdgpu/si.c  
> b/drivers/gpu/drm/amd/amdgpu/si.c
> index 904361451650..22ba2d7e797f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si.c
> @@ -1442,104 +1442,21 @@ static int si_common_early_init(void *handle)
>          adev->external_rev_id = 0xFF;
>          switch (adev->asic_type) {
>          case CHIP_TAHITI:
> -               adev->cg_flags =
> -                       AMD_CG_SUPPORT_GFX_MGCG |
> -                       AMD_CG_SUPPORT_GFX_MGLS |
> -                       /*AMD_CG_SUPPORT_GFX_CGCG |*/
> -                       AMD_CG_SUPPORT_GFX_CGLS |
> -                       AMD_CG_SUPPORT_GFX_CGTS |
> -                       AMD_CG_SUPPORT_GFX_CP_LS |
> -                       AMD_CG_SUPPORT_MC_MGCG |
> -                       AMD_CG_SUPPORT_SDMA_MGCG |
> -                       AMD_CG_SUPPORT_BIF_LS |
> -                       AMD_CG_SUPPORT_VCE_MGCG |
> -                       AMD_CG_SUPPORT_UVD_MGCG |
> -                       AMD_CG_SUPPORT_HDP_LS |
> -                       AMD_CG_SUPPORT_HDP_MGCG;
> -               adev->pg_flags = 0;
>                  adev->external_rev_id = (adev->rev_id == 0) ? 1 :
>                                          (adev->rev_id == 1) ? 5 : 6;
>                  break;
>          case CHIP_PITCAIRN:
> -               adev->cg_flags =
> -                       AMD_CG_SUPPORT_GFX_MGCG |
> -                       AMD_CG_SUPPORT_GFX_MGLS |
> -                       /*AMD_CG_SUPPORT_GFX_CGCG |*/
> -                       AMD_CG_SUPPORT_GFX_CGLS |
> -                       AMD_CG_SUPPORT_GFX_CGTS |
> -                       AMD_CG_SUPPORT_GFX_CP_LS |
> -                       AMD_CG_SUPPORT_GFX_RLC_LS |
> -                       AMD_CG_SUPPORT_MC_LS |
> -                       AMD_CG_SUPPORT_MC_MGCG |
> -                       AMD_CG_SUPPORT_SDMA_MGCG |
> -                       AMD_CG_SUPPORT_BIF_LS |
> -                       AMD_CG_SUPPORT_VCE_MGCG |
> -                       AMD_CG_SUPPORT_UVD_MGCG |
> -                       AMD_CG_SUPPORT_HDP_LS |
> -                       AMD_CG_SUPPORT_HDP_MGCG;
> -               adev->pg_flags = 0;
>                  adev->external_rev_id = adev->rev_id + 20;
>                  break;
> -
>          case CHIP_VERDE:
> -               adev->cg_flags =
> -                       AMD_CG_SUPPORT_GFX_MGCG |
> -                       AMD_CG_SUPPORT_GFX_MGLS |
> -                       AMD_CG_SUPPORT_GFX_CGLS |
> -                       AMD_CG_SUPPORT_GFX_CGTS |
> -                       AMD_CG_SUPPORT_GFX_CGTS_LS |
> -                       AMD_CG_SUPPORT_GFX_CP_LS |
> -                       AMD_CG_SUPPORT_MC_LS |
> -                       AMD_CG_SUPPORT_MC_MGCG |
> -                       AMD_CG_SUPPORT_SDMA_MGCG |
> -                       AMD_CG_SUPPORT_SDMA_LS |
> -                       AMD_CG_SUPPORT_BIF_LS |
> -                       AMD_CG_SUPPORT_VCE_MGCG |
> -                       AMD_CG_SUPPORT_UVD_MGCG |
> -                       AMD_CG_SUPPORT_HDP_LS |
> -                       AMD_CG_SUPPORT_HDP_MGCG;
> -               adev->pg_flags = 0;
> -               //???
>                  adev->external_rev_id = adev->rev_id + 40;
>                  break;
>          case CHIP_OLAND:
> -               adev->cg_flags =
> -                       AMD_CG_SUPPORT_GFX_MGCG |
> -                       AMD_CG_SUPPORT_GFX_MGLS |
> -                       /*AMD_CG_SUPPORT_GFX_CGCG |*/
> -                       AMD_CG_SUPPORT_GFX_CGLS |
> -                       AMD_CG_SUPPORT_GFX_CGTS |
> -                       AMD_CG_SUPPORT_GFX_CP_LS |
> -                       AMD_CG_SUPPORT_GFX_RLC_LS |
> -                       AMD_CG_SUPPORT_MC_LS |
> -                       AMD_CG_SUPPORT_MC_MGCG |
> -                       AMD_CG_SUPPORT_SDMA_MGCG |
> -                       AMD_CG_SUPPORT_BIF_LS |
> -                       AMD_CG_SUPPORT_UVD_MGCG |
> -                       AMD_CG_SUPPORT_HDP_LS |
> -                       AMD_CG_SUPPORT_HDP_MGCG;
> -               adev->pg_flags = 0;
>                  adev->external_rev_id = 60;
>                  break;
>          case CHIP_HAINAN:
> -               adev->cg_flags =
> -                       AMD_CG_SUPPORT_GFX_MGCG |
> -                       AMD_CG_SUPPORT_GFX_MGLS |
> -                       /*AMD_CG_SUPPORT_GFX_CGCG |*/
> -                       AMD_CG_SUPPORT_GFX_CGLS |
> -                       AMD_CG_SUPPORT_GFX_CGTS |
> -                       AMD_CG_SUPPORT_GFX_CP_LS |
> -                       AMD_CG_SUPPORT_GFX_RLC_LS |
> -                       AMD_CG_SUPPORT_MC_LS |
> -                       AMD_CG_SUPPORT_MC_MGCG |
> -                       AMD_CG_SUPPORT_SDMA_MGCG |
> -                       AMD_CG_SUPPORT_BIF_LS |
> -                       AMD_CG_SUPPORT_HDP_LS |
> -                       AMD_CG_SUPPORT_HDP_MGCG;
> -               adev->pg_flags = 0;
>                  adev->external_rev_id = 70;
>                  break;
> -
>          default:
>                  return -EINVAL;
>          }
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c  
> b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index c2d324d8da75..f2849fc463b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -983,72 +983,14 @@ static int soc15_common_early_init(void *handle)
>          switch (adev->asic_type) {
>          case CHIP_VEGA10:
>                  adev->asic_funcs = &soc15_asic_funcs;
> -               adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> -                       AMD_CG_SUPPORT_GFX_MGLS |
> -                       AMD_CG_SUPPORT_GFX_RLC_LS |
> -                       AMD_CG_SUPPORT_GFX_CP_LS |
> -                       AMD_CG_SUPPORT_GFX_3D_CGCG |
> -                       AMD_CG_SUPPORT_GFX_3D_CGLS |
> -                       AMD_CG_SUPPORT_GFX_CGCG |
> -                       AMD_CG_SUPPORT_GFX_CGLS |
> -                       AMD_CG_SUPPORT_BIF_MGCG |
> -                       AMD_CG_SUPPORT_BIF_LS |
> -                       AMD_CG_SUPPORT_HDP_LS |
> -                       AMD_CG_SUPPORT_DRM_MGCG |
> -                       AMD_CG_SUPPORT_DRM_LS |
> -                       AMD_CG_SUPPORT_ROM_MGCG |
> -                       AMD_CG_SUPPORT_DF_MGCG |
> -                       AMD_CG_SUPPORT_SDMA_MGCG |
> -                       AMD_CG_SUPPORT_SDMA_LS |
> -                       AMD_CG_SUPPORT_MC_MGCG |
> -                       AMD_CG_SUPPORT_MC_LS;
> -               adev->pg_flags = 0;
>                  adev->external_rev_id = 0x1;
>                  break;
>          case CHIP_VEGA12:
>                  adev->asic_funcs = &soc15_asic_funcs;
> -               adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> -                       AMD_CG_SUPPORT_GFX_MGLS |
> -                       AMD_CG_SUPPORT_GFX_CGCG |
> -                       AMD_CG_SUPPORT_GFX_CGLS |
> -                       AMD_CG_SUPPORT_GFX_3D_CGCG |
> -                       AMD_CG_SUPPORT_GFX_3D_CGLS |
> -                       AMD_CG_SUPPORT_GFX_CP_LS |
> -                       AMD_CG_SUPPORT_MC_LS |
> -                       AMD_CG_SUPPORT_MC_MGCG |
> -                       AMD_CG_SUPPORT_SDMA_MGCG |
> -                       AMD_CG_SUPPORT_SDMA_LS |
> -                       AMD_CG_SUPPORT_BIF_MGCG |
> -                       AMD_CG_SUPPORT_BIF_LS |
> -                       AMD_CG_SUPPORT_HDP_MGCG |
> -                       AMD_CG_SUPPORT_HDP_LS |
> -                       AMD_CG_SUPPORT_ROM_MGCG |
> -                       AMD_CG_SUPPORT_VCE_MGCG |
> -                       AMD_CG_SUPPORT_UVD_MGCG;
> -               adev->pg_flags = 0;
>                  adev->external_rev_id = adev->rev_id + 0x14;
>                  break;
>          case CHIP_VEGA20:
>                  adev->asic_funcs = &vega20_asic_funcs;
> -               adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> -                       AMD_CG_SUPPORT_GFX_MGLS |
> -                       AMD_CG_SUPPORT_GFX_CGCG |
> -                       AMD_CG_SUPPORT_GFX_CGLS |
> -                       AMD_CG_SUPPORT_GFX_3D_CGCG |
> -                       AMD_CG_SUPPORT_GFX_3D_CGLS |
> -                       AMD_CG_SUPPORT_GFX_CP_LS |
> -                       AMD_CG_SUPPORT_MC_LS |
> -                       AMD_CG_SUPPORT_MC_MGCG |
> -                       AMD_CG_SUPPORT_SDMA_MGCG |
> -                       AMD_CG_SUPPORT_SDMA_LS |
> -                       AMD_CG_SUPPORT_BIF_MGCG |
> -                       AMD_CG_SUPPORT_BIF_LS |
> -                       AMD_CG_SUPPORT_HDP_MGCG |
> -                       AMD_CG_SUPPORT_HDP_LS |
> -                       AMD_CG_SUPPORT_ROM_MGCG |
> -                       AMD_CG_SUPPORT_VCE_MGCG |
> -                       AMD_CG_SUPPORT_UVD_MGCG;
> -               adev->pg_flags = 0;
>                  adev->external_rev_id = adev->rev_id + 0x28;
>                  break;
>          case CHIP_RAVEN:
> @@ -1061,95 +1003,13 @@ static int soc15_common_early_init(void *handle)
>                          adev->external_rev_id = adev->rev_id + 0x20;
>                  else
>                          adev->external_rev_id = adev->rev_id + 0x01;
> -
> -               if (adev->rev_id >= 0x8) {
> -                       adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> -                               AMD_CG_SUPPORT_GFX_MGLS |
> -                               AMD_CG_SUPPORT_GFX_CP_LS |
> -                               AMD_CG_SUPPORT_GFX_3D_CGCG |
> -                               AMD_CG_SUPPORT_GFX_3D_CGLS |
> -                               AMD_CG_SUPPORT_GFX_CGCG |
> -                               AMD_CG_SUPPORT_GFX_CGLS |
> -                               AMD_CG_SUPPORT_BIF_LS |
> -                               AMD_CG_SUPPORT_HDP_LS |
> -                               AMD_CG_SUPPORT_ROM_MGCG |
> -                               AMD_CG_SUPPORT_MC_MGCG |
> -                               AMD_CG_SUPPORT_MC_LS |
> -                               AMD_CG_SUPPORT_SDMA_MGCG |
> -                               AMD_CG_SUPPORT_SDMA_LS |
> -                               AMD_CG_SUPPORT_VCN_MGCG;
> -
> -                       adev->pg_flags = AMD_PG_SUPPORT_SDMA |  
> AMD_PG_SUPPORT_VCN;
> -               } else if (adev->pdev->device == 0x15d8) {
> -                       adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> -                               AMD_CG_SUPPORT_GFX_MGLS |
> -                               AMD_CG_SUPPORT_GFX_CP_LS |
> -                               AMD_CG_SUPPORT_GFX_3D_CGCG |
> -                               AMD_CG_SUPPORT_GFX_3D_CGLS |
> -                               AMD_CG_SUPPORT_GFX_CGCG |
> -                               AMD_CG_SUPPORT_GFX_CGLS |
> -                               AMD_CG_SUPPORT_BIF_LS |
> -                               AMD_CG_SUPPORT_HDP_LS |
> -                               AMD_CG_SUPPORT_ROM_MGCG |
> -                               AMD_CG_SUPPORT_MC_MGCG |
> -                               AMD_CG_SUPPORT_MC_LS |
> -                               AMD_CG_SUPPORT_SDMA_MGCG |
> -                               AMD_CG_SUPPORT_SDMA_LS;
> -
> -                       adev->pg_flags = AMD_PG_SUPPORT_SDMA |
> -                               AMD_PG_SUPPORT_MMHUB |
> -                               AMD_PG_SUPPORT_VCN |
> -                               AMD_PG_SUPPORT_VCN_DPG;
> -               } else {
> -                       adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> -                               AMD_CG_SUPPORT_GFX_MGLS |
> -                               AMD_CG_SUPPORT_GFX_RLC_LS |
> -                               AMD_CG_SUPPORT_GFX_CP_LS |
> -                               AMD_CG_SUPPORT_GFX_3D_CGCG |
> -                               AMD_CG_SUPPORT_GFX_3D_CGLS |
> -                               AMD_CG_SUPPORT_GFX_CGCG |
> -                               AMD_CG_SUPPORT_GFX_CGLS |
> -                               AMD_CG_SUPPORT_BIF_MGCG |
> -                               AMD_CG_SUPPORT_BIF_LS |
> -                               AMD_CG_SUPPORT_HDP_MGCG |
> -                               AMD_CG_SUPPORT_HDP_LS |
> -                               AMD_CG_SUPPORT_DRM_MGCG |
> -                               AMD_CG_SUPPORT_DRM_LS |
> -                               AMD_CG_SUPPORT_ROM_MGCG |
> -                               AMD_CG_SUPPORT_MC_MGCG |
> -                               AMD_CG_SUPPORT_MC_LS |
> -                               AMD_CG_SUPPORT_SDMA_MGCG |
> -                               AMD_CG_SUPPORT_SDMA_LS |
> -                               AMD_CG_SUPPORT_VCN_MGCG;
> -
> -                       adev->pg_flags = AMD_PG_SUPPORT_SDMA |  
> AMD_PG_SUPPORT_VCN;
> -               }
> -
> -               if (adev->pm.pp_feature & PP_GFXOFF_MASK)
> -                       adev->pg_flags |= AMD_PG_SUPPORT_GFX_PG |
> -                               AMD_PG_SUPPORT_CP |
> -                               AMD_PG_SUPPORT_RLC_SMU_HS;
>                  break;
>          case CHIP_ARCTURUS:
>                  adev->asic_funcs = &vega20_asic_funcs;
> -               adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> -                       AMD_CG_SUPPORT_GFX_MGLS |
> -                       AMD_CG_SUPPORT_GFX_CGCG |
> -                       AMD_CG_SUPPORT_GFX_CGLS |
> -                       AMD_CG_SUPPORT_GFX_CP_LS |
> -                       AMD_CG_SUPPORT_HDP_MGCG |
> -                       AMD_CG_SUPPORT_HDP_LS |
> -                       AMD_CG_SUPPORT_SDMA_MGCG |
> -                       AMD_CG_SUPPORT_SDMA_LS |
> -                       AMD_CG_SUPPORT_MC_MGCG |
> -                       AMD_CG_SUPPORT_MC_LS;
> -               adev->pg_flags = 0;
>                  adev->external_rev_id = adev->rev_id + 0x32;
>                  break;
>          case CHIP_RENOIR:
>                  adev->asic_funcs = &soc15_asic_funcs;
> -               adev->cg_flags = 0;
> -               adev->pg_flags = 0;
>                  adev->external_rev_id = adev->rev_id + 0x91;
>                  break;
>          default:
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c  
> b/drivers/gpu/drm/amd/amdgpu/vi.c
> index 56c882b3ea3c..6a94c72e86f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -1042,9 +1042,6 @@ static const struct amdgpu_asic_funcs vi_asic_funcs =
>          .get_pcie_replay_count = &vi_get_pcie_replay_count,
>  };
>
> -#define CZ_REV_BRISTOL(rev)     \
> -       ((rev >= 0xC8 && rev <= 0xCE) || (rev >= 0xE1 && rev <= 0xE6))
> -
>  static int vi_common_early_init(void *handle)
>  {
>          struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> @@ -1071,189 +1068,30 @@ static int vi_common_early_init(void *handle)
>          adev->external_rev_id = 0xFF;
>          switch (adev->asic_type) {
>          case CHIP_TOPAZ:
> -               adev->cg_flags = 0;
> -               adev->pg_flags = 0;
>                  adev->external_rev_id = 0x1;
>                  break;
>          case CHIP_FIJI:
> -               adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> -                       AMD_CG_SUPPORT_GFX_MGLS |
> -                       AMD_CG_SUPPORT_GFX_RLC_LS |
> -                       AMD_CG_SUPPORT_GFX_CP_LS |
> -                       AMD_CG_SUPPORT_GFX_CGTS |
> -                       AMD_CG_SUPPORT_GFX_CGTS_LS |
> -                       AMD_CG_SUPPORT_GFX_CGCG |
> -                       AMD_CG_SUPPORT_GFX_CGLS |
> -                       AMD_CG_SUPPORT_SDMA_MGCG |
> -                       AMD_CG_SUPPORT_SDMA_LS |
> -                       AMD_CG_SUPPORT_BIF_LS |
> -                       AMD_CG_SUPPORT_HDP_MGCG |
> -                       AMD_CG_SUPPORT_HDP_LS |
> -                       AMD_CG_SUPPORT_ROM_MGCG |
> -                       AMD_CG_SUPPORT_MC_MGCG |
> -                       AMD_CG_SUPPORT_MC_LS |
> -                       AMD_CG_SUPPORT_UVD_MGCG;
> -               adev->pg_flags = 0;
>                  adev->external_rev_id = adev->rev_id + 0x3c;
>                  break;
>          case CHIP_TONGA:
> -               adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> -                       AMD_CG_SUPPORT_GFX_CGCG |
> -                       AMD_CG_SUPPORT_GFX_CGLS |
> -                       AMD_CG_SUPPORT_SDMA_MGCG |
> -                       AMD_CG_SUPPORT_SDMA_LS |
> -                       AMD_CG_SUPPORT_BIF_LS |
> -                       AMD_CG_SUPPORT_HDP_MGCG |
> -                       AMD_CG_SUPPORT_HDP_LS |
> -                       AMD_CG_SUPPORT_ROM_MGCG |
> -                       AMD_CG_SUPPORT_MC_MGCG |
> -                       AMD_CG_SUPPORT_MC_LS |
> -                       AMD_CG_SUPPORT_DRM_LS |
> -                       AMD_CG_SUPPORT_UVD_MGCG;
> -               adev->pg_flags = 0;
>                  adev->external_rev_id = adev->rev_id + 0x14;
>                  break;
>          case CHIP_POLARIS11:
> -               adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> -                       AMD_CG_SUPPORT_GFX_RLC_LS |
> -                       AMD_CG_SUPPORT_GFX_CP_LS |
> -                       AMD_CG_SUPPORT_GFX_CGCG |
> -                       AMD_CG_SUPPORT_GFX_CGLS |
> -                       AMD_CG_SUPPORT_GFX_3D_CGCG |
> -                       AMD_CG_SUPPORT_GFX_3D_CGLS |
> -                       AMD_CG_SUPPORT_SDMA_MGCG |
> -                       AMD_CG_SUPPORT_SDMA_LS |
> -                       AMD_CG_SUPPORT_BIF_MGCG |
> -                       AMD_CG_SUPPORT_BIF_LS |
> -                       AMD_CG_SUPPORT_HDP_MGCG |
> -                       AMD_CG_SUPPORT_HDP_LS |
> -                       AMD_CG_SUPPORT_ROM_MGCG |
> -                       AMD_CG_SUPPORT_MC_MGCG |
> -                       AMD_CG_SUPPORT_MC_LS |
> -                       AMD_CG_SUPPORT_DRM_LS |
> -                       AMD_CG_SUPPORT_UVD_MGCG |
> -                       AMD_CG_SUPPORT_VCE_MGCG;
> -               adev->pg_flags = 0;
>                  adev->external_rev_id = adev->rev_id + 0x5A;
>                  break;
>          case CHIP_POLARIS10:
> -               adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> -                       AMD_CG_SUPPORT_GFX_RLC_LS |
> -                       AMD_CG_SUPPORT_GFX_CP_LS |
> -                       AMD_CG_SUPPORT_GFX_CGCG |
> -                       AMD_CG_SUPPORT_GFX_CGLS |
> -                       AMD_CG_SUPPORT_GFX_3D_CGCG |
> -                       AMD_CG_SUPPORT_GFX_3D_CGLS |
> -                       AMD_CG_SUPPORT_SDMA_MGCG |
> -                       AMD_CG_SUPPORT_SDMA_LS |
> -                       AMD_CG_SUPPORT_BIF_MGCG |
> -                       AMD_CG_SUPPORT_BIF_LS |
> -                       AMD_CG_SUPPORT_HDP_MGCG |
> -                       AMD_CG_SUPPORT_HDP_LS |
> -                       AMD_CG_SUPPORT_ROM_MGCG |
> -                       AMD_CG_SUPPORT_MC_MGCG |
> -                       AMD_CG_SUPPORT_MC_LS |
> -                       AMD_CG_SUPPORT_DRM_LS |
> -                       AMD_CG_SUPPORT_UVD_MGCG |
> -                       AMD_CG_SUPPORT_VCE_MGCG;
> -               adev->pg_flags = 0;
>                  adev->external_rev_id = adev->rev_id + 0x50;
>                  break;
>          case CHIP_POLARIS12:
> -               adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> -                       AMD_CG_SUPPORT_GFX_RLC_LS |
> -                       AMD_CG_SUPPORT_GFX_CP_LS |
> -                       AMD_CG_SUPPORT_GFX_CGCG |
> -                       AMD_CG_SUPPORT_GFX_CGLS |
> -                       AMD_CG_SUPPORT_GFX_3D_CGCG |
> -                       AMD_CG_SUPPORT_GFX_3D_CGLS |
> -                       AMD_CG_SUPPORT_SDMA_MGCG |
> -                       AMD_CG_SUPPORT_SDMA_LS |
> -                       AMD_CG_SUPPORT_BIF_MGCG |
> -                       AMD_CG_SUPPORT_BIF_LS |
> -                       AMD_CG_SUPPORT_HDP_MGCG |
> -                       AMD_CG_SUPPORT_HDP_LS |
> -                       AMD_CG_SUPPORT_ROM_MGCG |
> -                       AMD_CG_SUPPORT_MC_MGCG |
> -                       AMD_CG_SUPPORT_MC_LS |
> -                       AMD_CG_SUPPORT_DRM_LS |
> -                       AMD_CG_SUPPORT_UVD_MGCG |
> -                       AMD_CG_SUPPORT_VCE_MGCG;
> -               adev->pg_flags = 0;
>                  adev->external_rev_id = adev->rev_id + 0x64;
>                  break;
>          case CHIP_VEGAM:
> -               adev->cg_flags = 0;
> -                       /*AMD_CG_SUPPORT_GFX_MGCG |
> -                       AMD_CG_SUPPORT_GFX_RLC_LS |
> -                       AMD_CG_SUPPORT_GFX_CP_LS |
> -                       AMD_CG_SUPPORT_GFX_CGCG |
> -                       AMD_CG_SUPPORT_GFX_CGLS |
> -                       AMD_CG_SUPPORT_GFX_3D_CGCG |
> -                       AMD_CG_SUPPORT_GFX_3D_CGLS |
> -                       AMD_CG_SUPPORT_SDMA_MGCG |
> -                       AMD_CG_SUPPORT_SDMA_LS |
> -                       AMD_CG_SUPPORT_BIF_MGCG |
> -                       AMD_CG_SUPPORT_BIF_LS |
> -                       AMD_CG_SUPPORT_HDP_MGCG |
> -                       AMD_CG_SUPPORT_HDP_LS |
> -                       AMD_CG_SUPPORT_ROM_MGCG |
> -                       AMD_CG_SUPPORT_MC_MGCG |
> -                       AMD_CG_SUPPORT_MC_LS |
> -                       AMD_CG_SUPPORT_DRM_LS |
> -                       AMD_CG_SUPPORT_UVD_MGCG |
> -                       AMD_CG_SUPPORT_VCE_MGCG;*/
> -               adev->pg_flags = 0;
>                  adev->external_rev_id = adev->rev_id + 0x6E;
>                  break;
>          case CHIP_CARRIZO:
> -               adev->cg_flags = AMD_CG_SUPPORT_UVD_MGCG |
> -                       AMD_CG_SUPPORT_GFX_MGCG |
> -                       AMD_CG_SUPPORT_GFX_MGLS |
> -                       AMD_CG_SUPPORT_GFX_RLC_LS |
> -                       AMD_CG_SUPPORT_GFX_CP_LS |
> -                       AMD_CG_SUPPORT_GFX_CGTS |
> -                       AMD_CG_SUPPORT_GFX_CGTS_LS |
> -                       AMD_CG_SUPPORT_GFX_CGCG |
> -                       AMD_CG_SUPPORT_GFX_CGLS |
> -                       AMD_CG_SUPPORT_BIF_LS |
> -                       AMD_CG_SUPPORT_HDP_MGCG |
> -                       AMD_CG_SUPPORT_HDP_LS |
> -                       AMD_CG_SUPPORT_SDMA_MGCG |
> -                       AMD_CG_SUPPORT_SDMA_LS |
> -                       AMD_CG_SUPPORT_VCE_MGCG;
> -               /* rev0 hardware requires workarounds to support PG */
> -               adev->pg_flags = 0;
> -               if (adev->rev_id != 0x00 ||  
> CZ_REV_BRISTOL(adev->pdev->revision)) {
> -                       adev->pg_flags |= AMD_PG_SUPPORT_GFX_SMG |
> -                               AMD_PG_SUPPORT_GFX_PIPELINE |
> -                               AMD_PG_SUPPORT_CP |
> -                               AMD_PG_SUPPORT_UVD |
> -                               AMD_PG_SUPPORT_VCE;
> -               }
>                  adev->external_rev_id = adev->rev_id + 0x1;
>                  break;
>          case CHIP_STONEY:
> -               adev->cg_flags = AMD_CG_SUPPORT_UVD_MGCG |
> -                       AMD_CG_SUPPORT_GFX_MGCG |
> -                       AMD_CG_SUPPORT_GFX_MGLS |
> -                       AMD_CG_SUPPORT_GFX_RLC_LS |
> -                       AMD_CG_SUPPORT_GFX_CP_LS |
> -                       AMD_CG_SUPPORT_GFX_CGTS |
> -                       AMD_CG_SUPPORT_GFX_CGTS_LS |
> -                       AMD_CG_SUPPORT_GFX_CGLS |
> -                       AMD_CG_SUPPORT_BIF_LS |
> -                       AMD_CG_SUPPORT_HDP_MGCG |
> -                       AMD_CG_SUPPORT_HDP_LS |
> -                       AMD_CG_SUPPORT_SDMA_MGCG |
> -                       AMD_CG_SUPPORT_SDMA_LS |
> -                       AMD_CG_SUPPORT_VCE_MGCG;
> -               adev->pg_flags = AMD_PG_SUPPORT_GFX_PG |
> -                       AMD_PG_SUPPORT_GFX_SMG |
> -                       AMD_PG_SUPPORT_GFX_PIPELINE |
> -                       AMD_PG_SUPPORT_CP |
> -                       AMD_PG_SUPPORT_UVD |
> -                       AMD_PG_SUPPORT_VCE;
>                  adev->external_rev_id = adev->rev_id + 0x61;
>                  break;
>          default:
> -- 
> 2.17.1
>
> <0001-drm-amdgpu-gfx9-update-pg_flags-after-determining-if.patch>


