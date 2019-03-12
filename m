Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62D4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA9C2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfCLPdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:33:33 -0400
Received: from hermes.aosc.io ([199.195.250.187]:40104 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbfCLPc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:32:59 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 0876A15FCBA;
        Tue, 12 Mar 2019 15:23:40 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 00/14] Support for Allwinner V3/S3L and Sochip S3
Date:   Tue, 12 Mar 2019 23:22:42 +0800
Message-Id: <20190312152256.35574-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset tries to add support for Allwinner V3/S3L and Sochip S3.

Allwinner V3/V3s/S3L and Sochip S3 share the same die, but with
different package. V3 is BGA w/o co-packaged DDR, V3s is QFP w/ DDR2,
S3L is BGA w/ DDR2 and S3 is BGA w/ DDR3. (S3 and S3L is compatible
for pinout, but because of different DDR, DDR voltage is different
between the two variants). Because of the pin count of V3s is
restricted due to the package, some pins are not bound on V3s, but
they're bound on V3/S3/S3L.

Currently the kernel is only prepared for the features available on V3s.
This patchset adds the features missing on V3s for using them on
V3/S3/S3L, and add bindings for V3/S3/S3L. It also adds a S3L device,
the Pine64 Single Cube Computer. The S3/S3L SoM by Sipeed (formerly
Lichee Pi), called Lichee Nano Plus, is ongoing.

Icenowy Zheng (14):
  dt-bindings: pinctrl: add missing compatible string for V3s
  pinctrl: sunxi: rename V3s driver to V3 driver
  dt-bindings: pinctrl: add compatible string for Allwinner V3 pinctrl
  pinctrl: sunxi: v3: really introduce support for V3
  clk: sunxi-ng: v3s: add the missing PLL_DDR1
  dt-bindings: clock: sunxi-ccu: remove bogus + before R40 compatible
  dt-bindings: clk: sunxi-ccu: add compatible string for V3 CCU
  clk: sunxi-ng: v3s: add Allwinner V3 support
  dt-bindings: vendor-prefixes: add SoChip
  dt-bindings: arm: sunxi: add compatible string for V3/S3/S3L SoCs
  ARM: sunxi: dts: s3/s3l/v3: add DTSI files for S3/S3L/V3 SoCs
  ARM: dts: sun8i: V3/V3s/S3/S3L: add pinctrl for UART2 RX/TX
  ARM: dts: sun8i: V3/V3s/S3/S3L: add Ethernet support
  ARM: dts: sun8i: s3l: add support for Pine64 Single Cube Computer

 .../devicetree/bindings/arm/sunxi.txt         |   3 +
 .../devicetree/bindings/clock/sunxi-ccu.txt   |   3 +-
 .../pinctrl/allwinner,sunxi-pinctrl.txt       |   2 +
 .../devicetree/bindings/vendor-prefixes.txt   |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/sun8i-s3.dtsi               |   6 +
 .../dts/sun8i-s3l-single-cube-computer.dts    | 166 ++++++++++
 arch/arm/boot/dts/sun8i-s3l.dtsi              |   6 +
 arch/arm/boot/dts/sun8i-v3.dtsi               |  27 ++
 arch/arm/boot/dts/sun8i-v3s.dtsi              |  59 ++++
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c          | 244 ++++++++++++++-
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.h          |   6 +-
 drivers/pinctrl/sunxi/Kconfig                 |   2 +-
 drivers/pinctrl/sunxi/Makefile                |   2 +-
 ...pinctrl-sun8i-v3s.c => pinctrl-sun8i-v3.c} | 291 ++++++++++++++++--
 drivers/pinctrl/sunxi/pinctrl-sunxi.h         |   2 +
 include/dt-bindings/clock/sun8i-v3s-ccu.h     |   4 +
 include/dt-bindings/reset/sun8i-v3s-ccu.h     |   3 +
 18 files changed, 799 insertions(+), 29 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun8i-s3.dtsi
 create mode 100644 arch/arm/boot/dts/sun8i-s3l-single-cube-computer.dts
 create mode 100644 arch/arm/boot/dts/sun8i-s3l.dtsi
 create mode 100644 arch/arm/boot/dts/sun8i-v3.dtsi
 rename drivers/pinctrl/sunxi/{pinctrl-sun8i-v3s.c => pinctrl-sun8i-v3.c} (51%)

-- 
2.18.1

