Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E927C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 00:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648352075B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 00:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="iBUc0x4v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfLXA1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 19:27:17 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:47550 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfLXA1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 19:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1577147234; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=fNIZfTznwRicv1L3tfCg8DVacLlI9bpQ8BJN1yvLWCU=;
        b=iBUc0x4vbq+4lSji13z2d+saT7tVMXDrBcYb1Mj1lT1mD7lBmiXT5dbD4coZWZLN/2PWdb
        w5xk54yGkUIvZyEz/v/FeI0qcWGwXmgBT5EVS6R8tMR+lEPmUpxPPuUtUDIuuotgfLHta2
        ZVYMPE6m2L9hpT4daVCC9TWV7Wgj9Cw=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     od@zcrc.me, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/2] dt-bindings: sound: Convert jz47*-codec doc to YAML
Date:   Tue, 24 Dec 2019 01:27:07 +0100
Message-Id: <20191224002708.1207884-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert ingenic,jz4740-codec.txt and ingenic,jz4725b-codec.txt to one
single ingenic,codec.yaml file, since they share the same binding.

Add the ingenic,jz4770-codec compatible string in the process.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 .../bindings/sound/ingenic,codec.yaml         | 55 +++++++++++++++++++
 .../bindings/sound/ingenic,jz4725b-codec.txt  | 20 -------
 .../bindings/sound/ingenic,jz4740-codec.txt   | 20 -------
 3 files changed, 55 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/ingenic,codec.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/ingenic,jz4725b-codec.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/ingenic,jz4740-codec.txt

diff --git a/Documentation/devicetree/bindings/sound/ingenic,codec.yaml b/Documentation/devicetree/bindings/sound/ingenic,codec.yaml
new file mode 100644
index 000000000000..eb4be86464bb
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ingenic,codec.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/ingenic,codec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ingenic JZ47xx internal codec DT bindings
+
+maintainers:
+  - Paul Cercueil <paul@crapouillou.net>
+
+properties:
+  $nodename:
+    pattern: '^audio-codec@.*'
+
+  compatible:
+    oneOf:
+      - const: ingenic,jz4770-codec
+      - const: ingenic,jz4725b-codec
+      - const: ingenic,jz4740-codec
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: aic
+
+  '#sound-dai-cells':
+    const: 0
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#sound-dai-cells'
+
+examples:
+  - |
+    #include <dt-bindings/clock/jz4740-cgu.h>
+    codec: audio-codec@10020080 {
+      compatible = "ingenic,jz4740-codec";
+      reg = <0x10020080 0x8>;
+      #sound-dai-cells = <0>;
+      clocks = <&cgu JZ4740_CLK_AIC>;
+      clock-names = "aic";
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/sound/ingenic,jz4725b-codec.txt b/Documentation/devicetree/bindings/sound/ingenic,jz4725b-codec.txt
deleted file mode 100644
index 05adc0d47b13..000000000000
--- a/Documentation/devicetree/bindings/sound/ingenic,jz4725b-codec.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-Ingenic JZ4725B codec controller
-
-Required properties:
-- compatible : "ingenic,jz4725b-codec"
-- reg : codec registers location and length
-- clocks : phandle to the AIC clock.
-- clock-names: must be set to "aic".
-- #sound-dai-cells: Must be set to 0.
-
-Example:
-
-codec: audio-codec@100200a4 {
-	compatible = "ingenic,jz4725b-codec";
-	reg = <0x100200a4 0x8>;
-
-	#sound-dai-cells = <0>;
-
-	clocks = <&cgu JZ4725B_CLK_AIC>;
-	clock-names = "aic";
-};
diff --git a/Documentation/devicetree/bindings/sound/ingenic,jz4740-codec.txt b/Documentation/devicetree/bindings/sound/ingenic,jz4740-codec.txt
deleted file mode 100644
index 1ffcade87e7b..000000000000
--- a/Documentation/devicetree/bindings/sound/ingenic,jz4740-codec.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-Ingenic JZ4740 codec controller
-
-Required properties:
-- compatible : "ingenic,jz4740-codec"
-- reg : codec registers location and length
-- clocks : phandle to the AIC clock.
-- clock-names: must be set to "aic".
-- #sound-dai-cells: Must be set to 0.
-
-Example:
-
-codec: audio-codec@10020080 {
-	compatible = "ingenic,jz4740-codec";
-	reg = <0x10020080 0x8>;
-
-	#sound-dai-cells = <0>;
-
-	clocks = <&cgu JZ4740_CLK_AIC>;
-	clock-names = "aic";
-};
-- 
2.24.0

