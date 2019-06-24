Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0782C4646C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C32E208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561413577;
	bh=1FMTUbwLvY6wTmFzlMUeHwTuZJeaqJEkQnSn+S5GGgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fh/ySlqz7daPovfJkFZZao5YrSmdUNANSWe9/lIGyZVPvdi71e9p22ayyMby5WTme
	 pJI+HzuQkCLSlyj1dWQ1oUfz1Pfj9cfR6b5KQuV9elDLYuenjoJYm1tm+KktcJCqSv
	 +ZoLYmDO2qzLk9VLcKxot8IrhcMx9uybROSeqEqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732748AbfFXV7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 17:59:14 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44878 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732677AbfFXV7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 17:59:08 -0400
Received: by mail-io1-f65.google.com with SMTP id s7so374640iob.11;
        Mon, 24 Jun 2019 14:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mwUOQlLuJ3XhE9Np0zOsuYiPvKJ0VZzFo8+UtVJgieA=;
        b=UTumO9WU8419zkGWlABUrSTnhrwtc9plOpfDCAzGzR/dFfP1g0UG/PYP/jqnyJWteV
         4YRn1+lK2ZGOEjLbtn4uGHUQdyd9TJT39wcNPDTv9qOismnFtWJ2/7vLOPLynC2MWgjX
         V5VL/RBWs0QHLstUUheyS7kJyWJHsHVb9MTME3lVUpqAnuqqBk8Zhj0XyBzjKyJRO6NY
         2vi3Fn+GUABmhU2h0L3X/Mq1r5N7U4bLNNInm0FFTIKsz/TIGSzG18tP7Arl4ROpbnjL
         Z80qqTTTppCaAEle5UhFXwfLdoRtgm2NNd53faxBQYCTsPi9iShA00EXBjUYW7paPUDk
         IsEQ==
X-Gm-Message-State: APjAAAWtXM+bZPlB1uk+Sv/DUnz9Av8JxFsd45LbrJ5DG15KQ/rvQojq
        yk8u1dgM6zeIkxTcwpamHw==
X-Google-Smtp-Source: APXvYqyxXnT1JtCb0RwdoHBwtx5v26EGMODkca/M/4MvZA3Oc1OC2p27IpM+tzl3ejOLPo5WWus1Zw==
X-Received: by 2002:a6b:7d49:: with SMTP id d9mr1606554ioq.50.1561413547310;
        Mon, 24 Jun 2019 14:59:07 -0700 (PDT)
Received: from localhost.localdomain ([64.188.179.247])
        by smtp.googlemail.com with ESMTPSA id l5sm14717301ioq.83.2019.06.24.14.59.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 14:59:06 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 10/15] dt-bindings: display: Convert tpo,tpg110 panel to DT schema
Date:   Mon, 24 Jun 2019 15:56:44 -0600
Message-Id: <20190624215649.8939-11-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624215649.8939-1-robh@kernel.org>
References: <20190624215649.8939-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the tpo,tpg110 panel binding to DT schema.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/display/panel/tpo,tpg110.txt     |  70 ------------
 .../bindings/display/panel/tpo,tpg110.yaml    | 101 ++++++++++++++++++
 2 files changed, 101 insertions(+), 70 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/tpo,tpg110.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/tpo,tpg110.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/tpo,tpg110.txt b/Documentation/devicetree/bindings/display/panel/tpo,tpg110.txt
deleted file mode 100644
index 40f3d7c713bb..000000000000
--- a/Documentation/devicetree/bindings/display/panel/tpo,tpg110.txt
+++ /dev/null
@@ -1,70 +0,0 @@
-TPO TPG110 Panel
-================
-
-This panel driver is a component that acts as an intermediary
-between an RGB output and a variety of panels. The panel
-driver is strapped up in electronics to the desired resolution
-and other properties, and has a control interface over 3WIRE
-SPI. By talking to the TPG110 over SPI, the strapped properties
-can be discovered and the hardware is therefore mostly
-self-describing.
-
-       +--------+
-SPI -> |  TPO   | -> physical display
-RGB -> | TPG110 |
-       +--------+
-
-If some electrical strap or alternate resolution is desired,
-this can be set up by taking software control of the display
-over the SPI interface. The interface can also adjust
-for properties of the display such as gamma correction and
-certain electrical driving levels.
-
-The TPG110 does not know the physical dimensions of the panel
-connected, so this needs to be specified in the device tree.
-
-It requires a GPIO line for control of its reset line.
-
-The serial protocol has line names that resemble I2C but the
-protocol is not I2C but 3WIRE SPI.
-
-Required properties:
-- compatible : one of:
-  "ste,nomadik-nhk15-display", "tpo,tpg110"
-  "tpo,tpg110"
-- grestb-gpios : panel reset GPIO
-- width-mm : see display/panel/panel-common.txt
-- height-mm : see display/panel/panel-common.txt
-
-The device needs to be a child of an SPI bus, see
-spi/spi-bus.txt. The SPI child must set the following
-properties:
-- spi-3wire
-- spi-max-frequency = <3000000>;
-as these are characteristics of this device.
-
-The device node can contain one 'port' child node with one child
-'endpoint' node, according to the bindings defined in
-media/video-interfaces.txt. This node should describe panel's video bus.
-
-Example
--------
-
-panel: display@0 {
-	compatible = "tpo,tpg110";
-	reg = <0>;
-	spi-3wire;
-	/* 320 ns min period ~= 3 MHz */
-	spi-max-frequency = <3000000>;
-	/* Width and height from data sheet */
-	width-mm = <116>;
-	height-mm = <87>;
-	grestb-gpios = <&foo_gpio 5 GPIO_ACTIVE_LOW>;
-	backlight = <&bl>;
-
-	port {
-		nomadik_clcd_panel: endpoint {
-			remote-endpoint = <&foo>;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/display/panel/tpo,tpg110.yaml b/Documentation/devicetree/bindings/display/panel/tpo,tpg110.yaml
new file mode 100644
index 000000000000..a51660b73f28
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/tpo,tpg110.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/tpo,tpg110.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TPO TPG110 Panel
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+  - Thierry Reding <thierry.reding@gmail.com>
+
+description: |+
+  This panel driver is a component that acts as an intermediary
+  between an RGB output and a variety of panels. The panel
+  driver is strapped up in electronics to the desired resolution
+  and other properties, and has a control interface over 3WIRE
+  SPI. By talking to the TPG110 over SPI, the strapped properties
+  can be discovered and the hardware is therefore mostly
+  self-describing.
+
+         +--------+
+  SPI -> |  TPO   | -> physical display
+  RGB -> | TPG110 |
+         +--------+
+
+  If some electrical strap or alternate resolution is desired,
+  this can be set up by taking software control of the display
+  over the SPI interface. The interface can also adjust
+  for properties of the display such as gamma correction and
+  certain electrical driving levels.
+
+  The TPG110 does not know the physical dimensions of the panel
+  connected, so this needs to be specified in the device tree.
+
+  It requires a GPIO line for control of its reset line.
+
+  The serial protocol has line names that resemble I2C but the
+  protocol is not I2C but 3WIRE SPI.
+
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - ste,nomadik-nhk15-display
+          - const: tpo,tpg110
+      - const: tpo,tpg110
+
+  reg: true
+
+  grestb-gpios:
+    maxItems: 1
+    description: panel reset GPIO
+
+  spi-3wire: true
+
+  spi-max-frequency:
+    const: 3000000
+
+required:
+  - compatible
+  - reg
+  - grestb-gpios
+  - width-mm
+  - height-mm
+  - spi-3wire
+  - spi-max-frequency
+  - port
+
+examples:
+  - |+
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      panel: display@0 {
+        compatible = "tpo,tpg110";
+        reg = <0>;
+        spi-3wire;
+        /* 320 ns min period ~= 3 MHz */
+        spi-max-frequency = <3000000>;
+        /* Width and height from data sheet */
+        width-mm = <116>;
+        height-mm = <87>;
+        grestb-gpios = <&foo_gpio 5 1>;
+        backlight = <&bl>;
+
+        port {
+          nomadik_clcd_panel: endpoint {
+            remote-endpoint = <&foo>;
+          };
+        };
+      };
+    };
+
+...
-- 
2.20.1

