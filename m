Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0351C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 04:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9936D21773
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 04:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfC2EOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 00:14:30 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5200 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725869AbfC2EO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 00:14:27 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2ED258C547F0702B1757;
        Fri, 29 Mar 2019 12:14:25 +0800 (CST)
Received: from vm100-107-113-134.huawei.com (100.107.113.134) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Fri, 29 Mar 2019 12:14:16 +0800
From:   Yu Chen <chenyu56@huawei.com>
To:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <john.stultz@linaro.org>, <suzhuangluan@hisilicon.com>,
        <kongfei@hisilicon.com>, <liuyu712@hisilicon.com>,
        <wanghu17@hisilicon.com>, <butao@hisilicon.com>,
        <chenyao11@huawei.com>, <fangshengzhou@hisilicon.com>,
        <lipengcheng8@huawei.com>, <songxiaowei@hisilicon.com>,
        <xuyiping@hisilicon.com>, <xuyoujun4@huawei.com>,
        <yudongbin@hisilicon.com>, <zangleigang@hisilicon.com>,
        Yu Chen <chenyu56@huawei.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Binghui Wang <wangbinghui@hisilicon.com>
Subject: [PATCH v5 02/13] dt-bindings: misc: Add bindings for HiSilicon usb hub and data role switch functionality on HiKey960
Date:   Fri, 29 Mar 2019 12:13:58 +0800
Message-ID: <20190329041409.70138-3-chenyu56@huawei.com>
X-Mailer: git-send-email 2.15.0-rc2
In-Reply-To: <20190329041409.70138-1-chenyu56@huawei.com>
References: <20190329041409.70138-1-chenyu56@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.107.113.134]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds binding documentation to support usb hub and usb
data role switch of Hisilicon HiKey960 Board.

Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Binghui Wang <wangbinghui@hisilicon.com>
Signed-off-by: Yu Chen <chenyu56@huawei.com>
---
v1:
* Fix some format errors as suggested by Sergei.
* Modify gpio description to use gpiod API.
v2:
* Remove information about Hikey.
* Fix gpio description.
* Remove device_type of endpoint.
v3:
* Remove property typec-vbus-enable-val.
* Add description of pinctrl-names.
* Add example for "hisilicon,gpio-hubv1"
* Add flag in gpiod properties.
---
---
 .../bindings/misc/hisilicon-hikey-usb.txt          | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt

diff --git a/Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt b/Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt
new file mode 100644
index 000000000000..422e844df719
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt
@@ -0,0 +1,52 @@
+Support usb hub and usb data role switch of Hisilicon HiKey960 Board.
+
+-----------------------------
+
+Required properties:
+- compatible: "hisilicon,gpio-hubv1","hisilicon,hikey960-usb"
+- typec-vbus-gpios: gpio to control the vbus of typeC port
+- otg-switch-gpios: gpio to switch DP & DM between the hub and typeC port
+- hub-vdd33-en-gpios: gpio to enable the power of hub
+- pinctrl-names: pin configuration state name ("default")
+- pinctrl-0: pinctrl config
+
+Example
+-----
+
+	hisi_hikey_usb: hisi_hikey_usb {
+		compatible = "hisilicon,hikey960-usb";
+		typec-vbus-gpios = <&gpio25 2 GPIO_ACTIVE_HIGH>;
+		otg-switch-gpios = <&gpio25 6 GPIO_ACTIVE_HIGH>;
+		hub-vdd33-en-gpios = <&gpio5 6 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usbhub5734_pmx_func>;
+
+		port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			hikey_usb_ep: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&dwc3_role_switch_notify>;
+			};
+		};
+	};
+
+	hisi_hikey_usb: hisi_hikey_usb {
+		compatible = "hisilicon,gpio-hubv1";
+		typec-vbus-gpios = <&gpio25 2 GPIO_ACTIVE_LOW>;
+		otg-switch-gpios = <&gpio25 6 GPIO_ACTIVE_HIGH>;
+		hub-vdd33-en-gpios = <&gpio5 6 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usbhub5734_pmx_func>;
+
+		port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			hikey_usb_ep: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&dwc3_role_switch_notify>;
+			};
+		};
+	};
-- 
2.15.0-rc2

