Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF71FC6196
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9BF0215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfKHVse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 16:48:34 -0500
Received: from mga17.intel.com ([192.55.52.151]:20333 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbfKHVsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:48:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2019 13:48:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,283,1569308400"; 
   d="scan'208";a="197038024"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by orsmga008.jf.intel.com with ESMTP; 08 Nov 2019 13:48:32 -0800
From:   thor.thayer@linux.intel.com
To:     dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCH] arm64: dts: agilex: Add EDAC Device Tree
Date:   Fri,  8 Nov 2019 15:50:25 -0600
Message-Id: <1573249825-21769-1-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Add the device tree nodes required to support the Intel
Agilex SoCFPGA EDAC framework.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi | 59 +++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
index f9d1b26a3384..2b3468590f30 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
@@ -534,6 +534,65 @@
 			reg = <0xf8011100 0xc0>;
 		};
 
+		eccmgr {
+			compatible = "altr,socfpga-s10-ecc-manager",
+				     "altr,socfpga-a10-ecc-manager";
+			altr,sysmgr-syscon = <&sysmgr>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			interrupts = <0 15 4>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			ranges;
+
+			sdramedac {
+				compatible = "altr,sdram-edac-s10";
+				altr,sdr-syscon = <&sdr>;
+				interrupts = <16 4>;
+			};
+
+			ocram-ecc@ff8cc000 {
+				compatible = "altr,socfpga-s10-ocram-ecc",
+					     "altr,socfpga-a10-ocram-ecc";
+				reg = <0xff8cc000 0x100>;
+				altr,ecc-parent = <&ocram>;
+				interrupts = <1 4>;
+			};
+
+			usb0-ecc@ff8c4000 {
+				compatible = "altr,socfpga-s10-usb-ecc",
+					     "altr,socfpga-usb-ecc";
+				reg = <0xff8c4000 0x100>;
+				altr,ecc-parent = <&usb0>;
+				interrupts = <2 4>;
+			};
+
+			emac0-rx-ecc@ff8c0000 {
+				compatible = "altr,socfpga-s10-eth-mac-ecc",
+					     "altr,socfpga-eth-mac-ecc";
+				reg = <0xff8c0000 0x100>;
+				altr,ecc-parent = <&gmac0>;
+				interrupts = <4 4>;
+			};
+
+			emac0-tx-ecc@ff8c0400 {
+				compatible = "altr,socfpga-s10-eth-mac-ecc",
+					     "altr,socfpga-eth-mac-ecc";
+				reg = <0xff8c0400 0x100>;
+				altr,ecc-parent = <&gmac0>;
+				interrupts = <5 4>;
+			};
+
+			sdmmca-ecc@ff8c8c00 {
+				compatible = "altr,socfpga-s10-sdmmc-ecc",
+					     "altr,socfpga-sdmmc-ecc";
+				reg = <0xff8c8c00 0x100>;
+				altr,ecc-parent = <&mmc>;
+				interrupts = <14 4>,
+					     <15 4>;
+			};
+		};
+
 		qspi: spi@ff8d2000 {
 			compatible = "cdns,qspi-nor";
 			#address-cells = <1>;
-- 
2.7.4

