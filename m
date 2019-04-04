Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2363EC10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E828D2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbfDDKSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 06:18:50 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35582 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729132AbfDDKSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 06:18:46 -0400
Received: by mail-lj1-f196.google.com with SMTP id t4so1595867ljc.2;
        Thu, 04 Apr 2019 03:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=eukAPmIp/DTYZKjL3NSWt8arxBeiDuXIgJ87ukC54tk=;
        b=XyvPFK1bR4bXfudtQOnx5aa8YmjBcasKaoqNsZCHML1OSW2yRt6nO72WK5u0iDZCwU
         cgFtmFL9z3MWrLezSeJKoDiXQNJfvVeyEEOI/WWo0gFCdmEB/ooCUGxRetZ4GDrL3odl
         GT6mgA5FHGeDUS8xCehcATKunTcwG+4owrEpv/CXW8C2p8fwT8wm10FqjiN0K8IelD80
         7Ljfaw0peES9tXqPJJxgr/ywYFHL1sqvxvq+e4w4WQzoy/H0pZgHoXJx9jHwN8dMC1lN
         OjgmInEhi/wDtObKlIotTZViTM0jNLW8y1sp+d6l9H/QfANsGk23ArAI+8SFxZUFiEmR
         UYgA==
X-Gm-Message-State: APjAAAVAianR30tqcjy1DRd3sNgvUacmiDVOIqiVZSWYp2u2bujbntnM
        DXkbDxJUOT+62P3CYBBNajk=
X-Google-Smtp-Source: APXvYqxuTWKQm9F/+XJMtd8KQFbvUl2ZKY5t0sz4YVD0sC/hgqWz1KWboszZTDpViFjB3NVfAx+Hqg==
X-Received: by 2002:a2e:380c:: with SMTP id f12mr3100860lja.116.1554373122854;
        Thu, 04 Apr 2019 03:18:42 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id i190sm3509725lfi.43.2019.04.04.03.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 03:18:42 -0700 (PDT)
Date:   Thu, 4 Apr 2019 13:18:29 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        mazziesaccount@gmail.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        bogdan-petru.chircu-mare@nxp.com
Subject: [PATCH v13 0/8] support ROHM BD70528 PMIC
Message-ID: <cover.1554371464.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch series introducing support for ROHM BD70528 PMIC

ROHM BD70528 is a programmable Power Management IC for battery
powered 'ultra low power' systems like the pre-announced NXP
i.MX7 ULP. This patch series introduces support for the PMIC. Please
note that this driver only supports HW setup where PMIC is connected
to I2C on A7 core. The other scenario is to use M4 as a power manager
and connect pmic to M4. On such setups the A7 can only access pmic
via M4 core using RPMSG virtio. Such setup depends on RPMSG
implementation on M4 core and is currently not supported by this
patch series.

RTC block of the bd70528 can support 'wake' irq which wakes PMIC
from standby state. Wake irq's can be armed to wake up system up
to 24 hours from arming. bd70528 can also generate alarm interrupts
which can be armed to occur years after triggering. The RTC driver
does always arm both the waker and alarm irqs and does not utilize
longer period of alarm interrupts. All the RTC timers are limited
to occur within the next 24 hours. Any suggestions on more elegant
timer support are welcome =)

GPIO portion of bd70528 driver adds I/O support for driving GPIO
pins or reading the state. The interrupt functionality is provided
by regmap-irq. Current GPIO driver is not aware of whether the pin(s)
are used for I/O or interrupts and it is up-to driver user to
ensure there is no misconfiguration or "double use".

The power-supply patch included in series is only poorly tested as I
lack of hardware with real battery connected. Reset and ADC are not
supported by this series.

Changelog v13:
- Moved WDT enable/disable code from MFD to WDT
- Added WDT enable/disable stubs for cases where WDT is omitted from
  Kconfig

Changelog v12:
- No functional changes
- Fixed styling issues pointed by Lee Jones
- Fixed styling issues pointed by Alexandre Belloni
- Fixed various styling issues

Changelog v11:
- No functional changes
- Rebased on linux 5.1-rc2
- Dropped patch 9 which was already applied by Mark
- renamed dt-bindings patch as suggested by Rob
  
Changelog v10:
- Exported locking functions for RTC lock and as a result dropped hid
  the struct bd70528 from sub-devices who no longer needed it.
- removed linux/gpio.h header from GPIO driver.

Changelog v9: Changes suggested by Lee Jones
- MFD, DT-binding, RTC and WDT changed
- DT-bindings: Spelling fixes
- RTC and WDT: Use exported function instead of function pointer for WDT
  arming/disarming
- MFD: Export WDT arming/disarming function instead of providing a
  pointer to it.
- Various styling fixes.

Changelog v8:
- regulators(*), wdt, gpio, rtc, mfd(*) and dt-bindings unchanged.
  (*)Patches 1-3 squashed to not break bisecting.

- removed unnecessary newline from clk
- fixed possible use of uninitialized 'reg' from power-supply.
  Found by 0-day tests and reported by Dan Carpenter.

Changelog v7:
Only patch 2 changed.
- Avoid out-of-array-bounds access at regulator probe if unsupported
  chip type is passed to bd718x7 regulator driver.

Changelog v6:
Only patch 10 changed.
- styling fixes pointed by Gunter Roeck
- dropped RFC tag

Changelog v5 (RFC):
Only patch 7 changed.
- Explained why lock is not needed at GPIO value getting
- removed ampersands from function pointer assignments.

Changelog v4 (RFC):
patches 1,2,3,4,5,10 are unchanged from v3
DT-binding fixes suggested by Rob Herring:
- drop interrupt-parent
- drop clock-frequency
- change pmic node name to a generic one
RTC:
- enable RTC block's irqs before registering rtc
GPIO fixes after initial testing:
- fix getting GPIO value when direction is output
POWER:
- Add ASCII art intended to clarify the charger HW state machine

Changelog v3 (RFC):
patches 1,2,3,4,5,6,7,8 and 10 are unchanged from v2
RTC fixups suggested by Guenter Roeck:
- create bd70528_set_time_locked function in order to simplify
  error handling and to make mutex lock/unlock path more obvious
- don't ignore errors on bd70528_set_time_locked
- simplify bd70528_read_alarm enabled condition setting
- add __packed to structs where members are mapped to HW registers
- remove unnecessary brackets from enable condition in set_wake
RTC: fixups suggested by Alessandro Belloni
- don't use deprecated devm_rtc_device_register
- add alarm_irq_enable callback
- add range_min and range_max
WDT:
- add regmap and mutex pointers to WDT data so that they can be accessed
  without dereferencing the parent data
- remove parent data pointer from WDT data
- embed struct watchdog_device into WDT data in order to avoid double
  allocation.
GPIO:
- remove unused header as pointed by Linus Walleij
POWER:
- do not copy the whole MFD data (especially the mutex to avoid
  all possibilities of accidentally using the copy of a mutex)

Changelog v2 (RFC): Mainly feedback from Guenter Roeck:
- patches 1, 2, 3, 4, 5, 9 are unchanged.
- mfd: own mutex for each bd70528 instance - embed in struct bd70528
- watchdog: do not copy parent device data
- watchdog: fix deadlock caused by double locked mutex
- watchdog: set initial timeouts and WDT parent information
- watchdog: remove unnecessary ping function from ops
- watchdog: and the comment regarding it
- watchdog: allocate watchdog struct in order to allow multiple WDG
  instances
- rtc: bd70528 fix the order of mutex unlock and re-enabling RTC based
  timers
- rtc: fix the irq mask register address
- power: fix the irq mask register address
- regulator/regmap-irq: Drop the patches 1, 8 and 9 from original series
  as those were already applied by Mark 

Patch 1:
	split the bd718x7.h to generic and chip specific portions.
	(breaks compilation without patch 2 and 3)
	- adapt bd718x7.h changes to bd718x7 regulator driver
	- adapt bd718x7.h changes to bd718x7 clk driver
Patch 2:
	add MFD core support for bd70528
Patch 3:
	support bd70528 clk using bd718x7 clk driver
Patch 4:
	document DT bindings for BD70528
Patch 5:
	support BD70528 GPIO block
Patch 6:
	support BD70528 RTC
Patch 7:
	support BD70528 battery charger
Patch 8:
	support BD70528 watchdog

This patch series is based on Linus' v5.1-rc2 tag.

---

Matti Vaittinen (8):
  mfd: regulator: clk: split rohm-bd718x7.h
  mfd: bd70528: Support ROHM bd70528 PMIC - core
  clk: bd718x7: Support ROHM BD70528 clk block
  dt-bindings: mfd: Document first ROHM BD70528 bindings
  gpio: Initial support for ROHM bd70528 GPIO block
  rtc: bd70528: Initial support for ROHM bd70528 RTC
  power: supply: Initial support for ROHM BD70528 PMIC charger block
  watchdog: bd70528: Initial support for ROHM BD70528 watchdog block

 .../bindings/mfd/rohm,bd70528-pmic.txt        | 102 +++
 drivers/clk/Kconfig                           |   6 +-
 drivers/clk/clk-bd718x7.c                     |  24 +-
 drivers/gpio/Kconfig                          |  11 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-bd70528.c                   | 232 ++++++
 drivers/mfd/Kconfig                           |  17 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/rohm-bd70528.c                    | 316 ++++++++
 drivers/mfd/rohm-bd718x7.c                    |  23 +-
 drivers/power/supply/Kconfig                  |   9 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/bd70528-charger.c        | 742 ++++++++++++++++++
 drivers/regulator/bd718x7-regulator.c         |  25 +-
 drivers/rtc/Kconfig                           |   8 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-bd70528.c                     | 500 ++++++++++++
 drivers/watchdog/Kconfig                      |  12 +
 drivers/watchdog/Makefile                     |   1 +
 drivers/watchdog/bd70528_wdt.c                | 290 +++++++
 include/linux/mfd/rohm-bd70528.h              | 408 ++++++++++
 include/linux/mfd/rohm-bd718x7.h              |  22 +-
 include/linux/mfd/rohm-generic.h              |  20 +
 23 files changed, 2726 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
 create mode 100644 drivers/gpio/gpio-bd70528.c
 create mode 100644 drivers/mfd/rohm-bd70528.c
 create mode 100644 drivers/power/supply/bd70528-charger.c
 create mode 100644 drivers/rtc/rtc-bd70528.c
 create mode 100644 drivers/watchdog/bd70528_wdt.c
 create mode 100644 include/linux/mfd/rohm-bd70528.h
 create mode 100644 include/linux/mfd/rohm-generic.h

-- 
2.17.2


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
