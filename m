Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4132FC2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189E72465E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="NcBqpqxr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbfLTOzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 09:55:22 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:20524 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727359AbfLTOzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 09:55:21 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBKEqpTP016204;
        Fri, 20 Dec 2019 15:55:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=sVrTZIezbYnRiKZqMTLj6zzvZboDkSX5bAiYWhg0T7o=;
 b=NcBqpqxrKkxfyeDW+SY0cyO5g6DMetHFtAwa1fm5KWIVBAlUjHDhUvgBz9heMPbwatBJ
 xy0xpppdSlhdbtOPPW4MH9Xbqs9tE5wlg8K5gpQWbfl3La5fIsM5Zwq/a+v3MiNRThwm
 92PxGh0mHmLtedC62PRLA32GEzvN3acsPlvFzckT7vXGZUqIapKEh0z+x4SCX7is2IZX
 jI2gDRTEA/gRjFRbld+Pkvy4LeYG7TbPuwgxez2PWanoceYfdIDheqTYWS68pFvqFhDc
 Zotrtr+UC/hH76bCS6oEox8txTdYo91Fds55nJyIUgqkmCxJQwrp+IDCLh1wOVbcJM+Z /g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2wvnreyuer-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Dec 2019 15:55:08 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3C8F310003D;
        Fri, 20 Dec 2019 15:55:04 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 275E72FF5DF;
        Fri, 20 Dec 2019 15:55:04 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG6NODE1.st.com (10.75.127.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 20 Dec 2019 15:55:03
 +0100
From:   Yannick Fertre <yannick.fertre@st.com>
To:     Alexandre Torgue <alexandre.torgue@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] dt-bindings: display: Convert orisetech,otm8009a panel to DT schema
Date:   Fri, 20 Dec 2019 15:54:48 +0100
Message-ID: <1576853688-2143-1-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-20_03:2019-12-17,2019-12-20 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yannick Fertré <yannick.fertre@st.com>

Convert the orisetech,otm8009a panel binding to DT schema.

Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
---
 .../bindings/display/panel/orisetech,otm8009a.txt  | 23 --------
 .../bindings/display/panel/orisetech,otm8009a.yaml | 62 ++++++++++++++++++++++
 2 files changed, 62 insertions(+), 23 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.txt b/Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.txt
deleted file mode 100644
index 203b03e..0000000
--- a/Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-Orise Tech OTM8009A 3.97" 480x800 TFT LCD panel (MIPI-DSI video mode)
-
-The Orise Tech OTM8009A is a 3.97" 480x800 TFT LCD panel connected using
-a MIPI-DSI video interface. Its backlight is managed through the DSI link.
-
-Required properties:
-  - compatible: "orisetech,otm8009a"
-  - reg: the virtual channel number of a DSI peripheral
-
-Optional properties:
-  - reset-gpios: a GPIO spec for the reset pin (active low).
-  - power-supply: phandle of the regulator that provides the supply voltage.
-
-Example:
-&dsi {
-	...
-	panel@0 {
-		compatible = "orisetech,otm8009a";
-		reg = <0>;
-		reset-gpios = <&gpioh 7 GPIO_ACTIVE_LOW>;
-		power-supply = <&v1v8>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.yaml b/Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.yaml
new file mode 100644
index 0000000..02bd69e
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/orisetech,otm8009a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Orise Tech OTM8009A 3.97" 480x800 panel
+
+maintainers:
+  - Yannick Fertre <yannick.fertre@st.com>
+
+description:
+  The Orise Tech OTM8009A is a 3.97" 480x800 TFT LCD panel connected using
+  a MIPI-DSI video interface. Its backlight is managed through the DSI link.
+
+properties:
+  compatible:
+    const: orisetech,otm8009a
+
+  power-supply:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  backlight:
+    maxItems: 1
+
+  port:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    display1: display {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      panel {
+        compatible = "orisetech,otm8009a";
+        reg = <0>;
+        reset-gpios = <&gpioh 7 GPIO_ACTIVE_LOW>;
+        power-supply = <&v1v8>;
+
+        port {
+          panel_in_dsi: endpoint {
+            remote-endpoint = <&controller_out_dsi>;
+          };
+        };
+      };
+    };
+
+...
-- 
2.7.4

