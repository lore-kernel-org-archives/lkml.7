Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8286C2D0CE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 11:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C24F20730
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 11:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="OzmW10V0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfL3LOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 06:14:41 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:19469 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbfL3LOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 06:14:37 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e09dc0f0000>; Mon, 30 Dec 2019 03:14:23 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 30 Dec 2019 03:14:37 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 30 Dec 2019 03:14:37 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 30 Dec
 2019 11:14:36 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 30 Dec 2019 11:14:36 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.64.167]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e09dc190000>; Mon, 30 Dec 2019 03:14:36 -0800
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [Patch V3 16/18] arm64: tegra: Enable xudc on Jetson TX1
Date:   Mon, 30 Dec 2019 16:39:53 +0530
Message-ID: <1577704195-2535-17-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1577704195-2535-1-git-send-email-nkristam@nvidia.com>
References: <1577704195-2535-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1577704463; bh=3jJDWYYlj/jZ+F+AIylDEpfSTDgOpZzuxpUrZjV98vo=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=OzmW10V0PTMXG3iosCIwetX1BWMPHygBoMCtdn/wgzKnYXVfXy7BOz1Sh+jZtpRXG
         ihcJze7rzWQVEHQ0ZiFZdclMY0R5YlehEFe1jqJu+1ZFp+7J0pa7EJKSBtwGaPYrF6
         V1uTycyODdpNymKB0ev9VFF7qa7UhOpppmnOMLvK+RvSaNktAvnJKaXsRM4dpZHlvW
         F318FVPDfpEBQHpp2eZLQCdmxKZTMbyGfcMlc7ZtNQX0CBfVqLpbLoT/PRQLVRFZbF
         QAmMQytShgSb92uSspKO+K7Ab9erUQVgYnUfOTqc4AAPCn4hzJqugzcBp9SZRrI4ou
         j/9Sy6w1qZCZA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable XUSB device mode driver for USB 2-0 slot on Jetson TX1.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
---
V2-V3:
 - No changes in this version
---
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
index 18c0610..49a2a82 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
@@ -1361,7 +1361,7 @@
 				status = "okay";
 
 				lanes {
-					usb2-0 {
+					micro_b: usb2-0 {
 						nvidia,function = "xusb";
 						status = "okay";
 					};
@@ -1494,6 +1494,14 @@
 		vmmc-supply = <&vdd_3v3_sd>;
 	};
 
+	usb@700d0000 {
+		status = "okay";
+		phys = <&micro_b>;
+		phy-names = "usb2-0";
+		avddio-usb-supply = <&vdd_3v3_sys>;
+		hvdd-usb-supply = <&vdd_1v8>;
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.7.4

