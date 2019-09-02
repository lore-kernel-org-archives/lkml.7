Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C68C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A69D217D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbfIBJxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 05:53:20 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46620 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729626AbfIBJxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 05:53:19 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id CA5C328CB6E
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Collabora kernel ML <kernel@collabora.com>, arnd@arndb.de
Subject: [PATCH v7 00/10] Move part of cros-ec out of MFD subsystem
Date:   Mon,  2 Sep 2019 11:52:59 +0200
Message-Id: <20190902095309.18574-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Now that rc1 is released is time to send another patchset rebased on
top. This is an attempt to clean up a bit more the cros-ec driver
to have a better separation on what is part of the MFD subsystem and
what is part of platform/chrome.

The major changes introduced by this patchset are:
1. Move the core driver to platform/chrome, as is not really related
   to an MFD device driver.
2. Create a new misc chardev driver to replace the chardev bits from
   cros-ec-dev (MFD)
3. Added some convenience structs on cros-ec-dev (MFD) to easy add
   more subdrivers avoiding to add more boiler plate.

Once applied we have moved all the code to platform/chrome except
the cros-ec-dev driver, which is the one that instantiates the different
subdrivers as cells of the MFD driver.

I tested the following patches on Veyron, Kevin, Samus, Peach Pi and
Peach Pit without noticing any problem, but they would need more
tests.

Thanks,
  Enric

Changes in v7:
- Add a transitional config option to help bisectability (Arnd, Lee)
- Add Acket-by tags from Lee Jones.

Changes in v6:
- Rebase on top of for-mfd-next to avoid conflicts.
- Add Acked-by tags from Lee Jones.
- Move cros_ec_chardev.h to include/linux/platform_data
- Add a break statement once the MCU type has been determined (Lee Jones)
- Improve patch description stating the reason of the change (Lee Jones)

Changes in v5:
- Prefix the versions strings with CROS_EC_DEV_VERSION (Gwendal)

Changes in v4:
- Rebase on top of for-mfd-next to avoid conflicts.

Changes in v3:
- Collect more acks an tested-by
- Fix 'linux/mfd/cros_ec.h' is not exported (reported by lkp)
- Use mfd_add_hotplug_devices helper (Gwendal)
- Add a new patch to use mfd_add_hoplug_devices to register subdevices

Changes in v2:
- Collect acks received.
- Remove '[PATCH 07/10] mfd: cros_ec: Update with SPDX Licence identifier
  and fix description' to avoid conflicts with some tree-wide patches
  that actually updates the Licence identifier.
- Add '[PATCH 10/10] arm/arm64: defconfig: Update configs to use the new
  CROS_EC options' to update the defconfigs after change some config
  symbols.
- Remove the list, and the lock, as are not needed (Greg Kroah-Hartman)
- Remove dev_info in probe, anyway we will see the chardev or not if the
  probe fails (Greg Kroah-Hartman)

Enric Balletbo i Serra (10):
  mfd / platform: cros_ec: Handle chained ECs as platform devices
  mfd / platform: cros_ec: Move cros-ec core driver out from MFD
  mfd / platform: cros_ec: Miscellaneous character device to talk with
    the EC
  mfd: cros_ec: Switch to use the new cros-ec-chardev driver
  mfd / platform: cros_ec: Rename config to a better name
  mfd / platform: cros_ec: Reorganize platform and mfd includes
  mfd: cros_ec: Use kzalloc and cros_ec_cmd_xfer_status helper
  mfd: cros_ec: Add convenience struct to define dedicated CrOS EC MCUs
  mfd: cros_ec: Add convenience struct to define autodetectable CrOS EC
    subdevices
  mfd: cros_ec: Use mfd_add_hotplug_devices() helper

 drivers/extcon/Kconfig                        |   2 +-
 drivers/extcon/extcon-usbc-cros-ec.c          |   3 +-
 drivers/hid/Kconfig                           |   2 +-
 drivers/hid/hid-google-hammer.c               |   4 +-
 drivers/i2c/busses/Kconfig                    |   2 +-
 drivers/i2c/busses/i2c-cros-ec-tunnel.c       |   4 +-
 drivers/iio/accel/cros_ec_accel_legacy.c      |   3 +-
 drivers/iio/common/cros_ec_sensors/Kconfig    |   2 +-
 .../cros_ec_sensors/cros_ec_lid_angle.c       |   3 +-
 .../common/cros_ec_sensors/cros_ec_sensors.c  |   3 +-
 .../cros_ec_sensors/cros_ec_sensors_core.c    |   3 +-
 drivers/iio/light/cros_ec_light_prox.c        |   3 +-
 drivers/iio/pressure/cros_ec_baro.c           |   3 +-
 drivers/input/keyboard/Kconfig                |   2 +-
 drivers/input/keyboard/cros_ec_keyb.c         |   4 +-
 drivers/media/platform/Kconfig                |   3 +-
 .../media/platform/cros-ec-cec/cros-ec-cec.c  |   5 +-
 drivers/mfd/Kconfig                           |  26 +-
 drivers/mfd/Makefile                          |   4 +-
 drivers/mfd/cros_ec_dev.c                     | 463 ++++++------------
 drivers/platform/chrome/Kconfig               |  60 ++-
 drivers/platform/chrome/Makefile              |   2 +
 drivers/{mfd => platform/chrome}/cros_ec.c    |  64 +--
 drivers/platform/chrome/cros_ec_chardev.c     | 252 ++++++++++
 drivers/platform/chrome/cros_ec_debugfs.c     |   3 +-
 drivers/platform/chrome/cros_ec_i2c.c         |  12 +-
 drivers/platform/chrome/cros_ec_ishtp.c       |   5 +-
 drivers/platform/chrome/cros_ec_lightbar.c    |   3 +-
 drivers/platform/chrome/cros_ec_lpc.c         |   7 +-
 drivers/platform/chrome/cros_ec_proto.c       |   3 +-
 drivers/platform/chrome/cros_ec_rpmsg.c       |   6 +-
 drivers/platform/chrome/cros_ec_spi.c         |  12 +-
 drivers/platform/chrome/cros_ec_sysfs.c       |   3 +-
 drivers/platform/chrome/cros_ec_trace.c       |   2 +-
 drivers/platform/chrome/cros_ec_trace.h       |   4 +-
 drivers/platform/chrome/cros_ec_vbc.c         |   3 +-
 drivers/platform/chrome/cros_usbpd_logger.c   |   5 +-
 drivers/power/supply/Kconfig                  |   2 +-
 drivers/power/supply/cros_usbpd-charger.c     |   5 +-
 drivers/pwm/Kconfig                           |   2 +-
 drivers/pwm/pwm-cros-ec.c                     |   4 +-
 drivers/rtc/Kconfig                           |   2 +-
 drivers/rtc/rtc-cros-ec.c                     |   3 +-
 include/Kbuild                                |   2 +-
 .../linux/iio/common/cros_ec_sensors_core.h   |   3 +-
 include/linux/mfd/cros_ec.h                   | 292 -----------
 .../linux/platform_data/cros_ec_chardev.h     |  12 +-
 .../{mfd => platform_data}/cros_ec_commands.h |   0
 include/linux/platform_data/cros_ec_proto.h   | 319 ++++++++++++
 sound/soc/codecs/Kconfig                      |   4 +-
 sound/soc/codecs/cros_ec_codec.c              |   4 +-
 sound/soc/qcom/Kconfig                        |   2 +-
 52 files changed, 900 insertions(+), 746 deletions(-)
 rename drivers/{mfd => platform/chrome}/cros_ec.c (84%)
 create mode 100644 drivers/platform/chrome/cros_ec_chardev.c
 rename drivers/mfd/cros_ec_dev.h => include/linux/platform_data/cros_ec_chardev.h (79%)
 rename include/linux/{mfd => platform_data}/cros_ec_commands.h (100%)
 create mode 100644 include/linux/platform_data/cros_ec_proto.h

-- 
2.20.1

