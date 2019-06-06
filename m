Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAF0C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 16:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 339D0208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 16:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="PQgR50TZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfFFQgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 12:36:36 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41767 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfFFQgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 12:36:36 -0400
Received: by mail-qk1-f196.google.com with SMTP id c11so1842453qkk.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 09:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=STDsoXP+pP2kkBjWE7AbnmJ4gXdqJUBbofwVvAfemWs=;
        b=PQgR50TZn+Ke3GnbJe8k0G/PFOCHXvPSXJec2go6hcGHOhUYyPspzvF6SjMF3fPdLM
         WuHCEEjr3lUfQ+IpKwwuMt6sPrMX9LyiLP3ziO1PW8OC5JOMuB+pD1OXYWFpJnuiShci
         ommHhdFzQYtabM/kdJBVpYbfxfU5VzPsKFbX73tZMX+cakbkPqiDGVHAs12fkh9jy225
         OxaeIi1pINWySoa8C7zrQ6UxTb4ickSVgPzJazTqZUQ1V9CeDS/GYn2Ct/54IEmkT8P3
         8fyDDyc8lB1/y6qXM1skJiCegtJGtm33cVok2Om6TBF+GUdRBKNpsC0okA3Y8GpijLGg
         mMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=STDsoXP+pP2kkBjWE7AbnmJ4gXdqJUBbofwVvAfemWs=;
        b=eMq9xCKuVPRrQ6bHabvUXyTrrzcwes5YuL3rKdFmNC8tjE2bN0cQe3hzUDn4i6IG0s
         NpC8nS6+0Egf3YU8hUpnrNnhIPWgnscIjaopwg4FWTwpiBgL6XlrPkyqLf5U4rFYS7tr
         zmq8rpEHU0C7ApLebPAUMyARq679r/ROZ2FxsVkdWQXXgD7qJRuPY7RCQ6id2rJosQwO
         x4HVyyzC65/eIoHIs/aOMOsR3jP7B5FzODyvCNQKRUwN7KXZMZGr9zjeffSIo1BKABox
         uBFrTWrOCASewjzvLx/dgXAjpWbqirOcusTbn674O5gjwxHt/rrUacHH5f5EsWcTH2KA
         gPlA==
X-Gm-Message-State: APjAAAU9Koks3o8liF6IyO1HOFpNucMJvUVqQ2j3oAWlIZaw57rc+zLY
        dlRoMXOekmdX7gD0IWrWfqXTyA==
X-Google-Smtp-Source: APXvYqzpj1H1CbzLQUyuVsyUmsnz4igWAdFlH5g0LzOPDJVCSL/w61N4HjhZWbY61HW0rU8n+hr/OQ==
X-Received: by 2002:a05:620a:1116:: with SMTP id o22mr37715818qkk.82.1559838994730;
        Thu, 06 Jun 2019 09:36:34 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id y29sm1179784qkj.8.2019.06.06.09.36.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 09:36:34 -0700 (PDT)
Date:   Thu, 6 Jun 2019 12:36:33 -0400
From:   Sean Paul <sean@poorly.run>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Sean Paul <seanpaul@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-rockchip@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>, mka@chromium.org,
        Jonas Karlman <jonas@kwiboo.se>,
        Zheng Yang <zhengyang@rock-chips.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v3 1/2] drm: bridge: dw-hdmi: Add hook for resume
Message-ID: <20190606163633.GH17077@art_vandelay>
References: <20190604204207.168085-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604204207.168085-1-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 01:42:06PM -0700, Douglas Anderson wrote:
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

Reviewed-by: Sean Paul <sean@poorly.run>

> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> 
> Changes in v3:
> - Change resume to void function (Laurent)
> 
> Changes in v2:
> - No empty stub for suspend (Laurent)
> - Refactor to use the same code in probe and resume (Laurent)
> - Unconditionally init i2c (seems OK + needed before hdmi->i2c init)
> - Combine "init" of i2c and "setup" of i2c (no reason to split)
> 
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 48 ++++++++++++++---------
>  include/drm/bridge/dw_hdmi.h              |  2 +
>  2 files changed, 31 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 66bd66bad44c..a00ccf123877 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -228,6 +228,13 @@ static void hdmi_mask_writeb(struct dw_hdmi *hdmi, u8 data, unsigned int reg,
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
> @@ -1926,16 +1933,6 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
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
> @@ -2436,6 +2433,21 @@ static const struct regmap_config hdmi_regmap_32bit_config = {
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
> @@ -2587,7 +2599,7 @@ __dw_hdmi_probe(struct platform_device *pdev,
>  		 prod_id1 & HDMI_PRODUCT_ID1_HDCP ? "with" : "without",
>  		 hdmi->phy.name);
>  
> -	initialize_hdmi_ih_mutes(hdmi);
> +	dw_hdmi_init_hw(hdmi);
>  
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
> @@ -2626,10 +2638,6 @@ __dw_hdmi_probe(struct platform_device *pdev,
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
> @@ -2682,10 +2690,6 @@ __dw_hdmi_probe(struct platform_device *pdev,
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
> @@ -2789,6 +2793,12 @@ void dw_hdmi_unbind(struct dw_hdmi *hdmi)
>  }
>  EXPORT_SYMBOL_GPL(dw_hdmi_unbind);
>  
> +void dw_hdmi_resume(struct dw_hdmi *hdmi)
> +{
> +	dw_hdmi_init_hw(hdmi);
> +}
> +EXPORT_SYMBOL_GPL(dw_hdmi_resume);
> +
>  MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
>  MODULE_AUTHOR("Andy Yan <andy.yan@rock-chips.com>");
>  MODULE_AUTHOR("Yakir Yang <ykk@rock-chips.com>");
> diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
> index 66e70770cce5..601243b56b69 100644
> --- a/include/drm/bridge/dw_hdmi.h
> +++ b/include/drm/bridge/dw_hdmi.h
> @@ -154,6 +154,8 @@ struct dw_hdmi *dw_hdmi_bind(struct platform_device *pdev,
>  			     struct drm_encoder *encoder,
>  			     const struct dw_hdmi_plat_data *plat_data);
>  
> +void dw_hdmi_resume(struct dw_hdmi *hdmi);
> +
>  void dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool hpd, bool rx_sense);
>  
>  void dw_hdmi_set_sample_rate(struct dw_hdmi *hdmi, unsigned int rate);
> -- 
> 2.22.0.rc1.311.g5d7573a151-goog
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
