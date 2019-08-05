Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9646C19759
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 02:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8995206A2
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 02:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="PoBAn8Q7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CHHYAtdP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfHECvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 22:51:51 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:32793 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726757AbfHECvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 22:51:50 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id BFF2AADF;
        Sun,  4 Aug 2019 22:51:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 04 Aug 2019 22:51:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=8UrLTRB4jgrSy
        WTy2sIOZ5rPOkCXFnPpTytcus6239s=; b=PoBAn8Q7o54zMa79mpkFg9VhZRAfx
        OU0J7fPec/sQAbrRkGA6aQcO3UIJ9hs86cWyOCffqEuJqRw1Oc2r607fVRg6FtAj
        gSgxCa5wOVvd/p/qaVzw9fopsUD3XMKusnRCKFnrZDqfBIIW2bkoPIGS4n+rPSUP
        N2ekFMuAmNfGfwsa7R2y4c+3pT0tJ3lhN6hxelh6QyTfLWUZ5h0RMPw4aKdKc+lM
        H0UG6E4EVDJg4ijHBnd2ZJZICQLkhODCbsWT9PTx1q46/0gqPuXCaUzmnGImlRxG
        vnNNOWeEmtPccewiZIoLWVa8RqQJwBAB5xrCz4ikM8ZhVyUF+DCHiIgCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=8UrLTRB4jgrSyWTy2sIOZ5rPOkCXFnPpTytcus6239s=; b=CHHYAtdP
        xIrEBHAoypoe/NPWkJSvcoHvykoBVPNJZ23zDKNUMaOAXkQGzApKgaT8r17d63Q4
        iZ9jRfzhQSLZ/+NSz6mB2EYHQAOSBnbEz+O8QVR7YOXmjCTmx79hUNmPqZQlA8HY
        SZ8YAbojwBwnprN9SaKKhDywc1jc5fxc4YLfjBJ02KUObAtStSFhQwejBMhG+ARA
        cUGBA4H9dBYvWmnVRPB5f19pahOcejHGl/sj9LBP3GmOM5nmMB7gZBpSOfUyLkv9
        6rlGym2TN0HgptzIAHeYQMCbQQ8kieML/cTzeZmjHAc2hMUMZFJI2WG9Qtasa0fa
        St6uVnyYf0v9LQ==
X-ME-Sender: <xms:xZlHXeaJMwYocCjr_pmJGrFhSFCPu7_Y8CXxJJzsQiXDbeYNx5aaRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddruddtiedgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegr
    jhdrihgurdgruheqnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucfkph
    epuddukedrvddutddrudegfedruddvheenucfrrghrrghmpehmrghilhhfrhhomheprghn
    ughrvgifsegrjhdrihgurdgruhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:xZlHXfxEUdncWA0r5MVtFjTza68sAUMsm46DSLEvzFQWffUtwIU9Ag>
    <xmx:xZlHXU-AUCffC9PMY-DRwmW97g_130XmvOESXPuBKMfPF7EBLqU7LA>
    <xmx:xZlHXTwyvZsLC5f98nTDrC9wdu0ZpH_LezCfVbjoMgtxFCINgWNIVQ>
    <xmx:xZlHXQWFzBLSnpY0G1nNPwSEnXi0SznqEU1bSqXBBtSYJG-LEpLHmQ>
Received: from localhost.localdomain (ppp118-210-143-125.adl-adc-lon-bras33.tpg.internode.on.net [118.210.143.125])
        by mail.messagingengine.com (Postfix) with ESMTPA id 77DBE380086;
        Sun,  4 Aug 2019 22:51:45 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, joel@jms.id.au,
        adrian.hunter@intel.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        ryanchen.aspeed@gmail.com
Subject: [PATCH v4 1/2] dt-bindings: mmc: Document Aspeed SD controller
Date:   Mon,  5 Aug 2019 12:21:54 +0930
Message-Id: <20190805025155.9020-2-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190805025155.9020-1-andrew@aj.id.au>
References: <20190805025155.9020-1-andrew@aj.id.au>
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
v3:
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
index 000000000000..ca8684f47962
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
@@ -0,0 +1,105 @@
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

