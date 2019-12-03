Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37077C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 21:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA982073F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 21:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mch82JqO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfLCV6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 16:58:08 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40235 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbfLCV6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 16:58:07 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so2226303plp.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 13:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=PV23OO9Xr/Mc2OFDjoQ4/L3wl1TU63dPuuNGie4xRp8=;
        b=Mch82JqOqey/ZSZD+MTASXQQ/KzjPgyFO6PzZBAjIsxytzS5sZEhXOPkr8rEweQsnp
         zQjWcP8YBxtbcQAgY6djkHvMkkum7cZ83fYd3aroVaFrK5lZoP1+Y1giBrn7sUjGfXFq
         JayJOXaVhLZQfeGk6h+BHiS5nQYvhBeFjRLf1waN82sogsPy4S7rVSD4+cKdsZCBmZEV
         mWc7vZFjfMBLQ8dFCYSO0Q4p7nZaC3WHjtLAbOaiynzMf3mYpeUlKsh1cCfZTWsyrMB8
         yclVkVxu3fxY8rmjkyk6ZtHbBEP/S3kXR4hOCH76CfgfLurfK6gQCm7c8C4DxH+HKB3O
         EMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=PV23OO9Xr/Mc2OFDjoQ4/L3wl1TU63dPuuNGie4xRp8=;
        b=KQNZi8R5rUno5DqGeyf1IvTJNiczS7vPT70yS7FrjMmzbI51fgWsRqspKYqhrkik2W
         F7mKh+UIyZUxVgyp8REx4mZNvAncfda+DSL8hIK49kGqaZybGUCveSZNBg1vblxm+Ci+
         EVul5bZ9DzXX0tJ2uGDouYvIGyPQwVBL/8KYeeb2TnMo/2zIl3c8POkiuTNRBIdVCyuE
         qg/yC4wAQylaUJoB8b31bRo3rpsty3Asb7Iab1WmR2dgHuGiWstGdwxoIE+Iiu4BXuHw
         Ku6JrMaQVDYVbq1eJFCJWtyyUCQipTditpi3ZEutgo+0POkjXlkggweYMh90qR3hKN6N
         NOLA==
X-Gm-Message-State: APjAAAUbPYiODllFn+jbkFPUthd4MXxoti2esjv5EY95rKCd81eC/en1
        h3/bN2nkvnQlW9+MWGW3sNLRQQ==
X-Google-Smtp-Source: APXvYqzM1A0P0eBhwkQEGWlnx17IiWlbmP0btON81EiKW0le9Yr/mQiUFUctsqdEzPmj/GCoxhbAWQ==
X-Received: by 2002:a17:90a:d807:: with SMTP id a7mr8219214pjv.15.1575410285936;
        Tue, 03 Dec 2019 13:58:05 -0800 (PST)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id m27sm4747405pff.179.2019.12.03.13.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 13:58:04 -0800 (PST)
Date:   Tue, 3 Dec 2019 13:58:00 -0800
From:   Benson Leung <bleung@google.com>
To:     torvalds@linux-foundation.org
Cc:     bleung@kernel.org, gwendal@chromium.org, bleung@chromium.org,
        bleung@google.com, enric.balletbo@collabora.com,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] chrome-platform changes for v5.5
Message-ID: <20191203215800.GA34130@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git t=
ags/tag-chrome-platform-for-v5.5

for you to fetch changes up to 856a0a6e2d09d31fd8f00cc1fc6645196a509d56:

  platform/chrome: wilco_ec: fix use after free issue (2019-12-02 12:14:42 =
+0100)

----------------------------------------------------------------
chrome platform changes for v5.5

* CrOS EC / MFD / IIO
 - Contains tag-ib-chrome-mfd-iio-input-5.5, which is the first part of a
   series from Gwendal to refactor sensor code between MFD, CrOS EC, iio
   and input in order to add a new sensorhub driver and FIFO processing

* Wilco EC:
 - Add support for Dell's USB PowerShare policy control, keyboard
   backlight LED driver, and a new test_event file.
 - Fixes use after free in wilco_ec's telemetry driver.

* Misc:
 - bugfix in cros_usbpd_logger (missing destroy workqueue).

----------------------------------------------------------------
Chuhong Yuan (1):
      platform/chrome: cros_usbpd_logger: add missed destroy_workqueue in r=
emove

Daniel Campello (3):
      platform/chrome: wilco_ec: Add debugfs test_event file
      platform/chrome: wilco_ec: Add Dell's USB PowerShare Policy control
      platform/chrome: wilco_ec: Add keyboard backlight LED support

Enric Balletbo i Serra (2):
      Merge tag 'tag-ib-chrome-mfd-iio-input-5.5' into chrome-platform-5.5
      platform/chrome: cros_ec: Add Kconfig default for cros-ec-sensorhub

Enrico Granata (1):
      platform/chrome: cros_ec: handle MKBP more events flag

Gwendal Grignou (8):
      platform/chrome: cros_ec: Put docs with the code
      mfd / platform: cros_ec: Add sensor_count and make check_features pub=
lic
      iio / platform: cros_ec: Add cros-ec-sensorhub driver
      mfd / platform / iio: cros_ec: Register sensor through sensorhub
      platform/chrome: cros-ec: Record event timestamp in the hard irq
      platform/chrome: cros_ec: Do not attempt to register a non-positive I=
RQ number
      Revert "Input: cros_ec_keyb - add back missing mask for event_type"
      Revert "Input: cros_ec_keyb: mask out extra flags in event_type"

Krzysztof Kozlowski (1):
      platform/chrome: cros_ec: Fix Kconfig indentation

Nick Crews (1):
      platform/chrome: wilco_ec: Add charging config driver

Wen Yang (1):
      platform/chrome: wilco_ec: fix use after free issue

 Documentation/ABI/testing/sysfs-platform-wilco-ec  |  17 ++
 drivers/iio/accel/cros_ec_accel_legacy.c           |   6 -
 drivers/iio/common/cros_ec_sensors/Kconfig         |   2 +-
 .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |   6 -
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |   4 +-
 drivers/iio/light/cros_ec_light_prox.c             |   6 -
 drivers/input/keyboard/cros_ec_keyb.c              |   6 +-
 drivers/mfd/cros_ec_dev.c                          | 235 +-----------------
 drivers/platform/chrome/Kconfig                    |  19 +-
 drivers/platform/chrome/Makefile                   |   1 +
 drivers/platform/chrome/cros_ec.c                  |  84 ++++++-
 drivers/platform/chrome/cros_ec_ishtp.c            |  25 +-
 drivers/platform/chrome/cros_ec_lpc.c              |  17 +-
 drivers/platform/chrome/cros_ec_proto.c            | 267 +++++++++++++++++=
+---
 drivers/platform/chrome/cros_ec_rpmsg.c            |  19 +-
 drivers/platform/chrome/cros_ec_sensorhub.c        | 199 +++++++++++++++
 drivers/platform/chrome/cros_usbpd_logger.c        |   1 +
 drivers/platform/chrome/wilco_ec/Kconfig           |   2 +-
 drivers/platform/chrome/wilco_ec/Makefile          |   3 +-
 drivers/platform/chrome/wilco_ec/core.c            |  28 ++-
 drivers/platform/chrome/wilco_ec/debugfs.c         |  47 +++-
 drivers/platform/chrome/wilco_ec/keyboard_leds.c   | 191 +++++++++++++++
 drivers/platform/chrome/wilco_ec/sysfs.c           |  91 +++++++
 drivers/platform/chrome/wilco_ec/telemetry.c       |   2 +-
 include/linux/platform_data/cros_ec_proto.h        | 138 +++--------
 include/linux/platform_data/cros_ec_sensorhub.h    |  30 +++
 include/linux/platform_data/wilco-ec.h             |  15 ++
 27 files changed, 1019 insertions(+), 442 deletions(-)
 create mode 100644 drivers/platform/chrome/cros_ec_sensorhub.c
 create mode 100644 drivers/platform/chrome/wilco_ec/keyboard_leds.c
 create mode 100644 include/linux/platform_data/cros_ec_sensorhub.h

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXebaaAAKCRBzbaomhzOw
wnQ/AP9d4B/OfY77BHFmC9bXRpa4KaO5pcZz5siGGcrcdaiv+QEA4aRE6HACbx2M
q/ToQmq+l2WPzHpWOiOvRD1j7FwYzgw=
=BHOH
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
