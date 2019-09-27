Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26A2C388F3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 14:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 703892146E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 14:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JOlbtDnB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfI0OdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 10:33:17 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:37760 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfI0OdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 10:33:17 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190927143314euoutp0174f599509d7316e6fc28f65fdd2570a0~IUiZkRcTS1545915459euoutp01Z
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 14:33:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190927143314euoutp0174f599509d7316e6fc28f65fdd2570a0~IUiZkRcTS1545915459euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569594795;
        bh=hiJbO/O5KGuNuMhqp/5c2SuOZIf79Yix8ZcvFieL2Mg=;
        h=From:To:Cc:Subject:Date:References:From;
        b=JOlbtDnBj6kBsDPiX4+3E6Fa4uQ/QLX0X90pIthuoyqV7HA2Djc437/sfLxD/YP6s
         qkvkC8TIXjGcB9y6tstcaC9npsiyW7L/f8vSEeWch1UZjERrnJg5fb/lQWIHZLdeN1
         j1Ii+mttta/bSIrQT3POKaIVFlycH4exKN0lF5tY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190927143314eucas1p1e8e031c5d7cd0b00ff7737c27491b61f~IUiZTsZ2k1143111431eucas1p13;
        Fri, 27 Sep 2019 14:33:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F8.88.04469.AAD1E8D5; Fri, 27
        Sep 2019 15:33:14 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190927143314eucas1p2d419866cd740207426cd37cb6fdff468~IUiY6KbjF1734917349eucas1p2-;
        Fri, 27 Sep 2019 14:33:14 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190927143314eusmtrp162aa909198e6ed383fa3d483e74658db~IUiY5caje3086830868eusmtrp1G;
        Fri, 27 Sep 2019 14:33:14 +0000 (GMT)
X-AuditID: cbfec7f2-569ff70000001175-c9-5d8e1daaff9a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 69.25.04117.AAD1E8D5; Fri, 27
        Sep 2019 15:33:14 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190927143313eusmtip1c0bd0ccf00d3fd9df7f66398d6fa7574~IUiYWmjgP0742707427eusmtip17;
        Fri, 27 Sep 2019 14:33:13 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Inki Dae <inki.dae@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Maciej Falkowski <m.falkowski@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v3] dt-bindings: gpu: Convert Samsung Image Scaler to
 dt-schema
Date:   Fri, 27 Sep 2019 16:33:06 +0200
Message-Id: <20190927143306.12133-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRmVeSWpSXmKPExsWy7djPc7qrZPtiDb7c1rCYf+Qcq8WVr+/Z
        LCbdn8Bicf78BnaLy7vmsFnMOL+PyeJB8zo2i7VH7rJbLL1+kcmide8RdgcujzXz1jB6bFrV
        yeZxv/s4k0ffllWMHp83yQWwRnHZpKTmZJalFunbJXBlXDmylalggXzFqt1rmRsYz0l0MXJy
        SAiYSKw/vYAFxBYSWMEoseSPbhcjF5D9hVFixutPbBDOZ0aJP1P3McF0tCxoZoRILGeUuPjx
        HlQ7UMv1WfIgNpuAoUTX2y6wbhGBJkaJKztfsYM4zAIfGCUObp7HBlIlLBAo0fnnLZjNIqAq
        MfHLEzCbV8BW4tHm6VDr5CVWbzjADNIsIfCeTaJlSi8rRMJF4v2+T2wQtrDEq+Nb2CFsGYnT
        k3tYIBqaGSUenlvLDuH0MEpcbprBCFFlLXH4+EWgSRxAN2lKrN+lD2JKCDhKzF0SCWHySdx4
        KwhSzAxkTto2nRkizCvR0SYEMUNNYtbxdXBbD164xAxhe0gsa53EBgmUWIn/Lw8yTmCUm4Ww
        agEj4ypG8dTS4tz01GLDvNRyveLE3OLSvHS95PzcTYzAVHH63/FPOxi/Xko6xCjAwajEw3uB
        vS9WiDWxrLgy9xCjBAezkgivb2RPrBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeaoYH0UIC6Ykl
        qdmpqQWpRTBZJg5OqQZGu/n/mV8cjdfmW+u2QEZVcNKeXtfYSZpilb1pfbGtJaX90sccsrgD
        m5emhCXP5bHS2Hqu5dOZ447l5acv7T2j+YuzaaHTLPOTBamT//NmLz0me9Lz25TLRvlz16/T
        lIx3Uvzxne1GNJuYauHZKU06O5jzdF+d/q2dNy25/MDZMinpL9OcNLmUWIozEg21mIuKEwFJ
        7kkCEQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsVy+t/xu7qrZPtiDRY847aYf+Qcq8WVr+/Z
        LCbdn8Bicf78BnaLy7vmsFnMOL+PyeJB8zo2i7VH7rJbLL1+kcmide8RdgcujzXz1jB6bFrV
        yeZxv/s4k0ffllWMHp83yQWwRunZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq
        6dvZpKTmZJalFunbJehlXDmylalggXzFqt1rmRsYz0l0MXJySAiYSLQsaGbsYuTiEBJYyijR
        9PYRC0RCRuLktAZWCFtY4s+1LjaIok+MEq/e3mQESbAJGEp0vYVIiAi0MUp8fnyFGcRhFvjC
        KLH57w92kCphAX+Jezeug9ksAqoSE788YQOxeQVsJR5tns4EsUJeYvWGA8wTGHkWMDKsYhRJ
        LS3OTc8tNtIrTswtLs1L10vOz93ECAzTbcd+btnB2PUu+BCjAAejEg9vBWtfrBBrYllxZe4h
        RgkOZiURXt/Inlgh3pTEyqrUovz4otKc1OJDjKZAyycyS4km5wNjKK8k3tDU0NzC0tDc2NzY
        zEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA6Po26T4f0u8272nuX/bW21q9PSaqGSJk0uI
        zFQz86umcwoVKyViPu6tUP1UEBAy8fTMpYe4JCu2zzbaEcXhPv/44TOpT2PLwxYmhe1vDDZa
        YfTpqkfn0nXHM3dbXZtwV6Fo5ZIl/v3nrPZsP5OldOv8qdzQsGmlR9uFTiV7f5GbVOk3LfHJ
        79VKLMUZiYZazEXFiQCaoSdsaQIAAA==
X-CMS-MailID: 20190927143314eucas1p2d419866cd740207426cd37cb6fdff468
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190927143314eucas1p2d419866cd740207426cd37cb6fdff468
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190927143314eucas1p2d419866cd740207426cd37cb6fdff468
References: <CGME20190927143314eucas1p2d419866cd740207426cd37cb6fdff468@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maciej Falkowski <m.falkowski@samsung.com>

Convert Samsung Image Scaler to newer dt-schema format.

Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
v3:
- Fixed description of 'clocks' property:
rather than 'mscl clock', 'pclk clock'
- Added empty line within if-else statement
- Added 'additionalProperties: false'
- Listed all missing 'properties' in properties scope

Best regards,
Maciej Falkowski
---
 .../bindings/gpu/samsung-scaler.txt           | 27 -------
 .../bindings/gpu/samsung-scaler.yaml          | 81 +++++++++++++++++++
 2 files changed, 81 insertions(+), 27 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gpu/samsung-scaler.txt
 create mode 100644 Documentation/devicetree/bindings/gpu/samsung-scaler.yaml

diff --git a/Documentation/devicetree/bindings/gpu/samsung-scaler.txt b/Documentation/devicetree/bindings/gpu/samsung-scaler.txt
deleted file mode 100644
index 9c3d98105dfd..000000000000
--- a/Documentation/devicetree/bindings/gpu/samsung-scaler.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-* Samsung Exynos Image Scaler
-
-Required properties:
-  - compatible : value should be one of the following:
-	(a) "samsung,exynos5420-scaler" for Scaler IP in Exynos5420
-	(b) "samsung,exynos5433-scaler" for Scaler IP in Exynos5433
-
-  - reg : Physical base address of the IP registers and length of memory
-	  mapped region.
-
-  - interrupts : Interrupt specifier for scaler interrupt, according to format
-		 specific to interrupt parent.
-
-  - clocks : Clock specifier for scaler clock, according to generic clock
-	     bindings. (See Documentation/devicetree/bindings/clock/exynos*.txt)
-
-  - clock-names : Names of clocks. For exynos scaler, it should be "mscl"
-		  on 5420 and "pclk", "aclk" and "aclk_xiu" on 5433.
-
-Example:
-	scaler@12800000 {
-		compatible = "samsung,exynos5420-scaler";
-		reg = <0x12800000 0x1294>;
-		interrupts = <0 220 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&clock CLK_MSCL0>;
-		clock-names = "mscl";
-	};
diff --git a/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml b/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml
new file mode 100644
index 000000000000..5317ac64426a
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpu/samsung-scaler.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos SoC Image Scaler
+
+maintainers:
+  - Inki Dae <inki.dae@samsung.com>
+
+properties:
+  compatible:
+    enum:
+      - samsung,exynos5420-scaler
+      - samsung,exynos5433-scaler
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks: {}
+  clock-names: {}
+  iommus: {}
+  power-domains: {}
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: samsung,exynos5420-scaler
+
+then:
+  properties:
+    clocks:
+      items:
+        - description: mscl clock
+
+    clock-names:
+      items:
+        - const: mscl
+
+else:
+  properties:
+    clocks:
+      items:
+        - description: pclk clock
+        - description: aclk clock
+        - description: aclk_xiu clock
+
+    clock-names:
+      items:
+        - const: pclk
+        - const: aclk
+        - const: aclk_xiu
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/exynos5420.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    scaler@12800000 {
+        compatible = "samsung,exynos5420-scaler";
+        reg = <0x12800000 0x1294>;
+        interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clock CLK_MSCL0>;
+        clock-names = "mscl";
+    };
+
+...
-- 
2.17.1



