Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9645EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 04:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7144D20828
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 04:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731078AbfCZE4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 00:56:18 -0400
Received: from mx.socionext.com ([202.248.49.38]:10155 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfCZE4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 00:56:18 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 26 Mar 2019 13:56:16 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 3B916180BD4;
        Tue, 26 Mar 2019 13:56:16 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Tue, 26 Mar 2019 13:56:16 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id A70F640385;
        Tue, 26 Mar 2019 13:56:15 +0900 (JST)
Received: from user-VB.e01.socionext.com (unknown [10.213.119.151])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 90ABC120487;
        Tue, 26 Mar 2019 13:56:15 +0900 (JST)
From:   Takao Orito <orito.takao@socionext.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, masami.hiramatsu@linaro.org,
        jaswinder.singh@linaro.org, sugaya.taichi@socionext.com,
        kasai.kazuhiro@socionext.com, kanematsu.shinji@socionext.com,
        orito.takao@socionext.com
Subject: [Milbeaut PATCH v0.4 1/2] dt-bindings: mmc: sdhci-fujitsu.txt: add miilbeaut driver
Date:   Tue, 26 Mar 2019 13:58:12 +0900
Message-Id: <1553576292-5854-1-git-send-email-orito.takao@socionext.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new compatible description for Milbeaut SoC. Socionext
inherits F_SDH30 IP from Fujitsu. Then new Soc series "Milbeaut"
has F_SDH30 controller specified by "socionext,milbeaut-m10v-sdhci-3.0".

Signed-off-by: Takao Orito <orito.takao@socionext.com>
---
 .../devicetree/bindings/mmc/sdhci-fujitsu.txt      | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt b/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
index 3ee9263..405811f 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
@@ -1,10 +1,10 @@
-* Fujitsu SDHCI controller
+* Fujitsu/Socionext SDHCI controller
 
 This file documents differences between the core properties in mmc.txt
-and the properties used by the sdhci_f_sdh30 driver.
+and the properties used by the sdhci_f_sdh30.
 
 Required properties:
-- compatible: "fujitsu,mb86s70-sdhci-3.0"
+- compatible: "fujitsu,mb86s70-sdhci-3.0", "socionext,milbeaut-m10v-sdhci-3.0"
 - clocks: Must contain an entry for each entry in clock-names. It is a
   list of phandles and clock-specifier pairs.
   See ../clocks/clock-bindings.txt for details.
@@ -17,6 +17,8 @@ Optional properties:
   as the VCCQ/VDD_IO supply in the eMMC/SD specs.
 - fujitsu,cmd-dat-delay-select: boolean property indicating that this host
   requires the CMD_DAT_DELAY control to be enabled.
+- sni,mmc-power-gpio: set property indicating that power on or off needs
+  control of gpio. This is for only "socionext,milbeaut-m10v-sdhci-3.0".
 
 Example:
 
@@ -30,3 +32,17 @@ Example:
 		clocks = <&clock 2 2 0>, <&clock 2 3 0>;
 		clock-names = "iface", "core";
 	};
+
+Exsample2:
+	sdhci3: mmc@1b010000 {
+		compatible = "socionext,milbeaut-m10v-sdhci-3.0";
+		reg = <0x1b010000 0x10000>;
+		interrupts = <0 265 0x4>;
+		voltage-ranges = <3300 3300>;
+		bus-width = <4>;
+		clocks = <&uhs1clk2>, <&ahb_clk>;
+		clock-names = "core", "iface";
+		cap-sdio-irq;
+		sni,mmc-power-gpio = <&pinctrl 53 GPIO_ACTIVE_HIGH>;
+			   fujitsu,cmd-dat-delay-select;
+	};
-- 
1.9.1


