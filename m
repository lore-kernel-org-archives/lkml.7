Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5351CCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 05:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B1220700
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 05:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bO/k05Un"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfJUFNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 01:13:53 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39830 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfJUFNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 01:13:41 -0400
Received: by mail-pl1-f195.google.com with SMTP id s17so6018514plp.6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 22:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TUZl0CQoQvAGz2R73DjxhA8bWjAhSY1NW57V0Jxe4NI=;
        b=bO/k05UnZaFqlQEgKd+63jKIeXODX4aLp0fINJl4TXgACRAGQlMbTVkIUmrSnKo6J+
         hNbSe48arbeA3FlXnbwwtoBt1R/lcudXswWo0FohxhCsSc9BH+PA36Bne6TD1SC26Ohw
         aHQiz+9/4phpv5tf3uWsmQVXOIDjnN2tX416I1aVN/bYvUYCZrqWzA9iPZtWRKR+3J5L
         iz0bB0TReOQUyupAvRSfqanFgOZbzU0S6Hapgdcw9zwSg5IsPmUa3PBpZoYH5pPaHHq1
         y8Qwyg+FyEvQk3+Qq2939MERDBnJbixJhaPOO8PA+JQCFXLQ4hE4qU8D/L8LT6iHUL4o
         B2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TUZl0CQoQvAGz2R73DjxhA8bWjAhSY1NW57V0Jxe4NI=;
        b=QiDLqCpvsCciWFJVSDKhsSwgDRA1d2uwoU0Xu4q6auMS6AV9X2jqMYbosCmoXE9kSS
         ybfaCHull18G1vb4+ga+WEare7gbWiqfU4J+GUymcnkJIaCP17SfP72oxmphthOcl4xu
         pngt2COsOonKd6as+X41qaKO1eB1P+P85fDQ2S9QbDamJu8iZY1Wlj0HmAHKijGPE9NS
         n2P+UYOj1iNauR7EqA79isIcQsuUrFtcH892rvWkTjcSYHzfaA0uGTHnnpQax5VzCsE/
         kSCjx7xh1v9YxdThTKjr8xgPB7dcV0yZkSSyuF0yhvghV8WfYR5BGgVyijfolh7MPm7C
         pi7Q==
X-Gm-Message-State: APjAAAVrQbWBZhd8M9uqfVMkjkpqi3VIBIkNHP/32J8JBPkF4/9j/NHA
        us6RKZWMPFFn4mNgEqfbaDRR3A==
X-Google-Smtp-Source: APXvYqxHFVYvehDyXsUuIzAJU8rscWfF0SfrU4oKBNdzsLX4or7h4SlVfdlrA8cxq4zZUEhNtndAow==
X-Received: by 2002:a17:902:bf0a:: with SMTP id bi10mr23454681plb.56.1571634818221;
        Sun, 20 Oct 2019 22:13:38 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h68sm15716862pfb.149.2019.10.20.22.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2019 22:13:37 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] arm64: dts: qcom: msm8996: Sort all nodes in msm8996.dtsi
Date:   Sun, 20 Oct 2019 22:13:20 -0700
Message-Id: <20191021051322.297560-10-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191021051322.297560-1-bjorn.andersson@linaro.org>
References: <20191021051322.297560-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort all the nodes by unit address, then name.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 3716 ++++++++++++-------------
 1 file changed, 1856 insertions(+), 1860 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 6c1a6774396d..60fd8b238c32 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -16,72 +16,19 @@
 
 	chosen { };
 
-	memory {
-		device_type = "memory";
-		/* We expect the bootloader to fill in the reg */
-		reg = <0 0 0 0>;
-	};
-
-	reserved-memory {
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		mba_region: mba@91500000 {
-			reg = <0x0 0x91500000 0x0 0x200000>;
-			no-map;
-		};
-
-		slpi_region: slpi@90b00000 {
-			reg = <0x0 0x90b00000 0x0 0xa00000>;
-			no-map;
-		};
-
-		venus_region: venus@90400000 {
-			reg = <0x0 0x90400000 0x0 0x700000>;
-			no-map;
-		};
-
-		adsp_region: adsp@8ea00000 {
-			reg = <0x0 0x8ea00000 0x0 0x1a00000>;
-			no-map;
-		};
-
-		mpss_region: mpss@88800000 {
-			reg = <0x0 0x88800000 0x0 0x6200000>;
-			no-map;
-		};
-
-		smem_mem: smem-mem@86000000 {
-			reg = <0x0 0x86000000 0x0 0x200000>;
-			no-map;
-		};
-
-		memory@85800000 {
-			reg = <0x0 0x85800000 0x0 0x800000>;
-			no-map;
-		};
-
-		memory@86200000 {
-			reg = <0x0 0x86200000 0x0 0x2600000>;
-			no-map;
-		};
-
-		rmtfs@86700000 {
-			compatible = "qcom,rmtfs-mem";
-
-			size = <0x0 0x200000>;
-			alloc-ranges = <0x0 0xa0000000 0x0 0x2000000>;
-			no-map;
-
-			qcom,client-id = <1>;
-			qcom,vmid = <15>;
+	clocks {
+		xo_board: xo_board {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <19200000>;
+			clock-output-names = "xo_board";
 		};
 
-		zap_shader_region: gpu@8f200000 {
-			compatible = "shared-dma-pool";
-			reg = <0x0 0x90b00000 0x0 0xa00000>;
-			no-map;
+		sleep_clk: sleep_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32764>;
+			clock-output-names = "sleep_clk";
 		};
 	};
 
@@ -173,307 +120,109 @@
 		};
 	};
 
-	thermal-zones {
-		cpu0-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+	firmware {
+		scm {
+			compatible = "qcom,scm-msm8996";
+			qcom,dload-mode = <&tcsr 0x13000>;
+		};
+	};
 
-			thermal-sensors = <&tsens0 3>;
+	tcsr_mutex: hwlock {
+		compatible = "qcom,tcsr-mutex";
+		syscon = <&tcsr_mutex_regs 0 0x1000>;
+		#hwlock-cells = <1>;
+	};
 
-			trips {
-				cpu0_alert0: trip-point@0 {
-					temperature = <75000>;
-					hysteresis = <2000>;
-					type = "passive";
-				};
+	memory {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the reg */
+		reg = <0 0 0 0>;
+	};
 
-				cpu0_crit: cpu_crit {
-					temperature = <110000>;
-					hysteresis = <2000>;
-					type = "critical";
-				};
-			};
-		};
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
 
-		cpu1-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
 
-			thermal-sensors = <&tsens0 5>;
+		mba_region: mba@91500000 {
+			reg = <0x0 0x91500000 0x0 0x200000>;
+			no-map;
+		};
 
-			trips {
-				cpu1_alert0: trip-point@0 {
-					temperature = <75000>;
-					hysteresis = <2000>;
-					type = "passive";
-				};
+		slpi_region: slpi@90b00000 {
+			reg = <0x0 0x90b00000 0x0 0xa00000>;
+			no-map;
+		};
 
-				cpu1_crit: cpu_crit {
-					temperature = <110000>;
-					hysteresis = <2000>;
-					type = "critical";
-				};
-			};
+		venus_region: venus@90400000 {
+			reg = <0x0 0x90400000 0x0 0x700000>;
+			no-map;
 		};
 
-		cpu2-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+		adsp_region: adsp@8ea00000 {
+			reg = <0x0 0x8ea00000 0x0 0x1a00000>;
+			no-map;
+		};
 
-			thermal-sensors = <&tsens0 8>;
+		mpss_region: mpss@88800000 {
+			reg = <0x0 0x88800000 0x0 0x6200000>;
+			no-map;
+		};
 
-			trips {
-				cpu2_alert0: trip-point@0 {
-					temperature = <75000>;
-					hysteresis = <2000>;
-					type = "passive";
-				};
+		smem_mem: smem-mem@86000000 {
+			reg = <0x0 0x86000000 0x0 0x200000>;
+			no-map;
+		};
 
-				cpu2_crit: cpu_crit {
-					temperature = <110000>;
-					hysteresis = <2000>;
-					type = "critical";
-				};
-			};
+		memory@85800000 {
+			reg = <0x0 0x85800000 0x0 0x800000>;
+			no-map;
 		};
 
-		cpu3-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+		memory@86200000 {
+			reg = <0x0 0x86200000 0x0 0x2600000>;
+			no-map;
+		};
 
-			thermal-sensors = <&tsens0 10>;
+		rmtfs@86700000 {
+			compatible = "qcom,rmtfs-mem";
 
-			trips {
-				cpu3_alert0: trip-point@0 {
-					temperature = <75000>;
-					hysteresis = <2000>;
-					type = "passive";
-				};
+			size = <0x0 0x200000>;
+			alloc-ranges = <0x0 0xa0000000 0x0 0x2000000>;
+			no-map;
 
-				cpu3_crit: cpu_crit {
-					temperature = <110000>;
-					hysteresis = <2000>;
-					type = "critical";
-				};
-			};
+			qcom,client-id = <1>;
+			qcom,vmid = <15>;
 		};
 
-		gpu-thermal-top {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
-			thermal-sensors = <&tsens1 6>;
-
-			trips {
-				gpu1_alert0: trip-point@0 {
-					temperature = <90000>;
-					hysteresis = <2000>;
-					type = "hot";
-				};
-			};
+		zap_shader_region: gpu@8f200000 {
+			compatible = "shared-dma-pool";
+			reg = <0x0 0x90b00000 0x0 0xa00000>;
+			no-map;
 		};
+	};
 
-		gpu-thermal-bottom {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+	rpm-glink {
+		compatible = "qcom,glink-rpm";
 
-			thermal-sensors = <&tsens1 7>;
+		interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
 
-			trips {
-				gpu2_alert0: trip-point@0 {
-					temperature = <90000>;
-					hysteresis = <2000>;
-					type = "hot";
-				};
-			};
-		};
+		qcom,rpm-msg-ram = <&rpm_msg_ram>;
 
-		m4m-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+		mboxes = <&apcs_glb 0>;
 
-			thermal-sensors = <&tsens0 1>;
+		rpm_requests: rpm-requests {
+			compatible = "qcom,rpm-msm8996";
+			qcom,glink-channels = "rpm_requests";
 
-			trips {
-				m4m_alert0: trip-point@0 {
-					temperature = <90000>;
-					hysteresis = <2000>;
-					type = "hot";
-				};
-			};
-		};
-
-		l3-or-venus-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
-			thermal-sensors = <&tsens0 2>;
-
-			trips {
-				l3_or_venus_alert0: trip-point@0 {
-					temperature = <90000>;
-					hysteresis = <2000>;
-					type = "hot";
-				};
-			};
-		};
-
-		cluster0-l2-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
-			thermal-sensors = <&tsens0 7>;
-
-			trips {
-				cluster0_l2_alert0: trip-point@0 {
-					temperature = <90000>;
-					hysteresis = <2000>;
-					type = "hot";
-				};
-			};
-		};
-
-		cluster1-l2-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
-			thermal-sensors = <&tsens0 12>;
-
-			trips {
-				cluster1_l2_alert0: trip-point@0 {
-					temperature = <90000>;
-					hysteresis = <2000>;
-					type = "hot";
-				};
-			};
-		};
-
-		camera-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
-			thermal-sensors = <&tsens1 1>;
-
-			trips {
-				camera_alert0: trip-point@0 {
-					temperature = <90000>;
-					hysteresis = <2000>;
-					type = "hot";
-				};
-			};
-		};
-
-		q6-dsp-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
-			thermal-sensors = <&tsens1 2>;
-
-			trips {
-				q6_dsp_alert0: trip-point@0 {
-					temperature = <90000>;
-					hysteresis = <2000>;
-					type = "hot";
-				};
-			};
-		};
-
-		mem-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
-			thermal-sensors = <&tsens1 3>;
-
-			trips {
-				mem_alert0: trip-point@0 {
-					temperature = <90000>;
-					hysteresis = <2000>;
-					type = "hot";
-				};
-			};
-		};
-
-		modemtx-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
-			thermal-sensors = <&tsens1 4>;
-
-			trips {
-				modemtx_alert0: trip-point@0 {
-					temperature = <90000>;
-					hysteresis = <2000>;
-					type = "hot";
-				};
-			};
-		};
-	};
-
-	timer {
-		compatible = "arm,armv8-timer";
-		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
-	};
-
-	clocks {
-		xo_board: xo_board {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <19200000>;
-			clock-output-names = "xo_board";
-		};
-
-		sleep_clk: sleep_clk {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <32764>;
-			clock-output-names = "sleep_clk";
-		};
-	};
-
-	psci {
-		compatible = "arm,psci-1.0";
-		method = "smc";
-	};
-
-	firmware {
-		scm {
-			compatible = "qcom,scm-msm8996";
-
-			qcom,dload-mode = <&tcsr 0x13000>;
-		};
-	};
-
-	tcsr_mutex: hwlock {
-		compatible = "qcom,tcsr-mutex";
-		syscon = <&tcsr_mutex_regs 0 0x1000>;
-		#hwlock-cells = <1>;
-	};
-
-	smem {
-		compatible = "qcom,smem";
-		memory-region = <&smem_mem>;
-		hwlocks = <&tcsr_mutex 3>;
-	};
-
-	rpm-glink {
-		compatible = "qcom,glink-rpm";
-
-		interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
-
-		qcom,rpm-msg-ram = <&rpm_msg_ram>;
-
-		mboxes = <&apcs_glb 0>;
-
-		rpm_requests: rpm-requests {
-			compatible = "qcom,rpm-msm8996";
-			qcom,glink-channels = "rpm_requests";
-
-			rpmcc: qcom,rpmcc {
-				compatible = "qcom,rpmcc-msm8996";
-				#clock-cells = <1>;
+			rpmcc: qcom,rpmcc {
+				compatible = "qcom,rpmcc-msm8996";
+				#clock-cells = <1>;
 			};
 
 			rpmpd: power-controller {
@@ -512,1414 +261,1675 @@
 		};
 	};
 
-	soc: soc {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0 0 0 0xffffffff>;
-		compatible = "simple-bus";
+	smem {
+		compatible = "qcom,smem";
+		memory-region = <&smem_mem>;
+		hwlocks = <&tcsr_mutex 3>;
+	};
 
-		rpm_msg_ram: memory@68000 {
-			compatible = "qcom,rpm-msg-ram";
-			reg = <0x00068000 0x6000>;
-		};
+	smp2p-adsp {
+		compatible = "qcom,smp2p";
+		qcom,smem = <443>, <429>;
 
-		rng: rng@83000 {
-			compatible = "qcom,prng-ee";
-			reg = <0x00083000 0x1000>;
-			clocks = <&gcc GCC_PRNG_AHB_CLK>;
-			clock-names = "core";
-		};
+		interrupts = <0 158 IRQ_TYPE_EDGE_RISING>;
 
-		tcsr_mutex_regs: syscon@740000 {
-			compatible = "syscon";
-			reg = <0x00740000 0x20000>;
-		};
+		mboxes = <&apcs_glb 10>;
 
-		tsens0: thermal-sensor@4a9000 {
-			compatible = "qcom,msm8996-tsens";
-			reg = <0x004a9000 0x1000>, /* TM */
-			      <0x004a8000 0x1000>; /* SROT */
-			#qcom,sensors = <13>;
-			#thermal-sensor-cells = <1>;
-		};
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <2>;
 
-		tsens1: thermal-sensor@4ad000 {
-			compatible = "qcom,msm8996-tsens";
-			reg = <0x004ad000 0x1000>, /* TM */
-			      <0x004ac000 0x1000>; /* SROT */
-			#qcom,sensors = <8>;
-			#thermal-sensor-cells = <1>;
+		smp2p_adsp_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
 		};
 
-		tcsr: syscon@7a0000 {
-			compatible = "qcom,tcsr-msm8996", "syscon";
-			reg = <0x007a0000 0x18000>;
-		};
+		smp2p_adsp_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
 
-		intc: interrupt-controller@9bc0000 {
-			compatible = "qcom,msm8996-gic-v3", "arm,gic-v3";
-			#interrupt-cells = <3>;
 			interrupt-controller;
-			#redistributor-regions = <1>;
-			redistributor-stride = <0x0 0x40000>;
-			reg = <0x09bc0000 0x10000>,
-			      <0x09c00000 0x100000>;
-			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			#interrupt-cells = <2>;
 		};
+	};
 
-		apcs_glb: mailbox@9820000 {
-			compatible = "qcom,msm8996-apcs-hmss-global";
-			reg = <0x09820000 0x1000>;
+	smp2p-modem {
+		compatible = "qcom,smp2p";
+		qcom,smem = <435>, <428>;
 
-			#mbox-cells = <1>;
-		};
+		interrupts = <GIC_SPI 451 IRQ_TYPE_EDGE_RISING>;
 
-		gcc: clock-controller@300000 {
-			compatible = "qcom,gcc-msm8996";
-			#clock-cells = <1>;
-			#reset-cells = <1>;
-			#power-domain-cells = <1>;
-			reg = <0x00300000 0x90000>;
-		};
+		mboxes = <&apcs_glb 14>;
 
-		stm@3002000 {
-			compatible = "arm,coresight-stm", "arm,primecell";
-			reg = <0x3002000 0x1000>,
-			      <0x8280000 0x180000>;
-			reg-names = "stm-base", "stm-stimulus-base";
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <1>;
 
-			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
-			clock-names = "apb_pclk", "atclk";
-
-			out-ports {
-				port {
-					stm_out: endpoint {
-						remote-endpoint =
-						  <&funnel0_in>;
-					};
-				};
-			};
+		modem_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
 		};
 
-		tpiu@3020000 {
-			compatible = "arm,coresight-tpiu", "arm,primecell";
-			reg = <0x3020000 0x1000>;
-
-			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
-			clock-names = "apb_pclk", "atclk";
+		modem_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
 
-			in-ports {
-				port {
-					tpiu_in: endpoint {
-						remote-endpoint =
-						  <&replicator_out1>;
-					};
-				};
-			};
+			interrupt-controller;
+			#interrupt-cells = <2>;
 		};
+	};
 
-		funnel@3021000 {
-			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
-			reg = <0x3021000 0x1000>;
+	smp2p-slpi {
+		compatible = "qcom,smp2p";
+		qcom,smem = <481>, <430>;
 
-			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
-			clock-names = "apb_pclk", "atclk";
+		interrupts = <GIC_SPI 178 IRQ_TYPE_EDGE_RISING>;
 
-			in-ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
+		mboxes = <&apcs_glb 26>;
 
-				port@7 {
-					reg = <7>;
-					funnel0_in: endpoint {
-						remote-endpoint =
-						  <&stm_out>;
-					};
-				};
-			};
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <3>;
 
-			out-ports {
-				port {
-					funnel0_out: endpoint {
-						remote-endpoint =
-						  <&merge_funnel_in0>;
-					};
-				};
-			};
+		smp2p_slpi_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
 		};
 
-		funnel@3022000 {
-			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
-			reg = <0x3022000 0x1000>;
+		smp2p_slpi_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+	};
 
-			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
-			clock-names = "apb_pclk", "atclk";
+	soc: soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 0 0xffffffff>;
+		compatible = "simple-bus";
 
-			in-ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
+		pcie_phy: phy@34000 {
+			compatible = "qcom,msm8996-qmp-pcie-phy";
+			reg = <0x00034000 0x488>;
+			#clock-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
 
-				port@6 {
-					reg = <6>;
-					funnel1_in: endpoint {
-						remote-endpoint =
-						  <&apss_merge_funnel_out>;
-					};
-				};
-			};
+			clocks = <&gcc GCC_PCIE_PHY_AUX_CLK>,
+				<&gcc GCC_PCIE_PHY_CFG_AHB_CLK>,
+				<&gcc GCC_PCIE_CLKREF_CLK>;
+			clock-names = "aux", "cfg_ahb", "ref";
 
-			out-ports {
-				port {
-					funnel1_out: endpoint {
-						remote-endpoint =
-						  <&merge_funnel_in1>;
-					};
-				};
-			};
-		};
+			resets = <&gcc GCC_PCIE_PHY_BCR>,
+				<&gcc GCC_PCIE_PHY_COM_BCR>,
+				<&gcc GCC_PCIE_PHY_COM_NOCSR_BCR>;
+			reset-names = "phy", "common", "cfg";
+			status = "disabled";
 
-		funnel@3023000 {
-			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
-			reg = <0x3023000 0x1000>;
+			pciephy_0: lane@35000 {
+				reg = <0x00035000 0x130>,
+				      <0x00035200 0x200>,
+				      <0x00035400 0x1dc>;
+				#phy-cells = <0>;
 
-			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
-			clock-names = "apb_pclk", "atclk";
+				clock-output-names = "pcie_0_pipe_clk_src";
+				clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
+				clock-names = "pipe0";
+				resets = <&gcc GCC_PCIE_0_PHY_BCR>;
+				reset-names = "lane0";
+			};
 
+			pciephy_1: lane@36000 {
+				reg = <0x00036000 0x130>,
+				      <0x00036200 0x200>,
+				      <0x00036400 0x1dc>;
+				#phy-cells = <0>;
 
-			out-ports {
-				port {
-					funnel2_out: endpoint {
-						remote-endpoint =
-						  <&merge_funnel_in2>;
-					};
-				};
+				clock-output-names = "pcie_1_pipe_clk_src";
+				clocks = <&gcc GCC_PCIE_1_PIPE_CLK>;
+				clock-names = "pipe1";
+				resets = <&gcc GCC_PCIE_1_PHY_BCR>;
+				reset-names = "lane1";
 			};
-		};
 
-		funnel@3025000 {
-			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
-			reg = <0x3025000 0x1000>;
+			pciephy_2: lane@37000 {
+				reg = <0x00037000 0x130>,
+				      <0x00037200 0x200>,
+				      <0x00037400 0x1dc>;
+				#phy-cells = <0>;
 
-			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
-			clock-names = "apb_pclk", "atclk";
+				clock-output-names = "pcie_2_pipe_clk_src";
+				clocks = <&gcc GCC_PCIE_2_PIPE_CLK>;
+				clock-names = "pipe2";
+				resets = <&gcc GCC_PCIE_2_PHY_BCR>;
+				reset-names = "lane2";
+			};
+		};
 
-			in-ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
+		rpm_msg_ram: memory@68000 {
+			compatible = "qcom,rpm-msg-ram";
+			reg = <0x00068000 0x6000>;
+		};
 
-				port@0 {
-					reg = <0>;
-					merge_funnel_in0: endpoint {
-						remote-endpoint =
-						  <&funnel0_out>;
-					};
-				};
+		qfprom@74000 {
+			compatible = "qcom,qfprom";
+			reg = <0x00074000 0x8ff>;
+			#address-cells = <1>;
+			#size-cells = <1>;
 
-				port@1 {
-					reg = <1>;
-					merge_funnel_in1: endpoint {
-						remote-endpoint =
-						  <&funnel1_out>;
-					};
-				};
+			qusb2p_hstx_trim: hstx_trim@24e {
+				reg = <0x24e 0x2>;
+				bits = <5 4>;
+			};
 
-				port@2 {
-					reg = <2>;
-					merge_funnel_in2: endpoint {
-						remote-endpoint =
-						  <&funnel2_out>;
-					};
-				};
+			qusb2s_hstx_trim: hstx_trim@24f {
+				reg = <0x24f 0x1>;
+				bits = <1 4>;
 			};
 
-			out-ports {
-				port {
-					merge_funnel_out: endpoint {
-						remote-endpoint =
-						  <&etf_in>;
-					};
-				};
+			gpu_speed_bin: gpu_speed_bin@133 {
+				reg = <0x133 0x1>;
+				bits = <5 3>;
 			};
 		};
 
-		replicator@3026000 {
-			compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
-			reg = <0x3026000 0x1000>;
-
-			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
-			clock-names = "apb_pclk", "atclk";
+		rng: rng@83000 {
+			compatible = "qcom,prng-ee";
+			reg = <0x00083000 0x1000>;
+			clocks = <&gcc GCC_PRNG_AHB_CLK>;
+			clock-names = "core";
+		};
 
-			in-ports {
-				port {
-					replicator_in: endpoint {
-						remote-endpoint =
-						  <&etf_out>;
-					};
-				};
-			};
+		gcc: clock-controller@300000 {
+			compatible = "qcom,gcc-msm8996";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+			reg = <0x00300000 0x90000>;
+		};
 
-			out-ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
+		tsens0: thermal-sensor@4a9000 {
+			compatible = "qcom,msm8996-tsens";
+			reg = <0x004a9000 0x1000>, /* TM */
+			      <0x004a8000 0x1000>; /* SROT */
+			#qcom,sensors = <13>;
+			#thermal-sensor-cells = <1>;
+		};
 
-				port@0 {
-					reg = <0>;
-					replicator_out0: endpoint {
-						remote-endpoint =
-						  <&etr_in>;
-					};
-				};
-
-				port@1 {
-					reg = <1>;
-					replicator_out1: endpoint {
-						remote-endpoint =
-						  <&tpiu_in>;
-					};
-				};
-			};
+		tsens1: thermal-sensor@4ad000 {
+			compatible = "qcom,msm8996-tsens";
+			reg = <0x004ad000 0x1000>, /* TM */
+			      <0x004ac000 0x1000>; /* SROT */
+			#qcom,sensors = <8>;
+			#thermal-sensor-cells = <1>;
 		};
 
-		etf@3027000 {
-			compatible = "arm,coresight-tmc", "arm,primecell";
-			reg = <0x3027000 0x1000>;
-
-			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
-			clock-names = "apb_pclk", "atclk";
-
-			in-ports {
-				port {
-					etf_in: endpoint {
-						remote-endpoint =
-						  <&merge_funnel_out>;
-					};
-				};
-			};
-
-			out-ports {
-				port {
-					etf_out: endpoint {
-						remote-endpoint =
-						  <&replicator_in>;
-					};
-				};
-			};
+		tcsr_mutex_regs: syscon@740000 {
+			compatible = "syscon";
+			reg = <0x00740000 0x20000>;
 		};
 
-		etr@3028000 {
-			compatible = "arm,coresight-tmc", "arm,primecell";
-			reg = <0x3028000 0x1000>;
-
-			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
-			clock-names = "apb_pclk", "atclk";
-			arm,scatter-gather;
-
-			in-ports {
-				port {
-					etr_in: endpoint {
-						remote-endpoint =
-						  <&replicator_out0>;
-					};
-				};
-			};
+		tcsr: syscon@7a0000 {
+			compatible = "qcom,tcsr-msm8996", "syscon";
+			reg = <0x007a0000 0x18000>;
 		};
 
-		debug@3810000 {
-			compatible = "arm,coresight-cpu-debug", "arm,primecell";
-			reg = <0x3810000 0x1000>;
-
-			clocks = <&rpmcc RPM_QDSS_CLK>;
-			clock-names = "apb_pclk";
-
-			cpu = <&CPU0>;
+		mmcc: clock-controller@8c0000 {
+			compatible = "qcom,mmcc-msm8996";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+			reg = <0x008c0000 0x40000>;
+			assigned-clocks = <&mmcc MMPLL9_PLL>,
+					  <&mmcc MMPLL1_PLL>,
+					  <&mmcc MMPLL3_PLL>,
+					  <&mmcc MMPLL4_PLL>,
+					  <&mmcc MMPLL5_PLL>;
+			assigned-clock-rates = <624000000>,
+					       <810000000>,
+					       <980000000>,
+					       <960000000>,
+					       <825000000>;
 		};
 
-		etm@3840000 {
-			compatible = "arm,coresight-etm4x", "arm,primecell";
-			reg = <0x3840000 0x1000>;
+		mdss: mdss@900000 {
+			compatible = "qcom,mdss";
 
-			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
-			clock-names = "apb_pclk", "atclk";
+			reg = <0x00900000 0x1000>,
+			      <0x009b0000 0x1040>,
+			      <0x009b8000 0x1040>;
+			reg-names = "mdss_phys",
+				    "vbif_phys",
+				    "vbif_nrt_phys";
 
-			cpu = <&CPU0>;
+			power-domains = <&mmcc MDSS_GDSC>;
+			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 
-			out-ports {
-				port {
-					etm0_out: endpoint {
-						remote-endpoint =
-						  <&apss_funnel0_in0>;
-					};
-				};
-			};
-		};
+			interrupt-controller;
+			#interrupt-cells = <1>;
 
-		debug@3910000 {
-			compatible = "arm,coresight-cpu-debug", "arm,primecell";
-			reg = <0x3910000 0x1000>;
+			clocks = <&mmcc MDSS_AHB_CLK>;
+			clock-names = "iface";
 
-			clocks = <&rpmcc RPM_QDSS_CLK>;
-			clock-names = "apb_pclk";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
 
-			cpu = <&CPU1>;
-		};
+			mdp: mdp@901000 {
+				compatible = "qcom,mdp5";
+				reg = <0x00901000 0x90000>;
+				reg-names = "mdp_phys";
 
-		etm@3940000 {
-			compatible = "arm,coresight-etm4x", "arm,primecell";
-			reg = <0x3940000 0x1000>;
+				interrupt-parent = <&mdss>;
+				interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
 
-			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
-			clock-names = "apb_pclk", "atclk";
+				clocks = <&mmcc MDSS_AHB_CLK>,
+					 <&mmcc MDSS_AXI_CLK>,
+					 <&mmcc MDSS_MDP_CLK>,
+					 <&mmcc SMMU_MDP_AXI_CLK>,
+					 <&mmcc MDSS_VSYNC_CLK>;
+				clock-names = "iface",
+					      "bus",
+					      "core",
+					      "iommu",
+					      "vsync";
 
-			cpu = <&CPU1>;
+				iommus = <&mdp_smmu 0>;
 
-			out-ports {
-				port {
-					etm1_out: endpoint {
-						remote-endpoint =
-						  <&apss_funnel0_in1>;
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						mdp5_intf3_out: endpoint {
+							remote-endpoint = <&hdmi_in>;
+						};
 					};
 				};
 			};
-		};
 
-		funnel@39b0000 { /* APSS Funnel 0 */
-			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
-			reg = <0x39b0000 0x1000>;
+			hdmi: hdmi-tx@9a0000 {
+				compatible = "qcom,hdmi-tx-8996";
+				reg =	<0x009a0000 0x50c>,
+					<0x00070000 0x6158>,
+					<0x009e0000 0xfff>;
+				reg-names = "core_physical",
+					    "qfprom_physical",
+					    "hdcp_physical";
 
-			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
-			clock-names = "apb_pclk", "atclk";
+				interrupt-parent = <&mdss>;
+				interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
 
-			in-ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
+				clocks = <&mmcc MDSS_MDP_CLK>,
+					 <&mmcc MDSS_AHB_CLK>,
+					 <&mmcc MDSS_HDMI_CLK>,
+					 <&mmcc MDSS_HDMI_AHB_CLK>,
+					 <&mmcc MDSS_EXTPCLK_CLK>;
+				clock-names =
+					"mdp_core",
+					"iface",
+					"core",
+					"alt_iface",
+					"extp";
 
-				port@0 {
-					reg = <0>;
-					apss_funnel0_in0: endpoint {
-						remote-endpoint = <&etm0_out>;
-					};
-				};
+				phys = <&hdmi_phy>;
+				phy-names = "hdmi_phy";
+				#sound-dai-cells = <1>;
 
-				port@1 {
-					reg = <1>;
-					apss_funnel0_in1: endpoint {
-						remote-endpoint = <&etm1_out>;
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						hdmi_in: endpoint {
+							remote-endpoint = <&mdp5_intf3_out>;
+						};
 					};
 				};
 			};
 
-			out-ports {
-				port {
-					apss_funnel0_out: endpoint {
-						remote-endpoint =
-						  <&apss_merge_funnel_in0>;
-					};
-				};
+			hdmi_phy: hdmi-phy@9a0600 {
+				#phy-cells = <0>;
+				compatible = "qcom,hdmi-phy-8996";
+				reg = <0x009a0600 0x1c4>,
+				      <0x009a0a00 0x124>,
+				      <0x009a0c00 0x124>,
+				      <0x009a0e00 0x124>,
+				      <0x009a1000 0x124>,
+				      <0x009a1200 0x0c8>;
+				reg-names = "hdmi_pll",
+					    "hdmi_tx_l0",
+					    "hdmi_tx_l1",
+					    "hdmi_tx_l2",
+					    "hdmi_tx_l3",
+					    "hdmi_phy";
+
+				clocks = <&mmcc MDSS_AHB_CLK>,
+					 <&gcc GCC_HDMI_CLKREF_CLK>;
+				clock-names = "iface",
+					      "ref";
 			};
 		};
+		gpu@b00000 {
+			compatible = "qcom,adreno-530.2", "qcom,adreno";
+			#stream-id-cells = <16>;
 
-		debug@3a10000 {
-			compatible = "arm,coresight-cpu-debug", "arm,primecell";
-			reg = <0x3a10000 0x1000>;
+			reg = <0x00b00000 0x3f000>;
+			reg-names = "kgsl_3d0_reg_memory";
 
-			clocks = <&rpmcc RPM_QDSS_CLK>;
-			clock-names = "apb_pclk";
+			interrupts = <0 300 IRQ_TYPE_LEVEL_HIGH>;
 
-			cpu = <&CPU2>;
-		};
+			clocks = <&mmcc GPU_GX_GFX3D_CLK>,
+				<&mmcc GPU_AHB_CLK>,
+				<&mmcc GPU_GX_RBBMTIMER_CLK>,
+				<&gcc GCC_BIMC_GFX_CLK>,
+				<&gcc GCC_MMSS_BIMC_GFX_CLK>;
 
-		etm@3a40000 {
-			compatible = "arm,coresight-etm4x", "arm,primecell";
-			reg = <0x3a40000 0x1000>;
+			clock-names = "core",
+				"iface",
+				"rbbmtimer",
+				"mem",
+				"mem_iface";
 
-			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
-			clock-names = "apb_pclk", "atclk";
+			power-domains = <&mmcc GPU_GDSC>;
+			iommus = <&adreno_smmu 0>;
 
-			cpu = <&CPU2>;
+			nvmem-cells = <&gpu_speed_bin>;
+			nvmem-cell-names = "speed_bin";
 
-			out-ports {
-				port {
-					etm2_out: endpoint {
-						remote-endpoint =
-						  <&apss_funnel1_in0>;
-					};
+			qcom,gpu-quirk-two-pass-use-wfi;
+			qcom,gpu-quirk-fault-detect-mask;
+
+			operating-points-v2 = <&gpu_opp_table>;
+
+			gpu_opp_table: opp-table {
+				compatible  ="operating-points-v2";
+
+				/*
+				 * 624Mhz and 560Mhz are only available on speed
+				 * bin (1 << 0). All the rest are available on
+				 * all bins of the hardware
+				 */
+				opp-624000000 {
+					opp-hz = /bits/ 64 <624000000>;
+					opp-supported-hw = <0x01>;
+				};
+				opp-560000000 {
+					opp-hz = /bits/ 64 <560000000>;
+					opp-supported-hw = <0x01>;
+				};
+				opp-510000000 {
+					opp-hz = /bits/ 64 <510000000>;
+					opp-supported-hw = <0xFF>;
+				};
+				opp-401800000 {
+					opp-hz = /bits/ 64 <401800000>;
+					opp-supported-hw = <0xFF>;
+				};
+				opp-315000000 {
+					opp-hz = /bits/ 64 <315000000>;
+					opp-supported-hw = <0xFF>;
+				};
+				opp-214000000 {
+					opp-hz = /bits/ 64 <214000000>;
+					opp-supported-hw = <0xFF>;
+				};
+				opp-133000000 {
+					opp-hz = /bits/ 64 <133000000>;
+					opp-supported-hw = <0xFF>;
 				};
 			};
-		};
 
-		debug@3b10000 {
-			compatible = "arm,coresight-cpu-debug", "arm,primecell";
-			reg = <0x3b10000 0x1000>;
+			zap-shader {
+				memory-region = <&zap_shader_region>;
+			};
+		};
 
-			clocks = <&rpmcc RPM_QDSS_CLK>;
-			clock-names = "apb_pclk";
+		msmgpio: pinctrl@1010000 {
+			compatible = "qcom,msm8996-pinctrl";
+			reg = <0x01010000 0x300000>;
+			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
 
-			cpu = <&CPU3>;
+		spmi_bus: qcom,spmi@400f000 {
+			compatible = "qcom,spmi-pmic-arb";
+			reg = <0x0400f000 0x1000>,
+			      <0x04400000 0x800000>,
+			      <0x04c00000 0x800000>,
+			      <0x05800000 0x200000>,
+			      <0x0400a000 0x002100>;
+			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
+			interrupt-names = "periph_irq";
+			interrupts = <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>;
+			qcom,ee = <0>;
+			qcom,channel = <0>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+			interrupt-controller;
+			#interrupt-cells = <4>;
 		};
 
-		etm@3b40000 {
-			compatible = "arm,coresight-etm4x", "arm,primecell";
-			reg = <0x3b40000 0x1000>;
+		agnoc@0 {
+			power-domains = <&gcc AGGRE0_NOC_GDSC>;
+			compatible = "simple-pm-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
 
-			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
-			clock-names = "apb_pclk", "atclk";
+			pcie0: pcie@600000 {
+				compatible = "qcom,pcie-msm8996", "snps,dw-pcie";
+				status = "disabled";
+				power-domains = <&gcc PCIE0_GDSC>;
+				bus-range = <0x00 0xff>;
+				num-lanes = <1>;
 
-			cpu = <&CPU3>;
+				reg = <0x00600000 0x2000>,
+				      <0x0c000000 0xf1d>,
+				      <0x0c000f20 0xa8>,
+				      <0x0c100000 0x100000>;
+				reg-names = "parf", "dbi", "elbi","config";
 
-			out-ports {
-				port {
-					etm3_out: endpoint {
-						remote-endpoint =
-						  <&apss_funnel1_in1>;
-					};
-				};
-			};
-		};
+				phys = <&pciephy_0>;
+				phy-names = "pciephy";
 
-		funnel@3bb0000 { /* APSS Funnel 1 */
-			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
-			reg = <0x3bb0000 0x1000>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges = <0x01000000 0x0 0x0c200000 0x0c200000 0x0 0x100000>,
+					<0x02000000 0x0 0x0c300000 0x0c300000 0x0 0xd00000>;
 
-			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
-			clock-names = "apb_pclk", "atclk";
+				interrupts = <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "msi";
+				#interrupt-cells = <1>;
+				interrupt-map-mask = <0 0 0 0x7>;
+				interrupt-map = <0 0 0 1 &intc 0 244 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+						<0 0 0 2 &intc 0 245 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+						<0 0 0 3 &intc 0 247 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+						<0 0 0 4 &intc 0 248 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
 
-			in-ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
+				pinctrl-names = "default", "sleep";
+				pinctrl-0 = <&pcie0_clkreq_default &pcie0_perst_default &pcie0_wake_default>;
+				pinctrl-1 = <&pcie0_clkreq_sleep &pcie0_perst_default &pcie0_wake_sleep>;
 
-				port@0 {
-					reg = <0>;
-					apss_funnel1_in0: endpoint {
-						remote-endpoint = <&etm2_out>;
-					};
-				};
+				linux,pci-domain = <0>;
 
-				port@1 {
-					reg = <1>;
-					apss_funnel1_in1: endpoint {
-						remote-endpoint = <&etm3_out>;
-					};
-				};
-			};
+				clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
+					<&gcc GCC_PCIE_0_AUX_CLK>,
+					<&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+					<&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
+					<&gcc GCC_PCIE_0_SLV_AXI_CLK>;
+
+				clock-names =  "pipe",
+						"aux",
+						"cfg",
+						"bus_master",
+						"bus_slave";
 
-			out-ports {
-				port {
-					apss_funnel1_out: endpoint {
-						remote-endpoint =
-						  <&apss_merge_funnel_in1>;
-					};
-				};
 			};
-		};
 
-		funnel@3bc0000 {
-			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
-			reg = <0x3bc0000 0x1000>;
+			pcie1: pcie@608000 {
+				compatible = "qcom,pcie-msm8996", "snps,dw-pcie";
+				power-domains = <&gcc PCIE1_GDSC>;
+				bus-range = <0x00 0xff>;
+				num-lanes = <1>;
 
-			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
-			clock-names = "apb_pclk", "atclk";
+				status  = "disabled";
 
-			in-ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
+				reg = <0x00608000 0x2000>,
+				      <0x0d000000 0xf1d>,
+				      <0x0d000f20 0xa8>,
+				      <0x0d100000 0x100000>;
 
-				port@0 {
-					reg = <0>;
-					apss_merge_funnel_in0: endpoint {
-						remote-endpoint =
-						  <&apss_funnel0_out>;
-					};
-				};
+				reg-names = "parf", "dbi", "elbi","config";
 
-				port@1 {
-					reg = <1>;
-					apss_merge_funnel_in1: endpoint {
-						remote-endpoint =
-						  <&apss_funnel1_out>;
-					};
-				};
-			};
+				phys = <&pciephy_1>;
+				phy-names = "pciephy";
 
-			out-ports {
-				port {
-					apss_merge_funnel_out: endpoint {
-						remote-endpoint =
-						  <&funnel1_in>;
-					};
-				};
-			};
-		};
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges = <0x01000000 0x0 0x0d200000 0x0d200000 0x0 0x100000>,
+					<0x02000000 0x0 0x0d300000 0x0d300000 0x0 0xd00000>;
 
-		kryocc: clock-controller@6400000 {
-			compatible = "qcom,apcc-msm8996";
-			reg = <0x06400000 0x90000>;
-			#clock-cells = <1>;
-		};
+				interrupts = <GIC_SPI 413 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "msi";
+				#interrupt-cells = <1>;
+				interrupt-map-mask = <0 0 0 0x7>;
+				interrupt-map = <0 0 0 1 &intc 0 272 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+						<0 0 0 2 &intc 0 273 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+						<0 0 0 3 &intc 0 274 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+						<0 0 0 4 &intc 0 275 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
 
-		blsp1_uart1: serial@7570000 {
-			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
-			reg = <0x07570000 0x1000>;
-			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>,
-				 <&gcc GCC_BLSP1_AHB_CLK>;
-			clock-names = "core", "iface";
+				pinctrl-names = "default", "sleep";
+				pinctrl-0 = <&pcie1_clkreq_default &pcie1_perst_default &pcie1_wake_default>;
+				pinctrl-1 = <&pcie1_clkreq_sleep &pcie1_perst_default &pcie1_wake_sleep>;
+
+				linux,pci-domain = <1>;
+
+				clocks = <&gcc GCC_PCIE_1_PIPE_CLK>,
+					<&gcc GCC_PCIE_1_AUX_CLK>,
+					<&gcc GCC_PCIE_1_CFG_AHB_CLK>,
+					<&gcc GCC_PCIE_1_MSTR_AXI_CLK>,
+					<&gcc GCC_PCIE_1_SLV_AXI_CLK>;
+
+				clock-names =  "pipe",
+						"aux",
+						"cfg",
+						"bus_master",
+						"bus_slave";
+			};
+
+			pcie2: pcie@610000 {
+				compatible = "qcom,pcie-msm8996", "snps,dw-pcie";
+				power-domains = <&gcc PCIE2_GDSC>;
+				bus-range = <0x00 0xff>;
+				num-lanes = <1>;
+				status = "disabled";
+				reg = <0x00610000 0x2000>,
+				      <0x0e000000 0xf1d>,
+				      <0x0e000f20 0xa8>,
+				      <0x0e100000 0x100000>;
+
+				reg-names = "parf", "dbi", "elbi","config";
+
+				phys = <&pciephy_2>;
+				phy-names = "pciephy";
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges = <0x01000000 0x0 0x0e200000 0x0e200000 0x0 0x100000>,
+					<0x02000000 0x0 0x0e300000 0x0e300000 0x0 0x1d00000>;
+
+				device_type = "pci";
+
+				interrupts = <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "msi";
+				#interrupt-cells = <1>;
+				interrupt-map-mask = <0 0 0 0x7>;
+				interrupt-map = <0 0 0 1 &intc 0 142 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+						<0 0 0 2 &intc 0 143 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+						<0 0 0 3 &intc 0 144 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+						<0 0 0 4 &intc 0 145 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+				pinctrl-names = "default", "sleep";
+				pinctrl-0 = <&pcie2_clkreq_default &pcie2_perst_default &pcie2_wake_default>;
+				pinctrl-1 = <&pcie2_clkreq_sleep &pcie2_perst_default &pcie2_wake_sleep >;
+
+				linux,pci-domain = <2>;
+				clocks = <&gcc GCC_PCIE_2_PIPE_CLK>,
+					<&gcc GCC_PCIE_2_AUX_CLK>,
+					<&gcc GCC_PCIE_2_CFG_AHB_CLK>,
+					<&gcc GCC_PCIE_2_MSTR_AXI_CLK>,
+					<&gcc GCC_PCIE_2_SLV_AXI_CLK>;
+
+				clock-names =  "pipe",
+						"aux",
+						"cfg",
+						"bus_master",
+						"bus_slave";
+			};
+		};
+
+		ufshc: ufshc@624000 {
+			compatible = "qcom,ufshc";
+			reg = <0x00624000 0x2500>;
+			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
+
+			phys = <&ufsphy>;
+			phy-names = "ufsphy";
+
+			power-domains = <&gcc UFS_GDSC>;
+
+			clock-names =
+				"core_clk_src",
+				"core_clk",
+				"bus_clk",
+				"bus_aggr_clk",
+				"iface_clk",
+				"core_clk_unipro_src",
+				"core_clk_unipro",
+				"core_clk_ice",
+				"ref_clk",
+				"tx_lane0_sync_clk",
+				"rx_lane0_sync_clk";
+			clocks =
+				<&gcc UFS_AXI_CLK_SRC>,
+				<&gcc GCC_UFS_AXI_CLK>,
+				<&gcc GCC_SYS_NOC_UFS_AXI_CLK>,
+				<&gcc GCC_AGGRE2_UFS_AXI_CLK>,
+				<&gcc GCC_UFS_AHB_CLK>,
+				<&gcc UFS_ICE_CORE_CLK_SRC>,
+				<&gcc GCC_UFS_UNIPRO_CORE_CLK>,
+				<&gcc GCC_UFS_ICE_CORE_CLK>,
+				<&rpmcc RPM_SMD_LN_BB_CLK>,
+				<&gcc GCC_UFS_TX_SYMBOL_0_CLK>,
+				<&gcc GCC_UFS_RX_SYMBOL_0_CLK>;
+			freq-table-hz =
+				<100000000 200000000>,
+				<0 0>,
+				<0 0>,
+				<0 0>,
+				<0 0>,
+				<150000000 300000000>,
+				<0 0>,
+				<0 0>,
+				<0 0>,
+				<0 0>,
+				<0 0>;
+
+			lanes-per-direction = <1>;
+			#reset-cells = <1>;
+			status = "disabled";
+
+			ufs_variant {
+				compatible = "qcom,ufs_variant";
+			};
+		};
+
+		ufsphy: phy@627000 {
+			compatible = "qcom,msm8996-ufs-phy-qmp-14nm";
+			reg = <0x00627000 0xda8>;
+			reg-names = "phy_mem";
+			#phy-cells = <0>;
+
+			clock-names = "ref_clk_src", "ref_clk";
+			clocks = <&rpmcc RPM_SMD_LN_BB_CLK>,
+				 <&gcc GCC_UFS_CLKREF_CLK>;
+			resets = <&ufshc 0>;
+			status = "disabled";
+		};
+
+		camss: camss@a00000 {
+			compatible = "qcom,msm8996-camss";
+			reg = <0x00a34000 0x1000>,
+			      <0x00a00030 0x4>,
+			      <0x00a35000 0x1000>,
+			      <0x00a00038 0x4>,
+			      <0x00a36000 0x1000>,
+			      <0x00a00040 0x4>,
+			      <0x00a30000 0x100>,
+			      <0x00a30400 0x100>,
+			      <0x00a30800 0x100>,
+			      <0x00a30c00 0x100>,
+			      <0x00a31000 0x500>,
+			      <0x00a00020 0x10>,
+			      <0x00a10000 0x1000>,
+			      <0x00a14000 0x1000>;
+			reg-names = "csiphy0",
+				"csiphy0_clk_mux",
+				"csiphy1",
+				"csiphy1_clk_mux",
+				"csiphy2",
+				"csiphy2_clk_mux",
+				"csid0",
+				"csid1",
+				"csid2",
+				"csid3",
+				"ispif",
+				"csi_clk_mux",
+				"vfe0",
+				"vfe1";
+			interrupts = <GIC_SPI 78 0>,
+				<GIC_SPI 79 0>,
+				<GIC_SPI 80 0>,
+				<GIC_SPI 296 0>,
+				<GIC_SPI 297 0>,
+				<GIC_SPI 298 0>,
+				<GIC_SPI 299 0>,
+				<GIC_SPI 309 0>,
+				<GIC_SPI 314 0>,
+				<GIC_SPI 315 0>;
+			interrupt-names = "csiphy0",
+				"csiphy1",
+				"csiphy2",
+				"csid0",
+				"csid1",
+				"csid2",
+				"csid3",
+				"ispif",
+				"vfe0",
+				"vfe1";
+			power-domains = <&mmcc VFE0_GDSC>;
+			clocks = <&mmcc CAMSS_TOP_AHB_CLK>,
+				<&mmcc CAMSS_ISPIF_AHB_CLK>,
+				<&mmcc CAMSS_CSI0PHYTIMER_CLK>,
+				<&mmcc CAMSS_CSI1PHYTIMER_CLK>,
+				<&mmcc CAMSS_CSI2PHYTIMER_CLK>,
+				<&mmcc CAMSS_CSI0_AHB_CLK>,
+				<&mmcc CAMSS_CSI0_CLK>,
+				<&mmcc CAMSS_CSI0PHY_CLK>,
+				<&mmcc CAMSS_CSI0PIX_CLK>,
+				<&mmcc CAMSS_CSI0RDI_CLK>,
+				<&mmcc CAMSS_CSI1_AHB_CLK>,
+				<&mmcc CAMSS_CSI1_CLK>,
+				<&mmcc CAMSS_CSI1PHY_CLK>,
+				<&mmcc CAMSS_CSI1PIX_CLK>,
+				<&mmcc CAMSS_CSI1RDI_CLK>,
+				<&mmcc CAMSS_CSI2_AHB_CLK>,
+				<&mmcc CAMSS_CSI2_CLK>,
+				<&mmcc CAMSS_CSI2PHY_CLK>,
+				<&mmcc CAMSS_CSI2PIX_CLK>,
+				<&mmcc CAMSS_CSI2RDI_CLK>,
+				<&mmcc CAMSS_CSI3_AHB_CLK>,
+				<&mmcc CAMSS_CSI3_CLK>,
+				<&mmcc CAMSS_CSI3PHY_CLK>,
+				<&mmcc CAMSS_CSI3PIX_CLK>,
+				<&mmcc CAMSS_CSI3RDI_CLK>,
+				<&mmcc CAMSS_AHB_CLK>,
+				<&mmcc CAMSS_VFE0_CLK>,
+				<&mmcc CAMSS_CSI_VFE0_CLK>,
+				<&mmcc CAMSS_VFE0_AHB_CLK>,
+				<&mmcc CAMSS_VFE0_STREAM_CLK>,
+				<&mmcc CAMSS_VFE1_CLK>,
+				<&mmcc CAMSS_CSI_VFE1_CLK>,
+				<&mmcc CAMSS_VFE1_AHB_CLK>,
+				<&mmcc CAMSS_VFE1_STREAM_CLK>,
+				<&mmcc CAMSS_VFE_AHB_CLK>,
+				<&mmcc CAMSS_VFE_AXI_CLK>;
+			clock-names = "top_ahb",
+				"ispif_ahb",
+				"csiphy0_timer",
+				"csiphy1_timer",
+				"csiphy2_timer",
+				"csi0_ahb",
+				"csi0",
+				"csi0_phy",
+				"csi0_pix",
+				"csi0_rdi",
+				"csi1_ahb",
+				"csi1",
+				"csi1_phy",
+				"csi1_pix",
+				"csi1_rdi",
+				"csi2_ahb",
+				"csi2",
+				"csi2_phy",
+				"csi2_pix",
+				"csi2_rdi",
+				"csi3_ahb",
+				"csi3",
+				"csi3_phy",
+				"csi3_pix",
+				"csi3_rdi",
+				"ahb",
+				"vfe0",
+				"csi_vfe0",
+				"vfe0_ahb",
+				"vfe0_stream",
+				"vfe1",
+				"csi_vfe1",
+				"vfe1_ahb",
+				"vfe1_stream",
+				"vfe_ahb",
+				"vfe_axi";
+			iommus = <&vfe_smmu 0>,
+				 <&vfe_smmu 1>,
+				 <&vfe_smmu 2>,
+				 <&vfe_smmu 3>;
 			status = "disabled";
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};
 
-		blsp1_spi0: spi@7575000 {
-			compatible = "qcom,spi-qup-v2.2.1";
-			reg = <0x07575000 0x600>;
-			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&gcc GCC_BLSP1_QUP1_SPI_APPS_CLK>,
-				 <&gcc GCC_BLSP1_AHB_CLK>;
-			clock-names = "core", "iface";
-			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&blsp1_spi0_default>;
-			pinctrl-1 = <&blsp1_spi0_sleep>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
+		adreno_smmu: iommu@b40000 {
+			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
+			reg = <0x00b40000 0x10000>;
+
+			#global-interrupts = <1>;
+			interrupts = <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+
+			clocks = <&mmcc GPU_AHB_CLK>,
+				 <&gcc GCC_MMSS_BIMC_GFX_CLK>;
+			clock-names = "iface", "bus";
+
+			power-domains = <&mmcc GPU_GDSC>;
 		};
 
-		blsp2_i2c0: i2c@75b5000 {
-			compatible = "qcom,i2c-qup-v2.2.1";
-			reg = <0x075b5000 0x1000>;
-			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&gcc GCC_BLSP2_AHB_CLK>,
-				<&gcc GCC_BLSP2_QUP1_I2C_APPS_CLK>;
-			clock-names = "iface", "core";
-			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&blsp2_i2c0_default>;
-			pinctrl-1 = <&blsp2_i2c0_sleep>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
+		video-codec@c00000 {
+			compatible = "qcom,msm8996-venus";
+			reg = <0x00c00000 0xff000>;
+			interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&mmcc VENUS_GDSC>;
+			clocks = <&mmcc VIDEO_CORE_CLK>,
+				 <&mmcc VIDEO_AHB_CLK>,
+				 <&mmcc VIDEO_AXI_CLK>,
+				 <&mmcc VIDEO_MAXI_CLK>;
+			clock-names = "core", "iface", "bus", "mbus";
+			iommus = <&venus_smmu 0x00>,
+				 <&venus_smmu 0x01>,
+				 <&venus_smmu 0x0a>,
+				 <&venus_smmu 0x07>,
+				 <&venus_smmu 0x0e>,
+				 <&venus_smmu 0x0f>,
+				 <&venus_smmu 0x08>,
+				 <&venus_smmu 0x09>,
+				 <&venus_smmu 0x0b>,
+				 <&venus_smmu 0x0c>,
+				 <&venus_smmu 0x0d>,
+				 <&venus_smmu 0x10>,
+				 <&venus_smmu 0x11>,
+				 <&venus_smmu 0x21>,
+				 <&venus_smmu 0x28>,
+				 <&venus_smmu 0x29>,
+				 <&venus_smmu 0x2b>,
+				 <&venus_smmu 0x2c>,
+				 <&venus_smmu 0x2d>,
+				 <&venus_smmu 0x31>;
+			memory-region = <&venus_region>;
+			status = "okay";
+
+			video-decoder {
+				compatible = "venus-decoder";
+				clocks = <&mmcc VIDEO_SUBCORE0_CLK>;
+				clock-names = "core";
+				power-domains = <&mmcc VENUS_CORE0_GDSC>;
+			};
+
+			video-encoder {
+				compatible = "venus-encoder";
+				clocks = <&mmcc VIDEO_SUBCORE1_CLK>;
+				clock-names = "core";
+				power-domains = <&mmcc VENUS_CORE1_GDSC>;
+			};
 		};
 
-		blsp2_uart1: serial@75b0000 {
-			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
-			reg = <0x075b0000 0x1000>;
-			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&gcc GCC_BLSP2_UART2_APPS_CLK>,
-				 <&gcc GCC_BLSP2_AHB_CLK>;
-			clock-names = "core", "iface";
-			status = "disabled";
+		mdp_smmu: iommu@d00000 {
+			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
+			reg = <0x00d00000 0x10000>;
+
+			#global-interrupts = <1>;
+			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			clocks = <&mmcc SMMU_MDP_AHB_CLK>,
+				 <&mmcc SMMU_MDP_AXI_CLK>;
+			clock-names = "iface", "bus";
+
+			power-domains = <&mmcc MDSS_GDSC>;
 		};
 
-		blsp2_i2c1: i2c@75b6000 {
-			compatible = "qcom,i2c-qup-v2.2.1";
-			reg = <0x075b6000 0x1000>;
-			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&gcc GCC_BLSP2_AHB_CLK>,
-				<&gcc GCC_BLSP2_QUP2_I2C_APPS_CLK>;
-			clock-names = "iface", "core";
-			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&blsp2_i2c1_default>;
-			pinctrl-1 = <&blsp2_i2c1_sleep>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
+		venus_smmu: arm,smmu-venus@d40000 {
+			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
+			reg = <0xd40000 0x20000>;
+			#global-interrupts = <1>;
+			interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&mmcc MMAGIC_VIDEO_GDSC>;
+			clocks = <&mmcc SMMU_VIDEO_AHB_CLK>,
+				 <&mmcc SMMU_VIDEO_AXI_CLK>;
+			clock-names = "iface", "bus";
+			#iommu-cells = <1>;
+			status = "okay";
 		};
 
-		blsp2_uart2: serial@75b1000 {
-			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
-			reg = <0x075b1000 0x1000>;
-			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&gcc GCC_BLSP2_UART3_APPS_CLK>,
-				 <&gcc GCC_BLSP2_AHB_CLK>;
-			clock-names = "core", "iface";
-			status = "disabled";
+		vfe_smmu: iommu@da0000 {
+			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
+			reg = <0x00da0000 0x10000>;
+
+			#global-interrupts = <1>;
+			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&mmcc MMAGIC_CAMSS_GDSC>;
+			clocks = <&mmcc SMMU_VFE_AHB_CLK>,
+				 <&mmcc SMMU_VFE_AXI_CLK>;
+			clock-names = "iface",
+				      "bus";
+			#iommu-cells = <1>;
 		};
 
-		blsp1_i2c2: i2c@7577000 {
-			compatible = "qcom,i2c-qup-v2.2.1";
-			reg = <0x07577000 0x1000>;
-			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
-				<&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>;
-			clock-names = "iface", "core";
-			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&blsp1_i2c2_default>;
-			pinctrl-1 = <&blsp1_i2c2_sleep>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
+		lpass_q6_smmu: iommu@1600000 {
+			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
+			reg = <0x01600000 0x20000>;
+			#iommu-cells = <1>;
+			power-domains = <&gcc HLOS1_VOTE_LPASS_CORE_GDSC>;
+
+			#global-interrupts = <1>;
+			interrupts = <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 393 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 394 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_HLOS1_VOTE_LPASS_CORE_SMMU_CLK>,
+				 <&gcc GCC_HLOS1_VOTE_LPASS_ADSP_SMMU_CLK>;
+			clock-names = "iface", "bus";
 		};
 
-		blsp2_spi5: spi@75ba000{
-			compatible = "qcom,spi-qup-v2.2.1";
-			reg = <0x075ba000 0x600>;
-			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&gcc GCC_BLSP2_QUP6_SPI_APPS_CLK>,
-				 <&gcc GCC_BLSP2_AHB_CLK>;
-			clock-names = "core", "iface";
-			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&blsp2_spi5_default>;
-			pinctrl-1 = <&blsp2_spi5_sleep>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
+		stm@3002000 {
+			compatible = "arm,coresight-stm", "arm,primecell";
+			reg = <0x3002000 0x1000>,
+			      <0x8280000 0x180000>;
+			reg-names = "stm-base", "stm-stimulus-base";
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			out-ports {
+				port {
+					stm_out: endpoint {
+						remote-endpoint =
+						  <&funnel0_in>;
+					};
+				};
+			};
+		};
+
+		tpiu@3020000 {
+			compatible = "arm,coresight-tpiu", "arm,primecell";
+			reg = <0x3020000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			in-ports {
+				port {
+					tpiu_in: endpoint {
+						remote-endpoint =
+						  <&replicator_out1>;
+					};
+				};
+			};
 		};
 
-		sdhc2: sdhci@74a4900 {
-			 status = "disabled";
-			 compatible = "qcom,sdhci-msm-v4";
-			 reg = <0x074a4900 0x314>, <0x074a4000 0x800>;
-			 reg-names = "hc_mem", "core_mem";
+		funnel@3021000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0x3021000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
 
-			 interrupts = <0 125 IRQ_TYPE_LEVEL_HIGH>,
-				      <0 221 IRQ_TYPE_LEVEL_HIGH>;
-			 interrupt-names = "hc_irq", "pwr_irq";
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
 
-			 clock-names = "iface", "core", "xo";
-			 clocks = <&gcc GCC_SDCC2_AHB_CLK>,
-			 <&gcc GCC_SDCC2_APPS_CLK>,
-			 <&xo_board>;
-			 bus-width = <4>;
-		 };
+				port@7 {
+					reg = <7>;
+					funnel0_in: endpoint {
+						remote-endpoint =
+						  <&stm_out>;
+					};
+				};
+			};
 
-		msmgpio: pinctrl@1010000 {
-			compatible = "qcom,msm8996-pinctrl";
-			reg = <0x01010000 0x300000>;
-			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
+			out-ports {
+				port {
+					funnel0_out: endpoint {
+						remote-endpoint =
+						  <&merge_funnel_in0>;
+					};
+				};
+			};
 		};
 
-		timer@9840000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-			compatible = "arm,armv7-timer-mem";
-			reg = <0x09840000 0x1000>;
-			clock-frequency = <19200000>;
+		funnel@3022000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0x3022000 0x1000>;
 
-			frame@9850000 {
-				frame-number = <0>;
-				interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x09850000 0x1000>,
-				      <0x09860000 0x1000>;
-			};
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
 
-			frame@9870000 {
-				frame-number = <1>;
-				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x09870000 0x1000>;
-				status = "disabled";
-			};
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
 
-			frame@9880000 {
-				frame-number = <2>;
-				interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x09880000 0x1000>;
-				status = "disabled";
+				port@6 {
+					reg = <6>;
+					funnel1_in: endpoint {
+						remote-endpoint =
+						  <&apss_merge_funnel_out>;
+					};
+				};
 			};
 
-			frame@9890000 {
-				frame-number = <3>;
-				interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x09890000 0x1000>;
-				status = "disabled";
+			out-ports {
+				port {
+					funnel1_out: endpoint {
+						remote-endpoint =
+						  <&merge_funnel_in1>;
+					};
+				};
 			};
+		};
 
-			frame@98a0000 {
-				frame-number = <4>;
-				interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x098a0000 0x1000>;
-				status = "disabled";
-			};
+		funnel@3023000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0x3023000 0x1000>;
 
-			frame@98b0000 {
-				frame-number = <5>;
-				interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x098b0000 0x1000>;
-				status = "disabled";
-			};
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
 
-			frame@98c0000 {
-				frame-number = <6>;
-				interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x098c0000 0x1000>;
-				status = "disabled";
+
+			out-ports {
+				port {
+					funnel2_out: endpoint {
+						remote-endpoint =
+						  <&merge_funnel_in2>;
+					};
+				};
 			};
 		};
 
-		spmi_bus: qcom,spmi@400f000 {
-			compatible = "qcom,spmi-pmic-arb";
-			reg = <0x0400f000 0x1000>,
-			      <0x04400000 0x800000>,
-			      <0x04c00000 0x800000>,
-			      <0x05800000 0x200000>,
-			      <0x0400a000 0x002100>;
-			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
-			interrupt-names = "periph_irq";
-			interrupts = <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>;
-			qcom,ee = <0>;
-			qcom,channel = <0>;
-			#address-cells = <2>;
-			#size-cells = <0>;
-			interrupt-controller;
-			#interrupt-cells = <4>;
-		};
+		funnel@3025000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0x3025000 0x1000>;
 
-		ufsphy: phy@627000 {
-			compatible = "qcom,msm8996-ufs-phy-qmp-14nm";
-			reg = <0x00627000 0xda8>;
-			reg-names = "phy_mem";
-			#phy-cells = <0>;
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
 
-			clock-names = "ref_clk_src", "ref_clk";
-			clocks = <&rpmcc RPM_SMD_LN_BB_CLK>,
-				 <&gcc GCC_UFS_CLKREF_CLK>;
-			resets = <&ufshc 0>;
-			status = "disabled";
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					merge_funnel_in0: endpoint {
+						remote-endpoint =
+						  <&funnel0_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					merge_funnel_in1: endpoint {
+						remote-endpoint =
+						  <&funnel1_out>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+					merge_funnel_in2: endpoint {
+						remote-endpoint =
+						  <&funnel2_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					merge_funnel_out: endpoint {
+						remote-endpoint =
+						  <&etf_in>;
+					};
+				};
+			};
 		};
 
-		ufshc: ufshc@624000 {
-			compatible = "qcom,ufshc";
-			reg = <0x00624000 0x2500>;
-			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
+		replicator@3026000 {
+			compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
+			reg = <0x3026000 0x1000>;
 
-			phys = <&ufsphy>;
-			phy-names = "ufsphy";
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
 
-			power-domains = <&gcc UFS_GDSC>;
+			in-ports {
+				port {
+					replicator_in: endpoint {
+						remote-endpoint =
+						  <&etf_out>;
+					};
+				};
+			};
 
-			clock-names =
-				"core_clk_src",
-				"core_clk",
-				"bus_clk",
-				"bus_aggr_clk",
-				"iface_clk",
-				"core_clk_unipro_src",
-				"core_clk_unipro",
-				"core_clk_ice",
-				"ref_clk",
-				"tx_lane0_sync_clk",
-				"rx_lane0_sync_clk";
-			clocks =
-				<&gcc UFS_AXI_CLK_SRC>,
-				<&gcc GCC_UFS_AXI_CLK>,
-				<&gcc GCC_SYS_NOC_UFS_AXI_CLK>,
-				<&gcc GCC_AGGRE2_UFS_AXI_CLK>,
-				<&gcc GCC_UFS_AHB_CLK>,
-				<&gcc UFS_ICE_CORE_CLK_SRC>,
-				<&gcc GCC_UFS_UNIPRO_CORE_CLK>,
-				<&gcc GCC_UFS_ICE_CORE_CLK>,
-				<&rpmcc RPM_SMD_LN_BB_CLK>,
-				<&gcc GCC_UFS_TX_SYMBOL_0_CLK>,
-				<&gcc GCC_UFS_RX_SYMBOL_0_CLK>;
-			freq-table-hz =
-				<100000000 200000000>,
-				<0 0>,
-				<0 0>,
-				<0 0>,
-				<0 0>,
-				<150000000 300000000>,
-				<0 0>,
-				<0 0>,
-				<0 0>,
-				<0 0>,
-				<0 0>;
+			out-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
 
-			lanes-per-direction = <1>;
-			#reset-cells = <1>;
-			status = "disabled";
+				port@0 {
+					reg = <0>;
+					replicator_out0: endpoint {
+						remote-endpoint =
+						  <&etr_in>;
+					};
+				};
 
-			ufs_variant {
-				compatible = "qcom,ufs_variant";
+				port@1 {
+					reg = <1>;
+					replicator_out1: endpoint {
+						remote-endpoint =
+						  <&tpiu_in>;
+					};
+				};
 			};
 		};
 
-		mmcc: clock-controller@8c0000 {
-			compatible = "qcom,mmcc-msm8996";
-			#clock-cells = <1>;
-			#reset-cells = <1>;
-			#power-domain-cells = <1>;
-			reg = <0x008c0000 0x40000>;
-			assigned-clocks = <&mmcc MMPLL9_PLL>,
-					  <&mmcc MMPLL1_PLL>,
-					  <&mmcc MMPLL3_PLL>,
-					  <&mmcc MMPLL4_PLL>,
-					  <&mmcc MMPLL5_PLL>;
-			assigned-clock-rates = <624000000>,
-					       <810000000>,
-					       <980000000>,
-					       <960000000>,
-					       <825000000>;
-		};
+		etf@3027000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0x3027000 0x1000>;
 
-		qfprom@74000 {
-			compatible = "qcom,qfprom";
-			reg = <0x00074000 0x8ff>;
-			#address-cells = <1>;
-			#size-cells = <1>;
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
 
-			qusb2p_hstx_trim: hstx_trim@24e {
-				reg = <0x24e 0x2>;
-				bits = <5 4>;
+			in-ports {
+				port {
+					etf_in: endpoint {
+						remote-endpoint =
+						  <&merge_funnel_out>;
+					};
+				};
 			};
 
-			qusb2s_hstx_trim: hstx_trim@24f {
-				reg = <0x24f 0x1>;
-				bits = <1 4>;
+			out-ports {
+				port {
+					etf_out: endpoint {
+						remote-endpoint =
+						  <&replicator_in>;
+					};
+				};
 			};
+		};
 
-			gpu_speed_bin: gpu_speed_bin@133 {
-				reg = <0x133 0x1>;
-				bits = <5 3>;
+		etr@3028000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0x3028000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+			arm,scatter-gather;
+
+			in-ports {
+				port {
+					etr_in: endpoint {
+						remote-endpoint =
+						  <&replicator_out0>;
+					};
+				};
 			};
 		};
 
-		pcie_phy: phy@34000 {
-			compatible = "qcom,msm8996-qmp-pcie-phy";
-			reg = <0x00034000 0x488>;
-			#clock-cells = <1>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
+		debug@3810000 {
+			compatible = "arm,coresight-cpu-debug", "arm,primecell";
+			reg = <0x3810000 0x1000>;
 
-			clocks = <&gcc GCC_PCIE_PHY_AUX_CLK>,
-				<&gcc GCC_PCIE_PHY_CFG_AHB_CLK>,
-				<&gcc GCC_PCIE_CLKREF_CLK>;
-			clock-names = "aux", "cfg_ahb", "ref";
+			clocks = <&rpmcc RPM_QDSS_CLK>;
+			clock-names = "apb_pclk";
 
-			resets = <&gcc GCC_PCIE_PHY_BCR>,
-				<&gcc GCC_PCIE_PHY_COM_BCR>,
-				<&gcc GCC_PCIE_PHY_COM_NOCSR_BCR>;
-			reset-names = "phy", "common", "cfg";
-			status = "disabled";
+			cpu = <&CPU0>;
+		};
 
-			pciephy_0: lane@35000 {
-				reg = <0x00035000 0x130>,
-				      <0x00035200 0x200>,
-				      <0x00035400 0x1dc>;
-				#phy-cells = <0>;
+		etm@3840000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x3840000 0x1000>;
 
-				clock-output-names = "pcie_0_pipe_clk_src";
-				clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
-				clock-names = "pipe0";
-				resets = <&gcc GCC_PCIE_0_PHY_BCR>;
-				reset-names = "lane0";
-			};
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
 
-			pciephy_1: lane@36000 {
-				reg = <0x00036000 0x130>,
-				      <0x00036200 0x200>,
-				      <0x00036400 0x1dc>;
-				#phy-cells = <0>;
+			cpu = <&CPU0>;
 
-				clock-output-names = "pcie_1_pipe_clk_src";
-				clocks = <&gcc GCC_PCIE_1_PIPE_CLK>;
-				clock-names = "pipe1";
-				resets = <&gcc GCC_PCIE_1_PHY_BCR>;
-				reset-names = "lane1";
+			out-ports {
+				port {
+					etm0_out: endpoint {
+						remote-endpoint =
+						  <&apss_funnel0_in0>;
+					};
+				};
 			};
+		};
 
-			pciephy_2: lane@37000 {
-				reg = <0x00037000 0x130>,
-				      <0x00037200 0x200>,
-				      <0x00037400 0x1dc>;
-				#phy-cells = <0>;
+		debug@3910000 {
+			compatible = "arm,coresight-cpu-debug", "arm,primecell";
+			reg = <0x3910000 0x1000>;
 
-				clock-output-names = "pcie_2_pipe_clk_src";
-				clocks = <&gcc GCC_PCIE_2_PIPE_CLK>;
-				clock-names = "pipe2";
-				resets = <&gcc GCC_PCIE_2_PHY_BCR>;
-				reset-names = "lane2";
-			};
-		};
+			clocks = <&rpmcc RPM_QDSS_CLK>;
+			clock-names = "apb_pclk";
 
-		usb3phy: phy@7410000 {
-			compatible = "qcom,msm8996-qmp-usb3-phy";
-			reg = <0x07410000 0x1c4>;
-			#clock-cells = <1>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
+			cpu = <&CPU1>;
+		};
 
-			clocks = <&gcc GCC_USB3_PHY_AUX_CLK>,
-				<&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
-				<&gcc GCC_USB3_CLKREF_CLK>;
-			clock-names = "aux", "cfg_ahb", "ref";
+		etm@3940000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x3940000 0x1000>;
 
-			resets = <&gcc GCC_USB3_PHY_BCR>,
-				<&gcc GCC_USB3PHY_PHY_BCR>;
-			reset-names = "phy", "common";
-			status = "disabled";
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
 
-			ssusb_phy_0: lane@7410200 {
-				reg = <0x07410200 0x200>,
-				      <0x07410400 0x130>,
-				      <0x07410600 0x1a8>;
-				#phy-cells = <0>;
+			cpu = <&CPU1>;
 
-				clock-output-names = "usb3_phy_pipe_clk_src";
-				clocks = <&gcc GCC_USB3_PHY_PIPE_CLK>;
-				clock-names = "pipe0";
+			out-ports {
+				port {
+					etm1_out: endpoint {
+						remote-endpoint =
+						  <&apss_funnel0_in1>;
+					};
+				};
 			};
 		};
 
-		hsusb_phy1: phy@7411000 {
-			compatible = "qcom,msm8996-qusb2-phy";
-			reg = <0x07411000 0x180>;
-			#phy-cells = <0>;
+		funnel@39b0000 { /* APSS Funnel 0 */
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0x39b0000 0x1000>;
 
-			clocks = <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
-				<&gcc GCC_RX1_USB2_CLKREF_CLK>;
-			clock-names = "cfg_ahb", "ref";
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
 
-			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
-			nvmem-cells = <&qusb2p_hstx_trim>;
-			status = "disabled";
-		};
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
 
-		hsusb_phy2: phy@7412000 {
-			compatible = "qcom,msm8996-qusb2-phy";
-			reg = <0x07412000 0x180>;
-			#phy-cells = <0>;
+				port@0 {
+					reg = <0>;
+					apss_funnel0_in0: endpoint {
+						remote-endpoint = <&etm0_out>;
+					};
+				};
 
-			clocks = <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
-				<&gcc GCC_RX2_USB2_CLKREF_CLK>;
-			clock-names = "cfg_ahb", "ref";
+				port@1 {
+					reg = <1>;
+					apss_funnel0_in1: endpoint {
+						remote-endpoint = <&etm1_out>;
+					};
+				};
+			};
 
-			resets = <&gcc GCC_QUSB2PHY_SEC_BCR>;
-			nvmem-cells = <&qusb2s_hstx_trim>;
-			status = "disabled";
+			out-ports {
+				port {
+					apss_funnel0_out: endpoint {
+						remote-endpoint =
+						  <&apss_merge_funnel_in0>;
+					};
+				};
+			};
 		};
 
-		usb2: usb@76f8800 {
-			compatible = "qcom,msm8996-dwc3", "qcom,dwc3";
-			reg = <0x076f8800 0x400>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
+		debug@3a10000 {
+			compatible = "arm,coresight-cpu-debug", "arm,primecell";
+			reg = <0x3a10000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			cpu = <&CPU2>;
+		};
 
-			clocks = <&gcc GCC_PERIPH_NOC_USB20_AHB_CLK>,
-				<&gcc GCC_USB20_MASTER_CLK>,
-				<&gcc GCC_USB20_MOCK_UTMI_CLK>,
-				<&gcc GCC_USB20_SLEEP_CLK>,
-				<&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>;
+		etm@3a40000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x3a40000 0x1000>;
 
-			assigned-clocks = <&gcc GCC_USB20_MOCK_UTMI_CLK>,
-					  <&gcc GCC_USB20_MASTER_CLK>;
-			assigned-clock-rates = <19200000>, <60000000>;
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
 
-			power-domains = <&gcc USB30_GDSC>;
-			status = "disabled";
+			cpu = <&CPU2>;
 
-			dwc3@7600000 {
-				compatible = "snps,dwc3";
-				reg = <0x07600000 0xcc00>;
-				interrupts = <0 138 IRQ_TYPE_LEVEL_HIGH>;
-				phys = <&hsusb_phy2>;
-				phy-names = "usb2-phy";
+			out-ports {
+				port {
+					etm2_out: endpoint {
+						remote-endpoint =
+						  <&apss_funnel1_in0>;
+					};
+				};
 			};
 		};
 
-		usb3: usb@6af8800 {
-			compatible = "qcom,msm8996-dwc3", "qcom,dwc3";
-			reg = <0x06af8800 0x400>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
+		debug@3b10000 {
+			compatible = "arm,coresight-cpu-debug", "arm,primecell";
+			reg = <0x3b10000 0x1000>;
 
-			clocks = <&gcc GCC_SYS_NOC_USB3_AXI_CLK>,
-				<&gcc GCC_USB30_MASTER_CLK>,
-				<&gcc GCC_AGGRE2_USB3_AXI_CLK>,
-				<&gcc GCC_USB30_MOCK_UTMI_CLK>,
-				<&gcc GCC_USB30_SLEEP_CLK>,
-				<&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>;
+			clocks = <&rpmcc RPM_QDSS_CLK>;
+			clock-names = "apb_pclk";
 
-			assigned-clocks = <&gcc GCC_USB30_MOCK_UTMI_CLK>,
-					  <&gcc GCC_USB30_MASTER_CLK>;
-			assigned-clock-rates = <19200000>, <120000000>;
+			cpu = <&CPU3>;
+		};
 
-			power-domains = <&gcc USB30_GDSC>;
-			status = "disabled";
+		etm@3b40000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x3b40000 0x1000>;
 
-			dwc3@6a00000 {
-				compatible = "snps,dwc3";
-				reg = <0x06a00000 0xcc00>;
-				interrupts = <0 131 IRQ_TYPE_LEVEL_HIGH>;
-				phys = <&hsusb_phy1>, <&ssusb_phy_0>;
-				phy-names = "usb2-phy", "usb3-phy";
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			cpu = <&CPU3>;
+
+			out-ports {
+				port {
+					etm3_out: endpoint {
+						remote-endpoint =
+						  <&apss_funnel1_in1>;
+					};
+				};
 			};
 		};
 
-		vfe_smmu: iommu@da0000 {
-			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
-			reg = <0x00da0000 0x10000>;
+		funnel@3bb0000 { /* APSS Funnel 1 */
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0x3bb0000 0x1000>;
 
-			#global-interrupts = <1>;
-			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>;
-			power-domains = <&mmcc MMAGIC_CAMSS_GDSC>;
-			clocks = <&mmcc SMMU_VFE_AHB_CLK>,
-				 <&mmcc SMMU_VFE_AXI_CLK>;
-			clock-names = "iface",
-				      "bus";
-			#iommu-cells = <1>;
-		};
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
 
-		camss: camss@a00000 {
-			compatible = "qcom,msm8996-camss";
-			reg = <0x00a34000 0x1000>,
-			      <0x00a00030 0x4>,
-			      <0x00a35000 0x1000>,
-			      <0x00a00038 0x4>,
-			      <0x00a36000 0x1000>,
-			      <0x00a00040 0x4>,
-			      <0x00a30000 0x100>,
-			      <0x00a30400 0x100>,
-			      <0x00a30800 0x100>,
-			      <0x00a30c00 0x100>,
-			      <0x00a31000 0x500>,
-			      <0x00a00020 0x10>,
-			      <0x00a10000 0x1000>,
-			      <0x00a14000 0x1000>;
-			reg-names = "csiphy0",
-				"csiphy0_clk_mux",
-				"csiphy1",
-				"csiphy1_clk_mux",
-				"csiphy2",
-				"csiphy2_clk_mux",
-				"csid0",
-				"csid1",
-				"csid2",
-				"csid3",
-				"ispif",
-				"csi_clk_mux",
-				"vfe0",
-				"vfe1";
-			interrupts = <GIC_SPI 78 0>,
-				<GIC_SPI 79 0>,
-				<GIC_SPI 80 0>,
-				<GIC_SPI 296 0>,
-				<GIC_SPI 297 0>,
-				<GIC_SPI 298 0>,
-				<GIC_SPI 299 0>,
-				<GIC_SPI 309 0>,
-				<GIC_SPI 314 0>,
-				<GIC_SPI 315 0>;
-			interrupt-names = "csiphy0",
-				"csiphy1",
-				"csiphy2",
-				"csid0",
-				"csid1",
-				"csid2",
-				"csid3",
-				"ispif",
-				"vfe0",
-				"vfe1";
-			power-domains = <&mmcc VFE0_GDSC>;
-			clocks = <&mmcc CAMSS_TOP_AHB_CLK>,
-				<&mmcc CAMSS_ISPIF_AHB_CLK>,
-				<&mmcc CAMSS_CSI0PHYTIMER_CLK>,
-				<&mmcc CAMSS_CSI1PHYTIMER_CLK>,
-				<&mmcc CAMSS_CSI2PHYTIMER_CLK>,
-				<&mmcc CAMSS_CSI0_AHB_CLK>,
-				<&mmcc CAMSS_CSI0_CLK>,
-				<&mmcc CAMSS_CSI0PHY_CLK>,
-				<&mmcc CAMSS_CSI0PIX_CLK>,
-				<&mmcc CAMSS_CSI0RDI_CLK>,
-				<&mmcc CAMSS_CSI1_AHB_CLK>,
-				<&mmcc CAMSS_CSI1_CLK>,
-				<&mmcc CAMSS_CSI1PHY_CLK>,
-				<&mmcc CAMSS_CSI1PIX_CLK>,
-				<&mmcc CAMSS_CSI1RDI_CLK>,
-				<&mmcc CAMSS_CSI2_AHB_CLK>,
-				<&mmcc CAMSS_CSI2_CLK>,
-				<&mmcc CAMSS_CSI2PHY_CLK>,
-				<&mmcc CAMSS_CSI2PIX_CLK>,
-				<&mmcc CAMSS_CSI2RDI_CLK>,
-				<&mmcc CAMSS_CSI3_AHB_CLK>,
-				<&mmcc CAMSS_CSI3_CLK>,
-				<&mmcc CAMSS_CSI3PHY_CLK>,
-				<&mmcc CAMSS_CSI3PIX_CLK>,
-				<&mmcc CAMSS_CSI3RDI_CLK>,
-				<&mmcc CAMSS_AHB_CLK>,
-				<&mmcc CAMSS_VFE0_CLK>,
-				<&mmcc CAMSS_CSI_VFE0_CLK>,
-				<&mmcc CAMSS_VFE0_AHB_CLK>,
-				<&mmcc CAMSS_VFE0_STREAM_CLK>,
-				<&mmcc CAMSS_VFE1_CLK>,
-				<&mmcc CAMSS_CSI_VFE1_CLK>,
-				<&mmcc CAMSS_VFE1_AHB_CLK>,
-				<&mmcc CAMSS_VFE1_STREAM_CLK>,
-				<&mmcc CAMSS_VFE_AHB_CLK>,
-				<&mmcc CAMSS_VFE_AXI_CLK>;
-			clock-names = "top_ahb",
-				"ispif_ahb",
-				"csiphy0_timer",
-				"csiphy1_timer",
-				"csiphy2_timer",
-				"csi0_ahb",
-				"csi0",
-				"csi0_phy",
-				"csi0_pix",
-				"csi0_rdi",
-				"csi1_ahb",
-				"csi1",
-				"csi1_phy",
-				"csi1_pix",
-				"csi1_rdi",
-				"csi2_ahb",
-				"csi2",
-				"csi2_phy",
-				"csi2_pix",
-				"csi2_rdi",
-				"csi3_ahb",
-				"csi3",
-				"csi3_phy",
-				"csi3_pix",
-				"csi3_rdi",
-				"ahb",
-				"vfe0",
-				"csi_vfe0",
-				"vfe0_ahb",
-				"vfe0_stream",
-				"vfe1",
-				"csi_vfe1",
-				"vfe1_ahb",
-				"vfe1_stream",
-				"vfe_ahb",
-				"vfe_axi";
-			iommus = <&vfe_smmu 0>,
-				 <&vfe_smmu 1>,
-				 <&vfe_smmu 2>,
-				 <&vfe_smmu 3>;
-			status = "disabled";
-			ports {
+			in-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
-			};
-		};
-
-		adreno_smmu: iommu@b40000 {
-			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
-			reg = <0x00b40000 0x10000>;
 
-			#global-interrupts = <1>;
-			interrupts = <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>;
-			#iommu-cells = <1>;
+				port@0 {
+					reg = <0>;
+					apss_funnel1_in0: endpoint {
+						remote-endpoint = <&etm2_out>;
+					};
+				};
 
-			clocks = <&mmcc GPU_AHB_CLK>,
-				 <&gcc GCC_MMSS_BIMC_GFX_CLK>;
-			clock-names = "iface", "bus";
+				port@1 {
+					reg = <1>;
+					apss_funnel1_in1: endpoint {
+						remote-endpoint = <&etm3_out>;
+					};
+				};
+			};
 
-			power-domains = <&mmcc GPU_GDSC>;
+			out-ports {
+				port {
+					apss_funnel1_out: endpoint {
+						remote-endpoint =
+						  <&apss_merge_funnel_in1>;
+					};
+				};
+			};
 		};
 
-		mdp_smmu: iommu@d00000 {
-			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
-			reg = <0x00d00000 0x10000>;
+		funnel@3bc0000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0x3bc0000 0x1000>;
 
-			#global-interrupts = <1>;
-			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>;
-			#iommu-cells = <1>;
-			clocks = <&mmcc SMMU_MDP_AHB_CLK>,
-				 <&mmcc SMMU_MDP_AXI_CLK>;
-			clock-names = "iface", "bus";
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
 
-			power-domains = <&mmcc MDSS_GDSC>;
-		};
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
 
-		lpass_q6_smmu: iommu@1600000 {
-			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
-			reg = <0x01600000 0x20000>;
-			#iommu-cells = <1>;
-			power-domains = <&gcc HLOS1_VOTE_LPASS_CORE_GDSC>;
+				port@0 {
+					reg = <0>;
+					apss_merge_funnel_in0: endpoint {
+						remote-endpoint =
+						  <&apss_funnel0_out>;
+					};
+				};
 
-			#global-interrupts = <1>;
-			interrupts = <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
-		                <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>,
-		                <GIC_SPI 393 IRQ_TYPE_LEVEL_HIGH>,
-		                <GIC_SPI 394 IRQ_TYPE_LEVEL_HIGH>,
-		                <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
-		                <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
-		                <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
-		                <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
-		                <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
-		                <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
-		                <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
-		                <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
-		                <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>;
+				port@1 {
+					reg = <1>;
+					apss_merge_funnel_in1: endpoint {
+						remote-endpoint =
+						  <&apss_funnel1_out>;
+					};
+				};
+			};
 
-			clocks = <&gcc GCC_HLOS1_VOTE_LPASS_CORE_SMMU_CLK>,
-				 <&gcc GCC_HLOS1_VOTE_LPASS_ADSP_SMMU_CLK>;
-			clock-names = "iface", "bus";
+			out-ports {
+				port {
+					apss_merge_funnel_out: endpoint {
+						remote-endpoint =
+						  <&funnel1_in>;
+					};
+				};
+			};
+		};
+		kryocc: clock-controller@6400000 {
+			compatible = "qcom,apcc-msm8996";
+			reg = <0x06400000 0x90000>;
+			#clock-cells = <1>;
 		};
 
-		agnoc@0 {
-			power-domains = <&gcc AGGRE0_NOC_GDSC>;
-			compatible = "simple-pm-bus";
+		usb3: usb@6af8800 {
+			compatible = "qcom,msm8996-dwc3", "qcom,dwc3";
+			reg = <0x06af8800 0x400>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
 
-			pcie0: pcie@600000 {
-				compatible = "qcom,pcie-msm8996", "snps,dw-pcie";
-				status = "disabled";
-				power-domains = <&gcc PCIE0_GDSC>;
-				bus-range = <0x00 0xff>;
-				num-lanes = <1>;
-
-				reg = <0x00600000 0x2000>,
-				      <0x0c000000 0xf1d>,
-				      <0x0c000f20 0xa8>,
-				      <0x0c100000 0x100000>;
-				reg-names = "parf", "dbi", "elbi","config";
+			clocks = <&gcc GCC_SYS_NOC_USB3_AXI_CLK>,
+				<&gcc GCC_USB30_MASTER_CLK>,
+				<&gcc GCC_AGGRE2_USB3_AXI_CLK>,
+				<&gcc GCC_USB30_MOCK_UTMI_CLK>,
+				<&gcc GCC_USB30_SLEEP_CLK>,
+				<&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>;
 
-				phys = <&pciephy_0>;
-				phy-names = "pciephy";
+			assigned-clocks = <&gcc GCC_USB30_MOCK_UTMI_CLK>,
+					  <&gcc GCC_USB30_MASTER_CLK>;
+			assigned-clock-rates = <19200000>, <120000000>;
 
-				#address-cells = <3>;
-				#size-cells = <2>;
-				ranges = <0x01000000 0x0 0x0c200000 0x0c200000 0x0 0x100000>,
-					<0x02000000 0x0 0x0c300000 0x0c300000 0x0 0xd00000>;
+			power-domains = <&gcc USB30_GDSC>;
+			status = "disabled";
 
-				interrupts = <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names = "msi";
-				#interrupt-cells = <1>;
-				interrupt-map-mask = <0 0 0 0x7>;
-				interrupt-map = <0 0 0 1 &intc 0 244 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
-						<0 0 0 2 &intc 0 245 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
-						<0 0 0 3 &intc 0 247 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
-						<0 0 0 4 &intc 0 248 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+			dwc3@6a00000 {
+				compatible = "snps,dwc3";
+				reg = <0x06a00000 0xcc00>;
+				interrupts = <0 131 IRQ_TYPE_LEVEL_HIGH>;
+				phys = <&hsusb_phy1>, <&ssusb_phy_0>;
+				phy-names = "usb2-phy", "usb3-phy";
+			};
+		};
 
-				pinctrl-names = "default", "sleep";
-				pinctrl-0 = <&pcie0_clkreq_default &pcie0_perst_default &pcie0_wake_default>;
-				pinctrl-1 = <&pcie0_clkreq_sleep &pcie0_perst_default &pcie0_wake_sleep>;
+		usb3phy: phy@7410000 {
+			compatible = "qcom,msm8996-qmp-usb3-phy";
+			reg = <0x07410000 0x1c4>;
+			#clock-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
 
-				linux,pci-domain = <0>;
+			clocks = <&gcc GCC_USB3_PHY_AUX_CLK>,
+				<&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
+				<&gcc GCC_USB3_CLKREF_CLK>;
+			clock-names = "aux", "cfg_ahb", "ref";
 
-				clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
-					<&gcc GCC_PCIE_0_AUX_CLK>,
-					<&gcc GCC_PCIE_0_CFG_AHB_CLK>,
-					<&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
-					<&gcc GCC_PCIE_0_SLV_AXI_CLK>;
+			resets = <&gcc GCC_USB3_PHY_BCR>,
+				<&gcc GCC_USB3PHY_PHY_BCR>;
+			reset-names = "phy", "common";
+			status = "disabled";
 
-				clock-names =  "pipe",
-						"aux",
-						"cfg",
-						"bus_master",
-						"bus_slave";
+			ssusb_phy_0: lane@7410200 {
+				reg = <0x07410200 0x200>,
+				      <0x07410400 0x130>,
+				      <0x07410600 0x1a8>;
+				#phy-cells = <0>;
 
+				clock-output-names = "usb3_phy_pipe_clk_src";
+				clocks = <&gcc GCC_USB3_PHY_PIPE_CLK>;
+				clock-names = "pipe0";
 			};
+		};
 
-			pcie1: pcie@608000 {
-				compatible = "qcom,pcie-msm8996", "snps,dw-pcie";
-				power-domains = <&gcc PCIE1_GDSC>;
-				bus-range = <0x00 0xff>;
-				num-lanes = <1>;
+		hsusb_phy1: phy@7411000 {
+			compatible = "qcom,msm8996-qusb2-phy";
+			reg = <0x07411000 0x180>;
+			#phy-cells = <0>;
 
-				status  = "disabled";
+			clocks = <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
+				<&gcc GCC_RX1_USB2_CLKREF_CLK>;
+			clock-names = "cfg_ahb", "ref";
 
-				reg = <0x00608000 0x2000>,
-				      <0x0d000000 0xf1d>,
-				      <0x0d000f20 0xa8>,
-				      <0x0d100000 0x100000>;
+			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
+			nvmem-cells = <&qusb2p_hstx_trim>;
+			status = "disabled";
+		};
 
-				reg-names = "parf", "dbi", "elbi","config";
+		hsusb_phy2: phy@7412000 {
+			compatible = "qcom,msm8996-qusb2-phy";
+			reg = <0x07412000 0x180>;
+			#phy-cells = <0>;
 
-				phys = <&pciephy_1>;
-				phy-names = "pciephy";
+			clocks = <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
+				<&gcc GCC_RX2_USB2_CLKREF_CLK>;
+			clock-names = "cfg_ahb", "ref";
 
-				#address-cells = <3>;
-				#size-cells = <2>;
-				ranges = <0x01000000 0x0 0x0d200000 0x0d200000 0x0 0x100000>,
-					<0x02000000 0x0 0x0d300000 0x0d300000 0x0 0xd00000>;
+			resets = <&gcc GCC_QUSB2PHY_SEC_BCR>;
+			nvmem-cells = <&qusb2s_hstx_trim>;
+			status = "disabled";
+		};
 
-				interrupts = <GIC_SPI 413 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names = "msi";
-				#interrupt-cells = <1>;
-				interrupt-map-mask = <0 0 0 0x7>;
-				interrupt-map = <0 0 0 1 &intc 0 272 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
-						<0 0 0 2 &intc 0 273 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
-						<0 0 0 3 &intc 0 274 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
-						<0 0 0 4 &intc 0 275 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+		sdhc2: sdhci@74a4900 {
+			 status = "disabled";
+			 compatible = "qcom,sdhci-msm-v4";
+			 reg = <0x074a4900 0x314>, <0x074a4000 0x800>;
+			 reg-names = "hc_mem", "core_mem";
 
-				pinctrl-names = "default", "sleep";
-				pinctrl-0 = <&pcie1_clkreq_default &pcie1_perst_default &pcie1_wake_default>;
-				pinctrl-1 = <&pcie1_clkreq_sleep &pcie1_perst_default &pcie1_wake_sleep>;
+			 interrupts = <0 125 IRQ_TYPE_LEVEL_HIGH>,
+				      <0 221 IRQ_TYPE_LEVEL_HIGH>;
+			 interrupt-names = "hc_irq", "pwr_irq";
 
-				linux,pci-domain = <1>;
+			 clock-names = "iface", "core", "xo";
+			 clocks = <&gcc GCC_SDCC2_AHB_CLK>,
+			 <&gcc GCC_SDCC2_APPS_CLK>,
+			 <&xo_board>;
+			 bus-width = <4>;
+		 };
+
+		blsp1_uart1: serial@7570000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x07570000 0x1000>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			status = "disabled";
+		};
+
+		blsp1_spi0: spi@7575000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x07575000 0x600>;
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_QUP1_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp1_spi0_default>;
+			pinctrl-1 = <&blsp1_spi0_sleep>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
 
-				clocks = <&gcc GCC_PCIE_1_PIPE_CLK>,
-					<&gcc GCC_PCIE_1_AUX_CLK>,
-					<&gcc GCC_PCIE_1_CFG_AHB_CLK>,
-					<&gcc GCC_PCIE_1_MSTR_AXI_CLK>,
-					<&gcc GCC_PCIE_1_SLV_AXI_CLK>;
+		blsp1_i2c2: i2c@7577000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x07577000 0x1000>;
+			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
+				<&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>;
+			clock-names = "iface", "core";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp1_i2c2_default>;
+			pinctrl-1 = <&blsp1_i2c2_sleep>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
 
-				clock-names =  "pipe",
-						"aux",
-						"cfg",
-						"bus_master",
-						"bus_slave";
-			};
+		blsp2_uart1: serial@75b0000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x075b0000 0x1000>;
+			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP2_UART2_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			status = "disabled";
+		};
 
-			pcie2: pcie@610000 {
-				compatible = "qcom,pcie-msm8996", "snps,dw-pcie";
-				power-domains = <&gcc PCIE2_GDSC>;
-				bus-range = <0x00 0xff>;
-				num-lanes = <1>;
-				status = "disabled";
-				reg = <0x00610000 0x2000>,
-				      <0x0e000000 0xf1d>,
-				      <0x0e000f20 0xa8>,
-				      <0x0e100000 0x100000>;
+		blsp2_uart2: serial@75b1000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x075b1000 0x1000>;
+			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP2_UART3_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			status = "disabled";
+		};
 
-				reg-names = "parf", "dbi", "elbi","config";
+		blsp2_i2c0: i2c@75b5000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x075b5000 0x1000>;
+			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP2_AHB_CLK>,
+				<&gcc GCC_BLSP2_QUP1_I2C_APPS_CLK>;
+			clock-names = "iface", "core";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp2_i2c0_default>;
+			pinctrl-1 = <&blsp2_i2c0_sleep>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
 
-				phys = <&pciephy_2>;
-				phy-names = "pciephy";
+		blsp2_i2c1: i2c@75b6000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x075b6000 0x1000>;
+			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP2_AHB_CLK>,
+				<&gcc GCC_BLSP2_QUP2_I2C_APPS_CLK>;
+			clock-names = "iface", "core";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp2_i2c1_default>;
+			pinctrl-1 = <&blsp2_i2c1_sleep>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
 
-				#address-cells = <3>;
-				#size-cells = <2>;
-				ranges = <0x01000000 0x0 0x0e200000 0x0e200000 0x0 0x100000>,
-					<0x02000000 0x0 0x0e300000 0x0e300000 0x0 0x1d00000>;
+		blsp2_spi5: spi@75ba000{
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x075ba000 0x600>;
+			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP2_QUP6_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp2_spi5_default>;
+			pinctrl-1 = <&blsp2_spi5_sleep>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
 
-				device_type = "pci";
+		usb2: usb@76f8800 {
+			compatible = "qcom,msm8996-dwc3", "qcom,dwc3";
+			reg = <0x076f8800 0x400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
 
-				interrupts = <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names = "msi";
-				#interrupt-cells = <1>;
-				interrupt-map-mask = <0 0 0 0x7>;
-				interrupt-map = <0 0 0 1 &intc 0 142 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
-						<0 0 0 2 &intc 0 143 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
-						<0 0 0 3 &intc 0 144 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
-						<0 0 0 4 &intc 0 145 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+			clocks = <&gcc GCC_PERIPH_NOC_USB20_AHB_CLK>,
+				<&gcc GCC_USB20_MASTER_CLK>,
+				<&gcc GCC_USB20_MOCK_UTMI_CLK>,
+				<&gcc GCC_USB20_SLEEP_CLK>,
+				<&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>;
 
-				pinctrl-names = "default", "sleep";
-				pinctrl-0 = <&pcie2_clkreq_default &pcie2_perst_default &pcie2_wake_default>;
-				pinctrl-1 = <&pcie2_clkreq_sleep &pcie2_perst_default &pcie2_wake_sleep >;
+			assigned-clocks = <&gcc GCC_USB20_MOCK_UTMI_CLK>,
+					  <&gcc GCC_USB20_MASTER_CLK>;
+			assigned-clock-rates = <19200000>, <60000000>;
 
-				linux,pci-domain = <2>;
-				clocks = <&gcc GCC_PCIE_2_PIPE_CLK>,
-					<&gcc GCC_PCIE_2_AUX_CLK>,
-					<&gcc GCC_PCIE_2_CFG_AHB_CLK>,
-					<&gcc GCC_PCIE_2_MSTR_AXI_CLK>,
-					<&gcc GCC_PCIE_2_SLV_AXI_CLK>;
+			power-domains = <&gcc USB30_GDSC>;
+			status = "disabled";
 
-				clock-names =  "pipe",
-						"aux",
-						"cfg",
-						"bus_master",
-						"bus_slave";
+			dwc3@7600000 {
+				compatible = "snps,dwc3";
+				reg = <0x07600000 0xcc00>;
+				interrupts = <0 138 IRQ_TYPE_LEVEL_HIGH>;
+				phys = <&hsusb_phy2>;
+				phy-names = "usb2-phy";
 			};
 		};
 
-		slimbam:dma@9184000
-		{
+		slimbam: dma@9184000 {
 			compatible = "qcom,bam-v1.7.0";
 			qcom,controlled-remotely;
 			reg = <0x09184000 0x32000>;
@@ -1935,459 +1945,445 @@
 			reg = <0x091c0000 0x2C000>;
 			reg-names = "ctrl";
 			interrupts = <0 163 IRQ_TYPE_LEVEL_HIGH>;
-			dmas =	<&slimbam 3>, <&slimbam 4>,
-				<&slimbam 5>, <&slimbam 6>;
-			dma-names = "rx", "tx", "tx2", "rx2";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			ngd@1 {
-				reg = <1>;
-				#address-cells = <1>;
-				#size-cells = <1>;
-
-				tasha_ifd: tas-ifd {
-					compatible = "slim217,1a0";
-					reg  = <0 0>;
-				};
-
-				wcd9335: codec@1{
-					pinctrl-0 = <&cdc_reset_active &wcd_intr_default>;
-					pinctrl-names = "default";
-
-					compatible = "slim217,1a0";
-					reg  = <1 0>;
-
-					interrupt-parent = <&msmgpio>;
-					interrupts = <54 IRQ_TYPE_LEVEL_HIGH>,
-						     <53 IRQ_TYPE_LEVEL_HIGH>;
-					interrupt-names  = "intr1", "intr2";
-					interrupt-controller;
-					#interrupt-cells = <1>;
-					reset-gpios = <&msmgpio 64 0>;
-
-					slim-ifc-dev  = <&tasha_ifd>;
-
-					#sound-dai-cells = <1>;
-				};
-			};
-		};
-
-		gpu@b00000 {
-			compatible = "qcom,adreno-530.2", "qcom,adreno";
-			#stream-id-cells = <16>;
-
-			reg = <0x00b00000 0x3f000>;
-			reg-names = "kgsl_3d0_reg_memory";
-
-			interrupts = <0 300 IRQ_TYPE_LEVEL_HIGH>;
-
-			clocks = <&mmcc GPU_GX_GFX3D_CLK>,
-				<&mmcc GPU_AHB_CLK>,
-				<&mmcc GPU_GX_RBBMTIMER_CLK>,
-				<&gcc GCC_BIMC_GFX_CLK>,
-				<&gcc GCC_MMSS_BIMC_GFX_CLK>;
-
-			clock-names = "core",
-				"iface",
-				"rbbmtimer",
-				"mem",
-				"mem_iface";
-
-			power-domains = <&mmcc GPU_GDSC>;
-			iommus = <&adreno_smmu 0>;
-
-			nvmem-cells = <&gpu_speed_bin>;
-			nvmem-cell-names = "speed_bin";
-
-			qcom,gpu-quirk-two-pass-use-wfi;
-			qcom,gpu-quirk-fault-detect-mask;
-
-			operating-points-v2 = <&gpu_opp_table>;
-
-			gpu_opp_table: opp-table {
-				compatible  ="operating-points-v2";
-
-				/*
-				 * 624Mhz and 560Mhz are only available on speed
-				 * bin (1 << 0). All the rest are available on
-				 * all bins of the hardware
-				 */
-				opp-624000000 {
-					opp-hz = /bits/ 64 <624000000>;
-					opp-supported-hw = <0x01>;
-				};
-				opp-560000000 {
-					opp-hz = /bits/ 64 <560000000>;
-					opp-supported-hw = <0x01>;
-				};
-				opp-510000000 {
-					opp-hz = /bits/ 64 <510000000>;
-					opp-supported-hw = <0xFF>;
-				};
-				opp-401800000 {
-					opp-hz = /bits/ 64 <401800000>;
-					opp-supported-hw = <0xFF>;
-				};
-				opp-315000000 {
-					opp-hz = /bits/ 64 <315000000>;
-					opp-supported-hw = <0xFF>;
-				};
-				opp-214000000 {
-					opp-hz = /bits/ 64 <214000000>;
-					opp-supported-hw = <0xFF>;
-				};
-				opp-133000000 {
-					opp-hz = /bits/ 64 <133000000>;
-					opp-supported-hw = <0xFF>;
+			dmas =	<&slimbam 3>, <&slimbam 4>,
+				<&slimbam 5>, <&slimbam 6>;
+			dma-names = "rx", "tx", "tx2", "rx2";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ngd@1 {
+				reg = <1>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				tasha_ifd: tas-ifd {
+					compatible = "slim217,1a0";
+					reg  = <0 0>;
 				};
-			};
 
-			zap-shader {
-				memory-region = <&zap_shader_region>;
-			};
-		};
+				wcd9335: codec@1{
+					pinctrl-0 = <&cdc_reset_active &wcd_intr_default>;
+					pinctrl-names = "default";
 
-		mdss: mdss@900000 {
-			compatible = "qcom,mdss";
+					compatible = "slim217,1a0";
+					reg  = <1 0>;
 
-			reg = <0x00900000 0x1000>,
-			      <0x009b0000 0x1040>,
-			      <0x009b8000 0x1040>;
-			reg-names = "mdss_phys",
-				    "vbif_phys",
-				    "vbif_nrt_phys";
+					interrupt-parent = <&msmgpio>;
+					interrupts = <54 IRQ_TYPE_LEVEL_HIGH>,
+						     <53 IRQ_TYPE_LEVEL_HIGH>;
+					interrupt-names  = "intr1", "intr2";
+					interrupt-controller;
+					#interrupt-cells = <1>;
+					reset-gpios = <&msmgpio 64 0>;
 
-			power-domains = <&mmcc MDSS_GDSC>;
-			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+					slim-ifc-dev  = <&tasha_ifd>;
 
-			interrupt-controller;
-			#interrupt-cells = <1>;
+					#sound-dai-cells = <1>;
+				};
+			};
+		};
 
-			clocks = <&mmcc MDSS_AHB_CLK>;
-			clock-names = "iface";
+		adsp_pil: remoteproc@9300000 {
+			compatible = "qcom,msm8996-adsp-pil";
+			reg = <0x09300000 0x80000>;
 
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
+			interrupts-extended = <&intc 0 162 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready",
+					  "handover", "stop-ack";
 
-			mdp: mdp@901000 {
-				compatible = "qcom,mdp5";
-				reg = <0x00901000 0x90000>;
-				reg-names = "mdp_phys";
+			clocks = <&xo_board>;
+			clock-names = "xo";
 
-				interrupt-parent = <&mdss>;
-				interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+			memory-region = <&adsp_region>;
 
-				clocks = <&mmcc MDSS_AHB_CLK>,
-					 <&mmcc MDSS_AXI_CLK>,
-					 <&mmcc MDSS_MDP_CLK>,
-					 <&mmcc SMMU_MDP_AXI_CLK>,
-					 <&mmcc MDSS_VSYNC_CLK>;
-				clock-names = "iface",
-					      "bus",
-					      "core",
-					      "iommu",
-					      "vsync";
+			qcom,smem-states = <&smp2p_adsp_out 0>;
+			qcom,smem-state-names = "stop";
 
-				iommus = <&mdp_smmu 0>;
+			smd-edge {
+				interrupts = <GIC_SPI 156 IRQ_TYPE_EDGE_RISING>;
 
-				ports {
+				label = "lpass";
+				mboxes = <&apcs_glb 8>;
+				qcom,smd-edge = <1>;
+				qcom,remote-pid = <2>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				apr {
+					power-domains = <&gcc HLOS1_VOTE_LPASS_ADSP_GDSC>;
+					compatible = "qcom,apr-v2";
+					qcom,smd-channels = "apr_audio_svc";
+					qcom,apr-domain = <APR_DOMAIN_ADSP>;
 					#address-cells = <1>;
 					#size-cells = <0>;
 
-					port@0 {
-						reg = <0>;
-						mdp5_intf3_out: endpoint {
-							remote-endpoint = <&hdmi_in>;
+					q6core {
+						reg = <APR_SVC_ADSP_CORE>;
+						compatible = "qcom,q6core";
+					};
+
+					q6afe: q6afe {
+						compatible = "qcom,q6afe";
+						reg = <APR_SVC_AFE>;
+						q6afedai: dais {
+							compatible = "qcom,q6afe-dais";
+							#address-cells = <1>;
+							#size-cells = <0>;
+							#sound-dai-cells = <1>;
+							hdmi@1 {
+								reg = <1>;
+							};
 						};
 					};
-				};
-			};
 
-			hdmi: hdmi-tx@9a0000 {
-				compatible = "qcom,hdmi-tx-8996";
-				reg =	<0x009a0000 0x50c>,
-					<0x00070000 0x6158>,
-					<0x009e0000 0xfff>;
-				reg-names = "core_physical",
-					    "qfprom_physical",
-					    "hdcp_physical";
+					q6asm: q6asm {
+						compatible = "qcom,q6asm";
+						reg = <APR_SVC_ASM>;
+						q6asmdai: dais {
+							compatible = "qcom,q6asm-dais";
+							#sound-dai-cells = <1>;
+							iommus = <&lpass_q6_smmu 1>;
+						};
+					};
 
-				interrupt-parent = <&mdss>;
-				interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
+					q6adm: q6adm {
+						compatible = "qcom,q6adm";
+						reg = <APR_SVC_ADM>;
+						q6routing: routing {
+							compatible = "qcom,q6adm-routing";
+							#sound-dai-cells = <0>;
+						};
+					};
+				};
 
-				clocks = <&mmcc MDSS_MDP_CLK>,
-					 <&mmcc MDSS_AHB_CLK>,
-					 <&mmcc MDSS_HDMI_CLK>,
-					 <&mmcc MDSS_HDMI_AHB_CLK>,
-					 <&mmcc MDSS_EXTPCLK_CLK>;
-				clock-names =
-					"mdp_core",
-					"iface",
-					"core",
-					"alt_iface",
-					"extp";
+			};
+		};
 
-				phys = <&hdmi_phy>;
-				phy-names = "hdmi_phy";
-				#sound-dai-cells = <1>;
+		apcs_glb: mailbox@9820000 {
+			compatible = "qcom,msm8996-apcs-hmss-global";
+			reg = <0x09820000 0x1000>;
 
-				ports {
-					#address-cells = <1>;
-					#size-cells = <0>;
+			#mbox-cells = <1>;
+		};
 
-					port@0 {
-						reg = <0>;
-						hdmi_in: endpoint {
-							remote-endpoint = <&mdp5_intf3_out>;
-						};
-					};
-				};
+		timer@9840000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			compatible = "arm,armv7-timer-mem";
+			reg = <0x09840000 0x1000>;
+			clock-frequency = <19200000>;
+
+			frame@9850000 {
+				frame-number = <0>;
+				interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x09850000 0x1000>,
+				      <0x09860000 0x1000>;
 			};
 
-			hdmi_phy: hdmi-phy@9a0600 {
-				#phy-cells = <0>;
-				compatible = "qcom,hdmi-phy-8996";
-				reg = <0x009a0600 0x1c4>,
-				      <0x009a0a00 0x124>,
-				      <0x009a0c00 0x124>,
-				      <0x009a0e00 0x124>,
-				      <0x009a1000 0x124>,
-				      <0x009a1200 0x0c8>;
-				reg-names = "hdmi_pll",
-					    "hdmi_tx_l0",
-					    "hdmi_tx_l1",
-					    "hdmi_tx_l2",
-					    "hdmi_tx_l3",
-					    "hdmi_phy";
+			frame@9870000 {
+				frame-number = <1>;
+				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x09870000 0x1000>;
+				status = "disabled";
+			};
 
-				clocks = <&mmcc MDSS_AHB_CLK>,
-					 <&gcc GCC_HDMI_CLKREF_CLK>;
-				clock-names = "iface",
-					      "ref";
+			frame@9880000 {
+				frame-number = <2>;
+				interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x09880000 0x1000>;
+				status = "disabled";
 			};
-		};
 
-		venus_smmu: arm,smmu-venus@d40000 {
-			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
-			reg = <0xd40000 0x20000>;
-			#global-interrupts = <1>;
-			interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>;
-			power-domains = <&mmcc MMAGIC_VIDEO_GDSC>;
-			clocks = <&mmcc SMMU_VIDEO_AHB_CLK>,
-				 <&mmcc SMMU_VIDEO_AXI_CLK>;
-			clock-names = "iface", "bus";
-			#iommu-cells = <1>;
-			status = "okay";
-		};
+			frame@9890000 {
+				frame-number = <3>;
+				interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x09890000 0x1000>;
+				status = "disabled";
+			};
 
-		video-codec@c00000 {
-			compatible = "qcom,msm8996-venus";
-			reg = <0x00c00000 0xff000>;
-			interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
-			power-domains = <&mmcc VENUS_GDSC>;
-			clocks = <&mmcc VIDEO_CORE_CLK>,
-				 <&mmcc VIDEO_AHB_CLK>,
-				 <&mmcc VIDEO_AXI_CLK>,
-				 <&mmcc VIDEO_MAXI_CLK>;
-			clock-names = "core", "iface", "bus", "mbus";
-			iommus = <&venus_smmu 0x00>,
-				 <&venus_smmu 0x01>,
-				 <&venus_smmu 0x0a>,
-				 <&venus_smmu 0x07>,
-				 <&venus_smmu 0x0e>,
-				 <&venus_smmu 0x0f>,
-				 <&venus_smmu 0x08>,
-				 <&venus_smmu 0x09>,
-				 <&venus_smmu 0x0b>,
-				 <&venus_smmu 0x0c>,
-				 <&venus_smmu 0x0d>,
-				 <&venus_smmu 0x10>,
-				 <&venus_smmu 0x11>,
-				 <&venus_smmu 0x21>,
-				 <&venus_smmu 0x28>,
-				 <&venus_smmu 0x29>,
-				 <&venus_smmu 0x2b>,
-				 <&venus_smmu 0x2c>,
-				 <&venus_smmu 0x2d>,
-				 <&venus_smmu 0x31>;
-			memory-region = <&venus_region>;
-			status = "okay";
+			frame@98a0000 {
+				frame-number = <4>;
+				interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x098a0000 0x1000>;
+				status = "disabled";
+			};
 
-			video-decoder {
-				compatible = "venus-decoder";
-				clocks = <&mmcc VIDEO_SUBCORE0_CLK>;
-				clock-names = "core";
-				power-domains = <&mmcc VENUS_CORE0_GDSC>;
+			frame@98b0000 {
+				frame-number = <5>;
+				interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x098b0000 0x1000>;
+				status = "disabled";
 			};
 
-			video-encoder {
-				compatible = "venus-encoder";
-				clocks = <&mmcc VIDEO_SUBCORE1_CLK>;
-				clock-names = "core";
-				power-domains = <&mmcc VENUS_CORE1_GDSC>;
+			frame@98c0000 {
+				frame-number = <6>;
+				interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x098c0000 0x1000>;
+				status = "disabled";
 			};
 		};
+
+		intc: interrupt-controller@9bc0000 {
+			compatible = "qcom,msm8996-gic-v3", "arm,gic-v3";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			#redistributor-regions = <1>;
+			redistributor-stride = <0x0 0x40000>;
+			reg = <0x09bc0000 0x10000>,
+			      <0x09c00000 0x100000>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
 
 	sound: sound {
 	};
 
-	adsp-pil {
-		compatible = "qcom,msm8996-adsp-pil";
+	thermal-zones {
+		cpu0-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
 
-		interrupts-extended = <&intc 0 162 IRQ_TYPE_EDGE_RISING>,
-				      <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
-				      <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
-				      <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
-				      <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
-		interrupt-names = "wdog", "fatal", "ready",
-				  "handover", "stop-ack";
+			thermal-sensors = <&tsens0 3>;
 
-		clocks = <&xo_board>;
-		clock-names = "xo";
+			trips {
+				cpu0_alert0: trip-point@0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
 
-		memory-region = <&adsp_region>;
+				cpu0_crit: cpu_crit {
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
 
-		qcom,smem-states = <&adsp_smp2p_out 0>;
-		qcom,smem-state-names = "stop";
+		cpu1-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
 
-		smd-edge {
-			interrupts = <GIC_SPI 156 IRQ_TYPE_EDGE_RISING>;
+			thermal-sensors = <&tsens0 5>;
 
-			label = "lpass";
-			mboxes = <&apcs_glb 8>;
-			qcom,smd-edge = <1>;
-			qcom,remote-pid = <2>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			apr {
-				power-domains = <&gcc HLOS1_VOTE_LPASS_ADSP_GDSC>;
-				compatible = "qcom,apr-v2";
-				qcom,smd-channels = "apr_audio_svc";
-				qcom,apr-domain = <APR_DOMAIN_ADSP>;
-				#address-cells = <1>;
-				#size-cells = <0>;
+			trips {
+				cpu1_alert0: trip-point@0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
 
-				q6core {
-					reg = <APR_SVC_ADSP_CORE>;
-					compatible = "qcom,q6core";
-				};
-
-				q6afe: q6afe {
-					compatible = "qcom,q6afe";
-					reg = <APR_SVC_AFE>;
-					q6afedai: dais {
-						compatible = "qcom,q6afe-dais";
-						#address-cells = <1>;
-						#size-cells = <0>;
-						#sound-dai-cells = <1>;
-						hdmi@1 {
-							reg = <1>;
-						};
-					};
+				cpu1_crit: cpu_crit {
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
 				};
+			};
+		};
 
-				q6asm: q6asm {
-					compatible = "qcom,q6asm";
-					reg = <APR_SVC_ASM>;
-					q6asmdai: dais {
-						compatible = "qcom,q6asm-dais";
-						#sound-dai-cells = <1>;
-						iommus = <&lpass_q6_smmu 1>;
-					};
+		cpu2-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 8>;
+
+			trips {
+				cpu2_alert0: trip-point@0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
 				};
 
-				q6adm: q6adm {
-					compatible = "qcom,q6adm";
-					reg = <APR_SVC_ADM>;
-					q6routing: routing {
-						compatible = "qcom,q6adm-routing";
-						#sound-dai-cells = <0>;
-					};
+				cpu2_crit: cpu_crit {
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
 				};
 			};
+		};
+
+		cpu3-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 10>;
+
+			trips {
+				cpu3_alert0: trip-point@0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
 
+				cpu3_crit: cpu_crit {
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
 		};
-	};
 
-	adsp-smp2p {
-		compatible = "qcom,smp2p";
-		qcom,smem = <443>, <429>;
+		gpu-thermal-top {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
 
-		interrupts = <0 158 IRQ_TYPE_EDGE_RISING>;
+			thermal-sensors = <&tsens1 6>;
 
-		mboxes = <&apcs_glb 10>;
+			trips {
+				gpu1_alert0: trip-point@0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
 
-		qcom,local-pid = <0>;
-		qcom,remote-pid = <2>;
+		gpu-thermal-bottom {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
 
-		adsp_smp2p_out: master-kernel {
-			qcom,entry-name = "master-kernel";
-			#qcom,smem-state-cells = <1>;
+			thermal-sensors = <&tsens1 7>;
+
+			trips {
+				gpu2_alert0: trip-point@0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
 		};
 
-		adsp_smp2p_in: slave-kernel {
-			qcom,entry-name = "slave-kernel";
+		m4m-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
 
-			interrupt-controller;
-			#interrupt-cells = <2>;
+			thermal-sensors = <&tsens0 1>;
+
+			trips {
+				m4m_alert0: trip-point@0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
 		};
-	};
 
-	modem-smp2p {
-		compatible = "qcom,smp2p";
-		qcom,smem = <435>, <428>;
+		l3-or-venus-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
 
-		interrupts = <GIC_SPI 451 IRQ_TYPE_EDGE_RISING>;
+			thermal-sensors = <&tsens0 2>;
 
-		mboxes = <&apcs_glb 14>;
+			trips {
+				l3_or_venus_alert0: trip-point@0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
 
-		qcom,local-pid = <0>;
-		qcom,remote-pid = <1>;
+		cluster0-l2-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
 
-		modem_smp2p_out: master-kernel {
-			qcom,entry-name = "master-kernel";
-			#qcom,smem-state-cells = <1>;
+			thermal-sensors = <&tsens0 7>;
+
+			trips {
+				cluster0_l2_alert0: trip-point@0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
 		};
 
-		modem_smp2p_in: slave-kernel {
-			qcom,entry-name = "slave-kernel";
+		cluster1-l2-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
 
-			interrupt-controller;
-			#interrupt-cells = <2>;
+			thermal-sensors = <&tsens0 12>;
+
+			trips {
+				cluster1_l2_alert0: trip-point@0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
 		};
-	};
 
-	smp2p-slpi {
-		compatible = "qcom,smp2p";
-		qcom,smem = <481>, <430>;
+		camera-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
 
-		interrupts = <GIC_SPI 178 IRQ_TYPE_EDGE_RISING>;
+			thermal-sensors = <&tsens1 1>;
 
-		mboxes = <&apcs_glb 26>;
+			trips {
+				camera_alert0: trip-point@0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
 
-		qcom,local-pid = <0>;
-		qcom,remote-pid = <3>;
+		q6-dsp-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
 
-		slpi_smp2p_in: slave-kernel {
-			qcom,entry-name = "slave-kernel";
-			interrupt-controller;
-			#interrupt-cells = <2>;
+			thermal-sensors = <&tsens1 2>;
+
+			trips {
+				q6_dsp_alert0: trip-point@0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
 		};
 
-		slpi_smp2p_out: master-kernel {
-			qcom,entry-name = "master-kernel";
-			#qcom,smem-state-cells = <1>;
+		mem-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 3>;
+
+			trips {
+				mem_alert0: trip-point@0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		modemtx-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 4>;
+
+			trips {
+				modemtx_alert0: trip-point@0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
 		};
 	};
 
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+	};
 };
 #include "msm8996-pins.dtsi"
-- 
2.23.0

