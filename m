Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAB8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8DFE20657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gncXCDo4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfCKJc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:32:59 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40785 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfCKJc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 05:32:56 -0400
Received: by mail-lj1-f195.google.com with SMTP id w6so3369794ljd.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 02:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=G2I1ddSNJXo34BiIe8hxFVlhcwLlqEXZc24XjUtdtkA=;
        b=gncXCDo48Sm+/0RXAgvUbKUmdJbgFZH5JAdHn88CSs0hQQhQH0rY2nPUTAGNjo3YW1
         02/eM6hteUNZ22QBMB1ZkSka9b5clduFlk9u3FwfRETX0OvRCVy1HWxZbMtQ7LS2kyU3
         h0WKuOyQPTYjTURPYngY/EldmIRiFDQQagEbAKS+eLjqvQLp2P+Rr1PxyQJNp0fUcAlq
         NE40wtQSrIdH0KSPvZuJxmodLHBKD6G7WwDpJMOIz9Op9UfYf6k7zPgybe6nCFVtDtRq
         7zcbB/D/okvbOwQViz7pW5eideVZ2vBpT1wzU9gEzZ3Ko8gGjUcBdzYStCpZvSAIDBfj
         wlVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=G2I1ddSNJXo34BiIe8hxFVlhcwLlqEXZc24XjUtdtkA=;
        b=g5ujDFmYuGzXvs3IUbvllr0GLy6Z8FsnXbjf/Lat1mxxcoz7X3MmgDJMZDfs1eMFz7
         8UbaA6p3122U3gpb/r2lLxulqJG0Uc0NIDr9FEfJiv2aSa3b9LGJGnzAaDPVJCd9UkbG
         v24wM+BbIHwPNlwJkhIbhezufeEXJL8Hb0jtWuXcRnlpdPe2/c+MgASPgpL6ChIddfiH
         HDOEB16MQztZmHT6Pj//rGkt3QwNLCQYLr0HBJ5p6EnS6UMrHLtjJuSRAb6foWK3aipU
         RlRS9FSzAEOvyPNWfP/hZwAlVLeywYSKIGvUuznr7jeg4cGasParyoxnCIpZxUMb5Qrc
         fvvA==
X-Gm-Message-State: APjAAAVgfjKyUVsWezjmEtSxR9Ymo8m0ZYJ2M4MXXNyA1NqpjfDC4ZZs
        z0K3huuQXIHluEiYcdAxp0Rb7RgrmIgDiqVeDk0DoA==
X-Google-Smtp-Source: APXvYqwRBaQiuzPBIXPNaqw8u0+qbLViFrTuPmkgjP4JxtsU2JfxeIildHD10dhhfGVyYC1TjTYaWN9f4ToJRU2hBfI=
X-Received: by 2002:a2e:89d9:: with SMTP id c25mr17210710ljk.105.1552296773379;
 Mon, 11 Mar 2019 02:32:53 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Mar 2019 10:32:41 +0100
Message-ID: <CACRpkda_4oHv103MWt+D-cuKsXmu0ctSpZTjpKX3wAAVVwRSMA@mail.gmail.com>
Subject: [GIT PULL] pin control bulk changes for v5.1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here is the big pull request for the pin control subsystem updates
for the v5.1 kernel cycle.

Note that this had pulled in an immutable branch for Qualcomm
hierarchical IRQ domains, affecting a bunch of subsystems such
as SPMI, MFD and the ARM architecture. You already have this
in your tree from the GPIO pull request, and these commits are
all ACKed, it was pulled into the pin control tree to avoid
conflicts.

Other than that this is a calm cycle, not much happened this
time around: not even much incremental development. Some
three new drivers, that is all.

Please pull it it!

Yours,
Linus Walleij

The following changes since commit d13937116f1e82bf508a6325111b322c30c85eb9=
:

  Linux 5.0-rc6 (2019-02-10 14:42:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v5.1-1

for you to fetch changes up to 9bc8fee96e9a4b8f17ba1544bf323f1ae6ded81d:

  pinctrl: imx: fix scu link errors (2019-03-08 13:17:24 +0100)

----------------------------------------------------------------
This is the bulk of pin control changes for the v5.1 kernel cycle.

No core changes.

New drivers:

- NXP (ex Freescale) i.MX 8QM driver.

- NXP (ex Freescale) i.MX 8MM driver.

- AT91 SAM9X60 subdriver.

Improvements:

- Support for external interrups (EINT) on Mediatek virtual GPIOs.

- Make BCM2835 pin config fully generic.

- Lots of Renesas SH-PFC incremental improvements.

----------------------------------------------------------------
Aisheng Dong (1):
      pinctrl: imx: add imx8qm driver

Alexandre Torgue (2):
      pinctrl: stm32: fix memory leak issue
      pinctrl: stm32: return error upon hwspinlock failure

Anders Roxell (1):
      pinctrl: imx: fix scu link errors

Bai Ping (2):
      dt-bindings: imx: Add pinctrl binding doc for imx8mm
      pinctrl: freescale: Add imx8mm pinctrl driver support

Bjorn Andersson (2):
      pinctrl: qcom: qcs404: Drop unused UFS_RESET macro
      pinctrl: qcom: spmi-gpio: Reorder debug print

Brian Masney (15):
      dt-bindings: pinctrl: qcom-pmic-gpio: add qcom,pmi8998-gpio binding
      pinctrl: qcom: spmi-gpio: add support for three new variants
      pinctrl: qcom: spmi-gpio: hardcode IRQ counts
      spmi: pmic-arb: convert to v2 irq interfaces to support
hierarchical IRQ chips
      gpio: add irq domain activate/deactivate functions
      spmi: pmic-arb: disassociate old virq if hwirq mapping already exists
      qcom: spmi-gpio: add support for hierarchical IRQ chip
      ARM: dts: qcom: pm8941: add interrupt controller properties
      ARM: dts: qcom: pma8084: add interrupt controller properties
      arm64: dts: qcom: pm8005: add interrupt controller properties
      arm64: dts: qcom: pm8998: add interrupt controller properties
      arm64: dts: qcom: pmi8994: add interrupt controller properties
      arm64: dts: qcom: pmi8998: add interrupt controller properties
      spmi: pmic-arb: validate type when mapping IRQ
      spmi: pmic-arb: revert "disassociate old virq if hwirq mapping
already exists"

Chen-Yu Tsai (1):
      pinctrl: sunxi: Support I/O bias voltage setting on A80

Claudiu Beznea (7):
      pinctrl: at91: add option to use drive strength bits
      pinctrl: at91: add drive strength support for SAM9X60
      pinctrl: at91: add compatibles for SAM9X60 pin controller
      dt-bindings: add documentation for banks
      dt-bindings: add bindings for SAM9X60
      pinctrl: at91: add slewrate support for SAM9X60
      dt-bindings: add documentation for slew rate

Geert Uytterhoeven (15):
      pinctrl: sh-pfc: r8a77990: GP6_9 does not have pull-down capability
      Revert "pinctrl: sh-pfc: r8a77990: Add support for pull-up only pins"
      pinctrl: sh-pfc: Print pin group when debugging
      pinctrl: sh-pfc: r8a7795: Deduplicate VIN5 pin definitions
      pinctrl: sh-pfc: r8a7796: Deduplicate VIN5 pin definitions
      pinctrl: sh-pfc: r8a77970: Deduplicate VIN[01] pin definitions
      pinctrl: sh-pfc: r8a77980: Deduplicate VIN1 pin definitions
      pinctrl: sh-pfc: r8a7791: Fix VIN1 versioned groups
      pinctrl: sh-pfc: r8a77965: Replace DU_DOTCLKIN2 by DU_DOTCLKIN3
      pinctrl: sh-pfc: r8a7778: Fix HSPI pin numbers and names
      pinctrl: sh-pfc: emev2: Add missing pinmux functions
      pinctrl: sh-pfc: r8a7791: Fix scifb2_data_c pin group
      pinctrl: sh-pfc: r8a7792: Fix vin1_data18_b pin group
      pinctrl: sh-pfc: sh73a0: Fix fsic_spdif pin groups
      pinctrl: sh-pfc: Validate fixed-size field widths at build time

Gregory CLEMENT (2):
      pinctrl: armada-37xx: add missing pin: PCIe1 Wakeup
      pinctrl: dt-bindings: Fix the armada-37xx documentation

Gustavo A. R. Silva (2):
      pinctrl: mcp23s08: use struct_size() in devm_kzalloc()
      pinctrl: sirf: atlas7: use struct_size() in devm_kzalloc()

Jerome Brunet (2):
      dt-bindings: pinctrl: meson: update register descriptions
      pinctrl: meson: add optional region for drive strength

Jisheng Zhang (1):
      pinctrl: berlin: as370: use generic "pwm" as pwm function name

Jonathan Neusch=C3=A4fer (1):
      dt-bindings: pinctrl: Document the i.MX50 IOMUXC binding

Krzysztof Kozlowski (1):
      pinctrl: samsung: Remove legacy API for handling external wakeup
interrupts mask

Lars Poeschel (1):
      pinctrl: mcp23s08: Allocate irq_chip dynamic

Linus Walleij (5):
      Merge branch 'ib-meson-fixes' into devel
      Merge branch 'ib-qcom-spmi' of /home/linus/linux-gpio into devel
      Merge tag 'sh-pfc-for-v5.1-tag1' of
git://git.kernel.org/.../geert/renesas-drivers into devel
      Merge tag 'v5.0-rc6' into devel
      Merge tag 'sh-pfc-for-v5.1-tag2' of
git://git.kernel.org/.../geert/renesas-drivers into devel

Marek Beh=C3=BAn (1):
      pinctrl: armada-37xx: Correct mpp definitions

Martin Blumenstingl (1):
      pinctrl: meson: meson8b: add the eth_rxd2 and eth_rxd3 pins

Matteo Croce (1):
      pinctrl/amd: fix typo

Miquel Raynal (1):
      pinctrl: armada-37xx: change suspend/resume time

Nishanth Menon (1):
      pinctrl: ti: iodelay: Lower the priority of prints

Paul Cercueil (1):
      pinctrl: ingenic: Add LCD pins for the JZ4725B SoC

Ramon Fried (1):
      pinctrl.txt: Remove outdated information

Stefan Wahren (2):
      pinctrl: bcm2835: declare pin config as generic
      pinctrl: bcm2835: Direct GPIO config changes to generic pinctrl

Takeshi Kihara (8):
      pinctrl: sh-pfc: r8a77990: Fix MOD_SEL0 bit3 when using TX0
      pinctrl: sh-pfc: r8a77990: Fix MOD_SEL0 bit2 when using RX2, TX2 and =
SCK2
      pinctrl: sh-pfc: r8a77990: Fix MOD_SEL bit numbering
      pinctrl: sh-pfc: r8a77995: Fix MOD_SEL bit numbering
      pinctrl: sh-pfc: r8a77990: Add TMU pins, groups and functions
      pinctrl: sh-pfc: r8a77990: Add DRIF pins, groups and functions
      pinctrl: sh-pfc: r8a77965: Add TMU pins, groups and functions
      pinctrl: sh-pfc: r8a77965: Add DRIF pins, groups and functions

Vladimir Zapolskiy (2):
      pinctrl: remove pinctrl/machine.h inclusion from pinctrl/pinconf.h
      pinctrl: remove unused 'pinconf-config' debugfs interface

WangBo (1):
      pinctrl: nomadik: fix possible object reference leak

Wolfram Sang (2):
      pinctrl: sh-pfc: r8a7790: Initialize TDSEL register for ES1.0
      pinctrl: sh-pfc: r8a7794: Initialize TDSEL register for ES1.0

Xingyu Chen (1):
      pinctrl: meson: fix G12A ao pull registers base address

YueHaibing (2):
      pinctrl: ti-iodelay: Fix platform_no_drv_owner.cocci warnings
      pinctrl: sirf: drop pointless static qualifier in sirfsoc_gpio_probe

Zhou Yanjie (3):
      Pinctrl: Ingenic: Fix bugs caused by differences between JZ4770
and JZ4780.
      Pinctrl: Ingenic: Add missing parts for JZ4770 and JZ4780.
      Pinctrl: Ingenic: Unify the function name prefix to "ingenic_gpio_".

chuanjia.liu (1):
      pinctrl: mediatek: add EINT support to virtual GPIOs

 .../bindings/pinctrl/atmel,at91-pinctrl.txt        |  27 +-
 .../bindings/pinctrl/fsl,imx50-pinctrl.txt         |  32 ++
 .../bindings/pinctrl/fsl,imx8mm-pinctrl.txt        |  36 ++
 .../pinctrl/marvell,armada-37xx-pinctrl.txt        |  24 +-
 .../devicetree/bindings/pinctrl/meson,pinctrl.txt  |  10 +-
 .../devicetree/bindings/pinctrl/qcom,pmic-gpio.txt |   1 +
 Documentation/driver-api/pinctl.rst                |   9 -
 arch/arm/boot/dts/qcom-pm8941.dtsi                 |  38 +-
 arch/arm/boot/dts/qcom-pma8084.dtsi                |  24 +-
 arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h     | 629 +++++++++++++++++=
++++
 arch/arm64/boot/dts/qcom/pm8005.dtsi               |   6 +-
 arch/arm64/boot/dts/qcom/pm8998.dtsi               |  28 +-
 arch/arm64/boot/dts/qcom/pmi8994.dtsi              |  12 +-
 arch/arm64/boot/dts/qcom/pmi8998.dtsi              |  16 +-
 drivers/gpio/gpiolib.c                             |  37 ++
 drivers/pinctrl/bcm/pinctrl-bcm2835.c              |   4 +-
 drivers/pinctrl/berlin/pinctrl-as370.c             |  58 +-
 drivers/pinctrl/cirrus/pinctrl-madera-core.c       |   1 +
 drivers/pinctrl/freescale/Kconfig                  |  16 +-
 drivers/pinctrl/freescale/Makefile                 |   2 +
 drivers/pinctrl/freescale/pinctrl-imx8mm.c         | 348 ++++++++++++
 drivers/pinctrl/freescale/pinctrl-imx8qm.c         | 326 +++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c   |   8 +-
 drivers/pinctrl/meson/pinctrl-meson.c              |  24 +-
 drivers/pinctrl/meson/pinctrl-meson.h              |   1 +
 drivers/pinctrl/meson/pinctrl-meson8b.c            |   6 +-
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c        |  15 +-
 drivers/pinctrl/nomadik/pinctrl-nomadik.c          |  17 +-
 drivers/pinctrl/pinconf.c                          | 222 --------
 drivers/pinctrl/pinctrl-amd.c                      |   2 +-
 drivers/pinctrl/pinctrl-at91.c                     | 134 ++++-
 drivers/pinctrl/pinctrl-at91.h                     |   3 +
 drivers/pinctrl/pinctrl-ingenic.c                  | 367 +++++++++---
 drivers/pinctrl/pinctrl-mcp23s08.c                 |  31 +-
 drivers/pinctrl/qcom/pinctrl-qcs404.c              |  25 -
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c           | 142 ++++-
 drivers/pinctrl/samsung/pinctrl-exynos.c           |  12 +-
 drivers/pinctrl/sh-pfc/pfc-emev2.c                 |  20 +
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c               |   6 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c               |  17 +
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c               |  70 +--
 drivers/pinctrl/sh-pfc/pfc-r8a7792.c               |   1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c               |  16 +
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c               |  90 +--
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c               |  90 +--
 drivers/pinctrl/sh-pfc/pfc-r8a77965.c              | 404 ++++++++++++-
 drivers/pinctrl/sh-pfc/pfc-r8a77970.c              | 128 ++---
 drivers/pinctrl/sh-pfc/pfc-r8a77980.c              |  64 +--
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c              | 388 +++++++++++--
 drivers/pinctrl/sh-pfc/pfc-r8a77995.c              |  11 +-
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c                |   3 +-
 drivers/pinctrl/sh-pfc/pinctrl.c                   |   2 +
 drivers/pinctrl/sh-pfc/sh_pfc.h                    |   3 +-
 drivers/pinctrl/sirf/pinctrl-atlas7.c              |   4 +-
 drivers/pinctrl/sirf/pinctrl-sirf.c                |   2 +-
 drivers/pinctrl/stm32/pinctrl-stm32.c              |  70 ++-
 drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c        |   1 +
 drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c          |   1 +
 drivers/pinctrl/sunxi/pinctrl-sunxi.c              |  41 ++
 drivers/pinctrl/sunxi/pinctrl-sunxi.h              |  12 +
 drivers/pinctrl/ti/pinctrl-ti-iodelay.c            |   7 +-
 drivers/spmi/spmi-pmic-arb.c                       |  74 ++-
 include/dt-bindings/pinctrl/at91.h                 |   4 +
 include/linux/gpio/driver.h                        |   5 +
 include/linux/pinctrl/pinconf.h                    |   6 -
 65 files changed, 3249 insertions(+), 984 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/pinctrl/fsl,imx50-pinctrl.txt
 create mode 100644
Documentation/devicetree/bindings/pinctrl/fsl,imx8mm-pinctrl.txt
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
 create mode 100644 drivers/pinctrl/freescale/pinctrl-imx8mm.c
 create mode 100644 drivers/pinctrl/freescale/pinctrl-imx8qm.c
