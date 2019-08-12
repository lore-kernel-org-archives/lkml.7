Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6EDC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B282087B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hZ7qD4mP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfHLHZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 03:25:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33386 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfHLHZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:25:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so103771285wru.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 00:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=11yg2kZY2EGWgze2Lbg0UUFU1Rc/h3ZItQKf4ZrpjYA=;
        b=hZ7qD4mPYJCW3INiL/R7Ln6McrJj6k0FSdpelbm7c37yKhbpf0HkTd5MXhPgz9FhTM
         490Aq65MJXUxgDLjRcKhHsQWJtNGwGSTDBCKnRXwOEQcGHuS3EuyXoHfu7b4nW6jyv6E
         s4nnqwXYxk/b/61gVM8MJVqz8D3AdjCrCA+bDRnboVR9M/USL9EzjQEXz5d17pg2AYBJ
         595IlksbzR5vbDO/WqigbfFEmRBAqR1gzt7Xd54PLkrK1N24m2vbLW2R8vJIVY1rl6lb
         6iauylJ65MvHuqLPcaxpRgnv4LG9dCmtc6suI1FVFYJ6+KeALOkp2IQ45d18L60Xa19i
         aD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=11yg2kZY2EGWgze2Lbg0UUFU1Rc/h3ZItQKf4ZrpjYA=;
        b=CwphPMpmAhX2O5LGHIygEeYss/oGeDe6IWohtXaHDL6zv83I22cHRRk+/BvGWysiop
         g26N2pbtxJxFNEc8NVsGIhxvofsWqNp1U0pZAHKtmv3k0uhP9mdT1rXN7KT9uRo/6pL8
         ZYKpjmn6gc0yoybMWYQWhJ23uVJcHxDcNLRlXLLdZlgd1TSQnmwWu+9PpMcV8058h46m
         ZXB6sRY1BY+giaU/mWvt6LrE6GuBwjMtPnou2uctQICIOVmQZW/XihZVjIWBsdpjkawy
         BI0oOoQ6kuS8MgbwZ5HnJIu03h4lfzmAzKUGkDLVZP0cC1Punaq8GESDCpGahPm4Qei6
         6OtQ==
X-Gm-Message-State: APjAAAV9YX/WlcVi616Io+03W6ivngXUW6lhvW5KepgzZunWADzKZHni
        bF93feC8jIRqGheS92sVRpYviQ==
X-Google-Smtp-Source: APXvYqyAbxe3mvzGA1RMHhIYEwWsR0Vx2LArOVjYWdROJOH3RWTsA3sVFiA3ZYd2aNonmZNTDCWcWA==
X-Received: by 2002:a5d:494d:: with SMTP id r13mr31649826wrs.82.1565594724814;
        Mon, 12 Aug 2019 00:25:24 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id c15sm50894256wrb.80.2019.08.12.00.25.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 00:25:24 -0700 (PDT)
Date:   Mon, 12 Aug 2019 08:25:22 +0100
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
Subject: Re: [PATCH v5 06/11] mfd / platform: cros_ec: Reorganize platform
 and mfd includes
Message-ID: <20190812072522.GJ4594@dell>
References: <20190722133257.9336-1-enric.balletbo@collabora.com>
 <20190722133257.9336-7-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190722133257.9336-7-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2019, Enric Balletbo i Serra wrote:

> There is a bit of mess between cros-ec mfd includes and platform
> includes. For example, we have a linux/mfd/cros_ec.h include that
> exports the interface implemented in platform/chrome/cros_ec_proto.c. Or
> we have a linux/mfd/cros_ec_commands.h file that is non related to the
> multifunction device (in the sense that is not exporting any function of
> the mfd device). This causes crossed includes between mfd and
> platform/chrome subsystems and makes the code difficult to read, apart
> from creating 'curious' situations where a platform/chrome driver includes
> a linux/mfd/cros_ec.h file just to get the exported functions that are
> implemented in another platform/chrome driver.
> 
> In order to have a better separation on what the cros-ec multifunction
> driver does and what the cros-ec core provides move and rework the
> affected includes doing:
> 
>  - Move cros_ec_commands.h to include/linux/platform_data/cros_ec_commands.h
>  - Get rid of the parts that are implemented in the platform/chrome/cros_ec_proto.c
>    driver from include/linux/mfd/cros_ec.h to a new file
>    include/linux/platform_data/cros_ec_proto.h
>  - Update all the drivers with the new includes, so
>    - Drivers that only need to know about the protocol include
>      - linux/platform_data/cros_ec_proto.h
>      - linux/platform_data/cros_ec_commands.h
>    - Drivers that need to know about the cros-ec mfd device also include
>      - linux/mfd/cros_ec.h
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
> Series changes: 3
> - Fix dereferencing pointer to incomplete type 'struct cros_ec_dev' (lkp)
> ---
> 
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/extcon/extcon-usbc-cros-ec.c          |   3 +-
>  drivers/hid/hid-google-hammer.c               |   4 +-
>  drivers/i2c/busses/i2c-cros-ec-tunnel.c       |   4 +-
>  drivers/iio/accel/cros_ec_accel_legacy.c      |   3 +-
>  .../cros_ec_sensors/cros_ec_lid_angle.c       |   3 +-
>  .../common/cros_ec_sensors/cros_ec_sensors.c  |   3 +-
>  .../cros_ec_sensors/cros_ec_sensors_core.c    |   3 +-
>  drivers/iio/light/cros_ec_light_prox.c        |   3 +-
>  drivers/iio/pressure/cros_ec_baro.c           |   3 +-
>  drivers/input/keyboard/cros_ec_keyb.c         |   4 +-
>  .../media/platform/cros-ec-cec/cros-ec-cec.c  |   5 +-
>  drivers/mfd/cros_ec_dev.c                     |   3 +-
>  drivers/platform/chrome/cros_ec.c             |   3 +-
>  drivers/platform/chrome/cros_ec_chardev.c     |   3 +-
>  drivers/platform/chrome/cros_ec_debugfs.c     |   3 +-
>  drivers/platform/chrome/cros_ec_i2c.c         |   4 +-
>  drivers/platform/chrome/cros_ec_ishtp.c       |   5 +-
>  drivers/platform/chrome/cros_ec_lightbar.c    |   3 +-
>  drivers/platform/chrome/cros_ec_lpc.c         |   4 +-
>  drivers/platform/chrome/cros_ec_proto.c       |   3 +-
>  drivers/platform/chrome/cros_ec_rpmsg.c       |   4 +-
>  drivers/platform/chrome/cros_ec_spi.c         |   4 +-
>  drivers/platform/chrome/cros_ec_sysfs.c       |   3 +-
>  drivers/platform/chrome/cros_ec_trace.c       |   2 +-
>  drivers/platform/chrome/cros_ec_trace.h       |   4 +-
>  drivers/platform/chrome/cros_ec_vbc.c         |   3 +-
>  drivers/platform/chrome/cros_usbpd_logger.c   |   5 +-
>  drivers/power/supply/cros_usbpd-charger.c     |   5 +-
>  drivers/pwm/pwm-cros-ec.c                     |   4 +-
>  drivers/rtc/rtc-cros-ec.c                     |   3 +-
>  .../linux/iio/common/cros_ec_sensors_core.h   |   3 +-
>  include/linux/mfd/cros_ec.h                   | 308 -----------------
>  .../{mfd => platform_data}/cros_ec_commands.h |   0
>  include/linux/platform_data/cros_ec_proto.h   | 317 ++++++++++++++++++
>  sound/soc/codecs/cros_ec_codec.c              |   4 +-
>  35 files changed, 383 insertions(+), 355 deletions(-)
>  rename include/linux/{mfd => platform_data}/cros_ec_commands.h (100%)
>  create mode 100644 include/linux/platform_data/cros_ec_proto.h

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
