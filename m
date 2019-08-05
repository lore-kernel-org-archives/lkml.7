Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1D5C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0895D2067D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbfHEJNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 05:13:10 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:62353 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728069AbfHEJMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 05:12:18 -0400
X-UUID: 8f66d207a15445bba07f1e2efbdbe3ba-20190805
X-UUID: 8f66d207a15445bba07f1e2efbdbe3ba-20190805
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <mars.cheng@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 1169585689; Mon, 05 Aug 2019 17:12:03 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 5 Aug 2019 17:12:05 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 5 Aug 2019 17:12:05 +0800
From:   Mars Cheng <mars.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>,
        Wendell Lin <wendell.lin@mediatek.com>,
        Ivan Tseng <ivan.tseng@mediatek.com>
Subject: [PATCH 00/11] Add basic SoC Support for Mediatek MT6779 SoC
Date:   Mon, 5 Aug 2019 17:11:49 +0800
Message-ID: <1564996320-10897-1-git-send-email-mars.cheng@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 4B7BB4B967302A6224F3882B8C334D65CEAC8A715A37D03142A05D2B0A9A4D852000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is based on v5.3-rc1. Basic SoC support for the new Mediatek
SoC, MT6779, which targets for smartphone.

It provides ccf, pinctrl, uart, timer, gic...etc. We will also upstream
other parts of this SoC very soon.


Mars Cheng (8):
  dt-bindings: mediatek: add support for mt6779 reference board
  dt-bindings: mtk-uart: add mt6779 uart bindings
  dt-bindings: irq: mtk,sysirq: add support for mt6779
  pinctrl: mediatek: update pinmux defintions for mt6779
  pinctrl: mediatek: avoid virtual gpio trying to set reg
  pinctrl: mediatek: add pinctrl support for MT6779 SoC
  pinctrl: mediatek: add mt6779 eint support
  arm64: dts: add dts nodes for MT6779

mtk01761 (3):
  dt-bindings: mediatek: bindings for MT6779 clk
  clk: mediatek: Add dt-bindings for MT6779 clocks
  clk: mediatek: Add MT6779 clock support

 .../devicetree/bindings/arm/mediatek.yaml     |    4 +
 .../arm/mediatek/mediatek,apmixedsys.txt      |    1 +
 .../bindings/arm/mediatek/mediatek,audsys.txt |    1 +
 .../bindings/arm/mediatek/mediatek,camsys.txt |    1 +
 .../bindings/arm/mediatek/mediatek,imgsys.txt |    1 +
 .../arm/mediatek/mediatek,infracfg.txt        |    1 +
 .../bindings/arm/mediatek/mediatek,ipesys.txt |   22 +
 .../bindings/arm/mediatek/mediatek,mfgcfg.txt |    1 +
 .../bindings/arm/mediatek/mediatek,mmsys.txt  |    1 +
 .../arm/mediatek/mediatek,topckgen.txt        |    1 +
 .../arm/mediatek/mediatek,vdecsys.txt         |    1 +
 .../arm/mediatek/mediatek,vencsys.txt         |    1 +
 .../interrupt-controller/mediatek,sysirq.txt  |    1 +
 .../devicetree/bindings/serial/mtk-uart.txt   |    1 +
 arch/arm64/boot/dts/mediatek/Makefile         |    1 +
 arch/arm64/boot/dts/mediatek/mt6779-evb.dtsi  |   99 +
 arch/arm64/boot/dts/mediatek/mt6779.dts       |  229 ++
 drivers/clk/mediatek/Kconfig                  |   56 +
 drivers/clk/mediatek/Makefile                 |    9 +
 drivers/clk/mediatek/clk-mt6779-aud.c         |  125 +
 drivers/clk/mediatek/clk-mt6779-cam.c         |   66 +
 drivers/clk/mediatek/clk-mt6779-img.c         |   58 +
 drivers/clk/mediatek/clk-mt6779-ipe.c         |   60 +
 drivers/clk/mediatek/clk-mt6779-mfg.c         |   55 +
 drivers/clk/mediatek/clk-mt6779-mm.c          |  113 +
 drivers/clk/mediatek/clk-mt6779-vdec.c        |   68 +
 drivers/clk/mediatek/clk-mt6779-venc.c        |   58 +
 drivers/clk/mediatek/clk-mt6779.c             | 1553 ++++++++++++
 drivers/pinctrl/mediatek/Kconfig              |    7 +
 drivers/pinctrl/mediatek/Makefile             |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt6779.c     |  783 +++++++
 .../pinctrl/mediatek/pinctrl-mtk-common-v2.c  |   20 +
 .../pinctrl/mediatek/pinctrl-mtk-common-v2.h  |    1 +
 drivers/pinctrl/mediatek/pinctrl-mtk-mt6779.h | 2085 +++++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-paris.c      |    3 +
 include/dt-bindings/clock/mt6779-clk.h        |  436 ++++
 include/dt-bindings/pinctrl/mt6779-pinfunc.h  | 1242 ++++++++++
 37 files changed, 7166 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,ipesys.txt
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6779-evb.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6779.dts
 create mode 100644 drivers/clk/mediatek/clk-mt6779-aud.c
 create mode 100644 drivers/clk/mediatek/clk-mt6779-cam.c
 create mode 100644 drivers/clk/mediatek/clk-mt6779-img.c
 create mode 100644 drivers/clk/mediatek/clk-mt6779-ipe.c
 create mode 100644 drivers/clk/mediatek/clk-mt6779-mfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt6779-mm.c
 create mode 100644 drivers/clk/mediatek/clk-mt6779-vdec.c
 create mode 100644 drivers/clk/mediatek/clk-mt6779-venc.c
 create mode 100644 drivers/clk/mediatek/clk-mt6779.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt6779.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt6779.h
 create mode 100644 include/dt-bindings/clock/mt6779-clk.h
 create mode 100644 include/dt-bindings/pinctrl/mt6779-pinfunc.h
