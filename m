Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AD8C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 17:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6225D206C2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 17:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aR+tdqTX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388256AbfIVRvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 13:51:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46574 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387763AbfIVRvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 13:51:03 -0400
Received: by mail-pf1-f196.google.com with SMTP id q5so7533806pfg.13
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2019 10:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E9hJK7fyg7Gs3bpoyJzsS+U/mgxQqM+p1WatcscDVEE=;
        b=aR+tdqTXd7HoN2kKoAqrYMQnvsbRZxgLGddysD5qblRr5owBy4z+YCb+qQGEErn7a7
         lluVppu5cCoW6vZwOllqDZnv5Knh4jluUpvyFIfZzclA5jCBh1va+/e8GwqVDKnxfl2u
         ZXryGM9pD875iE7m5P9/Ydj9zFAsazt9Ff/6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E9hJK7fyg7Gs3bpoyJzsS+U/mgxQqM+p1WatcscDVEE=;
        b=YOMeQOPzJVe59rDsG1WU9xN2+Ywbx67B2F0jdWwLDxqiqjXAecVeNi0OpCdY+1vC1A
         srA2uc4FYhkXRLL9kRowoiONG535OPwsdg4CanxJ0hTt8qv/8T4K013gUusxh0dpNjSW
         NWYH8iidEOYtt3iLNHTRCD1xG6Pq8y0BG8t3eibwZ9nBCiQvjbdmCzRa6LAi1kaqtv4g
         nytdGhMrVLYf7viBfGbvymg+F+VXnKjF6kQbXYQ3h+gPtYif7H6/psDIg/6NXfrbduXd
         LV+IRTKRaJhl5x+REIS4cVFM49hygtr3/e74eWaASgkGqmHWD7WeuGOincuF3RHMaq4V
         SlOg==
X-Gm-Message-State: APjAAAUcWieR409PY3GiJKcmEbvpY7bUtTdnc1Tcf0iSl13Ix3F4k6UR
        8/ArGSyOmtrO0lshLeuM9rYdwg==
X-Google-Smtp-Source: APXvYqzzYyMeiwfV+Lu/yawXRncC8IyhxytseRsW7w6m1sGcaLUrYmN6QCuhUbXeu9fo9mdsApNJfQ==
X-Received: by 2002:a62:4d45:: with SMTP id a66mr29826494pfb.24.1569174661540;
        Sun, 22 Sep 2019 10:51:01 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id u5sm10881646pfl.25.2019.09.22.10.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2019 10:51:00 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 00/13] cros_ec: Add sensorhub driver and FIFO processing
Date:   Sun, 22 Sep 2019 10:50:08 -0700
Message-Id: <20190922175021.53449-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds a sensorhub driver for spreading sensor
events coming from the Embedded controller sensor FIFO:

       +---------------+ +--------------+ +----
       | cros_ec_accel | | cros_ec_gyro | | ...
       +---------------+ +--------------+ +----
           id:0       \        id:1 |       / id:..
                 +------------------------------+
                 |       cros_ec_sensorhub      |
                 +------------------------------+
                 |           cros_ec_dev        |
                 +------------------------------+
                 | cros_ec_i2c, cros_ec_lpc, .. |
                 +------------------------------+
                                 |
                                 EC

When new sensors events are present, the EC raises and interrupt,
sensorhub reads the FIFO and uses the 'id' field to spread the event to
the proper IIO sensors. This stack is similar to the HID sensor input
stack.

The first 3 patches add a primitive cros_ec_sensorhub. MFD just have to
register this driver if at least one sensor is presented by the EC.
cros_ec_sensorhub retrieves more information from the EC to find out
which sensors are actually present:
  mfd: cros_ec: Add sensor_count and make check_features public
  platform: cros_ec: Add cros_ec_sensor_hub driver
  platform/mfd:iio: cros_ec: Register sensor through sensorhub

The next 3 patches prepare for FIFO support:
  platform: chrome: cros-ec: record event timestamp in the hard irq
  platform: chrome: cros_ec: Do not attempt to register a non-positive
  platform: chrome: cros_ec: handle MKBP more events flag

The next 4 patches add FIFO support. An interface is added to connect
the IIO sensors with cros_ec_sensorhub, and filters are needed to spread
the timestamp when the EC send batches of events and deal with variation
in interrupt delay.
  platform: chrome: sensorhub: Add FIFO support
  platform: chrome: sensorhub: Add code to spread timestmap
  platform: chrome: sensorhub: Add median filter
  iio: cros_ec: Use triggered buffer only when EC does not support FIFO

Finally, the last 3 patches present sensor information following the IIO
ABI:
-  Configurable EC timeout to allow batch mode in buffer/hwfifo_timeout,
  in seconds.
-  Hard coded EC FIFO size in buffer/hwfifo_watermark_max
-  Sensor sampling frequency in hertz at sampling_frequency:
  iio: cros_ec: Expose hwfifo_timeout
  iio: cros_ec: Report hwfifo_watermark_max
  iio: cros_ec: Use Hertz as unit for sampling frequency

For testing, libiio test tools can be used:
A iio device link looks like:
iio:device1 ->
...09:00/GOOG0004:00/cros-ec-dev.6.auto/cros-ec-sensorhub.7.auto/
                     cros-ec-accel.15.auto/iio:device1

When FIFO is available, no trigger are presented. Once
sampling_freqeuncy and hwfifo_timeout are set, sensor events flow
when listening to /dev/iio:device1:
echo 12 > sampling_frequency   # Set ODR to at least 12Hz
echo .100 > buffer/hwfifo_timeout  # do not wait more than 100ms to
                                   # to send samples
iio_readdev -b 2 -T 1000 -s 2 iio:device1 2>/dev/null| od -x
0000000 ffd0 2e20 d990 0000 8630 b56c 07ea 0000
0000020 ffc0 2e10 d970 0000 877e b56c 07ea 0000
0000040`

When FIFO is not supported by the EC, a trigger is present in the
directory. After registering a trigger, setting sampling_frequency,
the latest data collected by the sensor will be retrieved by the host
when the trigger expires.

When cros_ec_accel_legacy driver is used, no FIFO is supported and the
sampling frequency for the accelerometers is hard coded at 10Hz.

This set is built upon the master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git


Enrico Granata (2):
  platform: chrome: cros_ec: Do not attempt to register a non-positive
    IRQ number
  platform: chrome: cros_ec: handle MKBP more events flag

Gwendal Grignou (11):
  mfd: cros_ec: Add sensor_count and make check_features public
  platform: cros_ec: Add cros_ec_sensor_hub driver
  platform/mfd:iio: cros_ec: Register sensor through sensorhub
  platform: chrome: cros-ec: record event timestamp in the hard irq
  platform: chrome: sensorhub: Add FIFO support
  platform: chrome: sensorhub: Add code to spread timestmap
  platform: chrome: sensorhub: Add median filter
  iio: cros_ec: Use triggered buffer only when EC does not support FIFO
  iio: cros_ec: Expose hwfifo_timeout
  iio: cros_ec: Report hwfifo_watermark_max
  iio: cros_ec: Use Hertz as unit for sampling frequency

 drivers/iio/accel/cros_ec_accel_legacy.c      |  13 +-
 drivers/iio/common/cros_ec_sensors/Kconfig    |   2 +-
 .../cros_ec_sensors/cros_ec_lid_angle.c       |   2 +-
 .../common/cros_ec_sensors/cros_ec_sensors.c  |  14 +-
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 251 ++++-
 drivers/iio/light/cros_ec_light_prox.c        |  18 +-
 drivers/iio/pressure/cros_ec_baro.c           |  12 +-
 drivers/mfd/cros_ec_dev.c                     | 208 +---
 drivers/platform/chrome/Kconfig               |  18 +-
 drivers/platform/chrome/Makefile              |   2 +
 drivers/platform/chrome/cros_ec.c             |  51 +-
 drivers/platform/chrome/cros_ec_lpc.c         |   2 +
 drivers/platform/chrome/cros_ec_proto.c       |  51 +-
 drivers/platform/chrome/cros_ec_sensorhub.c   | 269 +++++
 .../platform/chrome/cros_ec_sensorhub_ring.c  | 918 ++++++++++++++++++
 .../linux/iio/common/cros_ec_sensors_core.h   |  29 +-
 include/linux/mfd/cros_ec.h                   |  17 +
 include/linux/platform_data/cros_ec_proto.h   |  30 +-
 .../linux/platform_data/cros_ec_sensorhub.h   | 173 ++++
 19 files changed, 1780 insertions(+), 300 deletions(-)
 create mode 100644 drivers/platform/chrome/cros_ec_sensorhub.c
 create mode 100644 drivers/platform/chrome/cros_ec_sensorhub_ring.c
 create mode 100644 include/linux/platform_data/cros_ec_sensorhub.h

-- 
2.23.0.351.gc4317032e6-goog

