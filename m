Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41055C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E50602084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIbJWgT+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730774AbfDBTYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 15:24:11 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40848 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfDBTYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 15:24:10 -0400
Received: by mail-wm1-f65.google.com with SMTP id z24so5214634wmi.5;
        Tue, 02 Apr 2019 12:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Okg2ZeMO3zh9fmq4j4GK+rVJbHsBLdHZ2ZvqKXHvO9E=;
        b=nIbJWgT+SgNaWfFLuMVY+a7lUjSieUbHS5swyJ909ZxBGXGyCZmI8CZ5i+l9hEMqif
         SLd6Ml5djBwmEo4ZZvGXKeGoDFcWLaNLOzylIOazGAm5wYswOZDKxY8Zg6aFNzb4mrQ9
         odzRA8yIW858x+3xk/prz0P0ozuvQpnuIkuy8rjQdgplsQsstjbgORxOzxPnwtDfRA29
         dkgbjvGCpY/IiGFojwrMtYotIq8/2h7QAG57ZG60a2nzns2ZIrj9gmIq7316zKM2U5Q8
         zuyL3FY1qkzqH2d2iHI6jAQveTgWQR4xTuSNFHwrKgxEayZyO8QjRMglDA3rH4oKOX9D
         927A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Okg2ZeMO3zh9fmq4j4GK+rVJbHsBLdHZ2ZvqKXHvO9E=;
        b=dsPics22/HnxfRo64NdSKCbC6S+M6Bkwsx/KtPzpFAJ3DEzDsGM6ghBnbUD99K6k/6
         6to6lSQ9MfRr16LxZJbJZZl4xtiahPADgflqXC7evZHFdBjmjJjhQI0/rVPWXjWdZQbi
         SOR/Jq0mbMVB8eTT8xW2IVpG3a7E8je9/WPy3UrvRI/HDgMYe4hgqEo9qIGgs0YJFD0y
         1M5/af6s/bANd67CqwGaq+4uYIbwg422XaOySW3ukpsEEweh0hOBfaxywA1dnS7aDbWP
         H+lTX6UwZ3LzP2C3AiSshjdh1SruNfBq57CSsDnxOaQuwylVoWcxYQtrKeun+liOtxDC
         xWnA==
X-Gm-Message-State: APjAAAVQBvRHuDmaPwOEC1lItkC1UIsCPS880x/C5jFQu7eKUfIAYZ1t
        TL1Ms1ty+o36i6QjFyW9eEfhWsf1
X-Google-Smtp-Source: APXvYqx0PfMSrjuAANcbOPrygMIzWWDcw1C3fCk3kd/XMZSAxsG0xhMJcyEZYSM4GJTG0Qc/zDHe6A==
X-Received: by 2002:a1c:20cf:: with SMTP id g198mr4764515wmg.42.1554233046507;
        Tue, 02 Apr 2019 12:24:06 -0700 (PDT)
Received: from [172.30.88.70] (sjewanfw1-nat.mentorg.com. [139.181.7.34])
        by smtp.gmail.com with ESMTPSA id g19sm14650262wmh.17.2019.04.02.12.24.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 12:24:05 -0700 (PDT)
Subject: Re: [PATCH 15/16] staging: media: imx: add proper SPDX identifiers on
 files that did not have them.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media@vger.kernel.org
References: <20190402103203.14959-1-gregkh@linuxfoundation.org>
 <20190402103203.14959-16-gregkh@linuxfoundation.org>
From:   Steve Longerbeam <slongerbeam@gmail.com>
Message-ID: <701a9e9e-1042-9014-f978-7e2b95d4ea3d@gmail.com>
Date:   Tue, 2 Apr 2019 12:24:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190402103203.14959-16-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Steve Longerbeam <slongerbeam@gmail.com>


On 4/2/19 3:32 AM, Greg Kroah-Hartman wrote:
> There were a few files for the imx media drivers that did not have SPDX
> identifiers on them, so fix that up.  At the same time, remove the "free
> form" text that specified the license of the file, as that is impossible
> for any tool to properly parse.
>
> Cc: Steve Longerbeam <slongerbeam@gmail.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: linux-media@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   drivers/staging/media/imx/imx-ic-common.c         | 6 +-----
>   drivers/staging/media/imx/imx-ic-prp.c            | 6 +-----
>   drivers/staging/media/imx/imx-ic-prpencvf.c       | 6 +-----
>   drivers/staging/media/imx/imx-ic.h                | 6 +-----
>   drivers/staging/media/imx/imx-media-capture.c     | 6 +-----
>   drivers/staging/media/imx/imx-media-csi.c         | 6 +-----
>   drivers/staging/media/imx/imx-media-dev.c         | 6 +-----
>   drivers/staging/media/imx/imx-media-fim.c         | 6 +-----
>   drivers/staging/media/imx/imx-media-internal-sd.c | 6 +-----
>   drivers/staging/media/imx/imx-media-of.c          | 6 +-----
>   drivers/staging/media/imx/imx-media-utils.c       | 6 +-----
>   drivers/staging/media/imx/imx-media-vdic.c        | 6 +-----
>   drivers/staging/media/imx/imx-media.h             | 6 +-----
>   drivers/staging/media/imx/imx6-mipi-csi2.c        | 6 +-----
>   14 files changed, 14 insertions(+), 70 deletions(-)
>
> diff --git a/drivers/staging/media/imx/imx-ic-common.c b/drivers/staging/media/imx/imx-ic-common.c
> index 765919487a73..7e2455097315 100644
> --- a/drivers/staging/media/imx/imx-ic-common.c
> +++ b/drivers/staging/media/imx/imx-ic-common.c
> @@ -1,12 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0+
>   /*
>    * V4L2 Image Converter Subdev for Freescale i.MX5/6 SOC
>    *
>    * Copyright (c) 2014-2016 Mentor Graphics Inc.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
>    */
>   #include <linux/module.h>
>   #include <linux/platform_device.h>
> diff --git a/drivers/staging/media/imx/imx-ic-prp.c b/drivers/staging/media/imx/imx-ic-prp.c
> index 3d43cdcb4bb9..10ffe00f1a54 100644
> --- a/drivers/staging/media/imx/imx-ic-prp.c
> +++ b/drivers/staging/media/imx/imx-ic-prp.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0+
>   /*
>    * V4L2 Capture IC Preprocess Subdev for Freescale i.MX5/6 SOC
>    *
> @@ -6,11 +7,6 @@
>    * for resizing, colorspace conversion, and rotation.
>    *
>    * Copyright (c) 2012-2017 Mentor Graphics Inc.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
>    */
>   #include <linux/delay.h>
>   #include <linux/interrupt.h>
> diff --git a/drivers/staging/media/imx/imx-ic-prpencvf.c b/drivers/staging/media/imx/imx-ic-prpencvf.c
> index 5c8e6ad8c025..1ba4a5154fb5 100644
> --- a/drivers/staging/media/imx/imx-ic-prpencvf.c
> +++ b/drivers/staging/media/imx/imx-ic-prpencvf.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0+
>   /*
>    * V4L2 Capture IC Preprocess Subdev for Freescale i.MX5/6 SOC
>    *
> @@ -6,11 +7,6 @@
>    * for resizing, colorspace conversion, and rotation.
>    *
>    * Copyright (c) 2012-2017 Mentor Graphics Inc.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
>    */
>   #include <linux/delay.h>
>   #include <linux/interrupt.h>
> diff --git a/drivers/staging/media/imx/imx-ic.h b/drivers/staging/media/imx/imx-ic.h
> index 6b2267bda8ab..0dbcf2a7ab5f 100644
> --- a/drivers/staging/media/imx/imx-ic.h
> +++ b/drivers/staging/media/imx/imx-ic.h
> @@ -1,12 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
>   /*
>    * V4L2 Image Converter Subdev for Freescale i.MX5/6 SOC
>    *
>    * Copyright (c) 2016 Mentor Graphics Inc.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
>    */
>   #ifndef _IMX_IC_H
>   #define _IMX_IC_H
> diff --git a/drivers/staging/media/imx/imx-media-capture.c b/drivers/staging/media/imx/imx-media-capture.c
> index facce18975d8..b7ce9d439279 100644
> --- a/drivers/staging/media/imx/imx-media-capture.c
> +++ b/drivers/staging/media/imx/imx-media-capture.c
> @@ -1,12 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0+
>   /*
>    * Video Capture Subdev for Freescale i.MX5/6 SOC
>    *
>    * Copyright (c) 2012-2016 Mentor Graphics Inc.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
>    */
>   #include <linux/delay.h>
>   #include <linux/fs.h>
> diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
> index 3b7517348666..edc0e9a2a90d 100644
> --- a/drivers/staging/media/imx/imx-media-csi.c
> +++ b/drivers/staging/media/imx/imx-media-csi.c
> @@ -1,13 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0+
>   /*
>    * V4L2 Capture CSI Subdev for Freescale i.MX5/6 SOC
>    *
>    * Copyright (c) 2014-2017 Mentor Graphics Inc.
>    * Copyright (C) 2017 Pengutronix, Philipp Zabel <kernel@pengutronix.de>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
>    */
>   #include <linux/delay.h>
>   #include <linux/gcd.h>
> diff --git a/drivers/staging/media/imx/imx-media-dev.c b/drivers/staging/media/imx/imx-media-dev.c
> index 28a3d23aad5b..bd4ddea488f1 100644
> --- a/drivers/staging/media/imx/imx-media-dev.c
> +++ b/drivers/staging/media/imx/imx-media-dev.c
> @@ -1,12 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0+
>   /*
>    * V4L2 Media Controller Driver for Freescale i.MX5/6 SOC
>    *
>    * Copyright (c) 2016 Mentor Graphics Inc.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
>    */
>   #include <linux/delay.h>
>   #include <linux/fs.h>
> diff --git a/drivers/staging/media/imx/imx-media-fim.c b/drivers/staging/media/imx/imx-media-fim.c
> index 8cf773eef9da..2ab64bc30f5c 100644
> --- a/drivers/staging/media/imx/imx-media-fim.c
> +++ b/drivers/staging/media/imx/imx-media-fim.c
> @@ -1,12 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0+
>   /*
>    * Frame Interval Monitor.
>    *
>    * Copyright (c) 2016 Mentor Graphics Inc.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
>    */
>   #include <linux/delay.h>
>   #include <linux/irq.h>
> diff --git a/drivers/staging/media/imx/imx-media-internal-sd.c b/drivers/staging/media/imx/imx-media-internal-sd.c
> index 5e10d95e5529..c547280a309e 100644
> --- a/drivers/staging/media/imx/imx-media-internal-sd.c
> +++ b/drivers/staging/media/imx/imx-media-internal-sd.c
> @@ -1,14 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0+
>   /*
>    * Media driver for Freescale i.MX5/6 SOC
>    *
>    * Adds the internal subdevices and the media links between them.
>    *
>    * Copyright (c) 2016 Mentor Graphics Inc.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
>    */
>   #include <linux/platform_device.h>
>   #include "imx-media.h"
> diff --git a/drivers/staging/media/imx/imx-media-of.c b/drivers/staging/media/imx/imx-media-of.c
> index 03446335ac03..09580d83c685 100644
> --- a/drivers/staging/media/imx/imx-media-of.c
> +++ b/drivers/staging/media/imx/imx-media-of.c
> @@ -1,14 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0+
>   /*
>    * Media driver for Freescale i.MX5/6 SOC
>    *
>    * Open Firmware parsing.
>    *
>    * Copyright (c) 2016 Mentor Graphics Inc.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
>    */
>   #include <linux/of_platform.h>
>   #include <media/v4l2-ctrls.h>
> diff --git a/drivers/staging/media/imx/imx-media-utils.c b/drivers/staging/media/imx/imx-media-utils.c
> index 1c63a2765a81..b41842dba5ec 100644
> --- a/drivers/staging/media/imx/imx-media-utils.c
> +++ b/drivers/staging/media/imx/imx-media-utils.c
> @@ -1,12 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0+
>   /*
>    * V4L2 Media Controller Driver for Freescale i.MX5/6 SOC
>    *
>    * Copyright (c) 2016 Mentor Graphics Inc.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
>    */
>   #include <linux/module.h>
>   #include "imx-media.h"
> diff --git a/drivers/staging/media/imx/imx-media-vdic.c b/drivers/staging/media/imx/imx-media-vdic.c
> index 2808662e2597..3f4b5e9080d4 100644
> --- a/drivers/staging/media/imx/imx-media-vdic.c
> +++ b/drivers/staging/media/imx/imx-media-vdic.c
> @@ -1,12 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0+
>   /*
>    * V4L2 Deinterlacer Subdev for Freescale i.MX5/6 SOC
>    *
>    * Copyright (c) 2017 Mentor Graphics Inc.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
>    */
>   #include <linux/delay.h>
>   #include <linux/interrupt.h>
> diff --git a/drivers/staging/media/imx/imx-media.h b/drivers/staging/media/imx/imx-media.h
> index ae964c8d5be1..1f7501d527fb 100644
> --- a/drivers/staging/media/imx/imx-media.h
> +++ b/drivers/staging/media/imx/imx-media.h
> @@ -1,12 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
>   /*
>    * V4L2 Media Controller Driver for Freescale i.MX5/6 SOC
>    *
>    * Copyright (c) 2016 Mentor Graphics Inc.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
>    */
>   #ifndef _IMX_MEDIA_H
>   #define _IMX_MEDIA_H
> diff --git a/drivers/staging/media/imx/imx6-mipi-csi2.c b/drivers/staging/media/imx/imx6-mipi-csi2.c
> index 2c5e3dd58cea..f29e28df36ed 100644
> --- a/drivers/staging/media/imx/imx6-mipi-csi2.c
> +++ b/drivers/staging/media/imx/imx6-mipi-csi2.c
> @@ -1,12 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0+
>   /*
>    * MIPI CSI-2 Receiver Subdev for Freescale i.MX6 SOC.
>    *
>    * Copyright (c) 2012-2017 Mentor Graphics Inc.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
>    */
>   #include <linux/clk.h>
>   #include <linux/interrupt.h>

