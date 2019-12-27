Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1240AC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 06:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC09620882
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 06:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="MpHDRE7J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfL0GjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 01:39:20 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:40135 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727215AbfL0GjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 01:39:17 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1577428757; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=QiQx3cjM55uLBJTSCwBsyoCk9KTzWDpDCsrXoBQpNao=; b=MpHDRE7J/3cGs2Fn/sKPYpQ01xnLZc2KcmhELRnV0X1nJxi17KUxtiLkIJUBQSNQLbIvMgYZ
 q50F78kUalGxvrMFyc0OIW3WzfAT3MQxv4eypAfmnL0o0yLKeKMhRjUTX83WeMGePftE+ypT
 1ZhzsLvSrs7lT0OJLnBmPwAiQcg=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e05a712.7f0165464f10-smtp-out-n02;
 Fri, 27 Dec 2019 06:39:14 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 88640C4479C; Fri, 27 Dec 2019 06:39:13 +0000 (UTC)
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 32D8BC447A4;
        Fri, 27 Dec 2019 06:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 32D8BC447A4
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Michael=20Turquette=20=C2=A0?= <mturquette@baylibre.com>
Cc:     David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        robh@kernel.org, robh+dt@kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v3 4/6] dt-bindings: clock: Add YAML schemas for the QCOM VIDEOCC clock bindings
Date:   Fri, 27 Dec 2019 12:08:32 +0530
Message-Id: <1577428714-17766-5-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1577428714-17766-1-git-send-email-tdas@codeaurora.org>
References: <1577428714-17766-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VIDEOCC clock provider have a bunch of generic properties that
are needed in a device tree. Add a YAML schemas for those.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/clock/qcom,videocc.txt     | 18 -------
 .../devicetree/bindings/clock/qcom,videocc.yaml    | 61 ++++++++++++++++++++++
 2 files changed, 61 insertions(+), 18 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,videocc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,videocc.yaml

diff --git a/Documentation/devicetree/bindings/clock/qcom,videocc.txt b/Documentation/devicetree/bindings/clock/qcom,videocc.txt
deleted file mode 100644
index 8a8622c..0000000
--- a/Documentation/devicetree/bindings/clock/qcom,videocc.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-Qualcomm Video Clock & Reset Controller Binding
------------------------------------------------
-
-Required properties :
-- compatible : shall contain "qcom,sdm845-videocc"
-- reg : shall contain base register location and length
-- #clock-cells : from common clock binding, shall contain 1.
-- #power-domain-cells : from generic power domain binding, shall contain 1.
-- #reset-cells : from common reset binding, shall contain 1.
-
-Example:
-	videocc: clock-controller@ab00000 {
-		compatible = "qcom,sdm845-videocc";
-		reg = <0xab00000 0x10000>;
-		#clock-cells = <1>;
-		#power-domain-cells = <1>;
-		#reset-cells = <1>;
-	};
diff --git a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
new file mode 100644
index 0000000..fc3fcca
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/clock/qcom,videocc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Video Clock & Reset Controller Binding
+
+maintainers:
+  - Taniya Das <tdas@codeaurora.org>
+
+description: |
+  Qualcomm video clock control module which supports the clocks, resets and
+  power domains.
+
+properties:
+  compatible:
+    enum:
+      - qcom,sdm845-videocc
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: xo
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
+  # Example of VIDEOCC with clock node properties for SDM845:
+  - |
+    clock-controller@ab00000 {
+      compatible = "qcom,sdm845-videocc";
+      reg = <0xab00000 0x10000>;
+      clocks = <&rpmhcc 0>;
+      clock-names = "xo";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+     };
+...
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.
