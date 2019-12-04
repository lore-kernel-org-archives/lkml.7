Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A9FC2BD09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF35B20865
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbfLDMGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 07:06:51 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:55858 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727445AbfLDMGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 07:06:51 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id B1417FB05;
        Wed,  4 Dec 2019 13:06:47 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id K5KA9HjBBtht; Wed,  4 Dec 2019 13:06:39 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id B70D64964C; Wed,  4 Dec 2019 13:06:38 +0100 (CET)
Date:   Wed, 4 Dec 2019 13:06:38 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Robert Chiras <robert.chiras@nxp.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "jernej.skrabec@siol.net" <jernej.skrabec@siol.net>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "a.hajda@samsung.com" <a.hajda@samsung.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "jonas@kwiboo.se" <jonas@kwiboo.se>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [EXT] [PATCH v8 2/2] drm/bridge: Add NWL MIPI DSI host
 controller support
Message-ID: <20191204120638.GB18094@bogon.m.sigxcpu.org>
References: <cover.1575315215.git.agx@sigxcpu.org>
 <cf9957498dd6d26015d8f39f47189b0df047ffc4.1575315215.git.agx@sigxcpu.org>
 <1575366594.6423.61.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1575366594.6423.61.camel@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,
On Tue, Dec 03, 2019 at 09:50:03AM +0000, Robert Chiras wrote:
> Hi Guido,
> 
> Since your last revision sent, I've done more tests here and found a
> few more improvements that could be added to this driver.
> See inline.
> 
> On Lu, 2019-12-02 at 20:35 +0100, Guido Günther wrote:
> > Caution: EXT Email
> > 
> > This adds initial support for the NWL MIPI DSI Host controller found
> > on
> > i.MX8 SoCs.
> > 
> > It adds support for the i.MX8MQ but the same IP can be found on
> > e.g. the i.MX8QXP.
> > 
> > It has been tested on the Librem 5 devkit using mxsfb.
> > 
> > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> > Co-developed-by: Robert Chiras <robert.chiras@nxp.com>
> > Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
> > Tested-by: Robert Chiras <robert.chiras@nxp.com>
> > ---
> >  drivers/gpu/drm/bridge/Kconfig   |   16 +
> >  drivers/gpu/drm/bridge/Makefile  |    3 +
> >  drivers/gpu/drm/bridge/nwl-dsi.c | 1230
> > ++++++++++++++++++++++++++++++
> >  drivers/gpu/drm/bridge/nwl-dsi.h |  144 ++++
> >  4 files changed, 1393 insertions(+)
> >  create mode 100644 drivers/gpu/drm/bridge/nwl-dsi.c
> >  create mode 100644 drivers/gpu/drm/bridge/nwl-dsi.h
> > 
> > diff --git a/drivers/gpu/drm/bridge/Kconfig
> > b/drivers/gpu/drm/bridge/Kconfig
> > index 34362976cd6f..6fb534f55d22 100644
> > --- a/drivers/gpu/drm/bridge/Kconfig
> > +++ b/drivers/gpu/drm/bridge/Kconfig
> > @@ -65,6 +65,22 @@ config DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW
> >            to DP++. This is used with the i.MX6 imx-ldb
> >            driver. You are likely to say N here.
> > 
> > +config DRM_NWL_MIPI_DSI
> > +       tristate "Northwest Logic MIPI DSI Host controller"
> > +       depends on DRM
> > +       depends on COMMON_CLK
> > +       depends on OF && HAS_IOMEM
> > +       select DRM_KMS_HELPER
> > +       select DRM_MIPI_DSI
> > +       select DRM_PANEL_BRIDGE
> > +       select GENERIC_PHY_MIPI_DPHY
> > +       select MFD_SYSCON
> > +       select MULTIPLEXER
> > +       select REGMAP_MMIO
> > +       help
> > +         This enables the Northwest Logic MIPI DSI Host controller
> > as
> > +         for example found on NXP's i.MX8 Processors.
> > +
> >  config DRM_NXP_PTN3460
> >         tristate "NXP PTN3460 DP/LVDS bridge"
> >         depends on OF
> > diff --git a/drivers/gpu/drm/bridge/Makefile
> > b/drivers/gpu/drm/bridge/Makefile
> > index 4934fcf5a6f8..c3f3a43e9b8f 100644
> > --- a/drivers/gpu/drm/bridge/Makefile
> > +++ b/drivers/gpu/drm/bridge/Makefile
> > @@ -16,4 +16,7 @@ obj-$(CONFIG_DRM_ANALOGIX_DP) += analogix/
> >  obj-$(CONFIG_DRM_I2C_ADV7511) += adv7511/
> >  obj-$(CONFIG_DRM_TI_SN65DSI86) += ti-sn65dsi86.o
> >  obj-$(CONFIG_DRM_TI_TFP410) += ti-tfp410.o
> > +obj-$(CONFIG_DRM_NWL_MIPI_DSI) += nwl-dsi.o
> >  obj-y += synopsys/
> > +
> > +header-test-y += nwl-dsi.h
> > diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c
> > b/drivers/gpu/drm/bridge/nwl-dsi.c
> > new file mode 100644
> > index 000000000000..023191894fe4
> > --- /dev/null
> > +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> > @@ -0,0 +1,1230 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * i.MX8 NWL MIPI DSI host driver
> > + *
> > + * Copyright (C) 2017 NXP
> > + * Copyright (C) 2019 Purism SPC
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/clk.h>
> > +#include <linux/irq.h>
> > +#include <linux/math64.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/module.h>
> > +#include <linux/mux/consumer.h>
> > +#include <linux/of.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/phy/phy.h>
> > +#include <linux/regmap.h>
> > +#include <linux/reset.h>
> > +#include <linux/sys_soc.h>
> > +#include <linux/time64.h>
> > +
> > +#include <drm/drm_atomic_helper.h>
> > +#include <drm/drm_bridge.h>
> > +#include <drm/drm_mipi_dsi.h>
> > +#include <drm/drm_of.h>
> > +#include <drm/drm_panel.h>
> > +#include <drm/drm_print.h>
> > +#include <drm/drm_probe_helper.h>
> > +
> > +#include <video/mipi_display.h>
> > +#include <video/videomode.h>
> > +
> > +#include "nwl-dsi.h"
> > +
> > +#define DRV_NAME "nwl-dsi"
> > +
> > +/* i.MX8 NWL quirks */
> > +/* i.MX8MQ errata E11418 */
> > +#define E11418_HS_MODE_QUIRK   BIT(0)
> > +
> > +#define NWL_DSI_MIPI_FIFO_TIMEOUT msecs_to_jiffies(500)
> > +
> > +enum transfer_direction {
> > +       DSI_PACKET_SEND,
> > +       DSI_PACKET_RECEIVE,
> > +};
> > +
> > +/* Possible platform specific clocks */
> > +#define NWL_DSI_CLK_CORE           "core"
> > +#define NWL_DSI_MAX_PLATFORM_CLOCKS 1
> > +
> > +#define NWL_DSI_ENDPOINT_LCDIF 0
> > +#define NWL_DSI_ENDPOINT_DCSS 1
> > +
> > +struct nwl_dsi_plat_clk_config {
> > +       const char *id;
> > +       struct clk *clk;
> > +       bool present;
> > +};
> > +
> > +struct nwl_dsi_transfer {
> > +       const struct mipi_dsi_msg *msg;
> > +       struct mipi_dsi_packet packet;
> > +       struct completion completed;
> > +
> > +       int status; /* status of transmission */
> > +       enum transfer_direction direction;
> > +       bool need_bta;
> > +       u8 cmd;
> > +       u16 rx_word_count;
> > +       size_t tx_len; /* in bytes */
> > +       size_t rx_len; /* in bytes */
> > +};
> > +
> > +struct nwl_dsi {
> > +       struct drm_bridge bridge;
> > +       struct mipi_dsi_host dsi_host;
> > +       struct drm_bridge *panel_bridge;
> > +       struct device *dev;
> > +       struct phy *phy;
> > +       union phy_configure_opts phy_cfg;
> > +       unsigned int quirks;
> > +
> > +       struct regmap *regmap;
> > +       int irq;
> > +       struct reset_control *rstc;
> > +       struct mux_control *mux;
> > +
> > +       /* DSI clocks */
> > +       struct clk *phy_ref_clk;
> > +       struct clk *rx_esc_clk;
> > +       struct clk *tx_esc_clk;
> > +       /* Platform dependent clocks */
> > +       struct nwl_dsi_plat_clk_config
> > clk_config[NWL_DSI_MAX_PLATFORM_CLOCKS];
> > +
> > +       /* dsi lanes */
> > +       u32 lanes;
> > +       enum mipi_dsi_pixel_format format;
> > +       struct drm_display_mode mode;
> > +       unsigned long dsi_mode_flags;
> > +       int error;
> > +
> > +       struct nwl_dsi_transfer *xfer;
> > +
> > +       const struct nwl_dsi_platform_data *pdata;
> > +};
> > +
> > +/* Platform specific hooks to enable other SoCs like the i.MX8QM */
> > +struct nwl_dsi_platform_data {
> > +       int (*poweron)(struct nwl_dsi *dsi);
> > +       int (*poweroff)(struct nwl_dsi *dsi);
> > +       int (*select_input)(struct nwl_dsi *dsi);
> > +       int (*deselect_input)(struct nwl_dsi *dsi);
> > +       struct nwl_dsi_plat_clk_config
> > clk_config[NWL_DSI_MAX_PLATFORM_CLOCKS];
> > +};
> > +
> > +static const struct regmap_config nwl_dsi_regmap_config = {
> > +       .reg_bits = 16,
> > +       .val_bits = 32,
> > +       .reg_stride = 4,
> > +       .max_register = NWL_DSI_IRQ_MASK2,
> > +       .name = DRV_NAME,
> > +};
> > +
> > +static inline struct nwl_dsi *bridge_to_dsi(struct drm_bridge
> > *bridge)
> > +{
> > +       return container_of(bridge, struct nwl_dsi, bridge);
> > +}
> > +
> > +static int nwl_dsi_clear_error(struct nwl_dsi *dsi)
> > +{
> > +       int ret = dsi->error;
> > +
> > +       dsi->error = 0;
> > +       return ret;
> > +}
> > +
> > +static void nwl_dsi_write(struct nwl_dsi *dsi, unsigned int reg, u32
> > val)
> > +{
> > +       int ret;
> > +
> > +       if (dsi->error)
> > +               return;
> > +
> > +       ret = regmap_write(dsi->regmap, reg, val);
> > +       if (ret < 0) {
> > +               DRM_DEV_ERROR(dsi->dev,
> > +                             "Failed to write NWL DSI reg 0x%x:
> > %d\n", reg,
> > +                             ret);
> > +               dsi->error = ret;
> > +       }
> > +}
> > +
> > +static u32 nwl_dsi_read(struct nwl_dsi *dsi, u32 reg)
> > +{
> > +       unsigned int val;
> > +       int ret;
> > +
> > +       if (dsi->error)
> > +               return 0;
> > +
> > +       ret = regmap_read(dsi->regmap, reg, &val);
> > +       if (ret < 0) {
> > +               DRM_DEV_ERROR(dsi->dev, "Failed to read NWL DSI reg
> > 0x%x: %d\n",
> > +                             reg, ret);
> > +               dsi->error = ret;
> > +       }
> > +       return val;
> > +}
> > +
> > +static int nwl_dsi_get_dpi_pixel_format(enum mipi_dsi_pixel_format
> > format)
> > +{
> > +       switch (format) {
> > +       case MIPI_DSI_FMT_RGB565:
> > +               return NWL_DSI_PIXEL_FORMAT_16;
> > +       case MIPI_DSI_FMT_RGB666:
> > +               return NWL_DSI_PIXEL_FORMAT_18L;
> > +       case MIPI_DSI_FMT_RGB666_PACKED:
> > +               return NWL_DSI_PIXEL_FORMAT_18;
> > +       case MIPI_DSI_FMT_RGB888:
> > +               return NWL_DSI_PIXEL_FORMAT_24;
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +}
> > +
> > +/*
> > + * ps2bc - Picoseconds to byte clock cycles
> > + */
> > +static u32 ps2bc(struct nwl_dsi *dsi, unsigned long long ps)
> > +{
> > +       u32 bpp = mipi_dsi_pixel_format_to_bpp(dsi->format);
> > +
> > +       return DIV64_U64_ROUND_UP(ps * dsi->mode.clock * bpp,
> > +                                 dsi->lanes * 8 * NSEC_PER_SEC);
> > +}
> > +
> > +/*
> > + * ui2bc - UI time periods to byte clock cycles
> > + */
> > +static u32 ui2bc(struct nwl_dsi *dsi, unsigned long long ui)
> > +{
> > +       u32 bpp = mipi_dsi_pixel_format_to_bpp(dsi->format);
> > +
> > +       return DIV64_U64_ROUND_UP(ui * dsi->lanes,
> > +                                 dsi->mode.clock * 1000 * bpp);
> > +}
> > +
> > +/*
> > + * us2bc - micro seconds to lp clock cycles
> > + */
> > +static u32 us2lp(u32 lp_clk_rate, unsigned long us)
> > +{
> > +       return DIV_ROUND_UP(us * lp_clk_rate, USEC_PER_SEC);
> > +}
> > +
> > +static int nwl_dsi_config_host(struct nwl_dsi *dsi)
> > +{
> > +       u32 cycles;
> > +       struct phy_configure_opts_mipi_dphy *cfg = &dsi-
> > >phy_cfg.mipi_dphy;
> > +
> > +       if (dsi->lanes < 1 || dsi->lanes > 4)
> > +               return -EINVAL;
> > +
> > +       DRM_DEV_DEBUG_DRIVER(dsi->dev, "DSI Lanes %d\n", dsi->lanes);
> > +       nwl_dsi_write(dsi, NWL_DSI_CFG_NUM_LANES, dsi->lanes - 1);
> > +
> > +       if (dsi->dsi_mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS) {
> > +               nwl_dsi_write(dsi, NWL_DSI_CFG_NONCONTINUOUS_CLK,
> > 0x01);
> > +               nwl_dsi_write(dsi, NWL_DSI_CFG_AUTOINSERT_EOTP,
> > 0x01);
> > +       } else {
> > +               nwl_dsi_write(dsi, NWL_DSI_CFG_NONCONTINUOUS_CLK,
> > 0x00);
> > +               nwl_dsi_write(dsi, NWL_DSI_CFG_AUTOINSERT_EOTP,
> > 0x00);
> > +       }
> > +
> > +       /* values in byte clock cycles */
> > +       cycles = ui2bc(dsi, cfg->clk_pre);
> > +       DRM_DEV_DEBUG_DRIVER(dsi->dev, "cfg_t_pre: 0x%x\n", cycles);
> > +       nwl_dsi_write(dsi, NWL_DSI_CFG_T_PRE, cycles);
> > +       cycles = ps2bc(dsi, cfg->lpx + cfg->clk_prepare + cfg-
> > >clk_zero);
> > +       DRM_DEV_DEBUG_DRIVER(dsi->dev, "cfg_tx_gap (pre): 0x%x\n",
> > cycles);
> > +       cycles += ui2bc(dsi, cfg->clk_pre);
> > +       DRM_DEV_DEBUG_DRIVER(dsi->dev, "cfg_t_post: 0x%x\n", cycles);
> > +       nwl_dsi_write(dsi, NWL_DSI_CFG_T_POST, cycles);
> > +       cycles = ps2bc(dsi, cfg->hs_exit);
> > +       DRM_DEV_DEBUG_DRIVER(dsi->dev, "cfg_tx_gap: 0x%x\n", cycles);
> > +       nwl_dsi_write(dsi, NWL_DSI_CFG_TX_GAP, cycles);
> > +
> > +       nwl_dsi_write(dsi, NWL_DSI_CFG_EXTRA_CMDS_AFTER_EOTP, 0x01);
> > +       nwl_dsi_write(dsi, NWL_DSI_CFG_HTX_TO_COUNT, 0x00);
> > +       nwl_dsi_write(dsi, NWL_DSI_CFG_LRX_H_TO_COUNT, 0x00);
> > +       nwl_dsi_write(dsi, NWL_DSI_CFG_BTA_H_TO_COUNT, 0x00);
> > +       /* In LP clock cycles */
> > +       cycles = us2lp(cfg->lp_clk_rate, cfg->wakeup);
> > +       DRM_DEV_DEBUG_DRIVER(dsi->dev, "cfg_twakeup: 0x%x\n",
> > cycles);
> > +       nwl_dsi_write(dsi, NWL_DSI_CFG_TWAKEUP, cycles);
> > +
> > +       return nwl_dsi_clear_error(dsi);
> > +}
> > +
> > +static int nwl_dsi_config_dpi(struct nwl_dsi *dsi)
> > +{
> > +       u32 mode;
> > +       int color_format;
> > +       bool burst_mode;
> > +       int hfront_porch, hback_porch, vfront_porch, vback_porch;
> > +       int hsync_len, vsync_len;
> > +
> > +       hfront_porch = dsi->mode.hsync_start - dsi->mode.hdisplay;
> > +       hsync_len = dsi->mode.hsync_end - dsi->mode.hsync_start;
> > +       hback_porch = dsi->mode.htotal - dsi->mode.hsync_end;
> > +
> > +       vfront_porch = dsi->mode.vsync_start - dsi->mode.vdisplay;
> > +       vsync_len = dsi->mode.vsync_end - dsi->mode.vsync_start;
> > +       vback_porch = dsi->mode.vtotal - dsi->mode.vsync_end;
> > +
> > +       DRM_DEV_DEBUG_DRIVER(dsi->dev, "hfront_porch = %d\n",
> > hfront_porch);
> > +       DRM_DEV_DEBUG_DRIVER(dsi->dev, "hback_porch = %d\n",
> > hback_porch);
> > +       DRM_DEV_DEBUG_DRIVER(dsi->dev, "hsync_len = %d\n",
> > hsync_len);
> > +       DRM_DEV_DEBUG_DRIVER(dsi->dev, "hdisplay = %d\n", dsi-
> > >mode.hdisplay);
> > +       DRM_DEV_DEBUG_DRIVER(dsi->dev, "vfront_porch = %d\n",
> > vfront_porch);
> > +       DRM_DEV_DEBUG_DRIVER(dsi->dev, "vback_porch = %d\n",
> > vback_porch);
> > +       DRM_DEV_DEBUG_DRIVER(dsi->dev, "vsync_len = %d\n",
> > vsync_len);
> > +       DRM_DEV_DEBUG_DRIVER(dsi->dev, "vactive = %d\n", dsi-
> > >mode.vdisplay);
> > +       DRM_DEV_DEBUG_DRIVER(dsi->dev, "clock = %d kHz\n", dsi-
> > >mode.clock);
> > +
> > +       color_format = nwl_dsi_get_dpi_pixel_format(dsi->format);
> > +       if (color_format < 0) {
> > +               DRM_DEV_ERROR(dsi->dev, "Invalid color format
> > 0x%x\n",
> > +                             dsi->format);
> > +               return color_format;
> > +       }
> > +       DRM_DEV_DEBUG_DRIVER(dsi->dev, "pixel fmt = %d\n", dsi-
> > >format);
> > +
> > +       nwl_dsi_write(dsi, NWL_DSI_INTERFACE_COLOR_CODING,
> > NWL_DSI_DPI_24_BIT);
> > +       nwl_dsi_write(dsi, NWL_DSI_PIXEL_FORMAT, color_format);
> > +       /*
> > +        * Adjusting input polarity based on the video mode results
> > in
> > +        * a black screen so always pick active low:
> > +        */
> > +       nwl_dsi_write(dsi, NWL_DSI_VSYNC_POLARITY,
> > +                     NWL_DSI_VSYNC_POLARITY_ACTIVE_LOW);
> > +       nwl_dsi_write(dsi, NWL_DSI_HSYNC_POLARITY,
> > +                     NWL_DSI_HSYNC_POLARITY_ACTIVE_LOW);
> > +
> > +       burst_mode = (dsi->dsi_mode_flags &
> > MIPI_DSI_MODE_VIDEO_BURST) &&
> > +                    !(dsi->dsi_mode_flags &
> > MIPI_DSI_MODE_VIDEO_SYNC_PULSE);
> > +
> > +       if (burst_mode) {
> > +               nwl_dsi_write(dsi, NWL_DSI_VIDEO_MODE,
> > NWL_DSI_VM_BURST_MODE);
> > +               nwl_dsi_write(dsi, NWL_DSI_PIXEL_FIFO_SEND_LEVEL,
> > 256);
> > +       } else {
> > +               mode = ((dsi->dsi_mode_flags &
> > MIPI_DSI_MODE_VIDEO_SYNC_PULSE) ?
> > +                               NWL_DSI_VM_BURST_MODE_WITH_SYNC_PULSE
> > S :
> > +                               NWL_DSI_VM_NON_BURST_MODE_WITH_SYNC_E
> > VENTS);
> > +               nwl_dsi_write(dsi, NWL_DSI_VIDEO_MODE, mode);
> > +               nwl_dsi_write(dsi, NWL_DSI_PIXEL_FIFO_SEND_LEVEL,
> > +                             dsi->mode.hdisplay);
> > +       }
> > +
> > +       nwl_dsi_write(dsi, NWL_DSI_HFP, hfront_porch);
> > +       nwl_dsi_write(dsi, NWL_DSI_HBP, hback_porch);
> > +       nwl_dsi_write(dsi, NWL_DSI_HSA, hsync_len);
> > +
> > +       nwl_dsi_write(dsi, NWL_DSI_ENABLE_MULT_PKTS, 0x0);
> > +       nwl_dsi_write(dsi, NWL_DSI_BLLP_MODE, 0x1);
> > +       nwl_dsi_write(dsi, NWL_DSI_USE_NULL_PKT_BLLP, 0x0);
> > +       nwl_dsi_write(dsi, NWL_DSI_VC, 0x0);
> > +
> > +       nwl_dsi_write(dsi, NWL_DSI_PIXEL_PAYLOAD_SIZE, dsi-
> > >mode.hdisplay);
> > +       nwl_dsi_write(dsi, NWL_DSI_VACTIVE, dsi->mode.vdisplay - 1);
> > +       nwl_dsi_write(dsi, NWL_DSI_VBP, vback_porch);
> > +       nwl_dsi_write(dsi, NWL_DSI_VFP, vfront_porch);
> > +
> > +       return nwl_dsi_clear_error(dsi);
> > +}
> > +
> > +static int nwl_dsi_init_interrupts(struct nwl_dsi *dsi)
> > +{
> > +       u32 irq_enable;
> > +
> > +       nwl_dsi_write(dsi, NWL_DSI_IRQ_MASK, 0xffffffff);
> > +       nwl_dsi_write(dsi, NWL_DSI_IRQ_MASK2, 0x7);
> > +
> > +       irq_enable = ~(u32)(NWL_DSI_TX_PKT_DONE_MASK |
> > +                           NWL_DSI_RX_PKT_HDR_RCVD_MASK |
> > +                           NWL_DSI_TX_FIFO_OVFLW_MASK |
> > +                           NWL_DSI_HS_TX_TIMEOUT_MASK);
> > +
> > +       nwl_dsi_write(dsi, NWL_DSI_IRQ_MASK, irq_enable);
> > +
> > +       return nwl_dsi_clear_error(dsi);
> > +}
> > +
> > +static int nwl_dsi_host_attach(struct mipi_dsi_host *dsi_host,
> > +                              struct mipi_dsi_device *device)
> > +{
> > +       struct nwl_dsi *dsi = container_of(dsi_host, struct nwl_dsi,
> > dsi_host);
> > +       struct device *dev = dsi->dev;
> > +       struct drm_bridge *bridge;
> > +       struct drm_panel *panel;
> > +       int ret;
> > +
> > +       DRM_DEV_INFO(dev, "lanes=%u, format=0x%x flags=0x%lx\n",
> > device->lanes,
> > +                    device->format, device->mode_flags);
> > +
> > +       if (device->lanes < 1 || device->lanes > 4)
> > +               return -EINVAL;
> > +
> > +       dsi->lanes = device->lanes;
> > +       dsi->format = device->format;
> > +       dsi->dsi_mode_flags = device->mode_flags;
> > +
> > +       ret = drm_of_find_panel_or_bridge(dsi->dev->of_node, 1, 0,
> > &panel,
> > +                                         &bridge);
> > +       if (ret)
> > +               return ret;
> > +
> > +       if (panel) {
> > +               bridge = drm_panel_bridge_add(panel);
> > +               if (IS_ERR(bridge))
> > +                       return PTR_ERR(bridge);
> > +       }
> > +
> > +       dsi->panel_bridge = bridge;
> > +       drm_bridge_add(&dsi->bridge);
> 
> This works only with a panel, but not with a bridge. For example,
> adv7511 bridge, will cal dsi_host_attach in it's drm_bridge_attach
> callback. Since you add our bridge only here, the bridge_attach from
> adv7511 will never be called so this callback will never be called.
> So, I'd suggest to call drm_bridge_add in probe, and
> move drm_of_find_panel_or_bridge in our bridge_attach. Basically, you
> need to separate the bridge_attach operations from the dsi_host_attach
> operations.

Makes sense.

> 
> > +
> > +       return 0;
> > +}
> > +
> > +static int nwl_dsi_host_detach(struct mipi_dsi_host *dsi_host,
> > +                              struct mipi_dsi_device *device)
> > +{
> > +       struct nwl_dsi *dsi = container_of(dsi_host, struct nwl_dsi,
> > dsi_host);
> > +
> > +       drm_of_panel_bridge_remove(dsi->dev->of_node, 1, 0);
> > +       drm_bridge_remove(&dsi->bridge);
> 
> Also, these removes should be done in our bridge_remove. These are not
> related to the dsi_device.
> 
> > +
> > +       return 0;
> > +}
> > +
> > +static bool nwl_dsi_read_packet(struct nwl_dsi *dsi, u32 status)
> > +{
> > +       struct device *dev = dsi->dev;
> > +       struct nwl_dsi_transfer *xfer = dsi->xfer;
> > +       int err;
> > +       u8 *payload = xfer->msg->rx_buf;
> > +       u32 val;
> > +       u16 word_count;
> > +       u8 channel;
> > +       u8 data_type;
> > +
> > +       xfer->status = 0;
> > +
> > +       if (xfer->rx_word_count == 0) {
> > +               if (!(status & NWL_DSI_RX_PKT_HDR_RCVD))
> > +                       return false;
> > +               /* Get the RX header and parse it */
> > +               val = nwl_dsi_read(dsi, NWL_DSI_RX_PKT_HEADER);
> > +               err = nwl_dsi_clear_error(dsi);
> > +               if (err)
> > +                       xfer->status = err;
> > +               word_count = NWL_DSI_WC(val);
> > +               channel = NWL_DSI_RX_VC(val);
> > +               data_type = NWL_DSI_RX_DT(val);
> > +
> > +               if (channel != xfer->msg->channel) {
> > +                       DRM_DEV_ERROR(dev,
> > +                                     "[%02X] Channel mismatch (%u !=
> > %u)\n",
> > +                                     xfer->cmd, channel, xfer->msg-
> > >channel);
> > +                       xfer->status = -EINVAL;
> > +                       return true;
> > +               }
> > +
> > +               switch (data_type) {
> > +               case MIPI_DSI_RX_GENERIC_SHORT_READ_RESPONSE_2BYTE:
> > +                       /* Fall through */
> > +               case MIPI_DSI_RX_DCS_SHORT_READ_RESPONSE_2BYTE:
> > +                       if (xfer->msg->rx_len > 1) {
> > +                               /* read second byte */
> > +                               payload[1] = word_count >> 8;
> > +                               ++xfer->rx_len;
> > +                       }
> > +                       /* Fall through */
> > +               case MIPI_DSI_RX_GENERIC_SHORT_READ_RESPONSE_1BYTE:
> > +                       /* Fall through */
> > +               case MIPI_DSI_RX_DCS_SHORT_READ_RESPONSE_1BYTE:
> > +                       if (xfer->msg->rx_len > 0) {
> > +                               /* read first byte */
> > +                               payload[0] = word_count & 0xff;
> > +                               ++xfer->rx_len;
> > +                       }
> > +                       xfer->status = xfer->rx_len;
> > +                       return true;
> > +               case MIPI_DSI_RX_ACKNOWLEDGE_AND_ERROR_REPORT:
> > +                       word_count &= 0xff;
> > +                       DRM_DEV_ERROR(dev, "[%02X] DSI error report:
> > 0x%02x\n",
> > +                                     xfer->cmd, word_count);
> > +                       xfer->status = -EPROTO;
> > +                       return true;
> > +               }
> > +
> > +               if (word_count > xfer->msg->rx_len) {
> > +                       DRM_DEV_ERROR(
> > +                               dev,
> > +                               "[%02X] Receive buffer too small: %zu
> > (< %u)\n",
> > +                               xfer->cmd, xfer->msg->rx_len,
> > word_count);
> > +                       xfer->status = -EINVAL;
> > +                       return true;
> > +               }
> > +
> > +               xfer->rx_word_count = word_count;
> > +       } else {
> > +               /* Set word_count from previous header read */
> > +               word_count = xfer->rx_word_count;
> > +       }
> > +
> > +       /* If RX payload is not yet received, wait for it */
> > +       if (!(status & NWL_DSI_RX_PKT_PAYLOAD_DATA_RCVD))
> > +               return false;
> > +
> > +       /* Read the RX payload */
> > +       while (word_count >= 4) {
> > +               val = nwl_dsi_read(dsi, NWL_DSI_RX_PAYLOAD);
> > +               payload[0] = (val >> 0) & 0xff;
> > +               payload[1] = (val >> 8) & 0xff;
> > +               payload[2] = (val >> 16) & 0xff;
> > +               payload[3] = (val >> 24) & 0xff;
> > +               payload += 4;
> > +               xfer->rx_len += 4;
> > +               word_count -= 4;
> > +       }
> > +
> > +       if (word_count > 0) {
> > +               val = nwl_dsi_read(dsi, NWL_DSI_RX_PAYLOAD);
> > +               switch (word_count) {
> > +               case 3:
> > +                       payload[2] = (val >> 16) & 0xff;
> > +                       ++xfer->rx_len;
> > +                       /* Fall through */
> > +               case 2:
> > +                       payload[1] = (val >> 8) & 0xff;
> > +                       ++xfer->rx_len;
> > +                       /* Fall through */
> > +               case 1:
> > +                       payload[0] = (val >> 0) & 0xff;
> > +                       ++xfer->rx_len;
> > +                       break;
> > +               }
> > +       }
> > +
> > +       xfer->status = xfer->rx_len;
> > +       err = nwl_dsi_clear_error(dsi);
> > +       if (err)
> > +               xfer->status = err;
> > +
> > +       return true;
> > +}
> > +
> > +static void nwl_dsi_finish_transmission(struct nwl_dsi *dsi, u32
> > status)
> > +{
> > +       struct nwl_dsi_transfer *xfer = dsi->xfer;
> > +       bool end_packet = false;
> > +
> > +       if (!xfer)
> > +               return;
> > +
> > +       if (xfer->direction == DSI_PACKET_SEND &&
> > +           status & NWL_DSI_TX_PKT_DONE) {
> > +               xfer->status = xfer->tx_len;
> > +               end_packet = true;
> > +       } else if (status & NWL_DSI_DPHY_DIRECTION &&
> > +                  ((status & (NWL_DSI_RX_PKT_HDR_RCVD |
> > +                              NWL_DSI_RX_PKT_PAYLOAD_DATA_RCVD)))) {
> > +               end_packet = nwl_dsi_read_packet(dsi, status);
> > +       }
> > +
> > +       if (end_packet)
> > +               complete(&xfer->completed);
> > +}
> > +
> > +static void nwl_dsi_begin_transmission(struct nwl_dsi *dsi)
> > +{
> > +       struct nwl_dsi_transfer *xfer = dsi->xfer;
> > +       struct mipi_dsi_packet *pkt = &xfer->packet;
> > +       const u8 *payload;
> > +       size_t length;
> > +       u16 word_count;
> > +       u8 hs_mode;
> > +       u32 val;
> > +       u32 hs_workaround = 0;
> > +
> > +       /* Send the payload, if any */
> > +       length = pkt->payload_length;
> > +       payload = pkt->payload;
> > +
> > +       while (length >= 4) {
> > +               val = *(u32 *)payload;
> > +               hs_workaround |= !(val & 0xFFFF00);
> > +               nwl_dsi_write(dsi, NWL_DSI_TX_PAYLOAD, val);
> > +               payload += 4;
> > +               length -= 4;
> > +       }
> > +       /* Send the rest of the payload */
> > +       val = 0;
> > +       switch (length) {
> > +       case 3:
> > +               val |= payload[2] << 16;
> > +               /* Fall through */
> > +       case 2:
> > +               val |= payload[1] << 8;
> > +               hs_workaround |= !(val & 0xFFFF00);
> > +               /* Fall through */
> > +       case 1:
> > +               val |= payload[0];
> > +               nwl_dsi_write(dsi, NWL_DSI_TX_PAYLOAD, val);
> > +               break;
> > +       }
> > +       xfer->tx_len = pkt->payload_length;
> > +
> > +       /*
> > +        * Send the header
> > +        * header[0] = Virtual Channel + Data Type
> > +        * header[1] = Word Count LSB (LP) or first param (SP)
> > +        * header[2] = Word Count MSB (LP) or second param (SP)
> > +        */
> > +       word_count = pkt->header[1] | (pkt->header[2] << 8);
> > +       if (hs_workaround && (dsi->quirks & E11418_HS_MODE_QUIRK)) {
> > +               DRM_DEV_DEBUG_DRIVER(dsi->dev,
> > +                                    "Using hs mode workaround for
> > cmd 0x%x\n",
> > +                                    xfer->cmd);
> > +               hs_mode = 1;
> > +       } else {
> > +               hs_mode = (xfer->msg->flags & MIPI_DSI_MSG_USE_LPM) ?
> > 0 : 1;
> > +       }
> > +       val = NWL_DSI_WC(word_count) | NWL_DSI_TX_VC(xfer->msg-
> > >channel) |
> > +             NWL_DSI_TX_DT(xfer->msg->type) |
> > NWL_DSI_HS_SEL(hs_mode) |
> > +             NWL_DSI_BTA_TX(xfer->need_bta);
> > +       nwl_dsi_write(dsi, NWL_DSI_PKT_CONTROL, val);
> > +
> > +       /* Send packet command */
> > +       nwl_dsi_write(dsi, NWL_DSI_SEND_PACKET, 0x1);
> > +}
> > +
> > +static ssize_t nwl_dsi_host_transfer(struct mipi_dsi_host *dsi_host,
> > +                                    const struct mipi_dsi_msg *msg)
> > +{
> > +       struct nwl_dsi *dsi = container_of(dsi_host, struct nwl_dsi,
> > dsi_host);
> > +       struct nwl_dsi_transfer xfer;
> > +       ssize_t ret = 0;
> > +
> > +       /* Create packet to be sent */
> > +       dsi->xfer = &xfer;
> > +       ret = mipi_dsi_create_packet(&xfer.packet, msg);
> > +       if (ret < 0) {
> > +               dsi->xfer = NULL;
> > +               return ret;
> > +       }
> > +
> > +       if ((msg->type & MIPI_DSI_GENERIC_READ_REQUEST_0_PARAM ||
> > +            msg->type & MIPI_DSI_GENERIC_READ_REQUEST_1_PARAM ||
> > +            msg->type & MIPI_DSI_GENERIC_READ_REQUEST_2_PARAM ||
> > +            msg->type & MIPI_DSI_DCS_READ) &&
> > +           msg->rx_len > 0 && msg->rx_buf != NULL)
> > +               xfer.direction = DSI_PACKET_RECEIVE;
> > +       else
> > +               xfer.direction = DSI_PACKET_SEND;
> > +
> > +       xfer.need_bta = (xfer.direction == DSI_PACKET_RECEIVE);
> > +       xfer.need_bta |= (msg->flags & MIPI_DSI_MSG_REQ_ACK) ? 1 : 0;
> > +       xfer.msg = msg;
> > +       xfer.status = -ETIMEDOUT;
> > +       xfer.rx_word_count = 0;
> > +       xfer.rx_len = 0;
> > +       xfer.cmd = 0x00;
> > +       if (msg->tx_len > 0)
> > +               xfer.cmd = ((u8 *)(msg->tx_buf))[0];
> > +       init_completion(&xfer.completed);
> > +
> > +       ret = clk_prepare_enable(dsi->rx_esc_clk);
> > +       if (ret < 0) {
> > +               DRM_DEV_ERROR(dsi->dev, "Failed to enable rx_esc clk:
> > %zd\n",
> > +                             ret);
> > +               return ret;
> > +       }
> > +       DRM_DEV_DEBUG_DRIVER(dsi->dev, "Enabled rx_esc clk @%lu
> > Hz\n",
> > +                            clk_get_rate(dsi->rx_esc_clk));
> > +
> > +       /* Initiate the DSI packet transmision */
> > +       nwl_dsi_begin_transmission(dsi);
> > +
> > +       if (!wait_for_completion_timeout(&xfer.completed,
> > +                                        NWL_DSI_MIPI_FIFO_TIMEOUT))
> > {
> > +               DRM_DEV_ERROR(dsi_host->dev, "[%02X] DSI transfer
> > timed out\n",
> > +                             xfer.cmd);
> > +               ret = -ETIMEDOUT;
> > +       } else {
> > +               ret = xfer.status;
> > +       }
> > +
> > +       clk_disable_unprepare(dsi->rx_esc_clk);
> > +
> > +       return ret;
> > +}
> > +
> > +static const struct mipi_dsi_host_ops nwl_dsi_host_ops = {
> > +       .attach = nwl_dsi_host_attach,
> > +       .detach = nwl_dsi_host_detach,
> > +       .transfer = nwl_dsi_host_transfer,
> > +};
> > +
> > +static irqreturn_t nwl_dsi_irq_handler(int irq, void *data)
> > +{
> > +       u32 irq_status;
> > +       struct nwl_dsi *dsi = data;
> > +
> > +       irq_status = nwl_dsi_read(dsi, NWL_DSI_IRQ_STATUS);
> > +
> > +       if (irq_status & NWL_DSI_TX_FIFO_OVFLW)
> > +               DRM_DEV_ERROR_RATELIMITED(dsi->dev, "tx fifo
> > overflow\n");
> > +
> > +       if (irq_status & NWL_DSI_HS_TX_TIMEOUT)
> > +               DRM_DEV_ERROR_RATELIMITED(dsi->dev, "HS tx
> > timeout\n");
> > +
> > +       if (irq_status & NWL_DSI_TX_PKT_DONE ||
> > +           irq_status & NWL_DSI_RX_PKT_HDR_RCVD ||
> > +           irq_status & NWL_DSI_RX_PKT_PAYLOAD_DATA_RCVD)
> > +               nwl_dsi_finish_transmission(dsi, irq_status);
> > +
> > +       return IRQ_HANDLED;
> > +}
> > +
> > +static int nwl_dsi_enable(struct nwl_dsi *dsi)
> > +{
> > +       struct device *dev = dsi->dev;
> > +       union phy_configure_opts *phy_cfg = &dsi->phy_cfg;
> > +       int ret;
> > +
> > +       if (!dsi->lanes) {
> > +               DRM_DEV_ERROR(dev, "Need DSI lanes: %d\n", dsi-
> > >lanes);
> > +               return -EINVAL;
> > +       }
> > +
> > +       ret = phy_init(dsi->phy);
> > +       if (ret < 0) {
> > +               DRM_DEV_ERROR(dev, "Failed to init DSI phy: %d\n",
> > ret);
> > +               return ret;
> > +       }
> > +
> > +       ret = phy_configure(dsi->phy, phy_cfg);
> > +       if (ret < 0) {
> > +               DRM_DEV_ERROR(dev, "Failed to configure DSI phy:
> > %d\n", ret);
> > +               goto uninit_phy;
> > +       }
> > +
> > +       ret = clk_prepare_enable(dsi->tx_esc_clk);
> > +       if (ret < 0) {
> > +               DRM_DEV_ERROR(dsi->dev, "Failed to enable tx_esc clk:
> > %d\n",
> > +                             ret);
> > +               goto uninit_phy;
> > +       }
> > +       DRM_DEV_DEBUG_DRIVER(dsi->dev, "Enabled tx_esc clk @%lu
> > Hz\n",
> > +                            clk_get_rate(dsi->tx_esc_clk));
> > +
> > +       ret = nwl_dsi_config_host(dsi);
> > +       if (ret < 0) {
> > +               DRM_DEV_ERROR(dev, "Failed to set up DSI: %d", ret);
> > +               goto disable_clock;
> > +       }
> > +
> > +       ret = nwl_dsi_config_dpi(dsi);
> > +       if (ret < 0) {
> > +               DRM_DEV_ERROR(dev, "Failed to set up DPI: %d", ret);
> > +               goto disable_clock;
> > +       }
> > +
> > +       ret = phy_power_on(dsi->phy);
> > +       if (ret < 0) {
> > +               DRM_DEV_ERROR(dev, "Failed to power on DPHY (%d)\n",
> > ret);
> > +               goto disable_clock;
> > +       }
> > +
> > +       ret = nwl_dsi_init_interrupts(dsi);
> > +       if (ret < 0)
> > +               goto power_off_phy;
> > +
> > +       return ret;
> > +
> > +power_off_phy:
> > +       phy_power_off(dsi->phy);
> > +disable_clock:
> > +       clk_disable_unprepare(dsi->tx_esc_clk);
> > +uninit_phy:
> > +       phy_exit(dsi->phy);
> > +
> > +       return ret;
> > +}
> > +
> > +static int nwl_dsi_disable(struct nwl_dsi *dsi)
> > +{
> > +       struct device *dev = dsi->dev;
> > +
> > +       DRM_DEV_DEBUG_DRIVER(dev, "Disabling clocks and phy\n");
> > +
> > +       phy_power_off(dsi->phy);
> > +       phy_exit(dsi->phy);
> > +
> > +       /* Disabling the clock before the phy breaks enabling dsi
> > again */
> > +       clk_disable_unprepare(dsi->tx_esc_clk);
> > +
> > +       return 0;
> > +}
> > +
> > +static int nwl_dsi_set_platform_clocks(struct nwl_dsi *dsi, bool
> > enable)
> > +{
> > +       struct device *dev = dsi->dev;
> > +       const char *id;
> > +       struct clk *clk;
> > +       size_t i;
> > +       unsigned long rate;
> > +       int ret, result = 0;
> > +
> > +       DRM_DEV_DEBUG_DRIVER(dev, "%s platform clocks\n",
> > +                            enable ? "enabling" : "disabling");
> > +       for (i = 0; i < ARRAY_SIZE(dsi->pdata->clk_config); i++) {
> > +               if (!dsi->clk_config[i].present)
> > +                       continue;
> > +               id = dsi->clk_config[i].id;
> > +               clk = dsi->clk_config[i].clk;
> > +
> > +               if (enable) {
> > +                       ret = clk_prepare_enable(clk);
> > +                       if (ret < 0) {
> > +                               DRM_DEV_ERROR(dev,
> > +                                             "Failed to enable %s
> > clk: %d\n",
> > +                                             id, ret);
> > +                               result = result ?: ret;
> > +                       }
> > +                       rate = clk_get_rate(clk);
> > +                       DRM_DEV_DEBUG_DRIVER(dev, "Enabled %s clk
> > @%lu Hz\n",
> > +                                            id, rate);
> > +               } else {
> > +                       clk_disable_unprepare(clk);
> > +                       DRM_DEV_DEBUG_DRIVER(dev, "Disabled %s
> > clk\n", id);
> > +               }
> > +       }
> > +
> > +       return result;
> > +}
> > +
> > +static int nwl_dsi_plat_enable(struct nwl_dsi *dsi)
> > +{
> > +       struct device *dev = dsi->dev;
> > +       int ret;
> > +
> > +       if (dsi->pdata->select_input) {
> > +               ret = dsi->pdata->select_input(dsi);
> > +               if (ret < 0)
> > +                       return ret;
> > +       }
> 
> Since the select_input always reads the dtb (and at runtime this node
> never changes anyway) I think it's best to use the select_input at
> probe since it is only needed once and also drop the deselect_input.
>
> 
> > +
> > +       ret = nwl_dsi_set_platform_clocks(dsi, true);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       ret = dsi->pdata->poweron(dsi);
> > +       if (ret < 0)
> > +               DRM_DEV_ERROR(dev, "Failed to power on DSI: %d\n",
> > ret);
> > +       return ret;
> > +}
> > +
> > +static void nwl_dsi_plat_disable(struct nwl_dsi *dsi)
> > +{
> > +       dsi->pdata->poweroff(dsi);
> > +       nwl_dsi_set_platform_clocks(dsi, false);
> > +       if (dsi->pdata->deselect_input)
> > +               dsi->pdata->deselect_input(dsi);
> > +}
> > +
> > +static void nwl_dsi_bridge_disable(struct drm_bridge *bridge)
> > +{
> > +       struct nwl_dsi *dsi = bridge_to_dsi(bridge);
> > +
> > +       nwl_dsi_disable(dsi);
> > +       nwl_dsi_plat_disable(dsi);
> > +       pm_runtime_put(dsi->dev);
> > +}
> > +
> > +static int nwl_dsi_get_dphy_params(struct nwl_dsi *dsi,
> > +                                  const struct drm_display_mode
> > *mode,
> > +                                  union phy_configure_opts
> > *phy_opts)
> > +{
> > +       unsigned long rate;
> > +       int ret;
> > +
> > +       if (dsi->lanes < 1 || dsi->lanes > 4)
> > +               return -EINVAL;
> > +
> > +       /*
> > +        * So far the DPHY spec minimal timings work for both mixel
> > +        * dphy and nwl dsi host
> > +        */
> > +       ret = phy_mipi_dphy_get_default_config(
> > +               mode->crtc_clock * 1000,
> 
> Why are you using crtc_clock here? I this this should be used only by
> the CRTC component. I'd suggest to use mode->clock here, since it is
> about the output clock of the DSI, not the input clock on the DPI
> interface, that is coming from CRTC.

crtc_clock is the actual pixel dot clock used which sounds like the
one we want to base our calcualations on, no?

>  
> > +               mipi_dsi_pixel_format_to_bpp(dsi->format), dsi-
> > >lanes,
> > +               &phy_opts->mipi_dphy);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       rate = clk_get_rate(dsi->tx_esc_clk);
> > +       DRM_DEV_DEBUG_DRIVER(dsi->dev, "LP clk is @%lu Hz\n", rate);
> > +       phy_opts->mipi_dphy.lp_clk_rate = rate;
> > +
> > +       return 0;
> > +}
> > +
> > +static bool nwl_dsi_bridge_mode_fixup(struct drm_bridge *bridge,
> > +                                     const struct drm_display_mode
> > *mode,
> > +                                     struct drm_display_mode
> > *adjusted_mode)
> > +{
> > +       /* At least LCDIF + NWL needs active high sync */
> > +       adjusted_mode->flags |= (DRM_MODE_FLAG_PHSYNC |
> > DRM_MODE_FLAG_PVSYNC);
> > +       adjusted_mode->flags &= ~(DRM_MODE_FLAG_NHSYNC |
> > DRM_MODE_FLAG_NVSYNC);
> > +
> > +       return true;
> > +}
> > +
> > +static enum drm_mode_status
> > +nwl_dsi_bridge_mode_valid(struct drm_bridge *bridge,
> > +                         const struct drm_display_mode *mode)
> > +{
> > +       struct nwl_dsi *dsi = bridge_to_dsi(bridge);
> > +       int bpp = mipi_dsi_pixel_format_to_bpp(dsi->format);
> > +
> > +       if (mode->clock * bpp > 15000000 * dsi->lanes)
> > +               return MODE_CLOCK_HIGH;
> > +
> > +       if (mode->clock * bpp < 80000 * dsi->lanes)
> > +               return MODE_CLOCK_LOW;
> > +
> > +       return MODE_OK;
> > +}
> > +
> > +static void
> > +nwl_dsi_bridge_mode_set(struct drm_bridge *bridge,
> > +                       const struct drm_display_mode *mode,
> > +                       const struct drm_display_mode *adjusted_mode)
> > +{
> > +       struct nwl_dsi *dsi = bridge_to_dsi(bridge);
> > +       struct device *dev = dsi->dev;
> > +       union phy_configure_opts new_cfg;
> > +       unsigned long phy_ref_rate;
> > +       int ret;
> > +
> > +       ret = nwl_dsi_get_dphy_params(dsi, adjusted_mode, &new_cfg);
> > +       if (ret < 0)
> > +               return;
> > +
> > +       /*
> > +        * If hs clock is unchanged, we're all good - all parameters
> > are
> > +        * derived from it atm.
> > +        */
> > +       if (new_cfg.mipi_dphy.hs_clk_rate == dsi-
> > >phy_cfg.mipi_dphy.hs_clk_rate)
> > +               return;
> > +
> > +       phy_ref_rate = clk_get_rate(dsi->phy_ref_clk);
> > +       DRM_DEV_DEBUG_DRIVER(dev, "PHY at ref rate: %lu\n",
> > phy_ref_rate);
> > +       /* Save the new desired phy config */
> > +       memcpy(&dsi->phy_cfg, &new_cfg, sizeof(new_cfg));
> > +
> > +       memcpy(&dsi->mode, adjusted_mode, sizeof(dsi->mode));
> > +       drm_mode_debug_printmodeline(adjusted_mode);
> > +}
> > +
> > +static void nwl_dsi_bridge_pre_enable(struct drm_bridge *bridge)
> > +{
> > +       struct nwl_dsi *dsi = bridge_to_dsi(bridge);
> > +
> > +       pm_runtime_get_sync(dsi->dev);
> > +       nwl_dsi_plat_enable(dsi);
> > +       nwl_dsi_enable(dsi);
> > +}
> > +
> > +static int nwl_dsi_bridge_attach(struct drm_bridge *bridge)
> > +{
> > +       struct nwl_dsi *dsi = bridge_to_dsi(bridge);
> > +
> > +       return drm_bridge_attach(bridge->encoder, dsi->panel_bridge,
> > bridge);
> > +}
> > +
> > +static const struct drm_bridge_funcs nwl_dsi_bridge_funcs = {
> > +       .pre_enable = nwl_dsi_bridge_pre_enable,
> > +       .disable    = nwl_dsi_bridge_disable,
> > +       .mode_fixup = nwl_dsi_bridge_mode_fixup,
> > +       .mode_set   = nwl_dsi_bridge_mode_set,
> > +       .mode_valid = nwl_dsi_bridge_mode_valid,
> > +       .attach     = nwl_dsi_bridge_attach,
> > +};
> > +
> > +static int nwl_dsi_parse_dt(struct nwl_dsi *dsi)
> > +{
> > +       struct platform_device *pdev = to_platform_device(dsi->dev);
> > +       struct clk *clk;
> > +       const char *clk_id;
> > +       void __iomem *base;
> > +       int i, ret;
> > +
> > +       dsi->phy = devm_phy_get(dsi->dev, "dphy");
> > +       if (IS_ERR(dsi->phy)) {
> > +               ret = PTR_ERR(dsi->phy);
> > +               if (ret != -EPROBE_DEFER)
> > +                       DRM_DEV_ERROR(dsi->dev, "Could not get PHY:
> > %d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       /* Platform dependent clocks */
> > +       memcpy(dsi->clk_config, dsi->pdata->clk_config,
> > +              sizeof(dsi->pdata->clk_config));
> > +
> > +       for (i = 0; i < ARRAY_SIZE(dsi->pdata->clk_config); i++) {
> > +               if (!dsi->clk_config[i].present)
> > +                       continue;
> > +
> > +               clk_id = dsi->clk_config[i].id;
> > +               clk = devm_clk_get(dsi->dev, clk_id);
> > +               if (IS_ERR(clk)) {
> > +                       ret = PTR_ERR(clk);
> > +                       DRM_DEV_ERROR(dsi->dev, "Failed to get %s
> > clock: %d\n",
> > +                                     clk_id, ret);
> > +                       return ret;
> > +               }
> > +               DRM_DEV_DEBUG_DRIVER(dsi->dev, "Setup clk %s (rate:
> > %lu)\n",
> > +                                    clk_id, clk_get_rate(clk));
> > +               dsi->clk_config[i].clk = clk;
> > +       }
> > +
> > +       /* DSI clocks */
> > +       clk = devm_clk_get(dsi->dev, "phy_ref");
> > +       if (IS_ERR(clk)) {
> > +               ret = PTR_ERR(clk);
> > +               DRM_DEV_ERROR(dsi->dev, "Failed to get phy_ref clock:
> > %d\n",
> > +                             ret);
> > +               return ret;
> > +       }
> > +       dsi->phy_ref_clk = clk;
> > +
> > +       clk = devm_clk_get(dsi->dev, "rx_esc");
> > +       if (IS_ERR(clk)) {
> > +               ret = PTR_ERR(clk);
> > +               DRM_DEV_ERROR(dsi->dev, "Failed to get rx_esc clock:
> > %d\n",
> > +                             ret);
> > +               return ret;
> > +       }
> > +       dsi->rx_esc_clk = clk;
> > +
> > +       clk = devm_clk_get(dsi->dev, "tx_esc");
> > +       if (IS_ERR(clk)) {
> > +               ret = PTR_ERR(clk);
> > +               DRM_DEV_ERROR(dsi->dev, "Failed to get tx_esc clock:
> > %d\n",
> > +                             ret);
> > +               return ret;
> > +       }
> > +       dsi->tx_esc_clk = clk;
> > +
> > +       dsi->mux = devm_mux_control_get(dsi->dev, NULL);
> > +       if (IS_ERR(dsi->mux)) {
> > +               ret = PTR_ERR(dsi->mux);
> > +               if (ret != -EPROBE_DEFER)
> > +                       DRM_DEV_ERROR(dsi->dev, "Failed to get mux:
> > %d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       base = devm_platform_ioremap_resource(pdev, 0);
> > +       if (IS_ERR(base))
> > +               return PTR_ERR(base);
> > +
> > +       dsi->regmap =
> > +               devm_regmap_init_mmio(dsi->dev, base,
> > &nwl_dsi_regmap_config);
> > +       if (IS_ERR(dsi->regmap)) {
> > +               ret = PTR_ERR(dsi->regmap);
> > +               DRM_DEV_ERROR(dsi->dev, "Failed to create NWL DSI
> > regmap: %d\n",
> > +                             ret);
> > +               return ret;
> > +       }
> > +
> > +       dsi->irq = platform_get_irq(pdev, 0);
> > +       if (dsi->irq < 0) {
> > +               DRM_DEV_ERROR(dsi->dev, "Failed to get device IRQ:
> > %d\n",
> > +                             dsi->irq);
> > +               return dsi->irq;
> > +       }
> > +
> > +       dsi->rstc = devm_reset_control_array_get(dsi->dev, false,
> > true);
> > +       if (IS_ERR(dsi->rstc)) {
> > +               ret = PTR_ERR(dsi->rstc);
> > +               if (ret != -EPROBE_DEFER)
> > +                       DRM_DEV_ERROR(dsi->dev, "Failed to get
> > resets: %d\n",
> > +                                     ret);
> > +               return ret;
> > +       }
> 
> Since you dropped the reset quirk (which is a good idea, but it needs a
> backup), I would like to tell you about our findings. So, as you know,
> DSi can receive input from DCSS or LCDIF (this is done through a mux).
> Now, the reset of the DSI block is not handled directly through the
> System Reset Controller (as initially I though). The signals coming
> from SRC are going into a reset_sync (Reset Synchronyzer block),
> because the DSI block needs the reset signals to be synchronous de-
> asserted.
> Recently, we discovered the bug that was not allowing us to correctly
> reset the DSI and also why that quirk was initially used.
> Normally, the output pixel-clock that was coming from that mux should
> be used as a clock for the reset_sync, but due to a design issue in the
> core, the LCDIF pixel-clock was used to drive this reset_sync.
> So, since HW bug here which can be managed in SW, what we did is to add
> the LCDIF pixel-clock to this driver (in dts it can be added as an
> external clock needed for reset_sync). I know it is a nasty external
> depencency, but this is the part in SW that fixes the issue in HW.
> Now: the LCDIF pixel-clock needs bo be on for the whole duration of the
> DSI operation, This means that LCDIF should be enabled before de-
> asserting the reset signals, then disabled after we are done with DSI
> and assert the reset signals back.

Pulling in the lcdif clock as optional clock works but how do things
work with DCSS? What clock will reset need to be synced there too? 'pix'?

> 
> Next, I want to detail you the sequence of the operations that needs to
> be done, since while debugging this issue we received the correct
> sequence from Northwest Logic representatives. This sequence is an
> absolute requirement for a proper initialization and I will detail it
> below:
> 1. De-assert 'pclk' reset (this is needed to have acces to the DSI
> registers)
> 2. Configure DSI Host
> 3. Configure DHPY
> 4. Enable DPHY
> 5. De-assert 'esc' and 'byte' resets (these are needed for Host TX
> operations)
> 6. Send DSI commands (if the DSI peripheral needs configuration)
> 7. De-assert 'dpi' reset (de-asserting this reset, will enable the DPI
> to start fetching data from it's input and start streaming DSI data)

Very nice! Especially the last part (e.g. keeping the dsi lanes free of
signal output until the dsi setup commands went through) answers some
questions I asked NXP a while ago in the forums but did not get a
reply. That should make things way more robust.

> You will see that I left the 'dpi' reset at the end, so that the 'DSI
> peripheral initialization' step will be clean. DSI lanes needs to be
> clean during this phase and not be "poluted" by any pixel data that DPI
> thinks it needs to stream. On my side, I tried to separate the above
> steps by implementing steps 1-5 in bridge_pre_enable, hoping that the
> step 6 will be automatically run in panel enable phase, and finally
> have step 7 implemented in bridge_enable. Unfortunatelly, the order of
> calls for enable is exactly the oposite way as for pre_enable, which
> makes impossible to have the step 7 executed AFTER step 6.
> In bridge_pre_enable, the pre_enable for the bridge chain is executed
> first, then our pre_enable is executed.
> In bridge_enable, our enable is executed first, then the enable for
> brigde chain is executed. This means that step 7 will end up executed
> before step 6, causing the 'DSI lane polution' I was talking above.
> As of now, I didn't manage to find a way to fix this, but I will keep
> investigating. If you have a good ideea for this it woule be great.
> So, with all the above details, I think you will need to treat each
> reset individually, instead of treating them as an array.
> 
> > +
> > +       return 0;
> > +}
> > +
> > +static int imx8mq_dsi_select_input(struct nwl_dsi *dsi)
> > +{
> > +       struct device_node *remote;
> > +       u32 use_dcss = 1;
> > +       int ret;
> > +
> > +       remote = of_graph_get_remote_node(dsi->dev->of_node, 0,
> > +                                         NWL_DSI_ENDPOINT_LCDIF);
> > +       if (remote) {
> > +               use_dcss = 0;
> > +       } else {
> > +               remote = of_graph_get_remote_node(dsi->dev->of_node,
> > 0,
> > +                                                 NWL_DSI_ENDPOINT_DC
> > SS);
> > +               if (!remote) {
> > +                       DRM_DEV_ERROR(dsi->dev,
> > +                                     "No valid input endpoint
> > found\n");
> > +                       return -EINVAL;
> > +               }
> > +       }
> > +
> > +       DRM_DEV_INFO(dsi->dev, "Using %s as input source\n",
> > +                    (use_dcss) ? "DCSS" : "LCDIF");
> > +       ret = mux_control_try_select(dsi->mux, use_dcss);
> > +       if (ret < 0)
> > +               DRM_DEV_ERROR(dsi->dev, "Failed to select input:
> > %d\n", ret);
> > +
> > +       of_node_put(remote);
> > +       return ret;
> > +}
> > +
> > +static int imx8mq_dsi_deselect_input(struct nwl_dsi *dsi)
> > +{
> > +       int ret;
> > +
> > +       ret = mux_control_deselect(dsi->mux);
> > +       if (ret < 0)
> > +               DRM_DEV_ERROR(dsi->dev, "Failed to deselect input:
> > %d\n", ret);
> > +
> > +       return ret;
> > +}
> > +
> > +
> > +static int imx8mq_dsi_poweron(struct nwl_dsi *dsi)
> > +{
> > +       int ret = 0;
> > +
> > +       /* otherwise the display stays blank */
> > +       usleep_range(200, 300);
> 
> If you implement the part with LCDIF clock detailed above, you can drop
> this sleep. Also, poweron should be replaced by various reset callbacks
> (ex: pclk_reset, mipi_reset, dpi_reset).
> 
> > +
> > +       if (dsi->rstc)
> > +               ret = reset_control_deassert(dsi->rstc);
> > +
> > +       return ret;
> > +}
> > +
> > +static int imx8mq_dsi_poweroff(struct nwl_dsi *dsi)
> > +{
> > +       int ret = 0;
> > +
> > +       if (dsi->rstc)
> > +               ret = reset_control_assert(dsi->rstc);
> > +       return ret;
> > +}
> > +
> > +static const struct drm_bridge_timings nwl_dsi_timings = {
> > +       .input_bus_flags = DRM_BUS_FLAG_DE_LOW,
> > +};
> > +
> > +static const struct nwl_dsi_platform_data imx8mq_dev = {
> > +       .poweron = &imx8mq_dsi_poweron,
> > +       .poweroff = &imx8mq_dsi_poweroff,
> > +       .select_input = &imx8mq_dsi_select_input,
> > +       .deselect_input = &imx8mq_dsi_deselect_input,
> > +       .clk_config = {
> > +               { .id = NWL_DSI_CLK_CORE, .present = true },
> > +       },
> > +};
> > +
> > +static const struct of_device_id nwl_dsi_dt_ids[] = {
> > +       { .compatible = "fsl,imx8mq-nwl-dsi", .data = &imx8mq_dev, },
> > +       { /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, nwl_dsi_dt_ids);
> > +
> > +static const struct soc_device_attribute nwl_dsi_quirks_match[] = {
> > +       { .soc_id = "i.MX8MQ", .revision = "2.0",
> > +         .data = (void *)E11418_HS_MODE_QUIRK },
> > +       { /* sentinel. */ },
> > +};
> > +
> > +static int nwl_dsi_probe(struct platform_device *pdev)
> > +{
> > +       struct device *dev = &pdev->dev;
> > +       const struct of_device_id *of_id =
> > of_match_device(nwl_dsi_dt_ids, dev);
> > +       const struct nwl_dsi_platform_data *pdata = of_id->data;
> > +       const struct soc_device_attribute *attr;
> > +       struct nwl_dsi *dsi;
> > +       int ret;
> > +
> > +       dsi = devm_kzalloc(dev, sizeof(*dsi), GFP_KERNEL);
> > +       if (!dsi)
> > +               return -ENOMEM;
> > +
> > +       dsi->dev = dev;
> > +       dsi->pdata = pdata;
> > +
> > +       ret = nwl_dsi_parse_dt(dsi);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret = devm_request_irq(dev, dsi->irq, nwl_dsi_irq_handler, 0,
> > +                              dev_name(dev), dsi);
> > +       if (ret < 0) {
> > +               DRM_DEV_ERROR(dev, "Failed to request IRQ %d: %d\n",
> > dsi->irq,
> > +                             ret);
> > +               return ret;
> > +       }
> > +
> > +       dsi->dsi_host.ops = &nwl_dsi_host_ops;
> > +       dsi->dsi_host.dev = dev;
> > +       ret = mipi_dsi_host_register(&dsi->dsi_host);
> > +       if (ret) {
> > +               DRM_DEV_ERROR(dev, "Failed to register MIPI host:
> > %d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       attr = soc_device_match(nwl_dsi_quirks_match);
> > +       if (attr)
> > +               dsi->quirks = (uintptr_t)attr->data;
> > +
> > +       dsi->bridge.driver_private = dsi;
> > +       dsi->bridge.funcs = &nwl_dsi_bridge_funcs;
> > +       dsi->bridge.of_node = dev->of_node;
> > +       dsi->bridge.timings = &nwl_dsi_timings;
> > +
> > +       dev_set_drvdata(dev, dsi);
> > +       pm_runtime_enable(dev);
> > +       return 0;
> > +}
> > +
> > +static int nwl_dsi_remove(struct platform_device *pdev)
> > +{
> > +       struct nwl_dsi *dsi = platform_get_drvdata(pdev);
> > +
> > +       mipi_dsi_host_unregister(&dsi->dsi_host);
> > +       pm_runtime_disable(&pdev->dev);
> > +       return 0;
> > +}
> > +
> > +static struct platform_driver nwl_dsi_driver = {
> > +       .probe          = nwl_dsi_probe,
> > +       .remove         = nwl_dsi_remove,
> > +       .driver         = {
> > +               .of_match_table = nwl_dsi_dt_ids,
> > +               .name   = DRV_NAME,
> > +       },
> > +};
> > +
> > +module_platform_driver(nwl_dsi_driver);
> > +
> > +MODULE_AUTHOR("NXP Semiconductor");
> > +MODULE_AUTHOR("Purism SPC");
> > +MODULE_DESCRIPTION("Northwest Logic MIPI-DSI driver");
> > +MODULE_LICENSE("GPL"); /* GPLv2 or later */
> > diff --git a/drivers/gpu/drm/bridge/nwl-dsi.h
> > b/drivers/gpu/drm/bridge/nwl-dsi.h
> > new file mode 100644
> > index 000000000000..a247a8a11c7c
> > --- /dev/null
> > +++ b/drivers/gpu/drm/bridge/nwl-dsi.h
> > @@ -0,0 +1,144 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * NWL MIPI DSI host driver
> > + *
> > + * Copyright (C) 2017 NXP
> > + * Copyright (C) 2019 Purism SPC
> > + */
> > +#ifndef __NWL_DSI_H__
> > +#define __NWL_DSI_H__
> > +
> > +/* DSI HOST registers */
> > +#define NWL_DSI_CFG_NUM_LANES                  0x0
> > +#define NWL_DSI_CFG_NONCONTINUOUS_CLK          0x4
> > +#define NWL_DSI_CFG_T_PRE                      0x8
> > +#define NWL_DSI_CFG_T_POST                     0xc
> > +#define NWL_DSI_CFG_TX_GAP                     0x10
> > +#define NWL_DSI_CFG_AUTOINSERT_EOTP            0x14
> > +#define NWL_DSI_CFG_EXTRA_CMDS_AFTER_EOTP      0x18
> > +#define NWL_DSI_CFG_HTX_TO_COUNT               0x1c
> > +#define NWL_DSI_CFG_LRX_H_TO_COUNT             0x20
> > +#define NWL_DSI_CFG_BTA_H_TO_COUNT             0x24
> > +#define NWL_DSI_CFG_TWAKEUP                    0x28
> > +#define NWL_DSI_CFG_STATUS_OUT                 0x2c
> > +#define NWL_DSI_RX_ERROR_STATUS                        0x30
> > +
> > +/* DSI DPI registers */
> > +#define NWL_DSI_PIXEL_PAYLOAD_SIZE             0x200
> > +#define NWL_DSI_PIXEL_FIFO_SEND_LEVEL          0x204
> > +#define NWL_DSI_INTERFACE_COLOR_CODING         0x208
> > +#define NWL_DSI_PIXEL_FORMAT                   0x20c
> > +#define NWL_DSI_VSYNC_POLARITY                 0x210
> > +#define NWL_DSI_VSYNC_POLARITY_ACTIVE_LOW      0
> > +#define NWL_DSI_VSYNC_POLARITY_ACTIVE_HIGH     BIT(1)
> > +
> > +#define NWL_DSI_HSYNC_POLARITY                 0x214
> > +#define NWL_DSI_HSYNC_POLARITY_ACTIVE_LOW      0
> > +#define NWL_DSI_HSYNC_POLARITY_ACTIVE_HIGH     BIT(1)
> > +
> > +#define NWL_DSI_VIDEO_MODE                     0x218
> > +#define NWL_DSI_HFP                            0x21c
> > +#define NWL_DSI_HBP                            0x220
> > +#define NWL_DSI_HSA                            0x224
> > +#define NWL_DSI_ENABLE_MULT_PKTS               0x228
> > +#define NWL_DSI_VBP                            0x22c
> > +#define NWL_DSI_VFP                            0x230
> > +#define NWL_DSI_BLLP_MODE                      0x234
> > +#define NWL_DSI_USE_NULL_PKT_BLLP              0x238
> > +#define NWL_DSI_VACTIVE                                0x23c
> > +#define NWL_DSI_VC                             0x240
> > +
> > +/* DSI APB PKT control */
> > +#define NWL_DSI_TX_PAYLOAD                     0x280
> > +#define NWL_DSI_PKT_CONTROL                    0x284
> > +#define NWL_DSI_SEND_PACKET                    0x288
> > +#define NWL_DSI_PKT_STATUS                     0x28c
> > +#define NWL_DSI_PKT_FIFO_WR_LEVEL              0x290
> > +#define NWL_DSI_PKT_FIFO_RD_LEVEL              0x294
> > +#define NWL_DSI_RX_PAYLOAD                     0x298
> > +#define NWL_DSI_RX_PKT_HEADER                  0x29c
> > +
> > +/* DSI IRQ handling */
> > +#define NWL_DSI_IRQ_STATUS                     0x2a0
> > +#define NWL_DSI_SM_NOT_IDLE                    BIT(0)
> > +#define NWL_DSI_TX_PKT_DONE                    BIT(1)
> > +#define NWL_DSI_DPHY_DIRECTION                 BIT(2)
> > +#define NWL_DSI_TX_FIFO_OVFLW                  BIT(3)
> > +#define NWL_DSI_TX_FIFO_UDFLW                  BIT(4)
> > +#define NWL_DSI_RX_FIFO_OVFLW                  BIT(5)
> > +#define NWL_DSI_RX_FIFO_UDFLW                  BIT(6)
> > +#define NWL_DSI_RX_PKT_HDR_RCVD                        BIT(7)
> > +#define NWL_DSI_RX_PKT_PAYLOAD_DATA_RCVD       BIT(8)
> > +#define NWL_DSI_BTA_TIMEOUT                    BIT(29)
> > +#define NWL_DSI_LP_RX_TIMEOUT                  BIT(30)
> > +#define NWL_DSI_HS_TX_TIMEOUT                  BIT(31)
> > +
> > +#define NWL_DSI_IRQ_STATUS2                    0x2a4
> > +#define NWL_DSI_SINGLE_BIT_ECC_ERR             BIT(0)
> > +#define NWL_DSI_MULTI_BIT_ECC_ERR              BIT(1)
> > +#define NWL_DSI_CRC_ERR                                BIT(2)
> > +
> > +#define NWL_DSI_IRQ_MASK                       0x2a8
> > +#define NWL_DSI_SM_NOT_IDLE_MASK               BIT(0)
> > +#define NWL_DSI_TX_PKT_DONE_MASK               BIT(1)
> > +#define NWL_DSI_DPHY_DIRECTION_MASK            BIT(2)
> > +#define NWL_DSI_TX_FIFO_OVFLW_MASK             BIT(3)
> > +#define NWL_DSI_TX_FIFO_UDFLW_MASK             BIT(4)
> > +#define NWL_DSI_RX_FIFO_OVFLW_MASK             BIT(5)
> > +#define NWL_DSI_RX_FIFO_UDFLW_MASK             BIT(6)
> > +#define NWL_DSI_RX_PKT_HDR_RCVD_MASK           BIT(7)
> > +#define NWL_DSI_RX_PKT_PAYLOAD_DATA_RCVD_MASK  BIT(8)
> > +#define NWL_DSI_BTA_TIMEOUT_MASK               BIT(29)
> > +#define NWL_DSI_LP_RX_TIMEOUT_MASK             BIT(30)
> > +#define NWL_DSI_HS_TX_TIMEOUT_MASK             BIT(31)
> > +
> > +#define NWL_DSI_IRQ_MASK2                      0x2ac
> > +#define NWL_DSI_SINGLE_BIT_ECC_ERR_MASK                BIT(0)
> > +#define NWL_DSI_MULTI_BIT_ECC_ERR_MASK         BIT(1)
> > +#define NWL_DSI_CRC_ERR_MASK                   BIT(2)
> > +
> > +/*
> > + * PKT_CONTROL format:
> > + * [15: 0] - word count
> > + * [17:16] - virtual channel
> > + * [23:18] - data type
> > + * [24]           - LP or HS select (0 - LP, 1 - HS)
> > + * [25]           - perform BTA after packet is sent
> > + * [26]           - perform BTA only, no packet tx
> > + */
> > +#define NWL_DSI_WC(x)          FIELD_PREP(GENMASK(15, 0), (x))
> > +#define NWL_DSI_TX_VC(x)       FIELD_PREP(GENMASK(17, 16), (x))
> > +#define NWL_DSI_TX_DT(x)       FIELD_PREP(GENMASK(23, 18), (x))
> > +#define NWL_DSI_HS_SEL(x)      FIELD_PREP(GENMASK(24, 24), (x))
> > +#define NWL_DSI_BTA_TX(x)      FIELD_PREP(GENMASK(25, 25), (x))
> > +#define NWL_DSI_BTA_NO_TX(x)   FIELD_PREP(GENMASK(26, 26), (x))
> > +
> > +/*
> > + * RX_PKT_HEADER format:
> > + * [15: 0] - word count
> > + * [21:16] - data type
> > + * [23:22] - virtual channel
> > + */
> > +#define NWL_DSI_RX_DT(x)       FIELD_GET(GENMASK(21, 16), (x))
> > +#define NWL_DSI_RX_VC(x)       FIELD_GET(GENMASK(23, 22), (x))
> > +
> > +/* DSI Video mode */
> > +#define NWL_DSI_VM_BURST_MODE_WITH_SYNC_PULSES         0
> > +#define NWL_DSI_VM_NON_BURST_MODE_WITH_SYNC_EVENTS     BIT(0)
> > +#define NWL_DSI_VM_BURST_MODE                          BIT(1)
> > +
> > +/* * DPI color coding */
> > +#define NWL_DSI_DPI_16_BIT_565_PACKED  0
> > +#define NWL_DSI_DPI_16_BIT_565_ALIGNED 1
> > +#define NWL_DSI_DPI_16_BIT_565_SHIFTED 2
> > +#define NWL_DSI_DPI_18_BIT_PACKED      3
> > +#define NWL_DSI_DPI_18_BIT_ALIGNED     4
> > +#define NWL_DSI_DPI_24_BIT             5
> > +
> > +/* * DPI Pixel format */
> > +#define NWL_DSI_PIXEL_FORMAT_16  0
> > +#define NWL_DSI_PIXEL_FORMAT_18  BIT(0)
> > +#define NWL_DSI_PIXEL_FORMAT_18L BIT(1)
> > +#define NWL_DSI_PIXEL_FORMAT_24  (BIT(0) | BIT(1))
> > +
> > +#endif /* __NWL_DSI_H__ */
> > --
> > 2.23.0
> > 
> > 
> 
> I know it's a lot of information here and, since I already have that
> implemented on my side, do you want me to send the next revision, or do
> you want to implement it on your own?

I'm fine with making (and testing) the changes but if you have some code
(even against an older driver version) i can borrow from in a tree
somewhere you can link to (or send via mail) that'd certainly speed up
things.

Cheers,
 -- Guido

> 
> Best regards,
> Robert
