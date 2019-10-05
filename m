Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A50DC4740A
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 22:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 177E6222C0
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 22:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="T9n7xSRf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfJEWlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 18:41:20 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43984 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfJEWlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 18:41:20 -0400
Received: by mail-lj1-f193.google.com with SMTP id n14so9924735ljj.10
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 15:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=bDJ3kWr0YfhxU7F7kTZgolzUOHCoYxjKPCVzPLU/enY=;
        b=T9n7xSRfvcMEUdVDArQluHs0IFoHdChw2a4xbDOCJOzZvcbeGZgIx+T71p77IJVg2Z
         Jvad6RUTgT0ML1vXm9LHZX6q+mGdFIAjY35iI9vxJeHDn1F8tRvQDKT2BeaRDowlELHY
         2OgvjvC75fhqHRtZsNLc5IhgIVMJo3p3MUwp/eK6yv81B1/dlUoQpIO0NZVmZua82eCF
         qV9olqO+KN1c02DQFgDEsrVELCS9n9Sd5hF7U7teC5/b0gwFpPsWm+yiQcnIkMvzsulR
         B5LALYnXf47Tz+S/puExygWb/4SsWGQQBEK+qw5Jsp2wYi7uoKgNIPs3EFkuO95KmWKu
         YyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bDJ3kWr0YfhxU7F7kTZgolzUOHCoYxjKPCVzPLU/enY=;
        b=Z2c96RZc2cguZNZsCxWx2QymEaxUrwYUaM0lDxu8kVLu2Jm0mxrhlIInLbu3Jd00+W
         aTGzW6JnKkm0EHYbfO9DOoHyq/Jhg0LR25+ifzbONXIoVTbiqCGdC/B14Z+JU1TdQ1Se
         pWqt4NZsn1g2Aw/IFpE1DxKxQWsY7r9hASSiG2bwoD2zby8mT6AraDNrI4AXoUjBmuRO
         yNy5qQJ8xjyo1Vuay//i4sTLTyuuZkqBlp7xHd/w7aJTP7erF6VE14Y1ZPm8/TODqq0c
         MixK40hpc0hGHFxMsjhyPMHQc6poXrl4Be/eulgKENXL/pny5R5irfXJv/2pBIKAJrsJ
         ZMAg==
X-Gm-Message-State: APjAAAV7C3YBAiTv7udBTDghGaK1t3cdsn0qBsho7/LVw43XzLERFZxa
        D19zr+7dh31kKbKMmDwczEwNuA==
X-Google-Smtp-Source: APXvYqxWxxPS9LA0EVWo9mgl3HLcgkvSNVDDrkJG4ReOnIeoPDnhUd0P8w5XpDAj904AN0SaWtKfEQ==
X-Received: by 2002:a2e:b607:: with SMTP id r7mr13883217ljn.100.1570315276513;
        Sat, 05 Oct 2019 15:41:16 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id g3sm2117902ljj.59.2019.10.05.15.41.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 05 Oct 2019 15:41:14 -0700 (PDT)
Date:   Sat, 5 Oct 2019 15:41:04 -0700
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     olof@lixom.net, soc@kernel.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20191005224104.qptaeg72tt2gzdyl@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes

for you to fetch changes up to 60c1b3e25728e0485f08e72e61c3cad5331925a3:

  ARM: multi_v7_defconfig: Fix SPI_STM32_QSPI support (2019-10-04 10:18:55 -0700)

----------------------------------------------------------------
ARM: SoC fixes

A few fixes this time around:

 - Fixup of some clock specifications for DRA7 (device-tree fix)
 - Removal of some dead/legacy CPU OPP/PM code for OMAP that throws
   warnings at boot
 - A few more minor fixups for OMAPs, most around display
 - Enable STM32 QSPI as =y since their rootfs sometimes comes from
   there
 - Switch CONFIG_REMOTEPROC to =y since it went from tristate to bool
 - Fix of thermal zone definition for ux500 (5.4 regression)

----------------------------------------------------------------
Adam Ford (1):
      ARM: omap2plus_defconfig: Enable DRM_TI_TFP410

H. Nikolaus Schaller (1):
      DTS: ARM: gta04: introduce legacy spi-cs-high to make display work again

Keerthy (1):
      arm64/ARM: configs: Change CONFIG_REMOTEPROC from m to y

Linus Walleij (1):
      ARM: dts: ux500: Fix up the CPU thermal zone

Olof Johansson (1):
      Merge tag 'omap-for-v5.4/fixes-rc1-signed' of git://git.kernel.org/.../tmlind/linux-omap into arm/fixes

Patrice Chotard (1):
      ARM: multi_v7_defconfig: Fix SPI_STM32_QSPI support

Peter Ujfalusi (1):
      ARM: dts: am4372: Set memory bandwidth limit for DISPC

Tony Lindgren (8):
      clk: ti: dra7: Fix mcasp8 clock bits
      ARM: dts: Fix wrong clocks for dra7 mcasp
      Merge branch 'fixes-merge-window-pt2' into fixes
      ARM: omap2plus_defconfig: Enable more droid4 devices as loadable modules
      ARM: dts: Fix gpio0 flags for am335x-icev2
      ARM: OMAP2+: Fix missing reset done flag for am3 and am43
      ARM: OMAP2+: Add missing LCDC midlemode for am335x
      ARM: OMAP2+: Fix warnings with broken omap2_set_init_voltage()

 arch/arm/boot/dts/am335x-icev2.dts                 |   2 +-
 arch/arm/boot/dts/am33xx-l4.dtsi                   |   6 +-
 arch/arm/boot/dts/am4372.dtsi                      |   2 +
 arch/arm/boot/dts/dra7-l4.dtsi                     |  48 +++++-----
 arch/arm/boot/dts/omap3-gta04.dtsi                 |   1 +
 arch/arm/boot/dts/ste-dbx5x0.dtsi                  |  11 ++-
 arch/arm/configs/davinci_all_defconfig             |   2 +-
 arch/arm/configs/multi_v7_defconfig                |   4 +-
 arch/arm/configs/omap2plus_defconfig               |   5 +-
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |   3 +-
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |   5 +-
 arch/arm/mach-omap2/pm.c                           | 100 ---------------------
 arch/arm64/configs/defconfig                       |   2 +-
 drivers/clk/ti/clk-7xx.c                           |   6 +-
 14 files changed, 53 insertions(+), 144 deletions(-)
