Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286A1C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 16:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33522077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 16:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXhUHm6e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfLJQIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 11:08:09 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40049 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbfLJQIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 11:08:09 -0500
Received: by mail-vs1-f65.google.com with SMTP id g23so13429981vsr.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 08:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rd/M1jiw0bt7SsTtI3ZjdMOpbgNyyyrt/v3LP3zJjyA=;
        b=LXhUHm6ees0V0daVV3GQg9YAcoUDnJGJR5XPnfgQTLm7CmZ0Okb7xp1ztsvHD7ZbIv
         ExwTnZquC2H2l8T0Am5u0xrerj9gjBxgEcYku5ZL2brd0iY3ErVBqq3K7+tErHtH/n+8
         YOxAcV64D4NP87dYnMko+2GcXDHaGESpDGDsyn15tyiyFgNyQt5jb2qvECazs3RC8ITr
         f8JhZe414FVdLb2sU00OqyPe+TM3vNpwgsBgDWzN43Lb1Bqj9gnqR0Xn+zEo5A/dhz4m
         V/l8DQJaaBTQFmnFWE0rZGFkeTbOdTky8VSpJKeF04+15zWxiJrNdxIlIQmFKeHieKm4
         SrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rd/M1jiw0bt7SsTtI3ZjdMOpbgNyyyrt/v3LP3zJjyA=;
        b=lB3i3QdnCRPGJcT3IU1GpUWbingIe0OyXvrMedusOwjLZjuprNliLURxPRnQEPDTjA
         HZBYQz65ZzjFes53L+NTw1qRVprAyyewfX1TsGDjq65jcsIEIpZxOT63tRkTaz5a1kmw
         uAYM+6Dd5qDvZ706ujQGsWfEMsm6/sVfdMya0ZsjVqi2HmUyMbFOksk81rosUnIwyFHv
         S1dHb3NbrPbXJlHmFooHlGgbFaFvg/P/kytvZTmfdZ0jtG85plA/jEFhF0HbKA3+3oGz
         Rk70CECA3/TaCGKbfgNuD6HfuXD1Vas479CeIQIdFzdTKEh6198JNJrEbSGxAE3VL5M2
         /mGw==
X-Gm-Message-State: APjAAAUri22tnSfd2AnSW74CsSgyOZEW+F6XYe/blAYEAh0n6GsyXi+e
        wPnG59PTAFGPcTNao/7+dVlmk/QzvzPdnmCkfDA=
X-Google-Smtp-Source: APXvYqzXUcVL7ay7dzMEdK34LEth1oxt2wC88iEyUDWeYkDCjpAhFxfaBz0vmF+f9wnrE9NhZohviL0n9DQi6jo5fz4=
X-Received: by 2002:a67:e205:: with SMTP id g5mr16607588vsa.186.1575994087596;
 Tue, 10 Dec 2019 08:08:07 -0800 (PST)
MIME-Version: 1.0
References: <1575966995-13757-1-git-send-email-kevin3.tang@gmail.com> <1575966995-13757-3-git-send-email-kevin3.tang@gmail.com>
In-Reply-To: <1575966995-13757-3-git-send-email-kevin3.tang@gmail.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Tue, 10 Dec 2019 16:06:53 +0000
Message-ID: <CACvgo50K=43OHW33i8ZsMG3QvuVxLZSo0iBMSt0Z-X4N2eTObw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/8] drm/sprd: add Unisoc's drm kms master
To:     Kevin Tang <kevin3.tang@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        orsonzhai@gmail.com,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        zhang.lyra@gmail.com, baolin.wang@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Welcome to DRM Kevin,

On Tue, 10 Dec 2019 at 08:40, Kevin Tang <kevin3.tang@gmail.com> wrote:
>
> From: Kevin Tang <kevin.tang@unisoc.com>
>
> Adds drm support for the Unisoc's display subsystem.
>
> This is drm device and gem driver. This driver provides support for the
> Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
>
Did you use XFree86 or Xorg to test this? The XFree86 codebase have been
missing for years.

Out of curiosity - did you try any Wayland, or bare-metal compositor?

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
> +       tristate "DRM Support for Unisoc SoCs Platform"
> +       depends on ARCH_SPRD
> +       depends on DRM && OF
> +       select DRM_KMS_HELPER
> +       select DRM_GEM_CMA_HELPER
> +       select DRM_KMS_CMA_HELPER
> +       select DRM_MIPI_DSI
> +       select DRM_PANEL
> +       select VIDEOMODE_HELPERS
> +       select BACKLIGHT_CLASS_DEVICE
> +       help
> +         Choose this option if you have a Unisoc chipsets.
s/chipsets/chipset/ ?


> --- /dev/null
> +++ b/drivers/gpu/drm/sprd/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +ccflags-y += -Iinclude/drm
> +
> +subdir-ccflags-y += -I$(src)
> +
I think we can drop the includes here, unless there's a specific error
message that you're setting.


> --- /dev/null
> +++ b/drivers/gpu/drm/sprd/sprd_drm.c

> +#define DRIVER_NAME    "sprd"
> +#define DRIVER_DESC    "Spreadtrum SoCs' DRM Driver"
> +#define DRIVER_DATE    "20180501"
The date is mostly for cosmetic purposes. Yet we're nearly 2020 and
this reads 2018 - update?

<snip>

> +static struct drm_driver sprd_drm_drv = {
> +       .driver_features        = DRIVER_GEM | DRIVER_MODESET |
> +                                 DRIVER_ATOMIC | DRIVER_HAVE_IRQ,
There is no modeset exposed by the driver, let alone an atomic one.

Thus I would drop the following code from this patch and add it with a
patch that uses it.
 - tokens - DRIVER_MODESET, DRIVER_ATOMIC)
 - no-op modeset/atomic functions just above, and
 - vblank/kms code (further down) in bind/unbind


<snip>

> +static int sprd_drm_probe(struct platform_device *pdev)
> +{
> +       int ret;
> +
> +       ret = dma_set_mask_and_coherent(&pdev->dev, ~0);
> +       if (ret)
> +               DRM_ERROR("dma_set_mask_and_coherent failed (%d)\n", ret);
> +
Is the hardware going to work correctly the dma call fails? Should we
use "return ret;" here?

> +       return sprd_drm_component_probe(&pdev->dev, &sprd_drm_component_ops);
> +}
> +
> +static int sprd_drm_remove(struct platform_device *pdev)
> +{
> +       component_master_del(&pdev->dev, &sprd_drm_component_ops);
> +       return 0;
> +}
> +
> +static void sprd_drm_shutdown(struct platform_device *pdev)
> +{
> +       struct drm_device *drm = platform_get_drvdata(pdev);
> +
> +       if (!drm) {
Can this happen in reality?

<snip>

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
> +       struct drm_device *drm;

> +       struct drm_atomic_state *state;
> +       struct device *dpu_dev;
> +       struct device *gsp_dev;
These three are unused. Please add alongside the code which is using them.


> --- /dev/null
> +++ b/drivers/gpu/drm/sprd/sprd_gem.c

As Thomas pointed out, this is effectively a copy of drm_gem_cma_helper.c
Please drop this file and use the respective CMA functions, instead.


> diff --git a/drivers/gpu/drm/sprd/sprd_gem.h b/drivers/gpu/drm/sprd/sprd_gem.h
> new file mode 100644
> index 0000000..4c10d8a
> --- /dev/null
> +++ b/drivers/gpu/drm/sprd/sprd_gem.h
Just like the C file - this is effectively a copy of the existing CMA codebase.

HTH
Emil
