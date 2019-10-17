Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E8CFA3733
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 08:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 846DE20663
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 08:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VC+bz3qt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408363AbfJQIrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 04:47:49 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:39640 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408296AbfJQIrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 04:47:48 -0400
Received: by mail-ua1-f67.google.com with SMTP id b14so414304uap.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 01:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=paqFDTtdY3M8Ln3kvS2sgcbv9f/ilylyzRvaduM2VsY=;
        b=VC+bz3qt6il9V5qrADuSCMdBWfzwaxRUScgGnlDsNHERQWfLKSR2Bxszm+EkQ6jXXD
         3nx7yN/G8ujuN794/Ej/j2SFHBU5W9H32gRcN3NFh2y5zsrNw1nPIZJf55cVcFnRu0BP
         TeeukIDKYJF1RYwC+cZmKLhQN+OJz0gzV5MlKgGUtQFDSVX+m5vYHKL3d0NLTmm+uee3
         gdKDqwBVu9qln9Rx8gaIbwB/tyB01lAaaELk7bklckQW0qidsuZpLO1MQg7uv4DqrYxg
         AewZ/U+sNxK/GmtPC9Sl4hp77at+xOiCv++zS2LhMdbJJz1FTZ5uhZiJwEzxK7SXdxjC
         Ci9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=paqFDTtdY3M8Ln3kvS2sgcbv9f/ilylyzRvaduM2VsY=;
        b=WacCWIyR41EDn3Qout4vI8UuwgH9Yab5hMPY3BkB2NCk8AUnD0mCUfZRA5CDrnB8et
         2TUoyO2G1ToJf0MSs39yBcpURPLRBhDxycZQ3v8FQheDFK6sI+CPqE89wikvleEgjiIA
         sRGMM+wqPXZ2LpPHFYYreDWHPZZRVPKFf47gHMusuMt4DPff480d1jrxgDya/ZU7UE3H
         aQNdBBQyQSnzETd4dgJP9DJueZwUBU2jVozV+MSwVp9SQtGZruMVXZG1P9c8inReY5Ji
         zFAmnMK56/o+JOIpKs9iVQ49QBteOw/BH3RPv227WRmUHenndcHa5HJxSezOi8bKKd9S
         uCPQ==
X-Gm-Message-State: APjAAAWVeBR7DN3b7hrvu23dbDNtRmWAZr3T353jThr/Tq1I9i9Qm3PJ
        8H4VlBcNTBehq14ht6cCCZ6R6xt0vq3lCvv2UWsK1A==
X-Google-Smtp-Source: APXvYqxd6dQcGbSpCKxJAN7cuzTjKDPHr8BOJ/ritWtbU7r/7bPdSmety13gO9Mj4sTiUij+G5xrdaUjYdN0Z/Ytw8o=
X-Received: by 2002:ab0:5a97:: with SMTP id w23mr1633617uae.129.1571302067047;
 Thu, 17 Oct 2019 01:47:47 -0700 (PDT)
MIME-Version: 1.0
References: <1571254641-13626-1-git-send-email-thara.gopinath@linaro.org> <1571254641-13626-5-git-send-email-thara.gopinath@linaro.org>
In-Reply-To: <1571254641-13626-5-git-send-email-thara.gopinath@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 17 Oct 2019 10:47:11 +0200
Message-ID: <CAPDyKFoOpxWWhbr0ZSmuKEoqx=qoZ2ksLO9QodyhWU35tPVX6w@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] thermal: Add generic power domain warming device driver.
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, amit.kucheria@verdurent.com,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2019 at 21:37, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>
> Resources modeled as power domains in linux kenrel
> can  be used to warm the SoC(eg. mx power domain on sdm845).
> To support this feature, introduce a generic power domain
> warming device driver that can be plugged into the thermal framework
> (The thermal framework itself requires further modifiction to
> support a warming device in place of a cooling device.
> Those extensions are not introduced in this patch series).
>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  drivers/thermal/Kconfig              |  10 +++
>  drivers/thermal/Makefile             |   2 +
>  drivers/thermal/pwr_domain_warming.c | 136 +++++++++++++++++++++++++++++++++++
>  include/linux/pwr_domain_warming.h   |  31 ++++++++
>  4 files changed, 179 insertions(+)
>  create mode 100644 drivers/thermal/pwr_domain_warming.c
>  create mode 100644 include/linux/pwr_domain_warming.h
>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 001a21a..0c5c93e 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -187,6 +187,16 @@ config DEVFREQ_THERMAL
>
>           If you want this support, you should say Y here.
>
> +config PWR_DOMAIN_WARMING_THERMAL
> +       bool "Power Domain based warming device"
> +       depends on PM_GENERIC_DOMAINS_OF
> +       help
> +         This implements the generic power domain based warming
> +         mechanism through increasing the performance state of
> +         a power domain.
> +
> +         If you want this support, you should say Y here.
> +
>  config THERMAL_EMULATION
>         bool "Thermal emulation mode support"
>         help
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 74a37c7..382c64a 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -27,6 +27,8 @@ thermal_sys-$(CONFIG_CLOCK_THERMAL)   += clock_cooling.o
>  # devfreq cooling
>  thermal_sys-$(CONFIG_DEVFREQ_THERMAL) += devfreq_cooling.o
>
> +thermal_sys-$(CONFIG_PWR_DOMAIN_WARMING_THERMAL)       += pwr_domain_warming.o
> +
>  # platform thermal drivers
>  obj-y                          += broadcom/
>  obj-$(CONFIG_THERMAL_MMIO)             += thermal_mmio.o
> diff --git a/drivers/thermal/pwr_domain_warming.c b/drivers/thermal/pwr_domain_warming.c
> new file mode 100644
> index 0000000..60fae3e
> --- /dev/null
> +++ b/drivers/thermal/pwr_domain_warming.c
> @@ -0,0 +1,136 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019, Linaro Ltd
> + */
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/slab.h>
> +#include <linux/pwr_domain_warming.h>
> +
> +struct pd_warming_device {
> +       struct thermal_cooling_device *cdev;
> +       struct generic_pm_domain *gpd;

No, this isn't a genpd provider and thus we should not need to carry
the above pointer in the struct pd_warming_device.

> +       struct device *dev;
> +       int max_state;
> +       int cur_state;
> +       bool runtime_resumed;
> +};
> +
> +static int pd_wdev_get_max_state(struct thermal_cooling_device *cdev,
> +                                unsigned long *state)
> +{
> +       struct pd_warming_device *pd_wdev = cdev->devdata;
> +
> +       *state = pd_wdev->max_state;
> +       return 0;
> +}
> +
> +static int pd_wdev_get_cur_state(struct thermal_cooling_device *cdev,
> +                                unsigned long *state)
> +{
> +       struct pd_warming_device *pd_wdev = cdev->devdata;
> +
> +       *state = dev_pm_genpd_get_performance_state(pd_wdev->dev);
> +
> +       return 0;
> +}
> +
> +static int pd_wdev_set_cur_state(struct thermal_cooling_device *cdev,
> +                                unsigned long state)
> +{
> +       struct pd_warming_device *pd_wdev = cdev->devdata;
> +       struct device *dev = pd_wdev->dev;
> +       int ret;
> +
> +       ret = dev_pm_genpd_set_performance_state(dev, state);
> +
> +       if (ret)
> +               return ret;
> +
> +       if (state && !pd_wdev->runtime_resumed) {
> +               ret = pm_runtime_get_sync(dev);
> +               pd_wdev->runtime_resumed = true;
> +       } else if (!state && pd_wdev->runtime_resumed) {
> +               ret = pm_runtime_put(dev);
> +               pd_wdev->runtime_resumed = false;
> +       }
> +
> +       return ret;
> +}
> +
> +static int pd_wdev_late_init(struct thermal_cooling_device *cdev)
> +{
> +       struct pd_warming_device *pd_wdev = cdev->devdata;
> +       struct device *dev = &cdev->device;
> +       int state_count, ret;
> +
> +       ret = pm_genpd_add_device(pd_wdev->gpd, dev);

The pm_genpd_add_device() is a legacy interface and we are striving to
remove it. I think there are two better options for you to use to deal
with the attach thingy.

1. The easiest one is probably just to convert into using
of_genpd_add_device() instead. I think you already have the
information that you need in the ->cdev pointer to do that. However,
that also means you need to add the ->late_init() callback to the
struct thermal_cooling_device_ops, like what you do here.

2. Maybe the most correct solution is, rather than attaching
&cdev->device to the PM domain, to register a separate new device
(device_register()) and assign it the corresponding OF node as the
genpd provider's subnode and then attach this one instead. If
"power-domains" can be specified in the subnode, you can even use
dev_pm_domain_attach() to attach the device to the PM domain, else
of_genpd_add_device() should work. In the second step, when
registering the cooling device, the new device above should be
assigned as parent to the device that is about to be registered via
thermal_of_cooling_device_register(). In other words, the
thermal_of_cooling_device_register() needs to be extended to cope with
receiving a parent device as an in-parameter, but that should be
doable I think. In this way, you don't need to add the ->late_init()
callback at all, but you can instead just use the parent device when
operating on the PM domain.

> +
> +       if (ret)
> +               return ret;
> +
> +       state_count = dev_pm_genpd_performance_state_count(dev);
> +       if (state_count < 0)
> +               return state_count;
> +
> +       pm_runtime_enable(dev);
> +
> +       pd_wdev->dev = dev;
> +       pd_wdev->max_state = state_count - 1;
> +
> +       return 0;
> +}
> +
> +static struct thermal_cooling_device_ops pd_warming_device_ops = {
> +       .late_init      = pd_wdev_late_init,
> +       .get_max_state  = pd_wdev_get_max_state,
> +       .get_cur_state  = pd_wdev_get_cur_state,
> +       .set_cur_state  = pd_wdev_set_cur_state,
> +};

[...]

Kind regards
Uffe
