Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A4EC46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1707020828
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562344984;
	bh=fafMgM4/c6F/XGUFt+rdYYgxWLfOwXetANrE6ixNRx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ih/vY3oDG2MjtyZCFK+09Bmc4we01nLnuivkaue/HXk624sUyVt12UuFgnickrhhj
	 CQ1SkAclhuWn4a78ZPPxLCBNuNN4e22fAEyZe0lzhXfPgQ0s+Ra6z4rlCtDjafnEK6
	 58QLm5xV5Uo0ELk8y/zoyx2kou/o8eexYpJzYoeI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbfGEQnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 12:43:02 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35021 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728750AbfGEQmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 12:42:43 -0400
Received: by mail-io1-f67.google.com with SMTP id m24so10882200ioo.2;
        Fri, 05 Jul 2019 09:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LabiQkmC1Rr/HV25LNsfRozq8YmiX5RtewiyO4nDttY=;
        b=U+8RLWR283EBnRsETZDyGcIj+wQAxUAmVO7UNsHxiv45qmDLBNTB2NwXn+kk3D8nGO
         zpRmcMP1OIJ/tYrFrH1FjZtRMyagC9Mt6UXr7ydcrs2UY8f8HSxbw0GK2Tz6tQ9Bu5sL
         FEv5GqUgq7QjjW4ktvo5J+vmyiMb451cL21LYELz31KRRMaz2xINpgyobsFdZ/2Y0cLv
         jpKTB9iKrfsUjt+8u+Vavn7piWOFOhdzjS4EuEmeGJDPzn5gAaHDdR5Ae+Rrc1B2dP+a
         gTBNPTFPEtgGlIl+NRySBmvojM9RmavY4i9ME2lZ+AwVGkY615bNUie0pQt5EX/mqJjs
         s4cQ==
X-Gm-Message-State: APjAAAU2BChjEHIck7DBQExWmI9FlaCBVxyamJpwmhoA+WJrz+kvPhho
        QrJ7ki5cID2HdBFDy7zC1Q==
X-Google-Smtp-Source: APXvYqw0S+v3RBEWr5++JbeIs7jwUoCLta54JTucXWP2s5b/WJV3U306/CJRgBrW4MrUJK3uquh4xA==
X-Received: by 2002:a6b:c98c:: with SMTP id z134mr892385iof.276.1562344962954;
        Fri, 05 Jul 2019 09:42:42 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id b8sm6878104ioj.16.2019.07.05.09.42.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 09:42:42 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v3 11/13] dt-bindings: display: Convert mitsubishi,aa104xd12 panel to DT schema
Date:   Fri,  5 Jul 2019 10:42:19 -0600
Message-Id: <20190705164221.4462-12-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190705164221.4462-1-robh@kernel.org>
References: <20190705164221.4462-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the mitsubishi,aa104xd12 LVDS panel binding to DT schema.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../display/panel/mitsubishi,aa104xd12.txt    | 47 ------------
 .../display/panel/mitsubishi,aa104xd12.yaml   | 75 +++++++++++++++++++
 2 files changed, 75 insertions(+), 47 deletions(-)
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
index 000000000000..b5e7ee230fa6
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/mitsubishi,aa104xd12.yaml
@@ -0,0 +1,75 @@
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

