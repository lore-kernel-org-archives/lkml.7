Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783B3C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 17:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 444E021924
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 17:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dusZAahf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390259AbfISRqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 13:46:51 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43846 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfISRqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 13:46:51 -0400
Received: by mail-pg1-f196.google.com with SMTP id u72so2282238pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 10:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=IzhKb3i/CzHfzdOJa5eIqcw5Dr51MqCu+X55sOcyHF4=;
        b=dusZAahfezV/LH2Rx7HuwLusn4dLmQQrrP8AsTGrazuzUoZHDt16uHc0pxt/eLNZJd
         v5DsncXCTYI1gHNfOd+mgCI7B1um55qEgRRayIpDKyAuDUYg51Jw/3hSvj+Dq3KiGl4C
         YjaeNWil2DO+O204UkMUR2WMSUwfC4UmcG586s9869oS1jmZJsjjG4OE6pud4c99+JhD
         0HQKSFoxWNaTyVnFmqj6Hu+dt4rcRaoC1ohW7wnql6ysplNHttKQH4LR80GMgogBaUG5
         CX3i/Ir6HC+Yjsmj3FCf8MEh1gC9/BvVUZrVaUeh9ow4xzS8xl3I526ay2yOwJjuElok
         HWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=IzhKb3i/CzHfzdOJa5eIqcw5Dr51MqCu+X55sOcyHF4=;
        b=b0mb6xMY1li437Fe2R1yZjFN0KD3h+5fUy12QsrDf3kMcn/ivkpF4FVWMBkF9Go3VE
         /Hsjehzj9SXlhEKee0Q/wZJvJZwVkR6dm3aNlSIIawEEOc89+Xn2PSAuJWHLkVYe+tOS
         q1pChFfCtDwsm60VbuI+5zS1WDyqx4BiB/FizwYLELcAD4dEl1FlpymAR7Ln/NjLw4DQ
         E+VGhykC7v570279pMFM6Z7G7mJqiwycGMwjQB3mQpmjWPu1+AJ5BIgVJ6+RV3vxOCUU
         TfbzZtLq5vuSOmbhKpkPH3fhkHOrBXyxtSoKKGvwbUDWjiK+P0yR8Lg+5zIksYUZv3ae
         Ge+Q==
X-Gm-Message-State: APjAAAWqAlkZwnur8aNrLbuZGdMSjxOcAHnBSlXA5ow4P8QBvm3suNUu
        1mJ7WJuw1nWTc17ZemknalS8lg==
X-Google-Smtp-Source: APXvYqyIdI35XmKFw5ppt4JyG3Au1puYNycZoBehCxd6F5bgLVS4QtkGtgmvFbEi1pyaetCJr3JsGg==
X-Received: by 2002:a17:90a:d351:: with SMTP id i17mr4843185pjx.13.1568915208055;
        Thu, 19 Sep 2019 10:46:48 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id w69sm18642538pgd.91.2019.09.19.10.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 10:46:46 -0700 (PDT)
Date:   Thu, 19 Sep 2019 10:46:41 -0700
From:   Benson Leung <bleung@google.com>
To:     torvalds@linux-foundation.org
Cc:     bleung@kernel.org, gwendal@chromium.org, bleung@chromium.org,
        bleung@google.com, enric.balletbo@collabora.com,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] chrome-platform changes for v5.4
Message-ID: <20190919174641.GA172744@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git t=
ags/tag-chrome-platform-for-v5.4

for you to fetch changes up to 4c1fde5077dcad1a2a10a6a0883c8f94326c4971:

  platform/chrome: cros_usbpd_logger: null check create_singlethread_workqu=
eue (2019-09-12 16:20:54 +0200)

----------------------------------------------------------------
chrome platform changes for v5.4

* CrOS EC / MFD Migration
 - Move cros_ec core driver from mfd into chrome platform.

* Wilco EC:
 - Add batt_ppid_info command to Wilco telemetry driver.

* CrOS EC:
 - cros_ec_rpmsg : Add support to inform EC of suspend/resume status
 - cros_ec_rpmsg : Fix race condition on probe failed
 - cros_ec_chardev : Add a poll handler to receive MKBP events

* Misc:
 - bugfixes in cros_usbpd_logger and cros_ec_ishtp

----------------------------------------------------------------
Benson Leung (1):
      Merge tag 'tag-chrome-platform-fixes-for-v5.3-rc6' into for-next

Enric Balletbo i Serra (12):
      mfd / platform: cros_ec: Handle chained ECs as platform devices
      mfd / platform: cros_ec: Move cros-ec core driver out from MFD
      mfd / platform: cros_ec: Miscellaneous character device to talk with =
the EC
      mfd: cros_ec: Switch to use the new cros-ec-chardev driver
      mfd / platform: cros_ec: Rename config to a better name
      mfd / platform: cros_ec: Reorganize platform and mfd includes
      mfd: cros_ec: Use kzalloc and cros_ec_cmd_xfer_status helper
      mfd: cros_ec: Add convenience struct to define dedicated CrOS EC MCUs
      mfd: cros_ec: Add convenience struct to define autodetectable CrOS EC=
 subdevices
      mfd: cros_ec: Use mfd_add_hotplug_devices() helper
      Merge tag 'ib-mfd-extcon-hid-i2c-iio-input-media-chrome-power-pwm-rtc=
-sound-v5.4' into chrome-platform/for-next
      platform/chrome: cros_ec_chardev: Add a poll handler to receive MKBP =
events

Hyungwoo Yang (1):
      platform/chrome: cros_ec_ishtp: fix crash during suspend

Navid Emamdoost (1):
      platform/chrome: cros_usbpd_logger: null check create_singlethread_wo=
rkqueue

Nick Crews (1):
      platform/chrome: wilco_ec: Add batt_ppid_info command to telemetry dr=
iver

Pi-Hsun Shih (1):
      platform/chrome: cros_ec_rpmsg: Fix race with host command when probe=
 failed

Ravi Chandra Sadineni (1):
      platform/chrome: chromeos_tbmc: Report wake events

Wolfram Sang (1):
      platform/chrome: chromeos_laptop: drop checks of NULL-safe functions

Yilun Lin (1):
      platform/chrome: cros_ec_rpmsg: Add host command AP sleep state suppo=
rt

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
 drivers/mfd/cros_ec_dev.c                          | 463 ++++++-----------=
----
 drivers/platform/chrome/Kconfig                    |  60 ++-
 drivers/platform/chrome/Makefile                   |   2 +
 drivers/platform/chrome/chromeos_laptop.c          |  10 +-
 drivers/platform/chrome/chromeos_tbmc.c            |   2 +
 drivers/{mfd =3D> platform/chrome}/cros_ec.c         |  64 +--
 drivers/platform/chrome/cros_ec_chardev.c          | 419 +++++++++++++++++=
++
 drivers/platform/chrome/cros_ec_debugfs.c          |   3 +-
 drivers/platform/chrome/cros_ec_i2c.c              |  12 +-
 drivers/platform/chrome/cros_ec_ishtp.c            |   9 +-
 drivers/platform/chrome/cros_ec_lightbar.c         |   3 +-
 drivers/platform/chrome/cros_ec_lpc.c              |   7 +-
 drivers/platform/chrome/cros_ec_proto.c            |   3 +-
 drivers/platform/chrome/cros_ec_rpmsg.c            |  57 ++-
 drivers/platform/chrome/cros_ec_spi.c              |  12 +-
 drivers/platform/chrome/cros_ec_sysfs.c            |   3 +-
 drivers/platform/chrome/cros_ec_trace.c            |   2 +-
 drivers/platform/chrome/cros_ec_trace.h            |   4 +-
 drivers/platform/chrome/cros_ec_vbc.c              |   3 +-
 drivers/platform/chrome/cros_usbpd_logger.c        |   8 +-
 drivers/platform/chrome/wilco_ec/telemetry.c       |  64 ++-
 drivers/power/supply/Kconfig                       |   2 +-
 drivers/power/supply/cros_usbpd-charger.c          |   5 +-
 drivers/pwm/Kconfig                                |   2 +-
 drivers/pwm/pwm-cros-ec.c                          |   4 +-
 drivers/rtc/Kconfig                                |   2 +-
 drivers/rtc/rtc-cros-ec.c                          |   3 +-
 include/Kbuild                                     |   2 +-
 include/linux/iio/common/cros_ec_sensors_core.h    |   3 +-
 include/linux/mfd/cros_ec.h                        | 292 -------------
 .../linux/platform_data/cros_ec_chardev.h          |  13 +-
 .../{mfd =3D> platform_data}/cros_ec_commands.h      |   0
 include/linux/platform_data/cros_ec_proto.h        | 319 ++++++++++++++
 sound/soc/codecs/Kconfig                           |   4 +-
 sound/soc/codecs/cros_ec_codec.c                   |   4 +-
 sound/soc/qcom/Kconfig                             |   2 +-
 55 files changed, 1168 insertions(+), 780 deletions(-)
 rename drivers/{mfd =3D> platform/chrome}/cros_ec.c (84%)
 create mode 100644 drivers/platform/chrome/cros_ec_chardev.c
 rename drivers/mfd/cros_ec_dev.h =3D> include/linux/platform_data/cros_ec_=
chardev.h (75%)
 rename include/linux/{mfd =3D> platform_data}/cros_ec_commands.h (100%)
 create mode 100644 include/linux/platform_data/cros_ec_proto.h

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXYO/AQAKCRBzbaomhzOw
wovuAP0WPHbZWCyUvj2YK+wX0QVPxOdfc7fq9GxYVtHlvXUQTwD/V8OUTGZ871yh
eSv9JnvAScg1TbyWIOfTX+Pberxt/g0=
=m0JT
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
