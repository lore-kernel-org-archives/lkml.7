Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598A7C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E1621D7D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9Etg41/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfLSKhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 05:37:37 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39206 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfLSKhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 05:37:35 -0500
Received: by mail-wm1-f68.google.com with SMTP id 20so4947922wmj.4;
        Thu, 19 Dec 2019 02:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HTOvBssqTqxtZmGGIc8RqHJ2OODrmOCdLMv1BNyEoI4=;
        b=M9Etg41/5NvZhTya2jX8mqCOhWXFTr90PGxhoMEgZWqJbk9VQa2AF3D8wleSnDg2zF
         jyt+pTWWS23yHnCnidS/upUxzEU6y5lVysOg6Rhd0Yt5K31aIiiz9wnHDMekyyI5MQK5
         LYmuIphhpSP1IaEduZWnlg7xYbeBPHgFoIhqLVOdkQkZbZSnZPU6OuUsxywEBxXHGA6y
         OfcQYyg5kBYYni6v3PiVVS4yivDdWbbv5Ivdli4uETDY7EF4oyBTvLaUeb8Ac1pWGNYq
         ynRWatwyl/EasbX5hRjDmlS0KORP2mL7oqBC8E2J+0yvCzO3DI6ZDC1s4JUMwLoqD/Ra
         JLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HTOvBssqTqxtZmGGIc8RqHJ2OODrmOCdLMv1BNyEoI4=;
        b=PVoop8qz4sTGsA0OfvnAl1zTYMd4fyMhZ+W9AEAue4JtNCgEg2g3PVHxmUdK3DFvQB
         EhvNl4hmpM/OBVpLNvu+ShSkauzde7mJf2no6x6uKox5/IEMqgOG8aqA5hlwKrUxFI8b
         6dfBLOjSAcZDaikANr6h9PRBAanCSOmgc9xRE1TPIxn8bk2m5PG9miXZy+zdSDLz07/F
         LpETtpqvdsljMtnclWQJ/Z5GuTiwVaoQXqjZeObT8EHkyHSQ+zrI0Kmo2q7qWxziMZXR
         S88lVbyumqhtVqVTu79+wMhtTwt3WJhGn7aZdIALus54c4VLP80YaAgigl3hARe26IJp
         5F6w==
X-Gm-Message-State: APjAAAUhu4QAmik7srFNKMej+5+AHaWDrUqTmYeyRKr1I6p1oqJ6NHzr
        gDkWyxMmVF+HXBbqm0arnVvz7rgVSN4=
X-Google-Smtp-Source: APXvYqzdIZml7rQ4gzmVnEHNW0+KtXGNpGbnllQcyt3WRcujOtHyQpE2skXnVLxXTNjxDyg8odzXuw==
X-Received: by 2002:a1c:1bc3:: with SMTP id b186mr9190522wmb.79.1576751852761;
        Thu, 19 Dec 2019 02:37:32 -0800 (PST)
Received: from localhost.localdomain (p5B3F677C.dip0.t-ipconnect.de. [91.63.103.124])
        by smtp.gmail.com with ESMTPSA id c68sm5735147wme.13.2019.12.19.02.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 02:37:32 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        heiko@sntech.de, shawnguo@kernel.org,
        laurent.pinchart@ideasonboard.com, icenowy@aosc.io,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 2/4] dt-bindings: regulator: add document bindings for mpq7920
Date:   Thu, 19 Dec 2019 11:37:19 +0100
Message-Id: <20191219103721.10935-3-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191219103721.10935-1-sravanhome@gmail.com>
References: <20191219103721.10935-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding information for mpq7920 regulator driver.
Example bindings for mpq7920 are added.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 .../bindings/regulator/mpq7920.yaml           | 149 ++++++++++++++++++
 1 file changed, 149 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mpq7920.yaml

diff --git a/Documentation/devicetree/bindings/regulator/mpq7920.yaml b/Documentation/devicetree/bindings/regulator/mpq7920.yaml
new file mode 100644
index 000000000000..79000b745cfd
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mpq7920.yaml
@@ -0,0 +1,149 @@
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
+    pattern: "mpq@[0-9a-f]{1,2}"
+  compatible:
+    enum:
+	- mps,mpq7920
+
+  reg:
+    maxItems: 1
+
+  regulators:
+    type: string
+    description: |
+      list of regulators provided by this controller, must be named
+      after their hardware counterparts BUCK[1-4], one LDORTC, and LDO[2-5]
+      The valid names for regulators are
+      buck1, buck2, buck3, buck4, ldortc, ldo2, ldo3, ldo4, ldo5
+
+    properties:
+       mps,time-slot:
+         - $ref: "/schemas/types.yaml#/definitions/uint8-array"
+       description: |
+         power on/off sequence time slot/interval must be one of following values
+         With:
+          * 0: 0.5ms
+          * 1: 2ms
+          * 2: 8ms
+          * 3: 16ms
+          Defaults to 0.5ms if not specified.
+
+    properties:
+       mps,fixed-on-time:
+          - $ref: "/schemas/types.yaml#/definitions/boolean"
+       description: |
+           select power on sequence with fixed time interval mentioned in
+           time-slot reg for all the regulators.
+
+    properties:
+       mps,fixed-off-time:
+          - $ref: "/schemas/types.yaml#/definitions/boolean"
+       description: |
+          select power off sequence with fixed time interval mentioned in
+          time-slot reg for all the regulators.
+
+    properties:
+       mps,inc-off-time:
+          - $ref: "/schemas/types.yaml#/definitions/uint8-array"
+       description: |
+          An array of 8, linearly increase power off sequence time
+          slot/interval for each regulator must be one of following values
+         * 0 to 15
+    properties:
+       mps,inc-on-time:
+          - $ref: "/schemas/types.yaml#/definitions/uint8-array"
+       description: |
+          An array of 8, linearly increase power on sequence time
+          slot/interval for each regulator must be one of following values
+          * 0 to 15
+
+    properties:
+       mps,switch-freq:
+          - $ref: "/schemas/types.yaml#/definitions/uint8"
+       description: |
+          switching frequency must be one of following values
+          * 0 : 1.1MHz
+          * 1 : 1.65MHz
+          * 2 : 2.2MHz
+          * 3 : 2.75MHz
+          Defaults to 2.2 MHz if not specified.
+
+    properties:
+       mps,buck-softstart:
+          - $ref: "/schemas/types.yaml#/definitions/uint8-array"
+       description: |
+          An array of 4 contains soft start time of each buck, must be one of
+          following values
+          * 0 : 150us
+          * 1 : 300us
+          * 2 : 610us
+          * 3 : 920us
+          Defaults to 300us if not specified.
+
+    properties:
+       mps,buck-ovp:
+          - $ref: "/schemas/types.yaml#/definitions/uint8-array"
+       description: |
+           An array of 4 contains over voltage protection of each buck, must be
+           one of following values
+           * 0 : disabled
+           * 1 : enabled
+           Defaults is enabled if not specified.
+
+    properties:
+        mps,buck-phase-delay:
+          - $ref: "/schemas/types.yaml#/definitions/uint8-array"
+       description: |
+           An array of 4 contains each buck phase delay must be one of following
+           values
+           * 0: 0deg
+           * 1: 90deg
+           * 2: 180deg
+           * 3: 270deg
+           Defaults to 0deg for buck1 & buck2, 90deg for buck3 & buck4 if not
+           specified.
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        mpq7920@69 {
+	  compatible = "mps,mpq7920";
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

