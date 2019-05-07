Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95881C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 08:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 703F4216B7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 08:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfEGIO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 04:14:29 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:41778 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727150AbfEGIOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 04:14:21 -0400
X-UUID: f765446abbcb407a9f38b6bec9387b48-20190507
X-UUID: f765446abbcb407a9f38b6bec9387b48-20190507
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 726903544; Tue, 07 May 2019 16:14:04 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 7 May 2019 16:13:56 +0800
Received: from mtkslt302.mediatek.inc (10.21.14.115) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 7 May 2019 16:13:57 +0800
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, CK HU <ck.hu@mediatek.com>
CC:     Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        "Sascha Hauer" <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Daoyuan Huang <daoyuan.huang@mediatek.com>,
        Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <ginny.chen@mediatek.com>, <kendrick.hsu@mediatek.com>,
        Frederic Chen <Frederic.Chen@mediatek.com>
Subject: [PATCH v5 00/14] support gce on mt8183 platform
Date:   Tue, 7 May 2019 16:13:43 +0800
Message-ID: <20190507081355.52630-1-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v4:
 - refine the architecture of the packet encoder function
 - refine the gce enevt property
 - change the patch's title

Changes since v3:
 - fix a typo in dt-binding and dtsi
 - cast the return value to right format

Changes since v2:
 - according to CK's review comment, change the property name and
   refine the parameter
 - change the patch's title
 - remove unused property from dt-binding and dts

Changes since v1:
 - add prefix "cmdq" in the commit subject
 - add dt-binding document for get event and subsys function
 - add fix up tag in fixup patch
 - fix up some coding style (alignment)

MTK will support gce function on mt8183 platform.
  dt-binding: gce: add gce header file for mt8183
  mailbox: mediatek: cmdq: support mt8183 gce function
  arm64: dts: add gce node for mt8183

Besides above patches, we refine gce driver on those patches.
  mailbox: mediatek: cmdq: move the CMDQ_IRQ_MASK into cmdq driver data
  soc: mediatek: cmdq: clear the event in cmdq initial flow

In order to enhance the convenience of gce usage, we add new helper
functions and refine the method of instruction combining.
  dt-binding: gce: remove thread-num property
  dt-binding: gce: add binding for gce subsys property
  dt-binding: gce: add binding for gce event property
  soc: mediatek: cmdq: define the instruction struct
  soc: mediatek: cmdq: add polling function
  soc: mediatek: cmdq: add cmdq_dev_get_subsys function
  soc: mediatek: cmdq: add cmdq_dev_get_event function

Bibby Hsieh (12):
  dt-binding: gce: remove thread-num property
  dt-binding: gce: add gce header file for mt8183
  dt-binding: gce: add binding for gce subsys property
  dt-binding: gce: add binding for gce event property
  mailbox: mediatek: cmdq: move the CMDQ_IRQ_MASK into cmdq driver data
  mailbox: mediatek: cmdq: support mt8183 gce function
  soc: mediatek: cmdq: clear the event in cmdq initial flow
  soc: mediatek: cmdq: define the instruction struct
  soc: mediatek: cmdq: add polling function
  soc: mediatek: cmdq: add cmdq_dev_get_subsys function
  soc: mediatek: cmdq: add cmdq_dev_get_event function
  arm64: dts: add gce node for mt8183

 .../devicetree/bindings/mailbox/mtk-gce.txt   |  31 ++-
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      |  11 +
 drivers/mailbox/mtk-cmdq-mailbox.c            |  18 +-
 drivers/soc/mediatek/mtk-cmdq-helper.c        | 195 ++++++++++++++----
 include/dt-bindings/gce/mt8183-gce.h          | 177 ++++++++++++++++
 include/linux/mailbox/mtk-cmdq-mailbox.h      |   5 +
 include/linux/soc/mediatek/mtk-cmdq.h         |  62 +++++-
 7 files changed, 437 insertions(+), 62 deletions(-)
 create mode 100644 include/dt-bindings/gce/mt8183-gce.h

-- 
2.18.0

