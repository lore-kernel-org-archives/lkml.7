Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5516AC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 09:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B956253AC
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 09:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfE3JTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 05:19:33 -0400
Received: from mx.socionext.com ([202.248.49.38]:34654 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727253AbfE3JTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 05:19:33 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 30 May 2019 18:19:31 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 27D56180D46;
        Thu, 30 May 2019 18:19:31 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 30 May 2019 18:19:31 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 61F5C1A14E3;
        Thu, 30 May 2019 18:19:30 +0900 (JST)
Received: from user-VB.e01.socionext.com (unknown [10.213.119.151])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 40F06120C10;
        Thu, 30 May 2019 18:19:30 +0900 (JST)
From:   Takao Orito <orito.takao@socionext.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, masami.hiramatsu@linaro.org,
        jaswinder.singh@linaro.org, sugaya.taichi@socionext.com,
        kasai.kazuhiro@socionext.com, kanematsu.shinji@socionext.com,
        orito.takao@socionext.com
Subject: [PATCH v2 1/2] dt-bindings: mmc: add DT bindings for Milbeaut SD controller
Date:   Thu, 30 May 2019 18:22:11 +0900
Message-Id: <1559208131-426-1-git-send-email-orito.takao@socionext.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the device-tree binding documentation for Milbeaut SDHCI driver.

Signed-off-by: Takao Orito <orito.takao@socionext.com>
---
 .../devicetree/bindings/mmc/sdhci-milbeaut.txt     | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt b/Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt
new file mode 100644
index 0000000..6063116
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt
@@ -0,0 +1,32 @@
+* SOCIONEXT Milbeaut SDHCI controller
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
+- vmmc-supply: a phandle of a fixed GPIO regulator
+
+Optional properties:
+- fujitsu,cmd-dat-delay-select: boolean property indicating that this host
+  requires the CMD_DAT_DELAY control to be enabled.
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
+		vmmc-supply = <&vcc_sdhci3>;
+		fujitsu,cmd-dat-delay-select;
+	};
-- 
1.9.1


