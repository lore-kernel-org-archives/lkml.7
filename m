Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B64CA9EB0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E83B21BE5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571674464;
	bh=peU7ouihHc9hidq+P9WiREumiGLtvR29ujNkdCjneXU=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JBNRECAiYCdiIGfvWkwiSEgg6ERH9cWjJp4pOxIDkkebpfivcvBS+nktRG0p9OzY7
	 dE1p2LA7IoV76V40fE5/revcSN5tS7pHAGedVTbiz5tEgXPBAuzpu8AzWaY4zV3fHo
	 T9sXK2l+mJRiV0yYiDh5Qw8/laTfTPJ2kVN/8AVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbfJUQOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 12:14:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:36710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfJUQOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:14:22 -0400
Received: from localhost.localdomain (unknown [194.230.155.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B58EC21872;
        Mon, 21 Oct 2019 16:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571674461;
        bh=peU7ouihHc9hidq+P9WiREumiGLtvR29ujNkdCjneXU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=E+UmOTXdLqE8ZIaq1PdV4NdYW4SeUoAbxANrgvpJuFgksDbnOqjcpVAoQyUQX+zVO
         8XAkrW/RKs4OMyBYuAi53a1bZlHmx0nAaiRgUH+EHIhQsDcAErcoyKRbeu63JGch1l
         FPe8SJTdIBGyYOoutskDB28/qphPyKfNXN0OaCuA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v4 7/7] dt-bindings: sram: Merge Socionext SRAM bindings into generic
Date:   Mon, 21 Oct 2019 18:13:51 +0200
Message-Id: <20191021161351.20789-7-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191021161351.20789-1-krzk@kernel.org>
References: <20191021161351.20789-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Socionext SRAM bindings list only compatible so integrate them into
generic SRAM bindings schema.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v3:
1. New patch
---
 .../bindings/sram/milbeaut-smp-sram.txt       | 24 -------------------
 .../devicetree/bindings/sram/sram.yaml        | 15 ++++++++++++
 2 files changed, 15 insertions(+), 24 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sram/milbeaut-smp-sram.txt

diff --git a/Documentation/devicetree/bindings/sram/milbeaut-smp-sram.txt b/Documentation/devicetree/bindings/sram/milbeaut-smp-sram.txt
deleted file mode 100644
index 194f6a3c1c1e..000000000000
--- a/Documentation/devicetree/bindings/sram/milbeaut-smp-sram.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-Milbeaut SRAM for smp bringup
-
-Milbeaut SoCs use a part of the sram for the bringup of the secondary cores.
-Once they get powered up in the bootloader, they stay at the specific part
-of the sram.
-Therefore the part needs to be added as the sub-node of mmio-sram.
-
-Required sub-node properties:
-- compatible : should be "socionext,milbeaut-smp-sram"
-
-Example:
-
-        sram: sram@0 {
-                compatible = "mmio-sram";
-                reg = <0x0 0x10000>;
-                #address-cells = <1>;
-                #size-cells = <1>;
-                ranges = <0 0x0 0x10000>;
-
-                smp-sram@f100 {
-                        compatible = "socionext,milbeaut-smp-sram";
-                        reg = <0xf100 0x20>;
-                };
-        };
diff --git a/Documentation/devicetree/bindings/sram/sram.yaml b/Documentation/devicetree/bindings/sram/sram.yaml
index 95d8cc7e2b87..de39e06c1ed9 100644
--- a/Documentation/devicetree/bindings/sram/sram.yaml
+++ b/Documentation/devicetree/bindings/sram/sram.yaml
@@ -72,6 +72,7 @@ patternProperties:
           - rockchip,rk3066-smp-sram
           - samsung,exynos4210-sysram
           - samsung,exynos4210-sysram-ns
+          - socionext,milbeaut-smp-sram
 
       reg:
         description:
@@ -241,3 +242,17 @@ examples:
             reg = <0x1000 0x8>;
         };
     };
+
+  - |
+    sram@0 {
+        compatible = "mmio-sram";
+        reg = <0x0 0x10000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0 0x0 0x10000>;
+
+        smp-sram@f100 {
+            compatible = "socionext,milbeaut-smp-sram";
+            reg = <0xf100 0x20>;
+        };
+    };
-- 
2.17.1

