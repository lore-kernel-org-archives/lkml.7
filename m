Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_RHS_DOB,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C17C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E8020652
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAu+Yxdr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388731AbfDRMzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:55:45 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34818 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733192AbfDRMzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 08:55:45 -0400
Received: by mail-pf1-f195.google.com with SMTP id t21so1092524pfh.2;
        Thu, 18 Apr 2019 05:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SjTu5plE2NlAxWIp+e3fl4rcYf59I53Cno7zN1Eowns=;
        b=XAu+YxdrSA9A0EUeWtVv9bEsbdS8IXUiE0WEMjHma3jmT0UlLVV9+8WHqbD5cNqVgu
         XUdnJJ45klYqTILpWjcaxpf49iH9BL2fN4SNiRT12EyVZOKpEs8JDMg58PqkJlYXauEK
         G+1lTAMiVdpOWfUpggOnjiiIALqyABHqgZGU0a37gK8av+sVXu8+MsTkfyRgIWYNVNVO
         JnKalS4Wc3L8cCbsSgAloB01tAwgBQSuPH/QJSD80gN6hwRn1k7iCEuzuMEAn1fmQtBN
         XNyLv316DfF+IZWjbCCBGb+Hpv0kJ7Pb4EUNy95oUDEQGq2rCJanLwNWUopTCoXl9t8Q
         0PhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SjTu5plE2NlAxWIp+e3fl4rcYf59I53Cno7zN1Eowns=;
        b=EC8kkditaqyX56iPAb1nQORnkURhABHDBDpFWhDhSTxNoxpUC+O82lA++H8kFUewud
         5v7lut6ulQIDHXGEypw5ih0RIwm1RkWDlRoRZ+EIJQRyNaItYHHqZBAldWY6+dF4zmQS
         mz8iGQVx3eTz5ML1NgqgG6y1x3Ol19bUxmbqOQicg4h30UwIKQqMHJTxa+ALCSZxDbZU
         HCiGF912c6W76RZEqaJ/s3HjH/nAoStBNIxEGssxCdfONdPdD5udBJfKP8yxzuyhr5yI
         d/j1GVZ1jf2KcJ9dZ7ADR9Yz3HkfKSPf0RzTZmduxCMwKMcSnktc/bymD74x3Sygywyl
         THNg==
X-Gm-Message-State: APjAAAWliwqMFgbQ1EvtM9aaW/QAlWZQoMj1rGQx5iTe9HGCb4uSaoFb
        Yaq7TKYN8CFjZrX9EQIVB64=
X-Google-Smtp-Source: APXvYqyRMg/vL58E1BswMJ4LVwNg05QdIiS71tTIWpmbw5Q3sO+UmidJj+dIsfRYhPvL2jnlUYIqFA==
X-Received: by 2002:a63:750c:: with SMTP id q12mr89903740pgc.133.1555592143840;
        Thu, 18 Apr 2019 05:55:43 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id w3sm3040210pfn.179.2019.04.18.05.55.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 05:55:42 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     tiny.windzz@gmail.com, vireshk@kernel.org, nm@ti.com,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESEND] dt-bindings: cpufreq: Document allwinner,sun50i-h6-operating-points
Date:   Thu, 18 Apr 2019 08:55:38 -0400
Message-Id: <20190418125538.25722-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner Process Voltage Scaling Tables defines the voltage and
frequency value based on the speedbin blown in the efuse combination.
The sunxi-cpufreq-nvmem driver reads the efuse value from the SoC to
provide the OPP framework with required information.
This is used to determine the voltage and frequency value for each
OPP of operating-points-v2 table when it is parsed by the OPP framework.

The "allwinner,sun50i-h6-operating-points" DT extends the
"operating-points-v2"
with following parameters:
- nvmem-cells (NVMEM area containig the speedbin information)
- opp-microvolt-<name>: voltage in micro Volts.
  At runtime, the platform can pick a <name> and matching
  opp-microvolt-<name> property.
			HW:		<name>:
			sun50i-h6      speed0 speed1 speed2

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
just fix a typo:
sun50iw-h6 -> sun50i-h6

This patch is [2/2].
for [1/2]:
https://patchwork.kernel.org/patch/10903381/
---
 .../bindings/opp/sun50i-nvmem-cpufreq.txt     | 167 ++++++++++++++++++
 1 file changed, 167 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt

diff --git a/Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt b/Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt
new file mode 100644
index 000000000000..7deae57a587b
--- /dev/null
+++ b/Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt
@@ -0,0 +1,167 @@
+Allwinner Technologies, Inc. NVMEM CPUFreq and OPP bindings
+===================================
+
+For some SoCs, the CPU frequency subset and voltage value of each OPP
+varies based on the silicon variant in use. Allwinner Process Voltage
+Scaling Tables defines the voltage and frequency value based on the
+speedbin blown in the efuse combination. The sun50i-cpufreq-nvmem driver
+reads the efuse value from the SoC to provide the OPP framework with
+required information.
+
+Required properties:
+--------------------
+In 'cpus' nodes:
+- operating-points-v2: Phandle to the operating-points-v2 table to use.
+
+In 'operating-points-v2' table:
+- compatible: Should be
+	- 'allwinner,sun50i-h6-operating-points'.
+- nvmem-cells: A phandle pointing to a nvmem-cells node representing the
+		efuse registers that has information about the speedbin
+		that is used to select the right frequency/voltage value
+		pair. Please refer the for nvmem-cells bindings
+		Documentation/devicetree/bindings/nvmem/nvmem.txt and
+		also examples below.
+
+In every OPP node:
+- opp-microvolt-<name>: Voltage in micro Volts.
+			At runtime, the platform can pick a <name> and
+			matching opp-microvolt-<name> property.
+			[See: opp.txt]
+			HW:		<name>:
+			sun50i-h6	speed0 speed1 speed2
+
+Example 1:
+---------
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <0>;
+			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
+		};
+
+		cpu1: cpu@1 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <1>;
+			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
+		};
+
+		cpu2: cpu@2 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <2>;
+			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
+		};
+
+		cpu3: cpu@3 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <3>;
+			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
+		};
+        };
+
+        cpu_opp_table: opp_table {
+                compatible = "allwinner,sun50i-h6-operating-points";
+                nvmem-cells = <&speedbin_efuse>;
+                opp-shared;
+
+                opp@480000000 {
+                        clock-latency-ns = <244144>; /* 8 32k periods */
+                        opp-hz = /bits/ 64 <480000000>;
+
+                        opp-microvolt-speed0 = <880000>;
+                        opp-microvolt-speed1 = <820000>;
+                        opp-microvolt-speed2 = <800000>;
+                };
+
+                opp@720000000 {
+                        clock-latency-ns = <244144>; /* 8 32k periods */
+                        opp-hz = /bits/ 64 <720000000>;
+
+                        opp-microvolt-speed0 = <880000>;
+                        opp-microvolt-speed1 = <820000>;
+                        opp-microvolt-speed2 = <800000>;
+                };
+
+                opp@816000000 {
+                        clock-latency-ns = <244144>; /* 8 32k periods */
+                        opp-hz = /bits/ 64 <816000000>;
+
+                        opp-microvolt-speed0 = <880000>;
+                        opp-microvolt-speed1 = <820000>;
+                        opp-microvolt-speed2 = <800000>;
+                };
+
+                opp@888000000 {
+                        clock-latency-ns = <244144>; /* 8 32k periods */
+                        opp-hz = /bits/ 64 <888000000>;
+
+                        opp-microvolt-speed0 = <940000>;
+                        opp-microvolt-speed1 = <820000>;
+                        opp-microvolt-speed2 = <800000>;
+                };
+
+                opp@1080000000 {
+                        clock-latency-ns = <244144>; /* 8 32k periods */
+                        opp-hz = /bits/ 64 <1080000000>;
+
+                        opp-microvolt-speed0 = <1060000>;
+                        opp-microvolt-speed1 = <880000>;
+                        opp-microvolt-speed2 = <840000>;
+                };
+
+                opp@1320000000 {
+                        clock-latency-ns = <244144>; /* 8 32k periods */
+                        opp-hz = /bits/ 64 <1320000000>;
+
+                        opp-microvolt-speed0 = <1160000>;
+                        opp-microvolt-speed1 = <940000>;
+                        opp-microvolt-speed2 = <900000>;
+                };
+
+                opp@1488000000 {
+                        clock-latency-ns = <244144>; /* 8 32k periods */
+                        opp-hz = /bits/ 64 <1488000000>;
+
+                        opp-microvolt-speed0 = <1160000>;
+                        opp-microvolt-speed1 = <1000000>;
+                        opp-microvolt-speed2 = <960000>;
+                };
+        };
+....
+soc {
+....
+	sid: sid@3006000 {
+		compatible = "allwinner,sun50i-h6-sid";
+		reg = <0x03006000 0x400>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		....
+		speedbin_efuse: speed@1c {
+			reg = <0x1c 4>;
+		};
+        };
+};
-- 
2.17.0

