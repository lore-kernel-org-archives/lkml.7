Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C89C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6810206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="jFM71Zc3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfHNLGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 07:06:34 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:35820 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfHNLGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 07:06:34 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id D2A405C2B10;
        Wed, 14 Aug 2019 13:06:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1565780790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kYGuMxiSxeUl5Au06aq8bOF9rLtDhjPE68Kq7sDH1l0=;
        b=jFM71Zc3y5nYl+eWHhNtRbvhMoGUt8Rx7isKmlOFcbj/a+bdXTfLk57PZb8HVZXnQBdaXe
        9Gt9pmA/CEhpr243vAvDGGbeirq52vmtEgjbh8QOXGaHrF4O7/udLmleKO6DxUI6KW0EFY
        bysmEAtgEvRoEQS6+KW1bJU0sw1/Flg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Wed, 14 Aug 2019 13:06:30 +0200
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
Subject: Re: [PATCH v2 12/15] drm/mxsfb: Improve the axi clock usage
In-Reply-To: <1565779731-1300-13-git-send-email-robert.chiras@nxp.com>
References: <1565779731-1300-1-git-send-email-robert.chiras@nxp.com>
 <1565779731-1300-13-git-send-email-robert.chiras@nxp.com>
Message-ID: <425a854f41248b083ff0c6c93673d696@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-14 12:48, Robert Chiras wrote:
> Currently, the enable of the axi clock return status is ignored, causing
> issues when the enable fails then we try to disable it. Therefore, it is
> better to check the return status and disable it only when enable
> succeeded.

Is this actually the case in real world sometimes? Why is it failing?

I guess if we do this in one place, we should do it in all places (e.g.
also in mxsfb_crtc_enable, mxsfb_plane_atomic_update..)

--
Stefan

> Also, remove the helper functions around clk_axi, since we can directly
> use the clk API function for enable/disable the clock. Those functions
> are already checking for NULL clk and returning 0 if that's the case.


> 
> Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
> Acked-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/gpu/drm/mxsfb/mxsfb_crtc.c |  8 ++++----
>  drivers/gpu/drm/mxsfb/mxsfb_drv.c  | 32 +++++++++++++-------------------
>  drivers/gpu/drm/mxsfb/mxsfb_drv.h  |  3 ---
>  3 files changed, 17 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> index a4ba368..e727f5e 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> @@ -408,7 +408,7 @@ void mxsfb_crtc_enable(struct mxsfb_drm_private *mxsfb)
>  {
>  	dma_addr_t paddr;
>  
> -	mxsfb_enable_axi_clk(mxsfb);
> +	clk_prepare_enable(mxsfb->clk_axi);
>  	writel(0, mxsfb->base + LCDC_CTRL);
>  	mxsfb_crtc_mode_set_nofb(mxsfb);
>  
> @@ -425,7 +425,7 @@ void mxsfb_crtc_enable(struct mxsfb_drm_private *mxsfb)
>  void mxsfb_crtc_disable(struct mxsfb_drm_private *mxsfb)
>  {
>  	mxsfb_disable_controller(mxsfb);
> -	mxsfb_disable_axi_clk(mxsfb);
> +	clk_disable_unprepare(mxsfb->clk_axi);
>  }
>  
>  void mxsfb_plane_atomic_update(struct mxsfb_drm_private *mxsfb,
> @@ -451,8 +451,8 @@ void mxsfb_plane_atomic_update(struct
> mxsfb_drm_private *mxsfb,
>  
>  	paddr = mxsfb_get_fb_paddr(mxsfb);
>  	if (paddr) {
> -		mxsfb_enable_axi_clk(mxsfb);
> +		clk_prepare_enable(mxsfb->clk_axi);
>  		writel(paddr, mxsfb->base + mxsfb->devdata->next_buf);
> -		mxsfb_disable_axi_clk(mxsfb);
> +		clk_disable_unprepare(mxsfb->clk_axi);
>  	}
>  }
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> index 6dae2bd..694b287 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> @@ -97,18 +97,6 @@ drm_pipe_to_mxsfb_drm_private(struct
> drm_simple_display_pipe *pipe)
>  	return container_of(pipe, struct mxsfb_drm_private, pipe);
>  }
>  
> -void mxsfb_enable_axi_clk(struct mxsfb_drm_private *mxsfb)
> -{
> -	if (mxsfb->clk_axi)
> -		clk_prepare_enable(mxsfb->clk_axi);
> -}
> -
> -void mxsfb_disable_axi_clk(struct mxsfb_drm_private *mxsfb)
> -{
> -	if (mxsfb->clk_axi)
> -		clk_disable_unprepare(mxsfb->clk_axi);
> -}
> -
>  /**
>   * mxsfb_atomic_helper_check - validate state object
>   * @dev: DRM device
> @@ -229,25 +217,31 @@ static void mxsfb_pipe_update(struct
> drm_simple_display_pipe *pipe,
>  static int mxsfb_pipe_enable_vblank(struct drm_simple_display_pipe *pipe)
>  {
>  	struct mxsfb_drm_private *mxsfb = drm_pipe_to_mxsfb_drm_private(pipe);
> +	int ret = 0;
> +
> +	ret = clk_prepare_enable(mxsfb->clk_axi);
> +	if (ret)
> +		return ret;
>  
>  	/* Clear and enable VBLANK IRQ */
> -	mxsfb_enable_axi_clk(mxsfb);
>  	writel(CTRL1_CUR_FRAME_DONE_IRQ, mxsfb->base + LCDC_CTRL1 + REG_CLR);
>  	writel(CTRL1_CUR_FRAME_DONE_IRQ_EN, mxsfb->base + LCDC_CTRL1 + REG_SET);
> -	mxsfb_disable_axi_clk(mxsfb);
> +	clk_disable_unprepare(mxsfb->clk_axi);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static void mxsfb_pipe_disable_vblank(struct drm_simple_display_pipe *pipe)
>  {
>  	struct mxsfb_drm_private *mxsfb = drm_pipe_to_mxsfb_drm_private(pipe);
>  
> +	if (clk_prepare_enable(mxsfb->clk_axi))
> +		return;
> +
>  	/* Disable and clear VBLANK IRQ */
> -	mxsfb_enable_axi_clk(mxsfb);
>  	writel(CTRL1_CUR_FRAME_DONE_IRQ_EN, mxsfb->base + LCDC_CTRL1 + REG_CLR);
>  	writel(CTRL1_CUR_FRAME_DONE_IRQ, mxsfb->base + LCDC_CTRL1 + REG_CLR);
> -	mxsfb_disable_axi_clk(mxsfb);
> +	clk_disable_unprepare(mxsfb->clk_axi);
>  }
>  
>  static struct drm_simple_display_pipe_funcs mxsfb_funcs = {
> @@ -413,7 +407,7 @@ static irqreturn_t mxsfb_irq_handler(int irq, void *data)
>  	struct mxsfb_drm_private *mxsfb = drm->dev_private;
>  	u32 reg;
>  
> -	mxsfb_enable_axi_clk(mxsfb);
> +	clk_prepare_enable(mxsfb->clk_axi);
>  
>  	reg = readl(mxsfb->base + LCDC_CTRL1);
>  
> @@ -422,7 +416,7 @@ static irqreturn_t mxsfb_irq_handler(int irq, void *data)
>  
>  	writel(CTRL1_CUR_FRAME_DONE_IRQ, mxsfb->base + LCDC_CTRL1 + REG_CLR);
>  
> -	mxsfb_disable_axi_clk(mxsfb);
> +	clk_disable_unprepare(mxsfb->clk_axi);
>  
>  	return IRQ_HANDLED;
>  }
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.h
> b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
> index 8fb65d3..d6df8fe 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.h
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
> @@ -37,9 +37,6 @@ struct mxsfb_drm_private {
>  int mxsfb_setup_crtc(struct drm_device *dev);
>  int mxsfb_create_output(struct drm_device *dev);
>  
> -void mxsfb_enable_axi_clk(struct mxsfb_drm_private *mxsfb);
> -void mxsfb_disable_axi_clk(struct mxsfb_drm_private *mxsfb);
> -
>  void mxsfb_crtc_enable(struct mxsfb_drm_private *mxsfb);
>  void mxsfb_crtc_disable(struct mxsfb_drm_private *mxsfb);
>  void mxsfb_plane_atomic_update(struct mxsfb_drm_private *mxsfb,
