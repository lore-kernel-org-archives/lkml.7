Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFF2C2D0C8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 20:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A8C2070A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 20:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azF+6XiZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfLVUpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 15:45:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32777 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfLVUpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 15:45:23 -0500
Received: by mail-wr1-f65.google.com with SMTP id b6so14659212wrq.0;
        Sun, 22 Dec 2019 12:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pHJmzEWzu41VV42M7/F9DaNeFiiLD5jjP6m2fN21gQ0=;
        b=azF+6XiZJ3a3UkKJ/l1+QOtCTbVyO8gUTFjKr91gFXNcPshHEsKKs8mXFOhGxO4A+t
         pDLHd1ceVwZIRqTD3Tg1Zfmh5/fKIlYRIsr7SIJC+Xh5R4UJIJ6C7ut5kZI646ga20Pc
         TAHYe237KooBx9Uv8AYNQt+Dpp+W2MCW/XUl2JSGJuEBYYv8Epvk6K9QRfeIo4EV7N2R
         UxkREtohNyEhbQj9iBiD+lpHDRqVYXv3vMlgo1TP8W7zPumsrmwPhbh3mX7y8Df3zmm1
         vEoCACi31H8HXNE409wfMjvgHYGfW7Fy0CoCmaL52vg2vLttSAhALayjc4x9EqGsWq6G
         t2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pHJmzEWzu41VV42M7/F9DaNeFiiLD5jjP6m2fN21gQ0=;
        b=dLNWes1WFC6bE+tIwk2B31wbvdYq+pKiK3L13BkZJHYuQ76jvuVFY7UkvjLYUo2dYp
         x6zE7yutN67/+yeA7BgVGSpq1+A3s8e9b5Gd6p+s+mn8MWX8eZdaEQl48OIY5e5N6AY9
         3wCuLRJq2zg9fRQ/7JIZNnS/ovVPclMCH+AxQs7fvhUTiD0MO2FHGbBTkTdOzY5Q/cYD
         QWjNWWqsitRKizZmfNWB4rIWpks08MEji3+sNPgGLIBesDMswBsAfLXx0c2H3NOvO8kg
         rUj/dsHBiDB3n+qQRQSLDR8JaJ3JZNsp/QuLZ+3IzdEcqtBrIycV7O6VtjY7FMW9N9bM
         +Biw==
X-Gm-Message-State: APjAAAWev9UHNxiyGEsxRxPgSMr07Je7FmYkk2O8M/b54QPXRC1+vXy4
        ue951KwtkYevGt51EuC9mbw=
X-Google-Smtp-Source: APXvYqyE3oytYGwCAcYjxbLBVNCH1/y/Qh9IMXcr2+8O63DDlEc9IqtwFi2C2MkJhDcUUMvMRkHfsg==
X-Received: by 2002:a5d:4085:: with SMTP id o5mr26195461wrp.321.1577047521107;
        Sun, 22 Dec 2019 12:45:21 -0800 (PST)
Received: from localhost.localdomain (p5B3F6AB6.dip0.t-ipconnect.de. [91.63.106.182])
        by smtp.gmail.com with ESMTPSA id o4sm17603792wrx.25.2019.12.22.12.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2019 12:45:20 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        shawnguo@kernel.org, heiko@sntech.de, sam@ravnborg.org,
        icenowy@aosc.io, laurent.pinchart@ideasonboard.com,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        davem@davemloft.net, mchehab+samsung@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] dt-bindings: regulator: add document bindings for mpq7920
Date:   Sun, 22 Dec 2019 21:45:05 +0100
Message-Id: <20191222204507.32413-3-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191222204507.32413-1-sravanhome@gmail.com>
References: <20191222204507.32413-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding information for mpq7920 regulator driver.
Example bindings for mpq7920 are added.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 .../bindings/regulator/mpq7920.yaml           | 143 ++++++++++++++++++
 1 file changed, 143 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mpq7920.yaml

diff --git a/Documentation/devicetree/bindings/regulator/mpq7920.yaml b/Documentation/devicetree/bindings/regulator/mpq7920.yaml
new file mode 100644
index 000000000000..d173ba1fb28d
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mpq7920.yaml
@@ -0,0 +1,143 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/mpq7920.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Monolithic Power System MPQ7920 PMIC
+
+maintainers:
+  - Saravanan Sekar <sravanhome@gmail.com>
+
+properties:
+  $nodename:
+    pattern: "pmic@[0-9a-f]{1,2}"
+  compatible:
+    enum:
+      - mps,mpq7920
+
+  reg:
+    maxItems: 1
+
+  mps,time-slot:
+    description:
+      each regulator output shall be delayed during power on/off sequence which
+      based on configurable time slot value, must be one of following corresponding
+      value 0.5ms, 2ms, 8ms, 16ms
+    allOf:
+      - $ref: "/schemas/types.yaml#/definitions/uint8"
+      - enum: [ 0, 1, 2, 3 ]
+      - default: 0
+
+  mps,fixed-on-time:
+     description:
+       select power on sequence with fixed time output delay mentioned in
+       time-slot reg for all the regulators.
+     type: boolean
+
+  mps,fixed-off-time:
+     description:
+        select power off sequence with fixed time output delay mentioned in
+        time-slot reg for all the regulators.
+     type: boolean
+
+  mps,inc-off-time:
+     description: |
+        mutually exclusive to mps,fixed-off-time an array of 8, linearly increase
+        output delay during power off sequence based on factor of time slot/interval
+        for each regulator.
+     allOf:
+       - $ref: "/schemas/types.yaml#/definitions/uint8-array"
+       - minimum: 0
+       - maximum: 15
+       - default: [ 0, 6, 0, 6, 7, 7, 7, 9 ]
+
+  mps,inc-on-time:
+     description: |
+        mutually exclusive to mps,fixed-on-time an array of 8, linearly increase
+        output delay during power on sequence based on factor of time slot/interval
+        for each regulator.
+     allOf:
+       - $ref: "/schemas/types.yaml#/definitions/uint8-array"
+       - minimum: 0
+       - maximum: 15
+       - default: [ 0, 6, 0, 6, 7, 7, 7, 9 ]
+
+  mps,switch-freq:
+     description: |
+        switching frequency must be one of following corresponding value
+        1.1MHz, 1.65MHz, 2.2MHz, 2.75MHz
+     allOf:
+       - $ref: "/schemas/types.yaml#/definitions/uint8"
+       - enum: [ 0, 1, 2, 3 ]
+       - default: 2
+
+  mps,buck-softstart:
+     description: |
+        An array of 4 contains soft start time of each buck, must be one of
+        following corresponding values 150us, 300us, 610us, 920us
+     allOf:
+       - $ref: "/schemas/types.yaml#/definitions/uint8-array"
+       - enum: [ 0, 1, 2, 3 ]
+       - default: [ 1, 1, 1, 1 ]
+
+  mps,buck-ovp:
+     description: |
+        An array of 4 contains over voltage protection of each buck, must be
+        one of above values
+     allOf:
+       - $ref: "/schemas/types.yaml#/definitions/uint8-array"
+       - enum: [ 0, 1 ]
+       - default: [ 1, 1, 1, 1 ]
+
+  mps,buck-phase-delay:
+     description: |
+        An array of 4 contains phase delay of each buck must be one of above values
+        corresponding to 0deg, 90deg, 180deg, 270deg
+     allOf:
+       - $ref: "/schemas/types.yaml#/definitions/uint8-array"
+       - enum: [ 0, 1, 2, 3 ]
+       - default: [ 0, 0, 1, 1 ]
+
+  regulators:
+    type: object
+    description:
+      list of regulators provided by this controller, must be named
+      after their hardware counterparts BUCK[1-4], one LDORTC, and LDO[2-5]
+      The valid names for regulators are
+      buck1, buck2, buck3, buck4, ldortc, ldo2, ldo3, ldo4, ldo5
+
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        mpq7920@69 {
+          compatible = "mps,mpq7920";
+          reg = <0x69>;
+
+          mps,switch-freq = <1>;
+          mps,buck-softstart = /bits/ 8 <1 2 1 3>;
+          mps,buck-ovp = /bits/ 8 <1 0 1 1>;
+
+          regulators {
+            buck1 {
+             regulator-name = "buck1";
+             regulator-min-microvolt = <400000>;
+             regulator-max-microvolt = <3587500>;
+             regulator-min-microamp  = <460000>;
+             regulator-max-microamp  = <7600000>;
+             regulator-boot-on;
+           };
+
+           ldo2 {
+             regulator-name = "ldo2";
+             regulator-min-microvolt = <650000>;
+             regulator-max-microvolt = <3587500>;
+           };
+         };
+       };
+     };
+...
-- 
2.17.1

