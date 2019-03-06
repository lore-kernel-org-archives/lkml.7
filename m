Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B5AC10F00
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12175206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfCFW4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 17:56:23 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:49001 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCFW4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 17:56:22 -0500
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id AAD79100006;
        Wed,  6 Mar 2019 22:56:20 +0000 (UTC)
Date:   Wed, 6 Mar 2019 23:56:20 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RTC for 5.1
Message-ID: <20190306225620.GA17610@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the pull-request for the RTC subsystem for 5.1.

There is an unusual amount of new drivers this cycle, and this explains
the number of insertions. Other than that, the changes are the usual
fixes and feature addition.

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-5.1

for you to fetch changes up to e91b94fd2bc411b5926031496bbc3de9a96bb1c6:

  rtc: pic32: convert to SPDX identifier (2019-03-04 20:23:15 +0100)

----------------------------------------------------------------
RTC for 5.0

Subsystem:
 - new quartz-load-femtofarads DT property for quartz load capacitance
 - remove rtc_class_ops.read_callback

New drivers:
 - Abracon AB-RTCMC-32.768kHz-EOZ9
 - Amlogic Meson RTC
 - Cadence RTC IP
 - Microcrystal RV3028
 - Whwave sd3078

Drivers:
 - cmos: ignore bogus century byte
 - ds1307: rework rx8130 support
 - isl1208: add isl1209 support, nvmem support
 - rs5C372: report invalid time when the oscillator stopped
 - rx8581: add rx8571 support

----------------------------------------------------------------
Alexandre Belloni (20):
      rtc: pcf8523: Add rv8523 compatible
      rtc: imx-sc: depend on HAVE_ARM_SMCCC
      rtc: meson: remove useless rtc_nvmem_unregister call
      rtc: rv3028: add new driver
      rtc: hid-sensor-time: stop selecting IIO
      rtc: remove rtc_class_ops.read_callback
      rtc: imx-sc: use rtc_time64_to_tm
      rtc: zynqmp: fix possible race condition
      rtc: zynqmp: let the core handle range
      rtc: tx4939: remove useless test
      rtc: tx4939: set range
      rtc: tx4939: switch to rtc_time64_to_tm/rtc_tm_to_time64
      rtc: tx4939: use .set_time
      rtc: tx4939: convert to SPDX identifier
      rtc: rv8803: let the core handle range
      rtc: rv8803: convert to SPDX identifier
      rtc: update my email address
      rtc: pic32: convert to devm_rtc_allocate_device
      rtc: pic32: let the core handle range
      rtc: pic32: convert to SPDX identifier

Alexey Roslyakov (1):
      rtc: pcf85063: remove dead code

Anson Huang (2):
      rtc: snvs: make sure clock is enabled for interrupt handle
      rtc: imx-sc: add rtc set time support

Artem Panfilov (2):
      dt-bindings: rtc: add ABEOZ9
      rtc: add AB-RTCMC-32.768kHz-EOZ9 RTC support

Biju Das (2):
      dt-bindings: rtc: add rx8571 compatible
      rtc: rx8581: Add support for Epson rx8571 RTC

Colin Ian King (4):
      rtc: ds1672: fix unintended sign extension
      rtc: 88pm860x: fix unintended sign extension
      rtc: 88pm80x: fix unintended sign extension
      rtc: pm8xxx: fix unintended sign extension

Dianlong Li (3):
      dt-bindings: define vendor prefix for whwave, Inc.
      dt-bindings: rtc: sd3078: add device tree documentation
      rtc: sd3078: new driver.

Eric Wong (1):
      rtc: cmos: ignore bogus century byte

Jan Kotas (2):
      dt-bindings: rtc: Add bindings for Cadence RTC
      rtc: Add Cadence RTC driver

Kangjie Lu (2):
      rtc: coh901331: fix a missing check of clk_prepare
      rtc: hym8563: fix a missing check of block data read

Marek Szyprowski (2):
      rtc: s3c: Rewrite clock handling
      rtc: s3c: Use generic helper to get driver data

Marek Vasut (2):
      dt-bindings: rtc: Add RV1805 to abracon,abx80x bindings
      rtc: abx80x: Configure reserved bits in RV1805

Martin Blumenstingl (2):
      dt-bindings: rtc: add device-tree bindings for the Amlogic Meson RTC
      rtc: support for the Amlogic Meson RTC

Oliver.Rohe@wago.com (2):
      rtc: rs5c372: r2221: fix to use the correct XSTP bit
      rtc: rs5c372: Fix reading from rtc when the oscillator got interrupted.

Sam Ravnborg (6):
      devicetree: property-units: Add femtofarads unit
      dt-bindings: rtc: Add quartz-load-femtofarads property
      dt-binding: pcf8523: add xtal load capacitance
      dt-binding: pcf85063: add xtal load capacitance
      rtc: pcf8523: set xtal load capacitance from DT
      rtc: pcf85063: set xtal load capacitance from DT

Trent Piepho (5):
      rtc: isl1208: fix negative digital trim reporting
      rtc: isl1208: Introduce driver state struct
      rtc: isl1208: Support more chip variations
      rtc: isl1208: Add new style nvmem support to driver
      dt-bindings: rtc: Update for new chip in isl1208 series

Uwe Kleine-König (5):
      rtc: ds1307: Move register definitions to start of file
      rtc: ds1307: forward declare chips array instead of a bunch of functions
      rtc: ds1307: correct register offset for rx8130
      rtc: ds1307: rx8130: honor Voltage Loss Flag when reading the time
      rtc: ds1307: rx8130: Fix alarm handling

Wei Yongjun (1):
      rtc: sd3078: make symbol 'sd3078_driver' static

YueHaibing (1):
      rtc: sd3078: fix platform_no_drv_owner.cocci warnings

ZhangXiaoxu (1):
      rtc: Fix UBSAN overflow warning

 .../devicetree/bindings/property-units.txt         |    1 +
 .../devicetree/bindings/rtc/abracon,abx80x.txt     |    1 +
 Documentation/devicetree/bindings/rtc/cdns,rtc.txt |   25 +
 .../devicetree/bindings/rtc/isil,isl1208.txt       |   38 +
 .../devicetree/bindings/rtc/isil,isl1219.txt       |   29 -
 .../devicetree/bindings/rtc/nxp,pcf85063.txt       |   18 +
 .../devicetree/bindings/rtc/nxp,pcf8523.txt        |   18 +
 .../devicetree/bindings/rtc/rtc-meson.txt          |   35 +
 Documentation/devicetree/bindings/rtc/rtc.txt      |   23 +-
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 MAINTAINERS                                        |    6 +
 drivers/rtc/Kconfig                                |   58 +-
 drivers/rtc/Makefile                               |    5 +
 drivers/rtc/dev.c                                  |    5 -
 drivers/rtc/lib.c                                  |    6 +-
 drivers/rtc/rtc-88pm80x.c                          |   21 +-
 drivers/rtc/rtc-88pm860x.c                         |   21 +-
 drivers/rtc/rtc-ab-eoz9.c                          |  465 +++++++++
 drivers/rtc/rtc-abx80x.c                           |   71 +-
 drivers/rtc/rtc-cadence.c                          |  423 ++++++++
 drivers/rtc/rtc-coh901331.c                        |    6 +-
 drivers/rtc/rtc-ds1307.c                           | 1095 ++++++++++----------
 drivers/rtc/rtc-ds1672.c                           |    3 +-
 drivers/rtc/rtc-hym8563.c                          |    2 +
 drivers/rtc/rtc-imx-sc.c                           |   21 +-
 drivers/rtc/rtc-isl1208.c                          |  167 ++-
 drivers/rtc/rtc-mc146818-lib.c                     |    2 +-
 drivers/rtc/rtc-meson.c                            |  407 ++++++++
 drivers/rtc/rtc-pcf85063.c                         |   46 +-
 drivers/rtc/rtc-pcf8523.c                          |   29 +-
 drivers/rtc/rtc-pic32.c                            |   34 +-
 drivers/rtc/rtc-pm8xxx.c                           |    6 +-
 drivers/rtc/rtc-rs5c372.c                          |   76 +-
 drivers/rtc/rtc-rv3028.c                           |  732 +++++++++++++
 drivers/rtc/rtc-rv8803.c                           |   15 +-
 drivers/rtc/rtc-rx8581.c                           |  114 +-
 drivers/rtc/rtc-s3c.c                              |   87 +-
 drivers/rtc/rtc-sd3078.c                           |  231 +++++
 drivers/rtc/rtc-snvs.c                             |    6 +
 drivers/rtc/rtc-tx4939.c                           |   26 +-
 drivers/rtc/rtc-zynqmp.c                           |   18 +-
 include/linux/rtc.h                                |    3 +-
 42 files changed, 3585 insertions(+), 811 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/cdns,rtc.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/isil,isl1208.txt
 delete mode 100644 Documentation/devicetree/bindings/rtc/isil,isl1219.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/nxp,pcf85063.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-meson.txt
 create mode 100644 drivers/rtc/rtc-ab-eoz9.c
 create mode 100644 drivers/rtc/rtc-cadence.c
 create mode 100644 drivers/rtc/rtc-meson.c
 create mode 100644 drivers/rtc/rtc-rv3028.c
 create mode 100644 drivers/rtc/rtc-sd3078.c

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
