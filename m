Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4849C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 11:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EFF5218AF
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 11:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567856156;
	bh=DjGNzh+fr05rUNc5wWkela8s+FXQ7EbFjXm5r11Xvyc=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XR6WvEBVhGuuJbbouQYWzod2uNSf++JokKt4vcej0VNIS+hgu6JFnFyd26CU+rLuc
	 Ez0exZa12Hws3pIeAJTvFkAFcOJEZ8cuJozaTUDeHJIEbbYTSkz6Ue5evnbVcvtWoK
	 6Amf49ECn0keIRfoOhKm5/EGm5Da6UCo1sgY66MY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392081AbfIGLfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 07:35:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:38118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbfIGLfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 07:35:53 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 644A1218DE;
        Sat,  7 Sep 2019 11:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567856153;
        bh=DjGNzh+fr05rUNc5wWkela8s+FXQ7EbFjXm5r11Xvyc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=oYl9n3KGIMIMS1LOa9ZVQvBI/H9n1aUdAJDb3KjNRbqgnEl+dZbPGV+XiymmuY7VZ
         5JksdBRRVgctcWZOhKh5KOktCCXBONxgMwbjDIZtne29kk74BOJyP32e1Aga/dm3mL
         HFdQdkI2/X0lKBMru+Gejm6N095z07tn7mwiUBsQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: sram: Convert Samsung Exynos SYSRAM bindings to json-schema
Date:   Sat,  7 Sep 2019 13:35:42 +0200
Message-Id: <20190907113542.4096-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190907113542.4096-1-krzk@kernel.org>
References: <20190907113542.4096-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Samsung Exynos SYSRAM bindings to DT schema format using
json-schema.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

TODO:
The node naming should be probably fixed (sysram->sram)
---
 .../devicetree/bindings/sram/samsung-sram.txt | 38 ------------
 .../bindings/sram/samsung-sram.yaml           | 58 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 59 insertions(+), 39 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sram/samsung-sram.txt
 create mode 100644 Documentation/devicetree/bindings/sram/samsung-sram.yaml

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
diff --git a/Documentation/devicetree/bindings/sram/samsung-sram.yaml b/Documentation/devicetree/bindings/sram/samsung-sram.yaml
new file mode 100644
index 000000000000..501d299a554e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sram/samsung-sram.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sram/samsung-sram.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos SoC SYSRAM for SMP bringup
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+
+description: |+
+  Samsung SMP-capable Exynos SoCs use part of the SYSRAM for the bringup
+  of the secondary cores. Once the core gets powered up it executes the
+  code that is residing at some specific location of the SYSRAM.
+
+  Therefore reserved section sub-nodes have to be added to the mmio-sram
+  declaration. These nodes are of two types depending upon secure or
+  non-secure execution environment.
+
+allOf:
+  - $ref: "sram.yaml#"
+
+properties:
+  $nodename:
+    pattern: "^sysram(@.*)?"
+
+patternProperties:
+  "^([a-z]*-)?sysram@[a-f0-9]$":
+    type: object
+
+    properties:
+      compatible:
+        description:
+          Depending upon boot mode
+        enum:
+          - samsung,exynos4210-sysram                 # for Secure SYSRAM
+          - samsung,exynos4210-sysram-ns              # for Non-secure SYSRAM
+
+examples:
+  - |
+    sysram@2020000 {
+      compatible = "mmio-sram";
+      reg = <0x02020000 0x54000>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+      ranges = <0 0x02020000 0x54000>;
+
+      smp-sysram@0 {
+        compatible = "samsung,exynos4210-sysram";
+        reg = <0x0 0x1000>;
+      };
+
+      smp-sysram@53000 {
+        compatible = "samsung,exynos4210-sysram-ns";
+        reg = <0x53000 0x1000>;
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index cdd2f1f3e1f4..36c30f31bdf2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2225,7 +2225,7 @@ F:	drivers/soc/samsung/
 F:	include/linux/soc/samsung/
 F:	Documentation/arm/samsung/
 F:	Documentation/devicetree/bindings/arm/samsung/
-F:	Documentation/devicetree/bindings/sram/samsung-sram.txt
+F:	Documentation/devicetree/bindings/sram/samsung-sram.yaml
 F:	Documentation/devicetree/bindings/power/pd-samsung.txt
 N:	exynos
 
-- 
2.17.1

