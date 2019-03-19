Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FE9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AC7320857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfCSICI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 04:02:08 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39390 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726916AbfCSICF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 04:02:05 -0400
X-UUID: 46f47f5a0d0f4ff6aea39ba7703f718a-20190319
X-UUID: 46f47f5a0d0f4ff6aea39ba7703f718a-20190319
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1211746939; Tue, 19 Mar 2019 16:01:56 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 19 Mar 2019 16:01:56 +0800
Received: from mtkslt210.mediatek.inc (10.21.14.14) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 19 Mar 2019 16:01:56 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v5 00/14] Mediatek MT8183 scpsys support 
Date:   Tue, 19 Mar 2019 16:01:26 +0800
Message-ID: <20190319080140.24055-1-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resend scpsys patches from v4[1].
Based on v5.1-rc1 with MT8183 dts v9 patch[2] and
MT8183 SMI dt-binding v6 patch[3].

[1] https://patchwork.kernel.org/patch/10792071/
[2] https://patchwork.kernel.org/patch/10856987/
[3] https://patchwork.kernel.org/patch/10816827/

changes since v4:
- add property to mt8183 smi-common
- seperate refactor patches and new add function
- add power controller device node

Weiyi Lu (14):
  dt-bindings: mediatek: Add property to mt8183 smi-common
  dt-bindings: soc: Add MT8183 power dt-bindings
  soc: mediatek: Switch to SPDX license identifier
  soc: mediatek: Refactor polling timeout and documentation
  soc: mediatek: Refactor regulator control
  soc: mediatek: Refactor clock control
  soc: mediatek: Refactor sram control
  soc: mediatek: Refactor bus protection control
  soc: mediatek: Add basic_clk_name to scp_power_data
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
 drivers/soc/mediatek/mtk-scpsys.c             | 603 +++++++++++++++---
 include/dt-bindings/power/mt8183-power.h      |  26 +
 include/linux/soc/mediatek/scpsys-ext.h       |  39 ++
 8 files changed, 757 insertions(+), 90 deletions(-)
 create mode 100644 drivers/soc/mediatek/mtk-scpsys-ext.c
 create mode 100644 include/dt-bindings/power/mt8183-power.h
 create mode 100644 include/linux/soc/mediatek/scpsys-ext.h


