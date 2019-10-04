Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FD2C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 08:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A8A21D81
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 08:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Sj/rpfsJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388638AbfJDIUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 04:20:11 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9863 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388566AbfJDIUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 04:20:04 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d9700b20000>; Fri, 04 Oct 2019 01:20:02 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 04 Oct 2019 01:20:02 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 04 Oct 2019 01:20:02 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 4 Oct
 2019 08:20:01 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 4 Oct 2019 08:20:01 +0000
Received: from jckuo-lt.nvidia.com (Not Verified[10.19.108.105]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d9700b00000>; Fri, 04 Oct 2019 01:20:01 -0700
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, <skomatineni@nvidia.com>,
        JC Kuo <jckuo@nvidia.com>
Subject: [PATCH v2 7/7] arm64: tegra: Enable XUSB host in P2972-0000 board
Date:   Fri, 4 Oct 2019 16:19:41 +0800
Message-ID: <20191004081941.4831-8-jckuo@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191004081941.4831-1-jckuo@nvidia.com>
References: <20191004081941.4831-1-jckuo@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1570177202; bh=Erbkds484JhNPrRLOYyEGFIbfjLX8oEulW7BxazUJQQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Sj/rpfsJNnGQPGJBMWbZB6HeaZgQ9rZUdaNTFGeQkRVmTp8ew2pWUjcCxMpYf7JW9
         jyCmQMS34CITD6fo27FjL7bJaPmIuVIiHph0c6wfczSL84aayAPrIRNOYe8f8AtSj+
         C2nujaLiGNlOJlXx3ILBgBqwN1mgGMH/TJcbk06SKnSyrTZdjwav3oUAm0DYUSnBW3
         8x+vOSzVRbJLYO1tdgZbjIUp8VnYT6L362kmMP9J9RloldM9ZPFQGLkcP/wQ80beKM
         VTHXpVMqXRo8bdb87jbsspKcXtjk6Xe3+1y0euwej+IdFLmssHq5pxkjsK8G0YSMLH
         CiydQhgp9u+tA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit enables XUSB host and pad controller in Tegra194
P2972-0000 board.

Signed-off-by: JC Kuo <jckuo@nvidia.com>
---
Changes in v2:
- use capitalization of regulator names
- fix gpio property of VDD_5V_SATA regulator

 .../arm64/boot/dts/nvidia/tegra194-p2888.dtsi | 36 ++++++++++-
 .../boot/dts/nvidia/tegra194-p2972-0000.dts   | 62 +++++++++++++++++++
 2 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
index 4c38426a6969..e7d5e8a30f93 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
@@ -66,6 +66,29 @@
 			vmmc-supply = <&vdd_emmc_3v3>;
 		};
 
+		padctl@3520000 {
+			avdd-usb-supply = <&vdd_usb_3v3>;
+			vclamp-usb-supply = <&vdd_1v8ao>;
+
+			ports {
+				usb2-1 {
+					vbus-supply = <&vdd_5v0_sys>;
+				};
+
+				usb2-3 {
+					vbus-supply = <&vdd_5v_sata>;
+				};
+
+				usb3-0 {
+					vbus-supply = <&vdd_5v0_sys>;
+				};
+
+				usb3-3 {
+					vbus-supply = <&vdd_5v0_sys>;
+				};
+			};
+		};
+
 		rtc@c2a0000 {
 			status = "okay";
 		};
@@ -229,7 +252,7 @@
 						regulator-max-microvolt = <3300000>;
 					};
 
-					ldo5 {
+					vdd_usb_3v3: ldo5 {
 						regulator-name = "VDD_USB_3V3";
 						regulator-min-microvolt = <3300000>;
 						regulator-max-microvolt = <3300000>;
@@ -313,5 +336,16 @@
 			regulator-boot-on;
 			enable-active-low;
 		};
+
+		vdd_5v_sata: regulator@4 {
+			compatible = "regulator-fixed";
+			reg = <4>;
+
+			regulator-name = "VDD_5V_SATA";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio TEGRA194_MAIN_GPIO(Z, 1) GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+		};
 	};
 };
diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
index d47cd8c4dd24..b60eef64c487 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
@@ -62,6 +62,68 @@
 							 GPIO_ACTIVE_LOW>;
 			};
 		};
+		padctl@3520000 {
+			status = "okay";
+
+			pads {
+				usb2 {
+					lanes {
+						usb2-1 {
+							status = "okay";
+						};
+
+						usb2-3 {
+							status = "okay";
+						};
+					};
+				};
+
+				usb3 {
+					lanes {
+						usb3-0 {
+							status = "okay";
+						};
+
+						usb3-3 {
+							status = "okay";
+						};
+					};
+				};
+			};
+
+			ports {
+				usb2-1 {
+					mode = "host";
+					status = "okay";
+				};
+
+				usb2-3 {
+					mode = "host";
+					status = "okay";
+				};
+
+				usb3-0 {
+					nvidia,usb2-companion = <1>;
+					status = "okay";
+				};
+
+				usb3-3 {
+					nvidia,usb2-companion = <3>;
+					nvidia,disable-gen2;
+					status = "okay";
+				};
+			};
+		};
+
+		usb@3610000 {
+			status = "okay";
+
+			phys =	<&{/cbb/padctl@3520000/pads/usb2/lanes/usb2-1}>,
+				<&{/cbb/padctl@3520000/pads/usb2/lanes/usb2-3}>,
+				<&{/cbb/padctl@3520000/pads/usb3/lanes/usb3-0}>,
+				<&{/cbb/padctl@3520000/pads/usb3/lanes/usb3-3}>;
+			phy-names = "usb2-1", "usb2-3", "usb3-0", "usb3-3";
+		};
 	};
 
 	pcie@14100000 {
-- 
2.17.1

