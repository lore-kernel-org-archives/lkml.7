Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B5BC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 20:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9938D218B8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 20:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NARsQl2n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387632AbfGZUBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 16:01:53 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39182 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387532AbfGZUBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 16:01:52 -0400
Received: by mail-lj1-f196.google.com with SMTP id v18so52564497ljh.6;
        Fri, 26 Jul 2019 13:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kZidz+2sfJl7QwKTupRy9ixTpNNMsvkYqhghMR5iiOA=;
        b=NARsQl2n+nPDCsm9EUG4kCkw++BmHPegwQhoi+3bQRUl6Brf7/lO+0tblQ/4eJEOHI
         Lrtghcb9rhtoKxeg7B0g2pxrsvoJUcGn2mnkXZOW63GELEIvRzNKZvoBYXzuOIuD9xF7
         hX7nj9TN5TdUsHRqseKvxvyf7YShoSR7NE2KmSYlVXXajXEHYIVvhq1gWYhSUifzhc1Y
         XOkZAAZAWA3FDTE9A8D9yfmaPmfv/loqnnVl5sRps4MvVkInilYnIVs8a7U+KsytLOf/
         hWVvVAqs2K0JFxxkPb5EBOcSPXbd550nTCcCj9xZgiKTOfpgs0SH4oI5nnTUPlmpb1CG
         M8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kZidz+2sfJl7QwKTupRy9ixTpNNMsvkYqhghMR5iiOA=;
        b=htcRf0oJ0dTcoi2YIohYKywJjmO/zEsx9MFkvmEjUu6dJUAfepPYLMhO7cZ6uEewwI
         XaPzN5Z6b0wi/J0c50X4nnT4GCKovz86fPPegSqt+DVh2e23GiKH4eTfIwvEZn3gu82T
         56hsfVCS2mI1VbOqUyJovMb0jSQrGed8XbTjnaaJXBO/VGB5Y+7e9wtBWl3GKs4jJu/y
         fL7zVlK7jZMWanHEsHHJYAkl62DepUop5vinpjmW99GSYPPX3FXc1ahvBqtvrwc5IFVW
         ovGpLW8kC584yS/Cffrw3Y0xdXQWSAjYCef5ecnKX9kFaZgT37X0Rya4PPUDCF+vOP9o
         IYew==
X-Gm-Message-State: APjAAAUxKxdGnbcPYqz15X62M1UEUp3gRAMZvnL0nrYlF3NCjSFNFjqZ
        UZ4cHkPVThfR8GwO67s+/sukvwproxo+0Yz2PG0=
X-Google-Smtp-Source: APXvYqyCaJ9ePwnew108BNRnyXQzksfZXAtDWBoUUB7fd8t1cwG9RTsr9WqtBV+qaQUebxiWncoq7iSlqp94M99YFig=
X-Received: by 2002:a2e:8650:: with SMTP id i16mr51072222ljj.178.1564171309337;
 Fri, 26 Jul 2019 13:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1563983037.git.agx@sigxcpu.org> <3158f4f8c97c21f98c394e5631d74bc60d796522.1563983037.git.agx@sigxcpu.org>
In-Reply-To: <3158f4f8c97c21f98c394e5631d74bc60d796522.1563983037.git.agx@sigxcpu.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 26 Jul 2019 17:01:52 -0300
Message-ID: <CAOMZO5BRbV_1du1b9eJqcBvvXSE2Mon3yxSPJxPpZgBqYNjBSg@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/bridge: Add NWL MIPI DSI host controller support
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Lee Jones <lee.jones@linaro.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Robert Chiras <robert.chiras@nxp.com>,
        Chris Healy <cphealy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido,

Thanks for your work on this driver!

On Wed, Jul 24, 2019 at 12:52 PM Guido G=C3=BCnther <agx@sigxcpu.org> wrote=
:

> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/imx-nwl/Kconfig
> @@ -0,0 +1,15 @@
> +config DRM_IMX_NWL_DSI
> +       tristate "Support for Northwest Logic MIPI DSI Host controller"
> +       depends on DRM && (ARCH_MXC || ARCH_MULTIPLATFORM || COMPILE_TEST=
)


This IP could potentially be found on other SoCs, so no need to make
it depend on ARCH_MXC.

> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
> +#include <drm/drm_print.h>
> +#include <drm/drm_probe_helper.h>
> +#include <linux/clk-provider.h>
> +#include <linux/clk.h>
> +#include <linux/component.h>
> +#include <linux/gpio/consumer.h>

I did not find gpio AP used in this driver.

> +static void imx_nwl_dsi_set_clocks(struct imx_nwl_dsi *dsi, bool enable)

Better make it to return 'int' instead...

> +{
> +       struct device *dev =3D dsi->dev;
> +       const char *id;
> +       struct clk *clk;
> +       unsigned long new_rate, cur_rate;
> +       bool enabled;
> +       size_t i;
> +       int ret;
> +
> +       DRM_DEV_DEBUG_DRIVER(dev, "%sabling platform clocks",

Please remove the letter 's' from 'sabling'.

> +                            enable ? "en" : "dis");
> +                       ret =3D clk_prepare_enable(clk);
> +                       if (ret < 0) {
> +                               DRM_DEV_ERROR(dev, "Failed to enable cloc=
k %s",
> +                                             id);

and propagate the error in case of clk_prepare_enable() failure.

> +                       }
> +                       dsi->clk_config[i].enabled =3D true;
> +                       cur_rate =3D clk_get_rate(clk);
> +                       DRM_DEV_DEBUG_DRIVER(
> +                               dev, "Enabled %s clk (rate: req=3D%lu act=
=3D%lu)\n",
> +                               id, new_rate, cur_rate);
> +               } else if (enabled) {
> +                       clk_disable_unprepare(clk);
> +                       dsi->clk_config[i].enabled =3D false;
> +                       DRM_DEV_DEBUG_DRIVER(dev, "Disabled %s clk\n", id=
);
> +               }
> +       }
> +}
> +
> +static void imx_nwl_dsi_enable(struct imx_nwl_dsi *dsi)

Same here. Please return 'int' instead.

> +{
> +       struct device *dev =3D dsi->dev;
> +       int ret;
> +
> +       imx_nwl_dsi_set_clocks(dsi, true);
> +
> +       ret =3D dsi->pdata->poweron(dsi);
> +       if (ret < 0)
> +               DRM_DEV_ERROR(dev, "Failed to power on DSI (%d)\n", ret);

If the power domain failed to turn on, it is better to propagate the error.

> +       phy_ref_rate =3D clk_get_rate(dsi->phy_ref_clk);
> +       DRM_DEV_DEBUG_DRIVER(dev, "PHY at ref rate: %lu\n", phy_ref_rate)=
;
> +       if (ret < 0) {

This check looks wrong. At this point ret is always 0.

> +               DRM_DEV_ERROR(dsi->dev,
> +                             "Cannot setup PHY for mode: %ux%u @%d Hz\n"=
,
> +                             adjusted_mode->hdisplay, adjusted_mode->vdi=
splay,
> +                             adjusted_mode->clock);
> +               DRM_DEV_ERROR(dsi->dev, "PHY ref clk: %lu, bit clk: %lu\n=
",
> +                             phy_ref_rate, new_cfg.mipi_dphy.hs_clk_rate=
);
> +       } else {
> +               /* Save the new desired phy config */
> +               memcpy(&dsi->phy_cfg, &new_cfg, sizeof(new_cfg));
> +       }
> +
> +       /* LCDIF + NWL needs active high sync */

Would this still work if DCSS is used instead?

> +       adjusted_mode->flags |=3D (DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_P=
VSYNC);
> +       adjusted_mode->flags &=3D ~(DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_=
NVSYNC);
> +
> +       drm_display_mode_to_videomode(adjusted_mode, &dsi->vm);
> +       drm_mode_debug_printmodeline(adjusted_mode);
> +
> +       return ret =3D=3D 0;

At this point ret is always 0.

> +static void imx_nwl_dsi_bridge_pre_enable(struct drm_bridge *bridge)
> +{
> +       struct imx_nwl_dsi *dsi =3D bridge_to_dsi(bridge);
> +
> +       if (dsi->dpms_mode =3D=3D DRM_MODE_DPMS_ON)
> +               return;
> +
> +       imx_nwl_select_input_source(dsi);

This function is i.MX8M specific, so better protect it to run only for
the i.MX8M variant.

> +       pm_runtime_get_sync(dsi->dev);
> +       imx_nwl_dsi_enable(dsi);
> +       nwl_dsi_enable(dsi);

Please check the error and propagate in the case of failure.

> +       dsi->dpms_mode =3D DRM_MODE_DPMS_ON;
> +}
> +

> +       dsi->csr =3D syscon_regmap_lookup_by_phandle(np, "csr");
> +       if (IS_ERR(dsi->csr) && dsi->pdata->ext_regs & IMX_REG_CSR) {
> +               ret =3D PTR_ERR(dsi->csr);
> +               DRM_DEV_ERROR(dsi->dev, "Failed to get CSR regmap: %d\n",

In this function (and globally in the driver) there is a mix of
DRM_DEV_ERROR() and dev_err().

Can we just pick one of the two and use it consistently?

Not sure what is the norm in drm code, but IMHO dev_err() looks prettier :-=
)

> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       base =3D devm_ioremap_resource(dsi->dev, res);

Could use devm_platform_ioremap_resource(), which makes it simpler.

> +err_cleanup:
> +       devm_free_irq(dev, dsi->irq, dsi);

No need to call devm_free_irq() here. The devm functions do not need
to be freed on probe.

> diff --git a/drivers/gpu/drm/bridge/imx-nwl/nwl-dsi.c b/drivers/gpu/drm/b=
ridge/imx-nwl/nwl-dsi.c
> new file mode 100644
> index 000000000000..0e1463af162f
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/imx-nwl/nwl-dsi.c
> @@ -0,0 +1,745 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * NWL DSI host driver
> + *
> + * Copyright (C) 2017 NXP
> + * Copyright (C) 2019 Purism SPC
> + */
> +
> +#include <asm/unaligned.h>

Is this asm header required?

> +/*
> + * DSI Video mode
> + */

Single line comment would suffice.

> +#define VIDEO_MODE_BURST_MODE_WITH_SYNC_PULSES         0
> +#define VIDEO_MODE_NON_BURST_MODE_WITH_SYNC_EVENTS     BIT(0)
> +#define VIDEO_MODE_BURST_MODE                          BIT(1)
> +
> +/*
> + * DPI color coding
> + */

Ditto.

> +#define DPI_16_BIT_565_PACKED  0
> +#define DPI_16_BIT_565_ALIGNED 1
> +#define DPI_16_BIT_565_SHIFTED 2
> +#define DPI_18_BIT_PACKED      3
> +#define DPI_18_BIT_ALIGNED     4
> +#define DPI_24_BIT             5
> +
> +/*
> + * DPI Pixel format
> + */

Ditto.

> +#define PIXEL_FORMAT_16  0
> +#define PIXEL_FORMAT_18  BIT(0)
> +#define PIXEL_FORMAT_18L BIT(1)
> +#define PIXEL_FORMAT_24  (BIT(0) | BIT(1))
> +
> +enum transfer_direction { DSI_PACKET_SEND, DSI_PACKET_RECEIVE };
> +
> +struct mipi_dsi_transfer {
> +       const struct mipi_dsi_msg *msg;
> +       struct mipi_dsi_packet packet;
> +       struct completion completed;
> +
> +       int status; /* status of transmission */
> +       enum transfer_direction direction;
> +       bool need_bta;
> +       u8 cmd;
> +       u16 rx_word_count;
> +       size_t tx_len; /* bytes sent */
> +       size_t rx_len; /* bytes received */
> +};

The comments here are kind of obvious, so I would just remove them.

> +static inline int nwl_dsi_write(struct imx_nwl_dsi *dsi, unsigned int re=
g,

inline can be dropped.

> +                               u32 val)
> +{
> +       int ret;
> +
> +       ret =3D regmap_write(dsi->regmap, reg, val);
> +       if (ret < 0)
> +               DRM_DEV_ERROR(dsi->dev,
> +                             "Failed to write NWL DSI reg 0x%x: %d\n", r=
eg,
> +                             ret);
> +       return ret;
> +}
> +
> +static inline u32 nwl_dsi_read(struct imx_nwl_dsi *dsi, u32 reg)

Same here.

> +{
> +       unsigned int val;
> +       int ret;
> +
> +       ret =3D regmap_read(dsi->regmap, reg, &val);
> +       if (ret < 0)
> +               DRM_DEV_ERROR(dsi->dev, "Failed to read NWL DSI reg 0x%x:=
 %d\n",
> +                             reg, ret);
> +
> +       return val;
> +}

It seems that we could simply use regmap_read/write() directly instead
of these functions.

> +int nwl_dsi_get_dphy_params(struct imx_nwl_dsi *dsi,
> +                           const struct drm_display_mode *mode,
> +                           union phy_configure_opts *phy_opts)
> +{
> +       unsigned long rate;
> +
> +       if (dsi->lanes < 1 || dsi->lanes > 4)
> +               return -EINVAL;
> +
> +       /*
> +        * So far the DPHY spec minimal timings work for both mixel
> +        * dphy and nwl dsi host
> +        */
> +       phy_mipi_dphy_get_default_config(
> +               mode->crtc_clock * 1000,
> +               mipi_dsi_pixel_format_to_bpp(dsi->format), dsi->lanes,
> +               &phy_opts->mipi_dphy);
> +       rate =3D clk_get_rate(dsi->tx_esc_clk);
> +       DRM_DEV_DEBUG_DRIVER(dsi->dev, "LP clk is @%lu Hz\n", rate);
> +       phy_opts->mipi_dphy.lp_clk_rate =3D rate;
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(nwl_dsi_get_dphy_params);

Does it really need to be exported? Why can't it be placed inside
nwl-drv.c and be made static?

> +/**

/* is enough


> + * ui2bc - UI time periods to byte clock cycles
> + */
> +static u32 ui2bc(struct imx_nwl_dsi *dsi, unsigned long long ui)
> +{
> +       int bpp =3D mipi_dsi_pixel_format_to_bpp(dsi->format);
> +
> +       return DIV_ROUND_UP(ui * dsi->lanes, dsi->vm.pixelclock * bpp);
> +}
> +
> +#define USEC_PER_SEC 1000000L

This definition already exists in include/linux/time64.h. No need to
redefine it.

> +static int nwl_dsi_enable_tx_clock(struct imx_nwl_dsi *dsi)
> +{
> +       struct device *dev =3D dsi->dev;
> +       int ret;
> +
> +       ret =3D clk_prepare_enable(dsi->tx_esc_clk);
> +       if (ret < 0) {
> +               DRM_DEV_ERROR(dev, "Failed to enable tx_esc clk: %d\n", r=
et);
> +               return ret;
> +       }
> +
> +       DRM_DEV_DEBUG_DRIVER(dev, "Enabled tx_esc clk @%lu Hz\n",
> +                            clk_get_rate(dsi->tx_esc_clk));
> +       return 0;
> +}

Do we really need this function? It looks like it would be simpler
just to call clk_prepare_enable() directly.

> +
> +static int nwl_dsi_enable_rx_clock(struct imx_nwl_dsi *dsi)
> +{
> +       struct device *dev =3D dsi->dev;
> +       int ret;
> +
> +       ret =3D clk_prepare_enable(dsi->rx_esc_clk);
> +       if (ret < 0) {
> +               DRM_DEV_ERROR(dev, "Failed to enable rx_esc clk: %d\n", r=
et);
> +               return ret;
> +       }
> +
> +       DRM_DEV_DEBUG_DRIVER(dev, "Enabled rx_esc clk @%lu Hz\n",
> +                            clk_get_rate(dsi->rx_esc_clk));
> +       return 0;
> +}

Same here.

> +static ssize_t nwl_dsi_host_transfer(struct mipi_dsi_host *dsi_host,
> +                                    const struct mipi_dsi_msg *msg)
> +{
> +       struct imx_nwl_dsi *dsi =3D
> +               container_of(dsi_host, struct imx_nwl_dsi, dsi_host);
> +       struct mipi_dsi_transfer xfer;
> +       ssize_t ret =3D 0;
> +
> +       /* Create packet to be sent */
> +       dsi->xfer =3D &xfer;
> +       ret =3D mipi_dsi_create_packet(&xfer.packet, msg);
> +       if (ret < 0) {
> +               dsi->xfer =3D NULL;
> +               return ret;
> +       }
> +
> +       if ((msg->type & MIPI_DSI_GENERIC_READ_REQUEST_0_PARAM ||
> +            msg->type & MIPI_DSI_GENERIC_READ_REQUEST_1_PARAM ||
> +            msg->type & MIPI_DSI_GENERIC_READ_REQUEST_2_PARAM ||
> +            msg->type & MIPI_DSI_DCS_READ) &&
> +           msg->rx_len > 0 && msg->rx_buf !=3D NULL)
> +               xfer.direction =3D DSI_PACKET_RECEIVE;
> +       else
> +               xfer.direction =3D DSI_PACKET_SEND;
> +
> +       xfer.need_bta =3D (xfer.direction =3D=3D DSI_PACKET_RECEIVE);
> +       xfer.need_bta |=3D (msg->flags & MIPI_DSI_MSG_REQ_ACK) ? 1 : 0;
> +       xfer.msg =3D msg;
> +       xfer.status =3D -ETIMEDOUT;
> +       xfer.rx_word_count =3D 0;
> +       xfer.rx_len =3D 0;
> +       xfer.cmd =3D 0x00;
> +       if (msg->tx_len > 0)
> +               xfer.cmd =3D ((u8 *)(msg->tx_buf))[0];
> +       init_completion(&xfer.completed);
> +
> +       nwl_dsi_enable_rx_clock(dsi);

This may fail, so better check the error.

ret =3D clk_prepare_enable()
if (ret < 0)
   return ret;

> +irqreturn_t nwl_dsi_irq_handler(int irq, void *data)
> +{
> +       u32 irq_status;
> +       struct imx_nwl_dsi *dsi =3D data;
> +
> +       irq_status =3D nwl_dsi_read(dsi, IRQ_STATUS);
> +
> +       if (irq_status & TX_PKT_DONE || irq_status & RX_PKT_HDR_RCVD ||
> +           irq_status & RX_PKT_PAYLOAD_DATA_RCVD)
> +               nwl_dsi_finish_transmission(dsi, irq_status);
> +
> +       return IRQ_HANDLED;
> +}
> +EXPORT_SYMBOL_GPL(nwl_dsi_irq_handler);

What about placing this function inside nwl-drv.c and make it static?

> +
> +int nwl_dsi_enable(struct imx_nwl_dsi *dsi)
> +{
> +       struct device *dev =3D dsi->dev;
> +       union phy_configure_opts *phy_cfg =3D &dsi->phy_cfg;
> +       int ret;
> +
> +       if (!dsi->lanes) {
> +               DRM_DEV_ERROR(dev, "Need DSI lanes: %d\n", dsi->lanes);
> +               return -EINVAL;
> +       }
> +
> +       ret =3D phy_init(dsi->phy);
> +       if (ret < 0) {
> +               DRM_DEV_ERROR(dev, "Failed to init DSI phy: %d\n", ret);
> +               return ret;
> +       }
> +
> +       ret =3D phy_configure(dsi->phy, phy_cfg);
> +       if (ret < 0) {
> +               DRM_DEV_ERROR(dev, "Failed to configure DSI phy: %d\n", r=
et);
> +               return ret;
> +       }
> +
> +       ret =3D nwl_dsi_enable_tx_clock(dsi);
> +       if (ret < 0) {
> +               DRM_DEV_ERROR(dev, "Failed to enable tx clock: %d\n", ret=
);
> +               return ret;
> +       }
> +
> +       ret =3D nwl_dsi_config_host(dsi);
> +       if (ret < 0) {
> +               DRM_DEV_ERROR(dev, "Failed to set up DSI: %d", ret);
> +               return ret;
> +       }
> +
> +       ret =3D nwl_dsi_config_dpi(dsi);
> +       if (ret < 0) {
> +               DRM_DEV_ERROR(dev, "Failed to set up DPI: %d", ret);
> +               return ret;
> +       }
> +
> +       ret =3D phy_power_on(dsi->phy);
> +       if (ret < 0) {
> +               DRM_DEV_ERROR(dev, "Failed to power on DPHY (%d)\n", ret)=
;
> +               return ret;
> +       }
> +
> +       nwl_dsi_init_interrupts(dsi);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(nwl_dsi_enable);

Same here.

> +
> +int nwl_dsi_disable(struct imx_nwl_dsi *dsi)
> +{
> +       struct device *dev =3D dsi->dev;
> +
> +       DRM_DEV_DEBUG_DRIVER(dev, "Disabling clocks and phy\n");
> +
> +       phy_power_off(dsi->phy);
> +       phy_exit(dsi->phy);
> +
> +       /* Disabling the clock before the phy breaks enabling dsi again *=
/
> +       clk_disable_unprepare(dsi->tx_esc_clk);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(nwl_dsi_disable);

Same here.
