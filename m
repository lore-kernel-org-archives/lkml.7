Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EB1C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A78206EF
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="nofuJvmU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfLTOyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 09:54:50 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:25010 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727390AbfLTOyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 09:54:49 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBKEmluw018721;
        Fri, 20 Dec 2019 15:54:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=OAxh9OFylBS1O2i0AQYBqRnIJ6+wfj/Z3JUs1ONnn4g=;
 b=nofuJvmUhaDKuc4aDMIWsJ/XfhwDRmh+T/2HeRWc71I+0qh6iYMPwK1hPfko7orM6bml
 Py1Uha+fbVQUW3jtOp8aIJkqgUph+NwC7VU4DpKTyMYY3+aPvVFNQAlHORGQYLGB9LOe
 G24ddTjYo+gUiPZrLviv0mEqPs0OlRs08DoWKczLU4xN9HcqdpCIwBE9gYZYEt4RXwOw
 ZluGbcwYMex83E7KCOsKzd18u77xPr8nz8DJCOfyCWoRH/KQVPnCgcxz90+hnMmxZdzA
 W49Ep6YlnIoS31NNd6Vg5zn/5fhhcyTkiO+FaZ0z8lLTyHV3+OcS9tCebtegBQoI4pj3 dA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2wvp37fu37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Dec 2019 15:54:32 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DEF3D10003E;
        Fri, 20 Dec 2019 15:54:26 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AC7392FF5DF;
        Fri, 20 Dec 2019 15:54:26 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG6NODE1.st.com (10.75.127.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 20 Dec 2019 15:54:26
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
Subject: [PATCH] dt-bindings: display: Convert raydium,rm68200 panel to DT schema
Date:   Fri, 20 Dec 2019 15:54:20 +0100
Message-ID: <1576853660-2083-1-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-20_03:2019-12-17,2019-12-20 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yannick Fertré <yannick.fertre@st.com>

Convert the raydium,rm68200 panel binding to DT schema.

Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
---
 .../bindings/display/panel/raydium,rm68200.txt     | 25 ---------
 .../bindings/display/panel/raydium,rm68200.yaml    | 61 ++++++++++++++++++++++
 2 files changed, 61 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/raydium,rm68200.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/raydium,rm68200.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/raydium,rm68200.txt b/Documentation/devicetree/bindings/display/panel/raydium,rm68200.txt
deleted file mode 100644
index cbb79ef..0000000
--- a/Documentation/devicetree/bindings/display/panel/raydium,rm68200.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Raydium Semiconductor Corporation RM68200 5.5" 720p MIPI-DSI TFT LCD panel
-
-The Raydium Semiconductor Corporation RM68200 is a 5.5" 720x1280 TFT LCD
-panel connected using a MIPI-DSI video interface.
-
-Required properties:
-  - compatible: "raydium,rm68200"
-  - reg: the virtual channel number of a DSI peripheral
-
-Optional properties:
-  - reset-gpios: a GPIO spec for the reset pin (active low).
-  - power-supply: phandle of the regulator that provides the supply voltage.
-  - backlight: phandle of the backlight device attached to the panel.
-
-Example:
-&dsi {
-	...
-	panel@0 {
-		compatible = "raydium,rm68200";
-		reg = <0>;
-		reset-gpios = <&gpiof 15 GPIO_ACTIVE_LOW>;
-		power-supply = <&v1v8>;
-		backlight = <&pwm_backlight>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/display/panel/raydium,rm68200.yaml b/Documentation/devicetree/bindings/display/panel/raydium,rm68200.yaml
new file mode 100644
index 0000000..ffe549f
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/raydium,rm68200.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/raydium,rm68200.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Raydium RM68200 5.5" 720x1280 panel
+
+maintainers:
+  - Yannick Fertre <yannick.fertre@st.com>
+
+description:
+  The Raydium Semiconductor Corporation RM68200 is a 5.5" 720x1280 TFT LCD
+  panel connected using a MIPI-DSI video interface.
+
+properties:
+  compatible:
+    const: raydium,rm68200
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
+    display0: display {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      panel {
+        compatible = "raydium,rm68200";
+        reg = <0>;
+        reset-gpios = <&gpiof 15 GPIO_ACTIVE_LOW>;
+        power-supply = <&v1v8>;
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

