Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E263AC433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 06:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2ED7206DD
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 06:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="LRv9UEEL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbfG1Ghb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 02:37:31 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40375 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfG1Ghb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 02:37:31 -0400
Received: by mail-lj1-f195.google.com with SMTP id m8so21761868lji.7
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 23:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=OWNZdvgNeBUzqh6l8mT/rTzlkWMLEndaO2EreTceoeo=;
        b=LRv9UEELTRDoEDDMIdoeWcYC3gcFXxheGuuiwdzKajyNA5YQUE0OlWBKiTJffFiVm3
         2OqWeIRNBeFhHOhoZ/sTieRD3Gg5o56m07WBzA6CxUFbl3Rdp79wnJRd701J1W9ZJmim
         2L5DSAuKgJxW1G6AL3e73s4BUH5QVrw90XEUsmXmIlItArs9FhHi4tSzD/TfSHwCYpZ/
         2e2sp3Tfleqeb8n4PAbjLo19dnwrMqMU7DBD2dIayi0uk6itoYYPllbMis63CfynQ3Pj
         nZHcJtj0FAvAiF3Il8a42+Pfxpp0STNs2aCwQvBRavAonhDj4BFcYvOaf5MjFEt3+T6U
         F0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=OWNZdvgNeBUzqh6l8mT/rTzlkWMLEndaO2EreTceoeo=;
        b=lusLUlUy8ccI2Du50HVB7liK09oAzMOp369VHPTYmCQBKBPBLiBJzLrQe5d5A2MGwr
         ut0uNA/z3HdTsBBTX1cPwu8+uzR9VjWegy/Xm2e5h6FovGDsQiHvqXjoG/V+IKGU8qCN
         lSAPpUnLhdLKUBTnLr212EhoIPLjnRCyl4PF7rpEIVsW0yBo2f8Bpc4Jo/Zr6AaLqDfZ
         Dx0EotCJh7e3rSKh+w1LcHGTDUkiEKsI1WWjSgXIWS0nZTyBCIwEnqdyRKy7wflaxN7z
         QR2DgstAomZI9mbpd5kVqd4IEmzfUzwhmVpqxeO70i5TgUIpV9hjRDJmIh8qnNzeXL3i
         WziA==
X-Gm-Message-State: APjAAAUp8p3y3+2kFMGWI8jQBil/wsTLr9Z/bVlF9AbYjPoQnG99/qik
        jt+eE5Hq6DP2zfmZhHIcB3mNksie
X-Google-Smtp-Source: APXvYqx4YI5j8nhEZopfxQ4RRPdbijzjV7ogMnyraki3+1lA1fLzb6F8HcZAbh5MakE6DVw3B9GwaQ==
X-Received: by 2002:a2e:9dca:: with SMTP id x10mr53291624ljj.17.1564295848080;
        Sat, 27 Jul 2019 23:37:28 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id w6sm9793025lff.80.2019.07.27.23.37.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Jul 2019 23:37:26 -0700 (PDT)
Date:   Sat, 27 Jul 2019 23:37:15 -0700
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     olof@lixom.net, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, soc@kernel.org,
        arm@kernel.org
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20190728063715.ensdmo7jyimrsez4@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes

for you to fetch changes up to 7bd9d465140a93c0a21ba2d2f426451c78bfcc7d:

  Merge tag 'imx-fixes-5.3' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into arm/fixes (2019-07-23 10:13:24 -0700)

----------------------------------------------------------------
ARM: SoC fixes

Here's the first batch of fixes for this release cycle.

Main diffstat here is the re-deletion of netx. I messed up and most
likely didn't remove the files from the index when I test-merged this
and saw conflicts, and from there on out 'git rerere' remembered the
mistake and I missed checking it. Here it's done again as expected.

Besides that:

 - A defconfig refresh + enabling of new drivers for u8500

 - i.MX fixlets for i2c/SAI/pinmux

 - sleep.S build fix for Davinci

 - Broadcom devicetree build/warning fix

----------------------------------------------------------------
Anson Huang (1):
      arm64: dts: imx8mm: Correct SAI3 RXC/TXFS pin's mux option #1

Arnd Bergmann (2):
      ARM: davinci: fix sleep.S build error on ARMv4
      ARM: dts: bcm: bcm47094: add missing #cells for mdio-bus-mux

Fabio Estevam (1):
      ARM: dts: imx7ulp: Fix usb-phy unit address format

Linus Walleij (3):
      ARM: Delete netx a second time
      ARM: defconfig: u8500: Refresh defconfig
      ARM: defconfig: u8500: Add new drivers

Lucas Stach (1):
      arm64: dts: imx8mq: fix SAI compatible

Olof Johansson (1):
      Merge tag 'imx-fixes-5.3' of git://git.kernel.org/.../shawnguo/linux into arm/fixes

Sébastien Szymanski (1):
      ARM: dts: imx6ul: fix clock frequency property name of I2C buses

 arch/arm/Kconfig.debug                          |   5 -
 arch/arm/boot/dts/bcm47094-linksys-panamera.dts |   3 +
 arch/arm/boot/dts/imx6ul-14x14-evk.dtsi         |   2 +-
 arch/arm/boot/dts/imx6ul-geam.dts               |   2 +-
 arch/arm/boot/dts/imx6ul-isiot.dtsi             |   2 +-
 arch/arm/boot/dts/imx6ul-pico-hobbit.dts        |   2 +-
 arch/arm/boot/dts/imx6ul-pico-pi.dts            |   4 +-
 arch/arm/boot/dts/imx7ulp.dtsi                  |   2 +-
 arch/arm/configs/u8500_defconfig                |  34 +-
 arch/arm/mach-davinci/sleep.S                   |   1 +
 arch/arm/mach-netx/Kconfig                      |  22 --
 arch/arm/mach-netx/Makefile                     |  13 -
 arch/arm/mach-netx/Makefile.boot                |   3 -
 arch/arm/mach-netx/fb.c                         |  65 ----
 arch/arm/mach-netx/fb.h                         |  12 -
 arch/arm/mach-netx/generic.c                    | 182 ----------
 arch/arm/mach-netx/generic.h                    |  14 -
 arch/arm/mach-netx/include/mach/hardware.h      |  27 --
 arch/arm/mach-netx/include/mach/irqs.h          |  58 ----
 arch/arm/mach-netx/include/mach/netx-regs.h     | 420 ------------------------
 arch/arm/mach-netx/include/mach/pfifo.h         |  42 ---
 arch/arm/mach-netx/include/mach/uncompress.h    |  63 ----
 arch/arm/mach-netx/include/mach/xc.h            |  30 --
 arch/arm/mach-netx/nxdb500.c                    | 197 -----------
 arch/arm/mach-netx/nxdkn.c                      |  90 -----
 arch/arm/mach-netx/nxeb500hmi.c                 | 174 ----------
 arch/arm/mach-netx/pfifo.c                      |  56 ----
 arch/arm/mach-netx/time.c                       | 141 --------
 arch/arm/mach-netx/xc.c                         | 246 --------------
 arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h  |   4 +-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi       |   3 +-
 31 files changed, 33 insertions(+), 1886 deletions(-)
 delete mode 100644 arch/arm/mach-netx/Kconfig
 delete mode 100644 arch/arm/mach-netx/Makefile
 delete mode 100644 arch/arm/mach-netx/Makefile.boot
 delete mode 100644 arch/arm/mach-netx/fb.c
 delete mode 100644 arch/arm/mach-netx/fb.h
 delete mode 100644 arch/arm/mach-netx/generic.c
 delete mode 100644 arch/arm/mach-netx/generic.h
 delete mode 100644 arch/arm/mach-netx/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-netx/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-netx/include/mach/netx-regs.h
 delete mode 100644 arch/arm/mach-netx/include/mach/pfifo.h
 delete mode 100644 arch/arm/mach-netx/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-netx/include/mach/xc.h
 delete mode 100644 arch/arm/mach-netx/nxdb500.c
 delete mode 100644 arch/arm/mach-netx/nxdkn.c
 delete mode 100644 arch/arm/mach-netx/nxeb500hmi.c
 delete mode 100644 arch/arm/mach-netx/pfifo.c
 delete mode 100644 arch/arm/mach-netx/time.c
 delete mode 100644 arch/arm/mach-netx/xc.c
