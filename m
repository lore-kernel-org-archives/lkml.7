Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C45C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 11:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 699A02089F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 11:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VU/wzzYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfIKLFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 07:05:04 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59258 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfIKLFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 07:05:04 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190911110501euoutp01ad13556397d9dbf644541f4dd50ea8c3~DXYCOZYN51795817958euoutp01u
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 11:05:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190911110501euoutp01ad13556397d9dbf644541f4dd50ea8c3~DXYCOZYN51795817958euoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568199902;
        bh=WSauEBVwysVYicF2nbz4sA7JWfa0qdbfulQkkofDGzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VU/wzzYiERpPbTM+F3Sv13uhQoZ0hbpajqX0AU+HpsABwOXENpHCcM0R6WXsbU0EE
         cTgB4haES65Ot84IVMC0mN15kAXmeIMsapBrv5xgpYGM9vwRdaRK+r1bF7K0V8HTMj
         8IADhZ/GuvYfuEZnNgXNFzc2XhOKk9/zV4QLVEAw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190911110501eucas1p1c1b16cf1212320315cafe7bb9e6535c9~DXYBaMMbd0606106061eucas1p1t;
        Wed, 11 Sep 2019 11:05:01 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id CD.52.04374.CD4D87D5; Wed, 11
        Sep 2019 12:05:00 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190911110500eucas1p2e1304a19e2e75ee43d80fcdc3b871237~DXYAkk2vd1572415724eucas1p2s;
        Wed, 11 Sep 2019 11:05:00 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190911110459eusmtrp2adfd6162d569b96fb560c7837ef6d1ba~DXYAWZK2R0325203252eusmtrp2W;
        Wed, 11 Sep 2019 11:04:59 +0000 (GMT)
X-AuditID: cbfec7f5-4ddff70000001116-89-5d78d4dc9ade
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 6B.F6.04166.BD4D87D5; Wed, 11
        Sep 2019 12:04:59 +0100 (BST)
Received: from AMDC2459.DIGITAL.local (unknown [106.120.51.95]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190911110459eusmtip25daf33a426cf7146d85c7d8e9db39474~DXX-zIwF82328523285eusmtip2Y;
        Wed, 11 Sep 2019 11:04:59 +0000 (GMT)
From:   Maciej Falkowski <m.falkowski@samsung.com>
To:     linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     krzk@kernel.org, robh+dt@kernel.org, m.falkowski@samsung.com,
        mark.rutland@arm.com, m.szyprowski@samsung.com, a.hajda@samsung.com
Subject: [PATCH v3] dt-bindings: arm: samsung: Convert Samsung Exynos IOMMU
 H/W, System MMU to dt-schema
Date:   Wed, 11 Sep 2019 13:04:46 +0200
Message-Id: <20190911110446.32058-1-m.falkowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAJKOXPeojuk1UrYo9Wakaaq4VJt3Ts22Vi-V5xzwAXoFU5+tcA@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRmVeSWpSXmKPExsWy7djPc7p3rlTEGvy7bGhxa905Vov5R4DE
        +fMb2C0u75rDZjHj/D4miwfN69gs1h65y26x9PpFJovWvUfYHTg91sxbw+ixaVUnm0ffllWM
        Hp83yQWwRHHZpKTmZJalFunbJXBlrNvJWvDbrqL/6BPGBsYzhl2MnBwSAiYSHffbmbsYuTiE
        BFYwSmx90MQI4XxhlNj0+w0ThPOZUaJ13xdWmJZHP56wQSSWM0pc3bCPGa7lwuyr7CBVbAIG
        Ev1v9rKA2CICiRK3f/ezgxQxC7QzSpw9cIcZJCEskCVxsKmLDcRmEVCV+Lf9MhOIzStgI7Gx
        sxlqnbzE6g0HwOo5BQIl2vacArtJQuA7m8S//TBFLhIX/l1hgbCFJV4d38IOYctI/N85H6iB
        A8iulrj2TRait4VR4vq0t2wQNdYSf1ZNZAOpYRbQlFi/Sx8i7Cjx5s59NohWPokbbwVBwsxA
        5qRt05khwrwSHW1CEKaqxJsJsRCN0hKta/YzQtgeEs9f94MdLySwhFHi6DWJCYzysxBWLWBk
        XMUonlpanJueWmycl1quV5yYW1yal66XnJ+7iRGYKk7/O/51B+O+P0mHGAU4GJV4eG+IVsQK
        sSaWFVfmHmKU4GBWEuF90AIU4k1JrKxKLcqPLyrNSS0+xCjNwaIkzlvN8CBaSCA9sSQ1OzW1
        ILUIJsvEwSnVwNha+Ym9UvO3UJOg0tM906bfV1Qy5+KJ0TmSlTT3idfm2RG/FsiukArgr2Hz
        s5go3pz/w201X0LjnT33t7IInAgWWHtt56d5H29vv/XVlIu7J+/jet8eUeklll2BFyoOXb2T
        WRkza9sEhU53J8sL1ystLVicl+pXvtnztEzgndn3vpKfZ/fV/FJiKc5INNRiLipOBAAWFo1c
        EQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsVy+t/xe7q3r1TEGuxtMrG4te4cq8X8I0Di
        /PkN7BaXd81hs5hxfh+TxYPmdWwWa4/cZbdYev0ik0Xr3iPsDpwea+atYfTYtKqTzaNvyypG
        j8+b5AJYovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/Tt
        EvQy1u1kLfhtV9F/9AljA+MZwy5GTg4JAROJRz+esHUxcnEICSxllPj7agUbREJaYv+1j+wQ
        trDEn2tdYHEhgU+MEpev8IHYbAIGEv1v9rKA2CICyRKLD+9kBBnELNDPKDHp7VqwhLBAhsSd
        vf1gg1gEVCX+bb/MBGLzCthIbOxsZoVYIC+xesMBZhCbUyBQom3PKSaIZQESZ47eZJ3AyLeA
        kWEVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYPBuO/Zz8w7GSxuDDzEKcDAq8fA+aCuPFWJN
        LCuuzD3EKMHBrCTC+6ClIlaINyWxsiq1KD++qDQntfgQoynQUROZpUST84GRlVcSb2hqaG5h
        aWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgbGvPfFs4Avb/UYp+febFwWbrOZ6
        rXBW0+7h7P9OK/cuEdVzeW2Qumbt8dayhb5+N263nSwoqPqy52XHi9RLKeuPKDQqT9rt85Kx
        J2PlP4ek46pr555/6pNZJFC7/tSXZO4b9hvDPjGpCny3npT1wezjcdfC5IPmOscu2Z09cu/g
        1ZV/WPdsOuqhxFKckWioxVxUnAgAvmHjanQCAAA=
X-CMS-MailID: 20190911110500eucas1p2e1304a19e2e75ee43d80fcdc3b871237
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190911110500eucas1p2e1304a19e2e75ee43d80fcdc3b871237
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190911110500eucas1p2e1304a19e2e75ee43d80fcdc3b871237
References: <CAJKOXPeojuk1UrYo9Wakaaq4VJt3Ts22Vi-V5xzwAXoFU5+tcA@mail.gmail.com>
        <CGME20190911110500eucas1p2e1304a19e2e75ee43d80fcdc3b871237@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Samsung Exynos IOMMU H/W, System Memory Management Unit
to newer dt-schema format.

Update clock description.

Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
Hi Krzysztof,

Thank you for feedback.

v3:

- remove obsolete interrupts description and
set its maxItems to one. There are some incompatible
files which will be fixed with another patch.

- clock-names pattern is changed to your more precise 
version. I also added option "pclk" + "aclk" as some
bindings are also using it.

Best regards,
Maciej Falkowski
---
 .../bindings/iommu/samsung,sysmmu.txt         |  67 -----------
 .../bindings/iommu/samsung,sysmmu.yaml        | 112 ++++++++++++++++++
 2 files changed, 112 insertions(+), 67 deletions(-)
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
index 000000000000..a8141d6c326a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/samsung,sysmmu.yaml
@@ -0,0 +1,112 @@
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
+      - items:
+        - const: pclk
+        - const: aclk
+    description: |
+      Should be "sysmmu" with optional "master"
+      or a pair "aclk" with "pclk".
+
+  "#iommu-cells":
+    const: 0
+
+  power-domains:
+    $ref: /schemas/types.yaml#/definitions/phandle
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
+      clocks = <&clock 0>; // CLK_GSCL0
+      clock-names = "gscl";
+      iommus = <&sysmmu_gsc0>;
+    };
+
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

