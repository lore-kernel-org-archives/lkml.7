Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA686C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3CBE206BA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rdMj+gsc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfCDO0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 09:26:40 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46625 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfCDO0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 09:26:39 -0500
Received: by mail-pf1-f193.google.com with SMTP id g6so3130988pfh.13;
        Mon, 04 Mar 2019 06:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=r++i/mfQTAOb5xIpGg9bAmyxVmJFdIgPf8uxmuj9Xn0=;
        b=rdMj+gscqX63DHddTgsEFX7a1rpveEfuW6yfmC0rVSvQ5OULlyg4FX/5c3jVbEL43z
         rfDYYKiJbpPpx3Yb8noDvVItkYzs0Nrx8HHCvEjqF7N1V4dYWdcB6LVq6jHsD20Olx1I
         SMWCA3gNs/KroBJG6BZZOGAaK1OFLwsQIVOU5ntViTz1d1QMzVrqT0zOesLlCqvcEGtf
         UDyZ9Ma6O5U6rOC/m2gc+bl5ajBDUGbzK/bbKsN7w1b4nIG09RTu2LMIXGeZsqRwy/tZ
         FATyDgGi7EmBNTzdoOdkckpnxuvRNezglU7e5UHlOoooAt3lYun3KIMysfKrCiLIYffc
         /GSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=r++i/mfQTAOb5xIpGg9bAmyxVmJFdIgPf8uxmuj9Xn0=;
        b=KnvA+19K1UaY2/zsZ6URplIIFXYLMzp5J5fNRjQgUdPGIXpnysp2iRRhj8AdZqvY09
         4ifXpmbneelZa0zCoOnqNVlO1jc+mIRj45eaq+RRvB4sXZ9xjIjIVszYAkctuxIhnGH7
         OXHp9ejvMXvH6jtnsZon14Vg5eQbRoEhH1pBkS3KqKbtgv+JJivfoAkvR054LL7D+nIJ
         gxQ6KJEJ4Eg7jx8uhAiG9bsukUNR8OnPGDWVUJHgxayd6dBL3zMvFodHPjVFe8JLVdHK
         itRQafqoxzWbkntRcjBF9U0Ziq+7yfLSsqvm+WamZs0GGZdf+awnpYupyVkmTiihqFcR
         dDkw==
X-Gm-Message-State: APjAAAUCBa5Xw0A2yFFeRZqRcIBgDP73hRVvE+V4gqHVFt3MTfLo7Pv0
        p9ournQwimdGOBvgyEyimus=
X-Google-Smtp-Source: APXvYqzKY9eLvcqmK0RjT6VWSYvxfPNwip1D8i9MiPpOzvSrH+ZyfRL4STZ2HMm0I12ozO4Spsrvgg==
X-Received: by 2002:a63:4f61:: with SMTP id p33mr18807970pgl.303.1551709598090;
        Mon, 04 Mar 2019 06:26:38 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v22sm13595995pfa.49.2019.03.04.06.26.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 06:26:36 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon updates for hwmon-for-v5.1
Date:   Mon,  4 Mar 2019 06:26:35 -0800
Message-Id: <1551709595-18246-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon updates for Linux hwmon-for-v5.1 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.1

Thanks,
Guenter
------

The following changes since commit a3b22b9f11d9fbc48b0291ea92259a5a810e9438:

  Linux 5.0-rc7 (2019-02-17 18:46:40 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.1

for you to fetch changes up to 985e225142cf0cb826401f5448763f13ee712b3a:

  dt-bindings: hwmon: Add missing documentation for lm75 (2019-02-28 09:38:05 -0800)

----------------------------------------------------------------
hwmon updates for v5.1

Add support for LM96000, DPS-650AB to existing drivers

Use permission specific SENSOR[_DEVICE]_ATTR variants in several drivers

Replace S_<PERMS> with octal values in several drivers

Update some license headers

Various minor fixes and improvements in several drivers

----------------------------------------------------------------
Andreas Kemnade (2):
      hwmon: (hih6130) add dtb compatibility tables
      devicetree: hwmon: Add bindings documentation for HIH6130

Brandon Maier (1):
      hwmon: (ad7418) Catch I2C errors

Corentin Labbe (7):
      hwmon: (adm1029) Remove write to FFF paragraph
      hwmon: (adm1029) Add SPDX header
      hwmon: (adm1029) replace S_IXXX macros by their numeric values
      hwmon: (adm1029) Add blank line after declarations
      hwmon: (adm1029) Fix Logical continuations should be on the previous line checkpatch warning
      hwmon: (adm1029) Fix function alignment
      hwmon: (adm1029) Add a comment for locking mutex

Eddie James (1):
      hwmon: (occ) Fix license headers

Guenter Roeck (60):
      hwmon: (gl518sm) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (gl520sm) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (gpio-fan) Replace S_<PERMS> with octal values
      hwmon: (hih6130) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (hwmon) Replace S_<PERMS> with octal values
      hwmon: (i5500_temp) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (i5k_amb) Replace S_<PERMS> with octal values
      hwmon: (ibmaem) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (ibmpex) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (iio_hwmon) Replace S_<PERMS> with octal values
      hwmon: (ina209) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (ina3221) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (jc42) Replace S_<PERMS> with octal values
      hwmon: (k8temp) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (lineage-pem) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (lm73) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (lm75) Replace S_<PERMS> with octal values
      hwmon: (lm77) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (lm80) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (lm83) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (lm90) Replace S_<PERMS> with octal values
      hwmon: (lm92) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (lm93) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (lm95241) Replace S_<PERMS> with octal values
      hwmon: (lm95245) Replace S_<PERMS> with octal values
      hwmon: (ltc2990) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (ltc4151) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (ltc4222) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (ltc4245) Replace S_<PERMS> with octal values
      hwmon: (ltc4261) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (max16065) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (max1619) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (max31722) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (max31790) Replace S_<PERMS> with octal values
      hwmon: (max6639) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (max6642) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (max6650) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (mc13783-adc) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (nct7904) Replace S_<PERMS> with octal values
      hwmon: (nsa320-hwmon) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (pc87360) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (pc87427) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (powr1220) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (sch5627) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (sch5636) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (scmi-hwmon) Replace S_<PERMS> with octal values
      hwmon: (scpi-hwmon) Replace S_<PERMS> with octal values
      hwmon: (sht15) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (sht21) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (sht3x) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (smsc47b397) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (stts751) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (tc654) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (tc74) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (tmp102) Replace S_<PERMS> with octal values
      hwmon: (tmp103) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (tmp421) Replace S_<PERMS> with octal values
      hwmon: (vexpress-hwmon) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (via-cputemp) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (ntc_thermistor) Convert to new hwmon API

Gustavo A. R. Silva (2):
      hwmon: (adt7462) Mark expected switch fall-throughs
      hwmon: (f71882fg) Mark expected switch fall-through

Jagan Teki (1):
      dt-bindings: hwmon: Add missing documentation for lm75

Jeremy Gebben (4):
      hwmon: (lm85) remove freq_map size hardcodes
      dt-bindings: Add LM96000 as a trivial device
      hwmon: (lm85) support the LM96000
      hwmon: (lm85) add support for LM96000 high frequencies

Linus Walleij (2):
      hwmon: (ad741x) Add DT bindings for Analog Devices AD741x
      hwmon: (ad7418) Add device tree probing

Michele Sorcinelli (1):
      hwmon: (dell-smm) Support up to 10 temp sensors

Nicolin Chen (2):
      dt-bindings: hwmon: (ina3221) Add ti,single-shot property
      hwmon: (ina3221) Implement ti,single-shot DT property

Stefan Wahren (2):
      dt-bindings: hwmon: Add optional regulator support to pwm-fan
      hwmon: (pwm-fan) Add optional regulator support

Vadim Pasternak (1):
      hwmon: (pmbus/tps53679) Fix driver info initialization in probe routine

Xiaoting Liu (3):
      hwmon: (pmbus) associate PMBUS_SKIP_STATUS_CHECK with driver data
      hwmon: (pmbus) add support for DPS-650AB
      dt-bindings: hwmon: add dps650ab documentation

 Documentation/devicetree/bindings/hwmon/ad741x.txt |  15 +
 .../devicetree/bindings/hwmon/dps650ab.txt         |  11 +
 .../devicetree/bindings/hwmon/hih6130.txt          |  12 +
 .../devicetree/bindings/hwmon/ina3221.txt          |  10 +
 Documentation/devicetree/bindings/hwmon/lm75.txt   |  37 ++
 .../devicetree/bindings/hwmon/pwm-fan.txt          |   3 +
 .../devicetree/bindings/trivial-devices.yaml       |   2 +
 Documentation/hwmon/lm85                           |   9 +-
 drivers/hwmon/ad7418.c                             |  78 ++-
 drivers/hwmon/adm1029.c                            |  67 +--
 drivers/hwmon/adt7462.c                            |   4 +
 drivers/hwmon/dell-smm-hwmon.c                     |  97 +++-
 drivers/hwmon/f71882fg.c                           |   2 +-
 drivers/hwmon/gl518sm.c                            | 120 ++--
 drivers/hwmon/gl520sm.c                            | 184 +++---
 drivers/hwmon/gpio-fan.c                           |   2 +-
 drivers/hwmon/hih6130.c                            |  21 +-
 drivers/hwmon/hwmon.c                              |   4 +-
 drivers/hwmon/i5500_temp.c                         |  14 +-
 drivers/hwmon/i5k_amb.c                            |  12 +-
 drivers/hwmon/ibmaem.c                             |  15 +-
 drivers/hwmon/ibmpex.c                             |  14 +-
 drivers/hwmon/iio_hwmon.c                          |   2 +-
 drivers/hwmon/ina209.c                             | 151 +++--
 drivers/hwmon/ina3221.c                            |  36 +-
 drivers/hwmon/jc42.c                               |   8 +-
 drivers/hwmon/k8temp.c                             |  12 +-
 drivers/hwmon/lineage-pem.c                        |  77 ++-
 drivers/hwmon/lm73.c                               |  34 +-
 drivers/hwmon/lm75.c                               |   6 +-
 drivers/hwmon/lm77.c                               |  45 +-
 drivers/hwmon/lm80.c                               | 138 ++---
 drivers/hwmon/lm83.c                               |  62 +-
 drivers/hwmon/lm85.c                               |  43 +-
 drivers/hwmon/lm90.c                               |  12 +-
 drivers/hwmon/lm92.c                               |  39 +-
 drivers/hwmon/lm93.c                               | 630 +++++++++------------
 drivers/hwmon/lm95241.c                            |   8 +-
 drivers/hwmon/lm95245.c                            |   8 +-
 drivers/hwmon/ltc2990.c                            |  32 +-
 drivers/hwmon/ltc4151.c                            |  11 +-
 drivers/hwmon/ltc4222.c                            |  56 +-
 drivers/hwmon/ltc4245.c                            |   8 +-
 drivers/hwmon/ltc4261.c                            |  28 +-
 drivers/hwmon/max16065.c                           | 225 +++-----
 drivers/hwmon/max1619.c                            |  33 +-
 drivers/hwmon/max31722.c                           |   8 +-
 drivers/hwmon/max31790.c                           |   6 +-
 drivers/hwmon/max6639.c                            |  92 ++-
 drivers/hwmon/max6642.c                            |  31 +-
 drivers/hwmon/max6650.c                            |   6 +-
 drivers/hwmon/mc13783-adc.c                        |  49 +-
 drivers/hwmon/nct7904.c                            |  10 +-
 drivers/hwmon/nsa320-hwmon.c                       |   8 +-
 drivers/hwmon/ntc_thermistor.c                     | 106 ++--
 drivers/hwmon/occ/common.c                         |   3 +-
 drivers/hwmon/occ/common.h                         |   3 +-
 drivers/hwmon/occ/p8_i2c.c                         |   3 +-
 drivers/hwmon/occ/p9_sbe.c                         |   3 +-
 drivers/hwmon/occ/sysfs.c                          |  13 +-
 drivers/hwmon/pc87360.c                            | 427 +++++++-------
 drivers/hwmon/pc87427.c                            | 317 +++++------
 drivers/hwmon/pmbus/pmbus.c                        |  64 ++-
 drivers/hwmon/pmbus/tps53679.c                     |   9 +-
 drivers/hwmon/powr1220.c                           | 144 ++---
 drivers/hwmon/pwm-fan.c                            |  43 +-
 drivers/hwmon/sch5627.c                            | 146 ++---
 drivers/hwmon/sch5636.c                            | 202 +++----
 drivers/hwmon/scmi-hwmon.c                         |   2 +-
 drivers/hwmon/scpi-hwmon.c                         |   4 +-
 drivers/hwmon/sht15.c                              |  34 +-
 drivers/hwmon/sht21.c                              |  17 +-
 drivers/hwmon/sht3x.c                              |  50 +-
 drivers/hwmon/smsc47b397.c                         |  24 +-
 drivers/hwmon/stts751.c                            |  64 +--
 drivers/hwmon/tc654.c                              |  60 +-
 drivers/hwmon/tc74.c                               |   4 +-
 drivers/hwmon/tmp102.c                             |   4 +-
 drivers/hwmon/tmp103.c                             |  20 +-
 drivers/hwmon/tmp421.c                             |   4 +-
 drivers/hwmon/vexpress-hwmon.c                     |  25 +-
 drivers/hwmon/via-cputemp.c                        |  15 +-
 82 files changed, 2186 insertions(+), 2271 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ad741x.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/dps650ab.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/hih6130.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/lm75.txt
