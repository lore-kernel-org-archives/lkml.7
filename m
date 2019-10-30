Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30423CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 17:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E90D2208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 17:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572456754;
	bh=7YttjPf25uaH/HJ9LjN93gAC67M6cLBWLgKLTrTSIEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HHTaaTX0SnurPcx4uEMS2fP3Pn6TKaESTXHwDADRZe14vB6CU1k3SrymL2l+dpZ8Y
	 A2fDgRljuXlmglfaOO/lttslsviKZS5L+OxTb14c4Aq1WjD4mFYPU/Ob6GyhPPzVOo
	 2icFcwBl+cFnvbzxMJJl2ijgRzovYPdXlGyHGhlE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfJ3Rcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 13:32:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727093AbfJ3Rcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 13:32:31 -0400
Received: from localhost.localdomain (unknown [194.230.155.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC06D208C0;
        Wed, 30 Oct 2019 17:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572456750;
        bh=7YttjPf25uaH/HJ9LjN93gAC67M6cLBWLgKLTrTSIEI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jdyAXwcuImbI5Dnlq9yhye6rNZ1vtiYHuRiN2L8gbUdOGL5amFQAfRXBN/oNUIDXQ
         Rr0GeyLu7xuKScUnY6gDOVragLGpAe8+i4iaUEgigkqGy5LKaadTlTVr65c6J3b4FR
         waArH0hxloCLG3ahcBQ+cvtPM2pe2sJdvzWb5/4M=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 2/2] dt-bindings: power: Convert Samsung Exynos Power Domain bindings to json-schema
Date:   Wed, 30 Oct 2019 18:32:16 +0100
Message-Id: <20191030173216.5993-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191030173216.5993-1-krzk@kernel.org>
References: <20191030173216.5993-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Samsung Exynos Soc Power Domain bindings to DT schema format using
json-schema.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v2:
1. Use new name of file in samsung,sysmmu.yaml and MAINTAINERS.

Changes since v1:
1. Indent example with four spaces (more readable),
2. Remove unneeded types,
3. Add missing address in example and fix the name.
---
 .../bindings/iommu/samsung,sysmmu.yaml        |  2 +-
 .../devicetree/bindings/power/pd-samsung.txt  | 45 -------------
 .../devicetree/bindings/power/pd-samsung.yaml | 66 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 4 files changed, 68 insertions(+), 47 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/pd-samsung.txt
 create mode 100644 Documentation/devicetree/bindings/power/pd-samsung.yaml

diff --git a/Documentation/devicetree/bindings/iommu/samsung,sysmmu.yaml b/Documentation/devicetree/bindings/iommu/samsung,sysmmu.yaml
index ecde98da5b72..7cdd3aaa2ba4 100644
--- a/Documentation/devicetree/bindings/iommu/samsung,sysmmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/samsung,sysmmu.yaml
@@ -69,7 +69,7 @@ properties:
     description: |
       Required if the System MMU is needed to gate its power.
       Please refer to the following document:
-      Documentation/devicetree/bindings/power/pd-samsung.txt
+      Documentation/devicetree/bindings/power/pd-samsung.yaml
     maxItems: 1
 
 required:
diff --git a/Documentation/devicetree/bindings/power/pd-samsung.txt b/Documentation/devicetree/bindings/power/pd-samsung.txt
deleted file mode 100644
index 92ef355e8f64..000000000000
--- a/Documentation/devicetree/bindings/power/pd-samsung.txt
+++ /dev/null
@@ -1,45 +0,0 @@
-* Samsung Exynos Power Domains
-
-Exynos processors include support for multiple power domains which are used
-to gate power to one or more peripherals on the processor.
-
-Required Properties:
-- compatible: should be one of the following.
-    * samsung,exynos4210-pd - for exynos4210 type power domain.
-    * samsung,exynos5433-pd - for exynos5433 type power domain.
-- reg: physical base address of the controller and length of memory mapped
-    region.
-- #power-domain-cells: number of cells in power domain specifier;
-    must be 0.
-
-Optional Properties:
-- label: Human readable string with domain name. Will be visible in userspace
-	to let user to distinguish between multiple domains in SoC.
-- power-domains: phandle pointing to the parent power domain, for more details
-		 see Documentation/devicetree/bindings/power/power_domain.txt
-
-Deprecated Properties:
-- clocks
-- clock-names
-
-Node of a device using power domains must have a power-domains property
-defined with a phandle to respective power domain.
-
-Example:
-
-	lcd0: power-domain-lcd0 {
-		compatible = "samsung,exynos4210-pd";
-		reg = <0x10023C00 0x10>;
-		#power-domain-cells = <0>;
-		label = "LCD0";
-	};
-
-	mfc_pd: power-domain@10044060 {
-		compatible = "samsung,exynos4210-pd";
-		reg = <0x10044060 0x20>;
-		#power-domain-cells = <0>;
-		label = "MFC";
-	};
-
-See Documentation/devicetree/bindings/power/power_domain.txt for description
-of consumer-side bindings.
diff --git a/Documentation/devicetree/bindings/power/pd-samsung.yaml b/Documentation/devicetree/bindings/power/pd-samsung.yaml
new file mode 100644
index 000000000000..09bdd96c1ec1
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/pd-samsung.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/pd-samsung.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos SoC Power Domains
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+
+description: |+
+  Exynos processors include support for multiple power domains which are used
+  to gate power to one or more peripherals on the processor.
+
+allOf:
+  - $ref: power-domain.yaml#
+
+properties:
+  compatible:
+    enum:
+      - samsung,exynos4210-pd
+      - samsung,exynos5433-pd
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    deprecated: true
+    maxItems: 1
+
+  clock-names:
+    deprecated: true
+    maxItems: 1
+
+  label:
+    description:
+      Human readable string with domain name. Will be visible in userspace
+      to let user to distinguish between multiple domains in SoC.
+
+  "#power-domain-cells":
+    const: 0
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - "#power-domain-cells"
+  - reg
+
+examples:
+  - |
+    lcd0_pd: power-domain@10023c80 {
+        compatible = "samsung,exynos4210-pd";
+        reg = <0x10023c80 0x20>;
+        #power-domain-cells = <0>;
+        label = "LCD0";
+    };
+
+    mfc_pd: power-domain@10044060 {
+        compatible = "samsung,exynos4210-pd";
+        reg = <0x10044060 0x20>;
+        #power-domain-cells = <0>;
+        label = "MFC";
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 8fde5aa64bda..7126d3e079a4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2258,7 +2258,7 @@ F:	drivers/soc/samsung/
 F:	include/linux/soc/samsung/
 F:	Documentation/arm/samsung/
 F:	Documentation/devicetree/bindings/arm/samsung/
-F:	Documentation/devicetree/bindings/power/pd-samsung.txt
+F:	Documentation/devicetree/bindings/power/pd-samsung.yaml
 N:	exynos
 
 ARM/SAMSUNG MOBILE MACHINE SUPPORT
-- 
2.17.1

