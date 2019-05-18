Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBC3C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 22:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB2CC20833
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 22:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="nRbRAwMx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbfERWvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 18:51:44 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:40787 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbfERWvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 18:51:44 -0400
Received: by mail-lf1-f54.google.com with SMTP id h13so7716117lfc.7
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2019 15:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=DH514z9aZ3H7U/0FSBgVq0iZjpE2oj7hKUPNpKf5WjU=;
        b=nRbRAwMxBefuFWhOvmci98mAdcK24vs88zQbxNSmm7KH4cGQ0KjtQSmzEVST07Ha/A
         4rUHk5UJU5otFOm3PNnilBBd1yxg9I9RN4v8m67MINg1n3QGRv5qAnFQz/RKygBg03lp
         4YpNnFYnKIl2FQT++NoVOTKvWntyNnRwLrl4J9dzdQhTtGVxRgHQZEuMOPnMRNINw4Bp
         iWqj5SBHi9tZY6DDYxrnxAxk500P6RGab34kTaEpCu19Z4hRIFbzQOPUoxRu+ALMmIS/
         j9pR9lVeyico6j60UmZtKy/2sdA8LT5/MESOGquxts/9stDw/iyXvliDI4N16v6LZPTh
         adKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=DH514z9aZ3H7U/0FSBgVq0iZjpE2oj7hKUPNpKf5WjU=;
        b=IKJnm5PTPycId9K+jUhrleidBjI29Pn5FUQ8EP9O8xyCwisjloq2Q/NE2rpmwHLjIx
         IBa0ML9QqSmbIBDkjW2cGgwefmdBGWWyKf479yxLgywfoRgM57QmX07e+iU+DJBOzWbE
         gGLEEqeIr8LMQHu5G8VAHzwCvKembKfgIT5itqMr146GWmQ9xWLfVBeJhPkhBzjC4bjc
         OpmmyUfNTJIbz1ymeLiuZgaSA+rRnqQ6lMY9e5sdF3v5VgACma1hthxHIMAYFTsG0DMQ
         jhC3BUpyz9sO0hJRehhIPunrfw/O+m8HZ4OqhBKLdvF41mtSy0yLVJ2O/LdvLCRmyBcM
         vZuw==
X-Gm-Message-State: APjAAAVMLSeZSkJcY+l+cKvHwVFbdbnPGJrLyqwqXTN6IDlhWLRDFg8/
        bePg4SqpISnrMxaXEBe0mDSBTA==
X-Google-Smtp-Source: APXvYqxsy9iGSMpHIWTCK/33V0sHiXZsWnqKRLy1zUlbBTPMUktT19NsVaj6ODE1GaCOocyWIqdTNA==
X-Received: by 2002:ac2:528f:: with SMTP id q15mr13949958lfm.37.1558219901524;
        Sat, 18 May 2019 15:51:41 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id v11sm2863221lfb.68.2019.05.18.15.51.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 May 2019 15:51:39 -0700 (PDT)
Date:   Sat, 18 May 2019 15:51:31 -0700
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     olof@lixom.net, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: SoC late updates
Message-ID: <20190518225131.2lyysevggfbyqfl6@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit ab02888e39212af2d1dddc565cd67192548b9fd8:

  Merge tag 'armsoc-defconfig' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc (2019-05-16 09:35:26 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-late

for you to fetch changes up to 15d574fbd3f8ec7705896ed14b74eae482cadd4e:

  arm64: dts: sprd: Add clock properties for serial devices (2019-05-16 14:43:33 -0700)

----------------------------------------------------------------
ARM: SoC: late updates

This is some material that we picked up into our tree late. Most of it
are smaller fixes and additions, some defconfig updates due to recent
development, etc.

Code-wise the largest portion is a series of PM updates for the at91
platform, and those have been in linux-next a while through the at91
tree before we picked them up.

----------------------------------------------------------------
Aaro Koskinen (1):
      ARM: OMAP1: ams-delta: fix early boot crash when LED support is disabled

Adam Ford (1):
      ARM: dts: logicpd-som-lv: Fix MMC1 card detect

Alan Tull (1):
      ARM: socfpga_defconfig: enable LTC2497

Andrey Zhizhikin (1):
      ARM: socfpga_defconfig: enable support for large block devices

Arnd Bergmann (1):
      amba: tegra-ahb: Mark PM functions as __maybe_unused

Baolin Wang (1):
      arm64: dts: sprd: Add clock properties for serial devices

Chris Packham (1):
      ARM: mvebu: kirkwood: remove error message when retrieving mac address

Claudiu Beznea (8):
      ARM: at91: pm: introduce at91_soc_pm structure
      dt-bindings: arm: atmel: add binding for SAM9X60 SoC
      ARM: at91: pm: initial PM support for SAM9X60
      ARM: at91: pm: keep at91_pm_backup_init() only for SAMA5D2 SoCs
      ARM: at91: pm: add support for per SoC wakeup source configuration
      ARM: at91: pm: add ULP1 support for SAM9X60
      ARM: at91: pm: disable RC oscillator in ULP0
      ARM: at91: pm: do not disable/enable PLLA for ULP modes

Dan Carpenter (2):
      soc/fsl/qe: Fix an error code in qe_pin_request()
      soc: ixp4xx: qmgr: Fix an NULL vs IS_ERR() check in probe

Jonathan Hunter (1):
      arm64: tegra: Fix insecure SMMU users for Tegra186

Marc Gonzalez (1):
      Opt out of scripts/get_maintainer.pl

Nicholas Mc Guire (1):
      ARM: mvebu: drop return from void function

Nicolas Ferre (1):
      ARM: at91: remove HAVE_FB_ATMEL for sama5 SoC as they use DRM

Olof Johansson (9):
      Merge tag 'omap-for-v5.1/fixes-rc6' of git://git.kernel.org/.../tmlind/linux-omap into arm/late
      Merge tag 'mvebu-arm-5.2-1' of git://git.infradead.org/linux-mvebu into arm/late
      Merge tag 'soc-fsl-fix-v5.1' of git://git.kernel.org/.../leo/linux into arm/late
      Merge tag 'socfpga_arm32_defconfig_for_v5.2' of git://git.kernel.org/.../dinguyen/linux into arm/late
      Merge tag 'tegra-for-5.2-bus-fixes' of git://git.kernel.org/.../tegra/linux into arm/late
      Merge tag 'tegra-for-5.2-arm64-soc-fixes' of git://git.kernel.org/.../tegra/linux into arm/late
      Merge tag 'tegra-for-5.2-arm64-dt-fixes' of git://git.kernel.org/.../tegra/linux into arm/late
      Merge tag 'at91-5.2-defconfig' of git://git.kernel.org/.../at91/linux into arm/late
      Merge tag 'at91-5.2-soc' of git://git.kernel.org/.../at91/linux into arm/late

Sameer Pujar (1):
      arm64: tegra: Select ARM_GIC_PM

Stefan Agner (2):
      ARM: mvebu: drop unnecessary label
      ARM: mvebu: prefix coprocessor operand with p

Thierry Reding (2):
      arm64: tegra: Enable SMMU translation for PCI on Tegra186
      arm64: tegra: Disable XUSB support on Jetson TX2

Tudor Ambarus (1):
      ARM: at91: sama5: make ov2640 as a module

Wen Yang (1):
      ARM: mvebu: fix a leaked reference by adding missing of_node_put

YueHaibing (1):
      ARM: ixp4xx: Remove duplicated include from common.c

 .get_maintainer.ignore                             |   1 +
 .../devicetree/bindings/arm/atmel-at91.txt         |   1 +
 arch/arm/boot/dts/logicpd-som-lv-baseboard.dtsi    |   2 +-
 arch/arm/configs/sama5_defconfig                   |   2 +-
 arch/arm/configs/socfpga_defconfig                 |   3 +-
 arch/arm/mach-at91/Kconfig                         |   3 -
 arch/arm/mach-at91/at91sam9.c                      |  18 ++
 arch/arm/mach-at91/generic.h                       |   2 +
 arch/arm/mach-at91/pm.c                            | 193 ++++++++++++++-------
 arch/arm/mach-at91/pm_suspend.S                    | 111 ++++++++----
 arch/arm/mach-ixp4xx/common.c                      |   1 -
 arch/arm/mach-mvebu/board-v7.c                     |   1 -
 arch/arm/mach-mvebu/coherency_ll.S                 |   2 +-
 arch/arm/mach-mvebu/kirkwood.c                     |   2 -
 arch/arm/mach-mvebu/pm-board.c                     |  11 +-
 arch/arm/mach-mvebu/pmsu_ll.S                      |   3 +-
 arch/arm/mach-omap1/board-ams-delta.c              |   2 +-
 arch/arm64/Kconfig.platforms                       |   1 +
 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts |   4 +-
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |   7 +
 arch/arm64/boot/dts/sprd/whale2.dtsi               |  16 +-
 drivers/amba/tegra-ahb.c                           |   6 +-
 drivers/soc/fsl/qe/gpio.c                          |   4 +-
 drivers/soc/ixp4xx/ixp4xx-qmgr.c                   |   4 +-
 include/linux/clk/at91_pmc.h                       |   1 +
 25 files changed, 277 insertions(+), 124 deletions(-)
