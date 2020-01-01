Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73847C2D0DC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 11:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 405C0206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 11:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="IXadCyul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgAALZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 06:25:19 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37319 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgAALZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 06:25:18 -0500
Received: by mail-pg1-f194.google.com with SMTP id q127so20540252pga.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 03:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xyLN4iY9zmJMkQfktKnQpRiD7IFHvGjo95ULoKZuL/c=;
        b=IXadCyul++yY5mPG22iSFOMQRK+KL5L9ALKOUeFfEH4nm+B5LBFbNpcHQb3/HrwRg3
         ZhVM3dPBunkPVLHx63K2jTaoz74vOIFPiBSyqo35wKbNw4jZSy51Nz9YgQcWRY0D54vv
         i+lN4Nxnt1ydsCzbq+6FROXZ/vibC0ATowOjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xyLN4iY9zmJMkQfktKnQpRiD7IFHvGjo95ULoKZuL/c=;
        b=KCOrK7eZQ4CC89v9cMeDqhPWZWwsAXFWg09p8ZbOMAXgg/1hfPcyzv64uYVNFS0zfV
         yDqcUS/4U4JzWxk8vOk6e7VXm/3TvbWLr7dhhWqPMEh0tsKj65wM+0M7Vb/BSAD6QSMq
         aufsBsKamH6L5CavBq8JX4ASn6MXGUbnTU+6hwU21nqAzKjF4mWbOyT489os61TQIHwe
         9hGFyDPri579dZIFxfdatgX5aDFW8cNVuIOMyUL8dCEUE8lu96pobLssK/uZjVv/h18w
         oLMAZ40+eHNIZlFp3dI15ozHHdvq05l9enGuASYy8I3sKkJCRF86X8+6tw9wy1dMcoJL
         RRAQ==
X-Gm-Message-State: APjAAAXvwFDGAdATG7B1NPgZNaDnOULc88/ggyIRjpuMT6lI+WMd9q+1
        eziYe+nLsQRWdDsE9DFbQr5dcg==
X-Google-Smtp-Source: APXvYqzJsxHKB6CYiuv0K6eWz0RNBAElBtDwT3PR+UKjW90HgavORgR7YgQVx/CpMu50nzTTp1RO7g==
X-Received: by 2002:a62:3343:: with SMTP id z64mr80281149pfz.150.1577877917923;
        Wed, 01 Jan 2020 03:25:17 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c809:c7d5:d0fe:8978:1b04:ff94])
        by smtp.gmail.com with ESMTPSA id y7sm51945439pfb.139.2020.01.01.03.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 03:25:17 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 2/6] dt-bindings: display: panel: Convert sitronix,st7701 to DT schema
Date:   Wed,  1 Jan 2020 16:54:40 +0530
Message-Id: <20200101112444.16250-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20200101112444.16250-1-jagan@amarulasolutions.com>
References: <20200101112444.16250-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the sitronix,st7701 panel bindings to DT schema.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../display/panel/sitronix,st7701.txt         | 30 ---------
 .../display/panel/sitronix,st7701.yaml        | 61 +++++++++++++++++++
 2 files changed, 61 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/sitronix,st7701.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,st7701.txt b/Documentation/devicetree/bindings/display/panel/sitronix,st7701.txt
deleted file mode 100644
index ccd17597f1f6..000000000000
--- a/Documentation/devicetree/bindings/display/panel/sitronix,st7701.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-Sitronix ST7701 based LCD panels
-
-ST7701 designed for small and medium sizes of TFT LCD display, is
-capable of supporting up to 480RGBX864 in resolution. It provides
-several system interfaces like MIPI/RGB/SPI.
-
-Techstar TS8550B is 480x854, 2-lane MIPI DSI LCD panel which has
-inbuilt ST7701 chip.
-
-Required properties:
-- compatible: must be "sitronix,st7701" and one of
-  * "techstar,ts8550b"
-- reset-gpios: a GPIO phandle for the reset pin
-
-Required properties for techstar,ts8550b:
-- reg: DSI virtual channel used by that screen
-- VCC-supply: analog regulator for MIPI circuit
-- IOVCC-supply: I/O system regulator
-
-Optional properties:
-- backlight: phandle for the backlight control.
-
-panel@0 {
-	compatible = "techstar,ts8550b", "sitronix,st7701";
-	reg = <0>;
-	VCC-supply = <&reg_dldo2>;
-	IOVCC-supply = <&reg_dldo2>;
-	reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* LCD-RST: PD24 */
-	backlight = <&backlight>;
-};
diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml b/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml
new file mode 100644
index 000000000000..49e4b54ecf7c
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0+ OR X11)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/sitronix,st7701.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sitronix ST7701 based LCD panels
+
+maintainers:
+  - Jagan Teki <jagan@amarulasolutions.com>
+
+description: |
+  ST7701 designed for small and medium sizes of TFT LCD display, is
+  capable of supporting up to 480RGBX864 in resolution. It provides
+  several system interfaces like MIPI/RGB/SPI.
+
+  Techstar TS8550B is 480x854, 2-lane MIPI DSI LCD panel which has
+  inbuilt ST7701 chip.
+
+properties:
+  compatible:
+    oneOf:
+      - const: sitronix,st7701
+      - items:
+          - const: techstar,ts8550b
+
+  reg:
+    description: DSI virtual channel used by that screen
+
+  VCC-supply:
+    description: analog regulator for MIPI circuit
+
+  IOVCC-supply:
+    description: I/O system regulator
+
+  reset-gpios:
+    description: a GPIO phandle for the reset pin
+
+  backlight:
+    description: Backlight used by the panel
+    $ref: "/schemas/types.yaml#/definitions/phandle"
+
+required:
+  - compatible
+  - reg
+  - VCC-supply
+  - IOVCC-supply
+  - reset-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    panel@0 {
+            compatible = "techstar,ts8550b", "sitronix,st7701";
+            reg = <0>;
+            VCC-supply = <&reg_dldo2>;
+            IOVCC-supply = <&reg_dldo2>;
+            reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* LCD-RST: PD24 */
+            backlight = <&backlight>;
+    };
-- 
2.18.0.321.gffc6fa0e3

