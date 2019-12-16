Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B129DC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 21:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B91920CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 21:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="XutwovNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfLPVxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 16:53:33 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46580 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfLPVxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 16:53:33 -0500
Received: by mail-lf1-f66.google.com with SMTP id f15so5384834lfl.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 13:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=UWnCdbVcICZmAK6eBq6qDsPZuchsCvO3LUVcqk3TXso=;
        b=XutwovNch624bzEmqS/scigRStmz63GXtqrGzMwVK0NC1oCv4UB0VCUM5PxxOzydWp
         KgxCwFsVHLq/KihZHLgr6f+D1KzJaw9KQWNiBii6VpvI+fy8aXiFpklcgeC2NtC4s7yd
         OUw90QVpp/GnOgfYUCKg0GgETLbPjzExFyNmFfB4CGfEDLBhPlg7mtjkUw9OuLtTcuJ2
         s7a8c/Pdb00Ozg8N+I1F420VBWmPgKgOPCnADGbzpiAHfFmW7dyyiXb8klzg4NJLO2xt
         rkBy2G+UwtTrqeAmX4v9c5nJS961nWawUq9rlVeQ9nOBRegwT2oDZR/Cpb1YQs2vllTj
         rKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=UWnCdbVcICZmAK6eBq6qDsPZuchsCvO3LUVcqk3TXso=;
        b=cLOzmYEdqnCGs+kWvUsc8gtq8vtEDZ+hUDWvDLLfb8baGsCo0BFJ9NxnANZeZdZZY+
         rZpgTNHpiTXCiE7yzOP5b04MN1nPAzi1YYYP6O0mYBbg1L8CHyk8M7t9Ol65Ygwiyr9g
         +ex0bhcozlwZ/dpVPEKWVgV4GxtWEbdVMxmudFocPUV1MiIgg4ObL07hGYu0zV01BJ+6
         iSrfDteKQCSKSzD9tib1xWbkP/95vDYQ8L+0Z7T3JxfBrpZ7TKAEBBG28USGTc/0MhKx
         35R6UV2AVg5aNxdoE4RflohpORhBtbpz0AFqjNoBCoHDPUfnABmxcB+UzBb/h0QXHja7
         +FTw==
X-Gm-Message-State: APjAAAWPmSl9pKJrxAKbjd91P4oO6aDxDt72Q6tuB5gMFSpEJRlsixDV
        WdAQx0mpdH2m9T8xXhb50q2Wt3LvtSloyA==
X-Google-Smtp-Source: APXvYqwbMx6tW5Wgn+Bdc3Hbpz9H0mRNZrI2wF2Gs8s8y4VPXUihxRs58UFX6f463QrP6ZujcZi8lQ==
X-Received: by 2002:ac2:489b:: with SMTP id x27mr799195lfc.130.1576533210378;
        Mon, 16 Dec 2019 13:53:30 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id n5sm11314858ljh.86.2019.12.16.13.53.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Dec 2019 13:53:28 -0800 (PST)
Date:   Mon, 16 Dec 2019 13:53:20 -0800
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     olof@lixom.net, arm@kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20191216215320.li7x45fhkrkolvbk@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes

for you to fetch changes up to e3992af1256a4fe0b83ac790d4caa58ff731609d:

  Merge tag 'arm-soc/for-5.5/soc-fixes' of https://github.com/Broadcom/stblinux into arm/fixes (2019-12-16 11:33:29 -0800)

----------------------------------------------------------------
ARM: SoC fixes

I didn't get a batch in this weekend, so here's what we queued up last
week and today.

 - A couple of defconfigs add back debugfs -- it used to be implicitly
 enabled through CONFIG_TRACING, but 0e4a459f56c32d3e ("tracing: Remove
 unnecessary DEBUG_FS dependency") removed that.

 - The rest are mostly minor fixlets of the usual kind; some DT tweaks,
 a headerfile refactor that needs a build fix now, etc.

----------------------------------------------------------------
Andreas Kemnade (1):
      ARM: dts: e60k02: fix power button

Arnd Bergmann (1):
      ARM: mmp: include the correct cputype.h

Christoph Niedermaier (1):
      ARM: imx: Correct ocotp id for serial number support of i.MX6ULL/ULZ SoCs

Florian Fainelli (4):
      ARM: dts: BCM5301X: Fix MDIO node address/size cells
      ARM: dts: Cygnus: Fix MDIO node address/size cells
      dt-bindings: reset: Fix brcmstb-reset example
      reset: brcmstb: Remove resource checks

Geert Uytterhoeven (3):
      reset: Fix {of,devm}_reset_control_array_get kerneldoc return types
      reset: Do not register resource data for missing resets
      ARM: shmobile: defconfig: Restore debugfs support

Grygorii Strashko (1):
      ARM: omap2plus_defconfig: enable NET_SWITCHDEV

H. Nikolaus Schaller (1):
      ARM: bcm: Add missing sentinel to bcm2711_compat[]

Krzysztof Kozlowski (1):
      MAINTAINERS: Include Samsung SoC serial driver in Samsung SoC entry

Leonard Crestez (3):
      ARM: dts: imx6ul-evk: Fix peripheral regulator
      ARM: imx_v6_v7_defconfig: Explicitly restore CONFIG_DEBUG_FS
      ARM: imx: Fix boot crash if ocotp is not found

Lukasz Luba (1):
      MAINTAINERS: Update Lukasz Luba's email address

Mans Rullgard (1):
      ARM: dts: am335x-sancloud-bbe: fix phy mode

Marek Szyprowski (1):
      ARM: exynos_defconfig: Restore debugfs support

Michael Walle (2):
      arm64: dts: ls1028a: fix typo in TMU calibration data
      arm64: dts: ls1028a: fix reboot node

Nicolas Saenz Julienne (1):
      ARM: dts: bcm2711: fix soc's node dma-ranges

Olof Johansson (8):
      Merge tag 'vexpress-fixes-5.5' of git://git.kernel.org/.../sudeep.holla/linux into arm/fixes
      Merge tag 'arm-soc/for-5.5/devicetree-fixes' of https://github.com/Broadcom/stblinux into arm/fixes
      Merge tag 'reset-fixes-for-v5.5-2' of git://git.pengutronix.de/git/pza/linux into arm/fixes
      Merge tag 'imx-fixes-5.5' of git://git.kernel.org/.../shawnguo/linux into arm/fixes
      Merge tag 'omap-for-v5.5/fixes-rc1-signed' of git://git.kernel.org/.../tmlind/linux-omap into arm/fixes
      Merge tag 'renesas-fixes-for-v5.5-tag1' of git://git.kernel.org/.../geert/renesas-devel into arm/fixes
      Merge tag 'samsung-fixes-5.5' of https://git.kernel.org/.../krzk/linux into arm/fixes
      Merge tag 'arm-soc/for-5.5/soc-fixes' of https://github.com/Broadcom/stblinux into arm/fixes

Stefan Roese (1):
      ARM: dts: imx6ul: imx6ul-14x14-evk.dtsi: Fix SPI NOR probing

Stefan Wahren (1):
      ARM: dts: bcm283x: Fix critical trip point

Sudeep Holla (2):
      ARM: vexpress: Set-up shared OPP table instead of individual for each CPU
      cpufreq: vexpress-spc: Switch cpumask from topology core to OPP sharing

Tomi Valkeinen (1):
      ARM: dts: am437x-gp/epos-evm: fix panel compatible

Tony Lindgren (3):
      bus: ti-sysc: Fix missing force mstandby quirk handling
      ARM: omap2plus_defconfig: Add back DEBUG_FS
      bus: ti-sysc: Fix missing reset delay handling

 .mailmap                                           |  1 +
 .../bindings/reset/brcm,brcmstb-reset.txt          |  2 +-
 MAINTAINERS                                        |  3 ++-
 arch/arm/boot/dts/am335x-sancloud-bbe.dts          |  2 +-
 arch/arm/boot/dts/am437x-gp-evm.dts                |  2 +-
 arch/arm/boot/dts/am43x-epos-evm.dts               |  2 +-
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |  4 ++--
 arch/arm/boot/dts/bcm2711.dtsi                     |  2 +-
 arch/arm/boot/dts/bcm283x.dtsi                     |  2 +-
 arch/arm/boot/dts/bcm5301x.dtsi                    |  4 ++--
 arch/arm/boot/dts/e60k02.dtsi                      |  5 ----
 arch/arm/boot/dts/imx6ul-14x14-evk.dtsi            | 28 ++++++++++++++++------
 arch/arm/configs/exynos_defconfig                  |  1 +
 arch/arm/configs/imx_v6_v7_defconfig               |  1 +
 arch/arm/configs/omap2plus_defconfig               |  4 +++-
 arch/arm/configs/shmobile_defconfig                |  1 +
 arch/arm/mach-bcm/bcm2711.c                        |  1 +
 arch/arm/mach-imx/cpu.c                            |  8 ++++---
 arch/arm/mach-mmp/pxa168.h                         |  2 +-
 arch/arm/mach-vexpress/spc.c                       | 12 +++++++++-
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi     | 10 ++++++--
 drivers/bus/ti-sysc.c                              |  7 +++++-
 drivers/cpufreq/vexpress-spc-cpufreq.c             |  2 +-
 drivers/reset/core.c                               | 10 ++++----
 drivers/reset/reset-brcmstb.c                      |  6 -----
 include/linux/platform_data/ti-sysc.h              |  1 +
 26 files changed, 78 insertions(+), 45 deletions(-)

