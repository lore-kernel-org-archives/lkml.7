Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDDBC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 21:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4897E205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 21:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfFYVYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 17:24:25 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:48066 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfFYVYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 17:24:25 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id A082580335;
        Tue, 25 Jun 2019 23:24:20 +0200 (CEST)
Date:   Tue, 25 Jun 2019 23:24:19 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Purism Kernel Team <kernel@puri.sm>
Subject: Re: [PATCH 4/4] drm/panel: jh057n0090: Add regulator support
Message-ID: <20190625212419.GB20625@ravnborg.org>
References: <cover.1561482165.git.agx@sigxcpu.org>
 <b239f1db7a1f67988a9bd1ed62f6a1cf1dce944c.1561482165.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b239f1db7a1f67988a9bd1ed62f6a1cf1dce944c.1561482165.git.agx@sigxcpu.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=8nJEP1OIZ-IA:10 a=ze386MxoAAAA:8
        a=7gkXJVJtAAAA:8 a=7rRW2WbpIZ4stnZHryMA:9 a=wPNLvfGTeEIA:10
        a=iBZjaW-pnkserzjvUTHh:22 a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 07:05:19PM +0200, Guido Günther wrote:
> Allow to specify regulators for vcc and iovcc. According to the data
> sheet the panel wants vcc (2.8V) and iovcc (1.8V) and there's no startup
> dependency between the two.
s/jh057n0090/jh057n00900

> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  .../drm/panel/panel-rocktech-jh057n00900.c    | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c b/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
> index b8a069055fbc..f8f6f087b9bc 100644
> --- a/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
> +++ b/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
> @@ -15,6 +15,7 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/media-bus-format.h>
>  #include <linux/module.h>
> +#include <linux/regulator/consumer.h>
>  #include <video/display_timing.h>
>  #include <video/mipi_display.h>
>  
> @@ -47,6 +48,8 @@ struct jh057n {
>  	struct drm_panel panel;
>  	struct gpio_desc *reset_gpio;
>  	struct backlight_device *backlight;
> +	struct regulator *vcc;
> +	struct regulator *iovcc;
>  	bool prepared;
>  
>  	struct dentry *debugfs;
> @@ -160,6 +163,8 @@ static int jh057n_unprepare(struct drm_panel *panel)
>  		return 0;
>  
>  	mipi_dsi_dcs_set_display_off(dsi);
> +	regulator_disable(ctx->iovcc);
> +	regulator_disable(ctx->vcc);
>  	ctx->prepared = false;
>  
>  	return 0;
> @@ -174,6 +179,13 @@ static int jh057n_prepare(struct drm_panel *panel)
>  		return 0;
>  
>  	DRM_DEV_DEBUG_DRIVER(ctx->dev, "Resetting the panel\n");
> +	ret = regulator_enable(ctx->vcc);
> +	if (ret < 0)
> +		return ret;
> +	ret = regulator_enable(ctx->iovcc);
> +	if (ret < 0)
> +		return ret;
> +
>  	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
>  	usleep_range(20, 40);
>  	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> @@ -301,6 +313,13 @@ static int jh057n_probe(struct mipi_dsi_device *dsi)
>  	if (IS_ERR(ctx->backlight))
>  		return PTR_ERR(ctx->backlight);
>  
> +	ctx->vcc = devm_regulator_get(dev, "vcc");
> +	if (IS_ERR(ctx->vcc))
> +		return PTR_ERR(ctx->vcc);
> +	ctx->iovcc = devm_regulator_get(dev, "iovcc");
> +	if (IS_ERR(ctx->iovcc))
> +		return PTR_ERR(ctx->iovcc);
> +
Consider to write an error message.
The regulators are now mandatory, but they be missing in some device
trees. So it would be good to help them to understand why it fails.

With this considered:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

	Sam
