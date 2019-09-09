Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27984C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 12:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD8B1218DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 12:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Dj/5EjTI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404859AbfIIMmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 08:42:10 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:36732 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728254AbfIIMmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 08:42:10 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190909124207euoutp01ea281b0f4e581edcb37b54ba43af070a~CxaPdnFcQ0272202722euoutp013
        for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2019 12:42:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190909124207euoutp01ea281b0f4e581edcb37b54ba43af070a~CxaPdnFcQ0272202722euoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568032927;
        bh=GQfp0KfghI3ZFpEMs3T7THOxuMfa9A+8AFLGOs78JFs=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Dj/5EjTIoozbFyKg18tXjO6Oq+fvmvL6QAmIOQpH2417N2ZZ2uWBxvxrZYEro2Xtt
         WPnRRA9LOzUV7Ark+mJHnnvjsWhl0tgO/J4mnOMNDdVP2gH7Yfc1aMmFC0eJMfZwoT
         mrscmzZTafdga/tmYCsohRvIuJ7e72E3FpVE2WG0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190909124207eucas1p2971d0a54c6221a33cb5ea060c8d7e6d4~CxaO4vuzv0605306053eucas1p2q;
        Mon,  9 Sep 2019 12:42:07 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 1D.34.04309.E98467D5; Mon,  9
        Sep 2019 13:42:06 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190909124206eucas1p13e4ffd50a3bbc6f390cb63f11034c34c~CxaOFuQg_0915909159eucas1p15;
        Mon,  9 Sep 2019 12:42:06 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190909124206eusmtrp1cf57e34114dc588b256456042e77cdc6~CxaN3WCvi0603806038eusmtrp1v;
        Mon,  9 Sep 2019 12:42:06 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-04-5d76489e01cf
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 34.AD.04166.E98467D5; Mon,  9
        Sep 2019 13:42:06 +0100 (BST)
Received: from AMDC2459.DIGITAL.local (unknown [106.120.51.95]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190909124205eusmtip117e7a08607f65ff739475e7d54211a86~CxaNWmbf60611406114eusmtip1K;
        Mon,  9 Sep 2019 12:42:05 +0000 (GMT)
From:   Maciej Falkowski <m.falkowski@samsung.com>
To:     linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     krzk@kernel.org, robh+dt@kernel.org, m.falkowski@samsung.com,
        mark.rutland@arm.com, m.szyprowski@samsung.com, a.hajda@samsung.com
Subject: [PATCH] dt-bindings: arm: samsung: Convert Samsung Exynos IOMMU
 H/W, System MMU to dt-schema
Date:   Mon,  9 Sep 2019 14:41:47 +0200
Message-Id: <20190909124147.17510-1-m.falkowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsWy7djPc7rzPcpiDXgtbq07x2ox/wiQOH9+
        A7vF5V1z2CxmnN/HZPGgeR2bxdojd9ktll6/yGTRuvcIuwOnx5p5axg9Nq3qZPPo27KK0ePz
        JrkAligum5TUnMyy1CJ9uwSujK0LdrEX7LKt2LT4FVMD4zuDLkZODgkBE4k713+xdzFycQgJ
        rGCU2DHjDSuE84VR4m3LDSYI5zOjxNHzhxhhWiZ//Q7VspxRYlHLaUa4lu4jf9hAqtgEDCT6
        3+xlAbFFBBIlbv/uB+tgFmhnlDh74A4zSEJYIF3iz6l/rCA2i4CqxJzePWA2r4CNxKzOpewQ
        6+QlVm84wAzSLCFwn03i4435LBAJF4l3U2GKhCVeHd8CZctInJ7cA1TDAWRXS1z7JgvR28Io
        cX3aWzaIGmuJP6smsoHUMAtoSqzfpQ9R7ihxrDcYwuSTuPFWEKSYGcictG06M0SYV6KjTQjC
        VJV4MyEWYpy0ROua/dDg8ZCY9LwB7EQhgViJd9PvME5glJuFsGkBI+MqRvHU0uLc9NRio7zU
        cr3ixNzi0rx0veT83E2MwHRw+t/xLzsYd/1JOsQowMGoxMO7w7wsVog1say4MvcQowQHs5II
        7/W+0lgh3pTEyqrUovz4otKc1OJDjNIcLErivNUMD6KFBNITS1KzU1MLUotgskwcnFINjIu2
        KO1/9HBd5Z3bE76mOSiE95X0eR/M/jJx2cqbuvUaT0X27pC5VHlD+sodWdPXj8xKNxdv8g62
        f5H5I9bvdvyN2wenZfzsMJM9/2ZjkkTyqdsak4+6H+T9PSNNhJvxyIrYA4Gfnk4qXXSefY1i
        YSB76oOQmQ5/vd6rhP5WnrHT0krGo5S/QUuJpTgj0VCLuag4EQCdy8IsAwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsVy+t/xu7rzPMpiDVofsFrcWneO1WL+ESBx
        /vwGdovLu+awWcw4v4/J4kHzOjaLtUfuslssvX6RyaJ17xF2B06PNfPWMHpsWtXJ5tG3ZRWj
        x+dNcgEsUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2
        CXoZWxfsYi/YZVuxafErpgbGdwZdjJwcEgImEpO/fmcHsYUEljJKdP9OgIhLS+y/9pEdwhaW
        +HOti62LkQuo5hOjxI7Hz1hBEmwCBhL9b/aygNgiAskSiw/vZAQpYhboZ5SY9HYtWEJYIFVi
        9YUWJhCbRUBVYk7vHrBmXgEbiVmdS6E2yEus3nCAeQIjzwJGhlWMIqmlxbnpucWGesWJucWl
        eel6yfm5mxiB4bjt2M/NOxgvbQw+xCjAwajEw7vDvCxWiDWxrLgy9xCjBAezkgjv9b7SWCHe
        lMTKqtSi/Pii0pzU4kOMpkDLJzJLiSbnA2MlryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpi
        SWp2ampBahFMHxMHp1QDY3ba13CXKQvvif+ffPhyV2ldzZIzf8pKS4JLJCOdZ4c8zzkhfets
        hv76RUUJugG3t6Q3PJEQXfbTwc91td+y5/ONuzx6Vxw5/Vph2q0Z73+XfvryZ9m6w5/1rmyS
        +l2+OvvPVOuc6p8JvebbKzWiDl+T3yJ3J8elpaT/A2fM3hsrk7rXKFVXVSmxFGckGmoxFxUn
        AgBkNKptXQIAAA==
X-CMS-MailID: 20190909124206eucas1p13e4ffd50a3bbc6f390cb63f11034c34c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190909124206eucas1p13e4ffd50a3bbc6f390cb63f11034c34c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190909124206eucas1p13e4ffd50a3bbc6f390cb63f11034c34c
References: <CGME20190909124206eucas1p13e4ffd50a3bbc6f390cb63f11034c34c@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Samsung Exynos IOMMU H/W, System Memory Management Unit
to newer dt-schema format.

Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 .../bindings/iommu/samsung,sysmmu.txt         |  67 ------------
 .../bindings/iommu/samsung,sysmmu.yaml        | 102 ++++++++++++++++++
 2 files changed, 102 insertions(+), 67 deletions(-)
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
index 000000000000..6c40dfb86899
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/samsung,sysmmu.yaml
@@ -0,0 +1,102 @@
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
+  reg:
+    description: A tuple of base address and size of System MMU registers.
+    maxItems: 1
+  interrupts:
+    description: |
+      An interrupt specifier for interrupt signal of System MMU,
+      according to the format defined by a particular interrupt
+      controller.
+  clocks:
+    description: Phandles for respective clocks described by clock-names.
+  clock-names:
+    description: |
+      Should be "sysmmu" or a pair of "aclk" and "pclk" to gate
+      SYSMMU core clocks.
+      Optional "master" if the clock to the System MMU is gated by
+      another gate clock other core  (usually main gate clock
+      of peripheral device this SYSMMU belongs to).
+    minItems: 1
+    maxItems: 2
+  "#iommu-cells":
+    const: 0
+    description: Should be <0>.
+  power-domains:
+    description: |
+      Required if the System MMU is needed to gate its power.
+      Please refer to the following document:
+      Documentation/devicetree/bindings/power/pd-samsung.txt
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
+    gsc_0: gsc@13e00000 {
+      compatible = "samsung,exynos5-gsc";
+      reg = <0x13e00000 0x1000>;
+      interrupts = <0 85 0>;
+      power-domains = <&pd_gsc>;
+      clocks = <&clock 0>; //CLK_GSCL0
+      clock-names = "gscl";
+      iommus = <&sysmmu_gsc0>;
+    };
+  - |
+    sysmmu_gsc0: sysmmu@13e80000 {
+      compatible = "samsung,exynos-sysmmu";
+      reg = <0x13E80000 0x1000>;
+      interrupt-parent = <&combiner>;
+      interrupts = <2 0>;
+      clock-names = "sysmmu", "master";
+      clocks = <&clock 0>, // CLK_SMMU_GSCL0
+               <&clock 0>; // CLK_GSCL0
+      power-domains = <&pd_gsc>;
+      #iommu-cells = <0>;
+    };
+
-- 
2.17.1

