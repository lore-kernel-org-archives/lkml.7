Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9653C4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 16:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E7A2081B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 16:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="I4gUetCi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733158AbfILQPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 12:15:54 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52671 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729361AbfILQPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 12:15:54 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190912161552euoutp0269dbfad2df5bb9e46801def5b33ba981~DvQtutPlX0393403934euoutp02U
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 16:15:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190912161552euoutp0269dbfad2df5bb9e46801def5b33ba981~DvQtutPlX0393403934euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568304952;
        bh=5S4jHwjySXMeViPrPMP4YNn6x+hNkId00H3i+t4121Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I4gUetCiketbGypAEnn8x+J+8hyO8LPlR2nETTJH0Ax5z0iEUiULZYH33JneNd3M1
         P8IJhItsztEqueAT6kxFuHzM11kpg19T6bPPufCaHXiXXbMK9tP36q3qBH9rtbM9mt
         6jIhbYf+Hza+iyqp9/uRoSVxNgW/TocNEAs4Tv5U=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190912161551eucas1p162d3b75081c28ba0055f29ba9c108738~DvQs_ULft1983319833eucas1p15;
        Thu, 12 Sep 2019 16:15:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id A1.E8.04309.63F6A7D5; Thu, 12
        Sep 2019 17:15:50 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190912161550eucas1p2bdc813d46f337f3717bdbfd33bae8d4a~DvQsP4wtY2511725117eucas1p2g;
        Thu, 12 Sep 2019 16:15:50 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190912161550eusmtrp24ea158bfa6ff6484de3615a219097eff~DvQsBuYOO1661816618eusmtrp2F;
        Thu, 12 Sep 2019 16:15:50 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-6f-5d7a6f3624a6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 0A.22.04166.53F6A7D5; Thu, 12
        Sep 2019 17:15:49 +0100 (BST)
Received: from AMDC2459.DIGITAL.local (unknown [106.120.51.95]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190912161549eusmtip27f78cece0ec8888a08c554da80ef8f57~DvQrP0X3A1586615866eusmtip2E;
        Thu, 12 Sep 2019 16:15:49 +0000 (GMT)
From:   Maciej Falkowski <m.falkowski@samsung.com>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, krzk@kernel.org, a.hajda@samsung.com,
        m.szyprowski@samsung.com, m.falkowski@samsung.com
Subject: [PATCH v2] dt-bindings: gpu: Convert Samsung Image Rotator to
 dt-schema
Date:   Thu, 12 Sep 2019 18:15:38 +0200
Message-Id: <20190912161538.4321-1-m.falkowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190912093315.5744-1-m.falkowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djP87pm+VWxBq+n2VjcWneO1aL33Ekm
        i//bJjJbzD8C5F75+p7N4vz5DewWl3fNYbOYcX4fk8WD5nVsFmuP3GW3WHr9IpNF694j7A48
        HmvmrWH02PttAYvHplWdbB7bvz1g9bjffZzJo2/LKkaPz5vkAtijuGxSUnMyy1KL9O0SuDKu
        fO9kKVgoXdGz+wJbA2ObWBcjJ4eEgIlEx4pmti5GLg4hgRWMEpNunmeEcL4wSmxtW8sO4Xxm
        lJh//gU7TMuqls9QieWMEs97X7LAtWxavYINpIpNwECi/81esISIQBNQ+6rjYIOZBdYwSvya
        2coEUiUsECRxv+0yUAcHB4uAqsSnj2AreAWsJZ6d2ssGsU5eYvWGA8wgNqeAjcS8eXNYQeZI
        CCxil7j/+CQLRJGLxNF5jawQtrDEq+NboG6Vkfi/cz4TyHwJgWqJa99kIXpbGCWuT3sLtcBa
        4s+qiWA3MAtoSqzfpQ8RdpR4+aKVHaKVT+LGW0GQMDOQOWnbdGaIMK9ER5sQhKkq8WZCLESj
        tETrmv2MEGEPif5bZpDQ6WeUWLNrJ9sERvlZCKsWMDKuYhRPLS3OTU8tNspLLdcrTswtLs1L
        10vOz93ECEw0p/8d/7KDcdefpEOMAhyMSjy8FjpVsUKsiWXFlbmHGCU4mJVEeH3eVMYK8aYk
        VlalFuXHF5XmpBYfYpTmYFES561meBAtJJCeWJKanZpakFoEk2Xi4JRqYAz+caVscvMV07bD
        h2Miz7PM/hzqvHlK4L05Gnf/b07SZNYtt+izc5o0R/Lt8jlsdu9flllJlp7dcOql2mRRpdfR
        4rKeQdV97vPyo5bXHd+ipFld/I1ZrulGn/jx0B2rdmz7tnHlfo3/DSqz/Ywep/kYiPBP3vox
        XyRO4Km/tcSMU/ni07re/1NiKc5INNRiLipOBAADlkh5MAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsVy+t/xe7qm+VWxBldvWlvcWneO1aL33Ekm
        i//bJjJbzD8C5F75+p7N4vz5DewWl3fNYbOYcX4fk8WD5nVsFmuP3GW3WHr9IpNF694j7A48
        HmvmrWH02PttAYvHplWdbB7bvz1g9bjffZzJo2/LKkaPz5vkAtij9GyK8ktLUhUy8otLbJWi
        DS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DKufO9kKVgoXdGz+wJbA2ObWBcj
        J4eEgInEqpbP7F2MXBxCAksZJRr/nWCDSEhL7L/2kR3CFpb4c62LDaLoE6PEvhVtYAk2AQOJ
        /jd7WUASIgJtjBJPTx1hAnGYBbYxSuxeex+ohYNDWCBA4vudehCTRUBV4hPEUF4Ba4lnp/ZC
        LZOXWL3hADOIzSlgIzFv3hxWkHIhoJqGNqYJjHwLGBlWMYqklhbnpucWG+oVJ+YWl+al6yXn
        525iBAb+tmM/N+9gvLQx+BCjAAejEg+vhU5VrBBrYllxZe4hRgkOZiURXp83lbFCvCmJlVWp
        RfnxRaU5qcWHGE2BTprILCWanA+MyrySeENTQ3MLS0NzY3NjMwslcd4OgYMxQgLpiSWp2amp
        BalFMH1MHJxSDYxVBjo8LOc2O92YFcS1zbW2auVnRz2deXNWpe+84P9Pr69wrUPog2btrh0C
        Z45lKq96EdW0d+a2H3mLb68OUAj9NGWJfaWRb5RxofzLRdJ+DBWv9gj+lJGv9dJmvJnOVOEx
        xUznqPoBrkCfK4s3Rk9kazzy9kJw/K6N98Qm1LHwT6/m9Jms6KjEUpyRaKjFXFScCAChZdWy
        kgIAAA==
X-CMS-MailID: 20190912161550eucas1p2bdc813d46f337f3717bdbfd33bae8d4a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190912161550eucas1p2bdc813d46f337f3717bdbfd33bae8d4a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190912161550eucas1p2bdc813d46f337f3717bdbfd33bae8d4a
References: <20190912093315.5744-1-m.falkowski@samsung.com>
        <CGME20190912161550eucas1p2bdc813d46f337f3717bdbfd33bae8d4a@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Samsung Image Rotator to newer dt-schema format.

Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
v2:
- add required properties
- add proper commit recipients
---
 .../bindings/gpu/samsung-rotator.txt          | 28 ----------
 .../bindings/gpu/samsung-rotator.yaml         | 52 +++++++++++++++++++
 2 files changed, 52 insertions(+), 28 deletions(-)
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
index 000000000000..96afafe98388
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/samsung-rotator.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpu/samsung-rotator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Image Rotator
+
+maintainers:
+  - Inki Dae <inki.dae@samsung.com>
+
+properties:
+  compatible:
+    enum:
+      - "samsung,s5pv210-rotator"    # for Rotator IP in S5PV210
+      - "samsung,exynos4210-rotator" # for Rotator IP in Exynos4210
+      - "samsung,exynos4212-rotator" # for Rotator IP in Exynos4212/4412
+      - "samsung,exynos5250-rotator" # for Rotator IP in Exynos5250
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    description: |
+      Clock specifier for rotator clock according to generic clock
+      bindings. (See Documentation/devicetree/bindings/clock/exynos*.txt)
+    maxItems: 1
+
+  clock-names:
+    items:
+    - const: rotator
+    maxItems: 1
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

