Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B8BCA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD1421872
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571674457;
	bh=eQ7bTx/R0P9vquohan/FmaxWHKD0fkRnjK6ziQ7PlFc=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Mgo4mby5j75Tw4oDysliGJA9vTTZLGaYlXOdEqSFsxREdzneZcNcujEFDmIlNWOBG
	 5/WyqLhV1DfKnHn3n+F/y0EdbIedlYfDtW6rne2hkSwIZ308+XaB3ETeAJLzrsu2tA
	 NJQTe3upcVAbbL4lp129OLilowUsTUGWO0lc+pQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbfJUQOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 12:14:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729734AbfJUQOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:14:15 -0400
Received: from localhost.localdomain (unknown [194.230.155.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0428217D7;
        Mon, 21 Oct 2019 16:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571674454;
        bh=eQ7bTx/R0P9vquohan/FmaxWHKD0fkRnjK6ziQ7PlFc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=2Q1YaqNKPdkYowiYJXx5h4BKccMqHEJW7kCKv3hZjB8AH2PAMzasEtdBSWZZu1JSg
         7H3YcdmAl3AUluKtacleQMX5kb1wSigDlb/Ho8XpNi6rVqXEvaBDBg7PnwrPycDnNV
         hywI1o6nHdUmw6GjzMyYG0iuMyjHi6xaPwur2QPE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v4 5/7] dt-bindings: sram: Merge Rockchip SRAM bindings into generic
Date:   Mon, 21 Oct 2019 18:13:49 +0200
Message-Id: <20191021161351.20789-5-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191021161351.20789-1-krzk@kernel.org>
References: <20191021161351.20789-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Rockchip SRAM bindings list only compatible so integrate them into
generic SRAM bindings schema.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v3:
1. New patch
---
 .../bindings/sram/rockchip-smp-sram.txt       | 30 -------------------
 .../devicetree/bindings/sram/sram.yaml        | 15 ++++++++++
 2 files changed, 15 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sram/rockchip-smp-sram.txt

diff --git a/Documentation/devicetree/bindings/sram/rockchip-smp-sram.txt b/Documentation/devicetree/bindings/sram/rockchip-smp-sram.txt
deleted file mode 100644
index 800701ecffca..000000000000
--- a/Documentation/devicetree/bindings/sram/rockchip-smp-sram.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-Rockchip SRAM for smp bringup:
-------------------------------
-
-Rockchip's smp-capable SoCs use the first part of the sram for the bringup
-of the cores. Once the core gets powered up it executes the code that is
-residing at the very beginning of the sram.
-
-Therefore a reserved section sub-node has to be added to the mmio-sram
-declaration.
-
-Required sub-node properties:
-- compatible : should be "rockchip,rk3066-smp-sram"
-
-The rest of the properties should follow the generic mmio-sram discription
-found in Documentation/devicetree/bindings/sram/sram.txt
-
-Example:
-
-	sram: sram@10080000 {
-		compatible = "mmio-sram";
-		reg = <0x10080000 0x10000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		smp-sram@10080000 {
-			compatible = "rockchip,rk3066-smp-sram";
-			reg = <0x10080000 0x50>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/sram/sram.yaml b/Documentation/devicetree/bindings/sram/sram.yaml
index b92e3e10fbfc..1c2d8b0408c0 100644
--- a/Documentation/devicetree/bindings/sram/sram.yaml
+++ b/Documentation/devicetree/bindings/sram/sram.yaml
@@ -68,6 +68,7 @@ patternProperties:
           - amlogic,meson8-smp-sram
           - amlogic,meson8b-smp-sram
           - renesas,smp-sram
+          - rockchip,rk3066-smp-sram
           - samsung,exynos4210-sysram
           - samsung,exynos4210-sysram-ns
 
@@ -201,3 +202,17 @@ examples:
             reg = <0 0x10>;
         };
     };
+
+  - |
+    sram@10080000 {
+        compatible = "mmio-sram";
+        reg = <0x10080000 0x10000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        smp-sram@10080000 {
+            compatible = "rockchip,rk3066-smp-sram";
+            reg = <0x10080000 0x50>;
+        };
+    };
-- 
2.17.1

