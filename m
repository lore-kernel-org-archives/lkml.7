Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4DDC00454
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 949D52053B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="I2lgJAKz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfLJWBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:01:39 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55779 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfLJWBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:01:39 -0500
Received: by mail-wm1-f66.google.com with SMTP id q9so4889865wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 14:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IdEgSF+/YKX111RPx3g26t6v4N0KcK/Dzr46XVnsmo8=;
        b=I2lgJAKzPmhuhNR5qnb+D+kfWQWwm3GyPv7nBqZQsLKz3OVTr/Vp2dkC8snQMtsgof
         oXwwUq4/fkGXQ7stdHlmy3Pzh+/qORuqEDYWDi9Q1/K3tgtirUKK91KMtP1YVg7jn0x6
         6gO8Haoq52TACeS7xbE34SeMyc4zwBYDLGpnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=IdEgSF+/YKX111RPx3g26t6v4N0KcK/Dzr46XVnsmo8=;
        b=tjRHeOQbvMrkVXWthI8aUFqM8dYiTrRk0I02LtWdoIFP8eYYNOgdcRcJ57/7bhuckd
         BUQSHS4ExVKLp6BzgdOeXZh9xnJ421oucK8qIqQomwN2M6TzA5CPxB1WhaPD2qVIcr7S
         o/ENXKJVDv/obvgM3GSDElSPvr6aiMHM4D1MTRri7zL78a5ruuq7u7wGVPMIPExrDsfP
         HP0/ugUaGH3EXhrXfqMgY+daeAAbP3qALUqWiAW/TaOC0MgLWW4d85qSe2Js/3Dx31cv
         21FSweq4v5QBbktgYBo2mT+zNnwYns1Bj+UbyZlEnzIrm0Xrte7f76WHY+DX8l/dq45s
         zERA==
X-Gm-Message-State: APjAAAWBmmgi59uEz4QTupixH8eMhgRmM0Q8AcIuSKzkNalx+K2RciVz
        hU9t4/AapD0OyB9mvwZNOVO68w==
X-Google-Smtp-Source: APXvYqwa8TfufsDB9aSx7a9VDy0lGOIlFFjZg/YM+/m43bHWCA6z9RoxBypwGEKS/fGkDLrJFYeuEA==
X-Received: by 2002:a7b:c19a:: with SMTP id y26mr7569408wmi.152.1576015296369;
        Tue, 10 Dec 2019 14:01:36 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:564b:0:7567:bb67:3d7f:f863])
        by smtp.gmail.com with ESMTPSA id k19sm4412552wmi.42.2019.12.10.14.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 14:01:35 -0800 (PST)
Date:   Tue, 10 Dec 2019 23:01:33 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     Kevin Tang <kevin3.tang@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, orsonzhai@gmail.com,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        zhang.lyra@gmail.com, baolin.wang@linaro.org
Subject: Re: [PATCH RFC 2/8] drm/sprd: add Unisoc's drm kms master
Message-ID: <20191210220133.GV624164@phenom.ffwll.local>
Mail-Followup-To: Emil Velikov <emil.l.velikov@gmail.com>,
        Kevin Tang <kevin3.tang@gmail.com>, David Airlie <airlied@linux.ie>,
        orsonzhai@gmail.com, ML dri-devel <dri-devel@lists.freedesktop.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        zhang.lyra@gmail.com, baolin.wang@linaro.org
References: <1575966995-13757-1-git-send-email-kevin3.tang@gmail.com>
 <1575966995-13757-3-git-send-email-kevin3.tang@gmail.com>
 <CACvgo50K=43OHW33i8ZsMG3QvuVxLZSo0iBMSt0Z-X4N2eTObw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACvgo50K=43OHW33i8ZsMG3QvuVxLZSo0iBMSt0Z-X4N2eTObw@mail.gmail.com>
X-Operating-System: Linux phenom 5.3.0-2-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 04:06:53PM +0000, Emil Velikov wrote:
> Welcome to DRM Kevin,
> 
> On Tue, 10 Dec 2019 at 08:40, Kevin Tang <kevin3.tang@gmail.com> wrote:
> >
> > From: Kevin Tang <kevin.tang@unisoc.com>
> >
> > Adds drm support for the Unisoc's display subsystem.
> >
> > This is drm device and gem driver. This driver provides support for the
> > Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
> >
> Did you use XFree86 or Xorg to test this? The XFree86 codebase have been
> missing for years.
> 
> Out of curiosity - did you try any Wayland, or bare-metal compositor?

Just noticed that the driver also seems to be missing fbdev emulation.
Given that that is a one-line (for a proper driver using all the right
helpers) it should be added. See drm_fbdev_generic_setup().
-Daniel

> 
> >  source "drivers/gpu/drm/mcde/Kconfig"
> >
> > +source "drivers/gpu/drm/sprd/Kconfig"
> > +
> >  # Keep legacy drivers last
> >
> >  menuconfig DRM_LEGACY
> > diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> > index 9f1c7c4..85ca211 100644
> > --- a/drivers/gpu/drm/Makefile
> > +++ b/drivers/gpu/drm/Makefile
> > @@ -122,3 +122,4 @@ obj-$(CONFIG_DRM_LIMA)  += lima/
> >  obj-$(CONFIG_DRM_PANFROST) += panfrost/
> >  obj-$(CONFIG_DRM_ASPEED_GFX) += aspeed/
> >  obj-$(CONFIG_DRM_MCDE) += mcde/
> > +obj-$(CONFIG_DRM_SPRD) += sprd/
> > diff --git a/drivers/gpu/drm/sprd/Kconfig b/drivers/gpu/drm/sprd/Kconfig
> > new file mode 100644
> > index 0000000..79f286b
> > --- /dev/null
> > +++ b/drivers/gpu/drm/sprd/Kconfig
> > @@ -0,0 +1,14 @@
> > +config DRM_SPRD
> > +       tristate "DRM Support for Unisoc SoCs Platform"
> > +       depends on ARCH_SPRD
> > +       depends on DRM && OF
> > +       select DRM_KMS_HELPER
> > +       select DRM_GEM_CMA_HELPER
> > +       select DRM_KMS_CMA_HELPER
> > +       select DRM_MIPI_DSI
> > +       select DRM_PANEL
> > +       select VIDEOMODE_HELPERS
> > +       select BACKLIGHT_CLASS_DEVICE
> > +       help
> > +         Choose this option if you have a Unisoc chipsets.
> s/chipsets/chipset/ ?
> 
> 
> > --- /dev/null
> > +++ b/drivers/gpu/drm/sprd/Makefile
> > @@ -0,0 +1,8 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +ccflags-y += -Iinclude/drm
> > +
> > +subdir-ccflags-y += -I$(src)
> > +
> I think we can drop the includes here, unless there's a specific error
> message that you're setting.
> 
> 
> > --- /dev/null
> > +++ b/drivers/gpu/drm/sprd/sprd_drm.c
> 
> > +#define DRIVER_NAME    "sprd"
> > +#define DRIVER_DESC    "Spreadtrum SoCs' DRM Driver"
> > +#define DRIVER_DATE    "20180501"
> The date is mostly for cosmetic purposes. Yet we're nearly 2020 and
> this reads 2018 - update?
> 
> <snip>
> 
> > +static struct drm_driver sprd_drm_drv = {
> > +       .driver_features        = DRIVER_GEM | DRIVER_MODESET |
> > +                                 DRIVER_ATOMIC | DRIVER_HAVE_IRQ,
> There is no modeset exposed by the driver, let alone an atomic one.
> 
> Thus I would drop the following code from this patch and add it with a
> patch that uses it.
>  - tokens - DRIVER_MODESET, DRIVER_ATOMIC)
>  - no-op modeset/atomic functions just above, and
>  - vblank/kms code (further down) in bind/unbind
> 
> 
> <snip>
> 
> > +static int sprd_drm_probe(struct platform_device *pdev)
> > +{
> > +       int ret;
> > +
> > +       ret = dma_set_mask_and_coherent(&pdev->dev, ~0);
> > +       if (ret)
> > +               DRM_ERROR("dma_set_mask_and_coherent failed (%d)\n", ret);
> > +
> Is the hardware going to work correctly the dma call fails? Should we
> use "return ret;" here?
> 
> > +       return sprd_drm_component_probe(&pdev->dev, &sprd_drm_component_ops);
> > +}
> > +
> > +static int sprd_drm_remove(struct platform_device *pdev)
> > +{
> > +       component_master_del(&pdev->dev, &sprd_drm_component_ops);
> > +       return 0;
> > +}
> > +
> > +static void sprd_drm_shutdown(struct platform_device *pdev)
> > +{
> > +       struct drm_device *drm = platform_get_drvdata(pdev);
> > +
> > +       if (!drm) {
> Can this happen in reality?
> 
> <snip>
> 
> > --- /dev/null
> > +++ b/drivers/gpu/drm/sprd/sprd_drm.h
> > @@ -0,0 +1,19 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2019 Unisoc Inc.
> > + */
> > +
> > +#ifndef _SPRD_DRM_H_
> > +#define _SPRD_DRM_H_
> > +
> > +#include <drm/drm_atomic.h>
> > +#include <drm/drm_print.h>
> > +
> > +struct sprd_drm {
> > +       struct drm_device *drm;
> 
> > +       struct drm_atomic_state *state;
> > +       struct device *dpu_dev;
> > +       struct device *gsp_dev;
> These three are unused. Please add alongside the code which is using them.
> 
> 
> > --- /dev/null
> > +++ b/drivers/gpu/drm/sprd/sprd_gem.c
> 
> As Thomas pointed out, this is effectively a copy of drm_gem_cma_helper.c
> Please drop this file and use the respective CMA functions, instead.
> 
> 
> > diff --git a/drivers/gpu/drm/sprd/sprd_gem.h b/drivers/gpu/drm/sprd/sprd_gem.h
> > new file mode 100644
> > index 0000000..4c10d8a
> > --- /dev/null
> > +++ b/drivers/gpu/drm/sprd/sprd_gem.h
> Just like the C file - this is effectively a copy of the existing CMA codebase.
> 
> HTH
> Emil

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
