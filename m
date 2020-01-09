Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF87C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 11:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5079D20656
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 11:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="QSd+j3/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbgAILvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 06:51:42 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:38273 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728618AbgAILvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 06:51:41 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578570701; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=wkMSvvedidKl+MpNoSaqFgdTzSSWj6iDIRJzG2yZ1SA=; b=QSd+j3/2Y2S2s+Upx9z8RAaGyfj8E45WBzByPGMnG3/cHZbjaJoDg02P2ih98NoGSxNT4bLW
 kc8vSp0WNNz7rP8N4vZGXPmbZO5cg2ypF+yePIzxC6KQTCgiUQ/7z920PPLI52uONxDUvOip
 UOQ/EnE8JiJRksPgncwRTuwT2B4=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e1713cb.7ff8ec5c7960-smtp-out-n03;
 Thu, 09 Jan 2020 11:51:39 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D7E9FC447A2; Thu,  9 Jan 2020 11:51:38 +0000 (UTC)
Received: from sthella-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sthella)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 990ECC4479C;
        Thu,  9 Jan 2020 11:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 990ECC4479C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sthella@codeaurora.org
From:   Shyam Kumar Thella <sthella@codeaurora.org>
To:     agross@kernel.org, srinivas.kandagatla@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     Shyam Kumar Thella <sthella@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: nvmem: add binding for QTI SPMI SDAM
Date:   Thu,  9 Jan 2020 17:21:22 +0530
Message-Id: <1578570682-4686-1-git-send-email-sthella@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QTI SDAM allows PMIC peripherals to access the shared memory that is
available on QTI PMICs. Add documentation for it.

Signed-off-by: Shyam Kumar Thella <sthella@codeaurora.org>
---
 .../devicetree/bindings/nvmem/qcom,spmi-sdam.yaml  | 80 ++++++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml b/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
new file mode 100644
index 0000000..c2b1d65
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/qcom,spmi-sdam.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. SPMI SDAM DT bindings
+
+maintainers:
+  - Shyam Kumar Thella <sthella@codeaurora.org>
+
+description: |
+  The SDAM provides scratch register space for the PMIC clients. This
+  memory can be used by software to store information or communicate
+  to/from the PBUS.
+
+allOf:
+  - $ref: "nvmem.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - qcom,spmi-sdam
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+
+patternProperties:
+  "^.*@[0-9a-f]+$":
+    type: object
+
+    properties:
+      reg:
+        maxItems: 1
+        description:
+          Offset and size in bytes within the storage device.
+
+      bits:
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        maxItems: 1
+        items:
+          items:
+            - minimum: 0
+              maximum: 7
+              description:
+                Offset in bit within the address range specified by reg.
+            - minimum: 1
+              description:
+                Size in bit within the address range specified by reg.
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+examples:
+  - |
+      sdam_1: nvram@b000 {
+         #address-cells = <1>;
+         #size-cells = <1>;
+         compatible = "qcom,spmi-sdam";
+          reg = <0xb000 0x100>;
+
+          /* Data cells */
+          restart_reason: restart@50 {
+              reg = <0x50 0x1>;
+              bits = <6 2>;
+          };
+      };
+...
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
 a Linux Foundation Collaborative Project
