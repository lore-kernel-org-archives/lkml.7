Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF15CC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E52206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="q1e/dUvD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbgAIOCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 09:02:33 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44822 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731414AbgAIOCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 09:02:32 -0500
Received: by mail-wr1-f65.google.com with SMTP id q10so7475979wrm.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 06:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DhI3OrQE978IeGvYgeHUGeY+2EytoVG3JIxosQ7S0uM=;
        b=q1e/dUvDF5SwCkBSTmdDLuBJ4Wf3yj1t2FDmQz4FjaMyXo1uUixu59+C+93seyRo8+
         mkbS5SUrRC9OO3HByXA9KHVds6Bgdndwexx+fzNLALdDrtPuYL1Gr9PKsnB9iN2IN80Q
         iUwxJu15Zlia4DNkOkqCHVGmkJVu7vttMztitsO+SiHbT8RacVPIkZ3z+6y1WlyoRnVB
         FHIFsRsfApT14glNH/DAg8WTmZyaOnNgtRGbABY6RAWNZBd+tZmYhf/3TOWYN7Ah56Ot
         o1WniFhkij0fzxcj3nm4Y8RXu4Ts6SXSJm5u/st5Z+FpxRPP/issLnh2FI+UJAqZldZM
         A/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=DhI3OrQE978IeGvYgeHUGeY+2EytoVG3JIxosQ7S0uM=;
        b=RFIDD1AHTzntCP+a/NOfuHaGw9GHjw/ue72m6oKjv9lkb0RgzAD4c+bqRlrr4V6JbC
         Xxi3eHgWg1ZgZuWbhNXqcbrpNbEV8c0+Vq+//KQO6ERjylqZaO/Ak+5c0U9EZdu4qnjn
         gptG833dpzMk/lWV3vr2bI4qBTt836QQlJFGmM234mIGBo8zMgNWNeWFW8/9tQ2fgU1q
         8Qj0nwZH+lNNlddK/c7Xtbr1PVQR7A0DlCmf5BAzyXWDI9lpQr3zbWWWnnevmlzBO34x
         TLH5X85VJsFg7L89/TJw1XiIrEzYCmNnkFc1Uoc+ggouORFgIbAn1EeXOzNAOyN1rtpy
         GiCw==
X-Gm-Message-State: APjAAAVHUDEKgc0xBNPsVANzvsn1RlJ1t57WkOrr5C0nS1HHc7qbAKdL
        R/ZQQV+BhNZJ+joDavTo0vGZqQ==
X-Google-Smtp-Source: APXvYqxicSUIyD6DM92gqQMlGx6+Yh1zxSYrFW/HOYZapL4yyPGgk4+gp4fqtd/WsIK+tSupGCCd7A==
X-Received: by 2002:a5d:5592:: with SMTP id i18mr10529597wrv.55.1578578550404;
        Thu, 09 Jan 2020 06:02:30 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id k82sm3099143wmf.10.2020.01.09.06.02.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Jan 2020 06:02:29 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-arm-kernel@lists.infradead.org, git@xilinx.com
Cc:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Harini Katakam <harini.katakam@xilinx.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Venkatesh Yadav Abbarapu <venkatesh.abbarapu@xilinx.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] arm64: zynqmp: Enable iio-hwmon for ina226 on zcu111
Date:   Thu,  9 Jan 2020 15:02:16 +0100
Message-Id: <cca3e4bbc5441bca051f274fe19c3328f0027eca.1578578535.git.michal.simek@xilinx.com>
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

 .../boot/dts/xilinx/zynqmp-zcu111-revA.dts    | 99 ++++++++++++++++---
 1 file changed, 85 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
index cb2e46833a7b..df2bc5a41c8d 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
@@ -59,6 +59,63 @@ heartbeat-led {
 			linux,default-trigger = "heartbeat";
 		};
 	};
+
+	ina226-u67 {
+		compatible = "iio-hwmon";
+		io-channels = <&u67 0>, <&u67 1>, <&u67 2>, <&u67 3>;
+	};
+	ina226-u59 {
+		compatible = "iio-hwmon";
+		io-channels = <&u59 0>, <&u59 1>, <&u59 2>, <&u59 3>;
+	};
+	ina226-u61 {
+		compatible = "iio-hwmon";
+		io-channels = <&u61 0>, <&u61 1>, <&u61 2>, <&u61 3>;
+	};
+	ina226-u60 {
+		compatible = "iio-hwmon";
+		io-channels = <&u60 0>, <&u60 1>, <&u60 2>, <&u60 3>;
+	};
+	ina226-u64 {
+		compatible = "iio-hwmon";
+		io-channels = <&u64 0>, <&u64 1>, <&u64 2>, <&u64 3>;
+	};
+	ina226-u69 {
+		compatible = "iio-hwmon";
+		io-channels = <&u69 0>, <&u69 1>, <&u69 2>, <&u69 3>;
+	};
+	ina226-u66 {
+		compatible = "iio-hwmon";
+		io-channels = <&u66 0>, <&u66 1>, <&u66 2>, <&u66 3>;
+	};
+	ina226-u65 {
+		compatible = "iio-hwmon";
+		io-channels = <&u65 0>, <&u65 1>, <&u65 2>, <&u65 3>;
+	};
+	ina226-u63 {
+		compatible = "iio-hwmon";
+		io-channels = <&u63 0>, <&u63 1>, <&u63 2>, <&u63 3>;
+	};
+	ina226-u3 {
+		compatible = "iio-hwmon";
+		io-channels = <&u3 0>, <&u3 1>, <&u3 2>, <&u3 3>;
+	};
+	ina226-u71 {
+		compatible = "iio-hwmon";
+		io-channels = <&u71 0>, <&u71 1>, <&u71 2>, <&u71 3>;
+	};
+	ina226-u77 {
+		compatible = "iio-hwmon";
+		io-channels = <&u77 0>, <&u77 1>, <&u77 2>, <&u77 3>;
+	};
+	ina226-u73 {
+		compatible = "iio-hwmon";
+		io-channels = <&u73 0>, <&u73 1>, <&u73 2>, <&u73 3>;
+	};
+	ina226-u79 {
+		compatible = "iio-hwmon";
+		io-channels = <&u79 0>, <&u79 1>, <&u79 2>, <&u79 3>;
+	};
 };
 
 &dcc {
@@ -152,73 +209,87 @@ i2c@0 {
 			reg = <0>;
 			/* PS_PMBUS */
 			/* PMBUS_ALERT done via pca9544 */
-			ina226@40 { /* u67 */
+			u67: ina226@40 { /* u67 */
 				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
 				reg = <0x40>;
 				shunt-resistor = <2000>;
 			};
-			ina226@41 { /* u59 */
+			u59: ina226@41 { /* u59 */
 				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
 				reg = <0x41>;
 				shunt-resistor = <5000>;
 			};
-			ina226@42 { /* u61 */
+			u61: ina226@42 { /* u61 */
 				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
 				reg = <0x42>;
 				shunt-resistor = <5000>;
 			};
-			ina226@43 { /* u60 */
+			u60: ina226@43 { /* u60 */
 				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
 				reg = <0x43>;
 				shunt-resistor = <5000>;
 			};
-			ina226@45 { /* u64 */
+			u64: ina226@45 { /* u64 */
 				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
 				reg = <0x45>;
 				shunt-resistor = <5000>;
 			};
-			ina226@46 { /* u69 */
+			u69: ina226@46 { /* u69 */
 				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
 				reg = <0x46>;
 				shunt-resistor = <2000>;
 			};
-			ina226@47 { /* u66 */
+			u66: ina226@47 { /* u66 */
 				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
 				reg = <0x47>;
 				shunt-resistor = <5000>;
 			};
-			ina226@48 { /* u65 */
+			u65: ina226@48 { /* u65 */
 				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
 				reg = <0x48>;
 				shunt-resistor = <5000>;
 			};
-			ina226@49 { /* u63 */
+			u63: ina226@49 { /* u63 */
 				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
 				reg = <0x49>;
 				shunt-resistor = <5000>;
 			};
-			ina226@4a { /* u3 */
+			u3: ina226@4a { /* u3 */
 				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
 				reg = <0x4a>;
 				shunt-resistor = <5000>;
 			};
-			ina226@4b { /* u71 */
+			u71: ina226@4b { /* u71 */
 				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
 				reg = <0x4b>;
 				shunt-resistor = <5000>;
 			};
-			ina226@4c { /* u77 */
+			u77: ina226@4c { /* u77 */
 				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
 				reg = <0x4c>;
 				shunt-resistor = <5000>;
 			};
-			ina226@4d { /* u73 */
+			u73: ina226@4d { /* u73 */
 				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
 				reg = <0x4d>;
 				shunt-resistor = <5000>;
 			};
-			ina226@4e { /* u79 */
+			u79: ina226@4e { /* u79 */
 				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
 				reg = <0x4e>;
 				shunt-resistor = <5000>;
 			};
-- 
2.24.0

