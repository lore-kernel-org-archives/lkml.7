Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94111C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4273F22CDA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xv5Uave8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390744AbfGYKmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 06:42:54 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35628 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390193AbfGYKmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 06:42:52 -0400
Received: by mail-lf1-f68.google.com with SMTP id p197so34147050lfa.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 03:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PiCimMlECSuSC3p9Tf5td0HbmG6WHhr2fDE9h4PjuDA=;
        b=Xv5Uave8H9XOovGyb9lcztVjF/oEuGRQL39AqbpSjmmMF1wvJBODiMZmkcnTeu/k8a
         pxHzHAZ3239Hd0lJMDZpcfiAqOfDJ/Wjf2gE1ofurYy2pdiXvbj9KsJ57+YYTI3sePlI
         P5wdKFlTC/cl5tcRYytLbXqsqPDeDN2L9cjvecjzfPUmtY83QV+mr3RzTcTw0z1C33a9
         rwwTTeKEowqggXwgN3JhfmCAYOjvlQbFnEVyfetO8aUdRb4nt6yKTF++g5mkGgICKxhR
         LlFhtcTOCR8LALTa8y35zlkFa9pW2NLdT1vvOb81UsWaXuyoQbjHmLpW5aV7jK9lOxUv
         BLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PiCimMlECSuSC3p9Tf5td0HbmG6WHhr2fDE9h4PjuDA=;
        b=mddRQbXkWAiT1colOcLYOioSdLBcDx5EalOPui0WDLkr7TkihCUyAFYGwzGNkxEFV7
         hkS1pXMRUAgs7nRHptmpWRo5j6EPlVniAVEafru+29U5pB5BFPLffnFWIQRRu69Glok7
         CXg8bzYXyM2NhCXIZgucfDKWWesFkAwaQfixa8BlBuoD+KqB6/r5NukmmNfxb9Bub+7w
         RagSL5POiFZ38Nhz2dxCHtNZL3jDCglqMSYM16kLiRfm92R+budU3uW7I/uAp7oiwhtC
         Epz3iOgiI2Qy7j/PGdKKXQkkbTLUo2TJQA5Uaq+urvrZBZT5iyDArFUNu/56JjXetx1y
         hFug==
X-Gm-Message-State: APjAAAVaS8rM8hK/QdsQKTZrswdciYxj/K0FPZ8KP1aU8W3OUX/fmEut
        l2D7jxbJqKrvt6rVjsHuo8XkfA==
X-Google-Smtp-Source: APXvYqwuemIlhiDoQ8VJnBGzwlpCiV36cLa8WrJS/hDozVNhFd/bOdMjfvdG7HvT5pD0k4dNtI97KQ==
X-Received: by 2002:a19:4f42:: with SMTP id a2mr1168480lfk.23.1564051370665;
        Thu, 25 Jul 2019 03:42:50 -0700 (PDT)
Received: from localhost.localdomain (ua-83-226-44-230.bbcust.telenor.se. [83.226.44.230])
        by smtp.gmail.com with ESMTPSA id e62sm9035045ljf.82.2019.07.25.03.42.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 03:42:50 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, sboyd@kernel.org,
        vireshk@kernel.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/14] dt-bindings: power: avs: Add support for CPR (Core Power Reduction)
Date:   Thu, 25 Jul 2019 12:41:38 +0200
Message-Id: <20190725104144.22924-11-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190725104144.22924-1-niklas.cassel@linaro.org>
References: <20190725104144.22924-1-niklas.cassel@linaro.org>
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
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes since V1:
-Picked up tags.

 .../bindings/power/avs/qcom,cpr.txt           | 193 ++++++++++++++++++
 1 file changed, 193 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/avs/qcom,cpr.txt

diff --git a/Documentation/devicetree/bindings/power/avs/qcom,cpr.txt b/Documentation/devicetree/bindings/power/avs/qcom,cpr.txt
new file mode 100644
index 000000000000..93be67fa8f38
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/avs/qcom,cpr.txt
@@ -0,0 +1,193 @@
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
+	Definition: should be "qcom,qcs404-cpr", "qcom,cpr" for qcs404
+
+- reg:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: base address and size of the rbcpr register region
+
+- interrupts:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: should specify the CPR interrupt
+
+- clocks:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: phandle to the reference clock
+
+- clock-names:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "ref"
+
+- vdd-apc-supply:
+	Usage: required
+	Value type: <phandle>
+	Definition: phandle to the vdd-apc-supply regulator
+
+- #power-domain-cells:
+	Usage: required
+	Value type: <u32>
+	Definition: should be 0
+
+- operating-points-v2:
+	Usage: required
+	Value type: <phandle>
+	Definition: A phandle to the OPP table containing the
+		    performance states supported by the CPR
+		    power domain
+
+- acc-syscon:
+	Usage: optional
+	Value type: <phandle>
+	Definition: phandle to syscon for writing ACC settings
+
+- nvmem-cells:
+	Usage: required
+	Value type: <phandle>
+	Definition: phandle to nvmem cells containing the data
+		    that makes up a fuse corner, for each fuse corner.
+		    As well as the CPR fuse revision.
+
+- nvmem-cell-names:
+	Usage: required
+	Value type: <stringlist>
+	Definition: should be "cpr_quotient_offset1", "cpr_quotient_offset2",
+		    "cpr_quotient_offset3", "cpr_init_voltage1",
+		    "cpr_init_voltage2", "cpr_init_voltage3", "cpr_quotient1",
+		    "cpr_quotient2", "cpr_quotient3", "cpr_ring_osc1",
+		    "cpr_ring_osc2", "cpr_ring_osc3", "cpr_fuse_revision"
+		    for qcs404.
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
+	Definition: The threshold for CPR to issue interrupt when error_steps
+		    is greater than it when stepping down
+
+- qcom,cpr-idle-clocks:
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
+	Definition: Limit of number of vdd-apc-supply regulator steps for
+		    scaling up
+
+- qcom,vdd-apc-step-down-limit:
+	Usage: required
+	Value type: <u32>
+	Definition: Limit of number of vdd-apc-supply regulator steps for
+		    scaling down
+
+Example:
+
+	cpr_opp_table: cpr-opp-table {
+		compatible = "operating-points-v2-qcom-level";
+
+		cpr_opp1: opp1 {
+			opp-level = <1>;
+			....
+		};
+		cpr_opp2: opp2 {
+			opp-level = <2>;
+			....
+		};
+		cpr_opp3: opp3 {
+			opp-level = <3>;
+			....
+		};
+	};
+
+	cpr@b018000 {
+		compatible = "qcom,qcs404-cpr", "qcom,cpr";
+		reg = <0x0b018000 0x1000>;
+		interrupts = <0 15 IRQ_TYPE_EDGE_RISING>;
+		clocks = <&xo_board>;
+		clock-names = "ref";
+		vdd-apc-supply = <&pms405_s3>;
+		#power-domain-cells = <0>;
+		operating-points-v2 = <&cpr_opp_table>;
+		acc-syscon = <&tcsr>;
+
+		nvmem-cells = <&cpr_efuse_quot_offset1>,
+			<&cpr_efuse_quot_offset2>,
+			<&cpr_efuse_quot_offset3>,
+			<&cpr_efuse_init_voltage1>,
+			<&cpr_efuse_init_voltage2>,
+			<&cpr_efuse_init_voltage3>,
+			<&cpr_efuse_quot1>,
+			<&cpr_efuse_quot2>,
+			<&cpr_efuse_quot3>,
+			<&cpr_efuse_ring1>,
+			<&cpr_efuse_ring2>,
+			<&cpr_efuse_ring3>,
+			<&cpr_efuse_revision>;
+		nvmem-cell-names = "cpr_quotient_offset1",
+			"cpr_quotient_offset2",
+			"cpr_quotient_offset3",
+			"cpr_init_voltage1",
+			"cpr_init_voltage2",
+			"cpr_init_voltage3",
+			"cpr_quotient1",
+			"cpr_quotient2",
+			"cpr_quotient3",
+			"cpr_ring_osc1",
+			"cpr_ring_osc2",
+			"cpr_ring_osc3",
+			"cpr_fuse_revision";
+
+		qcom,cpr-timer-delay-us = <5000>;
+		qcom,cpr-timer-cons-up = <0>;
+		qcom,cpr-timer-cons-down = <2>;
+		qcom,cpr-up-threshold = <1>;
+		qcom,cpr-down-threshold = <3>;
+		qcom,cpr-idle-clocks = <15>;
+		qcom,cpr-gcnt-us = <1>;
+		qcom,vdd-apc-step-up-limit = <1>;
+		qcom,vdd-apc-step-down-limit = <1>;
+	};
-- 
2.21.0

