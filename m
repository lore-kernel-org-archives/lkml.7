Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3111C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE67206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x/4t2gzj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfHLHYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 03:24:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33308 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfHLHYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:24:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so103769837wru.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 00:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9zWlaqRYNg33Ujw6gX84xxtRqD+/AO06V5Zy/fEvl2U=;
        b=x/4t2gzjTBnjUKUihtJFhrnYyaeNJGOSsaCCnEJdkw16AtqdhNMcUQbgHNnPirVZfc
         /bDy4r0bBjppKrKKngyxFcGQchOmESlbOw6I20b+tgkfFDFks7tDpzXcpBdqH2nsL0b6
         CPg5Uij6VpJ+lomzltFYGgWnBkj1C+rIWSXZ9w1/AmlZHqayTloiFAdlMHNR67o34sST
         puhpgbRfD6IiFlOKjK7euWKQVCX7oAszdB949r9CaHqaIiAqQTjsSTHo8A7hylteEZ6k
         GPT9tbs4q5DhVezyaQzAwrsSKTOhEGy9VJ4k+H6EFiAFdYDv2WWwn3SsIw/iDJiyVY0x
         y/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9zWlaqRYNg33Ujw6gX84xxtRqD+/AO06V5Zy/fEvl2U=;
        b=smxO9zhU8WFNC8Gp/+ein+QwPVh5RxXiG6sBItWfobxiBBH28orez+9FA0C7epdlm+
         LpF+BFIY+DrtcjmtRwdiIvBfpMgitlf8LKJQXcgtoyLwUqJCTkFWUgwBIA6rJfOoO9Vo
         7Xv8cuK0DNAny4EM9vLQFDFC26+x+p39F3cGuThJaceoXi57IClgIrtpMg24A70E56Ij
         pUud6kUH6f5U8hkcRW5ht5CtIiHD0jart7V221nmt6ji8LuyHvt5jJvEzkqgi8GA/MPN
         eLNW2vUlgtF0wkyc6uaO/BnMCntDdq/9fqCeM0MWlBg/O1AYcGiJ8Vz4/K8RQVofRUiW
         nFpg==
X-Gm-Message-State: APjAAAXWbac5V2xq9edJaVWGw9vfVSvIEok9vlLwD905bf10tFmejqCm
        HwH525TlgtV2o/1eXeFNYM7D6g==
X-Google-Smtp-Source: APXvYqx2c35NApNszr2AuXiAK8tFn5aJcPO/gWfDYaXXjxlyJIeTtYNK4gOiVYOQ0gGav8S4WfVatw==
X-Received: by 2002:adf:90d0:: with SMTP id i74mr26035572wri.218.1565594683417;
        Mon, 12 Aug 2019 00:24:43 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id 39sm11769739wrc.45.2019.08.12.00.24.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 00:24:42 -0700 (PDT)
Date:   Mon, 12 Aug 2019 08:24:40 +0100
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
        Wolfram Sang <wsa@the-dreams.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH v5 02/11] mfd / platform: cros_ec: Move cros-ec core
 driver out from MFD
Message-ID: <20190812072440.GF4594@dell>
References: <20190722133257.9336-1-enric.balletbo@collabora.com>
 <20190722133257.9336-3-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190722133257.9336-3-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2019, Enric Balletbo i Serra wrote:

> Now, the ChromeOS EC core driver has nothing related to an MFD device, so
> move that driver from the MFD subsystem to the platform/chrome subsystem.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Thierry Reding <thierry.reding@gmail.com>
> Acked-by: Mark Brown <broonie@kernel.org>
> Acked-by: Wolfram Sang <wsa@the-dreams.de>
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> Tested-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> 
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/extcon/Kconfig                     |  2 +-
>  drivers/hid/Kconfig                        |  2 +-
>  drivers/i2c/busses/Kconfig                 |  2 +-
>  drivers/iio/common/cros_ec_sensors/Kconfig |  2 +-
>  drivers/input/keyboard/Kconfig             |  2 +-
>  drivers/media/platform/Kconfig             |  3 +--
>  drivers/mfd/Kconfig                        | 15 ++-------------
>  drivers/mfd/Makefile                       |  2 --
>  drivers/platform/chrome/Kconfig            | 21 +++++++++++++++++----
>  drivers/platform/chrome/Makefile           |  1 +
>  drivers/{mfd => platform/chrome}/cros_ec.c |  0
>  drivers/power/supply/Kconfig               |  2 +-
>  drivers/pwm/Kconfig                        |  2 +-
>  drivers/rtc/Kconfig                        |  2 +-
>  sound/soc/codecs/Kconfig                   |  4 ++--
>  sound/soc/qcom/Kconfig                     |  2 +-
>  16 files changed, 32 insertions(+), 32 deletions(-)
>  rename drivers/{mfd => platform/chrome}/cros_ec.c (100%)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
