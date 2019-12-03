Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BA4C432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46E1E2073B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="PTM6wWmL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfLCNt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 08:49:29 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:58424 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726086AbfLCNt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 08:49:29 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB3DgIOx015268;
        Tue, 3 Dec 2019 14:49:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=aUjKg25Cf5lmzJtCypgppJCtT5TP5s8zd2LxslojreM=;
 b=PTM6wWmLt9Y003352fCUqBlRRhPfMu0x8vr+cavl7iwkYIs3Wp/3h7xfKxYfKjchot8i
 4ly7ScOQfx8Umpb5A+tPj107dduvFxTwslZ5ViHFkNU5cq5y2kCDuT7L4NQaTdShdDdq
 lGfnYg/C7qc8L2sYqP6rEYzTxCi8gfUXgVJtUQ2tWPmXpPpr9MSFDN963X93RxsdVwWL
 mLnmz96pGFKDlzQOYPI7rhpOB/7FGr0nM49Cq6oI3au8mVOdYO6Y9DYnnqiSlJVWgvac
 S9D2v0U2iO9IAb0Vhd+K0wT8GZ1qDkv/bj1ucor6g6qWHGHrROePzh3b7aF5nu6BzjgP Bg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2wkg6kfhfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Dec 2019 14:49:11 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3F111100034;
        Tue,  3 Dec 2019 14:49:11 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1B8502BC7AF;
        Tue,  3 Dec 2019 14:49:11 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 3 Dec 2019 14:49:10
 +0100
From:   Pascal Paillet <p.paillet@st.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <p.paillet@st.com>
Subject: [PATCH] regulator: Convert stm32-pwr regulator to json-schema
Date:   Tue, 3 Dec 2019 14:49:10 +0100
Message-ID: <20191203134910.26470-1-p.paillet@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-03_03:2019-12-02,2019-12-03 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the stm32-pwr regulator binding to DT schema format using
json-schema.

Signed-off-by: Pascal Paillet <p.paillet@st.com>
---
 .../regulator/st,stm32mp1-pwr-reg.txt         | 43 ------------
 .../regulator/st,stm32mp1-pwr-reg.yaml        | 67 +++++++++++++++++++
 2 files changed, 67 insertions(+), 43 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml

diff --git a/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.txt b/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.txt
deleted file mode 100644
index e372dd3f0c8a..000000000000
--- a/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-STM32MP1 PWR Regulators
------------------------
-
-Available Regulators in STM32MP1 PWR block are:
-  - reg11 for regulator 1V1
-  - reg18 for regulator 1V8
-  - usb33 for the swtich USB3V3
-
-Required properties:
-- compatible: Must be "st,stm32mp1,pwr-reg"
-- list of child nodes that specify the regulator reg11, reg18 or usb33
-  initialization data for defined regulators. The definition for each of
-  these nodes is defined using the standard binding for regulators found at
-  Documentation/devicetree/bindings/regulator/regulator.txt.
-- vdd-supply: phandle to the parent supply/regulator node for vdd input
-- vdd_3v3_usbfs-supply: phandle to the parent supply/regulator node for usb33
-
-Example:
-
-pwr_regulators: pwr@50001000 {
-	compatible = "st,stm32mp1,pwr-reg";
-	reg = <0x50001000 0x10>;
-	vdd-supply = <&vdd>;
-	vdd_3v3_usbfs-supply = <&vdd_usb>;
-
-	reg11: reg11 {
-		regulator-name = "reg11";
-		regulator-min-microvolt = <1100000>;
-		regulator-max-microvolt = <1100000>;
-	};
-
-	reg18: reg18 {
-		regulator-name = "reg18";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	usb33: usb33 {
-		regulator-name = "usb33";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml b/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
new file mode 100644
index 000000000000..f661728ebdeb
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/st,stm32mp1-pwr-reg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STM32MP1 PWR voltage regulators
+
+maintainers:
+  - Pascal Paillet <p.paillet@st.com>
+
+allOf:
+  - $ref: "regulator.yaml#"
+
+properties:
+  compatible:
+    const: st,stm32mp1,pwr-reg
+
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description: Input supply phandle(s) for vdd input
+
+  vdd_3v3_usbfs-supply:
+    description: Input supply phandle(s) for vdd_3v3_usbfs input
+
+patternProperties:
+  "^(reg11|reg18|usb33)":
+    type: object
+
+    allOf:
+      - $ref: "regulator.yaml#"
+
+required:
+   - compatible
+   - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    pwr@50001000 {
+      compatible = "st,stm32mp1,pwr-reg";
+      reg = <0x50001000 0x10>;
+      vdd-supply = <&vdd>;
+      vdd_3v3_usbfs-supply = <&vdd_usb>;
+
+      reg11 {
+        regulator-name = "reg11";
+        regulator-min-microvolt = <1100000>;
+        regulator-max-microvolt = <1100000>;
+      };
+
+      reg18 {
+        regulator-name = "reg18";
+        regulator-min-microvolt = <1800000>;
+        regulator-max-microvolt = <1800000>;
+      };
+
+      usb33 {
+        regulator-name = "usb33";
+        regulator-min-microvolt = <3300000>;
+        regulator-max-microvolt = <3300000>;
+      };
+    };
+...
-- 
2.17.1

