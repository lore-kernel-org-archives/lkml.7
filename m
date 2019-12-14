Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9B7C2D0C9
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 10:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C96D24658
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 10:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfLNKX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 05:23:59 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:44204 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfLNKX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 05:23:58 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id A8A518050E;
        Sat, 14 Dec 2019 11:23:55 +0100 (CET)
Date:   Sat, 14 Dec 2019 11:23:54 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] drm/panel: simple: Support reset GPIOs
Message-ID: <20191214102354.GB2967@ravnborg.org>
References: <20191213181325.26228-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213181325.26228-1-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=P-IC7800AAAA:8
        a=rgyZEuhkcDeh9zHs8M0A:9 a=CjuIK1q_8ugA:10 a=d3PnA9EDa4IxuAV0gXij:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel.

On Fri, Dec 13, 2019 at 07:13:25PM +0100, Miquel Raynal wrote:
> The panel common bindings provide a gpios-reset property which is
> active low by default. Let's support it in the simple driver.
> 
> De-asserting the reset pin implies a physical high, which in turns is
> a logic low.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Code looks fine - but I fail to see why simple panels would require a
reset pin.

Do you have any simple panels that requires this, or did you add it
because you saw it in the panel-common.yaml file?

	Sam


> ---
>  drivers/gpu/drm/panel/panel-simple.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 5d487686d25c..15dd495c347d 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -110,6 +110,7 @@ struct panel_simple {
>  	struct i2c_adapter *ddc;
>  
>  	struct gpio_desc *enable_gpio;
> +	struct gpio_desc *reset_gpio;
>  
>  	struct drm_display_mode override_mode;
>  };
> @@ -433,12 +434,21 @@ static int panel_simple_probe(struct device *dev, const struct panel_desc *desc)
>  	if (IS_ERR(panel->supply))
>  		return PTR_ERR(panel->supply);
>  
> +	panel->reset_gpio = devm_gpiod_get_optional(dev, "reset",
> +						    GPIOD_OUT_LOW);
> +	if (IS_ERR(panel->reset_gpio)) {
> +		err = PTR_ERR(panel->reset_gpio);
> +		if (err != -EPROBE_DEFER)
> +			dev_err(dev, "failed to request reset pin: %d\n", err);
> +		return err;
> +	}
> +
>  	panel->enable_gpio = devm_gpiod_get_optional(dev, "enable",
>  						     GPIOD_OUT_LOW);
>  	if (IS_ERR(panel->enable_gpio)) {
>  		err = PTR_ERR(panel->enable_gpio);
>  		if (err != -EPROBE_DEFER)
> -			dev_err(dev, "failed to request GPIO: %d\n", err);
> +			dev_err(dev, "failed to request enable pin: %d\n", err);
>  		return err;
>  	}
>  
> -- 
> 2.20.1
