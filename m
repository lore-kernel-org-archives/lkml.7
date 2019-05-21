Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BEAC072B5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 21:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB1721841
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 21:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558473639;
	bh=czZytKe/f/PdiFHoG/IEWDS157kVu3EudrHy8SODnlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QuavDoI43AnK4IsfnKY0XeKrByjTTFcWHcXT2o76aybYDGohKpEXeOSDM6EQTRIDa
	 AzWSZX4HK/fGQz5ceMAulh+pRNzfDfKGmRTntj8rAxaVSYHW7Xo+oU3dvhUVHluQot
	 SdNMqVfBKST+CKmSte2bm7rSw6Ux5iaFvCGUn7nk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfEUVUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 17:20:38 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40078 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbfEUVUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 17:20:36 -0400
Received: by mail-ot1-f65.google.com with SMTP id u11so132422otq.7;
        Tue, 21 May 2019 14:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=apsoYF5amNns5etmn4zujNCoRo5NDmvzuAIXQhJvm/E=;
        b=KjWR2dJyFJNsz5TAfVsaT0nXK0ij8pSscu1oxE9+llbcyVGoz9f3WhL0ECLVkl/cvJ
         ru1HlrsdxW+0czqdHo3Y2E43OeJSWlnQvTujUBkvBVvSALis64hRew4HyWus7OpUWO0/
         ieTsnNljU+xnNe8lHW+dVy5MfNuye3ksVYDzZDxLLZWPOdix+btjymeZjwKDR2gg969D
         v+lhRhjPn/JluS2vnvOaPCblxotnWdj9Nwy9uZLERxmX4xheOrnGzMaSGjq5as8kywq9
         o3A2CEmViqGkxHcWoLZJm4c941o9cy42Q2l3136Q+QIuuqD8ANFN1HQ7Ij8NBdl2agcU
         qCFA==
X-Gm-Message-State: APjAAAUNi4g56ZxUI18rI9o14P73llaurYN4J0ohTPhlfsm3ksWzbBQb
        FZX/2rQ70M/h+PcwWvUseHJqbl8=
X-Google-Smtp-Source: APXvYqzwoGvkeMWxpf1UgQICrcOEZw6wkLO4iYOXkxcSwbSUbHB4h4/jsSsgD59HQJbbnD9ZoHUCVg==
X-Received: by 2002:a9d:224c:: with SMTP id o70mr5753190ota.261.1558473635981;
        Tue, 21 May 2019 14:20:35 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id y3sm7510534oto.58.2019.05.21.14.20.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 14:20:35 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Mack <zonque@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 3/3] dt-bindings: regulator: Convert max8660 binding to json-schema
Date:   Tue, 21 May 2019 16:20:31 -0500
Message-Id: <20190521212031.12982-3-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190521212031.12982-1-robh@kernel.org>
References: <20190521212031.12982-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the max8660 binding to DT schema format using json-schema.

Cc: Daniel Mack <zonque@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/regulator/max8660.txt | 47 -----------
 .../bindings/regulator/max8660.yaml           | 77 +++++++++++++++++++
 2 files changed, 77 insertions(+), 47 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/max8660.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/max8660.yaml

diff --git a/Documentation/devicetree/bindings/regulator/max8660.txt b/Documentation/devicetree/bindings/regulator/max8660.txt
deleted file mode 100644
index 8ba994d8a142..000000000000
--- a/Documentation/devicetree/bindings/regulator/max8660.txt
+++ /dev/null
@@ -1,47 +0,0 @@
-Maxim MAX8660 voltage regulator
-
-Required properties:
-- compatible: must be one of "maxim,max8660", "maxim,max8661"
-- reg: I2C slave address, usually 0x34
-- any required generic properties defined in regulator.txt
-
-Example:
-
-	i2c_master {
-		max8660@34 {
-			compatible = "maxim,max8660";
-			reg = <0x34>;
-
-			regulators {
-				regulator@0 {
-					regulator-compatible= "V3(DCDC)";
-					regulator-min-microvolt = <725000>;
-					regulator-max-microvolt = <1800000>;
-				};
-
-				regulator@1 {
-					regulator-compatible= "V4(DCDC)";
-					regulator-min-microvolt = <725000>;
-					regulator-max-microvolt = <1800000>;
-				};
-
-				regulator@2 {
-					regulator-compatible= "V5(LDO)";
-					regulator-min-microvolt = <1700000>;
-					regulator-max-microvolt = <2000000>;
-				};
-
-				regulator@3 {
-					regulator-compatible= "V6(LDO)";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <3300000>;
-				};
-
-				regulator@4 {
-					regulator-compatible= "V7(LDO)";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <3300000>;
-				};
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/regulator/max8660.yaml b/Documentation/devicetree/bindings/regulator/max8660.yaml
new file mode 100644
index 000000000000..9c038698f880
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/max8660.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/max8660.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX8660 voltage regulator
+
+maintainers:
+  - Daniel Mack <zonque@gmail.com>
+
+properties:
+  $nodename:
+    pattern: "pmic@[0-9a-f]{1,2}"
+  compatible:
+    enum:
+      - maxim,max8660
+      - maxim,max8661
+
+  reg:
+    maxItems: 1
+
+  regulators:
+    type: object
+
+    patternProperties:
+      "regulator-.+":
+        $ref: "regulator.yaml#"
+
+    additionalProperties: false
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      pmic@34 {
+        compatible = "maxim,max8660";
+        reg = <0x34>;
+
+        regulators {
+          regulator-V3 {
+            regulator-compatible= "V3(DCDC)";
+            regulator-min-microvolt = <725000>;
+            regulator-max-microvolt = <1800000>;
+          };
+
+          regulator-V4 {
+            regulator-compatible= "V4(DCDC)";
+            regulator-min-microvolt = <725000>;
+            regulator-max-microvolt = <1800000>;
+          };
+
+          regulator-V5 {
+            regulator-compatible= "V5(LDO)";
+            regulator-min-microvolt = <1700000>;
+            regulator-max-microvolt = <2000000>;
+          };
+
+          regulator-V6 {
+            regulator-compatible= "V6(LDO)";
+            regulator-min-microvolt = <1800000>;
+            regulator-max-microvolt = <3300000>;
+          };
+
+          regulator-V7 {
+            regulator-compatible= "V7(LDO)";
+            regulator-min-microvolt = <1800000>;
+            regulator-max-microvolt = <3300000>;
+          };
+        };
+      };
+    };
+...
-- 
2.20.1

