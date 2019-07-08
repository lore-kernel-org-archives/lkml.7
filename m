Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8B3C606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7754E20693
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CfLjv4t9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391515AbfGHQKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 12:10:31 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34342 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729062AbfGHQKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 12:10:30 -0400
Received: by mail-pl1-f196.google.com with SMTP id i2so8528296plt.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 09:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fDCoSY5K0ITJqQYvscwo5UxJiyuZc3RyIH7jJSLU88U=;
        b=CfLjv4t9r4Kg2mSofS2nlQZMto3UY4mstJJjBcy91IFpxTd6+xOv3VwdVLcgFVUdVW
         j5PVsTuIkjKvjex7sWx70GltkB3B71Am79TnP0MeO+ihAkpGOpOQDafpfMi9i7wnEUUH
         3OHP5VEf+64cy0LL8hikc/pn1wZ/KR2jge1woKA5a6tL1EGf27T4yOG48LdVyh8xewdi
         4/+ddMjgJKskc5Ivy46J/G5z+QyT2ZWcf3TxK2wuJqimj0xykazxXmlcv65ZFjE1aIJl
         TYa/I2day1zmNig/jiZU9ScLfIp2yEcPl0pav2+YEs06oGpQ0n42my45uw5pfHQBvory
         TtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fDCoSY5K0ITJqQYvscwo5UxJiyuZc3RyIH7jJSLU88U=;
        b=I7khg/GI/UATsDsH6/K6O76bSW4qAVrIJNO67SrPyEdCT5XGPkiNAiow8vYojAxnXJ
         qO5BArPFqyYrcgBGtwG3GB2yfufcOgExSieF+QULikAACC/F9y5Yzz5/pK84KCx9NQTE
         641W/AcZtbt15e24FTP3lxvDde5HrtqgK6jltAOKKt2zOoV6NdjZrh9kgigWVi0KwGCI
         Oq1C4smCAa8fWEuV1saOkSp7DAET4KQMpmivrKmTuWTZ0m/8A3tUIdeRYMVJI/vnvYbN
         90DDMjRkuWthkbuYGcWdUAGlw4ZHLrqViJZ+59BV7d75FnDkrRXfeL1n14a2XZjR5dSo
         TW9A==
X-Gm-Message-State: APjAAAXgfOkIS/kVlICRhuF9A60yndEXS2jHiaM1svoCLsolsjdqnpXC
        nGUb6Awh/lAvc7dO3iUoigm/1g==
X-Google-Smtp-Source: APXvYqzD1aivQBDf69llf3avbBHNfxtRkZ9eXNatyrc78REwbz16rreOTstsv5QqjSoYFjtGpjbuhQ==
X-Received: by 2002:a17:902:4623:: with SMTP id o32mr25633974pld.112.1562602229878;
        Mon, 08 Jul 2019 09:10:29 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j20sm5476488pfr.113.2019.07.08.09.10.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jul 2019 09:10:29 -0700 (PDT)
Date:   Mon, 8 Jul 2019 09:10:26 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     robdclark@gmail.com, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/msm/mdp5: Find correct node for creating gem
 address space
Message-ID: <20190708161026.GB27383@builder>
References: <20190708151224.22555-1-jeffrey.l.hugo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708151224.22555-1-jeffrey.l.hugo@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 08 Jul 08:12 PDT 2019, Jeffrey Hugo wrote:

> Creating the msm gem address space requires a reference to the dev where
> the iommu is located.  The driver currently assumes this is the same as
> the platform device, which breaks when the iommu is outside of the
> platform device (ie in the parent).  Default to using the platform device,
> but check to see if that has an iommu reference, and if not, use the parent
> device instead.  This should handle all the various iommu designs for
> mdp5 supported systems.
> 
> Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>

Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
> 
> v2: It turns out there isn't a universal way to get the iommu device, so 
> check to see if its in the current node or parent
> 
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
> index 4a60f5fca6b0..02dc7d426cb0 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
> @@ -663,6 +663,7 @@ struct msm_kms *mdp5_kms_init(struct drm_device *dev)
>  	struct msm_kms *kms;
>  	struct msm_gem_address_space *aspace;
>  	int irq, i, ret;
> +	struct device *iommu_dev;
>  
>  	/* priv->kms would have been populated by the MDP5 driver */
>  	kms = priv->kms;
> @@ -702,7 +703,11 @@ struct msm_kms *mdp5_kms_init(struct drm_device *dev)
>  	mdelay(16);
>  
>  	if (config->platform.iommu) {
> -		aspace = msm_gem_address_space_create(&pdev->dev,
> +		iommu_dev = &pdev->dev;
> +		if (!iommu_dev->iommu_fwspec)
> +			iommu_dev = iommu_dev->parent;
> +
> +		aspace = msm_gem_address_space_create(iommu_dev,
>  				config->platform.iommu, "mdp5");
>  		if (IS_ERR(aspace)) {
>  			ret = PTR_ERR(aspace);
> -- 
> 2.17.1
> 
