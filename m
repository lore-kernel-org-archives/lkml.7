Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5EAC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E02B21741
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxOkQmjm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbfDPPwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:52:23 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36761 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729828AbfDPPwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:52:20 -0400
Received: by mail-pl1-f195.google.com with SMTP id ck15so10564402plb.3;
        Tue, 16 Apr 2019 08:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EZlkp7v2nPP5nRORX7K5OgVFxZt9urg33Gk3NoY2n5g=;
        b=pxOkQmjmednVnlhEUX6XxMc7vKHyzyQ1fLY2Wc+3vLZSJkv/1tnKeZeHM0QzsgFDWE
         d39rp23dtjqupn0jSiUHEtXG8ljmOVYZ64S04u4pLZOaycS0F4gFnP538+H5hPpBDPKP
         PyFC9bDn1ZrFJ13JkLoipSfpoHQqlIXScRhyCL+4CwtDnU/uVmjVVG5EatEBKQucTLHc
         0ysGlnMHz3dFTBYlgJVXMeZG+ZBASGEw13TGTwsUO8teTvjGBeQNGM3jRDky85JJncLT
         luPHH0SOnDN7aQCogVunLZnq3DgbJjjldZ3fLBVdbg0SqQXS+dkgCisK/3vYMpRgqEjF
         AJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EZlkp7v2nPP5nRORX7K5OgVFxZt9urg33Gk3NoY2n5g=;
        b=oA5hk06qZG0FwEIqX9i1t8mB9gYHUHMzIzUT9O7wi28TkhCaviTpW01HcbhLG0bvnV
         TEQgpUDoHN/4eSofk3ECvM4d7WNxXkEdXCH0EHL6QZKDNgvaRyHG9vXzBx0nzYAMVlTt
         FW2ooXsjgE2vJ2V28bLZmmTO2WvusbbI9HozCMlSylaqHlRu0Y/FBFU2Lai2bTTaH1dF
         N8W7ruKrtA4MBZGmEOfSovT/1csvmsKM9Ob4ypPc2FVk++ZGHrIiqM69+NXDY1bbuYd5
         i752DFSyD5F5FjA+leZjeyqPCwrleRfsrqNKfq+ScN8yEmxrkuQjyAM5z+Fzaic7pV7r
         drNw==
X-Gm-Message-State: APjAAAXxQHegc93xzaug8LtCQryXjPkrDrBCLS2HAxei17KPdaujrhnL
        RqvTFP5r66B4i0g2EIs4hxc=
X-Google-Smtp-Source: APXvYqzRb9kvwHuv7VDLrxoqyClEgyjaPcDfxDqMJTPxhK7bSica4VLun/ZHPBFmOapMIMr5/M7yJg==
X-Received: by 2002:a17:902:31c3:: with SMTP id x61mr80083887plb.143.1555429939450;
        Tue, 16 Apr 2019 08:52:19 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id l10sm76616289pfc.46.2019.04.16.08.52.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 08:52:18 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     tiny.windzz@gmail.com, vireshk@kernel.org, nm@ti.com,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, rjw@rjwysocki.net,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] dt-bindings: cpufreq: Document allwinner,sun50i-h6-operating-points
Date:   Tue, 16 Apr 2019 11:52:09 -0400
Message-Id: <20190416155209.24216-3-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190416155209.24216-1-tiny.windzz@gmail.com>
References: <20190416155209.24216-1-tiny.windzz@gmail.com>
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
			sun50iw-h6      speed0 speed1 speed2

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 .../bindings/opp/sun50i-nvmem-cpufreq.txt     | 167 ++++++++++++++++++
 1 file changed, 167 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt

diff --git a/Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt b/Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt
new file mode 100644
index 000000000000..3cb39c6caec3
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
+			sun50iw-h6	speed0 speed1 speed2
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

