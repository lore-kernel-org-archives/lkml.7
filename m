Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FAFC00307
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 09:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6AE32086D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 09:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bdcic7+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbfIIJxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 05:53:09 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51334 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbfIIJxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 05:53:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id 7so3383905wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 02:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q0Bu4MUr8Rse6QepVD+Mo7/VVrikFAdvAtW78HC8sMg=;
        b=Bdcic7+lcLbSMXP63HOL8yGDSyRidRn33ahnPC9DyBQXs/uzkjDWHM6b+3k/T5b8rP
         B0EcqGZmUCTyCvJUwQmSpboPIL7qnlQNvmgn6UBWaCeq8OxhRiPa784Gi4iG4ziivAHe
         40DI6CbEhX8vC6FpHJuao5Ia8QbiRsojJzGqRn4PvkWrgyaQRQW8cqHcQ+fq9pvmnn57
         OTr9M3sOnmtmha2JM6yxCnLPt3ol5O/t3/kjj+47pamlrROJHzvMxkTNqp0WRQoja+4U
         NN+IVCqxOSJmxpEQRTn+Od7PnTqjxD4F9bnN/lmRbb0qrsSzeSADIEW/BnF3aXzyqR4y
         dEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q0Bu4MUr8Rse6QepVD+Mo7/VVrikFAdvAtW78HC8sMg=;
        b=JEhAaYT6lR7f41LqwOWflCACs0QbahTikU+aOa9iFEPW3IqsPI8HTC7bs2NCuEzvFX
         6Ucbz+QO7x5HTv5e69x90R9VRgV6PeuCRUWY/HyJ2f770vHnySE7dsBSfuGDLX4KwpXY
         LtbN09b3XzFgIEtlNtXyxbP5XS2FDsDm50RG807JjkVdjGYtV3MQt/5imn1cpm/FyoBw
         0slY4IoDh2XfI9Nne9N3/q8dYK88xcQadO+TsqB2f9Q0bqdGEPlm0zUtCb3JE+aJVXmP
         lyQl1BB68oqyYjmg2aLKOap3e6N51fCcMl2hqrs6S0IaVxeoR2ch67O/z2gkf5b7TsnC
         TFvQ==
X-Gm-Message-State: APjAAAXlpz2PEzQZoxoyda+HcVPKzrheAlzrj8eEVVku6ocL9/o5vnF4
        bE1ksL4ZwNjrQzg5Eu3YLx7FBQ==
X-Google-Smtp-Source: APXvYqyD7rIWfK15PwhuVw8tOpuuhFAqh0A4/sE3kYWn0d2L0pLoNlfPN6HlEweSVm7rZWqOpmvIXg==
X-Received: by 2002:a1c:1d85:: with SMTP id d127mr19129801wmd.14.1568022787085;
        Mon, 09 Sep 2019 02:53:07 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id q15sm12234012wmb.28.2019.09.09.02.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 02:53:06 -0700 (PDT)
Date:   Mon, 9 Sep 2019 10:53:04 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jean-Jacques Hiblot <jjhiblot@ti.com>
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        mark.rutland@arm.com, lee.jones@linaro.org, jingoohan1@gmail.com,
        dmurphy@ti.com, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        tomi.valkeinen@ti.com
Subject: Re: [PATCH v4 4/4] backlight: add led-backlight driver
Message-ID: <20190909095304.67ehnpg6gckwpno4@holly.lan>
References: <20190717141514.21171-1-jjhiblot@ti.com>
 <20190717141514.21171-5-jjhiblot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717141514.21171-5-jjhiblot@ti.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 04:15:14PM +0200, Jean-Jacques Hiblot wrote:
> From: Tomi Valkeinen <tomi.valkeinen@ti.com>
> 
> This patch adds a led-backlight driver (led_bl), which is similar to
> pwm_bl except the driver uses a LED class driver to adjust the
> brightness in the HW. Multiple LEDs can be used for a single backlight.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> ---
>  drivers/video/backlight/Kconfig  |   7 +
>  drivers/video/backlight/Makefile |   1 +
>  drivers/video/backlight/led_bl.c | 268 +++++++++++++++++++++++++++++++
>  3 files changed, 276 insertions(+)
>  create mode 100644 drivers/video/backlight/led_bl.c
> 
> diff --git a/drivers/video/backlight/led_bl.c b/drivers/video/backlight/led_bl.c
> new file mode 100644
> index 000000000000..ac5ff78e7859
> --- /dev/null
> +++ b/drivers/video/backlight/led_bl.c
> @@ -0,0 +1,268 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2015-2019 Texas Instruments Incorporated -  http://www.ti.com/
> + * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
> + *
> + * Based on pwm_bl.c
> + */
> +
> +#include <linux/backlight.h>
> +#include <linux/gpio/consumer.h>

Why do we need this header file?

> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#define BKL_FULL_BRIGHTNESS 255

If we really need to have a full intensity constant then shouldn't we
use LED_FULL directly.

> +
> +struct led_bl_data {
> +	struct device		*dev;
> +	struct backlight_device	*bl_dev;
> +	struct led_classdev	**leds;
> +	bool			enabled;
> +	int			nb_leds;
> +	unsigned int		*levels;
> +	unsigned int		default_brightness;
> +	unsigned int		max_brightness;
> +};
> +
> +static int to_led_brightness(struct led_classdev *led, int value)
> +{
> +	return (value * led->max_brightness) / BKL_FULL_BRIGHTNESS;

This code looks broken.

For example led->max_brightness is 127 then the value this
function will pick values is in the interval 0..63 which is
wrong since we are not using the full range of the LED.

Similarly led->max_brightness is > 255 then we'll generate values
that are out-of-range


Daniel.
