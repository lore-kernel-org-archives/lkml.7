Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6B2C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 00:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A970221738
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 00:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="gO0q/4nZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vq9r47Rt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfHGAiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 20:38:04 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:37781 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726542AbfHGAiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 20:38:03 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6764927D4;
        Tue,  6 Aug 2019 20:38:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 06 Aug 2019 20:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=rqpiLLusQurvK
        WQs9c8c91zRlnYataWeo+My6eoeOzA=; b=gO0q/4nZt1GsBCEkq5ReozR8M7+0c
        1zt/Z2Z4aPpn2jij+lNkIfFewCU+831zc1VwJVQEN/fGM5VzYTXV8nED/tgFB9FL
        1sx/F8pt8I+FH/+AhQW+jEgyUpBjR39vDLLkxPTWWQ7/Rwt3hI3ZsvR84LuFKgKl
        8TZzWXy9Q1MrjJDqYf6EDWSEs7MzqOOf4j2o7YlgysugUeA2EhoaIsZ8gvxjbFC+
        vMIG/RJWh9mhnNriFpH3mATQmWerlc1c1YvPaC/MLZQdzpnFlHFab9JiI5I6aylc
        0AcyegN+jDnlpWirEsUkF7UvwV18u1hrcunvuQZxuTp8ThehtuoXq18/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=rqpiLLusQurvKWQs9c8c91zRlnYataWeo+My6eoeOzA=; b=vq9r47Rt
        VjPznrxmuvGPnSX1kaqMzmdVWRBBSRaNOfv4a3kyqfusk8DmilaLPHkbpl4FdC1k
        NZj/4WN/byJPDaScGDIxLdUys/8MCKYi4njH1dfXVNnv2BZ0nDbLzDgjSZiEo4cg
        AIivX/6raykk0gmuYvukVp92VdKs1mTqVs83liU1esW+xgPSwq9TGip/ajcyeRF2
        /2ddOqKzBJXyqqbyv2+7HN1IC6tL8p5zA9zu8Dq3R+bh/ifSrjyjn/tw0WeDwcmk
        VK083PZYzkXIWf+0bGrt9e+lhBcT491mYr7FJbudlazcZQ1eyVo+ldNeFyEb7X/j
        9rn258/oG9xKig==
X-ME-Sender: <xms:ah1KXVMwXFCVRUPHgXgJYrl5YH5rX0A4BVD_OBAbtAoOx_aapEcEKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudduuddgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegr
    jhdrihgurdgruheqnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucfkph
    epvddtvddrkedurddukedrfedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgv
    fiesrghjrdhiugdrrghunecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:ah1KXboY9S5hZhzkmDPYzGhKMbcezkpiLd43PTQgX8nW-8dk9CczCg>
    <xmx:ah1KXc7wgREoNILuaoklxsb4UTj9mjI6H4L9HTwR56zCBXt9lh1Lhg>
    <xmx:ah1KXTHjFAUbc4jGxxjxd4IpW2AmQBrsc6HxZfMJRB3ftV3EXh1qaw>
    <xmx:ah1KXfq15eI16rlXyFWhpWxfePeFKUL-RSmvoS4TpA6VHsWq9wQlyA>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id 50003380088;
        Tue,  6 Aug 2019 20:37:58 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, joel@jms.id.au,
        adrian.hunter@intel.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        ryanchen.aspeed@gmail.com
Subject: [PATCH v5 1/2] dt-bindings: mmc: Document Aspeed SD controller
Date:   Wed,  7 Aug 2019 10:06:28 +0930
Message-Id: <20190807003629.2974-2-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807003629.2974-1-andrew@aj.id.au>
References: <20190807003629.2974-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ASPEED SD/SDIO/MMC controller exposes two slots implementing the
SDIO Host Specification v2.00, with 1 or 4 bit data buses, or an 8 bit
data bus if only a single slot is enabled.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

---
v4:
* Make use of mmc-controller.yaml
* Document sdhci,auto-cmd12

v2:
* Fix compatible enums
* Add AST2600 compatibles
* Describe #address-cells / #size-cells
---
 .../devicetree/bindings/mmc/aspeed,sdhci.yaml | 105 ++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml

diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
new file mode 100644
index 000000000000..570f8c72662b
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASPEED SD/SDIO/MMC Controller
+
+maintainers:
+  - Andrew Jeffery <andrew@aj.id.au>
+  - Ryan Chen <ryanchen.aspeed@gmail.com>
+
+description: |+
+  The ASPEED SD/SDIO/eMMC controller exposes two slots implementing the SDIO
+  Host Specification v2.00, with 1 or 4 bit data buses, or an 8 bit data bus if
+  only a single slot is enabled.
+
+  The two slots are supported by a common configuration area. As the SDHCIs for
+  the slots are dependent on the common configuration area, they are described
+  as child nodes.
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2400-sd-controller
+      - aspeed,ast2500-sd-controller
+      - aspeed,ast2600-sd-controller
+  reg:
+    maxItems: 1
+    description: Common configuration registers
+  "#address-cells":
+    const: 1
+  "#size-cells":
+    const: 1
+  ranges: true
+  clocks:
+    maxItems: 1
+    description: The SD/SDIO controller clock gate
+
+patternProperties:
+  "^sdhci@[0-9a-f]+$":
+    type: object
+    allOf:
+        - $ref: mmc-controller.yaml
+    properties:
+      compatible:
+        enum:
+          - aspeed,ast2400-sdhci
+          - aspeed,ast2500-sdhci
+          - aspeed,ast2600-sdhci
+      reg:
+        maxItems: 1
+        description: The SDHCI registers
+      clocks:
+        maxItems: 1
+        description: The SD bus clock
+      interrupts:
+        maxItems: 1
+        description: The SD interrupt shared between both slots
+      sdhci,auto-cmd12:
+        type: boolean
+        description: Specifies that controller should use auto CMD12
+    required:
+      - compatible
+      - reg
+      - clocks
+      - interrupts
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+  - clocks
+
+examples:
+  - |
+    #include <dt-bindings/clock/aspeed-clock.h>
+    sdc@1e740000 {
+            compatible = "aspeed,ast2500-sd-controller";
+            reg = <0x1e740000 0x100>;
+            #address-cells = <1>;
+            #size-cells = <1>;
+            ranges = <0 0x1e740000 0x10000>;
+            clocks = <&syscon ASPEED_CLK_GATE_SDCLK>;
+
+            sdhci0: sdhci@100 {
+                    compatible = "aspeed,ast2500-sdhci";
+                    reg = <0x100 0x100>;
+                    interrupts = <26>;
+                    sdhci,auto-cmd12;
+                    clocks = <&syscon ASPEED_CLK_SDIO>;
+            };
+
+            sdhci1: sdhci@200 {
+                    compatible = "aspeed,ast2500-sdhci";
+                    reg = <0x200 0x100>;
+                    interrupts = <26>;
+                    sdhci,auto-cmd12;
+                    clocks = <&syscon ASPEED_CLK_SDIO>;
+            };
+    };
-- 
2.20.1

