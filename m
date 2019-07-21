Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B9BC76195
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 10:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F338208C0
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 10:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfGUK0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 06:26:55 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:57598 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbfGUK0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 06:26:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id D9795FB03;
        Sun, 21 Jul 2019 12:26:50 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8DykkjfOyHTt; Sun, 21 Jul 2019 12:26:48 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 1510B41113; Sun, 21 Jul 2019 12:26:48 +0200 (CEST)
Date:   Sun, 21 Jul 2019 12:26:48 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Robert Chiras <robert.chiras@nxp.com>
Cc:     Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 01/10] drm/mxsfb: Update mxsfb to support a bridge
Message-ID: <20190721102647.GA999@bogon.m.sigxcpu.org>
References: <1561555938-21595-1-git-send-email-robert.chiras@nxp.com>
 <1561555938-21595-2-git-send-email-robert.chiras@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1561555938-21595-2-git-send-email-robert.chiras@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,
On Wed, Jun 26, 2019 at 04:32:09PM +0300, Robert Chiras wrote:
> Currently, the MXSFB DRM driver only supports a panel. But, its output
> display signal can also be redirected to another encoder, like a DSI
> controller. In this case, that DSI controller may act like a drm_bridge.
> In order support this use-case too, this patch adds support for
> drm_bridge in mxsfb.
> 
> Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
> ---
>  drivers/gpu/drm/mxsfb/mxsfb_crtc.c | 46 +++++++++++++++++++++++++++++++++++---
>  drivers/gpu/drm/mxsfb/mxsfb_drv.c  | 46 +++++++++++++++++++++++++++++++++-----
>  drivers/gpu/drm/mxsfb/mxsfb_drv.h  |  4 +++-
>  drivers/gpu/drm/mxsfb/mxsfb_out.c  | 26 +++++++++++----------
>  drivers/gpu/drm/mxsfb/mxsfb_regs.h | 15 +++++++++++++
>  5 files changed, 116 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> index 93f4133..14bde024 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> @@ -93,8 +93,11 @@ static void mxsfb_set_bus_fmt(struct mxsfb_drm_private *mxsfb)
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
> @@ -122,6 +125,9 @@ static void mxsfb_enable_controller(struct mxsfb_drm_private *mxsfb)
>  		clk_prepare_enable(mxsfb->clk_disp_axi);
>  	clk_prepare_enable(mxsfb->clk);
>  
> +	writel(CTRL2_OUTSTANDING_REQS__REQ_16,
> +	       mxsfb->base + LCDC_V4_CTRL2 + REG_SET);
> +
>  	/* If it was disabled, re-enable the mode again */
>  	writel(CTRL_DOTCLK_MODE, mxsfb->base + LCDC_CTRL + REG_SET);
>  
> @@ -131,12 +137,15 @@ static void mxsfb_enable_controller(struct mxsfb_drm_private *mxsfb)
>  	writel(reg, mxsfb->base + LCDC_VDCTRL4);
>  
>  	writel(CTRL_RUN, mxsfb->base + LCDC_CTRL + REG_SET);
> +	writel(CTRL1_RECOVERY_ON_UNDERFLOW, mxsfb->base + LCDC_CTRL1 + REG_SET);
>  }
>  
>  static void mxsfb_disable_controller(struct mxsfb_drm_private *mxsfb)
>  {
>  	u32 reg;
>  
> +	writel(CTRL_RUN, mxsfb->base + LCDC_CTRL + REG_CLR);
> +
>  	/*
>  	 * Even if we disable the controller here, it will still continue
>  	 * until its FIFOs are running out of data
> @@ -202,8 +211,9 @@ static dma_addr_t mxsfb_get_fb_paddr(struct mxsfb_drm_private *mxsfb)
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
> @@ -227,6 +237,13 @@ static void mxsfb_crtc_mode_set_nofb(struct mxsfb_drm_private *mxsfb)
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
> @@ -279,6 +296,7 @@ void mxsfb_crtc_enable(struct mxsfb_drm_private *mxsfb)
>  	dma_addr_t paddr;
>  
>  	mxsfb_enable_axi_clk(mxsfb);
> +	writel(0, mxsfb->base + LCDC_CTRL);
>  	mxsfb_crtc_mode_set_nofb(mxsfb);
>  
>  	/* Write cur_buf as well to avoid an initial corrupt frame */
> @@ -302,6 +320,8 @@ void mxsfb_plane_atomic_update(struct mxsfb_drm_private *mxsfb,
>  {
>  	struct drm_simple_display_pipe *pipe = &mxsfb->pipe;
>  	struct drm_crtc *crtc = &pipe->crtc;
> +	struct drm_framebuffer *fb = pipe->plane.state->fb;
> +	struct drm_framebuffer *old_fb = old_state->fb;
>  	struct drm_pending_vblank_event *event;
>  	dma_addr_t paddr;
>  
> @@ -324,4 +344,24 @@ void mxsfb_plane_atomic_update(struct mxsfb_drm_private *mxsfb,
>  		writel(paddr, mxsfb->base + mxsfb->devdata->next_buf);
>  		mxsfb_disable_axi_clk(mxsfb);
>  	}
> +
> +	if (!fb || !old_fb)
> +		return;
> +
> +	/*
> +	 * TODO: Currently, we only support pixel format change, but we need
> +	 * also to care about size changes too
> +	 */
> +	if (old_fb->format->format != fb->format->format) {
> +		struct drm_format_name_buf old_fmt_buf;
> +		struct drm_format_name_buf new_fmt_buf;
> +
> +		DRM_DEV_DEBUG_DRIVER(crtc->dev->dev,
> +				     "Switching pixel format: %s -> %s\n",
> +				     drm_get_format_name(old_fb->format->format,
> +							 &old_fmt_buf),
> +				     drm_get_format_name(fb->format->format,
> +							 &new_fmt_buf));
> +		mxsfb_set_pixel_fmt(mxsfb, true);

This assumes mxsfb_set_pixel_fmt has two arguments which is being introduced
in the following commit. With that fixed:

Tested-by: Guido Günther <agx@sigxcpu.org> 

Cheers,
 -- Guido

> +	}
>  }
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> index 6fafc90..0d171e9 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> @@ -98,9 +98,25 @@ static void mxsfb_pipe_enable(struct drm_simple_display_pipe *pipe,
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
> @@ -126,6 +142,9 @@ static void mxsfb_pipe_disable(struct drm_simple_display_pipe *pipe)
>  		drm_crtc_send_vblank_event(crtc, event);
>  	}
>  	spin_unlock_irq(&drm->event_lock);
> +
> +	if (mxsfb->connector != &mxsfb->panel_connector)
> +		mxsfb->connector = NULL;
>  }
>  
>  static void mxsfb_pipe_update(struct drm_simple_display_pipe *pipe,
> @@ -223,16 +242,33 @@ static int mxsfb_load(struct drm_device *drm, unsigned long flags)
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
> +			dev_err(drm->dev, "Cannot connect panel\n");
> +			goto err_vblank;
> +		}
> +	} else if (mxsfb->bridge) {
> +		ret = drm_simple_display_pipe_attach_bridge(&mxsfb->pipe,
> +							    mxsfb->bridge);
> +		if (ret) {
> +			dev_err(drm->dev, "Cannot connect bridge\n");
> +			goto err_vblank;
> +		}
>  	}
>  
>  	drm->mode_config.min_width	= MXSFB_MIN_XRES;
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.h b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
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
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_out.c b/drivers/gpu/drm/mxsfb/mxsfb_out.c
> index 91e76f9..b9acf2b 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_out.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_out.c
> @@ -22,7 +22,8 @@
>  static struct mxsfb_drm_private *
>  drm_connector_to_mxsfb_drm_private(struct drm_connector *connector)
>  {
> -	return container_of(connector, struct mxsfb_drm_private, connector);
> +	return container_of(connector, struct mxsfb_drm_private,
> +			    panel_connector);
>  }
>  
>  static int mxsfb_panel_get_modes(struct drm_connector *connector)
> @@ -77,22 +78,23 @@ static const struct drm_connector_funcs mxsfb_panel_connector_funcs = {
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
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_regs.h b/drivers/gpu/drm/mxsfb/mxsfb_regs.h
> index 932d7ea..71426aa 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_regs.h
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_regs.h
> @@ -14,19 +14,31 @@
>  
>  #define LCDC_CTRL			0x00
>  #define LCDC_CTRL1			0x10
> +#define LCDC_V4_CTRL2			0x20
>  #define LCDC_V3_TRANSFER_COUNT		0x20
>  #define LCDC_V4_TRANSFER_COUNT		0x30
>  #define LCDC_V4_CUR_BUF			0x40
>  #define LCDC_V4_NEXT_BUF		0x50
>  #define LCDC_V3_CUR_BUF			0x30
>  #define LCDC_V3_NEXT_BUF		0x40
> +#define LCDC_TIMING			0x60
>  #define LCDC_VDCTRL0			0x70
>  #define LCDC_VDCTRL1			0x80
>  #define LCDC_VDCTRL2			0x90
>  #define LCDC_VDCTRL3			0xa0
>  #define LCDC_VDCTRL4			0xb0
> +#define LCDC_DVICTRL0			0xc0
> +#define LCDC_DVICTRL1			0xd0
> +#define LCDC_DVICTRL2			0xe0
> +#define LCDC_DVICTRL3			0xf0
> +#define LCDC_DVICTRL4			0x100
> +#define LCDC_V4_DATA			0x180
> +#define LCDC_V3_DATA			0x1b0
>  #define LCDC_V4_DEBUG0			0x1d0
>  #define LCDC_V3_DEBUG0			0x1f0
> +#define LCDC_AS_CTRL			0x210
> +#define LCDC_AS_BUF			0x220
> +#define LCDC_AS_NEXT_BUF		0x230
>  
>  #define CTRL_SFTRST			(1 << 31)
>  #define CTRL_CLKGATE			(1 << 30)
> @@ -45,12 +57,15 @@
>  #define CTRL_DF24			(1 << 1)
>  #define CTRL_RUN			(1 << 0)
>  
> +#define CTRL1_RECOVERY_ON_UNDERFLOW	(1 << 24)
>  #define CTRL1_FIFO_CLEAR		(1 << 21)
>  #define CTRL1_SET_BYTE_PACKAGING(x)	(((x) & 0xf) << 16)
>  #define CTRL1_GET_BYTE_PACKAGING(x)	(((x) >> 16) & 0xf)
>  #define CTRL1_CUR_FRAME_DONE_IRQ_EN	(1 << 13)
>  #define CTRL1_CUR_FRAME_DONE_IRQ	(1 << 9)
>  
> +#define CTRL2_OUTSTANDING_REQS__REQ_16		(4 << 21)
> +
>  #define TRANSFER_COUNT_SET_VCOUNT(x)	(((x) & 0xffff) << 16)
>  #define TRANSFER_COUNT_GET_VCOUNT(x)	(((x) >> 16) & 0xffff)
>  #define TRANSFER_COUNT_SET_HCOUNT(x)	((x) & 0xffff)
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
