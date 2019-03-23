Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F49C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 21:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D252133F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 21:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xbSTH+a4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfCWVQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 17:16:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40262 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbfCWVQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 17:16:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id t5so5963800wri.7
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 14:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4McGYYq2ZUptZXqYtAHX//HxnWqV5/YakhobL5pTDps=;
        b=xbSTH+a45Zi6x1BUqwnibZCTkAFasMmJZQ8izwesJPZnHuZIHhGu3u8L01TmM1rHif
         IEC78tWAov0bgc6JsgIYZ+dJ/n95+5BmkcA4N7dEW8PtXcJjtkCVqXgzV5DxTZ0TiBmM
         5rTvHFrAK15HJ5fC9Jy0O/Zkbwp16Z4+fXEnFAutAue2+6brOUeBvFTiBn03QHH9kvBj
         sZepdN0pD/hlLr7UC8BdXTg5r6PjUjF/Sf51Lf4wPpT0kvAtlOz73r11Y1br45+OomQD
         SILOFMRo7kWJKUp8FgfgvaUga+0Vd1sg7Hgo7CcXCh3RqqzYzolyk8QA/cnLxQX03UI1
         aeKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4McGYYq2ZUptZXqYtAHX//HxnWqV5/YakhobL5pTDps=;
        b=a4sEcCZCxfmaMFfm3SLGJo+J97ONpiP9ulEMExkbLQ2I2Z2SgJE0krtsjIiTF6xl6x
         dksnndqKUzJooqo0ffUnmeA33e+knYEmQAcHsBPSGGbxdAQjx3Ow7nZwD1Ed5ct3gPZ/
         t/A7yIhzJCHytcsGWvgpEJydhs8V0paGwrw841emIW3fZYALXim/0/q3TRXmfOZVM2Ei
         qpUmp0VnVkKQLFh64OKMTwhv5izrKpm/V/8/vpMi+ZV6AaCw7TCjjY6+6kWfNOZk5Z2u
         +5AZyjLkEgDLbjuipc7r+9WSAhKrXCHHvV5/TjvKLbW2yKdlcP8WOhloS7gBC539o5F1
         n8yQ==
X-Gm-Message-State: APjAAAVOIP78Gfacg9YHaIo2uIQIOeMMgfbKTM2Q72hktJ5iy5OMurEA
        kyfw3yPGSRqc7dU/MQko2vaeH8T3quDrvCKs
X-Google-Smtp-Source: APXvYqwWXn0fyODwrAZ6niPpQMs28EUAEIINdt1c/GXwI+ZaBvDHjV/+22ncaxIqZXuI8lOKAmFnvQ==
X-Received: by 2002:a5d:6883:: with SMTP id h3mr10528279wru.215.1553375796536;
        Sat, 23 Mar 2019 14:16:36 -0700 (PDT)
Received: from localhost.localdomain (cag06-8-78-203-165-84.fbx.proxad.net. [78.203.165.84])
        by smtp.gmail.com with ESMTPSA id y66sm8050503wmd.37.2019.03.23.14.16.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 14:16:35 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     matthias.bgg@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     sean.wang@kernel.org, ryder.lee@mediatek.com,
        hsin-hsiung.wang@mediatek.com, wenzhen.yu@mediatek.com,
        chaotian.jing@mediatek.com, yong.mao@mediatek.com,
        jjian.zhou@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-clk@vger.kernel.org, stephane.leprovost@mediatek.com,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 00/24] arm64: mediatek: add support for Pumpkin MT8516 board
Date:   Sat, 23 Mar 2019 22:15:48 +0100
Message-Id: <20190323211612.860-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pumpkin board is designed by Gossamer Engineering and is
using a MediaTek SoC. The board currently comes in two available
version: MT8516 SoC and MT8167 SoC.

The board provides the following IOs: eMMC, NAND, SD card, USB 2 type-A,
Ethernet, Wi-Fi, Bluetooth, Audio (jack out, 2 PDM port, 1 analog in),
serial over USB, and an expansion header.

This patch series adds the basic board support to be able to boot
on the eMMC of the MT8516 based Pumpkin board.

The board is using a MT6392 PMIC.

Fabien Parent (24):
  dt-bindings: regulator: add support for MT6392
  regulator: mt6392: Add support for MT6392 regulator
  dt-bindings: pwrap: mediatek: add pwrap support for MT8516
  soc: mediatek: pwrap: add missing check on rstc
  soc: mediatek: pwrap: add support for MT8516 pwrap
  mfd: mt6397: Add support for MT6397 pmic
  arm64: dts: mt6392: Add PMIC mt6392 dtsi
  dt-bindings: mmc: mtk-sd: add mtk-sd support for MT8516
  mmc: mtk-sd: check for valid optional memory resource
  mmc: mtk-sd: add support for MT8516
  dt-bindings: mediatek: topckgen: add support for MT8516
  dt-bindings: mediatek: infracfg: add support for MT8516
  dt-bindings: mediatek: apmixedsys: add support for MT8516
  clk: mediatek: add clock driver for MT8516
  dt-bindings: pinctrl: pinctrl-mt65xx: add support for MT8516
  pinctrl: mediatek: Add MT8516 Pinctrl driver
  dt-bindings: wdog: mtk-wdt: add support for MT851
  dt-bindings: timer: mtk-timer: add support for MT8516
  dt-bindings: spi: spi-mt65xx: add support for MT8516
  dt-bindings: serial: mtk-uart: add support for MT8516
  dt-bindings: irq: mtk,sysirq: add support for MT8516
  dt-bindings: i2c: i2c-mtk: add support for MT8516
  arm64: dts: mediatek: add dtsi for MT8516
  arm64: dts: mediatek: add pumpkin board dts

 .../arm/mediatek/mediatek,apmixedsys.txt      |    1 +
 .../arm/mediatek/mediatek,infracfg.txt        |    1 +
 .../arm/mediatek/mediatek,topckgen.txt        |    1 +
 .../devicetree/bindings/i2c/i2c-mtk.txt       |    1 +
 .../interrupt-controller/mediatek,sysirq.txt  |    3 +-
 .../devicetree/bindings/mmc/mtk-sd.txt        |    1 +
 .../bindings/pinctrl/pinctrl-mt65xx.txt       |    1 +
 .../bindings/regulator/mt6392-regulator.txt   |  220 +++
 .../devicetree/bindings/serial/mtk-uart.txt   |    1 +
 .../bindings/soc/mediatek/pwrap.txt           |    1 +
 .../devicetree/bindings/spi/spi-mt65xx.txt    |    1 +
 .../bindings/timer/mediatek,mtk-timer.txt     |    1 +
 .../devicetree/bindings/watchdog/mtk-wdt.txt  |    1 +
 arch/arm64/boot/dts/mediatek/Makefile         |    1 +
 arch/arm64/boot/dts/mediatek/mt6392.dtsi      |  208 +++
 arch/arm64/boot/dts/mediatek/mt8516-pinfunc.h |  663 +++++++++
 .../boot/dts/mediatek/mt8516-pumpkin.dts      |   19 +
 arch/arm64/boot/dts/mediatek/mt8516.dtsi      |  409 ++++++
 .../boot/dts/mediatek/pumpkin-common.dtsi     |  210 +++
 .../dts/mediatek/pumpkin-emmc-common.dtsi     |   75 ++
 drivers/clk/mediatek/Kconfig                  |    9 +
 drivers/clk/mediatek/Makefile                 |    1 +
 drivers/clk/mediatek/clk-mt8516.c             |  815 ++++++++++++
 drivers/mfd/mt6397-core.c                     |   96 ++
 drivers/mmc/host/mtk-sd.c                     |   19 +-
 drivers/pinctrl/mediatek/Kconfig              |    7 +
 drivers/pinctrl/mediatek/Makefile             |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt8516.c     |  384 ++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-mt8516.h | 1182 +++++++++++++++++
 drivers/regulator/Kconfig                     |    9 +
 drivers/regulator/Makefile                    |    1 +
 drivers/regulator/mt6392-regulator.c          |  490 +++++++
 drivers/soc/mediatek/mtk-pmic-wrap.c          |  109 +-
 include/dt-bindings/clock/mt8516-clk.h        |  211 +++
 include/linux/mfd/mt6392/core.h               |   42 +
 include/linux/mfd/mt6392/registers.h          |  487 +++++++
 include/linux/regulator/mt6392-regulator.h    |   40 +
 37 files changed, 5717 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/mt6392-regulator.txt
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6392.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8516-pinfunc.h
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8516-pumpkin.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8516.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/pumpkin-emmc-common.dtsi
 create mode 100644 drivers/clk/mediatek/clk-mt8516.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt8516.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt8516.h
 create mode 100644 drivers/regulator/mt6392-regulator.c
 create mode 100644 include/dt-bindings/clock/mt8516-clk.h
 create mode 100644 include/linux/mfd/mt6392/core.h
 create mode 100644 include/linux/mfd/mt6392/registers.h
 create mode 100644 include/linux/regulator/mt6392-regulator.h

-- 
2.20.1

