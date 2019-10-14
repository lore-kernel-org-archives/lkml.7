Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F30C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 19:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C64E206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 19:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571080381;
	bh=Tc7qb+KgLq7MOMTrGfdYD+5o3/4hXE41uoI0Rh9saBw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=yKfDCFqb8pOdsH0kjcwfmZiJP33zXXnUQflYMUwWVFSuipB/KZSb1vE8nnivBFmHe
	 7gGpbipdsnQuTC8YDczZz/tuVMKYj+vJETrzqpQGhbcfYs1sqw0oUFQv5lKZFPlotd
	 2zuyBnflLU7g3a1tbZrSP27ktwJH5JJdFS0gpXII=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388131AbfJNTNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 15:13:00 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43889 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbfJNTM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 15:12:59 -0400
Received: by mail-oi1-f193.google.com with SMTP id t84so14665541oih.10;
        Mon, 14 Oct 2019 12:12:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BKXy075na4ND49CdMbGkDtc/ZP4/qAVkyOLqEDxA11Q=;
        b=PEJsPK27AhaDPfMOySjb8U/BbYVGac/Sx/UdtlnZO3SENFB68NJkl0ktF6D8CtwNgr
         4bSBFNvitE5RbKyOlasV0NegB6FzkEDAP6xBfHRTe2q5WiQJdliEW3p8B/9dT4cB8s1k
         ShgN/Ayyz4hzH5w1Ez95R5ipIX7vAxh+AtJCoqgE7udqaxBhSX/SCCa18dCU433/Rzok
         BLwOhrycOrTYnL7wE+IneZFJnxh3jZ1BSfbtZaYMTWcQLPV2pecD0+zJWaCwanvuMhPP
         nLVeGyDTeK5HNZV+AjRf4s/G8amSbA0hyowRT3PZsFCZeH6PUc3MfSgpVClph81bjBXh
         pbng==
X-Gm-Message-State: APjAAAVr5sg7s/gp6yXYGIbU/mlzHPjGDozs1OzrCWjaNwFRrMXUhapE
        u33HQnblmGAcpWqWnKOBw/n1FyU=
X-Google-Smtp-Source: APXvYqyrO4c+jhZ0cqjrdApT7AA5i5nT+lBbo2O8aFYuRslpiPvoVTgj7UWQ1E37xdrNwG9HFKS57w==
X-Received: by 2002:aca:5ed7:: with SMTP id s206mr24477966oib.134.1571080377970;
        Mon, 14 Oct 2019 12:12:57 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id o23sm5999596ote.67.2019.10.14.12.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 12:12:57 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <Robin.Murphy@arm.com>,
        iommu@lists.linux-foundation.org
Subject: [PATCH v2] dt-bindings: iommu: Convert Arm SMMUv3 to DT schema
Date:   Mon, 14 Oct 2019 14:12:56 -0500
Message-Id: <20191014191256.12697-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Arm SMMv3 binding to the DT schema format.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <Robin.Murphy@arm.com>
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
- Refine interrupt definition based on Robin's comments

 .../devicetree/bindings/iommu/arm,smmu-v3.txt |  77 --------------
 .../bindings/iommu/arm,smmu-v3.yaml           | 100 ++++++++++++++++++
 2 files changed, 100 insertions(+), 77 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
 create mode 100644 Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
deleted file mode 100644
index c9abbf3e4f68..000000000000
--- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
+++ /dev/null
@@ -1,77 +0,0 @@
-* ARM SMMUv3 Architecture Implementation
-
-The SMMUv3 architecture is a significant departure from previous
-revisions, replacing the MMIO register interface with in-memory command
-and event queues and adding support for the ATS and PRI components of
-the PCIe specification.
-
-** SMMUv3 required properties:
-
-- compatible        : Should include:
-
-                      * "arm,smmu-v3" for any SMMUv3 compliant
-                        implementation. This entry should be last in the
-                        compatible list.
-
-- reg               : Base address and size of the SMMU.
-
-- interrupts        : Non-secure interrupt list describing the wired
-                      interrupt sources corresponding to entries in
-                      interrupt-names. If no wired interrupts are
-                      present then this property may be omitted.
-
-- interrupt-names   : When the interrupts property is present, should
-                      include the following:
-                      * "eventq"    - Event Queue not empty
-                      * "priq"      - PRI Queue not empty
-                      * "cmdq-sync" - CMD_SYNC complete
-                      * "gerror"    - Global Error activated
-                      * "combined"  - The combined interrupt is optional,
-				      and should only be provided if the
-				      hardware supports just a single,
-				      combined interrupt line.
-				      If provided, then the combined interrupt
-				      will be used in preference to any others.
-
-- #iommu-cells      : See the generic IOMMU binding described in
-                        devicetree/bindings/pci/pci-iommu.txt
-                      for details. For SMMUv3, must be 1, with each cell
-                      describing a single stream ID. All possible stream
-                      IDs which a device may emit must be described.
-
-** SMMUv3 optional properties:
-
-- dma-coherent      : Present if DMA operations made by the SMMU (page
-                      table walks, stream table accesses etc) are cache
-                      coherent with the CPU.
-
-                      NOTE: this only applies to the SMMU itself, not
-                      masters connected upstream of the SMMU.
-
-- msi-parent        : See the generic MSI binding described in
-                        devicetree/bindings/interrupt-controller/msi.txt
-                      for a description of the msi-parent property.
-
-- hisilicon,broken-prefetch-cmd
-                    : Avoid sending CMD_PREFETCH_* commands to the SMMU.
-
-- cavium,cn9900-broken-page1-regspace
-                    : Replaces all page 1 offsets used for EVTQ_PROD/CONS,
-		      PRIQ_PROD/CONS register access with page 0 offsets.
-		      Set for Cavium ThunderX2 silicon that doesn't support
-		      SMMU page1 register space.
-
-** Example
-
-        smmu@2b400000 {
-                compatible = "arm,smmu-v3";
-                reg = <0x0 0x2b400000 0x0 0x20000>;
-                interrupts = <GIC_SPI 74 IRQ_TYPE_EDGE_RISING>,
-                             <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>,
-                             <GIC_SPI 77 IRQ_TYPE_EDGE_RISING>,
-                             <GIC_SPI 79 IRQ_TYPE_EDGE_RISING>;
-                interrupt-names = "eventq", "priq", "cmdq-sync", "gerror";
-                dma-coherent;
-                #iommu-cells = <1>;
-                msi-parent = <&its 0xff0000>;
-        };
diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
new file mode 100644
index 000000000000..662cbc4592c9
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iommu/arm,smmu-v3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM SMMUv3 Architecture Implementation
+
+maintainers:
+  - Will Deacon <will@kernel.org>
+  - Robin Murphy <Robin.Murphy@arm.com>
+
+description: |+
+  The SMMUv3 architecture is a significant departure from previous
+  revisions, replacing the MMIO register interface with in-memory command
+  and event queues and adding support for the ATS and PRI components of
+  the PCIe specification.
+
+properties:
+  $nodename:
+    pattern: "^iommu@[0-9a-f]*"
+  compatible:
+    const: arm,smmu-v3
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 4
+
+  interrupt-names:
+    oneOf:
+      - const: combined
+        description:
+          The combined interrupt is optional, and should only be provided if the
+          hardware supports just a single, combined interrupt line.
+          If provided, then the combined interrupt will be used in preference to
+          any others.
+      - items:
+          - const: eventq     # Event Queue not empt
+          - const: priq       # PRI Queue not empty
+          - const: cmdq-sync  # CMD_SYNC complete
+          - const: gerror     # Global Error activated
+      - minItems: 2
+        maxItems: 4
+        items:
+          - const: eventq
+          - const: gerror
+          - const: priq
+          - const: cmdq-sync
+
+  '#iommu-cells':
+    const: 1
+
+  dma-coherent:
+    description: |
+      Present if page table walks made by the SMMU are cache coherent with the
+      CPU.
+
+      NOTE: this only applies to the SMMU itself, not masters connected
+      upstream of the SMMU.
+
+  msi-parent: true
+
+  hisilicon,broken-prefetch-cmd:
+    type: boolean
+    description: Avoid sending CMD_PREFETCH_* commands to the SMMU.
+
+  cavium,cn9900-broken-page1-regspace:
+    type: boolean
+    description:
+      Replaces all page 1 offsets used for EVTQ_PROD/CONS, PRIQ_PROD/CONS
+      register access with page 0 offsets. Set for Cavium ThunderX2 silicon that
+      doesn't support SMMU page1 register space.
+
+required:
+  - compatible
+  - reg
+  - '#iommu-cells'
+
+additionalProperties: false
+
+examples:
+  - |+
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    iommu@2b400000 {
+            compatible = "arm,smmu-v3";
+            reg = <0x2b400000 0x20000>;
+            interrupts = <GIC_SPI 74 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 77 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 79 IRQ_TYPE_EDGE_RISING>;
+            interrupt-names = "eventq", "priq", "cmdq-sync", "gerror";
+            dma-coherent;
+            #iommu-cells = <1>;
+            msi-parent = <&its 0xff0000>;
+    };
-- 
2.20.1

