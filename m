Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50A2C004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 16:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7294720645
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 16:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p4961rDh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfEAQvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 12:51:16 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45538 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfEAQvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 12:51:15 -0400
Received: by mail-pf1-f195.google.com with SMTP id e24so8839221pfi.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 09:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Kd5MuO+17SSO78jER84yawU/+kS4c+qH+M/4Z95iLNY=;
        b=p4961rDhAAkYdVL2MmCqcSFfDmoIe5vhA3cShJh7egp3Eb4kLmL2sB5jcTZBT1bBrs
         X2UUpPkwn29f2c9UAdFVjJrMkV/aK/zL0MDk5lw3aYKNt8+QE8TalXcEbVeApDAU7UpH
         c/g+s2N/Ee/n2VFwIgnhu9W8R9Ope8RnBjoUlC04/UVVNRV/DsvA60nM2TVkJcPgPPBn
         0NuLBjuj6N2yXocjsMpPtUk0uZ2h6lEVZZCL6NhHgemzzc6Y0KboxPCTpXRsyjpqwnkO
         9Fb6NIX/Wne6nx8wc6NGWcfcJ8cX/arFAHndFz2zwEoeHM97MNQ6pXGTfWQ6ddBRLQBq
         9foA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kd5MuO+17SSO78jER84yawU/+kS4c+qH+M/4Z95iLNY=;
        b=ZJDGVuFwCVoahBJf6CqXXMReaq4mbkO3lbPJ4N+yVDcbCITuOLeqOp9CGabHb4U817
         +XyijEj0VPOqCDMpcvA0WbvT9eKJ3scS/0QeN/6mMHtiTaEs+2dLNkznlulFQITeOmmF
         NlBgqgnsQAQJb02XTmC/3bcOOqaWcZZtSh3hNtEJnOB6O422j3MhEuamm38o/0OUIJC+
         0PJDUSRzGyBF5mYwQkgKUvJc2II03LyHdXBJqWX4+oQ6lhrAsKxOJgYZl/fA9XnHCZ0g
         EZmni+7jCcWsL7GhF21IEh0RSQUTSjzlfuxwHZPb/dvEcTFFN+IA4TU59/AhflYEY/xd
         +T7g==
X-Gm-Message-State: APjAAAUebZ5r5+wZswhfaJLxCx/PJw3VwF9MwmszakorCt9QtaKVTM1R
        JRhl38qtySWruu93OTxncDtOqw==
X-Google-Smtp-Source: APXvYqwTaF3lkS2xcbZsYzpMTkI1G6dbKWjh7tN8qOSRuhSBT3G0ZPf6rYTURl8olJfGXJ2vBQZtGw==
X-Received: by 2002:a65:6145:: with SMTP id o5mr17411677pgv.262.1556729474737;
        Wed, 01 May 2019 09:51:14 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 18sm58777799pfp.18.2019.05.01.09.51.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 09:51:13 -0700 (PDT)
Date:   Wed, 1 May 2019 09:51:15 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     robdclark@gmail.com, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/mdp5: Fix mdp5_cfg_init error return
Message-ID: <20190501165115.GH2938@tuxbook-pro>
References: <20190501161437.15728-1-jeffrey.l.hugo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501161437.15728-1-jeffrey.l.hugo@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 01 May 09:14 PDT 2019, Jeffrey Hugo wrote:

> If mdp5_cfg_init fails because of an unknown major version, a null pointer
> dereference occurs.  This is because the caller of init expects error
> pointers, but init returns NULL on error.  Fix this by returning the
> expected values on error.
> 
> Fixes: 2e362e1772b8 (drm/msm/mdp5: introduce mdp5_cfg module)

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
> ---
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
> index ea8f7d7daf7f..52e23780fce1 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
> @@ -721,7 +721,7 @@ struct mdp5_cfg_handler *mdp5_cfg_init(struct mdp5_kms *mdp5_kms,
>  	if (cfg_handler)
>  		mdp5_cfg_destroy(cfg_handler);
>  
> -	return NULL;
> +	return ERR_PTR(ret);
>  }
>  
>  static struct mdp5_cfg_platform *mdp5_get_config(struct platform_device *dev)
> -- 
> 2.17.1
> 
