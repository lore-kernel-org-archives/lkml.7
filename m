Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D49AC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 076C520989
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561593606;
	bh=2//0RM0Eel4J/mpPXxL5mE1faNEGPDniF778R1+tnfw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=mg0GDHYeUxrFOtThe/WJYmOS96EH9v7oS9IfiEcG7v3Gq4E2uci3OEsx0LcuChVlh
	 mnw8UXY7h2qO8nZr/6b28/3Tu0HLtgIuNeCbujX0QfllDGXs4EBGj2au+c1Ah2uht8
	 uUtWD2EOt1ZhS4gbzWEWhM1/VXaDus0mt7ipl59Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfF0AAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:00:04 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35760 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfF0AAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:00:04 -0400
Received: by mail-io1-f68.google.com with SMTP id m24so759525ioo.2;
        Wed, 26 Jun 2019 17:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=53IaqpMPerVQvE5lpwCouRahQV8Om4olnk1aH2ko0g8=;
        b=fyerAui09rzodqkgck6mCAQTJNiB2/oMvJtyO4bs1E9J+RHMcLUcH5vhe2lr9T5Eqn
         bVarnAOA05Stgo2ue12yMWpvDI/iboXBBovnatKAk8eMuPNqJ6ahEwxlsFS5DeH02EAA
         t1gwVC/kMNI7CRCR+qa10x0r2PQAXa/lodOInEzkrRyqLzIP1/BihXpHqsxIdFdVErOf
         GyRLLziLGjJ78vppXtcwVlAm6XPnT1jAwmqGvgr9XBjPmZhXy2/rkytn6GtWPxdekf4v
         dBEF7khtOwhlLZ4T0fNGw6xHM1IDxXJ1E12mkZeu5URRknncTOLzR3QXOau36gQ5EAQr
         3uMQ==
X-Gm-Message-State: APjAAAVH2qMLklp+zijU8aPCHXngdvsKRJ3qKcowO7T10AKQ3kx4OrU7
        kg16nnDMvYIHu/WbZ+pbZ8ExHwc=
X-Google-Smtp-Source: APXvYqy5ezO/dANnHV+5w59X63kyA+lDVkCf1HEj3VQeONMkV/b1rEwNK5rUNDyShpwyMeIlhrynAg==
X-Received: by 2002:a02:a384:: with SMTP id y4mr866306jak.77.1561593602990;
        Wed, 26 Jun 2019 17:00:02 -0700 (PDT)
Received: from localhost.localdomain ([64.188.179.243])
        by smtp.googlemail.com with ESMTPSA id l2sm359969ioh.20.2019.06.26.17.00.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 17:00:02 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@sifive.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: riscv: Limit cpus schema to only check RiscV 'cpu' nodes
Date:   Wed, 26 Jun 2019 17:57:59 -0600
Message-Id: <20190626235759.3615-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matching on the 'cpus' node was a bad choice because the schema is
incorrectly applied to non-RiscV cpus nodes. As we now have a common cpus
schema which checks the general structure, it is also redundant to do so
in the Risc-V CPU schema.

The downside is one could conceivably mix different architecture's cpu
nodes or have typos in the compatible string. The latter problem pretty
much exists for every schema.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/riscv/cpus.yaml       | 143 ++++++++----------
 1 file changed, 61 insertions(+), 82 deletions(-)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 27f02ec4bb45..67e54251eb90 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -10,97 +10,76 @@ maintainers:
   - Paul Walmsley <paul.walmsley@sifive.com>
   - Palmer Dabbelt <palmer@sifive.com>
 
-allOf:
-  - $ref: /schemas/cpus.yaml#
-
 properties:
-  $nodename:
-    const: cpus
-    description: Container of cpu nodes
-
-  '#address-cells':
-    const: 1
-    description: |
-      A single unsigned 32-bit integer uniquely identifies each RISC-V
-      hart in a system.  (See the "reg" node under the "cpu" node,
-      below).
-
-  '#size-cells':
-    const: 0
+  compatible:
+    items:
+      - enum:
+          - sifive,rocket0
+          - sifive,e5
+          - sifive,e51
+          - sifive,u54-mc
+          - sifive,u54
+          - sifive,u5
+      - const: riscv
+    description:
+      Identifies that the hart uses the RISC-V instruction set
+      and identifies the type of the hart.
+
+  mmu-type:
+    allOf:
+      - $ref: "/schemas/types.yaml#/definitions/string"
+      - enum:
+          - riscv,sv32
+          - riscv,sv39
+          - riscv,sv48
+    description:
+      Identifies the MMU address translation mode used on this
+      hart.  These values originate from the RISC-V Privileged
+      Specification document, available from
+      https://riscv.org/specifications/
+
+  riscv,isa:
+    allOf:
+      - $ref: "/schemas/types.yaml#/definitions/string"
+      - enum:
+          - rv64imac
+          - rv64imafdc
+    description:
+      Identifies the specific RISC-V instruction set architecture
+      supported by the hart.  These are documented in the RISC-V
+      User-Level ISA document, available from
+      https://riscv.org/specifications/
+
+  timebase-frequency:
+    type: integer
+    minimum: 1
+    description:
+      Specifies the clock frequency of the system timer in Hz.
+      This value is common to all harts on a single system image.
+
+  interrupt-controller:
+    type: object
+    description: Describes the CPU's local interrupt controller
 
-patternProperties:
-  '^cpu@[0-9a-f]+$':
     properties:
-      compatible:
-        type: array
-        items:
-          - enum:
-              - sifive,rocket0
-              - sifive,e5
-              - sifive,e51
-              - sifive,u54-mc
-              - sifive,u54
-              - sifive,u5
-          - const: riscv
-        description:
-          Identifies that the hart uses the RISC-V instruction set
-          and identifies the type of the hart.
-
-      mmu-type:
-        allOf:
-          - $ref: "/schemas/types.yaml#/definitions/string"
-          - enum:
-              - riscv,sv32
-              - riscv,sv39
-              - riscv,sv48
-        description:
-          Identifies the MMU address translation mode used on this
-          hart.  These values originate from the RISC-V Privileged
-          Specification document, available from
-          https://riscv.org/specifications/
-
-      riscv,isa:
-        allOf:
-          - $ref: "/schemas/types.yaml#/definitions/string"
-          - enum:
-              - rv64imac
-              - rv64imafdc
-        description:
-          Identifies the specific RISC-V instruction set architecture
-          supported by the hart.  These are documented in the RISC-V
-          User-Level ISA document, available from
-          https://riscv.org/specifications/
+      '#interrupt-cells':
+        const: 1
 
-      timebase-frequency:
-        type: integer
-        minimum: 1
-        description:
-          Specifies the clock frequency of the system timer in Hz.
-          This value is common to all harts on a single system image.
-
-      interrupt-controller:
-        type: object
-        description: Describes the CPU's local interrupt controller
-
-        properties:
-          '#interrupt-cells':
-            const: 1
-
-          compatible:
-            const: riscv,cpu-intc
-
-          interrupt-controller: true
+      compatible:
+        const: riscv,cpu-intc
 
-        required:
-          - '#interrupt-cells'
-          - compatible
-          - interrupt-controller
+      interrupt-controller: true
 
     required:
-      - riscv,isa
-      - timebase-frequency
+      - '#interrupt-cells'
+      - compatible
       - interrupt-controller
 
+required:
+  - riscv,isa
+  - timebase-frequency
+  - interrupt-controller
+
 examples:
   - |
     // Example 1: SiFive Freedom U540G Development Kit
-- 
2.20.1

