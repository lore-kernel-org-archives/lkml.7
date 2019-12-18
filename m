Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCAAC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50674227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="o6jBUFRZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfLRJSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 04:18:08 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19223 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbfLRJSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 04:18:05 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5df9eec30000>; Wed, 18 Dec 2019 01:17:55 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 18 Dec 2019 01:18:04 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 18 Dec 2019 01:18:04 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Dec
 2019 09:18:04 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Dec
 2019 09:18:04 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 18 Dec 2019 09:18:03 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.64.167]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5df9eec80001>; Wed, 18 Dec 2019 01:18:03 -0800
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Nagarjuna Kristam" <nkristam@nvidia.com>
Subject: [Patch V2 18/18] arm64: tegra: Enable xudc node on Jetson TX2
Date:   Wed, 18 Dec 2019 14:46:31 +0530
Message-ID: <1576660591-10383-19-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576660591-10383-1-git-send-email-nkristam@nvidia.com>
References: <1576660591-10383-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1576660675; bh=C0/bPP0Si3PtUhAyH7cgK7xLOGsgAQRhZLX5XyQMzOw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=o6jBUFRZeK3IbYOcO/xQ1f9M5+S2XxnTDQREu+Ww6GRNRsCn930i8uxIIIbYildVV
         t4avTNOBTqnhKFCcUytkRqHGHAs65+MTuvQMqo/3PX9TCDWZrqKGAqrWEbnHMwK11L
         YclP4wHgyfJE3Ft2GonFeFwJosJWUQ/esLLo68CZM7PNuzxX/IehRiZhzjWQ3Vajml
         akI4edBhPbaHbkrM6b7HFAXVfOJYYyWP6gsvM8pU092NOznaTCgPQIwnjeGI8FotBs
         5+QqHEb9eNqAMPhckql6fhfsR4KeXF9sNZaapzWu5RfhG7pbhsbrtCGWIo+t/0MVzc
         gO9gk8eLf1pOQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable XUSB device mode driver for USB 2-0 slot on Jetson TX2.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
---
V2:
 - No changes in this version
---
 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
index a1dcdb9..d7628f5 100644
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
@@ -213,6 +213,13 @@
 		phy-names = "usb2-0", "usb2-1", "usb3-0";
 	};
 
+	usb@3550000 {
+		status = "okay";
+
+		phys = <&micro_b>;
+		phy-names = "usb2-0";
+	};
+
 	i2c@c250000 {
 		/* carrier board ID EEPROM */
 		eeprom@57 {
-- 
2.7.4

