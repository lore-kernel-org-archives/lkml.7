Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C22C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 16:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4781206D3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 16:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbfKMQ4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 11:56:09 -0500
Received: from smtprelay0046.hostedemail.com ([216.40.44.46]:53376 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726129AbfKMQ4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 11:56:08 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 30073100E7B40;
        Wed, 13 Nov 2019 16:56:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cloth41_18055f6faa706
X-Filterd-Recvd-Size: 2543
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Wed, 13 Nov 2019 16:56:04 +0000 (UTC)
Message-ID: <ac4566662a04e0c25039df7ed30789d0792885cd.camel@perches.com>
Subject: Re: [PATCH 1/7] drm/amdgpu: remove set but not used variable
 'mc_shared_chmap' from 'gfx_v6_0.c' and 'gfx_v7_0.c'
From:   Joe Perches <joe@perches.com>
To:     yu kuai <yukuai3@huawei.com>, alexander.deucher@amd.com,
        Felix.Kuehling@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        Rex.Zhu@amd.com, evan.quan@amd.com
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, zhengbin13@huawei.com,
        yi.zhang@huawei.com
Date:   Wed, 13 Nov 2019 08:55:47 -0800
In-Reply-To: <1573649074-72589-2-git-send-email-yukuai3@huawei.com>
References: <1573649074-72589-1-git-send-email-yukuai3@huawei.com>
         <1573649074-72589-2-git-send-email-yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-11-13 at 20:44 +0800, yu kuai wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c: In function
> ‘gfx_v6_0_constants_init’:
> drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c:1579:6: warning: variable
> ‘mc_shared_chmap’ set but not used [-Wunused-but-set-variable]
[]
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
[]
> @@ -1678,7 +1678,6 @@ static void gfx_v6_0_constants_init(struct amdgpu_device *adev)
>  
>  	WREG32(mmBIF_FB_EN, BIF_FB_EN__FB_READ_EN_MASK | BIF_FB_EN__FB_WRITE_EN_MASK);
>  
> -	mc_shared_chmap = RREG32(mmMC_SHARED_CHMAP);

I do not know the hardware but frequently hardware like
this has read ordering requirements and various registers
can not be read in a random order.

Does removing this read have no effect on the hardware?

>  	adev->gfx.config.mc_arb_ramcfg = RREG32(mmMC_ARB_RAMCFG);
>  	mc_arb_ramcfg = adev->gfx.config.mc_arb_ramcfg;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
[]
> @@ -4336,7 +4336,6 @@ static void gfx_v7_0_gpu_early_init(struct amdgpu_device *adev)
>  		break;
>  	}
>  
> -	mc_shared_chmap = RREG32(mmMC_SHARED_CHMAP);
>  	adev->gfx.config.mc_arb_ramcfg = RREG32(mmMC_ARB_RAMCFG);
>  	mc_arb_ramcfg = adev->gfx.config.mc_arb_ramcfg;

Same question.

