Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E02BC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34715206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tbvBfQ4b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfLPMUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 07:20:48 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:33153 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbfLPMUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 07:20:47 -0500
Received: by mail-pj1-f65.google.com with SMTP id r67so2912058pjb.0;
        Mon, 16 Dec 2019 04:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VFoOgSa0mgncJCsldexTszCD+8TIIog8TeeHmBf2y58=;
        b=tbvBfQ4bdiVYRNJE4pnt2oWEbpOF1mVoU/h0CBbk22WiYY/QpIpn4IfZMQ30iigJGk
         Z2FgeLcqMrfbE1IMf9I9eWulWY9ef880LNd0N9cl1FTAjz3paLd0v97qHZlfbpQvodUo
         d/mfunBTa9hPveAbLYIjNIxe2HhvAQ3/Llhmyy1p2oNm2Oq2t9ZMSqo43i7KbyNrmF4M
         4wo6FPcjyJKfgrD15gPMNWKI+q7LpALcAHrLIcdY9oN4BTxNxM074BBry/vJOuVuxT1P
         VaXst1LW5vd/RJMOhWBzoUMuI92LZe2oJgRE0qqriwNMXVVv/bLsU68FyWjKjCSboc3T
         Fl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VFoOgSa0mgncJCsldexTszCD+8TIIog8TeeHmBf2y58=;
        b=taqvu8CzsR95W3sXUzjQpwDd26uScu3hJL3IlDao2XSrC25gzX2kMqhAmcVRJg8KZC
         3LHSp0Z6FXwdCgY9x066ic4vxJiqZe/jUH2XdaZuTv6qc6GcbiJICxOAHv5wFwNEFMpV
         Clj4JbrSige88hhzw0TTK7ryhbaMILtAag7qIYO+hJLAXGtd5CNuj7y33oSy4k+b1ktB
         iP6aRTS43fXJ7uyR0qGGpYYc8aziU00iwn6FWdwBQzUNBbdry5jo2DnaYSjLSqgNG+cK
         rLkKSrnMgMpRwuMe8A5PDHV6wZw6lRfJYiKl0h60Q4MPI6czHhblDpAT6trKZ1RFH9ru
         lvcw==
X-Gm-Message-State: APjAAAVbP42Zja4WZ76iHiqrnfQAEdfQ7ly51x+iOwe279/VALjbNh9b
        kh8wUWfb9zfBjvznQb7hELc=
X-Google-Smtp-Source: APXvYqx4y+PmeLlh4oK9aKL5GWfPwdG4HLc2zVJSitgBxEi5fZSBwOzkMusddlCf6qmXi7BpXojXng==
X-Received: by 2002:a17:902:8eca:: with SMTP id x10mr4731373plo.248.1576498847159;
        Mon, 16 Dec 2019 04:20:47 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id o17sm18633910pjq.1.2019.12.16.04.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 04:20:46 -0800 (PST)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH V2 3/6] dt-bindings: clk: sprd: add bindings for sc9863a clock controller
Date:   Mon, 16 Dec 2019 20:19:29 +0800
Message-Id: <20191216121932.22967-4-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216121932.22967-1-zhang.lyra@gmail.com>
References: <20191216121932.22967-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

add a new bindings to describe sc9863a clock compatible string.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 .../bindings/clock/sprd,sc9863a-clk.yaml      | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml

diff --git a/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml b/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
new file mode 100644
index 000000000000..881f0a0287e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2019 Unisoc Inc.
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/clock/sprd,sc9863a-clk.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: SC9863A Clock Control Unit Device Tree Bindings
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+properties:
+  "#clock-cells":
+    const: 1
+
+  compatible :
+    enum:
+      - sprd,sc9863a-ap-clk
+      - sprd,sc9863a-pmu-gate
+      - sprd,sc9863a-pll
+      - sprd,sc9863a-mpll
+      - sprd,sc9863a-rpll
+      - sprd,sc9863a-dpll
+      - sprd,sc9863a-aon-clk
+      - sprd,sc9863a-apahb-gate
+      - sprd,sc9863a-aonapb-gate
+      - sprd,sc9863a-mm-gate
+      - sprd,sc9863a-mm-clk
+      - sprd,sc9863a-vspahb-gate
+      - sprd,sc9863a-apapb-gate
+
+  clocks:
+    description: |
+      The input parent clock(s) phandle for this clock, only list fixed
+      clocks which are decleared in devicetree.
+
+  clock-names:
+    description: |
+      Clock name strings used for driver to reference.
+
+  reg:
+    description: |
+      Contain the registers base address and length. It must be configured
+      only if no 'sprd,syscon' under the node.
+
+  sprd,syscon:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description: |
+      The phandle to the syscon which is in the same address area with
+      the clock, and so we can get regmap for the clocks from the
+      syscon device.
+
+required:
+  - compatible
+  - '#clock-cells'
+
+examples:
+  - |
+    ap_clk: clock-controller@21500000 {
+      compatible = "sprd,sc9863a-ap-clk";
+      reg = <0 0x21500000 0 0x1000>;
+      clocks = <&ext_32k>, <&ext_26m>;
+      clock-names = "ext-32k", "ext-26m";
+      #clock-cells = <1>;
+    };
+
+  - |
+    apahb_gate: apahb-gate {
+      compatible = "sprd,sc9863a-apahb-gate";
+      sprd,syscon = <&ap_ahb_regs>;
+      #clock-cells = <1>;
+    };
+
+...
-- 
2.20.1

