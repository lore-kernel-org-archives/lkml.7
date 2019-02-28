Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21321C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B6A2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Y6SYwX/A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732289AbfB1OKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:10:16 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45195 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731833AbfB1OKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:10:16 -0500
Received: by mail-ed1-f65.google.com with SMTP id f19so7694921eds.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 06:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=PFbPLD6VeOq18/ptRpITjq76j0CIg95wkU9o/YTlVOY=;
        b=Y6SYwX/AVDzJ3sL9xfVUbXWNMCmM9Xk6FSOw2I3WoxK6N3vn1sh8fBTMmQK2egwsqd
         CAsih08d1bTiZCxbHZ7QU0XlOGB92tdCq3t5Uvsi7XO8dfyGfsgUj7PKfucyTGQKgRej
         m4UpzytEwF6DoWiXVLWXaldmQb5LSmkQmbZfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=PFbPLD6VeOq18/ptRpITjq76j0CIg95wkU9o/YTlVOY=;
        b=bLvIA/Y9Is8wUWqFJ68x4sHuAVT/byFQ5udY7TmWY4zg1XH1ug/oJ/eill8+ps3NS4
         dvCBxRlUECFljW+2qpM81+BqlhhYxn4/GNwWVkHGbEm9GdIqMnE/O42bUiFJFN+/7CmW
         wkqVh2LvcWCyeMBQJkLY65Xpy+zUCUQoaZj0sQTBc4murkEFK5u0pS7Omw3Q9Xl5y1Ql
         EWIJt655k+nI/3ywnKbfWzlSeLWzRV7WChyvR2ywXYQhXmMc5iSw38p1tfsKIA1XvCPf
         jGrI07NFxnzO8lAPe7gfoCsLme0GD/i3vS6MDxQ9wrhsWzq6meAWDCLIsGmT04ziBx5Q
         IyzQ==
X-Gm-Message-State: AHQUAuZfgt3lQ5XqknrR3ZzPpkwKJEbt9B3KkTOQfq2M3d8vNa2SokGg
        gnQ9asoLEh9970+nwxLL74nPiQ==
X-Google-Smtp-Source: AHgI3IYFTMuX3MOFvjS89OfSWyPGdWbl2rStuoVqII4G04F1LYPrwszhTmRezHJnfyad/TmHJz2eZw==
X-Received: by 2002:a50:b397:: with SMTP id s23mr7126277edd.219.1551363012898;
        Thu, 28 Feb 2019 06:10:12 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id s6sm3222413eda.90.2019.02.28.06.10.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 06:10:11 -0800 (PST)
Date:   Thu, 28 Feb 2019 15:10:09 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "Hean-Loong, Ong" <hean.loong.ong@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Rienk de Jong <rienk.dejong@quest-innovations.com>,
        devicetree@vger.kernel.org, chin.liang.see@intel.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Ong@freedesktop.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv11 3/3] ARM:drm ivip Intel FPGA Video and Image
 Processing Suite
Message-ID: <20190228141009.GP2665@phenom.ffwll.local>
Mail-Followup-To: "Hean-Loong, Ong" <hean.loong.ong@intel.com>,
        Rob Herring <robh+dt@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Rienk de Jong <rienk.dejong@quest-innovations.com>,
        devicetree@vger.kernel.org, chin.liang.see@intel.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Ong@freedesktop.org, linux-arm-kernel@lists.infradead.org
References: <20190211021110.2717-1-hean.loong.ong@intel.com>
 <20190211021110.2717-4-hean.loong.ong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211021110.2717-4-hean.loong.ong@intel.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 10:11:10AM +0800, Hean-Loong, Ong wrote:
> From: Ong, Hean Loong <hean.loong.ong@intel.com>
> 
> Signed-off-by: Ong, Hean Loong <hean.loong.ong@intel.com>

Per-patch changelog is missing here, would be good to include that to help
reviewers. I've done a very quick scroll through, looks like a nice&clean
driver.

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

I think all we need is ack from the dt side. Rob Herring has commit rights
to drm-misc, so he can push your driver once he's reviewed the dt side.

Cheers, Daniel

> ---
>  drivers/gpu/drm/ivip/Kconfig          |   14 +++
>  drivers/gpu/drm/ivip/Makefile         |    7 ++
>  drivers/gpu/drm/ivip/intel_vip_conn.c |   91 ++++++++++++++++
>  drivers/gpu/drm/ivip/intel_vip_core.c |  189 +++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/ivip/intel_vip_drv.h  |   73 +++++++++++++
>  drivers/gpu/drm/ivip/intel_vip_of.c   |  181 +++++++++++++++++++++++++++++++
>  6 files changed, 555 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/gpu/drm/ivip/Kconfig
>  create mode 100644 drivers/gpu/drm/ivip/Makefile
>  create mode 100644 drivers/gpu/drm/ivip/intel_vip_conn.c
>  create mode 100644 drivers/gpu/drm/ivip/intel_vip_core.c
>  create mode 100644 drivers/gpu/drm/ivip/intel_vip_drv.h
>  create mode 100644 drivers/gpu/drm/ivip/intel_vip_of.c
> 
> diff --git a/drivers/gpu/drm/ivip/Kconfig b/drivers/gpu/drm/ivip/Kconfig
> new file mode 100644
> index 0000000..1d08b90
> --- /dev/null
> +++ b/drivers/gpu/drm/ivip/Kconfig
> @@ -0,0 +1,14 @@
> +config DRM_IVIP
> +        tristate "Intel FGPA Video and Image Processing"
> +        depends on DRM && OF
> +        select DRM_GEM_CMA_HELPER
> +        select DRM_KMS_HELPER
> +        select DRM_KMS_FB_HELPER
> +        select DRM_KMS_CMA_HELPER
> +        help
> +		  Choose this option if you have an Intel FPGA Arria 10 system
> +		  and above with an Intel Display Port IP. This does not support
> +		  legacy Intel FPGA Cyclone V display port. Currently only single
> +		  frame buffer is supported. Note that ACPI and X_86 architecture
> +		  is not supported for Arria10. If M is selected the module will be
> +		  called ivip.
> diff --git a/drivers/gpu/drm/ivip/Makefile b/drivers/gpu/drm/ivip/Makefile
> new file mode 100644
> index 0000000..3fd2e75
> --- /dev/null
> +++ b/drivers/gpu/drm/ivip/Makefile
> @@ -0,0 +1,7 @@
> +#
> +# Makefile for the drm device driver.  This driver provides support for the
> +# Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
> +
> +obj-$(CONFIG_DRM_IVIP) += ivip.o
> +ivip-objs := intel_vip_of.o intel_vip_core.o \
> +	intel_vip_conn.o
> diff --git a/drivers/gpu/drm/ivip/intel_vip_conn.c b/drivers/gpu/drm/ivip/intel_vip_conn.c
> new file mode 100644
> index 0000000..93ce0b3
> --- /dev/null
> +++ b/drivers/gpu/drm/ivip/intel_vip_conn.c
> @@ -0,0 +1,91 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 Intel Corporation.
> + *
> + * intel_vip_conn.c -- Intel Video and Image Processing(VIP)
> + * Frame Buffer II driver
> + *
> + * This driver supports the Intel VIP Frame Reader component.
> + * More info on the hardware can be found in the Intel Video
> + * and Image Processing Suite User Guide at this address
> + * http://www.altera.com/literature/ug/ug_vip.pdf.
> + *
> + * Authors:
> + * Walter Goossens <waltergoossens@home.nl>
> + * Thomas Chou <thomas@wytron.com.tw>
> + * Chris Rauer <crauer@altera.com>
> + * Ong, Hean-Loong <hean.loong.ong@intel.com>
> + *
> + */
> +
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_crtc_helper.h>
> +#include <drm/drm_encoder_slave.h>
> +#include <drm/drm_plane_helper.h>
> +
> +static enum drm_connector_status
> +intelvipfb_drm_connector_detect(struct drm_connector *connector, bool force)
> +{
> +	return connector_status_connected;
> +}
> +
> +static void intelvipfb_drm_connector_destroy(struct drm_connector *connector)
> +{
> +	drm_connector_unregister(connector);
> +	drm_connector_cleanup(connector);
> +}
> +
> +static const struct drm_connector_funcs intelvipfb_drm_connector_funcs = {
> +	.detect = intelvipfb_drm_connector_detect,
> +	.reset = drm_atomic_helper_connector_reset,
> +	.fill_modes = drm_helper_probe_single_connector_modes,
> +	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> +	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> +	.destroy = intelvipfb_drm_connector_destroy,
> +};
> +
> +static int intelvipfb_drm_connector_get_modes(struct drm_connector *connector)
> +{
> +	struct drm_device *drm = connector->dev;
> +	int count;
> +
> +	count = drm_add_modes_noedid(connector, drm->mode_config.max_width,
> +			drm->mode_config.max_height);
> +	drm_set_preferred_mode(connector, drm->mode_config.max_width,
> +			drm->mode_config.max_height);
> +	return count;
> +}
> +
> +static const struct drm_connector_helper_funcs
> +intelvipfb_drm_connector_helper_funcs = {
> +	.get_modes = intelvipfb_drm_connector_get_modes,
> +};
> +
> +struct drm_connector *
> +intelvipfb_conn_setup(struct drm_device *drm)
> +{
> +	struct drm_connector *conn;
> +	int ret;
> +
> +	conn = devm_kzalloc(drm->dev, sizeof(*conn), GFP_KERNEL);
> +	if (IS_ERR(conn))
> +		return NULL;
> +
> +	drm_connector_helper_add(conn, &intelvipfb_drm_connector_helper_funcs);
> +	ret = drm_connector_init(drm, conn, &intelvipfb_drm_connector_funcs,
> +			DRM_MODE_CONNECTOR_DisplayPort);
> +	if (ret < 0) {
> +		dev_err(drm->dev, "failed to initialize drm connector\n");
> +		ret = -ENOMEM;
> +		goto error_connector_cleanup;
> +	}
> +
> +	return conn;
> +
> +error_connector_cleanup:
> +	drm_connector_cleanup(conn);
> +
> +	return NULL;
> +}
> diff --git a/drivers/gpu/drm/ivip/intel_vip_core.c b/drivers/gpu/drm/ivip/intel_vip_core.c
> new file mode 100644
> index 0000000..980f0f3
> --- /dev/null
> +++ b/drivers/gpu/drm/ivip/intel_vip_core.c
> @@ -0,0 +1,189 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 Intel Corporation.
> + *
> + * intel_vip_core.c -- Intel Video and Image Processing(VIP)
> + * Frame Buffer II driver
> + *
> + * This driver supports the Intel VIP Frame Reader component.
> + * More info on the hardware can be found in the Intel Video
> + * and Image Processing Suite User Guide at this address
> + * http://www.altera.com/literature/ug/ug_vip.pdf.
> + *
> + * Authors:
> + * Walter Goossens <waltergoossens@home.nl>
> + * Thomas Chou <thomas@wytron.com.tw>
> + * Chris Rauer <crauer@altera.com>
> + * Ong, Hean-Loong <hean.loong.ong@intel.com>
> + *
> + */
> +
> +#include <drm/drmP.h>
> +#include <drm/drm_atomic.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_crtc_helper.h>
> +#include <drm/drm_fb_helper.h>
> +#include <drm/drm_fb_cma_helper.h>
> +#include <drm/drm_gem_cma_helper.h>
> +#include <drm/drm_plane_helper.h>
> +#include <drm/drm_simple_kms_helper.h>
> +#include <drm/drm_gem_framebuffer_helper.h>
> +
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +
> +#include "intel_vip_drv.h"
> +
> +static inline struct intelvipfb_priv *
> +pipe_to_intelvipdrm(struct drm_simple_display_pipe *pipe)
> +{
> +	return container_of(pipe, struct intelvipfb_priv, pipe);
> +}
> +
> +static void intelvipfb_enable(struct drm_simple_display_pipe *pipe,
> +	       struct drm_crtc_state *crtc_state, struct drm_plane_state *
> +	       plane_state)
> +{
> +	/*
> +	 * The frameinfo variable has to correspond to the size of the VIP Suite
> +	 * Frame Reader register 7 which will determine the maximum size used
> +	 * in this frameinfo
> +	 */
> +
> +	u32 frameinfo;
> +	struct intelvipfb_priv *priv = pipe->plane.dev->dev_private;
> +	void __iomem *base = priv->base;
> +	struct drm_plane_state *state = pipe->plane.state;
> +	dma_addr_t addr;
> +
> +	addr = drm_fb_cma_get_gem_addr(state->fb, state, 0);
> +
> +	frameinfo =
> +		readl(base + INTELVIPFB_FRAME_READER) & 0x00ffffff;
> +	writel(frameinfo, base + INTELVIPFB_FRAME_INFO);
> +	writel(addr, base + INTELVIPFB_FRAME_START);
> +	/* Finally set the control register to 1 to start streaming */
> +	writel(1, base + INTELVIPFB_CONTROL);
> +}
> +
> +static void intelvipfb_disable(struct drm_simple_display_pipe *pipe)
> +{
> +	struct intelvipfb_priv *priv = pipe->plane.dev->dev_private;
> +	void __iomem *base = priv->base;
> +	/* set the control register to 0 to stop streaming */
> +	writel(0, base + INTELVIPFB_CONTROL);
> +}
> +
> +
> +static const struct drm_mode_config_funcs intelvipfb_mode_config_funcs = {
> +	.fb_create = drm_gem_fb_create,
> +	.atomic_check = drm_atomic_helper_check,
> +	.atomic_commit = drm_atomic_helper_commit,
> +};
> +
> +
> +static void intelvipfb_setup_mode_config(struct drm_device *drm)
> +{
> +	drm_mode_config_init(drm);
> +	drm->mode_config.funcs = &intelvipfb_mode_config_funcs;
> +}
> +
> +void intelvipfb_display_pipe_update(struct drm_simple_display_pipe *pipe,
> +				 struct drm_plane_state *old_state)
> +{
> +	struct intelvipfb_priv *fbpriv = pipe_to_intelvipdrm(pipe);
> +	struct drm_framebuffer *fb = pipe->plane.state->fb;
> +	struct drm_crtc *crtc = &fbpriv->pipe.crtc;
> +
> +	if (fb && (fb != old_state->fb)) {
> +		if (fbpriv->fb_dirty)
> +			fbpriv->fb_dirty(fb, NULL, 0, 0, NULL, 0);
> +	}
> +
> +	if (crtc->state->event) {
> +		spin_lock_irq(&crtc->dev->event_lock);
> +		drm_crtc_send_vblank_event(crtc, crtc->state->event);
> +		spin_unlock_irq(&crtc->dev->event_lock);
> +		crtc->state->event = NULL;
> +	}
> +}
> +EXPORT_SYMBOL(intelvipfb_display_pipe_update);
> +
> +static struct drm_simple_display_pipe_funcs fbpriv_funcs = {
> +	.prepare_fb = drm_gem_fb_simple_display_pipe_prepare_fb,
> +	.update = intelvipfb_display_pipe_update,
> +	.enable = intelvipfb_enable,
> +	.disable = intelvipfb_disable,
> +};
> +
> +
> +int intelvipfb_probe(struct device *dev)
> +{
> +	int retval;
> +	struct drm_device *drm;
> +	struct intelvipfb_priv *fbpriv = dev_get_drvdata(dev);
> +
> +	struct drm_connector *connector;
> +	u32 formats[] = {DRM_FORMAT_XRGB8888};
> +
> +	drm = fbpriv->drm;
> +
> +	drm->dev_private = fbpriv;
> +
> +	intelvipfb_setup_mode_config(drm);
> +
> +	connector = intelvipfb_conn_setup(drm);
> +	if (!connector) {
> +		dev_err(drm->dev, "Connector setup failed\n");
> +		goto err_mode_config;
> +	}
> +
> +	retval = drm_simple_display_pipe_init(drm,
> +			&fbpriv->pipe,
> +			&fbpriv_funcs,
> +			formats,
> +			ARRAY_SIZE(formats),
> +			NULL, connector);
> +
> +	if (retval < 0) {
> +		dev_err(drm->dev, "Cannot setup simple display pipe\n");
> +		goto err_mode_config;
> +	}
> +
> +	drm_mode_config_reset(drm);
> +
> +	drm_dev_register(drm, 0);
> +
> +	drm_fbdev_generic_setup(drm, 32);
> +
> +	dev_info(drm->dev, "ivip: Successfully created fb\n");
> +
> +	return retval;
> +
> +err_mode_config:
> +
> +	drm_mode_config_cleanup(drm);
> +	return -ENODEV;
> +}
> +
> +int intelvipfb_remove(struct device *dev)
> +{
> +	struct intelvipfb_priv *fbpriv = dev_get_drvdata(dev);
> +	struct drm_device *drm =  fbpriv->drm;
> +
> +	drm_dev_unregister(drm);
> +
> +	drm_mode_config_cleanup(drm);
> +
> +	return 0;
> +}
> +
> +/* Original author of Altera Frame Buffer*/
> +MODULE_AUTHOR("Walter Goossens <waltergoossens@home.nl>");
> +MODULE_AUTHOR("Thomas Chou <thomas@wytron.com.tw>");
> +MODULE_AUTHOR("Chris Rauer <crauer@altera.com>");
> +/* Author of Intel FPGA Frame Buffer II*/
> +MODULE_AUTHOR("Ong, Hean-Loong <hean.loong.ong@intel.com>");
> +MODULE_DESCRIPTION("Intel VIP Frame Buffer II driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/gpu/drm/ivip/intel_vip_drv.h b/drivers/gpu/drm/ivip/intel_vip_drv.h
> new file mode 100644
> index 0000000..c038f29
> --- /dev/null
> +++ b/drivers/gpu/drm/ivip/intel_vip_drv.h
> @@ -0,0 +1,73 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2019 Intel Corporation.
> + *
> + * Intel Video and Image Processing(VIP) Frame Buffer II driver.
> + * Frame Buffer II driver
> + *
> + * This driver supports the Intel VIP Frame Reader component.
> + * More info on the hardware can be found in the Intel Video
> + * and Image Processing Suite User Guide at this address
> + * http://www.altera.com/literature/ug/ug_vip.pdf.
> + *
> + * Authors:
> + * Walter Goossens <waltergoossens@home.nl>
> + * Thomas Chou <thomas@wytron.com.tw>
> + * Chris Rauer <crauer@altera.com>
> + * Ong, Hean-Loong <hean.loong.ong@intel.com>
> + *
> + */
> +#ifndef _INTEL_VIP_DRV_H
> +#define _INTEL_VIP_DRV_H
> +
> +#define DRIVER_NAME    "intelvipfb"
> +#define BYTES_PER_PIXEL	 4
> +#define CRTC_NUM	        1
> +#define CONN_NUM	        1
> +
> +/* control registers */
> +#define INTELVIPFB_CONTROL	      0
> +#define INTELVIPFB_STATUS	       0x4
> +#define INTELVIPFB_INTERRUPT	    0x8
> +#define INTELVIPFB_FRAME_COUNTER	0xC
> +#define INTELVIPFB_FRAME_DROP	   0x10
> +#define INTELVIPFB_FRAME_INFO	   0x14
> +#define INTELVIPFB_FRAME_START	  0x18
> +#define INTELVIPFB_FRAME_READER	         0x1C
> +
> +int intelvipfb_probe(struct device *dev);
> +int intelvipfb_remove(struct device *dev);
> +int intelvipfb_setup_crtc(struct drm_device *drm);
> +struct drm_connector *intelvipfb_conn_setup(struct drm_device *drm);
> +
> +struct intelvipfb_priv {
> +	/**
> +	 * @pipe: Display pipe structure
> +	 */
> +	struct drm_simple_display_pipe pipe;
> +
> +	/**
> +	 * @drm: DRM device
> +	 */
> +	struct drm_device *drm;
> +
> +	/**
> +	 * @dirty_lock: Serializes framebuffer flushing
> +	 */
> +	struct mutex dirty_lock;
> +
> +	/**
> +	 * @base: Base memory for the framebuffer
> +	 */
> +	void    __iomem *base;
> +
> +	/**
> +	 * @fb_dirty: Framebuffer dirty callback
> +	 */
> +	int (*fb_dirty)(struct drm_framebuffer *framebuffer,
> +		struct drm_file *file_priv, unsigned int flags,
> +		unsigned int color, struct drm_clip_rect *clips,
> +		unsigned int num_clips);
> +};
> +
> +#endif
> diff --git a/drivers/gpu/drm/ivip/intel_vip_of.c b/drivers/gpu/drm/ivip/intel_vip_of.c
> new file mode 100644
> index 0000000..c899e30
> --- /dev/null
> +++ b/drivers/gpu/drm/ivip/intel_vip_of.c
> @@ -0,0 +1,181 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 Intel Corporation.
> + *
> + * intel_vip_of.c -- Intel Video and Image Processing(VIP)
> + * Frame Buffer II driver
> + *
> + * This driver supports the Intel VIP Frame Reader component.
> + * More info on the hardware can be found in the Intel Video
> + * and Image Processing Suite User Guide at this address
> + * http://www.altera.com/literature/ug/ug_vip.pdf.
> + *
> + * Authors:
> + * Ong, Hean-Loong <hean.loong.ong@intel.com>
> + *
> + */
> +#include <drm/drmP.h>
> +#include <drm/drm_drv.h>
> +#include <drm/drm_fb_helper.h>
> +#include <drm/drm_fb_cma_helper.h>
> +#include <drm/drm_gem_cma_helper.h>
> +#include <drm/drm_of.h>
> +#include <drm/drm_simple_kms_helper.h>
> +
> +#include <linux/component.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#include "intel_vip_drv.h"
> +
> +DEFINE_DRM_GEM_CMA_FOPS(drm_fops);
> +
> +static struct drm_driver intelvipfb_drm = {
> +	.driver_features =
> +			DRIVER_MODESET | DRIVER_GEM |
> +			DRIVER_PRIME | DRIVER_ATOMIC,
> +	.gem_free_object_unlocked = drm_gem_cma_free_object,
> +	.gem_vm_ops = &drm_gem_cma_vm_ops,
> +	.dumb_create = drm_gem_cma_dumb_create,
> +	.dumb_destroy = drm_gem_dumb_destroy,
> +	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
> +	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
> +	.gem_prime_export = drm_gem_prime_export,
> +	.gem_prime_import = drm_gem_prime_import,
> +	.gem_prime_get_sg_table = drm_gem_cma_prime_get_sg_table,
> +	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
> +	.gem_prime_vmap = drm_gem_cma_prime_vmap,
> +	.gem_prime_vunmap = drm_gem_cma_prime_vunmap,
> +	.gem_prime_mmap = drm_gem_cma_prime_mmap,
> +	.name = DRIVER_NAME,
> +	.date = "20190129",
> +	.desc = "Intel FPGA VIP SUITE",
> +	.major = 1,
> +	.minor = 0,
> +	.ioctls = NULL,
> +	.patchlevel = 0,
> +	.fops = &drm_fops,
> +};
> +
> +/*
> + * Setting up information derived from OF Device Tree Nodes
> + * max-width, max-height, bits per pixel, memory port width
> + */
> +
> +static int intelvipfb_drm_setup(struct device *dev,
> +					struct intelvipfb_priv *fbpriv)
> +{
> +	struct drm_device *drm = fbpriv->drm;
> +	struct device_node *np = dev->of_node;
> +	int mem_word_width;
> +	int max_h, max_w;
> +	int ret;
> +
> +	ret = of_property_read_u32(np, "altr,max-width", &max_w);
> +	if (ret) {
> +		dev_err(dev,
> +			"Missing required parameter 'altr,max-width'");
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32(np, "altr,max-height", &max_h);
> +	if (ret) {
> +		dev_err(dev,
> +			"Missing required parameter 'altr,max-height'");
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32(np, "altr,mem-port-width", &mem_word_width);
> +	if (ret) {
> +		dev_err(dev, "Missing required parameter 'altr,mem-port-width '");
> +		return ret;
> +	}
> +
> +	if (!(mem_word_width >= 32 && mem_word_width % 32 == 0)) {
> +		dev_err(dev,
> +			"mem-word-width is set to %i. must be >= 32 and multiple of 32.",
> +			 mem_word_width);
> +		return -ENODEV;
> +	}
> +
> +	drm->mode_config.min_width = 640;
> +	drm->mode_config.min_height = 480;
> +	drm->mode_config.max_width = max_w;
> +	drm->mode_config.max_height = max_h;
> +	drm->mode_config.preferred_depth = 32;
> +
> +	return 0;
> +}
> +
> +static int intelvipfb_of_probe(struct platform_device *pdev)
> +{
> +	int retval;
> +	struct resource *reg_res;
> +	struct intelvipfb_priv *fbpriv;
> +	struct device *dev = &pdev->dev;
> +	struct drm_device *drm;
> +
> +	fbpriv = devm_kzalloc(dev, sizeof(*fbpriv), GFP_KERNEL);
> +	if (!fbpriv)
> +		return -ENOMEM;
> +
> +	/*setup DRM */
> +	drm = drm_dev_alloc(&intelvipfb_drm, dev);
> +	if (IS_ERR(drm))
> +		return PTR_ERR(drm);
> +
> +	retval = dma_set_mask_and_coherent(drm->dev, DMA_BIT_MASK(32));
> +	if (retval)
> +		return -ENODEV;
> +
> +	fbpriv->drm = drm;
> +
> +	reg_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!reg_res)
> +		return -ENOMEM;
> +
> +	fbpriv->base = devm_ioremap_resource(dev, reg_res);
> +
> +	if (IS_ERR(fbpriv->base)) {
> +		dev_err(dev, "devm_ioremap_resource failed\n");
> +		retval = PTR_ERR(fbpriv->base);
> +		return -ENOMEM;
> +	}
> +
> +	intelvipfb_drm_setup(dev, fbpriv);
> +
> +	dev_set_drvdata(dev, fbpriv);
> +
> +	return intelvipfb_probe(dev);
> +}
> +
> +static int intelvipfb_of_remove(struct platform_device *pdev)
> +{
> +	return intelvipfb_remove(&pdev->dev);
> +}
> +
> +/*
> + * The name vip-frame-buffer-2.0 is derived from
> + * http://www.altera.com/literature/ug/ug_vip.pdf
> + * frame buffer IP cores section 14
> + */
> +
> +static const struct of_device_id intelvipfb_of_match[] = {
> +	{ .compatible = "altr,vip-frame-buffer-2.0" },
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, intelvipfb_of_match);
> +
> +static struct platform_driver intelvipfb_driver = {
> +	.probe = intelvipfb_of_probe,
> +	.remove = intelvipfb_of_remove,
> +	.driver = {
> +		.name = DRIVER_NAME,
> +		.of_match_table = intelvipfb_of_match,
> +	},
> +};
> +
> +module_platform_driver(intelvipfb_driver);
> -- 
> 1.7.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
