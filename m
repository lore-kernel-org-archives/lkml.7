Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E391AC46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACCF52184C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562344992;
	bh=6AWJxdzggq8jdRaQwBhACvdN0GiYYF6qgZP2ZobE3Dc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1nZWZRMtmdHv/O56PQVlOjXG4bXuYTKJWiOhJYkXowyFF1XQlr+zL7oe8kxevJIBI
	 xSLv0btmYyD6picmW8Bv3/bcxNddVxadPMhnOKq2FRujlYEzHMUdeQDBeSAbS/KLMN
	 j6KnOQ2052YHIcJPX78qveWaEXp5DykaIXwLfs5o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbfGEQnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 12:43:11 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:34422 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728690AbfGEQmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 12:42:37 -0400
Received: by mail-io1-f42.google.com with SMTP id k8so20433065iot.1;
        Fri, 05 Jul 2019 09:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XS98x+56z0gRiNEek56gSNwAwH+14pgGnF4eQrePkmg=;
        b=qRmHyiJMq+wAQyJmEuMsc/uX6SAOH1aOwPIL+oix6NEKxxTMfo5UHCPgs0yOZ0CNQC
         HG7BulH9u11hu3G1fTMWq6IAQh9Bhca4NUlq3xQQQH2KT1k8IxKoWCy2gCcsRxeZVqKT
         L5BLJtvKc68aSH1ckhlhQI7VBFi+DZot08hJIlGFT1QK0oAlnEsNvZii3ulFCuDVA5vW
         rNjN2UvXwXyIbu474dwCExmLfNmeBq7JlWsp2n9872Wbaiwb1rbTR68Cg5xA2WiluDwh
         1VegEKMe3uyWq9xmWoc+s51P+nGb7wvjXR0KNxdc5gID20nam++9OEA/1snNRE1ML5zO
         k/pw==
X-Gm-Message-State: APjAAAUNQRXXhpvZ2U2M1joWIzSOeylVS8ycdGAoEfwe37iNdT9CwhDV
        YCkfLGBTFswNS0rKHEqLYQYJfgk=
X-Google-Smtp-Source: APXvYqxb4qPpf2440NuEycGWkpJEhmYJgIh5tlmZHPrGm2Bz2vlqn70s1akoqenPe8BuOKMGI+gjdA==
X-Received: by 2002:a6b:790a:: with SMTP id i10mr4957673iop.150.1562344956206;
        Fri, 05 Jul 2019 09:42:36 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id b8sm6878104ioj.16.2019.07.05.09.42.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 09:42:35 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH v3 07/13] dt-bindings: display: Convert raspberrypi,7inch-touchscreen panel to DT schema
Date:   Fri,  5 Jul 2019 10:42:15 -0600
Message-Id: <20190705164221.4462-8-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190705164221.4462-1-robh@kernel.org>
References: <20190705164221.4462-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the raspberrypi,7inch-touchscreen panel binding to DT schema.

Cc: Eric Anholt <eric@anholt.net>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../panel/raspberrypi,7inch-touchscreen.txt   | 49 -------------
 .../panel/raspberrypi,7inch-touchscreen.yaml  | 71 +++++++++++++++++++
 2 files changed, 71 insertions(+), 49 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/raspberrypi,7inch-touchscreen.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/raspberrypi,7inch-touchscreen.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/raspberrypi,7inch-touchscreen.txt b/Documentation/devicetree/bindings/display/panel/raspberrypi,7inch-touchscreen.txt
deleted file mode 100644
index e9e19c059260..000000000000
--- a/Documentation/devicetree/bindings/display/panel/raspberrypi,7inch-touchscreen.txt
+++ /dev/null
@@ -1,49 +0,0 @@
-This binding covers the official 7" (800x480) Raspberry Pi touchscreen
-panel.
-
-This DSI panel contains:
-
-- TC358762 DSI->DPI bridge
-- Atmel microcontroller on I2C for power sequencing the DSI bridge and
-  controlling backlight
-- Touchscreen controller on I2C for touch input
-
-and this binding covers the DSI display parts but not its touch input.
-
-Required properties:
-- compatible:	Must be "raspberrypi,7inch-touchscreen-panel"
-- reg:		Must be "45"
-- port:		See panel-common.txt
-
-Example:
-
-dsi1: dsi@7e700000 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	<...>
-
-	port {
-		dsi_out_port: endpoint {
-			remote-endpoint = <&panel_dsi_port>;
-		};
-	};
-};
-
-i2c_dsi: i2c {
-	compatible = "i2c-gpio";
-	#address-cells = <1>;
-	#size-cells = <0>;
-	gpios = <&gpio 28 0
-		 &gpio 29 0>;
-
-	lcd@45 {
-		compatible = "raspberrypi,7inch-touchscreen-panel";
-		reg = <0x45>;
-
-		port {
-			panel_dsi_port: endpoint {
-				remote-endpoint = <&dsi_out_port>;
-			};
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/display/panel/raspberrypi,7inch-touchscreen.yaml b/Documentation/devicetree/bindings/display/panel/raspberrypi,7inch-touchscreen.yaml
new file mode 100644
index 000000000000..22a083f7bc8e
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/raspberrypi,7inch-touchscreen.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/raspberrypi,7inch-touchscreen.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: The official 7" (800x480) Raspberry Pi touchscreen
+
+maintainers:
+  - Eric Anholt <eric@anholt.net>
+  - Thierry Reding <thierry.reding@gmail.com>
+
+description: |+
+  This DSI panel contains:
+
+  - TC358762 DSI->DPI bridge
+  - Atmel microcontroller on I2C for power sequencing the DSI bridge and
+    controlling backlight
+  - Touchscreen controller on I2C for touch input
+
+  and this binding covers the DSI display parts but not its touch input.
+
+properties:
+  compatible:
+    const: raspberrypi,7inch-touchscreen-panel
+
+  reg:
+    const: 0x45
+
+  port: true
+
+required:
+  - compatible
+  - reg
+  - port
+
+additionalProperties: false
+
+examples:
+  - |+
+    dsi1: dsi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      port {
+        dsi_out_port: endpoint {
+          remote-endpoint = <&panel_dsi_port>;
+        };
+      };
+    };
+
+    i2c_dsi: i2c {
+      compatible = "i2c-gpio";
+      #address-cells = <1>;
+      #size-cells = <0>;
+      scl-gpios = <&gpio 28 0>;
+      sda-gpios = <&gpio 29 0>;
+
+      lcd@45 {
+        compatible = "raspberrypi,7inch-touchscreen-panel";
+        reg = <0x45>;
+
+        port {
+          panel_dsi_port: endpoint {
+            remote-endpoint = <&dsi_out_port>;
+          };
+        };
+      };
+    };
+
+...
-- 
2.20.1

