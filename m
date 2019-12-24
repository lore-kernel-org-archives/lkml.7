Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066EFC2D0D5
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 02:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B3E206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 02:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="CV9Zc+dl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfLXC5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 21:57:36 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:45575 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726832AbfLXC5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 21:57:35 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1577156254; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=mF5Yk5W/LFHhcmsl8A7AIYFZxAxJ+b22oU+U2E97r6g=;
 b=CV9Zc+dlfCJWn5/UMpNUjW0om/EFavBPj2oaGUxvP5EkRrXUeVKle4CFy35H3WsdgKu6iaGJ
 sb6uuwJLSLlSuZrmEaVwTwehdLRlrMeOqzuybkinTGoX5a8NEo58CuLqi0jE5HVTCq0MbHqs
 p/QSWypX49+emR860I6pJMKf3Wc=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e017e9b.7f3277fc4b20-smtp-out-n03;
 Tue, 24 Dec 2019 02:57:31 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A8E68C43383; Tue, 24 Dec 2019 02:57:29 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: smasetty)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C5E8DC43383;
        Tue, 24 Dec 2019 02:57:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 24 Dec 2019 08:27:28 +0530
From:   smasetty@codeaurora.org
To:     Jordan Crouse <jcrouse@codeaurora.org>
Cc:     iommu@lists.linux-foundation.org, freedreno@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>, will@kernel.org,
        robin.murphy@arm.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Sean Paul <sean@poorly.run>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 5/5] drm/msm/a6xx: Support split pagetables
In-Reply-To: <1576514271-15687-6-git-send-email-jcrouse@codeaurora.org>
References: <1576514271-15687-1-git-send-email-jcrouse@codeaurora.org>
 <1576514271-15687-6-git-send-email-jcrouse@codeaurora.org>
Message-ID: <8aec2a4f74fede1cf616b9e2eece3e8e@codeaurora.org>
X-Sender: smasetty@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-16 22:07, Jordan Crouse wrote:
> Attempt to enable split pagetables if the arm-smmu driver supports it.
> This will move the default address space from the default region to
> the address range assigned to TTBR1. The behavior should be transparent
> to the driver for now but it gets the default buffers out of the way
> when we want to start swapping TTBR0 for context-specific pagetables.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
> 
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 52 
> ++++++++++++++++++++++++++++++++++-
>  1 file changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 5dc0b2c..1c6da93 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -811,6 +811,56 @@ static unsigned long a6xx_gpu_busy(struct msm_gpu 
> *gpu)
>  	return (unsigned long)busy_time;
>  }
> 
> +static struct msm_gem_address_space *
> +a6xx_create_address_space(struct msm_gpu *gpu, struct platform_device 
> *pdev)
> +{
> +	struct iommu_domain *iommu = iommu_domain_alloc(&platform_bus_type);
> +	struct msm_gem_address_space *aspace;
> +	struct msm_mmu *mmu;
> +	u64 start, size;
> +	u32 val = 1;
> +	int ret;
> +
> +	if (!iommu)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/*
> +	 * Try to request split pagetables - the request has to be made 
> before
> +	 * the domian is attached
> +	 */
> +	iommu_domain_set_attr(iommu, DOMAIN_ATTR_SPLIT_TABLES, &val);
> +
> +	mmu = msm_iommu_new(&pdev->dev, iommu);
> +	if (IS_ERR(mmu)) {
> +		iommu_domain_free(iommu);
> +		return ERR_CAST(mmu);
> +	}
> +
> +	/*
> +	 * After the domain is attached, see if the split tables were 
> actually
> +	 * successful.
> +	 */
> +	ret = iommu_domain_get_attr(iommu, DOMAIN_ATTR_SPLIT_TABLES, &val);
> +	if (!ret && val) {
> +		/*
> +		 * The aperture start will be at the beginning of the TTBR1
> +		 * space so use that as a base
> +		 */
> +		start = iommu->geometry.aperture_start;
> +		size = 0xffffffff;
This should be the va_end and not the size
> +	} else {
> +		/* Otherwise use the legacy 32 bit region */
> +		start = SZ_16M;
> +		size = 0xffffffff - SZ_16M;
same as above
> +	}
> +
> +	aspace = msm_gem_address_space_create(mmu, "gpu", start, size);
> +	if (IS_ERR(aspace))
> +		iommu_domain_free(iommu);
> +
> +	return aspace;
> +}
> +
>  static const struct adreno_gpu_funcs funcs = {
>  	.base = {
>  		.get_param = adreno_get_param,
> @@ -832,7 +882,7 @@ static const struct adreno_gpu_funcs funcs = {
>  #if defined(CONFIG_DRM_MSM_GPU_STATE)
>  		.gpu_state_get = a6xx_gpu_state_get,
>  		.gpu_state_put = a6xx_gpu_state_put,
> -		.create_address_space = adreno_iommu_create_address_space,
> +		.create_address_space = a6xx_create_address_space,
>  #endif
>  	},
>  	.get_timestamp = a6xx_get_timestamp,
