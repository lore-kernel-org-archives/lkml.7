Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88590ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 19:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 596692067B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 19:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571341763;
	bh=DLhaDeUm88Lp26TBb8OTy8D2/5dGsWQPFYuFZrW/VJI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=vgHP8gAKb772CdKi83LRc/mgjhR8WADgDavh+gkNK4c4/eEDZ3h3yDWH4AYAiB4L4
	 eXCDayE5KPJf9KtdvC4oRNMBpL/2Eatng0/mnm9qSyTLtMC2VApnENPx0glP/NTBPl
	 GoF1qy0x2ff5NwZdkeHgqveLP0OEO7TKBBc+q3jk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440985AbfJQTtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 15:49:22 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:37156 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389032AbfJQTtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 15:49:21 -0400
Received: by mail-ot1-f51.google.com with SMTP id k32so2968177otc.4;
        Thu, 17 Oct 2019 12:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rKf+TvXQTdvhCSr97ET7nrM7ndk5bzLwGtaQj1lzb7w=;
        b=cVc4Ivqb5Ui6FPtR8JVxo1PM8nY6Ux0ToP0uZW4lVOThMBn1ciVr6FFsDSAVnJ2atk
         d8Mk67ao5Os75tzTKbb7tgRG5lea+0q2xQiJRQD1kakcW5fbn7YcbNtD/J6Xx9puu+Lf
         z5c3NdYEvjPRGPz2PD/PKzoUC8TXoejFB709ZKbA/N5ryXz5ew8khIIwtUdvBl/IdyUJ
         PiGzcdm3cY8a6FNaJ9t9K41uepmpbmsj3ZXZ41EjxfE6y4qmPT17LuD+TwGQqcmDvYzr
         SckvZ2u8/jdlWObytwblTLN4BC7nbRmnjIGN0Nn1WC8W24BcqjBHYJR1dcwESeDWl3gd
         pdyA==
X-Gm-Message-State: APjAAAXC9x68S4EozRWSghFf9u596cjcGrOJdjALyDsYZUR6Sjggi+EM
        SKw6k6u3t7ZmfENGWViXsSoB7F0=
X-Google-Smtp-Source: APXvYqxmGNTSkP0amvesxTZNgskxmL7YCSudNZFXfg4QBuArpON4424uoubxmMPhnGsnrbcTq9jGCA==
X-Received: by 2002:a9d:286:: with SMTP id 6mr4590504otl.192.1571341759884;
        Thu, 17 Oct 2019 12:49:19 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id i4sm841448oto.43.2019.10.17.12.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 12:49:18 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: example-schema: Add some additional examples and commentary
Date:   Thu, 17 Oct 2019 14:49:16 -0500
Message-Id: <20191017194916.10166-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add examples for properties with standard units, child nodes,
dependencies, and if/then schema. Also, make some minor updates based on
common questions and review issues.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/example-schema.yaml   | 81 +++++++++++++++++--
 1 file changed, 74 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/example-schema.yaml b/Documentation/devicetree/bindings/example-schema.yaml
index c43819c2783a..4ddcf709cc3c 100644
--- a/Documentation/devicetree/bindings/example-schema.yaml
+++ b/Documentation/devicetree/bindings/example-schema.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 # Copyright 2018 Linaro Ltd.
 %YAML 1.2
 ---
@@ -71,7 +71,7 @@ properties:
     # minItems/maxItems equal to 2 is implied
 
   reg-names:
-    # The core schema enforces this is a string array
+    # The core schema enforces this (*-names) is a string array
     items:
       - const: core
       - const: aux
@@ -79,7 +79,8 @@ properties:
   clocks:
     # Cases that have only a single entry just need to express that with maxItems
     maxItems: 1
-    description: bus clock
+    description: bus clock. A description is only needed for a single item if
+      there's something unique to add.
 
   clock-names:
     items:
@@ -127,6 +128,14 @@ properties:
     maxItems: 1
     description: A connection of the 'foo' gpio line.
 
+  # *-supply is always a single phandle, so nothing more to define.
+  foo-supply: true
+
+  # Vendor specific properties
+  #
+  # Vendor specific properties have slightly different schema requirements than
+  # common properties. They must have at least a type definition and
+  # 'description'.
   vendor,int-property:
     description: Vendor specific properties must have a description
     # 'allOf' is the json-schema way of subclassing a schema. Here the base
@@ -137,9 +146,9 @@ properties:
       - enum: [2, 4, 6, 8, 10]
 
   vendor,bool-property:
-    description: Vendor specific properties must have a description
-    # boolean properties is one case where the json-schema 'type' keyword
-    # can be used directly
+    description: Vendor specific properties must have a description. Boolean
+      properties are one case where the json-schema 'type' keyword can be used
+      directly.
     type: boolean
 
   vendor,string-array-property:
@@ -151,14 +160,72 @@ properties:
           - enum: [ foo, bar ]
           - enum: [ baz, boo ]
 
+  vendor,property-in-standard-units-microvolt:
+    description: Vendor specific properties having a standard unit suffix
+      don't need a type.
+    enum: [ 100, 200, 300 ]
+
+  child-node:
+    description: Child nodes are just another property from a json-schema
+      perspective.
+    type: object  # DT nodes are json objects
+    properties:
+      vendor,a-child-node-property:
+        description: Child node properties have all the same schema
+          requirements.
+        type: boolean
+
+    required:
+      - vendor,a-child-node-property
+
+# Describe the relationship between different properties
+dependencies:
+  # 'vendor,bool-property' is only allowed when 'vendor,string-array-property'
+  # is present
+  vendor,bool-property: [ vendor,string-array-property ]
+  # Expressing 2 properties in both orders means all of the set of properties
+  # must be present or none of them.
+  vendor,string-array-property: [ vendor,bool-property ]
+
 required:
   - compatible
   - reg
   - interrupts
   - interrupt-controller
 
+# if/then schema can be used to handle conditions on a property affecting
+# another property. A typical case is a specific 'compatible' value changes the
+# constraints on other properties.
+#
+# For multiple 'if' schema, group them under an 'allOf'.
+#
+# If the conditionals become too unweldy, then it may be better to just split
+# the binding into separate schema documents.
+if:
+  properties:
+    compatible:
+      contains:
+        const: vendor,soc2-ip
+then:
+  required:
+    - foo-supply
+
+# Ideally, the schema should have this line otherwise any other properties
+# present are allowed. There's a few common properties such as 'status' and
+# 'pinctrl-*' which are added automatically by the tooling.
+#
+# This can't be used in cases where another schema is referenced
+# (i.e. allOf: [{$ref: ...}]).
+additionalProperties: false
+
 examples:
-  # Examples are now compiled with dtc
+  # Examples are now compiled with dtc and validated against the schemas
+  #
+  # Examples have a default #address-cells and #size-cells value of 1. This can
+  # be overridden or an appropriate parent bus node should be shown (such as on
+  # i2c buses).
+  #
+  # Any includes used have to be explicitly included.
   - |
     node@1000 {
           compatible = "vendor,soc4-ip", "vendor,soc1-ip";
-- 
2.20.1

