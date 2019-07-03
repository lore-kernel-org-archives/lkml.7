Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D741AC06511
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 04:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01C22089C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 04:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="thNW3ICb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbfGCEIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 00:08:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44073 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfGCEIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 00:08:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so468791pgl.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 21:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BOHEn0gshPaD156fAbU+LPgYeovu+KLC6H+rqvqrtq4=;
        b=thNW3ICbdgjo5v4OnrHC8HngYpGdmRrbNHaD/DbS92CXxHGPR59WaqhuwSzFyBYThW
         eeip6X5FJ/8DmwPxp53o5qXeCuYst0A/0fKVm9p/ZJJgreL8Mnl7RsLZssD700+4Lgnx
         BFm4LqDqLsjM7uO/1d7j0A/0n4CcW2Uy8o1oVQgj8vwuTyZDvN/IuUWC2a90f4NZkUIX
         5gV5QvPA6NVOeNYPJ107ElYM3bm60jG6d9vecux/YZBBMJeS9ixnOJ6J/qa4DnT9MOgK
         lWlLiZfrNmxIZZb/zvT7kyuNBfFtZqeFaXtcsCkZtrZy1wxGxLBMb2p6cPC4Y+wikg4x
         bM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BOHEn0gshPaD156fAbU+LPgYeovu+KLC6H+rqvqrtq4=;
        b=r9fRvVxkWzJTV/5oXzbtaR5VVB0dfsPlFAvzxagqIDWZUb5oCvUyOgDYAVKUq7p9vB
         IC+DsUO083A47qBCUsyZr3oX2Cg6Jfi83c5pw1D/ssTMpawvcVwJTAdKWy5RRzKVTXgZ
         mAIySAK2mh59MbZEtLofZHyhyvg1wkk6L6jvPoVDsgkMTkFaZ6vO9Q52VRlr8XdsTvAX
         IUp1TXHsEDEdw0uAmkDqzT4E2V3S3paYmyE58dDo1e6ynmi0N3IDbFYTRIAfs9eR+udf
         zxfQ7119VER44qTcHK2FQ9LdrUejw+lDoD1tyUNwcN/j8e02XQg0gjx0KY7eybUP2QC5
         GC1Q==
X-Gm-Message-State: APjAAAVTzQmbgVY5fjy3+J39vqeEGGIJ5jZ8jOza3amWs+E8gBDtBD7p
        eaNO7nh+WZyb6YwiO8gR7YvXiQ==
X-Google-Smtp-Source: APXvYqxQq8cU5yTVEx60W1ue5LxeoHrpQ3mjFnp+R6PN/s26w0eINwgwrUDi2TCCpBgj2P6m9+w4ig==
X-Received: by 2002:a65:44c8:: with SMTP id g8mr34199417pgs.443.1562126926314;
        Tue, 02 Jul 2019 21:08:46 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id f2sm563251pgs.83.2019.07.02.21.08.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jul 2019 21:08:45 -0700 (PDT)
Date:   Tue, 2 Jul 2019 21:08:43 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     robdclark@gmail.com, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/mdp5: Use drm_device for creating gem address
 space
Message-ID: <20190703040843.GA27383@builder>
References: <20190701173907.15494-1-jeffrey.l.hugo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701173907.15494-1-jeffrey.l.hugo@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 01 Jul 10:39 PDT 2019, Jeffrey Hugo wrote:

> Creating the msm gem address space requires a reference to the dev where
> the iommu is located.  The driver currently assumes this is the same as
> the platform device, which breaks when the iommu is outside of the
> platform device.  Use the drm_device instead, which happens to always have
> a reference to the proper device.
> 
> Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>

Sorry, but on db820c this patch results in:

[   64.803263] msm_mdp 901000.mdp: [drm:mdp5_kms_init [msm]] *ERROR* failed to attach iommu: -19

Followed by 3 oopses as we're trying to fail the initialization.

Regards,
Bjorn

> ---
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
> index 4a60f5fca6b0..1347a5223918 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
> @@ -702,7 +702,7 @@ struct msm_kms *mdp5_kms_init(struct drm_device *dev)
>  	mdelay(16);
>  
>  	if (config->platform.iommu) {
> -		aspace = msm_gem_address_space_create(&pdev->dev,
> +		aspace = msm_gem_address_space_create(dev->dev,
>  				config->platform.iommu, "mdp5");
>  		if (IS_ERR(aspace)) {
>  			ret = PTR_ERR(aspace);
> -- 
> 2.17.1
> 
