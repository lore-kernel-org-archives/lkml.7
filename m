Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02E0C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 23:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C1D2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 23:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="rMDEd3yy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbfCAXC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 18:02:26 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37002 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfCAXC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 18:02:26 -0500
Received: by mail-qk1-f193.google.com with SMTP id m9so15348875qkl.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 15:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mw44HYy7Lc6frKkrPfPzOFDmJbP9nuk8UEeG+RXhqdc=;
        b=rMDEd3yyOqkfUKS8s1PkgqubL7KwiydCeY9x8aw4I7GZJzJWKKPAHfpFkZfavuT7Z/
         jJukNsl8r60PMIBrebNvmUbukmzCJz8YAYwKflTclJcLjF7uLxJ6Tm4Fz9maQGt4octp
         /ehn7VD8rH7TIjTmCAnSwSBunLY/LgkLWHeR7666R+QnR1MT2UPU/B9nDIAYFjYXm6uk
         m5me1N0JqtekWO1JZgvbql40D6Dhi8Oa2u5Z3BRQui0fW3habp+4H31FNqJUKrSO4a+8
         VSN5b0Xpd9UVWZw1bvlkmhsrRr1rqH3ewEDRc3tREU3aTp0tzWcRDo5c5JpU+tEOsF1Z
         eL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mw44HYy7Lc6frKkrPfPzOFDmJbP9nuk8UEeG+RXhqdc=;
        b=YtJ4K33JdAI0yjDXNZyJZcemyMmfB5QCUBBpHI34/D0PooPMbFnACy9zr14kU7ysqB
         wVrIVfQ1vjZ3dG+CYOKb48988JZFJPeUzHb1ctmfaQnmOmKqiriQzlbPAZ0PX/wWCY59
         0kNsvjvBIqgYVXaI1PQSviJFv6yMYl9LbxKtaBbt6R5Jz1Y7VU3/wR6xhQnM7B3hmqYO
         oglUW9tx56egEdxEAEPAe6cfsfGlB9U5oPZ0O0UIHu196+snqGhCdL9nD8jJF2c/0qjp
         FzgNCD5v1kTUuWkPyGJ6NnA0RlONnGw3pAh+WCWqZsq4sFYlzXDXeKBquXHTzYXP2Zsr
         kM1Q==
X-Gm-Message-State: APjAAAVJsvL13wN/PzYvJ0b6QqQzmECLMWptCjM0ZoitlDvmot0YxUtk
        bFkbVtxhhbEgBZCNZ8bKqi96SQpFR5KJIiBf
X-Google-Smtp-Source: APXvYqyjntKEWzeZqaOt+TjZh3Z/v7niWkkZHDokhsAGJ1PPFV4h6qhXmnKl1NbF24RtvOt+NBQBBg==
X-Received: by 2002:a05:620a:1103:: with SMTP id o3mr5835918qkk.157.1551481343757;
        Fri, 01 Mar 2019 15:02:23 -0800 (PST)
Received: from [192.168.0.189] (modemcable014.247-57-74.mc.videotron.ca. [74.57.247.14])
        by smtp.gmail.com with ESMTPSA id i1sm13816970qtb.0.2019.03.01.15.02.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 15:02:23 -0800 (PST)
Subject: Re: [RFC PATCH v1 09/15] drm/msm/gpu: Move address space setup to the
 GPU targets
To:     Jordan Crouse <jcrouse@codeaurora.org>,
        freedreno@lists.freedesktop.org
Cc:     jean-philippe.brucker@arm.com, linux-arm-msm@vger.kernel.org,
        dianders@chromimum.org, hoegsberg@google.com,
        baolu.lu@linux.intel.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sean Paul <sean@poorly.run>,
        Sharat Masetty <smasetty@codeaurora.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
References: <1551469117-3404-1-git-send-email-jcrouse@codeaurora.org>
 <1551469117-3404-10-git-send-email-jcrouse@codeaurora.org>
From:   Jonathan Marek <jonathan@marek.ca>
Message-ID: <3f584b2d-9d9e-e18d-e745-cdb8f3599c59@marek.ca>
Date:   Fri, 1 Mar 2019 18:01:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1551469117-3404-10-git-send-email-jcrouse@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an error in the a2xx part of this patch: 0xfff in adreno_gpu.c 
became 0xff in a2xx_gpu.c

On 3/1/19 2:38 PM, Jordan Crouse wrote:
> Move the address space steup code out of the generic msm GPU code to
> to the individual GPU targets. This allows us to do target specific
> setup such as gpummu for a2xx or split pagetables and per-instance
> pagetables for newer a5xx and a6xx targets. All this is at the
> expense of duplicated code in some of the target files but I think
> it pays for itself in improved code flow and flexibility.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
> 
>   drivers/gpu/drm/msm/adreno/a2xx_gpu.c   | 37 ++++++++++++++++------
>   drivers/gpu/drm/msm/adreno/a3xx_gpu.c   | 50 ++++++++++++++++++++++--------
>   drivers/gpu/drm/msm/adreno/a4xx_gpu.c   | 51 +++++++++++++++++++++++--------
>   drivers/gpu/drm/msm/adreno/a5xx_gpu.c   | 37 +++++++++++++++++++---
>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 37 +++++++++++++++++++---
>   drivers/gpu/drm/msm/adreno/adreno_gpu.c |  7 -----
>   drivers/gpu/drm/msm/msm_gem.h           |  1 +
>   drivers/gpu/drm/msm/msm_gpu.c           | 54 ++-------------------------------
>   drivers/gpu/drm/msm/msm_gpu.h           |  2 ++
>   9 files changed, 173 insertions(+), 103 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a2xx_gpu.c b/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
> index 1f83bc1..49241d0 100644
> --- a/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
> @@ -401,6 +401,30 @@ static struct msm_gpu_state *a2xx_gpu_state_get(struct msm_gpu *gpu)
>   	return state;
>   }
>   
> +static struct msm_gem_address_space *
> +a2xx_create_address_space(struct msm_gpu *gpu)
> +{
> +	struct msm_gem_address_space *aspace;
> +	int ret;
> +
> +	aspace = msm_gem_address_space_create_a2xx(&gpu->pdev->dev, gpu,
> +		"gpu", SZ_16M, SZ_16M + 0xff * SZ_64K);
> +	if (IS_ERR(aspace)) {
> +		DRM_DEV_ERROR(gpu->dev->dev,
> +			"No memory protection without MMU\n");
> +		return ERR_PTR(-ENXIO);
> +	}
> +
> +	ret = aspace->mmu->funcs->attach(aspace->mmu, NULL, 0);
> +	if (ret) {
> +		msm_gem_address_space_put(aspace);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return aspace;
> +}
> +
> +
>   /* Register offset defines for A2XX - copy of A3XX */
>   static const unsigned int a2xx_register_offsets[REG_ADRENO_REGISTER_MAX] = {
>   	REG_ADRENO_DEFINE(REG_ADRENO_CP_RB_BASE, REG_AXXX_CP_RB_BASE),
> @@ -429,6 +453,7 @@ static const struct adreno_gpu_funcs funcs = {
>   #endif
>   		.gpu_state_get = a2xx_gpu_state_get,
>   		.gpu_state_put = adreno_gpu_state_put,
> +		.create_address_space = a2xx_create_address_space,
>   	},
>   };
>   
> @@ -473,16 +498,8 @@ struct msm_gpu *a2xx_gpu_init(struct drm_device *dev)
>   	adreno_gpu->reg_offsets = a2xx_register_offsets;
>   
>   	ret = adreno_gpu_init(dev, pdev, adreno_gpu, &funcs, 1);
> -	if (ret)
> -		goto fail;
> -
> -	if (!gpu->aspace) {
> -		dev_err(dev->dev, "No memory protection without MMU\n");
> -		ret = -ENXIO;
> -		goto fail;
> -	}
> -
> -	return gpu;
> +	if (!ret)
> +		return gpu;
>   
>   fail:
>   	if (a2xx_gpu)
> diff --git a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
> index c3b4bc6..33ab5e8 100644
> --- a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
> @@ -21,6 +21,7 @@
>   #  include <mach/ocmem.h>
>   #endif
>   
> +#include "msm_gem.h"
>   #include "a3xx_gpu.h"
>   
>   #define A3XX_INT0_MASK \
> @@ -433,6 +434,41 @@ static struct msm_gpu_state *a3xx_gpu_state_get(struct msm_gpu *gpu)
>   	return state;
>   }
>   
> +static struct msm_gem_address_space *
> +a3xx_create_address_space(struct msm_gpu *gpu)
> +{
> +	struct msm_gem_address_space *aspace;
> +	struct iommu_domain *iommu;
> +	int ret;
> +
> +	iommu = iommu_domain_alloc(&platform_bus_type);
> +	if (!iommu) {
> +		DRM_DEV_ERROR(gpu->dev->dev,
> +			"No memory protection without IOMMU\n");
> +		return ERR_PTR(-ENXIO);
> +	}
> +
> +	iommu->geometry.aperture_start = SZ_16M;
> +	iommu->geometry.aperture_end = 0xffffffff;
> +
> +	aspace = msm_gem_address_space_create(&gpu->pdev->dev, iommu, "gpu");
> +	if (IS_ERR(aspace)) {
> +		iommu_domain_free(iommu);
> +		DRM_DEV_ERROR(gpu->dev->dev, "failed to init mmu: %ld\n",
> +			PTR_ERR(aspace));
> +		return aspace;
> +	}
> +
> +	ret = aspace->mmu->funcs->attach(aspace->mmu, NULL, 0);
> +	if (ret) {
> +		msm_gem_address_space_put(aspace);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return aspace;
> +}
> +
> +
>   /* Register offset defines for A3XX */
>   static const unsigned int a3xx_register_offsets[REG_ADRENO_REGISTER_MAX] = {
>   	REG_ADRENO_DEFINE(REG_ADRENO_CP_RB_BASE, REG_AXXX_CP_RB_BASE),
> @@ -461,6 +497,7 @@ static const struct adreno_gpu_funcs funcs = {
>   #endif
>   		.gpu_state_get = a3xx_gpu_state_get,
>   		.gpu_state_put = adreno_gpu_state_put,
> +		.create_address_space = a3xx_create_address_space,
>   	},
>   };
>   
> @@ -520,19 +557,6 @@ struct msm_gpu *a3xx_gpu_init(struct drm_device *dev)
>   #endif
>   	}
>   
> -	if (!gpu->aspace) {
> -		/* TODO we think it is possible to configure the GPU to
> -		 * restrict access to VRAM carveout.  But the required
> -		 * registers are unknown.  For now just bail out and
> -		 * limp along with just modesetting.  If it turns out
> -		 * to not be possible to restrict access, then we must
> -		 * implement a cmdstream validator.
> -		 */
> -		DRM_DEV_ERROR(dev->dev, "No memory protection without IOMMU\n");
> -		ret = -ENXIO;
> -		goto fail;
> -	}
> -
>   	return gpu;
>   
>   fail:
> diff --git a/drivers/gpu/drm/msm/adreno/a4xx_gpu.c b/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
> index 18f9a8e..08a5729 100644
> --- a/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
> @@ -15,6 +15,8 @@
>   #  include <soc/qcom/ocmem.h>
>   #endif
>   
> +#include "msm_gem.h"
> +
>   #define A4XX_INT0_MASK \
>   	(A4XX_INT0_RBBM_AHB_ERROR |        \
>   	 A4XX_INT0_RBBM_ATB_BUS_OVERFLOW | \
> @@ -530,6 +532,41 @@ static int a4xx_get_timestamp(struct msm_gpu *gpu, uint64_t *value)
>   	return 0;
>   }
>   
> +static struct msm_gem_address_space *
> +a4xx_create_address_space(struct msm_gpu *gpu)
> +{
> +	struct msm_gem_address_space *aspace;
> +	struct iommu_domain *iommu;
> +	int ret;
> +
> +	iommu = iommu_domain_alloc(&platform_bus_type);
> +	if (!iommu) {
> +		DRM_DEV_ERROR(gpu->dev->dev,
> +			"No memory protection without IOMMU\n");
> +		return ERR_PTR(-ENXIO);
> +	}
> +
> +	iommu->geometry.aperture_start = SZ_16M;
> +	iommu->geometry.aperture_end = 0xffffffff;
> +
> +	aspace = msm_gem_address_space_create(&gpu->pdev->dev, iommu, "gpu");
> +	if (IS_ERR(aspace)) {
> +		iommu_domain_free(iommu);
> +		DRM_DEV_ERROR(gpu->dev->dev, "failed to init mmu: %ld\n",
> +			PTR_ERR(aspace));
> +		return aspace;
> +	}
> +
> +	ret = aspace->mmu->funcs->attach(aspace->mmu, NULL, 0);
> +	if (ret) {
> +		msm_gem_address_space_put(aspace);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return aspace;
> +}
> +
> +
>   static const struct adreno_gpu_funcs funcs = {
>   	.base = {
>   		.get_param = adreno_get_param,
> @@ -547,6 +584,7 @@ static const struct adreno_gpu_funcs funcs = {
>   #endif
>   		.gpu_state_get = a4xx_gpu_state_get,
>   		.gpu_state_put = adreno_gpu_state_put,
> +		.create_address_space = a4xx_create_address_space,
>   	},
>   	.get_timestamp = a4xx_get_timestamp,
>   };
> @@ -600,19 +638,6 @@ struct msm_gpu *a4xx_gpu_init(struct drm_device *dev)
>   #endif
>   	}
>   
> -	if (!gpu->aspace) {
> -		/* TODO we think it is possible to configure the GPU to
> -		 * restrict access to VRAM carveout.  But the required
> -		 * registers are unknown.  For now just bail out and
> -		 * limp along with just modesetting.  If it turns out
> -		 * to not be possible to restrict access, then we must
> -		 * implement a cmdstream validator.
> -		 */
> -		DRM_DEV_ERROR(dev->dev, "No memory protection without IOMMU\n");
> -		ret = -ENXIO;
> -		goto fail;
> -	}
> -
>   	return gpu;
>   
>   fail:
> diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> index 45662d3..3d6f414 100644
> --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> @@ -1456,6 +1456,38 @@ static unsigned long a5xx_gpu_busy(struct msm_gpu *gpu)
>   	return (unsigned long)busy_time;
>   }
>   
> +static struct msm_gem_address_space *
> +a5xx_create_address_space(struct msm_gpu *gpu)
> +{
> +	struct msm_gem_address_space *aspace;
> +	struct iommu_domain *iommu;
> +	int ret;
> +
> +	iommu = iommu_domain_alloc(&platform_bus_type);
> +	if (!iommu)
> +		return NULL;
> +
> +	iommu->geometry.aperture_start = 0x100000000ULL;
> +	iommu->geometry.aperture_end = 0x1ffffffffULL;
> +
> +	aspace = msm_gem_address_space_create(&gpu->pdev->dev, iommu, "gpu");
> +	if (IS_ERR(aspace)) {
> +		iommu_domain_free(iommu);
> +		DRM_DEV_ERROR(gpu->dev->dev, "failed to init mmu: %ld\n",
> +			PTR_ERR(aspace));
> +		return aspace;
> +	}
> +
> +	ret = aspace->mmu->funcs->attach(aspace->mmu, NULL, 0);
> +	if (ret) {
> +		msm_gem_address_space_put(aspace);
> +		return ERR_PTR(ret);
> +	}
> +
> +	msm_mmu_set_fault_handler(aspace->mmu, gpu, a5xx_fault_handler);
> +	return aspace;
> +}
> +
>   static const struct adreno_gpu_funcs funcs = {
>   	.base = {
>   		.get_param = adreno_get_param,
> @@ -1477,6 +1509,7 @@ static const struct adreno_gpu_funcs funcs = {
>   		.gpu_busy = a5xx_gpu_busy,
>   		.gpu_state_get = a5xx_gpu_state_get,
>   		.gpu_state_put = a5xx_gpu_state_put,
> +		.create_address_space = a5xx_create_address_space,
>   	},
>   	.get_timestamp = a5xx_get_timestamp,
>   };
> @@ -1523,7 +1556,6 @@ struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)
>   
>   	adreno_gpu->registers = a5xx_registers;
>   	adreno_gpu->reg_offsets = a5xx_register_offsets;
> -
>   	a5xx_gpu->lm_leakage = 0x4E001A;
>   
>   	check_speed_bin(&pdev->dev);
> @@ -1534,9 +1566,6 @@ struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)
>   		return ERR_PTR(ret);
>   	}
>   
> -	if (gpu->aspace)
> -		msm_mmu_set_fault_handler(gpu->aspace->mmu, gpu, a5xx_fault_handler);
> -
>   	/* Set up the preemption specific bits and pieces for each ringbuffer */
>   	a5xx_preempt_init(gpu);
>   
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 1c20d59..f2e0800 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -783,6 +783,38 @@ static unsigned long a6xx_gpu_busy(struct msm_gpu *gpu)
>   	return (unsigned long)busy_time;
>   }
>   
> +static struct msm_gem_address_space *
> +a6xx_create_address_space(struct msm_gpu *gpu)
> +{
> +	struct msm_gem_address_space *aspace;
> +	struct iommu_domain *iommu;
> +	int ret;
> +
> +	iommu = iommu_domain_alloc(&platform_bus_type);
> +	if (!iommu)
> +		return NULL;
> +
> +	iommu->geometry.aperture_start = 0x100000000ULL;
> +	iommu->geometry.aperture_end = 0x1ffffffffULL;
> +
> +	aspace = msm_gem_address_space_create(&gpu->pdev->dev, iommu, "gpu");
> +	if (IS_ERR(aspace)) {
> +		iommu_domain_free(iommu);
> +		DRM_DEV_ERROR(gpu->dev->dev, "failed to init mmu: %ld\n",
> +			PTR_ERR(aspace));
> +		return aspace;
> +	}
> +
> +	ret = aspace->mmu->funcs->attach(aspace->mmu, NULL, 0);
> +	if (ret) {
> +		msm_gem_address_space_put(aspace);
> +		return ERR_PTR(ret);
> +	}
> +
> +	msm_mmu_set_fault_handler(aspace->mmu, gpu, a6xx_fault_handler);
> +	return aspace;
> +}
> +
>   static const struct adreno_gpu_funcs funcs = {
>   	.base = {
>   		.get_param = adreno_get_param,
> @@ -803,6 +835,7 @@ static const struct adreno_gpu_funcs funcs = {
>   		.gpu_set_freq = a6xx_gmu_set_freq,
>   		.gpu_state_get = a6xx_gpu_state_get,
>   		.gpu_state_put = a6xx_gpu_state_put,
> +		.create_address_space = a6xx_create_address_space,
>   	},
>   	.get_timestamp = a6xx_get_timestamp,
>   };
> @@ -845,9 +878,5 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
>   		return ERR_PTR(ret);
>   	}
>   
> -	if (gpu->aspace)
> -		msm_mmu_set_fault_handler(gpu->aspace->mmu, gpu,
> -				a6xx_fault_handler);
> -
>   	return gpu;
>   }
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index 2cfee1a..dc9ea82 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -765,13 +765,6 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>   	adreno_gpu->rev = config->rev;
>   
>   	adreno_gpu_config.ioname = "kgsl_3d0_reg_memory";
> -
> -	adreno_gpu_config.va_start = SZ_16M;
> -	adreno_gpu_config.va_end = 0xffffffff;
> -	/* maximum range of a2xx mmu */
> -	if (adreno_is_a2xx(adreno_gpu))
> -		adreno_gpu_config.va_end = SZ_16M + 0xfff * SZ_64K;
> -
>   	adreno_gpu_config.nr_rings = nr_rings;
>   
>   	adreno_get_pwrlevels(&pdev->dev, gpu);
> diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
> index 5e21d01..777f5fb 100644
> --- a/drivers/gpu/drm/msm/msm_gem.h
> +++ b/drivers/gpu/drm/msm/msm_gem.h
> @@ -21,6 +21,7 @@
>   #include <linux/kref.h>
>   #include <linux/reservation.h>
>   #include "msm_drv.h"
> +#include "msm_mmu.h"
>   
>   /* Additional internal-use only BO flags: */
>   #define MSM_BO_STOLEN        0x10000000    /* try to use stolen/splash memory */
> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> index 79b71b1..ec48bb3 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -20,7 +20,6 @@
>   #include "msm_mmu.h"
>   #include "msm_fence.h"
>   #include "msm_gpu_trace.h"
> -#include "adreno/adreno_gpu.h"
>   
>   #include <generated/utsrelease.h>
>   #include <linux/string_helpers.h>
> @@ -821,51 +820,6 @@ static int get_clocks(struct platform_device *pdev, struct msm_gpu *gpu)
>   	return 0;
>   }
>   
> -static struct msm_gem_address_space *
> -msm_gpu_create_address_space(struct msm_gpu *gpu, struct platform_device *pdev,
> -		uint64_t va_start, uint64_t va_end)
> -{
> -	struct msm_gem_address_space *aspace;
> -	int ret;
> -
> -	/*
> -	 * Setup IOMMU.. eventually we will (I think) do this once per context
> -	 * and have separate page tables per context.  For now, to keep things
> -	 * simple and to get something working, just use a single address space:
> -	 */
> -	if (!adreno_is_a2xx(to_adreno_gpu(gpu))) {
> -		struct iommu_domain *iommu = iommu_domain_alloc(&platform_bus_type);
> -		if (!iommu)
> -			return NULL;
> -
> -		iommu->geometry.aperture_start = va_start;
> -		iommu->geometry.aperture_end = va_end;
> -
> -		DRM_DEV_INFO(gpu->dev->dev, "%s: using IOMMU\n", gpu->name);
> -
> -		aspace = msm_gem_address_space_create(&pdev->dev, iommu, "gpu");
> -		if (IS_ERR(aspace))
> -			iommu_domain_free(iommu);
> -	} else {
> -		aspace = msm_gem_address_space_create_a2xx(&pdev->dev, gpu, "gpu",
> -			va_start, va_end);
> -	}
> -
> -	if (IS_ERR(aspace)) {
> -		DRM_DEV_ERROR(gpu->dev->dev, "failed to init mmu: %ld\n",
> -			PTR_ERR(aspace));
> -		return ERR_CAST(aspace);
> -	}
> -
> -	ret = aspace->mmu->funcs->attach(aspace->mmu, NULL, 0);
> -	if (ret) {
> -		msm_gem_address_space_put(aspace);
> -		return ERR_PTR(ret);
> -	}
> -
> -	return aspace;
> -}
> -
>   int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>   		struct msm_gpu *gpu, const struct msm_gpu_funcs *funcs,
>   		const char *name, struct msm_gpu_config *config)
> @@ -938,12 +892,8 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>   
>   	msm_devfreq_init(gpu);
>   
> -	gpu->aspace = msm_gpu_create_address_space(gpu, pdev,
> -		config->va_start, config->va_end);
> -
> -	if (gpu->aspace == NULL)
> -		DRM_DEV_INFO(drm->dev, "%s: no IOMMU, fallback to VRAM carveout!\n", name);
> -	else if (IS_ERR(gpu->aspace)) {
> +	gpu->aspace = gpu->funcs->create_address_space(gpu);
> +	if (IS_ERR(gpu->aspace)) {
>   		ret = PTR_ERR(gpu->aspace);
>   		goto fail;
>   	}
> diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
> index ca17086..81b9861 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.h
> +++ b/drivers/gpu/drm/msm/msm_gpu.h
> @@ -74,6 +74,8 @@ struct msm_gpu_funcs {
>   	int (*gpu_state_put)(struct msm_gpu_state *state);
>   	unsigned long (*gpu_get_freq)(struct msm_gpu *gpu);
>   	void (*gpu_set_freq)(struct msm_gpu *gpu, unsigned long freq);
> +	struct msm_gem_address_space *(*create_address_space)
> +		(struct msm_gpu *gpu);
>   };
>   
>   struct msm_gpu {
> 
