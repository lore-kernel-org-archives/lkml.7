Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A57C4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 01:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43AE42082C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 01:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392462AbfIJBkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 21:40:06 -0400
Received: from mx.socionext.com ([202.248.49.38]:11404 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390948AbfIJBkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 21:40:06 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 10 Sep 2019 10:40:04 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 1B987605F8;
        Tue, 10 Sep 2019 10:40:04 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Tue, 10 Sep 2019 10:40:04 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 9359A40373;
        Tue, 10 Sep 2019 10:40:03 +0900 (JST)
Received: from user-VB.e01.socionext.com (unknown [10.213.119.151])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 7FE251204B3;
        Tue, 10 Sep 2019 10:40:03 +0900 (JST)
From:   Takao Orito <orito.takao@socionext.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, masami.hiramatsu@linaro.org,
        jaswinder.singh@linaro.org, sugaya.taichi@socionext.com,
        kasai.kazuhiro@socionext.com, kanematsu.shinji@socionext.com,
        orito.takao@socionext.com
Subject: [PATCH v3 1/2] dt-bindings: mmc: add DT bindings for Milbeaut SD controller
Date:   Tue, 10 Sep 2019 10:40:52 +0900
Message-Id: <1568079652-28849-1-git-send-email-orito.takao@socionext.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the device-tree binding documentation for Milbeaut SDHCI driver.

Signed-off-by: Takao Orito <orito.takao@socionext.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/mmc/sdhci-milbeaut.txt     | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt b/Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt
new file mode 100644
index 0000000..627ee89
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt
@@ -0,0 +1,30 @@
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
+		fujitsu,cmd-dat-delay-select;
+	};
-- 
1.9.1


