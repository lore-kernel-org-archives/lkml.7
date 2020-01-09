Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D574C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 11:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A762067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 11:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idakzpeq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730649AbgAIL0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 06:26:04 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46394 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730624AbgAIL0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 06:26:01 -0500
Received: by mail-wr1-f65.google.com with SMTP id z7so6919510wrl.13;
        Thu, 09 Jan 2020 03:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=St6q5202LZ4WNScNSwJG5KHQgHK6N7FvcWjRsWrSrMk=;
        b=idakzpeqUJQRz3NBnf3tQ061a51djA7xFxvbQlbCcXjnbh3SqWiT6jRu8ieOu9t6it
         d9+7U0LrlHUVSwaj4g666aq5GbnUN7t3WN70wBQ/xDLHD2Tpx6Iq6fkoTSSbHexByhKN
         slJ00abRSQHPIkn6vYCz+LIPb0ObtKRMpeFdqHNo+4H3ri+4axS8GKCanXhx6Ma8r7dz
         1hyOgNvh/vwqedNfdbH36kf44KMsWtBWkiKbKtqkuLC4hODiD/sniLjhrjpumvupUb+A
         /9uox6LQi/sWfzyZnoHw33B3KG1rf54wr+HBbwQGF836PTbxi+7FCaqLAB86yObVkyl4
         Yr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=St6q5202LZ4WNScNSwJG5KHQgHK6N7FvcWjRsWrSrMk=;
        b=Tn/NMmkwoS39LOfAeftQ0HZa/tXSwWB90FSyio1fy1TypdaL+WQG/oYS6BbWuG3bjc
         LhBYpSpG76NIHomjYJcTE9SU1bgfxqD0m+D9Vd9qzaJpjWZAq8qEqtUiUXyFWWiDt7lc
         jc2RwH4bwAaqJib2W7L7peQFtm+TOqAq1zHfP7ulB1R21nqNUHF5POX3m9/S5bhm/XH0
         DXneUvh1qsurNJvjvKH7yba9OFa9BWfLj9IDvaxlZvS9yh/YVb3Aev8MtHRfzqpItU1i
         H8QQMfUB8vDV7WHECPdr/5SU3nsrTRsc8CwKbect3sPc4XvloHDQzjh1i34tPl3jGKnd
         FveQ==
X-Gm-Message-State: APjAAAU3KE5AcxNTiTCTe2egz+svsbYuderYvPa9S38Rq4S1oNd2a4+U
        a2yNhrjcUlfG7k1OBDA/8Rg=
X-Google-Smtp-Source: APXvYqzpdnbFL/KOCO2Me6ix0AZ1wfnrL9sw2CXyxRJKaC8Sor3jexOFlArpwV2FIaj+sq0uE1HtbA==
X-Received: by 2002:adf:bc4f:: with SMTP id a15mr10472078wrh.160.1578569158977;
        Thu, 09 Jan 2020 03:25:58 -0800 (PST)
Received: from localhost.localdomain (p5B3F655B.dip0.t-ipconnect.de. [91.63.101.91])
        by smtp.gmail.com with ESMTPSA id 60sm8298660wrn.86.2020.01.09.03.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 03:25:58 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        shawnguo@kernel.org, heiko@sntech.de, sam@ravnborg.org,
        icenowy@aosc.io, laurent.pinchart@ideasonboard.com,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        davem@davemloft.net, mchehab+samsung@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/4] dt-bindings: regulator: add document bindings for mpq7920
Date:   Thu,  9 Jan 2020 12:25:46 +0100
Message-Id: <20200109112548.23914-3-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200109112548.23914-1-sravanhome@gmail.com>
References: <20200109112548.23914-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding information for mpq7920 regulator driver.
Example bindings for mpq7920 are added.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 .../bindings/regulator/mps,mpq7920.yaml       | 202 ++++++++++++++++++
 1 file changed, 202 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml

diff --git a/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml b/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
new file mode 100644
index 000000000000..598f3ea070c9
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
@@ -0,0 +1,202 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/mps,mpq7920.yaml#
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
+  regulators:
+    type: object
+    description: |
+      list of regulators provided by this controller, must be named
+      after their hardware counterparts BUCK[1-4], one LDORTC, and LDO[2-5]
+
+      mps,switch-freq:
+        description: |
+          switching frequency must be one of following corresponding value
+          1.1MHz, 1.65MHz, 2.2MHz, 2.75MHz
+        $ref: "/schemas/types.yaml#/definitions/uint8"
+        enum: [ 0, 1, 2, 3 ]
+        default: 2
+
+      buck1:
+        type: object
+        $ref: "regulator.yaml#"
+        description: |
+          4.5A DC-DC step down converter
+
+        mps,buck-softstart:
+           $ref: "/schemas/types.yaml#/definitions/uint8"
+           enum: [ 0, 1, 2, 3 ]
+           default: 1
+           description: |
+             defines the soft start time of this buck, must be one of the following
+             corresponding values 150us, 300us, 610us, 920us
+
+         mps,buck-phase-delay:
+           $ref: "/schemas/types.yaml#/definitions/uint8"
+           enum: [ 0, 1, 2, 3 ]
+           default: 0
+           description: |
+             defines the phase delay of this buck, must be one of the following
+             corresponding values 0deg, 90deg, 180deg, 270deg
+
+         mps,buck-ovp-disable:
+           type: boolean
+           description: |
+             disables over voltage protection of this buck
+
+      buck2:
+        type: object
+        $ref: "regulator.yaml#"
+        description: |
+          2.5A DC-DC step down converter
+
+        mps,buck-softstart:
+          description: |
+            defines the soft start time of this buck, must be one of the following
+            corresponding values 150us, 300us, 610us, 920us
+          $ref: "/schemas/types.yaml#/definitions/uint8"
+          enum: [ 0, 1, 2, 3 ]
+          default: 1
+
+        mps,buck-phase-delay:
+          description: |
+            defines the phase delay of this buck, must be one of the following
+            corresponding values 0deg, 90deg, 180deg, 270deg
+          $ref: "/schemas/types.yaml#/definitions/uint8"
+          enum: [ 0, 1, 2, 3 ]
+          default: 0
+
+        mps,buck-ovp-disable:
+          description: |
+            disables over voltage protection of this buck
+          type: boolean
+
+      buck3:
+        type: object
+        $ref: "regulator.yaml#"
+        description: |
+          4.5A DC-DC step down converter
+
+        mps,buck-softstart:
+           description: |
+             defines the soft start time of this buck, must be one of the following
+             corresponding values 150us, 300us, 610us, 920us
+           $ref: "/schemas/types.yaml#/definitions/uint8"
+           enum: [ 0, 1, 2, 3 ]
+           default: 1
+
+         mps,buck-phase-delay:
+           description: |
+             defines the phase delay of this buck, must be one of the following
+             corresponding values 0deg, 90deg, 180deg, 270deg
+           $ref: "/schemas/types.yaml#/definitions/uint8"
+           enum: [ 0, 1, 2, 3 ]
+           default: 1
+
+         mps,buck-ovp-disable:
+           description: |
+             disables over voltage protection of this buck
+           type: boolean
+
+      buck4:
+        type: object
+        $ref: "regulator.yaml#"
+        description: |
+          2.5A DC-DC step down converter
+
+        mps,buck-softstart:
+          description: |
+            defines the soft start time of this buck, must be one of the following
+            corresponding values 150us, 300us, 610us, 920us
+          $ref: "/schemas/types.yaml#/definitions/uint8"
+          enum: [ 0, 1, 2, 3 ]
+          default: 1
+
+        mps,buck-phase-delay:
+          description: |
+            defines the phase delay of this buck, must be one of the following
+            corresponding values 0deg, 90deg, 180deg, 270deg
+          $ref: "/schemas/types.yaml#/definitions/uint8"
+          enum: [ 0, 1, 2, 3 ]
+          default: 1
+
+        mps,buck-ovp-disable:
+          description: |
+            disables over voltage protection of this buck
+          type: boolean
+
+      ldortc:
+        $ref: "regulator.yaml#"
+        description: |
+          regulator with 0.65V-3.5875V for RTC, always enabled
+
+      ldo2:
+        $ref: "regulator.yaml#"
+        description: |
+          regulator with 0.65V-3.5875V
+
+      ldo3:
+        $ref: "regulator.yaml#"
+        description: |
+          regulator with 0.65V-3.5875V
+
+      ldo4:
+        $ref: "regulator.yaml#"
+        description: |
+          regulator with 0.65V-3.5875V
+
+      ldo5:
+        $ref: "regulator.yaml#"
+        description: |
+          regulator with 0.65V-3.5875V
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
+          regulators {
+            mps,switch-freq = <1>;
+
+            buck1 {
+             regulator-name = "buck1";
+             regulator-min-microvolt = <400000>;
+             regulator-max-microvolt = <3587500>;
+             regulator-min-microamp  = <460000>;
+             regulator-max-microamp  = <7600000>;
+             regulator-boot-on;
+             mps,buck-ovp-disable;
+             mps,buck-phase-delay = <2>;
+             mps,buck-softstart = <1>;
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

