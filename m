Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E030C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 21:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32D00218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 21:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfCPV7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 17:59:52 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:41328 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfCPV7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 17:59:52 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 14057200C3;
        Sat, 16 Mar 2019 22:59:46 +0100 (CET)
Date:   Sat, 16 Mar 2019 22:59:44 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 3/3] DRM: Add KMS driver for the Ingenic JZ47xx SoCs
Message-ID: <20190316215944.GB11309@ravnborg.org>
References: <20190315170701.29670-1-paul@crapouillou.net>
 <20190315170701.29670-3-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315170701.29670-3-paul@crapouillou.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=ER_8r6IbAAAA:8
        a=p6pI0oa4AAAA:8 a=3iZPsmZ1dwio5CCrdjoA:9 a=CjuIK1q_8ugA:10
        a=9LHmKk7ezEChjTCyhBa9:22 a=9cw2y2bKwytFd151gpuR:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul.

Thanks for the v2 submission.

Did you analyze the possibility to utilize drm_simple_display_pipe_init()
and the related infrastructure?
If this fits it should simplify the driver.
If it does not fit please let us know why.
As this is a one crtc / one connector / one panel the drm_simple_*
infrastructure is supposed to be a good fit.

Some smaller comments in the following.
Most are suggestion, do not follow these blindly.

	Sam

> Add a KMS driver for the Ingenic JZ47xx family of SoCs.
> This driver is meant to replace the aging jz4740-fb driver.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Artur Rojek <contact@artur-rojek.eu>

> +struct ingenic_drm {
> +	struct device *dev;
> +	void __iomem *base;
> +	struct regmap *map;
> +	struct clk *lcd_clk, *pix_clk;
> +
> +	u32 lcd_mode;
> +
> +	struct ingenic_dma_hwdesc *framedesc;

Consider the name "dma_hwdesc" for this.
The struct is named so, which give a good indication
this is a more descriptive name.

That said, the current solution looks much cleaner than the
previous one.

> +	dma_addr_t framedesc_phys;
Likewise.


> +
> +	struct drm_device *drm;
If drm is embedded you can use devm_drm_dev_init()
recently added to drm-misc.

See the very nice example in drivers/gu/drm/drm_drv.c
(only in drm-misc-next for now)

> +	struct drm_plane primary;
> +	struct drm_crtc crtc;
> +	struct drm_encoder encoder;
> +};
> +
> +
> +static int ingenic_drm_probe(struct platform_device *pdev)
> +{
> +	const struct jz_soc_info *soc_info;
> +	struct device *dev = &pdev->dev;
> +	struct ingenic_drm *priv;
> +	struct clk *parent_clk;
> +	struct drm_bridge *bridge;
> +	struct drm_panel *panel;
> +	struct drm_device *drm;
> +	struct resource *mem;
> +	void __iomem *base;
> +	long parent_rate;
> +	int ret, irq;
> +
> +	soc_info = device_get_match_data(dev);
Everyone else uses of_device_... here. You should most
likely do the same.

> +	if (!soc_info)
> +		return -EINVAL;
Also, consider to print an error here.

> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
Use of devm_kzalloc() here is not good. See driver example in drm_drv.c

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
> +	ret = drm_of_find_panel_or_bridge(dev->of_node, 0, 0, &panel, &bridge);
> +	if (ret) {
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to get panel handle\n");
> +		return ret;
> +	}
> +
> +	if (panel) {
> +		bridge = devm_drm_panel_bridge_add(dev, panel,
> +						   DRM_MODE_CONNECTOR_Unknown);
> +	}
> +
> +	device_property_read_u32(dev, "ingenic,lcd-mode", &priv->lcd_mode);
> +
> +	priv->framedesc = dma_alloc_coherent(dev, sizeof(*priv->framedesc),
> +					     &priv->framedesc_phys, GFP_KERNEL);
> +	if (!priv->framedesc)
> +		return -ENOMEM;
> +
> +	priv->framedesc->next = priv->framedesc_phys;
> +	priv->framedesc->id = 0xdeafbead;
> +
> +	drm = drm_dev_alloc(&ingenic_drm_driver_data, dev);
> +	if (IS_ERR(drm)) {
> +		ret = PTR_ERR(drm);
> +		goto err_free_dma;
> +	}
> +
> +	priv->drm = drm;
> +
> +	drm_mode_config_init(drm);
> +	drm->mode_config.min_width = 0;
> +	drm->mode_config.min_height = 0;
> +	drm->mode_config.max_width = 800;
> +	drm->mode_config.max_height = 600;
> +	drm->mode_config.funcs = &ingenic_drm_mode_config_funcs;
> +
> +	drm_plane_helper_add(&priv->primary, &ingenic_drm_plane_helper_funcs);
> +
> +	ret = drm_universal_plane_init(drm, &priv->primary,
> +				       0, &ingenic_drm_primary_plane_funcs,
> +				       ingenic_drm_primary_formats,
> +				       ARRAY_SIZE(ingenic_drm_primary_formats),
> +				       NULL, DRM_PLANE_TYPE_PRIMARY, NULL);
> +	if (ret) {
> +		dev_err(dev, "Failed to register primary plane: %i\n", ret);
> +		goto err_unref_drm;
> +	}
> +
> +	drm_crtc_helper_add(&priv->crtc, &ingenic_drm_crtc_helper_funcs);
> +
> +	ret = drm_crtc_init_with_planes(drm, &priv->crtc, &priv->primary,
> +					NULL, &ingenic_drm_crtc_funcs, NULL);
> +	if (ret) {
> +		dev_err(dev, "Failed to init CRTC: %i\n", ret);
> +		goto err_cleanup_plane;
> +	}
> +
> +	priv->encoder.possible_crtcs = 1;
> +
> +	drm_encoder_helper_add(&priv->encoder,
> +			       &ingenic_drm_encoder_helper_funcs);
> +
> +	ret = drm_encoder_init(drm, &priv->encoder, &ingenic_drm_encoder_funcs,
> +			       DRM_MODE_ENCODER_DPI, NULL);
> +	if (ret) {
> +		dev_err(dev, "Failed to init encoder: %i\n", ret);
> +		goto err_cleanup_crtc;
> +	}
> +
> +	ret = drm_bridge_attach(&priv->encoder, bridge, NULL);
> +	if (ret) {
> +		dev_err(dev, "Unable to attach bridge\n");
> +		goto err_cleanup_encoder;
> +	}
> +
> +	platform_set_drvdata(pdev, drm);
> +	priv->drm = drm;
> +	drm->dev_private = priv;
> +
> +	ret = drm_irq_install(drm, irq);
> +	if (ret) {
> +		dev_err(dev, "Unable to install IRQ handler\n");
> +		goto err_cleanup_encoder;
> +	}
> +
> +	ret = drm_vblank_init(drm, 1);
> +	if (ret) {
> +		dev_err(dev, "Failed calling drm_vblank_init()\n");
> +		goto err_uninstall_irq;
> +	}
> +
> +	drm_mode_config_reset(drm);
> +
> +	ret = clk_prepare_enable(priv->pix_clk);
> +	if (ret) {
> +		dev_err(dev, "Unable to start pixel clock\n");
> +		goto err_uninstall_irq;
> +	}
> +
> +	if (priv->lcd_clk) {
> +		parent_clk = clk_get_parent(priv->lcd_clk);
> +		parent_rate = clk_get_rate(parent_clk);
> +
> +		/* LCD Device clock must be 3x the pixel clock for STN panels,
> +		 * or 1.5x the pixel clock for TFT panels. To avoid having to
> +		 * check for the LCD device clock everytime we do a mode change,
> +		 * we set the LCD device clock to the highest rate possible.
> +		 */
> +		ret = clk_set_rate(priv->lcd_clk, parent_rate);
> +		if (ret) {
> +			dev_err(dev, "Unable to set LCD clock rate\n");
> +			goto err_pixclk_disable;
> +		}
> +
> +		ret = clk_prepare_enable(priv->lcd_clk);
> +		if (ret) {
> +			dev_err(dev, "Unable to start lcd clock\n");
> +			goto err_pixclk_disable;
> +		}
> +	}
> +
> +	ret = drm_fbdev_generic_setup(drm, 16);
> +	if (ret) {
> +		dev_err(dev, "Failed to init fbdev\n");
> +		goto err_devclk_disable;
> +	}
fbdev is usually considered an optionl feature that do not prevent
the display driver from loading.
Consider what to do in the error case.

