Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EFDC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6D22071C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="zRs3IQ0s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbfKVKpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:45:54 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:13414 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729099AbfKVKpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:45:51 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAMAekVL019532;
        Fri, 22 Nov 2019 11:45:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=N39mr9JiTRKAZ1G00aMZSsPpF8DNn4u3LtchSa7kshc=;
 b=zRs3IQ0sYnHGLbdAp8Qcbs1LPVM6hiseuU2EaV81OLdu1orRFdFdGek7lyu+4XLnT6VF
 pfqaWIdK4o4D4ixeub7XGVgBUhyHYZc8DXazRNjNY7oYGBmb5cBjDPGr1ChxxIAyN9TX
 ti3SkPxBbHTW0hw4ZinMEmjuTTfuMClWLVsLbrtfZz7pNXs26UUqqiEzL/fYCUlNKi2r
 9DPW6wB9hr/Y1NMKtrfggCGjRLMsRBf2Hx+EFJ3vLJ6Nca18ybwm50K1cgkD6CK5jI7A
 x7KW5NoMMW8z+rmw2rdZ41pAHjnk8oY6w9q+vSj/ziCrjQHsS2C6pzD8+zyyRVWYDcOi 4A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2wa9upgtrt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Nov 2019 11:45:39 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4C4C4100038;
        Fri, 22 Nov 2019 11:45:39 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 32BE02B56BD;
        Fri, 22 Nov 2019 11:45:39 +0100 (CET)
Received: from localhost (10.75.127.51) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 22 Nov 2019 11:45:38
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <alexandre.torgue@st.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH] dt-bindings: regulator: Convert stm32 booster bindings to json-schema
Date:   Fri, 22 Nov 2019 11:45:35 +0100
Message-ID: <20191122104536.20283-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG6NODE3.st.com (10.75.127.18) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-22_02:2019-11-21,2019-11-22 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the STM32 regulator booster binding to DT schema format using json-schema

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
CC: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 .../bindings/regulator/st,stm32-booster.txt        | 18 ---------
 .../bindings/regulator/st,stm32-booster.yaml       | 46 ++++++++++++++++++++++
 2 files changed, 46 insertions(+), 18 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/st,stm32-booster.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/st,stm32-booster.yaml

diff --git a/Documentation/devicetree/bindings/regulator/st,stm32-booster.txt b/Documentation/devicetree/bindings/regulator/st,stm32-booster.txt
deleted file mode 100644
index 479ad4c8758e..000000000000
--- a/Documentation/devicetree/bindings/regulator/st,stm32-booster.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-STM32 BOOSTER - Booster for ADC analog input switches
-
-Some STM32 devices embed a 3.3V booster supplied by Vdda, that can be used
-to supply ADC analog input switches.
-
-Required properties:
-- compatible: Should be one of:
-  "st,stm32h7-booster"
-  "st,stm32mp1-booster"
-- st,syscfg: Phandle to system configuration controller.
-- vdda-supply: Phandle to the vdda input analog voltage.
-
-Example:
-	booster: regulator-booster {
-		compatible = "st,stm32mp1-booster";
-		st,syscfg = <&syscfg>;
-		vdda-supply = <&vdda>;
-	};
diff --git a/Documentation/devicetree/bindings/regulator/st,stm32-booster.yaml b/Documentation/devicetree/bindings/regulator/st,stm32-booster.yaml
new file mode 100644
index 000000000000..64f1183ce841
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/st,stm32-booster.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/st,stm32-booster.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STM32 booster for ADC analog input switches bindings
+
+maintainers:
+  - Fabrice Gasnier <fabrice.gasnier@st.com>
+
+description: |
+  Some STM32 devices embed a 3.3V booster supplied by Vdda, that can be used
+  to supply ADC analog input switches.
+
+allOf:
+  - $ref: "regulator.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - st,stm32h7-booster
+      - st,stm32mp1-booster
+
+  st,syscfg:
+    allOf:
+      - $ref: "/schemas/types.yaml#/definitions/phandle-array"
+    description: phandle to system configuration controller.
+
+  vdda-supply:
+    description: phandle to the vdda input analog voltage.
+
+required:
+  - compatible
+  - st,syscfg
+  - vdda-supply
+
+examples:
+  - |
+    regulator-booster {
+      compatible = "st,stm32mp1-booster";
+      st,syscfg = <&syscfg>;
+      vdda-supply = <&vdda>;
+    };
+
+...
-- 
2.15.0

