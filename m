Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79A9C43613
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 21:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3E821721
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 21:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560981138;
	bh=urZJK504KW8i0CCEmlesyUZmxKFCIwn6WTEdzPvLXUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b87E03YAB427GIXcnl5HUDov4AdjKWUnptA0yrf0eBAyg0HXeh9LjAHTlQbFpBRKI
	 5MymsZC+mYpJ0spMdAJImYPVj/KOQzrpr0eIqXiUA36Iafg1ANvJ18DvZAdE1EDS46
	 E2Bdqhm7dYsAm+wytdMg5kxEx3fatToRamVZnQzw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730800AbfFSVwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 17:52:17 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33452 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730616AbfFSVwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 17:52:02 -0400
Received: by mail-io1-f67.google.com with SMTP id u13so1248961iop.0;
        Wed, 19 Jun 2019 14:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/7RNl0V1WoARVRD/RxLj0SbJgldmEVIr2syT8aiqqBI=;
        b=XfxLaYAiI5x8hAnBhocjZm90A9Lg/0CTPLwCsTsgdAANDvmwRPCKJUfOGYAkZXaNmn
         IeaUEq2k1IVGrBYoQm1o4hx1xdNs0mQlUPVAMY1BlV92rIdHeLcCvgyOmqU594gPrj4s
         8/9M+Sr0dBxCxIzbV+6iZUhtw4eBzD87q12Oqqa0ewKjryEQ+i1z4f9hdhNWbBB0cp68
         L1CbkPd3hzlWCFmxbiaw9hSYPfvTFCIYn0TztdNVTPH3yZyzQhVhJpcjsMBQBz0jg6GL
         QezRKWE/fudI7t/0Y8yKVtP5fnqXc3/UeyRzuC4i1/urnZmeQbDhw0QMuuToOx2tD/Mm
         XeXQ==
X-Gm-Message-State: APjAAAWBjY9YmLevzTfxahlqaef2f++wSAcwr+gfo5oa2GHehI9Sc/c7
        OIZpfIGwhXrmDFlkO0U6rw==
X-Google-Smtp-Source: APXvYqwsCLCHHve5YFnB7Eegl0JTw/80pFtx6JeAxTQ67f75e5Qj4mCBLH4/9MyYF/LdnVCfkHlSJw==
X-Received: by 2002:a5d:94d0:: with SMTP id y16mr42777142ior.123.1560981121583;
        Wed, 19 Jun 2019 14:52:01 -0700 (PDT)
Received: from localhost.localdomain ([64.188.179.247])
        by smtp.googlemail.com with ESMTPSA id e84sm37754698iof.39.2019.06.19.14.52.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 14:52:01 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [RFC PATCH 2/4] dt-bindings: display: Convert ampire,am-480272h3tmqw-t01h panel to DT schema
Date:   Wed, 19 Jun 2019 15:51:54 -0600
Message-Id: <20190619215156.27795-2-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190619215156.27795-1-robh@kernel.org>
References: <20190619215156.27795-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the ampire,am-480272h3tmqw-t01h panel binding to DT schema.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../panel/ampire,am-480272h3tmqw-t01h.txt     | 26 ------------
 .../panel/ampire,am-480272h3tmqw-t01h.yaml    | 41 +++++++++++++++++++
 2 files changed, 41 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt b/Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt
deleted file mode 100644
index 6812280cb109..000000000000
--- a/Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-Ampire AM-480272H3TMQW-T01H 4.3" WQVGA TFT LCD panel
-
-This binding is compatible with the simple-panel binding, which is specified
-in simple-panel.txt in this directory.
-
-Required properties:
-- compatible: should be "ampire,am-480272h3tmqw-t01h"
-
-Optional properties:
-- power-supply: regulator to provide the supply voltage
-- enable-gpios: GPIO pin to enable or disable the panel
-- backlight: phandle of the backlight device attached to the panel
-
-Optional nodes:
-- Video port for RGB input.
-
-Example:
-	panel_rgb: panel-rgb {
-		compatible = "ampire,am-480272h3tmqw-t01h";
-		enable-gpios = <&gpioa 8 1>;
-		port {
-			panel_in_rgb: endpoint {
-				remote-endpoint = <&controller_out_rgb>;
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.yaml b/Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.yaml
new file mode 100644
index 000000000000..cc2f6ec6ebf6
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/ampire,am-480272h3tmqw-t01h.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ampire AM-480272H3TMQW-T01H 4.3" WQVGA TFT LCD panel
+
+maintainers:
+  - Thierry Reding <treding@nvidia.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: ampire,am-480272h3tmqw-t01h
+
+  power-supply: true
+  enable-gpios: true
+  backlight: true
+  port: true
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    panel_rgb: panel {
+      compatible = "ampire,am-480272h3tmqw-t01h";
+      enable-gpios = <&gpioa 8 1>;
+      port {
+        panel_in_rgb: endpoint {
+          remote-endpoint = <&controller_out_rgb>;
+        };
+      };
+    };
+
+...
-- 
2.20.1

