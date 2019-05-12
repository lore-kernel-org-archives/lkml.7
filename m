Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D79C04AB1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 01:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AFAB2146F
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 01:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AWXXSy/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfELBZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 21:25:37 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54083 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfELBZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 21:25:33 -0400
Received: by mail-it1-f196.google.com with SMTP id m141so13818339ita.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 18:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h9s9Psuy/E87ixvvmJRRBd63LEM82ud4Ysnws8m9DPo=;
        b=AWXXSy/tHZxFMRnTUKsZJnn9/i8AXv0hS2HYZR6FQcrVjQrQ09I32/yoVtzsUR2uvV
         7zFSuZ42IIityqAbgIch+MnZjykjf86pSvE3xK6T3DbJLy303eH3CTiokRPPw456N8xL
         7rI3DRDo93kVQVqJEx4+iSJvkrcLeNnYP4jstVIDSaVJG+KMvmJzVubuadREOf9UCb8W
         USnVNLzHRgNAXX2TjQLba4bBE2mOLm4VG47LigzSgco1g+vRs5H9TFKdWGAgoWbfuYl3
         +Be+cvBJCbfwgeh+cHqB9JKmSpIV8MVT217A79khc94LPvZ/bvDo631/dJdIpWXfDX0V
         7e+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h9s9Psuy/E87ixvvmJRRBd63LEM82ud4Ysnws8m9DPo=;
        b=kw/zkTu7GiIm3fTCO6ox4HkPdNt7mNnGf0ubfAQq0fRJQq3ArK69NsdbTs/V6rZPub
         KD0zB4JntQNtiujE4RkA28FMhmZRG/w1Dul4gkUAIWRJEP7M8fsSljx740k31rGYsqHC
         j6zcVYmKI1A3NAeZmHwqdBZCaALq1myeIEURPjBzTAfgsQMCCr51Rk7TUGeLb0H5gwWz
         uLOyzDOODxTfrqqgxALzhB450APsz5fzW+BXY8eXpIm+s1zG+oPZCDeZfS68NT7wsMIn
         JwVAS1Y0P10KidbCS2tSbaAs1cRsMJW5dVRXevuMXRRzxyO/csqeCGhBhFs5Hi3PqKeI
         1Jhg==
X-Gm-Message-State: APjAAAV+prhSmMzCcqvnfZrYlOgHa/lZ+O0zritSqKOXQkYmoirNAsAo
        l6VqqMI9N1BQocQT/xkpK/bEEg==
X-Google-Smtp-Source: APXvYqy1xZlzYsZGq/MuafbqYG4Jy0s7IuPBsGBC5KHMhJtjd+vzZyh69aFdSxcJthEZRtMgn3iiiA==
X-Received: by 2002:a24:56c1:: with SMTP id o184mr815571itb.123.1557624331932;
        Sat, 11 May 2019 18:25:31 -0700 (PDT)
Received: from shibby.hil-lafwehx.chi.wayport.net (hampton-inn.wintek.com. [72.12.199.50])
        by smtp.gmail.com with ESMTPSA id u134sm1579013itb.32.2019.05.11.18.25.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 18:25:31 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, arnd@arndb.de, bjorn.andersson@linaro.org,
        ilias.apalodimas@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org, david.brown@linaro.org
Cc:     syadagir@codeaurora.org, mjavid@codeaurora.org,
        evgreen@chromium.org, benchan@google.com, ejcaruso@google.com,
        abhishek.esse@gmail.com, linux-kernel@vger.kernel.org,
        Alex Elder <elder@linaro.org>
Subject: [PATCH 03/18] dt-bindings: soc: qcom: add IPA bindings
Date:   Sat, 11 May 2019 20:24:53 -0500
Message-Id: <20190512012508.10608-4-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190512012508.10608-1-elder@linaro.org>
References: <20190512012508.10608-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the binding definitions for the "qcom,ipa" device tree node.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 .../devicetree/bindings/net/qcom,ipa.txt      | 164 ++++++++++++++++++
 1 file changed, 164 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/qcom,ipa.txt

diff --git a/Documentation/devicetree/bindings/net/qcom,ipa.txt b/Documentation/devicetree/bindings/net/qcom,ipa.txt
new file mode 100644
index 000000000000..2705e198f12e
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/qcom,ipa.txt
@@ -0,0 +1,164 @@
+Qualcomm IP Accelerator (IPA)
+
+This binding describes the Qualcomm IPA.  The IPA is capable of offloading
+certain network processing tasks (e.g. filtering, routing, and NAT) from
+the main processor.
+
+The IPA sits between multiple independent "execution environments,"
+including the Application Processor (AP) and the modem.  The IPA presents
+a Generic Software Interface (GSI) to each execution environment.
+The GSI is an integral part of the IPA, but it is logically isolated
+and has a distinct interrupt and a separately-defined address space.
+
+	--------	     ---------
+	|      |	     |	     |
+	|  AP  +<---.	.----+ Modem |
+	|      +--. |	| .->+	     |
+	|      |  | |	| |  |	     |
+	--------  | |	| |  ---------
+		  v |	v |
+		--+-+---+-+--
+		|    GSI    |
+		|-----------|
+		|	    |
+		|    IPA    |
+		|	    |
+		-------------
+
+See also:
+  bindings/interrupt-controller/interrupts.txt
+  bindings/interconnect/interconnect.txt
+  bindings/soc/qcom/qcom,smp2p.txt
+  bindings/reserved-memory/reserved-memory.txt
+  bindings/clock/clock-bindings.txt
+
+All properties except "modem-init" defined below are required.
+
+- compatible:
+	Must be "qcom,sdm845-ipa".
+
+- modem-init:
+	This Boolean property is optional.  If present, it indicates that
+	the modem is responsible for performing early IPA initialization,
+	including loading and validating firwmare used by the GSI.  This
+	early initialization is performed by Trust Zone otherwise.
+
+- reg:
+	Resources specifying the physical address spaces of the IPA and GSI.
+
+- reg-names:
+	The names of the two address space ranges defined by the "reg"
+	property.  Must be:
+		"ipa-reg"
+		"ipa-shared"
+		"gsi"
+
+- interrupts:
+	Specifies the IRQs used by the IPA.  Four interrupts are required,
+	specifying: the IPA IRQ; the GSI IRQ; the clock query interrupt
+	from the modem; and the "ready for setup" interrupt from the modem.
+	The first two are hardware IRQs; the third and fourth are SMP2P
+	input interrupts.
+
+- interrupt-names:
+	The names of the interrupts defined by the "interrupts-extended"
+	property.  Must be:
+		"ipa"
+		"gsi"
+		"ipa-clock-query"
+		"ipa-setup-ready"
+
+- clocks:
+	Resource that defines the IPA core clock.
+
+- clock-names:
+	The name used for the IPA core clock.  Must be "core".
+
+- interconnects:
+	Specifies the interconnects used by the IPA.  Three interconnects
+	are required, specifying:  the path from the IPA to memory; from
+	IPA to internal (SoC resident) memory; and between the AP subsystem
+	and IPA for register access.
+
+- interconnect-names:
+	The names of the interconnects defined by the "interconnects"
+	property.  Must be:
+		"memory"
+		"imem"
+		"config"
+
+- qcom,smem-states
+	The state bits used for SMP2P output.  Two states must be specified.
+	The first indicates whether the value in the second bit is valid
+	(1 means valid).  The second, if valid, defines whether the IPA
+	clock is enabled (1 means enabled).
+
+- qcom,smem-state-names
+	The names of the state bits used for SMP2P output.  Must be:
+		"ipa-clock-enabled-valid"
+		"ipa-clock-enabled"
+
+- memory-region
+	A phandle for a reserved memory area that holds the firmware passed
+	to Trust Zone for authentication.  (Note, this is required
+	only when Trust Zone performs early initialization; that is,
+	it is required if "modem-init" is not defined.)
+
+= EXAMPLE
+
+The following example represents the IPA present in the SDM845 SoC.  It
+shows portions of the "modem-smp2p" node to indicate its relationship
+with the interrupts and SMEM states used by the IPA.
+
+	smp2p-mpss {
+		compatible = "qcom,smp2p";
+		. . .
+		ipa_smp2p_out: ipa-ap-to-modem {
+			qcom,entry-name = "ipa";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		ipa_smp2p_in: ipa-modem-to-ap {
+			qcom,entry-name = "ipa";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	ipa@1e40000 {
+		compatible = "qcom,sdm845-ipa";
+
+		modem-init;
+
+		reg = <0 0x1e40000 0 0x7000>,
+		      <0 0x1e47000 0 0x2000>,
+		      <0 0x1e04000 0 0x2c000>;
+		reg-names = "ipa-reg",
+			    "ipa-shared";
+			    "gsi";
+
+		interrupts-extended = <&intc 0 311 IRQ_TYPE_EDGE_RISING>,
+				      <&intc 0 432 IRQ_TYPE_LEVEL_HIGH>,
+				      <&ipa_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+				      <&ipa_smp2p_in 1 IRQ_TYPE_EDGE_RISING>;
+		interrupt-names = "ipa",
+				   "gsi",
+				   "ipa-clock-query",
+				   "ipa-setup-ready";
+
+		clocks = <&rpmhcc RPMH_IPA_CLK>;
+		clock-names = "core";
+
+		interconnects =
+			<&rsc_hlos MASTER_IPA &rsc_hlos SLAVE_EBI1>,
+			<&rsc_hlos MASTER_IPA &rsc_hlos SLAVE_IMEM>,
+			<&rsc_hlos MASTER_APPSS_PROC &rsc_hlos SLAVE_IPA_CFG>;
+		interconnect-names = "memory",
+				     "imem",
+				     "config";
+
+		qcom,smem-states = <&ipa_smp2p_out 0>,
+				   <&ipa_smp2p_out 1>;
+		qcom,smem-state-names = "ipa-clock-enabled-valid",
+					"ipa-clock-enabled";
+	};
-- 
2.20.1

