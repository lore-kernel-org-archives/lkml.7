Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB53CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89DF721783
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571674453;
	bh=OZV3IdG9TFjThEBiUSry0JTCOch8mmKj85p44+ujfdQ=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ei0f4mazhqm6NTElX9YQeVFiC+0nxIPsAXTp6Y/eDwOvrXCnKXieZbrQ5JRAMSrwS
	 TmTyAYIpY6S7aOxrGjPdMo1SzQouFA9XUWRzQB5CcrMY2jacgVuHiw653CFmJx6o3h
	 yqmMzCit33pmnPTXDbX0pTYwEnzzZ3NF2VnxESr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbfJUQOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 12:14:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728829AbfJUQOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:14:11 -0400
Received: from localhost.localdomain (unknown [194.230.155.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9359921920;
        Mon, 21 Oct 2019 16:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571674451;
        bh=OZV3IdG9TFjThEBiUSry0JTCOch8mmKj85p44+ujfdQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eyKtANDmUfnBUpeXI3HZ0GbTN6xcLOtloEpO1dRwt7bs5hc8GV+M4K/N5Ff4FcGRA
         ykkkz/lvXLR/gIAldJZcMVhoOWvaYLTlXBuGbs7yDtrnNN3THklE6qQK96PT0YQga3
         wKW02YKlpmeBBEZYP+AWDIMmOtTXGgHLLvcgAW40=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v4 4/7] dt-bindings: sram: Merge Renesas SRAM bindings into generic
Date:   Mon, 21 Oct 2019 18:13:48 +0200
Message-Id: <20191021161351.20789-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191021161351.20789-1-krzk@kernel.org>
References: <20191021161351.20789-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Renesas SRAM bindings list only compatible so integrate them into
generic SRAM bindings schema.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v3:
1. New patch
---
 .../bindings/sram/renesas,smp-sram.txt        | 27 -------------------
 .../devicetree/bindings/sram/sram.yaml        | 15 +++++++++++
 2 files changed, 15 insertions(+), 27 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sram/renesas,smp-sram.txt

diff --git a/Documentation/devicetree/bindings/sram/renesas,smp-sram.txt b/Documentation/devicetree/bindings/sram/renesas,smp-sram.txt
deleted file mode 100644
index 712d05e3e15e..000000000000
--- a/Documentation/devicetree/bindings/sram/renesas,smp-sram.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-* Renesas SMP SRAM
-
-Renesas R-Car Gen2 and RZ/G1 SoCs need a small piece of SRAM for the jump stub
-for secondary CPU bringup and CPU hotplug.
-This memory is reserved by adding a child node to a "mmio-sram" node, cfr.
-Documentation/devicetree/bindings/sram/sram.txt.
-
-Required child node properties:
-  - compatible: Must be "renesas,smp-sram",
-  - reg: Address and length of the reserved SRAM.
-    The full physical (bus) address must be aligned to a 256 KiB boundary.
-
-
-Example:
-
-	icram1:	sram@e63c0000 {
-		compatible = "mmio-sram";
-		reg = <0 0xe63c0000 0 0x1000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0 0 0xe63c0000 0x1000>;
-
-		smp-sram@0 {
-			compatible = "renesas,smp-sram";
-			reg = <0 0x10>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/sram/sram.yaml b/Documentation/devicetree/bindings/sram/sram.yaml
index a78da7a686d0..b92e3e10fbfc 100644
--- a/Documentation/devicetree/bindings/sram/sram.yaml
+++ b/Documentation/devicetree/bindings/sram/sram.yaml
@@ -67,6 +67,7 @@ patternProperties:
         enum:
           - amlogic,meson8-smp-sram
           - amlogic,meson8b-smp-sram
+          - renesas,smp-sram
           - samsung,exynos4210-sysram
           - samsung,exynos4210-sysram-ns
 
@@ -186,3 +187,17 @@ examples:
             reg = <0x1ff80 0x8>;
         };
     };
+
+  - |
+    sram@e63c0000 {
+        compatible = "mmio-sram";
+        reg = <0xe63c0000 0x1000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0 0xe63c0000 0x1000>;
+
+        smp-sram@0 {
+            compatible = "renesas,smp-sram";
+            reg = <0 0x10>;
+        };
+    };
-- 
2.17.1

