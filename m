Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183EDC10F05
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7EBF20882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Bx7jRVNr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfDDHrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:47:12 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43036 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfDDHrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 03:47:12 -0400
Received: by mail-ed1-f66.google.com with SMTP id d26so1244961ede.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 00:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=gdxfcS2kGRaSjIP/SHS0OUrImmhlg820vTEjIpjlgm8=;
        b=Bx7jRVNrM8BhvRmgbsK7uJMmhRZAjomw7B6mcbPSfYkr7al86sQ9Wjqy+SAYIs7E6f
         SkJNR11Vf6vW3KlCBj61pj9YnxgGwtO2dNVSmItxiM3AHXFKmBzKEG2/1cL8k6XYmL6f
         kQ2qTyIJI1HHrZWGyrzS9tW80T+xlOvhRKGyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=gdxfcS2kGRaSjIP/SHS0OUrImmhlg820vTEjIpjlgm8=;
        b=fMaAtfUEeoM2s6fkaAXaJvS6qdxxz8kibkJFnlNs7c05EcQeNQQM2NwW8xThqHdrag
         WqlXOaq8c0zGsf/8SRFsB5iVCFu5DAWO2UDr2uM+F0mPpgJLkxAHbXcYvIqcjsu6ylFS
         jeZeOQAN6JKnzM/DGAhlUiD8UVz0YMwr4ATFoomcxJLF+pbjobDLACYU1eSftFVL+GUm
         JX8ML9zHO1uXlcRte3+nXw6DDfFKnNmf+TXsI0h9xmosSsY5QSMqvQG3LvfweH+AQTQb
         E7Yn06brV65zwG522CSsgw9eZgH3TWcTAkFmJtZU5nibZGXq1VXMK2JAO4+sKE1fyLpT
         6HeQ==
X-Gm-Message-State: APjAAAX/UG9j5o6sIxywrblikb8J7mXjY3XYiA+78dljRlWaY69AZxK5
        cYQ+IjA3Zruacf9en778YxuxXQ==
X-Google-Smtp-Source: APXvYqyEevlJP1y8O/0u7aebO0Xw7LQgK7jGWZEgLNnpcmmGmacfu3kc83nQNRxKE0fkir4s0S3oPw==
X-Received: by 2002:a17:906:3db1:: with SMTP id y17mr2667080ejh.90.1554364029551;
        Thu, 04 Apr 2019 00:47:09 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id ga13sm3444192ejb.9.2019.04.04.00.47.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 00:47:08 -0700 (PDT)
Date:   Thu, 4 Apr 2019 09:47:06 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     VenkataRajesh.Kalakodima@in.bosch.com
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Balasubramani Vivekanandan 
        <balasubramani_vivekanandan@mentor.com>,
        Steve Longerbeam <steve_longerbeam@mentor.com>,
        Koji Matsuoka <koji.matsuoka.xm@renesas.com>
Subject: Re: [PATCH 8/8] drm: rcar-du: Add shutdown callback function in
 platform_driver
Message-ID: <20190404074706.GO2665@phenom.ffwll.local>
Mail-Followup-To: VenkataRajesh.Kalakodima@in.bosch.com,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Balasubramani Vivekanandan <balasubramani_vivekanandan@mentor.com>,
        Steve Longerbeam <steve_longerbeam@mentor.com>,
        Koji Matsuoka <koji.matsuoka.xm@renesas.com>
References: <1554297284-14009-1-git-send-email-VenkataRajesh.Kalakodima@in.bosch.com>
 <1554297284-14009-9-git-send-email-VenkataRajesh.Kalakodima@in.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554297284-14009-9-git-send-email-VenkataRajesh.Kalakodima@in.bosch.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 06:44:44PM +0530, VenkataRajesh.Kalakodima@in.bosch.com wrote:
> From: kalakodima venkata rajesh <venkatarajesh.kalakodima@in.bosch.com>
> 
> When rebooting, the Display driver is accessing H/W (reading DDR).
> Therefore, there is a problem of hanging when setting DDR to self
> refresh mode.
> 
> This patch implement the shutdown function and solve this problem
> by stopping H/W access.
> 
> In addtion, on the ulcb board, since initial values of versaclock
> are used as they are, signals are not output when initializing to
> 0 with shutdown, so this patch excludes processing to initialize
> versaclock to 0.
> drm: rcar-du: Add HDMI control clock when S2RAM
> 
> Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
> 
> (cherry picked from horms/renesas-bsp commit 3cfda6331c4069800dd4434427284aba8e6f1ed6)
> [slongerbeam: keep integer i in rcar_du_pm_shutdown(), needed because of
>  050e54d87f ("drm: rcar-du: drm: rcar-du: Add DU CMM support")]
> 
> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>

Maybe look into drm_atomic_helper_shutdown instead of hand-rolling? That
should disable all display related stuff for you.
-Daniel

> 
> drm: rcar-du: cmm: lut and clu backup not required during
>  shutdown
> rcar_du_cmm_pm_suspend function copies LUT and CLU hardare
> register values to memory. In the patch which adds DU CMM
> support (https://github.com/renesas-rcar/du_cmm/commit/
> 9a65d02119e4ae405a89a850463a6a0d0f2c1ecb), the intention of
> the author was to backup the registers during suspend and
> restore it on resume. But rcar_du_cmm_pm_suspend was also
> called on system shutdown. Though it does not cause any harm,
> it is not required during shutdown as it does not make sense
> to backup. This patch ensures that rcar_du_cmm_pm_suspend is
> called only during suspend
> 
> Fixes: https://github.com/renesas-rcar/du_cmm/commit/9a65d02119e4ae405a89a850463a6a0d0f2c1ecb
> 
> Signed-off-by: Balasubramani Vivekanandan <balasubramani_vivekanandan@mentor.com>
> 
>       - Resolved checkpatch errors
>       - Resolved merge conflicts according to latest version
> 
> Signed-off-by: kalakodima venkata rajesh <venkatarajesh.kalakodima@in.bosch.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 35 ++++++++++++++++++++
>  drivers/gpu/drm/rcar-du/rcar_du_drv.c     | 54 +++++++++++++++++++++++++------
>  drivers/gpu/drm/rcar-du/rcar_du_encoder.c |  2 +-
>  drivers/gpu/drm/rcar-du/rcar_du_encoder.h |  1 +
>  include/drm/bridge/dw_hdmi.h              |  1 +
>  5 files changed, 83 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 5971976..aa257d7 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -2033,6 +2033,41 @@ static void dw_hdmi_bridge_enable(struct drm_bridge *bridge)
>  	mutex_unlock(&hdmi->mutex);
>  }
>  
> +/*
> + * This function controls clocks of dw_hdmi through drm_bridge
> + * at system suspend/resume.
> + * Arguments:
> + *  bridge: drm_bridge that contains dw_hdmi.
> + *  flag: controlled flag.
> + *		false: is used when suspend.
> + *		true: is used when resume.
> + */
> +void dw_hdmi_s2r_ctrl(struct drm_bridge *bridge, int flag)
> +{
> +	struct dw_hdmi *hdmi = bridge->driver_private;
> +
> +	if (!hdmi)
> +		return;
> +
> +	if (flag) { /* enable clk */
> +		if (hdmi->isfr_clk)
> +			clk_prepare_enable(hdmi->isfr_clk);
> +		if (hdmi->iahb_clk)
> +			clk_prepare_enable(hdmi->iahb_clk);
> +
> +		initialize_hdmi_ih_mutes(hdmi);
> +		dw_hdmi_setup_i2c(hdmi);
> +		dw_hdmi_i2c_init(hdmi);
> +		dw_hdmi_phy_setup_hpd(hdmi, NULL);
> +	} else { /* disable clk */
> +		if (hdmi->isfr_clk)
> +			clk_disable_unprepare(hdmi->isfr_clk);
> +		if (hdmi->iahb_clk)
> +			clk_disable_unprepare(hdmi->iahb_clk);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(dw_hdmi_s2r_ctrl);
> +
>  static const struct drm_bridge_funcs dw_hdmi_bridge_funcs = {
>  	.attach = dw_hdmi_bridge_attach,
>  	.enable = dw_hdmi_bridge_enable,
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> index 838b7c9..9eb63b0 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> @@ -21,6 +21,7 @@
>  #include <linux/slab.h>
>  #include <linux/wait.h>
>  
> +#include <drm/bridge/dw_hdmi.h>
>  #include <drm/drmP.h>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_crtc_helper.h>
> @@ -368,18 +369,14 @@ static struct drm_driver rcar_du_driver = {
>   */
>  
>  #ifdef CONFIG_PM_SLEEP
> -static int rcar_du_pm_suspend(struct device *dev)
> +static int rcar_du_pm_shutdown(struct device *dev)
>  {
>  	struct rcar_du_device *rcdu = dev_get_drvdata(dev);
>  	struct drm_atomic_state *state;
> -	int i;
> -
> -	if (rcar_du_has(rcdu, RCAR_DU_FEATURE_CMM)) {
> -		for (i = 0; i < rcdu->num_crtcs; ++i)
> -			rcar_du_cmm_pm_suspend(&rcdu->crtcs[i]);
> -	}
> -
> -	drm_kms_helper_poll_disable(rcdu->ddev);
> +#if IS_ENABLED(CONFIG_DRM_RCAR_DW_HDMI)
> +	struct drm_encoder *encoder;
> +#endif
> +		drm_kms_helper_poll_disable(rcdu->ddev);
>  	drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, true);
>  
>  	state = drm_atomic_helper_suspend(rcdu->ddev);
> @@ -389,11 +386,43 @@ static int rcar_du_pm_suspend(struct device *dev)
>  		return PTR_ERR(state);
>  	}
>  
> +#if IS_ENABLED(CONFIG_DRM_RCAR_DW_HDMI)
> +	list_for_each_entry(encoder,
> +			    &rcdu->ddev->mode_config.encoder_list,
> +			    head) {
> +		struct rcar_du_encoder *renc = to_rcar_encoder(encoder);
> +
> +		if (renc->bridge && (renc->output == RCAR_DU_OUTPUT_HDMI0 ||
> +				     renc->output == RCAR_DU_OUTPUT_HDMI1))
> +			dw_hdmi_s2r_ctrl(encoder->bridge, false);
> +	}
> +#endif
>  	rcdu->suspend_state = state;
>  
>  	return 0;
>  }
>  
> +static int rcar_du_pm_suspend(struct device *dev)
> +{
> +	struct rcar_du_device *rcdu = dev_get_drvdata(dev);
> +
> +	int i, ret;
> +
> +	if (rcar_du_has(rcdu, RCAR_DU_FEATURE_CMM)) {
> +		for (i = 0; i < rcdu->num_crtcs; ++i)
> +			rcar_du_cmm_pm_suspend(&rcdu->crtcs[i]);
> +	}
> +
> +	ret = rcar_du_pm_shutdown(dev);
> +
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < rcdu->num_crtcs; ++i)
> +		clk_set_rate(rcdu->crtcs[i].extclock, 0);
> +	return 0;
> +}
> +
>  static int rcar_du_pm_resume(struct device *dev)
>  {
>  	struct rcar_du_device *rcdu = dev_get_drvdata(dev);
> @@ -504,6 +533,12 @@ static int rcar_du_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static void rcar_du_shutdown(struct platform_device *pdev)
> +{
> +#ifdef CONFIG_PM_SLEEP
> +	rcar_du_pm_shutdown(&pdev->dev);
> +#endif
> +}
>  static struct platform_driver rcar_du_platform_driver = {
>  	.probe		= rcar_du_probe,
>  	.remove		= rcar_du_remove,
> @@ -512,6 +547,7 @@ static struct platform_driver rcar_du_platform_driver = {
>  		.pm	= &rcar_du_pm_ops,
>  		.of_match_table = rcar_du_of_table,
>  	},
> +	.shutdown       = rcar_du_shutdown,
>  };
>  
>  static int __init rcar_du_init(void)
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
> index f9c933d..98df8a2 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
> @@ -62,7 +62,7 @@ int rcar_du_encoder_init(struct rcar_du_device *rcdu,
>  
>  	dev_dbg(rcdu->dev, "initializing encoder %pOF for output %u\n",
>  		enc_node, output);
> -
> +	renc->bridge = bridge;
>  	/* Locate the DRM bridge from the encoder DT node. */
>  	bridge = of_drm_find_bridge(enc_node);
>  	if (!bridge) {
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_encoder.h b/drivers/gpu/drm/rcar-du/rcar_du_encoder.h
> index 2d2abca..cc5bfcb 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_encoder.h
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_encoder.h
> @@ -23,6 +23,7 @@ struct rcar_du_device;
>  struct rcar_du_encoder {
>  	struct drm_encoder base;
>  	enum rcar_du_output output;
> +	struct drm_bridge *bridge;
>  };
>  
>  #define to_rcar_encoder(e) \
> diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
> index ccb5aa8..36383cf4 100644
> --- a/include/drm/bridge/dw_hdmi.h
> +++ b/include/drm/bridge/dw_hdmi.h
> @@ -171,5 +171,6 @@ enum drm_connector_status dw_hdmi_phy_read_hpd(struct dw_hdmi *hdmi,
>  void dw_hdmi_phy_update_hpd(struct dw_hdmi *hdmi, void *data,
>  			    bool force, bool disabled, bool rxsense);
>  void dw_hdmi_phy_setup_hpd(struct dw_hdmi *hdmi, void *data);
> +void dw_hdmi_s2r_ctrl(struct drm_bridge *bridge, int flag);
>  
>  #endif /* __IMX_HDMI_H__ */
> -- 
> 2.7.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
