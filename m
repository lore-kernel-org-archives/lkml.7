Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF18C73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 13:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF23214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 13:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfGINJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 09:09:54 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:22880 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726345AbfGINJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 09:09:53 -0400
X-UUID: 040cb6db70d6486b9edf9840134d1ed8-20190709
X-UUID: 040cb6db70d6486b9edf9840134d1ed8-20190709
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <qii.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 696691753; Tue, 09 Jul 2019 21:09:46 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 9 Jul 2019 21:09:45 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 9 Jul 2019 21:09:45 +0800
From:   Qii Wang <qii.wang@mediatek.com>
To:     <bbrezillon@kernel.org>
CC:     <matthias.bgg@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-i3c@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <leilk.liu@mediatek.com>,
        <qii.wang@mediatek.com>, <liguo.zhang@mediatek.com>,
        <xinping.qian@mediatek.com>
Subject: [PATCH v3 1/2] dt-bindings: i3c: Document MediaTek I3C master bindings
Date:   Tue, 9 Jul 2019 21:09:21 +0800
Message-ID: <1562677762-24067-2-git-send-email-qii.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1562677762-24067-1-git-send-email-qii.wang@mediatek.com>
References: <1562677762-24067-1-git-send-email-qii.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document MediaTek I3C master DT bindings.

Signed-off-by: Qii Wang <qii.wang@mediatek.com>
---
 .../devicetree/bindings/i3c/mtk,i3c-master.txt     |   48 ++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i3c/mtk,i3c-master.txt

diff --git a/Documentation/devicetree/bindings/i3c/mtk,i3c-master.txt b/Documentation/devicetree/bindings/i3c/mtk,i3c-master.txt
new file mode 100644
index 0000000..d32eda6
--- /dev/null
+++ b/Documentation/devicetree/bindings/i3c/mtk,i3c-master.txt
@@ -0,0 +1,48 @@
+Bindings for MediaTek I3C master block
+=====================================
+
+Required properties:
+--------------------
+- compatible: shall be "mediatek,i3c-master"
+- reg: physical base address of the controller and apdma base, length of
+  memory mapped region.
+- reg-names: shall be "main" for master controller and "dma" for apdma.
+- interrupts: the interrupt line connected to this I3C master.
+- clocks: shall reference the i3c and apdma clocks.
+- clock-names: shall include "main" and "dma".
+
+Mandatory properties defined by the generic binding (see
+Documentation/devicetree/bindings/i3c/i3c.txt for more details):
+
+- #address-cells: shall be set to 3
+- #size-cells: shall be set to 0
+
+Optional properties defined by the generic binding (see
+Documentation/devicetree/bindings/i3c/i3c.txt for more details):
+
+- i2c-scl-hz
+- i3c-scl-hz
+
+I3C device connected on the bus follow the generic description (see
+Documentation/devicetree/bindings/i3c/i3c.txt for more details).
+
+Example:
+
+	i3c0: i3c@1100d000 {
+		compatible = "mediatek,i3c-master";
+		reg = <0x1100d000 0x1000>,
+		      <0x11000300 0x80>;
+		reg-names = "main", "dma";
+		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&infracfg CLK_INFRA_I3C0>,
+			 <&infracfg CLK_INFRA_AP_DMA>;
+		clock-names = "main", "dma";
+		#address-cells = <3>;
+		#size-cells = <0>;
+		i2c-scl-hz = <100000>;
+
+		nunchuk: nunchuk@52 {
+			compatible = "nintendo,nunchuk";
+			reg = <0x52 0x0 0x10>;
+		};
+	};
-- 
1.7.9.5

