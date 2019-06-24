Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99150C4646B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF8520820
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561413572;
	bh=ibdI3MOYXze5+qtScGOonZd47xurIBeNQtJRLtSZksI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yH/ZNx2+P5DW5/JLyFcS4cuidFTqYAXUuSrgtEOy3ZcP8iOIKPwcRsglLnpw9Aaq6
	 QY3s/zX14+Mkc7uP5mnqfBTUFbww+jCYGa2kG0ml+k5OiaVioEmIm9A0U6G7k+8Ofa
	 AOxSCPHtSvRtX6Cy7w7aYNx5Rz5V59pXARf77tIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732836AbfFXV7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 17:59:30 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44919 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732758AbfFXV7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 17:59:16 -0400
Received: by mail-io1-f66.google.com with SMTP id s7so375238iob.11;
        Mon, 24 Jun 2019 14:59:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yESbo+i10idiBFWz3etXGo6XCmb8EOHmWEtPPGEz5fg=;
        b=MJPnPFcx3FT6k1/keLY2A9rCgikbC5T3SIjQxbrf2+agyaGbfMJIkU+fl9h+At/N14
         7jfSniV79nby1EZwcQ1gcyWD+VIrw2OdpBEQvD0CMsPWIe78CTZHV/OhyzJHsCwufz0t
         oZbYlvkkIMqahkhbUUfkHBBC9WL6HZMJ/wEQUN3zcaRg9Tsq7t+fCk5DpvKT1b83M1Iu
         5zAUGj9vgibc+3ysKZ2WgNBGp8FEtzKhFjSHMrXjMqFZ7txMr/eD11L4DUv25V3SsXcL
         2+aO6xbgIuEWucueJLLmo8Gjp6ILDGa1iw1MhGp1+j4D1YleWI7NIHwZMtrzjTqFAmRT
         g0uw==
X-Gm-Message-State: APjAAAWPuiYCUf3ibpqqdD/GOfgjKEZyOyVkuUw4st8rRwbzIeuzTVev
        IB6DaopZkLB6w3k5B4DOhw==
X-Google-Smtp-Source: APXvYqzx4ePf7Uty9RR9tYKGcckhJ+bYViFIXE+QeRd8I8EaUvtcw0Nt5XfARxGLI3Ds4h7wBvKfOA==
X-Received: by 2002:a6b:4e08:: with SMTP id c8mr33071155iob.217.1561413554728;
        Mon, 24 Jun 2019 14:59:14 -0700 (PDT)
Received: from localhost.localdomain ([64.188.179.247])
        by smtp.googlemail.com with ESMTPSA id l5sm14717301ioq.83.2019.06.24.14.59.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 14:59:14 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 15/15] dt-bindings: display: Convert sgd,gktw70sdae4se panel to DT schema
Date:   Mon, 24 Jun 2019 15:56:49 -0600
Message-Id: <20190624215649.8939-16-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624215649.8939-1-robh@kernel.org>
References: <20190624215649.8939-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the sgd,gktw70sdae4se LVDS panel binding to DT schema.

Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../display/panel/sgd,gktw70sdae4se.txt       | 41 ------------
 .../display/panel/sgd,gktw70sdae4se.yaml      | 63 +++++++++++++++++++
 2 files changed, 63 insertions(+), 41 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/sgd,gktw70sdae4se.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/sgd,gktw70sdae4se.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/sgd,gktw70sdae4se.txt b/Documentation/devicetree/bindings/display/panel/sgd,gktw70sdae4se.txt
deleted file mode 100644
index d06644b555bd..000000000000
--- a/Documentation/devicetree/bindings/display/panel/sgd,gktw70sdae4se.txt
+++ /dev/null
@@ -1,41 +0,0 @@
-Solomon Goldentek Display GKTW70SDAE4SE LVDS Display Panel
-==========================================================
-
-The GKTW70SDAE4SE is a 7" WVGA TFT-LCD display panel.
-
-These DT bindings follow the LVDS panel bindings defined in panel-lvds.txt
-with the following device-specific properties.
-
-Required properties:
-
-- compatible: Shall contain "sgd,gktw70sdae4se" and "panel-lvds", in that order.
-
-Example
--------
-
-panel {
-	compatible = "sgd,gktw70sdae4se", "panel-lvds";
-
-	width-mm = <153>;
-	height-mm = <86>;
-
-	data-mapping = "jeida-18";
-
-	panel-timing {
-		clock-frequency = <32000000>;
-		hactive = <800>;
-		vactive = <480>;
-		hback-porch = <39>;
-		hfront-porch = <39>;
-		vback-porch = <29>;
-		vfront-porch = <13>;
-		hsync-len = <47>;
-		vsync-len = <2>;
-	};
-
-	port {
-		panel_in: endpoint {
-			remote-endpoint = <&lvds_encoder>;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/display/panel/sgd,gktw70sdae4se.yaml b/Documentation/devicetree/bindings/display/panel/sgd,gktw70sdae4se.yaml
new file mode 100644
index 000000000000..487283288cb0
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/sgd,gktw70sdae4se.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/sgd,gktw70sdae4se.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Solomon Goldentek Display GKTW70SDAE4SE 7" WVGA LVDS Display Panel
+
+maintainers:
+  - Neil Armstrong <narmstrong@baylibre.com>
+  - Thierry Reding <thierry.reding@gmail.com>
+
+allOf:
+  - $ref: lvds.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: sgd,gktw70sdae4se
+      - {} # panel-lvds, but not listed here to avoid false select
+
+  data-mapping:
+    const: jeida-18
+
+  width-mm:
+    const: 153
+
+  height-mm:
+    const: 86
+
+required:
+  - compatible
+
+examples:
+  - |+
+    panel {
+      compatible = "sgd,gktw70sdae4se", "panel-lvds";
+
+      width-mm = <153>;
+      height-mm = <86>;
+
+      data-mapping = "jeida-18";
+
+      panel-timing {
+        clock-frequency = <32000000>;
+        hactive = <800>;
+        vactive = <480>;
+        hback-porch = <39>;
+        hfront-porch = <39>;
+        vback-porch = <29>;
+        vfront-porch = <13>;
+        hsync-len = <47>;
+        vsync-len = <2>;
+      };
+
+      port {
+        panel_in: endpoint {
+          remote-endpoint = <&lvds_encoder>;
+        };
+      };
+    };
+
+...
-- 
2.20.1

