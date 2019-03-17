Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BECC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 22:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C57E2086A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 22:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="vmZ7yYk5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfCQWzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 18:55:37 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:43952 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfCQWzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 18:55:36 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 66CA423A;
        Sun, 17 Mar 2019 23:55:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1552863333;
        bh=U/sw6zlRJ9dAk/4PRtbudOCv30wRobn1dk49Peyjupo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vmZ7yYk5DnLbi/miuoH8CSz8NjwnDTpg47X+bRCtjFKl3mSyVe7zXHDL3yRtW2sQ+
         SYW0hoLBgTKlHUyruCDUvxw+MHdmf1ZF8vxfeCKsE9P4JXkzYfPVDCGsJ0EWSn8F7b
         Ppjh4MNxQK/bxZvXRuMIaoaeU6deopUCpGeVaJRY=
Date:   Mon, 18 Mar 2019 00:55:25 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] drm: rcar-du: Link CRTCs to the DU device
Message-ID: <20190317225525.GC12636@pendragon.ideasonboard.com>
References: <20190315170110.23280-1-kieran.bingham+renesas@ideasonboard.com>
 <20190315170110.23280-2-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190315170110.23280-2-kieran.bingham+renesas@ideasonboard.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Thank you for the patch.

On Fri, Mar 15, 2019 at 05:01:05PM +0000, Kieran Bingham wrote:
> The rcar_du_crtc functions have a heavy reliance on the rcar_du_group
> structure, in many cases just to access the DU device context.
> 
> To better separate the groups out of the CRTC handling code, give the
> rcar_du_crtc its own pointer to the device and remove the indirection
> through the group pointers.

I've thought about doing this so many times, every time I had to access
the device from the crtc.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

And taken in my tree.

> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> ---
>  drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 48 +++++++++++++-------------
>  drivers/gpu/drm/rcar-du/rcar_du_crtc.h |  2 ++
>  drivers/gpu/drm/rcar-du/rcar_du_vsp.c  |  2 +-
>  3 files changed, 27 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> index 57fd5c00494b..471ce464654a 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> @@ -32,21 +32,21 @@
>  
>  static u32 rcar_du_crtc_read(struct rcar_du_crtc *rcrtc, u32 reg)
>  {
> -	struct rcar_du_device *rcdu = rcrtc->group->dev;
> +	struct rcar_du_device *rcdu = rcrtc->dev;
>  
>  	return rcar_du_read(rcdu, rcrtc->mmio_offset + reg);
>  }
>  
>  static void rcar_du_crtc_write(struct rcar_du_crtc *rcrtc, u32 reg, u32 data)
>  {
> -	struct rcar_du_device *rcdu = rcrtc->group->dev;
> +	struct rcar_du_device *rcdu = rcrtc->dev;
>  
>  	rcar_du_write(rcdu, rcrtc->mmio_offset + reg, data);
>  }
>  
>  static void rcar_du_crtc_clr(struct rcar_du_crtc *rcrtc, u32 reg, u32 clr)
>  {
> -	struct rcar_du_device *rcdu = rcrtc->group->dev;
> +	struct rcar_du_device *rcdu = rcrtc->dev;
>  
>  	rcar_du_write(rcdu, rcrtc->mmio_offset + reg,
>  		      rcar_du_read(rcdu, rcrtc->mmio_offset + reg) & ~clr);
> @@ -54,7 +54,7 @@ static void rcar_du_crtc_clr(struct rcar_du_crtc *rcrtc, u32 reg, u32 clr)
>  
>  static void rcar_du_crtc_set(struct rcar_du_crtc *rcrtc, u32 reg, u32 set)
>  {
> -	struct rcar_du_device *rcdu = rcrtc->group->dev;
> +	struct rcar_du_device *rcdu = rcrtc->dev;
>  
>  	rcar_du_write(rcdu, rcrtc->mmio_offset + reg,
>  		      rcar_du_read(rcdu, rcrtc->mmio_offset + reg) | set);
> @@ -62,7 +62,7 @@ static void rcar_du_crtc_set(struct rcar_du_crtc *rcrtc, u32 reg, u32 set)
>  
>  void rcar_du_crtc_dsysr_clr_set(struct rcar_du_crtc *rcrtc, u32 clr, u32 set)
>  {
> -	struct rcar_du_device *rcdu = rcrtc->group->dev;
> +	struct rcar_du_device *rcdu = rcrtc->dev;
>  
>  	rcrtc->dsysr = (rcrtc->dsysr & ~clr) | set;
>  	rcar_du_write(rcdu, rcrtc->mmio_offset + DSYSR, rcrtc->dsysr);
> @@ -157,10 +157,9 @@ static void rcar_du_dpll_divider(struct rcar_du_crtc *rcrtc,
>  	}
>  
>  done:
> -	dev_dbg(rcrtc->group->dev->dev,
> +	dev_dbg(rcrtc->dev->dev,
>  		"output:%u, fdpll:%u, n:%u, m:%u, diff:%lu\n",
> -		 dpll->output, dpll->fdpll, dpll->n, dpll->m,
> -		 best_diff);
> +		 dpll->output, dpll->fdpll, dpll->n, dpll->m, best_diff);
>  }
>  
>  struct du_clk_params {
> @@ -212,7 +211,7 @@ static const struct soc_device_attribute rcar_du_r8a7795_es1[] = {
>  static void rcar_du_crtc_set_display_timing(struct rcar_du_crtc *rcrtc)
>  {
>  	const struct drm_display_mode *mode = &rcrtc->crtc.state->adjusted_mode;
> -	struct rcar_du_device *rcdu = rcrtc->group->dev;
> +	struct rcar_du_device *rcdu = rcrtc->dev;
>  	unsigned long mode_clock = mode->clock * 1000;
>  	u32 dsmr;
>  	u32 escr;
> @@ -277,7 +276,7 @@ static void rcar_du_crtc_set_display_timing(struct rcar_du_crtc *rcrtc)
>  			rcar_du_escr_divider(rcrtc->extclock, mode_clock,
>  					     ESCR_DCLKSEL_DCLKIN, &params);
>  
> -		dev_dbg(rcrtc->group->dev->dev,	"mode clock %lu %s rate %lu\n",
> +		dev_dbg(rcrtc->dev->dev, "mode clock %lu %s rate %lu\n",
>  			mode_clock, params.clk == rcrtc->clock ? "cpg" : "ext",
>  			params.rate);
>  
> @@ -285,7 +284,7 @@ static void rcar_du_crtc_set_display_timing(struct rcar_du_crtc *rcrtc)
>  		escr = params.escr;
>  	}
>  
> -	dev_dbg(rcrtc->group->dev->dev, "%s: ESCR 0x%08x\n", __func__, escr);
> +	dev_dbg(rcrtc->dev->dev, "%s: ESCR 0x%08x\n", __func__, escr);
>  
>  	rcar_du_crtc_write(rcrtc, rcrtc->index % 2 ? ESCR13 : ESCR02, escr);
>  	rcar_du_crtc_write(rcrtc, rcrtc->index % 2 ? OTAR13 : OTAR02, 0);
> @@ -333,7 +332,7 @@ plane_format(struct rcar_du_plane *plane)
>  static void rcar_du_crtc_update_planes(struct rcar_du_crtc *rcrtc)
>  {
>  	struct rcar_du_plane *planes[RCAR_DU_NUM_HW_PLANES];
> -	struct rcar_du_device *rcdu = rcrtc->group->dev;
> +	struct rcar_du_device *rcdu = rcrtc->dev;
>  	unsigned int num_planes = 0;
>  	unsigned int dptsr_planes;
>  	unsigned int hwplanes = 0;
> @@ -463,7 +462,7 @@ static bool rcar_du_crtc_page_flip_pending(struct rcar_du_crtc *rcrtc)
>  
>  static void rcar_du_crtc_wait_page_flip(struct rcar_du_crtc *rcrtc)
>  {
> -	struct rcar_du_device *rcdu = rcrtc->group->dev;
> +	struct rcar_du_device *rcdu = rcrtc->dev;
>  
>  	if (wait_event_timeout(rcrtc->flip_wait,
>  			       !rcar_du_crtc_page_flip_pending(rcrtc),
> @@ -493,7 +492,7 @@ static void rcar_du_crtc_setup(struct rcar_du_crtc *rcrtc)
>  	rcar_du_group_write(rcrtc->group, rcrtc->index % 2 ? DS2PR : DS1PR, 0);
>  
>  	/* Enable the VSP compositor. */
> -	if (rcar_du_has(rcrtc->group->dev, RCAR_DU_FEATURE_VSP1_SOURCE))
> +	if (rcar_du_has(rcrtc->dev, RCAR_DU_FEATURE_VSP1_SOURCE))
>  		rcar_du_vsp_enable(rcrtc);
>  
>  	/* Turn vertical blanking interrupt reporting on. */
> @@ -564,7 +563,7 @@ static void rcar_du_crtc_start(struct rcar_du_crtc *rcrtc)
>  
>  static void rcar_du_crtc_disable_planes(struct rcar_du_crtc *rcrtc)
>  {
> -	struct rcar_du_device *rcdu = rcrtc->group->dev;
> +	struct rcar_du_device *rcdu = rcrtc->dev;
>  	struct drm_crtc *crtc = &rcrtc->crtc;
>  	u32 status;
>  
> @@ -617,7 +616,7 @@ static void rcar_du_crtc_stop(struct rcar_du_crtc *rcrtc)
>  	drm_crtc_vblank_off(crtc);
>  
>  	/* Disable the VSP compositor. */
> -	if (rcar_du_has(rcrtc->group->dev, RCAR_DU_FEATURE_VSP1_SOURCE))
> +	if (rcar_du_has(rcrtc->dev, RCAR_DU_FEATURE_VSP1_SOURCE))
>  		rcar_du_vsp_disable(rcrtc);
>  
>  	/*
> @@ -627,7 +626,7 @@ static void rcar_du_crtc_stop(struct rcar_du_crtc *rcrtc)
>  	 * TODO: Find another way to stop the display for DUs that don't support
>  	 * TVM sync.
>  	 */
> -	if (rcar_du_has(rcrtc->group->dev, RCAR_DU_FEATURE_TVM_SYNC))
> +	if (rcar_du_has(rcrtc->dev, RCAR_DU_FEATURE_TVM_SYNC))
>  		rcar_du_crtc_dsysr_clr_set(rcrtc, DSYSR_TVM_MASK,
>  					   DSYSR_TVM_SWITCH);
>  
> @@ -661,7 +660,7 @@ static void rcar_du_crtc_atomic_enable(struct drm_crtc *crtc,
>  {
>  	struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
>  	struct rcar_du_crtc_state *rstate = to_rcar_crtc_state(crtc->state);
> -	struct rcar_du_device *rcdu = rcrtc->group->dev;
> +	struct rcar_du_device *rcdu = rcrtc->dev;
>  
>  	rcar_du_crtc_get(rcrtc);
>  
> @@ -689,7 +688,7 @@ static void rcar_du_crtc_atomic_disable(struct drm_crtc *crtc,
>  {
>  	struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
>  	struct rcar_du_crtc_state *rstate = to_rcar_crtc_state(old_state);
> -	struct rcar_du_device *rcdu = rcrtc->group->dev;
> +	struct rcar_du_device *rcdu = rcrtc->dev;
>  
>  	rcar_du_crtc_stop(rcrtc);
>  	rcar_du_crtc_put(rcrtc);
> @@ -735,7 +734,7 @@ static void rcar_du_crtc_atomic_begin(struct drm_crtc *crtc,
>  	 */
>  	rcar_du_crtc_get(rcrtc);
>  
> -	if (rcar_du_has(rcrtc->group->dev, RCAR_DU_FEATURE_VSP1_SOURCE))
> +	if (rcar_du_has(rcrtc->dev, RCAR_DU_FEATURE_VSP1_SOURCE))
>  		rcar_du_vsp_atomic_begin(rcrtc);
>  }
>  
> @@ -757,7 +756,7 @@ static void rcar_du_crtc_atomic_flush(struct drm_crtc *crtc,
>  		spin_unlock_irqrestore(&dev->event_lock, flags);
>  	}
>  
> -	if (rcar_du_has(rcrtc->group->dev, RCAR_DU_FEATURE_VSP1_SOURCE))
> +	if (rcar_du_has(rcrtc->dev, RCAR_DU_FEATURE_VSP1_SOURCE))
>  		rcar_du_vsp_atomic_flush(rcrtc);
>  }
>  
> @@ -766,7 +765,7 @@ rcar_du_crtc_mode_valid(struct drm_crtc *crtc,
>  			const struct drm_display_mode *mode)
>  {
>  	struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
> -	struct rcar_du_device *rcdu = rcrtc->group->dev;
> +	struct rcar_du_device *rcdu = rcrtc->dev;
>  	bool interlaced = mode->flags & DRM_MODE_FLAG_INTERLACE;
>  	unsigned int vbp;
>  
> @@ -798,7 +797,7 @@ static const struct drm_crtc_helper_funcs crtc_helper_funcs = {
>  
>  static void rcar_du_crtc_crc_init(struct rcar_du_crtc *rcrtc)
>  {
> -	struct rcar_du_device *rcdu = rcrtc->group->dev;
> +	struct rcar_du_device *rcdu = rcrtc->dev;
>  	const char **sources;
>  	unsigned int count;
>  	int i = -1;
> @@ -1080,7 +1079,7 @@ static const struct drm_crtc_funcs crtc_funcs_gen3 = {
>  static irqreturn_t rcar_du_crtc_irq(int irq, void *arg)
>  {
>  	struct rcar_du_crtc *rcrtc = arg;
> -	struct rcar_du_device *rcdu = rcrtc->group->dev;
> +	struct rcar_du_device *rcdu = rcrtc->dev;
>  	irqreturn_t ret = IRQ_NONE;
>  	u32 status;
>  
> @@ -1172,6 +1171,7 @@ int rcar_du_crtc_create(struct rcar_du_group *rgrp, unsigned int swindex,
>  	init_waitqueue_head(&rcrtc->vblank_wait);
>  	spin_lock_init(&rcrtc->vblank_lock);
>  
> +	rcrtc->dev = rcdu;
>  	rcrtc->group = rgrp;
>  	rcrtc->mmio_offset = mmio_offsets[hwindex];
>  	rcrtc->index = hwindex;
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.h b/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
> index 3f339a7e8d14..11814eafef77 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
> @@ -24,6 +24,7 @@ struct rcar_du_vsp;
>  /**
>   * struct rcar_du_crtc - the CRTC, representing a DU superposition processor
>   * @crtc: base DRM CRTC
> + * @dev: the DU device
>   * @clock: the CRTC functional clock
>   * @extclock: external pixel dot clock (optional)
>   * @mmio_offset: offset of the CRTC registers in the DU MMIO block
> @@ -43,6 +44,7 @@ struct rcar_du_vsp;
>  struct rcar_du_crtc {
>  	struct drm_crtc crtc;
>  
> +	struct rcar_du_device *dev;
>  	struct clk *clock;
>  	struct clk *extclock;
>  	unsigned int mmio_offset;
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_vsp.c b/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
> index 0878accbd134..f6deea90dcce 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
> @@ -43,7 +43,7 @@ static void rcar_du_vsp_complete(void *private, bool completed, u32 crc)
>  void rcar_du_vsp_enable(struct rcar_du_crtc *crtc)
>  {
>  	const struct drm_display_mode *mode = &crtc->crtc.state->adjusted_mode;
> -	struct rcar_du_device *rcdu = crtc->group->dev;
> +	struct rcar_du_device *rcdu = crtc->dev;
>  	struct vsp1_du_lif_config cfg = {
>  		.width = mode->hdisplay,
>  		.height = mode->vdisplay,

-- 
Regards,

Laurent Pinchart
