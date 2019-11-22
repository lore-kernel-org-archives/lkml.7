Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A7FC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3AF420748
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Lh7tB1R1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbfKVKp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:45:59 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:7864 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729545AbfKVKpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:45:53 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAMAhMJr011963;
        Fri, 22 Nov 2019 11:45:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=3uvMaCvyj8tNBEVETH0tKEXxb92y41/JsxGMzqMtSM0=;
 b=Lh7tB1R1ohJKj4m7G9Csue4E8s4QAaeKoV/JqDc4YtKTvf3p0z4hbVAhT7Bw04eZJAyZ
 vHxWUxlrDUgcQ+lOdWA+0fSThIFxPTO5kvnC9q11E1pcDf999mHebtt/JVehGb7RvPDn
 7JaJSN8NIMln40R12+4BQLEbyIQqmtMDb+0SCYSUFUvhEoVLcqSrBa8mMv+VRpJBg9X5
 p+E2k2WIhiAcQvJQD8HWFoQQBeJ6J3Sz/mMMfw0UUF9IZ094ubNcB4Ercoxw7rkOmvRM
 ZuuPXe7dB//xFr6QqvLAxdbVTsGOqJcWxayp7ET9cLpmrzWaetamDgaGGrKh2ixkgru2 kQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2wa9usrayx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Nov 2019 11:45:40 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 31F6710002A;
        Fri, 22 Nov 2019 11:45:40 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 166482B56BD;
        Fri, 22 Nov 2019 11:45:40 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 22 Nov 2019 11:45:39
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <alexandre.torgue@st.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH] dt-bindings: regulator: Convert stm32 vrefbuf bindings to json-schema
Date:   Fri, 22 Nov 2019 11:45:36 +0100
Message-ID: <20191122104536.20283-2-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20191122104536.20283-1-benjamin.gaignard@st.com>
References: <20191122104536.20283-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG6NODE1.st.com (10.75.127.16) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-22_02:2019-11-21,2019-11-22 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the STM32 regulator vrefbuf binding to DT schema format using json-schema

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
CC: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 .../bindings/regulator/st,stm32-vrefbuf.txt        | 20 ---------
 .../bindings/regulator/st,stm32-vrefbuf.yaml       | 52 ++++++++++++++++++++++
 2 files changed, 52 insertions(+), 20 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/st,stm32-vrefbuf.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/st,stm32-vrefbuf.yaml

diff --git a/Documentation/devicetree/bindings/regulator/st,stm32-vrefbuf.txt b/Documentation/devicetree/bindings/regulator/st,stm32-vrefbuf.txt
deleted file mode 100644
index 5ddb8500a929..000000000000
--- a/Documentation/devicetree/bindings/regulator/st,stm32-vrefbuf.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-STM32 VREFBUF - Voltage reference buffer
-
-Some STM32 devices embed a voltage reference buffer which can be used as
-voltage reference for ADCs, DACs and also as voltage reference for external
-components through the dedicated VREF+ pin.
-
-Required properties:
-- compatible:		Must be "st,stm32-vrefbuf".
-- reg:			Offset and length of VREFBUF register set.
-- clocks:		Must contain an entry for peripheral clock.
-
-Example:
-	vrefbuf: regulator@58003c00 {
-		compatible = "st,stm32-vrefbuf";
-		reg = <0x58003C00 0x8>;
-		clocks = <&rcc VREF_CK>;
-		regulator-min-microvolt = <1500000>;
-		regulator-max-microvolt = <2500000>;
-		vdda-supply = <&vdda>;
-	};
diff --git a/Documentation/devicetree/bindings/regulator/st,stm32-vrefbuf.yaml b/Documentation/devicetree/bindings/regulator/st,stm32-vrefbuf.yaml
new file mode 100644
index 000000000000..33cdaeb25aee
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/st,stm32-vrefbuf.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/st,stm32-vrefbuf.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STM32 Voltage reference buffer bindings
+
+description: |
+  Some STM32 devices embed a voltage reference buffer which can be used as
+  voltage reference for ADCs, DACs and also as voltage reference for external
+  components through the dedicated VREF+ pin.
+
+maintainers:
+  - Fabrice Gasnier <fabrice.gasnier@st.com>
+
+allOf:
+  - $ref: "regulator.yaml#"
+
+properties:
+  compatible:
+    const: st,stm32-vrefbuf
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  vdda-supply:
+    description: phandle to the vdda input analog voltage.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - vdda-supply
+
+examples:
+  - |
+    #include <dt-bindings/clock/stm32mp1-clks.h>
+    vrefbuf@50025000 {
+      compatible = "st,stm32-vrefbuf";
+      reg = <0x50025000 0x8>;
+      regulator-min-microvolt = <1500000>;
+      regulator-max-microvolt = <2500000>;
+      clocks = <&rcc VREF>;
+      vdda-supply = <&vdda>;
+    };
+
+...
+
-- 
2.15.0

