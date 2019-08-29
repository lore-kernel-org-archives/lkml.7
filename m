Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51416C3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 09:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 332AB208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 09:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfH2JXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 05:23:19 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:14552 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727101AbfH2JXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 05:23:13 -0400
X-UUID: 31ecad922b4b4ed0a32146e3ad90497d-20190829
X-UUID: 31ecad922b4b4ed0a32146e3ad90497d-20190829
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1608560054; Thu, 29 Aug 2019 17:23:11 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 29 Aug 2019 17:23:09 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 29 Aug 2019 17:23:08 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Biju Das <biju.das@bp.renesas.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [PATCH next v11 03/11] dt-bindings: usb: add binding for USB GPIO based connection detection driver
Date:   Thu, 29 Aug 2019 17:22:30 +0800
Message-ID: <1567070558-29417-4-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1567070558-29417-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1567070558-29417-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: B59DAFD410BA8AF279F9E0A9B2672EA1E00E8BAC821020BD5225B94C965F85A12000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's used to support dual role switch via GPIO when use Type-B
receptacle, typically the USB ID pin is connected to an input
GPIO, and also used to enable/disable device when the USB Vbus
pin is connected to an input GPIO.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
v11 changes:
 1. add Reviewed-by Linus
 2. change compatible as "gpio-usb-b-connector", and remove label
    in example suggested by Rob

v9~v10 no changes

v8 changes:
 1. rename the title
 2. change the compatible as "linux,usb-conn-gpio" instead of
    "linux,typeb-conn-gpio"

v7 changes:
 1. add description for device only mode

v6 changes:
 1. remove status and port nodes in example
 2. make vbus-supply as optional property

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
 .../devicetree/bindings/usb/usb-conn-gpio.txt | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/usb-conn-gpio.txt

diff --git a/Documentation/devicetree/bindings/usb/usb-conn-gpio.txt b/Documentation/devicetree/bindings/usb/usb-conn-gpio.txt
new file mode 100644
index 000000000000..3d05ae56cb0d
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/usb-conn-gpio.txt
@@ -0,0 +1,30 @@
+USB GPIO Based Connection Detection
+
+This is typically used to switch dual role mode from the USB ID pin connected
+to an input GPIO, and also used to enable/disable device mode from the USB
+Vbus pin connected to an input GPIO.
+
+Required properties:
+- compatible : should include "gpio-usb-b-connector" and "usb-b-connector".
+- id-gpios, vbus-gpios : input gpios, either one of them must be present,
+	and both can be present as well.
+	see connector/usb-connector.txt
+
+Optional properties:
+- vbus-supply : can be present if needed when supports dual role mode.
+	see connector/usb-connector.txt
+
+- Sub-nodes:
+	- port : can be present.
+		see graph.txt
+
+Example:
+
+&mtu3 {
+	connector {
+		compatible = "gpio-usb-b-connector", "usb-b-connector";
+		type = "micro";
+		id-gpios = <&pio 12 GPIO_ACTIVE_HIGH>;
+		vbus-supply = <&usb_p0_vbus>;
+	};
+};
-- 
2.23.0

