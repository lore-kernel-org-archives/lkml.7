Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BDDC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A602064A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732826AbfDJOum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:50:42 -0400
Received: from gloria.sntech.de ([185.11.138.130]:50802 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728729AbfDJOum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 10:50:42 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hEEYZ-0002vv-PW; Wed, 10 Apr 2019 16:50:31 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Christoph Muellner <christoph.muellner@theobroma-systems.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm: panel-simple: Add simple-panel driver.
Date:   Wed, 10 Apr 2019 16:50:30 +0200
Message-ID: <7915415.Bhcl4jWJiJ@diego>
In-Reply-To: <20190410141045.58097-1-christoph.muellner@theobroma-systems.com>
References: <20190410141045.58097-1-christoph.muellner@theobroma-systems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

Am Mittwoch, 10. April 2019, 16:10:44 CEST schrieb Christoph Muellner:
> On our RK3399-Q7 EVK base board we have the option to connect an arbitrary
> monitor via DP cable. The actual monitor is therefore not known in advance.
> This means, we don't have any panel information besides the EDID
> data from the device itself.

Just so I understand correctly, you have a real dp-connector wired to
the Analogix dp-controller, and therefore want to connect actual
monitors to it.

So the problem you're trying to work around is probably that the
rockchip-driver of the analogix controller explictly expects a bridge
to be present during probe, right?

I think hacking up the panel-driver is not an ideal approach:
(1) bridges/panels do expect to stay connected all the time
    and are meant for devices with actual hard-wired displays with specific
    power-sequence requirements
(2) devicetree is expected to describe the real hardware, therefore the
    dt should not describe one thing while the actual hardware is really
    different

So, I guess a more ideal approach could perhaps be to:
(1) define a "dp-connector" devicetree binding, see
    Documentation/devicetree/bindings/display/connector/hdmi-connector.txt
    for a similar one
(2) steal an idea from drivers/gpu/drm/mediatek/mtk_hdmi.c and check
    for that new compatible:
	if (!of_device_is_compatible(remote, "hdmi-connector")) {
		//move bridge handling here
	}

    and modify both the rockchip-part and the generic analogix bridge code
    to work with the connector declared instead of a panel?


Heiko

> The functionality for a 'simple-panel' has been remove a couple
> of years ago with 81cf32b. This patch brings this feature back.
> 
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 9e8218f6a3f2..1f69283f3e4b 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -176,7 +176,7 @@ static int panel_simple_disable(struct drm_panel *panel)
>  		backlight_update_status(p->backlight);
>  	}
>  
> -	if (p->desc->delay.disable)
> +	if (p->desc && p->desc->delay.disable)
>  		msleep(p->desc->delay.disable);
>  
>  	p->enabled = false;
> @@ -195,7 +195,7 @@ static int panel_simple_unprepare(struct drm_panel *panel)
>  
>  	regulator_disable(p->supply);
>  
> -	if (p->desc->delay.unprepare)
> +	if (p->desc && p->desc->delay.unprepare)
>  		msleep(p->desc->delay.unprepare);
>  
>  	p->prepared = false;
> @@ -220,11 +220,13 @@ static int panel_simple_prepare(struct drm_panel *panel)
>  
>  	gpiod_set_value_cansleep(p->enable_gpio, 1);
>  
> -	delay = p->desc->delay.prepare;
> -	if (p->no_hpd)
> -		delay += p->desc->delay.hpd_absent_delay;
> -	if (delay)
> -		msleep(delay);
> +	if (p->desc) {
> +		delay = p->desc->delay.prepare;
> +		if (p->no_hpd)
> +			delay += p->desc->delay.hpd_absent_delay;
> +		if (delay)
> +			msleep(delay);
> +	}
>  
>  	p->prepared = true;
>  
> @@ -238,7 +240,7 @@ static int panel_simple_enable(struct drm_panel *panel)
>  	if (p->enabled)
>  		return 0;
>  
> -	if (p->desc->delay.enable)
> +	if (p->desc && p->desc->delay.enable)
>  		msleep(p->desc->delay.enable);
>  
>  	if (p->backlight) {
> @@ -280,6 +282,9 @@ static int panel_simple_get_timings(struct drm_panel *panel,
>  	struct panel_simple *p = to_panel_simple(panel);
>  	unsigned int i;
>  
> +	if (!p->desc)
> +		return 0;
> +
>  	if (p->desc->num_timings < num_timings)
>  		num_timings = p->desc->num_timings;
>  
> @@ -2536,6 +2541,9 @@ static const struct panel_desc arm_rtsm = {
>  
>  static const struct of_device_id platform_of_match[] = {
>  	{
> +		.compatible = "simple-panel",
> +		.data = NULL,
> +	}, {
>  		.compatible = "ampire,am-480272h3tmqw-t01h",
>  		.data = &ampire_am_480272h3tmqw_t01h,
>  	}, {
> 




