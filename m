Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CE9C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 07:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03FC422B48
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 07:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eCzo+pmZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfLLHMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 02:12:53 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43547 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728037AbfLLHMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 02:12:52 -0500
Received: by mail-pl1-f196.google.com with SMTP id p27so186066pli.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 23:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pzvbMvksIeRzLHPUfhZRb4G8rwpYHOZcVb2OFZ2VjU8=;
        b=eCzo+pmZKR5fF8dArzFSpVmbtK2mtqqm2VaPcm+gaRkpR/ZakpY0oYFCIoXxrVRtyE
         jrnXFQbzkJaEkUP0w3W8J2UChgLC/5xQL8hY/DeTGMm6DhFdhlizzl6zfEZdO/R6jeEn
         KtN7WfSco0VkklnCT23TppkBkj4Hc1+0HCdo2PpbuvKI7V1VNbaS5ktns9B82xB6BOBk
         vYyXQPl2iXB7LQsVbXqBBBTVPoAz5hTxYkOuUOeq6ncLbM7S3nfcmT/CKvLKlQMnR7pn
         lGBJCqyjAnw6/WRUYxXnBxdjgB7E+w0Ka6Pl+1EeU4nN+h77R5hmSaRAGQ0Yb1AzBz/p
         RpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pzvbMvksIeRzLHPUfhZRb4G8rwpYHOZcVb2OFZ2VjU8=;
        b=ZdX+wbylGIkRjGK5vp4bNRyLbbc4EGE+7M9dDSwHHBd+XOuDtGjsEBiXNq2IUOE44d
         TOafYZNuXzQcGpUVJTOWORbuZzmj1PBgKKClLjpvmllsB/nooD7wCmd7rCW7LwaKy/YS
         TSA80e4JlhO1SZQh1fPz78aYbW4wVcp68ej0TZDTI1dVNCWDnph3+QXsu4SOXcJTicue
         suLJT8F28HuVAGzfXT7ADVxWTbagcT7OZNVoVRnFoNT/noPlRupnJimWooGvOJYaUgV2
         1E1ADFNJT2vDEzEJDeo58wWV741b81iTrY5cRdcdOL9hRvOzP1qVHXKLRzmcwW8+iK3c
         ME2w==
X-Gm-Message-State: APjAAAUG6g3PC5Kl6PWK4f5JLE+WE3CY+qjtSNoTZ1Rly5xR4ky5H/AO
        +w816y+7KqUKC945C/ptizcwxQ==
X-Google-Smtp-Source: APXvYqyNNjHa/A1b0Jzbj51OTA3nttYn3rIvaHSHmyfvgctwgTKy97oy1R+YT+wxbc1PEjgqYkUidg==
X-Received: by 2002:a17:90a:20aa:: with SMTP id f39mr8401328pjg.35.1576134771826;
        Wed, 11 Dec 2019 23:12:51 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id e7sm5610222pfe.168.2019.12.11.23.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 23:12:51 -0800 (PST)
Date:   Wed, 11 Dec 2019 23:12:48 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     robdclark@gmail.com, sean@poorly.run, robh+dt@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, jcrouse@codeaurora.org,
        dianders@chromium.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/4] drm/msm/gpu: add support for ocmem interconnect
 path
Message-ID: <20191212071248.GK3143381@builder>
References: <20191122012645.7430-1-masneyb@onstation.org>
 <20191122012645.7430-3-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122012645.7430-3-masneyb@onstation.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 21 Nov 17:26 PST 2019, Brian Masney wrote:

> Some A3xx and all A4xx Adreno GPUs do not have GMEM inside the GPU core
> and must use the On Chip MEMory (OCMEM) in order to be functional.
> There's a separate interconnect path that needs to be setup to OCMEM.
> Add support for this second path to the GPU core.
> 
> In the downstream MSM 3.4 sources, the two interconnect paths for the
> GPU are between:
> 
>   - MSM_BUS_MASTER_GRAPHICS_3D and MSM_BUS_SLAVE_EBI_CH0
>   - MSM_BUS_MASTER_V_OCMEM_GFX3D and MSM_BUS_SLAVE_OCMEM
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 14 +++++++++++++-
>  drivers/gpu/drm/msm/msm_gpu.h           |  7 +++++++
>  2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index 0783e4b5486a..d27bdc999777 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -887,10 +887,21 @@ static int adreno_get_pwrlevels(struct device *dev,
>  	DBG("fast_rate=%u, slow_rate=27000000", gpu->fast_rate);
>  
>  	/* Check for an interconnect path for the bus */
> -	gpu->icc_path = of_icc_get(dev, NULL);
> +	gpu->icc_path = of_icc_get(dev, "gfx-mem");
> +	if (!gpu->icc_path) {
> +		/*
> +		 * Keep compatbility with device trees that don't have an
> +		 * interconnect-names property.
> +		 */
> +		gpu->icc_path = of_icc_get(dev, NULL);
> +	}
>  	if (IS_ERR(gpu->icc_path))
>  		gpu->icc_path = NULL;
>  
> +	gpu->ocmem_icc_path = of_icc_get(dev, "ocmem");
> +	if (IS_ERR(gpu->ocmem_icc_path))
> +		gpu->ocmem_icc_path = NULL;
> +
>  	return 0;
>  }
>  
> @@ -977,6 +988,7 @@ void adreno_gpu_cleanup(struct adreno_gpu *adreno_gpu)
>  		release_firmware(adreno_gpu->fw[i]);
>  
>  	icc_put(gpu->icc_path);
> +	icc_put(gpu->ocmem_icc_path);
>  
>  	msm_gpu_cleanup(&adreno_gpu->base);
>  }
> diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
> index ab8f0f9c9dc8..be5bc2e8425c 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.h
> +++ b/drivers/gpu/drm/msm/msm_gpu.h
> @@ -111,8 +111,15 @@ struct msm_gpu {
>  	struct clk *ebi1_clk, *core_clk, *rbbmtimer_clk;
>  	uint32_t fast_rate;
>  
> +	/* The gfx-mem interconnect path that's used by all GPU types. */
>  	struct icc_path *icc_path;
>  
> +	/*
> +	 * Second interconnect path for some A3xx and all A4xx GPUs to the
> +	 * On Chip MEMory (OCMEM).
> +	 */
> +	struct icc_path *ocmem_icc_path;
> +
>  	/* Hang and Inactivity Detection:
>  	 */
>  #define DRM_MSM_INACTIVE_PERIOD   66 /* in ms (roughly four frames) */
> -- 
> 2.21.0
> 
