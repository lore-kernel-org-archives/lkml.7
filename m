Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A68C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9446F2087E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="dKwtWkJB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfEOSUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 14:20:45 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34843 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfEOSUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 14:20:40 -0400
Received: by mail-qt1-f194.google.com with SMTP id a39so846588qtk.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 11:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v/0i4suNLrZlvLYCymnJUzWMiUujcvtmtoNvzuC9xPk=;
        b=dKwtWkJBxN4Ffyi6WayRfbCyUB29AkQMdx3yr8GO0yMT82FxN86x3iFEYMj/enkanw
         CEkqNy97kqREecZQQHG5xz5fdRAq1MiGJujwXNGblfmxDBjUdIbyyaauV6ir4uLsT/4o
         9qd/BnaKqmdsP6BOvPc+d36qcEjQcF9TvarAu5/Y0X3Zb8CFEDjR5cseL/KlG8GQmKOr
         O+182LfChBB1T4DjYHL3OEb6rBXTJ5Jyi6JV5zWXJNLzAzfhQArSdO7W9S6iRZA2CP+F
         etu6DAssYupHdCJrpvVPfhXHCRB4g8hZ6k+fDi0L4fJgNqMuISaYO8QY8cTu282xWYz7
         BtWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v/0i4suNLrZlvLYCymnJUzWMiUujcvtmtoNvzuC9xPk=;
        b=OXac4/NJIr2Wy3i1EkgVqwprNuSFHn1LQci/dbq/Kf8omI0gN/Qvl7ZiGODb964rUW
         nVOqMoUHu1QJoozQYmOo6BjhRUihnITbBII0N+71sOtkOvl2nt02f1CNbd5EhcHurQHk
         kozmDvOstQIFJsiuXHoWQ0cbMxJvIqtlnMA4H7Qha4I6G/epDfdWuGnh/ihwRvvJbQJf
         Ve3mFoPZuqqo1JczIRVwORXVnPnRbpWGIGV3kl7fyhw1XA6GVjNj4EGQNA1jC6XNjkg6
         bMw8FgOxADFldsfYjfEck+sv93HSWCypAUj5W7+ig1dlmUPtiqBd0peAXxdcVY/gK8e+
         pBJw==
X-Gm-Message-State: APjAAAX5u3IFR7FlFDXAzG13O/meRppKaE2sq3jeyD1N43gPtB4Gol35
        kKmOumZTRu7HKfidujgm571v5A==
X-Google-Smtp-Source: APXvYqy2Ftu9tGgy5VThvdaW8121BYKmev4Dui5YBA07+f4Avqy70b0KFtuOSd05AcYAcDOr2XEf1A==
X-Received: by 2002:a0c:86e5:: with SMTP id 34mr28715424qvg.201.1557944439349;
        Wed, 15 May 2019 11:20:39 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id w41sm1896116qtc.49.2019.05.15.11.20.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 11:20:38 -0700 (PDT)
Date:   Wed, 15 May 2019 14:20:38 -0400
From:   Sean Paul <sean@poorly.run>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, mka@chromium.org,
        Sean Paul <seanpaul@chromium.org>
Subject: Re: [PATCH 2/5] drm/bridge/synopsys: dw-hdmi: Add "unwedge" for ddc
 bus
Message-ID: <20190515182038.GV17077@art_vandelay>
References: <20190502225336.206885-1-dianders@chromium.org>
 <20190502225336.206885-2-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502225336.206885-2-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 03:53:33PM -0700, Douglas Anderson wrote:
> See the PhD thesis in the comments in this patch for details, but to
> summarize this adds a hacky "unwedge" feature to the dw_hdmi i2c bus to
> workaround what appears to be a hardware errata.  This relies on a
> pinctrl entry to help change around muxing to perform the unwedge.
> 
> NOTE that the specific TV this was tested on was the "Samsung
> UN40HU6950FXZA" and the specific port was the "STB" port.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 116 +++++++++++++++++++---
>  1 file changed, 100 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index db761329a1e3..c66587e33813 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -19,6 +19,7 @@
>  #include <linux/hdmi.h>
>  #include <linux/mutex.h>
>  #include <linux/of_device.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/regmap.h>
>  #include <linux/spinlock.h>
>  
> @@ -169,6 +170,10 @@ struct dw_hdmi {
>  	bool sink_is_hdmi;
>  	bool sink_has_audio;
>  
> +	struct pinctrl *pinctrl;
> +	struct pinctrl_state *default_state;
> +	struct pinctrl_state *unwedge_state;
> +
>  	struct mutex mutex;		/* for state below and previous_mode */
>  	enum drm_connector_force force;	/* mutex-protected force state */
>  	bool disabled;			/* DRM has disabled our bridge */
> @@ -247,11 +252,82 @@ static void dw_hdmi_i2c_init(struct dw_hdmi *hdmi)
>  		    HDMI_IH_MUTE_I2CM_STAT0);
>  }
>  
> +static bool dw_hdmi_i2c_unwedge(struct dw_hdmi *hdmi)
> +{
> +	/* If no unwedge state then give up */
> +	if (IS_ERR(hdmi->unwedge_state))
> +		return false;
> +
> +	dev_info(hdmi->dev, "Attempting to unwedge stuck i2c bus\n");
> +
> +	/*
> +	 * This is a huge hack to workaround a problem where the dw_hdmi i2c
> +	 * bus could sometimes get wedged.  Once wedged there doesn't appear
> +	 * to be any way to unwedge it (including the HDMI_I2CM_SOFTRSTZ)
> +	 * other than pulsing the SDA line.
> +	 *
> +	 * We appear to be able to pulse the SDA line (in the eyes of dw_hdmi)
> +	 * by:
> +	 * 1. Remux the pin as a GPIO output, driven low.
> +	 * 2. Wait a little while.  1 ms seems to work, but we'll do 10.
> +	 * 3. Immediately jump to remux the pin as dw_hdmi i2c again.
> +	 *
> +	 * At the moment of remuxing, the line will still be low due to its
> +	 * recent stint as an output, but then it will be pulled high by the
> +	 * (presumed) external pullup.  dw_hdmi seems to see this as a rising
> +	 * edge and that seems to get it out of its jam.
> +	 *
> +	 * This wedging was only ever seen on one TV, and only on one of
> +	 * its HDMI ports.  It happened when the TV was powered on while the
> +	 * device was plugged in.  A scope trace shows the TV bringing both SDA
> +	 * and SCL low, then bringing them both back up at roughly the same
> +	 * time.  Presumably this confuses dw_hdmi because it saw activity but
> +	 * no real STOP (maybe it thinks there's another master on the bus?).
> +	 * Giving it a clean rising edge of SDA while SCL is already high
> +	 * presumably makes dw_hdmi see a STOP which seems to bring dw_hdmi out
> +	 * of its stupor.
> +	 *
> +	 * Note that after coming back alive, transfers seem to immediately
> +	 * resume, so if we unwedge due to a timeout we should wait a little
> +	 * longer for our transfer to finish, since it might have just started
> +	 * now.
> +	 */
> +	pinctrl_select_state(hdmi->pinctrl, hdmi->unwedge_state);
> +	msleep(10);
> +	pinctrl_select_state(hdmi->pinctrl, hdmi->default_state);
> +
> +	return true;
> +}
> +
> +static int dw_hdmi_i2c_wait(struct dw_hdmi *hdmi)
> +{
> +	struct dw_hdmi_i2c *i2c = hdmi->i2c;
> +	int stat;
> +
> +	stat = wait_for_completion_timeout(&i2c->cmp, HZ / 10);
> +	if (!stat) {
> +		/* If we can't unwedge, return timeout */
> +		if (!dw_hdmi_i2c_unwedge(hdmi))
> +			return -EAGAIN;
> +
> +		/* We tried to unwedge; give it another chance */
> +		stat = wait_for_completion_timeout(&i2c->cmp, HZ / 10);
> +		if (!stat)
> +			return -EAGAIN;
> +	}
> +
> +	/* Check for error condition on the bus */
> +	if (i2c->stat & HDMI_IH_I2CM_STAT0_ERROR)
> +		return -EIO;
> +
> +	return 0;
> +}
> +
>  static int dw_hdmi_i2c_read(struct dw_hdmi *hdmi,
>  			    unsigned char *buf, unsigned int length)
>  {
>  	struct dw_hdmi_i2c *i2c = hdmi->i2c;
> -	int stat;
> +	int ret;
>  
>  	if (!i2c->is_regaddr) {
>  		dev_dbg(hdmi->dev, "set read register address to 0\n");
> @@ -270,13 +346,9 @@ static int dw_hdmi_i2c_read(struct dw_hdmi *hdmi,
>  			hdmi_writeb(hdmi, HDMI_I2CM_OPERATION_READ,
>  				    HDMI_I2CM_OPERATION);
>  
> -		stat = wait_for_completion_timeout(&i2c->cmp, HZ / 10);
> -		if (!stat)
> -			return -EAGAIN;
> -
> -		/* Check for error condition on the bus */
> -		if (i2c->stat & HDMI_IH_I2CM_STAT0_ERROR)
> -			return -EIO;
> +		ret = dw_hdmi_i2c_wait(hdmi);
> +		if (ret)
> +			return ret;
>  
>  		*buf++ = hdmi_readb(hdmi, HDMI_I2CM_DATAI);
>  	}
> @@ -289,7 +361,7 @@ static int dw_hdmi_i2c_write(struct dw_hdmi *hdmi,
>  			     unsigned char *buf, unsigned int length)
>  {
>  	struct dw_hdmi_i2c *i2c = hdmi->i2c;
> -	int stat;
> +	int ret;
>  
>  	if (!i2c->is_regaddr) {
>  		/* Use the first write byte as register address */
> @@ -307,13 +379,9 @@ static int dw_hdmi_i2c_write(struct dw_hdmi *hdmi,
>  		hdmi_writeb(hdmi, HDMI_I2CM_OPERATION_WRITE,
>  			    HDMI_I2CM_OPERATION);
>  
> -		stat = wait_for_completion_timeout(&i2c->cmp, HZ / 10);
> -		if (!stat)
> -			return -EAGAIN;
> -
> -		/* Check for error condition on the bus */
> -		if (i2c->stat & HDMI_IH_I2CM_STAT0_ERROR)
> -			return -EIO;
> +		ret = dw_hdmi_i2c_wait(hdmi);
> +		if (ret)
> +			return ret;
>  	}
>  
>  	return 0;
> @@ -2606,6 +2674,22 @@ __dw_hdmi_probe(struct platform_device *pdev,
>  
>  	/* If DDC bus is not specified, try to register HDMI I2C bus */
>  	if (!hdmi->ddc) {
> +		/* Look for (optional) stuff related to unwedging */
> +		hdmi->pinctrl = devm_pinctrl_get(dev);
> +		if (!IS_ERR(hdmi->pinctrl)) {
> +			hdmi->unwedge_state =
> +				pinctrl_lookup_state(hdmi->pinctrl, "unwedge");
> +			hdmi->default_state =
> +				pinctrl_lookup_state(hdmi->pinctrl, "default");
> +
> +			if (IS_ERR(hdmi->default_state) &&
> +			    !IS_ERR(hdmi->unwedge_state)) {
> +				dev_warn(dev,
> +					 "Unwedge requires default pinctrl\n");

Can you downgrade this message to info or dbg? Given how rare this issue is, we
probably don't want to spam everyone who is happily using dw-hdmi.

With that, 

Reviewed-by: Sean Paul <sean@poorly.run>


Sean

> +				hdmi->unwedge_state = ERR_PTR(-ENODEV);
> +			}
> +		}
> +
>  		hdmi->ddc = dw_hdmi_i2c_adapter(hdmi);
>  		if (IS_ERR(hdmi->ddc))
>  			hdmi->ddc = NULL;
> -- 
> 2.21.0.1020.gf2820cf01a-goog
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Sean Paul, Software Engineer, Google / Chromium OS
