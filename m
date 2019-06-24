Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC585C4646C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7B420679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561413561;
	bh=8sn+cn0TEQ5n2b0dTZBLUWdp6bREikHw+vM0Uq8Ba2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2fXa0Q0i/EIMR8YxCvluKFMTv40hOmrxFpnXcupNF/mSK1t0S8Kn577tC1FXGSaw1
	 yV2nRr0ae44eCHFw5cy6aqteHHaYp+7RDBojtXootCtpXfR3ufb704+umVeSrIZM2A
	 ObYnusiF9McSAd86gXTy6ThnLA5waoMEajKJU7Ik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732802AbfFXV7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 17:59:20 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40537 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732735AbfFXV7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 17:59:14 -0400
Received: by mail-io1-f65.google.com with SMTP id n5so295287ioc.7;
        Mon, 24 Jun 2019 14:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GFdFvbsDhPtM+T2pPl7/SqcPeksqsAg2JuxBKixkKqA=;
        b=ckZ+F9gRBy+Z4LdsBZXYAF2bGbUE6B42RjZu+dyNleHbb4UL6v+1V/gVPNf9/e2riI
         iKV7HlcqWaTJ6g0LGIs6nkn7H6HVx6NP5+nYB0fiTg1kae6rMngXaQ9VsDQTm6fHjOzs
         r3qi9owLRAdZLPn5joJFFQ6aLMO/wIwljAeXPdYUcfULGslwcXZB3g7Iabf0BPsrIdLy
         d9eS5ywfDRGqTD8FlCfNUHzWZCGY0iG8QNUwYxCA1Pinm4lOhl9JcyTwFBLJ8KUYhaWj
         pHLml+0ls+OOjPXKMoYENKKLFsBi5ooDJmr3Y7dWX3R2GdB9KYLzl9KUgxG2jeBIZpsO
         UmNg==
X-Gm-Message-State: APjAAAXJdLu+/0bY3r3KHRPoTeUkpU95zvE7inKyFOiQQPQtkSZLd0SY
        uv7/r3vix+3tP9lXvaXiGg==
X-Google-Smtp-Source: APXvYqz4z7NFFYDhtVQpl8EPWt5X5N0Iq8pgDY+KI6VQqCXvwLeDMNrwgcxxQgrvQkuxUzc+XprBOQ==
X-Received: by 2002:a5d:904e:: with SMTP id v14mr22328731ioq.61.1561413552627;
        Mon, 24 Jun 2019 14:59:12 -0700 (PDT)
Received: from localhost.localdomain ([64.188.179.247])
        by smtp.googlemail.com with ESMTPSA id l5sm14717301ioq.83.2019.06.24.14.59.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 14:59:12 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 13/15] dt-bindings: display: Convert mitsubishi,aa104xd12 panel to DT schema
Date:   Mon, 24 Jun 2019 15:56:47 -0600
Message-Id: <20190624215649.8939-14-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624215649.8939-1-robh@kernel.org>
References: <20190624215649.8939-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the mitsubishi,aa104xd12 LVDS panel binding to DT schema.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../display/panel/mitsubishi,aa104xd12.txt    | 47 ------------
 .../display/panel/mitsubishi,aa104xd12.yaml   | 71 +++++++++++++++++++
 2 files changed, 71 insertions(+), 47 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/mitsubishi,aa104xd12.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/mitsubishi,aa104xd12.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/mitsubishi,aa104xd12.txt b/Documentation/devicetree/bindings/display/panel/mitsubishi,aa104xd12.txt
deleted file mode 100644
index ced0121aed7d..000000000000
--- a/Documentation/devicetree/bindings/display/panel/mitsubishi,aa104xd12.txt
+++ /dev/null
@@ -1,47 +0,0 @@
-Mitsubishi AA204XD12 LVDS Display Panel
-=======================================
-
-The AA104XD12 is a 10.4" XGA TFT-LCD display panel.
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
-	compatible = "mitsubishi,aa104xd12", "panel-lvds";
-	vcc-supply = <&vcc_3v3>;
-
-	width-mm = <210>;
-	height-mm = <158>;
-
-	data-mapping = "jeida-24";
-
-	panel-timing {
-		/* 1024x768 @65Hz */
-		clock-frequency = <65000000>;
-		hactive = <1024>;
-		vactive = <768>;
-		hsync-len = <136>;
-		hfront-porch = <20>;
-		hback-porch = <160>;
-		vfront-porch = <3>;
-		vback-porch = <29>;
-		vsync-len = <6>;
-	};
-
-	port {
-		panel_in: endpoint {
-			remote-endpoint = <&lvds_encoder>;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/display/panel/mitsubishi,aa104xd12.yaml b/Documentation/devicetree/bindings/display/panel/mitsubishi,aa104xd12.yaml
new file mode 100644
index 000000000000..fd97ca49c104
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/mitsubishi,aa104xd12.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/mitsubishi,aa104xd12.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mitsubishi AA104XD12 10.4" XGA LVDS Display Panel
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
+      - const: mitsubishi,aa104xd12
+      - {} # panel-lvds, but not listed here to avoid false select
+
+  vcc-supply:
+    description: Reference to the regulator powering the panel VCC pins.
+
+  data-mapping:
+    const: jeida-24
+
+  width-mm:
+    const: 210
+
+  height-mm:
+    const: 158
+
+
+required:
+  - compatible
+  - vcc-supply
+
+examples:
+  - |+
+
+    panel {
+      compatible = "mitsubishi,aa104xd12", "panel-lvds";
+      vcc-supply = <&vcc_3v3>;
+
+      width-mm = <210>;
+      height-mm = <158>;
+
+      data-mapping = "jeida-24";
+
+      panel-timing {
+        /* 1024x768 @65Hz */
+        clock-frequency = <65000000>;
+        hactive = <1024>;
+        vactive = <768>;
+        hsync-len = <136>;
+        hfront-porch = <20>;
+        hback-porch = <160>;
+        vfront-porch = <3>;
+        vback-porch = <29>;
+        vsync-len = <6>;
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

