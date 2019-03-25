Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E54CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 473972085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731248AbfCYMmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:42:00 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:61399 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731096AbfCYMl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 08:41:56 -0400
X-UUID: 13c0bfc77b9c4ad081e7542d806cccf5-20190325
X-UUID: 13c0bfc77b9c4ad081e7542d806cccf5-20190325
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <zhiyong.tao@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 912487030; Mon, 25 Mar 2019 20:41:49 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 25 Mar 2019 20:41:40 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 25 Mar 2019 20:41:39 +0800
From:   Zhiyong Tao <zhiyong.tao@mediatek.com>
To:     <robh+dt@kernel.org>, <linus.walleij@linaro.org>,
        <mark.rutland@arm.com>, <matthias.bgg@gmail.com>,
        <sean.wang@kernel.org>
CC:     <srv_heupstream@mediatek.com>, <zhiyong.tao@mediatek.com>,
        <hui.liu@mediatek.com>, <eddie.huang@mediatek.com>,
        <chuanjia.liu@mediatek.com>, <biao.huang@mediatek.com>,
        <hongzhou.yang@mediatek.com>, <erin.lo@mediatek.com>,
        <sean.wang@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-gpio@vger.kernel.org>
Subject: [PATCH v3 RESEND 0/4] PINCTRL: Mediatek pinctrl patch on mt8183 
Date:   Mon, 25 Mar 2019 20:41:33 +0800
Message-ID: <20190325124137.6117-1-zhiyong.tao@mediatek.com>
X-Mailer: git-send-email 2.12.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 315498D66F836E635214DB8D139430440DF7A464694D865B66E2D9BD454BCD972000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes 4 patches:
1.add pintcrl binding document on mt8183.
2.add pintcrl file on mt8183.
3.add pintcrl device node on mt8183.
4.add drive for I2C related pins on MT8183.

Changes in patch v3:
1)add the patch "dt-bindings: pinctrl: mt8183: add binding document".
2)add the patch "arm64: dts: mt8183: add pintcrl file".
3)add the patch "arm64: dts: mt8183: add pintcrl device node".
4)add more datail information for the specific driving setup in commit message.
5)use "mediatek,drive-strength-adv" instead of
  "mediatek,drive-enable-adv" and "mediatek,drive-enable-disable".
6)change "PINCTRL_PIN_REG_DRV_EN_DIS" to "PINCTRL_PIN_REG_DRV_EN".
7)change the function "mtk_pinconf_adv_drive_set".

Changes in patch v2:
1)add the details strength specification of the I2c pins.
2)change "mt8183_pin_drv_en_dis_range" to "mt8183_pin_e1e0en_range".
3)change "mt8183_pin_drv_e0_range" to "mt8183_pin_e0_range".
4)change "mt8183_pin_drv_e1_range" to "mt8183_pin_e1_range".

Zhiyong Tao (4):
  dt-bindings: pinctrl: mt8183: add binding document
  arm64: dts: mt8183: add pintcrl file
  arm64: dts: mt8183: add pintcrl device node
  pinctrl: add drive for I2C related pins on MT8183

 .../devicetree/bindings/pinctrl/pinctrl-mt8183.txt |  132 +++
 arch/arm64/boot/dts/mediatek/mt8183-pinfunc.h      | 1120 ++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi           |   27 +-
 drivers/pinctrl/mediatek/pinctrl-mt8183.c          |   50 +
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c   |   47 +
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h   |   11 +
 drivers/pinctrl/mediatek/pinctrl-paris.c           |   12 +
 7 files changed, 1398 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-pinfunc.h

--
2.12.5
