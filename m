Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BC9C4646B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E5420679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561413565;
	bh=q8pjBWdYxq0srnhI81nirqYyIYx69qauVVYcH1vaTOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=svfwnvIHFmQRkmqrnXcqjZ86IKa5wCZdYXN7p9UjplDfuPDNBu1U6wxoRSJhmhfl6
	 0f8iFz6/nPDLFIkMxPl8zknyo7JVtmM214caz72TI7ir7f7yE41f46Vzb8daarxcck
	 0fdsv6zO9WTu5X/3g0wKb/tvkPfQ/CkPd18uPTM0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732830AbfFXV7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 17:59:23 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37384 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732744AbfFXV7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 17:59:14 -0400
Received: by mail-io1-f66.google.com with SMTP id e5so506980iok.4;
        Mon, 24 Jun 2019 14:59:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Z2UKVw9wR+nM3C1smoMCBCX/v7ccCU9RTU41ZXWQi8=;
        b=SpTtogjqmN4bX90q7b/DuB8p4t9Aa5kgHgv9CuQIoLi1eZCHDYyfc7tWQIsijmsRLf
         at2AIwar/FWOCnwv61RpfY0s6ZKckNJNvGoqpbjBNgUO/XxiCJmC1bYxIJhB8kyTGnGW
         HTvyEH/8zcKY329aKy2FWuWDa8uwZL5VfhzpJGYNF1pqntXfA+KFsEWteb3eJSV5WsIF
         H0AOBKjGa/piA0oq7tdOt4v+ZouncQH4WJHOFXJr19QDu8914hxLW6cE4QJE4Wv8hzL0
         vdHoUFNqoYdakhQidq7qNTdXpWXGkWEewmx0vbGoqRLn4/pWxUJ/A8cDtypvb9V3wgkV
         JBvg==
X-Gm-Message-State: APjAAAX81Ni40xnlGmKMNJpVUZaZmecGSGXMfStTtC9oV4ILX/tisSHi
        jIq/CrDJjfqld093M1F0Mw==
X-Google-Smtp-Source: APXvYqz4/GP+MyoLRLqLyf+EfgB01ytAxMuglaUHIpjWgp3O1dZXc/ovMwdd6jaOTzBArO/d04AgQg==
X-Received: by 2002:a6b:f00c:: with SMTP id w12mr4135540ioc.280.1561413553707;
        Mon, 24 Jun 2019 14:59:13 -0700 (PDT)
Received: from localhost.localdomain ([64.188.179.247])
        by smtp.googlemail.com with ESMTPSA id l5sm14717301ioq.83.2019.06.24.14.59.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 14:59:13 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 14/15] dt-bindings: display: Convert mitsubishi,aa121td01 panel to DT schema
Date:   Mon, 24 Jun 2019 15:56:48 -0600
Message-Id: <20190624215649.8939-15-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624215649.8939-1-robh@kernel.org>
References: <20190624215649.8939-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the mitsubishi,aa121td01 LVDS panel binding to DT schema.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../display/panel/mitsubishi,aa121td01.txt    | 47 -------------
 .../display/panel/mitsubishi,aa121td01.yaml   | 69 +++++++++++++++++++
 2 files changed, 69 insertions(+), 47 deletions(-)
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
index 000000000000..68750d8f0aef
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/mitsubishi,aa121td01.yaml
@@ -0,0 +1,69 @@
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

