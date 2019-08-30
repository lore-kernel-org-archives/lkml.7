Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC92C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F98323430
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbfH3Q0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 12:26:10 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36397 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbfH3Q0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:26:10 -0400
Received: by mail-qt1-f195.google.com with SMTP id z4so8231305qtc.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 09:26:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=qHgWu5Rl4zvcECH09Viw3cWfbmbYnQJRz+dq3rEzn6k=;
        b=bldkA9j/JDkmhvQfKq/VdxoARhkv5ee1wc2LET1T/mjJChNb5YBhanpWBHlgIT10kf
         RxAjCaFgE2+0pV0c0gvvvaVd0qyx0rCktoJR74AfL0YOUoUSaIeW6yqIHxGLNacdGLAf
         35KipioZ51/Krc2rZmFHKC6HbMetrvKPABWZFA8hk6J3rjNbzMevuUcl4kJk325rffrQ
         gyag2bYng3PeWpYizJwZmL+JXavMk/xHeqP0ath4yUiT1FvU6Q6ee4fi7NxigclHoINz
         L88qrcBFSBe5f4LsWFvsHH92XtFkmeQTfDJK4KCsc6b56d3QT94mxzbY2m7qUA/0GHWe
         xmaA==
X-Gm-Message-State: APjAAAXdihOdvo52PlxpXuvCH6Djh6SeoWRp78f67GTuPMkgJqwVJML1
        Q2igAIodI7bXOaN5fNUFYJpEPPi2iUQskaBBSsI=
X-Google-Smtp-Source: APXvYqyWqzDMv6Hcrz05N4SE3mDmSNuAw0OYHoxkdQOiyRxXs5JB18HnTRXZ/9ZMa7+OEnE/pUAH561xbkH5EkpIf+I=
X-Received: by 2002:ac8:117:: with SMTP id e23mr16102582qtg.18.1567182368579;
 Fri, 30 Aug 2019 09:26:08 -0700 (PDT)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 30 Aug 2019 18:25:52 +0200
Message-ID: <CAK8P3a2OZPybUQ=2xXcF4Qft-Gpe3a1mvgPncJZugETnaOxsvw@mail.gmail.com>
Subject: [GIT PULL] ARM: SoC fixes for Linux-5.3
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        SoC Team <soc@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        John Garry <john.garry@huawei.com>,
        Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d45331b00ddb179e291766617259261c112db872:

  Linux 5.3-rc4 (2019-08-11 13:26:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git armsoc-fixes

for you to fetch changes up to 7a6c9dbb36a415c5901313fc89871fd19f533656:

  soc: ixp4xx: Protect IXP4xx SoC drivers by ARCH_IXP4XX ||
COMPILE_TEST (2019-08-29 17:34:38 +0200)

----------------------------------------------------------------
ARM: SoC fixes

The majority of the fixes this time are for OMAP hardware,
here is a breakdown of the significant changes:

Various device tree bug fixes:
- TI am57xx boards need a voltage level fix to avoid damaging SD cards
- vf610-bk4 fails to detect its flash due to an incorrect description
- meson-g12a USB phy configuration fails
- meson-g12b reboot should not power off the SD card
- Some corrections for apparently harmless differences from the
  documentation.

Regression fixes:
- ams-delta FIQ interrupts broke in 5.3
- TI am3/am4 mmc controllers broke in 5.2

The logic_pio driver (used on some Huawei ARM servers) needs a few
bug fixes for reliability.

A couple of compile-time warning fixes

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Arnd Bergmann (5):
      Merge tag 'imx-fixes-5.3-2' of
git://git.kernel.org/.../shawnguo/linux into arm/fixes
      Merge tag 'omap-for-v5.3/fixes-rc4' of
git://git.kernel.org/.../tmlind/linux-omap into arm/fixes
      Merge tag 'amlogic-fixes' of
git://git.kernel.org/.../khilman/linux-amlogic into arm/fixes
      Merge tag 'hisi-fixes-for-5.3' of
git://github.com/hisilicon/linux-hisi into arm/fixes
      Merge tag 'sunxi-fixes-for-5.3-3' of
git://git.kernel.org/.../sunxi/linux into arm/fixes

Emmanuel Vadot (1):
      ARM: dts: am335x: Fix UARTs length

Faiz Abbas (2):
      ARM: dts: am57xx: Disable voltage switching for SD card
      ARM: dts: dra74x: Fix iodelay configuration for mmc3

Geert Uytterhoeven (1):
      soc: ixp4xx: Protect IXP4xx SoC drivers by ARCH_IXP4XX || COMPILE_TEST

Gustavo A. R. Silva (1):
      ARM: OMAP: dma: Mark expected switch fall-throughs

Janusz Krzysztofik (1):
      ARM: OMAP1: ams-delta-fiq: Fix missing irq_ack

John Garry (5):
      lib: logic_pio: Fix RCU usage
      lib: logic_pio: Avoid possible overlap for unregistering regions
      lib: logic_pio: Add logic_pio_unregister_range()
      bus: hisi_lpc: Unregister logical PIO range to avoid potential
use-after-free
      bus: hisi_lpc: Add .remove method to avoid driver unbind crash

Keerthy (1):
      soc: ti: pm33xx: Fix static checker warnings

Lukasz Majewski (1):
      ARM: dts: vf610-bk4: Fix qspi node description

Maxime Ripard (1):
      MAINTAINERS: Update my email address

Neil Armstrong (2):
      arm64: dts: meson-g12a: add missing dwc2 phy-names
      arm64: dts: meson-g12a-sei510: enable IR controller

Suman Anna (1):
      bus: ti-sysc: Simplify cleanup upon failures in sysc_probe()

Tony Lindgren (10):
      Merge commit '79499bb11db508' into fixes
      ARM: OMAP2+: Fix missing SYSC_HAS_RESET_STATUS for dra7 epwmss
      bus: ti-sysc: Fix handling of forced idle
      bus: ti-sysc: Fix using configured sysc mask value
      ARM: dts: Fix flags for gpio7
      ARM: dts: Fix incorrect dcan register mapping for am3, am4 and dra7
      ARM: OMAP2+: Fix omap4 errata warning on other SoCs
      Merge branch 'ti-sysc-fixes' into fixes
      ARM: dts: Fix incomplete dts data for am3 and am4 mmc
      Merge branch 'ti-sysc-fixes' into fixes

Xavier Ruppen (1):
      arm64: dts: amlogic: odroid-n2: keep SD card regulator always on

YueHaibing (1):
      soc: ti: pm33xx: Make two symbols static

 .mailmap                                             |  2 ++
 MAINTAINERS                                          | 10 +++++-----
 arch/arm/boot/dts/am33xx-l4.dtsi                     | 16 ++++++++++------
 arch/arm/boot/dts/am33xx.dtsi                        | 32
++++++++++++++++++++++++++------
 arch/arm/boot/dts/am4372.dtsi                        | 32
++++++++++++++++++++++++++------
 arch/arm/boot/dts/am437x-l4.dtsi                     |  4 ++++
 arch/arm/boot/dts/am571x-idk.dts                     |  7 +------
 arch/arm/boot/dts/am572x-idk.dts                     |  7 +------
 arch/arm/boot/dts/am574x-idk.dts                     |  7 +------
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi      |  3 ++-
 arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts        |  7 +------
 arch/arm/boot/dts/am57xx-beagle-x15-revc.dts         |  7 +------
 arch/arm/boot/dts/dra7-evm.dts                       |  2 +-
 arch/arm/boot/dts/dra7-l4.dtsi                       |  6 +++---
 arch/arm/boot/dts/dra74x-mmc-iodelay.dtsi            | 50
++++++++++++++++++++++++-------------------------
 arch/arm/boot/dts/vf610-bk4.dts                      |  4 ++--
 arch/arm/mach-omap1/ams-delta-fiq-handler.S          |  3 ++-
 arch/arm/mach-omap1/ams-delta-fiq.c                  |  4 +---
 arch/arm/mach-omap2/omap4-common.c                   |  3 +++
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c            |  3 ++-
 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts    |  6 ++++++
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi          |  1 +
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts |  1 +
 drivers/bus/hisi_lpc.c                               | 47
++++++++++++++++++++++++++++++++++++++++------
 drivers/bus/ti-sysc.c                                | 24
+++++++++++-------------
 drivers/soc/ixp4xx/Kconfig                           |  4 ++++
 drivers/soc/ti/pm33xx.c                              | 19 ++++++++++++-------
 include/linux/logic_pio.h                            |  1 +
 lib/logic_pio.c                                      | 73
+++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------
 29 files changed, 250 insertions(+), 135 deletions(-)
