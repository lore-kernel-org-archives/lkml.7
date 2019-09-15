Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C444BC4CEC7
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 22:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D3620692
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 22:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnzrivaJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfIOWRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 18:17:06 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45397 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfIOWRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 18:17:06 -0400
Received: by mail-pg1-f194.google.com with SMTP id 4so18472911pgm.12;
        Sun, 15 Sep 2019 15:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZjaV8y7yH/juQUdAbDmH776B3Iv6G5aiEBUh0Egz+/Q=;
        b=HnzrivaJ4nFtWkW0DuY6TIIFdFBHZDtOtRKqj/g1j7vbZ85Ijn7LjLvdMbXpk2RLDC
         9tPeHe6a9hL/N8UDStqrlKB+PQRrZDVeFRrMhGcQWAsEtgBYlfoP5rkLQo8j5SztjXpr
         1a5gUwgJ0z9tkcRyAticqIJ6my81e1OtdeIIiUIGsY2gNGhhkf8UW9rzIkhxgHdnBeYW
         9FMRZjcvIcbIQdGbK4pepcqraeDJFPEw/xkPorwb0MN6iMs4T7lSO8KH9+suaPp8rG77
         eq+0fPsK3DXpQmPbpoPTNn7aeTo/KddhLIbL1whfZd36CjmFLvEVjboWAhc6szSRHGki
         lr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ZjaV8y7yH/juQUdAbDmH776B3Iv6G5aiEBUh0Egz+/Q=;
        b=Q44TEqeMRzXUm4xGTG+0tXXecBehhTq0Vwofkw0Liwp7Jsed8wYwI/477AFPXdRab4
         D75rXerGTYSq8x2HpHH5267SEkqMGkzvDl3gW3f9ao7+ps40UVk46mEqgvbbi3mETUYH
         uOE8k1En7jcDAmysHkR97afjF7mYOtnrpPfT9O5MSclvAU/jPgEvjnC0u7CuoBJ4YXdM
         bTo9reOXmHqlBt3ILkX1Vv9WAZ/IxxpfRl4Fr4oC8Pp3NCSCGEr57W3mZzX4QKyNZV8I
         gysvf035+0VxksU6UXy6e4WoMdmiirpVHTQhYMcKxZLcCUe7CH3IbemzpCBj6BsULQI9
         Ckng==
X-Gm-Message-State: APjAAAVHXcLWALpiA82rHyLZg518wJocsjTq7ATRCOpg9d+nMgWHqd2V
        ip/BOexTyElvGKHJOR7g3LXSIMRl
X-Google-Smtp-Source: APXvYqxIoBUAAqHXW9dNxBnuCioHwXa1PYno65gys8S6CHECtblnzbZVL7RIrmWeVi/Vj8+CGoh7lg==
X-Received: by 2002:a65:450a:: with SMTP id n10mr17725708pgq.432.1568585825068;
        Sun, 15 Sep 2019 15:17:05 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u17sm9758323pgf.8.2019.09.15.15.17.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Sep 2019 15:17:03 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon updates for v5.4
Date:   Sun, 15 Sep 2019 15:17:02 -0700
Message-Id: <20190915221702.28480-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon updates for Linux v5.4 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.4

Thanks,
Guenter
------

The following changes since commit a55aa89aab90fae7c815b0551b07be37db359d76:

  Linux 5.3-rc6 (2019-08-25 12:01:23 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.4

for you to fetch changes up to 4e19e72f45d360975c59df8272f98bff59f6b748:

  hwmon: submitting-patches: Add note on comment style (2019-09-13 05:43:06 -0700)

----------------------------------------------------------------
hwmon updates for v5.4

New drivers and chip support
- Add Inspur Power System power supply driver
- Add Synaptics AS370 PVT sensor driver
- Add support for SHTC3 to shtc1 driver
- Add support for NCT6116 to nct6775 driver
- Add support for AMD family 17h, model 70h CPUs to k10temp driver
- Add support for PCT2075 to lm75 driver

Removed drivers
- Remove ads1015 driver (now supported in iio)

Other changes
- Convert drivers to use devm_i2c_new_dummy_device
- Substantial structural improvements in lm75 driver
  Add support for writing sample interval for supported chips
- Add support for PSU version 2 to ibm-cffps driver
- Add support for power attribute to iio_hwmon bridge
- Add support for additional fan, voltage and temperature attributes
  to nct7904 driver
- Convert adt7475 driver to use hwmon_device_register_with_groups()
- Convert k8temp driver to use hwmon_device_register_with_info()
- Various other improvements and minor fixes

----------------------------------------------------------------
Bartosz Golaszewski (1):
      hwmon: pmbus: ucd9000: remove unneeded include

Björn Gerhart (1):
      hwmon: (nct6775) Integrate new model nct6116

Christophe JAILLET (1):
      hwmon: (pmbus/max31785) Remove a useless #define

Dan Robertson (2):
      hwmon: (shtc1) fix shtc1 and shtw1 id mask
      hwmon: (shtc1) add support for the SHTC3 sensor

Daniel Mack (2):
      device-tree: bindinds: add NXP PCT2075 as compatible device to LM75
      hwmon: (lm75) add support for PCT2075

Eddie James (2):
      dt-bindings: hwmon: Document ibm,cffps2 compatible string
      pmbus: (ibm-cffps) Add support for version 2 of the PSU

Grant McEwan (1):
      hwmon: (adt7475) Convert to use hwmon_device_register_with_groups()

Guenter Roeck (8):
      hwmon: (lm75) Fix write operations for negative temperatures
      hwmon: Remove ads1015 driver
      hwmon: (lm75) Support configuring the sample time for various chips
      hwmon: (lm75) Move updating the sample interval to its own function
      hwmon: (lm75) Add support for writing conversion time for TMP112
      hwmon: (lm75) Add support for writing sampling period on PCT2075
      hwmon: submitting-patches: Point to with_info API
      hwmon: submitting-patches: Add note on comment style

Iker Perez del Palomar Sustatxa (5):
      hwmon: (lm75) Create structure to save all the configuration parameters.
      hwmon: (lm75) Create function from code to write into registers
      hwmon: (lm75) Add new fields into lm75_params_
      hwmon: (lm75) Modularize lm75_write and make hwmon_chip writable
      hwmon: (lm75) Aproximate sample times to data-sheet values

Jean Delvare (1):
      hwmon: w83795: Fan control option isn't that dangerous

Jisheng Zhang (2):
      hwmon: Add Synaptics AS370 PVT sensor driver
      hwmon: (as370-hwmon) Add DT bindings for Synaptics AS370 PVT

John Wang (2):
      hwmon: pmbus: Add Inspur Power System power supply driver
      dt-bindings: Add ipsps1 as a trivial device

Marcel Bocu (2):
      x86/amd_nb: Add PCI device IDs for family 17h, model 70h
      hwmon: (k10temp) Add support for AMD family 17h, model 70h CPUs

Mauro Carvalho Chehab (1):
      docs: hwmon: pxe1610: convert to ReST format and add to the index

Max Staudt (1):
      hwmon/ltc2990: Generalise DT to fwnode support

Michal Simek (1):
      hwmon: (iio_hwmon) Enable power exporting from IIO

Robert Karszniewicz (1):
      hwmon: (k8temp) update to use new hwmon registration API

Stefan Wahren (1):
      hwmon: (raspberrypi) update MODULE_AUTHOR() email address

Stephen Boyd (1):
      hwmon: (npcm750-pwm-fan) Remove dev_err() usage after platform_get_irq()

Wang Shenran (1):
      hwmon: (acpi_power_meter) Change log level for 'unsafe software power cap'

Wenwen Wang (1):
      hwmon (coretemp) Fix a memory leak bug

Wolfram Sang (6):
      hwmon: (asb100) convert to i2c_new_dummy_device
      hwmon: (smm665) convert to i2c_new_dummy_device
      hwmon: (w83781d) convert to i2c_new_dummy_device
      hwmon: (w83791d) convert to use devm_i2c_new_dummy_device
      hwmon: (w83792d) convert to use devm_i2c_new_dummy_device
      hwmon: (w83793d) convert to use devm_i2c_new_dummy_device

amy.shih (3):
      hwmon: (nct7904) Add extra sysfs support for fan, voltage and temperature.
      hwmon: (nct7904) Fix incorrect temperature limitation register setting of LTD.
      hwmon: (nct7904) Fix incorrect SMI status register setting of LTD temperature and fan.

kbuild test robot (1):
      hwmon: (as370-hwmon) fix devm_platform_ioremap_resource.cocci warnings

 Documentation/devicetree/bindings/hwmon/as370.txt  |  11 +
 .../devicetree/bindings/hwmon/ibm,cffps1.txt       |   8 +-
 Documentation/devicetree/bindings/hwmon/lm75.txt   |   1 +
 .../bindings/{hwmon => iio/adc}/ads1015.txt        |   0
 .../devicetree/bindings/trivial-devices.yaml       |   2 +
 Documentation/hwmon/ads1015.rst                    |  90 ----
 Documentation/hwmon/index.rst                      |   2 +-
 Documentation/hwmon/inspur-ipsps1.rst              |  79 ++++
 Documentation/hwmon/lm75.rst                       |   6 +-
 Documentation/hwmon/{pxe1610 => pxe1610.rst}       |  33 +-
 Documentation/hwmon/shtc1.rst                      |  19 +-
 Documentation/hwmon/submitting-patches.rst         |   8 +-
 MAINTAINERS                                        |   8 -
 arch/x86/kernel/amd_nb.c                           |   3 +
 drivers/hwmon/Kconfig                              |  31 +-
 drivers/hwmon/Makefile                             |   2 +-
 drivers/hwmon/acpi_power_meter.c                   |   4 +-
 drivers/hwmon/ads1015.c                            | 324 --------------
 drivers/hwmon/adt7475.c                            | 146 +++----
 drivers/hwmon/as370-hwmon.c                        | 145 +++++++
 drivers/hwmon/asb100.c                             |  12 +-
 drivers/hwmon/coretemp.c                           |   3 +-
 drivers/hwmon/iio_hwmon.c                          |  18 +-
 drivers/hwmon/k10temp.c                            |   1 +
 drivers/hwmon/k8temp.c                             | 233 +++-------
 drivers/hwmon/lm75.c                               | 462 +++++++++++++++-----
 drivers/hwmon/ltc2990.c                            |  10 +-
 drivers/hwmon/nct6775.c                            | 180 +++++++-
 drivers/hwmon/nct7904.c                            | 476 +++++++++++++++++++--
 drivers/hwmon/npcm750-pwm-fan.c                    |   4 +-
 drivers/hwmon/pmbus/Kconfig                        |   9 +
 drivers/hwmon/pmbus/Makefile                       |   1 +
 drivers/hwmon/pmbus/ibm-cffps.c                    | 110 ++++-
 drivers/hwmon/pmbus/inspur-ipsps.c                 | 228 ++++++++++
 drivers/hwmon/pmbus/max31785.c                     |   2 -
 drivers/hwmon/pmbus/ucd9000.c                      |   1 -
 drivers/hwmon/raspberrypi-hwmon.c                  |   2 +-
 drivers/hwmon/shtc1.c                              |  57 ++-
 drivers/hwmon/smm665.c                             |   6 +-
 drivers/hwmon/w83781d.c                            |   6 +-
 drivers/hwmon/w83791d.c                            |  32 +-
 drivers/hwmon/w83792d.c                            |  32 +-
 drivers/hwmon/w83793.c                             |  30 +-
 drivers/iio/adc/Kconfig                            |   2 +-
 include/linux/pci_ids.h                            |   1 +
 45 files changed, 1817 insertions(+), 1023 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/as370.txt
 rename Documentation/devicetree/bindings/{hwmon => iio/adc}/ads1015.txt (100%)
 delete mode 100644 Documentation/hwmon/ads1015.rst
 create mode 100644 Documentation/hwmon/inspur-ipsps1.rst
 rename Documentation/hwmon/{pxe1610 => pxe1610.rst} (82%)
 delete mode 100644 drivers/hwmon/ads1015.c
 create mode 100644 drivers/hwmon/as370-hwmon.c
 create mode 100644 drivers/hwmon/pmbus/inspur-ipsps.c
