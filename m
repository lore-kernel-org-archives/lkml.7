Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3CFC742A5
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 03:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F0BC214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 03:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="Q90CrvOU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o+oDEYuM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbfGLDc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 23:32:26 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:45107 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728955AbfGLDcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 23:32:25 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id C10AC1B61;
        Thu, 11 Jul 2019 23:32:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 11 Jul 2019 23:32:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=8OTTrn15u+3N9
        pDWV3Ka61zLndSduUjJwrYMM8MILms=; b=Q90CrvOUoebID2ta1bqq8kxPeT2hw
        6PnXZ07fFtMufFlH0lypw7I3ASf2lleRSUO3xt3T70x41NHGsUmJ1VV3NvVAHZqD
        JRltB0BssjVGZzYBMcW5y9iOsa5lHdgiZafE+HbjNSesbt0Xul3vZBUaw1KIzmi/
        WITjOZYrr9ecmtw0fIpI5VUIyeWBO8LXAtM5O+omlHXMacpf3QaL9ok1VVfiT18h
        LcFF5ogdYMD06XRSt0RDe4HjJDzyyVnOIeQ5BEm3FKEB2AX3pBB0ilWWbu7X+1zW
        OLz9JZoWTQVw8aSwlrr4oVs4q369QI9ToYOXAE/Sure+Y9H+wFPDYGb/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=8OTTrn15u+3N9pDWV3Ka61zLndSduUjJwrYMM8MILms=; b=o+oDEYuM
        nBf8QPrJpDwucokTXM+LYxLYvzioci4sZ+UKx0JesDJnsB4VpU8BjZE5jITJfprQ
        AVqYUOcBodZIqX5VIAoQxuhdygEDhw64Uv7pTmwUM8tn6xFZEy49jg1X+UT3q4t0
        Wd3wwkFnG0ZAx4TCyCnhAUE0PTN9PFnisYlJ4hSOU6bB8KedCwrFpoyU2XhwvBwC
        JCDPPWvvLiWYEknOcMx5DoYuBrYkaNBD3JMxge9fe0CFIWEsZnOm86U1xoWeeGOI
        mvzBYXV+g1AWq70DQ2ZGtjPndEZktE10mBey/GTmETvJcTduWUtvvr2ASuiJm39V
        vdGKzDduW1EDIg==
X-ME-Sender: <xms:R_8nXcfX6S_LHtcgnTWXo-jPdwanjE1-4Bo9pPFP2D-BSjSWkRSvJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrgeelgdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghj
    rdhiugdrrghuqeenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecukfhppe
    dvtddvrdekuddrudekrdeftdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgif
    segrjhdrihgurdgruhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:R_8nXSefBp0KqkQhYIlxFNWJEjdEzT93OqB-5dH_46X0IG1J2w_RJw>
    <xmx:R_8nXYi6bRp5LY-yEeG6Rz-E6POK6n6ldxl9UEk7mG1BMiMh4wHYNA>
    <xmx:R_8nXWSlrcobXtpvUxqGmgfkUPGH-XiSq0hnKR5ttu8YOgF48nWGQA>
    <xmx:R_8nXSPsTsCUllLbebsiWNu3ggDr2HT-M_8eEjbYv_ARCsXS-OFhzg>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id AC94B80060;
        Thu, 11 Jul 2019 23:32:19 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, joel@jms.id.au,
        adrian.hunter@intel.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        ryanchen.aspeed@gmail.com
Subject: [PATCH v2 1/2] dt-bindings: mmc: Document Aspeed SD controller
Date:   Fri, 12 Jul 2019 13:02:13 +0930
Message-Id: <20190712033214.24713-2-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190712033214.24713-1-andrew@aj.id.au>
References: <20190712033214.24713-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ASPEED SD/SDIO/eMMC controller exposes two slots implementing the
SDIO Host Specification v2.00, with 1 or 4 bit data buses, or an 8 bit
data bus if only a single slot is enabled.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
In v2:

* Rename to aspeed,sdhci.yaml
* Rename sd-controller compatible
* Add `maxItems: 1` for reg properties
* Move sdhci subnode description to patternProperties
* Drop sdhci compatible requirement
* #address-cells and #size-cells are required
* Prevent additional properties
* Implement explicit ranges in example
* Remove slot property

 .../devicetree/bindings/mmc/aspeed,sdhci.yaml | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml

diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
new file mode 100644
index 000000000000..67a691c3348c
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASPEED SD/SDIO/eMMC Controller
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
+    enum: [ aspeed,ast2400-sd-controller, aspeed,ast2500-sd-controller ]
+  reg:
+    maxItems: 1
+    description: Common configuration registers
+  ranges: true
+  clocks:
+    maxItems: 1
+    description: The SD/SDIO controller clock gate
+
+patternProperties:
+  "^sdhci@[0-9a-f]+$":
+    type: object
+    properties:
+      compatible:
+        enum: [ aspeed,ast2400-sdhci, aspeed,ast2500-sdhci ]
+      reg:
+        maxItems: 1
+        description: The SDHCI registers
+      clocks:
+        maxItems: 1
+        description: The SD bus clock
+      interrupts:
+        maxItems: 1
+        description: The SD interrupt shared between both slots
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

