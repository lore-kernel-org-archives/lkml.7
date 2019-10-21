Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D36CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 169DE21872
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571674451;
	bh=PesYZ+HA875Gfaapu9lLXMBV2ZwPk+XBT+8vkmww23U=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wWdZ5EGwMpEkvOMGaqaPP8hK6bpznuQTcXdWJXzpeEcGnbJVhMkK85KZS1oJ5h1Ql
	 xwpFUve0Z7SnrPQbPnL7pQ7ncAn4Em0o5FVCelOQvJl4La5Sn6X2zEia1ZtcjFKpo7
	 uxT0Oao9UmTBd++PObkgxTUdbsiBLBuG7boJEHus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbfJUQOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 12:14:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728829AbfJUQOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:14:09 -0400
Received: from localhost.localdomain (unknown [194.230.155.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8024E2173B;
        Mon, 21 Oct 2019 16:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571674448;
        bh=PesYZ+HA875Gfaapu9lLXMBV2ZwPk+XBT+8vkmww23U=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=RFRhPoEiZVxyEt90zQAwknCO80KBatrwuzdN+N1r1iIu4kq/cxQZ3RxBIcEARt+ON
         DMnKUyONZ7WI75aa58PSKcXPuO1InU1lG/3tnFIR0IjC959EcC1dCHi3xsijoAms8o
         b7Pi5/tbl/GwZE21/h703VJwZV2ulVnXyFOozE9E=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v4 3/7] dt-bindings: sram: Merge Amlogic SRAM bindings into generic
Date:   Mon, 21 Oct 2019 18:13:47 +0200
Message-Id: <20191021161351.20789-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191021161351.20789-1-krzk@kernel.org>
References: <20191021161351.20789-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic SRAM bindings list only compatible so integrate them into
generic SRAM bindings schema.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v3:
1. New patch
---
 .../bindings/arm/amlogic/smp-sram.txt         | 32 -------------------
 .../devicetree/bindings/sram/sram.yaml        | 22 +++++++++++++
 2 files changed, 22 insertions(+), 32 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/amlogic/smp-sram.txt

diff --git a/Documentation/devicetree/bindings/arm/amlogic/smp-sram.txt b/Documentation/devicetree/bindings/arm/amlogic/smp-sram.txt
deleted file mode 100644
index 3473ddaadfac..000000000000
--- a/Documentation/devicetree/bindings/arm/amlogic/smp-sram.txt
+++ /dev/null
@@ -1,32 +0,0 @@
-Amlogic Meson8 and Meson8b SRAM for smp bringup:
-------------------------------------------------
-
-Amlogic's SMP-capable SoCs use part of the sram for the bringup of the cores.
-Once the core gets powered up it executes the code that is residing at a
-specific location.
-
-Therefore a reserved section sub-node has to be added to the mmio-sram
-declaration.
-
-Required sub-node properties:
-- compatible : depending on the SoC this should be one of:
-		"amlogic,meson8-smp-sram"
-		"amlogic,meson8b-smp-sram"
-
-The rest of the properties should follow the generic mmio-sram discription
-found in ../../misc/sram.txt
-
-Example:
-
-	sram: sram@d9000000 {
-		compatible = "mmio-sram";
-		reg = <0xd9000000 0x20000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0 0xd9000000 0x20000>;
-
-		smp-sram@1ff80 {
-			compatible = "amlogic,meson8b-smp-sram";
-			reg = <0x1ff80 0x8>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/sram/sram.yaml b/Documentation/devicetree/bindings/sram/sram.yaml
index 9ed94f8b0794..a78da7a686d0 100644
--- a/Documentation/devicetree/bindings/sram/sram.yaml
+++ b/Documentation/devicetree/bindings/sram/sram.yaml
@@ -65,6 +65,8 @@ patternProperties:
           Should contain a vendor specific string in the form
           <vendor>,[<device>-]<usage>
         enum:
+          - amlogic,meson8-smp-sram
+          - amlogic,meson8b-smp-sram
           - samsung,exynos4210-sysram
           - samsung,exynos4210-sysram-ns
 
@@ -164,3 +166,23 @@ examples:
             reg = <0x53000 0x1000>;
         };
     };
+
+  - |
+    // Amlogic's SMP-capable SoCs use part of the sram for the bringup of the cores.
+    // Once the core gets powered up it executes the code that is residing at a
+    // specific location.
+    //
+    // Therefore a reserved section sub-node has to be added to the mmio-sram
+    // declaration.
+    sram@d9000000 {
+        compatible = "mmio-sram";
+        reg = <0xd9000000 0x20000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0 0xd9000000 0x20000>;
+
+        smp-sram@1ff80 {
+            compatible = "amlogic,meson8b-smp-sram";
+            reg = <0x1ff80 0x8>;
+        };
+    };
-- 
2.17.1

