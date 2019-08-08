Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAAFC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 11:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 699022171F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 11:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="XCviUWeK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731532AbfHHLlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 07:41:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45945 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730057AbfHHLlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 07:41:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id q12so4323600wrj.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 04:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jLs8gsGUflhNohKub9X/BIMLOOG/CQbdDT1tFffxDuY=;
        b=XCviUWeKRkSRCCa/WbhBCxqWZYG9Q3KVElYw3KenWmqioc7CntEFYmHI2bdmc0TaL1
         nQe/1CTNPFAGHZ64k6oVwMi2kRM61wXmk0KVq8tABLdqJhl4YdLKfNO5qrDUroP1BVRb
         F1gv+ZEur9587XidenVkSewdj+rp2ST3wrnDDnkCtOZsr4BykHsKvlwP1H8QHRUEjbNz
         nE9ygKAqvvdKl8WU0Or87Rd44f3JINl/L/hj+MEfyVDRa9ndFf6KeyOe2Os7/OyZ/wTO
         3lE/d32lurn0MX/EnsCvFWGmjKnCINzXzWTcT9aibbqphQxVAW4caVMqvtuqG24Urb88
         vnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jLs8gsGUflhNohKub9X/BIMLOOG/CQbdDT1tFffxDuY=;
        b=egPPqlJ0LNIjoulAIwd2uxa2glFUqysJaoRPL0cjxODz12G4NmeDtSL9jkxM1dGFoY
         3u8FTMIEtWdfwYish01dp/c5fOXM7m0oYlM2mpUzPDT6tcv8pKE2aJbJmd9Rh3mZON/Y
         TnO3kMkWJzWevGrBOVSl7h9wSJ+Pm0NWntxpXJOlInJQ7wQySA30AODZhOPHmy2+Oytz
         Dk2Xz+/nxVgVIHADj2K8bByrzMrkPCVsPJx3SIQCgC9Fihyki5TsMpVmGGmOZI17WY0I
         TWCuqFpdqzCc7+rPVM6cJA5XlXprlgBJ6XdC6CINp4gE6S3MeSeDpAAa3kCl5r+gN6kr
         FLgg==
X-Gm-Message-State: APjAAAVAXbtVq5zwsl1U6ystKZ+eJOw68jSriAgCEDWBuaLDSFAxZKrE
        0RWkNUmm6s4asLm4g4h8Vc2BYg==
X-Google-Smtp-Source: APXvYqztunF++39tb302s/pBXxCPqakJ156cHmWCzudYlWy22NFjqLvf/QEYaxeIqI7H63+hEyvdIA==
X-Received: by 2002:a5d:5012:: with SMTP id e18mr16900192wrt.166.1565264465684;
        Thu, 08 Aug 2019 04:41:05 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f12sm104555882wrg.5.2019.08.08.04.41.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 04:41:04 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     robh+dt@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        martin.blumenstingl@googlemail.com, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 2/2] dt-bindings: net: meson-dwmac: convert to yaml
Date:   Thu,  8 Aug 2019 13:41:01 +0200
Message-Id: <20190808114101.29982-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808114101.29982-1-narmstrong@baylibre.com>
References: <20190808114101.29982-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have the DT validation in place, let's convert the device tree
bindings for the Synopsys DWMAC Glue for Amlogic SoCs over to a YAML schemas.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../bindings/net/amlogic,meson-dwmac.yaml     | 113 ++++++++++++++++++
 .../devicetree/bindings/net/meson-dwmac.txt   |  71 -----------
 .../devicetree/bindings/net/snps,dwmac.yaml   |   5 +
 3 files changed, 118 insertions(+), 71 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/meson-dwmac.txt

diff --git a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
new file mode 100644
index 000000000000..ae91aa9d8616
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
@@ -0,0 +1,113 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2019 BayLibre, SAS
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/net/amlogic,meson-dwmac.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Amlogic Meson DWMAC Ethernet controller
+
+maintainers:
+  - Neil Armstrong <narmstrong@baylibre.com>
+  - Martin Blumenstingl <martin.blumenstingl@googlemail.com>
+
+# We need a select here so we don't match all nodes with 'snps,dwmac'
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - amlogic,meson6-dwmac
+          - amlogic,meson8b-dwmac
+          - amlogic,meson8m2-dwmac
+          - amlogic,meson-gxbb-dwmac
+          - amlogic,meson-axg-dwmac
+  required:
+    - compatible
+
+allOf:
+  - $ref: "snps,dwmac.yaml#"
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - amlogic,meson8b-dwmac
+              - amlogic,meson8m2-dwmac
+              - amlogic,meson-gxbb-dwmac
+              - amlogic,meson-axg-dwmac
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: GMAC main clock
+            - description: First parent clock of the internal mux
+            - description: Second parent clock of the internal mux
+
+        clock-names:
+          minItems: 3
+          maxItems: 3
+          items:
+            - const: stmmaceth
+            - const: clkin0
+            - const: clkin1
+
+        amlogic,tx-delay-ns:
+          $ref: /schemas/types.yaml#definitions/uint32
+          description:
+            The internal RGMII TX clock delay (provided by this driver) in
+            nanoseconds. Allowed values are 0ns, 2ns, 4ns, 6ns.
+            When phy-mode is set to "rgmii" then the TX delay should be
+            explicitly configured. When not configured a fallback of 2ns is
+            used. When the phy-mode is set to either "rgmii-id" or "rgmii-txid"
+            the TX clock delay is already provided by the PHY. In that case
+            this property should be set to 0ns (which disables the TX clock
+            delay in the MAC to prevent the clock from going off because both
+            PHY and MAC are adding a delay).
+            Any configuration is ignored when the phy-mode is set to "rmii".
+
+properties:
+  compatible:
+    additionalItems: true
+    maxItems: 3
+    items:
+      - enum:
+          - amlogic,meson6-dwmac
+          - amlogic,meson8b-dwmac
+          - amlogic,meson8m2-dwmac
+          - amlogic,meson-gxbb-dwmac
+          - amlogic,meson-axg-dwmac
+    contains:
+      enum:
+        - snps,dwmac-3.70a
+        - snps,dwmac
+
+  reg:
+    items:
+      - description:
+          The first register range should be the one of the DWMAC controller
+      - description:
+          The second range is is for the Amlogic specific configuration
+          (for example the PRG_ETHERNET register range on Meson8b and newer)
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - phy-mode
+
+examples:
+  - |
+    ethmac: ethernet@c9410000 {
+         compatible = "amlogic,meson-gxbb-dwmac", "snps,dwmac";
+         reg = <0xc9410000 0x10000>, <0xc8834540 0x8>;
+         interrupts = <8>;
+         interrupt-names = "macirq";
+         clocks = <&clk_eth>, <&clkc_fclk_div2>, <&clk_mpll2>;
+         clock-names = "stmmaceth", "clkin0", "clkin1";
+         phy-mode = "rgmii";
+    };
diff --git a/Documentation/devicetree/bindings/net/meson-dwmac.txt b/Documentation/devicetree/bindings/net/meson-dwmac.txt
deleted file mode 100644
index 1321bb194ed9..000000000000
--- a/Documentation/devicetree/bindings/net/meson-dwmac.txt
+++ /dev/null
@@ -1,71 +0,0 @@
-* Amlogic Meson DWMAC Ethernet controller
-
-The device inherits all the properties of the dwmac/stmmac devices
-described in the file stmmac.txt in the current directory with the
-following changes.
-
-Required properties on all platforms:
-
-- compatible:	Depending on the platform this should be one of:
-			- "amlogic,meson6-dwmac"
-			- "amlogic,meson8b-dwmac"
-			- "amlogic,meson8m2-dwmac"
-			- "amlogic,meson-gxbb-dwmac"
-			- "amlogic,meson-axg-dwmac"
-		Additionally "snps,dwmac" and any applicable more
-		detailed version number described in net/stmmac.txt
-		should be used.
-
-- reg:	The first register range should be the one of the DWMAC
-	controller. The second range is is for the Amlogic specific
-	configuration (for example the PRG_ETHERNET register range
-	on Meson8b and newer)
-
-Required properties on Meson8b, Meson8m2, GXBB and newer:
-- clock-names:	Should contain the following:
-		- "stmmaceth" - see stmmac.txt
-		- "clkin0" - first parent clock of the internal mux
-		- "clkin1" - second parent clock of the internal mux
-
-Optional properties on Meson8b, Meson8m2, GXBB and newer:
-- amlogic,tx-delay-ns:	The internal RGMII TX clock delay (provided
-			by this driver) in nanoseconds. Allowed values
-			are: 0ns, 2ns, 4ns, 6ns.
-			When phy-mode is set to "rgmii" then the TX
-			delay should be explicitly configured. When
-			not configured a fallback of 2ns is used.
-			When the phy-mode is set to either "rgmii-id"
-			or "rgmii-txid" the TX clock delay is already
-			provided by the PHY. In that case this
-			property should be set to 0ns (which disables
-			the TX clock delay in the MAC to prevent the
-			clock from going off because both PHY and MAC
-			are adding a delay).
-			Any configuration is ignored when the phy-mode
-			is set to "rmii".
-
-Example for Meson6:
-
-	ethmac: ethernet@c9410000 {
-		compatible = "amlogic,meson6-dwmac", "snps,dwmac";
-		reg = <0xc9410000 0x10000
-		       0xc1108108 0x4>;
-		interrupts = <0 8 1>;
-		interrupt-names = "macirq";
-		clocks = <&clk81>;
-		clock-names = "stmmaceth";
-	}
-
-Example for GXBB:
-	ethmac: ethernet@c9410000 {
-		compatible = "amlogic,meson-gxbb-dwmac", "snps,dwmac";
-		reg = <0x0 0xc9410000 0x0 0x10000>,
-			<0x0 0xc8834540 0x0 0x8>;
-		interrupts = <0 8 1>;
-		interrupt-names = "macirq";
-		clocks = <&clkc CLKID_ETH>,
-				<&clkc CLKID_FCLK_DIV2>,
-				<&clkc CLKID_MPLL2>;
-		clock-names = "stmmaceth", "clkin0", "clkin1";
-		phy-mode = "rgmii";
-	};
diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 4377f511a51d..c78be15704b9 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -50,6 +50,11 @@ properties:
         - allwinner,sun8i-r40-emac
         - allwinner,sun8i-v3s-emac
         - allwinner,sun50i-a64-emac
+        - amlogic,meson6-dwmac
+        - amlogic,meson8b-dwmac
+        - amlogic,meson8m2-dwmac
+        - amlogic,meson-gxbb-dwmac
+        - amlogic,meson-axg-dwmac
         - snps,dwmac
         - snps,dwmac-3.50a
         - snps,dwmac-3.610
-- 
2.22.0

