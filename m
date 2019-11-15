Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2544C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B7D02073B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZPxN65cy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WNGTVsUq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfKOKE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 05:04:29 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33944 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbfKOKE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 05:04:29 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3EE24611D1; Fri, 15 Nov 2019 10:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573812266;
        bh=RrMUjJPRQz+smOvwPr79jK6ZcVL32D1D6S/AAnEJU84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZPxN65cybtEbJy41d3flWBR4fZvDubmSGn4PqXZ9OxM2iiMw42hBx6UcDCiA7o0Eg
         rhZJiecKF3D9x4IcJ6TkerwJrxHZBCKANPFgucAVcFhYNfk06/Nn/V1La8W3hywali
         BjGTTVu1+hKTasoWoZ0q6r9LoMdMtOKxnvyOFxlM=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DD6AD611C6;
        Fri, 15 Nov 2019 10:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573812264;
        bh=RrMUjJPRQz+smOvwPr79jK6ZcVL32D1D6S/AAnEJU84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WNGTVsUq7bQYVOSRKT8tDcsLhEW3zjoNagtz214Xk3H2WZX7bKt8Re9HhaaVFV/j2
         seLlllTsCJ2G2ucE2ByKCz2unIsnVMoKNWssXxgAYTSYvshmys6hkV3JnlxIa3hopZ
         GV7UViiRmBZz5g4Kp5UitGVmPuwA1K3ICHC67w90=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DD6AD611C6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Michael=20Turquette=20=C2=A0?= <mturquette@baylibre.com>
Cc:     David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, robh+dt@kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v1 1/3] dt-bindings: clock: Add YAML schemas for the QCOM DISPCC clock bindings
Date:   Fri, 15 Nov 2019 15:34:03 +0530
Message-Id: <1573812245-23827-2-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573812245-23827-1-git-send-email-tdas@codeaurora.org>
References: <1573812245-23827-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DISPCC clock provider have a bunch of generic properties that
are needed in a device tree. Add a YAML schemas for those.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 .../devicetree/bindings/clock/qcom,dispcc.txt      | 19 -------
 .../devicetree/bindings/clock/qcom,dispcc.yaml     | 66 ++++++++++++++++++++++
 2 files changed, 66 insertions(+), 19 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,dispcc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,dispcc.yaml

diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc.txt b/Documentation/devicetree/bindings/clock/qcom,dispcc.txt
deleted file mode 100644
index d639e18..0000000
--- a/Documentation/devicetree/bindings/clock/qcom,dispcc.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-Qualcomm Technologies, Inc. Display Clock Controller Binding
-------------------------------------------------------------
-
-Required properties :
-
-- compatible : shall contain "qcom,sdm845-dispcc"
-- reg : shall contain base register location and length.
-- #clock-cells : from common clock binding, shall contain 1.
-- #reset-cells : from common reset binding, shall contain 1.
-- #power-domain-cells : from generic power domain binding, shall contain 1.
-
-Example:
-	dispcc: clock-controller@af00000 {
-		compatible = "qcom,sdm845-dispcc";
-		reg = <0xaf00000 0x100000>;
-		#clock-cells = <1>;
-		#reset-cells = <1>;
-		#power-domain-cells = <1>;
-	};
diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,dispcc.yaml
new file mode 100644
index 0000000..1185e49
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,dispcc.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/clock/qcom,dispcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Display Clock & Reset Controller Binding
+
+maintainers:
+  - Taniya Das <tdas@codeaurora.org>
+
+description: |
+  Qualcomm display clock control module which supports the clocks, resets and
+  power domains.
+
+properties:
+  compatible:
+    enum:
+      - qcom,sdm845-dispcc
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+    items:
+      - description: Board XO source
+      - description: GPLL0 source from GCC
+
+  clock-names:
+    items:
+      - const: xo
+      - const: gpll0
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+  '#power-domain-cells':
+    const: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+  - '#reset-cells'
+  - '#power-domain-cells'
+
+examples:
+  # Example of DISPCC with clock node properties for SDM845:
+  - |
+    clock-controller@af00000 {
+      compatible = "qcom,sdm845-dispcc";
+      reg = <0xaf00000 0x10000>;
+      clocks = <&rpmhcc 0>, <&gcc 24>;
+      clock-names = "xo", "gpll0";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+     };
+...
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

