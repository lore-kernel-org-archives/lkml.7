Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3AFECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 09:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6DBE20882
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 09:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="DFNYV5Mt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730808AbfJNJSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 05:18:12 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22188 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730713AbfJNJSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 05:18:11 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9E9BgUs022240;
        Mon, 14 Oct 2019 11:18:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=rppez0TLqKr7YkVENE3vEAgH7KKEnoklKwSXeMW5hE0=;
 b=DFNYV5MtpvRsSZAzHlfLc3B0+XEKkNJ683+vDjSCDB5bEq+3raU1dQD28YpkeH4ae1Vu
 E9y1Vv1nFom+CJ94Q/9ckj1kLS/8VGN6add2+FpjlZC1ttG5d+dikLUUGwHs/Q/qt2xX
 NYaD3gXOi6/cmY81B4prQAOdj0YcdineO3Vm5db+xLkJwhSdRzK3e5c7Hm4EPvOxOv/i
 p8WeC0vK06qr3x3+OqmirefnVyH9sNgGputS8z54QDak5w97yY8DZoQiVCWQ3BOMM5+j
 oAg9akOy1ld+TuEomQAq8TCCN3owcghIIi5+1sbpWCDb2gq9x3n4pE2Tp15agQXNCzxi jQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2vk3y9hrrm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Oct 2019 11:18:01 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1F40A10003A;
        Mon, 14 Oct 2019 11:17:59 +0200 (CEST)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0D3A42B8C52;
        Mon, 14 Oct 2019 11:17:59 +0200 (CEST)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 14 Oct
 2019 11:17:59 +0200
Received: from localhost (10.201.20.122) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 14 Oct 2019 11:17:58
 +0200
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <ohad@wizery.com>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <alexandre.torgue@st.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v3] dt-bindings: hwlock: Convert stm32 hwspinlock bindings to json-schema
Date:   Mon, 14 Oct 2019 11:17:56 +0200
Message-ID: <20191014091756.23763-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.122]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-14_06:2019-10-10,2019-10-14 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the STM32 hwspinlock binding to DT schema format using json-schema

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
change in v3:
- use (GPL-2.0-only OR BSD-2-Clause)

change in v2:
- use BSD-2-Clause license
- use const for #hwlock-cells
- add additionalProperties: false

 .../bindings/hwlock/st,stm32-hwspinlock.txt        | 23 ----------
 .../bindings/hwlock/st,stm32-hwspinlock.yaml       | 50 ++++++++++++++++++++++
 2 files changed, 50 insertions(+), 23 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
 create mode 100644 Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.yaml

diff --git a/Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt b/Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
deleted file mode 100644
index adf4f000ea3d..000000000000
--- a/Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-STM32 Hardware Spinlock Device Binding
--------------------------------------
-
-Required properties :
-- compatible : should be "st,stm32-hwspinlock".
-- reg : the register address of hwspinlock.
-- #hwlock-cells : hwlock users only use the hwlock id to represent a specific
-	hwlock, so the number of cells should be <1> here.
-- clock-names : Must contain "hsem".
-- clocks : Must contain a phandle entry for the clock in clock-names, see the
-	common clock bindings.
-
-Please look at the generic hwlock binding for usage information for consumers,
-"Documentation/devicetree/bindings/hwlock/hwlock.txt"
-
-Example of hwlock provider:
-	hwspinlock@4c000000 {
-		compatible = "st,stm32-hwspinlock";
-		#hwlock-cells = <1>;
-		reg = <0x4c000000 0x400>;
-		clocks = <&rcc HSEM>;
-		clock-names = "hsem";
-	};
diff --git a/Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.yaml b/Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.yaml
new file mode 100644
index 000000000000..47cf9c8d97e9
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwlock/st,stm32-hwspinlock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STM32 Hardware Spinlock bindings
+
+maintainers:
+  - Benjamin Gaignard <benjamin.gaignard@st.com>
+  - Fabien Dessenne <fabien.dessenne@st.com>
+
+properties:
+  "#hwlock-cells":
+    const: 1
+
+  compatible:
+    const: st,stm32-hwspinlock
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: hsem
+
+required:
+  - "#hwlock-cells"
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/stm32mp1-clks.h>
+    hwspinlock@4c000000 {
+        compatible = "st,stm32-hwspinlock";
+        #hwlock-cells = <1>;
+        reg = <0x4c000000 0x400>;
+        clocks = <&rcc HSEM>;
+        clock-names = "hsem";
+    };
+
+...
-- 
2.15.0

