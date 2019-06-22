Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B45C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 14:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D12520652
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 14:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfFVOAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 10:00:33 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:7088 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726286AbfFVOAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 10:00:33 -0400
X-IronPort-AV: E=Sophos;i="5.63,404,1557180000"; 
   d="scan'208";a="311073839"
Received: from abo-12-105-68.mrs.modulonet.fr (HELO hadrien) ([85.68.105.12])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2019 16:00:29 +0200
Date:   Sat, 22 Jun 2019 16:00:29 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     maowenan <maowenan@huawei.com>
cc:     airlied@linux.ie, daniel@ffwll.ch, alexander.deucher@amd.com,
        christian.koenig@amd.com, David1.Zhou@amd.com,
        dan.carpenter@oracle.com, kernel-janitors@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] drm/amdgpu: return 'ret' in amdgpu_pmu_init
In-Reply-To: <063c9726-8f16-f9b7-2d16-bc87a99085bb@huawei.com>
Message-ID: <alpine.DEB.2.21.1906221559060.3253@hadrien>
References: <20190622104318.GT28859@kadam> <20190622130527.182022-1-maowenan@huawei.com> <alpine.DEB.2.21.1906221504110.3253@hadrien> <063c9726-8f16-f9b7-2d16-bc87a99085bb@huawei.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-716062006-1561212030=:3253"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-716062006-1561212030=:3253
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sat, 22 Jun 2019, maowenan wrote:

>
>
> On 2019/6/22 21:06, Julia Lawall wrote:
> >
> >
> > On Sat, 22 Jun 2019, Mao Wenan wrote:
> >
> >> There is one warning:
> >> drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c: In function ‘amdgpu_pmu_init’:
> >> drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c:249:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
> >>   int ret = 0;
> >>       ^
> >> amdgpu_pmu_init() is called by amdgpu_device_init() in drivers/gpu/drm/amd/amdgpu/amdgpu_device.c,
> >> which will use the return value. So it returns 'ret' for caller.
> >> amdgpu_device_init()
> >> 	r = amdgpu_pmu_init(adev);
> >>
> >> Fixes: 9c7c85f7ea1f ("drm/amdgpu: add pmu counters")
> >>
> >> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> >> ---
> >>  v1->v2: change the subject for this patch; change the indenting when it calls init_pmu_by_type; use the value 'ret' in
> >>  amdgpu_pmu_init().
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> >> index 0e6dba9..145e720 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> >> @@ -252,8 +252,8 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
> >>  	case CHIP_VEGA20:
> >>  		/* init df */
> >>  		ret = init_pmu_by_type(adev, df_v3_6_attr_groups,
> >> -				       "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,
> >> -				       DF_V3_6_MAX_COUNTERS);
> >> +							   "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,
> >> +							   DF_V3_6_MAX_COUNTERS);
> >>
> >>  		/* other pmu types go here*/
> >
> > I don't know what is the impact of the other pmu types that are planned
> > for the future.  Perhaps it would be better to abort the function
> > immediately in the case of a failure.
>
> I guess it would be better to use new function or new switch case clause to process different PMU types
> in future.

I don't know.  But normally when an error may occur it is checked for
immediately, rather than just letting it go until the end of the function.
But maybe the developer know what is planned for the future for this
function.

julia

>
> >
> > julia
> >
> >>  		break;
> >> @@ -261,7 +261,7 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
> >>  		return 0;
> >>  	}
> >>
> >> -	return 0;
> >> +	return ret;
> >>  }
> >>
> >>
> >> --
> >> 2.7.4
> >>
> >>
> >
>
>
--8323329-716062006-1561212030=:3253--
