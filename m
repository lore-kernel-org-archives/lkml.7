Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB880C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 02:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3FD82173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 02:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbfC1CTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 22:19:45 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:25155 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727385AbfC1CTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 22:19:44 -0400
X-UUID: 5bd5a5aa07ed44589b48ddb881ee36eb-20190328
X-UUID: 5bd5a5aa07ed44589b48ddb881ee36eb-20190328
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 278449596; Thu, 28 Mar 2019 10:19:37 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 28 Mar 2019 10:19:35 +0800
Received: from mtkslt302.mediatek.inc (10.21.14.115) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 28 Mar 2019 10:19:35 +0800
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
        Sascha Hauer <kernel@pengutronix.de>,
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
Subject: [PATCH v3 00/12] support gce on mt8183 platform
Date:   Thu, 28 Mar 2019 10:19:21 +0800
Message-ID: <1553739573-19708-1-git-send-email-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: D2C628574C2A1665A91204B9CAA10D3E9E707CF30F01B6EFEBCA3EE11510B8A52000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
  soc: mediatek: cmdq: support mt8183 gce function
  arm64: dts: add gce node for mt8183

Besides above patches, we refine gce driver on those patches.
  soc: mediatek: cmdq: move the CMDQ_IRQ_MASK into cmdq driver data
  soc: mediatek: cmdq: clear the event in cmdq initial flow

In order to enhance the convenience of gce usage, we add new helper
functions and refine the method of instruction combining. 
  dt-binding: gce: remove thread-num property
  dt-binding: gce: add binding for gce event property
  dt-binding: gce: add binding for gce subsys property
  soc: mediatek: cmdq: add packet encoder function
  soc: mediatek: cmdq: add polling function
  soc: mediatek: cmdq: add cmdq_dev_get_subsys function
  soc: mediatek: cmdq: add cmdq_dev_get_event function

Based on v5.0-rc1 and these series
  http://lists.infradead.org/pipermail/linux-mediatek/2019-February/017570.html
  http://lists.infradead.org/pipermail/linux-mediatek/2019-February/017320.html
  http://lists.infradead.org/pipermail/linux-mediatek/2019-January/017196.html

Bibby Hsieh (12):
  dt-binding: gce: remove thread-num property
  dt-binding: gce: add gce header file for mt8183
  dt-binding: gce: add binding for gce event property
  dt-binding: gce: add binding for gce subsys property
  soc: mediatek: cmdq: move the CMDQ_IRQ_MASK into cmdq driver data
  soc: mediatek: cmdq: support mt8183 gce function
  soc: mediatek: cmdq: clear the event in cmdq initial flow
  soc: mediatek: cmdq: add packet encoder function
  soc: mediatek: cmdq: add polling function
  soc: mediatek: cmdq: add cmdq_dev_get_subsys function
  soc: mediatek: cmdq: add cmdq_dev_get_event function
  arm64: dts: add gce node for mt8183

 .../devicetree/bindings/mailbox/mtk-gce.txt        |  37 +++-
 arch/arm64/boot/dts/mediatek/mt8183.dtsi           |  12 ++
 drivers/mailbox/mtk-cmdq-mailbox.c                 |  18 +-
 drivers/soc/mediatek/mtk-cmdq-helper.c             | 212 +++++++++++++++++----
 include/dt-bindings/gce/mt8183-gce.h               | 177 +++++++++++++++++
 include/linux/mailbox/mtk-cmdq-mailbox.h           |   5 +
 include/linux/soc/mediatek/mtk-cmdq.h              |  62 +++++-
 7 files changed, 464 insertions(+), 59 deletions(-)
 create mode 100644 include/dt-bindings/gce/mt8183-gce.h

-- 
1.9.1

