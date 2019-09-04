Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894C0C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A98123400
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="TNVcfNBk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbfIDIYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 04:24:40 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:9702 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfIDIYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 04:24:39 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d6f74ca0000>; Wed, 04 Sep 2019 01:24:42 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 04 Sep 2019 01:24:38 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 04 Sep 2019 01:24:38 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Sep
 2019 08:24:38 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Sep
 2019 08:24:38 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 4 Sep 2019 08:24:38 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.65.118]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d6f74c30001>; Wed, 04 Sep 2019 01:24:37 -0700
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Nagarjuna Kristam" <nkristam@nvidia.com>
Subject: [Patch V8 6/8] arm64: tegra: Enable xudc on Jetson TX1
Date:   Wed, 4 Sep 2019 13:53:58 +0530
Message-ID: <1567585440-13751-7-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567585440-13751-1-git-send-email-nkristam@nvidia.com>
References: <1567585440-13751-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1567585482; bh=J9QMNc1pVBlMlGvavWsVQDg5Qo8DcYOWUp5aTYdVbv0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=TNVcfNBkPUBhO86Z+bWTx6E2MBmnP8PRbxgwlUjh7gVAdqYp0ra1cDLMkJCr/Z9OT
         /ooQqSe/EnqbHaKget/NNODUBnVudGG+fwW+brzP9KLCSJJ6XL6Ct+Ntzg5mI33Qei
         JazIhjrCpF7D8+Biz12E8F87TCM6xSexmqGBrsij+odL9x53GgSpG1lZlwcl5zaWut
         Fansxf7sVIqPLt/TW1lS9xUfb2okxamG1icVi1YxRq2B3XNqoVYoELwoup56Vx+ezh
         FApOhMKZvPixxaJDxEZr9AsfEEe3c5qo2FwQ+xwwmExRBRKvttM5YZwcA3nGX/5UZC
         4sfMAracMH/Uw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable XUSB device mode driver for USB0 slot on Jetson TX1.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
Reviewed-by: JC Kuo <jckuo@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi | 31 +++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
index a7dc319..6aba1ba 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
@@ -1362,7 +1362,7 @@
 				status = "okay";
 
 				lanes {
-					usb2-0 {
+					micro_b: usb2-0 {
 						nvidia,function = "xusb";
 						status = "okay";
 					};
@@ -1483,6 +1483,21 @@
 		vmmc-supply = <&vdd_3v3_sd>;
 	};
 
+	usb@700d0000 {
+		status = "okay";
+		phys = <&micro_b>;
+		phy-names = "usb2";
+		avddio-usb-supply = <&vdd_3v3_sys>;
+		hvdd-usb-supply = <&vdd_1v8>;
+		usb-role-switch;
+
+		port {
+			usb_role_switch: endpoint {
+				remote-endpoint = <&usb_b_conn_ep>;
+			};
+		};
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -1641,4 +1656,18 @@
 			linux,code = <KEY_VOLUMEUP>;
 		};
 	};
+
+	usb_type_b: connector {
+		compatible = "linux,usb-conn-gpio", "gpio-usb-b-connector";
+		label = "micro-USB";
+		type = "micro";
+		vbus-gpio = <&gpio TEGRA_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
+
+		port {
+			usb_b_conn_ep: endpoint {
+				remote-endpoint = <&usb_role_switch>;
+			};
+		};
+	};
+
 };
-- 
2.7.4

