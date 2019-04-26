Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275F2C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 02:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F1D7206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 02:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfDZCEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 22:04:14 -0400
Received: from mx.socionext.com ([202.248.49.38]:12548 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbfDZCEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 22:04:13 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 26 Apr 2019 11:04:11 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id C08B7180B6F;
        Fri, 26 Apr 2019 11:04:11 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 26 Apr 2019 11:04:11 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 7E4071A15B7;
        Fri, 26 Apr 2019 11:04:11 +0900 (JST)
Received: from user-VB.e01.socionext.com (unknown [10.213.119.151])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 670F3121D03;
        Fri, 26 Apr 2019 11:04:11 +0900 (JST)
From:   Takao Orito <orito.takao@socionext.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, masami.hiramatsu@linaro.org,
        jaswinder.singh@linaro.org, sugaya.taichi@socionext.com,
        kasai.kazuhiro@socionext.com, kanematsu.shinji@socionext.com,
        orito.takao@socionext.com
Subject: [PATCH 1/2] dt-bindings: mmc: add DT bindings for Milbeaut SD controller
Date:   Fri, 26 Apr 2019 11:06:32 +0900
Message-Id: <1556244392-15822-1-git-send-email-orito.takao@socionext.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Takao Orito <orito.takao@socionext.com>
---
 .../devicetree/bindings/mmc/sdhci-milbeaut.txt     | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt b/Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt
new file mode 100644
index 0000000..7008462
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt
@@ -0,0 +1,35 @@
+* SOCIONEXT SDHCI controller
+
+This file documents differences between the core properties in mmc.txt
+and the properties used by the sdhci_milbeaut driver.
+
+Required properties:
+- compatible: "socionext,milbeaut-m10v-sdhci-3.0"
+- clocks: Must contain an entry for each entry in clock-names. It is a
+  list of phandles and clock-specifier pairs.
+  See ../clocks/clock-bindings.txt for details.
+- clock-names: Should contain the following two entries:
+	"iface" - clock used for sdhci interface
+	"core"  - core clock for sdhci controller
+
+Optional properties:
+- vqmmc-supply: phandle to the regulator device tree node, mentioned
+  as the VCCQ/VDD_IO supply in the eMMC/SD specs.
+- fujitsu,cmd-dat-delay-select: boolean property indicating that this host
+  requires the CMD_DAT_DELAY control to be enabled.
+- sni,mmc-power-gpio: set property indicating that power on or off needs
+  control of gpios.
+
+Example:
+	sdhci3: mmc@1b010000 {
+		compatible = "socionext,milbeaut-m10v-sdhci-3.0";
+		reg = <0x1b010000 0x10000>;
+		interrupts = <0 265 0x4>;
+		voltage-ranges = <3300 3300>;
+		bus-width = <4>;
+		clocks = <&clk 7>, <&ahb_clk>;
+		clock-names = "core", "iface";
+		cap-sdio-irq;
+		sni,mmc-power-gpio = <&pinctrl 53 GPIO_ACTIVE_HIGH>;
+			fujitsu,cmd-dat-delay-select;
+	};
-- 
1.9.1


