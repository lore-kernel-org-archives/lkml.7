Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8F9C04AB7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 08:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430BF20879
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 08:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfENIsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 04:48:08 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:55472 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725916AbfENIrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 04:47:39 -0400
X-UUID: bf7c4763819d42ffbce3bc351accec92-20190514
X-UUID: bf7c4763819d42ffbce3bc351accec92-20190514
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2021548160; Tue, 14 May 2019 16:47:34 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 14 May 2019 16:47:30 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 14 May 2019 16:47:28 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v5 2/6] dt-bindings: usb: add binding for Type-B GPIO connector driver
Date:   Tue, 14 May 2019 16:47:19 +0800
Message-ID: <1557823643-8616-3-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1557823643-8616-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1557823643-8616-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's used to support dual role switch via GPIO when use Type-B
receptacle, typically the USB ID pin is connected to an input
GPIO pin

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v5 changes:
 1. treat type-B connector as child device of USB controller's, but not
    as a separate virtual device, suggested by Rob
 2. put connector's port node under connector node, suggested by Rob

v4 no changes

v3 changes:
 1. treat type-B connector as a virtual device, but not child device of
    USB controller's

v2 changes:
  1. new patch to make binding clear suggested by Hans
---
 .../bindings/usb/typeb-conn-gpio.txt          | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/typeb-conn-gpio.txt

diff --git a/Documentation/devicetree/bindings/usb/typeb-conn-gpio.txt b/Documentation/devicetree/bindings/usb/typeb-conn-gpio.txt
new file mode 100644
index 000000000000..20dd3499a348
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/typeb-conn-gpio.txt
@@ -0,0 +1,42 @@
+USB Type-B GPIO Connector
+
+This is used to switch dual role mode from the USB ID pin connected to
+an input GPIO pin.
+
+Required properties:
+- compatible : should include "linux,typeb-conn-gpio" and "usb-b-connector".
+- id-gpios, vbus-gpios : either one of them must be present, and both
+	can be present as well.
+- vbus-supply : can be present if needed when supports dual role mode or
+	host mode.
+	see connector/usb-connector.txt
+
+Sub-nodes:
+- port : should be present.
+	see graph.txt
+
+Example:
+
+&mtu3 {
+	status = "okay";
+
+	connector {
+		compatible = "linux,typeb-conn-gpio", "usb-b-connector";
+		label = "micro-USB";
+		type = "micro";
+		id-gpios = <&pio 12 GPIO_ACTIVE_HIGH>;
+		vbus-supply = <&usb_p0_vbus>;
+
+		port {
+			bconn_ep: endpoint@0 {
+				remote-endpoint = <&usb_role_sw>;
+			};
+		};
+	};
+
+	port {
+		usb_role_sw: endpoint@0 {
+			remote-endpoint = <&bconn_ep>;
+		};
+	};
+};
-- 
2.21.0

