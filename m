Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8649C4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 06:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C28842067B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 06:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="RGeK01Dv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbfIMGJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 02:09:24 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9577 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfIMGJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 02:09:22 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d7b32920000>; Thu, 12 Sep 2019 23:09:22 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 12 Sep 2019 23:09:21 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 12 Sep 2019 23:09:21 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 13 Sep
 2019 06:09:20 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 13 Sep
 2019 06:09:20 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 13 Sep 2019 06:09:20 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.65.118]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d7b328d0009>; Thu, 12 Sep 2019 23:09:20 -0700
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Nagarjuna Kristam" <nkristam@nvidia.com>
Subject: [Patch V9 6/8] arm64: tegra: Enable xudc on Jetson TX1
Date:   Fri, 13 Sep 2019 11:37:51 +0530
Message-ID: <1568354873-24073-7-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568354873-24073-1-git-send-email-nkristam@nvidia.com>
References: <1568354873-24073-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1568354962; bh=LgM5Q71EB8xrEoV3NbATo8O6W8tTMR6THMZBVCLx/LQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=RGeK01Dv0V65OPZC4qZ9SM+nGHra0ur8KIpNGytb+QVFHE0QywgMsEQIFD/Meu91j
         zluDy2+aYNoMr70V/r1Fg1P03QnxEbVxzJIxt7luMjU3Xhza5K+Ru0AIZNY9DZtJm0
         wFak39GWgRkSMxvn4yM9EzeiLYkF0W4cdgcbvdGj/HLwruZ3KoofVlgDJABB6E9dBK
         y+KZ41eLpC/ON0goiakcZu/cQ9mmYF25/NkZK+vAssDzlaLfSpQQFW5t+ya5RCa6Bg
         1kM2OoTb0aYLuQ5K5IpJEtXbuR+X481lAgzF50qmJUiCYgwfJER7rYE3YnBiugXbAy
         vkGL4hzwlPUeg==
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
index a7dc319..c1e106e 100644
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
+		compatible = "linux,usb-b-connector", "gpio-usb-b-connector";
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

