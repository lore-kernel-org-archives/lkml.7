Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD1FCA9EA3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A767721D7C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Tb9KsRI4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633124AbfJRJk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 05:40:26 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:13378 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442378AbfJRJjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 05:39:44 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5da988620000>; Fri, 18 Oct 2019 02:39:46 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 18 Oct 2019 02:39:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 18 Oct 2019 02:39:43 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Oct
 2019 09:39:42 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 18 Oct 2019 09:39:43 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.66.147]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5da9885c0000>; Fri, 18 Oct 2019 02:39:42 -0700
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [Patch V11 09/11] arm64: tegra: Enable xudc on Jetson TX2
Date:   Fri, 18 Oct 2019 15:08:14 +0530
Message-ID: <1571391496-20834-10-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571391496-20834-1-git-send-email-nkristam@nvidia.com>
References: <1571391496-20834-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1571391586; bh=E76RFg4hKivDlAPkzUSnSS0t3ggcoA3D3Vws4hzLjjg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Tb9KsRI4F6GdJb673V/8fUaaFpvEk2LLTUTumsQHvCxGoF1EHHmbd/fQCcKW4/ywW
         Gx4u8hReGcFkdxV1rUajMJO87TPKHK2nde48xTRJD950n1A85C1BMWwxkhS4G4TMT8
         Ubwaps6+i9WYBVnCHwwtkpQ21K1diVXwEMrvtqoDz1YOpgU8WPyNaeplO3mxKY1/sV
         tJBpxsOV6A5uC+Zii5J0lbqXQYueYnhPKPIkfn7VYKIJSup0b26S6SDXzUKeFqI7/b
         jNwGCvfsgTzLUwV9i2sfx07R2V4ZtExkKn63/brJXAkHlRtm3JwA/ezrqi6MWygZ0X
         Fao9l02MvRYLw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable XUSB device mode driver for USB0 slot on Jetson TX2.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts | 29 +++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
index 2e61957..b55de35 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
@@ -131,7 +131,7 @@
 				status = "okay";
 
 				lanes {
-					usb2-0 {
+					micro_b: usb2-0 {
 						nvidia,function = "xusb";
 						status = "okay";
 					};
@@ -201,6 +201,20 @@
 		phy-names = "usb2-0", "usb2-1", "usb3-0";
 	};
 
+	usb@3550000 {
+		status = "okay";
+
+		phys = <&micro_b>;
+		phy-names = "usb2";
+		usb-role-switch;
+
+		port {
+			usb_role_switch: endpoint {
+				remote-endpoint = <&usb_b_conn_ep>;
+			};
+		};
+	};
+
 	i2c@c250000 {
 		/* carrier board ID EEPROM */
 		eeprom@57 {
@@ -367,4 +381,17 @@
 			vin-supply = <&vdd_5v0_sys>;
 		};
 	};
+
+	usb_type_b: connector {
+		compatible = "usb-b-connector", "gpio-usb-b-connector";
+		label = "micro-USB";
+		type = "micro";
+		vbus-gpio = <&gpio TEGRA186_MAIN_GPIO(X, 7) GPIO_ACTIVE_LOW>;
+
+		port {
+			usb_b_conn_ep: endpoint {
+				remote-endpoint = <&usb_role_switch>;
+			};
+		};
+	};
 };
-- 
2.7.4

