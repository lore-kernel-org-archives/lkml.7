Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D79C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC022184C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562344976;
	bh=qzVTyKbX1nPMZzNX8Fdk+RzS3ee8slYM37DhhqKvil8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JM7YuXZbHVUi3RWuHYLTP0D4tVfQr/c9NerwXpstiXbh6G5H8rIXT0oh8kerm4/Rg
	 Ve3Zvaz4tcYlXCwWO2qeTMPEZgMRzcp/uSEBKOJrp0oHPZnAwPHe+qpB8mf9mXr8Jz
	 QJXbgP4UkYDDySCblEeQStGFJbZUsCMAFisAtMGs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbfGEQmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 12:42:55 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40810 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728717AbfGEQmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 12:42:45 -0400
Received: by mail-io1-f66.google.com with SMTP id h6so12149007iom.7;
        Fri, 05 Jul 2019 09:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MqMTUG9wusta6WwgMcwAagT6tLykgnN6pCm15C73X54=;
        b=HUrfvMgbbMl0LQ71ILYM/w+HxyVtR1Qejec+w5c3IWWPZiklCxTB4HB8Yepwjh++S3
         uvSis1SXt5OVwDd6rVM5JMmlkvj7a0czxei22ngQQrccJiLvoEPnQ1Oqk+MhKCoenaBH
         tyFLGt8pLhWZC8mzJAFSwOI1Ws4NAG2ebBjrQezUSA2QQQLDYHCkc0HH64QAGtfSQhAx
         PbLEPhZvJ3RKTqrhSX/ZZ+UpK4hdB5z7WpDW0PfT/SVDekNdgEBPkGa/DL0sJLS3hGWP
         a1a+kpkuUS0nrR9sPOryWPy5lMJWlGjZPI9aLGu2b1uc7+pqo0HEQbLTsRQL1dncCwxe
         hGTw==
X-Gm-Message-State: APjAAAVsqDpzwVF3XxKHrM3kZOQBEhLvlMyKpAbGomViMb34sg4Z11w0
        jVkK6cFWLH90YwwinrGRPQ==
X-Google-Smtp-Source: APXvYqyeO0Feku3Dh4QSAhvGAZcLWY6JzL35SHPz0t/l0RTaN5lVtg8E4+5yYF5hJ9zRAPpPce3bHg==
X-Received: by 2002:a5e:8913:: with SMTP id k19mr4963873ioj.155.1562344964310;
        Fri, 05 Jul 2019 09:42:44 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id b8sm6878104ioj.16.2019.07.05.09.42.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 09:42:43 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v3 12/13] dt-bindings: display: Convert mitsubishi,aa121td01 panel to DT schema
Date:   Fri,  5 Jul 2019 10:42:20 -0600
Message-Id: <20190705164221.4462-13-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190705164221.4462-1-robh@kernel.org>
References: <20190705164221.4462-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the mitsubishi,aa121td01 LVDS panel binding to DT schema.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../display/panel/mitsubishi,aa121td01.txt    | 47 ------------
 .../display/panel/mitsubishi,aa121td01.yaml   | 74 +++++++++++++++++++
 2 files changed, 74 insertions(+), 47 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/mitsubishi,aa121td01.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/mitsubishi,aa121td01.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/mitsubishi,aa121td01.txt b/Documentation/devicetree/bindings/display/panel/mitsubishi,aa121td01.txt
deleted file mode 100644
index d6e1097504fe..000000000000
--- a/Documentation/devicetree/bindings/display/panel/mitsubishi,aa121td01.txt
+++ /dev/null
@@ -1,47 +0,0 @@
-Mitsubishi AA121TD01 LVDS Display Panel
-=======================================
-
-The AA121TD01 is a 12.1" WXGA TFT-LCD display panel.
-
-These DT bindings follow the LVDS panel bindings defined in panel-lvds.txt
-with the following device-specific properties.
-
-
-Required properties:
-
-- compatible: Shall contain "mitsubishi,aa121td01" and "panel-lvds", in that
-  order.
-- vcc-supply: Reference to the regulator powering the panel VCC pins.
-
-
-Example
--------
-
-panel {
-	compatible = "mitsubishi,aa121td01", "panel-lvds";
-	vcc-supply = <&vcc_3v3>;
-
-	width-mm = <261>;
-	height-mm = <163>;
-
-	data-mapping = "jeida-24";
-
-	panel-timing {
-		/* 1280x800 @60Hz */
-		clock-frequency = <71000000>;
-		hactive = <1280>;
-		vactive = <800>;
-		hsync-len = <70>;
-		hfront-porch = <20>;
-		hback-porch = <70>;
-		vsync-len = <5>;
-		vfront-porch = <3>;
-		vback-porch = <15>;
-	};
-
-	port {
-		panel_in: endpoint {
-			remote-endpoint = <&lvds_encoder>;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/display/panel/mitsubishi,aa121td01.yaml b/Documentation/devicetree/bindings/display/panel/mitsubishi,aa121td01.yaml
new file mode 100644
index 000000000000..977c50a85b67
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/mitsubishi,aa121td01.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/mitsubishi,aa121td01.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mitsubishi AA121TD01 12.1" WXGA LVDS Display Panel
+
+maintainers:
+  - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+  - Thierry Reding <thierry.reding@gmail.com>
+
+allOf:
+  - $ref: lvds.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: mitsubishi,aa121td01
+      - {} # panel-lvds, but not listed here to avoid false select
+
+  vcc-supply:
+    description: Reference to the regulator powering the panel VCC pins.
+
+  data-mapping:
+    const: jeida-24
+
+  width-mm:
+    const: 261
+
+  height-mm:
+    const: 163
+
+  panel-timing: true
+  port: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - vcc-supply
+
+examples:
+  - |+
+    panel {
+      compatible = "mitsubishi,aa121td01", "panel-lvds";
+      vcc-supply = <&vcc_3v3>;
+
+      width-mm = <261>;
+      height-mm = <163>;
+
+      data-mapping = "jeida-24";
+
+      panel-timing {
+        /* 1280x800 @60Hz */
+        clock-frequency = <71000000>;
+        hactive = <1280>;
+        vactive = <800>;
+        hsync-len = <70>;
+        hfront-porch = <20>;
+        hback-porch = <70>;
+        vsync-len = <5>;
+        vfront-porch = <3>;
+        vback-porch = <15>;
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

