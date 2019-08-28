Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7879AC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 09:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5768A20856
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 09:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfH1JME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 05:12:04 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:52746 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726246AbfH1JMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 05:12:03 -0400
X-UUID: e42c72d1f271448e818dfddf04097030-20190828
X-UUID: e42c72d1f271448e818dfddf04097030-20190828
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1919572274; Wed, 28 Aug 2019 17:11:58 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 28 Aug 2019 17:12:03 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 28 Aug 2019 17:12:03 +0800
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
Subject: [PATCH v7 00/13] Mediatek MT8183 scpsys support  
Date:   Wed, 28 Aug 2019 17:11:33 +0800
Message-ID: <1566983506-26598-1-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is based on v5.3-rc1 with MT8183 SMI dt-binding patch v11[1].

[1] [v11,01/23] dt-bindings: mediatek: Add binding for mt8183 IOMMU and SMI
    (https://patchwork.kernel.org/patch/11112769/)

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

Weiyi Lu (13):
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

 .../mediatek,smi-common.txt                   |   2 +-
 .../bindings/soc/mediatek/scpsys.txt          |  14 +
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      |  62 ++
 drivers/soc/mediatek/Makefile                 |   2 +-
 drivers/soc/mediatek/mtk-scpsys-ext.c         |  99 +++
 drivers/soc/mediatek/mtk-scpsys.c             | 575 +++++++++++++++---
 include/dt-bindings/power/mt8183-power.h      |  26 +
 include/linux/soc/mediatek/scpsys-ext.h       |  39 ++
 8 files changed, 741 insertions(+), 78 deletions(-)
 create mode 100644 drivers/soc/mediatek/mtk-scpsys-ext.c
 create mode 100644 include/dt-bindings/power/mt8183-power.h
 create mode 100644 include/linux/soc/mediatek/scpsys-ext.h

