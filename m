Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86DCC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C7721773
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfG2QCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:02:47 -0400
Received: from foss.arm.com ([217.140.110.172]:46438 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbfG2QCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:02:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A990337;
        Mon, 29 Jul 2019 09:02:45 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F3CC33F694;
        Mon, 29 Jul 2019 09:02:44 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id BB7DB682408; Mon, 29 Jul 2019 17:02:43 +0100 (BST)
Date:   Mon, 29 Jul 2019 17:02:43 +0100
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Cc:     "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>
Subject: Re: [PATCH 2/2] drm/komeda: Enable dual-link support
Message-ID: <20190729160243.w53nfeoaobk4j6j4@e110455-lin.cambridge.arm.com>
References: <20190618081013.13638-1-james.qian.wang@arm.com>
 <20190618081013.13638-3-james.qian.wang@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190618081013.13638-3-james.qian.wang@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 09:10:49AM +0100, james qian wang (Arm Technology China) wrote:
> Komeda HW can support dual-link which splits display frame to two halves
> (left/link0, right/link1) and output them by two output links.
> Due to the halved pixel rate of each link, the pxlclk of dual-link can be
> reduced two times compare with single-link.
> 
> For enabling dual-link:
> - The DT need to configure two output-links for the pipeline node.
> - Komeda enable dual-link when both link0 and link1 have been connected.
> 
> Example of how the pipeline node will look like for dual-link setup
> 
> pipe0: pipeline@0 {
> 	clocks = <&fpgaosc2>;
> 	clock-names = "pxclk";
> 	reg = <0>;
> 
> 	#address-cells = <1>;
> 	#size-cells = <0>;
> 
> 	port@0 {
> 		reg = <0>;
> 
> 		#address-cells = <1>;
> 		#size-cells = <0>;
> 		dp0_pipe0_link0: endpoint@0 {
> 			reg = <0>;
> 			remote-endpoint = <&dlink_connector_in0>;
> 
> 		};
> 		dp0_pipe0_link1: endpoint@1 {
> 			reg = <1>;
> 			remote-endpoint = <&dlink_connector_in1>;
> 		};
> 	};
> };
> 
> Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  .../arm/display/komeda/d71/d71_component.c    |  6 +-
>  .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 73 +++++++++++++------
>  .../gpu/drm/arm/display/komeda/komeda_dev.c   |  5 +-
>  .../gpu/drm/arm/display/komeda/komeda_drv.c   |  8 +-
>  .../gpu/drm/arm/display/komeda/komeda_kms.h   |  2 +-
>  .../drm/arm/display/komeda/komeda_pipeline.c  | 19 ++++-
>  .../drm/arm/display/komeda/komeda_pipeline.h  |  6 +-
>  .../display/komeda/komeda_pipeline_state.c    |  2 +-
>  8 files changed, 85 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> index 049e8bfac27b..8e9d44d01e91 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> @@ -4,8 +4,6 @@
>   * Author: James.Qian.Wang <james.qian.wang@arm.com>
>   *
>   */
> -
> -#include <drm/drm_print.h>
>  #include "d71_dev.h"
>  #include "komeda_kms.h"
>  #include "malidp_io.h"
> @@ -1088,6 +1086,10 @@ static void d71_timing_ctrlr_update(struct komeda_component *c,
> 
>  	/* configure bs control register */
>  	value = BS_CTRL_EN | BS_CTRL_VM;
> +	if (c->pipeline->dual_link) {
> +		malidp_write32(reg, BS_DRIFT_TO, hfront_porch + 16);
> +		value |= BS_CTRL_DL;
> +	}
> 
>  	malidp_write32(reg, BLK_CONTROL, value);
>  }
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> index 98e36e1fb2ad..ec43032f3c2c 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> @@ -28,7 +28,7 @@ static void komeda_crtc_update_clock_ratio(struct komeda_crtc_state *kcrtc_st)
>  	}
> 
>  	pxlclk = kcrtc_st->base.adjusted_mode.crtc_clock * 1000;
> -	aclk = komeda_calc_aclk(kcrtc_st) << 32;
> +	aclk = komeda_crtc_get_aclk(kcrtc_st) << 32;
> 
>  	do_div(aclk, pxlclk);
>  	kcrtc_st->clock_ratio = aclk;
> @@ -75,14 +75,6 @@ komeda_crtc_atomic_check(struct drm_crtc *crtc,
>  	return 0;
>  }
> 
> -unsigned long komeda_calc_aclk(struct komeda_crtc_state *kcrtc_st)
> -{
> -	struct komeda_dev *mdev = kcrtc_st->base.crtc->dev->dev_private;
> -	unsigned long aclk = kcrtc_st->base.adjusted_mode.crtc_clock;
> -
> -	return clk_round_rate(mdev->aclk, aclk * 1000);
> -}
> -
>  /* For active a crtc, mainly need two parts of preparation
>   * 1. adjust display operation mode.
>   * 2. enable needed clk
> @@ -119,7 +111,7 @@ komeda_crtc_prepare(struct komeda_crtc *kcrtc)
>  	 * to enable it again.
>  	 */
>  	if (new_mode != KOMEDA_MODE_DUAL_DISP) {
> -		err = clk_set_rate(mdev->aclk, komeda_calc_aclk(kcrtc_st));
> +		err = clk_set_rate(mdev->aclk, komeda_crtc_get_aclk(kcrtc_st));
>  		if (err)
>  			DRM_ERROR("failed to set aclk.\n");
>  		err = clk_prepare_enable(mdev->aclk);
> @@ -345,29 +337,58 @@ komeda_crtc_atomic_flush(struct drm_crtc *crtc,
>  	komeda_crtc_do_flush(crtc, old);
>  }
> 
> +/* Returns the minimum frequency of the aclk rate (main engine clock) in Hz */
> +static unsigned long
> +komeda_calc_min_aclk_rate(struct komeda_crtc *kcrtc,
> +			  unsigned long pxlclk)
> +{
> +	/* Once dual-link one display pipeline drives two display outputs,
> +	 * the aclk needs run on the double rate of pxlclk
> +	 */
> +	if (kcrtc->master->dual_link)
> +		return pxlclk * 2;
> +	else
> +		return pxlclk;
> +}
> +
> +/* Get current aclk rate that specified by state */
> +unsigned long komeda_crtc_get_aclk(struct komeda_crtc_state *kcrtc_st)
> +{
> +	struct drm_crtc *crtc = kcrtc_st->base.crtc;
> +	struct komeda_dev *mdev = crtc->dev->dev_private;
> +	unsigned long pxlclk = kcrtc_st->base.adjusted_mode.crtc_clock * 1000;
> +	unsigned long min_aclk;
> +
> +	min_aclk = komeda_calc_min_aclk_rate(to_kcrtc(crtc), pxlclk);
> +
> +	return clk_round_rate(mdev->aclk, min_aclk);
> +}
> +
>  static enum drm_mode_status
>  komeda_crtc_mode_valid(struct drm_crtc *crtc, const struct drm_display_mode *m)
>  {
>  	struct komeda_dev *mdev = crtc->dev->dev_private;
>  	struct komeda_crtc *kcrtc = to_kcrtc(crtc);
>  	struct komeda_pipeline *master = kcrtc->master;
> -	long mode_clk, pxlclk;
> +	unsigned long min_pxlclk, min_aclk;
> 
>  	if (m->flags & DRM_MODE_FLAG_INTERLACE)
>  		return MODE_NO_INTERLACE;
> 
> -	mode_clk = m->clock * 1000;
> -	pxlclk = clk_round_rate(master->pxlclk, mode_clk);
> -	if (pxlclk != mode_clk) {
> -		DRM_DEBUG_ATOMIC("pxlclk doesn't support %ld Hz\n", mode_clk);
> +	min_pxlclk = m->clock * 1000;
> +	if (master->dual_link)
> +		min_pxlclk /= 2;
> +
> +	if (min_pxlclk != clk_round_rate(master->pxlclk, min_pxlclk)) {
> +		DRM_DEBUG_ATOMIC("pxlclk doesn't support %lu Hz\n", min_pxlclk);
> 
>  		return MODE_NOCLOCK;
>  	}
> 
> -	/* main engine clock must be faster than pxlclk*/
> -	if (clk_round_rate(mdev->aclk, mode_clk) < pxlclk) {
> -		DRM_DEBUG_ATOMIC("engine clk can't satisfy the requirement of %s-clk: %ld.\n",
> -				 m->name, pxlclk);
> +	min_aclk = komeda_calc_min_aclk_rate(to_kcrtc(crtc), min_pxlclk);
> +	if (clk_round_rate(mdev->aclk, min_aclk) < min_aclk) {
> +		DRM_DEBUG_ATOMIC("engine clk can't satisfy the requirement of %s-clk: %lu.\n",
> +				 m->name, min_pxlclk);
> 
>  		return MODE_CLOCK_HIGH;
>  	}
> @@ -383,6 +404,14 @@ static bool komeda_crtc_mode_fixup(struct drm_crtc *crtc,
>  	unsigned long clk_rate;
> 
>  	drm_mode_set_crtcinfo(adjusted_mode, 0);
> +	/* In dual link half the horizontal settings */
> +	if (kcrtc->master->dual_link) {
> +		adjusted_mode->crtc_clock /= 2;
> +		adjusted_mode->crtc_hdisplay /= 2;
> +		adjusted_mode->crtc_hsync_start /= 2;
> +		adjusted_mode->crtc_hsync_end /= 2;
> +		adjusted_mode->crtc_htotal /= 2;
> +	}
> 
>  	clk_rate = adjusted_mode->crtc_clock * 1000;
>  	/* crtc_clock will be used as the komeda output pixel clock */
> @@ -514,10 +543,8 @@ int komeda_kms_setup_crtcs(struct komeda_kms_dev *kms,
>  		else
>  			sprintf(str, "None");
> 
> -		DRM_INFO("crtc%d: master(pipe-%d) slave(%s) output: %s.\n",
> -			 kms->n_crtcs, master->id, str,
> -			 master->of_output_dev ?
> -			 master->of_output_dev->full_name : "None");
> +		DRM_INFO("CRTC-%d: master(pipe-%d) slave(%s).\n",
> +			 kms->n_crtcs, master->id, str);
> 
>  		kms->n_crtcs++;
>  	}
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> index edd09435f35d..591da1ef7894 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> @@ -123,11 +123,14 @@ static int komeda_parse_pipe_dt(struct komeda_dev *mdev, struct device_node *np)
>  	pipe->pxlclk = clk;
> 
>  	/* enum ports */
> -	pipe->of_output_dev =
> +	pipe->of_output_links[0] =
>  		of_graph_get_remote_node(np, KOMEDA_OF_PORT_OUTPUT, 0);
> +	pipe->of_output_links[1] =
> +		of_graph_get_remote_node(np, KOMEDA_OF_PORT_OUTPUT, 1);
>  	pipe->of_output_port =
>  		of_graph_get_port_by_id(np, KOMEDA_OF_PORT_OUTPUT);
> 
> +	pipe->dual_link = pipe->of_output_links[0] && pipe->of_output_links[1];
>  	pipe->of_node = np;
> 
>  	return 0;
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> index aa4cef1fe84e..66e4ce8abd67 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> @@ -89,11 +89,12 @@ static int compare_of(struct device *dev, void *data)
> 
>  static void komeda_add_slave(struct device *master,
>  			     struct component_match **match,
> -			     struct device_node *np, int port)
> +			     struct device_node *np,
> +			     u32 port, u32 endpoint)
>  {
>  	struct device_node *remote;
> 
> -	remote = of_graph_get_remote_node(np, port, 0);
> +	remote = of_graph_get_remote_node(np, port, endpoint);
>  	if (remote) {
>  		drm_of_component_match_add(master, match, compare_of, remote);
>  		of_node_put(remote);
> @@ -114,7 +115,8 @@ static int komeda_platform_probe(struct platform_device *pdev)
>  			continue;
> 
>  		/* add connector */
> -		komeda_add_slave(dev, &match, child, KOMEDA_OF_PORT_OUTPUT);
> +		komeda_add_slave(dev, &match, child, KOMEDA_OF_PORT_OUTPUT, 0);
> +		komeda_add_slave(dev, &match, child, KOMEDA_OF_PORT_OUTPUT, 1);
>  	}
> 
>  	return component_master_add_with_match(dev, &komeda_master_ops, match);
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> index af6af1d55643..cf2122be2740 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> @@ -180,7 +180,7 @@ static inline bool has_flip_h(u32 rot)
>  		return !!(rotation & DRM_MODE_REFLECT_X);
>  }
> 
> -unsigned long komeda_calc_aclk(struct komeda_crtc_state *kcrtc_st);
> +unsigned long komeda_crtc_get_aclk(struct komeda_crtc_state *kcrtc_st);
> 
>  int komeda_kms_setup_crtcs(struct komeda_kms_dev *kms, struct komeda_dev *mdev);
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
> index 78e44d9e1520..452e505a1fd3 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
> @@ -54,7 +54,8 @@ void komeda_pipeline_destroy(struct komeda_dev *mdev,
> 
>  	clk_put(pipe->pxlclk);
> 
> -	of_node_put(pipe->of_output_dev);
> +	of_node_put(pipe->of_output_links[0]);
> +	of_node_put(pipe->of_output_links[1]);
>  	of_node_put(pipe->of_output_port);
>  	of_node_put(pipe->of_node);
> 
> @@ -246,9 +247,15 @@ static void komeda_pipeline_dump(struct komeda_pipeline *pipe)
>  	struct komeda_component *c;
>  	int id;
> 
> -	DRM_INFO("Pipeline-%d: n_layers: %d, n_scalers: %d, output: %s\n",
> +	DRM_INFO("Pipeline-%d: n_layers: %d, n_scalers: %d, output: %s.\n",
>  		 pipe->id, pipe->n_layers, pipe->n_scalers,
> -		 pipe->of_output_dev ? pipe->of_output_dev->full_name : "none");
> +		 pipe->dual_link ? "dual-link" : "single-link");
> +	DRM_INFO("	output_link[0]: %s.\n",
> +		 pipe->of_output_links[0] ?
> +		 pipe->of_output_links[0]->full_name : "none");
> +	DRM_INFO("	output_link[1]: %s.\n",
> +		 pipe->of_output_links[1] ?
> +		 pipe->of_output_links[1]->full_name : "none");
> 
>  	dp_for_each_set_bit(id, pipe->avail_comps) {
>  		c = komeda_pipeline_get_component(pipe, id);
> @@ -305,6 +312,12 @@ static void komeda_pipeline_assemble(struct komeda_pipeline *pipe)
> 
>  		layer->right = komeda_get_layer_split_right_layer(pipe, layer);
>  	}
> +
> +	if (pipe->dual_link && !pipe->ctrlr->supports_dual_link) {
> +		pipe->dual_link = false;
> +		DRM_WARN("PIPE-%d doesn't support dual-link, ignore DT dual-link configuration.\n",
> +			 pipe->id);
> +	}
>  }
> 
>  /* if pipeline_A accept another pipeline_B's component as input, treat
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> index 7af3e266bdff..059d76fc405d 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> @@ -419,8 +419,10 @@ struct komeda_pipeline {
>  	struct device_node *of_node;
>  	/** @of_output_port: pipeline output port */
>  	struct device_node *of_output_port;
> -	/** @of_output_dev: output connector device node */
> -	struct device_node *of_output_dev;
> +	/** @of_output_links: output connector device nodes */
> +	struct device_node *of_output_links[2];
> +	/** @dual_link: true if of_output_links[0] and [1] are both valid */
> +	bool dual_link;
>  };
> 
>  /**
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> index 257f0aedd11d..796cae61ffb3 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> @@ -473,7 +473,7 @@ komeda_scaler_check_cfg(struct komeda_scaler *scaler,
> 
>  		err = pipe->funcs->downscaling_clk_check(pipe,
>  					&kcrtc_st->base.adjusted_mode,
> -					komeda_calc_aclk(kcrtc_st), dflow);
> +					komeda_crtc_get_aclk(kcrtc_st), dflow);
>  		if (err) {
>  			DRM_DEBUG_ATOMIC("aclk can't satisfy the clock requirement of the downscaling\n");
>  			return err;
> --
> 2.17.1

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
