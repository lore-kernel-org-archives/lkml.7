Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED26BC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 02:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA752206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 02:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfDCCKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 22:10:03 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:52408 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726183AbfDCCJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 22:09:59 -0400
X-UUID: 894389519d0b4be080f8f1595156295e-20190403
X-UUID: 894389519d0b4be080f8f1595156295e-20190403
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 751282814; Wed, 03 Apr 2019 10:09:37 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 3 Apr 2019 10:09:35 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 3 Apr 2019 10:09:34 +0800
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
        Min Guo <min.guo@mediatek.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [v3 PATCH 2/6] dt-bindings: usb: add binding for Type-B GPIO connector driver
Date:   Wed, 3 Apr 2019 10:09:10 +0800
Message-ID: <1554257354-7440-3-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1554257354-7440-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1554257354-7440-1-git-send-email-chunfeng.yun@mediatek.com>
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
v3 changes:
 1. treat type-B connector as a virtual device, but not child device of
    USB controller's

v2 changes:
  1. new patch to make binding clear suggested by Hans
---
 .../bindings/usb/typeb-conn-gpio.txt          | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/typeb-conn-gpio.txt

diff --git a/Documentation/devicetree/bindings/usb/typeb-conn-gpio.txt b/Documentation/devicetree/bindings/usb/typeb-conn-gpio.txt
new file mode 100644
index 000000000000..d2e1c4e01b6d
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/typeb-conn-gpio.txt
@@ -0,0 +1,49 @@
+USB Type-B GPIO Connector
+
+This is a virtual device used to switch dual role mode from the USB ID pin
+connected to an input GPIO pin.
+
+Required properties:
+- compatible : Should be "linux,typeb-conn-gpio"
+
+Sub-nodes:
+- connector : should be present.
+	- compatible : should be "usb-b-connector".
+	- id-gpios, vbus-gpios : either one of them must be present,
+		and both can be present as well.
+	- vbus-supply : can be present if needed when supports dual role mode.
+	see connector/usb-connector.txt
+
+- port : should be present.
+	see graph.txt
+
+Example:
+
+rsw_iddig: role_sw_iddig {
+	compatible = "linux,typeb-conn-gpio";
+	status = "okay";
+
+	connector {
+		compatible = "usb-b-connector";
+		label = "micro-USB";
+		type = "micro";
+		id-gpios = <&pio 12 GPIO_ACTIVE_HIGH>;
+		vbus-supply = <&usb_p0_vbus>;
+	};
+
+	port {
+		bconn_ep: endpoint@0 {
+			remote-endpoint = <&usb_role_sw>;
+		};
+	};
+};
+
+&mtu3 {
+	status = "okay";
+
+	port {
+		usb_role_sw: endpoint@0 {
+			remote-endpoint = <&bconn_ep>;
+		};
+	};
+};
-- 
2.20.1

