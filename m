Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780F0C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 21:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 438D82173C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 21:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pYoLTnUC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfHKVBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 17:01:53 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43100 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbfHKVBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 17:01:40 -0400
Received: by mail-lf1-f67.google.com with SMTP id c19so72974132lfm.10;
        Sun, 11 Aug 2019 14:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XNaRCrFUSl/K+Rrlj4buIJrBwJTcaqkZQLm0qTW4nWg=;
        b=pYoLTnUCH9ZkDXbwFYV6k/DWyIoqhH6qI5MPoc+J0z77sktuwJk5OgRy9IE9bR62tp
         yVk+LO7QyVBUCrzxJ6QqICxm/G8jpYkEl9BkqyrxPEoLRUTA0Iob1pRs6sCLwhKpkXT1
         +eFT0IjKetD95awkch9aIGnynjVExqODM54hpQD/UxzFR0svc5ffnfjWOcGvcz4Hp9MK
         GJSyksm05rfcKq+DZkzWvzd/RpR3+aRLBNnNHT07CNXuuSXo+bx56bxfclcOYUjMMEO9
         fMneAxJ3s8FltE8hVPw1Uvj1R1xVoFa3pT0fn8Dh4dsVMj6lp7T258AlKeHUnikrqq8+
         AxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XNaRCrFUSl/K+Rrlj4buIJrBwJTcaqkZQLm0qTW4nWg=;
        b=XgzFWWO1gyp+dHejv4nqwar0jDi2YbkxtCbBc0wTuTFg9Jpji4uuLqaQ/aPCwp/DdG
         G9leVD4e1yqMrK1Wm0xzgFfSGUc8MIrPeS9ktUQGnTpW6uy8xqLKlUHEXImkWNbi8sM4
         soqnZtEMC0mdM/hWOMJWfr8kUW2C6ZJ0Lc7bCzQ7h0cLM1C0gD8yebk5NCcxJYZYVZg2
         eBmoW0sTlW1i8UozlmFgcnQgi9IJj32ViH3BsOjbOQJuMZCYHE70aw6B89OJH/s5RV9T
         KSt1fUs/AVzzgKpJ41H7PT58iewnquLgEyHnuYLgVYx5HQeoOH2eVxyNXuwpt1fcnXPB
         3nsg==
X-Gm-Message-State: APjAAAWKt47fiM2cUO+14X1Xy9Jb/4N2adzxgksDc4ewAksochV/eFYp
        eeN+EOrXJHYAIv12BfD39D8=
X-Google-Smtp-Source: APXvYqxIOChYEz6SJAp8kQE4MkRNeMwSYP9bDq3QjUh0ywZECwkBgmhGKKEsfMo36IjwdLlZqOkxRw==
X-Received: by 2002:a19:5f1c:: with SMTP id t28mr18541637lfb.34.1565557296888;
        Sun, 11 Aug 2019 14:01:36 -0700 (PDT)
Received: from localhost.localdomain ([94.29.34.218])
        by smtp.gmail.com with ESMTPSA id z25sm18708161lfi.51.2019.08.11.14.01.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 14:01:36 -0700 (PDT)
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
Subject: [PATCH v10 10/15] dt-bindings: memory: Add binding for NVIDIA Tegra30 Memory Controller
Date:   Mon, 12 Aug 2019 00:00:38 +0300
Message-Id: <20190811210043.20122-11-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190811210043.20122-1-digetx@gmail.com>
References: <20190811210043.20122-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for the NVIDIA Tegra30 SoC Memory Controller.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../memory-controllers/nvidia,tegra30-mc.yaml | 167 ++++++++++++++++++
 1 file changed, 167 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml
new file mode 100644
index 000000000000..84fd57bcf0dc
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml
@@ -0,0 +1,167 @@
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
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: mc
+
+  interrupts:
+    maxItems: 1
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

