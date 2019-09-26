Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C878CC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 12:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F58222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 12:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ysn18o/N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfIZM4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 08:56:22 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58623 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfIZM4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 08:56:22 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190926125620euoutp02773475247c17d99a958b2d5c3d79148a~H-kgK874g0588705887euoutp02S
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 12:56:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190926125620euoutp02773475247c17d99a958b2d5c3d79148a~H-kgK874g0588705887euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569502580;
        bh=2qQDxqYPHhCVF57kJMr4/wROezjZFSeNjBWmnGfCzE4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Ysn18o/NKgSQWz5nZnHoey2tB3+H37fdZ9XMu6Hu8GkkgBOTAICpi0bPt8bkKzaIE
         ZkVwyTpkr/W56FWtYOCS5VHh5cAMHH0ZREwSGr1tbqLT6KHlKwBpSSMqgQ0B+YtY5v
         JXg5hoQvz/NPAcvzuABZMmxbCvHW83+vwJyyI+84=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190926125620eucas1p29b39ec3cfd0a15952e064f6643dba2d3~H-kf3K8vG1380113801eucas1p28;
        Thu, 26 Sep 2019 12:56:20 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 03.0A.04374.475BC8D5; Thu, 26
        Sep 2019 13:56:20 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190926125619eucas1p249ac149ef1e1a3eb975dae94b08cd7be~H-kfkPKTa2227022270eucas1p2X;
        Thu, 26 Sep 2019 12:56:19 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190926125619eusmtrp108d0625b63966590fcef45b2fd324cf6~H-kfkFhCI0264802648eusmtrp1s;
        Thu, 26 Sep 2019 12:56:19 +0000 (GMT)
X-AuditID: cbfec7f5-4ddff70000001116-6b-5d8cb574fb0d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 53.A8.04166.375BC8D5; Thu, 26
        Sep 2019 13:56:19 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190926125619eusmtip2a47b589aeba0c6fa54c368a75966592a~H-kfAr7cm1774917749eusmtip2L;
        Thu, 26 Sep 2019 12:56:19 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Inki Dae <inki.dae@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Maciej Falkowski <m.falkowski@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2] dt-bindings: gpu: Convert Samsung Image Scaler to
 dt-schema
Date:   Thu, 26 Sep 2019 14:56:14 +0200
Message-Id: <20190926125614.10408-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSe0hTURzu7D52HV25TsGDidKgICHNCrqQRmbEMgSDoFwsW/OmopuyO18J
        YYqla9lQTJlmBmYyHw2z5QYOnaMRhku3yqChhVOxTMFXRmpu1+y/73k++HEIRLiJhhFZSjWj
        UspyRLgANb1Zdx5Wv9JKj7wd49NP7CMY7V5ZwOmaCR1KO51GPu2yNOF0g9PKoyfLu3G6y+7h
        088+jfLoin47/7RA3NncCcQ9hipcPHHfwRNX9xqAeKknIgWTCOLSmZysAkYVc+q6IHPiRyuW
        VxdRNDhLl4LpUA0gCEgdh0MfzmiAgBBS7QA+cpTzObIMYH+dCXBkCcA7LgdPAwL8jTb3Ux5n
        PAewtckCdivfW7y4L4VTsVAzr8F9RghVBqDbPOd/GKEWARx82exPBVMX4bMWL+bDKHUA6qaH
        /Jik4mGtx7qzFwk7jAOIrwypGRwuPXTinHEWvm5sxjgcDOccvXwOh8PhWi3KFcoB/DrSxeeI
        FkBXWQPgUifhkGMU8x0BoQ7BF5YYTk6AHd/WMO42gXB8PsgnI9uwxlSPcDIJK+8KufRBqHd0
        784Ovh/biYhhneWSTxZSUmgqW8F1IEL/f6oFAAMIZfJZRQbDHlMyhdGsTMHmKzOi5bmKHrD9
        K4Y3HSt9wPrnhg1QBBDtJRsMWqkQkxWwxQobgAQiCiGTU7clMl1WfItR5aap8nMY1gb2Eago
        lCzZM3lVSGXI1Ew2w+Qxqn8ujwgIKwVof1yJsHfq9upqUHx7o46nffyz81fV4sLWRmMbNtaa
        NBItP3pt3Jq9fCI5od5sVxvbJbMVennxRuTHVC8wi7fSo7xxnpTEL+ue8O5Cidu2PPU7/EFl
        2jm9O6nImnsz0XjlvPnCmisgNXBGu19OklLJgP6e3Pn5suVdvKa6T4SymbLYKETFyv4CCpMY
        FhEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsVy+t/xe7rFW3tiDc4fNrSYf+Qcq8WVr+/Z
        LCbdn8Bicf78BnaLy7vmsFnMOL+PyeJB8zo2i7VH7rJbLL1+kcmide8RdgcujzXz1jB6bFrV
        yeZxv/s4k0ffllWMHp83yQWwRunZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq
        6dvZpKTmZJalFunbJehl3H+zhLVgqlzFwRcWDYzPxLsYOTkkBEwkll1ZyNTFyMUhJLCUUWL5
        jH2sEAkZiZPTGqBsYYk/17rYIIo+MUpMe3+aBSTBJmAo0fUWIiEi0MYo8fnxFWYQh1ngC6PE
        5r8/2EGqhAX8JZpX3wMbxSKgKjHh2WEwm1fAVmLy3X1MECvkJVZvOMA8gZFnASPDKkaR1NLi
        3PTcYkO94sTc4tK8dL3k/NxNjMAg3Xbs5+YdjJc2Bh9iFOBgVOLh/bCmJ1aINbGsuDL3EKME
        B7OSCK9vJFCINyWxsiq1KD++qDQntfgQoynQ8onMUqLJ+cAIyiuJNzQ1NLewNDQ3Njc2s1AS
        5+0QOBgjJJCeWJKanZpakFoE08fEwSnVwBgjuuLWFHO32WIiHRrO5gqdfus+3yxoChO6/eJb
        uu+eXy/2LVyowrBvcpogs1XLTUuNfPmDBn1T9l115LPRPV5cIFFm6Gf5K/nAytj9/q/PHXJ9
        n1Yx6VmiMs8r5gV3U5Pip9bPnyNbuvBfYV1ZocbWvWUzRRPYVoRcuhQRLvu4iiXs9kq72Uos
        xRmJhlrMRcWJAOCT+6JoAgAA
X-CMS-MailID: 20190926125619eucas1p249ac149ef1e1a3eb975dae94b08cd7be
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190926125619eucas1p249ac149ef1e1a3eb975dae94b08cd7be
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190926125619eucas1p249ac149ef1e1a3eb975dae94b08cd7be
References: <CGME20190926125619eucas1p249ac149ef1e1a3eb975dae94b08cd7be@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maciej Falkowski <m.falkowski@samsung.com>

Convert Samsung Image Scaler to newer dt-schema format.

Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
v2:
- Removed quotation marks from string in 'compatible' property
- Added if-then statement for 'clocks' and 'clock-names' property
- Added include directive to example
- Added GIC_SPI macro to example

Best regards,
Maciej Falkowski
---
 .../bindings/gpu/samsung-scaler.txt           | 27 -------
 .../bindings/gpu/samsung-scaler.yaml          | 71 +++++++++++++++++++
 2 files changed, 71 insertions(+), 27 deletions(-)
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
index 000000000000..af19930d052e
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml
@@ -0,0 +1,71 @@
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
+if:
+  properties:
+    compatible:
+      contains:
+        const: samsung,exynos5420-scaler
+then:
+  properties:
+    clocks:
+      items:
+        - description: mscl clock
+
+    clock-names:
+      items:
+        - const: mscl
+else:
+  properties:
+    clocks:
+      items:
+        - description: mscl clock
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
-- 
2.17.1



