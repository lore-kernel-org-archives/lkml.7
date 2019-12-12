Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20526C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 11:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EADBF214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 11:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbfLLLyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 06:54:31 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40662 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfLLLya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 06:54:30 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 9C6672923E5
Subject: Re: [PATCH RESEND 4/4] drm: bridge: Generic GPIO mux driver
To:     Hsin-Yi Wang <hsinyi@chromium.org>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        p.zabel@pengutronix.de, Matthias Brugger <mbrugger@suse.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>
References: <20191211061911.238393-1-hsinyi@chromium.org>
 <20191211061911.238393-5-hsinyi@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <3a1e7d45-dd41-9ab3-e375-5e2610a1d7d6@collabora.com>
Date:   Thu, 12 Dec 2019 12:54:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191211061911.238393-5-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi,

On 11/12/19 7:19, Hsin-Yi Wang wrote:
> From: Nicolas Boichat <drinkcat@chromium.org>
> 
> This driver supports single input, 2 output display mux (e.g.
> HDMI mux), that provide its status via a GPIO.
> 
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

I'll let drm maintainers comment on this but if that's the way to go you can add my:

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Only one issue that needs to be solved in next version, see below.

> ---
>  drivers/gpu/drm/bridge/Kconfig            |  10 +
>  drivers/gpu/drm/bridge/Makefile           |   1 +
>  drivers/gpu/drm/bridge/generic-gpio-mux.c | 306 ++++++++++++++++++++++
>  3 files changed, 317 insertions(+)
>  create mode 100644 drivers/gpu/drm/bridge/generic-gpio-mux.c
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 1f3fc6bec842..4734f6993858 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -54,6 +54,16 @@ config DRM_DUMB_VGA_DAC
>  	  Support for non-programmable RGB to VGA DAC bridges, such as ADI
>  	  ADV7123, TI THS8134 and THS8135 or passive resistor ladder DACs.
>  
> +config DRM_GENERIC_GPIO_MUX
> +	tristate "Generic GPIO-controlled mux"
> +	depends on OF
> +	select DRM_KMS_HELPER
> +	---help---
> +	  This bridge driver models a GPIO-controlled display mux with one
> +	  input, 2 outputs (e.g. an HDMI mux). The hardware decides which output
> +	  is active, reports it as a GPIO, and the driver redirects calls to the
> +	  appropriate downstream bridge (if any).
> +
>  config DRM_LVDS_ENCODER
>  	tristate "Transparent parallel to LVDS encoder support"
>  	depends on OF
> diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
> index 7a1e0ec032e6..1c0c92667ac4 100644
> --- a/drivers/gpu/drm/bridge/Makefile
> +++ b/drivers/gpu/drm/bridge/Makefile
> @@ -3,6 +3,7 @@ obj-$(CONFIG_DRM_ANALOGIX_ANX7688) += analogix-anx7688.o
>  obj-$(CONFIG_DRM_ANALOGIX_ANX78XX) += analogix-anx78xx.o
>  obj-$(CONFIG_DRM_CDNS_DSI) += cdns-dsi.o
>  obj-$(CONFIG_DRM_DUMB_VGA_DAC) += dumb-vga-dac.o
> +obj-$(CONFIG_DRM_GENERIC_GPIO_MUX) += generic-gpio-mux.o
>  obj-$(CONFIG_DRM_LVDS_ENCODER) += lvds-encoder.o
>  obj-$(CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW) += megachips-stdpxxxx-ge-b850v3-fw.o
>  obj-$(CONFIG_DRM_NXP_PTN3460) += nxp-ptn3460.o
> diff --git a/drivers/gpu/drm/bridge/generic-gpio-mux.c b/drivers/gpu/drm/bridge/generic-gpio-mux.c
> new file mode 100644
> index 000000000000..ba08321dcc17
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/generic-gpio-mux.c
> @@ -0,0 +1,306 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Generic gpio mux bridge driver
> + *
> + * Copyright 2016 Google LLC
> + */
> +
> +
> +#include <linux/gpio.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
> +#include <linux/of_graph.h>
> +#include <drm/drm_bridge.h>
> +#include <drm/drm_crtc_helper.h>
> +#include <drm/drm_probe_helper.h>
> +
> +struct gpio_display_mux {
> +	struct device *dev;
> +
> +	struct gpio_desc *gpiod_detect;
> +	int detect_irq;
> +
> +	struct drm_bridge bridge;
> +
> +	struct drm_bridge *next[2];
> +};
> +
> +static inline struct gpio_display_mux *bridge_to_gpio_display_mux(
> +		struct drm_bridge *bridge)
> +{
> +	return container_of(bridge, struct gpio_display_mux, bridge);
> +}
> +
> +static irqreturn_t gpio_display_mux_det_threaded_handler(int unused, void *data)
> +{
> +	struct gpio_display_mux *gpio_display_mux = data;
> +	int active = gpiod_get_value(gpio_display_mux->gpiod_detect);
> +
> +	dev_dbg(gpio_display_mux->dev, "Interrupt %d!\n", active);
> +
> +	if (gpio_display_mux->bridge.dev)
> +		drm_kms_helper_hotplug_event(gpio_display_mux->bridge.dev);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int gpio_display_mux_attach(struct drm_bridge *bridge)
> +{
> +	struct gpio_display_mux *gpio_display_mux =
> +			bridge_to_gpio_display_mux(bridge);
> +	struct drm_bridge *next;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(gpio_display_mux->next); i++) {
> +		next = gpio_display_mux->next[i];
> +		if (next)
> +			next->encoder = bridge->encoder;
> +	}
> +
> +	return 0;
> +}
> +
> +static bool gpio_display_mux_mode_fixup(struct drm_bridge *bridge,
> +				const struct drm_display_mode *mode,
> +				struct drm_display_mode *adjusted_mode)
> +{
> +	struct gpio_display_mux *gpio_display_mux =
> +		bridge_to_gpio_display_mux(bridge);
> +	int active;
> +	struct drm_bridge *next;
> +
> +	active = gpiod_get_value(gpio_display_mux->gpiod_detect);
> +	next = gpio_display_mux->next[active];
> +
> +	if (next && next->funcs->mode_fixup)
> +		return next->funcs->mode_fixup(next, mode, adjusted_mode);
> +	else
> +		return true;
> +}
> +
> +static void gpio_display_mux_mode_set(struct drm_bridge *bridge,
> +				struct drm_display_mode *mode,
> +				struct drm_display_mode *adjusted_mode)

Those two need to be const now.

> +{
> +	struct gpio_display_mux *gpio_display_mux =
> +		bridge_to_gpio_display_mux(bridge);
> +	int active;
> +	struct drm_bridge *next;
> +
> +	active = gpiod_get_value(gpio_display_mux->gpiod_detect);
> +	next = gpio_display_mux->next[active];
> +
> +	if (next && next->funcs->mode_set)
> +		next->funcs->mode_set(next, mode, adjusted_mode);
> +}
> +
> +/**
> + * Since this driver _reacts_ to mux changes, we need to make sure all
> + * downstream bridges are pre-enabled.
> + */
> +static void gpio_display_mux_pre_enable(struct drm_bridge *bridge)
> +{
> +	struct gpio_display_mux *gpio_display_mux =
> +		bridge_to_gpio_display_mux(bridge);
> +	struct drm_bridge *next;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(gpio_display_mux->next); i++) {
> +		next = gpio_display_mux->next[i];
> +		if (next && next->funcs->pre_enable)
> +			next->funcs->pre_enable(next);
> +	}
> +}
> +
> +static void gpio_display_mux_post_disable(struct drm_bridge *bridge)
> +{
> +	struct gpio_display_mux *gpio_display_mux =
> +		bridge_to_gpio_display_mux(bridge);
> +	struct drm_bridge *next;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(gpio_display_mux->next); i++) {
> +		next = gpio_display_mux->next[i];
> +		if (next && next->funcs->post_disable)
> +			next->funcs->post_disable(next);
> +	}
> +}
> +
> +/**
> + * In an ideal mux driver, only the currently selected bridge should be enabled.
> + * For the sake of simplicity, we just just enable/disable all downstream
> + * bridges at the same time.
> + */
> +static void gpio_display_mux_enable(struct drm_bridge *bridge)
> +{
> +	struct gpio_display_mux *gpio_display_mux =
> +		bridge_to_gpio_display_mux(bridge);
> +	struct drm_bridge *next;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(gpio_display_mux->next); i++) {
> +		next = gpio_display_mux->next[i];
> +		if (next && next->funcs->enable)
> +			next->funcs->enable(next);
> +	}
> +}
> +
> +static void gpio_display_mux_disable(struct drm_bridge *bridge)
> +{
> +	struct gpio_display_mux *gpio_display_mux =
> +		bridge_to_gpio_display_mux(bridge);
> +	struct drm_bridge *next;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(gpio_display_mux->next); i++) {
> +		next = gpio_display_mux->next[i];
> +		if (next && next->funcs->disable)
> +			next->funcs->disable(next);
> +	}
> +}
> +
> +static const struct drm_bridge_funcs gpio_display_mux_bridge_funcs = {
> +	.attach = gpio_display_mux_attach,
> +	.mode_fixup = gpio_display_mux_mode_fixup,
> +	.disable = gpio_display_mux_disable,
> +	.post_disable = gpio_display_mux_post_disable,
> +	.mode_set = gpio_display_mux_mode_set,
> +	.pre_enable = gpio_display_mux_pre_enable,
> +	.enable = gpio_display_mux_enable,
> +};
> +
> +static int gpio_display_mux_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct gpio_display_mux *gpio_display_mux;
> +	struct device_node *port, *ep, *remote;
> +	int ret;
> +	u32 reg;
> +
> +	gpio_display_mux = devm_kzalloc(dev, sizeof(*gpio_display_mux),
> +					GFP_KERNEL);
> +	if (!gpio_display_mux)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, gpio_display_mux);
> +	gpio_display_mux->dev = &pdev->dev;
> +
> +	gpio_display_mux->bridge.of_node = dev->of_node;
> +
> +	gpio_display_mux->gpiod_detect =
> +		devm_gpiod_get(dev, "detect", GPIOD_IN);
> +	if (IS_ERR(gpio_display_mux->gpiod_detect))
> +		return PTR_ERR(gpio_display_mux->gpiod_detect);
> +
> +	gpio_display_mux->detect_irq =
> +		gpiod_to_irq(gpio_display_mux->gpiod_detect);
> +	if (gpio_display_mux->detect_irq < 0) {
> +		dev_err(dev, "Failed to get output irq %d\n",
> +			gpio_display_mux->detect_irq);
> +		return -ENODEV;
> +	}
> +
> +	port = of_graph_get_port_by_id(dev->of_node, 1);
> +	if (!port) {
> +		dev_err(dev, "Missing output port node\n");
> +		return -EINVAL;
> +	}
> +
> +	for_each_child_of_node(port, ep) {
> +		if (!ep->name || (of_node_cmp(ep->name, "endpoint") != 0)) {
> +			of_node_put(ep);
> +			continue;
> +		}
> +
> +		if (of_property_read_u32(ep, "reg", &reg) < 0 ||
> +				reg >= ARRAY_SIZE(gpio_display_mux->next)) {
> +			dev_err(dev,
> +			    "Missing/invalid reg property for endpoint %s\n",
> +				ep->full_name);
> +			of_node_put(ep);
> +			of_node_put(port);
> +			return -EINVAL;
> +		}
> +
> +		remote = of_graph_get_remote_port_parent(ep);
> +		if (!remote) {
> +			dev_err(dev,
> +			    "Missing connector/bridge node for endpoint %s\n",
> +				ep->full_name);
> +			of_node_put(ep);
> +			of_node_put(port);
> +			return -EINVAL;
> +		}
> +		of_node_put(ep);
> +
> +		if (of_device_is_compatible(remote, "hdmi-connector")) {
> +			of_node_put(remote);
> +			continue;
> +		}
> +
> +		gpio_display_mux->next[reg] = of_drm_find_bridge(remote);
> +		if (!gpio_display_mux->next[reg]) {
> +			dev_err(dev, "Waiting for external bridge %s\n",
> +				remote->name);
> +			of_node_put(remote);
> +			of_node_put(port);
> +			return -EPROBE_DEFER;
> +		}
> +
> +		of_node_put(remote);
> +	}
> +	of_node_put(port);
> +
> +	gpio_display_mux->bridge.funcs = &gpio_display_mux_bridge_funcs;
> +	drm_bridge_add(&gpio_display_mux->bridge);
> +
> +	ret = devm_request_threaded_irq(dev, gpio_display_mux->detect_irq,
> +				NULL,
> +				gpio_display_mux_det_threaded_handler,
> +				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
> +					IRQF_ONESHOT,
> +				"gpio-display-mux-det", gpio_display_mux);
> +	if (ret) {
> +		dev_err(dev, "Failed to request MUX_DET threaded irq\n");
> +		goto err_bridge_remove;
> +	}
> +
> +	return 0;
> +
> +err_bridge_remove:
> +	drm_bridge_remove(&gpio_display_mux->bridge);
> +
> +	return ret;
> +}
> +
> +static int gpio_display_mux_remove(struct platform_device *pdev)
> +{
> +	struct gpio_display_mux *gpio_display_mux = platform_get_drvdata(pdev);
> +
> +	drm_bridge_remove(&gpio_display_mux->bridge);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id gpio_display_mux_match[] = {
> +	{ .compatible = "gpio-display-mux", },
> +	{},
> +};
> +
> +struct platform_driver gpio_display_mux_driver = {
> +	.probe = gpio_display_mux_probe,
> +	.remove = gpio_display_mux_remove,
> +	.driver = {
> +		.name = "gpio-display-mux",
> +		.of_match_table = gpio_display_mux_match,
> +	},
> +};
> +
> +module_platform_driver(gpio_display_mux_driver);
> +
> +MODULE_DESCRIPTION("GPIO-controlled display mux");
> +MODULE_AUTHOR("Nicolas Boichat <drinkcat@chromium.org>");
> +MODULE_LICENSE("GPL v2");
> 
