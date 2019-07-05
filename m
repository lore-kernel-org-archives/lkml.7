Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26578C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007D921670
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562344971;
	bh=+/TRA4ZE0VpuBt0YbfIfwwsfBeHJldqeMe5lH0AzjGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M3ryg/7cPyhe1VlHxX0VhbKp179UBhDiqGZajr3k4cQkqkSc/WlSGWeAlnfrtpnVT
	 v9YQg/4yRRo0w6y9DLq1EBCsTCIoudxc3yVlZ/lzcGKeDT1NtkjookIx7CRZTmFHb2
	 FspdmDFUuzAOOgCb1qmAul6QyZnRyO9vxreYWkVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbfGEQmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 12:42:49 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44485 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728758AbfGEQmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 12:42:46 -0400
Received: by mail-io1-f66.google.com with SMTP id s7so20320375iob.11;
        Fri, 05 Jul 2019 09:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4u+6qapxeTisjBjV1LDNg1dP2Dk7yZmXQTbzF8olw5A=;
        b=bjrdAMJPXxajh2jSDx5707slvz+MXBGgG4xqETDNMQPhRcaUpm25lAhNYtsTB7t7J4
         GtyhbZgTZ3jx1r3mpwttaK5Q/eBvzkHw3AWuSXLb11FSWcIaguG4nDYqRkxz6LvG/+wS
         zGVgOjeTHKIvRro1pg+B8aqrm0HJIap6duFponqqu6UvlH/U0RjwZcukIqOK/jQLSViU
         L25MtsXqxCmS7JlRGrNeMjbIKc+8iWyIKXw6teEwO3bDy1NnNN2rXxZ6JIbE/CQ6r+pN
         dI52zsYD3vjU4AahMH4Pvm3VEJ2eLumGLN92A+HfyK/0vUrtfprnh3AFAwnl2vKFIpvY
         QyYg==
X-Gm-Message-State: APjAAAW8i6BzoiCmL7vIo7Jqap5gfcVdIRK4aPaQHWNPDM1ibS7R0Ky1
        hauWPsrGj4hcPp3mSjgTL9imBBA=
X-Google-Smtp-Source: APXvYqxz2DHGPlJxRSIxbizb1JVeLUdXDwOC9XowLkLz/SOUbfeAE6k57d3jmFM/zcbiN3zywcoRbg==
X-Received: by 2002:a02:c519:: with SMTP id s25mr5497475jam.11.1562344965673;
        Fri, 05 Jul 2019 09:42:45 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id b8sm6878104ioj.16.2019.07.05.09.42.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 09:42:45 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v3 13/13] dt-bindings: display: Convert sgd,gktw70sdae4se panel to DT schema
Date:   Fri,  5 Jul 2019 10:42:21 -0600
Message-Id: <20190705164221.4462-14-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190705164221.4462-1-robh@kernel.org>
References: <20190705164221.4462-1-robh@kernel.org>
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
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../display/panel/sgd,gktw70sdae4se.txt       | 41 -----------
 .../display/panel/sgd,gktw70sdae4se.yaml      | 68 +++++++++++++++++++
 2 files changed, 68 insertions(+), 41 deletions(-)
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
index 000000000000..e63a570ae59d
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/sgd,gktw70sdae4se.yaml
@@ -0,0 +1,68 @@
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
+  panel-timing: true
+  port: true
+
+additionalProperties: false
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

