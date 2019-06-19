Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057EFC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE9D20679
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dne5yISq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbfFSOFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 10:05:55 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33333 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfFSOFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 10:05:54 -0400
Received: by mail-lf1-f65.google.com with SMTP id y17so12260629lfe.0;
        Wed, 19 Jun 2019 07:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=miF6KLe+JTMy9V+W6+TCgEtvMujexPbxoJdln4ucJ00=;
        b=Dne5yISqQ7A/ERpghHzAXyPKthyag7DlatsQ4HK3JrmO6lYrY/kn6zFJOnYn0c9kIq
         XGiZU79OnT4wqIUQLa3Gfaz9wDHjKqYgMeyDfbaQzNX8b4p6X0rVk+vjpemSAycDpXJR
         tfi4k8D36LECbg9VqXPSQTRu7MnZX2+TddXFzmHr80JTPaVwm5moi4jJniLNQdhAjFRS
         BR206ko9l6qwicJ5kfxc5PRebpHwqvtfAZggZF1/6Uk04oAbPYVBXQK2+me9iz93aYIT
         KMm3VEGjaEyGPeJzxSAEHsqPm0YWkwXZO+3oqQkGztdYPfPPrN3dlG7Yy2+oxiYQlfIS
         m03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=miF6KLe+JTMy9V+W6+TCgEtvMujexPbxoJdln4ucJ00=;
        b=dIO8FOgOPYEpKWSKHYQNZ+vONDGj9Mv0ghiHWh1e3BdmiEgXmuJ6WIRHElUC3NrpPq
         hcw4X6JRlhlBS9jYyrRgPbe2ZVkv69zcwVjdR/gfORjkltfS8XjiOzrQHiA8LigFxdvt
         upg9q/3DX3i7BtWJKSzDrqYjTvzBd++IhfJMPlLkJIbaXAzOb2AFHZfFD64m050KX074
         Q3ci1rGGgBxSfxLFHqZdKtV+XVRHvGfO8RfBiMDME1f6jSzJ637vxUDslhqAoIONjzW9
         NIMDqsUeSqQB61nX+kQqxi5hqU8VZ9ZswHrv9bSaP96t76U0jeUvoGG2EXwi8CYkvG+g
         WZGA==
X-Gm-Message-State: APjAAAWt0a2PbdbWGKNTPuhQsqflwH7+6qdM87sGVltJQT8zr/9nKeWu
        w2ytqDUlKG9HnsLyTiws1kEj5It//7eVsyV142k=
X-Google-Smtp-Source: APXvYqxhxMJfV8ig3p/kP+Si8Pi0F7lz1Rn7V5EXkaUsqp3waFJE/b90lmSb3FZs2/Oh61IOwKK8Nrd7T+OggnWC4B0=
X-Received: by 2002:a19:5046:: with SMTP id z6mr14358463lfj.185.1560953151192;
 Wed, 19 Jun 2019 07:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <1560864646-1468-1-git-send-email-robert.chiras@nxp.com> <1560864646-1468-3-git-send-email-robert.chiras@nxp.com>
In-Reply-To: <1560864646-1468-3-git-send-email-robert.chiras@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 19 Jun 2019 11:06:03 -0300
Message-ID: <CAOMZO5B3BRbpAHCAHFvFXDZjPcF+sc=PMwwkntzcBWtRQR+2gQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/panel: Add support for Raydium RM67191 panel driver
To:     Robert Chiras <robert.chiras@nxp.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 10:31 AM Robert Chiras <robert.chiras@nxp.com> wrote:

> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-raydium-rm67191.c
> @@ -0,0 +1,709 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * i.MX drm driver - Raydium MIPI-DSI panel driver

Please remove the "i.MX drm driver" as there is nothing i.MX specific
in this driver.


> + *
> + * Copyright 2019 NXP
> + */
> +
> +#include <linux/backlight.h>
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <video/mipi_display.h>
> +#include <video/of_videomode.h>
> +#include <video/videomode.h>
> +
> +#include <drm/drm_crtc.h>
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_panel.h>
> +#include <drm/drm_print.h>
> +
> +/* Write Manufacture Command Set Control */
> +#define WRMAUCCTR 0xFE
> +
> +#define COL_FMT_16BPP 0x55
> +#define COL_FMT_18BPP 0x66
> +#define COL_FMT_24BPP 0x77
> +
> +/* Manufacturer Command Set pages (CMD2) */
> +struct cmd_set_entry {
> +       u8 cmd;
> +       u8 param;
> +};
> +
> +/*
> + * There is no description in the Reference Manual about these commands.
> + * We received them from vendor, so just use them as is.
> + */
> +static const struct cmd_set_entry manufacturer_cmd_set[] = {
> +       {0xFE, 0x0B},
> +       {0x28, 0x40},
> +       {0x29, 0x4F},
> +       {0xFE, 0x0E},
> +       {0x4B, 0x00},
> +       {0x4C, 0x0F},
> +       {0x4D, 0x20},
> +       {0x4E, 0x40},
> +       {0x4F, 0x60},
> +       {0x50, 0xA0},
> +       {0x51, 0xC0},
> +       {0x52, 0xE0},
> +       {0x53, 0xFF},
> +       {0xFE, 0x0D},
> +       {0x18, 0x08},
> +       {0x42, 0x00},
> +       {0x08, 0x41},
> +       {0x46, 0x02},
> +       {0x72, 0x09},
> +       {0xFE, 0x0A},
> +       {0x24, 0x17},
> +       {0x04, 0x07},
> +       {0x1A, 0x0C},
> +       {0x0F, 0x44},
> +       {0xFE, 0x04},
> +       {0x00, 0x0C},
> +       {0x05, 0x08},
> +       {0x06, 0x08},
> +       {0x08, 0x08},
> +       {0x09, 0x08},
> +       {0x0A, 0xE6},
> +       {0x0B, 0x8C},
> +       {0x1A, 0x12},
> +       {0x1E, 0xE0},
> +       {0x29, 0x93},
> +       {0x2A, 0x93},
> +       {0x2F, 0x02},
> +       {0x31, 0x02},
> +       {0x33, 0x05},
> +       {0x37, 0x2D},
> +       {0x38, 0x2D},
> +       {0x3A, 0x1E},
> +       {0x3B, 0x1E},
> +       {0x3D, 0x27},
> +       {0x3F, 0x80},
> +       {0x40, 0x40},
> +       {0x41, 0xE0},
> +       {0x4F, 0x2F},
> +       {0x50, 0x1E},
> +       {0xFE, 0x06},
> +       {0x00, 0xCC},
> +       {0x05, 0x05},
> +       {0x07, 0xA2},
> +       {0x08, 0xCC},
> +       {0x0D, 0x03},
> +       {0x0F, 0xA2},
> +       {0x32, 0xCC},
> +       {0x37, 0x05},
> +       {0x39, 0x83},
> +       {0x3A, 0xCC},
> +       {0x41, 0x04},
> +       {0x43, 0x83},
> +       {0x44, 0xCC},
> +       {0x49, 0x05},
> +       {0x4B, 0xA2},
> +       {0x4C, 0xCC},
> +       {0x51, 0x03},
> +       {0x53, 0xA2},
> +       {0x75, 0xCC},
> +       {0x7A, 0x03},
> +       {0x7C, 0x83},
> +       {0x7D, 0xCC},
> +       {0x82, 0x02},
> +       {0x84, 0x83},
> +       {0x85, 0xEC},
> +       {0x86, 0x0F},
> +       {0x87, 0xFF},
> +       {0x88, 0x00},
> +       {0x8A, 0x02},
> +       {0x8C, 0xA2},
> +       {0x8D, 0xEA},
> +       {0x8E, 0x01},
> +       {0x8F, 0xE8},
> +       {0xFE, 0x06},
> +       {0x90, 0x0A},
> +       {0x92, 0x06},
> +       {0x93, 0xA0},
> +       {0x94, 0xA8},
> +       {0x95, 0xEC},
> +       {0x96, 0x0F},
> +       {0x97, 0xFF},
> +       {0x98, 0x00},
> +       {0x9A, 0x02},
> +       {0x9C, 0xA2},
> +       {0xAC, 0x04},
> +       {0xFE, 0x06},
> +       {0xB1, 0x12},
> +       {0xB2, 0x17},
> +       {0xB3, 0x17},
> +       {0xB4, 0x17},
> +       {0xB5, 0x17},
> +       {0xB6, 0x11},
> +       {0xB7, 0x08},
> +       {0xB8, 0x09},
> +       {0xB9, 0x06},
> +       {0xBA, 0x07},
> +       {0xBB, 0x17},
> +       {0xBC, 0x17},
> +       {0xBD, 0x17},
> +       {0xBE, 0x17},
> +       {0xBF, 0x17},
> +       {0xC0, 0x17},
> +       {0xC1, 0x17},
> +       {0xC2, 0x17},
> +       {0xC3, 0x17},
> +       {0xC4, 0x0F},
> +       {0xC5, 0x0E},
> +       {0xC6, 0x00},
> +       {0xC7, 0x01},
> +       {0xC8, 0x10},
> +       {0xFE, 0x06},
> +       {0x95, 0xEC},
> +       {0x8D, 0xEE},
> +       {0x44, 0xEC},
> +       {0x4C, 0xEC},
> +       {0x32, 0xEC},
> +       {0x3A, 0xEC},
> +       {0x7D, 0xEC},
> +       {0x75, 0xEC},
> +       {0x00, 0xEC},
> +       {0x08, 0xEC},
> +       {0x85, 0xEC},
> +       {0xA6, 0x21},
> +       {0xA7, 0x05},
> +       {0xA9, 0x06},
> +       {0x82, 0x06},
> +       {0x41, 0x06},
> +       {0x7A, 0x07},
> +       {0x37, 0x07},
> +       {0x05, 0x06},
> +       {0x49, 0x06},
> +       {0x0D, 0x04},
> +       {0x51, 0x04},
> +};
> +
> +static const u32 rad_bus_formats[] = {
> +       MEDIA_BUS_FMT_RGB888_1X24,
> +       MEDIA_BUS_FMT_RGB666_1X18,
> +       MEDIA_BUS_FMT_RGB565_1X16,
> +};
> +
> +struct rad_panel {
> +       struct drm_panel panel;
> +       struct mipi_dsi_device *dsi;
> +
> +       struct gpio_desc *reset;
> +       struct backlight_device *backlight;
> +
> +       bool prepared;
> +       bool enabled;
> +
> +       struct videomode vm;
> +       u32 width_mm;
> +       u32 height_mm;
> +};
> +
> +static inline struct rad_panel *to_rad_panel(struct drm_panel *panel)
> +{
> +       return container_of(panel, struct rad_panel, panel);
> +}
> +
> +static int rad_panel_push_cmd_list(struct mipi_dsi_device *dsi)
> +{
> +       size_t i;
> +       size_t count = ARRAY_SIZE(manufacturer_cmd_set);
> +       int ret = 0;
> +
> +       for (i = 0; i < count; i++) {
> +               const struct cmd_set_entry *entry = &manufacturer_cmd_set[i];
> +               u8 buffer[2] = { entry->cmd, entry->param };
> +
> +               ret = mipi_dsi_generic_write(dsi, &buffer, sizeof(buffer));
> +               if (ret < 0)
> +                       return ret;
> +       }
> +
> +       return ret;
> +};
> +
> +static int color_format_from_dsi_format(enum mipi_dsi_pixel_format format)
> +{
> +       switch (format) {
> +       case MIPI_DSI_FMT_RGB565:
> +               return COL_FMT_16BPP;
> +       case MIPI_DSI_FMT_RGB666:
> +       case MIPI_DSI_FMT_RGB666_PACKED:
> +               return COL_FMT_18BPP;
> +       case MIPI_DSI_FMT_RGB888:
> +               return COL_FMT_24BPP;
> +       default:
> +               return COL_FMT_24BPP; /* for backward compatibility */
> +       }
> +};
> +
> +static int rad_panel_prepare(struct drm_panel *panel)
> +{
> +       struct rad_panel *rad = to_rad_panel(panel);
> +
> +       if (rad->prepared)
> +               return 0;
> +
> +       if (rad->reset) {
> +               gpiod_set_value_cansleep(rad->reset, 1);
> +               usleep_range(3000, 5000);
> +               gpiod_set_value_cansleep(rad->reset, 0);
> +               usleep_range(18000, 20000);
> +       }
> +
> +       rad->prepared = true;
> +
> +       return 0;
> +}
> +
> +static int rad_panel_unprepare(struct drm_panel *panel)
> +{
> +       struct rad_panel *rad = to_rad_panel(panel);
> +
> +       if (!rad->prepared)
> +               return 0;
> +
> +       if (rad->reset) {
> +               gpiod_set_value_cansleep(rad->reset, 1);
> +               usleep_range(15000, 17000);
> +               gpiod_set_value_cansleep(rad->reset, 0);
> +       }
> +
> +       rad->prepared = false;
> +
> +       return 0;
> +}
> +
> +static int rad_panel_enable(struct drm_panel *panel)
> +{
> +       struct rad_panel *rad = to_rad_panel(panel);
> +       struct mipi_dsi_device *dsi = rad->dsi;
> +       struct device *dev = &dsi->dev;
> +       int color_format = color_format_from_dsi_format(dsi->format);
> +       int ret;
> +
> +       if (rad->enabled)
> +               return 0;
> +
> +       dsi->mode_flags |= MIPI_DSI_MODE_LPM;
> +
> +       ret = rad_panel_push_cmd_list(dsi);
> +       if (ret < 0) {
> +               DRM_DEV_ERROR(dev, "Failed to send MCS (%d)\n", ret);
> +               goto fail;
> +       }
> +
> +       /* Select User Command Set table (CMD1) */
> +       ret = mipi_dsi_generic_write(dsi, (u8[]){ WRMAUCCTR, 0x00 }, 2);
> +       if (ret < 0)
> +               goto fail;
> +
> +       /* Software reset */
> +       ret = mipi_dsi_dcs_soft_reset(dsi);
> +       if (ret < 0) {
> +               DRM_DEV_ERROR(dev, "Failed to do Software Reset (%d)\n", ret);
> +               goto fail;
> +       }
> +
> +       usleep_range(15000, 17000);
> +
> +       /* Set DSI mode */
> +       ret = mipi_dsi_generic_write(dsi, (u8[]){ 0xC2, 0x0B }, 2);
> +       if (ret < 0) {
> +               DRM_DEV_ERROR(dev, "Failed to set DSI mode (%d)\n", ret);
> +               goto fail;
> +       }
> +       /* Set tear ON */
> +       ret = mipi_dsi_dcs_set_tear_on(dsi, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
> +       if (ret < 0) {
> +               DRM_DEV_ERROR(dev, "Failed to set tear ON (%d)\n", ret);
> +               goto fail;
> +       }
> +       /* Set tear scanline */
> +       ret = mipi_dsi_dcs_set_tear_scanline(dsi, 0x380);
> +       if (ret < 0) {
> +               DRM_DEV_ERROR(dev, "Failed to set tear scanline (%d)\n", ret);
> +               goto fail;
> +       }
> +       /* Set pixel format */
> +       ret = mipi_dsi_dcs_set_pixel_format(dsi, color_format);
> +       DRM_DEV_DEBUG_DRIVER(dev, "Interface color format set to 0x%x\n",
> +                            color_format);
> +       if (ret < 0) {
> +               DRM_DEV_ERROR(dev, "Failed to set pixel format (%d)\n", ret);
> +               goto fail;
> +       }
> +       /* Exit sleep mode */
> +       ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
> +       if (ret < 0) {
> +               DRM_DEV_ERROR(dev, "Failed to exit sleep mode (%d)\n", ret);
> +               goto fail;
> +       }
> +
> +       usleep_range(5000, 7000);
> +
> +       ret = mipi_dsi_dcs_set_display_on(dsi);
> +       if (ret < 0) {
> +               DRM_DEV_ERROR(dev, "Failed to set display ON (%d)\n", ret);
> +               goto fail;
> +       }
> +
> +       backlight_enable(rad->backlight);
> +
> +       rad->enabled = true;
> +
> +       return 0;
> +
> +fail:
> +       if (rad->reset)
> +               gpiod_set_value_cansleep(rad->reset, 1);
> +
> +       return ret;
> +}
> +
> +static int rad_panel_disable(struct drm_panel *panel)
> +{
> +       struct rad_panel *rad = to_rad_panel(panel);
> +       struct mipi_dsi_device *dsi = rad->dsi;
> +       struct device *dev = &dsi->dev;
> +       int ret;
> +
> +       if (!rad->enabled)
> +               return 0;
> +
> +       dsi->mode_flags |= MIPI_DSI_MODE_LPM;
> +
> +       backlight_disable(rad->backlight);
> +
> +       usleep_range(10000, 12000);
> +
> +       ret = mipi_dsi_dcs_set_display_off(dsi);
> +       if (ret < 0) {
> +               DRM_DEV_ERROR(dev, "Failed to set display OFF (%d)\n", ret);
> +               return ret;
> +       }
> +
> +       usleep_range(5000, 10000);
> +
> +       ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
> +       if (ret < 0) {
> +               DRM_DEV_ERROR(dev, "Failed to enter sleep mode (%d)\n", ret);
> +               return ret;
> +       }
> +
> +       rad->enabled = false;
> +
> +       return 0;
> +}
> +
> +static int rad_panel_get_modes(struct drm_panel *panel)
> +{
> +       struct rad_panel *rad = to_rad_panel(panel);
> +       struct device *dev = &rad->dsi->dev;
> +       struct drm_connector *connector = panel->connector;
> +       struct drm_display_mode *mode;
> +       u32 *bus_flags = &connector->display_info.bus_flags;
> +       int ret;
> +
> +       mode = drm_mode_create(connector->dev);
> +       if (!mode) {
> +               DRM_DEV_ERROR(dev, "Failed to create display mode!\n");
> +               return 0;
> +       }
> +
> +       drm_display_mode_from_videomode(&rad->vm, mode);
> +       mode->width_mm = rad->width_mm;
> +       mode->height_mm = rad->height_mm;
> +       connector->display_info.width_mm = rad->width_mm;
> +       connector->display_info.height_mm = rad->height_mm;
> +       mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
> +
> +       if (rad->vm.flags & DISPLAY_FLAGS_DE_HIGH)
> +               *bus_flags |= DRM_BUS_FLAG_DE_HIGH;
> +       if (rad->vm.flags & DISPLAY_FLAGS_DE_LOW)
> +               *bus_flags |= DRM_BUS_FLAG_DE_LOW;
> +       if (rad->vm.flags & DISPLAY_FLAGS_PIXDATA_NEGEDGE)
> +               *bus_flags |= DRM_BUS_FLAG_PIXDATA_NEGEDGE;
> +       if (rad->vm.flags & DISPLAY_FLAGS_PIXDATA_POSEDGE)
> +               *bus_flags |= DRM_BUS_FLAG_PIXDATA_POSEDGE;
> +
> +       ret = drm_display_info_set_bus_formats(&connector->display_info,
> +                                              rad_bus_formats,
> +                                              ARRAY_SIZE(rad_bus_formats));
> +       if (ret)
> +               return ret;
> +
> +       drm_mode_probed_add(panel->connector, mode);
> +
> +       return 1;
> +}
> +
> +static int rad_bl_get_brightness(struct backlight_device *bl)
> +{
> +       struct mipi_dsi_device *dsi = bl_get_data(bl);
> +       struct rad_panel *rad = mipi_dsi_get_drvdata(dsi);
> +       struct device *dev = &dsi->dev;
> +       u16 brightness;
> +       int ret;
> +
> +       if (!rad->prepared)
> +               return 0;
> +
> +       DRM_DEV_DEBUG_DRIVER(dev, "\n");
> +
> +       dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
> +
> +       ret = mipi_dsi_dcs_get_display_brightness(dsi, &brightness);
> +       if (ret < 0)
> +               return ret;
> +
> +       bl->props.brightness = brightness;
> +
> +       return brightness & 0xff;
> +}
> +
> +static int rad_bl_update_status(struct backlight_device *bl)
> +{
> +       struct mipi_dsi_device *dsi = bl_get_data(bl);
> +       struct rad_panel *rad = mipi_dsi_get_drvdata(dsi);
> +       struct device *dev = &dsi->dev;
> +       int ret = 0;
> +
> +       if (!rad->prepared)
> +               return 0;
> +
> +       DRM_DEV_DEBUG_DRIVER(dev, "New brightness: %d\n", bl->props.brightness);
> +
> +       dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
> +
> +       ret = mipi_dsi_dcs_set_display_brightness(dsi, bl->props.brightness);
> +       if (ret < 0)
> +               return ret;
> +
> +       return 0;
> +}
> +
> +static const struct backlight_ops rad_bl_ops = {
> +       .update_status = rad_bl_update_status,
> +       .get_brightness = rad_bl_get_brightness,
> +};
> +
> +static const struct drm_panel_funcs rad_panel_funcs = {
> +       .prepare = rad_panel_prepare,
> +       .unprepare = rad_panel_unprepare,
> +       .enable = rad_panel_enable,
> +       .disable = rad_panel_disable,
> +       .get_modes = rad_panel_get_modes,
> +};
> +
> +/*
> + * The clock might range from 66MHz (30Hz refresh rate)
> + * to 132MHz (60Hz refresh rate)
> + */
> +static const struct display_timing rad_default_timing = {
> +       .pixelclock = { 66000000, 132000000, 132000000 },
> +       .hactive = { 1080, 1080, 1080 },
> +       .hfront_porch = { 20, 20, 20 },
> +       .hsync_len = { 2, 2, 2 },
> +       .hback_porch = { 34, 34, 34 },
> +       .vactive = { 1920, 1920, 1920 },
> +       .vfront_porch = { 10, 10, 10 },
> +       .vsync_len = { 2, 2, 2 },
> +       .vback_porch = { 4, 4, 4 },
> +       .flags = DISPLAY_FLAGS_HSYNC_LOW |
> +                DISPLAY_FLAGS_VSYNC_LOW |
> +                DISPLAY_FLAGS_DE_LOW |
> +                DISPLAY_FLAGS_PIXDATA_NEGEDGE,
> +};
> +
> +static int rad_panel_probe(struct mipi_dsi_device *dsi)
> +{
> +       struct device *dev = &dsi->dev;
> +       struct device_node *np = dev->of_node;
> +       struct device_node *timings;
> +       struct rad_panel *panel;
> +       struct backlight_properties bl_props;
> +       int ret;
> +       u32 video_mode;
> +
> +       panel = devm_kzalloc(&dsi->dev, sizeof(*panel), GFP_KERNEL);
> +       if (!panel)
> +               return -ENOMEM;
> +
> +       mipi_dsi_set_drvdata(dsi, panel);
> +
> +       panel->dsi = dsi;
> +
> +       dsi->format = MIPI_DSI_FMT_RGB888;
> +       dsi->mode_flags =  MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO |
> +                          MIPI_DSI_CLOCK_NON_CONTINUOUS;
> +
> +       ret = of_property_read_u32(np, "video-mode", &video_mode);
> +       if (!ret) {
> +               switch (video_mode) {
> +               case 0:
> +                       /* burst mode */
> +                       dsi->mode_flags |= MIPI_DSI_MODE_VIDEO_BURST;
> +                       break;
> +               case 1:
> +                       /* non-burst mode with sync event */
> +                       break;
> +               case 2:
> +                       /* non-burst mode with sync pulse */
> +                       dsi->mode_flags |= MIPI_DSI_MODE_VIDEO_SYNC_PULSE;
> +                       break;
> +               default:
> +                       dev_warn(dev, "invalid video mode %d\n", video_mode);
> +                       break;
> +               }
> +       }
> +
> +       ret = of_property_read_u32(np, "dsi-lanes", &dsi->lanes);
> +       if (ret < 0) {
> +               dev_err(dev, "Failed to get dsi-lanes property (%d)\n", ret);
> +               return ret;
> +       }
> +
> +       /*
> +        * 'display-timings' is optional, so verify if the node is present
> +        * before calling of_get_videomode so we won't get console error
> +        * messages
> +        */
> +       timings = of_get_child_by_name(np, "display-timings");
> +       if (timings) {
> +               of_node_put(timings);
> +               ret = of_get_videomode(np, &panel->vm, 0);
> +       } else {
> +               videomode_from_timing(&rad_default_timing, &panel->vm);
> +       }
> +       if (ret < 0)
> +               return ret;
> +
> +       of_property_read_u32(np, "width-mm", &panel->width_mm);
> +       of_property_read_u32(np, "height-mm", &panel->height_mm);
> +
> +       panel->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> +
> +       if (IS_ERR(panel->reset))
> +               panel->reset = NULL;
> +       else
> +               gpiod_set_value_cansleep(panel->reset, 1);
> +
> +       memset(&bl_props, 0, sizeof(bl_props));
> +       bl_props.type = BACKLIGHT_RAW;
> +       bl_props.brightness = 255;
> +       bl_props.max_brightness = 255;
> +
> +       panel->backlight = devm_backlight_device_register(dev, dev_name(dev),
> +                                                         dev, dsi,
> +                                                         &rad_bl_ops,
> +                                                         &bl_props);
> +       if (IS_ERR(panel->backlight)) {
> +               ret = PTR_ERR(panel->backlight);
> +               dev_err(dev, "Failed to register backlight (%d)\n", ret);
> +               return ret;
> +       }
> +
> +       drm_panel_init(&panel->panel);
> +       panel->panel.funcs = &rad_panel_funcs;
> +       panel->panel.dev = dev;
> +       dev_set_drvdata(dev, panel);
> +
> +       ret = drm_panel_add(&panel->panel);
> +
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = mipi_dsi_attach(dsi);
> +       if (ret < 0)
> +               drm_panel_remove(&panel->panel);
> +
> +       return ret;
> +}
> +
> +static int rad_panel_remove(struct mipi_dsi_device *dsi)
> +{
> +       struct rad_panel *rad = mipi_dsi_get_drvdata(dsi);
> +       struct device *dev = &dsi->dev;
> +       int ret;
> +
> +       ret = mipi_dsi_detach(dsi);
> +       if (ret < 0)
> +               DRM_DEV_ERROR(dev, "Failed to detach from host (%d)\n",
> +                             ret);
> +
> +       drm_panel_remove(&rad->panel);
> +
> +       return 0;
> +}
> +
> +static void rad_panel_shutdown(struct mipi_dsi_device *dsi)
> +{
> +       struct rad_panel *rad = mipi_dsi_get_drvdata(dsi);
> +
> +       rad_panel_disable(&rad->panel);
> +       rad_panel_unprepare(&rad->panel);
> +}
> +
> +#ifdef CONFIG_PM
> +static int rad_panel_suspend(struct device *dev)
> +{
> +       struct rad_panel *rad = dev_get_drvdata(dev);
> +
> +       if (!rad->reset)
> +               return 0;
> +
> +       devm_gpiod_put(dev, rad->reset);
> +       rad->reset = NULL;
> +
> +       return 0;
> +}
> +
> +static int rad_panel_resume(struct device *dev)
> +{
> +       struct rad_panel *rad = dev_get_drvdata(dev);
> +
> +       if (rad->reset)
> +               return 0;
> +
> +       rad->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> +       if (IS_ERR(rad->reset))
> +               rad->reset = NULL;
> +
> +       return PTR_ERR_OR_ZERO(rad->reset);
> +}
> +
> +#endif
> +
> +static const struct dev_pm_ops rad_pm_ops = {
> +       SET_RUNTIME_PM_OPS(rad_panel_suspend, rad_panel_resume, NULL)
> +       SET_SYSTEM_SLEEP_PM_OPS(rad_panel_suspend, rad_panel_resume)
> +};
> +
> +static const struct of_device_id rad_of_match[] = {
> +       { .compatible = "raydium,rm67191", },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, rad_of_match);
> +
> +static struct mipi_dsi_driver rad_panel_driver = {
> +       .driver = {
> +               .name = "panel-raydium-rm67191",
> +               .of_match_table = rad_of_match,
> +               .pm     = &rad_pm_ops,
> +       },
> +       .probe = rad_panel_probe,
> +       .remove = rad_panel_remove,
> +       .shutdown = rad_panel_shutdown,
> +};
> +module_mipi_dsi_driver(rad_panel_driver);
> +
> +MODULE_AUTHOR("Robert Chiras <robert.chiras@nxp.com>");
> +MODULE_DESCRIPTION("DRM Driver for Raydium RM67191 MIPI DSI panel");
> +MODULE_LICENSE("GPL v2");
> --
> 2.7.4
>
