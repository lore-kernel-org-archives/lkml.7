Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B62C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2915A21473
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tXIvJrLT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfFNM1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 08:27:51 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44131 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbfFNM1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 08:27:48 -0400
Received: by mail-lj1-f193.google.com with SMTP id k18so2175665ljc.11;
        Fri, 14 Jun 2019 05:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k0QRDXLHUntxOov7zrayFNvinwKPTFOzvVDJZpJssAo=;
        b=tXIvJrLTtd0fKEFBWbapSx/XhIgzyWMKMVSi8DJz19bpqqEc9DGRLaV9ZOhF+vXRme
         0NSfsmWlHItyo9ypwszqm49k7rivvv2lMI+VU8Dl7DgUXmVYYecRuGRgs+dXEDfAf7+1
         kY9grNndKXLh8EwpTkJuNIP4OGZ9Gp5GtBZ67G8UQexVZthJBxIvXWcWHpTDaLvKZvNr
         5apddKLqIehHzt+lU4Ycgwq1yU2ZJDV/UCo3noUeAG4n7DLnjzVMWo8gRm5v46jqbHd7
         0LQ65jl2ZCxiGdV+XyNHKZ4Z8pUEUKAxT/JPAq3QW4ITVyFG80Z1ViZIllsdZrJAIwgp
         zA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k0QRDXLHUntxOov7zrayFNvinwKPTFOzvVDJZpJssAo=;
        b=ZsUiDrzdvpa/YbkgW8PIt3DVbsPqPfPkOr0ScJHHJOl2KHWpJz+yYxf2aX9riTR5rg
         2gT0q8zt/rXl60Qz8y9HzoR2RX3z69Ea5M6S1nEJ5AIA31i92sswSFGgNakMInRUMaSr
         wmLsGrJVAzFIXOEYskrNoMmoGQW9zQueAkn7Y8845TFoQyjzz6nHlNmV+9qKIXe4ncj1
         WnWkNDeGhvTsd3u8v0p6UG0O5W5tQ+aoYb8dKl3xQE/WgaxYkrgj2xJUzvbkJ2ZYLm3J
         nHqM74F/2dwMkZXI36cudgdARk9+m0tjtmiohM+3VxowpQZMYQmnz9VpEZikoLbZe7u8
         CqEg==
X-Gm-Message-State: APjAAAVYn+hipXBp2gMBdQyskju1ARqCoZnYXRgH+P0qabUbTYXC70Gp
        1GfC1CeBfxdul9uXqeWKugLyjzCNjURk3p9IuHA=
X-Google-Smtp-Source: APXvYqzbXK8JHzAnv53oPJ62nUc83fkXffrgUkMyteZ/yr3Rwt4+r4Pzv7+Y+xrxdQ/u+mSg5m5FhnmjOv3EoYULcas=
X-Received: by 2002:a2e:63c4:: with SMTP id s65mr40810611lje.211.1560515266728;
 Fri, 14 Jun 2019 05:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <1560513063-24995-1-git-send-email-robert.chiras@nxp.com> <1560513063-24995-3-git-send-email-robert.chiras@nxp.com>
In-Reply-To: <1560513063-24995-3-git-send-email-robert.chiras@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 14 Jun 2019 09:27:49 -0300
Message-ID: <CAOMZO5BAborMvk=4cgreWKX6rJjK-237me98dM1dDV53oUnExQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/panel: Add support for Raydium RM67191 panel driver
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

Hi Robert,

On Fri, Jun 14, 2019 at 8:52 AM Robert Chiras <robert.chiras@nxp.com> wrote:

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

No need for this text as you are using SPDX tag.

> +static int color_format_from_dsi_format(enum mipi_dsi_pixel_format format)
> +{
> +       switch (format) {
> +       case MIPI_DSI_FMT_RGB565:
> +               return 0x55;
> +       case MIPI_DSI_FMT_RGB666:
> +       case MIPI_DSI_FMT_RGB666_PACKED:
> +               return 0x66;
> +       case MIPI_DSI_FMT_RGB888:
> +               return 0x77;

Could you use defines for these magic 0x55, 0x66 and 0x77 numbers?

> +static int rad_panel_prepare(struct drm_panel *panel)
> +{
> +       struct rad_panel *rad = to_rad_panel(panel);
> +
> +       if (rad->prepared)
> +               return 0;
> +
> +       if (rad->reset) {
> +               gpiod_set_value(rad->reset, 0);
> +               usleep_range(5000, 10000);
> +               gpiod_set_value(rad->reset, 1);
> +               usleep_range(20000, 25000);

This does not look correct.

The correct way to do a reset with gpiod API is:

 gpiod_set_value(rad->reset, 1);

delay

gpiod_set_value(rad->reset, 0);

I don't have the datasheet for the RM67191 panel, but I assume the
reset GPIO is active low.

Since you inverted the polarity in the dts and inside the driver, you
got it right by accident.

You could also consider using gpiod_set_value_cansleep() variant
instead because the GPIO reset could be provided by an I2C GPIO
expander, for example.

Also, when sleeping for more than 10ms, msleep is a better fit as per
Documentation/timers/timers-howto.txt.

> +       if (rad->reset) {
> +               gpiod_set_value(rad->reset, 0);
> +               usleep_range(15000, 17000);
> +               gpiod_set_value(rad->reset, 1);
> +       }

Another reset?
