Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1251FC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF63620B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407106AbfHIQpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 12:45:42 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:59504 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406412AbfHIQpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 12:45:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 2B1D1FB03;
        Fri,  9 Aug 2019 18:45:40 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zG0agjQGW3tZ; Fri,  9 Aug 2019 18:45:38 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id BDFB241D9E; Fri,  9 Aug 2019 18:45:37 +0200 (CEST)
Date:   Fri, 9 Aug 2019 18:45:37 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Ville Baillie <vmbaillie@googlemail.com>
Cc:     marex@denx.de, stefan@agner.ch, airlied@linux.ie, daniel@ffwll.ch,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Robert Chiras <robert.chiras@nxp.com>
Subject: Re: [PATCH] mxsfb: allow attachment of display bridges
Message-ID: <20190809164537.GA4212@bogon.m.sigxcpu.org>
References: <20190801111853.GA24574@villeb-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801111853.GA24574@villeb-dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Thu, Aug 01, 2019 at 11:18:53AM +0000, Ville Baillie wrote:
> ---
>  drivers/gpu/drm/mxsfb/mxsfb_drv.c | 20 ++++++++++++++++----
>  drivers/gpu/drm/mxsfb/mxsfb_drv.h |  1 +
>  drivers/gpu/drm/mxsfb/mxsfb_out.c | 14 +++++++++++---
>  3 files changed, 28 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> index 6fafc90da4ec..c19a7b7aa3a6 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> @@ -229,10 +229,22 @@ static int mxsfb_load(struct drm_device *drm, unsigned long flags)
>  		goto err_vblank;
>  	}
>  
> -	ret = drm_panel_attach(mxsfb->panel, &mxsfb->connector);
> -	if (ret) {
> -		dev_err(drm->dev, "Cannot connect panel\n");
> -		goto err_vblank;
> +	if (mxsfb->panel) {
> +		ret = drm_panel_attach(mxsfb->panel, &mxsfb->connector);
> +		if (ret) {
> +			dev_err(drm->dev, "Cannot connect panel\n");
> +			goto err_vblank;
> +		}
> +	} else if (mxsfb->bridge) {
> +		ret = drm_bridge_attach(&mxsfb->pipe.encoder, mxsfb->bridge,
> +				NULL);
> +		if (ret) {
> +			dev_err(drm->dev, "Cannot connect bridge\n");
> +			goto err_vblank;
> +		}
> +	} else {
> +		dev_err(drm->dev, "No panel or bridge\n");
> +		return -EINVAL;
>  	}
>  
>  	drm->mode_config.min_width	= MXSFB_MIN_XRES;
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.h b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
> index d975300dca05..436fe4bbb47a 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.h
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
> @@ -29,6 +29,7 @@ struct mxsfb_drm_private {
>  	struct drm_simple_display_pipe	pipe;
>  	struct drm_connector		connector;
>  	struct drm_panel		*panel;
> +	struct drm_bridge		*bridge;
>  };
>  
>  int mxsfb_setup_crtc(struct drm_device *dev);
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_out.c b/drivers/gpu/drm/mxsfb/mxsfb_out.c
> index 91e76f9cead6..77e03eb0fca6 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_out.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_out.c
> @@ -78,9 +78,11 @@ int mxsfb_create_output(struct drm_device *drm)
>  {
>  	struct mxsfb_drm_private *mxsfb = drm->dev_private;
>  	struct drm_panel *panel;
> +	struct drm_bridge *bridge;
>  	int ret;
>  
> -	ret = drm_of_find_panel_or_bridge(drm->dev->of_node, 0, 0, &panel, NULL);
> +	ret = drm_of_find_panel_or_bridge(drm->dev->of_node, 0, 0, &panel,
> +			&bridge);
>  	if (ret)
>  		return ret;
>  
> @@ -91,8 +93,14 @@ int mxsfb_create_output(struct drm_device *drm)
>  	ret = drm_connector_init(drm, &mxsfb->connector,
>  				 &mxsfb_panel_connector_funcs,
>  				 DRM_MODE_CONNECTOR_Unknown);
> -	if (!ret)
> -		mxsfb->panel = panel;
> +	if (!ret) {
> +		if (panel)
> +			mxsfb->panel = panel;
> +		else if (bridge)
> +			mxsfb->bridge = bridge;
> +		else
> +			return -EINVAL;
> +	}
>  
>  	return ret;
>  }
> -- 
> 2.17.1

Robert Chiras posted bridge support for mxsfb back in June:

    https://patchwork.freedesktop.org/patch/314430/?series=62822&rev=1

Cheers,
 -- Guido

> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
