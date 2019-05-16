Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD4FC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 10:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DAEE205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 10:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="liOxQDvX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfEPKSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 06:18:18 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:55422 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfEPKSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 06:18:18 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 11F4B320;
        Thu, 16 May 2019 12:18:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1558001896;
        bh=kzLY4Yw2M9JQvyUjiZQ70U/NxQtmDWpBcjhnf9P1Tyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=liOxQDvXOnnTBSiSw2xxDatXOTMuu8pX37BIJKL1PfVVk2x/0PWXU4b9oAVqte0y6
         l48Kevcm2NYFt2uNwQviKin+IhnczEkkVGqQ3AZPJ2avZwof0/QGI22M4qRTPZThlL
         aHWKaw5JNxLhhk1gBiI9qSRBCfCOlDqqpk9iH7as=
Date:   Thu, 16 May 2019 13:18:00 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        linux-rockchip@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>, mka@chromium.org,
        Sean Paul <seanpaul@chromium.org>,
        Zheng Yang <zhengyang@rock-chips.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 1/2] drm: bridge: dw-hdmi: Add hooks for suspend/resume
Message-ID: <20190516101800.GE4995@pendragon.ideasonboard.com>
References: <20190502223808.185180-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190502223808.185180-1-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Douglas,

Thank you for the patch.

On Thu, May 02, 2019 at 03:38:07PM -0700, Douglas Anderson wrote:
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
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 21 +++++++++++++++++++++
>  include/drm/bridge/dw_hdmi.h              |  3 +++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index db761329a1e3..4b38bfd43e59 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -2780,6 +2780,27 @@ void dw_hdmi_unbind(struct dw_hdmi *hdmi)
>  }
>  EXPORT_SYMBOL_GPL(dw_hdmi_unbind);
>  
> +int dw_hdmi_suspend(struct dw_hdmi *hdmi)
> +{
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dw_hdmi_suspend);
> +

As this is empty, should we leave it out ? It adds a bit of bloat to the
kernel for no real reason, and we can add it later if required.

> +int dw_hdmi_resume(struct dw_hdmi *hdmi)
> +{
> +	initialize_hdmi_ih_mutes(hdmi);
> +
> +	dw_hdmi_setup_i2c(hdmi);
> +	if (hdmi->i2c)
> +		dw_hdmi_i2c_init(hdmi);
> +
> +	if (hdmi->phy.ops->setup_hpd)
> +		hdmi->phy.ops->setup_hpd(hdmi, hdmi->phy.data);
> +
> +	return 0;

How about refactoring the probe function to extract hardware
initialisation to a separate function, and calling it from here ?

> +}
> +EXPORT_SYMBOL_GPL(dw_hdmi_resume);
> +
>  MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
>  MODULE_AUTHOR("Andy Yan <andy.yan@rock-chips.com>");
>  MODULE_AUTHOR("Yakir Yang <ykk@rock-chips.com>");
> diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
> index 66e70770cce5..c4132e9a5ae3 100644
> --- a/include/drm/bridge/dw_hdmi.h
> +++ b/include/drm/bridge/dw_hdmi.h
> @@ -154,6 +154,9 @@ struct dw_hdmi *dw_hdmi_bind(struct platform_device *pdev,
>  			     struct drm_encoder *encoder,
>  			     const struct dw_hdmi_plat_data *plat_data);
>  
> +int dw_hdmi_suspend(struct dw_hdmi *hdmi);
> +int dw_hdmi_resume(struct dw_hdmi *hdmi);
> +
>  void dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool hpd, bool rx_sense);
>  
>  void dw_hdmi_set_sample_rate(struct dw_hdmi *hdmi, unsigned int rate);

-- 
Regards,

Laurent Pinchart
