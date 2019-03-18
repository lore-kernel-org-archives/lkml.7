Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEE4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5319A21473
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="S+nuY1S3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfCRRkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:40:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39910 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbfCRRkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:40:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id j9so3885154wrn.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 10:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zWsuY7SQLTOsW6dl9uNB44LxJ1gQojgHylmbkg8s1Qk=;
        b=S+nuY1S3QEhS1FvyZM/3ExGSJ272O3DyEPAuSlwOiNRtPAeEzqa8sE6vD2f2SYaaE3
         hWTwt19HZfNoYLfQDs3TC6WabqLpkGJzzRGm30cSB6A+tAOdTY+Yp9nWOr+YT66cyY6m
         UMWddQ5BOHBR4eSCLNVsOSJlE0LxIglleVYaoTIS4lWsFo95WEFMpS2JhzLX8+B/Qn1z
         2T6rXwze0jMT3lEtVeSC2VNLRp1EkjGUCL0QAgmv+XwOyeRvZ9+fFO6Vxh9Zm4ArG2b3
         OXJs83eiOEabJoA+avP4hFQgQGPhH7GvoHAKgYY5UTJj9DKDGkbucL9tDOnh1Dp9LMOx
         I4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zWsuY7SQLTOsW6dl9uNB44LxJ1gQojgHylmbkg8s1Qk=;
        b=ECyZev2XBSTIq15yzIEprvzie/0zsLC82y9MRcEtRp2GPxre8jGZwi8jnezSvE+IHb
         WCjWj0xfB7XH2o4lgdZZ07vOZ+dTOsRPCbubg1zizbWE34qxf6kloBnYAUK0GOsbvZRV
         01BeSfNSXOzPvg9R8Bss9W3QvaH/ASvJIgBErfoFL2GTeIBBmcPk7rcRcL0dvHEvTh7C
         jLjzVPgIC3tk0fQnvRQt/EtCJRmftqkGgTNjjwES5WxjprpwdASLFEFJl9MjgEdT7ojZ
         LGhub05jgR77qkA5N9xFVRHmLguBKXam+lmN6oc6p+xBofVX6vf10Yqy/3Bm+kB8f7Fy
         6Cfg==
X-Gm-Message-State: APjAAAWuNKerPfLV+iSwHTNwH0yAPpNLuOez2THylTfF/TqsTGhCvm0O
        JsjbLH04+GisQIeJUFtXbB8TcA==
X-Google-Smtp-Source: APXvYqzKS5J1m6nzNY+4e3X0mijefOUDtJply7p5lhIHc3aAhPeCkhDzuZlNN8/2WbrCVgsx1BV0/A==
X-Received: by 2002:adf:b591:: with SMTP id c17mr13947247wre.195.1552930849981;
        Mon, 18 Mar 2019 10:40:49 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id y140sm41436988wmd.18.2019.03.18.10.40.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 10:40:49 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v6 00/11] mfd: add support for max77650 PMIC
Date:   Mon, 18 Mar 2019 18:40:29 +0100
Message-Id: <20190318174040.17899-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series missed the last merge window so resending rebased on top
of v5.1-rc1 with no functional changes.

---

This series adds support for max77650 ultra low-power PMIC. It provides
the core mfd driver and a set of five sub-drivers for the regulator,
power supply, gpio, leds and input subsystems.

Patches 1-4 add the DT binding documents. Patch 5 documents mfd_add_devices().
Patches 6-10 add all drivers. Last patch adds a MAINTAINERS entry for this
device.

The regulator part is already upstream.

v1 -> v2:
=========

General:
- use C++ style comments for the SPDX license identifier and the
  copyright header
- s/MODULE_LICENSE("GPL")/MODULE_LICENSE("GPL v2")/
- lookup the virtual interrupt numbers in the MFD driver, setup
  resources for child devices and use platform_get_irq_byname()
  in sub-drivers
- picked up review tags
- use devm_request_any_context_irq() for interrupt requests

LEDs:
- changed the max77650_leds_ prefix to max77650_led_
- drop the max77650_leds structure as the only field it held was the
  regmap pointer, move said pointer to struct max77650_led
- change the driver name to "max77650-led"
- drop the last return value check and return the result of
  regmap_write() directly
- change the labeling scheme to one consistent with other LED drivers

ONKEY:
- drop the key reporting helper and call the input functions directly
  from interrupt handlers
- rename the rv local variable to error
- drop parent device asignment

Regulator:
- drop the unnecessary init_data lookup from the driver code
- drop unnecessary include

Charger:
- disable the charger on driver remove
- change the power supply type to POWER_SUPPLY_TYPE_USB

GPIO:
- drop interrupt support until we have correct implementation of hierarchical
  irqs in gpiolib

v2 -> v3:
=========

General:
- dropped regulator patches as they're already in Mark Brown's branch

LED:
- fix the compatible string in the DT binding example
- use the max_brightness property
- use a common prefix ("MAX77650_LED") for all defines in the driver

MFD:
- add the MODULE_DEVICE_TABLE()
- add a sentinel to the of_device_id array
- constify the pointers to irq names
- use an enum instead of defines for interrupt indexes

v3 -> v4:
=========

GPIO:
- as discussed with Linus Walleij: the gpio-controller is now part of
  the core mfd module (we don't spawn a sub-node anymore), the binding
  document for GPIO has been dropped, the GPIO properties have been
  defined in the binding document for the mfd core, the interrupt
  functionality has been reintroduced with the irq directly passed from
  the mfd part
- due to the above changes the Reviewed-by tag from Linus was dropped

v4 -> v5:
=========

General:
- add a patch documenting mfd_add_devices()

MFD:
- pass the regmap irq_chip irq domain to mfd over mfd_add_devices so that
  the hw interrupts from resources can be correctly mapped to virtual irqs
- remove the enum listing cell indexes
- extend Kconfig help
- add a link to the programming manual
- use REGMAP_IRQ_REG() for regmap interrupts (except for GPI which has
  is composed of two hw interrupts for rising and falling edge)
- add error messages in probe
- use PLATFORM_DEVID_NONE constant in devm_mfd_add_devices()
- set irq_base to 0 in regmap_add_irq_chip() as other users to, it's only
  relevant if it's > 0

Charger:
- use non-maxim specific property names for minimum input voltage and current
  limit
- code shrink by using the enable/disable charger helpers everywhere
- use more descriptive names for constants

Onkey:
- use EV_SW event type for slide mode

LED:
- remove stray " from Kconfig help

v5 -> v6:
=========

MFD:
- remove stray spaces in the binding document
- rename the example dt node
- remove unnecessary interrupt-parent property from the bindings

LED:
- add a missing dependency on LEDS_CLASS to Kconfig

Onkey:
- use boolean for the slide button property

Charger:
- fix the property names in DT example
- make constants even more readable

Bartosz Golaszewski (11):
  dt-bindings: mfd: add DT bindings for max77650
  dt-bindings: power: supply: add DT bindings for max77650
  dt-bindings: leds: add DT bindings for max77650
  dt-bindings: input: add DT bindings for max77650
  mfd: core: document mfd_add_devices()
  mfd: max77650: new core mfd driver
  power: supply: max77650: add support for battery charger
  gpio: max77650: add GPIO support
  leds: max77650: add LEDs support
  input: max77650: add onkey support
  MAINTAINERS: add an entry for max77650 mfd driver

 .../bindings/input/max77650-onkey.txt         |  26 ++
 .../bindings/leds/leds-max77650.txt           |  57 +++
 .../devicetree/bindings/mfd/max77650.txt      |  46 +++
 .../power/supply/max77650-charger.txt         |  27 ++
 MAINTAINERS                                   |  14 +
 drivers/gpio/Kconfig                          |   7 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-max77650.c                  | 190 +++++++++
 drivers/input/misc/Kconfig                    |   9 +
 drivers/input/misc/Makefile                   |   1 +
 drivers/input/misc/max77650-onkey.c           | 121 ++++++
 drivers/leds/Kconfig                          |   6 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-max77650.c                  | 147 +++++++
 drivers/mfd/Kconfig                           |  14 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/max77650.c                        | 234 +++++++++++
 drivers/mfd/mfd-core.c                        |  14 +
 drivers/power/supply/Kconfig                  |   7 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/max77650-charger.c       | 366 ++++++++++++++++++
 include/linux/mfd/max77650.h                  |  59 +++
 22 files changed, 1349 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/max77650-onkey.txt
 create mode 100644 Documentation/devicetree/bindings/leds/leds-max77650.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/max77650.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/max77650-charger.txt
 create mode 100644 drivers/gpio/gpio-max77650.c
 create mode 100644 drivers/input/misc/max77650-onkey.c
 create mode 100644 drivers/leds/leds-max77650.c
 create mode 100644 drivers/mfd/max77650.c
 create mode 100644 drivers/power/supply/max77650-charger.c
 create mode 100644 include/linux/mfd/max77650.h

-- 
2.20.1

