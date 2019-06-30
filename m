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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C7EC4646D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 21:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4333F212F5
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 21:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8lXtyLt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfF3VEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 17:04:48 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46242 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbfF3VEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 17:04:46 -0400
Received: by mail-lj1-f193.google.com with SMTP id v24so10913512ljg.13;
        Sun, 30 Jun 2019 14:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w5DeDNLd/nQYRKa3PrC/JK8YgoKIo6tthgU3l9nbyhM=;
        b=L8lXtyLtevN0fPA9VQbbOOjoI8pIdxDsdA3iC5X+mNx9KALw1hHwmqUo6svcNQpQGS
         q7ihkyhqbugkSfpDXjk7GcgyAPrgs6euJh2kD6j9zxCDDoDgRe9y/h09u4IH6o65P3F/
         UsieJZaizfR313jX5pCW78cbLYUkmn1ntk4OTWZTrUPTalvbd8jDBcCWtKYOUpDJmkHD
         bv/b2LamCUhoprhzgdvEcp85te6rCgWSaLry/PLXduG+W+np7Q2HX7cUhSTCN5+UR1BH
         yNMHzcWIyAjczHR6b8hqfzeFt+iPw4yrPvh4Rh2+aTHXtC/5EC5NNLnl4Y05c4hOXDtq
         qU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w5DeDNLd/nQYRKa3PrC/JK8YgoKIo6tthgU3l9nbyhM=;
        b=g6Ob2J9Oz9+GoulwpjsWAAl7yJLuuox531O9zxNg/mJl2Uar9PmB5f/b8Ttp+5303I
         l1gyaQOPSdShtKFX56qr3LvuwLQ1Ke4ScvBMVPDQFDNgfCSH/gfxhh33qs3v1tKmPThj
         q1VoD1c32t6Z+B6KN8WKPlJBI0abjgDF1eg7c+yzgkMtQ3ZyKJv0Sw9sLY1f9H22AAmB
         E4+tk35zHpE7bzaPBwa4k8WMtYmqaaxbvaE6FK4qrujBCrx6cCdDNIJfaQAjF85eXpXk
         FTQp4eKKSFMLpt9CqHweETswS0eCG4aPOGMzat9409h93DICJxSndKLvdChPMbh1Tkbe
         yaFA==
X-Gm-Message-State: APjAAAWd4Krw/kv1Ad0Bt1iSzxE7JO1LrlNFHk+0l/5UWcgytREGdHX4
        a7UDeeFhSGt4lGC01KlO+XM=
X-Google-Smtp-Source: APXvYqxDf9fAoh/QOFHOlZosDvLeJfJFp65fPEPLUKop0WiPXnoSPRVMF89d2DKlZ+k5fQgiQwB93Q==
X-Received: by 2002:a2e:3e01:: with SMTP id l1mr12034305lja.208.1561928683855;
        Sun, 30 Jun 2019 14:04:43 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id u9sm2221408lfb.38.2019.06.30.14.04.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Jun 2019 14:04:43 -0700 (PDT)
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
Subject: [PATCH v6 07/15] dt-bindings: memory: tegra30: Convert to Tegra124 YAML
Date:   Mon,  1 Jul 2019 00:00:11 +0300
Message-Id: <20190630210019.26914-8-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190630210019.26914-1-digetx@gmail.com>
References: <20190630210019.26914-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Tegra30 binding will actually differ from the Tegra124 a tad, in
particular the EMEM configuration description. Hence rename the binding
to Tegra124 during of the conversion to YAML.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../nvidia,tegra124-mc.yaml                   | 149 ++++++++++++++++++
 1 file changed, 149 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
new file mode 100644
index 000000000000..d18242510295
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
@@ -0,0 +1,149 @@
+# SPDX-License-Identifier: (GPL-2.0)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/nvidia,tegra124-mc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title:
+  NVIDIA Tegra124 SoC Memory Controller
+
+maintainers:
+  - Jon Hunter <jonathanh@nvidia.com>
+  - Thierry Reding <thierry.reding@gmail.com>
+
+description: |
+  Tegra124 SoC features a hybrid 2x32-bit / 1x64-bit memory controller.
+  These are interleaved to provide high performance with the load shared across
+  two memory channels. The Tegra124 Memory Controller handles memory requests
+  from internal clients and arbitrates among them to allocate memory bandwidth
+  for DDR3L and LPDDR3 SDRAMs.
+
+properties:
+  compatible:
+    const: nvidia,tegra124-mc
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
+              "15.6.1 MC Registers" in the TRM.
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
+              - description: MC_EMEM_ARB_MISC1
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
+    memory-controller@70019000 {
+        compatible = "nvidia,tegra124-mc";
+        reg = <0x0 0x70019000 0x0 0x1000>;
+        clocks = <&tegra_car 32>;
+        clock-names = "mc";
+
+        interrupts = <0 77 4>;
+
+        #iommu-cells = <1>;
+        #reset-cells = <1>;
+
+        emc-timings-3 {
+            nvidia,ram-code = <3>;
+
+            timing-12750000 {
+                clock-frequency = <12750000>;
+
+                nvidia,emem-configuration = <
+                    0x40040001 /* MC_EMEM_ARB_CFG */
+                    0x8000000a /* MC_EMEM_ARB_OUTSTANDING_REQ */
+                    0x00000001 /* MC_EMEM_ARB_TIMING_RCD */
+                    0x00000001 /* MC_EMEM_ARB_TIMING_RP */
+                    0x00000002 /* MC_EMEM_ARB_TIMING_RC */
+                    0x00000000 /* MC_EMEM_ARB_TIMING_RAS */
+                    0x00000002 /* MC_EMEM_ARB_TIMING_FAW */
+                    0x00000001 /* MC_EMEM_ARB_TIMING_RRD */
+                    0x00000002 /* MC_EMEM_ARB_TIMING_RAP2PRE */
+                    0x00000008 /* MC_EMEM_ARB_TIMING_WAP2PRE */
+                    0x00000003 /* MC_EMEM_ARB_TIMING_R2R */
+                    0x00000002 /* MC_EMEM_ARB_TIMING_W2W */
+                    0x00000003 /* MC_EMEM_ARB_TIMING_R2W */
+                    0x00000006 /* MC_EMEM_ARB_TIMING_W2R */
+                    0x06030203 /* MC_EMEM_ARB_DA_TURNS */
+                    0x000a0402 /* MC_EMEM_ARB_DA_COVERS */
+                    0x77e30303 /* MC_EMEM_ARB_MISC0 */
+                    0x70000f03 /* MC_EMEM_ARB_MISC1 */
+                    0x001f0000 /* MC_EMEM_ARB_RING1_THROTTLE */
+                >;
+            };
+        };
+    };
-- 
2.22.0

