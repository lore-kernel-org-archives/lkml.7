Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C05C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 03:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4ECA20870
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 03:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731745AbfDADfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 23:35:53 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:32746 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731389AbfDADfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 23:35:52 -0400
X-UUID: 5203d50b7b3e4570990c85494af1690c-20190401
X-UUID: 5203d50b7b3e4570990c85494af1690c-20190401
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <zhiyong.tao@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1106489575; Mon, 01 Apr 2019 11:35:43 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 1 Apr 2019 11:35:41 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 1 Apr 2019 11:35:40 +0800
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
Subject: [PATCH v4 1/4] dt-bindings: pinctrl: mt8183: add binding document
Date:   Mon, 1 Apr 2019 11:35:32 +0800
Message-ID: <20190401033535.16910-2-zhiyong.tao@mediatek.com>
X-Mailer: git-send-email 2.12.5
In-Reply-To: <20190401033535.16910-1-zhiyong.tao@mediatek.com>
References: <20190401033535.16910-1-zhiyong.tao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: CEC92972E6A54A6553DDEEB43FBD6E9F806BE6983843E26814CDC458A3E7ECDF2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit adds mt8183 compatible node in binding document.

Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
Signed-off-by: Erin Lo <erin.lo@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>

---
This patch is based on patch "https://patchwork.kernel.org/patch/10778511/".
---
 .../devicetree/bindings/pinctrl/pinctrl-mt8183.txt | 132 +++++++++++++++++++++
 1 file changed, 132 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
new file mode 100644
index 000000000000..eccbe3f55d3f
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
@@ -0,0 +1,132 @@
+* Mediatek MT8183 Pin Controller
+
+The Mediatek's Pin controller is used to control SoC pins.
+
+Required properties:
+- compatible: value should be one of the following.
+	"mediatek,mt8183-pinctrl", compatible with mt8183 pinctrl.
+- gpio-controller : Marks the device node as a gpio controller.
+- #gpio-cells: number of cells in GPIO specifier. Since the generic GPIO
+  binding is used, the amount of cells must be specified as 2. See the below
+  mentioned gpio binding representation for description of particular cells.
+- gpio-ranges : gpio valid number range.
+- reg: physical address base for gpio base registers. There are 10 GPIO
+  physical address base in mt8183.
+
+Optional properties:
+- reg-names: gpio base register names. There are 10 gpio base register
+  names in mt8183. They are "iocfg0", "iocfg1", "iocfg2", "iocfg3", "iocfg4",
+  "iocfg5", "iocfg6", "iocfg7", "iocfg8", "eint".
+- interrupt-controller: Marks the device node as an interrupt controller
+- #interrupt-cells: Should be two.
+- interrupts : The interrupt outputs to sysirq.
+
+Please refer to pinctrl-bindings.txt in this directory for details of the
+common pinctrl bindings used by client devices.
+
+Subnode format
+A pinctrl node should contain at least one subnodes representing the
+pinctrl groups available on the machine. Each subnode will list the
+pins it needs, and how they should be configured, with regard to muxer
+configuration, pullups, drive strength, input enable/disable and input schmitt.
+
+    node {
+	pinmux = <PIN_NUMBER_PINMUX>;
+	GENERIC_PINCONFIG;
+    };
+
+Required properties:
+- pinmux: integer array, represents gpio pin number and mux setting.
+    Supported pin number and mux varies for different SoCs, and are defined
+    as macros in boot/dts/<soc>-pinfunc.h directly.
+
+Optional properties:
+- GENERIC_PINCONFIG: is the generic pinconfig options to use, bias-disable,
+    bias-pull-down, bias-pull-up, input-enable, input-disable, output-low,
+    output-high, input-schmitt-enable, input-schmitt-disable
+    and drive-strength are valid.
+
+    Some special pins have extra pull up strength, there are R0 and R1 pull-up
+    resistors available, but for user, it's only need to set R1R0 as 00, 01,
+    10 or 11. So It needs config "mediatek,pull-up-adv" or
+    "mediatek,pull-down-adv" to support arguments for those special pins.
+    Valid arguments are from 0 to 3.
+
+    mediatek,tdsel: An integer describing the steps for output level shifter
+      duty cycle when asserted (high pulse width adjustment). Valid arguments
+      are from 0 to 15.
+    mediatek,rdsel: An integer describing the steps for input level shifter
+      duty cycle when asserted (high pulse width adjustment). Valid arguments
+      are from 0 to 63.
+
+    When config drive-strength, it can support some arguments, such as
+    MTK_DRIVE_4mA, MTK_DRIVE_6mA, etc. See dt-bindings/pinctrl/mt65xx.h.
+    It can only support 2/4/6/8/10/12/14/16mA in mt8183.
+    For I2C pins, there are existing generic driving setup and the specific
+    driving setup. I2C pins can only support 2/4/6/8/10/12/14/16mA driving
+    adjustment in generic driving setup. But in specific driving setup,
+    they can support 0.125/0.25/0.5/1mA adjustment. If we enable specific
+    driving setup for I2C pins, the existing generic driving setup will be
+    disabled. For some special features, we need the I2C pins specific
+    driving setup. The specific driving setup is controlled by E1E0EN.
+    So we need add extra vendor driving preperty instead of
+    the generic driving property.
+    We can add "mediatek,drive-strength-adv = <XXX>;" to describe the specific
+    driving setup property. "XXX" means the value of E1E0EN. EN is 0 or 1.
+    It is used to enable or disable the specific driving setup.
+    E1E0 is used to describe the detail strength specification of the I2C pin.
+    When E1=0/E0=0, the strength is 0.125mA.
+    When E1=0/E0=1, the strength is 0.25mA.
+    When E1=1/E0=0, the strength is 0.5mA.
+    When E1=1/E0=1, the strength is 1mA.
+    So the valid arguments of "mediatek,drive-strength-adv" are from 0 to 7.
+
+Examples:
+
+#include "mt8183-pinfunc.h"
+
+...
+{
+	pio: pinctrl@10005000 {
+		compatible = "mediatek,mt8183-pinctrl";
+		reg = <0 0x10005000 0 0x1000>,
+		      <0 0x11f20000 0 0x1000>,
+		      <0 0x11e80000 0 0x1000>,
+		      <0 0x11e70000 0 0x1000>,
+		      <0 0x11e90000 0 0x1000>,
+		      <0 0x11d30000 0 0x1000>,
+		      <0 0x11d20000 0 0x1000>,
+		      <0 0x11c50000 0 0x1000>,
+		      <0 0x11f30000 0 0x1000>,
+		      <0 0x1000b000 0 0x1000>;
+		reg-names = "iocfg0", "iocfg1", "iocfg2",
+			    "iocfg3", "iocfg4", "iocfg5",
+			    "iocfg6", "iocfg7", "iocfg8",
+			    "eint";
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-ranges = <&pio 0 0 192>;
+		interrupt-controller;
+		interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>;
+		#interrupt-cells = <2>;
+
+		i2c0_pins_a: i2c0 {
+			pins1 {
+				pinmux = <PINMUX_GPIO48__FUNC_SCL5>,
+					 <PINMUX_GPIO49__FUNC_SDA5>;
+				mediatek,pull-up-adv = <3>;
+				mediatek,drive-strength-adv = <7>;
+			};
+		};
+
+		i2c1_pins_a: i2c1 {
+			pins {
+				pinmux = <PINMUX_GPIO50__FUNC_SCL3>,
+					 <PINMUX_GPIO51__FUNC_SDA3>;
+				mediatek,pull-down-adv = <2>;
+				mediatek,drive-strength-adv = <4>;
+			};
+		};
+		...
+	};
+};
-- 
2.12.5

