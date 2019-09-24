Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0F6C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 13:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5725921906
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 13:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Y49yQLmR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405762AbfIXNqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 09:46:31 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40283 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390471AbfIXNqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 09:46:30 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190924134629euoutp02572b083d402c07403f25981a9e97b487~HY9t0KbWx2951329513euoutp02J
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 13:46:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190924134629euoutp02572b083d402c07403f25981a9e97b487~HY9t0KbWx2951329513euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569332789;
        bh=hjG7mIhqoiOETo/vBYiUdDrKZ8xHLwwvqLJb2beAL28=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Y49yQLmRhXpcDp+Z/DI64yse89omla7BI9frg6hfkBSFKJORfItP2jDpzinY66yH/
         6e+RhD0a9t0FnhrxO8YUUEo7+IQqJDzyk0LnvpyvpgUY9eRjim79zZyZItgBpVfwIX
         MhJDb1v246CVPP3a5E8xBJdIMDLwBUd+hMIhZgA8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190924134628eucas1p2bd276c27a6f10a9c22fe01ee96c1191e~HY9tYCT0k1167611676eucas1p2s;
        Tue, 24 Sep 2019 13:46:28 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 13.A0.04309.43E1A8D5; Tue, 24
        Sep 2019 14:46:28 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190924134628eucas1p1586ca3285dac6b5d5cd1026ea78c436e~HY9tBJLQ02098520985eucas1p1C;
        Tue, 24 Sep 2019 13:46:28 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190924134628eusmtrp251cfad991c9cd03ca569a4a2329fdbfb~HY9s9tNxH0218002180eusmtrp2Z;
        Tue, 24 Sep 2019 13:46:28 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-17-5d8a1e34e9f8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 66.A8.04117.43E1A8D5; Tue, 24
        Sep 2019 14:46:28 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190924134627eusmtip1dd6609f10e2c9112831705383be71907~HY9sg53nY2427224272eusmtip1j;
        Tue, 24 Sep 2019 13:46:27 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Inki Dae <inki.dae@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Maciej Falkowski <m.falkowski@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2] dt-bindings: gpu: Convert Samsung 2D Graphics
 Accelerator to dt-schema
Date:   Tue, 24 Sep 2019 15:46:14 +0200
Message-Id: <20190924134614.13371-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRju29m5OJycpuWXyqJBQuElQ+JAFhqF56eU/imHHvO0edmUHbW0
        CHN0cVrpCBwmzglleUen6KqVNt2PbGtpJaFsEiVow/ISBqJtO5r/nve5vM/Lx0cgkko0gshT
        l7AaNVMow0TCwfG/jthEqU5+zOJIoIw2B0pNrS1hlN5dJ6Sczl6cmrQ0YZTBaRVQHm03RnXZ
        ZnHqyReXgLr9yoYni+jO5k5A97VXY7S7xi6gH5jbAb3SJ01DL4qSctnCvDJWE386W6Q0TU7j
        xbPSazVuG6gEj8N1IIiAZCJ8blkT6oCIkJDPAByxLiL8sArgC5sD87sk5AqA61rFTqL26e/t
        RBuArbUN+G5CO4z6XRiZAHVeHeYXwsgqAKeGFwIuhPzlK+lvDuwNJTPhjyYH4sdC8jB8bXgU
        wGLyFGxZeYjxfQdhR++bwFGQXMTgrT89KC+chfUTLsDjULhgN+M8joJbw0YBH9ACOOfowvmh
        FsDJKsN24iR8a3f5NhG+m47AHks8T6dAx/Jn3E9DMgROe/f6acQH9YMNCE+L4b07Et4dDRvt
        3f9rRz58RHhMQ717DuffTg71801oHZA27na1ANAOwtlSTqVgueNq9mocx6i4UrUi7nKRqg/4
        /sW7TfvqELBs5IwCkgCyYHEyqpNLUKaMK1eNAkggsjBxY5SPEucy5RWspihLU1rIcqMgkhDK
        wsXX93guSUgFU8IWsGwxq9lRBURQRCWQZmrvZr1P/dbfMDWuXB8TLCbhXLkxp+NERbVVli3q
        b0ucv2maMdc4I0Luh0bG3MiXmpTJn1ZfLp9nYo1d1sh9cmDSdrIZZ7aME9GusYIMYibV4KVa
        B7J/Dh0QHdIXp9yLD9u48n0z/+uAJ32/NzomeCntwnImfc6MebbS62VCTskkHEU0HPMP3bub
        YhMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsVy+t/xu7omcl2xBgd+SVrMP3KO1eLK1/ds
        FpPuT2CxOH9+A7vF5V1z2CxmnN/HZPGgeR2bxdojd9ktll6/yGTRuvcIuwOXx5p5axg9Nq3q
        ZPO4332cyaNvyypGj8+b5AJYo/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV
        9O1sUlJzMstSi/TtEvQyFl6+wV5wV66i+/4RxgbG2eJdjJwcEgImEj3LPrJ0MXJxCAksZZTo
        WNzBDpGQkTg5rYEVwhaW+HOtiw2i6BOjxJKVq5hBEmwChhJdbyESIgJtjBKfH19hBnGYBb4w
        Smz++wNslLBAlMT+y7PBbBYBVYn9M6aAdfMK2Eos+NzPBrFCXmL1hgPMExh5FjAyrGIUSS0t
        zk3PLTbSK07MLS7NS9dLzs/dxAgM023Hfm7Zwdj1LvgQowAHoxIPrwNrV6wQa2JZcWXuIUYJ
        DmYlEd5ZMkAh3pTEyqrUovz4otKc1OJDjKZAyycyS4km5wNjKK8k3tDU0NzC0tDc2NzYzEJJ
        nLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA6N04YdLt3oVDrTyMt14FBrayHOQbfPNbaorfGdJ
        BgkpBjSI63a5r79w/aHxh/6VU2cuu3s8L/DTvcm/udcUbmWZfjnE8nps07ynmuvlQ95mMiq9
        uP2IN0Huqsr89An/znE75Zt1vDpRLXrhpG29yO569lU9qsd8NyeKn5W4U6v4rqS1miXtmo0S
        S3FGoqEWc1FxIgDgf4sLaQIAAA==
X-CMS-MailID: 20190924134628eucas1p1586ca3285dac6b5d5cd1026ea78c436e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190924134628eucas1p1586ca3285dac6b5d5cd1026ea78c436e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190924134628eucas1p1586ca3285dac6b5d5cd1026ea78c436e
References: <CGME20190924134628eucas1p1586ca3285dac6b5d5cd1026ea78c436e@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maciej Falkowski <m.falkowski@samsung.com>

Convert Samsung 2D Graphics Accelerator to newer dt-schema format

Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
v2:
- Added if-then statements for 'clocks' and 'clock-names'
properties.

Best regards,
Maciej Falkowski
---
 .../devicetree/bindings/gpu/samsung-g2d.txt   | 27 -------
 .../devicetree/bindings/gpu/samsung-g2d.yaml  | 76 +++++++++++++++++++
 2 files changed, 76 insertions(+), 27 deletions(-)
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
index 000000000000..5e05e8ccc83f
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/samsung-g2d.yaml
@@ -0,0 +1,76 @@
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
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5250-g2d
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: fimg2d clock
+        clock-names:
+          items:
+            - const: fimg2d
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,s5pv210-g2d
+              - samsung,exynos4212-g2d
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: sclk_fimg2d clock
+            - description: fimg2d clock
+        clock-names:
+          items:
+            - const: sclk_fimg2d
+            - const: fimg2d
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



