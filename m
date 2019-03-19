Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA956C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 03:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9437320854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 03:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfCSDNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 23:13:24 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35436 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfCSDNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 23:13:23 -0400
Received: by mail-ed1-f67.google.com with SMTP id d6so14740262eds.2;
        Mon, 18 Mar 2019 20:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OdJnvpNBYQDryP5Kf/wLnYh9eC1MmlFGzSk9D+G7R30=;
        b=pUYVKCF51P8W6T1ZKgyk41Yuo8I0gWYGsDvA8UhvIOHGqqyHLFlSeAUUCHSs+KEMuH
         XL3Y9Y5b/UAtA0a8gCV7VrfUcerAjMmFuYR40V9xdHmrUH2EE4c1YTiOfQNmXhlP01Za
         DXzLi+Y7TKj8Hl2acSosa4uMmklL0nIAGFq4WxbKt7hBcFFToO1TJsilTaXFwR5IJjZl
         LZOzcy01B5EBDTe4f9ykSYz6Sq7FRXCxJ+MxckZT8X8tL1XpQhZZoy8Bk0A6TK4m90B0
         1FJ8dyy+MqIhWPrkZ4obwN4qJFpoc6cys+O9LYam+LD3DfxbqAll8Pd/dbBOnooHRihg
         V1RQ==
X-Gm-Message-State: APjAAAUgMrWiSFBjoawgiUgTgj/UcIIv5OdqxbdMMRmN8xlcy5tH/eM+
        4T+rCsmsrtucbk22lPIVFLj1/qQV/ZE=
X-Google-Smtp-Source: APXvYqwtycihj5eln+sgrpLUIxmt8MnYarZRslGdDmqAj7rVK274CZ+frQtq6m5HFeS7fG+Jcu9kyA==
X-Received: by 2002:a17:906:f44:: with SMTP id h4mr12451786ejj.4.1552965200302;
        Mon, 18 Mar 2019 20:13:20 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id cd11sm2732667ejb.61.2019.03.18.20.13.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 20:13:20 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id j9so5142817wrn.6;
        Mon, 18 Mar 2019 20:13:20 -0700 (PDT)
X-Received: by 2002:a05:6000:1107:: with SMTP id z7mr13929908wrw.87.1552964743767;
 Mon, 18 Mar 2019 20:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190315130825.9005-1-jagan@amarulasolutions.com>
 <20190315130825.9005-6-jagan@amarulasolutions.com> <20190315133304.vzwy3tbw27e6lum3@flea>
 <CAMty3ZDjq5U3fHAZESuLtx9XMtZmKL=2RG-6QU8UemVtRh-Tuw@mail.gmail.com>
In-Reply-To: <CAMty3ZDjq5U3fHAZESuLtx9XMtZmKL=2RG-6QU8UemVtRh-Tuw@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 19 Mar 2019 11:05:33 +0800
X-Gmail-Original-Message-ID: <CAGb2v65GCkfdMZRmNHyMyv2ECLxKK8w_mD3DALfKK4_J2kn0Og@mail.gmail.com>
Message-ID: <CAGb2v65GCkfdMZRmNHyMyv2ECLxKK8w_mD3DALfKK4_J2kn0Og@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH 5/6] drm/bridge: Add Chipone ICN6211
 MIPI-DSI/RGB convertor bridge
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 1:59 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Fri, Mar 15, 2019 at 7:03 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Fri, Mar 15, 2019 at 06:38:24PM +0530, Jagan Teki wrote:
> > > ICN6211 is MIPI-DSI/RGB converter bridge from chipone.
> > > It has a flexible configuration of MIPI DSI signal input
> > > and produce RGB565, RGB666, RGB888 output format.
> > >
> > > Add bridge driver for it.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > >  MAINTAINERS                              |   6 +
> > >  drivers/gpu/drm/bridge/Kconfig           |  10 +
> > >  drivers/gpu/drm/bridge/Makefile          |   1 +
> > >  drivers/gpu/drm/bridge/chipone-icn6211.c | 275 +++++++++++++++++++++++
> > >  4 files changed, 292 insertions(+)
> > >  create mode 100644 drivers/gpu/drm/bridge/chipone-icn6211.c
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 4de80222cffb..e529addd30f5 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -4897,6 +4897,12 @@ T:     git git://anongit.freedesktop.org/drm/drm-misc
> > >  S:   Maintained
> > >  F:   drivers/gpu/drm/bochs/
> > >
> > > +DRM DRIVER FOR CHIPONE ICN6211 MIPI-DSI to RGB CONVERTOR BRIDGE
> > > +M:   Jagan Teki <jagan@amarulasolutions.com>
> > > +S:   Maintained
> > > +F:   drivers/gpu/drm/bridge/chipone-icn6211.c
> > > +F:   Documentation/devicetree/bindings/display/bridge/chipone,icn6211.txt
> > > +
> > >  DRM DRIVER FOR FARADAY TVE200 TV ENCODER
> > >  M:   Linus Walleij <linus.walleij@linaro.org>
> > >  T:   git git://anongit.freedesktop.org/drm/drm-misc
> > > diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> > > index 8840f396a7b6..cd314572e4ed 100644
> > > --- a/drivers/gpu/drm/bridge/Kconfig
> > > +++ b/drivers/gpu/drm/bridge/Kconfig
> > > @@ -36,6 +36,16 @@ config DRM_CDNS_DSI
> > >         Support Cadence DPI to DSI bridge. This is an internal
> > >         bridge and is meant to be directly embedded in a SoC.
> > >
> > > +config DRM_CHIPONE_ICN6211
> > > +     tristate "Chipone ICN6211 MIPI-DSI/RGB converter bridge"
> > > +     depends on DRM && DRM_PANEL
> > > +     depends on OF
> > > +     select DRM_MIPI_DSI
> > > +     help
> > > +       ICN6211 is MIPI-DSI/RGB converter bridge from chipone.
> > > +       It has a flexible configuration of MIPI DSI signal input
> > > +       and produce RGB565, RGB666, RGB888 output format.
> > > +
> > >  config DRM_DUMB_VGA_DAC
> > >       tristate "Dumb VGA DAC Bridge support"
> > >       depends on OF
> > > diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
> > > index 4934fcf5a6f8..541fdccad10b 100644
> > > --- a/drivers/gpu/drm/bridge/Makefile
> > > +++ b/drivers/gpu/drm/bridge/Makefile
> > > @@ -1,6 +1,7 @@
> > >  # SPDX-License-Identifier: GPL-2.0
> > >  obj-$(CONFIG_DRM_ANALOGIX_ANX78XX) += analogix-anx78xx.o
> > >  obj-$(CONFIG_DRM_CDNS_DSI) += cdns-dsi.o
> > > +obj-$(CONFIG_DRM_CHIPONE_ICN6211) += chipone-icn6211.o
> > >  obj-$(CONFIG_DRM_DUMB_VGA_DAC) += dumb-vga-dac.o
> > >  obj-$(CONFIG_DRM_LVDS_ENCODER) += lvds-encoder.o
> > >  obj-$(CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW) += megachips-stdpxxxx-ge-b850v3-fw.o
> > > diff --git a/drivers/gpu/drm/bridge/chipone-icn6211.c b/drivers/gpu/drm/bridge/chipone-icn6211.c
> > > new file mode 100644
> > > index 000000000000..cd2f3505f845
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/bridge/chipone-icn6211.c
> > > @@ -0,0 +1,275 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * Copyright (C) 2018 Amarula Solutions
> > > + * Author: Jagan Teki <jagan@amarulasolutions.com>
> > > + */
> > > +
> > > +#include <drm/drm_atomic_helper.h>
> > > +#include <drm/drm_fb_helper.h>
> > > +#include <drm/drm_of.h>
> > > +#include <drm/drm_panel.h>
> > > +#include <drm/drm_print.h>
> > > +#include <drm/drm_probe_helper.h>
> > > +#include <drm/drm_mipi_dsi.h>
> > > +
> > > +#include <linux/delay.h>
> > > +#include <linux/gpio/consumer.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of_graph.h>
> > > +
> > > +#define ICN6211_INIT_CMD_LEN         2
> > > +
> > > +struct chipone {
> > > +     struct device *dev;
> > > +     struct drm_bridge bridge;
> > > +     struct drm_connector connector;
> > > +     struct drm_panel *panel;
> > > +
> > > +     struct gpio_desc *reset;
> > > +};
> > > +
> > > +static inline struct chipone *bridge_to_chipone(struct drm_bridge *bridge)
> > > +{
> > > +     return container_of(bridge, struct chipone, bridge);
> > > +}
> > > +
> > > +static inline
> > > +struct chipone *connector_to_chipone(struct drm_connector *connector)
> > > +{
> > > +     return container_of(connector, struct chipone, connector);
> > > +}
> > > +
> > > +struct icn6211_init_cmd {
> > > +     u8 data[ICN6211_INIT_CMD_LEN];
> > > +};
> > > +
> > > +static const struct icn6211_init_cmd icn6211_init_cmds[] = {
> > > +     { .data = { 0x7A, 0xC1 } },
> > > +     { .data = { 0x20, 0x20 } },
> > > +     { .data = { 0x21, 0xE0 } },
> > > +     { .data = { 0x22, 0x13 } },
> > > +     { .data = { 0x23, 0x28 } },
> > > +     { .data = { 0x24, 0x30 } },
> > > +     { .data = { 0x25, 0x28 } },
> > > +     { .data = { 0x26, 0x00 } },
> > > +     { .data = { 0x27, 0x0D } },
> > > +     { .data = { 0x28, 0x03 } },
> > > +     { .data = { 0x29, 0x1D } },
> > > +     { .data = { 0x34, 0x80 } },
> > > +     { .data = { 0x36, 0x28 } },
> > > +     { .data = { 0xB5, 0xA0 } },
> > > +     { .data = { 0x5C, 0xFF } },
> > > +     { .data = { 0x2A, 0x01 } },
> > > +     { .data = { 0x56, 0x92 } },
> > > +     { .data = { 0x6B, 0x71 } },
> > > +     { .data = { 0x69, 0x2B } },
> > > +     { .data = { 0x10, 0x40 } },
> > > +     { .data = { 0x11, 0x98 } },
> > > +     { .data = { 0xB6, 0x20 } },
> > > +     { .data = { 0x51, 0x20 } },
> > > +     { .data = { 0x09, 0x10 } },
> > > +};
> >
> > What are those commands supposed to be? Some of them at least look
> > pretty standard (and have proper functions):
> > MIPI_DCS_EXIT_INVERT_MODE, _SET_DISPLAY_ON, _SET_TEAR_OFF, etc.
>
> As I said in previous Allwinner MIPI-DSI fixes and new code support
> series. For this bridge we don't have programming guide or any
> datasheet. The initialization sequence is taken from BSP panel driver
> and analyzed based on other references mentioned here [1]. Some of the
> command sequence value are based on the timings other based on
> standard MIPI commands as you said. Do you need to add comments to
> describe the same or some other changes?

Please at least put in proper macros or even calculated values for
the stuff that we do know, such as the standard commands and basic
timings that I already worked out for you previously.

For a good reason why, see the slightly cleaned up but still awful
table of init values in the ov5640 camera sensor driver.

> >
> > > +static int chipone_get_modes(struct drm_connector *connector)
> > > +{
> > > +     struct chipone *icn = connector_to_chipone(connector);
> > > +
> > > +     return drm_panel_get_modes(icn->panel);
> > > +}
> > > +
> > > +static const
> > > +struct drm_connector_helper_funcs chipone_connector_helper_funcs = {
> > > +     .get_modes = chipone_get_modes,
> > > +};
> > > +
> > > +static const struct drm_connector_funcs chipone_connector_funcs = {
> > > +     .fill_modes = drm_helper_probe_single_connector_modes,
> > > +     .destroy = drm_connector_cleanup,
> > > +     .reset = drm_atomic_helper_connector_reset,
> > > +     .atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> > > +     .atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> > > +};
> > > +
> > > +static void chipone_disable(struct drm_bridge *bridge)
> > > +{
> > > +     struct chipone *icn = bridge_to_chipone(bridge);
> > > +     int ret = drm_panel_disable(bridge_to_chipone(bridge)->panel);
> > > +
> > > +     if (ret < 0)
> > > +             DRM_DEV_ERROR(icn->dev, "error disabling panel (%d)\n", ret);
> > > +}
> > > +
> > > +static void chipone_post_disable(struct drm_bridge *bridge)
> > > +{
> > > +     struct chipone *icn = bridge_to_chipone(bridge);
> > > +     int ret;
> > > +
> > > +     ret = drm_panel_unprepare(icn->panel);
> > > +     if (ret < 0)
> > > +             DRM_DEV_ERROR(icn->dev, "error unpreparing panel (%d)\n", ret);
> > > +
> > > +     msleep(50);
> > > +
> > > +     gpiod_set_value(icn->reset, 0);
> > > +}
> > > +
> > > +static void chipone_pre_enable(struct drm_bridge *bridge)
> > > +{
> > > +     struct chipone *icn = bridge_to_chipone(bridge);
> > > +     struct mipi_dsi_device *dsi = to_mipi_dsi_device(icn->dev);
> > > +     unsigned int i;
> > > +     int ret;
> > > +
> > > +     gpiod_set_value(icn->reset, 0);
> > > +     msleep(20);
> > > +
> > > +     gpiod_set_value(icn->reset, 1);
> > > +     msleep(50);
> > > +
> > > +     for (i = 0; i < ARRAY_SIZE(icn6211_init_cmds); i++) {
> > > +             const struct icn6211_init_cmd *cmd = &icn6211_init_cmds[i];
> > > +
> > > +             ret = mipi_dsi_generic_write(dsi, cmd->data,
> > > +                                          ICN6211_INIT_CMD_LEN);
> > > +             if (ret < 0) {
> > > +                     DRM_DEV_ERROR(icn->dev,
> > > +                                   "failed to write cmd %d: %d\n", i, ret);
> > > +                     return;
> > > +             }
> > > +     }
> > > +
> > > +     ret = drm_panel_prepare(icn->panel);
> > > +     if (ret < 0)
> > > +             DRM_DEV_ERROR(icn->dev, "error preparing panel (%d)\n", ret);
> > > +}
> > > +
> > > +static void chipone_enable(struct drm_bridge *bridge)
> > > +{
> > > +     struct chipone *icn = bridge_to_chipone(bridge);
> > > +     int ret = drm_panel_enable(icn->panel);
> > > +
> > > +     if (ret < 0)
> > > +             DRM_DEV_ERROR(icn->dev, "error enabling panel (%d)\n", ret);
> > > +}
> > > +
> > > +static int chipone_attach(struct drm_bridge *bridge)
> > > +{
> > > +     struct chipone *icn = bridge_to_chipone(bridge);
> > > +     struct drm_device *drm = bridge->dev;
> > > +     int ret;
> > > +
> > > +     icn->connector.polled = DRM_CONNECTOR_POLL_HPD;
> > > +     ret = drm_connector_init(drm, &icn->connector,
> > > +                              &chipone_connector_funcs,
> > > +                              DRM_MODE_CONNECTOR_Unknown);
> >
> > It should be a DRM_MODE_CONNECTOR_DPI connector.
>
> Since the output connector is RGB, I have used 'Unknown' since we
> follow similar connector type in sun4i_rgb.c So these RGB comes under
> parallel display interface we can have to use this DPI connector is
> it?

It should be the DPI connector. We used the wrong connector to begin
with and now we can't fix it, since the connector type is exported to
userspace.

> >
> > > +     if (ret) {
> > > +             DRM_ERROR("Failed to initialize connector\n");
> > > +             return ret;
> > > +     }
> > > +
> > > +     drm_connector_helper_add(&icn->connector,
> > > +                              &chipone_connector_helper_funcs);
> > > +     drm_connector_attach_encoder(&icn->connector, bridge->encoder);
> > > +     drm_panel_attach(icn->panel, &icn->connector);
> > > +     icn->connector.funcs->reset(&icn->connector);
> > > +     drm_fb_helper_add_one_connector(drm->fb_helper, &icn->connector);
> >
> > What do you need that for?
>
> I took the reference code, sorry it is accidentally present will
> wind-up in next version.
>
> >
> > > +     drm_connector_register(&icn->connector);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static void chipone_detach(struct drm_bridge *bridge)
> > > +{
> > > +     struct chipone *icn = bridge_to_chipone(bridge);
> > > +     struct drm_device *drm = bridge->dev;
> > > +
> > > +     drm_connector_unregister(&icn->connector);
> > > +     drm_fb_helper_remove_one_connector(drm->fb_helper, &icn->connector);
> > > +     drm_panel_detach(icn->panel);
> > > +     icn->panel = NULL;
> > > +     drm_connector_put(&icn->connector);
> > > +}
> > > +
> > > +static const struct drm_bridge_funcs chipone_bridge_funcs = {
> > > +     .disable = chipone_disable,
> > > +     .post_disable = chipone_post_disable,
> > > +     .enable = chipone_enable,
> > > +     .pre_enable = chipone_pre_enable,
> > > +     .attach = chipone_attach,
> > > +     .detach = chipone_detach,
> > > +};
> > > +
> > > +static int chipone_probe(struct mipi_dsi_device *dsi)
> > > +{
> > > +     struct device *dev = &dsi->dev;
> > > +     struct chipone *icn;
> > > +     int ret;
> > > +
> > > +     icn = devm_kzalloc(dev, sizeof(struct chipone), GFP_KERNEL);
> > > +     if (!icn)
> > > +             return -ENOMEM;
> > > +
> > > +     mipi_dsi_set_drvdata(dsi, icn);
> > > +
> > > +     icn->dev = dev;
> > > +     dsi->lanes = 4;
> > > +     dsi->format = MIPI_DSI_FMT_RGB888;
> > > +     dsi->mode_flags = MIPI_DSI_MODE_VIDEO_SYNC_PULSE;
> > > +
> > > +     icn->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> > > +     if (IS_ERR(icn->reset)) {
> > > +             DRM_DEV_ERROR(dev, "no reset GPIO pin provided\n");
> > > +             return PTR_ERR(icn->reset);
> > > +     }
> > > +
> > > +     ret = drm_of_find_panel_or_bridge(icn->dev->of_node, 1, 0,
> > > +                                       &icn->panel, NULL);
> > > +     if (ret && ret != -EPROBE_DEFER) {
> > > +             DRM_DEV_ERROR(dev, "failed to find panel (ret = %d)\n", ret);
> > > +             return ret;
> > > +     }
> > > +
> > > +     icn->bridge.funcs = &chipone_bridge_funcs;
> > > +     icn->bridge.of_node = dev->of_node;
> > > +
> > > +     drm_bridge_add(&icn->bridge);
> > > +
> > > +     ret = mipi_dsi_attach(dsi);
> > > +     if (ret < 0) {
> > > +             drm_bridge_remove(&icn->bridge);
> > > +             DRM_DEV_ERROR(dev, "failed to attach dsi (ret = %d)\n", ret);
> > > +     }
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +static int chipone_remove(struct mipi_dsi_device *dsi)
> > > +{
> > > +     struct chipone *icn = mipi_dsi_get_drvdata(dsi);
> > > +
> > > +     mipi_dsi_detach(dsi);
> > > +     drm_bridge_remove(&icn->bridge);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static const struct of_device_id chipone_of_match[] = {
> > > +     { .compatible = "bananapi,icn6211" },
> >
> > This should have your generic compatible listed
>
> Any idea why? usually it can be know attached device associated IC
> chip isn't it? I can see this similar approach in some panel driver
> which I commented in 4/5
> https://patchwork.freedesktop.org/patch/292416/

A panel driver is tied to a specific set of timings, as required by
the actual LCD panel. A bridge on the other hand is generic. Whatever
timings needed are a property of the downstream end device. So you
really need to use the generic compatible string here.

You can add a big fat warning in this driver saying it currently only
supports one panel, and even peek at the downstream panel and bail out
if it's not the expected one. If other people encounter this chip, they
can come in and either add their own set of init commands, or even help
to generalize this driver.

ChenYu

> [1] https://patchwork.kernel.org/patch/10617921/
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
