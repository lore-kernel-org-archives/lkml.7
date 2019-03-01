Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DE0C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 21:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28242206B6
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 21:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfCAVAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 16:00:41 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:34172 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfCAVAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 16:00:41 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id C41488044D;
        Fri,  1 Mar 2019 22:00:35 +0100 (CET)
Date:   Fri, 1 Mar 2019 22:00:33 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] DRM: Add KMS driver for the Ingenic JZ47xx SoCs
Message-ID: <20190301210033.GA11150@ravnborg.org>
References: <20190228220756.20262-1-paul@crapouillou.net>
 <20190228220756.20262-4-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228220756.20262-4-paul@crapouillou.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=p8lomlI2yiL8qkzjzeYA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul.

Driver looks good and is a very nice piece of work.
In the following a number of minor issues.

One area that jumped at me was framedesc and the use of dma_alloc_coherent()
I hope someone that knows the memory handling better can give some advice here.
To me it looks like something drm should be able to help you with.

	Sam

> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -94,6 +94,7 @@ obj-$(CONFIG_DRM_TEGRA) += tegra/
>  obj-$(CONFIG_DRM_STM) += stm/
>  obj-$(CONFIG_DRM_STI) += sti/
>  obj-$(CONFIG_DRM_IMX) += imx/
> +obj-y			+= ingenic/

To avoid visiting ingenic/ dir for every build use:
obj-$(CONFIG_DRM_INGENIC) += ingennic/

And accept that you need to do this also in ingenic/Makefile

>  obj-$(CONFIG_DRM_MEDIATEK) += mediatek/
>  obj-$(CONFIG_DRM_MESON)	+= meson/
>  obj-y			+= i2c/
> +#include <drm/drm_gem_cma_helper.h>
> +#include <drm/drm_fb_cma_helper.h>
> +#include <drm/drm_fb_helper.h>
> +#include <drm/drm_fourcc.h>
> +#include <drm/drm_gem_framebuffer_helper.h>
> +#include <drm/drm_irq.h>
> +#include <drm/drm_panel.h>
> +#include <drm/drm_plane.h>
> +#include <drm/drm_plane_helper.h>
> +#include <drm/drm_probe_helper.h>
> +#include <drm/drm_vblank.h>
> +
> +#include <dt-bindings/display/ingenic,drm.h>
> +
> +#include "../drm_internal.h"
No other drivers needs drm_internal.h - what makes this driver special?
Or do we have something in drm_internal that should be moved to
include/drm/ ?

> +struct ingenic_framedesc {
> +	uint32_t next;
> +	uint32_t addr;
> +	uint32_t id;
> +	uint32_t cmd;
> +} __packed;
For internel types u32 is the typical use.
uint32_t is usually used in uapi.

Consider to use dma_addr_t for addresses - we see this in other drivers.
If there are alignemnt constraints then add these.

> +
> +struct jz_soc_info {
> +	bool needs_dev_clk;
> +};
> +
> +struct ingenic_drm {
> +	struct device *dev;
> +	void __iomem *base;
> +	struct regmap *map;
> +	struct clk *lcd_clk, *pix_clk;
> +
> +	u32 lcd_mode;
> +
> +	struct ingenic_framedesc *framedesc;
> +	dma_addr_t framedesc_phys;
> +
> +	struct drm_device *drm;
> +	struct drm_plane primary;
> +	struct drm_crtc crtc;
> +	struct drm_connector connector;
> +	struct drm_encoder encoder;
> +	struct drm_panel *panel;
> +
> +	struct device_node *panel_node;
panel_node is not used outside ingenic_drm_probe() so no need
to have it here.

> +
> +	unsigned short ps_start, ps_end, cls_start,
> +		       cls_end, spl_start, spl_end, rev_start;
I do not see these used, they can all be dropped.

> +};
> +
> +
> +static const struct regmap_config ingenic_drm_regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +
> +	.max_register = JZ_REG_LCD_CMD1,
> +	.writeable_reg = ingenic_drm_writeable_reg,
> +};

+1 for using regmap.

> +
> +static inline bool ingenic_drm_lcd_is_special_mode(u32 mode)
> +{
> +	switch (mode) {
> +	case JZ_DRM_LCD_SPECIAL_TFT_1:
> +	case JZ_DRM_LCD_SPECIAL_TFT_2:
> +	case JZ_DRM_LCD_SPECIAL_TFT_3:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
Does it make sense to support these modes today?
If it is not used in practice then no need to carry it in the driver.


> +
> +static inline bool ingenic_drm_lcd_is_stn_mode(u32 mode)
> +{
> +	switch (mode) {
> +	case JZ_DRM_LCD_SINGLE_COLOR_STN:
> +	case JZ_DRM_LCD_SINGLE_MONOCHROME_STN:
> +	case JZ_DRM_LCD_DUAL_COLOR_STN:
> +	case JZ_DRM_LCD_DUAL_MONOCHROME_STN:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
This function is not used and can be deleted.
stn display are not really worth it these days anyway.


> +static void ingenic_drm_crtc_atomic_flush(struct drm_crtc *crtc,
> +					  struct drm_crtc_state *oldstate)
> +{
> +	struct ingenic_drm *priv = drm_crtc_get_priv(crtc);
> +	struct drm_crtc_state *state = crtc->state;
> +	struct drm_pending_vblank_event *event = state->event;
> +	struct drm_framebuffer *drm_fb = crtc->primary->state->fb;
> +	const struct drm_format_info *finfo;
> +	unsigned int width, height;
> +
> +	if (drm_atomic_crtc_needs_modeset(state)) {
> +		finfo = drm_format_info(drm_fb->format->format);
> +		width = state->adjusted_mode.hdisplay;
> +		height = state->adjusted_mode.vdisplay;

width and height are unused and can be dropped.

> +
> +		ingenic_drm_crtc_update_timings(priv, &state->mode);
> +
> +		ingenic_drm_crtc_update_ctrl(priv, finfo->depth);
> +		ingenic_drm_crtc_update_cfg(priv, &state->adjusted_mode);
> +
> +		clk_set_rate(priv->pix_clk, state->adjusted_mode.clock * 1000);
> +
> +		regmap_write(priv->map, JZ_REG_LCD_DA0, priv->framedesc->next);
> +	}
> +
> +	if (event) {
> +		state->event = NULL;
> +
> +		spin_lock_irq(&crtc->dev->event_lock);
> +		if (drm_crtc_vblank_get(crtc) == 0)
> +			drm_crtc_arm_vblank_event(crtc, event);
> +		else
> +			drm_crtc_send_vblank_event(crtc, event);
> +		spin_unlock_irq(&crtc->dev->event_lock);
> +	}
> +}
> +
> +static void ingenic_drm_plane_atomic_update(struct drm_plane *plane,
> +					    struct drm_plane_state *oldstate)
> +{
> +	struct ingenic_drm *priv = drm_plane_get_priv(plane);
> +	struct drm_plane_state *state = plane->state;
> +	const struct drm_format_info *finfo;
> +	unsigned int width, height;
> +
> +	finfo = drm_format_info(state->fb->format->format);
> +	width = state->crtc->state->adjusted_mode.hdisplay;
> +	height = state->crtc->state->adjusted_mode.vdisplay;
adjusted_mode->{h,v}display are both ints. So there is a hidden conversion to unsigned int here.
and framedesc->cmd is uint32_t then this is maybe fine.
Noticed so added a comment about it.

> +
> +	priv->framedesc->addr = drm_fb_cma_get_gem_addr(state->fb, state, 0);
> +
> +	priv->framedesc->cmd = width * height * ((finfo->depth + 7) / 8) / 4;
> +	priv->framedesc->cmd |= JZ_LCD_CMD_EOF_IRQ;
> +}
> +
> +static struct drm_driver ingenic_drm_driver_data = {
> +	.driver_features	= DRIVER_MODESET | DRIVER_GEM | DRIVER_PRIME
> +				| DRIVER_ATOMIC | DRIVER_HAVE_IRQ,

DRIVER_HAVE_IRQ are only for legacy drivers these days.
You can drop it.

> +	.name			= "ingenic-drm",
> +	.desc			= "DRM module for Ingenic SoCs",
> +	.date			= "20190228",
> +	.major			= 1,
> +	.minor			= 0,
> +	.patchlevel		= 0,
> +
> +	.fops			= &ingenic_drm_fops,
> +
> +	.dumb_create		= drm_gem_cma_dumb_create,
> +	.gem_free_object_unlocked = drm_gem_cma_free_object,
> +	.gem_vm_ops		= &drm_gem_cma_vm_ops,
> +
> +	.prime_handle_to_fd	= drm_gem_prime_handle_to_fd,
> +	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle,

> +	.gem_prime_import	= drm_gem_prime_import,
> +	.gem_prime_export	= drm_gem_prime_export,
The two assignments above are not needed. This is the default behaviour. See drm_drv.h
(from drm-misc-next)

> +static int ingenic_drm_probe(struct platform_device *pdev)
> +{
> +	const struct jz_soc_info *soc_info;
> +	struct device *dev = &pdev->dev;
> +	struct ingenic_drm *priv;
> +	struct clk *parent_clk;
> +	struct drm_device *drm;
> +	struct resource *mem;
> +	void __iomem *base;
> +	long parent_rate;
> +	int ret, irq;
> +
> +	soc_info = device_get_match_data(dev);
> +	if (!soc_info)
> +		return -EINVAL;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->dev = dev;
> +
> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	priv->base = base = devm_ioremap_resource(dev, mem);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(dev, "Failed to get platform irq\n");
> +		return -ENOENT;
> +	}
> +
> +	priv->map = devm_regmap_init_mmio(dev, base,
> +					  &ingenic_drm_regmap_config);
> +	if (IS_ERR(priv->map)) {
> +		dev_err(dev, "Failed to create regmap\n");
> +		return PTR_ERR(priv->map);
> +	}
> +
> +	if (soc_info->needs_dev_clk) {
> +		priv->lcd_clk = devm_clk_get(dev, "lcd");
> +		if (IS_ERR(priv->lcd_clk)) {
> +			dev_err(dev, "Failed to get lcd clock\n");
> +			return PTR_ERR(priv->lcd_clk);
> +		}
> +	}
> +
> +	priv->pix_clk = devm_clk_get(dev, "lcd_pclk");
> +	if (IS_ERR(priv->pix_clk)) {
> +		dev_err(dev, "Failed to get pixel clock\n");
> +		return PTR_ERR(priv->pix_clk);
> +	}
> +
> +	priv->panel_node = of_parse_phandle(dev->of_node, "ingenic,panel", 0);
> +	if (!priv->panel_node) {
> +		DRM_INFO("No panel found");
> +	} else {
> +		priv->panel = of_drm_find_panel(priv->panel_node);
> +		of_node_put(priv->panel_node);
> +
> +		if (IS_ERR(priv->panel)) {
> +			if (PTR_ERR(priv->panel) == -EPROBE_DEFER)
> +				return -EPROBE_DEFER;
> +
> +			priv->panel = NULL;
> +		} else {
> +			ret = drm_panel_prepare(priv->panel);
> +			if (ret && ret != -ENOSYS)
> +				return ret;
> +		}
> +	}
> +
> +	if (priv->panel) {
> +		ret = device_property_read_u32(dev, "ingenic,lcd-mode",
> +					       &priv->lcd_mode);
> +		if (ret) {
> +			dev_err(dev, "Unable to read ingenic,lcd-mode property\n");
> +			return ret;
> +		}
> +	}
> +
> +	priv->framedesc = dma_alloc_coherent(dev, sizeof(*priv->framedesc),
> +					     &priv->framedesc_phys, GFP_KERNEL);
> +	if (!priv->framedesc)
> +		return -ENOMEM;
> +
> +	priv->framedesc->next = priv->framedesc_phys;
> +	priv->framedesc->id = 0xdeafbead;
I did not really follow this code.
But you have framedesc that include a next pointer which is uint32_t,
and you assign to it framedesc_phys which is dmaaddr_t.
This looks fishy to me, but maybe it is fine.

When browsing other drivers I see uses of for example {dma,dmam}_pool_create()

When lookign at the origianl fbdev code it is obvious where this comes from.
Notice that in the fbdev code JZ_REG_LCD_DA0 register is updated in the enable function.
This is done different in this driver.
Just an observation, what is right I dunno.

> +static int ingenic_drm_remove(struct platform_device *pdev)
> +{
> +	struct drm_device *drm = platform_get_drvdata(pdev);
> +	struct ingenic_drm *priv = drm->dev_private;
> +
> +	drm_dev_unregister(drm);
> +	drm_mode_config_cleanup(drm);
> +
> +	if (priv->lcd_clk)
> +		clk_disable_unprepare(priv->lcd_clk);
> +	clk_disable_unprepare(priv->pix_clk);
> +
> +	drm_vblank_cleanup(drm);
> +	drm_irq_uninstall(drm);
> +
> +	drm_encoder_cleanup(&priv->encoder);
> +	drm_connector_cleanup(&priv->connector);
> +	drm_crtc_cleanup(&priv->crtc);
> +	drm_plane_cleanup(&priv->primary);
> +
> +	drm_dev_put(drm);
> +
> +	dma_free_coherent(&pdev->dev, sizeof(*priv->framedesc),
> +			  priv->framedesc, priv->framedesc_phys);
> +
> +	return 0;
> +}
> +
> +static const struct jz_soc_info jz4740_soc_info = {
> +	.needs_dev_clk = true,
> +};
> +
> +static const struct jz_soc_info jz4725b_soc_info = {
> +	.needs_dev_clk = false,
> +};
> +
> +static const struct of_device_id ingenic_drm_of_match[] = {
> +	{ .compatible = "ingenic,jz4740-drm", .data = &jz4740_soc_info },
> +	{ .compatible = "ingenic,jz4725b-drm", .data = &jz4725b_soc_info },
> +	{},
Use /* sentinel */ like in most drivers.
