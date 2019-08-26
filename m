Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCEDC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518E82186A
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SOVljHUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730797AbfHZUow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 16:44:52 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45823 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728694AbfHZUou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 16:44:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id q12so16555356wrj.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 13:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SZT7LwQ4zVm6UpU1R0QaKTwCzMI6AEH9QZz6xkZt/VY=;
        b=SOVljHUU8N7UbYj/cOCqgEomKmgW/J60GyZGE8TlJHFlEQP3S8H5JbmKJRln4V8uTH
         1wmjcjxn/otSmTYMMbHHqk9cpXO+iunSYYqnkeDJFnZrbagQOcDvaYvDvTSuCkGdobYH
         yPdEdjfRf6YWiDbWw1rcR4Xbnt+xZQDzSLOJ8+NCTjg8G6U1uArrZc6VWR7N2eiz78O8
         OLrmN2VVwjDWJN9bIz+7NwHo+JPHDfW9WOQ/cQXIiT4ozFmPGQjrtNYzUU9q0dF2RvPz
         fmrQAxhgz9q1XKjICu+OBZQTaq9AJl3SQ+jbS2GjyferSwq0iMEqajyG2HyIPnOs0OVR
         eKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SZT7LwQ4zVm6UpU1R0QaKTwCzMI6AEH9QZz6xkZt/VY=;
        b=tMLlGMzRaOMR0K1dlg1wOL9Xlbuvnd+hax4Sn1CWEWwM6VmBD3gI3vpLmuWMAMu0tQ
         ZquC1tOxvwmeXmS6N1gpjTvq0Rw61KJaapAV4FKS62c6HSyF1qGb04W1J2MFxrP7G6WY
         9vNQGl7ctfpqXfTT04aIdEzECRrfp4SD5loTwwWXb5mNgX7r6Qv6LKSzJa9N2d2gUM3n
         /r4gAZiN/lpqfiEqzvH7Oc9U/nPhfuuyU4E9fNC81gRbjM5aFWn6mm/cmdJcWm5CES7s
         Ona/Nfpja5KlStkRzn3G3VAxLkHUQRpGOpBBMjy3P8P1sR0JJCh4bPbArawj+XHNq/EI
         ubOA==
X-Gm-Message-State: APjAAAWqx6uvcXdV9x5hUutepjlJR1jPRfrBi1YKpdNYrkltGhr1lcbN
        58MJ3b8J12IN3uFuPsIlyGfDiQ==
X-Google-Smtp-Source: APXvYqwdwUCw5aUqZelDvNyEgt4T4jxvKT/tVakrpiJfZDKLHDs0Lltb+i/VwDXc0av0TDel5R/6Gg==
X-Received: by 2002:adf:e5cd:: with SMTP id a13mr23978628wrn.316.1566852288125;
        Mon, 26 Aug 2019 13:44:48 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:f881:f5ed:b15d:96ab])
        by smtp.gmail.com with ESMTPSA id 20sm549557wmk.34.2019.08.26.13.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 13:44:47 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support)
Subject: [PATCH 05/20] dt-bindings: timer: Convert Allwinner A13 HSTimer to a schema
Date:   Mon, 26 Aug 2019 22:43:52 +0200
Message-Id: <20190826204407.17759-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190826204407.17759-1-daniel.lezcano@linaro.org>
References: <df27caba-d9f8-e64d-0563-609f8785ecb3@linaro.org>
 <20190826204407.17759-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

The newer Allwinner SoCs have a High Speed Timer supported in Linux, with a
matching Device Tree binding.

Now that we have the DT validation in place, let's convert the device tree
bindings for that controller over to a YAML schemas.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../timer/allwinner,sun5i-a13-hstimer.txt     | 26 ------
 .../timer/allwinner,sun5i-a13-hstimer.yaml    | 79 +++++++++++++++++++
 2 files changed, 79 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/allwinner,sun5i-a13-hstimer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/allwinner,sun5i-a13-hstimer.yaml

diff --git a/Documentation/devicetree/bindings/timer/allwinner,sun5i-a13-hstimer.txt b/Documentation/devicetree/bindings/timer/allwinner,sun5i-a13-hstimer.txt
deleted file mode 100644
index 2c5c1be78360..000000000000
--- a/Documentation/devicetree/bindings/timer/allwinner,sun5i-a13-hstimer.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-Allwinner SoCs High Speed Timer Controller
-
-Required properties:
-
-- compatible :	should be "allwinner,sun5i-a13-hstimer" or
-		"allwinner,sun7i-a20-hstimer"
-- reg : Specifies base physical address and size of the registers.
-- interrupts :	The interrupts of these timers (2 for the sun5i IP, 4 for the sun7i
-		one)
-- clocks: phandle to the source clock (usually the AHB clock)
-
-Optional properties:
-- resets: phandle to a reset controller asserting the timer
-
-Example:
-
-timer@1c60000 {
-	compatible = "allwinner,sun7i-a20-hstimer";
-	reg = <0x01c60000 0x1000>;
-	interrupts = <0 51 1>,
-		     <0 52 1>,
-		     <0 53 1>,
-		     <0 54 1>;
-	clocks = <&ahb1_gates 19>;
-	resets = <&ahb1rst 19>;
-};
diff --git a/Documentation/devicetree/bindings/timer/allwinner,sun5i-a13-hstimer.yaml b/Documentation/devicetree/bindings/timer/allwinner,sun5i-a13-hstimer.yaml
new file mode 100644
index 000000000000..dfa0c41fd261
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/allwinner,sun5i-a13-hstimer.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/allwinner,sun5i-a13-hstimer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner A13 High-Speed Timer Device Tree Bindings
+
+maintainers:
+  - Chen-Yu Tsai <wens@csie.org>
+  - Maxime Ripard <maxime.ripard@bootlin.com>
+
+properties:
+  compatible:
+    oneOf:
+      - const: allwinner,sun5i-a13-hstimer
+      - const: allwinner,sun7i-a20-hstimer
+      - items:
+          - const: allwinner,sun6i-a31-hstimer
+          - const: allwinner,sun7i-a20-hstimer
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 2
+    maxItems: 4
+    items:
+      - description: Timer 0 Interrupt
+      - description: Timer 1 Interrupt
+      - description: Timer 2 Interrupt
+      - description: Timer 3 Interrupt
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+if:
+  properties:
+    compatible:
+      items:
+        const: allwinner,sun5i-a13-hstimer
+
+then:
+  properties:
+    interrupts:
+      minItems: 2
+      maxItems: 2
+
+else:
+  properties:
+    interrupts:
+      minItems: 4
+      maxItems: 4
+
+additionalProperties: false
+
+examples:
+  - |
+    timer@1c60000 {
+        compatible = "allwinner,sun7i-a20-hstimer";
+        reg = <0x01c60000 0x1000>;
+        interrupts = <0 51 1>,
+                     <0 52 1>,
+                     <0 53 1>,
+                     <0 54 1>;
+        clocks = <&ahb1_gates 19>;
+        resets = <&ahb1rst 19>;
+    };
+
+...
-- 
2.17.1

