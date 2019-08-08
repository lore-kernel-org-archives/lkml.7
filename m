Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E086C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E2B2184E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Q7rWpRAl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731677AbfHHIzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 04:55:31 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:39063 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731054AbfHHIz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 04:55:28 -0400
Received: by mail-wm1-f44.google.com with SMTP id u25so1580935wmc.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 01:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NVSIoQDQUI59AbtDU6wtNrL9Ak0Km4aJoVNG1T5jUh0=;
        b=Q7rWpRAlxZmePJwFcK/A1Seoos3aHW86F4zqwi6X2K5uJbQUCQoHQjijXhmCxV5Bj+
         O7j1saG4tbzqr5meHTXY97mykA2rU7WEghzcfYrZFztqJV7VkT6AK7EdwG1LjoMKvBs2
         dGjTy4wflmtqhrOAcuv8osb4qT5oovQZdUBlr1suzJSY0e2AjTGGxjR9DCNeRoZkCxNX
         8iQUS0aZH3LrFzY7PpzQsw6kl54Fuk0v51GQ1sRPTFtpSFxiXSk1xqmmi+5uEzK6i3br
         Mx9kdgg1ptLfRkCwL2OJS3rScaDhR4b6hj+KXOYgvpxHhsVthboLLTTXEQoNbzkUnLW3
         8QLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NVSIoQDQUI59AbtDU6wtNrL9Ak0Km4aJoVNG1T5jUh0=;
        b=aLZnxjC/ZSAQkHSXyU+71UKIxtyyBVrVwJ3RrzG/YVVlonyvFS631qzlNvvaiVB8Y+
         a8yBqm9BGRsX+u45Eyn8rE3pKyb7Kz9QwTayjLvaMOLuVkoFLD/EkWE3SOdZ30LmK4uE
         5DmsWHu2Axwwbh1vsCT9CZpMo/s4jTbOOHgJfngL0HkdV8JKPWdvX/CyaFerxGeucqJA
         9vNrGqy/OK8cZhGWhr9fIyXM1VsInkGLRaSWfXQpIE1HRufqa9XvdZvwaB6PwnFhteMc
         WjBJDwHHiXtdWUc2LO3lbl5q7GQkTvid9QOxbe7BMK95LygGCdlQYa8DALxdKySripmv
         +Mgw==
X-Gm-Message-State: APjAAAV69yjtfdpzTmLaL3IXfcGrRCK3hvzKtsaCL3fw3p5Rwc5ZBXbj
        47Yv+tBNBb4MOjTLztozAmmALw==
X-Google-Smtp-Source: APXvYqyu96zGmIOApLPbpBTQ4/4iKEhq0gFuIrKTMrwi5bDmwbLqVtd0bhV3sBSTgavLKkMt5rsUdA==
X-Received: by 2002:a7b:cf21:: with SMTP id m1mr3247605wmg.150.1565254525438;
        Thu, 08 Aug 2019 01:55:25 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id i66sm3380649wmi.11.2019.08.08.01.55.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 01:55:24 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     robh+dt@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/3] dt-bindings: display: amlogic,meson-dw-hdmi: convert to yaml
Date:   Thu,  8 Aug 2019 10:55:20 +0200
Message-Id: <20190808085522.21950-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808085522.21950-1-narmstrong@baylibre.com>
References: <20190808085522.21950-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have the DT validation in place, let's convert the device tree
bindings for the Amlogic Synopsys DW-HDMI specifics over to YAML schemas.

The original example and usage of clock-names uses a reversed "isfr"
and "iahb" clock-names, the rewritten YAML bindings uses the reversed
instead of fixing the device trees order.

The #sound-dai-cells optional property has been added to match this node
as a sound dai.

The port connection table has been dropped in favor of a description
of each port.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../display/amlogic,meson-dw-hdmi.txt         | 119 --------------
 .../display/amlogic,meson-dw-hdmi.yaml        | 150 ++++++++++++++++++
 2 files changed, 150 insertions(+), 119 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.txt
 create mode 100644 Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml

diff --git a/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.txt b/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.txt
deleted file mode 100644
index 3a50a7862cf3..000000000000
--- a/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.txt
+++ /dev/null
@@ -1,119 +0,0 @@
-Amlogic specific extensions to the Synopsys Designware HDMI Controller
-======================================================================
-
-The Amlogic Meson Synopsys Designware Integration is composed of :
-- A Synopsys DesignWare HDMI Controller IP
-- A TOP control block controlling the Clocks and PHY
-- A custom HDMI PHY in order to convert video to TMDS signal
- ___________________________________
-|            HDMI TOP               |<= HPD
-|___________________________________|
-|                  |                |
-|  Synopsys HDMI   |   HDMI PHY     |=> TMDS
-|    Controller    |________________|
-|___________________________________|<=> DDC
-
-The HDMI TOP block only supports HPD sensing.
-The Synopsys HDMI Controller interrupt is routed through the
-TOP Block interrupt.
-Communication to the TOP Block and the Synopsys HDMI Controller is done
-via a pair of dedicated addr+read/write registers.
-The HDMI PHY is configured by registers in the HHI register block.
-
-Pixel data arrives in 4:4:4 format from the VENC block and the VPU HDMI mux
-selects either the ENCI encoder for the 576i or 480i formats or the ENCP
-encoder for all the other formats including interlaced HD formats.
-
-The VENC uses a DVI encoder on top of the ENCI or ENCP encoders to generate
-DVI timings for the HDMI controller.
-
-Amlogic Meson GXBB, GXL and GXM SoCs families embeds the Synopsys DesignWare
-HDMI TX IP version 2.01a with HDCP and I2C & S/PDIF
-audio source interfaces.
-
-Required properties:
-- compatible: value should be different for each SoC family as :
-	- GXBB (S905) : "amlogic,meson-gxbb-dw-hdmi"
-	- GXL (S905X, S905D) : "amlogic,meson-gxl-dw-hdmi"
-	- GXM (S912) : "amlogic,meson-gxm-dw-hdmi"
-	followed by the common "amlogic,meson-gx-dw-hdmi"
-	- G12A (S905X2, S905Y2, S905D2) : "amlogic,meson-g12a-dw-hdmi"
-- reg: Physical base address and length of the controller's registers.
-- interrupts: The HDMI interrupt number
-- clocks, clock-names : must have the phandles to the HDMI iahb and isfr clocks,
-  and the Amlogic Meson venci clocks as described in
-  Documentation/devicetree/bindings/clock/clock-bindings.txt,
-  the clocks are soc specific, the clock-names should be "iahb", "isfr", "venci"
-- resets, resets-names: must have the phandles to the HDMI apb, glue and phy
-  resets as described in :
-  Documentation/devicetree/bindings/reset/reset.txt,
-  the reset-names should be "hdmitx_apb", "hdmitx", "hdmitx_phy"
-
-Optional properties:
-- hdmi-supply: Optional phandle to an external 5V regulator to power the HDMI
-  logic, as described in the file ../regulator/regulator.txt
-
-Required nodes:
-
-The connections to the HDMI ports are modeled using the OF graph
-bindings specified in Documentation/devicetree/bindings/graph.txt.
-
-The following table lists for each supported model the port number
-corresponding to each HDMI output and input.
-
-		Port 0		Port 1
------------------------------------------
- S905 (GXBB)	VENC Input	TMDS Output
- S905X (GXL)	VENC Input	TMDS Output
- S905D (GXL)	VENC Input	TMDS Output
- S912 (GXM)	VENC Input	TMDS Output
- S905X2 (G12A)	VENC Input	TMDS Output
- S905Y2 (G12A)	VENC Input	TMDS Output
- S905D2 (G12A)	VENC Input	TMDS Output
-
-Example:
-
-hdmi-connector {
-	compatible = "hdmi-connector";
-	type = "a";
-
-	port {
-		hdmi_connector_in: endpoint {
-			remote-endpoint = <&hdmi_tx_tmds_out>;
-		};
-	};
-};
-
-hdmi_tx: hdmi-tx@c883a000 {
-	compatible = "amlogic,meson-gxbb-dw-hdmi", "amlogic,meson-gx-dw-hdmi";
-	reg = <0x0 0xc883a000 0x0 0x1c>;
-	interrupts = <GIC_SPI 57 IRQ_TYPE_EDGE_RISING>;
-	resets = <&reset RESET_HDMITX_CAPB3>,
-		 <&reset RESET_HDMI_SYSTEM_RESET>,
-		 <&reset RESET_HDMI_TX>;
-	reset-names = "hdmitx_apb", "hdmitx", "hdmitx_phy";
-	clocks = <&clkc CLKID_HDMI_PCLK>,
-		 <&clkc CLKID_CLK81>,
-		 <&clkc CLKID_GCLK_VENCI_INT0>;
-	clock-names = "isfr", "iahb", "venci";
-	#address-cells = <1>;
-	#size-cells = <0>;
-
-	/* VPU VENC Input */
-	hdmi_tx_venc_port: port@0 {
-		reg = <0>;
-
-		hdmi_tx_in: endpoint {
-			remote-endpoint = <&hdmi_tx_out>;
-		};
-	};
-
-	/* TMDS Output */
-	hdmi_tx_tmds_port: port@1 {
-		reg = <1>;
-
-		hdmi_tx_tmds_out: endpoint {
-			remote-endpoint = <&hdmi_connector_in>;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml b/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml
new file mode 100644
index 000000000000..fb747682006d
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml
@@ -0,0 +1,150 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2019 BayLibre, SAS
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/display/amlogic,meson-dw-hdmi.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Amlogic specific extensions to the Synopsys Designware HDMI Controller
+
+maintainers:
+  - Neil Armstrong <narmstrong@baylibre.com>
+
+description: |
+  The Amlogic Meson Synopsys Designware Integration is composed of
+  - A Synopsys DesignWare HDMI Controller IP
+  - A TOP control block controlling the Clocks and PHY
+  - A custom HDMI PHY in order to convert video to TMDS signal
+   ___________________________________
+  |            HDMI TOP               |<= HPD
+  |___________________________________|
+  |                  |                |
+  |  Synopsys HDMI   |   HDMI PHY     |=> TMDS
+  |    Controller    |________________|
+  |___________________________________|<=> DDC
+
+  The HDMI TOP block only supports HPD sensing.
+  The Synopsys HDMI Controller interrupt is routed through the
+  TOP Block interrupt.
+  Communication to the TOP Block and the Synopsys HDMI Controller is done
+  via a pair of dedicated addr+read/write registers.
+  The HDMI PHY is configured by registers in the HHI register block.
+
+  Pixel data arrives in "4:4:4" format from the VENC block and the VPU HDMI mux
+  selects either the ENCI encoder for the 576i or 480i formats or the ENCP
+  encoder for all the other formats including interlaced HD formats.
+
+  The VENC uses a DVI encoder on top of the ENCI or ENCP encoders to generate
+  DVI timings for the HDMI controller.
+
+  Amlogic Meson GXBB, GXL and GXM SoCs families embeds the Synopsys DesignWare
+  HDMI TX IP version 2.01a with HDCP and I2C & S/PDIF
+  audio source interfaces.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - amlogic,meson-gxbb-dw-hdmi # GXBB (S905)
+              - amlogic,meson-gxl-dw-hdmi # GXL (S905X, S905D)
+              - amlogic,meson-gxm-dw-hdmi # GXM (S912)
+          - const: amlogic,meson-gx-dw-hdmi
+      - enum:
+          - amlogic,meson-g12a-dw-hdmi # G12A (S905X2, S905Y2, S905D2)
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 3
+
+  clock-names:
+    items:
+      - const: isfr
+      - const: iahb
+      - const: venci
+
+  resets:
+    minItems: 3
+
+  reset-names:
+    items:
+      - const: hdmitx_apb
+      - const: hdmitx
+      - const: hdmitx_phy
+
+  hdmi-supply:
+    description: phandle to an external 5V regulator to power the HDMI logic
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/phandle
+
+  port@0:
+    type: object
+    description:
+      A port node pointing to the VENC Input port node.
+
+  port@1:
+    type: object
+    description:
+      A port node pointing to the TMDS Output port node.
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  "#sound-dai-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - port@0
+  - port@1
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    hdmi_tx: hdmi-tx@c883a000 {
+        compatible = "amlogic,meson-gxbb-dw-hdmi", "amlogic,meson-gx-dw-hdmi";
+        reg = <0xc883a000 0x1c>;
+        interrupts = <57>;
+        resets = <&reset_apb>, <&reset_hdmitx>, <&reset_hdmitx_phy>;
+        reset-names = "hdmitx_apb", "hdmitx", "hdmitx_phy";
+        clocks = <&clk_isfr>, <&clk_iahb>, <&clk_venci>;
+        clock-names = "isfr", "iahb", "venci";
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        /* VPU VENC Input */
+        hdmi_tx_venc_port: port@0 {
+            reg = <0>;
+
+            hdmi_tx_in: endpoint {
+                remote-endpoint = <&hdmi_tx_out>;
+            };
+        };
+
+        /* TMDS Output */
+        hdmi_tx_tmds_port: port@1 {
+             reg = <1>;
+
+             hdmi_tx_tmds_out: endpoint {
+                 remote-endpoint = <&hdmi_connector_in>;
+             };
+        };
+    };
+
-- 
2.22.0

