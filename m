Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B635EC2D0C4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7772920663
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="cx+Bk3PJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfLJKlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 05:41:06 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42991 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfLJKlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 05:41:06 -0500
Received: by mail-wr1-f65.google.com with SMTP id a15so19397872wrf.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 02:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fqkWdNku1hAcCowu0r3i1TnQqpHLnWO996JHll0UTvQ=;
        b=cx+Bk3PJF76GNX4Ii9zWiWE39O4tVWj7ziwhGy+v3PFguOWqhfpiSFJvJIJd12Skz6
         yEngv42f7iGZngglWa6VE48am3JUp30VJjaEWNT34lytYHM0r5qtPMB6BWCTACqnejVq
         8xuApBnt+J+P/MbzoVLPjo7Q/gWpaqCEKQPng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=fqkWdNku1hAcCowu0r3i1TnQqpHLnWO996JHll0UTvQ=;
        b=HrIoAFjsZl35DZuryfuYiJSVAYr5LVBZCPP3jQ0wSqeR5NkU0aI3F9aaSeW9Us/jr0
         aFNv93OOdVG69Fe2iRj/9zTrZKi5sz/8O8ERtOWc7VbCAOwU5l5BnABQtmpNN/7NOSwa
         0OqsegNcwy1+C1cpDXP93tJjAdHxYTUBI/SgXxxgk4UbWyrNnWWW+Ml44xvpix7l2O1z
         8ACNPSCjUFKgLJcn2zAb/teortXQ8VgKbRtxYu0AbdVhcg+hEV9O/XJzDAU+mZn1PXZk
         p9vgnD1lyze9Yc3qcGOW8f0hz56MmMh9KWIMq8TrDR5Gke8/wjCSAtSmUPRJikO1yJsa
         LjsA==
X-Gm-Message-State: APjAAAWNhcFwa1/s8GCxZMWcpSAlfA1qeGzlPDzYPrWkBmi/aVjSZw2T
        5C1LePsnF3cFx7O2PzYdciHvZ28m1ZA=
X-Google-Smtp-Source: APXvYqyseSWGbET5K9v9aEUhYXj0p1Fe+eQ8/mqecqZ81egqIvcoIhygS70IeQ1qn7vwpXsao+76Kw==
X-Received: by 2002:adf:f6c1:: with SMTP id y1mr2585915wrp.17.1575974462959;
        Tue, 10 Dec 2019 02:41:02 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:564b:0:7567:bb67:3d7f:f863])
        by smtp.gmail.com with ESMTPSA id p26sm1531611wmc.24.2019.12.10.02.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 02:41:02 -0800 (PST)
Date:   Tue, 10 Dec 2019 11:41:00 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Kevin Tang <kevin3.tang@gmail.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, orsonzhai@gmail.com,
        baolin.wang@linaro.org, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH RFC 2/8] drm/sprd: add Unisoc's drm kms master
Message-ID: <20191210104100.GU624164@phenom.ffwll.local>
Mail-Followup-To: Kevin Tang <kevin3.tang@gmail.com>, airlied@linux.ie,
        orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <1575966995-13757-1-git-send-email-kevin3.tang@gmail.com>
 <1575966995-13757-3-git-send-email-kevin3.tang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575966995-13757-3-git-send-email-kevin3.tang@gmail.com>
X-Operating-System: Linux phenom 5.3.0-2-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 04:36:29PM +0800, Kevin Tang wrote:
> From: Kevin Tang <kevin.tang@unisoc.com>
> 
> Adds drm support for the Unisoc's display subsystem.
> 
> This is drm device and gem driver. This driver provides support for the
> Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
> 
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Baolin Wang <baolin.wang@linaro.org>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
> ---
>  drivers/gpu/drm/Kconfig         |   2 +
>  drivers/gpu/drm/Makefile        |   1 +
>  drivers/gpu/drm/sprd/Kconfig    |  14 ++
>  drivers/gpu/drm/sprd/Makefile   |   8 ++
>  drivers/gpu/drm/sprd/sprd_drm.c | 287 ++++++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/sprd/sprd_drm.h |  19 +++
>  drivers/gpu/drm/sprd/sprd_gem.c | 178 +++++++++++++++++++++++++
>  drivers/gpu/drm/sprd/sprd_gem.h |  30 +++++
>  8 files changed, 539 insertions(+)
>  create mode 100644 drivers/gpu/drm/sprd/Kconfig
>  create mode 100644 drivers/gpu/drm/sprd/Makefile
>  create mode 100644 drivers/gpu/drm/sprd/sprd_drm.c
>  create mode 100644 drivers/gpu/drm/sprd/sprd_drm.h
>  create mode 100644 drivers/gpu/drm/sprd/sprd_gem.c
>  create mode 100644 drivers/gpu/drm/sprd/sprd_gem.h
> 
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index bfdadc3..cead12c 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -387,6 +387,8 @@ source "drivers/gpu/drm/aspeed/Kconfig"
>  
>  source "drivers/gpu/drm/mcde/Kconfig"
>  
> +source "drivers/gpu/drm/sprd/Kconfig"
> +
>  # Keep legacy drivers last
>  
>  menuconfig DRM_LEGACY
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index 9f1c7c4..85ca211 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -122,3 +122,4 @@ obj-$(CONFIG_DRM_LIMA)  += lima/
>  obj-$(CONFIG_DRM_PANFROST) += panfrost/
>  obj-$(CONFIG_DRM_ASPEED_GFX) += aspeed/
>  obj-$(CONFIG_DRM_MCDE) += mcde/
> +obj-$(CONFIG_DRM_SPRD) += sprd/
> diff --git a/drivers/gpu/drm/sprd/Kconfig b/drivers/gpu/drm/sprd/Kconfig
> new file mode 100644
> index 0000000..79f286b
> --- /dev/null
> +++ b/drivers/gpu/drm/sprd/Kconfig
> @@ -0,0 +1,14 @@
> +config DRM_SPRD
> +	tristate "DRM Support for Unisoc SoCs Platform"
> +	depends on ARCH_SPRD
> +	depends on DRM && OF
> +	select DRM_KMS_HELPER
> +	select DRM_GEM_CMA_HELPER
> +	select DRM_KMS_CMA_HELPER
> +	select DRM_MIPI_DSI
> +	select DRM_PANEL
> +	select VIDEOMODE_HELPERS
> +	select BACKLIGHT_CLASS_DEVICE
> +	help
> +	  Choose this option if you have a Unisoc chipsets.
> +	  If M is selected the module will be called sprd-drm.
> \ No newline at end of file
> diff --git a/drivers/gpu/drm/sprd/Makefile b/drivers/gpu/drm/sprd/Makefile
> new file mode 100644
> index 0000000..df0b316
> --- /dev/null
> +++ b/drivers/gpu/drm/sprd/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +ccflags-y += -Iinclude/drm
> +
> +subdir-ccflags-y += -I$(src)
> +
> +obj-y := sprd_drm.o \
> +	sprd_gem.o
> \ No newline at end of file
> diff --git a/drivers/gpu/drm/sprd/sprd_drm.c b/drivers/gpu/drm/sprd/sprd_drm.c
> new file mode 100644
> index 0000000..ec16fee
> --- /dev/null
> +++ b/drivers/gpu/drm/sprd/sprd_drm.c
> @@ -0,0 +1,287 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 Unisoc Inc.
> + */
> +
> +#include <linux/component.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of_graph.h>
> +#include <linux/of_platform.h>
> +
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_crtc_helper.h>
> +#include <drm/drm_drv.h>
> +#include <drm/drm_gem_cma_helper.h>
> +#include <drm/drm_gem_framebuffer_helper.h>
> +#include <drm/drm_probe_helper.h>
> +#include <drm/drm_vblank.h>
> +
> +#include "sprd_drm.h"
> +#include "sprd_gem.h"
> +
> +#define DRIVER_NAME	"sprd"
> +#define DRIVER_DESC	"Spreadtrum SoCs' DRM Driver"
> +#define DRIVER_DATE	"20180501"
> +#define DRIVER_MAJOR	1
> +#define DRIVER_MINOR	0
> +
> +static const struct drm_mode_config_helper_funcs sprd_drm_mode_config_helper = {
> +	.atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
> +};
> +
> +static const struct drm_mode_config_funcs sprd_drm_mode_config_funcs = {
> +	.fb_create = drm_gem_fb_create,
> +	.atomic_check = drm_atomic_helper_check,
> +	.atomic_commit = drm_atomic_helper_commit,
> +};
> +
> +static void sprd_drm_mode_config_init(struct drm_device *drm)
> +{
> +	drm_mode_config_init(drm);
> +
> +	drm->mode_config.min_width = 0;
> +	drm->mode_config.min_height = 0;
> +	drm->mode_config.max_width = 8192;
> +	drm->mode_config.max_height = 8192;
> +	drm->mode_config.allow_fb_modifiers = true;
> +
> +	drm->mode_config.funcs = &sprd_drm_mode_config_funcs;
> +	drm->mode_config.helper_private = &sprd_drm_mode_config_helper;
> +}
> +
> +static const struct file_operations sprd_drm_fops = {
> +	.owner		= THIS_MODULE,
> +	.open		= drm_open,
> +	.release	= drm_release,
> +	.unlocked_ioctl	= drm_ioctl,
> +	.compat_ioctl	= drm_compat_ioctl,
> +	.poll		= drm_poll,
> +	.read		= drm_read,
> +	.llseek		= no_llseek,
> +	.mmap		= sprd_gem_cma_mmap,
> +};
> +
> +static struct drm_driver sprd_drm_drv = {
> +	.driver_features	= DRIVER_GEM | DRIVER_MODESET |
> +				  DRIVER_ATOMIC | DRIVER_HAVE_IRQ,

DRIVER_HAVE_IRQ only does something for pci drivers, please remove this.

Just a quick drive-by, I didn't read through your driver really.
-Daniel

> +	.fops			= &sprd_drm_fops,
> +
> +	.gem_vm_ops		= &drm_gem_cma_vm_ops,
> +	.gem_free_object_unlocked	= sprd_gem_free_object,
> +	.dumb_create		= sprd_gem_cma_dumb_create,
> +
> +	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle,
> +	.gem_prime_import	= drm_gem_prime_import,
> +	.gem_prime_import_sg_table = sprd_gem_prime_import_sg_table,
> +
> +	.name			= DRIVER_NAME,
> +	.desc			= DRIVER_DESC,
> +	.date			= DRIVER_DATE,
> +	.major			= DRIVER_MAJOR,
> +	.minor			= DRIVER_MINOR,
> +};
> +
> +static int sprd_drm_bind(struct device *dev)
> +{
> +	struct drm_device *drm;
> +	struct sprd_drm *sprd;
> +	int err;
> +
> +	drm = drm_dev_alloc(&sprd_drm_drv, dev);
> +	if (IS_ERR(drm))
> +		return PTR_ERR(drm);
> +
> +	dev_set_drvdata(dev, drm);
> +
> +	sprd = devm_kzalloc(drm->dev, sizeof(*sprd), GFP_KERNEL);
> +	if (!sprd) {
> +		err = -ENOMEM;
> +		goto err_free_drm;
> +	}
> +	drm->dev_private = sprd;
> +
> +	sprd_drm_mode_config_init(drm);
> +
> +	/* bind and init sub drivers */
> +	err = component_bind_all(drm->dev, drm);
> +	if (err) {
> +		DRM_ERROR("failed to bind all component.\n");
> +		goto err_dc_cleanup;
> +	}
> +
> +	/* vblank init */
> +	err = drm_vblank_init(drm, drm->mode_config.num_crtc);
> +	if (err) {
> +		DRM_ERROR("failed to initialize vblank.\n");
> +		goto err_unbind_all;
> +	}
> +	/* with irq_enabled = true, we can use the vblank feature. */
> +	drm->irq_enabled = true;
> +
> +	/* reset all the states of crtc/plane/encoder/connector */
> +	drm_mode_config_reset(drm);
> +
> +	/* init kms poll for handling hpd */
> +	drm_kms_helper_poll_init(drm);
> +
> +	err = drm_dev_register(drm, 0);
> +	if (err < 0)
> +		goto err_kms_helper_poll_fini;
> +
> +	return 0;
> +
> +err_kms_helper_poll_fini:
> +	drm_kms_helper_poll_fini(drm);
> +err_unbind_all:
> +	component_unbind_all(drm->dev, drm);
> +err_dc_cleanup:
> +	drm_mode_config_cleanup(drm);
> +err_free_drm:
> +	drm_dev_put(drm);
> +	return err;
> +}
> +
> +static void sprd_drm_unbind(struct device *dev)
> +{
> +	drm_put_dev(dev_get_drvdata(dev));
> +}
> +
> +static const struct component_master_ops sprd_drm_component_ops = {
> +	.bind = sprd_drm_bind,
> +	.unbind = sprd_drm_unbind,
> +};
> +
> +static int compare_of(struct device *dev, void *data)
> +{
> +	struct device_node *np = data;
> +
> +	DRM_DEBUG("compare %s\n", np->full_name);
> +
> +	return dev->of_node == np;
> +}
> +
> +static int sprd_drm_component_probe(struct device *dev,
> +			   const struct component_master_ops *m_ops)
> +{
> +	struct device_node *ep, *port, *remote;
> +	struct component_match *match = NULL;
> +	int i;
> +
> +	if (!dev->of_node)
> +		return -EINVAL;
> +
> +	/*
> +	 * Bind the crtc's ports first, so that drm_of_find_possible_crtcs()
> +	 * called from encoder's .bind callbacks works as expected
> +	 */
> +	for (i = 0; ; i++) {
> +		port = of_parse_phandle(dev->of_node, "ports", i);
> +		if (!port)
> +			break;
> +
> +		if (!of_device_is_available(port->parent)) {
> +			of_node_put(port);
> +			continue;
> +		}
> +
> +		component_match_add(dev, &match, compare_of, port->parent);
> +		of_node_put(port);
> +	}
> +
> +	if (i == 0) {
> +		dev_err(dev, "missing 'ports' property\n");
> +		return -ENODEV;
> +	}
> +
> +	if (!match) {
> +		dev_err(dev, "no available port\n");
> +		return -ENODEV;
> +	}
> +
> +	/*
> +	 * For bound crtcs, bind the encoders attached to their remote endpoint
> +	 */
> +	for (i = 0; ; i++) {
> +		port = of_parse_phandle(dev->of_node, "ports", i);
> +		if (!port)
> +			break;
> +
> +		if (!of_device_is_available(port->parent)) {
> +			of_node_put(port);
> +			continue;
> +		}
> +
> +		for_each_child_of_node(port, ep) {
> +			remote = of_graph_get_remote_port_parent(ep);
> +			if (!remote || !of_device_is_available(remote)) {
> +				of_node_put(remote);
> +				continue;
> +			} else if (!of_device_is_available(remote->parent)) {
> +				dev_warn(dev, "parent device of %s is not available\n",
> +					 remote->full_name);
> +				of_node_put(remote);
> +				continue;
> +			}
> +
> +			component_match_add(dev, &match, compare_of, remote);
> +			of_node_put(remote);
> +		}
> +		of_node_put(port);
> +	}
> +
> +	return component_master_add_with_match(dev, m_ops, match);
> +}
> +
> +static int sprd_drm_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +
> +	ret = dma_set_mask_and_coherent(&pdev->dev, ~0);
> +	if (ret)
> +		DRM_ERROR("dma_set_mask_and_coherent failed (%d)\n", ret);
> +
> +	return sprd_drm_component_probe(&pdev->dev, &sprd_drm_component_ops);
> +}
> +
> +static int sprd_drm_remove(struct platform_device *pdev)
> +{
> +	component_master_del(&pdev->dev, &sprd_drm_component_ops);
> +	return 0;
> +}
> +
> +static void sprd_drm_shutdown(struct platform_device *pdev)
> +{
> +	struct drm_device *drm = platform_get_drvdata(pdev);
> +
> +	if (!drm) {
> +		DRM_WARN("drm device is not available, no shutdown\n");
> +		return;
> +	}
> +
> +	drm_atomic_helper_shutdown(drm);
> +}
> +
> +static const struct of_device_id sprd_drm_match_table[] = {
> +	{ .compatible = "sprd,display-subsystem",},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, sprd_drm_match_table);
> +
> +static struct platform_driver sprd_drm_driver = {
> +	.probe = sprd_drm_probe,
> +	.remove = sprd_drm_remove,
> +	.shutdown = sprd_drm_shutdown,
> +	.driver = {
> +		.name = "sprd-drm-drv",
> +		.of_match_table = sprd_drm_match_table,
> +	},
> +};
> +
> +module_platform_driver(sprd_drm_driver);
> +
> +MODULE_AUTHOR("Leon He <leon.he@unisoc.com>");
> +MODULE_AUTHOR("Kevin Tang <kevin.tang@unisoc.com>");
> +MODULE_DESCRIPTION("Unisoc DRM KMS Master Driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/gpu/drm/sprd/sprd_drm.h b/drivers/gpu/drm/sprd/sprd_drm.h
> new file mode 100644
> index 0000000..e840e65
> --- /dev/null
> +++ b/drivers/gpu/drm/sprd/sprd_drm.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2019 Unisoc Inc.
> + */
> +
> +#ifndef _SPRD_DRM_H_
> +#define _SPRD_DRM_H_
> +
> +#include <drm/drm_atomic.h>
> +#include <drm/drm_print.h>
> +
> +struct sprd_drm {
> +	struct drm_device *drm;
> +	struct drm_atomic_state *state;
> +	struct device *dpu_dev;
> +	struct device *gsp_dev;
> +};
> +
> +#endif /* _SPRD_DRM_H_ */
> diff --git a/drivers/gpu/drm/sprd/sprd_gem.c b/drivers/gpu/drm/sprd/sprd_gem.c
> new file mode 100644
> index 0000000..c617c8b
> --- /dev/null
> +++ b/drivers/gpu/drm/sprd/sprd_gem.c
> @@ -0,0 +1,178 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 Unisoc Inc.
> + */
> +
> +#include <linux/dma-buf.h>
> +#include <linux/pm_runtime.h>
> +
> +#include <drm/drm_prime.h>
> +
> +#include "sprd_drm.h"
> +#include "sprd_gem.h"
> +
> +static struct sprd_gem_obj *sprd_gem_obj_create(struct drm_device *drm,
> +						unsigned long size)
> +{
> +	struct sprd_gem_obj *sprd_gem;
> +	int ret;
> +
> +	sprd_gem = kzalloc(sizeof(*sprd_gem), GFP_KERNEL);
> +	if (!sprd_gem)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = drm_gem_object_init(drm, &sprd_gem->base, size);
> +	if (ret < 0) {
> +		DRM_ERROR("failed to initialize gem object\n");
> +		goto error;
> +	}
> +
> +	ret = drm_gem_create_mmap_offset(&sprd_gem->base);
> +	if (ret) {
> +		drm_gem_object_release(&sprd_gem->base);
> +		goto error;
> +	}
> +
> +	return sprd_gem;
> +
> +error:
> +	kfree(sprd_gem);
> +	return ERR_PTR(ret);
> +}
> +
> +void sprd_gem_free_object(struct drm_gem_object *obj)
> +{
> +	struct sprd_gem_obj *sprd_gem = to_sprd_gem_obj(obj);
> +
> +	DRM_DEBUG("gem = %p\n", obj);
> +
> +	if (sprd_gem->vaddr)
> +		dma_alloc_wc(obj->dev->dev, obj->size,
> +				      sprd_gem->vaddr, sprd_gem->dma_addr);
> +	else if (sprd_gem->sgtb)
> +		drm_prime_gem_destroy(obj, sprd_gem->sgtb);
> +
> +	drm_gem_object_release(obj);
> +
> +	kfree(sprd_gem);
> +}
> +
> +int sprd_gem_cma_dumb_create(struct drm_file *file_priv, struct drm_device *drm,
> +			    struct drm_mode_create_dumb *args)
> +{
> +	struct sprd_gem_obj *sprd_gem;
> +	int ret;
> +
> +	args->pitch = DIV_ROUND_UP(args->width * args->bpp, 8);
> +	args->size = round_up(args->pitch * args->height, PAGE_SIZE);
> +
> +	sprd_gem = sprd_gem_obj_create(drm, args->size);
> +	if (IS_ERR(sprd_gem))
> +		return PTR_ERR(sprd_gem);
> +
> +	sprd_gem->vaddr = dma_alloc_wc(drm->dev, args->size,
> +			&sprd_gem->dma_addr, GFP_KERNEL | __GFP_NOWARN | GFP_DMA);
> +	if (!sprd_gem->vaddr) {
> +		DRM_ERROR("failed to allocate buffer with size %llu\n",
> +			  args->size);
> +		ret = -ENOMEM;
> +		goto error;
> +	}
> +
> +	ret = drm_gem_handle_create(file_priv, &sprd_gem->base, &args->handle);
> +	if (ret)
> +		goto error;
> +
> +	drm_gem_object_put_unlocked(&sprd_gem->base);
> +
> +	return 0;
> +
> +error:
> +	sprd_gem_free_object(&sprd_gem->base);
> +	return ret;
> +}
> +
> +static int sprd_gem_cma_object_mmap(struct drm_gem_object *obj,
> +				   struct vm_area_struct *vma)
> +
> +{
> +	int ret;
> +	struct sprd_gem_obj *sprd_gem = to_sprd_gem_obj(obj);
> +
> +	vma->vm_flags &= ~VM_PFNMAP;
> +	vma->vm_pgoff = 0;
> +
> +	ret = dma_mmap_wc(obj->dev->dev, vma,
> +				    sprd_gem->vaddr, sprd_gem->dma_addr,
> +				    vma->vm_end - vma->vm_start);
> +	if (ret)
> +		drm_gem_vm_close(vma);
> +
> +	return ret;
> +}
> +
> +int sprd_gem_cma_mmap(struct file *filp, struct vm_area_struct *vma)
> +{
> +	struct drm_gem_object *obj;
> +	int ret;
> +
> +	ret = drm_gem_mmap(filp, vma);
> +	if (ret)
> +		return ret;
> +
> +	obj = vma->vm_private_data;
> +
> +	return sprd_gem_cma_object_mmap(obj, vma);
> +}
> +
> +int sprd_gem_cma_prime_mmap(struct drm_gem_object *obj,
> +			    struct vm_area_struct *vma)
> +{
> +	int ret;
> +
> +	ret = drm_gem_mmap_obj(obj, obj->size, vma);
> +	if (ret)
> +		return ret;
> +
> +	return sprd_gem_cma_object_mmap(obj, vma);
> +}
> +
> +struct sg_table *sprd_gem_cma_prime_get_sg_table(struct drm_gem_object *obj)
> +{
> +	struct sprd_gem_obj *sprd_gem = to_sprd_gem_obj(obj);
> +	struct sg_table *sgtb;
> +	int ret;
> +
> +	sgtb = kzalloc(sizeof(*sgtb), GFP_KERNEL);
> +	if (!sgtb)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = dma_get_sgtable(obj->dev->dev, sgtb, sprd_gem->vaddr,
> +			      sprd_gem->dma_addr, obj->size);
> +	if (ret) {
> +		DRM_ERROR("failed to allocate sg_table, %d\n", ret);
> +		kfree(sgtb);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return sgtb;
> +}
> +
> +struct drm_gem_object *sprd_gem_prime_import_sg_table(struct drm_device *drm,
> +		struct dma_buf_attachment *attach, struct sg_table *sgtb)
> +{
> +	struct sprd_gem_obj *sprd_gem;
> +
> +	sprd_gem = sprd_gem_obj_create(drm, attach->dmabuf->size);
> +	if (IS_ERR(sprd_gem))
> +		return ERR_CAST(sprd_gem);
> +
> +	DRM_DEBUG("gem = %p\n", &sprd_gem->base);
> +
> +	if (sgtb->nents == 1)
> +		sprd_gem->dma_addr = sg_dma_address(sgtb->sgl);
> +
> +	sprd_gem->sgtb = sgtb;
> +
> +	return &sprd_gem->base;
> +}
> diff --git a/drivers/gpu/drm/sprd/sprd_gem.h b/drivers/gpu/drm/sprd/sprd_gem.h
> new file mode 100644
> index 0000000..4c10d8a
> --- /dev/null
> +++ b/drivers/gpu/drm/sprd/sprd_gem.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2019 Unisoc Inc.
> + */
> +
> +#ifndef _SPRD_GEM_H_
> +#define _SPRD_GEM_H_
> +
> +#include <drm/drm_gem.h>
> +
> +struct sprd_gem_obj {
> +	struct drm_gem_object	base;
> +	dma_addr_t		dma_addr;
> +	struct sg_table		*sgtb;
> +	void			*vaddr;
> +};
> +
> +#define to_sprd_gem_obj(x)	container_of(x, struct sprd_gem_obj, base)
> +
> +void sprd_gem_free_object(struct drm_gem_object *gem);
> +int sprd_gem_cma_dumb_create(struct drm_file *file_priv, struct drm_device *dev,
> +			    struct drm_mode_create_dumb *args);
> +int sprd_gem_cma_mmap(struct file *filp, struct vm_area_struct *vma);
> +int sprd_gem_cma_prime_mmap(struct drm_gem_object *obj,
> +			 struct vm_area_struct *vma);
> +struct sg_table *sprd_gem_cma_prime_get_sg_table(struct drm_gem_object *obj);
> +struct drm_gem_object *sprd_gem_prime_import_sg_table(struct drm_device *dev,
> +		struct dma_buf_attachment *attach, struct sg_table *sgtb);
> +
> +#endif
> -- 
> 2.7.4
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
