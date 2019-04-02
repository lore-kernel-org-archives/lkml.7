Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA94C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3D81204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="mbIFUed4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731331AbfDBQQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:16:34 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:59658 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729063AbfDBQQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:16:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1554221790; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7BoUW7wkXmwq1F86MheIkcRHo0Bu6aTziXZlMkMl70E=;
        b=mbIFUed4Kv067WNUy0+5BQ4yo6n3JwHHs7VJyQ+CJoiP/c1qm77S0gdHxAmDbsC5pDmbK9
        qEbIEX+fDBP5G5DE7iZ4GyWTLIiKV9a/7JPo0AM7NeNjyR6ikE7Lpl4hlnXbUNU0AbSjwr
        /h0ssdi3wpl07JgbKcbkRFL+hwn5qQk=
Date:   Tue, 02 Apr 2019 18:16:23 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 3/3] DRM: Add KMS driver for the Ingenic JZ47xx SoCs
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Message-Id: <1554221783.1199.1@crapouillou.net>
In-Reply-To: <20190316215944.GB11309@ravnborg.org>
References: <20190315170701.29670-1-paul@crapouillou.net>
        <20190315170701.29670-3-paul@crapouillou.net>
        <20190316215944.GB11309@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

Le sam. 16 mars 2019 =E0 22:59, Sam Ravnborg <sam@ravnborg.org> a =E9crit=20
:
> Hi Paul.
>=20
> Thanks for the v2 submission.
>=20
> Did you analyze the possibility to utilize=20
> drm_simple_display_pipe_init()
> and the related infrastructure?
> If this fits it should simplify the driver.
> If it does not fit please let us know why.
> As this is a one crtc / one connector / one panel the drm_simple_*
> infrastructure is supposed to be a good fit.
>=20
> Some smaller comments in the following.
> Most are suggestion, do not follow these blindly.
>=20
> 	Sam
>=20
>>  Add a KMS driver for the Ingenic JZ47xx family of SoCs.
>>  This driver is meant to replace the aging jz4740-fb driver.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  Tested-by: Artur Rojek <contact@artur-rojek.eu>
>=20
>>  +struct ingenic_drm {
>>  +	struct device *dev;
>>  +	void __iomem *base;
>>  +	struct regmap *map;
>>  +	struct clk *lcd_clk, *pix_clk;
>>  +
>>  +	u32 lcd_mode;
>>  +
>>  +	struct ingenic_dma_hwdesc *framedesc;
>=20
> Consider the name "dma_hwdesc" for this.
> The struct is named so, which give a good indication
> this is a more descriptive name.
>=20
> That said, the current solution looks much cleaner than the
> previous one.
>=20
>>  +	dma_addr_t framedesc_phys;
> Likewise.
>=20
>=20
>>  +
>>  +	struct drm_device *drm;
> If drm is embedded you can use devm_drm_dev_init()
> recently added to drm-misc.
>=20
> See the very nice example in drivers/gu/drm/drm_drv.c
> (only in drm-misc-next for now)

If I have a request for deferred probe after devm_drm_dev_init(),
I get a kernel oops in drm_mode_config_cleanup()...

>>  +	struct drm_plane primary;
>>  +	struct drm_crtc crtc;
>>  +	struct drm_encoder encoder;
>>  +};
>>  +
>>  +
>>  +static int ingenic_drm_probe(struct platform_device *pdev)
>>  +{
>>  +	const struct jz_soc_info *soc_info;
>>  +	struct device *dev =3D &pdev->dev;
>>  +	struct ingenic_drm *priv;
>>  +	struct clk *parent_clk;
>>  +	struct drm_bridge *bridge;
>>  +	struct drm_panel *panel;
>>  +	struct drm_device *drm;
>>  +	struct resource *mem;
>>  +	void __iomem *base;
>>  +	long parent_rate;
>>  +	int ret, irq;
>>  +
>>  +	soc_info =3D device_get_match_data(dev);
> Everyone else uses of_device_... here. You should most
> likely do the same.
>=20
>>  +	if (!soc_info)
>>  +		return -EINVAL;
> Also, consider to print an error here.
>=20
>>  +
>>  +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>  +	if (!priv)
>>  +		return -ENOMEM;
> Use of devm_kzalloc() here is not good. See driver example in=20
> drm_drv.c
>=20
>>  +
>>  +	priv->dev =3D dev;
>>  +
>>  +	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>  +	priv->base =3D base =3D devm_ioremap_resource(dev, mem);
>>  +	if (IS_ERR(base))
>>  +		return PTR_ERR(base);
>>  +
>>  +	irq =3D platform_get_irq(pdev, 0);
>>  +	if (irq < 0) {
>>  +		dev_err(dev, "Failed to get platform irq\n");
>>  +		return -ENOENT;
>>  +	}
>>  +
>>  +	priv->map =3D devm_regmap_init_mmio(dev, base,
>>  +					  &ingenic_drm_regmap_config);
>>  +	if (IS_ERR(priv->map)) {
>>  +		dev_err(dev, "Failed to create regmap\n");
>>  +		return PTR_ERR(priv->map);
>>  +	}
>>  +
>>  +	if (soc_info->needs_dev_clk) {
>>  +		priv->lcd_clk =3D devm_clk_get(dev, "lcd");
>>  +		if (IS_ERR(priv->lcd_clk)) {
>>  +			dev_err(dev, "Failed to get lcd clock\n");
>>  +			return PTR_ERR(priv->lcd_clk);
>>  +		}
>>  +	}
>>  +
>>  +	priv->pix_clk =3D devm_clk_get(dev, "lcd_pclk");
>>  +	if (IS_ERR(priv->pix_clk)) {
>>  +		dev_err(dev, "Failed to get pixel clock\n");
>>  +		return PTR_ERR(priv->pix_clk);
>>  +	}
>>  +
>>  +	ret =3D drm_of_find_panel_or_bridge(dev->of_node, 0, 0, &panel,=20
>> &bridge);
>>  +	if (ret) {
>>  +		if (ret !=3D -EPROBE_DEFER)
>>  +			dev_err(dev, "Failed to get panel handle\n");
>>  +		return ret;
>>  +	}
>>  +
>>  +	if (panel) {
>>  +		bridge =3D devm_drm_panel_bridge_add(dev, panel,
>>  +						   DRM_MODE_CONNECTOR_Unknown);
>>  +	}
>>  +
>>  +	device_property_read_u32(dev, "ingenic,lcd-mode",=20
>> &priv->lcd_mode);
>>  +
>>  +	priv->framedesc =3D dma_alloc_coherent(dev,=20
>> sizeof(*priv->framedesc),
>>  +					     &priv->framedesc_phys, GFP_KERNEL);
>>  +	if (!priv->framedesc)
>>  +		return -ENOMEM;
>>  +
>>  +	priv->framedesc->next =3D priv->framedesc_phys;
>>  +	priv->framedesc->id =3D 0xdeafbead;
>>  +
>>  +	drm =3D drm_dev_alloc(&ingenic_drm_driver_data, dev);
>>  +	if (IS_ERR(drm)) {
>>  +		ret =3D PTR_ERR(drm);
>>  +		goto err_free_dma;
>>  +	}
>>  +
>>  +	priv->drm =3D drm;
>>  +
>>  +	drm_mode_config_init(drm);
>>  +	drm->mode_config.min_width =3D 0;
>>  +	drm->mode_config.min_height =3D 0;
>>  +	drm->mode_config.max_width =3D 800;
>>  +	drm->mode_config.max_height =3D 600;
>>  +	drm->mode_config.funcs =3D &ingenic_drm_mode_config_funcs;
>>  +
>>  +	drm_plane_helper_add(&priv->primary,=20
>> &ingenic_drm_plane_helper_funcs);
>>  +
>>  +	ret =3D drm_universal_plane_init(drm, &priv->primary,
>>  +				       0, &ingenic_drm_primary_plane_funcs,
>>  +				       ingenic_drm_primary_formats,
>>  +				       ARRAY_SIZE(ingenic_drm_primary_formats),
>>  +				       NULL, DRM_PLANE_TYPE_PRIMARY, NULL);
>>  +	if (ret) {
>>  +		dev_err(dev, "Failed to register primary plane: %i\n", ret);
>>  +		goto err_unref_drm;
>>  +	}
>>  +
>>  +	drm_crtc_helper_add(&priv->crtc, &ingenic_drm_crtc_helper_funcs);
>>  +
>>  +	ret =3D drm_crtc_init_with_planes(drm, &priv->crtc, &priv->primary,
>>  +					NULL, &ingenic_drm_crtc_funcs, NULL);
>>  +	if (ret) {
>>  +		dev_err(dev, "Failed to init CRTC: %i\n", ret);
>>  +		goto err_cleanup_plane;
>>  +	}
>>  +
>>  +	priv->encoder.possible_crtcs =3D 1;
>>  +
>>  +	drm_encoder_helper_add(&priv->encoder,
>>  +			       &ingenic_drm_encoder_helper_funcs);
>>  +
>>  +	ret =3D drm_encoder_init(drm, &priv->encoder,=20
>> &ingenic_drm_encoder_funcs,
>>  +			       DRM_MODE_ENCODER_DPI, NULL);
>>  +	if (ret) {
>>  +		dev_err(dev, "Failed to init encoder: %i\n", ret);
>>  +		goto err_cleanup_crtc;
>>  +	}
>>  +
>>  +	ret =3D drm_bridge_attach(&priv->encoder, bridge, NULL);
>>  +	if (ret) {
>>  +		dev_err(dev, "Unable to attach bridge\n");
>>  +		goto err_cleanup_encoder;
>>  +	}
>>  +
>>  +	platform_set_drvdata(pdev, drm);
>>  +	priv->drm =3D drm;
>>  +	drm->dev_private =3D priv;
>>  +
>>  +	ret =3D drm_irq_install(drm, irq);
>>  +	if (ret) {
>>  +		dev_err(dev, "Unable to install IRQ handler\n");
>>  +		goto err_cleanup_encoder;
>>  +	}
>>  +
>>  +	ret =3D drm_vblank_init(drm, 1);
>>  +	if (ret) {
>>  +		dev_err(dev, "Failed calling drm_vblank_init()\n");
>>  +		goto err_uninstall_irq;
>>  +	}
>>  +
>>  +	drm_mode_config_reset(drm);
>>  +
>>  +	ret =3D clk_prepare_enable(priv->pix_clk);
>>  +	if (ret) {
>>  +		dev_err(dev, "Unable to start pixel clock\n");
>>  +		goto err_uninstall_irq;
>>  +	}
>>  +
>>  +	if (priv->lcd_clk) {
>>  +		parent_clk =3D clk_get_parent(priv->lcd_clk);
>>  +		parent_rate =3D clk_get_rate(parent_clk);
>>  +
>>  +		/* LCD Device clock must be 3x the pixel clock for STN panels,
>>  +		 * or 1.5x the pixel clock for TFT panels. To avoid having to
>>  +		 * check for the LCD device clock everytime we do a mode change,
>>  +		 * we set the LCD device clock to the highest rate possible.
>>  +		 */
>>  +		ret =3D clk_set_rate(priv->lcd_clk, parent_rate);
>>  +		if (ret) {
>>  +			dev_err(dev, "Unable to set LCD clock rate\n");
>>  +			goto err_pixclk_disable;
>>  +		}
>>  +
>>  +		ret =3D clk_prepare_enable(priv->lcd_clk);
>>  +		if (ret) {
>>  +			dev_err(dev, "Unable to start lcd clock\n");
>>  +			goto err_pixclk_disable;
>>  +		}
>>  +	}
>>  +
>>  +	ret =3D drm_fbdev_generic_setup(drm, 16);
>>  +	if (ret) {
>>  +		dev_err(dev, "Failed to init fbdev\n");
>>  +		goto err_devclk_disable;
>>  +	}
> fbdev is usually considered an optionl feature that do not prevent
> the display driver from loading.
> Consider what to do in the error case.
>=20

=

