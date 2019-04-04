Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E2AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134CE20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TVrlYzkJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfDDFKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 01:10:49 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44296 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfDDFKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 01:10:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id i2so601660pgj.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 22:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KklAnXYLBcaWUwOXv3w+NPnCSqij3vKIBVWvRjd2T1M=;
        b=TVrlYzkJah4xdZ0w8EvrnSm/BK2kbCUs+gYrh4qHXuTB+9XfnOKDUijzhXIOhYcCQ1
         lMWLSiwQm+HBmQ8e4X8RqpPvj65Nem5N7MMVM86i766VY6p6IXLsPIDlRbHoOoXhjrkM
         i41Ogs62ITdcsCP4H3olAyjjOUko92YbM/gLAPKf3PBVt/OaCvR34FNNUfU/GGNzxrDt
         4dK87LDFQXJLL/EefUGM7xmBQ9sKFFy/Np27g9F+KAJFqgzDyy3t5QGS+0VMhXbPKQwv
         Dkb9xcd4wT7vQL5n7o1j4Ra+ue6z78MoWYjjfcBc4E1tnEXZ3IG9Y1v+bcdpW/aD3CTf
         rdPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KklAnXYLBcaWUwOXv3w+NPnCSqij3vKIBVWvRjd2T1M=;
        b=UyuCHT+2KaNkVNwffA3U3rPARbRrXljfMJvYDLTFSVsJi13Pk78OmmuhHYFHe8nsDi
         lSBBnZqJgL154nE3NqyPLk4hkZd0fjmTJKTIS7D+eHlQT0E7RQvCPCsRViGsleI5wOXg
         2FLpPo7plrTBmoW7vdP6kd/R2O0vh57tUBU+VLSYqJB07HbaafNpCCsY/4WsJ6MfCOb3
         V9oNc72xgYiQp5cugtBFVmU1gXiaoV2scx+kTET8v2r2Epi2ldMgijrxwrxFndtzV4aj
         R5upbqJWal4k8XAV10YHFvlPoPGqg8lT2JgcNBdKNctkT1GLsmF0Di0eRBiaJH5kjmQI
         Rl2Q==
X-Gm-Message-State: APjAAAWBA3ufI4smHPuCW8q44+s+xqdhVTWpYDFA4gMdwH+GKMuztu/D
        oUT6HKMJk3mAWUadbGhCxNDWIg==
X-Google-Smtp-Source: APXvYqy17XvZpOsXAVU3uU50LFA03fh5j3uiMNXPtk8QswXoP6g8HpJA/G8U3H2/zvSa2I3B9C0CYg==
X-Received: by 2002:a62:1318:: with SMTP id b24mr3620039pfj.201.1554354647500;
        Wed, 03 Apr 2019 22:10:47 -0700 (PDT)
Received: from centauri.imgcgcw.net ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id g64sm43254361pfg.13.2019.04.03.22.10.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 22:10:46 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 7/9] dt-bindings: power: avs: Add support for CPR (Core Power Reduction)
Date:   Thu,  4 Apr 2019 07:09:28 +0200
Message-Id: <20190404050931.9812-8-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190404050931.9812-1-niklas.cassel@linaro.org>
References: <20190404050931.9812-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings to describe the CPR HW found on certain Qualcomm SoCs.

Co-developed-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 .../bindings/power/avs/qcom,cpr.txt           | 119 ++++++++++++++++++
 1 file changed, 119 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/avs/qcom,cpr.txt

diff --git a/Documentation/devicetree/bindings/power/avs/qcom,cpr.txt b/Documentation/devicetree/bindings/power/avs/qcom,cpr.txt
new file mode 100644
index 000000000000..541c9b31cd3b
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/avs/qcom,cpr.txt
@@ -0,0 +1,119 @@
+QCOM CPR (Core Power Reduction)
+
+CPR (Core Power Reduction) is a technology to reduce core power on a CPU
+or other device. Each OPP of a device corresponds to a "corner" that has
+a range of valid voltages for a particular frequency. While the device is
+running at a particular frequency, CPR monitors dynamic factors such as
+temperature, etc. and suggests adjustments to the voltage to save power
+and meet silicon characteristic requirements.
+
+- compatible:
+	Usage: required
+	Value type: <string>
+	Definition: must be "qcom,cpr"
+
+- reg:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: base address and size of the rbcpr register region
+
+- interrupts:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: list of three interrupts in order of irq0, irq1, irq2
+
+- acc-syscon:
+	Usage: optional
+	Value type: <phandle>
+	Definition: phandle to syscon for writing ACC settings
+
+- nvmem:
+	Usage: required
+	Value type: <phandle>
+	Definition: phandle to nvmem provider containing efuse settings
+
+- nvmem-names:
+	Usage: required
+	Value type: <string>
+	Definition: must be "qfprom"
+
+vdd-mx-supply = <&pm8916_l3>;
+
+- qcom,cpr-ref-clk:
+	Usage: required
+	Value type: <u32>
+	Definition: rate of reference clock in kHz
+
+- qcom,cpr-timer-delay-us:
+	Usage: required
+	Value type: <u32>
+	Definition: delay in uS for the timer interval
+
+- qcom,cpr-timer-cons-up:
+	Usage: required
+	Value type: <u32>
+	Definition: Consecutive number of timer intervals, or units of
+		    qcom,cpr-timer-delay-us, that occur before issuing an up
+		    interrupt
+
+- qcom,cpr-timer-cons-down:
+	Usage: required
+	Value type: <u32>
+	Definition: Consecutive number of timer intervals, or units of
+		    qcom,cpr-timer-delay-us, that occur before issuing a down
+		    interrupt
+
+- qcom,cpr-up-threshold:
+	Usage: optional
+	Value type: <u32>
+	Definition: The threshold for CPR to issue interrupt when error_steps
+		    is greater than it when stepping up
+
+- qcom,cpr-down-threshold:
+	Usage: optional
+	Value type: <u32>
+	Definition: The threshold for CPR to issue interrdownt when error_steps
+		    is greater than it when stepping down
+
+- qcom,cpr-down-threshold:
+	Usage: optional
+	Value type: <u32>
+	Definition: Idle clock cycles ring oscillator can be in
+
+- qcom,cpr-gcnt-us:
+	Usage: required
+	Value type: <u32>
+	Definition: The time for gate count in uS
+
+- qcom,vdd-apc-step-up-limit:
+	Usage: required
+	Value type: <u32>
+	Definition: Limit of vdd-apc-supply steps for scaling up
+
+- qcom,vdd-apc-step-down-limit:
+	Usage: required
+	Value type: <u32>
+	Definition: Limit of vdd-apc-supply steps for scaling down
+
+Example:
+
+	avs@b018000 {
+		compatible = "qcom,cpr";
+		reg = <0xb018000 0x1000>;
+		interrupts = <0 15 1>, <0 16 1>, <0 17 1>;
+		vdd-mx-supply = <&pm8916_l3>;
+		acc-syscon = <&tcsr>;
+		nvmem = <&qfprom>;
+		nvmem-names = "qfprom";
+
+		qcom,cpr-ref-clk = <19200>;
+		qcom,cpr-timer-delay-us = <5000>;
+		qcom,cpr-timer-cons-up = <0>;
+		qcom,cpr-timer-cons-down = <2>;
+		qcom,cpr-up-threshold = <0>;
+		qcom,cpr-down-threshold = <2>;
+		qcom,cpr-idle-clocks = <15>;
+		qcom,cpr-gcnt-us = <1>;
+		qcom,vdd-apc-step-up-limit = <1>;
+		qcom,vdd-apc-step-down-limit = <1>;
+	};
-- 
2.20.1

