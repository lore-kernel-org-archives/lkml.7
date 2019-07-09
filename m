Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63402C73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A0A2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pujEg630"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbfGISXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:23:12 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43718 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbfGISXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:23:11 -0400
Received: by mail-pl1-f193.google.com with SMTP id cl9so10484863plb.10;
        Tue, 09 Jul 2019 11:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=LCMLgHJ1KXlp99Gv2wkxAzbZDPVeSL8C2PTBny9wQ7g=;
        b=pujEg6308qU0RMwp+4YjFwJaOlPrDWNNTdKt100PKX/zrDybn2fzbTR8Wwgj+9Sbyd
         FRZeq5sWEoE2IvgiqW2Chy6WH+NwiaOUtYyb75bk1CSI7V9oo/Zv4YWbgAniYM8W/P98
         DBC2DARiffAlT9NG1cjNNKft/7+f0tkHvYHD1ISY3haeZEsAnXKn+qN4fkw9J6QPFh3p
         /0WDsSsHUxWLKQiKKk389rHhtclMXyPPHQ4XdvHXLqjJOqobrUEh6qlGJiSYGMbeGuW2
         8jpHv2NHWbtMUcWb8cWP72ApS9QZZsfMW3frL2PkbBJRqA5uLeaYD27j3uG/SQM9pT8t
         /pXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=LCMLgHJ1KXlp99Gv2wkxAzbZDPVeSL8C2PTBny9wQ7g=;
        b=dDDBMeCx8pQwWO3E2clJHJ3u3rVzWjsMnKNkzZP2PzDhJRc8ZD1nE2BgluHi0anpbK
         wvmEsDZn7DTRh7WdtTzoEGOaxlmeJSFuHDQZYrlgSNbRN5Y1BLtL0wkE/bvxQkRzXMOF
         2Xakk+74dglH5Iyq/CQJXZ1VvpTvt9mTpFtH4AvS5OC7XrhRGweJpgHkWoM2hm0SBEgc
         /XYHOlp6SzjI+nM5csurX3I8NFQnaNqGjkvqJIXDrXJHHyce/6rAK4RtQMFzI5Do8UlT
         1mv7yCm1a3C2hOAl+C9o83h8s+B+Dc1QBv6udKdRx6G4jMnY3fG5Qs5ztzI0oxmW78RE
         XpKA==
X-Gm-Message-State: APjAAAXuETXtQEXOwKx7iVZAvbchvHEWDuCrcYGT3vv7nLWP4oCMw+mu
        Lb/lpKoTwN03fFX+/AfNTyGJHjbn
X-Google-Smtp-Source: APXvYqzS72n4+wpP4CGHtXqb0vKR0fQMrpbZKIus1+TruDS9xGrw1cfE/ybkj05w7VuXsKD/5dOYOA==
X-Received: by 2002:a17:902:28:: with SMTP id 37mr31614085pla.188.1562696590472;
        Tue, 09 Jul 2019 11:23:10 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m4sm18377689pgs.71.2019.07.09.11.23.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 11:23:09 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon updates for hwmon-for-v5.3
Date:   Tue,  9 Jul 2019 11:23:08 -0700
Message-Id: <1562696588-26554-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon updates for Linux hwmon-for-v5.3 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.3

Thanks,
Guenter
------

The following changes since commit 4b972a01a7da614b4796475f933094751a295a2f:

  Linux 5.2-rc6 (2019-06-22 16:01:36 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.3

for you to fetch changes up to 9f7546570bcb20debfaa97bcf720fa0fcb8fc05a:

  hwmon: (ina3221) Add of_node_put() before return (2019-07-08 18:11:32 -0700)

----------------------------------------------------------------
hwmon updates for v5.3

New drivers for Infineon PXE1610 and IRPS5401
Minor improvements, cleanup, and fixes in several drivers

----------------------------------------------------------------
Adamski, Krzysztof (Nokia - PL/Wroclaw) (1):
      hwmon: (pmbus/adm1275) support PMBUS_VIRT_*_SAMPLES

Alexander Soldatov (1):
      hwmon: (occ) Add temp sensor value check

Arnd Bergmann (1):
      hwmon: (max6650) Fix unused variable warning

Boyang Yu (1):
      hwmon: (lm90) Fix max6658 sporadic wrong temperature reading

Christian Schneider (2):
      hwmon: (gpio-fan) move fan_alarm_init after devm_hwmon_device_register_with_groups
      hwmon: (gpio-fan) fix sysfs notifications and udev events for gpio-fan alarms

Greg Kroah-Hartman (1):
      hwmon: (asus_atk0110) no need to check return value of debugfs_create functions

Guenter Roeck (17):
      hwmon: (gpio-fan) Check return value from devm_add_action_or_reset
      hwmon: (pwm-fan) Check return value from devm_add_action_or_reset
      hwmon: (core) Add comment describing how hwdev is freed in error path
      hwmon: (max6650) Use devm function to register thermal device
      hwmon: (max6650) Introduce pwm_to_dac and dac_to_pwm
      hwmon: (max6650) Improve error handling in max6650_init_client
      hwmon: (max6650) Declare valid as boolean
      hwmon: (max6650) Cache alarm_en register
      hwmon: (max6650) Simplify alarm handling
      hwmon: (max6650) Convert to use devm_hwmon_device_register_with_info
      hwmon: (max6650) Read non-volatile registers only once
      hwmon: (max6650) Improve error handling in max6650_update_device
      hwmon: (max6650) Fix minor formatting issues
      hwmon: (pmbus/adm1275) Fix power sampling support
      hwmon: Convert remaining drivers to use SPDX identifier
      hwmon: (lm90) Cache configuration register value
      hwmon: (lm90) Introduce function to update configuration register

Masahiro Yamada (1):
      hwmon: (smsc47m1) fix (suspicious) outside array bounds warnings

Nishka Dasgupta (1):
      hwmon: (ina3221) Add of_node_put() before return

Robert Hancock (1):
      hwmon: (pmbus) Add Infineon IRPS5401 driver

Vijay Khemka (2):
      hwmon: (pmbus) Add Infineon PXE1610 VR driver
      hwmon: (pmbus) Document Infineon PXE1610 driver

Wolfram Sang (1):
      hwmon: (lm90) simplify getting the adapter of a client

amy.shih (3):
      hwmon: (nct7904) Fix the incorrect value of tcpu_mask in nct7904_data struct.
      hwmon: (nct7904) Add error handling in probe function.
      hwmon: (nct7904) Changes comments in probe function.

 Documentation/hwmon/pxe1610    |  90 ++++++
 drivers/hwmon/adm1029.c        |  10 -
 drivers/hwmon/asus_atk0110.c   |  23 +-
 drivers/hwmon/gpio-fan.c       |  22 +-
 drivers/hwmon/hwmon.c          |   6 +
 drivers/hwmon/ina3221.c        |   4 +-
 drivers/hwmon/lm90.c           | 106 +++---
 drivers/hwmon/max6650.c        | 710 +++++++++++++++++++++--------------------
 drivers/hwmon/nct7904.c        |  81 ++++-
 drivers/hwmon/occ/common.c     |   6 +
 drivers/hwmon/pmbus/Kconfig    |  18 ++
 drivers/hwmon/pmbus/Makefile   |   2 +
 drivers/hwmon/pmbus/adm1275.c  | 105 +++++-
 drivers/hwmon/pmbus/irps5401.c |  67 ++++
 drivers/hwmon/pmbus/pxe1610.c  | 139 ++++++++
 drivers/hwmon/pwm-fan.c        |  10 +-
 drivers/hwmon/scpi-hwmon.c     |  10 +-
 drivers/hwmon/smsc47m1.c       |   2 +
 18 files changed, 954 insertions(+), 457 deletions(-)
 create mode 100644 Documentation/hwmon/pxe1610
 create mode 100644 drivers/hwmon/pmbus/irps5401.c
 create mode 100644 drivers/hwmon/pmbus/pxe1610.c
