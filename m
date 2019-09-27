Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF770C388F3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 14:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2B7217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 14:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aSrUe4QD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfI0Od2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 10:33:28 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:37807 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfI0Od1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 10:33:27 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190927143326euoutp0185718f06cb472c87e0d5edc5d4176fa0~IUikVQtED1636616366euoutp01j
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 14:33:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190927143326euoutp0185718f06cb472c87e0d5edc5d4176fa0~IUikVQtED1636616366euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569594806;
        bh=G2Au4nqh316kn+/C2/u5KhH+/FqAvU2AUojAO78U73I=;
        h=From:To:Cc:Subject:Date:References:From;
        b=aSrUe4QDRg4qX8rEwHOoNLFkqlXJv8D856A1o0jU0uc+5BDe7Z+WNNW+YyKv/L+sX
         R3zk9S947Fonynyu+0vWIRvoSZR1gcVeNlY0OUd/TBPug3w+FW/T25532mUKm+L14P
         WCyLbc10edEKLsOurj/idUVslycLkCdlvzBnsqeg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190927143326eucas1p191957130d7648dee680b08c7987054a0~IUij-26UX3115431154eucas1p1q;
        Fri, 27 Sep 2019 14:33:26 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C9.38.04374.6BD1E8D5; Fri, 27
        Sep 2019 15:33:26 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190927143325eucas1p289cb46e8dcbb1ace0b1f80ade738c29b~IUijt1R9y0135701357eucas1p2l;
        Fri, 27 Sep 2019 14:33:25 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190927143325eusmtrp1e6f567178d9de4f7767a7f93ee5bb734~IUijtRLM13086830868eusmtrp1U;
        Fri, 27 Sep 2019 14:33:25 +0000 (GMT)
X-AuditID: cbfec7f5-4ddff70000001116-85-5d8e1db64ccc
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CD.25.04117.5BD1E8D5; Fri, 27
        Sep 2019 15:33:25 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190927143325eusmtip2fc047acbf4efd1ce4281a2182177454a~IUijRlbgD0300703007eusmtip2Z;
        Fri, 27 Sep 2019 14:33:25 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Inki Dae <inki.dae@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Maciej Falkowski <m.falkowski@samsung.com>
Subject: [PATCH v3] dt-bindings: gpu: Convert Samsung 2D Graphics
 Accelerator to dt-schema
Date:   Fri, 27 Sep 2019 16:33:19 +0200
Message-Id: <20190927143319.12232-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsWy7djPc7rbZPtiDWYeZ7eYf+Qcq8WVr+/Z
        LCbdn8Bicf78BnaLy7vmsFnMOL+PyeJB8zo2i6XXLzJZtO49wu7A6bFm3hpGj02rOtk87ncf
        Z/Lo27KK0ePzJrkA1igum5TUnMyy1CJ9uwSujM+fnrEWnJOt2DnrP2sD4yzxLkZODgkBE4n2
        Wa9Yuhi5OIQEVjBKtG5awgbhfGGUOL5iAzNIlZDAZ0aJfQsiYDoe37kN1bGcUWLFrjkscB3P
        759hAqliEzCU6HrbBTZKRKCJUeLKzlfsIAlmgYOMEku2BYLYwgIxEpdffAeLswioSryd+RbM
        5hWwlZh9djMzxDp5idUbDjCDDJIQeM4mMef1DTaIhIvEv44jUEXCEq+Ob2GHsGUkTk/uYYFo
        aGaUeHhuLTuE08MocblpBiNElbXE4eMXWbsYOYBO0pRYv0sfIuwo0fB0JTNIWEKAT+LGW0GI
        o/kkJm2bDhXmlehoE4KoVpOYdXwd3NqDFy5BneMhMXPpanZI0MVKbJuyl3ECo9wshF0LGBlX
        MYqnlhbnpqcWG+ellusVJ+YWl+al6yXn525iBKaI0/+Of93BuO9P0iFGAQ5GJR7eC+x9sUKs
        iWXFlbmHGCU4mJVEeH0je2KFeFMSK6tSi/Lji0pzUosPMUpzsCiJ81YzPIgWEkhPLEnNTk0t
        SC2CyTJxcEo1MPIn3ehhX7W0U9SpNdfhYGNy0rELJ04Gb+t4y7kgMH3/1IDGEF67Tp2APR+j
        Apk3povNmfPKJi3o2oP1gjuOvXjV8f/Wk+MnDux1mX/2y8aOAyd0123a2qryfVmEwPNC3/Wx
        Z3ZcqXDkTmS9VNp44XeuS/23GUFiF7Keqc54GMH19vvdNR1ZWceVWIozEg21mIuKEwGXFv6o
        DQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsVy+t/xe7pbZftiDXpuGlnMP3KO1eLK1/ds
        FpPuT2CxOH9+A7vF5V1z2CxmnN/HZPGgeR2bxdLrF5ksWvceYXfg9Fgzbw2jx6ZVnWwe97uP
        M3n0bVnF6PF5k1wAa5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpq
        TmZZapG+XYJexudPz1gLzslW7Jz1n7WBcZZ4FyMnh4SAicTjO7dZuhi5OIQEljJKPFl7gQki
        ISNxcloDK4QtLPHnWhcbiC0k8IlR4szDGhCbTcBQoustSJyLQ0SgjVHi8+MrzCAOs8BRRon1
        7XfZQaqEBaIkjs1dAtbNIqAq8XbmW7A4r4CtxOyzm5khNshLrN5wgHkCI88CRoZVjCKppcW5
        6bnFRnrFibnFpXnpesn5uZsYgaG57djPLTsYu94FH2IU4GBU4uGtYO2LFWJNLCuuzD3EKMHB
        rCTC6xvZEyvEm5JYWZValB9fVJqTWnyI0RRo+URmKdHkfGDc5JXEG5oamltYGpobmxubWSiJ
        83YIHIwREkhPLEnNTk0tSC2C6WPi4JRqYGxmn2xc1yP34Xp/1ry4D76muQsivnZaNDnZ+DpL
        60f2C55NyDKQss4ULPmYsb+lTuHwK4P5VysE+GI2TVl62Sz2ygmHrSfTLl/mzdqYtWXF5Nqn
        yum/Y5muGxhOPOncGvpsr3r0stqfXeZpC2u+50bkFkQbfL57fZ8dh3Pzrs+1d2fE/l2mqcRS
        nJFoqMVcVJwIAPEvoU5jAgAA
X-CMS-MailID: 20190927143325eucas1p289cb46e8dcbb1ace0b1f80ade738c29b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190927143325eucas1p289cb46e8dcbb1ace0b1f80ade738c29b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190927143325eucas1p289cb46e8dcbb1ace0b1f80ade738c29b
References: <CGME20190927143325eucas1p289cb46e8dcbb1ace0b1f80ade738c29b@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maciej Falkowski <m.falkowski@samsung.com>

Convert Samsung 2D Graphics Accelerator to newer dt-schema format

Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
---
v3:
- Merged two if-statements with single if-else statement
- Added 'additionalProperties: false'
- Listed all missing 'properties' in properties scope

Best regards,
Maciej Falkowski
---
 .../devicetree/bindings/gpu/samsung-g2d.txt   | 27 -------
 .../devicetree/bindings/gpu/samsung-g2d.yaml  | 75 +++++++++++++++++++
 2 files changed, 75 insertions(+), 27 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gpu/samsung-g2d.txt
 create mode 100644 Documentation/devicetree/bindings/gpu/samsung-g2d.yaml

diff --git a/Documentation/devicetree/bindings/gpu/samsung-g2d.txt b/Documentation/devicetree/bindings/gpu/samsung-g2d.txt
deleted file mode 100644
index 1e7959332dbc..000000000000
--- a/Documentation/devicetree/bindings/gpu/samsung-g2d.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-* Samsung 2D Graphics Accelerator
-
-Required properties:
-  - compatible : value should be one among the following:
-	(a) "samsung,s5pv210-g2d" for G2D IP present in S5PV210 & Exynos4210 SoC
-	(b) "samsung,exynos4212-g2d" for G2D IP present in Exynos4x12 SoCs
-	(c) "samsung,exynos5250-g2d" for G2D IP present in Exynos5250 SoC
-
-  - reg : Physical base address of the IP registers and length of memory
-	  mapped region.
-
-  - interrupts : G2D interrupt number to the CPU.
-  - clocks : from common clock binding: handle to G2D clocks.
-  - clock-names : names of clocks listed in clocks property, in the same
-		  order, depending on SoC type:
-		  - for S5PV210 and Exynos4 based SoCs: "fimg2d" and
-		    "sclk_fimg2d"
-		  - for Exynos5250 SoC: "fimg2d".
-
-Example:
-	g2d@12800000 {
-		compatible = "samsung,s5pv210-g2d";
-		reg = <0x12800000 0x1000>;
-		interrupts = <0 89 0>;
-		clocks = <&clock 177>, <&clock 277>;
-		clock-names = "sclk_fimg2d", "fimg2d";
-	};
diff --git a/Documentation/devicetree/bindings/gpu/samsung-g2d.yaml b/Documentation/devicetree/bindings/gpu/samsung-g2d.yaml
new file mode 100644
index 000000000000..e7daae862578
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/samsung-g2d.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpu/samsung-g2d.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung SoC 2D Graphics Accelerator
+
+maintainers:
+  - Inki Dae <inki.dae@samsung.com>
+
+properties:
+  compatible:
+    enum:
+      - samsung,s5pv210-g2d    # in S5PV210 & Exynos4210 SoC
+      - samsung,exynos4212-g2d # in Exynos4x12 SoCs
+      - samsung,exynos5250-g2d
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
+        const: samsung,exynos5250-g2d
+
+then:
+  properties:
+    clocks:
+      items:
+        - description: fimg2d clock
+    clock-names:
+      items:
+        - const: fimg2d
+
+else:
+  properties:
+    clocks:
+      items:
+        - description: sclk_fimg2d clock
+        - description: fimg2d clock
+    clock-names:
+      items:
+        - const: sclk_fimg2d
+        - const: fimg2d
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
+    g2d@12800000 {
+        compatible = "samsung,s5pv210-g2d";
+        reg = <0x12800000 0x1000>;
+        interrupts = <0 89 0>;
+        clocks = <&clock 177>, <&clock 277>;
+        clock-names = "sclk_fimg2d", "fimg2d";
+    };
+
+...
-- 
2.17.1



