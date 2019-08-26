Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A864C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C1D722CED
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbfHZH2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 03:28:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:55080 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729925AbfHZH2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 03:28:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 00:28:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,431,1559545200"; 
   d="scan'208";a="209266928"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga002.fm.intel.com with ESMTP; 26 Aug 2019 00:28:04 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, michal.simek@xilinx.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v1 1/2] dt-bindings: mmc: sdhci-of-arasan: Add new compatible for Intel LGM eMMC
Date:   Mon, 26 Aug 2019 15:27:59 +0800
Message-Id: <20190826072800.38413-1-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Add a new compatible to use the sdhc-arasan host controller driver
with the eMMC PHY on Intel's Lightning Mountain SoC.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
---
 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index 1edbb049cccb..7ca0aa7ccc0b 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -17,6 +17,8 @@ Required Properties:
       For this device it is strongly suggested to include arasan,soc-ctl-syscon.
     - "ti,am654-sdhci-5.1", "arasan,sdhci-5.1": TI AM654 MMC PHY
 	Note: This binding has been deprecated and moved to [5].
+    - "intel,lgm-sdhci-5.1-emmc", "arasan,sdhci-5.1": Intel LGM eMMC PHY
+      For this device it is strongly suggested to include arasan,soc-ctl-syscon.
 
   [5] Documentation/devicetree/bindings/mmc/sdhci-am654.txt
 
@@ -80,3 +82,18 @@ Example:
 		phy-names = "phy_arasan";
 		#clock-cells = <0>;
 	};
+
+	emmc: sdhci@ec700000 {
+		compatible = "intel,lgm-sdhci-5.1-emmc", "arasan,sdhci-5.1";
+		reg = <0xec700000 0x300>;
+		interrupt-parent = <&ioapic1>;
+		interrupts = <44 1>;
+		clocks = <&cgu0 LGM_CLK_EMMC5>, <&cgu0 LGM_CLK_NGI>,
+			 <&cgu0 LGM_GCLK_EMMC>;
+		clock-names = "clk_xin", "clk_ahb", "gate";
+		clock-output-names = "emmc_cardclock";
+		#clock-cells = <0>;
+		phys = <&emmc_phy>;
+		phy-names = "phy_arasan";
+		arasan,soc-ctl-syscon = <&sysconf>;
+	};
-- 
2.11.0

