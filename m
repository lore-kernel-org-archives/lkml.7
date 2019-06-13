Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07327C31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA69A21721
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="CNPZ9BSa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731782AbfFMQbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:31:50 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41294 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730865AbfFMIVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:21:52 -0400
Received: by mail-ed1-f65.google.com with SMTP id p15so29927377eds.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 01:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=/5Q5aUaRAcEEPNriaL09NE2LBrtuC+UfFWkB6hD3AL0=;
        b=CNPZ9BSaAlskYq9oJPK3nw+RHvlOS+kmhCaPVmRqdv2KGR7tiu8aOdrFbya1btWYrV
         /LL4gCUeCIqqlSTrQRyon/4otVWW808zDERPOuLa1zZ/UvAr46hYZgQ5D+TFonXqs0e5
         6FRikD9geEaT5shYlUm40D03a+O3W7C6AcYwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=/5Q5aUaRAcEEPNriaL09NE2LBrtuC+UfFWkB6hD3AL0=;
        b=OuRrZmrY6OGj6TzpY1rK/PztSonddOSzDsINl9yHBQ8WFXVfejBfLLrmXdSNpurAyY
         nvhSmht3LzhFKtfgICnX6q1+mTHmnYz66zdoyk4MlQp08zVGi7ENS7lCP8MzmGJEhO6Z
         XzILWKWQtmtgLSSyuQrb/zQfINU/fbeq6QC/2hqbntt86dtxztOwLcCzDXl/6OG3zKks
         5gbo1hE2kF3CKXTAijS+vLgP8XtSQQFh9fSHqd8OP+Y2GIbsjpFoxg/33tMirbJ2xcMG
         V++YASkZshgj7JT5pwrqNEyXtTtRZZIG3qtJD6V4nvxExQFJosvmMkuCOBkU9Pg8aKHx
         zzig==
X-Gm-Message-State: APjAAAWm4uOfxd1FR5pcxwW7cGvPrFS2njLbGBm2BFpLcLSi8cdL1/AX
        01xNmlLPRcAiXwCSLw/5goQw+Q==
X-Google-Smtp-Source: APXvYqyuHNHI3b36rm4k6jVjf5YQ4S6ebCAH64O/yrmvhY4OJMhpcxY3jnmxNU5QJu6XRHEVCYxqiw==
X-Received: by 2002:a50:97c8:: with SMTP id f8mr45283000edb.176.1560414110413;
        Thu, 13 Jun 2019 01:21:50 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id z10sm684614edl.35.2019.06.13.01.21.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 01:21:49 -0700 (PDT)
Date:   Thu, 13 Jun 2019 10:21:47 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: [RESEND PATCH V3] drm/drm_vblank: Change EINVAL by the correct
 errno
Message-ID: <20190613082147.GG23020@phenom.ffwll.local>
Mail-Followup-To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, intel-gfx@lists.freedesktop.org
References: <20190613021054.cdewdb3azy6zuoyw@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190613021054.cdewdb3azy6zuoyw@smtp.gmail.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 11:10:54PM -0300, Rodrigo Siqueira wrote:
> For historical reason, the function drm_wait_vblank_ioctl always return
> -EINVAL if something gets wrong. This scenario limits the flexibility
> for the userspace make detailed verification of the problem and take
> some action. In particular, the validation of “if (!dev->irq_enabled)”
> in the drm_wait_vblank_ioctl is responsible for checking if the driver
> support vblank or not. If the driver does not support VBlank, the
> function drm_wait_vblank_ioctl returns EINVAL which does not represent
> the real issue; this patch changes this behavior by return EOPNOTSUPP.
> Additionally, some operations are unsupported by this function, and
> returns EINVAL; this patch also changes the return value to EOPNOTSUPP
> in this case. Lastly, the function drm_wait_vblank_ioctl is invoked by
> libdrm, which is used by many compositors; because of this, it is
> important to check if this change breaks any compositor. In this sense,
> the following projects were examined:
> 
> * Drm-hwcomposer
> * Kwin
> * Sway
> * Wlroots
> * Wayland-core
> * Weston
> * Xorg (67 different drivers)
> 
> For each repository the verification happened in three steps:
> 
> * Update the main branch
> * Look for any occurrence "drmWaitVBlank" with the command:
>   git grep -n "drmWaitVBlank"
> * Look in the git history of the project with the command:
>   git log -SdrmWaitVBlank
> 
> Finally, none of the above projects validate the use of EINVAL which
> make safe, at least for these projects, to change the return values.
> 
> Change since V2:
>  Daniel Vetter and Chris Wilson
>  - Replace ENOTTY by EOPNOTSUPP
>  - Return EINVAL if the parameters are wrong
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> ---
> Update:
>   Now IGT has a way to validate if a driver has vblank support or not.
>   See: https://gitlab.freedesktop.org/drm/igt-gpu-tools/commit/2d244aed69165753f3adbbd6468db073dc1acf9A
> 
>  drivers/gpu/drm/drm_vblank.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index 0d704bddb1a6..d76a783a7d4b 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -1578,10 +1578,10 @@ int drm_wait_vblank_ioctl(struct drm_device *dev, void *data,
>  	unsigned int flags, pipe, high_pipe;
>  
>  	if (!dev->irq_enabled)
> -		return -EINVAL;
> +		return -EOPNOTSUPP;
>  
>  	if (vblwait->request.type & _DRM_VBLANK_SIGNAL)
> -		return -EINVAL;
> +		return -EOPNOTSUPP;

Not sure we want EINVAL here, that's kinda a "parameters are wrong"
version too. With that changed:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

>  
>  	if (vblwait->request.type &
>  	    ~(_DRM_VBLANK_TYPES_MASK | _DRM_VBLANK_FLAGS_MASK |
> -- 
> 2.21.0



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
