Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31B0C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 04:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB0E21897
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 04:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yWOqH74l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfIDENu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 00:13:50 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42731 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfIDENu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 00:13:50 -0400
Received: by mail-pg1-f195.google.com with SMTP id p3so10457622pgb.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 21:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TKDcz9GEkq0+jTlX4XnG4MmP4DXsoB8ism0APIW6WXQ=;
        b=yWOqH74lTdL0xzn4KduFkFnfeuA6TxebZ/0lcsCSU6TfvfB33BHb5+UZKjrmx2xZfV
         z0mXE7FbdS+QTb/+X7UZTIi+dJTTpvNrStE+qGpoEIEUf/dEB3ISiDvaUraBduJnXLyN
         b09D5OMsvfI/eJIeAJE+aKgcVJnQMRsHiwQglRNZBi28wdsnRUzCmNPN7QaKe9KLl5cI
         fUTHUJIi9n/VgDgtEEk5ESV1R0hBDldBsD0vrE+C+7o5ET0/PLDGcVMfVC1qTcMtQE/+
         efYWZIJUuS+hD9bIcAdP1/FiLg0O635PzhAKlf8wDH/sgN7065DKKRjDMr1+1WBdv7XZ
         ORvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TKDcz9GEkq0+jTlX4XnG4MmP4DXsoB8ism0APIW6WXQ=;
        b=jO8GkS7O+ZsTkGiCIKXhQCHRP5UM0POZ+bnWhHLQd58tC1U/YIb7UyZa35uhOwX0/z
         2C4TiwcBJkhlfuui8/FffsF8P2S4nliDsJ3NRiG7/cDugn5a52Ah5ocZaJlJv8I+6dH+
         qVBaXQqoEesPOxOvnZchlcrNLAe7HX5DQ5iiW0/65dgg8piVymX9HIBiqp7wUf47/MoO
         I3LAOqNo3nCUHTNgrZTG10ntN4onSp22OaiAouZnJpxFrCF5626HYoez1SApCO2PmnOR
         0PemGPcacnN2Cau7afdVndU7kVSsIVnUw5bI4ZumzwHau87aoxEzHUkl8Kk78plp/HeP
         C7xQ==
X-Gm-Message-State: APjAAAUXwX2WsqjbD5BFUEaoTwhjVbmjw4xcUV5cXUo6dGoqLQf4syjq
        H5bt9wCyQpsyoHhm8pp/xvaPfg==
X-Google-Smtp-Source: APXvYqxsqJ3hNQRFq3ixeUtG46LHLPaeaxAQsBMx89pzwZF3ApMq4oZQvbEinaPSdK7PfwqTN14bVQ==
X-Received: by 2002:a63:550e:: with SMTP id j14mr29867505pgb.302.1567570429722;
        Tue, 03 Sep 2019 21:13:49 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b126sm21458534pfb.110.2019.09.03.21.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 21:13:49 -0700 (PDT)
Date:   Tue, 3 Sep 2019 21:13:46 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Denis Efremov <efremov@linux.com>
Cc:     linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 02/11] drm/msm: remove unlikely() from WARN_ON()
 conditions
Message-ID: <20190904041346.GB3081@tuxbook-pro>
References: <20190829165025.15750-1-efremov@linux.com>
 <20190829165025.15750-2-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829165025.15750-2-efremov@linux.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 29 Aug 09:50 PDT 2019, Denis Efremov wrote:

> "unlikely(WARN_ON(x))" is excessive. WARN_ON() already uses unlikely()
> internally.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: Joe Perches <joe@perches.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_ctl.c | 4 ++--
>  drivers/gpu/drm/msm/disp/mdp_format.c    | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_ctl.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_ctl.c
> index 4804cf40de14..030279d7b64b 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_ctl.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_ctl.c
> @@ -253,7 +253,7 @@ int mdp5_ctl_set_cursor(struct mdp5_ctl *ctl, struct mdp5_pipeline *pipeline,
>  	u32 blend_cfg;
>  	struct mdp5_hw_mixer *mixer = pipeline->mixer;
>  
> -	if (unlikely(WARN_ON(!mixer))) {
> +	if (WARN_ON(!mixer)) {
>  		DRM_DEV_ERROR(ctl_mgr->dev->dev, "CTL %d cannot find LM",
>  			ctl->id);
>  		return -EINVAL;
> @@ -695,7 +695,7 @@ struct mdp5_ctl_manager *mdp5_ctlm_init(struct drm_device *dev,
>  		goto fail;
>  	}
>  
> -	if (unlikely(WARN_ON(ctl_cfg->count > MAX_CTL))) {
> +	if (WARN_ON(ctl_cfg->count > MAX_CTL)) {
>  		DRM_DEV_ERROR(dev->dev, "Increase static pool size to at least %d\n",
>  				ctl_cfg->count);
>  		ret = -ENOSPC;
> diff --git a/drivers/gpu/drm/msm/disp/mdp_format.c b/drivers/gpu/drm/msm/disp/mdp_format.c
> index 8afb0f9c04bb..5495d8b3f5b9 100644
> --- a/drivers/gpu/drm/msm/disp/mdp_format.c
> +++ b/drivers/gpu/drm/msm/disp/mdp_format.c
> @@ -174,7 +174,7 @@ const struct msm_format *mdp_get_format(struct msm_kms *kms, uint32_t format,
>  
>  struct csc_cfg *mdp_get_default_csc_cfg(enum csc_type type)
>  {
> -	if (unlikely(WARN_ON(type >= CSC_MAX)))
> +	if (WARN_ON(type >= CSC_MAX))
>  		return NULL;
>  
>  	return &csc_convert[type];
> -- 
> 2.21.0
> 
