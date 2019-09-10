Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6459C49ED8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 15:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66473217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 15:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="N2IIsd7W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394053AbfIJPwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 11:52:44 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33547 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731689AbfIJPwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 11:52:43 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190910155241euoutp0274667bfa84644b687fecc2074f690bef~DHp6B4CKC0617606176euoutp02e
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 15:52:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190910155241euoutp0274667bfa84644b687fecc2074f690bef~DHp6B4CKC0617606176euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568130761;
        bh=/YsZZzdShPctD2nTGbZKdLhDE+/Uegf2N++UCSMGCKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N2IIsd7WI6JJ4UrNcpE/pQZS9lhq2+QnbV3pHWLgAqz5cjKtZV0lVzlVEdITjuf2Z
         MXT1hkM4ZI09U/hNWzOEGDPhKGCDA7g+5W5QamqFL850XxVnBDvxfFsgFrr+K4jAhq
         /XtZ6mIjYnflLMOBZ3u9IItTu88QdT1LJ9X/LlnY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190910155240eucas1p1eed26b65c7cdaf6e7bc829b0aaabea84~DHp5iOw992696926969eucas1p1u;
        Tue, 10 Sep 2019 15:52:40 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 51.46.04374.8C6C77D5; Tue, 10
        Sep 2019 16:52:40 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190910155240eucas1p26b343fd58e0f7b7fbe8dae06fe565de7~DHp40VGw21780117801eucas1p2f;
        Tue, 10 Sep 2019 15:52:40 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190910155239eusmtrp2be481cda038426def5d4949c23980216~DHp4mNpRn2338023380eusmtrp26;
        Tue, 10 Sep 2019 15:52:39 +0000 (GMT)
X-AuditID: cbfec7f5-4ddff70000001116-12-5d77c6c8b439
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D1.A5.04117.7C6C77D5; Tue, 10
        Sep 2019 16:52:39 +0100 (BST)
Received: from AMDC2459.DIGITAL.local (unknown [106.120.51.95]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190910155239eusmtip195392ebcb6c265300a922df528b3fe57~DHp4G0AV_1008010080eusmtip1l;
        Tue, 10 Sep 2019 15:52:39 +0000 (GMT)
From:   Maciej Falkowski <m.falkowski@samsung.com>
To:     linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     krzk@kernel.org, robh+dt@kernel.org, m.falkowski@samsung.com,
        mark.rutland@arm.com, m.szyprowski@samsung.com, a.hajda@samsung.com
Subject: [PATCH v2] dt-bindings: arm: samsung: Convert Samsung Exynos IOMMU
 H/W, System MMU to dt-schema
Date:   Tue, 10 Sep 2019 17:52:07 +0200
Message-Id: <20190910155207.6569-1-m.falkowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAJKOXPf9zBSPnQgm0tVA_6N+mgR7xiCskf8JUOmQMG8C+jF8pA@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsWy7djP87onjpXHGnz8omJxa905Vov5R4DE
        +fMb2C0u75rDZjHj/D4miwfN69gs1h65y26x9PpFJovWvUfYHTg91sxbw+ixaVUnm0ffllWM
        Hp83yQWwRHHZpKTmZJalFunbJXBlfPu+grmg2ani29Y/bA2Mf427GDk5JARMJH7+WcXaxcjF
        ISSwglFiw9IDjBDOF0aJtY8XskE4nxkldjbPYoRp2bLtOjNEYjmjxP+F55jgWpZu/QhWxSZg
        INH/Zi8LiC0ikChx+3c/O0gRs0A7o8TZA3eYQRLCAlkSjzZsYgexWQRUJT60nQCL8wpYS7y8
        eoUNYp28xOoNB8DinAKBEv+v9oNtkxD4zibx7esfZogiF4knM6axQtjCEq+Ob2GHsGUk/u+c
        D9TAAWRXS1z7JgvR28IocX3aW6gF1hJ/Vk1kA6lhFtCUWL9LHyLsKPFk0Q2oVj6JG28FQcLM
        QOakbdOZIcK8Eh1tQhCmqsSbCbEQjdISrWv2Q8PKQ2Lu90Nge4QEljBK3H9ZM4FRfhbCqgWM
        jKsYxVNLi3PTU4uN81LL9YoTc4tL89L1kvNzNzECk8Xpf8e/7mDc9yfpEKMAB6MSD29HS3ms
        EGtiWXFl7iFGCQ5mJRHe632lsUK8KYmVValF+fFFpTmpxYcYpTlYlMR5qxkeRAsJpCeWpGan
        phakFsFkmTg4pRoYbc49LF2ary74dpXkN7Xbk1tU3XIuNqinznwTyhq2fs/yBQFJff/eHJFa
        JNVddPG+cfqcUzem9qUztahoL5U/FTjl9Kx/Wf7zNp9d3rjgQqWvsNo9w4Zlos1b89hLqrU1
        Xp43EK57+8xTK6VuxyTxqCxt5gW+q6oE1V2/FcjM+rEkNzd34ceHSizFGYmGWsxFxYkATLxG
        xBIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsVy+t/xu7rHj5XHGvw6q2txa905Vov5R4DE
        +fMb2C0u75rDZjHj/D4miwfN69gs1h65y26x9PpFJovWvUfYHTg91sxbw+ixaVUnm0ffllWM
        Hp83yQWwROnZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunb
        JehlfPu+grmg2ani29Y/bA2Mf427GDk5JARMJLZsu87cxcjFISSwlFGi6e0ENoiEtMT+ax/Z
        IWxhiT/Xutggij4xSqy91Q1WxCZgINH/Zi8LiC0ikCyx+PBORpAiZoF+RolJb9eCJYQFMiR+
        zFnHBGKzCKhKfGg7wQxi8wpYS7y8egVqm7zE6g0HwOKcAoES/6/2g9ULCQRITL+zgXUCI98C
        RoZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgQG87djPLTsYu94FH2IU4GBU4uHtaCmPFWJN
        LCuuzD3EKMHBrCTCe72vNFaINyWxsiq1KD++qDQntfgQoynQUROZpUST84HRlVcSb2hqaG5h
        aWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgXFtYcA5npmTjt53DU9TCS6yWr3Z
        eGLRA5ufSlMWeCmq9q6ecJftSsGK4KO5bUdX7g+cW1U48emmG4+XfNHXmPckbZXWoQ1pLzgd
        viwT4KuqOh34Z6VzzvsLjY8L2MVmpvzblMtbkMeUUcu1dErI+8IpDkfFkkxuPOl/0L711/Sj
        lT6Kh9qTd91TYinOSDTUYi4qTgQAMIZdoHYCAAA=
X-CMS-MailID: 20190910155240eucas1p26b343fd58e0f7b7fbe8dae06fe565de7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190910155240eucas1p26b343fd58e0f7b7fbe8dae06fe565de7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190910155240eucas1p26b343fd58e0f7b7fbe8dae06fe565de7
References: <CAJKOXPf9zBSPnQgm0tVA_6N+mgR7xiCskf8JUOmQMG8C+jF8pA@mail.gmail.com>
        <CGME20190910155240eucas1p26b343fd58e0f7b7fbe8dae06fe565de7@eucas1p2.samsung.com>
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

New changes:
- style fixes including missing empty lines,
deletion of unneeded descriptions

- fix mistake where one example was split 
into two separete ones.

There are some updates with clock description. I have spoken with
Marek Szyprowski and the right setup for clocks seems to be two pairs: 
"sysmmu" with optional "master" or a pair of "aclk" + "pclk".

The option: "aclk" + "pclk" + "master" was never used in any 
of device bindings and there are none compilation problems with that.

In so, clock-names are rewritten to handle this version
and maximal clock number is set to two.

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
index 000000000000..85d1a251f2ff
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
+    description: |
+      An interrupt specifier for interrupt signal of System MMU,
+      according to the format defined by a particular interrupt
+      controller.
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    oneOf:
+      - contains:
+          enum:
+            - sysmmu
+            - master
+      - contains:
+          enum:
+            - aclk
+            - pclk
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

