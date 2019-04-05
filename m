Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28763C10F0F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51D8217D7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oecTP5HL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731018AbfDEKZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 06:25:12 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44258 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730969AbfDEKZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 06:25:09 -0400
Received: by mail-pg1-f194.google.com with SMTP id i2so2833379pgj.11;
        Fri, 05 Apr 2019 03:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8IOHX4+GUan7OC0wrcdLOgof/PQ3ca/HDtjaOrmW7a8=;
        b=oecTP5HLzQI+0SgB98Ed+g0QrDKyJJyPwmoRGzPgHsxWzBqud6oB5Ju1w3g2tR0oO/
         ZooIvmmRyFbSwZC5vdr2WQry0uf4Orl8aFmV5lmhKU16xLyBBC0tjTfAFXSjFr+77YUL
         0rcVPStzqCcVTTVqmxalx1kKahmYY/yR0r3BNDj6c+klNIm1WPAO0JnOxJo/nYFaPr2u
         XkNCVjEB3ONfIsq/9AmCDs/sqL9zDEl5NvsRyD4HeSpltkoZo0TF3pN1dUg2XKUmJK1r
         Lxel3MtLGVX38DP/PpB0n+FjOr0IIsoZTNEsmpsc0HcZC8hYkq+1GGmkkSR9pQ0M3jcK
         jB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8IOHX4+GUan7OC0wrcdLOgof/PQ3ca/HDtjaOrmW7a8=;
        b=opF9kk5tztGUYbryxsJPAEuKptepOypb+iem/KADYxfABZ0KwN0hb13XgGJkZ3J93o
         TbHz58XQ3CqxZvxWHtFtQF1E+78ZGs4zyZa4RO1Fj7CdVOWS4tHIae2QEqUXfLESpkbr
         acVhs9fb3Z0HGqDSoVv8JpHoLHKqYbrQoD9dsK+YImefD/jK1FVT0c2uufMNfv1DtG4L
         /NIRGoV6sjcJ36dhd1Bvsnlot5GOLK2haZRKkhPtwXhp8nhd3NUf/bdlxr8LQ8/sxvVn
         XkcBpwbEdNbYReerK9rJaei0Hkp949/9NbMgfrk0FCGQD7ElnSSNUA9X9FJ8yhPZkT7h
         Y6lg==
X-Gm-Message-State: APjAAAWhTQgvBsrf2gBGeUhEHkY2P2NhQKO1dkeb7lGOxZeKMMfbpxxs
        G7lDc6CfM3u1V2NqaMu3r8k=
X-Google-Smtp-Source: APXvYqyMgESvPAphKUsGMaj5TAAVEnBBRRTiOazPn2sugHMbgyVRdcfSlHHlSyroYcaE3IZTUgJIBA==
X-Received: by 2002:aa7:9294:: with SMTP id j20mr11654641pfa.64.1554459908291;
        Fri, 05 Apr 2019 03:25:08 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id w11sm3850030pfi.37.2019.04.05.03.25.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 03:25:07 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     tiny.windzz@gmail.com, vireshk@kernel.org, nm@ti.com,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, rjw@rjwysocki.net,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: cpufreq: Document operating-points-v2-sunxi-cpu
Date:   Fri,  5 Apr 2019 06:24:55 -0400
Message-Id: <20190405102455.15311-3-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190405102455.15311-1-tiny.windzz@gmail.com>
References: <20190405102455.15311-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner Process Voltage Scaling Tables defines the voltage and
frequency value  based on the speedbin blown in the efuse combination.
The sunxi-cpufreq-nvmem driver reads the efuse value from the SoC to
provide the OPP framework with required information.
This is used to determine the voltage and frequency value for each
OPP of operating-points-v2 table when it is parsed by the OPP framework.

This change adds documentation for the DT bindings.
The "operating-points-v2-sunxi-cpu" DT extends the "operating-points-v2"
with following parameters:
- nvmem-cells (NVMEM area containig the speedbin information)
- opp-supported-hw: A single 32 bit bitmap value,
  representing compatible HW:
			0:      speedbin 0
			1:      speedbin 1
			2:      speedbin 2
			3-31:   unused

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 .../bindings/opp/sunxi-nvmem-cpufreq.txt      | 235 ++++++++++++++++++
 1 file changed, 235 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt

diff --git a/Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt b/Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt
new file mode 100644
index 000000000000..80201d4e5147
--- /dev/null
+++ b/Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt
@@ -0,0 +1,235 @@
+Allwinner Technologies, Inc. NVMEM CPUFreq and OPP bindings
+===================================
+
+For some SoCs, the CPU frequency subset and voltage value of each OPP
+varies based on the silicon variant in use. Allwinner Process Voltage
+Scaling Tables defines the voltage and frequency value  based on the
+speedbin blown in the efuse combination. The sunxi-cpufreq-nvmem driver
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
+	- 'operating-points-v2-sunxi-cpu'.
+- nvmem-cells: A phandle pointing to a nvmem-cells node representing the
+		efuse registers that has information about the
+		speedbin that is used to select the right frequency/voltage
+		value pair.
+		Please refer the for nvmem-cells
+		bindings Documentation/devicetree/bindings/nvmem/nvmem.txt
+		and also examples below.
+
+In every OPP node:
+- opp-supported-hw: A single 32 bit bitmap value, representing compatible HW.
+		    Bitmap:
+			0:	speedbin 0
+			1:	speedbin 1
+			2:	speedbin 2
+			3-31:	unused
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
+	cpu_opp_table: opp_table {
+		compatible = "operating-points-v2-sunxi-cpu";
+		nvmem-cells = <&speedbin_efuse>;
+		opp-shared;
+
+		opp-480000000-0 {
+			opp-hz = /bits/ 64 <480000000>;
+			opp-microvolt = <880000>;
+			opp-supported-hw = <0x1>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+		opp-720000000-0 {
+			opp-hz = /bits/ 64 <720000000>;
+			opp-microvolt = <880000>;
+			opp-supported-hw = <0x1>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+		opp-816000000-0 {
+			opp-hz = /bits/ 64 <816000000>;
+			opp-microvolt = <880000>;
+			opp-supported-hw = <0x1>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+		opp-888000000-0 {
+			opp-hz = /bits/ 64 <888000000>;
+			opp-microvolt = <940000>;
+			opp-supported-hw = <0x1>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+		opp-1080000000-0 {
+			opp-hz = /bits/ 64 <1080000000>;
+			opp-microvolt = <1060000>;
+			opp-supported-hw = <0x1>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+		opp-1320000000-0 {
+			opp-hz = /bits/ 64 <1320000000>;
+			opp-microvolt = <1160000>;
+			opp-supported-hw = <0x1>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+		opp-1488000000-0 {
+			opp-hz = /bits/ 64 <1488000000>;
+			opp-microvolt = <1160000>;
+			opp-supported-hw = <0x1>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp-480000000-1 {
+			opp-hz = /bits/ 64 <480000000>;
+			opp-microvolt = <820000>;
+			opp-supported-hw = <0x2>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+		opp-720000000-1 {
+			opp-hz = /bits/ 64 <720000000>;
+			opp-microvolt = <820000>;
+			opp-supported-hw = <0x2>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+		opp-816000000-1 {
+			opp-hz = /bits/ 64 <816000000>;
+			opp-microvolt = <820000>;
+			opp-supported-hw = <0x2>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+		opp-888000000-1 {
+			opp-hz = /bits/ 64 <888000000>;
+			opp-microvolt = <820000>;
+			opp-supported-hw = <0x2>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+		opp-1080000000-1 {
+			opp-hz = /bits/ 64 <1080000000>;
+			opp-microvolt = <880000>;
+			opp-supported-hw = <0x2>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+		opp-1320000000-1 {
+			opp-hz = /bits/ 64 <1320000000>;
+			opp-microvolt = <940000>;
+			opp-supported-hw = <0x2>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+		opp-1488000000-1 {
+			opp-hz = /bits/ 64 <1488000000>;
+			opp-microvolt = <1000000>;
+			opp-supported-hw = <0x2>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp-480000000-2 {
+			opp-hz = /bits/ 64 <480000000>;
+			opp-microvolt = <800000>;
+			opp-supported-hw = <0x4>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+		opp-720000000-2 {
+			opp-hz = /bits/ 64 <720000000>;
+			opp-microvolt = <800000>;
+			opp-supported-hw = <0x4>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+		opp-816000000-2 {
+			opp-hz = /bits/ 64 <816000000>;
+			opp-microvolt = <800000>;
+			opp-supported-hw = <0x4>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+		opp-888000000-2 {
+			opp-hz = /bits/ 64 <888000000>;
+			opp-microvolt = <800000>;
+			opp-supported-hw = <0x4>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+		opp-1080000000-2 {
+			opp-hz = /bits/ 64 <1080000000>;
+			opp-microvolt = <840000>;
+			opp-supported-hw = <0x4>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+		opp-1320000000-2 {
+			opp-hz = /bits/ 64 <1320000000>;
+			opp-microvolt = <900000>;
+			opp-supported-hw = <0x4>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+		opp-1488000000-2 {
+			opp-hz = /bits/ 64 <1488000000>;
+			opp-microvolt = <960000>;
+			opp-supported-hw = <0x4>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+	};
+
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

