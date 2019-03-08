Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51120C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC552087C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gk/hzMIQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfCHPEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 10:04:04 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36090 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfCHPEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 10:04:04 -0500
Received: by mail-lj1-f195.google.com with SMTP id v10so17652134lji.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 07:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rSc2Fs/Qnsy6alCu2pT+O5708I19aJIRzSNVpG2UlPM=;
        b=gk/hzMIQCIXMksqrJKeDzM5hOJEEDJUR+Rm8N6ZDH7DU1jtCZObo4JZCxep6/5Jxyt
         tgJjGWZN3zDXH98mC8zub0Lm2uF/9Xj0qdNlq6jDOSVxDbEZy+rtd7jKUYOQEc6FnU2R
         9RR/j894O1kpxlKH0PDcIKmxHuafL5vjmY3RVPCli2y6JtTop2KW/sV3AYjA/V16BO+J
         mfNZ03mhSu8sSbORL8dmNM5IzxPNjivyQym3wlksD7CWQqwJ+5ZNAXpVAr60JwUAuT3Q
         0tQb4Ug5hba4KNHTgbLvypopbWKj63s0rh3+JFjM3KzofNC5+8Pll5DavSWlMZ13YHmi
         4PkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rSc2Fs/Qnsy6alCu2pT+O5708I19aJIRzSNVpG2UlPM=;
        b=FCmz3/zL+LtrBbMef+srwI9Nl2MAKKnQTllvAZz0XyC7JOCOzEgGNVEMKSdGT2Pqv/
         cpEB6aoHtbHWNTIUAR+HV9i/fDXh0Ee5Dui4D7DUve0dkzeLMaxFENneWqvWp1hjkYwJ
         q6mpJfwwJ2jjFr/CVtkQxtn2ZaqAJyS5CopDUzZXGfmauMQCldei9x/Rqns+CyrzZwcu
         OuinGg/Fvhu7iKFacbAlzuRiWRpAV03MIo1KuC86DqRmMizQVaYYr4aReAddPy/Mf3YM
         bEmHnlxgzmn0FqkT7zaT3IPWImfAQ4jqzDPZ9hZHt+ksP034llo7zdnZEOyC5UL6eboR
         4MVA==
X-Gm-Message-State: APjAAAX6wmZa6pQM0EKTaf3PkguCHHOnQuQY+SfkwRJNIeRQDXMJO2uC
        Op0U3RAt5ZYsKDw+llTzCGd02EWV+htC/cFlRm03sA==
X-Google-Smtp-Source: APXvYqxJVYxNYsa3PDxQUEUvqwvcYGJrNaSvmq9LWU61OpPk2eRZUX2LZOGYuQhXzSyrGlZasOxw9xuVpriQ8zDHXIo=
X-Received: by 2002:a2e:89d9:: with SMTP id c25mr9990839ljk.105.1552057439827;
 Fri, 08 Mar 2019 07:03:59 -0800 (PST)
MIME-Version: 1.0
References: <CACRpkdYcT3zkSUo74i=WXS4AhHtKEDF2K8o1wttsZeGMK9cvCQ@mail.gmail.com>
In-Reply-To: <CACRpkdYcT3zkSUo74i=WXS4AhHtKEDF2K8o1wttsZeGMK9cvCQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 8 Mar 2019 16:03:48 +0100
Message-ID: <CACRpkda7uJf=o_+EtPZ+rZHwYwvoBiQcm5m2wiUZHf597kgU8w@mail.gmail.com>
Subject: Re: [GIT PULL] Bulk GPIO changes for the v5.1 kernel cycle
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brian Masney <masneyb@onstation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I got a few fixes since three days ago, maybe you already tried to
pull this and got annoyed of the Kconfig noise, if you didn't, then
I am pleased to not annoy you.

The massage and tag is the same, just with a few new nice fixes
on top. The problems were in minor platform drivers, but it was
annoying so now those problems are gone. Arnd and Randy
fixed it up.

I updated the pull request with the proper hash and shortstat
below.

Yours,
Linus Walleij

On Tue, Mar 5, 2019 at 10:35 AM Linus Walleij <linus.walleij@linaro.org> wr=
ote:

> here is the bulk of the GPIO changes for the v5.1 kernel cycle.
> I'm very happy to get this merged now because the development
> has been all over the place, all is properly ACKed as far as possible
> and has been merging and compiling nicely in linux-next but it
> still makes me nervous to have it lying around on different immutable
> branches and what not.
>
> The signed tag describes what the changes are about. We have
> some hunks hitting x86 platform code, generic irqchip, ARM device
> trees and machines, pin control and even device core. The respective
> subsystem maintainers have been involved and ACKed the patches.
>
> Please pull it in for v5.1!

The following changes since commit d13937116f1e82bf508a6325111b322c30c85eb9=
:

  Linux 5.0-rc6 (2019-02-10 14:42:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
tags/gpio-v5.1-1

for you to fetch changes up to d01849f7deba81f4959fd9e51bf20dbf46987d1c:

  gpio: gpio-omap: fix level interrupt idling (2019-03-08 14:11:30 +0100)

----------------------------------------------------------------
This is the bulk of GPIO changes for the v5.1 cycle:

Core changes:

- The big change this time around is the irqchip handling in
  the qualcomm pin controllers, closely coupled with the
  gpiochip. This rework, in a classic fall-between-the-chairs
  fashion has been sidestepped for too long. The Qualcomm
  IRQchips using the SPMI and SSBI transport mechanisms have
  been rewritten to use hierarchical irqchip. This creates
  the base from which I intend to gradually pull support for
  hierarchical irqchips into the gpiolib irqchip helpers to
  cut down on duplicate code. We have too many hacks in the
  kernel because people have been working around the missing
  hierarchical irqchip for years, and once it was there,
  noone understood it for a while. We are now slowly adapting
  to using it. This is why this pull requests include changes
  to MFD, SPMI, IRQchip core and some ARM Device Trees
  pertaining to the Qualcomm chip family. Since Qualcomm have
  so many chips and such large deployments it is paramount
  that this platform gets this right, and now it (hopefully)
  does.

- Core support for pull-up and pull-down configuration, also
  from the device tree. When a simple GPIO chip support a
  "off or on" pull-up or pull-down resistor, we provide a
  way to set this up using machine descriptors or device tree.
  If more elaborate control of pull up/down (such as
  resistance shunt setting) is required, drivers should be
  phased over to use pin control. We do not yet provide a
  userspace ABI for this pull up-down setting but I suspect
  the makers are going to ask for it soon enough. PCA953x
  is the first user of this new API.

- The GPIO mockup driver has been revamped after some
  discussion improving the IRQ simulator in the process.
  The idea is to make it possible to use the mockup for
  both testing and virtual prototyping, e.g. when you do
  not yet have a GPIO expander to play with but really
  want to get something to develop code around before
  hardware is available. It's neat. The blackbox testing
  usecase is currently making its way into kernelci.

- ACPI GPIO core preserves non direction flags when updating
  flags.

- A new device core helper for devm_platform_ioremap_resource()
  is funneled through the GPIO tree with Greg's ACK.

New drivers:

- TQ-Systems QTMX86 GPIO controllers (using port-mapped
  I/O)

- Gateworks PLD GPIO driver (vaccumed up from OpenWrt)

- AMD G-Series PCH (Platform Controller Hub) GPIO driver.

- Fintek F81804 & F81966 subvariants.

- PCA953x now supports NXP PCAL6416.

Driver improvements:

- IRQ support on the Nintendo Wii (Hollywood) GPIO.

- get_direction() support for the MVEBU driver.

- Set the right output level on SAMA5D2.

- Drop the unused irq trigger setting on the Spreadtrum
  driver.

- Wakeup support for PCA953x.

- A slew of cleanups in the various Intel drivers.

----------------------------------------------------------------
Andrew Lunn (1):
      gpio: tqmx86: Add GPIO from for this IO controller

Andy Shevchenko (12):
      gpiolib: acpi: Correct kernel doc of struct acpi_gpio_event
      gpio: crystalcove: Use for_each_set_bit() in IRQ handler
      gpio: wcove: Allow return negative error code from to_reg()
      gpio: msic: Remove duplicate check in IRQ handler
      gpio: crystalcove: Sort headers alphabetically
      gpio: msic: Sort headers alphabetically
      gpio: wcove: Sort headers alphabetically
      gpio: wcove: Fix indentation
      gpio: crystalcove: Convert to use SPDX identifier
      gpio: msic: Convert to use SPDX identifier
      gpio: wcove: Convert to use SPDX identifier
      gpio: pca953x: Use PCA_LATCH_INT

Anson Huang (1):
      gpio: mxc: add check to return defer probe if clock tree NOT ready

Arnd Bergmann (1):
      x86: apuv2: remove unused variable

Axel Lin (4):
      gpio: sama5d2-piobu: Set proper output level for direction_output
      gpio: altera-a10sr: Trivial coding style fix
      gpio: tqmx86: Set proper output level for direction_output
      gpio: amd-fch: Set proper output level for direction_output

Baolin Wang (3):
      gpio: sprd: Remove unused irq trigger setting
      gpio: sprd: Use SoC compatible string instead of wildcard string
      gpio: sprd: Change to use SoC compatible string

Bartosz Golaszewski (10):
      irq/irq_sim: add irq_set_type() callback
      gpio: mockup: add locking
      gpio: mockup: implement get_multiple()
      gpio: mockup: don't create the debugfs link named after the label
      gpio: mockup: change the type of 'offset' to unsigned int
      gpio: mockup: change the signature of unlocked get/set helpers
      gpio: mockup: rework debugfs interface
      drivers: provide devm_platform_ioremap_resource()
      gpio: davinci: use devm_platform_ioremap_resource()
      drivers: depend on HAS_IOMEM for devm_platform_ioremap_resource()

Baruch Siach (1):
      gpio: mvebu: implement get_direction

Bjorn Andersson (1):
      qcom: spmi-gpio: Fix boundary conditions IRQ domain translate

Brian Masney (30):
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
      genirq: export irq_chip_set_wake_parent symbol
      pinctrl: qcom: spmi-gpio: select IRQ_DOMAIN_HIERARCHY in Kconfig
      spmi: pmic-arb: revert "validate type when mapping IRQ"
      pinctrl: qcom: ssbi-gpio: hardcode IRQ counts
      genirq: introduce irq_domain_translate_twocell
      mfd: pm8xxx: convert to v2 irq interfaces to support
hierarchical IRQ chips
      mfd: pm8xxx: disassociate old virq if hwirq mapping already exists
      qcom: ssbi-gpio: add support for hierarchical IRQ chip
      arm: dts: qcom: apq8064: add interrupt controller properties
      arm: dts: qcom: msm8660: add interrupt controller properties
      arm: dts: qcom: mdm9615: add interrupt controller properties
      mfd: pm8xxx: revert "disassociate old virq if hwirq mapping
already exists"
      spmi: pmic-arb: select IRQ_DOMAIN_HIERARCHY in Kconfig
      mfd: pm8xxx: select IRQ_DOMAIN_HIERARCHY in Kconfig
      qcom: ssbi-gpio: correct boundary conditions in pm8xxx_domain_transla=
te

Charles Keepax (1):
      gpio: madera: Add missing const

Enrico Weigelt, metux IT consult (2):
      gpio: AMD G-Series PCH gpio driver
      x86: pcengines apuv2 gpio/leds/keys platform driver

Geert Uytterhoeven (2):
      gpio: pcf857x: Simpify wake-up handling
      gpio: pca953x: Add wake-up support

Gustavo A. R. Silva (1):
      gpio: sprd: Add missing break in switch statement

Hans de Goede (1):
      gpiolib-acpi: Preserve non direction flags when updating gpiod_flags

Jonathan Neusch=C3=A4fer (2):
      gpio: hlwd: Add basic IRQ support
      gpio: hlwd: Implement edge trigger emulation

Linus Walleij (16):
      Merge branch 'ib-qcom-spmi' into devel
      dt-bindings: Add a prefix for Gateworks Corporation
      gpio: Add DT bindings for Gateworks PLD GPIO
      gpio: Add a Gateworks PLD GPIO driver
      genirq: introduce irq_chip_mask_ack_parent()
      ARM: dts: qcom-apq8060: Fix up interrupt parents
      Merge branch 'ib-pca953x-config' into devel
      Merge tag 'gpio-v5.1-updates-for-linus' of
git://git.kernel.org/.../brgl/linux into devel
      Merge tag 'intel-gpio-v5.1-1' of
git://git.kernel.org/.../andy/linux-gpio-intel into devel
      gpio: tegra: Fix offset of pinctrl calls
      Merge tag 'gpio-v5.1-updates-for-linus-part-2' of
git://git.kernel.org/.../brgl/linux into devel
      Merge branch 'ib-qcom-ssbi' into devel
      gpio: ixp4xx: Add DT bindings
      gpio: ftgpio: Register per-instance irqchip
      gpio: amd-fch: Drop const from resource
      gpio: amd-fch: Fix type error found by sparse

Marek Vasut (2):
      gpio: of: Apply regulator-gpio quirk only to enable-gpios
      gpio: of: Handle both enable-gpio{,s}

Mark Walton (1):
      gpio: pca953x: Fix dereference of irq data in shutdown

Nikolaus Voss (2):
      gpio: adp5588: Add device tree support
      gpio: adp5588.c: Switch to events system

Phil Reid (1):
      gpio: altera: Fixup block comment style

Randy Dunlap (2):
      Documenation: driver-api: fix gpio/board.rst warning
      platform/x86: fix PCENGINES_APU2 Kconfig warning

Russell King (1):
      gpio: gpio-omap: fix level interrupt idling

Souptick Joarder (1):
      arm/mach-sa1100/simpad.c: Remove duplicate header

Steffen Kothe (1):
      gpio-f7188x: add support Fintek F81804 & F81966

Thierry Reding (2):
      gpio: tegra186: Use TEGRA186_ prefix for GPIO names
      gpio: of: Restrict enable-gpio quirk to regulator-gpio

Thomas Petazzoni (10):
      gpio: pca953x: reduce indentation level in pca953x_irq_setup()
      gpio: pca953x: use a per instance irq_chip structure
      dt-bindings: gpio: document the new pull-up/pull-down flags
      gpio: rename gpio_set_drive_single_ended() to gpio_set_config()
      gpio: use new gpio_set_config() helper in more places
      gpio: add core support for pull-up/pull-down configuration
      gpio: pca953x: add ->set_config implementation
      gpio: zynq: properly support runtime PM for GPIO used as interrupts
      dt-bindings: gpio: pca953x: document the nxp,pcal6416
      gpio: pca953x: add support for pcal6416 type

Uwe Kleine-K=C3=B6nig (1):
      Documentation: gpio: legacy: Don't use POLLERR for poll(2)

Vladimir Zapolskiy (1):
      gpio: rcar: select General Output Register to set output states

Wei Yongjun (1):
      gpio: tqmx86: Drop unnecessary gpiochip_remove in tqmx86_gpio_probe()

Wolfram Sang (1):
      Documentation: gpio: driver: fix wire name for I2C

 .../bindings/gpio/gateworks,pld-gpio.txt           |  20 ++
 .../devicetree/bindings/gpio/gpio-eic-sprd.txt     |   4 +-
 .../devicetree/bindings/gpio/gpio-pca953x.txt      |   1 +
 Documentation/devicetree/bindings/gpio/gpio.txt    |  12 +
 .../devicetree/bindings/gpio/intel,ixp4xx-gpio.txt |  38 +++
 .../devicetree/bindings/pinctrl/qcom,pmic-gpio.txt |   1 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 Documentation/driver-api/gpio/board.rst            |   1 +
 Documentation/driver-api/gpio/driver.rst           |   2 +-
 Documentation/driver-api/gpio/legacy.rst           |   9 +-
 MAINTAINERS                                        |  12 +
 arch/arm/boot/dts/qcom-apq8060-dragonboard.dts     |  21 +-
 arch/arm/boot/dts/qcom-apq8064.dtsi                |  46 +--
 arch/arm/boot/dts/qcom-mdm9615.dtsi                |   9 +-
 arch/arm/boot/dts/qcom-msm8660.dtsi                |  47 +--
 arch/arm/boot/dts/qcom-pm8941.dtsi                 |  38 +--
 arch/arm/boot/dts/qcom-pma8084.dtsi                |  24 +-
 arch/arm/mach-sa1100/simpad.c                      |   1 -
 arch/arm64/boot/dts/qcom/pm8005.dtsi               |   6 +-
 arch/arm64/boot/dts/qcom/pm8998.dtsi               |  28 +-
 arch/arm64/boot/dts/qcom/pmi8994.dtsi              |  12 +-
 arch/arm64/boot/dts/qcom/pmi8998.dtsi              |  16 +-
 drivers/base/platform.c                            |  20 ++
 drivers/gpio/Kconfig                               |  24 ++
 drivers/gpio/Makefile                              |   3 +
 drivers/gpio/gpio-adp5588.c                        | 234 ++++++---------
 drivers/gpio/gpio-altera-a10sr.c                   |  17 +-
 drivers/gpio/gpio-altera.c                         |   4 +-
 drivers/gpio/gpio-amd-fch.c                        | 194 ++++++++++++
 drivers/gpio/gpio-crystalcove.c                    |  30 +-
 drivers/gpio/gpio-davinci.c                        |   4 +-
 drivers/gpio/gpio-eic-sprd.c                       |   1 +
 drivers/gpio/gpio-f7188x.c                         |  24 +-
 drivers/gpio/gpio-ftgpio010.c                      |  20 +-
 drivers/gpio/gpio-gw-pld.c                         | 137 +++++++++
 drivers/gpio/gpio-hlwd.c                           | 192 +++++++++++-
 drivers/gpio/gpio-madera.c                         |   2 +-
 drivers/gpio/gpio-mockup.c                         | 189 ++++++++++--
 drivers/gpio/gpio-msic.c                           |  34 +--
 drivers/gpio/gpio-mvebu.c                          |  11 +
 drivers/gpio/gpio-mxc.c                            |   5 +-
 drivers/gpio/gpio-omap.c                           |  14 +-
 drivers/gpio/gpio-pca953x.c                        | 190 ++++++++----
 drivers/gpio/gpio-pcf857x.c                        |  15 +-
 drivers/gpio/gpio-pmic-eic-sprd.c                  |   3 +-
 drivers/gpio/gpio-rcar.c                           |  12 +-
 drivers/gpio/gpio-sama5d2-piobu.c                  |  20 +-
 drivers/gpio/gpio-tegra.c                          |  25 +-
 drivers/gpio/gpio-tegra186.c                       |  70 ++---
 drivers/gpio/gpio-tqmx86.c                         | 332 +++++++++++++++++=
++++
 drivers/gpio/gpio-wcove.c                          |  29 +-
 drivers/gpio/gpio-zynq.c                           |  24 ++
 drivers/gpio/gpiolib-acpi.c                        |   7 +-
 drivers/gpio/gpiolib-of.c                          |   9 +-
 drivers/gpio/gpiolib.c                             |  87 +++++-
 drivers/gpio/gpiolib.h                             |   2 +
 drivers/mfd/Kconfig                                |   2 +-
 drivers/mfd/qcom-pm8xxx.c                          |  75 ++---
 drivers/pinctrl/qcom/Kconfig                       |   2 +
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c           | 141 +++++++--
 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c           | 157 ++++++++--
 drivers/platform/x86/Kconfig                       |  14 +
 drivers/platform/x86/Makefile                      |   1 +
 drivers/platform/x86/pcengines-apuv2.c             | 260 ++++++++++++++++
 drivers/spmi/Kconfig                               |   2 +-
 drivers/spmi/spmi-pmic-arb.c                       |  67 +++--
 include/dt-bindings/gpio/gpio.h                    |   6 +
 include/linux/gpio/driver.h                        |   5 +
 include/linux/gpio/machine.h                       |   2 +
 include/linux/irq.h                                |   1 +
 include/linux/irqdomain.h                          |   5 +
 include/linux/of_gpio.h                            |   2 +
 include/linux/platform_data/gpio/gpio-amd-fch.h    |  46 +++
 include/linux/platform_device.h                    |   3 +
 kernel/irq/chip.c                                  |  12 +
 kernel/irq/irq_sim.c                               |  12 +
 kernel/irq/irqdomain.c                             |  45 ++-
 77 files changed, 2438 insertions(+), 755 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/gpio/gateworks,pld-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/intel,ixp4xx-gpi=
o.txt
 create mode 100644 drivers/gpio/gpio-amd-fch.c
 create mode 100644 drivers/gpio/gpio-gw-pld.c
 create mode 100644 drivers/gpio/gpio-tqmx86.c
 create mode 100644 drivers/platform/x86/pcengines-apuv2.c
 create mode 100644 include/linux/platform_data/gpio/gpio-amd-fch.h
