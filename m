Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B163DC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C058206C1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="k/gxraMc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbfHNRcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:32:01 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45203 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728487AbfHNRcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:32:01 -0400
Received: by mail-ed1-f67.google.com with SMTP id x19so104669087eda.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 10:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qm6tCEyYHljYJCx+l7YOn3eiOVSI2Q6xsqKk/Szr8xk=;
        b=k/gxraMcIYfFKbabTJ1uwZwJ8VES3yQLUNViHQMA+d1o/fXBUmn8Xlra/WXeXV9OK6
         oIRMcB4HXQV1z1V493ABRs1dndtGFVbP9eicDVkQRWohVqSbxdWxsF3LaxECADogDqgb
         PIOsIK/y/ZmlDZ6O+dGhdkqTrvL9DfZPgNEz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Qm6tCEyYHljYJCx+l7YOn3eiOVSI2Q6xsqKk/Szr8xk=;
        b=l5OtkinyNgJkwMcPhafJvBHDQgw/K1LeYF1vGBsfam9huA5LAlbfPmPLNtggZ4ixTp
         SIsumarloaqC6uviYI1tRAcRyW3vOe+UQilbQ1GfDPI8vnho85byLUD/Oz2htDlTCTO5
         76YTDujvd3Btg0cHd9nGljbaKWL3k7SIvKfT4bFTc+0LHUtGo3qiVfz52qd3HmFHywUb
         5mMHBMFlwJzgB/g4hVQSFQjOim1G5RPLcye4Sor4/6kGFJ81q3Uc1gH3X/O0fuAH/WQ/
         yDNpgTGDFpwVMZWK1Oz0ccFvAK7hOkAn9zeQ4XkVA9FOeevPZ3MFPmm+9pIWFI5R7hvV
         /5Gg==
X-Gm-Message-State: APjAAAVFadQpwtpy3pd5DKuHXjuJPIpwwlwp7oeI0ZCKdPnP6ZgBF3uZ
        /TJqaCdaCa42eEpVunimHTFFoQ==
X-Google-Smtp-Source: APXvYqwRn9v1KmyAl7iLql4TVsuC4BlSbySrQOJ2/+/4v8L1EDdXOOJ8MyXwatv64FQ4zcha8koF8Q==
X-Received: by 2002:aa7:c353:: with SMTP id j19mr858899edr.292.1565803918776;
        Wed, 14 Aug 2019 10:31:58 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id f6sm74361edn.63.2019.08.14.10.31.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 10:31:58 -0700 (PDT)
Date:   Wed, 14 Aug 2019 19:31:55 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Robert Chiras <robert.chiras@nxp.com>
Cc:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/15] drm/mxsfb: Fix the vblank events
Message-ID: <20190814173155.GR7444@phenom.ffwll.local>
Mail-Followup-To: Robert Chiras <robert.chiras@nxp.com>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1565779731-1300-1-git-send-email-robert.chiras@nxp.com>
 <1565779731-1300-8-git-send-email-robert.chiras@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565779731-1300-8-git-send-email-robert.chiras@nxp.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 01:48:43PM +0300, Robert Chiras wrote:
> Currently, the vblank support is not correctly implemented in MXSFB_DRM
> driver. The call to drm_vblank_init is made with mode_config.num_crtc
> which at that time is 0. Because of this, vblank is not activated, so
> there won't be any vblank event submitted.
> For example, when running modetest with the '-v' parameter will result
> in an astronomical refresh rate (10000+ Hz), because of that.

Uh, that sounds a bit like a bug somewhere. If vblank doesn't work, we
should give userspace an error back.

Maybe we need more checks in drm_vblank_init()? Can you pls look into
that?

> 
> Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
> ---
>  drivers/gpu/drm/mxsfb/mxsfb_drv.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> index 2743975..829abec 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> @@ -38,6 +38,9 @@
>  #include "mxsfb_drv.h"
>  #include "mxsfb_regs.h"
>  
> +/* The eLCDIF max possible CRTCs */
> +#define MAX_CRTCS 1
> +
>  enum mxsfb_devtype {
>  	MXSFB_V3,
>  	MXSFB_V4,
> @@ -138,6 +141,8 @@ static void mxsfb_pipe_enable(struct drm_simple_display_pipe *pipe,
>  		mxsfb->connector = &mxsfb->panel_connector;
>  	}
>  
> +	drm_crtc_vblank_on(&pipe->crtc);
> +
>  	pm_runtime_get_sync(drm->dev);
>  	drm_panel_prepare(mxsfb->panel);
>  	mxsfb_crtc_enable(mxsfb);
> @@ -164,6 +169,8 @@ static void mxsfb_pipe_disable(struct drm_simple_display_pipe *pipe)
>  	}
>  	spin_unlock_irq(&drm->event_lock);
>  
> +	drm_crtc_vblank_off(&pipe->crtc);
> +
>  	if (mxsfb->connector != &mxsfb->panel_connector)
>  		mxsfb->connector = NULL;
>  }
> @@ -246,7 +253,7 @@ static int mxsfb_load(struct drm_device *drm, unsigned long flags)
>  
>  	pm_runtime_enable(drm->dev);
>  
> -	ret = drm_vblank_init(drm, drm->mode_config.num_crtc);
> +	ret = drm_vblank_init(drm, MAX_CRTCS);
>  	if (ret < 0) {
>  		dev_err(drm->dev, "Failed to initialise vblank\n");
>  		goto err_vblank;
> @@ -269,6 +276,8 @@ static int mxsfb_load(struct drm_device *drm, unsigned long flags)
>  		goto err_vblank;
>  	}
>  
> +	drm_crtc_vblank_off(&mxsfb->pipe.crtc);

Are you sure you need this one here? vblanks should be off after
drm_vblank_init() is called.

Thanks, Daniel

> +
>  	/*
>  	 * Attach panel only if there is one.
>  	 * If there is no panel attach, it must be a bridge. In this case, we
> -- 
> 2.7.4
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
