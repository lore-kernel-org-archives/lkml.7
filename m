Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D783FC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2751208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZ9mV96g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbfG3Q6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 12:58:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42767 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729908AbfG3Q6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:58:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id x1so16664746wrr.9;
        Tue, 30 Jul 2019 09:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BE65cOTXtmtLp98MJ/wcdV0Av74ifD6PaTlEiBDCTbg=;
        b=ZZ9mV96gy6iFmpubEjT/JcS92SZqHZxnB6QhjtNqaU8ewfOjb7O74ynPsTx1bNAXFn
         7GWYCWbXYK2Ov+z9QXkJv0wu3EVoZ4vA0CNXLr+oX5orXfcknLKh4ce2DSlrhB/I1xcm
         hdzdg/MXvhh32Yg9UdRa7zrc+19PPWdvOwK9PTDdE5V8biwDCgEK1MzdkeBVUZzUeFD8
         Nc8dgLeQce/g3dDD1NIHCd6OvyyRoWUlrs8AX692KeydKOmmSZ/YE5TeOdOkSNNL2G00
         RTOa4Ey3kwAQLg8N5wyqe4BZaz+xWJTiNnh25W3FerAr1UFpJlsnRp6VKnlnLgXMRo3k
         CnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BE65cOTXtmtLp98MJ/wcdV0Av74ifD6PaTlEiBDCTbg=;
        b=fyw5bsF9SsZ1VrdiqzMfimRaj1H2GdfphS8Zkv5Pp/feHAtWv9m0mQj4H5dH6vsv+H
         VPpL3DGfOKQ1iwce+GhuL0UvNP0Qu6ITaFdBxTMylAbNF9q/FFggNKgTWb4bJLQJItOS
         mia3TCQkVC5Kb8Q62d6H3AA0LQerZBoNpg5xE6ohWbonobMqxazyMpshrGoEi+F2P//S
         GRdrAF5qJbf9EUp9dU7qezGjzVZnsya/4tkUhP1tFgLxts7ceoSK1mQGeVAC+NLjaEvr
         uphpOxciYgs8vyAZZmCo9hD8TraIEWeNeqs27L8thOIkh+u8BkgKq+v2VQUdPCY7DIfr
         S2lA==
X-Gm-Message-State: APjAAAXwwXQ71DFmJMoKUaQXUzAjucVRLYjDQcqQEqeunQxsQxxQXHe0
        Pu9s+PIaM8K1SoUOWpQdS+g=
X-Google-Smtp-Source: APXvYqzjZBS7WSbFdI+PUAwaagScTahSJXaybdXjz6NF/PxfyF0cl/CcTc2r/GPQWd2TA1FZRRzHAw==
X-Received: by 2002:adf:b1d0:: with SMTP id r16mr73828566wra.332.1564505902144;
        Tue, 30 Jul 2019 09:58:22 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id r5sm70845040wmh.35.2019.07.30.09.58.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 09:58:21 -0700 (PDT)
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
Subject: [PATCH v9 10/15] dt-bindings: memory: Add binding for NVIDIA Tegra30 Memory Controller
Date:   Tue, 30 Jul 2019 19:56:13 +0300
Message-Id: <20190730165618.10122-11-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730165618.10122-1-digetx@gmail.com>
References: <20190730165618.10122-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for the NVIDIA Tegra30 SoC Memory Controller.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../memory-controllers/nvidia,tegra30-mc.yaml | 173 ++++++++++++++++++
 1 file changed, 173 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml
new file mode 100644
index 000000000000..40e63cdf836b
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml
@@ -0,0 +1,173 @@
+# SPDX-License-Identifier: (GPL-2.0)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/nvidia,tegra30-mc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra30 SoC Memory Controller
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
+  The Tegra30 Memory Controller handles memory requests from internal clients
+  and arbitrates among them to allocate memory bandwidth for DDR3L and LPDDR2
+  SDRAMs.
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
+  "^emc-timings-[0-9]+$":
+    type: object
+    properties:
+      nvidia,ram-code:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Value of RAM_CODE this timing set is used for.
+
+    patternProperties:
+      "^timing-[0-9]+$":
+        type: object
+        properties:
+          clock-frequency:
+            description:
+              Memory clock rate in Hz.
+            minimum: 1000000
+            maximum: 900000000
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
+        additionalProperties: false
+
+    required:
+      - nvidia,ram-code
+
+    additionalProperties: false
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
+additionalProperties: false
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

