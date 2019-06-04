Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B658C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D85AA24987
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Pq5xdg30"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfFDMuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 08:50:05 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:48030 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbfFDMuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 08:50:04 -0400
Received: from pendragon.ideasonboard.com (unknown [IPv6:2a02:2788:668:163:5bb7:9f6c:564c:d55e])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 38CA02D1;
        Tue,  4 Jun 2019 14:50:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1559652602;
        bh=49AXk+Qk9s0ffpOBjkaJWUGYPSwhbMANLkqmpJAIs0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pq5xdg303rmgusvJWmZE5zLcpVJgX2KME5ag1uy+HPylZBBug6iPN6Lyq5beNr1p0
         m36g10rGucJ9uploJyFGYYc5BRx2+5IXpw+Cz+R3yOTOwRVUXOlt1xz432IcnUj+7O
         yPzEqc1yOLPTkNraXBQ4SvJDPbzg+BIKAs2cLcuc=
Date:   Tue, 4 Jun 2019 15:49:48 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, mka@chromium.org,
        Sean Paul <seanpaul@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v2 1/2] drm: bridge: dw-hdmi: Add hook for resume
Message-ID: <20190604124948.GF7812@pendragon.ideasonboard.com>
References: <20190516214022.65220-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190516214022.65220-1-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Douglas,

Thank you for the patch.

On Thu, May 16, 2019 at 02:40:21PM -0700, Douglas Anderson wrote:
> On Rockchip rk3288-based Chromebooks when you do a suspend/resume
> cycle:
> 
> 1. You lose the ability to detect an HDMI device being plugged in.
> 
> 2. If you're using the i2c bus built in to dw_hdmi then it stops
> working.
> 
> Let's add a hook to the core dw-hdmi driver so that we can call it in
> dw_hdmi-rockchip in the next commit.
> 
> NOTE: the exact set of steps I've done here in resume come from
> looking at the normal dw_hdmi init sequence in upstream Linux plus the
> sequence that we did in downstream Chrome OS 3.14.  Testing show that
> it seems to work, but if an extra step is needed or something here is
> not needed we could improve it.
> 
> As part of this change we'll refactor the hardware init bits of
> dw-hdmi to happen all in one function and all at the same time.  Since
> we need to init the interrupt mutes before we request the IRQ, this
> means moving the hardware init earlier in the function, but there
> should be no problems with that.  Also as part of this we now
> unconditionally init the "i2c" parts of dw-hdmi, but again that ought
> to be fine.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> Changes in v2:
> - No empty stub for suspend (Laurent)
> - Refactor to use the same code in probe and resume (Laurent)
> - Unconditionally init i2c (seems OK + needed before hdmi->i2c init)
> - Combine "init" of i2c and "setup" of i2c (no reason to split)
> 
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 50 ++++++++++++++---------
>  include/drm/bridge/dw_hdmi.h              |  2 +
>  2 files changed, 33 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index ab7968c8f6a2..636d55d1398c 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -227,6 +227,13 @@ static void hdmi_mask_writeb(struct dw_hdmi *hdmi, u8 data, unsigned int reg,
>  
>  static void dw_hdmi_i2c_init(struct dw_hdmi *hdmi)
>  {
> +	hdmi_writeb(hdmi, HDMI_PHY_I2CM_INT_ADDR_DONE_POL,
> +		    HDMI_PHY_I2CM_INT_ADDR);
> +
> +	hdmi_writeb(hdmi, HDMI_PHY_I2CM_CTLINT_ADDR_NAC_POL |
> +		    HDMI_PHY_I2CM_CTLINT_ADDR_ARBITRATION_POL,
> +		    HDMI_PHY_I2CM_CTLINT_ADDR);
> +
>  	/* Software reset */
>  	hdmi_writeb(hdmi, 0x00, HDMI_I2CM_SOFTRSTZ);
>  
> @@ -1925,16 +1932,6 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
>  	return 0;
>  }
>  
> -static void dw_hdmi_setup_i2c(struct dw_hdmi *hdmi)
> -{
> -	hdmi_writeb(hdmi, HDMI_PHY_I2CM_INT_ADDR_DONE_POL,
> -		    HDMI_PHY_I2CM_INT_ADDR);
> -
> -	hdmi_writeb(hdmi, HDMI_PHY_I2CM_CTLINT_ADDR_NAC_POL |
> -		    HDMI_PHY_I2CM_CTLINT_ADDR_ARBITRATION_POL,
> -		    HDMI_PHY_I2CM_CTLINT_ADDR);
> -}
> -
>  static void initialize_hdmi_ih_mutes(struct dw_hdmi *hdmi)
>  {
>  	u8 ih_mute;
> @@ -2435,6 +2432,21 @@ static const struct regmap_config hdmi_regmap_32bit_config = {
>  	.max_register	= HDMI_I2CM_FS_SCL_LCNT_0_ADDR << 2,
>  };
>  
> +static void dw_hdmi_init_hw(struct dw_hdmi *hdmi)
> +{
> +	initialize_hdmi_ih_mutes(hdmi);
> +
> +	/*
> +	 * Reset HDMI DDC I2C master controller and mute I2CM interrupts.
> +	 * Even if we are using a separate i2c adapter doing this doesn't
> +	 * hurt.
> +	 */
> +	dw_hdmi_i2c_init(hdmi);
> +
> +	if (hdmi->phy.ops->setup_hpd)
> +		hdmi->phy.ops->setup_hpd(hdmi, hdmi->phy.data);
> +}
> +
>  static struct dw_hdmi *
>  __dw_hdmi_probe(struct platform_device *pdev,
>  		const struct dw_hdmi_plat_data *plat_data)
> @@ -2586,7 +2598,7 @@ __dw_hdmi_probe(struct platform_device *pdev,
>  		 prod_id1 & HDMI_PRODUCT_ID1_HDCP ? "with" : "without",
>  		 hdmi->phy.name);
>  
> -	initialize_hdmi_ih_mutes(hdmi);
> +	dw_hdmi_init_hw(hdmi);
>  
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
> @@ -2625,10 +2637,6 @@ __dw_hdmi_probe(struct platform_device *pdev,
>  	hdmi->bridge.of_node = pdev->dev.of_node;
>  #endif
>  
> -	dw_hdmi_setup_i2c(hdmi);
> -	if (hdmi->phy.ops->setup_hpd)
> -		hdmi->phy.ops->setup_hpd(hdmi, hdmi->phy.data);
> -
>  	memset(&pdevinfo, 0, sizeof(pdevinfo));
>  	pdevinfo.parent = dev;
>  	pdevinfo.id = PLATFORM_DEVID_AUTO;
> @@ -2681,10 +2689,6 @@ __dw_hdmi_probe(struct platform_device *pdev,
>  		hdmi->cec = platform_device_register_full(&pdevinfo);
>  	}
>  
> -	/* Reset HDMI DDC I2C master controller and mute I2CM interrupts */
> -	if (hdmi->i2c)
> -		dw_hdmi_i2c_init(hdmi);
> -
>  	return hdmi;
>  
>  err_iahb:
> @@ -2788,6 +2792,14 @@ void dw_hdmi_unbind(struct dw_hdmi *hdmi)
>  }
>  EXPORT_SYMBOL_GPL(dw_hdmi_unbind);
>  
> +int dw_hdmi_resume(struct dw_hdmi *hdmi)
> +{
> +	dw_hdmi_init_hw(hdmi);
> +
> +	return 0;
> +}

If the function always returns 0 I would make it void. Apart from that,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +EXPORT_SYMBOL_GPL(dw_hdmi_resume);
> +
>  MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
>  MODULE_AUTHOR("Andy Yan <andy.yan@rock-chips.com>");
>  MODULE_AUTHOR("Yakir Yang <ykk@rock-chips.com>");
> diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
> index 66e70770cce5..1626731e1681 100644
> --- a/include/drm/bridge/dw_hdmi.h
> +++ b/include/drm/bridge/dw_hdmi.h
> @@ -154,6 +154,8 @@ struct dw_hdmi *dw_hdmi_bind(struct platform_device *pdev,
>  			     struct drm_encoder *encoder,
>  			     const struct dw_hdmi_plat_data *plat_data);
>  
> +int dw_hdmi_resume(struct dw_hdmi *hdmi);
> +
>  void dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool hpd, bool rx_sense);
>  
>  void dw_hdmi_set_sample_rate(struct dw_hdmi *hdmi, unsigned int rate);

-- 
Regards,

Laurent Pinchart
