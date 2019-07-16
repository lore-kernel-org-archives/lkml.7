Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CE6C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 17:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A8642064B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 17:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rIj1ENw6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388256AbfGPRcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 13:32:05 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42581 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbfGPRcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 13:32:04 -0400
Received: by mail-ed1-f67.google.com with SMTP id v15so21184851eds.9;
        Tue, 16 Jul 2019 10:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3D1HNQZnwOTNKK1krsSFd8w1kBkxByzwQaoWXaXeG9E=;
        b=rIj1ENw6XqofAfDtk8vR/eDPR/4Cv7qRp88MKp+6Adiu9d7tZ3RQ/sgsMXiqzpMs/N
         mmEG8ZaJUuTT4Bksxe82PtTrew1Ba0DM/Iawis+fJNfskKWTpfbRMJqMSBEUK38MnG+9
         1QCrDyjmfyC8/fXme46E8QIAqWChX22ixohAtilW0p6r2rnjYRSsLEQQ4bARDjlkFZBA
         50GanugfaWCCNqnTa69q0r/ru38hCx8MzJohmLgcqLB0x5sXB8qXjbEaHCtYdUpL/FQI
         1De+QILvEoh6BP8/nQ/QiUYo90fOW8w4CCp/UVXMHpJztK0a0HrTo91D/ZTVbugJoWKj
         jC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3D1HNQZnwOTNKK1krsSFd8w1kBkxByzwQaoWXaXeG9E=;
        b=J0zKN0PS4HZuT+btgpvXTos67ZSyHsw2rQYW4+zcI4sgsyneGvDb7JQvfjYSsPJKw/
         1yEv9HIPU4V2UStHj6RAKK/Pq7V9KFxR2nfWilS+1Fy+lUyRmhxZzZ8Ufpyj+48Pp7gc
         29NggMuI/Z3uKn9DFcsvn7x1kXUT35ngQ4P0xC1dQ9muXKxvqEaSmIo8SkfaRxGhlv0r
         0GqpegHw07Sgplra71F8XqLqb4QOvDq3ASV7VmBj3h1TjkNuBH7syOH3po6CDDuLB0zw
         iPBCct/1y5h6QA79ESDHvYtUVJONtK3yqYgXniKJVk3ZUWJXYu++5NwXkv3/xr4PbpOi
         tqHA==
X-Gm-Message-State: APjAAAXK/jPEid4niZeFLusmxcsRw7H9/hkmQlL26xUDuQX8RvPkZ69L
        chM/IfgIfz/JI4yuKsT4sI3dAMsqflbwcvB+TZw=
X-Google-Smtp-Source: APXvYqyFD90pb/Cr9xmbGwSToc//XsyTuxBh0VQzNZIyiS2NQoMQ6yZTENnhuk7Lh7ExxCjSxM5W4K2f7qvBpSNhYk8=
X-Received: by 2002:a17:906:e95:: with SMTP id p21mr26559018ejf.205.1563298321754;
 Tue, 16 Jul 2019 10:32:01 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190627071744eucas1p164b065a96afa23f2f5534fbc73660dae@eucas1p1.samsung.com>
 <20190627071726.30467-1-m.szyprowski@samsung.com> <20190627071726.30467-2-m.szyprowski@samsung.com>
In-Reply-To: <20190627071726.30467-2-m.szyprowski@samsung.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Tue, 16 Jul 2019 23:01:50 +0530
Message-ID: <CANAwSgTFhFu6iwryiO8244-CbuKe=XgOArpEJcb9kMjBs=V_rQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] usb: host: xhci-plat: Add support for Exynos5/DWC3
 specific variant
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Linux USB Mailing List <linux-usb@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jochen Sprickerhof <jochen@sprickerhof.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On Thu, 27 Jun 2019 at 12:47, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> USB3.0 DRD PHY found in Exynos5 SoCs requires calibration to be done
> after every HCD reset. This was initially handled by DWC3 core by commit
> d8c80bb3b55b ("phy: exynos5-usbdrd: Calibrate LOS levels for
> exynos5420/5800"), but it turned out that the mentioned patch worked only
> by the pure luck and fixed only one use case.
>
> PHY calibration was done in DWC3 driver, just before initializing XHCI
> core. This approach was prone to a race. It worked for the fresh boot
> case iff XHCI-plat driver was compiled into the kernel or it's module has
> been loaded before DWC3 probe. In other cases (XHCI-plat module loaded on
> demand after DWC3 probe or during suspend/resume cycle) - the
> calibration was not performed at proper time and had no effect.
>
> This patch creates Exynos5/DWC3 specific variant of XHCI-plat driver,
> which takes care of proper PHY calibration after XHCI core reset, what
> fixes all known use cases (XHCI driver compiled as module and loaded on
> demand as well as during system suspend/resume cycle).
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---

Please add my tested on XU4 / XU3 using linux next-20190716
Tested-by: Anand Moon <linux.amoon@gmail.com>

Best Regards
-Anand

>  drivers/usb/host/Kconfig       |  8 ++++++
>  drivers/usb/host/Makefile      |  3 ++
>  drivers/usb/host/xhci-exynos.c | 51 ++++++++++++++++++++++++++++++++++
>  drivers/usb/host/xhci-exynos.h | 26 +++++++++++++++++
>  drivers/usb/host/xhci-plat.c   | 38 ++++++++++++++++++++++++-
>  drivers/usb/host/xhci-plat.h   |  2 ++
>  6 files changed, 127 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/usb/host/xhci-exynos.c
>  create mode 100644 drivers/usb/host/xhci-exynos.h
>
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 40b5de597112..5a17a9b1fbff 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -53,6 +53,14 @@ config USB_XHCI_PLATFORM
>
>           If unsure, say N.
>
> +config USB_XHCI_EXYNOS
> +       tristate "xHCI support for Samsung Exynos SoCs"
> +       depends on USB_XHCI_PLATFORM
> +       depends on ARCH_EXYNOS || COMPILE_TEST
> +       ---help---
> +         Say 'Y' to enable the support for the xHCI host controller
> +         found in Samsung Exynos ARM SoCs.
> +
>  config USB_XHCI_HISTB
>         tristate "xHCI support for HiSilicon STB SoCs"
>         depends on USB_XHCI_PLATFORM && (ARCH_HISI || COMPILE_TEST)
> diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
> index 84514f71ae44..34afd6680751 100644
> --- a/drivers/usb/host/Makefile
> +++ b/drivers/usb/host/Makefile
> @@ -30,6 +30,9 @@ endif
>  ifneq ($(CONFIG_USB_XHCI_RCAR), )
>         xhci-plat-hcd-y         += xhci-rcar.o
>  endif
> +ifneq ($(CONFIG_USB_XHCI_EXYNOS), )
> +       xhci-plat-hcd-y         += xhci-exynos.o
> +endif
>
>  ifneq ($(CONFIG_DEBUG_FS),)
>         xhci-hcd-y              += xhci-debugfs.o
> diff --git a/drivers/usb/host/xhci-exynos.c b/drivers/usb/host/xhci-exynos.c
> new file mode 100644
> index 000000000000..446d33998382
> --- /dev/null
> +++ b/drivers/usb/host/xhci-exynos.c
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * xHCI host controller driver for Samsung Exynos5 SoCs
> + *
> + * Copyright (C) 2019 Samsung Electronics Co., Ltd.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/phy/phy.h>
> +
> +#include "xhci.h"
> +#include "xhci-plat.h"
> +#include "xhci-exynos.h"
> +
> +int xhci_exynos_init_quirk(struct usb_hcd *hcd)
> +{
> +       struct xhci_hcd *xhci = hcd_to_xhci(hcd);
> +       struct device *dev = hcd->self.controller;
> +       struct xhci_plat_priv *xhci_priv = hcd_to_xhci_priv(hcd);
> +       struct phy *usb2_generic_phy;
> +       int ret;
> +
> +       usb2_generic_phy = devm_phy_get(dev->parent, "usb2-phy");
> +       if (IS_ERR(usb2_generic_phy)) {
> +               ret = PTR_ERR(usb2_generic_phy);
> +               if (ret == -EPROBE_DEFER) {
> +                       return ret;
> +               } else {
> +                       dev_err(dev, "no usb2 phy configured\n");
> +                       return ret;
> +               }
> +       }
> +
> +       phy_calibrate(usb2_generic_phy);
> +       xhci_priv->priv = usb2_generic_phy;
> +
> +       xhci->quirks |= XHCI_RESET_ON_RESUME;
> +
> +       return 0;
> +}
> +
> +int xhci_exynos_post_resume_quirk(struct usb_hcd *hcd)
> +{
> +       struct xhci_plat_priv *xhci_priv = hcd_to_xhci_priv(hcd);
> +       struct phy *usb2_generic_phy = xhci_priv->priv;
> +
> +       phy_calibrate(usb2_generic_phy);
> +
> +       return 0;
> +}
> diff --git a/drivers/usb/host/xhci-exynos.h b/drivers/usb/host/xhci-exynos.h
> new file mode 100644
> index 000000000000..58ea3e9aea8d
> --- /dev/null
> +++ b/drivers/usb/host/xhci-exynos.h
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * drivers/usb/host/xhci-exynos.h
> + *
> + * Copyright (C) 2019 Samsung Electronics Co., Ltd.
> + */
> +
> +#ifndef _XHCI_EXYNOS_H
> +#define _XHCI_EXYNOS_H
> +
> +
> +#if IS_ENABLED(CONFIG_USB_XHCI_EXYNOS)
> +int xhci_exynos_init_quirk(struct usb_hcd *hcd);
> +int xhci_exynos_post_resume_quirk(struct usb_hcd *hcd);
> +#else
> +static inline int xhci_exynos_init_quirk(struct usb_hcd *hcd)
> +{
> +       return 0;
> +}
> +
> +static inline int xhci_exynos_post_resume_quirk(struct usb_hcd *hcd)
> +{
> +       return 0;
> +}
> +#endif
> +#endif /* _XHCI_EXYNOS_H */
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 998241f5fce3..6bc03cdb2f21 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -24,6 +24,7 @@
>  #include "xhci-plat.h"
>  #include "xhci-mvebu.h"
>  #include "xhci-rcar.h"
> +#include "xhci-exynos.h"
>
>  static struct hc_driver __read_mostly xhci_plat_hc_driver;
>
> @@ -64,6 +65,16 @@ static int xhci_priv_resume_quirk(struct usb_hcd *hcd)
>         return priv->resume_quirk(hcd);
>  }
>
> +static int xhci_priv_post_resume_quirk(struct usb_hcd *hcd)
> +{
> +       struct xhci_plat_priv *priv = hcd_to_xhci_priv(hcd);
> +
> +       if (!priv->post_resume_quirk)
> +               return 0;
> +
> +       return priv->post_resume_quirk(hcd);
> +}
> +
>  static void xhci_plat_quirks(struct device *dev, struct xhci_hcd *xhci)
>  {
>         /*
> @@ -102,6 +113,11 @@ static const struct xhci_plat_priv xhci_plat_marvell_armada3700 = {
>         .init_quirk = xhci_mvebu_a3700_init_quirk,
>  };
>
> +static const struct xhci_plat_priv xhci_plat_samsung_exynos5 = {
> +       .init_quirk = xhci_exynos_init_quirk,
> +       .post_resume_quirk = xhci_exynos_post_resume_quirk,
> +};
> +
>  static const struct xhci_plat_priv xhci_plat_renesas_rcar_gen2 = {
>         .firmware_name = XHCI_RCAR_FIRMWARE_NAME_V1,
>         .init_quirk = xhci_rcar_init_quirk,
> @@ -260,6 +276,13 @@ static int xhci_plat_probe(struct platform_device *pdev)
>                 goto disable_reg_clk;
>
>         priv_match = of_device_get_match_data(&pdev->dev);
> +       if (!priv_match) {
> +               const struct platform_device_id *id =
> +                                                  platform_get_device_id(pdev);
> +               if (id)
> +                       priv_match = (const struct xhci_plat_priv *)
> +                                                               id->driver_data;
> +       }
>         if (priv_match) {
>                 struct xhci_plat_priv *priv = hcd_to_xhci_priv(hcd);
>
> @@ -413,7 +436,11 @@ static int __maybe_unused xhci_plat_resume(struct device *dev)
>         if (ret)
>                 return ret;
>
> -       return xhci_resume(xhci, 0);
> +       ret = xhci_resume(xhci, 0);
> +       if (ret)
> +               return ret;
> +
> +       return xhci_priv_post_resume_quirk(hcd);
>  }
>
>  static int __maybe_unused xhci_plat_runtime_suspend(struct device *dev)
> @@ -447,9 +474,18 @@ static const struct acpi_device_id usb_xhci_acpi_match[] = {
>  };
>  MODULE_DEVICE_TABLE(acpi, usb_xhci_acpi_match);
>
> +static struct platform_device_id xhci_plat_driver_ids[] = {
> +       {
> +               .name           = "exynos5-dwc3-xhci",
> +               .driver_data    = (long) &xhci_plat_samsung_exynos5,
> +       }, { },
> +};
> +MODULE_DEVICE_TABLE(platform, xhci_plat_driver_ids);
> +
>  static struct platform_driver usb_xhci_driver = {
>         .probe  = xhci_plat_probe,
>         .remove = xhci_plat_remove,
> +       .id_table = xhci_plat_driver_ids,
>         .driver = {
>                 .name = "xhci-hcd",
>                 .pm = &xhci_plat_pm_ops,
> diff --git a/drivers/usb/host/xhci-plat.h b/drivers/usb/host/xhci-plat.h
> index ae29f22ff5bd..f8a8e84b4ebe 100644
> --- a/drivers/usb/host/xhci-plat.h
> +++ b/drivers/usb/host/xhci-plat.h
> @@ -12,9 +12,11 @@
>
>  struct xhci_plat_priv {
>         const char *firmware_name;
> +       void *priv;
>         void (*plat_start)(struct usb_hcd *);
>         int (*init_quirk)(struct usb_hcd *);
>         int (*resume_quirk)(struct usb_hcd *);
> +       int (*post_resume_quirk)(struct usb_hcd *);
>  };
>
>  #define hcd_to_xhci_priv(h) ((struct xhci_plat_priv *)hcd_to_xhci(h)->priv)
> --
> 2.17.1
>
