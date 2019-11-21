Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537E6C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B94204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="u65R19sz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfKUJxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 04:53:12 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:30330 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726165AbfKUJxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 04:53:11 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAL9lSHh027654;
        Thu, 21 Nov 2019 10:53:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=WbtwwDT3nWx9hLJ3/dJjwMMjxpPXL7VD+gsWmcpdC3o=;
 b=u65R19szElJQq90oIOlasfp8pyb/ecYhA3tO1KIU2If2FEjhqsexava9kMOAzzmRIGpx
 OAn1Uq0JKDpBlhx5Y5vY6aArNkQS7IK/DtIvA0Qx7a4uQJoB25g2MOGH8Lcq8sfA/7M0
 guW8TEEmQ8ZkTbyR2P3Glz4mXq9GTb9w0ALH5recdW8FjkZu+MDBGFmlJNHSoFZfCfHh
 2orZHscb7Y7EcfJmzx+mu1tZbEXUI02T8kLx+grudI5jZAQ5L8XXqsMlJZ2AmVAy37sR
 d7Tt98kcMSFbO/FF8gFHr+bCz6IT4cm2G30KVOI2MNpJLT5H7l8Zc5sUFmHd1bfLm4nR 7w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2wa9ujagqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Nov 2019 10:53:00 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5BF3E100039;
        Thu, 21 Nov 2019 10:52:58 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4C1C92B05D9;
        Thu, 21 Nov 2019 10:52:58 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 21 Nov 2019 10:52:57
 +0100
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH v2] dt-bindings: remoteproc: convert stm32-rproc to json-schema
Date:   Thu, 21 Nov 2019 10:52:25 +0100
Message-ID: <20191121095225.26775-1-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-21_01:2019-11-21,2019-11-21 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the STM32 remoteproc bindings to DT schema format using
json-schema

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 .../bindings/remoteproc/st,stm32-rproc.yaml   | 131 ++++++++++++++++++
 .../bindings/remoteproc/stm32-rproc.txt       |  63 ---------
 2 files changed, 131 insertions(+), 63 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
 delete mode 100644 Documentation/devicetree/bindings/remoteproc/stm32-rproc.txt

diff --git a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
new file mode 100644
index 000000000000..13c2d06c2e0f
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
@@ -0,0 +1,131 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/remoteproc/st,stm32-rproc.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: STMicroelectronics STM32 remote processor controller bindings
+
+description:
+  This document defines the binding for the remoteproc component that loads and
+  boots firmwares on the ST32MP family chipset.
+
+maintainers:
+  - Fabien Dessenne <fabien.dessenne@st.com>
+  - Arnaud Pouliquen <arnaud.pouliquen@st.com>
+
+
+allOf:
+  - $ref: /schemas/mbox/mbox-consumer.yaml#
+
+properties:
+  compatible:
+    const: st,stm32mp1-m4
+
+  reg:
+    description:
+      Address ranges of the RETRAM and MCU SRAM memories used by the remote
+      processor.
+    maxItems: 3
+
+  resets:
+     maxItems: 1
+
+  st,syscfg-holdboot:
+    allOf:
+      - $ref: "/schemas/types.yaml#/definitions/phandle-array"
+    description: remote processor reset hold boot
+      - Phandle of syscon block.
+      - The offset of the hold boot setting register.
+      - The field mask of the hold boot.
+    maxItems: 1
+
+  st,syscfg-tz:
+    allOf:
+      - $ref: "/schemas/types.yaml#/definitions/phandle-array"
+    description:
+      Reference to the system configuration which holds the RCC trust zone mode
+      - Phandle of syscon block.
+      - The offset of the RCC trust zone mode register.
+      - The field mask of the RCC trust zone mode.
+    maxItems: 1
+
+  interrupts:
+    description: Should contain the WWDG1 watchdog reset interrupt
+    maxItems: 1
+
+  mboxes:
+    description:
+      This property is required only if the rpmsg/virtio functionality is used.
+    items:
+      - description: |
+          A channel (a) used to communicate through virtqueues with the
+          remote proc.
+          Bi-directional channel:
+            - from local to remote = send message
+            - from remote to local = send message ack
+      - description: |
+          A channel (b) working the opposite direction of channel (a)
+      - description: |
+          A channel (c) used by the local proc to notify the remote proc that it
+          is about to be shut down.
+          Unidirectional channel:
+            - from local to remote, where ACK from the remote means that it is
+              ready for shutdown
+    maxItems: 3
+
+  mbox-names:
+    items:
+      - const: vq0
+      - const: vq1
+      - const: shutdown
+    minItems: 1
+    maxItems: 3
+
+  memory-region:
+    description:
+      List of phandles to the reserved memory regions associated with the
+      remoteproc device. This is variable and describes the memories shared with
+      the remote processor (e.g. remoteproc firmware and carveouts, rpmsg
+      vrings, ...).
+      (see ../reserved-memory/reserved-memory.txt)
+
+  st,syscfg-pdds:
+    allOf:
+      - $ref: "/schemas/types.yaml#/definitions/phandle-array"
+    description: |
+      Reference to the system configuration which holds the remote
+        1st cell: phandle to syscon block
+        2nd cell: register offset containing the deep sleep setting
+        3rd cell: register bitmask for the deep sleep bit
+    maxItems: 1
+
+  st,auto-boot:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      If defined, when remoteproc is probed, it loads the default firmware and
+      starts the remote processor.
+
+required:
+  - compatible
+  - reg
+  - resets
+  - st,syscfg-holdboot
+  - st,syscfg-tz
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/reset/stm32mp1-resets.h>
+    m4_rproc: m4@10000000 {
+      compatible = "st,stm32mp1-m4";
+      reg = <0x10000000 0x40000>,
+            <0x30000000 0x40000>,
+            <0x38000000 0x10000>;
+      resets = <&rcc MCU_R>;
+      st,syscfg-holdboot = <&rcc 0x10C 0x1>;
+      st,syscfg-tz = <&rcc 0x000 0x1>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/remoteproc/stm32-rproc.txt b/Documentation/devicetree/bindings/remoteproc/stm32-rproc.txt
deleted file mode 100644
index 5fa915a4b736..000000000000
--- a/Documentation/devicetree/bindings/remoteproc/stm32-rproc.txt
+++ /dev/null
@@ -1,63 +0,0 @@
-STMicroelectronics STM32 Remoteproc
------------------------------------
-This document defines the binding for the remoteproc component that loads and
-boots firmwares on the ST32MP family chipset.
-
-Required properties:
-- compatible:	Must be "st,stm32mp1-m4"
-- reg:		Address ranges of the RETRAM and MCU SRAM memories used by the
-		remote processor.
-- resets:	Reference to a reset controller asserting the remote processor.
-- st,syscfg-holdboot: Reference to the system configuration which holds the
-		remote processor reset hold boot
-	1st cell: phandle of syscon block
-	2nd cell: register offset containing the hold boot setting
-	3rd cell: register bitmask for the hold boot field
-- st,syscfg-tz: Reference to the system configuration which holds the RCC trust
-		zone mode
-	1st cell: phandle to syscon block
-	2nd cell: register offset containing the RCC trust zone mode setting
-	3rd cell: register bitmask for the RCC trust zone mode bit
-
-Optional properties:
-- interrupts:	Should contain the watchdog interrupt
-- mboxes:	This property is required only if the rpmsg/virtio functionality
-		is used. List of phandle and mailbox channel specifiers:
-		- a channel (a) used to communicate through virtqueues with the
-		  remote proc.
-		  Bi-directional channel:
-		      - from local to remote = send message
-		      - from remote to local = send message ack
-		- a channel (b) working the opposite direction of channel (a)
-		- a channel (c) used by the local proc to notify the remote proc
-		  that it is about to be shut down.
-		  Unidirectional channel:
-		      - from local to remote, where ACK from the remote means
-		        that it is ready for shutdown
-- mbox-names:	This property is required if the mboxes property is used.
-		- must be "vq0" for channel (a)
-		- must be "vq1" for channel (b)
-		- must be "shutdown" for channel (c)
-- memory-region: List of phandles to the reserved memory regions associated with
-		the remoteproc device. This is variable and describes the
-		memories shared with the remote processor (eg: remoteproc
-		firmware and carveouts, rpmsg vrings, ...).
-		(see ../reserved-memory/reserved-memory.txt)
-- st,syscfg-pdds: Reference to the system configuration which holds the remote
-		processor deep sleep setting
-	1st cell: phandle to syscon block
-	2nd cell: register offset containing the deep sleep setting
-	3rd cell: register bitmask for the deep sleep bit
-- st,auto-boot:	If defined, when remoteproc is probed, it loads the default
-		firmware and starts the remote processor.
-
-Example:
-	m4_rproc: m4@10000000 {
-		compatible = "st,stm32mp1-m4";
-		reg = <0x10000000 0x40000>,
-		      <0x30000000 0x40000>,
-		      <0x38000000 0x10000>;
-		resets = <&rcc MCU_R>;
-		st,syscfg-holdboot = <&rcc 0x10C 0x1>;
-		st,syscfg-tz = <&rcc 0x000 0x1>;
-	};
-- 
2.17.1

