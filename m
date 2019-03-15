Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFF2C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 07:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 838CB21871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 07:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbfCOHkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 03:40:23 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:4873 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727262AbfCOHkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 03:40:22 -0400
X-UUID: 74f93406e72b450ba7fb8df376042b4b-20190315
X-UUID: 74f93406e72b450ba7fb8df376042b4b-20190315
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2038116600; Fri, 15 Mar 2019 15:40:15 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 15 Mar 2019 15:40:12 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 15 Mar 2019 15:40:09 +0800
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
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 2/6] dt-bindings: usb: add binding for Type-B dual role switch by GPIO
Date:   Fri, 15 Mar 2019 15:38:29 +0800
Message-ID: <1552635513-2378-3-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1552635513-2378-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1552635513-2378-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's used to support dual role switch via GPIO when use Type-B
receptacle

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2 changes:
  1. new patch to make binding clear suggested by Hans
---
 .../bindings/usb/typeb-switch-gpio.txt        | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/typeb-switch-gpio.txt

diff --git a/Documentation/devicetree/bindings/usb/typeb-switch-gpio.txt b/Documentation/devicetree/bindings/usb/typeb-switch-gpio.txt
new file mode 100644
index 000000000000..d46d83bc6500
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/typeb-switch-gpio.txt
@@ -0,0 +1,26 @@
+USB Type-B dual role switch via a GPIO
+
+This is a virtual device used to switch dual role mode from the USB ID pin
+connected to a GPIO pin.
+
+Required properties:
+- compatible: Should be "linux,typeb-switch-gpio"
+
+Either one of id-gpios or vbus-gpios must be present, and both can be present
+as well.
+vbus-supply could be present if needed when support dual role mode.
+	see connector/usb-connector.txt
+
+Example:
+
+&mtu3 {
+	status = "okay";
+
+	connector@0 {
+		compatible = "usb-b-connector", "linux,typeb-switch-gpio";
+		label = "micro-USB";
+		type = "micro";
+		id-gpio = <&pio 12 GPIO_ACTIVE_HIGH>;
+		vbus-supply = <&usb_p0_vbus>;
+	};
+};
-- 
2.20.1

