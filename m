Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A4CC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 10:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524BA217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 10:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rWEsZNtu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731071AbfIBKgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 06:36:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38816 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbfIBKgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 06:36:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id l11so4658378wrx.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 03:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hYv0ybgUE+3VBczzF9okop5DwFXcEXmzNC34Kmlpq8k=;
        b=rWEsZNtuSO1SrL2jIvFZVjNjQmRtCVhs4wMTaLuuK4o3CNfgsX6G5f4SlCFftxCrXI
         AmejjnZEud6EwyfBmKWFGpDVROuxoB4n5nJWiAe+Boipt0/aqRShAR8QAJQncmyjcpkk
         ptRx6iQ/1TW4pCz5aqoudNORo8Db9g+spnRIUajXjrG6i+zs62yZ3imQlMe+U9UsIZOx
         vZgMtJgfP2401wCm6cLD5EG2K9O2ZdCdTXbEyMxz2uIb62siQShbYMCmBclEeEHpNG5U
         cZXu5lIQS9TKGGnfb7I8SyUXUKWoxQ6Afv/rkdtx7DCz3TE5IGFCsrDOeYR4Pahy0M40
         /zdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hYv0ybgUE+3VBczzF9okop5DwFXcEXmzNC34Kmlpq8k=;
        b=KMP9cHLSfyaREjUpMhMm7DnmFPd+DTGRfLb3bgw2bwvC6xJbf5bHxxfIYrgxxldt8M
         K+0MJG59POsyxp5fPMehGMU48LxqEDNlipLBvm7zrXRYvsJYYq9MrIW5ztbv6oM/XHfS
         xYUNCrA8DASz56a9q7MmUoYOZRv69FXdQgMDT+VIzyv0hSCSblLlr//luP2ZbSzS/SAM
         GHNqQ4vEMayayFxFww7ATwB62qDald/8REsl7Sd5AfrZp5zDb3BW3rIAyAmt7QdRZ1wa
         YXm56V/YneDsX3SzKRR3d6cE7sixxCm0mXz64UZRU6tPnuT6I8bEUb9jAZ9wiYO2l82K
         3zug==
X-Gm-Message-State: APjAAAVs8CWAFQ28ztJ3F1w9QhSMjCB89HQ1fgeT+JD87d/RU1+vNM9o
        taF7nw8zylLRV4JBNNISdOI+NA==
X-Google-Smtp-Source: APXvYqzSCATBGAXY5ktq4jrrHvpN5sdGw3Wso8wNvYIym6EUi8X30kHYtfLNnHMstO6NM4LBFQj06w==
X-Received: by 2002:adf:f801:: with SMTP id s1mr36010176wrp.320.1567420596421;
        Mon, 02 Sep 2019 03:36:36 -0700 (PDT)
Received: from dell ([95.147.198.93])
        by smtp.gmail.com with ESMTPSA id s1sm51407893wrg.80.2019.09.02.03.36.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Sep 2019 03:36:35 -0700 (PDT)
Date:   Mon, 2 Sep 2019 11:36:33 +0100
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
        Collabora kernel ML <kernel@collabora.com>, arnd@arndb.de
Subject: [GIT PULL] Immutable branch between MFD, Extcon, HID, I2C, IIO,
 Input, Chrome, Power, PWM, RTC and Sounds due for the v5.4 merge window
Message-ID: <20190902103633.GA26880@dell>
References: <20190902095309.18574-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190902095309.18574-1-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enjoy!

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-extcon-hid-i2c-iio-input-media-chrome-power-pwm-rtc-sound-v5.4

for you to fetch changes up to 28e6fcc871bcff640c8960448034ea3a7c7fdfa3:

  mfd: cros_ec: Use mfd_add_hotplug_devices() helper (2019-09-02 11:34:24 +0100)

----------------------------------------------------------------
Immutable branch between MFD, Extcon, HID, I2C, IIO, Input, Chrome, Power, PWM, RTC and Sounds due for the v5.4 merge window

----------------------------------------------------------------
Enric Balletbo i Serra (10):
      mfd / platform: cros_ec: Handle chained ECs as platform devices
      mfd / platform: cros_ec: Move cros-ec core driver out from MFD
      mfd / platform: cros_ec: Miscellaneous character device to talk with the EC
      mfd: cros_ec: Switch to use the new cros-ec-chardev driver
      mfd / platform: cros_ec: Rename config to a better name
      mfd / platform: cros_ec: Reorganize platform and mfd includes
      mfd: cros_ec: Use kzalloc and cros_ec_cmd_xfer_status helper
      mfd: cros_ec: Add convenience struct to define dedicated CrOS EC MCUs
      mfd: cros_ec: Add convenience struct to define autodetectable CrOS EC subdevices
      mfd: cros_ec: Use mfd_add_hotplug_devices() helper

 drivers/extcon/Kconfig                             |   2 +-
 drivers/extcon/extcon-usbc-cros-ec.c               |   3 +-
 drivers/hid/Kconfig                                |   2 +-
 drivers/hid/hid-google-hammer.c                    |   4 +-
 drivers/i2c/busses/Kconfig                         |   2 +-
 drivers/i2c/busses/i2c-cros-ec-tunnel.c            |   4 +-
 drivers/iio/accel/cros_ec_accel_legacy.c           |   3 +-
 drivers/iio/common/cros_ec_sensors/Kconfig         |   2 +-
 .../iio/common/cros_ec_sensors/cros_ec_lid_angle.c |   3 +-
 .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |   3 +-
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |   3 +-
 drivers/iio/light/cros_ec_light_prox.c             |   3 +-
 drivers/iio/pressure/cros_ec_baro.c                |   3 +-
 drivers/input/keyboard/Kconfig                     |   2 +-
 drivers/input/keyboard/cros_ec_keyb.c              |   4 +-
 drivers/media/platform/Kconfig                     |   3 +-
 drivers/media/platform/cros-ec-cec/cros-ec-cec.c   |   5 +-
 drivers/mfd/Kconfig                                |  26 +-
 drivers/mfd/Makefile                               |   4 +-
 drivers/mfd/cros_ec_dev.c                          | 463 ++++++---------------
 drivers/platform/chrome/Kconfig                    |  60 ++-
 drivers/platform/chrome/Makefile                   |   2 +
 drivers/{mfd => platform/chrome}/cros_ec.c         |  64 +--
 drivers/platform/chrome/cros_ec_chardev.c          | 252 +++++++++++
 drivers/platform/chrome/cros_ec_debugfs.c          |   3 +-
 drivers/platform/chrome/cros_ec_i2c.c              |  12 +-
 drivers/platform/chrome/cros_ec_ishtp.c            |   5 +-
 drivers/platform/chrome/cros_ec_lightbar.c         |   3 +-
 drivers/platform/chrome/cros_ec_lpc.c              |   7 +-
 drivers/platform/chrome/cros_ec_proto.c            |   3 +-
 drivers/platform/chrome/cros_ec_rpmsg.c            |   6 +-
 drivers/platform/chrome/cros_ec_spi.c              |  12 +-
 drivers/platform/chrome/cros_ec_sysfs.c            |   3 +-
 drivers/platform/chrome/cros_ec_trace.c            |   2 +-
 drivers/platform/chrome/cros_ec_trace.h            |   4 +-
 drivers/platform/chrome/cros_ec_vbc.c              |   3 +-
 drivers/platform/chrome/cros_usbpd_logger.c        |   5 +-
 drivers/power/supply/Kconfig                       |   2 +-
 drivers/power/supply/cros_usbpd-charger.c          |   5 +-
 drivers/pwm/Kconfig                                |   2 +-
 drivers/pwm/pwm-cros-ec.c                          |   4 +-
 drivers/rtc/Kconfig                                |   2 +-
 drivers/rtc/rtc-cros-ec.c                          |   3 +-
 include/Kbuild                                     |   2 +-
 include/linux/iio/common/cros_ec_sensors_core.h    |   3 +-
 include/linux/mfd/cros_ec.h                        | 292 -------------
 .../linux/platform_data/cros_ec_chardev.h          |  12 +-
 .../{mfd => platform_data}/cros_ec_commands.h      |   0
 include/linux/platform_data/cros_ec_proto.h        | 319 ++++++++++++++
 sound/soc/codecs/Kconfig                           |   4 +-
 sound/soc/codecs/cros_ec_codec.c                   |   4 +-
 sound/soc/qcom/Kconfig                             |   2 +-
 52 files changed, 900 insertions(+), 746 deletions(-)
 rename drivers/{mfd => platform/chrome}/cros_ec.c (84%)
 create mode 100644 drivers/platform/chrome/cros_ec_chardev.c
 rename drivers/mfd/cros_ec_dev.h => include/linux/platform_data/cros_ec_chardev.h (79%)
 rename include/linux/{mfd => platform_data}/cros_ec_commands.h (100%)
 create mode 100644 include/linux/platform_data/cros_ec_proto.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
