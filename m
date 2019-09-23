Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BODY_QUOTE_MALF_MSGID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DDFC432C2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 23:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC0E20820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 23:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KPs3kXSd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503524AbfIWXIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 19:08:52 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38722 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729156AbfIWXIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 19:08:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id h195so10160820pfe.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 16:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=eLRKMSoA+WC1eR0vlVSQqqXMfiUE6LAQsLv3reaUuhs=;
        b=KPs3kXSda4fFP6vEwHioG/7o5DLR/j/l3z1hnV4nNzB8sS2Oppa6b3KSWa5kp5Ywim
         oComoLNdD98J8OEE9wlW/SOdgVAghNGMd0yEgNz9zITpGTcoE8fhxVzuzYqUPjmPx0Yz
         yb7ysK6fft00H6/nnzrH47zruN4XrnYUzcOUQKv5iwQ8m4Vl0jLr978yHFWvvC/JOnsl
         su7rCw86mvHv7jDlKrrpbvqQMrS8BmDLh3osjUHZ62cTXoNGKM1r/3tOamnMhlV+UNEB
         1zseWhti0q1XswU1HcJQeCetT4DVWRt+6S5VaNVNMzIDqAC18N4+yrwCCEi/HHGoBRB/
         cVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=eLRKMSoA+WC1eR0vlVSQqqXMfiUE6LAQsLv3reaUuhs=;
        b=tEkDQFg2/GiwKte54zD6AqCfe5XpUF8XeystScKZRVL61oD1QIQYhDw7y0zjujcpNp
         JkOGa6cvcyU9CQLWhMviVXrBw2UUYVxoouIU47o71F2ryZHG2B6LaQmXsqt4q8BKcvdJ
         jsnlP2ri3QcdRSwgLY1jF/U70aYgGaBCiLn8key/EpXbOvBYI8fL7wlGF9+lETfQY4IQ
         ZWlUyFNhBh8M1qbGshTdTrTr/kKCePefGWHf56ea9uJkOYnQnJ0edaBZE98wakMG4Zxd
         T9qMSYZmM9n9ImLJUQg6NAD42yKS2x9uMqfTLTS3pXP2P/KPvgd974JFe2A+jYIH0S52
         muJA==
X-Gm-Message-State: APjAAAVRzaF000jBhjCT+X22KYvZPzVuPJRR4cW9RD/YDYS8YHm46cYX
        GyH3LZS3kTRU/dmCbfDtD8Z/RzsuuCh6Ng==
X-Google-Smtp-Source: APXvYqz3792IkGk7jWNPM6UvqsTuar1f5qjxULpkfFGdCF6gYaEW5r68RtnLwUxI39ShlqqL7XXI3A==
X-Received: by 2002:aa7:9735:: with SMTP id k21mr2310519pfg.174.1569280131022;
        Mon, 23 Sep 2019 16:08:51 -0700 (PDT)
Received: from dell ([12.157.10.118])
        by smtp.gmail.com with ESMTPSA id v43sm203408pjb.1.2019.09.23.16.08.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Sep 2019 16:08:50 -0700 (PDT)
Date:   Tue, 24 Sep 2019 00:08:48 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] MFD for v5.4
Message-ID: <20190923230848.GB4469@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Enjoy!

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-next-5.4

for you to fetch changes up to 8391c6cb2414d9a75bbe247a838d28cb0cee77ee:

  mfd: mt6323: Add MT6323 RTC and PWRC (2019-09-02 11:20:40 +0100)

----------------------------------------------------------------
 - New Drivers
   - Add support for Merrifield Basin Cove PMIC

 - New Device Support
   - Add support for Intel Tiger Lake to Intel LPSS PCI
   - Add support for Intel Sky Lake to Intel LPSS PCI
   - Add support for ST-Ericsson DB8520 to DB8500 PRCMU

 - New Functionality
   - Add RTC and PWRC support to MT6323

 - Fix-ups
   - Clean-up include files; davinci_voicecodec, asic3, sm501, mt6397
   - Ignore return values from debugfs_create*(); ab3100-*, ab8500-debugfs, aat2870-core
   - Device Tree changes; rn5t618, mt6397
   - Use new I2C API; tps80031, 88pm860x-core, ab3100-core, bcm590xx,
                      da9150-core, max14577, max77693, max77843, max8907,
                      max8925-i2c, max8997, max8998, palmas, twl-core,
   - Remove obsolete code; da9063, jz4740-adc
   - Simplify semantics; timberdale, htc-i2cpld
   - Add 'fall-through' tags; omap-usb-host, db8500-prcmu
   - Remove superfluous prints; ab8500-debugfs, db8500-prcmu, fsl-imx25-tsadc,
                                intel_soc_pmic_bxtwc, qcom_rpm, sm501
   - Trivial rename/whitespace/typo fixes; mt6397-core, MAINTAINERS
   - Reorganise code structure; mt6397-*
   - Improve code consistency; intel-lpss
   - Use MODULE_SOFTDEP() helper; intel-lpss
   - Use DEFINE_RES_*() helpers; mt6397-core

 - Bug Fixes
   - Clean-up resources; max77620
   - Prevent input events being dropped on resume; intel-lpss-pci
   - Prevent sleeping in IRQ context; ezx-pcap

----------------------------------------------------------------
Andy Shevchenko (5):
      mfd: intel-lpss: Add Intel Tiger Lake PCI IDs
      mfd: Add support for Merrifield Basin Cove PMIC
      mfd: intel-lpss: Consistently use GENMASK()
      mfd: intel-lpss: Add Intel Skylake ACPI IDs
      mfd: intel-lpss: Use MODULE_SOFTDEP() instead of implicit request

Arnd Bergmann (1):
      mfd: davinci_voicecodec: Remove pointless #include

Chuhong Yuan (1):
      mfd: timberdale: Use dev_get_drvdata

Denis Efremov (1):
      MAINTAINERS: altera-sysmgr: Fix typo in a filepath

Frank Wunderlich (1):
      dt-bindings: mfd: mediatek: mt6397: Change to relative paths

Fuqian Huang (1):
      mfd: ezx-pcap: Replace mutex_lock with spin_lock

Greg Kroah-Hartman (3):
      mfd: ab3100: No need to check return value of debugfs_create functions
      mfd: ab8500: No need to check return value of debugfs_create functions
      mfd: aat2870: No need to check return value of debugfs_create functions

Gustavo A. R. Silva (2):
      mfd: omap-usb-host: Mark expected switch fall-throughs
      mfd: db8500-prcmu: Mark expected switch fall-throughs

Hsin-Hsiung Wang (2):
      mfd: mt6397: Rename macros to something more readable
      mfd: mt6397: Extract IRQ related code from core driver

Jonathan Neuschäfer (1):
      dt-bindings: mfd: rn5t618: Document optional property system-power-controller

Josef Friedl (5):
      dt-bindings: mfd: mediatek: Update RTC to include MT6323
      dt-bindings: mfd: mediatek: Add MT6323 Power Controller
      mfd: mt6397: Add mutex include
      mfd: mt6323: Replace boilerplate resource code with DEFINE_RES_* macros
      mfd: mt6323: Add MT6323 RTC and PWRC

Kai-Heng Feng (1):
      mfd: intel-lpss: Remove D3cold delay

Linus Walleij (3):
      mfd: asic3: Include the right header
      mfd: sm501: Include the GPIO driver header
      mfd: db8500-prcmu: Support the higher DB8520 ARMSS

Nishka Dasgupta (1):
      mfd: max77620: Add of_node_put() before return

Paul Cercueil (1):
      mfd: Drop obsolete JZ4740 driver

Stephen Boyd (1):
      mfd: Remove dev_err() usage after platform_get_irq()

Wolfram Sang (17):
      mfd: tps80031: Convert to devm_i2c_new_dummy_device
      mfd: da9063: Remove now unused platform_data
      mfd: 88pm800: Convert to i2c_new_dummy_device
      mfd: 88pm860x-core: Convert to i2c_new_dummy_device
      mfd: ab3100-core: Convert to i2c_new_dummy_device
      mfd: bcm590xx: Convert to i2c_new_dummy_device
      mfd: da9150-core: Convert to i2c_new_dummy_device
      mfd: max14577: Convert to i2c_new_dummy_device
      mfd: max77693: Convert to i2c_new_dummy_device
      mfd: max77843: Convert to i2c_new_dummy_device
      mfd: max8907: Convert to i2c_new_dummy_device
      mfd: max8925-i2c: Convert to i2c_new_dummy_device
      mfd: max8997: Convert to i2c_new_dummy_device
      mfd: max8998: Convert to i2c_new_dummy_device
      mfd: palmas: Convert to i2c_new_dummy_device
      mfd: twl-core: Convert to i2c_new_dummy_device
      mfd: htc-i2cpld: Drop check because i2c_unregister_device() is NULL safe

Yicheng Li (1):
      mfd: cros_ec: Update cros_ec_commands.h

 Documentation/devicetree/bindings/mfd/mt6397.txt   |  20 +-
 Documentation/devicetree/bindings/mfd/rn5t618.txt  |   5 +
 .../bindings/power/reset/mt6323-poweroff.txt       |  20 ++
 MAINTAINERS                                        |   2 +-
 drivers/mfd/88pm800.c                              |  12 +-
 drivers/mfd/88pm860x-core.c                        |   6 +-
 drivers/mfd/Kconfig                                |  20 +-
 drivers/mfd/Makefile                               |   5 +-
 drivers/mfd/aat2870-core.c                         |  13 +-
 drivers/mfd/ab3100-core.c                          |  53 +---
 drivers/mfd/ab3100-otp.c                           |  21 +-
 drivers/mfd/ab8500-debugfs.c                       | 332 +++++++--------------
 drivers/mfd/asic3.c                                |   2 +-
 drivers/mfd/bcm590xx.c                             |   6 +-
 drivers/mfd/da9150-core.c                          |   6 +-
 drivers/mfd/davinci_voicecodec.c                   |   9 +-
 drivers/mfd/db8500-prcmu.c                         |  46 ++-
 drivers/mfd/ezx-pcap.c                             |  53 ++--
 drivers/mfd/fsl-imx25-tsadc.c                      |   4 +-
 drivers/mfd/htc-i2cpld.c                           |   3 +-
 drivers/mfd/intel-lpss-acpi.c                      |  26 ++
 drivers/mfd/intel-lpss-pci.c                       |  25 ++
 drivers/mfd/intel-lpss.c                           |  39 +--
 drivers/mfd/intel_soc_pmic_bxtwc.c                 |   4 +-
 drivers/mfd/intel_soc_pmic_mrfld.c                 | 157 ++++++++++
 drivers/mfd/jz4740-adc.c                           | 324 --------------------
 drivers/mfd/max14577.c                             |   6 +-
 drivers/mfd/max77620.c                             |   4 +-
 drivers/mfd/max77693.c                             |  12 +-
 drivers/mfd/max77843.c                             |   6 +-
 drivers/mfd/max8907.c                              |   6 +-
 drivers/mfd/max8925-i2c.c                          |  12 +-
 drivers/mfd/max8997.c                              |  18 +-
 drivers/mfd/max8998.c                              |   6 +-
 drivers/mfd/mt6397-core.c                          | 192 ++----------
 drivers/mfd/mt6397-irq.c                           | 181 +++++++++++
 drivers/mfd/omap-usb-host.c                        |   4 +-
 drivers/mfd/palmas.c                               |   6 +-
 drivers/mfd/qcom_rpm.c                             |  12 +-
 drivers/mfd/sm501.c                                |   5 +-
 drivers/mfd/timberdale.c                           |   3 +-
 drivers/mfd/tps80031.c                             |  23 +-
 drivers/mfd/twl-core.c                             |   6 +-
 include/Kbuild                                     |   1 -
 include/linux/mfd/aat2870.h                        |   1 -
 include/linux/mfd/cros_ec_commands.h               |  12 +
 include/linux/mfd/da9063/pdata.h                   |  60 ----
 include/linux/mfd/intel_soc_pmic_mrfld.h           |  81 +++++
 include/linux/mfd/mt6397/core.h                    |  11 +
 49 files changed, 860 insertions(+), 1021 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt
 create mode 100644 drivers/mfd/intel_soc_pmic_mrfld.c
 delete mode 100644 drivers/mfd/jz4740-adc.c
 create mode 100644 drivers/mfd/mt6397-irq.c
 delete mode 100644 include/linux/mfd/da9063/pdata.h
 create mode 100644 include/linux/mfd/intel_soc_pmic_mrfld.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
