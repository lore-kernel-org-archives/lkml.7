Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A15C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 10:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D2C2189D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 10:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="skeo03Lx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfIQKiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 06:38:02 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:52407 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfIQKiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 06:38:02 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190917103800euoutp018b54369163961432219bcbd075d696c9~FM4JjNv0u2679526795euoutp01M
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 10:38:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190917103800euoutp018b54369163961432219bcbd075d696c9~FM4JjNv0u2679526795euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568716680;
        bh=dMTOUiJXpryj3x6XPv0aEEYIJHqqRS47dekWk1nhjEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=skeo03LxM7QIw6XrBnswET5VrhR9S/11M60R+7zBUm3K1ZWZjjMj6NmOSgnQjlVbp
         OAQQxy7Ay0TIafz/HZRCvl0F6MVDqJWkWSfs/aQvkabBEsCoemF0enSkEa1iqAOuE4
         51NWuEAnhZDjP+U5Ja7i/PJ25Y1Kpvr0Yhx7CNtE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190917103759eucas1p1f8df25325e4754c12a823f7263e2296a~FM4IrGNUy1434014340eucas1p1G;
        Tue, 17 Sep 2019 10:37:59 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 48.3B.04309.687B08D5; Tue, 17
        Sep 2019 11:37:58 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190917103758eucas1p10793e499209137630681186a10a4b7bd~FM4Hoz1pO1434014340eucas1p1D;
        Tue, 17 Sep 2019 10:37:58 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190917103758eusmtrp2ef805a9a7986ed995556f76690e3f0df~FM4HaqEit1908519085eusmtrp2O;
        Tue, 17 Sep 2019 10:37:58 +0000 (GMT)
X-AuditID: cbfec7f4-afbff700000010d5-12-5d80b786928f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 3A.37.04166.587B08D5; Tue, 17
        Sep 2019 11:37:57 +0100 (BST)
Received: from AMDC2459.digital.local (unknown [106.120.51.95]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190917103757eusmtip208717cdb181c927823afc54f28fbf2a5~FM4G1vhY60082800828eusmtip2c;
        Tue, 17 Sep 2019 10:37:57 +0000 (GMT)
From:   Maciej Falkowski <m.falkowski@samsung.com>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, krzk@kernel.org, a.hajda@samsung.com,
        m.szyprowski@samsung.com, m.falkowski@samsung.com
Subject: [PATCH v3] dt-bindings: gpu: Convert Samsung Image Rotator to
 dt-schema
Date:   Tue, 17 Sep 2019 12:37:27 +0200
Message-Id: <20190917103727.14997-1-m.falkowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190913062945.GA10283@pi3>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsWy7djPc7rt2xtiDWa+Z7S4te4cq0XvuZNM
        Fv+3TWS2mH8EyL3y9T2bxfnzG9gtLu+aw2Yx4/w+JosHzevYLNYeuctusfT6RSaL1r1H2B14
        PNbMW8PosffbAhaPTas62Ty2f3vA6nG/+ziTR9+WVYwenzfJBbBHcdmkpOZklqUW6dslcGVc
        u/CarWCmZMX/vRkNjLtFuhg5OSQETCQ+rN/B1sXIxSEksIJRYuOVE4wQzhdGiZ0bGpkhnM+M
        EpP3HWCCaXl0/QQTRGI5o8TjA5PZQRJgLQsfV4PYbAIGEv1v9rKAFIkINDFKzF91HGwus8Aa
        RolfM1vBRgkLBEmsXNzPCmKzCKhK3N6ynxHE5hWwkbh3pIMRYp28xOoNB5hBbE4BTYn2S+9Y
        QQZJCCxil/iy4gILRJGLxLr5d6EahCVeHd/CDmHLSPzfOR9oGQeQXS1x7ZssRG8Lo8T1aW/Z
        IGqsJf6smsgGUsMMtGD9Ln2IsKPErAmXoFr5JG68FQQJMwOZk7ZNZ4YI80p0tAlBmKoSbybE
        QjRKS7Su2Q91i4dEe9tnaPDUSEzo3844gVF+FsKqBYyMqxjFU0uLc9NTi43yUsv1ihNzi0vz
        0vWS83M3MQLTzOl/x7/sYNz1J+kQowAHoxIPr8G2+lgh1sSy4srcQ4wSHMxKIrwBtUAh3pTE
        yqrUovz4otKc1OJDjNIcLErivNUMD6KFBNITS1KzU1MLUotgskwcnFINjFxK9f2+ivX8Wd25
        bx/d41igIGR6quqMknJmecsBp/25CaK9mlOrLl2Uj9L0Mpp9cI6vrHexkKLMy3Ppoq8Vc3hX
        cNwQip/HeSct+PC7KwbhWqdshcQF7XlOzqlS10rUV5cINAiq/7lMYXX9pAu1V1bZ/L4qcH72
        i6a6PgZx0X7hZeqMfd1KLMUZiYZazEXFiQBgUiSKLwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkkeLIzCtJLcpLzFFi42I5/e/4Pd3W7Q2xBu1nLSxurTvHatF77iST
        xf9tE5kt5h8Bcq98fc9mcf78BnaLy7vmsFnMOL+PyeJB8zo2i7VH7rJbLL1+kcmide8Rdgce
        jzXz1jB67P22gMVj06pONo/t3x6wetzvPs7k0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrR
        hhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehnXLrxmK5gpWfF/b0YD426RLkZO
        DgkBE4lH108wdTFycQgJLGWUWDf5DyNEQlpi/7WP7BC2sMSfa11sEEWfGCXafkxiBUmwCRhI
        9L/ZywKSEBFoY5R4euoI2ChmgW2MErvX3mcDqRIWCJDYu+0q2CgWAVWJ21v2g63gFbCRuHek
        A2qdvMTqDQeYQWxOAU2J9kvvwDYICWhI3N+1gHUCI98CRoZVjCKppcW56bnFhnrFibnFpXnp
        esn5uZsYgcG/7djPzTsYL20MPsQowMGoxMNrsK0+Vog1say4MvcQowQHs5IIb0AtUIg3JbGy
        KrUoP76oNCe1+BCjKdBRE5mlRJPzgZGZVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2xJDU7
        NbUgtQimj4mDU6qBUX/OrpMMOz88tn1Q1q93fYqxtZZBsc7F9ItWb5wCn72tmLXBaeM99qVN
        F1g9Sm3FN0v4TRK4v/6Zj6ncoYAcv/qHqxLfvbX9csJm9ct892KLFpO/z1tZ44UMde/aTfHl
        C4h6seSd1fUpHtob5W5wfDmwa8vqJToHnq/Rf114YdZ3lSwdlXrNvUosxRmJhlrMRcWJAB3p
        4vOUAgAA
X-CMS-MailID: 20190917103758eucas1p10793e499209137630681186a10a4b7bd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190917103758eucas1p10793e499209137630681186a10a4b7bd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190917103758eucas1p10793e499209137630681186a10a4b7bd
References: <20190913062945.GA10283@pi3>
        <CGME20190917103758eucas1p10793e499209137630681186a10a4b7bd@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Samsung Image Rotator to newer dt-schema format.

Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
v3:
- remove unneded comments and descriptions
- remove unneded maxItems field from clock-names property
---
 .../bindings/gpu/samsung-rotator.txt          | 28 -----------
 .../bindings/gpu/samsung-rotator.yaml         | 48 +++++++++++++++++++
 2 files changed, 48 insertions(+), 28 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gpu/samsung-rotator.txt
 create mode 100644 Documentation/devicetree/bindings/gpu/samsung-rotator.yaml

diff --git a/Documentation/devicetree/bindings/gpu/samsung-rotator.txt b/Documentation/devicetree/bindings/gpu/samsung-rotator.txt
deleted file mode 100644
index 3aca2578da0b..000000000000
--- a/Documentation/devicetree/bindings/gpu/samsung-rotator.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-* Samsung Image Rotator
-
-Required properties:
-  - compatible : value should be one of the following:
-	* "samsung,s5pv210-rotator" for Rotator IP in S5PV210
-	* "samsung,exynos4210-rotator" for Rotator IP in Exynos4210
-	* "samsung,exynos4212-rotator" for Rotator IP in Exynos4212/4412
-	* "samsung,exynos5250-rotator" for Rotator IP in Exynos5250
-
-  - reg : Physical base address of the IP registers and length of memory
-	  mapped region.
-
-  - interrupts : Interrupt specifier for rotator interrupt, according to format
-		 specific to interrupt parent.
-
-  - clocks : Clock specifier for rotator clock, according to generic clock
-	     bindings. (See Documentation/devicetree/bindings/clock/exynos*.txt)
-
-  - clock-names : Names of clocks. For exynos rotator, it should be "rotator".
-
-Example:
-	rotator@12810000 {
-		compatible = "samsung,exynos4210-rotator";
-		reg = <0x12810000 0x1000>;
-		interrupts = <0 83 0>;
-		clocks = <&clock 278>;
-		clock-names = "rotator";
-	};
diff --git a/Documentation/devicetree/bindings/gpu/samsung-rotator.yaml b/Documentation/devicetree/bindings/gpu/samsung-rotator.yaml
new file mode 100644
index 000000000000..45ce562435fa
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/samsung-rotator.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpu/samsung-rotator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung SoC Image Rotator
+
+maintainers:
+  - Inki Dae <inki.dae@samsung.com>
+
+properties:
+  compatible:
+    enum:
+      - "samsung,s5pv210-rotator"
+      - "samsung,exynos4210-rotator"
+      - "samsung,exynos4212-rotator"
+      - "samsung,exynos5250-rotator"
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+    - const: rotator
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+examples:
+  - |
+    rotator@12810000 {
+        compatible = "samsung,exynos4210-rotator";
+        reg = <0x12810000 0x1000>;
+        interrupts = <0 83 0>;
+        clocks = <&clock 278>;
+        clock-names = "rotator";
+    };
+
-- 
2.17.1

