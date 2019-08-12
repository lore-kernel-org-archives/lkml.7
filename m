Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1862EC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6FE2087B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cHadjI9z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfHLHYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 03:24:38 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37215 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfHLHYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:24:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id z23so10833522wmf.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 00:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/EQ4at7WuhC2wsgDOCnM8fQPkTZ0WBVqkzyUHM074KY=;
        b=cHadjI9zYq9B7QDJFUqRjtNhwHVM7kGTATasOgCd5vgV8XXWRHzC/OeCEnqPlgvMam
         Lp1/DmnrmZ54mI+HFQlU/vJ2R1utPJ82ZMev7iorrk9IAMEBq7gVunGCD/6YR4CVSBzp
         HAabL7OFYT6qrCvfbazFbIjT0Up3D59nBmrhqxZNcdu69AhkOmNd/MChnWUNpSjdyhCX
         xdXjR4AA+9yDPHFusoTpiOOhZUAGELmie4DjUG1opjf1I0A5QlQpospoqmAmdg9AuYu2
         B6SuV0q/S92leIOq1a0DSdi+BTnfvrb79FH34CVKMDXdyLEC2K1iIqYrrf/sUI71o5X+
         ct7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/EQ4at7WuhC2wsgDOCnM8fQPkTZ0WBVqkzyUHM074KY=;
        b=IuYRrhwznDbyyhsvN4BEXkEqbXz2i5Do7yBCSAtwGQyx1OkoUj1piL4L5q3Zs3jRmx
         V9CsMURIX3mVfmXlD0XjM2uT5eIGrRXsqGNPwMdy2zWpxmiGkuuvdL0pHp2S3zlO6t7Z
         L3eJVgvViY0qnrqVEmTD7xtJwy8hq2xtlXCNK3J6q4S3rshlUIZJ7dncUVlL/IYrIVJe
         HC+UlMBRjYt2m0YdJjurQ1M1lcl+XSgFBe8qfHK7HBEy5Tfy39IyGlgpojZO1eulHjes
         GL20KFFRcU5cKZ3I+PdHZBpGJJBsdnRH1XqWmJQr2JQI180TQJOeypSbWw6xZzxkDvfj
         4xqw==
X-Gm-Message-State: APjAAAUrhU4ZSJtGZe/1KgZ9i6uRI/gBwqXpx2c1U7s2llH0Titu5NEL
        m7RvXSXVTaJHChAeXCTca0I27w==
X-Google-Smtp-Source: APXvYqz/0fItZ/jY3YSS40ttMi01zPdUVkC5lPKFpM+w2DRebnu3CDXWrCtrSkdWEa+5wFiLK0Qu9A==
X-Received: by 2002:a1c:a1c1:: with SMTP id k184mr26714773wme.81.1565594674247;
        Mon, 12 Aug 2019 00:24:34 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id f17sm18044659wmf.27.2019.08.12.00.24.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 00:24:33 -0700 (PDT)
Date:   Mon, 12 Aug 2019 08:24:31 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Collabora kernel ML <kernel@collabora.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH v5 01/11] mfd / platform: cros_ec: Handle chained ECs as
 platform devices
Message-ID: <20190812072431.GE4594@dell>
References: <20190722133257.9336-1-enric.balletbo@collabora.com>
 <20190722133257.9336-2-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190722133257.9336-2-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2019, Enric Balletbo i Serra wrote:

> An MFD is a device that contains several sub-devices (cells). For instance,
> the ChromeOS EC fits in this description as usually contains a charger and
> can have other devices with different functions like a Real-Time Clock,
> an Audio codec, a Real-Time Clock, ...
> 
> If you look at the driver, though, we're doing something odd. We have
> two MFD cros-ec drivers where one of them (cros-ec-core) instantiates
> another MFD driver as sub-driver (cros-ec-dev), and the latest
> instantiates the different sub-devices (Real-Time Clock, Audio codec,
> etc).
> 
>                   MFD
> ------------------------------------------
>    cros-ec-core
>        |___ mfd-cellA (cros-ec-dev)
>        |       |__ mfd-cell0
>        |       |__ mfd-cell1
>        |       |__ ...
>        |
>        |___ mfd-cellB (cros-ec-dev)
>                |__ mfd-cell0
>                |__ mfd-cell1
>                |__ ...
> 
> The problem that was trying to solve is to describe some kind of topology for
> the case where we have an EC (cros-ec) chained with another EC
> (cros-pd). Apart from that this extends the bounds of what MFD was
> designed to do we might be interested on have other kinds of topology that
> can't be implemented in that way.
> 
> Let's prepare the code to move the cros-ec-core part from MFD to
> platform/chrome as this is clearly a platform specific thing non-related
> to a MFD device.
> 
>   platform/chrome  |         MFD
> ------------------------------------------
>                    |
>    cros-ec ________|___ cros-ec-dev
>                    |       |__ mfd-cell0
>                    |       |__ mfd-cell1
>                    |       |__ ...
>                    |
>    cros-pd ________|___ cros-ec-dev
>                    |        |__ mfd-cell0
>                    |        |__ mfd-cell1
>                    |        |__ ...
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> Tested-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> 
> Changes in v5:
> - Rebased on top of 5.3-rc1
> 
> Changes in v4:
> - Rebase again on top of for-mfd-next to avoid conflicts.
> 
> Changes in v3:
> - Collect more acks an tested-by
> 
> Changes in v2:
> - Collect acks received.
> - Remove '[PATCH 07/10] mfd: cros_ec: Update with SPDX Licence identifier
>   and fix description' to avoid conflicts with some tree-wide patches
>   that actually updates the Licence identifier.
> - Add '[PATCH 10/10] arm/arm64: defconfig: Update configs to use the new
>   CROS_EC options' to update the defconfigs after change some config
>   symbols.
> 
>  drivers/mfd/cros_ec.c                   | 61 +++++++++++++------------
>  drivers/platform/chrome/cros_ec_i2c.c   |  8 ++++
>  drivers/platform/chrome/cros_ec_lpc.c   |  3 +-
>  drivers/platform/chrome/cros_ec_rpmsg.c |  2 +
>  drivers/platform/chrome/cros_ec_spi.c   |  8 ++++
>  include/linux/mfd/cros_ec.h             | 18 ++++++++
>  6 files changed, 69 insertions(+), 31 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
