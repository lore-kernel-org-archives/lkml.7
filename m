Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E1FC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51049214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OLpRKtIS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388659AbfDXWZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:25:07 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50696 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388212AbfDXWZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 18:25:02 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3OMOu9h107954;
        Wed, 24 Apr 2019 17:24:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556144696;
        bh=XC9DUfP/ZASD82wmKHrnFgq/h5W+J7IDXLFpWqgB6W8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=OLpRKtISByWP5nv6f17dmxKkxmnq4RAomm+9N2iAiZAEf/SJtf2JBNWq1OtZW5cy4
         nCwAqvgNad7iVR9ahZ1XlRyYsHwNZrn7UDCtDK3yOkGww5Aaf1CdJjGjuGAfccseDI
         TryHqz0+GZXX1Nw0vS0m+NqSJFPv8cIXKmTzCZ0s=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3OMOuMp038532
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Apr 2019 17:24:56 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 24
 Apr 2019 17:24:55 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 24 Apr 2019 17:24:55 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3OMOsBX035553;
        Wed, 24 Apr 2019 17:24:55 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     <netdev@vger.kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Jiri Pirko <jiri@resnulli.us>
CC:     Florian Fainelli <f.fainelli@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Ivan Vecera <ivecera@redhat.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [RFC PATCH v3 net-next 11/11] ARM: dts: am57xx-idk: add dt nodes for new cpsw switch dev driver
Date:   Thu, 25 Apr 2019 01:24:27 +0300
Message-ID: <1556144667-27997-12-git-send-email-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556144667-27997-1-git-send-email-grygorii.strashko@ti.com>
References: <1556144667-27997-1-git-send-email-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT nodes for new cpsw switch dev driver.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/boot/dts/am571x-idk.dts         | 28 +++++++++++++
 arch/arm/boot/dts/am57xx-idk-common.dtsi |  2 +-
 arch/arm/boot/dts/dra7-l4.dtsi           | 53 ++++++++++++++++++++++++
 3 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am571x-idk.dts b/arch/arm/boot/dts/am571x-idk.dts
index 6432309b39e3..6ec02be9d80b 100644
--- a/arch/arm/boot/dts/am571x-idk.dts
+++ b/arch/arm/boot/dts/am571x-idk.dts
@@ -194,3 +194,31 @@
 	pinctrl-1 = <&mmc2_pins_hs>;
 	pinctrl-2 = <&mmc2_pins_ddr_rev20 &mmc2_iodelay_ddr_conf>;
 };
+
+&mac_sw {
+	pinctrl-names = "default", "sleep";
+	status = "okay";
+};
+
+&cpsw_port1 {
+	phy-handle = <&ethphy0_sw>;
+	phy-mode = "rgmii";
+	dual_emac_res_vlan = <1>;
+};
+
+&cpsw_port2 {
+	phy-handle = <&ethphy1_sw>;
+	phy-mode = "rgmii";
+	dual_emac_res_vlan = <2>;
+};
+
+&davinci_mdio_sw {
+	ethphy0_sw: ethernet-phy@0 {
+		reg = <0>;
+	};
+
+	ethphy1_sw: ethernet-phy@1 {
+		reg = <1>;
+	};
+};
+
diff --git a/arch/arm/boot/dts/am57xx-idk-common.dtsi b/arch/arm/boot/dts/am57xx-idk-common.dtsi
index f7bd26458915..5c7663699efa 100644
--- a/arch/arm/boot/dts/am57xx-idk-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-idk-common.dtsi
@@ -367,7 +367,7 @@
 };
 
 &mac {
-	status = "okay";
+//	status = "okay";
 	dual_emac;
 };
 
diff --git a/arch/arm/boot/dts/dra7-l4.dtsi b/arch/arm/boot/dts/dra7-l4.dtsi
index 414f1cd68733..c17c506b51e6 100644
--- a/arch/arm/boot/dts/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/dra7-l4.dtsi
@@ -3122,6 +3122,59 @@
 					phys = <&phy_gmii_sel 2>;
 				};
 			};
+
+			mac_sw: ethernet_switch@0 {
+				compatible = "ti,dra7-cpsw-switch","ti,cpsw-switch";
+				reg = <0x0 0x4000>;
+				ranges = <0 0 0x4000>;
+				clocks = <&gmac_main_clk>;
+				clock-names = "fck";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				syscon = <&scm_conf>;
+				status = "disabled";
+
+				interrupts = <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "rx_thresh", "rx", "tx", "misc";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					cpsw_port1: port@1 {
+						reg = <1>;
+						ti,label = "port1";
+						/* Filled in by U-Boot */
+						mac-address = [ 00 00 00 00 00 00 ];
+						phys = <&phy_gmii_sel 1>;
+					};
+
+					cpsw_port2: port@2 {
+						reg = <2>;
+						ti,label = "port2";
+						/* Filled in by U-Boot */
+						mac-address = [ 00 00 00 00 00 00 ];
+						phys = <&phy_gmii_sel 2>;
+					};
+				};
+
+				davinci_mdio_sw: mdio@1000 {
+					compatible = "ti,cpsw-mdio","ti,davinci_mdio";
+					#address-cells = <1>;
+					#size-cells = <0>;
+					ti,hwmods = "davinci_mdio";
+					bus_freq = <1000000>;
+					reg = <0x1000 0x100>;
+				};
+
+				cpts {
+					clocks = <&gmac_clkctrl DRA7_GMAC_GMAC_CLKCTRL 25>;
+					clock-names = "cpts";
+				};
+			};
 		};
 	};
 };
-- 
2.17.1

