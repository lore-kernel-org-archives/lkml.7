Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCD7C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 22:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8242420882
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 22:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLnVUsrj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfLZW3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 17:29:47 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42067 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfLZW3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 17:29:45 -0500
Received: by mail-wr1-f66.google.com with SMTP id q6so24620563wro.9;
        Thu, 26 Dec 2019 14:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=55LT+HlmWUTY6vJ3k/knFjbScNdU0pNrnELzUMhZDVM=;
        b=SLnVUsrjCesu4wjGpvU/07sxDbTESGKmDrlSDTdLU0EWiQ4WUi0Ih9o3UjpbT1pp+Q
         tghtygMibk811toffjP9+BW3lEtdkFLnHqfR6U8dINOxr7JCpVzdjkugTgKsWn2qMc7+
         y8WRsPTOIVq7tACJLmlBFLSD8v5fiGH2RqYhQibq90L4kcZu2r4PPMoTEGahIMGQPysX
         4ttwot3pGyHUgeRU4lcevCK/ZMBvYgMyrbx5XAb00AVjs0FKWlxHdMLibDUWPzKWlpPX
         6TJ4/ZBwejGewjwVFs1SlRGkqwt3zb0Xrlmk+fORbg5C4X5o9ds2koa8XflwxUqw0LDC
         0JJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=55LT+HlmWUTY6vJ3k/knFjbScNdU0pNrnELzUMhZDVM=;
        b=ezLS/MdG4feqH4+nwkvKVB68u62gPWdNmvO+o3qSzAxHEhOFxXaw9phT1CqkTQk+BP
         dOhIyL0JQ5zbYXHpmYRM1N5tFuSyBo94qRBGEkmHiCxYajVGDTjObYEqILrWueHTpcm/
         y6DF28JUprwG7A7LtLdhkc3CcA+eOov3gCcuu6WYf/fJV2ZxkC6ylAI5jsG3MMm8Ltp2
         LdqTNMsSGEP0P+jaVT2/lOxh15LlnwoFepNumFlmnweercHlpITvfPicl4Qkqus/Beb1
         3JC3K9EHOzP5AmXtbo+smE0iEkFfy7A6hNIDgme05UKAhbqVrKHZVBOoz5hU3IrVM6WD
         CGcg==
X-Gm-Message-State: APjAAAW+CLy8JOmAfsITn9O15I2IP5x++tdRh2MH0a/cptYlLUItyXbs
        lCnQYysMNuX5/8fVodJPxxM=
X-Google-Smtp-Source: APXvYqwvUd18e0IfPfzvo/i5cgnMVaK5NxtdoE+z2hBDofUReXWsvEozmdTOolZqiEK/s8g/dyaARw==
X-Received: by 2002:adf:a109:: with SMTP id o9mr50552336wro.189.1577399383822;
        Thu, 26 Dec 2019 14:29:43 -0800 (PST)
Received: from localhost.localdomain (p5B3F7018.dip0.t-ipconnect.de. [91.63.112.24])
        by smtp.gmail.com with ESMTPSA id j2sm9731276wmk.23.2019.12.26.14.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 14:29:43 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        shawnguo@kernel.org, heiko@sntech.de, sam@ravnborg.org,
        icenowy@aosc.io, laurent.pinchart@ideasonboard.com,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        davem@davemloft.net, mchehab+samsung@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/4] dt-bindings: regulator: add document bindings for mpq7920
Date:   Thu, 26 Dec 2019 23:29:28 +0100
Message-Id: <20191226222930.8882-3-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191226222930.8882-1-sravanhome@gmail.com>
References: <20191226222930.8882-1-sravanhome@gmail.com>
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
index 000000000000..54e9177dfd1b
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
+        pmic@69 {
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
+            };
+
+            ldo2 {
+             regulator-name = "ldo2";
+             regulator-min-microvolt = <650000>;
+             regulator-max-microvolt = <3587500>;
+            };
+         };
+       };
+     };
+...
-- 
2.17.1

