Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0092BC4646B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53E82089F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561413569;
	bh=oBT4PNyR8IyFASpe0MpI3X6hgCdwHaBZcjL4oz4D5J4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zr0RzJVZ1MI5m2W37q0J/N/lAMnRZSIGBIvvCjdJ8kgM9QAj5ol1FO1kMSfz19taF
	 qOILJnAG0TTpCcAdysIrTpT8cxXb36ic5tb7zv3uVnV+zUtSpQrP0dYOetSluGerPZ
	 2skgTY9+K+1DYS7kt1aJpyPR2Zclf1uPvckJ1M2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732765AbfFXV7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 17:59:16 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33337 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732696AbfFXV7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 17:59:10 -0400
Received: by mail-io1-f66.google.com with SMTP id u13so1058802iop.0;
        Mon, 24 Jun 2019 14:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G+s42jlOutJVoH3ChTzadVhi4SKC/zB2mUxbB3XIwJ8=;
        b=kudN0o0Xmy+CjXGINQvQBoevxmCpoXN7o5FX3fNWNZFc62L2DVtK961Q0Dc4T2A8EE
         Q86QpvO3K43JaxXKbd0IHm1wE/okVQqNKKn8CPov0ASdGAxb+VVhvJrbLn9JNB1hYYEU
         Vx9zaeOusmuWIW016QuKGrVhSE1fhKPbT0shVb35gPOgym6vbkdX8h8oHD0Uyi+Ps1cy
         uRfA7pt6KbS5YoasLV83Roh7DrjJF/zUeifM3mcCLIDZ2KN54VzWQli9Isob0Yt3D408
         SjwLrWujq0moaiqIFSm1LNB9PDM6hZc098qIfHl18owTm9xBE/3385UQrsJ9Lq2swulO
         NT7A==
X-Gm-Message-State: APjAAAWDzFJG5ueDdejaH3Bf28AnvXuq86ZiVSbGLGeDSnr5sKpa8DEM
        64sSH2ugY7XzF9vWzEW5nuewUFk=
X-Google-Smtp-Source: APXvYqydJRomez7URVatqxObQ0Hz4v2raDOQcuxNUQttepuMBd2GCFZzz37sgrf3Hpy/QU5pJj+M+w==
X-Received: by 2002:a5d:8759:: with SMTP id k25mr17595306iol.307.1561413549182;
        Mon, 24 Jun 2019 14:59:09 -0700 (PDT)
Received: from localhost.localdomain ([64.188.179.247])
        by smtp.googlemail.com with ESMTPSA id l5sm14717301ioq.83.2019.06.24.14.59.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 14:59:08 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH v2 11/15] dt-bindings: display: Convert panel-lvds to DT schema
Date:   Mon, 24 Jun 2019 15:56:45 -0600
Message-Id: <20190624215649.8939-12-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624215649.8939-1-robh@kernel.org>
References: <20190624215649.8939-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the panel-lvds binding to use DT schema. The panel-lvds schema
inherits from the panel-common.yaml schema and specific LVDS panel
bindings should inherit from this schema.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/display/panel/lvds.yaml          | 107 ++++++++++++++++
 .../bindings/display/panel/panel-lvds.txt     | 121 ------------------
 2 files changed, 107 insertions(+), 121 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/lvds.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/panel/panel-lvds.txt

diff --git a/Documentation/devicetree/bindings/display/panel/lvds.yaml b/Documentation/devicetree/bindings/display/panel/lvds.yaml
new file mode 100644
index 000000000000..d0083301acbe
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/lvds.yaml
@@ -0,0 +1,107 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/lvds.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LVDS Display Panel
+
+maintainers:
+  - Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
+  - Thierry Reding <thierry.reding@gmail.com>
+
+description: |+
+  LVDS is a physical layer specification defined in ANSI/TIA/EIA-644-A. Multiple
+  incompatible data link layers have been used over time to transmit image data
+  to LVDS panels. This bindings supports display panels compatible with the
+  following specifications.
+
+  [JEIDA] "Digital Interface Standards for Monitor", JEIDA-59-1999, February
+  1999 (Version 1.0), Japan Electronic Industry Development Association (JEIDA)
+  [LDI] "Open LVDS Display Interface", May 1999 (Version 0.95), National
+  Semiconductor
+  [VESA] "VESA Notebook Panel Standard", October 2007 (Version 1.0), Video
+  Electronics Standards Association (VESA)
+
+  Device compatible with those specifications have been marketed under the
+  FPD-Link and FlatLink brands.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    contains:
+      const: panel-lvds
+    description:
+      Shall contain "panel-lvds" in addition to a mandatory panel-specific
+      compatible string defined in individual panel bindings. The "panel-lvds"
+      value shall never be used on its own.
+
+  data-mapping:
+    enum:
+      - jeida-18
+      - jeida-24
+      - vesa-24
+    description: |
+      The color signals mapping order.
+
+      LVDS data mappings are defined as follows.
+
+      - "jeida-18" - 18-bit data mapping compatible with the [JEIDA], [LDI] and
+        [VESA] specifications. Data are transferred as follows on 3 LVDS lanes.
+
+      Slot	    0       1       2       3       4       5       6
+            ________________                         _________________
+      Clock	                \_______________________/
+              ______  ______  ______  ______  ______  ______  ______
+      DATA0	><__G0__><__R5__><__R4__><__R3__><__R2__><__R1__><__R0__><
+      DATA1	><__B1__><__B0__><__G5__><__G4__><__G3__><__G2__><__G1__><
+      DATA2	><_CTL2_><_CTL1_><_CTL0_><__B5__><__B4__><__B3__><__B2__><
+
+      - "jeida-24" - 24-bit data mapping compatible with the [DSIM] and [LDI]
+        specifications. Data are transferred as follows on 4 LVDS lanes.
+
+      Slot	    0       1       2       3       4       5       6
+            ________________                         _________________
+      Clock	                \_______________________/
+              ______  ______  ______  ______  ______  ______  ______
+      DATA0	><__G2__><__R7__><__R6__><__R5__><__R4__><__R3__><__R2__><
+      DATA1	><__B3__><__B2__><__G7__><__G6__><__G5__><__G4__><__G3__><
+      DATA2	><_CTL2_><_CTL1_><_CTL0_><__B7__><__B6__><__B5__><__B4__><
+      DATA3	><_CTL3_><__B1__><__B0__><__G1__><__G0__><__R1__><__R0__><
+
+      - "vesa-24" - 24-bit data mapping compatible with the [VESA] specification.
+        Data are transferred as follows on 4 LVDS lanes.
+
+      Slot	    0       1       2       3       4       5       6
+            ________________                         _________________
+      Clock	                \_______________________/
+              ______  ______  ______  ______  ______  ______  ______
+      DATA0	><__G0__><__R5__><__R4__><__R3__><__R2__><__R1__><__R0__><
+      DATA1	><__B1__><__B0__><__G5__><__G4__><__G3__><__G2__><__G1__><
+      DATA2	><_CTL2_><_CTL1_><_CTL0_><__B5__><__B4__><__B3__><__B2__><
+      DATA3	><_CTL3_><__B7__><__B6__><__G7__><__G6__><__R7__><__R6__><
+
+      Control signals are mapped as follows.
+
+      CTL0: HSync
+      CTL1: VSync
+      CTL2: Data Enable
+      CTL3: 0
+
+  data-mirror:
+    type: boolean
+    description:
+      If set, reverse the bit order described in the data mappings below on all
+      data lanes, transmitting bits for slots 6 to 0 instead of 0 to 6.
+
+required:
+  - compatible
+  - data-mapping
+  - width-mm
+  - height-mm
+  - panel-timing
+  - port
+
+...
diff --git a/Documentation/devicetree/bindings/display/panel/panel-lvds.txt b/Documentation/devicetree/bindings/display/panel/panel-lvds.txt
deleted file mode 100644
index 250850a2150b..000000000000
--- a/Documentation/devicetree/bindings/display/panel/panel-lvds.txt
+++ /dev/null
@@ -1,121 +0,0 @@
-LVDS Display Panel
-==================
-
-LVDS is a physical layer specification defined in ANSI/TIA/EIA-644-A. Multiple
-incompatible data link layers have been used over time to transmit image data
-to LVDS panels. This bindings supports display panels compatible with the
-following specifications.
-
-[JEIDA] "Digital Interface Standards for Monitor", JEIDA-59-1999, February
-1999 (Version 1.0), Japan Electronic Industry Development Association (JEIDA)
-[LDI] "Open LVDS Display Interface", May 1999 (Version 0.95), National
-Semiconductor
-[VESA] "VESA Notebook Panel Standard", October 2007 (Version 1.0), Video
-Electronics Standards Association (VESA)
-
-Device compatible with those specifications have been marketed under the
-FPD-Link and FlatLink brands.
-
-
-Required properties:
-
-- compatible: Shall contain "panel-lvds" in addition to a mandatory
-  panel-specific compatible string defined in individual panel bindings. The
-  "panel-lvds" value shall never be used on its own.
-- width-mm: See panel-common.txt.
-- height-mm: See panel-common.txt.
-- data-mapping: The color signals mapping order, "jeida-18", "jeida-24"
-  or "vesa-24".
-
-Optional properties:
-
-- label: See panel-common.txt.
-- gpios: See panel-common.txt.
-- backlight: See panel-common.txt.
-- power-supply: See panel-common.txt.
-- data-mirror: If set, reverse the bit order described in the data mappings
-  below on all data lanes, transmitting bits for slots 6 to 0 instead of
-  0 to 6.
-
-Required nodes:
-
-- panel-timing: See panel-common.txt.
-- ports: See panel-common.txt. These bindings require a single port subnode
-  corresponding to the panel LVDS input.
-
-
-LVDS data mappings are defined as follows.
-
-- "jeida-18" - 18-bit data mapping compatible with the [JEIDA], [LDI] and
-  [VESA] specifications. Data are transferred as follows on 3 LVDS lanes.
-
-Slot	    0       1       2       3       4       5       6
-	________________                         _________________
-Clock	                \_______________________/
-	  ______  ______  ______  ______  ______  ______  ______
-DATA0	><__G0__><__R5__><__R4__><__R3__><__R2__><__R1__><__R0__><
-DATA1	><__B1__><__B0__><__G5__><__G4__><__G3__><__G2__><__G1__><
-DATA2	><_CTL2_><_CTL1_><_CTL0_><__B5__><__B4__><__B3__><__B2__><
-
-- "jeida-24" - 24-bit data mapping compatible with the [DSIM] and [LDI]
-  specifications. Data are transferred as follows on 4 LVDS lanes.
-
-Slot	    0       1       2       3       4       5       6
-	________________                         _________________
-Clock	                \_______________________/
-	  ______  ______  ______  ______  ______  ______  ______
-DATA0	><__G2__><__R7__><__R6__><__R5__><__R4__><__R3__><__R2__><
-DATA1	><__B3__><__B2__><__G7__><__G6__><__G5__><__G4__><__G3__><
-DATA2	><_CTL2_><_CTL1_><_CTL0_><__B7__><__B6__><__B5__><__B4__><
-DATA3	><_CTL3_><__B1__><__B0__><__G1__><__G0__><__R1__><__R0__><
-
-- "vesa-24" - 24-bit data mapping compatible with the [VESA] specification.
-  Data are transferred as follows on 4 LVDS lanes.
-
-Slot	    0       1       2       3       4       5       6
-	________________                         _________________
-Clock	                \_______________________/
-	  ______  ______  ______  ______  ______  ______  ______
-DATA0	><__G0__><__R5__><__R4__><__R3__><__R2__><__R1__><__R0__><
-DATA1	><__B1__><__B0__><__G5__><__G4__><__G3__><__G2__><__G1__><
-DATA2	><_CTL2_><_CTL1_><_CTL0_><__B5__><__B4__><__B3__><__B2__><
-DATA3	><_CTL3_><__B7__><__B6__><__G7__><__G6__><__R7__><__R6__><
-
-Control signals are mapped as follows.
-
-CTL0: HSync
-CTL1: VSync
-CTL2: Data Enable
-CTL3: 0
-
-
-Example
--------
-
-panel {
-	compatible = "mitsubishi,aa121td01", "panel-lvds";
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
-- 
2.20.1

