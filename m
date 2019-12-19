Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC6EC2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D13E24679
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="jGx2wuFt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfLSOlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 09:41:47 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:9742 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726751AbfLSOlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 09:41:44 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBJEaXgG008246;
        Thu, 19 Dec 2019 15:41:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=YrqEhoOFzVhBDyBqtPSRVN9rQAkZAEPrgnH0llmvGc4=;
 b=jGx2wuFt0ehrsIZU4KNvGMSVFCyRD5sJLndmOHP1dHi25/l3SIGYLds5TPsmHAHtVaQQ
 79zHJUCnTWc7BFu7bfHeOwcwIPxRF1XvL7LSCjYLE7vGcr8hLewfaQQXZxUv0KN+CJqG
 wQUsDEnqTpt5zcp9OoDJmb5GWqc11R9LnWEHr2SR31+hrqEehoUhfnWy92ZzYFOSX6Br
 e18BDEw56hARv0YVtg1kAycn+y+NQ8j2Gm8AHysvcM3aTUZ2MRaH1ZwdPD11SCh+dtFj
 bAUdGrIHYMGm1cidl4/NFqAnDVbHLtaveXYUpMq+hBqgZ8gR434Oeuz0BRnQd1DC7cpA VA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2wvpd1t556-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Dec 2019 15:41:29 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CE6C510003E;
        Thu, 19 Dec 2019 15:41:20 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BA9942C6B63;
        Thu, 19 Dec 2019 15:41:19 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 19 Dec 2019 15:41:19
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <fabrice.gasnier@st.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 1/3] dt-bindings: nvmem: Convert STM32 ROMEM to json-schema
Date:   Thu, 19 Dec 2019 15:41:15 +0100
Message-ID: <20191219144117.21527-2-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20191219144117.21527-1-benjamin.gaignard@st.com>
References: <20191219144117.21527-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-19_01:2019-12-17,2019-12-19 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the STM32 ROMEM binding to DT schema format using json-schema

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 .../devicetree/bindings/nvmem/st,stm32-romem.txt   | 31 ---------------
 .../devicetree/bindings/nvmem/st,stm32-romem.yaml  | 46 ++++++++++++++++++++++
 2 files changed, 46 insertions(+), 31 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt
deleted file mode 100644
index 142a51d5a9be..000000000000
--- a/Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-STMicroelectronics STM32 Factory-programmed data device tree bindings
-
-This represents STM32 Factory-programmed read only non-volatile area: locked
-flash, OTP, read-only HW regs... This contains various information such as:
-analog calibration data for temperature sensor (e.g. TS_CAL1, TS_CAL2),
-internal vref (VREFIN_CAL), unique device ID...
-
-Required properties:
-- compatible:		Should be one of:
-			"st,stm32f4-otp"
-			"st,stm32mp15-bsec"
-- reg:			Offset and length of factory-programmed area.
-- #address-cells:	Should be '<1>'.
-- #size-cells:		Should be '<1>'.
-
-Optional Data cells:
-- Must be child nodes as described in nvmem.txt.
-
-Example on stm32f4:
-	romem: nvmem@1fff7800 {
-		compatible = "st,stm32f4-otp";
-		reg = <0x1fff7800 0x400>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		/* Data cells: ts_cal1 at 0x1fff7a2c */
-		ts_cal1: calib@22c {
-			reg = <0x22c 0x2>;
-		};
-		...
-	};
diff --git a/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
new file mode 100644
index 000000000000..d84deb4774a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/st,stm32-romem.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STM32 Factory-programmed data bindings
+
+description: |
+  This represents STM32 Factory-programmed read only non-volatile area: locked
+  flash, OTP, read-only HW regs... This contains various information such as:
+  analog calibration data for temperature sensor (e.g. TS_CAL1, TS_CAL2),
+  internal vref (VREFIN_CAL), unique device ID...
+
+maintainers:
+  - Fabrice Gasnier <fabrice.gasnier@st.com>
+
+allOf:
+  - $ref: "nvmem.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - st,stm32f4-otp
+      - st,stm32mp15-bsec
+
+required:
+  - "#address-cells"
+  - "#size-cells"
+  - compatible
+  - reg
+
+examples:
+  - |
+    efuse@1fff7800 {
+      compatible = "st,stm32f4-otp";
+      reg = <0x1fff7800 0x400>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+
+      calib@22c {
+        reg = <0x22c 0x2>;
+      };
+    };
+
+...
-- 
2.15.0

