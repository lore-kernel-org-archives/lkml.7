Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C303ACA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 02:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 997FD20B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 02:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbfJ1Csd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 22:48:33 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:8347 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726934AbfJ1Csc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 22:48:32 -0400
X-UUID: e1cfa5f3336c4e5eaa45b5fe7802b51b-20191028
X-UUID: e1cfa5f3336c4e5eaa45b5fe7802b51b-20191028
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 981587691; Mon, 28 Oct 2019 10:48:27 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 28 Oct 2019 10:48:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 28 Oct 2019 10:48:25 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>
Subject: [PATCH v8 00/14] Mediatek MT8183 scpsys support  
Date:   Mon, 28 Oct 2019 10:48:04 +0800
Message-ID: <1572230898-7860-1-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is based on v5.4-rc1

changes since v7:
- reword in binding document [PATCH 02/14]
- fix error return checking bug in subsys clock control [PATCH 10/14]
- add power domains properity to mfgcfg patch [PATCH 14/14] from
  https://patchwork.kernel.org/patch/11126199/

changes since v6:
- remove the patch of SPDX license identifier because it's already fixed

changes since v5:
- fix documentation in [PATCH 04/14]
- remove useless variable checking and reuse API of clock control in [PATCH 06/14]
- coding style fix of bus protection control in [PATCH 08/14]
- fix naming of new added data in [PATCH 09/14]
- small refactor of multiple step bus protection control in [PATCH 10/14]

changes since v4:
- add property to mt8183 smi-common
- seperate refactor patches and new add function
- add power controller device node

Weiyi Lu (14):
  dt-bindings: mediatek: Add property to mt8183 smi-common
  dt-bindings: soc: Add MT8183 power dt-bindings
  soc: mediatek: Refactor polling timeout and documentation
  soc: mediatek: Refactor regulator control
  soc: mediatek: Refactor clock control
  soc: mediatek: Refactor sram control
  soc: mediatek: Refactor bus protection control
  soc: mediatek: Add basic_clk_id to scp_power_data
  soc: mediatek: Add multiple step bus protection control
  soc: mediatek: Add subsys clock control for bus protection
  soc: mediatek: Add extra sram control
  soc: mediatek: Add MT8183 scpsys support
  arm64: dts: Add power controller device node of MT8183
  arm64: dts: Add power-domains properity to mfgcfg

 .../memory-controllers/mediatek,smi-common.txt     |   2 +-
 .../devicetree/bindings/soc/mediatek/scpsys.txt    |  20 +-
 arch/arm64/boot/dts/mediatek/mt8183.dtsi           |  63 +++
 drivers/soc/mediatek/Makefile                      |   2 +-
 drivers/soc/mediatek/mtk-scpsys-ext.c              |  99 ++++
 drivers/soc/mediatek/mtk-scpsys.c                  | 575 ++++++++++++++++++---
 include/dt-bindings/power/mt8183-power.h           |  26 +
 include/linux/soc/mediatek/scpsys-ext.h            |  39 ++
 8 files changed, 745 insertions(+), 81 deletions(-)
 create mode 100644 drivers/soc/mediatek/mtk-scpsys-ext.c
 create mode 100644 include/dt-bindings/power/mt8183-power.h
 create mode 100644 include/linux/soc/mediatek/scpsys-ext.h

