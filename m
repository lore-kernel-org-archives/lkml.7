Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDE5ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 20:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A9B2089C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 20:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="gBYlwscW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732822AbfJNUXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 16:23:24 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:59732 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729667AbfJNUXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 16:23:24 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 2994A5C1173;
        Mon, 14 Oct 2019 22:23:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1571084600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P+rXe5gqDkpR/ocxB4jA4wn6gLVIHyh3cCV/a77qceY=;
        b=gBYlwscWUPHbKxkp6VSFsPahfglZNpR4LUY6VaSqswdF2KOS+4LpuZzGSDbS6X177L3Byp
        sD0yyz/kS2E1E2R0cmXu7Dy00K2WcXMtPucfckKM7ljgYofFzsZw3NYO/9M4EMryccoah+
        IhBToOeeVVxL61+x9+heWTnHJ2wRysk=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date:   Mon, 14 Oct 2019 22:23:20 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Robert Chiras <robert.chiras@nxp.com>
Cc:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Marek Vasut <marex@denx.de>, David Airlie <airlied@linux.ie>,
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
Subject: Re: [PATCH v4 01/14] drm/mxsfb: Update mxsfb to support a bridge
In-Reply-To: <1567078215-31601-2-git-send-email-robert.chiras@nxp.com>
References: <1567078215-31601-1-git-send-email-robert.chiras@nxp.com>
 <1567078215-31601-2-git-send-email-robert.chiras@nxp.com>
Message-ID: <4138bd0cea847abb60888a50236c2aa4@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-29 13:30, Robert Chiras wrote:
> Currently, the MXSFB DRM driver only supports a panel. But, its output
> display signal can also be redirected to another encoder, like a DSI
> controller. In this case, that DSI controller may act like a drm_bridge.
> In order support this use-case too, this patch adds support for drm_bridge
> in mxsfb.
> 
> Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
> Tested-by: Guido Günther <agx@sigxcpu.org>

Applied to the drm-misc-next branch.

--
Stefan

> ---
>  drivers/gpu/drm/mxsfb/mxsfb_crtc.c | 17 +++++++++++---
>  drivers/gpu/drm/mxsfb/mxsfb_drv.c  | 46 +++++++++++++++++++++++++++++++++-----
>  drivers/gpu/drm/mxsfb/mxsfb_drv.h  |  4 +++-
>  drivers/gpu/drm/mxsfb/mxsfb_out.c  | 26 +++++++++++----------
>  4 files changed, 72 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> index 1242156..de09b93 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> @@ -95,8 +95,11 @@ static void mxsfb_set_bus_fmt(struct
> mxsfb_drm_private *mxsfb)
>  
>  	reg = readl(mxsfb->base + LCDC_CTRL);
>  
> -	if (mxsfb->connector.display_info.num_bus_formats)
> -		bus_format = mxsfb->connector.display_info.bus_formats[0];
> +	if (mxsfb->connector->display_info.num_bus_formats)
> +		bus_format = mxsfb->connector->display_info.bus_formats[0];
> +
> +	DRM_DEV_DEBUG_DRIVER(drm->dev, "Using bus_format: 0x%08X\n",
> +			     bus_format);
>  
>  	reg &= ~CTRL_BUS_WIDTH_MASK;
>  	switch (bus_format) {
> @@ -204,8 +207,9 @@ static dma_addr_t mxsfb_get_fb_paddr(struct
> mxsfb_drm_private *mxsfb)
>  
>  static void mxsfb_crtc_mode_set_nofb(struct mxsfb_drm_private *mxsfb)
>  {
> +	struct drm_device *drm = mxsfb->pipe.crtc.dev;
>  	struct drm_display_mode *m = &mxsfb->pipe.crtc.state->adjusted_mode;
> -	const u32 bus_flags = mxsfb->connector.display_info.bus_flags;
> +	const u32 bus_flags = mxsfb->connector->display_info.bus_flags;
>  	u32 vdctrl0, vsync_pulse_len, hsync_pulse_len;
>  	int err;
>  
> @@ -229,6 +233,13 @@ static void mxsfb_crtc_mode_set_nofb(struct
> mxsfb_drm_private *mxsfb)
>  
>  	clk_set_rate(mxsfb->clk, m->crtc_clock * 1000);
>  
> +	DRM_DEV_DEBUG_DRIVER(drm->dev, "Pixel clock: %dkHz (actual: %dkHz)\n",
> +			     m->crtc_clock,
> +			     (int)(clk_get_rate(mxsfb->clk) / 1000));
> +	DRM_DEV_DEBUG_DRIVER(drm->dev, "Connector bus_flags: 0x%08X\n",
> +			     bus_flags);
> +	DRM_DEV_DEBUG_DRIVER(drm->dev, "Mode flags: 0x%08X\n", m->flags);
> +
>  	writel(TRANSFER_COUNT_SET_VCOUNT(m->crtc_vdisplay) |
>  	       TRANSFER_COUNT_SET_HCOUNT(m->crtc_hdisplay),
>  	       mxsfb->base + mxsfb->devdata->transfer_count);
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> index e850633..497cf44 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> @@ -101,9 +101,25 @@ static void mxsfb_pipe_enable(struct
> drm_simple_display_pipe *pipe,
>  			      struct drm_crtc_state *crtc_state,
>  			      struct drm_plane_state *plane_state)
>  {
> +	struct drm_connector *connector;
>  	struct mxsfb_drm_private *mxsfb = drm_pipe_to_mxsfb_drm_private(pipe);
>  	struct drm_device *drm = pipe->plane.dev;
>  
> +	if (!mxsfb->connector) {
> +		list_for_each_entry(connector,
> +				    &drm->mode_config.connector_list,
> +				    head)
> +			if (connector->encoder == &mxsfb->pipe.encoder) {
> +				mxsfb->connector = connector;
> +				break;
> +			}
> +	}
> +
> +	if (!mxsfb->connector) {
> +		dev_warn(drm->dev, "No connector attached, using default\n");
> +		mxsfb->connector = &mxsfb->panel_connector;
> +	}
> +
>  	pm_runtime_get_sync(drm->dev);
>  	drm_panel_prepare(mxsfb->panel);
>  	mxsfb_crtc_enable(mxsfb);
> @@ -129,6 +145,9 @@ static void mxsfb_pipe_disable(struct
> drm_simple_display_pipe *pipe)
>  		drm_crtc_send_vblank_event(crtc, event);
>  	}
>  	spin_unlock_irq(&drm->event_lock);
> +
> +	if (mxsfb->connector != &mxsfb->panel_connector)
> +		mxsfb->connector = NULL;
>  }
>  
>  static void mxsfb_pipe_update(struct drm_simple_display_pipe *pipe,
> @@ -226,16 +245,33 @@ static int mxsfb_load(struct drm_device *drm,
> unsigned long flags)
>  
>  	ret = drm_simple_display_pipe_init(drm, &mxsfb->pipe, &mxsfb_funcs,
>  			mxsfb_formats, ARRAY_SIZE(mxsfb_formats), NULL,
> -			&mxsfb->connector);
> +			mxsfb->connector);
>  	if (ret < 0) {
>  		dev_err(drm->dev, "Cannot setup simple display pipe\n");
>  		goto err_vblank;
>  	}
>  
> -	ret = drm_panel_attach(mxsfb->panel, &mxsfb->connector);
> -	if (ret) {
> -		dev_err(drm->dev, "Cannot connect panel\n");
> -		goto err_vblank;
> +	/*
> +	 * Attach panel only if there is one.
> +	 * If there is no panel attach, it must be a bridge. In this case, we
> +	 * need a reference to its connector for a proper initialization.
> +	 * We will do this check in pipe->enable(), since the connector won't
> +	 * be attached to an encoder until then.
> +	 */
> +
> +	if (mxsfb->panel) {
> +		ret = drm_panel_attach(mxsfb->panel, mxsfb->connector);
> +		if (ret) {
> +			dev_err(drm->dev, "Cannot connect panel: %d\n", ret);
> +			goto err_vblank;
> +		}
> +	} else if (mxsfb->bridge) {
> +		ret = drm_simple_display_pipe_attach_bridge(&mxsfb->pipe,
> +							    mxsfb->bridge);
> +		if (ret) {
> +			dev_err(drm->dev, "Cannot connect bridge: %d\n", ret);
> +			goto err_vblank;
> +		}
>  	}
>  
>  	drm->mode_config.min_width	= MXSFB_MIN_XRES;
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.h
> b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
> index d975300..0b65b51 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.h
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
> @@ -27,8 +27,10 @@ struct mxsfb_drm_private {
>  	struct clk			*clk_disp_axi;
>  
>  	struct drm_simple_display_pipe	pipe;
> -	struct drm_connector		connector;
> +	struct drm_connector		panel_connector;
> +	struct drm_connector		*connector;
>  	struct drm_panel		*panel;
> +	struct drm_bridge		*bridge;
>  };
>  
>  int mxsfb_setup_crtc(struct drm_device *dev);
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_out.c
> b/drivers/gpu/drm/mxsfb/mxsfb_out.c
> index be36f4d..4eb9474 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_out.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_out.c
> @@ -21,7 +21,8 @@
>  static struct mxsfb_drm_private *
>  drm_connector_to_mxsfb_drm_private(struct drm_connector *connector)
>  {
> -	return container_of(connector, struct mxsfb_drm_private, connector);
> +	return container_of(connector, struct mxsfb_drm_private,
> +			    panel_connector);
>  }
>  
>  static int mxsfb_panel_get_modes(struct drm_connector *connector)
> @@ -76,22 +77,23 @@ static const struct drm_connector_funcs
> mxsfb_panel_connector_funcs = {
>  int mxsfb_create_output(struct drm_device *drm)
>  {
>  	struct mxsfb_drm_private *mxsfb = drm->dev_private;
> -	struct drm_panel *panel;
>  	int ret;
>  
> -	ret = drm_of_find_panel_or_bridge(drm->dev->of_node, 0, 0, &panel, NULL);
> +	ret = drm_of_find_panel_or_bridge(drm->dev->of_node, 0, 0,
> +					  &mxsfb->panel, &mxsfb->bridge);
>  	if (ret)
>  		return ret;
>  
> -	mxsfb->connector.dpms = DRM_MODE_DPMS_OFF;
> -	mxsfb->connector.polled = 0;
> -	drm_connector_helper_add(&mxsfb->connector,
> -			&mxsfb_panel_connector_helper_funcs);
> -	ret = drm_connector_init(drm, &mxsfb->connector,
> -				 &mxsfb_panel_connector_funcs,
> -				 DRM_MODE_CONNECTOR_Unknown);
> -	if (!ret)
> -		mxsfb->panel = panel;
> +	if (mxsfb->panel) {
> +		mxsfb->connector = &mxsfb->panel_connector;
> +		mxsfb->connector->dpms = DRM_MODE_DPMS_OFF;
> +		mxsfb->connector->polled = 0;
> +		drm_connector_helper_add(mxsfb->connector,
> +					 &mxsfb_panel_connector_helper_funcs);
> +		ret = drm_connector_init(drm, mxsfb->connector,
> +					 &mxsfb_panel_connector_funcs,
> +					 DRM_MODE_CONNECTOR_Unknown);
> +	}
>  
>  	return ret;
>  }
