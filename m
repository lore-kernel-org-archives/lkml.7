Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE446C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADAE220665
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbfFRM6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 08:58:52 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:43581 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfFRM6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 08:58:52 -0400
Received: from aptenodytes (aaubervilliers-681-1-81-150.w90-88.abo.wanadoo.fr [90.88.23.150])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 551DF200008;
        Tue, 18 Jun 2019 12:58:48 +0000 (UTC)
Message-ID: <bee40295b2c6b489468d4e1fc12d7a1ac122cb9b.camel@bootlin.com>
Subject: Re: [PATCH] backlight: gpio-backlight: Set power state instead of
 brightness at probe
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date:   Tue, 18 Jun 2019 14:58:47 +0200
In-Reply-To: <20190517150546.4508-1-paul.kocialkowski@bootlin.com>
References: <20190517150546.4508-1-paul.kocialkowski@bootlin.com>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2019-05-17 at 17:05 +0200, Paul Kocialkowski wrote:
> On a trivial gpio-backlight setup with a panel using the backlight but
> no boot software to enable it beforehand, we fall in a case where the
> backlight is disabled (not just blanked) and thus remains disabled when
> the panel gets enabled.
> 
> Setting gbl->def_value via the device-tree prop allows enabling the
> backlight in this situation, but it will be unblanked straight away,
> in compliance with the binding. This does not work well when there was no
> boot software to display something before, since we really need to unblank
> by the time the panel is enabled, not before.
> 
> Resolve the situation by setting the brightness to 1 at probe and
> managing the power state accordingly, a bit like it's done in
> pwm-backlight.

Any feedback on this? I was under the impression that it could be quite
controversial, as it implies that the backlight can no longer be
enabled without a bound panel (which IMO makes good sense but could be
a matter to debate).

Cheers,

Paul

> Fixes: 8b770e3c9824 ("backlight: Add GPIO-based backlight driver")
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/video/backlight/gpio_backlight.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
> index e470da95d806..c9cb97fa13d0 100644
> --- a/drivers/video/backlight/gpio_backlight.c
> +++ b/drivers/video/backlight/gpio_backlight.c
> @@ -57,6 +57,21 @@ static const struct backlight_ops gpio_backlight_ops = {
>  	.check_fb	= gpio_backlight_check_fb,
>  };
>  
> +static int gpio_backlight_initial_power_state(struct gpio_backlight *gbl)
> +{
> +	struct device_node *node = gbl->dev->of_node;
> +
> +	/* If we absolutely want the backlight enabled at boot. */
> +	if (gbl->def_value)
> +		return FB_BLANK_UNBLANK;
> +
> +	/* If there's no panel to unblank the backlight later. */
> +	if (!node || !node->phandle)
> +		return FB_BLANK_UNBLANK;
> +
> +	return FB_BLANK_POWERDOWN;
> +}
> +
>  static int gpio_backlight_probe_dt(struct platform_device *pdev,
>  				   struct gpio_backlight *gbl)
>  {
> @@ -142,7 +157,9 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>  		return PTR_ERR(bl);
>  	}
>  
> -	bl->props.brightness = gbl->def_value;
> +	bl->props.brightness = 1;
> +	bl->props.power = gpio_backlight_initial_power_state(gbl);
> +
>  	backlight_update_status(bl);
>  
>  	platform_set_drvdata(pdev, bl);
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

