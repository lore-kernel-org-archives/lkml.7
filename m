Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF82CA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 16:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22BB921835
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 16:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yeMa8ruk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbfKAQpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 12:45:16 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:34242 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfKAQpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 12:45:16 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xA1GjBsr085616;
        Fri, 1 Nov 2019 11:45:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572626711;
        bh=aLazdWHqwMmzhyqcTwdhpTY3yMjMZynbrNye1KKLlZs=;
        h=From:To:CC:Subject:Date;
        b=yeMa8rukT2H837Z9cSK/bSEAsvhyPlTrTzIZLUB9vE9WqcIQ9hyaox5er0rWkjixe
         Nj8yUgxwBZ7zfv+RxkHZRwWMGC+snIcnV9zNmpztvzqcuMjuYPze5YnF720sTozaKp
         8FB9TuoVBN2oatqEUNgDCJ9nujIehH0Lb0VBb4io=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xA1GjBBL067059
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Nov 2019 11:45:11 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 1 Nov
 2019 11:44:57 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 1 Nov 2019 11:44:57 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA1GjAos082902;
        Fri, 1 Nov 2019 11:45:10 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] dt-bindings: net: davinci-mdio: convert bindings to json-schema
Date:   Fri, 1 Nov 2019 18:45:02 +0200
Message-ID: <20191101164502.19089-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have the DT validation in place, let's convert the device tree
bindings for the TI SoC Davinci/OMAP/Keystone2 MDIO Controllerr over to a
YAML schemas.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
changes since rfc:
 - removed old bindings
 - bus_freq defined as "required" for davinci_mdio
rfc: https://lkml.org/lkml/2019/10/24/300

 .../devicetree/bindings/net/davinci-mdio.txt  | 36 ----------
 .../bindings/net/ti,davinci-mdio.yaml         | 71 +++++++++++++++++++
 2 files changed, 71 insertions(+), 36 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/davinci-mdio.txt
 create mode 100644 Documentation/devicetree/bindings/net/ti,davinci-mdio.yaml

diff --git a/Documentation/devicetree/bindings/net/davinci-mdio.txt b/Documentation/devicetree/bindings/net/davinci-mdio.txt
deleted file mode 100644
index e6527de80f10..000000000000
--- a/Documentation/devicetree/bindings/net/davinci-mdio.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-TI SoC Davinci/Keystone2 MDIO Controller Device Tree Bindings
----------------------------------------------------
-
-Required properties:
-- compatible		: Should be "ti,davinci_mdio"
-			  and "ti,keystone_mdio" for Keystone 2 SoCs
-			  and "ti,cpsw-mdio" for am335x, am472x, am57xx/dra7, dm814x SoCs
-			  and "ti,am4372-mdio" for am472x SoC
-- reg			: physical base address and size of the davinci mdio
-			  registers map
-- bus_freq		: Mdio Bus frequency
-
-Optional properties:
-- ti,hwmods		: Must be "davinci_mdio"
-
-Note: "ti,hwmods" field is used to fetch the base address and irq
-resources from TI, omap hwmod data base during device registration.
-Future plan is to migrate hwmod data base contents into device tree
-blob so that, all the required data will be used from device tree dts
-file.
-
-Examples:
-
-	mdio: davinci_mdio@4a101000 {
-		compatible = "ti,davinci_mdio";
-		reg = <0x4A101000 0x1000>;
-		bus_freq = <1000000>;
-	};
-
-(or)
-
-	mdio: davinci_mdio@4a101000 {
-		compatible = "ti,davinci_mdio";
-		ti,hwmods = "davinci_mdio";
-		bus_freq = <1000000>;
-	};
diff --git a/Documentation/devicetree/bindings/net/ti,davinci-mdio.yaml b/Documentation/devicetree/bindings/net/ti,davinci-mdio.yaml
new file mode 100644
index 000000000000..242ac4935a4b
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/ti,davinci-mdio.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/ti,davinci-mdio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI SoC Davinci/Keystone2 MDIO Controller
+
+maintainers:
+  - Grygorii Strashko <grygorii.strashko@ti.com>
+
+description:
+  TI SoC Davinci/Keystone2 MDIO Controller
+
+allOf:
+  - $ref: "mdio.yaml#"
+
+properties:
+  compatible:
+    oneOf:
+       - const: ti,davinci_mdio
+       - items:
+         - const: ti,keystone_mdio
+         - const: ti,davinci_mdio
+       - items:
+         - const: ti,cpsw-mdio
+         - const: ti,davinci_mdio
+       - items:
+         - const: ti,am4372-mdio
+         - const: ti,cpsw-mdio
+         - const: ti,davinci_mdio
+
+  reg:
+    maxItems: 1
+
+  bus_freq:
+      maximum: 2500000
+      description:
+        MDIO Bus frequency
+
+  ti,hwmods:
+    description: TI hwmod name
+    deprecated: true
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/string-array
+      - items:
+          const: davinci_mdio
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: ti,davinci_mdio
+  required:
+    - bus_freq
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+
+examples:
+  - |
+    davinci_mdio: mdio@4a101000 {
+         compatible = "ti,davinci_mdio";
+         #address-cells = <1>;
+         #size-cells = <0>;
+         reg = <0x4a101000 0x1000>;
+         bus_freq = <1000000>;
+    };
-- 
2.17.1

