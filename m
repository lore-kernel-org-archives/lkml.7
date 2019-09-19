Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3916CC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB35121924
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OhKxk2Wf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbfISNUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 09:20:06 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56819 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731819AbfISNUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 09:20:05 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190919132003euoutp020408a7898fe78643e22c72fc250a0513~F2YN2cDew1288512885euoutp022
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 13:20:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190919132003euoutp020408a7898fe78643e22c72fc250a0513~F2YN2cDew1288512885euoutp022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568899203;
        bh=elF/o5EauRPnSTTBG6lmRKBVlDN/9CAvgA/uzFSxGsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OhKxk2Wfrq0iWW4//bRoZ2hPpHgAiWWUy4DbgksKbS0rbncjbakLp+rm06V8vV4/o
         GB5YS3475x+8rnswRNESRHoep8nMiGbYk8uyn2YAviFPuAPs+pxhciXtTXPQNLt+3n
         HFcpX5khSIw3YqW1OnFHm9UvmgLZm1VO4CHj0EO4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190919132003eucas1p15cdf9e5608cbe3470269e2dd769bf46a~F2YNaSk7b2823128231eucas1p1R;
        Thu, 19 Sep 2019 13:20:03 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 0B.6F.04374.280838D5; Thu, 19
        Sep 2019 14:20:02 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190919132002eucas1p19ceac65f49939be3152affb4d6a426a1~F2YMaJhQs2823128231eucas1p1O;
        Thu, 19 Sep 2019 13:20:02 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190919132002eusmtrp2d6125dbbdee00ce9699b42d923722228~F2YMMDv-R2532425324eusmtrp2z;
        Thu, 19 Sep 2019 13:20:02 +0000 (GMT)
X-AuditID: cbfec7f5-4f7ff70000001116-57-5d838082d225
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 42.2C.04117.180838D5; Thu, 19
        Sep 2019 14:20:01 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190919132001eusmtip1be43ba9fadc469b12019839d8bb36150~F2YLuJf_I2610626106eusmtip1B;
        Thu, 19 Sep 2019 13:20:01 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Maciej Falkowski <m.falkowski@samsung.com>, krzk@kernel.org,
        mark.rutland@arm.com, robh@kernel.org, a.hajda@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v4] dt-bindings: iommu: Convert Samsung Exynos IOMMU H/W,
 System MMU to dt-schema
Date:   Thu, 19 Sep 2019 15:19:44 +0200
Message-Id: <20190919131944.11007-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190917192113.GA26604@bogus>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsWy7djP87pNDc2xBmv/WVvcWneO1WL+ESBx
        /vwGdovLu+awWcw4v4/J4kHzOjaLtUfuslssvX6RyeL/nh3sDpwea+atYfTYtKqTzaNvyypG
        j8+b5AJYorhsUlJzMstSi/TtErgyelY4F7Q4VvQcPcvewHjWuIuRk0NCwETi1LkljF2MXBxC
        AisYJWZ9eQ7lfGGUWPBjPjOE85lR4tXV/8wwLdPefWWDSCxnlNja+ZMZruXKwedgVWwChhJd
        b7vYQGwRgUSJ27/72UGKmAXWMEp8+faOtYuRg0NYIFli1p5qkBoWAVWJpZP6wOp5BWwlXnVu
        ZoTYJi+xesMBsJmcAtoSlz70QsU/s0ksPA5lu0i8vtQLdZ2wxKvjW9ghbBmJ/zvnM4HslRBo
        ZpR4eG4tO4TTwyhxuWkGVLe1xOHjF8EOYhbQlFi/Sx/ElBBwlLj+MRbC5JO48VYQpJgZyJy0
        bTozRJhXoqNNCGKGmsSs4+vgth68cAnqGg+Jgx8nM4GUCwnUSXzcFjKBUX4WwqYFjIyrGMVT
        S4tz01OLjfNSy/WKE3OLS/PS9ZLzczcxAhPF6X/Hv+5g3Pcn6RCjAAejEg+vQnlzrBBrYllx
        Ze4hRgkOZiUR3jmmTbFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeasZHkQLCaQnlqRmp6YWpBbB
        ZJk4OKUaGFcJXWOvfufE8fPa/B5L8R9pe3qfK9uUaSTXFOet2PlEX+BlMedVvbYWxvuhMfOm
        zr8Wf2XdwT8fEiIl1L8/sOp//Nrkzv9p78RFFvpIVwt5WGjff3t8UwTf5UxeJZVaNy5lJudJ
        vDsFLdaIMwbVL1l0V3M2X+ChHyVetcX5fztNegXE/hl+V2Ipzkg01GIuKk4EAOqJOOwQAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsVy+t/xu7pNDc2xBtfELW6tO8dqMf8IkDh/
        fgO7xeVdc9gsZpzfx2TxoHkdm8XaI3fZLZZev8hk8X/PDnYHTo8189Ywemxa1cnm0bdlFaPH
        501yASxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJ
        ehk9K5wLWhwreo6eZW9gPGvcxcjJISFgIjHt3Ve2LkYuDiGBpYwSexduYodIyEicnNbACmEL
        S/y51gVV9IlR4vOei2AJNgFDia63IAlODhGBZInFh3cyghQxC2xilNi54jIjSEJYIFFi3fo1
        YEUsAqoSSyf1gdm8ArYSrzo3M0JskJdYveEAM4jNKaAtcelDL1hcSEBL4vWcxywTGPkWMDKs
        YhRJLS3OTc8tNtIrTswtLs1L10vOz93ECAzebcd+btnB2PUu+BCjAAejEg+vQnlzrBBrYllx
        Ze4hRgkOZiUR3jmmTbFCvCmJlVWpRfnxRaU5qcWHGE2BjprILCWanA+MrLySeENTQ3MLS0Nz
        Y3NjMwslcd4OgYMxQgLpiSWp2ampBalFMH1MHJxSDYwrXcU1bgrXTWMou7DEq7LpFev+3eu6
        /K5crvW8/ObLpOTqID3vuyHlLOmXeyR8vVWl3txqL1f32LbYU6WyfmqYEotWg0KVlJRYgHe1
        7t6wvQybIhTcut68zRb68bRo5p63U37nbLPjqHvGy79hqlsDV9WGDeu+b98dqTNJcN/59n+T
        Qix/OSixFGckGmoxFxUnAgD/izNQdAIAAA==
X-CMS-MailID: 20190919132002eucas1p19ceac65f49939be3152affb4d6a426a1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190919132002eucas1p19ceac65f49939be3152affb4d6a426a1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190919132002eucas1p19ceac65f49939be3152affb4d6a426a1
References: <20190917192113.GA26604@bogus>
        <CGME20190919132002eucas1p19ceac65f49939be3152affb4d6a426a1@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maciej Falkowski <m.falkowski@samsung.com>

Convert Samsung Exynos IOMMU H/W, System Memory Management Unit
to newer dt-schema format.

Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
v4:
- Rename commit message to match common style
- Remove '"pclk", "aclk"' option from clock-names property.
  Some of bindings are incompatible with that and they will be fixed with
  another patch.
- Remove unneeded description of clock-names property.
- Remove type description from power-domains property as it is
  already a common property.
- Rename node names to match generic names,
  specifically: sysmmu -> iommu, gsc -> scaler

- Add include directive in examples to include
  clock macros. This increases readability of the example
  as clock macros do not have to be substituted with numerical values
  which makes examples more self-explanatory and natural.

Best regards,
Maciej Falkowski
---
 .../bindings/iommu/samsung,sysmmu.txt         |  67 -----------
 .../bindings/iommu/samsung,sysmmu.yaml        | 108 ++++++++++++++++++
 2 files changed, 108 insertions(+), 67 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iommu/samsung,sysmmu.txt
 create mode 100644 Documentation/devicetree/bindings/iommu/samsung,sysmmu.yaml

diff --git a/Documentation/devicetree/bindings/iommu/samsung,sysmmu.txt b/Documentation/devicetree/bindings/iommu/samsung,sysmmu.txt
deleted file mode 100644
index 525ec82615a6..000000000000
--- a/Documentation/devicetree/bindings/iommu/samsung,sysmmu.txt
+++ /dev/null
@@ -1,67 +0,0 @@
-Samsung Exynos IOMMU H/W, System MMU (System Memory Management Unit)
-
-Samsung's Exynos architecture contains System MMUs that enables scattered
-physical memory chunks visible as a contiguous region to DMA-capable peripheral
-devices like MFC, FIMC, FIMD, GScaler, FIMC-IS and so forth.
-
-System MMU is an IOMMU and supports identical translation table format to
-ARMv7 translation tables with minimum set of page properties including access
-permissions, shareability and security protection. In addition, System MMU has
-another capabilities like L2 TLB or block-fetch buffers to minimize translation
-latency.
-
-System MMUs are in many to one relation with peripheral devices, i.e. single
-peripheral device might have multiple System MMUs (usually one for each bus
-master), but one System MMU can handle transactions from only one peripheral
-device. The relation between a System MMU and the peripheral device needs to be
-defined in device node of the peripheral device.
-
-MFC in all Exynos SoCs and FIMD, M2M Scalers and G2D in Exynos5420 has 2 System
-MMUs.
-* MFC has one System MMU on its left and right bus.
-* FIMD in Exynos5420 has one System MMU for window 0 and 4, the other system MMU
-  for window 1, 2 and 3.
-* M2M Scalers and G2D in Exynos5420 has one System MMU on the read channel and
-  the other System MMU on the write channel.
-
-For information on assigning System MMU controller to its peripheral devices,
-see generic IOMMU bindings.
-
-Required properties:
-- compatible: Should be "samsung,exynos-sysmmu"
-- reg: A tuple of base address and size of System MMU registers.
-- #iommu-cells: Should be <0>.
-- interrupts: An interrupt specifier for interrupt signal of System MMU,
-	      according to the format defined by a particular interrupt
-	      controller.
-- clock-names: Should be "sysmmu" or a pair of "aclk" and "pclk" to gate
-	       SYSMMU core clocks.
-	       Optional "master" if the clock to the System MMU is gated by
-	       another gate clock other core  (usually main gate clock
-	       of peripheral device this SYSMMU belongs to).
-- clocks: Phandles for respective clocks described by clock-names.
-- power-domains: Required if the System MMU is needed to gate its power.
-	  Please refer to the following document:
-	  Documentation/devicetree/bindings/power/pd-samsung.txt
-
-Examples:
-	gsc_0: gsc@13e00000 {
-		compatible = "samsung,exynos5-gsc";
-		reg = <0x13e00000 0x1000>;
-		interrupts = <0 85 0>;
-		power-domains = <&pd_gsc>;
-		clocks = <&clock CLK_GSCL0>;
-		clock-names = "gscl";
-		iommus = <&sysmmu_gsc0>;
-	};
-
-	sysmmu_gsc0: sysmmu@13e80000 {
-		compatible = "samsung,exynos-sysmmu";
-		reg = <0x13E80000 0x1000>;
-		interrupt-parent = <&combiner>;
-		interrupts = <2 0>;
-		clock-names = "sysmmu", "master";
-		clocks = <&clock CLK_SMMU_GSCL0>, <&clock CLK_GSCL0>;
-		power-domains = <&pd_gsc>;
-		#iommu-cells = <0>;
-	};
diff --git a/Documentation/devicetree/bindings/iommu/samsung,sysmmu.yaml b/Documentation/devicetree/bindings/iommu/samsung,sysmmu.yaml
new file mode 100644
index 000000000000..ecde98da5b72
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/samsung,sysmmu.yaml
@@ -0,0 +1,108 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iommu/samsung,sysmmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos IOMMU H/W, System MMU (System Memory Management Unit)
+
+maintainers:
+  - Marek Szyprowski <m.szyprowski@samsung.com>
+
+description: |+
+  Samsung's Exynos architecture contains System MMUs that enables scattered
+  physical memory chunks visible as a contiguous region to DMA-capable peripheral
+  devices like MFC, FIMC, FIMD, GScaler, FIMC-IS and so forth.
+
+  System MMU is an IOMMU and supports identical translation table format to
+  ARMv7 translation tables with minimum set of page properties including access
+  permissions, shareability and security protection. In addition, System MMU has
+  another capabilities like L2 TLB or block-fetch buffers to minimize translation
+  latency.
+
+  System MMUs are in many to one relation with peripheral devices, i.e. single
+  peripheral device might have multiple System MMUs (usually one for each bus
+  master), but one System MMU can handle transactions from only one peripheral
+  device. The relation between a System MMU and the peripheral device needs to be
+  defined in device node of the peripheral device.
+
+  MFC in all Exynos SoCs and FIMD, M2M Scalers and G2D in Exynos5420 has 2 System
+  MMUs.
+  * MFC has one System MMU on its left and right bus.
+  * FIMD in Exynos5420 has one System MMU for window 0 and 4, the other system MMU
+    for window 1, 2 and 3.
+  * M2M Scalers and G2D in Exynos5420 has one System MMU on the read channel and
+    the other System MMU on the write channel.
+
+  For information on assigning System MMU controller to its peripheral devices,
+  see generic IOMMU bindings.
+
+properties:
+  compatible:
+    const: samsung,exynos-sysmmu
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    oneOf:
+      - items:
+        - const: sysmmu
+      - items:
+        - const: sysmmu
+        - const: master
+      - items:
+        - const: aclk
+        - const: pclk
+
+  "#iommu-cells":
+    const: 0
+
+  power-domains:
+    description: |
+      Required if the System MMU is needed to gate its power.
+      Please refer to the following document:
+      Documentation/devicetree/bindings/power/pd-samsung.txt
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - "#iommu-cells"
+
+examples:
+  - |
+    #include <dt-bindings/clock/exynos5250.h>
+
+    gsc_0: scaler@13e00000 {
+      compatible = "samsung,exynos5-gsc";
+      reg = <0x13e00000 0x1000>;
+      interrupts = <0 85 0>;
+      power-domains = <&pd_gsc>;
+      clocks = <&clock CLK_GSCL0>;
+      clock-names = "gscl";
+      iommus = <&sysmmu_gsc0>;
+    };
+
+    sysmmu_gsc0: iommu@13e80000 {
+      compatible = "samsung,exynos-sysmmu";
+      reg = <0x13E80000 0x1000>;
+      interrupt-parent = <&combiner>;
+      interrupts = <2 0>;
+      clock-names = "sysmmu", "master";
+      clocks = <&clock CLK_SMMU_GSCL0>,
+               <&clock CLK_GSCL0>;
+      power-domains = <&pd_gsc>;
+      #iommu-cells = <0>;
+    };
+
-- 
2.17.1



