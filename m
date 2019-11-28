Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78916C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 15:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50949217BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 15:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="QgnRDT9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfK1PrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 10:47:16 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:37584 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726510AbfK1PrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 10:47:16 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xASFgPVo023621;
        Thu, 28 Nov 2019 16:47:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=rUcrmp6FDis0MYM6sfyej2AR9/hatx5q+JoT9j7Vktc=;
 b=QgnRDT9ig/K54IfKnmwnt2JtFyprAUi04+kHWxFzQgcYH/QuQkzGhzskgFXZd9XgArH+
 UBtCPA2Y/6gadfBYviu05CWYYtwTy3lVmB/RI5CYW1uHdPnAThIkD/pNYsyVH/Mlyg7i
 5I3fqSn+wL3QyxjLYI20t5wjBxw4Bk3f2v2w5fUJlOH4ge/Ot27pTadhSLehGzZwsyxX
 3wjVqFe1nBQYQrLFWAn+A9yeXjXvz8R6gtC1ZYe/itZ9KneD4I2G+3+SoMFqMq1blm2k
 tqLp9L5fIkP7JZXInWUWIyUSpNlaC1Ppsl/v2/vE/nSUBKWti9Fj1rd4N7+iwC7TvpsS lw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2whcxktpp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Nov 2019 16:47:00 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D5DDE10002A;
        Thu, 28 Nov 2019 16:46:59 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BFB482BF9AD;
        Thu, 28 Nov 2019 16:46:59 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 Nov 2019 16:46:58
 +0100
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH] dt-bindings: stm32: convert mlahb to json-schema
Date:   Thu, 28 Nov 2019 16:46:03 +0100
Message-ID: <20191128154603.6911-1-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-28_04:2019-11-28,2019-11-28 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the ML-AHB bus bindings to DT schema format using json-schema

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
Notice that this patch requests an update of the simple-bus schema to add
the support of the "dma-ranges" property.
A Pull request has been sent in parallel to the dt-schema github repo:
https://github.com/devicetree-org/dt-schema/pull/30

To remind the topic around the use of "dma-ranges" please
refer to following discussion: https://lkml.org/lkml/2019/4/3/1261
---
 .../devicetree/bindings/arm/stm32/mlahb.txt   | 37 ----------
 .../bindings/arm/stm32/st,mlahb.yaml          | 69 +++++++++++++++++++
 2 files changed, 69 insertions(+), 37 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/stm32/mlahb.txt
 create mode 100644 Documentation/devicetree/bindings/arm/stm32/st,mlahb.yaml

diff --git a/Documentation/devicetree/bindings/arm/stm32/mlahb.txt b/Documentation/devicetree/bindings/arm/stm32/mlahb.txt
deleted file mode 100644
index 25307aa1eb9b..000000000000
--- a/Documentation/devicetree/bindings/arm/stm32/mlahb.txt
+++ /dev/null
@@ -1,37 +0,0 @@
-ML-AHB interconnect bindings
-
-These bindings describe the STM32 SoCs ML-AHB interconnect bus which connects
-a Cortex-M subsystem with dedicated memories.
-The MCU SRAM and RETRAM memory parts can be accessed through different addresses
-(see "RAM aliases" in [1]) using different buses (see [2]) : balancing the
-Cortex-M firmware accesses among those ports allows to tune the system
-performance.
-
-[1]: https://www.st.com/resource/en/reference_manual/dm00327659.pdf
-[2]: https://wiki.st.com/stm32mpu/wiki/STM32MP15_RAM_mapping
-
-Required properties:
-- compatible: should be "simple-bus"
-- dma-ranges: describes memory addresses translation between the local CPU and
-	   the remote Cortex-M processor. Each memory region, is declared with
-	   3 parameters:
-		 - param 1: device base address (Cortex-M processor address)
-		 - param 2: physical base address (local CPU address)
-		 - param 3: size of the memory region.
-
-The Cortex-M remote processor accessed via the mlahb interconnect is described
-by a child node.
-
-Example:
-mlahb {
-	compatible = "simple-bus";
-	#address-cells = <1>;
-	#size-cells = <1>;
-	dma-ranges = <0x00000000 0x38000000 0x10000>,
-		     <0x10000000 0x10000000 0x60000>,
-		     <0x30000000 0x30000000 0x60000>;
-
-	m4_rproc: m4@10000000 {
-		...
-	};
-};
diff --git a/Documentation/devicetree/bindings/arm/stm32/st,mlahb.yaml b/Documentation/devicetree/bindings/arm/stm32/st,mlahb.yaml
new file mode 100644
index 000000000000..8ad3f7c7f9ab
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/stm32/st,mlahb.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/arm/stm32/st,mlahb.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: STMicroelectronics STM32 ML-AHB interconnect bindings
+
+maintainers:
+  - Fabien Dessenne <fabien.dessenne@st.com>
+  - Arnaud Pouliquen <arnaud.pouliquen@st.com>
+
+description: |
+  These bindings describe the STM32 SoCs ML-AHB interconnect bus which connects
+  a Cortex-M subsystem with dedicated memories. The MCU SRAM and RETRAM memory
+  parts can be accessed through different addresses (see "RAM aliases" in [1])
+  using different buses (see [2]): balancing the Cortex-M firmware accesses
+  among those ports allows to tune the system performance.
+  [1]: https://www.st.com/resource/en/reference_manual/dm00327659.pdf
+  [2]: https://wiki.st.com/stm32mpu/wiki/STM32MP15_RAM_mapping
+
+allOf:
+ - $ref: /schemas/simple-bus.yaml#
+
+properties:
+  compatible:
+    contains:
+      enum:
+        - st,mlahb
+
+  dma-ranges:
+    description: |
+      Describe memory addresses translation between the local CPU and the
+      remote Cortex-M processor. Each memory region, is declared with
+      3 parameters:
+      - param 1: device base address (Cortex-M processor address)
+      - param 2: physical base address (local CPU address)
+      - param 3: size of the memory region.
+    maxItems: 3
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+required:
+  - compatible
+  - '#address-cells'
+  - '#size-cells'
+  - dma-ranges
+
+examples:
+  - |
+    mlahb: ahb {
+      compatible = "st,mlahb", "simple-bus";
+      #address-cells = <1>;
+      #size-cells = <1>;
+      reg = <0x10000000 0x40000>;
+      dma-ranges = <0x00000000 0x38000000 0x10000>,
+                   <0x10000000 0x10000000 0x60000>,
+                   <0x30000000 0x30000000 0x60000>;
+
+      m4_rproc: m4@10000000 {
+       reg = <0x10000000 0x40000>;
+      };
+    };
+
+...
-- 
2.17.1

