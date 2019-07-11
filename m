Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB76C74A35
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 15:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA48320872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 15:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UGM03b7P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbfGKPZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 11:25:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44348 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbfGKPZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 11:25:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id i18so3097329pgl.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 08:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=sXRjt3wHITvXGn/rIbtIA2lYimSJe3tLFSQhwUeZ2Qk=;
        b=UGM03b7PSKokRzTqlSyyUPbNi3KR+0hFYFIrqZl4RNgxLzMx34xdkXtDpmI7B6xc9K
         ahgoGJDA9T4dhxqPdQ1VVX4y9WCys/QZ16k+6Ejvep87zsRt3hPS2Qih2C6KH8PSrGwf
         SFM53ljESkgIAUXqsSjU1ajvKefLEZ1EVdJO5q7k07Qr205nnp9LdJd5p9Z0CiiU3zDg
         H/lHCfFU5MujXvNtuicEh8t7iP/2H9CiOhOe7dBl9WICB9CnoQiEcSWfxkRzofRPchLH
         zQbzxjwxkB3h9UtUZqEJeNHl2utyZUbhmNir4A+K29lKJbrzi0MEXrqCc5TcubOVese6
         rVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=sXRjt3wHITvXGn/rIbtIA2lYimSJe3tLFSQhwUeZ2Qk=;
        b=cHm8siljlty4zTd1hpcDQ94j1Wkv/xj3Hk7q8U4ab1ATaKhAwaZvdfBup+bpaxGlEt
         8jbn85tSFW+bVBTDfK9LtQ9VqE0tW4V1nAeL+JCRtvam+JIcgMgWh4aPHr0I6OLdMHwY
         4LBj/HLt8rPmhkGzmVfdKHHYz+msgwWQxwAaprhqX/X+s/dNYANjKlHSRQNNNkV4m2lg
         CBPaK0kTz/A562Z+f8as4n0cmaGR002ziRXqD1kDQXns8dB8ghvoF2M/8uRxbm5lfyIm
         HoUmBRZ8U81+g09c1W0gNcMVWyzUtGVBfpArR8GFAr26siVvxEfkALktAzmu1J3Udg3D
         /wug==
X-Gm-Message-State: APjAAAXc9jIyBCIa9KqX6/WhC6SkKQSdkimdjN7WDJp7lndnSoFyv0xJ
        9B9avogeLCri2Ghq68dFx8tiXQ==
X-Google-Smtp-Source: APXvYqzShU4mBbbSRm/iNOULp6Pb1Iyj3LaMluA+HbMysAJ3aZlwgwwfS3w1GK8T0ZPyQfzBOPD//Q==
X-Received: by 2002:a63:e54f:: with SMTP id z15mr5037150pgj.4.1562858707591;
        Thu, 11 Jul 2019 08:25:07 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id p15sm5630883pjf.27.2019.07.11.08.25.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 08:25:06 -0700 (PDT)
Date:   Thu, 11 Jul 2019 08:25:01 -0700
From:   Benson Leung <bleung@google.com>
To:     torvalds@linux-foundation.org
Cc:     bleung@kernel.org, gwendal@chromium.org, bleung@chromium.org,
        bleung@google.com, enric.balletbo@collabora.com,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] chrome-platform changes for v5.3
Message-ID: <20190711152501.GA190607@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git t=
ags/tag-chrome-platform-for-v5.3

for you to fetch changes up to 8c3166e17cf10161d2871dfb1d017287c7b79ff1:

  mfd / platform: cros_ec_debugfs: Expose resume result via debugfs (2019-0=
7-01 15:39:11 +0200)

----------------------------------------------------------------
chrome platform changes for v5.3

* CrOS EC:

- Add new CrOS ISHTP transport protocol
- Add proper documentation for debugfs entries and expose resume and uptime=
 files
- Select LPC transport protocol variant at runtime.
- Add lid angle sensor driver
- Fix oops on suspend/resume for lightbar driver
- Set CrOS SPI transport protol in realtime

* Wilco EC:

- Add telemetry char device interface
- Add support for event handling
- Add new sysfs attributes

* Misc:
- Contains ib-mfd-cros-v5.3 immutable branch from mfd, with cros_ec_command=
s.h
  header freshly synced with Chrome OS's EC project.

----------------------------------------------------------------
Douglas Anderson (3):
      platform/chrome: cros_ec_spi: Move to real time priority for transfers
      spi: Allow SPI devices to request the pumping thread be realtime
      platform/chrome: cros_ec_spi: Request the SPI thread be realtime

Enric Balletbo i Serra (7):
      Merge tag 'spi-rt-pump' into chrome-platform/for-next
      Merge tag 'ib-mfd-cros-v5.3' into chrome-platform/for-next
      platform/chrome: cros_ec_debugfs: Fix kernel-doc comment first line
      platform/chrome: cros_ec_debugfs: Add debugfs ABI documentation
      platform/chrome: cros_ec_lpc: Merge cros_ec_lpc and cros_ec_lpc_reg
      platform/chrome: cros_ec_lpc: Choose Microchip EC at runtime
      platform/chrome: cros_ec_lpc_mec: Fix kernel-doc comment first line

Evan Green (2):
      platform/chrome: cros_ec_spi: Always add of_match_table
      mfd / platform: cros_ec_debugfs: Expose resume result via debugfs

Gwendal Grignou (31):
      mfd: cros_ec: Update license term
      mfd: cros_ec: Zero BUILD_ macro
      mfd: cros_ec: set comments properly
      mfd: cros_ec: add ec_align macros
      mfd: cros_ec: Define commands as 4-digit UPPER CASE hex values
      mfd: cros_ec: use BIT macro
      mfd: cros_ec: Update ACPI interface definition
      mfd: cros_ec: move HDMI CEC API definition
      mfd: cros_ec: Remove zero-size structs
      mfd: cros_ec: Add Flash V2 commands API
      mfd: cros_ec: Add PWM_SET_DUTY API
      mfd: cros_ec: Add lightbar v2 API
      mfd: cros_ec: Expand hash API
      mfd: cros_ec: Add EC transport protocol v4
      mfd: cros_ec: Complete MEMS sensor API
      mfd: cros_ec: Fix event processing API
      mfd: cros_ec: Add fingerprint API
      mfd: cros_ec: Fix temperature API
      mfd: cros_ec: Complete Power and USB PD API
      mfd: cros_ec: Add API for keyboard testing
      mfd: cros_ec: Add Hibernate API
      mfd: cros_ec: Add Smart Battery Firmware update API
      mfd: cros_ec: Add I2C passthru protection API
      mfd: cros_ec: Add API for EC-EC communication
      mfd: cros_ec: Add API for Touchpad support
      mfd: cros_ec: Add API for Fingerprint support
      mfd: cros_ec: Add API for rwsig
      mfd: cros_ec: Add SKU ID and Secure storage API
      mfd: cros_ec: Add Management API entry points
      mfd: cros_ec: Update I2S API
      iio: cros_ec: Add lid angle driver

Nick Crews (7):
      platform/chrome: wilco_ec: Add property helper library
      platform/chrome: wilco_ec: Add Boot on AC support
      platform/chrome: wilco_ec: Remove 256 byte transfers
      platform/chrome: wilco_ec: Add event handling
      platform/chrome: wilco_ec: Add telemetry char device interface
      platform/chrome: wilco_ec: Fix unreleased lock in event_read()
      platform/chrome: wilco_ec: Add circular buffer as event queue

Rajat Jain (1):
      platform/chrome: lightbar: Get drvdata from parent in suspend/resume

Raul E Rangel (1):
      platform/chrome: wilco_ec: Add version sysfs entries

Rushikesh S Kadam (1):
      platform/chrome: Add ChromeOS EC ISHTP driver

Tim Wawrzynczak (1):
      platform/chrome: cros_ec_debugfs: Add debugfs entry to retrieve EC up=
time

Ting Shen (1):
      Input: cros_ec_keyb: mask out extra flags in event_type

YueHaibing (1):
      platform/chrome: cros_ec: Make some symbols static

kbuild test robot (1):
      platform/chrome: cros_ec_debugfs: cros_ec_uptime_fops can be static

 Documentation/ABI/testing/debugfs-cros-ec          |   56 +
 Documentation/ABI/testing/debugfs-wilco-ec         |   16 +-
 Documentation/ABI/testing/sysfs-platform-wilco-ec  |   40 +
 drivers/iio/common/cros_ec_sensors/Kconfig         |    9 +
 drivers/iio/common/cros_ec_sensors/Makefile        |    1 +
 .../iio/common/cros_ec_sensors/cros_ec_lid_angle.c |  139 +
 drivers/input/keyboard/cros_ec_keyb.c              |    2 +-
 drivers/mfd/cros_ec.c                              |    6 +-
 drivers/platform/chrome/Kconfig                    |   42 +-
 drivers/platform/chrome/Makefile                   |    4 +-
 drivers/platform/chrome/cros_ec_debugfs.c          |   48 +-
 drivers/platform/chrome/cros_ec_ishtp.c            |  763 ++++
 drivers/platform/chrome/cros_ec_lightbar.c         |    6 +-
 drivers/platform/chrome/cros_ec_lpc.c              |  165 +-
 drivers/platform/chrome/cros_ec_lpc_mec.c          |   14 +-
 drivers/platform/chrome/cros_ec_lpc_reg.c          |  101 -
 drivers/platform/chrome/cros_ec_lpc_reg.h          |   45 -
 drivers/platform/chrome/cros_ec_spi.c              |   68 +-
 drivers/platform/chrome/cros_ec_sysfs.c            |    2 +-
 drivers/platform/chrome/cros_ec_vbc.c              |    2 +-
 drivers/platform/chrome/wilco_ec/Kconfig           |   18 +-
 drivers/platform/chrome/wilco_ec/Makefile          |    6 +-
 drivers/platform/chrome/wilco_ec/core.c            |   26 +-
 drivers/platform/chrome/wilco_ec/debugfs.c         |   12 +-
 drivers/platform/chrome/wilco_ec/event.c           |  581 ++++
 drivers/platform/chrome/wilco_ec/mailbox.c         |   21 +-
 drivers/platform/chrome/wilco_ec/properties.c      |  132 +
 drivers/platform/chrome/wilco_ec/sysfs.c           |  156 +
 drivers/platform/chrome/wilco_ec/telemetry.c       |  450 +++
 drivers/spi/spi.c                                  |   36 +-
 include/linux/mfd/cros_ec.h                        |    1 +
 include/linux/mfd/cros_ec_commands.h               | 3658 ++++++++++++++++=
----
 include/linux/platform_data/wilco-ec.h             |   94 +-
 include/linux/spi/spi.h                            |    2 +
 sound/soc/codecs/cros_ec_codec.c                   |    8 +-
 35 files changed, 5698 insertions(+), 1032 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-cros-ec
 create mode 100644 Documentation/ABI/testing/sysfs-platform-wilco-ec
 create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
 create mode 100644 drivers/platform/chrome/cros_ec_ishtp.c
 delete mode 100644 drivers/platform/chrome/cros_ec_lpc_reg.c
 delete mode 100644 drivers/platform/chrome/cros_ec_lpc_reg.h
 create mode 100644 drivers/platform/chrome/wilco_ec/event.c
 create mode 100644 drivers/platform/chrome/wilco_ec/properties.c
 create mode 100644 drivers/platform/chrome/wilco_ec/sysfs.c
 create mode 100644 drivers/platform/chrome/wilco_ec/telemetry.c

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXSdUzQAKCRBzbaomhzOw
wouXAQDYpwlS0SounmhO/ugMIdo5T+yCKy30J9cKU9cxPln5KgEAzGSFu6lIVygi
41ptztALGnaOCnAQCdh0CUrfVTpl2AU=
=rGDr
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
