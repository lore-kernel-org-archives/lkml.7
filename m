Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE8BC10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 22:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962B120880
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 22:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="DW38fZg5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfDGWui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 18:50:38 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40467 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfDGWuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 18:50:37 -0400
Received: by mail-lj1-f195.google.com with SMTP id q66so9515395ljq.7
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 15:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=gmSY+YrvTQ0t67bBFiioqzdSdjOk5S5clWfEge8OBo4=;
        b=DW38fZg5dG8RLboGOXIdgd0tDB14/pVrlZnlpJPMt1yQWZP8PLlCWvbcVZYE1jiHdv
         rR1768SYiG14TGnFIvnPJ/ldTq3wPczKMwCXcnt8SQ5oexDfKnP+Yj2GQU0MFanZ9QDq
         78ZFtNdAsNIS7QSA+gjrByArDsvvIhj1R6t29mhIq7ZxCg+MJkzmbAOdZ5wbQxWLaLJq
         8x8VgLaV4Z/Z8yQRNAolbq4HfOL8V8GmRdOeBafvSB9D8PaznZuNwHgQHOMe9epYmGHr
         927veA5VobsjZyIwWAWO5eI7EneY9tfHBVkRIN55kjn/ykOTfdErZbnsXrTZ0+7vBg9q
         5qrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=gmSY+YrvTQ0t67bBFiioqzdSdjOk5S5clWfEge8OBo4=;
        b=OLlNqPYGOqXTI7cKVSXTJab8Dt4X2vnxvxQUlzarAnp2JYRw2xAJ9QaCIG18jZf49/
         vUBAfqeI8VXVKWUkzry85Fni86ig7L1eaEAu491ba+e/v9H4/de0qhitJGYeI0vMZ2xH
         O6Wbgeld8rZu93FP2LPR9dPZoQ001IGy8Ppg3U4sXAdMIK3WKm3A8Rpu4uVjJpQMzFNt
         g6R2mgvy6/FKDOl7Ccb7uPep6NtSTYFVQFbWr8QC/CMZqAIVp6LFfBGbiWsXO4/m72GC
         NaKKjB7Gt+BDAKUGf9JNa1a8+F5PbnfFIrNZiYENw46MwiWZdiofQHPLPyX3dazmTFaQ
         tnLg==
X-Gm-Message-State: APjAAAUCdBcYrjliCQtowDIWspBf2TIFgWepMj11tUPnXA5MYV3G4pUE
        rXCeXtycjI9KFL1YHedQubBCBA==
X-Google-Smtp-Source: APXvYqx7BwNO7+kSn2Wy6fMZ0ufLO6huaBi1Y4IdCjJ7oIApc7cBwjbMUjKryXPh4ccKss/1efwyLw==
X-Received: by 2002:a2e:91d2:: with SMTP id u18mr5554000ljg.161.1554677434433;
        Sun, 07 Apr 2019 15:50:34 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id 7sm6587231lju.27.2019.04.07.15.50.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Apr 2019 15:50:32 -0700 (PDT)
Date:   Sun, 7 Apr 2019 15:50:20 -0700
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     olof@lixom.net, arm@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20190407225020.64gf2b57mv47vfuv@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 79a3aaa7b82e3106be97842dedfd8429248896e6:

  Linux 5.1-rc3 (2019-03-31 14:39:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes

for you to fetch changes up to 9a8f32038a74cb800e9649afbf4b3dba2b7d6539:

  ARM: milbeaut: fix build with !CONFIG_HOTPLUG_CPU (2019-04-07 15:29:55 -0700)

----------------------------------------------------------------
ARM: SoC fixes

A collection of fixes from the last few weeks. Most of them are smaller
tweaks and fixes to DT and hardware descriptions for boards. Some of the
more significant ones are:

 - eMMC and RGMII stability tweaks for rk3288
 - DDC fixes for Rock PI 4
 - Audio fixes for two TI am335x eval boards
 - D_CAN clock fix for am335x
 - Compilation fixes for clang
 - !SMP compilation fix for one of the new platforms this release (milbeaut)
 - A revert of a gpio fix for nomadik that instead was fixed in the gpio
   subsystem
 - Whitespace fix for the DT JSON schema (no tabs allowed)

----------------------------------------------------------------
Arnd Bergmann (3):
      ARM: orion: don't use using 64-bit DMA masks
      ARM: iop: don't use using 64-bit DMA masks
      ARM: milbeaut: fix build with !CONFIG_HOTPLUG_CPU

Axel Lin (1):
      reset: meson-audio-arb: Fix missing .owner setting of reset_controller_dev

David Engraf (1):
      ARM: dts: at91: Fix typo in ISC_D0 on PC9

David Summers (1):
      ARM: dts: rockchip: Fix SD card detection on rk3288-tinker

Dinh Nguyen (1):
      arm64: dts: stratix10: add the sysmgr-syscon property from the gmac's

Douglas Anderson (3):
      ARM: dts: rockchip: Fix gpu opp node names for rk3288
      ARM: dts: rockchip: Remove #address/#size-cells from rk3288 mipi_dsi
      ARM: dts: rockchip: Remove #address/#size-cells from rk3288-veyron gpio-keys

Ezequiel Garcia (1):
      arm64: dts: rockchip: add DDC bus on Rock Pi 4

Janusz Krzysztofik (1):
      ARM: OMAP1: ams-delta: Fix broken GPIO ID allocation

Jonas Karlman (1):
      ARM: dts: rockchip: fix rk3288 cpu opp node reference

Julia Lawall (1):
      ARM: OMAP2+: add missing of_node_put after of_device_is_available

Leonidas P. Papadakos (1):
      arm64: dts: rockchip: fix rk3328-roc-cc gmac2io tx/rx_delay

Maxime Ripard (1):
      dt-bindings: cpu: Fix JSON schema

Neil Armstrong (1):
      dt-bindings: reset: meson-g12a: Add missing USB2 PHY resets

Olof Johansson (6):
      Merge tag 'reset-fixes-for-v5.1' of git://git.pengutronix.de/pza/linux into arm/fixes
      Merge tag 'stratix10_fix_for_v5.1' of git://git.kernel.org/.../dinguyen/linux into arm/fixes
      Merge tag 'v5.1-rockchip-dtfixes-1' of git://git.kernel.org/.../mmind/linux-rockchip into arm/fixes
      Merge tag 'at91-5.1-fixes' of git://git.kernel.org/.../at91/linux into arm/fixes
      Merge tag 'omap-for-v5.1/fixes-signed' of git://git.kernel.org/.../tmlind/linux-omap into arm/fixes
      Revert "ARM: dts: nomadik: Fix polarity of SPI CS"

Peng Hao (1):
      arm/mach-at91/pm : fix possible object reference leak

Peter Geis (2):
      arm64: dts: rockchip: fix rk3328 rgmii high tx error rate
      arm64: dts: rockchip: fix rk3328 sdmmc0 write errors

Peter Ujfalusi (2):
      ARM: dts: am335x-evm: Correct the regulators for the audio codec
      ARM: dts: am335x-evmsk: Correct the regulators for the audio codec

Tomohiro Mayama (1):
      arm64: dts: rockchip: Fix vcc_host1_5v GPIO polarity on rk3328-rock64

Tony Lindgren (2):
      ARM: dts: Fix dcan clkctrl clock for am3
      Merge commit '7d56bedb2730dc2ea8abf0fd7240ee99ecfee3c9' into omap-for-v5.1/fixes

 Documentation/devicetree/bindings/arm/cpus.yaml    |  2 +-
 arch/arm/boot/dts/am335x-evm.dts                   | 26 ++++++++--
 arch/arm/boot/dts/am335x-evmsk.dts                 | 26 ++++++++--
 arch/arm/boot/dts/am33xx-l4.dtsi                   |  4 +-
 arch/arm/boot/dts/rk3288-tinker.dtsi               |  3 +-
 arch/arm/boot/dts/rk3288-veyron.dtsi               |  2 -
 arch/arm/boot/dts/rk3288.dtsi                      | 20 ++++----
 arch/arm/boot/dts/sama5d2-pinfunc.h                |  2 +-
 arch/arm/boot/dts/ste-nomadik-nhk15.dts            |  9 ++--
 arch/arm/mach-at91/pm.c                            |  6 ++-
 arch/arm/mach-iop13xx/setup.c                      |  8 +--
 arch/arm/mach-iop13xx/tpmi.c                       | 10 ++--
 arch/arm/mach-milbeaut/platsmp.c                   |  4 ++
 arch/arm/mach-omap1/board-ams-delta.c              |  2 +
 arch/arm/mach-omap2/display.c                      |  4 +-
 arch/arm/plat-iop/adma.c                           |  6 +--
 arch/arm/plat-orion/common.c                       |  4 +-
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |  3 ++
 arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts     |  4 +-
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts     |  3 +-
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           | 58 +++++++++++-----------
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts  |  1 +
 drivers/reset/reset-meson-audio-arb.c              |  1 +
 .../dt-bindings/reset/amlogic,meson-g12a-reset.h   |  5 +-
 24 files changed, 131 insertions(+), 82 deletions(-)
