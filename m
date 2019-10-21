Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7465BCA9EB0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA9021783
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571674447;
	bh=7SuovnyOFIDXjjAa3m7sCNKHcZazJdRm/MfbQcjj8bs=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rHT9F2AEQTJNq7rPvqQiCkS3hqkuTi0qZpSGsLsJQ6ryWUUp5k26TNRunKO0TBLRC
	 Dz+YdFl74nDq3rAheuE0U362pF1+EDNZfsC3NZpPJQKbOrnZ0/Rc6MKPv/fFZYTguh
	 L12dZlzetDFHDr3zMhWLEQ8hgS8vaCMuQDqU85io=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbfJUQOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 12:14:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727211AbfJUQOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:14:05 -0400
Received: from localhost.localdomain (unknown [194.230.155.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 234182084B;
        Mon, 21 Oct 2019 16:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571674444;
        bh=7SuovnyOFIDXjjAa3m7sCNKHcZazJdRm/MfbQcjj8bs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=vlo+VW/blpqwBIg3aWdMxDXNV5PIPwffmgd93C+9tZN/RmPx7ujBNey4MEa52kuGn
         GKjoc5RKsfKjxkaxG8tM5BwUIxq888O5LUltOESit2hiLJDDlAraQGerHgy1nB/Ehb
         dM7w1tS7JXFuXswW0j7L7hqjn7kysDQy8jYZL0Yo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v4 2/7] dt-bindings: sram: Merge Samsung SRAM bindings into generic
Date:   Mon, 21 Oct 2019 18:13:46 +0200
Message-Id: <20191021161351.20789-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191021161351.20789-1-krzk@kernel.org>
References: <20191021161351.20789-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Samsung SRAM bindings list only compatible so integrate them into
generic SRAM bindings schema.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v3:
1. New patch
---
 .../devicetree/bindings/sram/samsung-sram.txt | 38 -------------------
 .../devicetree/bindings/sram/sram.yaml        | 29 ++++++++++++++
 MAINTAINERS                                   |  1 -
 3 files changed, 29 insertions(+), 39 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sram/samsung-sram.txt

diff --git a/Documentation/devicetree/bindings/sram/samsung-sram.txt b/Documentation/devicetree/bindings/sram/samsung-sram.txt
deleted file mode 100644
index 61a9bbed303d..000000000000
--- a/Documentation/devicetree/bindings/sram/samsung-sram.txt
+++ /dev/null
@@ -1,38 +0,0 @@
-Samsung Exynos SYSRAM for SMP bringup:
-------------------------------------
-
-Samsung SMP-capable Exynos SoCs use part of the SYSRAM for the bringup
-of the secondary cores. Once the core gets powered up it executes the
-code that is residing at some specific location of the SYSRAM.
-
-Therefore reserved section sub-nodes have to be added to the mmio-sram
-declaration. These nodes are of two types depending upon secure or
-non-secure execution environment.
-
-Required sub-node properties:
-- compatible : depending upon boot mode, should be
-		"samsung,exynos4210-sysram" : for Secure SYSRAM
-		"samsung,exynos4210-sysram-ns" : for Non-secure SYSRAM
-
-The rest of the properties should follow the generic mmio-sram discription
-found in Documentation/devicetree/bindings/sram/sram.txt
-
-Example:
-
-	sysram@2020000 {
-		compatible = "mmio-sram";
-		reg = <0x02020000 0x54000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0 0x02020000 0x54000>;
-
-		smp-sysram@0 {
-			compatible = "samsung,exynos4210-sysram";
-			reg = <0x0 0x1000>;
-		};
-
-		smp-sysram@53000 {
-			compatible = "samsung,exynos4210-sysram-ns";
-			reg = <0x53000 0x1000>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/sram/sram.yaml b/Documentation/devicetree/bindings/sram/sram.yaml
index d338fcaa21ed..9ed94f8b0794 100644
--- a/Documentation/devicetree/bindings/sram/sram.yaml
+++ b/Documentation/devicetree/bindings/sram/sram.yaml
@@ -64,6 +64,9 @@ patternProperties:
         description:
           Should contain a vendor specific string in the form
           <vendor>,[<device>-]<usage>
+        enum:
+          - samsung,exynos4210-sysram
+          - samsung,exynos4210-sysram-ns
 
       reg:
         description:
@@ -135,3 +138,29 @@ examples:
             export;
         };
     };
+
+  - |
+    // Samsung SMP-capable Exynos SoCs use part of the SYSRAM for the bringup
+    // of the secondary cores. Once the core gets powered up it executes the
+    // code that is residing at some specific location of the SYSRAM.
+    //
+    // Therefore reserved section sub-nodes have to be added to the mmio-sram
+    // declaration. These nodes are of two types depending upon secure or
+    // non-secure execution environment.
+    sram@2020000 {
+        compatible = "mmio-sram";
+        reg = <0x02020000 0x54000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0 0x02020000 0x54000>;
+
+        smp-sram@0 {
+            compatible = "samsung,exynos4210-sysram";
+            reg = <0x0 0x1000>;
+        };
+
+        smp-sram@53000 {
+            compatible = "samsung,exynos4210-sysram-ns";
+            reg = <0x53000 0x1000>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 56c78eadfdc5..699ad8f1eb38 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2235,7 +2235,6 @@ F:	drivers/soc/samsung/
 F:	include/linux/soc/samsung/
 F:	Documentation/arm/samsung/
 F:	Documentation/devicetree/bindings/arm/samsung/
-F:	Documentation/devicetree/bindings/sram/samsung-sram.txt
 F:	Documentation/devicetree/bindings/power/pd-samsung.txt
 N:	exynos
 
-- 
2.17.1

