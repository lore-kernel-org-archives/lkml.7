Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8521C742B1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9882084B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfGLJod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 05:44:33 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:56731 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726057AbfGLJoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 05:44:32 -0400
X-UUID: ac40bddd1b784772b1ed6f55dee99109-20190712
X-UUID: ac40bddd1b784772b1ed6f55dee99109-20190712
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 201960188; Fri, 12 Jul 2019 17:44:27 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 12 Jul 2019 17:44:19 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 12 Jul 2019 17:44:19 +0800
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        Owen Chen <owen.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <wsd_upstream@mediatek.com>, CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, Macpaul Lin <macpaul.lin@mediatek.com>
Subject: [PATCH v6 0/8] Add basic SoC support for mt6765
Date:   Fri, 12 Jul 2019 17:43:36 +0800
Message-ID: <1562924653-10056-1-git-send-email-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 652D05AEE8BA6B315CF08EEE2E1D8453BBB4EB91AB589F2FB8116AA5BECD01822000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds basic SoC support for Mediatek's new 8-core SoC,
MT6765, which is mainly for smartphone application.

Changes in V6:
1. Adapt V5's patchset to latest kernel tree.
   Origin V5 patchset.
   https://lore.kernel.org/patchwork/cover/963612/
2. Due to clk's common code has been submit by other platform,
   this patch set will have dependencies with the following patchsets
   as the following orders.
   2.a. [v8,00/21] MT8183 IOMMU SUPPORT
        https://patchwork.kernel.org/cover/11023585/
   2.b. [v11,0/6] Add basic node support for Mediatek MT8183 SoC
        https://patchwork.kernel.org/cover/10962385/
   2.c. [v6,00/14] Mediatek MT8183 scpsys support
        https://patchwork.kernel.org/cover/11005751/
3. Correct power related patches into dt-binding patches.
4. Re-order V5's 4/11, 6/11, and 7/11 due clk common code change
   and make dependencies in order.
5. Update some commit message in clk related patches.

Changes in V5:
1. add clk support

Changes in V4:
1. add gic's settings in reg properties
2. remove some patches about dt-bindings since GKH already took them

Changes in V3:
1. split dt-binding document patchs
2. fix mt6765.dtsi warnings with W=12
3. remove uncessary PPI affinity for timer
4. add gicc base for gic dt node

Changes in V2:
1. fix clk properties in uart dts node
2. fix typo in submit title
3. add simple-bus in mt6765.dtsi
4. use correct SPDX license format

Mars Cheng (6):
  dt-bindings: clock: mediatek: document clk bindings for Mediatek
    MT6765 SoC
  dt-bindings: mediatek: Add smi dts binding for Mediatek MT6765 SoC
  dt-bindings: mediatek: add MT6765 power dt-bindings
  clk: mediatek: add mt6765 clock IDs
  soc: mediatek: add MT6765 scpsys and subdomain support
  arm64: dts: mediatek: add mt6765 support

Owen Chen (2):
  clk: mediatek: Add MT6765 clock support
  arm64: defconfig: add CONFIG_COMMON_CLK_MT6765_XXX clocks

 .../arm/mediatek/mediatek,apmixedsys.txt      |   1 +
 .../bindings/arm/mediatek/mediatek,audsys.txt |   1 +
 .../bindings/arm/mediatek/mediatek,camsys.txt |   1 +
 .../bindings/arm/mediatek/mediatek,imgsys.txt |   1 +
 .../arm/mediatek/mediatek,infracfg.txt        |   1 +
 .../bindings/arm/mediatek/mediatek,mipi0a.txt |  28 +
 .../bindings/arm/mediatek/mediatek,mmsys.txt  |   1 +
 .../arm/mediatek/mediatek,pericfg.txt         |   1 +
 .../arm/mediatek/mediatek,topckgen.txt        |   1 +
 .../arm/mediatek/mediatek,vcodecsys.txt       |  27 +
 .../mediatek,smi-common.txt                   |   1 +
 .../bindings/soc/mediatek/scpsys.txt          |   6 +
 arch/arm64/boot/dts/mediatek/Makefile         |   1 +
 arch/arm64/boot/dts/mediatek/mt6765-evb.dts   |  33 +
 arch/arm64/boot/dts/mediatek/mt6765.dtsi      | 253 +++++
 arch/arm64/configs/defconfig                  |   6 +
 drivers/clk/mediatek/Kconfig                  |  86 ++
 drivers/clk/mediatek/Makefile                 |   7 +
 drivers/clk/mediatek/clk-mt6765-audio.c       | 109 ++
 drivers/clk/mediatek/clk-mt6765-cam.c         |  83 ++
 drivers/clk/mediatek/clk-mt6765-img.c         |  79 ++
 drivers/clk/mediatek/clk-mt6765-mipi0a.c      |  77 ++
 drivers/clk/mediatek/clk-mt6765-mm.c          | 105 ++
 drivers/clk/mediatek/clk-mt6765-vcodec.c      |  79 ++
 drivers/clk/mediatek/clk-mt6765.c             | 961 ++++++++++++++++++
 drivers/soc/mediatek/mtk-scpsys.c             | 130 +++
 include/dt-bindings/clock/mt6765-clk.h        | 313 ++++++
 include/dt-bindings/power/mt6765-power.h      |  14 +
 28 files changed, 2406 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mipi0a.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,vcodecsys.txt
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6765-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6765.dtsi
 create mode 100644 drivers/clk/mediatek/clk-mt6765-audio.c
 create mode 100644 drivers/clk/mediatek/clk-mt6765-cam.c
 create mode 100644 drivers/clk/mediatek/clk-mt6765-img.c
 create mode 100644 drivers/clk/mediatek/clk-mt6765-mipi0a.c
 create mode 100644 drivers/clk/mediatek/clk-mt6765-mm.c
 create mode 100644 drivers/clk/mediatek/clk-mt6765-vcodec.c
 create mode 100644 drivers/clk/mediatek/clk-mt6765.c
 create mode 100644 include/dt-bindings/clock/mt6765-clk.h
 create mode 100644 include/dt-bindings/power/mt6765-power.h

-- 
2.18.0

