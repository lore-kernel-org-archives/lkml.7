Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA8AC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 10:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB0820727
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 10:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="lF6z598X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfKRKPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 05:15:11 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:58224 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726460AbfKRKPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 05:15:11 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAIACf3i029389;
        Mon, 18 Nov 2019 11:14:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=JjcDf7Se1JV93hHJ3IUg1llt1Gmr33d0sDqj28vMS+A=;
 b=lF6z598XQNP7D8PkuPEODSravAKBbTY5z2krXCYaG1nAkzuD7XOHWiB6kGwhY8ugWEIB
 mUrvAVLD9wR6VS3Kt0TktGKPqZhXemfEr4NKZ+T3xHkzWBTyBFUlcDPtr3TUc+Iid95i
 EBJr+zyAB5Kj6pkUxpsdogLB05uyzg2fayipistl9Hj1frG7BHnbSVhvTUsLyD38fJbl
 N7cQjoESxU56rfllI81FFDiwy2LtiQu3UMyovLitgQM8PSAuWe4R5++CKVKiTSviPv69
 yFDeYk+mz36HS0JTXzBx1ksOQ7ws0hLa0kQT2Sgv9sIqQudfDCosL2W5tTSLfq/GfKai kQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2wa9uv0sjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Nov 2019 11:14:59 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 846F3100051;
        Mon, 18 Nov 2019 11:14:48 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7056B2BE245;
        Mon, 18 Nov 2019 11:14:48 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 18 Nov 2019 11:14:48
 +0100
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH v2] dt-bindings: mailbox: convert stm32-ipcc to json-schema
Date:   Mon, 18 Nov 2019 11:14:20 +0100
Message-ID: <20191118101420.23610-1-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-18_01:2019-11-15,2019-11-17 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the STM32 IPCC bindings to DT schema format using
json-schema

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 .../bindings/mailbox/st,stm32-ipcc.yaml       | 91 +++++++++++++++++++
 .../bindings/mailbox/stm32-ipcc.txt           | 47 ----------
 2 files changed, 91 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/st,stm32-ipcc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mailbox/stm32-ipcc.txt

diff --git a/Documentation/devicetree/bindings/mailbox/st,stm32-ipcc.yaml b/Documentation/devicetree/bindings/mailbox/st,stm32-ipcc.yaml
new file mode 100644
index 000000000000..90157d4deac1
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/st,stm32-ipcc.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/mailbox/st,stm32-ipcc.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: STMicroelectronics STM32 IPC controller bindings
+
+description:
+  The IPCC block provides a non blocking signaling mechanism to post and
+  retrieve messages in an atomic way between two processors.
+  It provides the signaling for N bidirectionnal channels. The number of
+  channels (N) can be read from a dedicated register.
+
+maintainers:
+  - Fabien Dessenne <fabien.dessenne@st.com>
+  - Arnaud Pouliquen <arnaud.pouliquen@st.com>
+
+properties:
+  compatible:
+    const: st,stm32mp1-ipcc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+     maxItems: 1
+
+  interrupts:
+    items:
+      - description: rx channel occupied
+      - description: tx channel free
+      - description: wakeup source
+    minItems: 2
+    maxItems: 3
+
+  interrupt-names:
+    items:
+      enums: [ rx, tx, wakeup ]
+    minItems: 2
+    maxItems: 3
+
+  wakeup-source:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Enables wake up of host system on wakeup IRQ assertion.
+
+  "#mbox-cells":
+    const: 1
+
+  st,proc-id:
+    description: Processor id using the mailbox (0 or 1)
+    allOf:
+      - minimum: 0
+      - maximum: 1
+      - default: 0
+
+required:
+  - compatible
+  - reg
+  - st,proc-id
+  - clocks
+  - interrupt-names
+  - "#mbox-cells"
+
+oneOf:
+  - required:
+      - interrupts
+  - required:
+      - interrupts-extended
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/stm32mp1-clks.h>
+    ipcc: mailbox@4c001000 {
+      compatible = "st,stm32mp1-ipcc";
+      #mbox-cells = <1>;
+      reg = <0x4c001000 0x400>;
+      st,proc-id = <0>;
+      interrupts-extended = <&intc GIC_SPI 100 IRQ_TYPE_NONE>,
+      		      <&intc GIC_SPI 101 IRQ_TYPE_NONE>,
+      		      <&aiec 62 1>;
+      interrupt-names = "rx", "tx", "wakeup";
+      clocks = <&rcc_clk IPCC>;
+      wakeup-source;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/mailbox/stm32-ipcc.txt b/Documentation/devicetree/bindings/mailbox/stm32-ipcc.txt
deleted file mode 100644
index 1d2b7fee7b85..000000000000
--- a/Documentation/devicetree/bindings/mailbox/stm32-ipcc.txt
+++ /dev/null
@@ -1,47 +0,0 @@
-* STMicroelectronics STM32 IPCC (Inter-Processor Communication Controller)
-
-The IPCC block provides a non blocking signaling mechanism to post and
-retrieve messages in an atomic way between two processors.
-It provides the signaling for N bidirectionnal channels. The number of channels
-(N) can be read from a dedicated register.
-
-Required properties:
-- compatible:   Must be "st,stm32mp1-ipcc"
-- reg:          Register address range (base address and length)
-- st,proc-id:   Processor id using the mailbox (0 or 1)
-- clocks:       Input clock
-- interrupt-names: List of names for the interrupts described by the interrupt
-                   property. Must contain the following entries:
-                   - "rx"
-                   - "tx"
-                   - "wakeup"
-- interrupts:   Interrupt specifiers for "rx channel occupied", "tx channel
-                free" and "system wakeup".
-- #mbox-cells:  Number of cells required for the mailbox specifier. Must be 1.
-                The data contained in the mbox specifier of the "mboxes"
-                property in the client node is the mailbox channel index.
-
-Optional properties:
-- wakeup-source: Flag to indicate whether this device can wake up the system
-
-
-
-Example:
-	ipcc: mailbox@4c001000 {
-		compatible = "st,stm32mp1-ipcc";
-		#mbox-cells = <1>;
-		reg = <0x4c001000 0x400>;
-		st,proc-id = <0>;
-		interrupts-extended = <&intc GIC_SPI 100 IRQ_TYPE_NONE>,
-				      <&intc GIC_SPI 101 IRQ_TYPE_NONE>,
-				      <&aiec 62 1>;
-		interrupt-names = "rx", "tx", "wakeup";
-		clocks = <&rcc_clk IPCC>;
-		wakeup-source;
-	}
-
-Client:
-	mbox_test {
-		...
-		mboxes = <&ipcc 0>, <&ipcc 1>;
-	};
-- 
2.17.1

