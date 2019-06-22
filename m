Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A40AC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1617D2070B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfFVGCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 02:02:20 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:55312
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725932AbfFVGCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 02:02:20 -0400
X-IronPort-AV: E=Sophos;i="5.63,403,1557180000"; 
   d="scan'208";a="311051050"
Received: from abo-12-105-68.mrs.modulonet.fr (HELO hadrien) ([85.68.105.12])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2019 08:02:16 +0200
Date:   Sat, 22 Jun 2019 08:02:16 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Mao Wenan <maowenan@huawei.com>
cc:     airlied@linux.ie, daniel@ffwll.ch, alexander.deucher@amd.com,
        christian.koenig@amd.com, David1.Zhou@amd.com,
        kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] drm/amdgpu: remove set but not used variables
 'ret'
In-Reply-To: <20190622030314.169640-1-maowenan@huawei.com>
Message-ID: <alpine.DEB.2.21.1906220801210.3253@hadrien>
References: <20190622030314.169640-1-maowenan@huawei.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-406165930-1561183337=:3253"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-406165930-1561183337=:3253
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 22 Jun 2019, Mao Wenan wrote:

> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c: In function ‘amdgpu_pmu_init’:
> drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c:249:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
>   int ret = 0;
>       ^
>
> It is never used since introduction in 9c7c85f7ea1f ("drm/amdgpu: add pmu counters")
>
> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> index 0e6dba9..0bf4dd9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> @@ -246,12 +246,10 @@ static int init_pmu_by_type(struct amdgpu_device *adev,
>  /* init amdgpu_pmu */
>  int amdgpu_pmu_init(struct amdgpu_device *adev)
>  {
> -	int ret = 0;
> -
>  	switch (adev->asic_type) {
>  	case CHIP_VEGA20:
>  		/* init df */
> -		ret = init_pmu_by_type(adev, df_v3_6_attr_groups,
> +		init_pmu_by_type(adev, df_v3_6_attr_groups,
>  				       "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,
>  				       DF_V3_6_MAX_COUNTERS);

Maybe it would be better to use ret?

If knowing whether the call has failed is really useless, then maybe the
return type should be void?

julia


>
> --
> 2.7.4
>
>
--8323329-406165930-1561183337=:3253--
