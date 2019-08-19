Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63438C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 18:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DBAB22CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 18:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566238849;
	bh=WlmSIy9FhdBOLKfq102q4YX3QMPbyA7nFdt9dtzsEoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jVRbcBqlJpKEqbUhThLVqJH04mL6WecXYq49c31uhohYmKzdr/5YcfOabpoAlNT6H
	 yQrEfKOZMpuHuNSVe6V8odAjexFPpnKG7rGeFOH22bq5FLvpTjKSWEiNXlFl3YdKtc
	 XYQ0YDcxyCNuyQBv5+Cmv14W9+axJrVuaicvRdoQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbfHSSUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 14:20:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728029AbfHSSUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 14:20:47 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3C4122CF6;
        Mon, 19 Aug 2019 18:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566238846;
        bh=WlmSIy9FhdBOLKfq102q4YX3QMPbyA7nFdt9dtzsEoo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FnBL+MgF/ZB9CCVuwr5m9KxZREBzouKCnw8igv0c0JCFLkh41S5vVyloAifD8oYH1
         aGuPiAlokWUN5Hkx3nN2ytnjYdRLr/d79mUIFzZJK1V3koYQiDaG0LAgq6FswWllzQ
         OQYjfJeovXVTZ3wSDVgKluGpVG+yUr/bmQmHYko0=
From:   Maxime Ripard <mripard@kernel.org>
To:     linux@roeck-us.net, wim@linux-watchdog.org
Cc:     linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v2 2/6] dt-bindings: watchdog: Convert Allwinner watchdog to a schema
Date:   Mon, 19 Aug 2019 20:20:35 +0200
Message-Id: <20190819182039.24892-2-mripard@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190819182039.24892-1-mripard@kernel.org>
References: <20190819182039.24892-1-mripard@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

The Allwinner SoCs have a watchdog supported in Linux, with a matching
Device Tree binding.

Now that we have the DT validation in place, let's convert the device tree
bindings for that controller over to a YAML schemas.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

---

Changes from v1:
  - Use generic watchdog schema
  - Use unevaluatedProperties instead of additionalProperties
---
 .../watchdog/allwinner,sun4i-a10-wdt.yaml     | 48 +++++++++++++++++++
 .../bindings/watchdog/sunxi-wdt.txt           | 22 ---------
 2 files changed, 48 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml b/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
new file mode 100644
index 000000000000..dc7553f57708
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/allwinner,sun4i-a10-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner A10 Watchdog Device Tree Bindings
+
+allOf:
+  - $ref: "watchdog.yaml#"
+
+maintainers:
+  - Chen-Yu Tsai <wens@csie.org>
+  - Maxime Ripard <maxime.ripard@bootlin.com>
+
+properties:
+  compatible:
+    oneOf:
+      - const: allwinner,sun4i-a10-wdt
+      - const: allwinner,sun6i-a31-wdt
+      - items:
+          - const: allwinner,sun50i-a64-wdt
+          - const: allwinner,sun6i-a31-wdt
+      - items:
+          - const: allwinner,sun50i-h6-wdt
+          - const: allwinner,sun6i-a31-wdt
+      - items:
+          - const: allwinner,suniv-f1c100s-wdt
+          - const: allwinner,sun4i-a10-wdt
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    wdt: watchdog@1c20c90 {
+        compatible = "allwinner,sun4i-a10-wdt";
+        reg = <0x01c20c90 0x10>;
+        timeout-sec = <10>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt b/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt
deleted file mode 100644
index e65198d82a2b..000000000000
--- a/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-Allwinner SoCs Watchdog timer
-
-Required properties:
-
-- compatible : should be one of
-	"allwinner,sun4i-a10-wdt"
-	"allwinner,sun6i-a31-wdt"
-	"allwinner,sun50i-a64-wdt","allwinner,sun6i-a31-wdt"
-	"allwinner,sun50i-h6-wdt","allwinner,sun6i-a31-wdt"
-	"allwinner,suniv-f1c100s-wdt", "allwinner,sun4i-a10-wdt"
-- reg : Specifies base physical address and size of the registers.
-
-Optional properties:
-- timeout-sec : Contains the watchdog timeout in seconds
-
-Example:
-
-wdt: watchdog@1c20c90 {
-	compatible = "allwinner,sun4i-a10-wdt";
-	reg = <0x01c20c90 0x10>;
-	timeout-sec = <10>;
-};
-- 
2.21.0

