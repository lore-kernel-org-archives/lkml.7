Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF01C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D3C2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="a0b5q2Kc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfDKInl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:43:41 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41912 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbfDKInk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 04:43:40 -0400
Received: by mail-pl1-f196.google.com with SMTP id d1so3075357plj.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 01:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wlkTljkwq+PkQfX1dW/uq4ezlFHkmRq4tmpfuCy2ILM=;
        b=a0b5q2KcMeI2ouCBKXCoE3wMZTBP5mL/SeGdh7fPnfX1P4y9F0yy7kTyaMyS6cwYGS
         tHrClsmwiTO5bYidNzMMDIwiwqC4WZxzLGt+XU4YX+NFyvUmMqhxMsDAKqq12Fuh9OXz
         hfuQUNOFAlE4V4Ws9nBIGjHF6IG2m/0z+2fCkonRfnSHME2ggYofwwwhoiddBZ07jzTK
         G4qR4Bg3SM5UFAse6t1P6+2+W5p0YR53PsPduZHmowB6YREoQOfFzm3R00vMhAnKsFkT
         EHesv4B25MTWGOoKEYpaWHv85LmeLG/cse3Z38qIEkbko+68IcmzGERZ9TcbNuSIN1GB
         c5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wlkTljkwq+PkQfX1dW/uq4ezlFHkmRq4tmpfuCy2ILM=;
        b=VpNk3hHnNT3JTqPXPTezyH0VWNIEGxnKGyRKldzTVPmqhCdCz2YuLDZzDoiJa6LOX3
         AQwFeLT3AgLS4MktZk/oM8vjv42dmGpJAJ2mjh5s0wFe2NF/D37HoVrKVGIGQUfmFTPp
         2rfqHRq/5nE2iEIpmdP9qnSdB+kSuTl7awKq4CqkSUudxWhDtOJbcN1PN2tNlXurVya8
         PorwXUDKjZkNqyesy3T4iDkke8mnJTwpTp5f9shNDSdaP9Eo49EQuBavVOJgx7zJ2H13
         WN6sFNjPfB8k1bhORGxb7DnShgl/ZV8w5lPlgkTCXmG5xayRONJZt/DtVd+Tq1G1B4Hf
         Sq7g==
X-Gm-Message-State: APjAAAV3VrE63bfmSSbYFM8CpzF176JFGkdrmRug83S19InGvC18NHDa
        bjjcgWtiJEQpqAnoQQlr/X0rZjPvmMo=
X-Google-Smtp-Source: APXvYqym1+UGVXXwnIz1BJV3MN5bvNTOpQK4MK2SRRYqsY5eeoonJXMjKd2HGP+8qz5pFqdqx3k21g==
X-Received: by 2002:a17:902:1003:: with SMTP id b3mr47737480pla.306.1554972219434;
        Thu, 11 Apr 2019 01:43:39 -0700 (PDT)
Received: from viisi.sifive.com ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id a3sm61699456pfn.182.2019.04.11.01.43.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 01:43:38 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Paul Walmsley <paul@pwsan.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 3/6] dt-bindings: riscv: convert cpu binding to json-schema
Date:   Thu, 11 Apr 2019 01:43:01 -0700
Message-Id: <20190411084304.5072-4-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190411084304.5072-2-paul.walmsley@sifive.com>
References: <20190411084304.5072-2-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At Rob's request, we're starting to migrate our DT binding
documentation to json-schema YAML format.  Start by converting our cpu
binding documentation.  While doing so, document more properties and
nodes.  This includes adding binding documentation support for the E51
and U54 CPU cores ("harts") that are present on this SoC.  These cores
are described in:

    https://static.dev.sifive.com/FU540-C000-v1.0.pdf

This cpus.yaml file is intended to be a starting point and to
evolve over time.  It passes dt-doc-validate as of the yaml-bindings
commit 4c79d42e9216.

This patch was originally based on the ARM json-schema binding
documentation as added by commit 672951cbd1b7 ("dt-bindings: arm: Convert
cpu binding to json-schema").

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
---
 .../devicetree/bindings/riscv/cpus.yaml       | 274 ++++++++++++++++++
 1 file changed, 274 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/cpus.yaml

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
new file mode 100644
index 000000000000..11ade807fd49
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -0,0 +1,274 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/cpus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V bindings for 'cpus' DT nodes
+
+maintainers:
+  - Paul Walmsley <paul.walmsley@sifive.com>
+  - Palmer Dabbelt <palmer@sifive.com>
+
+description: |+
+  In SoC device tree data files, the layout of CPUs is described in
+  the "cpus" node.   This node in turn contains a number of subnodes
+  representing CPUs, which define properties for every cpu.
+
+  Bindings for CPU nodes follow the Devicetree Specification, available from:
+
+  https://www.devicetree.org/specifications/
+
+  with updates for RISC-V cores provided in this document.
+
+  ================================
+  Convention used in this document
+  ================================
+
+  This document follows the conventions described in the Devicetree
+  Specification, with the addition:
+
+  - square brackets define bitfields, e.g. reg[7:0] represents the
+    value of the bitfield in the reg property contained in bits 7 down
+    to 0
+
+  =====================================
+  cpus and cpu node bindings definition
+  =====================================
+
+  If a Devicetree file is used to provide hardware data to the kernel,
+  the RISC-V architecture requires the cpus and cpu nodes to be
+  present and contain the properties described below.
+
+properties:
+  $nodename:
+    const: cpus
+    description: Container of cpu nodes
+
+  '#address-cells':
+    const: 1
+    description: |
+      A single unsigned 32-bit integer uniquely identifies
+      each RISC-V hart in a system.  (See the "reg" node under
+      the "cpu" node, below).
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  '^cpu@[0-9a-f]+$':
+    properties:
+      device_type:
+        const: cpu
+
+      reg:
+        maxItems: 1
+        description: |
+          Set the "reg" property to the hart ID of this CPU node.
+          Each value in this property must be unique in the scope
+          of the Devicetree file that contains it.
+
+      compatible:
+        items:
+          - const: riscv
+          - enum:
+              - sifive,rocket0
+              - sifive,e5
+              - sifive,e51
+              - sifive,u54-mc
+              - sifive,u54
+              - sifive,u5
+        description: |
+          Identifies that the hart uses the RISC-V instruction set
+          and identifies the type of the hart.
+
+      mmu-type:
+        items:
+          - enum:
+              - riscv,sv32
+              - riscv,sv39
+              - riscv,sv48
+        description: |
+          Identifies the MMU address translation mode used on this
+          hart.  These values originate from the RISC-V Privileged
+          Specification document, available from
+          https://riscv.org/specifications/
+
+      riscv,isa:
+        items:
+          - enum:
+              - rv64imac
+              - rv64imafdc
+        description: |
+          Identifies the specific RISC-V instruction set architecture
+          supported by the hart.  These are documented in the RISC-V
+          User-Level ISA document, available from
+          https://riscv.org/specifications/
+
+          The RISC-V Linux port only will execute on a subset of these
+          values.  However, other hart cores may be present in the
+          Devicetree hardware description file that do not run Linux.
+
+      timebase-frequency:
+        maxItems: 1
+        description: |
+          Specifies the clock frequency of the system timer in Hz.
+          This value is common to all harts in this Linux system image.
+
+      i-cache-block-size:
+        maxItems: 1
+        description: |
+          Specifies the size, in bytes, of an instruction cache line.
+
+      i-cache-sets:
+        maxItems: 1
+        description: |
+          Specifies the number of sets in the hart's instruction cache.
+
+      i-cache-size:
+        maxItems: 1
+        description: |
+          Specifies the size, in bytes, of the hart's instruction cache.
+
+      i-tlb-sets:
+        maxItems: 1
+        description: |
+          Specifies the number of sets in the hart's instruction TLB.
+          If present, the "tlb-split" property must be set.
+
+      i-tlb-size:
+        maxItems: 1
+        description: |
+          Specifies the number of entries in the hart's instruction TLB.
+          If present, the "tlb-split" property must be set.
+
+      d-cache-block-size:
+        maxItems: 1
+        description: |
+          Specifies the size, in bytes, of a data cache line.
+
+      d-cache-sets:
+        maxItems: 1
+        description: |
+          Specifies the number of sets in the hart's data cache.
+
+      d-cache-size:
+        maxItems: 1
+        description: |
+          Specifies the size, in bytes, of the hart's data cache.
+
+      d-tlb-sets:
+        maxItems: 1
+        description: |
+          Specifies the number of sets in the hart's data TLB.
+          If present, the "tlb-split" property must be set.
+
+      d-tlb-size:
+        maxItems: 1
+        description: |
+          Specifies the number of entries in the hart's data TLB.
+          If present, the "tlb-split" property must be set.
+
+      tlb-split: true
+
+    patternProperties:
+      '^interrupt-controller@[0-9a-f]+$':
+        properties:
+          $nodename:
+            const: interrupt-controller
+            description: Describes the CPU's local interrupt controller
+
+          '#interrupt-cells':
+            const: 1
+
+          compatible:
+            const: riscv,cpu-intc
+
+          interrupt-controller: true
+
+        required:
+          - '#interrupt-cells'
+          - compatible
+          - interrupt-controller
+
+    required:
+      - device_type
+      - reg
+      - compatible
+      - riscv,isa
+      - timebase-frequency
+
+required:
+  - '#address-cells'
+  - '#size-cells'
+
+examples:
+  - |
+    // Example 1: SiFive Freedom U540G Development Kit
+    cpus {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        timebase-frequency = <1000000>;
+        cpu@0 {
+                clock-frequency = <0>;
+                compatible = "sifive,rocket0", "riscv";
+                device_type = "cpu";
+                i-cache-block-size = <64>;
+                i-cache-sets = <128>;
+                i-cache-size = <16384>;
+                reg = <0>;
+                riscv,isa = "rv64imac";
+                sifive,dtim = <&L8>;
+                sifive,itim = <&L7>;
+                status = "okay";
+                L10: interrupt-controller {
+                        #interrupt-cells = <1>;
+                        compatible = "riscv,cpu-intc";
+                        interrupt-controller;
+                };
+        };
+        cpu@1 {
+                clock-frequency = <0>;
+                compatible = "sifive,rocket0", "riscv";
+                d-cache-block-size = <64>;
+                d-cache-sets = <64>;
+                d-cache-size = <32768>;
+                d-tlb-sets = <1>;
+                d-tlb-size = <32>;
+                device_type = "cpu";
+                i-cache-block-size = <64>;
+                i-cache-sets = <64>;
+                i-cache-size = <32768>;
+                i-tlb-sets = <1>;
+                i-tlb-size = <32>;
+                mmu-type = "riscv,sv39";
+                reg = <1>;
+                riscv,isa = "rv64imafdc";
+                status = "okay";
+                tlb-split;
+                L13: interrupt-controller {
+                        #interrupt-cells = <1>;
+                        compatible = "riscv,cpu-intc";
+                        interrupt-controller;
+                };
+        };
+    };
+
+  - |
+    // Example 2: Spike ISA Simulator with 1 Hart
+    cpus {
+            cpu@0 {
+                    device_type = "cpu";
+                    reg = <0>;
+                    status = "okay";
+                    compatible = "riscv";
+                    riscv,isa = "rv64imafdc";
+                    mmu-type = "riscv,sv48";
+                    interrupt-controller {
+                            #interrupt-cells = <1>;
+                            interrupt-controller;
+                            compatible = "riscv,cpu-intc";
+                    };
+            };
+    };
+...
-- 
2.20.1

