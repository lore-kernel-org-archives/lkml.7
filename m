Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B88C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14DE8206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="IGBpdmGy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731468AbgAIOCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 09:02:43 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37873 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731454AbgAIOCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 09:02:42 -0500
Received: by mail-wm1-f65.google.com with SMTP id f129so2971563wmf.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 06:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SqnmMkQEK4wShRkXHJYP8EzU5gVOo8rnm7WGaX4km1I=;
        b=IGBpdmGyAlrwpUXMO8unod8bBHFnSNXPaeyDOhV6wB6qgm8oSDcYYw5P2dBp25GhNC
         Ld2tCsRJ6qMQqvPdyxK0BnI54vRvfiFgA2sz2YtIF+FMBIoyLloOHN5TO9S5sQ2nERUF
         aLbnbyqnb1mlv26ne7kojB1SJdDBQ/obQ2X9B8/Y1xMShWkSxDPszVMrHQlNct+V14hh
         YM2S2aV0GpJdYrkpTYLIszEwgrI6TFqXRBdqiFVAIJeQn0mw2EQKgoDEAVPW1aezK4FY
         e4IZXzkhKO8H6EmBgs/kA8CdY2BWfc2oimjlzS/6Dqz9NiExngavRyUPOnk4LuLZSsSS
         /Ppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=SqnmMkQEK4wShRkXHJYP8EzU5gVOo8rnm7WGaX4km1I=;
        b=Zm0UjuzRDPu58FuCVYciNepD1GeNSHwlxAxMo59JLIiQcLhjzkjMKldEPsVBn/vWAR
         e6GqmlePlJChLPKeluxEzhCNJp0HOSpLb7jwELsvxvRK8k46cL5lLYf0u0mYd0DBJpei
         2Khx7qjz3P5Abl6UwUQQX7ObsAs44XVi6iggfV2yAFENbCE09CkYdLaQ61Gf7W4sTZwJ
         njHLh3X/9Ccmkka1sa3vW3bzzP4LcxSTAkikPJJA3z1myhUomxgrJnZ+a+KQtvrI/Rih
         iRzLG8VnQkTbY+mgW+UAc/QE6kW4YoTBaNueQLxNPlSQkVW71EK1q35V4+M7x0rTQCZo
         I9vw==
X-Gm-Message-State: APjAAAWGcpt12Rqel03Qf56JyxUOIdO6ntztCMhoJME26zlFRTG5wRS3
        4/an0biHptnfUeFDkVdeyruHhw==
X-Google-Smtp-Source: APXvYqxPU6RPEC+Y30lAr9qhmkcMeop+8IMsXQENU0eYqx/5WQbGJJd35xndpUF6O8I+Rel23WUEzg==
X-Received: by 2002:a05:600c:24d1:: with SMTP id 17mr5037154wmu.136.1578578559676;
        Thu, 09 Jan 2020 06:02:39 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id m10sm8238072wrx.19.2020.01.09.06.02.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Jan 2020 06:02:38 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-arm-kernel@lists.infradead.org, git@xilinx.com
Cc:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Harini Katakam <harini.katakam@xilinx.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] arm64: zynqmp: Enable iio-hwmon for ina226 on zcu106
Date:   Thu,  9 Jan 2020 15:02:20 +0100
Message-Id: <2c0200e7c802915389c23e27589ef29e97fb3b48.1578578535.git.michal.simek@xilinx.com>
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

 .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    | 127 +++++++++++++++---
 1 file changed, 109 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
index 822de6f04725..d136ce1fb07e 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
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

