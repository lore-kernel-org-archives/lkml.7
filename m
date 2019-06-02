Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97CAC28CC5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 08:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98112788C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 08:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YwyMTxQ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfFBIFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 04:05:21 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35304 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfFBIFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 04:05:10 -0400
Received: by mail-wm1-f68.google.com with SMTP id c6so5461233wml.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 01:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wvk9LhsSu5lYNJZOdSQrHtIo1oj0PZh/JKcuQJp9vDo=;
        b=YwyMTxQ0Tv2Qdzp8L6b5CjQfwl8xlL/N7sdxHxKS6MqZq/BtV/T063MjUmRs2SbdmR
         Sq5DHcZBWq7V/QEeu+Twu624TVEg07klgcnFIdC1qnvqzBUytHts8BwADI9dBQVvGMKc
         4+z2cbGB2F4ba5nePNL78S7cnIkLoBiEKu3YJCx+zmFvJAaxVxDFCqKtJJGw014VXxrj
         z3QRd78A1HA1X/AYEDC54il+/X+NkJgGI61lA0jJCHiZx6PiTaLzetAsbjTZN3hb518x
         7ciIJA93p4pqRvNQe+pBqc9LXyL4KfrRFm9BQnxDD7Vys1z6opqUYhoH4HC0Bjb5i3z0
         Spmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wvk9LhsSu5lYNJZOdSQrHtIo1oj0PZh/JKcuQJp9vDo=;
        b=EFw/s8IvyS2Cm2fSbCm+nS0uo//Z4AaQO6TBh+96NyuoU+cPAC8MQc6rjUAYhvHX1p
         RkwZCg6nbRadwzGtJyE4jZ6x0RTd8KJMhKXklQCwBTmWQFdjTG+b0rfRliO5KO0a6H1v
         g1uKCxsjfWkLxDCxUaP35sLGcuPwwyKgqbiVYvDDMkfhpJzydyrjFTErSywQBA98DOTl
         DSfS66vhtdGQjl1XNrQqeP/9nR7tzWGGjDNtraAB30sJjzarv+7V01eI8hIXULp7YYUO
         gLv6U4y9JGXoSTW0O+jV19x/tSMlKDKEey6pMNJNsPQAOKWoMqfVmlaVDG/m1OemLfom
         DDpw==
X-Gm-Message-State: APjAAAWOvbgMt+liqKXadV/K7Sd2+jNTLA3LyKpWlcu66AiBwumQyLAg
        rqhM6zNmCaBITFwjYCtce0OJ3b/2W0I=
X-Google-Smtp-Source: APXvYqyAZ6rxxIrchthzK1GIyd+woTIGPDx+BzNwo8BfN8W3cUIcc5lwTK4V5096dz+9iq2uCXG2HQ==
X-Received: by 2002:a1c:b4d4:: with SMTP id d203mr10966857wmf.34.1559462707984;
        Sun, 02 Jun 2019 01:05:07 -0700 (PDT)
Received: from viisi.fritz.box (217-76-161-89.static.highway.a1.net. [217.76.161.89])
        by smtp.gmail.com with ESMTPSA id l190sm10186301wml.16.2019.06.02.01.05.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 02 Jun 2019 01:05:07 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Paul Walmsley <paul@pwsan.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v3 3/5] dt-bindings: riscv: convert cpu binding to json-schema
Date:   Sun,  2 Jun 2019 01:04:58 -0700
Message-Id: <20190602080500.31700-4-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602080500.31700-1-paul.walmsley@sifive.com>
References: <20190602080500.31700-1-paul.walmsley@sifive.com>
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
 .../devicetree/bindings/riscv/cpus.yaml       | 168 ++++++++++++++++++
 1 file changed, 168 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/cpus.yaml

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
new file mode 100644
index 000000000000..6e8d55d9d4e1
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -0,0 +1,168 @@
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
+allOf:
+  - $ref: /schemas/cpus.yaml#
+
+properties:
+  $nodename:
+    const: cpus
+    description: Container of cpu nodes
+
+  '#address-cells':
+    const: 1
+    description: |
+      A single unsigned 32-bit integer uniquely identifies each RISC-V
+      hart in a system.  (See the "reg" node under the "cpu" node,
+      below).
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  '^cpu@[0-9a-f]+$':
+    properties:
+      compatible:
+        type: array
+        items:
+          - enum:
+              - sifive,rocket0
+              - sifive,e5
+              - sifive,e51
+              - sifive,u54-mc
+              - sifive,u54
+              - sifive,u5
+          - const: riscv
+        description:
+          Identifies that the hart uses the RISC-V instruction set
+          and identifies the type of the hart.
+
+      mmu-type:
+        allOf:
+          - $ref: "/schemas/types.yaml#/definitions/string"
+          - enum:
+              - riscv,sv32
+              - riscv,sv39
+              - riscv,sv48
+        description:
+          Identifies the MMU address translation mode used on this
+          hart.  These values originate from the RISC-V Privileged
+          Specification document, available from
+          https://riscv.org/specifications/
+
+      riscv,isa:
+        allOf:
+          - $ref: "/schemas/types.yaml#/definitions/string"
+          - enum:
+              - rv64imac
+              - rv64imafdc
+        description:
+          Identifies the specific RISC-V instruction set architecture
+          supported by the hart.  These are documented in the RISC-V
+          User-Level ISA document, available from
+          https://riscv.org/specifications/
+
+      timebase-frequency:
+        type: integer
+        minimum: 1
+        description:
+          Specifies the clock frequency of the system timer in Hz.
+          This value is common to all harts on a single system image.
+
+      interrupt-controller:
+        type: object
+        description: Describes the CPU's local interrupt controller
+
+        properties:
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
+      - riscv,isa
+      - timebase-frequency
+      - interrupt-controller
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
+                cpu_intc0: interrupt-controller {
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
+                tlb-split;
+                cpu_intc1: interrupt-controller {
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

