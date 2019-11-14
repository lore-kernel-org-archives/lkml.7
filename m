Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA66AC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 16:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C42420727
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 16:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="hkI/WIpf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfKNQlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 11:41:32 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:25332 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726214AbfKNQlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 11:41:32 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAEGRfQv012514;
        Thu, 14 Nov 2019 17:41:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=/A39Sh+nCYrrupVXGJZyMVV+LPFXNnjXh6rGGijztCw=;
 b=hkI/WIpfS0WslxmzwqRUtIm1FWpoHNI4/2n2xp4znd9LQEhp6zclQ+xFbyxfWh/OO4nV
 RnlzowKJ9Wceeg9AMUqe+SOT4gspwnnBvEtWi81iGA1KZf94ruwh2UIx6dZCAil/fhID
 HqpyUfrj7hwYgNtoCSkdzmL7cFm8MO+4CGgKdVoqQ5E8NnWGLvrZUfaCCa7LjlCG5Jm8
 028QQ14O2h0/yh+FbRvkF7dzzJx+EKQven4tgjrPGaoMoYu12duS8ZpPCXWwV5m+Basj
 lt6fAssTIhcizj6jzW2HsWEhRGkW/wqEvLPYAhs4kLd+t01tK9xnfFY3HeGnJhyHFxJ2 tA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2w7psbf99g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Nov 2019 17:41:07 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B6DA3100038;
        Thu, 14 Nov 2019 17:41:05 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9D0DE2C2DB5;
        Thu, 14 Nov 2019 17:41:05 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 14 Nov 2019 17:41:05
 +0100
From:   Alexandre Torgue <alexandre.torgue@st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] dt-bindings: interrupt-controller: Convert stm32-exti to json-schema
Date:   Thu, 14 Nov 2019 17:41:04 +0100
Message-ID: <20191114164104.22782-1-alexandre.torgue@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-14_05:2019-11-14,2019-11-14 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the STM32 external interrupt controller (EXTI) binding to DT
schema format using json-schema.

Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
---

Hi Rob,

I planned to use "additionalProperties: false" for this schema but as I add a
property under condition, I got an error (property added under contion seems
to be detected as an "additional" property and then error is raised).

Is there a way to fix that ?

regards
Alex

diff --git a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
deleted file mode 100644
index cd01b2292ec6..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-STM32 External Interrupt Controller
-
-Required properties:
-
-- compatible: Should be:
-    "st,stm32-exti"
-    "st,stm32h7-exti"
-    "st,stm32mp1-exti"
-- reg: Specifies base physical address and size of the registers
-- interrupt-controller: Indentifies the node as an interrupt controller
-- #interrupt-cells: Specifies the number of cells to encode an interrupt
-  specifier, shall be 2
-- interrupts: interrupts references to primary interrupt controller
-  (only needed for exti controller with multiple exti under
-  same parent interrupt: st,stm32-exti and st,stm32h7-exti)
-
-Optional properties:
-
-- hwlocks: reference to a phandle of a hardware spinlock provider node.
-
-Example:
-
-exti: interrupt-controller@40013c00 {
-	compatible = "st,stm32-exti";
-	interrupt-controller;
-	#interrupt-cells = <2>;
-	reg = <0x40013C00 0x400>;
-	interrupts = <1>, <2>, <3>, <6>, <7>, <8>, <9>, <10>, <23>, <40>, <41>, <42>, <62>, <76>;
-};
diff --git a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml
new file mode 100644
index 000000000000..39be37e1e532
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/st,stm32-exti.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STM32 External Interrupt Controller Device Tree Bindings
+
+maintainers:
+  - Alexandre Torgue <alexandre.torgue@st.com>
+  - Ludovic Barre <ludovic.barre@st.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+        - enum:
+          - st,stm32-exti
+          - st,stm32h7-exti
+      - items:
+        - enum:
+          - st,stm32mp1-exti
+        - const: syscon
+
+  "#interrupt-cells":
+    const: 2
+
+  reg:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  hwlocks:
+    maxItems: 1
+    description:
+      Reference to a phandle of a hardware spinlock provider node.
+
+required:
+  - "#interrupt-cells"
+  - compatible
+  - reg
+  - interrupt-controller
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - st,stm32-exti
+              - st,stm32h7-exti
+    then:
+      properties:
+        interrupts:
+          allOf:
+            - $ref: /schemas/types.yaml#/definitions/uint32-array
+          description:
+            Interrupts references to primary interrupt controller
+      required:
+        - interrupts
+
+examples:
+  - |
+    //Example 1
+    exti1: interrupt-controller@5000d000 {
+        compatible = "st,stm32mp1-exti", "syscon";
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        reg = <0x5000d000 0x400>;
+    };
+
+    //Example 2
+    exti2: interrupt-controller@40013c00 {
+        compatible = "st,stm32-exti";
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        reg = <0x40013C00 0x400>;
+        interrupts = <1>, <2>, <3>, <6>, <7>, <8>, <9>, <10>, <23>, <40>, <41>, <42>, <62>, <76>;
+    };
+
+...
-- 
2.17.1

