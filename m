Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8114EC10F03
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 23:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2232D2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 23:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="v6xqt1xb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfCAXdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 18:33:51 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:35558 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfCAXdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 18:33:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1551483223; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M9gBlIYyO4o2HJp0iVR53m7NUL16S1dnOwRzMbqww8I=;
        b=v6xqt1xbK/84YjZG8x66d7N8YsLzXV09L8FT6N7YjtYltbMH5K2Ju9kc5/aIT4gx6AgMNj
        VNtNLt1qUQ98iF3B6Qpt8n93abTnLI1HcfY1Y3TJgcuykeb8FhjnDn0m3M9okfj7IUJjJa
        NZ3wN+CwCqI7/10tvvBO1Zhvue6G8AM=
Date:   Fri, 01 Mar 2019 20:33:29 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 3/3] DRM: Add KMS driver for the Ingenic JZ47xx SoCs
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Message-Id: <1551483209.1526.2@crapouillou.net>
In-Reply-To: <20190301210033.GA11150@ravnborg.org>
References: <20190228220756.20262-1-paul@crapouillou.net>
        <20190228220756.20262-4-paul@crapouillou.net>
        <20190301210033.GA11150@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le ven. 1 mars 2019 =E0 18:00, Sam Ravnborg <sam@ravnborg.org> a =E9crit :
> Hi Paul.
>=20
> Driver looks good and is a very nice piece of work.
> In the following a number of minor issues.
>=20
> One area that jumped at me was framedesc and the use of=20
> dma_alloc_coherent()
> I hope someone that knows the memory handling better can give some=20
> advice here.
> To me it looks like something drm should be able to help you with.
>=20
> 	Sam
>=20
>>  --- a/drivers/gpu/drm/Makefile
>>  +++ b/drivers/gpu/drm/Makefile
>>  @@ -94,6 +94,7 @@ obj-$(CONFIG_DRM_TEGRA) +=3D tegra/
>>   obj-$(CONFIG_DRM_STM) +=3D stm/
>>   obj-$(CONFIG_DRM_STI) +=3D sti/
>>   obj-$(CONFIG_DRM_IMX) +=3D imx/
>>  +obj-y			+=3D ingenic/
>=20
> To avoid visiting ingenic/ dir for every build use:
> obj-$(CONFIG_DRM_INGENIC) +=3D ingennic/
>=20
> And accept that you need to do this also in ingenic/Makefile

OK.

>>   obj-$(CONFIG_DRM_MEDIATEK) +=3D mediatek/
>>   obj-$(CONFIG_DRM_MESON)	+=3D meson/
>>   obj-y			+=3D i2c/
>>  +#include <drm/drm_gem_cma_helper.h>
>>  +#include <drm/drm_fb_cma_helper.h>
>>  +#include <drm/drm_fb_helper.h>
>>  +#include <drm/drm_fourcc.h>
>>  +#include <drm/drm_gem_framebuffer_helper.h>
>>  +#include <drm/drm_irq.h>
>>  +#include <drm/drm_panel.h>
>>  +#include <drm/drm_plane.h>
>>  +#include <drm/drm_plane_helper.h>
>>  +#include <drm/drm_probe_helper.h>
>>  +#include <drm/drm_vblank.h>
>>  +
>>  +#include <dt-bindings/display/ingenic,drm.h>
>>  +
>>  +#include "../drm_internal.h"
> No other drivers needs drm_internal.h - what makes this driver=20
> special?
> Or do we have something in drm_internal that should be moved to
> include/drm/ ?

I needed to include it for drm_vblank_cleanup().
But I guess I don't need to call that function? It's not obvious to me
how the error handling and driver removal should be done.

>>  +struct ingenic_framedesc {
>>  +	uint32_t next;
>>  +	uint32_t addr;
>>  +	uint32_t id;
>>  +	uint32_t cmd;
>>  +} __packed;
> For internel types u32 is the typical use.
> uint32_t is usually used in uapi.
>=20
> Consider to use dma_addr_t for addresses - we see this in other=20
> drivers.
> If there are alignemnt constraints then add these.

So 'ingenic_framedesc' represents a DMA descriptor, in the format that
the hardware expects it. The fields must be 32-bit. Is a dma_addr_t
the best option in that case?

>>  +
>>  +struct jz_soc_info {
>>  +	bool needs_dev_clk;
>>  +};
>>  +
>>  +struct ingenic_drm {
>>  +	struct device *dev;
>>  +	void __iomem *base;
>>  +	struct regmap *map;
>>  +	struct clk *lcd_clk, *pix_clk;
>>  +
>>  +	u32 lcd_mode;
>>  +
>>  +	struct ingenic_framedesc *framedesc;
>>  +	dma_addr_t framedesc_phys;
>>  +
>>  +	struct drm_device *drm;
>>  +	struct drm_plane primary;
>>  +	struct drm_crtc crtc;
>>  +	struct drm_connector connector;
>>  +	struct drm_encoder encoder;
>>  +	struct drm_panel *panel;
>>  +
>>  +	struct device_node *panel_node;
> panel_node is not used outside ingenic_drm_probe() so no need
> to have it here.

Noted.

>=20
>>  +
>>  +	unsigned short ps_start, ps_end, cls_start,
>>  +		       cls_end, spl_start, spl_end, rev_start;
> I do not see these used, they can all be dropped.
>=20
>>  +};
>>  +
>>  +
>>  +static const struct regmap_config ingenic_drm_regmap_config =3D {
>>  +	.reg_bits =3D 32,
>>  +	.val_bits =3D 32,
>>  +	.reg_stride =3D 4,
>>  +
>>  +	.max_register =3D JZ_REG_LCD_CMD1,
>>  +	.writeable_reg =3D ingenic_drm_writeable_reg,
>>  +};
>=20
> +1 for using regmap.
>=20
>>  +
>>  +static inline bool ingenic_drm_lcd_is_special_mode(u32 mode)
>>  +{
>>  +	switch (mode) {
>>  +	case JZ_DRM_LCD_SPECIAL_TFT_1:
>>  +	case JZ_DRM_LCD_SPECIAL_TFT_2:
>>  +	case JZ_DRM_LCD_SPECIAL_TFT_3:
>>  +		return true;
>>  +	default:
>>  +		return false;
>>  +	}
>>  +}
> Does it make sense to support these modes today?
> If it is not used in practice then no need to carry it in the driver.

Yes, I have a board that uses such a panel.

>>  +
>>  +static inline bool ingenic_drm_lcd_is_stn_mode(u32 mode)
>>  +{
>>  +	switch (mode) {
>>  +	case JZ_DRM_LCD_SINGLE_COLOR_STN:
>>  +	case JZ_DRM_LCD_SINGLE_MONOCHROME_STN:
>>  +	case JZ_DRM_LCD_DUAL_COLOR_STN:
>>  +	case JZ_DRM_LCD_DUAL_MONOCHROME_STN:
>>  +		return true;
>>  +	default:
>>  +		return false;
>>  +	}
>>  +}
> This function is not used and can be deleted.
> stn display are not really worth it these days anyway.
>=20
>=20
>>  +static void ingenic_drm_crtc_atomic_flush(struct drm_crtc *crtc,
>>  +					  struct drm_crtc_state *oldstate)
>>  +{
>>  +	struct ingenic_drm *priv =3D drm_crtc_get_priv(crtc);
>>  +	struct drm_crtc_state *state =3D crtc->state;
>>  +	struct drm_pending_vblank_event *event =3D state->event;
>>  +	struct drm_framebuffer *drm_fb =3D crtc->primary->state->fb;
>>  +	const struct drm_format_info *finfo;
>>  +	unsigned int width, height;
>>  +
>>  +	if (drm_atomic_crtc_needs_modeset(state)) {
>>  +		finfo =3D drm_format_info(drm_fb->format->format);
>>  +		width =3D state->adjusted_mode.hdisplay;
>>  +		height =3D state->adjusted_mode.vdisplay;
>=20
> width and height are unused and can be dropped.
>=20
>>  +
>>  +		ingenic_drm_crtc_update_timings(priv, &state->mode);
>>  +
>>  +		ingenic_drm_crtc_update_ctrl(priv, finfo->depth);
>>  +		ingenic_drm_crtc_update_cfg(priv, &state->adjusted_mode);
>>  +
>>  +		clk_set_rate(priv->pix_clk, state->adjusted_mode.clock * 1000);
>>  +
>>  +		regmap_write(priv->map, JZ_REG_LCD_DA0, priv->framedesc->next);
>>  +	}
>>  +
>>  +	if (event) {
>>  +		state->event =3D NULL;
>>  +
>>  +		spin_lock_irq(&crtc->dev->event_lock);
>>  +		if (drm_crtc_vblank_get(crtc) =3D=3D 0)
>>  +			drm_crtc_arm_vblank_event(crtc, event);
>>  +		else
>>  +			drm_crtc_send_vblank_event(crtc, event);
>>  +		spin_unlock_irq(&crtc->dev->event_lock);
>>  +	}
>>  +}
>>  +
>>  +static void ingenic_drm_plane_atomic_update(struct drm_plane=20
>> *plane,
>>  +					    struct drm_plane_state *oldstate)
>>  +{
>>  +	struct ingenic_drm *priv =3D drm_plane_get_priv(plane);
>>  +	struct drm_plane_state *state =3D plane->state;
>>  +	const struct drm_format_info *finfo;
>>  +	unsigned int width, height;
>>  +
>>  +	finfo =3D drm_format_info(state->fb->format->format);
>>  +	width =3D state->crtc->state->adjusted_mode.hdisplay;
>>  +	height =3D state->crtc->state->adjusted_mode.vdisplay;
> adjusted_mode->{h,v}display are both ints. So there is a hidden=20
> conversion to unsigned int here.
> and framedesc->cmd is uint32_t then this is maybe fine.
> Noticed so added a comment about it.
>=20
>>  +
>>  +	priv->framedesc->addr =3D drm_fb_cma_get_gem_addr(state->fb, state,=20
>> 0);
>>  +
>>  +	priv->framedesc->cmd =3D width * height * ((finfo->depth + 7) / 8)=20
>> / 4;
>>  +	priv->framedesc->cmd |=3D JZ_LCD_CMD_EOF_IRQ;
>>  +}
>>  +
>>  +static struct drm_driver ingenic_drm_driver_data =3D {
>>  +	.driver_features	=3D DRIVER_MODESET | DRIVER_GEM | DRIVER_PRIME
>>  +				| DRIVER_ATOMIC | DRIVER_HAVE_IRQ,
>=20
> DRIVER_HAVE_IRQ are only for legacy drivers these days.
> You can drop it.
>=20
>>  +	.name			=3D "ingenic-drm",
>>  +	.desc			=3D "DRM module for Ingenic SoCs",
>>  +	.date			=3D "20190228",
>>  +	.major			=3D 1,
>>  +	.minor			=3D 0,
>>  +	.patchlevel		=3D 0,
>>  +
>>  +	.fops			=3D &ingenic_drm_fops,
>>  +
>>  +	.dumb_create		=3D drm_gem_cma_dumb_create,
>>  +	.gem_free_object_unlocked =3D drm_gem_cma_free_object,
>>  +	.gem_vm_ops		=3D &drm_gem_cma_vm_ops,
>>  +
>>  +	.prime_handle_to_fd	=3D drm_gem_prime_handle_to_fd,
>>  +	.prime_fd_to_handle	=3D drm_gem_prime_fd_to_handle,
>=20
>>  +	.gem_prime_import	=3D drm_gem_prime_import,
>>  +	.gem_prime_export	=3D drm_gem_prime_export,
> The two assignments above are not needed. This is the default=20
> behaviour. See drm_drv.h
> (from drm-misc-next)
>=20
>>  +static int ingenic_drm_probe(struct platform_device *pdev)
>>  +{
>>  +	const struct jz_soc_info *soc_info;
>>  +	struct device *dev =3D &pdev->dev;
>>  +	struct ingenic_drm *priv;
>>  +	struct clk *parent_clk;
>>  +	struct drm_device *drm;
>>  +	struct resource *mem;
>>  +	void __iomem *base;
>>  +	long parent_rate;
>>  +	int ret, irq;
>>  +
>>  +	soc_info =3D device_get_match_data(dev);
>>  +	if (!soc_info)
>>  +		return -EINVAL;
>>  +
>>  +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>  +	if (!priv)
>>  +		return -ENOMEM;
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
>>  +	priv->panel_node =3D of_parse_phandle(dev->of_node,=20
>> "ingenic,panel", 0);
>>  +	if (!priv->panel_node) {
>>  +		DRM_INFO("No panel found");
>>  +	} else {
>>  +		priv->panel =3D of_drm_find_panel(priv->panel_node);
>>  +		of_node_put(priv->panel_node);
>>  +
>>  +		if (IS_ERR(priv->panel)) {
>>  +			if (PTR_ERR(priv->panel) =3D=3D -EPROBE_DEFER)
>>  +				return -EPROBE_DEFER;
>>  +
>>  +			priv->panel =3D NULL;
>>  +		} else {
>>  +			ret =3D drm_panel_prepare(priv->panel);
>>  +			if (ret && ret !=3D -ENOSYS)
>>  +				return ret;
>>  +		}
>>  +	}
>>  +
>>  +	if (priv->panel) {
>>  +		ret =3D device_property_read_u32(dev, "ingenic,lcd-mode",
>>  +					       &priv->lcd_mode);
>>  +		if (ret) {
>>  +			dev_err(dev, "Unable to read ingenic,lcd-mode property\n");
>>  +			return ret;
>>  +		}
>>  +	}
>>  +
>>  +	priv->framedesc =3D dma_alloc_coherent(dev,=20
>> sizeof(*priv->framedesc),
>>  +					     &priv->framedesc_phys, GFP_KERNEL);
>>  +	if (!priv->framedesc)
>>  +		return -ENOMEM;
>>  +
>>  +	priv->framedesc->next =3D priv->framedesc_phys;
>>  +	priv->framedesc->id =3D 0xdeafbead;
> I did not really follow this code.
> But you have framedesc that include a next pointer which is uint32_t,
> and you assign to it framedesc_phys which is dmaaddr_t.
> This looks fishy to me, but maybe it is fine.

As explained above, the framedesc is the hardware DMA descriptor, its=20
fields
must be 32-bit, that's why it's done this way.

> When browsing other drivers I see uses of for example=20
> {dma,dmam}_pool_create()
>=20
> When lookign at the origianl fbdev code it is obvious where this=20
> comes from.
> Notice that in the fbdev code JZ_REG_LCD_DA0 register is updated in=20
> the enable function.
> This is done different in this driver.
> Just an observation, what is right I dunno.

JZ_REG_LCD_DA0 should contain the address of the DMA descriptor. In=20
this driver,
I create a single DMA descriptor that commands the transfer of a full=20
frame.
It only has to be set once, so it could even be written in the probe=20
function,
provided the clocks are enabled.

>>  +static int ingenic_drm_remove(struct platform_device *pdev)
>>  +{
>>  +	struct drm_device *drm =3D platform_get_drvdata(pdev);
>>  +	struct ingenic_drm *priv =3D drm->dev_private;
>>  +
>>  +	drm_dev_unregister(drm);
>>  +	drm_mode_config_cleanup(drm);
>>  +
>>  +	if (priv->lcd_clk)
>>  +		clk_disable_unprepare(priv->lcd_clk);
>>  +	clk_disable_unprepare(priv->pix_clk);
>>  +
>>  +	drm_vblank_cleanup(drm);
>>  +	drm_irq_uninstall(drm);
>>  +
>>  +	drm_encoder_cleanup(&priv->encoder);
>>  +	drm_connector_cleanup(&priv->connector);
>>  +	drm_crtc_cleanup(&priv->crtc);
>>  +	drm_plane_cleanup(&priv->primary);
>>  +
>>  +	drm_dev_put(drm);
>>  +
>>  +	dma_free_coherent(&pdev->dev, sizeof(*priv->framedesc),
>>  +			  priv->framedesc, priv->framedesc_phys);
>>  +
>>  +	return 0;
>>  +}
>>  +
>>  +static const struct jz_soc_info jz4740_soc_info =3D {
>>  +	.needs_dev_clk =3D true,
>>  +};
>>  +
>>  +static const struct jz_soc_info jz4725b_soc_info =3D {
>>  +	.needs_dev_clk =3D false,
>>  +};
>>  +
>>  +static const struct of_device_id ingenic_drm_of_match[] =3D {
>>  +	{ .compatible =3D "ingenic,jz4740-drm", .data =3D &jz4740_soc_info },
>>  +	{ .compatible =3D "ingenic,jz4725b-drm", .data =3D &jz4725b_soc_info=20
>> },
>>  +	{},
> Use /* sentinel */ like in most drivers.

For this and other embedded comments I didn't directly reply: duly=20
noted.

Thanks for the review.

Greetings,
-Paul
=

