Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C68FC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 11:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B4F21D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 11:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405183AbfIYL75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 07:59:57 -0400
Received: from mail-sz.amlogic.com ([211.162.65.117]:37247 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405128AbfIYL7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 07:59:55 -0400
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Sep 2019 07:59:52 EDT
Received: from droid15-sz.amlogic.com (10.28.8.25) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.1591.10; Wed, 25 Sep 2019
 19:44:49 +0800
From:   Jian Hu <jian.hu@amlogic.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Jian Hu <jian.hu@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        <linux-clk@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: clock: meson: add A1 clock controller bindings
Date:   Wed, 25 Sep 2019 19:44:47 +0800
Message-ID: <1569411888-98116-2-git-send-email-jian.hu@amlogic.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1569411888-98116-1-git-send-email-jian.hu@amlogic.com>
References: <1569411888-98116-1-git-send-email-jian.hu@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.28.8.25]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the documentation to support Amlogic A1 clock driver,
and add A1 clock controller bindings.

Signed-off-by: Jian Hu <jian.hu@amlogic.com>
Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
---
 .../devicetree/bindings/clock/amlogic,a1-clkc.yaml |  65 +++++++++++++
 include/dt-bindings/clock/a1-clkc.h                | 102 +++++++++++++++++++++
 2 files changed, 167 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml
 create mode 100644 include/dt-bindings/clock/a1-clkc.h

diff --git a/Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml
new file mode 100644
index 0000000..f012eb2
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
+ * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
+ */
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/clock/amlogic,a1-clkc.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Amlogic Meson A1 Clock Control Unit Device Tree Bindings
+
+maintainers:
+  - Neil Armstrong <narmstrong@baylibre.com>
+  - Jerome Brunet <jbrunet@baylibre.com>
+  - Jian Hu <jian.hu@jian.hu.com>
+
+properties:
+  compatible:
+    - enum:
+        - amlogic,a1-clkc
+
+  reg:
+    minItems: 1
+    maxItems: 3
+    items:
+      - description: peripheral registers
+      - description: cpu registers
+      - description: pll registers
+
+  reg-names:
+    items:
+      - const: peripheral
+      - const: pll
+      - const: cpu
+
+  clocks:
+    maxItems: 1
+    items:
+      - description: Input Oscillator (usually at 24MHz)
+
+  clock-names:
+    maxItems: 1
+    items:
+      - const: xtal
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - "#clock-cells"
+
+examples:
+  - |
+    clkc: clock-controller {
+        compatible = "amlogic,a1-clkc";
+        reg = <0x0 0xfe000800 0x0 0x100>,
+              <0x0 0xfe007c00 0x0 0x21c>,
+              <0x0 0xfd000080 0x0 0x20>;
+        reg-names = "peripheral", "pll", "cpu";
+        clocks = <&xtal;
+        clock-names = "xtal";
+        #clock-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/a1-clkc.h b/include/dt-bindings/clock/a1-clkc.h
new file mode 100644
index 0000000..69fbf37
--- /dev/null
+++ b/include/dt-bindings/clock/a1-clkc.h
@@ -0,0 +1,102 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
+ * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
+ */
+
+#ifndef __A1_CLKC_H
+#define __A1_CLKC_H
+
+#define CLKID_FIXED_PLL				1
+#define CLKID_FCLK_DIV2				2
+#define CLKID_FCLK_DIV3				3
+#define CLKID_FCLK_DIV5				4
+#define CLKID_FCLK_DIV7				5
+#define CLKID_FCLK_DIV2_DIV			6
+#define CLKID_FCLK_DIV3_DIV			7
+#define CLKID_FCLK_DIV5_DIV			8
+#define CLKID_FCLK_DIV7_DIV			9
+#define CLKID_SYS_CLK				16
+#define CLKID_HIFI_PLL				17
+#define CLKID_CLKTREE				25
+#define CLKID_RESET_CTRL			26
+#define CLKID_ANALOG_CTRL			27
+#define CLKID_PWR_CTRL				28
+#define CLKID_PAD_CTRL				29
+#define CLKID_SYS_CTRL				30
+#define CLKID_TEMP_SENSOR			31
+#define CLKID_AM2AXI_DIV			32
+#define CLKID_SPICC_B				33
+#define CLKID_SPICC_A				34
+#define CLKID_CLK_MSR				35
+#define CLKID_AUDIO				36
+#define CLKID_JTAG_CTRL				37
+#define CLKID_SARADC				38
+#define CLKID_PWM_EF				39
+#define CLKID_PWM_CD				40
+#define CLKID_PWM_AB				41
+#define CLKID_CEC				42
+#define CLKID_I2C_S				43
+#define CLKID_IR_CTRL				44
+#define CLKID_I2C_M_D				45
+#define CLKID_I2C_M_C				46
+#define CLKID_I2C_M_B				47
+#define CLKID_I2C_M_A				48
+#define CLKID_ACODEC				49
+#define CLKID_OTP				50
+#define CLKID_SD_EMMC_A				51
+#define CLKID_USB_PHY				52
+#define CLKID_USB_CTRL				53
+#define CLKID_SYS_DSPB				54
+#define CLKID_SYS_DSPA				55
+#define CLKID_DMA				56
+#define CLKID_IRQ_CTRL				57
+#define CLKID_NIC				58
+#define CLKID_GIC				59
+#define CLKID_UART_C				60
+#define CLKID_UART_B				61
+#define CLKID_UART_A				62
+#define CLKID_SYS_PSRAM				63
+#define CLKID_RSA				64
+#define CLKID_CORESIGHT				65
+#define CLKID_AM2AXI_VAD			66
+#define CLKID_AUDIO_VAD				67
+#define CLKID_AXI_DMC				68
+#define CLKID_AXI_PSRAM				69
+#define CLKID_RAMB				70
+#define CLKID_RAMA				71
+#define CLKID_AXI_SPIFC				72
+#define CLKID_AXI_NIC				73
+#define CLKID_AXI_DMA				74
+#define CLKID_CPU_CTRL				75
+#define CLKID_ROM				76
+#define CLKID_PROC_I2C				77
+#define CLKID_DSPA_SEL				84
+#define CLKID_DSPB_SEL				91
+#define CLKID_DSPA_EN_DSPA			92
+#define CLKID_DSPA_EN_NIC			93
+#define CLKID_DSPB_EN_DSPB			94
+#define CLKID_DSPB_EN_NIC			95
+#define CLKID_RTC_CLK				100
+#define CLKID_CECA_32K				105
+#define CLKID_CECB_32K				110
+#define CLKID_24M				111
+#define CLKID_12M				112
+#define CLKID_FCLK_DIV2_DIVN			114
+#define CLKID_GEN				118
+#define CLKID_SARADC_SEL			119
+#define CLKID_SARADC_CLK			121
+#define CLKID_PWM_A				124
+#define CLKID_PWM_B				127
+#define CLKID_PWM_C				130
+#define CLKID_PWM_D				133
+#define CLKID_PWM_E				136
+#define CLKID_PWM_F				139
+#define CLKID_SPICC				143
+#define CLKID_TS				145
+#define CLKID_SPIFC				149
+#define CLKID_USB_BUS				152
+#define CLKID_SD_EMMC				156
+#define CLKID_PSRAM				160
+#define CLKID_DMC				164
+
+#endif /* __A1_CLKC_H */
-- 
1.9.1

