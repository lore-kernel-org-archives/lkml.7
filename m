Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81040C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 09:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B8D721479
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 09:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="m3r59NtR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbfIMJlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 05:41:40 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56894 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbfIMJlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 05:41:40 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190913094138euoutp0177fc7dc2630cefd807f8b890deb07e65~D9hy1Gt6q0058700587euoutp01I
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 09:41:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190913094138euoutp0177fc7dc2630cefd807f8b890deb07e65~D9hy1Gt6q0058700587euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568367698;
        bh=DUfibKh2tr8MmWDBAzldojteXCAsf97FcfAmYZzYvp0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=m3r59NtRBYe9H0J2O7JU1aJF7iGRuXmudFAT8YWo2oBizIooLFNoKY941uE19tDna
         cDyRRaipzhgyylyZUC+lHzULgWrHsHdFkMX5DOf3nGRWPnOXnkTrogb/yyUPPPfKWF
         1RdXm8D1/QQLCZCsAzICopnS3dTiHupmzDvLT5dA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190913094137eucas1p189206a153fe6a5b656a0abc3b2ddcc28~D9hyFo5cX1631916319eucas1p1t;
        Fri, 13 Sep 2019 09:41:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 16.51.04374.1546B7D5; Fri, 13
        Sep 2019 10:41:37 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190913094136eucas1p1fd424b5f5a6f0a97b31af54e55fe28c1~D9hxTzlle1300013000eucas1p1l;
        Fri, 13 Sep 2019 09:41:36 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190913094136eusmtrp170a964bdf2df72f66d8b0ee4121f3c99~D9hxFYsIQ2788327883eusmtrp1d;
        Fri, 13 Sep 2019 09:41:36 +0000 (GMT)
X-AuditID: cbfec7f5-4f7ff70000001116-4a-5d7b645182df
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 16.BB.04117.0546B7D5; Fri, 13
        Sep 2019 10:41:36 +0100 (BST)
Received: from AMDC2459.DIGITAL.local (unknown [106.120.51.95]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190913094135eusmtip1e8543ea67585bb615d24f42ea2e72529~D9hwfRpnN1498914989eusmtip1z;
        Fri, 13 Sep 2019 09:41:35 +0000 (GMT)
From:   Maciej Falkowski <m.falkowski@samsung.com>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, krzk@kernel.org, a.hajda@samsung.com,
        m.szyprowski@samsung.com, m.falkowski@samsung.com
Subject: [PATCH] dt-bindings: gpu: Convert Samsung Image Scaler to dt-schema
Date:   Fri, 13 Sep 2019 11:41:23 +0200
Message-Id: <20190913094123.23169-1-m.falkowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42LZduznOd3AlOpYg5lnRS1urTvHatF77iST
        xf9tE5kt5h8Bcq98fc9mcf78BnaLy7vmsFnMOL+PyeJB8zo2i7VH7rJbLL1+kcmide8Rdgce
        jzXz1jB67P22gMVj06pONo/t3x6wetzvPs7k0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBkX
        nnSzF9yVrHg8k6eBcZVIFyMnh4SAicTERc8Zuxi5OIQEVjBKXJlwHcr5wijx5MNuJpAqIYHP
        jBKfz8B1/Px9mR2iaDmjRPfmXyxwHTMWPADrYBMwkOh/sxcsISLQxCgxf9VxsLnMAmsYJX7N
        bAWrEhbwkVh6cysriM0ioCrRevsdO4jNK2AjMWPyEzaIffISqzccYIawu9klfrzx7WLkALJd
        JC5NzIUIC0u8Or6FHcKWkTg9uYcFoqRa4to3WZC1EgItjBLXp72FGmkt8WfVRDaQGmYBTYn1
        u/Qhwo4Sm5YvYYZo5ZO48VYQJMwMZE7aNh0qzCvR0SYEYapKvJkQC9EoLdG6Zj8jhO0h0XPl
        OCMk2GIl7m6awTiBUW4WwqoFjIyrGMVTS4tz01OLjfNSy/WKE3OLS/PS9ZLzczcxAlPJ6X/H
        v+5g3Pcn6RCjAAejEg+vhU5VrBBrYllxZe4hRgkOZiURXp83lbFCvCmJlVWpRfnxRaU5qcWH
        GKU5WJTEeasZHkQLCaQnlqRmp6YWpBbBZJk4OKUaGFfc/Ln+/X7OlCav27tFZXfNNpvSa20X
        eyat/cyS1cy737/m4pffGD5XhvfAtKSdiQZXnHtbDdweSHN81uhkuzijsJPLwlkpgeM/k09A
        TbbIrcyCha+apttNn2M9W6H/YVTQlYjJt2Ob33xJ2qEhyDT9UWzvR6OWrM5wiyBuB4FAydvG
        rPpzlViKMxINtZiLihMBCUt9gyEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsVy+t/xu7oBKdWxBtN7pCxurTvHatF77iST
        xf9tE5kt5h8Bcq98fc9mcf78BnaLy7vmsFnMOL+PyeJB8zo2i7VH7rJbLL1+kcmide8Rdgce
        jzXz1jB67P22gMVj06pONo/t3x6wetzvPs7k0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrR
        hhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehkXnnSzF9yVrHg8k6eBcZVIFyMn
        h4SAicTP35fZuxi5OIQEljJKrFz7igUiIS2x/9pHdghbWOLPtS42iKJPjBLXF/UygyTYBAwk
        +t/sZQFJiAi0MUo8PXWECcRhFtjGKLF77X02kCphAR+JpTe3soLYLAKqEq2334GN5RWwkZgx
        +QkbxAp5idUbDjBPYORZwMiwilEktbQ4Nz232EivODG3uDQvXS85P3cTIzCYtx37uWUHY9e7
        4EOMAhyMSjy8FjpVsUKsiWXFlbmHGCU4mJVEeH3eVMYK8aYkVlalFuXHF5XmpBYfYjQFWj6R
        WUo0OR8YaXkl8YamhuYWlobmxubGZhZK4rwdAgdjhATSE0tSs1NTC1KLYPqYODilGhgXT1UT
        Tn8cnmDZOv9e1/tTEuy3fuXJc2xOCFGvlX5nv51PvieKQWeF7dLfzxRdNT1v37vWYZ8wPcfP
        brFGY4z2HRuHle2mLcZF78W2d+3r+CRz9JvCHb2kx2oz63YtneCndUfrvi5rwLnpPEVKrFXl
        l4TP3GNdY+fpVcCbf+OF2d4VDav2rFJiKc5INNRiLipOBADgtPMpfAIAAA==
X-CMS-MailID: 20190913094136eucas1p1fd424b5f5a6f0a97b31af54e55fe28c1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190913094136eucas1p1fd424b5f5a6f0a97b31af54e55fe28c1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190913094136eucas1p1fd424b5f5a6f0a97b31af54e55fe28c1
References: <CGME20190913094136eucas1p1fd424b5f5a6f0a97b31af54e55fe28c1@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Samsung Image Scaler to newer dt-schema format.

Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 .../bindings/gpu/samsung-scaler.txt           | 27 ---------
 .../bindings/gpu/samsung-scaler.yaml          | 57 +++++++++++++++++++
 2 files changed, 57 insertions(+), 27 deletions(-)
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
index 000000000000..ee2caab22977
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml
@@ -0,0 +1,57 @@
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
+      - "samsung,exynos5420-scaler"
+      - "samsung,exynos5433-scaler"
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 3
+
+  clock-names:
+    oneOf:
+      - items:
+          - const: mscl
+      - items:
+          - const: pclk
+          - const: aclk
+          - const: aclk_xiu
+    description: |
+      For exynos scaler it should be:
+      - "mscl" on Exynos5420
+      - "pclk", "aclk", "aclk_xiu" on Exynos5433
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
+    scaler@12800000 {
+        compatible = "samsung,exynos5420-scaler";
+        reg = <0x12800000 0x1294>;
+        interrupts = <0 220 4>; // IRQ_TYPE_LEVEL_HIGH
+        clocks = <&clock 0>; // CLK_MSCL0
+        clock-names = "mscl";
+    };
+
-- 
2.17.1

