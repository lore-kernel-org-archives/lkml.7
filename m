Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EF1C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C2920854
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbfCONdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:33:14 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:45305 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbfCONdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 09:33:14 -0400
X-Originating-IP: 185.94.189.187
Received: from localhost (unknown [185.94.189.187])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 0280424001F;
        Fri, 15 Mar 2019 13:33:04 +0000 (UTC)
Date:   Fri, 15 Mar 2019 14:33:04 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, linux-amarula@amarulasolutions.com
Subject: Re: [PATCH 5/6] drm/bridge: Add Chipone ICN6211 MIPI-DSI/RGB
 convertor bridge
Message-ID: <20190315133304.vzwy3tbw27e6lum3@flea>
References: <20190315130825.9005-1-jagan@amarulasolutions.com>
 <20190315130825.9005-6-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ir35vyjoqc5slvyq"
Content-Disposition: inline
In-Reply-To: <20190315130825.9005-6-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ir35vyjoqc5slvyq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2019 at 06:38:24PM +0530, Jagan Teki wrote:
> ICN6211 is MIPI-DSI/RGB converter bridge from chipone.
> It has a flexible configuration of MIPI DSI signal input
> and produce RGB565, RGB666, RGB888 output format.
>=20
> Add bridge driver for it.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  MAINTAINERS                              |   6 +
>  drivers/gpu/drm/bridge/Kconfig           |  10 +
>  drivers/gpu/drm/bridge/Makefile          |   1 +
>  drivers/gpu/drm/bridge/chipone-icn6211.c | 275 +++++++++++++++++++++++
>  4 files changed, 292 insertions(+)
>  create mode 100644 drivers/gpu/drm/bridge/chipone-icn6211.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4de80222cffb..e529addd30f5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4897,6 +4897,12 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
>  S:	Maintained
>  F:	drivers/gpu/drm/bochs/
> =20
> +DRM DRIVER FOR CHIPONE ICN6211 MIPI-DSI to RGB CONVERTOR BRIDGE
> +M:	Jagan Teki <jagan@amarulasolutions.com>
> +S:	Maintained
> +F:	drivers/gpu/drm/bridge/chipone-icn6211.c
> +F:	Documentation/devicetree/bindings/display/bridge/chipone,icn6211.txt
> +
>  DRM DRIVER FOR FARADAY TVE200 TV ENCODER
>  M:	Linus Walleij <linus.walleij@linaro.org>
>  T:	git git://anongit.freedesktop.org/drm/drm-misc
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kcon=
fig
> index 8840f396a7b6..cd314572e4ed 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -36,6 +36,16 @@ config DRM_CDNS_DSI
>  	  Support Cadence DPI to DSI bridge. This is an internal
>  	  bridge and is meant to be directly embedded in a SoC.
> =20
> +config DRM_CHIPONE_ICN6211
> +	tristate "Chipone ICN6211 MIPI-DSI/RGB converter bridge"
> +	depends on DRM && DRM_PANEL
> +	depends on OF
> +	select DRM_MIPI_DSI
> +	help
> +	  ICN6211 is MIPI-DSI/RGB converter bridge from chipone.
> +	  It has a flexible configuration of MIPI DSI signal input
> +	  and produce RGB565, RGB666, RGB888 output format.
> +
>  config DRM_DUMB_VGA_DAC
>  	tristate "Dumb VGA DAC Bridge support"
>  	depends on OF
> diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Mak=
efile
> index 4934fcf5a6f8..541fdccad10b 100644
> --- a/drivers/gpu/drm/bridge/Makefile
> +++ b/drivers/gpu/drm/bridge/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_DRM_ANALOGIX_ANX78XX) +=3D analogix-anx78xx.o
>  obj-$(CONFIG_DRM_CDNS_DSI) +=3D cdns-dsi.o
> +obj-$(CONFIG_DRM_CHIPONE_ICN6211) +=3D chipone-icn6211.o
>  obj-$(CONFIG_DRM_DUMB_VGA_DAC) +=3D dumb-vga-dac.o
>  obj-$(CONFIG_DRM_LVDS_ENCODER) +=3D lvds-encoder.o
>  obj-$(CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW) +=3D megachips-stdpxxx=
x-ge-b850v3-fw.o
> diff --git a/drivers/gpu/drm/bridge/chipone-icn6211.c b/drivers/gpu/drm/b=
ridge/chipone-icn6211.c
> new file mode 100644
> index 000000000000..cd2f3505f845
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/chipone-icn6211.c
> @@ -0,0 +1,275 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2018 Amarula Solutions
> + * Author: Jagan Teki <jagan@amarulasolutions.com>
> + */
> +
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_fb_helper.h>
> +#include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
> +#include <drm/drm_print.h>
> +#include <drm/drm_probe_helper.h>
> +#include <drm/drm_mipi_dsi.h>
> +
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/of_graph.h>
> +
> +#define ICN6211_INIT_CMD_LEN		2
> +
> +struct chipone {
> +	struct device *dev;
> +	struct drm_bridge bridge;
> +	struct drm_connector connector;
> +	struct drm_panel *panel;
> +
> +	struct gpio_desc *reset;
> +};
> +
> +static inline struct chipone *bridge_to_chipone(struct drm_bridge *bridg=
e)
> +{
> +	return container_of(bridge, struct chipone, bridge);
> +}
> +
> +static inline
> +struct chipone *connector_to_chipone(struct drm_connector *connector)
> +{
> +	return container_of(connector, struct chipone, connector);
> +}
> +
> +struct icn6211_init_cmd {
> +	u8 data[ICN6211_INIT_CMD_LEN];
> +};
> +
> +static const struct icn6211_init_cmd icn6211_init_cmds[] =3D {
> +	{ .data =3D { 0x7A, 0xC1 } },
> +	{ .data =3D { 0x20, 0x20 } },
> +	{ .data =3D { 0x21, 0xE0 } },
> +	{ .data =3D { 0x22, 0x13 } },
> +	{ .data =3D { 0x23, 0x28 } },
> +	{ .data =3D { 0x24, 0x30 } },
> +	{ .data =3D { 0x25, 0x28 } },
> +	{ .data =3D { 0x26, 0x00 } },
> +	{ .data =3D { 0x27, 0x0D } },
> +	{ .data =3D { 0x28, 0x03 } },
> +	{ .data =3D { 0x29, 0x1D } },
> +	{ .data =3D { 0x34, 0x80 } },
> +	{ .data =3D { 0x36, 0x28 } },
> +	{ .data =3D { 0xB5, 0xA0 } },
> +	{ .data =3D { 0x5C, 0xFF } },
> +	{ .data =3D { 0x2A, 0x01 } },
> +	{ .data =3D { 0x56, 0x92 } },
> +	{ .data =3D { 0x6B, 0x71 } },
> +	{ .data =3D { 0x69, 0x2B } },
> +	{ .data =3D { 0x10, 0x40 } },
> +	{ .data =3D { 0x11, 0x98 } },
> +	{ .data =3D { 0xB6, 0x20 } },
> +	{ .data =3D { 0x51, 0x20 } },
> +	{ .data =3D { 0x09, 0x10 } },
> +};

What are those commands supposed to be? Some of them at least look
pretty standard (and have proper functions):
MIPI_DCS_EXIT_INVERT_MODE, _SET_DISPLAY_ON, _SET_TEAR_OFF, etc.

> +static int chipone_get_modes(struct drm_connector *connector)
> +{
> +	struct chipone *icn =3D connector_to_chipone(connector);
> +
> +	return drm_panel_get_modes(icn->panel);
> +}
> +
> +static const
> +struct drm_connector_helper_funcs chipone_connector_helper_funcs =3D {
> +	.get_modes =3D chipone_get_modes,
> +};
> +
> +static const struct drm_connector_funcs chipone_connector_funcs =3D {
> +	.fill_modes =3D drm_helper_probe_single_connector_modes,
> +	.destroy =3D drm_connector_cleanup,
> +	.reset =3D drm_atomic_helper_connector_reset,
> +	.atomic_duplicate_state =3D drm_atomic_helper_connector_duplicate_state,
> +	.atomic_destroy_state =3D drm_atomic_helper_connector_destroy_state,
> +};
> +
> +static void chipone_disable(struct drm_bridge *bridge)
> +{
> +	struct chipone *icn =3D bridge_to_chipone(bridge);
> +	int ret =3D drm_panel_disable(bridge_to_chipone(bridge)->panel);
> +
> +	if (ret < 0)
> +		DRM_DEV_ERROR(icn->dev, "error disabling panel (%d)\n", ret);
> +}
> +
> +static void chipone_post_disable(struct drm_bridge *bridge)
> +{
> +	struct chipone *icn =3D bridge_to_chipone(bridge);
> +	int ret;
> +
> +	ret =3D drm_panel_unprepare(icn->panel);
> +	if (ret < 0)
> +		DRM_DEV_ERROR(icn->dev, "error unpreparing panel (%d)\n", ret);
> +
> +	msleep(50);
> +
> +	gpiod_set_value(icn->reset, 0);
> +}
> +
> +static void chipone_pre_enable(struct drm_bridge *bridge)
> +{
> +	struct chipone *icn =3D bridge_to_chipone(bridge);
> +	struct mipi_dsi_device *dsi =3D to_mipi_dsi_device(icn->dev);
> +	unsigned int i;
> +	int ret;
> +
> +	gpiod_set_value(icn->reset, 0);
> +	msleep(20);
> +
> +	gpiod_set_value(icn->reset, 1);
> +	msleep(50);
> +
> +	for (i =3D 0; i < ARRAY_SIZE(icn6211_init_cmds); i++) {
> +		const struct icn6211_init_cmd *cmd =3D &icn6211_init_cmds[i];
> +
> +		ret =3D mipi_dsi_generic_write(dsi, cmd->data,
> +					     ICN6211_INIT_CMD_LEN);
> +		if (ret < 0) {
> +			DRM_DEV_ERROR(icn->dev,
> +				      "failed to write cmd %d: %d\n", i, ret);
> +			return;
> +		}
> +	}
> +
> +	ret =3D drm_panel_prepare(icn->panel);
> +	if (ret < 0)
> +		DRM_DEV_ERROR(icn->dev, "error preparing panel (%d)\n", ret);
> +}
> +
> +static void chipone_enable(struct drm_bridge *bridge)
> +{
> +	struct chipone *icn =3D bridge_to_chipone(bridge);
> +	int ret =3D drm_panel_enable(icn->panel);
> +
> +	if (ret < 0)
> +		DRM_DEV_ERROR(icn->dev, "error enabling panel (%d)\n", ret);
> +}
> +
> +static int chipone_attach(struct drm_bridge *bridge)
> +{
> +	struct chipone *icn =3D bridge_to_chipone(bridge);
> +	struct drm_device *drm =3D bridge->dev;
> +	int ret;
> +
> +	icn->connector.polled =3D DRM_CONNECTOR_POLL_HPD;
> +	ret =3D drm_connector_init(drm, &icn->connector,
> +				 &chipone_connector_funcs,
> +				 DRM_MODE_CONNECTOR_Unknown);

It should be a DRM_MODE_CONNECTOR_DPI connector.

> +	if (ret) {
> +		DRM_ERROR("Failed to initialize connector\n");
> +		return ret;
> +	}
> +
> +	drm_connector_helper_add(&icn->connector,
> +				 &chipone_connector_helper_funcs);
> +	drm_connector_attach_encoder(&icn->connector, bridge->encoder);
> +	drm_panel_attach(icn->panel, &icn->connector);
> +	icn->connector.funcs->reset(&icn->connector);
> +	drm_fb_helper_add_one_connector(drm->fb_helper, &icn->connector);

What do you need that for?

> +	drm_connector_register(&icn->connector);
> +
> +	return 0;
> +}
> +
> +static void chipone_detach(struct drm_bridge *bridge)
> +{
> +	struct chipone *icn =3D bridge_to_chipone(bridge);
> +	struct drm_device *drm =3D bridge->dev;
> +
> +	drm_connector_unregister(&icn->connector);
> +	drm_fb_helper_remove_one_connector(drm->fb_helper, &icn->connector);
> +	drm_panel_detach(icn->panel);
> +	icn->panel =3D NULL;
> +	drm_connector_put(&icn->connector);
> +}
> +
> +static const struct drm_bridge_funcs chipone_bridge_funcs =3D {
> +	.disable =3D chipone_disable,
> +	.post_disable =3D chipone_post_disable,
> +	.enable =3D chipone_enable,
> +	.pre_enable =3D chipone_pre_enable,
> +	.attach =3D chipone_attach,
> +	.detach =3D chipone_detach,
> +};
> +
> +static int chipone_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct device *dev =3D &dsi->dev;
> +	struct chipone *icn;
> +	int ret;
> +
> +	icn =3D devm_kzalloc(dev, sizeof(struct chipone), GFP_KERNEL);
> +	if (!icn)
> +		return -ENOMEM;
> +
> +	mipi_dsi_set_drvdata(dsi, icn);
> +
> +	icn->dev =3D dev;
> +	dsi->lanes =3D 4;
> +	dsi->format =3D MIPI_DSI_FMT_RGB888;
> +	dsi->mode_flags =3D MIPI_DSI_MODE_VIDEO_SYNC_PULSE;
> +
> +	icn->reset =3D devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(icn->reset)) {
> +		DRM_DEV_ERROR(dev, "no reset GPIO pin provided\n");
> +		return PTR_ERR(icn->reset);
> +	}
> +
> +	ret =3D drm_of_find_panel_or_bridge(icn->dev->of_node, 1, 0,
> +					  &icn->panel, NULL);
> +	if (ret && ret !=3D -EPROBE_DEFER) {
> +		DRM_DEV_ERROR(dev, "failed to find panel (ret =3D %d)\n", ret);
> +		return ret;
> +	}
> +
> +	icn->bridge.funcs =3D &chipone_bridge_funcs;
> +	icn->bridge.of_node =3D dev->of_node;
> +
> +	drm_bridge_add(&icn->bridge);
> +
> +	ret =3D mipi_dsi_attach(dsi);
> +	if (ret < 0) {
> +		drm_bridge_remove(&icn->bridge);
> +		DRM_DEV_ERROR(dev, "failed to attach dsi (ret =3D %d)\n", ret);
> +	}
> +
> +	return ret;
> +}
> +
> +static int chipone_remove(struct mipi_dsi_device *dsi)
> +{
> +	struct chipone *icn =3D mipi_dsi_get_drvdata(dsi);
> +
> +	mipi_dsi_detach(dsi);
> +	drm_bridge_remove(&icn->bridge);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id chipone_of_match[] =3D {
> +	{ .compatible =3D "bananapi,icn6211" },

This should have your generic compatible listed

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ir35vyjoqc5slvyq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXIupkAAKCRDj7w1vZxhR
xbZwAQCAMHzsSsC9kTp1iwM2MlsXncPaM9lMknbPZ56TA2HxVAD/ZBuvcuOfsroq
jWh9h791CmoQtF9JercyvkKbCdv6kA4=
=b+is
-----END PGP SIGNATURE-----

--ir35vyjoqc5slvyq--
