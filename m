Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8089C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 18:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85033214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 18:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="hoFYnGwW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfKJSZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 13:25:19 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35524 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbfKJSZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 13:25:18 -0500
Received: by mail-lf1-f68.google.com with SMTP id y6so8128003lfj.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 10:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=l2BnyD6N7ZcbJ6rXM8fCOY30NMfgyP+0HNQN729Mi1M=;
        b=hoFYnGwWiIlUN79CfL1458Egx86yn2011W1GbOz5KrvnM+68zPmerizl6c27zU79q9
         7n0GedelUIbzBdRggt+hAxMWuT1tVEMv++FfCsIB0czxM6TS/zSFXUyti11NHc7proty
         uQugtzsHn1TlhwejQPZSmCvLu0tD9MXwI75/XorbCseKy8Exzo6vT/aII06OnG9vGZad
         PHxdG7FfuUzozixoup5LSmM8P4GK5s3K4owAlPINjwSEkpQIMEenbqKGxbIPzu9O+W6H
         sPIyVbQcVTQ0yYd5N2sOT86jUZBk9p3+tzpEfNQr2bk2kbbz9mDlGmKqfpgZHUU1MNJy
         KdqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=l2BnyD6N7ZcbJ6rXM8fCOY30NMfgyP+0HNQN729Mi1M=;
        b=J7ZUyyetctnSqGfry8ox0rt+XrUmBuZwY7OB3blDRrITVLfjGdzE6cFkRluCTTUhRJ
         v1fXyWr6VIJXBvCQIO3zaczzmMFXyLoRmgIYL4P8plZkegEiiIgyU9wU3234i/xtDmVh
         Bv45v3Ipm6X+rzSck8OS26mcs/y5horoOT35iiLq2K4VEIJ3ueyMDak/Z6tiP58CbwVR
         TKx1RVkjdSAu/XeZ94tc7R0rFzfRAba6oCM8VWABtXFhehVG37JF+F98FTAzZXxUBInb
         zyyO658hF2RSnKSkrJE2ASR4YIEArkB0mt+XKQ6/5LHFWo1wd1cEjHdtf81yCleqo3Ks
         grGw==
X-Gm-Message-State: APjAAAUVuYH/HqTOXSIj0INY/gPT6vdHS5iotwfO9t7UAh3XutjAvSWl
        ug0PkQfWJROKtu/mPGzt75Smm/1Lszs=
X-Google-Smtp-Source: APXvYqwhFDigIoPYPsuWKDxPKZk3mKzC2RO5M2X+XFqlY4s6hgEwbqTFAyQMm45l/PT3t2RvOUgUzw==
X-Received: by 2002:a19:ca13:: with SMTP id a19mr12852250lfg.133.1573410316179;
        Sun, 10 Nov 2019 10:25:16 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id k19sm6879114ljg.18.2019.11.10.10.25.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Nov 2019 10:25:14 -0800 (PST)
Date:   Sun, 10 Nov 2019 10:25:06 -0800
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     olof@lixom.net, arm@kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20191110182506.a2o7r5nyoqaz27gc@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 86ec2e1739aa1d6565888b4b2059fa47354e1a89:

  ARM: dts: stm32: relax qspi pins slew-rate for stm32mp157 (2019-10-25 08:18:23 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes

for you to fetch changes up to 002d3c65ee81a604430da61e20de7a5b32a0afd5:

  MAINTAINERS: update Cavium ThunderX2 maintainers (2019-11-06 07:43:19 -0800)

----------------------------------------------------------------
ARM: SoC fixes

A set of fixes that have trickled in over the last couple of weeks:

 - MAINTAINER update for Cavium/Marvell ThunderX2

 - stm32 tweaks to pinmux for Joystick/Camera, and RAM allocation for CAN
   interfaces

 - i.MX fixes for voltage regulator GPIO mappings, fixes voltage scaling
   issues

 - More i.MX fixes for various issues on i.MX eval boards: interrupt
   storm due to u-boot leaving pins in new states, fixing power button
   config, a couple of compatible-string corrections.

 - Powerdown and Suspend/Resume fixes for Allwinner A83-based tablets

 - A few documentation tweaks and a fix of a memory leak in the reset
   subsystem

----------------------------------------------------------------
Adam Ford (1):
      ARM: dts: imx6-logicpd: Re-enable SNVS power key

Amelie Delaunay (2):
      ARM: dts: stm32: remove OV5640 pinctrl definition on stm32mp157c-ev1
      ARM: dts: stm32: change joystick pinctrl definition on stm32mp157c-ev1

Ben Dooks (1):
      soc: imx: gpc: fix initialiser format

Christophe Roullier (1):
      ARM: dts: stm32: Fix CAN RAM mapping on stm32mp157c

Fabio Estevam (1):
      ARM: dts: imx6qdl-sabreauto: Fix storm of accelerometer interrupts

Jayachandran C (1):
      MAINTAINERS: update Cavium ThunderX2 maintainers

Kishon Vijay Abraham I (1):
      reset: Fix memory leak in reset_control_array_put()

Lucas Stach (1):
      arm64: dts: zii-ultra: fix ARM regulator GPIO handle

Olof Johansson (5):
      Merge tag 'reset-fixes-for-v5.5' of git://git.pengutronix.de/git/pza/linux into arm/fixes
      Merge tag 'imx-fixes-5.4-2' of git://git.kernel.org/.../shawnguo/linux into arm/fixes
      Merge tag 'sunxi-fixes-for-5.4-2' of https://git.kernel.org/.../sunxi/linux into arm/fixes
      Merge tag 'imx-fixes-5.4-3' of git://git.kernel.org/.../shawnguo/linux into arm/fixes
      Merge tag 'stm32-dt-for-v5.4-fixes-2' of git://git.kernel.org/.../atorgue/stm32 into arm/fixes

Ondrej Jirman (2):
      ARM: dts: sun8i-a83t-tbs-a711: Fix WiFi resume from suspend
      ARM: sunxi: Fix CPU powerdown on A83T

Patrice Chotard (1):
      ARM: dts: stm32: relax qspi pins slew-rate for stm32mp157

Philipp Zabel (4):
      reset: fix of_reset_simple_xlate kerneldoc comment
      reset: fix of_reset_control_get_count kerneldoc comment
      reset: fix reset_control_lookup kerneldoc comment
      reset: fix reset_control_get_exclusive kerneldoc comment

Randy Dunlap (1):
      reset: fix reset_control_ops kerneldoc comment

Shengjiu Wang (2):
      arm64: dts: imx8mm: fix compatible string for sdma
      arm64: dts: imx8mn: fix compatible string for sdma

Yuantian Tang (1):
      arm64: dts: ls1028a: fix a compatible issue

 .mailmap                                            |  4 ++++
 MAINTAINERS                                         |  1 -
 arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi       |  4 ++++
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi            |  8 ++++++++
 arch/arm/boot/dts/stm32mp157c-ev1.dts               | 13 ++-----------
 arch/arm/boot/dts/stm32mp157c.dtsi                  |  4 ++--
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts           |  1 +
 arch/arm/mach-sunxi/mc_smp.c                        |  6 +++++-
 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts   |  2 +-
 arch/arm64/boot/dts/freescale/imx8mm.dtsi           |  6 +++---
 arch/arm64/boot/dts/freescale/imx8mn.dtsi           |  6 +++---
 arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi |  2 +-
 drivers/reset/core.c                                |  5 +++--
 drivers/soc/imx/gpc.c                               |  8 ++++----
 include/linux/reset-controller.h                    |  4 ++--
 include/linux/reset.h                               |  2 +-
 16 files changed, 44 insertions(+), 32 deletions(-)
