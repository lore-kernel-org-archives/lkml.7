Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08768C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7CC621473
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5CHbTqH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbfFNMDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 08:03:30 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52918 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbfFNMDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 08:03:30 -0400
Received: by mail-wm1-f65.google.com with SMTP id s3so2089076wms.2;
        Fri, 14 Jun 2019 05:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cShyFkkmWiHnsjmUQgXX28LcVYfBv8SOqWlH6SPYRUQ=;
        b=B5CHbTqHgazRv85fYB6qcW/DGkY6lv6fwiiiSu0OBHcgweSNDpZyIW9F2RN6VrIcIW
         38rllu0/vNktkMaesiFUHr2i8JuWl/hbG4SdQKM9WJA9Jt95TjwBoJHQRroRg2uwkVhx
         qz6JFi/NFuYO5p6hi11fSIIy8tYGriGfrQSWGGOrmaWhrin+ZDWzQ1Obrm/KKwd+tI1B
         bOa+M/FzAXsGpYQywfHA9bnPZn9KZHrcgIN1So9SI+RStILzW/2pmJCyvrtRLJ00Lhtj
         4LDUtsHIhm4789TBidIsDrf3+F4XulU2mS2PWJsYnDSiv7JFVoGCTR1HXxxMWSPMUk6U
         4suA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cShyFkkmWiHnsjmUQgXX28LcVYfBv8SOqWlH6SPYRUQ=;
        b=LAD2veHMdCA/Sn3tQ2y6hEJoroGhU3iTs2+kbhfq+ZLhDvPxD4xbwxv5z071Gy66mV
         erUkdlIXb4Xwj+A2Kp7iTQknX08+2PHbFjEjnactEHDliENaXDrJSbgoXJZr/sWWvvX3
         1ml3PT2E8vBgwV7qzONTojqOBvN7N6cWZEU2hIREHSTCkyWeBxGSdC11M8Uy/8CZUQVA
         gdtvZ3QfI9Uns13Sq8i1imOUvHY0ugNAsCLelE19jNVYMo0Ynd1XuOe9vV53o4HpqxfB
         IvI80WzFkuBnn6LKVSxZl0DmutaNQS1jHy+JRc5nEn0yD7ihHN++zR4TyolDbb6XGFxN
         sZYg==
X-Gm-Message-State: APjAAAXDVjaqqgSlXa4GyxSAf1btrHmE4tgmCzBGdFwnf8FMNmOqDoad
        yqGAoiof1f1eStzAlxeC+SYJDP2SJB1a0dT+FyI=
X-Google-Smtp-Source: APXvYqxHOhGAxfhtTTPi6t7uAwRltrvjH/NqXqmw08VpXZpoMAYhTdcpPhC1ZS6CKEf9eePZKkmmvwD3J6yNEDTd0Yg=
X-Received: by 2002:a7b:c247:: with SMTP id b7mr8209757wmj.13.1560513807708;
 Fri, 14 Jun 2019 05:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <1560513063-24995-1-git-send-email-robert.chiras@nxp.com> <1560513063-24995-3-git-send-email-robert.chiras@nxp.com>
In-Reply-To: <1560513063-24995-3-git-send-email-robert.chiras@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Fri, 14 Jun 2019 15:03:15 +0300
Message-ID: <CAEnQRZA0yB8KKU8zcZU1CgPE5x9bYtp_4ESQ+miMkwuYKRkbJQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/panel: Add support for Raydium RM67191 panel driver
To:     Robert Chiras <robert.chiras@nxp.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

Minor comment. See inline:

On Fri, Jun 14, 2019 at 2:52 PM Robert Chiras <robert.chiras@nxp.com> wrote:
>
> This patch adds Raydium RM67191 TFT LCD panel driver (MIPI-DSI
> protocol).
>
> Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
> ---
>  drivers/gpu/drm/panel/Kconfig                 |   9 +
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  drivers/gpu/drm/panel/panel-raydium-rm67191.c | 730 ++++++++++++++++++++++++++
>  3 files changed, 740 insertions(+)
>  create mode 100644 drivers/gpu/drm/panel/panel-raydium-rm67191.c
>
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index d9d931a..8be1ac1 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -159,6 +159,15 @@ config DRM_PANEL_RASPBERRYPI_TOUCHSCREEN
>           Pi 7" Touchscreen.  To compile this driver as a module,
>           choose M here.
>
> +config DRM_PANEL_RAYDIUM_RM67191
> +       tristate "Raydium RM67191 FHD 1080x1920 DSI video mode panel"
> +       depends on OF
> +       depends on DRM_MIPI_DSI
> +       depends on BACKLIGHT_CLASS_DEVICE
> +       help
> +         Say Y here if you want to enable support for Raydium RM67191 FHD
> +         (1080x1920) DSI panel.
> +
>  config DRM_PANEL_RAYDIUM_RM68200
>         tristate "Raydium RM68200 720x1280 DSI video mode panel"
>         depends on OF
> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
> index fb0cb3a..1fc0f68 100644
> --- a/drivers/gpu/drm/panel/Makefile
> +++ b/drivers/gpu/drm/panel/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_DRM_PANEL_ORISETECH_OTM8009A) += panel-orisetech-otm8009a.o
>  obj-$(CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS) += panel-osd-osd101t2587-53ts.o
>  obj-$(CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00) += panel-panasonic-vvx10f034n00.o
>  obj-$(CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN) += panel-raspberrypi-touchscreen.o
> +obj-$(CONFIG_DRM_PANEL_RAYDIUM_RM67191) += panel-raydium-rm67191.o
>  obj-$(CONFIG_DRM_PANEL_RAYDIUM_RM68200) += panel-raydium-rm68200.o
>  obj-$(CONFIG_DRM_PANEL_ROCKTECH_JH057N00900) += panel-rocktech-jh057n00900.o
>  obj-$(CONFIG_DRM_PANEL_RONBO_RB070D30) += panel-ronbo-rb070d30.o
> diff --git a/drivers/gpu/drm/panel/panel-raydium-rm67191.c b/drivers/gpu/drm/panel/panel-raydium-rm67191.c
> new file mode 100644
> index 0000000..75bfb03
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-raydium-rm67191.c
> @@ -0,0 +1,730 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * i.MX drm driver - Raydium MIPI-DSI panel driver
> + *
> + * Copyright (C) 2017 NXP
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */

Please remove the license text once you already added the SPDX identifier.

Also preferred copyright for NXP is:

Copyright 2019 NXP

So, the file should look like this:

// SPDX-License-Identifier: GPL-2.0
/*
 * i.MX drm driver - Raydium MIPI-DSI panel driver
 *
 * Copyright 2019 NXP
 */
