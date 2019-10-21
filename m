Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F307CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3324821BE5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571674461;
	bh=Ccmnu6nOxDiVIz1NGNVhXQ9dyLKK9QddZTiml6Ecya8=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sq46yy/6x7/zJfWqx+CIoQJggJfMt9aXM166JERPJjm9i7LRBH8R3ztahoANSh00E
	 1TfNGpG/TpoGMc7alvOicVPn1DHVVt0SxDeXBrNndJZSu1H+gti3A2l+jpxPYZjCgY
	 aqRD1q+j1bHFRmgo3NBysvM+W3wMdZCUoQbPXASk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbfJUQOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 12:14:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfJUQOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:14:19 -0400
Received: from localhost.localdomain (unknown [194.230.155.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 327F921928;
        Mon, 21 Oct 2019 16:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571674458;
        bh=Ccmnu6nOxDiVIz1NGNVhXQ9dyLKK9QddZTiml6Ecya8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=o+B4P02hmGXNzk0OhAGP0/wFMKWMmuCS885TPCqqBYEeCT/j1rmYRplBpJR6yJTl+
         ZWlYqXeU1W589WuJ5CQNPe4WjwkXgmrWqHwjFIX5fqnWkfdosncmtRcaM6euEdhURW
         bci/YEvMRwmfZ0Vvni42uUZRJpwxwHyARPRPT4x8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v4 6/7] dt-bindings: sram: Merge Allwinner SRAM bindings into generic
Date:   Mon, 21 Oct 2019 18:13:50 +0200
Message-Id: <20191021161351.20789-6-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191021161351.20789-1-krzk@kernel.org>
References: <20191021161351.20789-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner SRAM bindings list only compatible so integrate them into
generic SRAM bindings schema.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v3:
1. New patch
---
 .../bindings/arm/sunxi/smp-sram.txt           | 44 -------------------
 .../devicetree/bindings/sram/sram.yaml        | 25 +++++++++++
 2 files changed, 25 insertions(+), 44 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/sunxi/smp-sram.txt

diff --git a/Documentation/devicetree/bindings/arm/sunxi/smp-sram.txt b/Documentation/devicetree/bindings/arm/sunxi/smp-sram.txt
deleted file mode 100644
index 082e6a9382d3..000000000000
--- a/Documentation/devicetree/bindings/arm/sunxi/smp-sram.txt
+++ /dev/null
@@ -1,44 +0,0 @@
-Allwinner SRAM for smp bringup:
-------------------------------------------------
-
-Allwinner's A80 SoC uses part of the secure sram for hotplugging of the
-primary core (cpu0). Once the core gets powered up it checks if a magic
-value is set at a specific location. If it is then the BROM will jump
-to the software entry address, instead of executing a standard boot.
-
-Therefore a reserved section sub-node has to be added to the mmio-sram
-declaration.
-
-Note that this is separate from the Allwinner SRAM controller found in
-../../sram/sunxi-sram.txt. This SRAM is secure only and not mappable to
-any device.
-
-Also there are no "secure-only" properties. The implementation should
-check if this SRAM is usable first.
-
-Required sub-node properties:
-- compatible : depending on the SoC this should be one of:
-		"allwinner,sun9i-a80-smp-sram"
-
-The rest of the properties should follow the generic mmio-sram discription
-found in ../../misc/sram.txt
-
-Example:
-
-	sram_b: sram@20000 {
-		/* 256 KiB secure SRAM at 0x20000 */
-		compatible = "mmio-sram";
-		reg = <0x00020000 0x40000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0 0x00020000 0x40000>;
-
-		smp-sram@1000 {
-			/*
-			 * This is checked by BROM to determine if
-			 * cpu0 should jump to SMP entry vector
-			 */
-			compatible = "allwinner,sun9i-a80-smp-sram";
-			reg = <0x1000 0x8>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/sram/sram.yaml b/Documentation/devicetree/bindings/sram/sram.yaml
index 1c2d8b0408c0..95d8cc7e2b87 100644
--- a/Documentation/devicetree/bindings/sram/sram.yaml
+++ b/Documentation/devicetree/bindings/sram/sram.yaml
@@ -65,6 +65,7 @@ patternProperties:
           Should contain a vendor specific string in the form
           <vendor>,[<device>-]<usage>
         enum:
+          - allwinner,sun9i-a80-smp-sram
           - amlogic,meson8-smp-sram
           - amlogic,meson8b-smp-sram
           - renesas,smp-sram
@@ -216,3 +217,27 @@ examples:
             reg = <0x10080000 0x50>;
         };
     };
+
+  - |
+    // Allwinner's A80 SoC uses part of the secure sram for hotplugging of the
+    // primary core (cpu0). Once the core gets powered up it checks if a magic
+    // value is set at a specific location. If it is then the BROM will jump
+    // to the software entry address, instead of executing a standard boot.
+    //
+    // Also there are no "secure-only" properties. The implementation should
+    // check if this SRAM is usable first.
+    sram@20000 {
+        // 256 KiB secure SRAM at 0x20000
+        compatible = "mmio-sram";
+        reg = <0x00020000 0x40000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0 0x00020000 0x40000>;
+
+        smp-sram@1000 {
+            // This is checked by BROM to determine if
+            // cpu0 should jump to SMP entry vector
+            compatible = "allwinner,sun9i-a80-smp-sram";
+            reg = <0x1000 0x8>;
+        };
+    };
-- 
2.17.1

