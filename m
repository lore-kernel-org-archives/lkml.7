Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9ACC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6809B2084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbgVBwYT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfDIR0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:26:14 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39392 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfDIR0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:26:10 -0400
Received: by mail-pl1-f193.google.com with SMTP id a96so5123539pla.6;
        Tue, 09 Apr 2019 10:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j8MhABEWkWYRyjcFZHAWML0uI1F2U0tM8j3vgtNzpEA=;
        b=SbgVBwYTKAjSYKou+jTTE9KCdJbYc0fNBLoI7tCPe7DBiooVOUOnkuQVyKs2apq224
         8y05dkbV4L1vD4rJvxKWWn8pyu8U/RM+4Yq9el0laNG/vUNcKxPz8WFEice59PukldKr
         JDuPP173TDnxNncIl/3L+D0imqgXbxyz5cIY/qNDEhBMMq/qSWUFASgRYbs1pcet5YYV
         XJpZKvvNsP1JTf0Ul7HEqrMQ/ETqsJ/Ge92xn4jXDRf9OsCQvsfophIHIvjMExIIcbH0
         k7X3YVgUQvMZzyRKN0S47F1WvLtsjYWPOySi2tlK3dd0RDoSn6fKCaFA+vk97eEeghaQ
         9IAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j8MhABEWkWYRyjcFZHAWML0uI1F2U0tM8j3vgtNzpEA=;
        b=cr+ypgROEce9Jqgrmo6vLOz7clHezSFic7DnDhmUAbSRn1SjWMo7wwAtGykAKMvkwB
         cgEvLSWru0SwHlveyIaMIPOzsIEwMnff775Ak6mXoWaRwUWy2q1YdXqPxS8E05EL0OTS
         q0LT5BKcm2hR31JQD03qNd+JF/sekNx9Hb3Uce1XcV5WUEYX6cwT0d3C3Bfw+Qy5ZLeI
         exCo5hLaVzhL5sTbDBe++9sbteSfLjnMCpK4U48knk8A0LTZcC7hw5QMcXvEAWxscHkF
         hI6CPCiGNoohb/DleniYb+zd4ye1dILLGeMP+VP9CnEh43Tbj/WUDupQsnE8meSSHV4p
         nD2g==
X-Gm-Message-State: APjAAAW0hBofWm59092JbfVhz7vAmQ/l2P6wSiVfJqqrjbE4N2OOSUyz
        impulECQwVPnxMV+7VN92k4=
X-Google-Smtp-Source: APXvYqxLZZGdG1oy7QavG3FZE9+aeK8dWyzSqmkYrZHxf69Xgu4+0mCyoyA0W6jE5P0KjgKzTSY9MQ==
X-Received: by 2002:a17:902:681:: with SMTP id 1mr39055317plh.31.1554830769038;
        Tue, 09 Apr 2019 10:26:09 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id j5sm28421405pfe.15.2019.04.09.10.26.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 10:26:08 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     tiny.windzz@gmail.com, vireshk@kernel.org, nm@ti.com,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, rjw@rjwysocki.net,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] dt-bindings: cpufreq: Document operating-points-v2-sunxi-cpu
Date:   Tue,  9 Apr 2019 13:25:58 -0400
Message-Id: <20190409172558.18778-3-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409172558.18778-1-tiny.windzz@gmail.com>
References: <20190409172558.18778-1-tiny.windzz@gmail.com>
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

The "operating-points-v2-sunxi-cpu" DT extends the "operating-points-v2"
with following parameters:
- nvmem-cells (NVMEM area containig the speedbin information)
- opp-microvolt-<name>: voltage in micro Volts.
  At runtime, the platform can pick a <name> and matching
  opp-microvolt-<name> property

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 .../bindings/opp/sunxi-nvmem-cpufreq.txt      | 166 ++++++++++++++++++
 1 file changed, 166 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt

diff --git a/Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt b/Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt
new file mode 100644
index 000000000000..c81a2075b974
--- /dev/null
+++ b/Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt
@@ -0,0 +1,166 @@
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
+- opp-microvolt-<name>: Voltage in micro Volts.
+			At runtime, the platform can pick a <name> and
+			matching opp-microvolt-<name> property.
+			[See: opp.txt]
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
+                compatible = "operating-points-v2-sunxi-cpu";
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

