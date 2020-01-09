Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AEBC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7308B206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="lGddIunY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731445AbgAIOCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 09:02:38 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34219 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731416AbgAIOCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 09:02:37 -0500
Received: by mail-wr1-f67.google.com with SMTP id t2so7567563wrr.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 06:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dFM0D8p7bvZnuOxQ5bVI5Tzrv/0jemFLa7fTccdCztw=;
        b=lGddIunYoy80qEqXzeNVX2rKClqEwYE42HaO3QpDQ+kOd4s5B9DirCGC4FGCdeWpZe
         VBXfwz+Urj7ydlxkWfkwjatl5rUnY+h3rxqMDTFDemLoWSbxsU7aOpi8oTnlio9RFp2B
         mkkRcvpAyEy92f9/XfGLLQ/7b+mQ0TJoE4rb9k+0LpGda/i05jBw4LrseMDf5njruyl6
         50ZaE59eg8hgu4tukjRZG6+plcnlPQhqwlZO5xz1a+OxMp2w6jx+Yv7s9YWNnzkdfi79
         xDlhl7Twh7HHum7Vl48NoVpjX430sO1AqgQZu7cWFWwii9FjFR3WxqGKgdSvk6Ug1Mfa
         3k5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=dFM0D8p7bvZnuOxQ5bVI5Tzrv/0jemFLa7fTccdCztw=;
        b=eUVrlLvjC0l2z2iowkTroMDk1WZ42RqZruo5W2PQ+DErTJiNUOTM7G7a7SaeWRDjPb
         F5HGsOrFDkIgToTU8kSFbbLK1GHy44eoor8vopOygocCPnf0u7yNYmqq3PeF6OzwTinv
         ae0dE2qezAB8XHWuzv+6sAvN/zRkt/oq9rUtMw90AkGvEUK1aXce9D8H6VusbCD+dFwU
         PWX51yoYrpP2EDmaxnp44CfvxlTmIjAUjf61FUPilLdgk5+Uk1QieaOGFiXDAf2lvMxk
         dEsqez9nKrPnX+veO+OA1jCBKeLHi6mkKVOuLV7mEzIRf1DTJFiLDp2YS7taay4ASwOw
         /4TA==
X-Gm-Message-State: APjAAAVt7vmZ8Jhef3Ah7iBwVqOs2ZXVxQ4JDIhOMqrNvdmZAgZvvBML
        fx1WEU1OUd6N/iQX5GL/rFM4zg==
X-Google-Smtp-Source: APXvYqwMs4WMiqPC7BimXW28pVEhvqvwnzgTJTXr3SdZfArqjD5ERNYEEGPNBkq2z5G2dhfpHrCZfA==
X-Received: by 2002:adf:f8c8:: with SMTP id f8mr10724349wrq.331.1578578553552;
        Thu, 09 Jan 2020 06:02:33 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id i5sm8295074wrv.34.2020.01.09.06.02.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Jan 2020 06:02:32 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-arm-kernel@lists.infradead.org, git@xilinx.com
Cc:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Harini Katakam <harini.katakam@xilinx.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] arm64: zynqmp: Enable iio-hwmon for ina226 on zcu102
Date:   Thu,  9 Jan 2020 15:02:18 +0100
Message-Id: <f9055270522ccd43246a33dd22f5c74c13479bb4.1578578535.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1578578535.git.michal.simek@xilinx.com>
References: <cover.1578578535.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ina226 hwmon driver is deprecated and it is recommended to use new iio
based driver. The patch is enabling iio-hwmon driver to export
functionality from IIO to hwmon interface to be able to use lm-sensors
package.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    | 127 +++++++++++++++---
 1 file changed, 109 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index 845671447f60..afdd0ff37900 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -59,6 +59,79 @@ heartbeat-led {
 			linux,default-trigger = "heartbeat";
 		};
 	};
+
+	ina226-u76 {
+		compatible = "iio-hwmon";
+		io-channels = <&u76 0>, <&u76 1>, <&u76 2>, <&u76 3>;
+	};
+	ina226-u77 {
+		compatible = "iio-hwmon";
+		io-channels = <&u77 0>, <&u77 1>, <&u77 2>, <&u77 3>;
+	};
+	ina226-u78 {
+		compatible = "iio-hwmon";
+		io-channels = <&u78 0>, <&u78 1>, <&u78 2>, <&u78 3>;
+	};
+	ina226-u87 {
+		compatible = "iio-hwmon";
+		io-channels = <&u87 0>, <&u87 1>, <&u87 2>, <&u87 3>;
+	};
+	ina226-u85 {
+		compatible = "iio-hwmon";
+		io-channels = <&u85 0>, <&u85 1>, <&u85 2>, <&u85 3>;
+	};
+	ina226-u86 {
+		compatible = "iio-hwmon";
+		io-channels = <&u86 0>, <&u86 1>, <&u86 2>, <&u86 3>;
+	};
+	ina226-u93 {
+		compatible = "iio-hwmon";
+		io-channels = <&u93 0>, <&u93 1>, <&u93 2>, <&u93 3>;
+	};
+	ina226-u88 {
+		compatible = "iio-hwmon";
+		io-channels = <&u88 0>, <&u88 1>, <&u88 2>, <&u88 3>;
+	};
+	ina226-u15 {
+		compatible = "iio-hwmon";
+		io-channels = <&u15 0>, <&u15 1>, <&u15 2>, <&u15 3>;
+	};
+	ina226-u92 {
+		compatible = "iio-hwmon";
+		io-channels = <&u92 0>, <&u92 1>, <&u92 2>, <&u92 3>;
+	};
+	ina226-u79 {
+		compatible = "iio-hwmon";
+		io-channels = <&u79 0>, <&u79 1>, <&u79 2>, <&u79 3>;
+	};
+	ina226-u81 {
+		compatible = "iio-hwmon";
+		io-channels = <&u81 0>, <&u81 1>, <&u81 2>, <&u81 3>;
+	};
+	ina226-u80 {
+		compatible = "iio-hwmon";
+		io-channels = <&u80 0>, <&u80 1>, <&u80 2>, <&u80 3>;
+	};
+	ina226-u84 {
+		compatible = "iio-hwmon";
+		io-channels = <&u84 0>, <&u84 1>, <&u84 2>, <&u84 3>;
+	};
+	ina226-u16 {
+		compatible = "iio-hwmon";
+		io-channels = <&u16 0>, <&u16 1>, <&u16 2>, <&u16 3>;
+	};
+	ina226-u65 {
+		compatible = "iio-hwmon";
+		io-channels = <&u65 0>, <&u65 1>, <&u65 2>, <&u65 3>;
+	};
+	ina226-u74 {
+		compatible = "iio-hwmon";
+		io-channels = <&u74 0>, <&u74 1>, <&u74 2>, <&u74 3>;
+	};
+	ina226-u75 {
+		compatible = "iio-hwmon";
+		io-channels = <&u75 0>, <&u75 1>, <&u75 2>, <&u75 3>;
+	};
 };
 
 &can1 {
@@ -177,53 +250,63 @@ i2c@0 {
 			#size-cells = <0>;
 			reg = <0>;
 			/* PS_PMBUS */
-			ina226@40 { /* u76 */
+			u76: ina226@40 { /* u76 */
 				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
 				reg = <0x40>;
 				shunt-resistor = <5000>;
 			};
-			ina226@41 { /* u77 */
+			u77: ina226@41 { /* u77 */
 				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
 				reg = <0x41>;
 				shunt-resistor = <5000>;
 			};
-			ina226@42 { /* u78 */
+			u78: ina226@42 { /* u78 */
 				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
 				reg = <0x42>;
 				shunt-resistor = <5000>;
 			};
-			ina226@43 { /* u87 */
+			u87: ina226@43 { /* u87 */
 				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
 				reg = <0x43>;
 				shunt-resistor = <5000>;
 			};
-			ina226@44 { /* u85 */
+			u85: ina226@44 { /* u85 */
 				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
 				reg = <0x44>;
 				shunt-resistor = <5000>;
 			};
-			ina226@45 { /* u86 */
+			u86: ina226@45 { /* u86 */
 				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
 				reg = <0x45>;
 				shunt-resistor = <5000>;
 			};
-			ina226@46 { /* u93 */
+			u93: ina226@46 { /* u93 */
 				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
 				reg = <0x46>;
 				shunt-resistor = <5000>;
 			};
-			ina226@47 { /* u88 */
+			u88: ina226@47 { /* u88 */
 				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
 				reg = <0x47>;
 				shunt-resistor = <5000>;
 			};
-			ina226@4a { /* u15 */
+			u15: ina226@4a { /* u15 */
 				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
 				reg = <0x4a>;
 				shunt-resistor = <5000>;
 			};
-			ina226@4b { /* u92 */
+			u92: ina226@4b { /* u92 */
 				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
 				reg = <0x4b>;
 				shunt-resistor = <5000>;
 			};
@@ -233,43 +316,51 @@ i2c@1 {
 			#size-cells = <0>;
 			reg = <1>;
 			/* PL_PMBUS */
-			ina226@40 { /* u79 */
+			u79: ina226@40 { /* u79 */
 				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
 				reg = <0x40>;
 				shunt-resistor = <2000>;
 			};
-			ina226@41 { /* u81 */
+			u81: ina226@41 { /* u81 */
 				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
 				reg = <0x41>;
 				shunt-resistor = <5000>;
 			};
-			ina226@42 { /* u80 */
+			u80: ina226@42 { /* u80 */
 				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
 				reg = <0x42>;
 				shunt-resistor = <5000>;
 			};
-			ina226@43 { /* u84 */
+			u84: ina226@43 { /* u84 */
 				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
 				reg = <0x43>;
 				shunt-resistor = <5000>;
 			};
-			ina226@44 { /* u16 */
+			u16: ina226@44 { /* u16 */
 				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
 				reg = <0x44>;
 				shunt-resistor = <5000>;
 			};
-			ina226@45 { /* u65 */
+			u65: ina226@45 { /* u65 */
 				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
 				reg = <0x45>;
 				shunt-resistor = <5000>;
 			};
-			ina226@46 { /* u74 */
+			u74: ina226@46 { /* u74 */
 				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
 				reg = <0x46>;
 				shunt-resistor = <5000>;
 			};
-			ina226@47 { /* u75 */
+			u75: ina226@47 { /* u75 */
 				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
 				reg = <0x47>;
 				shunt-resistor = <5000>;
 			};
-- 
2.24.0

