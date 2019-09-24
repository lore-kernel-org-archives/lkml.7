Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EC7C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 11:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6572214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 11:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NAcqmYRk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504737AbfIXLc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 07:32:29 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35254 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405917AbfIXLc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 07:32:28 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190924113226euoutp01f8844999554922f3f3b984566e89b36e~HXIrddlh_3016330163euoutp01L
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 11:32:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190924113226euoutp01f8844999554922f3f3b984566e89b36e~HXIrddlh_3016330163euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569324746;
        bh=JPDQtgLHmeZoXEVwTjgfaqO3O0YNINhi8WqO+zseF40=;
        h=From:To:Cc:Subject:Date:References:From;
        b=NAcqmYRku0pMBvmCKpVNTG97Nj1Dzskfn71CRW/CUdXLOo6VvH+PtqCwe0YkSn8Wh
         ydwpO9MzXJCvKNizX9rNARsMSRVEDDYxhJb8etQzmRm/2jvD4nAi3fvBFcO+yETUV6
         Ze+txS5b8jzulFtTTlzF7jTusgPcHACsRvO6qIcM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190924113226eucas1p2ba616fbd0d9ad41dc7394065f63087a7~HXIrBdiDr2078720787eucas1p2z;
        Tue, 24 Sep 2019 11:32:26 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 0A.7A.04374.ACEF98D5; Tue, 24
        Sep 2019 12:32:26 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190924113225eucas1p131429c7f7e0d520693b89bb2a7d9e211~HXIqqUcku1757117571eucas1p1P;
        Tue, 24 Sep 2019 11:32:25 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190924113225eusmtrp119d863657d9cb73388343609c65ee94d~HXIqpXan32716827168eusmtrp1z;
        Tue, 24 Sep 2019 11:32:25 +0000 (GMT)
X-AuditID: cbfec7f5-4ddff70000001116-ef-5d89feca3d10
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A3.E5.04117.9CEF98D5; Tue, 24
        Sep 2019 12:32:25 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190924113225eusmtip1b1a6f986d87223bb532d624e17a7e97a~HXIqJJDrv1091910919eusmtip16;
        Tue, 24 Sep 2019 11:32:25 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Inki Dae <inki.dae@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Maciej Falkowski <m.falkowski@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] dt-bindings: gpu: Convert Samsung 2D Graphics Accelerator
 to dt-schema
Date:   Tue, 24 Sep 2019 13:31:59 +0200
Message-Id: <20190924113159.24873-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSXUhTcRz1v3t373V44zYH/jOxWGkkpJmFF7RPephEWA8+aCy76U1FN23X
        WbOX6VLcFNMJfowyITLxm03mFCZujQZKOlMrlFDpIfxi4kcRDGvbTXs75/zO+Z/z8CcQsVYY
        SRQoS1mVkimSYiLU+uH31LmJfb38fNs8Sr92TQnpuT0vRhuXGlB6enoQp2dHX2J06/SYgF7W
        9WN0n+sbTr/9MiOgq+wu/JpI1tveC2Tmbj0mW6p1C2T1Q91AtmOOviPMEqXmskUFZawq4coD
        UX6naRst8R17OlDVhWqBR2IAoQSkLsKFfi9mACJCTHUBOOIyCHmyC2Bj4wTgyY6fWLaRg0hF
        7biAP7wD0Ktz4ocR74AdDbgwKhEaNg3BhyVUJYBzI2tBF0JtAeiwtGMBVziVCR2rFkEAo1QM
        fLU56tcJgqQuQ70hiq87AXsGx5FAFlLrGGxdPNhxE9a0NQh5HA7X3EM4j6PgZFMdygd0AK5M
        9eE8qQNwtrIV8K4U+N49Iwy0IdRZODCawMvX4UqFNTgCUkfg182jARnxQ6O1BeFlEtZUi3l3
        LDS5+w9rHZ5P/6bJ4IStJThNTMmh4fk63gCiTf+7OgDoBhGsmlPksVySkn0SzzEKTq3Mi88p
        VpiB/19M7rv3bGDM99AJKAJIw0horZGLhUwZp1E4ASQQqYQ0x1XLxWQuoylnVcXZKnURyznB
        cQKVRpDPQpbviak8ppQtZNkSVnVwFRChkVqQYG/66fk11pylhhf2lN7GdO6ULc4S646RhJAu
        wbyJ1Pbe+uxjduUbpuHmtNUk+4ZvpTAlqcNy1ao6vW/suWu8Iaq+lIGxOZpI+aIgufTHpGg4
        /czWo+ym3eWT4Zo3aXr349v3dxyZybrOF99TcZuuxVFV7/mTUT5TtvAxTIpy+UxiHKLimL/w
        wTV1EwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsVy+t/xu7on/3XGGly6pWUx/8g5VosrX9+z
        WUy6P4HF4vz5DewWl3fNYbOYcX4fk8WD5nVsFmuP3GW3WHr9IpNF694j7A5cHmvmrWH02LSq
        k83jfvdxJo++LasYPT5vkgtgjdKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV
        0rezSUnNySxLLdK3S9DLWDbrE0vBH8mK9a0rWBoYL4h0MXJySAiYSDR2H2DqYuTiEBJYyijR
        NPkeE0RCRuLktAZWCFtY4s+1LjaIok+MEjdOXAdLsAkYSnS9hUiICLQxSnx+fIUZxGEW+MIo
        sfnvD3aQKmGBcIklJ8+CjWURUJWY+3YXUAcHB6+ArURnlwzEBnmJ1RsOME9g5FnAyLCKUSS1
        tDg3PbfYSK84Mbe4NC9dLzk/dxMjMEi3Hfu5ZQdj17vgQ4wCHIxKPLwS2zpihVgTy4orcw8x
        SnAwK4nwbtJqixXiTUmsrEotyo8vKs1JLT7EaAq0eyKzlGhyPjCC8kriDU0NzS0sDc2NzY3N
        LJTEeTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1MDpu3D87Pu9N74+7VYdE16lFBu1evrWt7dFb
        8yubz37W5FzHbTpTM/SXVlar4bwle2o2Z0yXkNCrMe6/LXBsYrumibrtubWa65KFo14v7PmT
        q2wal353e0aQBuexmf/UhL/O9J19duoc/c8nGrcc9BARy5f1SZcK3KOUsNQxZ3X+Dz5Vgbt5
        bEosxRmJhlrMRcWJAC26ZfhoAgAA
X-CMS-MailID: 20190924113225eucas1p131429c7f7e0d520693b89bb2a7d9e211
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190924113225eucas1p131429c7f7e0d520693b89bb2a7d9e211
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190924113225eucas1p131429c7f7e0d520693b89bb2a7d9e211
References: <CGME20190924113225eucas1p131429c7f7e0d520693b89bb2a7d9e211@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maciej Falkowski <m.falkowski@samsung.com>

Convert Samsung 2D Graphics Accelerator to newer dt-schema format

Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 .../devicetree/bindings/gpu/samsung-g2d.txt   | 27 ----------
 .../devicetree/bindings/gpu/samsung-g2d.yaml  | 53 +++++++++++++++++++
 2 files changed, 53 insertions(+), 27 deletions(-)
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
index 000000000000..bb0a4bf168cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/samsung-g2d.yaml
@@ -0,0 +1,53 @@
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
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    oneOf:
+      - items: # for Exynos5250 SoC
+          - const: fimg2d
+      - items: # for S5PV210 and Exynos4 based SoCs
+          - const: sclk_fimg2d
+          - const: fimg2d
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
+    g2d@12800000 {
+        compatible = "samsung,s5pv210-g2d";
+        reg = <0x12800000 0x1000>;
+        interrupts = <0 89 0>;
+        clocks = <&clock 177>, <&clock 277>;
+        clock-names = "sclk_fimg2d", "fimg2d";
+    };
+
-- 
2.17.1



