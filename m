Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B318C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7FC4207FA
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="gYNaqs3+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbfKVKkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:40:04 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:40964 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726546AbfKVKj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:39:59 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAMAddRd023808;
        Fri, 22 Nov 2019 11:39:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=Yb4uCeALV8Ui44IqHMV+f+MNdt/2wAzvgT9C57Q3BZw=;
 b=gYNaqs3+QC6W3lndyyz8UqbqmpEyOIZp1U1iZ28HGNjAXmZW/dWrvDAesNWYWg3CXIuZ
 W4rOFR9Qy/VZ3QQzNzN7VIfuYbDvN8rQmoHY92ynRaDGrF/WH5HmACEoGiloOgENoLR7
 CtqIUfkKscVnBACUQbXZZYRrnj1tqX8W39Iv106aYETYA6bL10VcDxK+JhSNxEkeqC+q
 Itashsf+Py7ul0X53zWXSXIXrmRkatC7mqLXOJhV4uVDmMdVXdIQNyRoJvrhxIcdOsge
 tRoiUnfzUqyGihNiGj2xT/yMsxz+fpxiJm5x10a1RxqTxjWkv2U9Io82eNNKUyLbbtcP 9A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2wa9uvrqa0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Nov 2019 11:39:44 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 41F31100034;
        Fri, 22 Nov 2019 11:39:43 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 133DA2B56A1;
        Fri, 22 Nov 2019 11:39:43 +0100 (CET)
Received: from localhost (10.75.127.51) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 22 Nov 2019 11:39:42
 +0100
From:   Alexandre Torgue <alexandre.torgue@st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] dt-bindings: arm: stm32: Convert stm32-syscon to json-schema
Date:   Fri, 22 Nov 2019 11:39:42 +0100
Message-ID: <20191122103942.23572-1-alexandre.torgue@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG4NODE1.st.com (10.75.127.10) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-22_02:2019-11-21,2019-11-22 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the STM32 syscon binding to DT schema format using json-schema.

Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

diff --git a/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml b/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml
new file mode 100644
index 000000000000..0dedf94c8578
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/arm/stm32/st,stm32-syscon.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: STMicroelectronics STM32 Platforms System Controller bindings
+
+maintainers:
+  - Alexandre Torgue <alexandre.torgue@st.com>
+  - Christophe Roullier <christophe.roullier@st.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+        - enum:
+          - st,stm32mp157-syscfg
+        - const: syscon
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+examples:
+  - |
+    #include <dt-bindings/clock/stm32mp1-clks.h>
+    syscfg: syscon@50020000 {
+        compatible = "st,stm32mp157-syscfg", "syscon";
+        reg = <0x50020000 0x400>;
+        clocks = <&rcc SYSCFG>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32-syscon.txt b/Documentation/devicetree/bindings/arm/stm32/stm32-syscon.txt
deleted file mode 100644
index c92d411fd023..000000000000
--- a/Documentation/devicetree/bindings/arm/stm32/stm32-syscon.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-STMicroelectronics STM32 Platforms System Controller
-
-Properties:
-   - compatible : should contain two values. First value must be :
-                 - " st,stm32mp157-syscfg " - for stm32mp157 based SoCs,
-                 second value must be always "syscon".
-   - reg : offset and length of the register set.
-   - clocks: phandle to the syscfg clock
-
- Example:
-         syscfg: syscon@50020000 {
-                 compatible = "st,stm32mp157-syscfg", "syscon";
-                 reg = <0x50020000 0x400>;
-                 clocks = <&rcc SYSCFG>;
-         };
-
-- 
2.17.1

