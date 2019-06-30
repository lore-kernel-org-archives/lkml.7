Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13D0C5B576
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 21:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728262089C
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 21:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjxiXAud"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfF3VEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 17:04:51 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44531 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbfF3VEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 17:04:47 -0400
Received: by mail-lj1-f194.google.com with SMTP id k18so10907656ljc.11;
        Sun, 30 Jun 2019 14:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N1v+lKPWKb1Ym25cVQTv9jKxSvdn/WMSKG5wQTDxpKA=;
        b=kjxiXAudovqufo9e1Y/w1qCfdBR35+eHcMX1GgXRz5ZPLuD6wKq+qczaIhJMrdcq8B
         /7mbQCKnqd1B0HiloDUC/mD6fu10og6YwInbdqfo6UhsRgmLoiusRvNebLT3CqqlvRJI
         FirhvA/lZPGU6BOO+gMLtSf3q3OsFQLEpBog2gYUimUUXs9vVThUxkF/sTTLKsK9tNe4
         YN0eDpoGYxqxb2VG6fZJDWjYB5V51qgkFXL03tKKw4ij9i7tA5EpaZDsK3VTxUfm41Ij
         gO3WoXjHQxKcuPKBjykcGFhfl9P1jysJu7NHJmMNrxscs7VlsGSxpGI4JfG4n3t2iflA
         A+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N1v+lKPWKb1Ym25cVQTv9jKxSvdn/WMSKG5wQTDxpKA=;
        b=eKrh47htf98zuzOIPlAUnBejL4mpeLEdFpTZlv4wYAV3IzT4y4FVG51JXy7Au2UhxK
         BbZNPf1zPBFOs6VlnFWaFCkFwhtLI1/dbYURvTzJirAJI64K16jpTXZRAaHSiKNy3X54
         kWPrcwaXgKIA7aBtBF17MrrIxY4aeRbYRdLu4VWZarHodk8kXyM0qFHKynTPpQIysiSt
         8cqFeAsQy7mOEm17mHjwy8zA2oYR8Tf4Y75LezagrlZ1X6wfyIlWBLw2PaWw2q984ntR
         jxqrPCSBThEqxBAC7mAu/gBf4XoNeybaKh9lTeLVygjWnV8+/zNglXvwqOVLhFIQsBKl
         n8Xg==
X-Gm-Message-State: APjAAAVMw3xNYnk8KExET2zs2gZNm3b9T/52uuoQahZXl+VTrqSS9TG9
        PQN3adhbKTLhO28Sw/nG6WuVeVQ4
X-Google-Smtp-Source: APXvYqz2pg0n34JcDCqS2Co8HUo3LkU95ZNYCsE4tl0nuFJOtdNmiIDQqriHCNJkOJW7L5lr74Wnbg==
X-Received: by 2002:a2e:5cc8:: with SMTP id q191mr12223241ljb.118.1561928684898;
        Sun, 30 Jun 2019 14:04:44 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id u9sm2221408lfb.38.2019.06.30.14.04.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Jun 2019 14:04:44 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 08/15] dt-bindings: memory: Add binding for NVIDIA Tegra30 Memory Controller
Date:   Mon,  1 Jul 2019 00:00:12 +0300
Message-Id: <20190630210019.26914-9-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190630210019.26914-1-digetx@gmail.com>
References: <20190630210019.26914-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for the NVIDIA Tegra30 SoC Memory Controller.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../memory-controllers/nvidia,tegra30-mc.yaml | 160 ++++++++++++++++++
 1 file changed, 160 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml
new file mode 100644
index 000000000000..a3b59c569229
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml
@@ -0,0 +1,160 @@
+# SPDX-License-Identifier: (GPL-2.0)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/nvidia,tegra30-mc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title:
+  NVIDIA Tegra30 SoC Memory Controller
+
+maintainers:
+  - Dmitry Osipenko <digetx@gmail.com>
+  - Jon Hunter <jonathanh@nvidia.com>
+  - Thierry Reding <thierry.reding@gmail.com>
+
+description: |
+  Tegra30 Memory Controller architecturally consists of the following parts:
+
+    Arbitration Domains, which can handle a single request or response per
+    clock from a group of clients. Typically, a system has a single Arbitration
+    Domain, but an implementation may divide the client space into multiple
+    Arbitration Domains to increase the effective system bandwidth.
+
+    Protocol Arbiter, which manage a related pool of memory devices. A system
+    may have a single Protocol Arbiter or multiple Protocol Arbiters.
+
+    Memory Crossbar, which routes request and responses between Arbitration
+    Domains and Protocol Arbiters. In the simplest version of the system, the
+    Memory Crossbar is just a pass through between a single Arbitration Domain
+    and a single Protocol Arbiter.
+
+    Global Resources, which include things like configuration registers which
+    are shared across the Memory Subsystem.
+
+properties:
+  compatible:
+    const: nvidia,tegra30-mc
+
+  reg:
+    maxItems: 1
+    description:
+      Physical base address.
+
+  clocks:
+    maxItems: 1
+    description:
+      Memory Controller clock.
+
+  clock-names:
+    items:
+      - const: mc
+
+  interrupts:
+    maxItems: 1
+    description:
+      Memory Controller interrupt.
+
+  "#reset-cells":
+    const: 1
+
+  "#iommu-cells":
+    const: 1
+
+patternProperties:
+  ".*":
+    properties:
+      nvidia,ram-code:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Value of RAM_CODE this timing set is used for.
+
+    patternProperties:
+      ".*":
+        properties:
+          clock-frequency:
+            description:
+              Memory clock rate in Hz.
+
+          nvidia,emem-configuration:
+            $ref: /schemas/types.yaml#/definitions/uint32-array
+            description: |
+              Values to be written to the EMEM register block. See section
+              "18.13.1 MC Registers" in the TRM.
+            items:
+              - description: MC_EMEM_ARB_CFG
+              - description: MC_EMEM_ARB_OUTSTANDING_REQ
+              - description: MC_EMEM_ARB_TIMING_RCD
+              - description: MC_EMEM_ARB_TIMING_RP
+              - description: MC_EMEM_ARB_TIMING_RC
+              - description: MC_EMEM_ARB_TIMING_RAS
+              - description: MC_EMEM_ARB_TIMING_FAW
+              - description: MC_EMEM_ARB_TIMING_RRD
+              - description: MC_EMEM_ARB_TIMING_RAP2PRE
+              - description: MC_EMEM_ARB_TIMING_WAP2PRE
+              - description: MC_EMEM_ARB_TIMING_R2R
+              - description: MC_EMEM_ARB_TIMING_W2W
+              - description: MC_EMEM_ARB_TIMING_R2W
+              - description: MC_EMEM_ARB_TIMING_W2R
+              - description: MC_EMEM_ARB_DA_TURNS
+              - description: MC_EMEM_ARB_DA_COVERS
+              - description: MC_EMEM_ARB_MISC0
+              - description: MC_EMEM_ARB_RING1_THROTTLE
+
+        required:
+          - clock-frequency
+          - nvidia,emem-configuration
+
+    required:
+      - nvidia,ram-code
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - "#reset-cells"
+  - "#iommu-cells"
+
+examples:
+  - |
+    memory-controller@7000f000 {
+        compatible = "nvidia,tegra30-mc";
+        reg = <0x7000f000 0x400>;
+        clocks = <&tegra_car 32>;
+        clock-names = "mc";
+
+        interrupts = <0 77 4>;
+
+        #iommu-cells = <1>;
+        #reset-cells = <1>;
+
+        emc-timings-1 {
+            nvidia,ram-code = <1>;
+
+            timing-667000000 {
+                clock-frequency = <667000000>;
+
+                nvidia,emem-configuration = <
+                    0x0000000a /* MC_EMEM_ARB_CFG */
+                    0xc0000079 /* MC_EMEM_ARB_OUTSTANDING_REQ */
+                    0x00000003 /* MC_EMEM_ARB_TIMING_RCD */
+                    0x00000004 /* MC_EMEM_ARB_TIMING_RP */
+                    0x00000010 /* MC_EMEM_ARB_TIMING_RC */
+                    0x0000000b /* MC_EMEM_ARB_TIMING_RAS */
+                    0x0000000a /* MC_EMEM_ARB_TIMING_FAW */
+                    0x00000001 /* MC_EMEM_ARB_TIMING_RRD */
+                    0x00000003 /* MC_EMEM_ARB_TIMING_RAP2PRE */
+                    0x0000000b /* MC_EMEM_ARB_TIMING_WAP2PRE */
+                    0x00000002 /* MC_EMEM_ARB_TIMING_R2R */
+                    0x00000002 /* MC_EMEM_ARB_TIMING_W2W */
+                    0x00000004 /* MC_EMEM_ARB_TIMING_R2W */
+                    0x00000008 /* MC_EMEM_ARB_TIMING_W2R */
+                    0x08040202 /* MC_EMEM_ARB_DA_TURNS */
+                    0x00130b10 /* MC_EMEM_ARB_DA_COVERS */
+                    0x70ea1f11 /* MC_EMEM_ARB_MISC0 */
+                    0x001f0000 /* MC_EMEM_ARB_RING1_THROTTLE */
+                >;
+            };
+        };
+    };
-- 
2.22.0

