Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE04C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B13320730
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="gzj3jtQh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfKOSMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 13:12:55 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:2452 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726075AbfKOSMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 13:12:55 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAFI7gcv008411;
        Fri, 15 Nov 2019 19:12:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=I4OZGc1DEJycxhbwtoTStNlbRPxr5FwtwYGsHf5hRvs=;
 b=gzj3jtQhOMX+xdIenn64k/uK3jNnOXxkLSsOvRO11bj4P6QPQnCbccIwxFeksoPn8UJ4
 1OmEqkDWAg4lRS099CgMulu6KCOTluXysxf1rK90QggUZ+VjDFBuv0BKzyPBYppGxjon
 gx/25JlLgEYJX0wwoBKf1SgOJ+TWhAqS3yohngImYoioujE8bRCwK5/RrfN3aNIlxYxN
 xJwizplGZ2amzeGkX0VxJ7nDavBqcaSL0Je/8TGC0HO3/oR2AUgV6RFT1uOEAlAqHeGw
 lLBl1rtIzOx1321MNIXSMiWvn6eOXfYnM8vGgJRqpvQtPpOpWabdAPRydt1uTlmFxzbY gA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2w7psbnnxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Nov 2019 19:12:40 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5495310002A;
        Fri, 15 Nov 2019 19:12:40 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 42A412C161F;
        Fri, 15 Nov 2019 19:12:40 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 15 Nov 2019 19:12:39
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
Subject: [PATCH v2] dt-bindings: interrupt-controller: Convert stm32-exti to json-schema
Date:   Fri, 15 Nov 2019 19:12:39 +0100
Message-ID: <20191115181239.549-1-alexandre.torgue@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-15_05:2019-11-15,2019-11-15 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the STM32 external interrupt controller (EXTI) binding to DT
schema format using json-schema.

Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

---

Changes since v1:

According to Rob's review:

-fix license
-fix interrupts conditional declaration

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
index 000000000000..9e5c6608b4e3
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
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
+  interrupts:
+    description:
+      Interrupts references to primary interrupt controller
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
+    then:
+      properties:
+        interrupts:
+          minItems: 1
+          maxItems: 32
+      required:
+        - interrupts
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - st,stm32h7-exti
+    then:
+      properties:
+        interrupts:
+          minItems: 1
+          maxItems: 96
+      required:
+        - interrupts
+
+additionalProperties: false
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

