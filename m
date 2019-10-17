Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317D5FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 10:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93DA20869
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 10:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SpxaLWr7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408740AbfJQKFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 06:05:37 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33984 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408729AbfJQKFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 06:05:36 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191017100535euoutp010049041f5da1e01d9f3d83b237f676a6~OZyadoUYp0774307743euoutp01J
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 10:05:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191017100535euoutp010049041f5da1e01d9f3d83b237f676a6~OZyadoUYp0774307743euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1571306735;
        bh=zwOlnVoiHkpkS1qISvZUE1+ZuYCNoayDt7eUAU8ghBI=;
        h=From:To:Cc:Subject:Date:References:From;
        b=SpxaLWr7ZPq9NqzInHJTitFyGU+CEX3jviIsobqOFhxbg5aUAE5riSxU9pKIWgNq4
         SSV/NE1lvAq7jBSfYWRzbqy9uZFHYTgsnEA+CMxM/jT8xaj3lVObc6pfyDuBov757q
         12OXFShQ/GAr9OFE7oLc5vvAFr57KXqKkBO1qZ7I=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191017100534eucas1p29e0e07a46b5522b6a80033f7aa2d0627~OZyZ6eukv2843428434eucas1p2t;
        Thu, 17 Oct 2019 10:05:34 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id EA.8B.04309.EEC38AD5; Thu, 17
        Oct 2019 11:05:34 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191017100534eucas1p1407cf6ef5606d6bd6a4140502cc95984~OZyZmWJUv1060810608eucas1p1n;
        Thu, 17 Oct 2019 10:05:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191017100534eusmtrp12ed03787e55c280b2d54235283ed3e79~OZyZlku1J0854508545eusmtrp1C;
        Thu, 17 Oct 2019 10:05:34 +0000 (GMT)
X-AuditID: cbfec7f4-afbff700000010d5-7a-5da83cee35ce
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 9E.D2.04166.EEC38AD5; Thu, 17
        Oct 2019 11:05:34 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191017100534eusmtip284f84d249c6e0f6a2f1c1c21abe1f185~OZyZEXyQ41706717067eusmtip2c;
        Thu, 17 Oct 2019 10:05:34 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maciej Falkowski <m.falkowski@samsung.com>
Subject: [PATCH v2] dt-bindings: sound: Convert Samsung Exynos Odroid
 XU3/XU4 audio complex to dt-schema
Date:   Thu, 17 Oct 2019 12:05:29 +0200
Message-Id: <20191017100529.4183-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSfUhTYRTGe3c/dh1OblP0TUNhMMUgPyLqRhJmEQsKIwUpGbbyMq1tyq5b
        aVI2RW3NUYZNR8O+yLXQbbLEj5Caayu1zU1J/7EmVJQ4I5TIlMp5+/jv9zznnPc5B14CETRj
        iUS5sopWKaVyIc5D+zwrvu2LORZJlmeIoqYCLg7laLdhVNvce5zqdPswyu+3c6lvU80canLw
        Nk61+4c5VKi+B6e63bNc6tfTfi41stCE5UaL7UtaXDxgmuWKe61XcbHBaQXipd7kY9hJXk4p
        LS/X0KrMfad4ZT3eNm7laOaFuVAHqAN6kQ5EEZDcCY0zBo4O8AgBaQFwuuEdlxXLAF7zruKs
        WALwg6tjvUJsjMwYalm/C8DOCQP6b8L30IhF3sXJbKgL6/AIx5GX4OtxN4gwQgY50OmIinAs
        eRZ227+iEUZJEXStGDaYT+bAF75hnN0vBT62P0MiAZBcxWFw4T7GFg7CK4F7XJZj4bzX+Ye3
        wrGbepQdqAdwztfNZYUewEltO2C79sIRbwCL3IOQ6dA2mMna++GrWx2APTMGzoQ3s0vHwNY+
        I8LafNjcKGC7U6HJ2/Mv9vlEEGFZDE195g0WkBL4xNKEXgfJpv9ZdwCwggRazShkNLNDSZ/P
        YKQKRq2UZZypUPSC9f8x9tO73A8G1067AEkAYTT/E9IlEWBSDVOtcAFIIMI4fmfDA4mAXyqt
        rqFVFSUqtZxmXCCJQIUJ/IubQsUCUiatos/RdCWt+lvlEFGJdUD15VBda9bIcZAWnz19Qm0p
        LLGFRH6RrZRfbZUXp/LvfgwOJQ3o196meRzK8cLawjxNujac8uNRU4tRXQbn42tyzUd2p+A4
        dbig6HORVjbcfxl3LfpWMtx5uzRFW/bcCCwUvHGYx5ye77gZyU8ftYQPNKK5R6Ut+Y5QzUsh
        ypRJs7chKkb6GxDdnpcbAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsVy+t/xe7rvbFbEGjSuU7K4cvEQk8XGGetZ
        LaY+fMJmMf/IOVaL8+c3sFt8u9LBZHF51xw2ixnn9zFZPGhex2ax9shddov/e3awWxx+087q
        wOOx4XMTm8fOWXfZPTat6mTz6NuyitHj8ya5ANYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0j
        E0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYx1x6eyF5zSr3j4YCZjA2OPahcjB4eEgInEjb6a
        LkYuDiGBpYwSu/sOsnUxcgLFZSROTmtghbCFJf5c62KDKPrEKPFu71uwIjYBQ4mutxAJEYEm
        Roljm2eygDjMAjeYJPbP6WABqRIWyJBY+Wc7O4jNIqAqcehnH1icV8BG4ui5fVDr5CVWbzjA
        PIGRZwEjwypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzAwN127OfmHYyXNgYfYhTgYFTi4Z3A
        uDxWiDWxrLgy9xCjBAezkgjv/JYlsUK8KYmVValF+fFFpTmpxYcYTYGWT2SWEk3OB0ZVXkm8
        oamhuYWlobmxubGZhZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkGRs/rR4Q0/Aq6/roxm960
        ZMti7mATcfDcVp5z6pHIuitsO97XLpJt+2h7636ZqLZI7WmBazM1/cR6tVZsShBMYtXdmhya
        267wT35iquyjutoJXxYmzFPPmJ20IbrUWaspa4bpgqk9uiUL738I6r+17OWf4hT3yzMOv50Y
        IrAlZLV/XKZs7JkgJZbijERDLeai4kQA4gOHZnICAAA=
X-CMS-MailID: 20191017100534eucas1p1407cf6ef5606d6bd6a4140502cc95984
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191017100534eucas1p1407cf6ef5606d6bd6a4140502cc95984
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191017100534eucas1p1407cf6ef5606d6bd6a4140502cc95984
References: <CGME20191017100534eucas1p1407cf6ef5606d6bd6a4140502cc95984@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maciej Falkowski <m.falkowski@samsung.com>

Convert Samsung Exynos Odroid XU3/XU4 audio complex with MAX98090 codec
to newer dt-schema format.

'clocks' property is unneeded in the bindings and is left undefined in 'properties'.

'samsung,audio-widgets' and 'samsung,audio-routing' are optional from driver
perspective and they are set as unrequired.

Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
[mszyprow: reordered non-standard properties]
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 .../bindings/sound/samsung,odroid.txt         | 54 -----------
 .../bindings/sound/samsung,odroid.yaml        | 91 +++++++++++++++++++
 2 files changed, 91 insertions(+), 54 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/samsung,odroid.txt
 create mode 100644 Documentation/devicetree/bindings/sound/samsung,odroid.yaml

diff --git a/Documentation/devicetree/bindings/sound/samsung,odroid.txt b/Documentation/devicetree/bindings/sound/samsung,odroid.txt
deleted file mode 100644
index e9da2200e173..000000000000
--- a/Documentation/devicetree/bindings/sound/samsung,odroid.txt
+++ /dev/null
@@ -1,54 +0,0 @@
-Samsung Exynos Odroid XU3/XU4 audio complex with MAX98090 codec
-
-Required properties:
-
- - compatible - "hardkernel,odroid-xu3-audio" - for Odroid XU3 board,
-		"hardkernel,odroid-xu4-audio" - for Odroid XU4 board (deprecated),
-		"samsung,odroid-xu3-audio" - for Odroid XU3 board (deprecated),
-		"samsung,odroid-xu4-audio" - for Odroid XU4 board (deprecated)
- - model - the user-visible name of this sound complex
- - clocks - should contain entries matching clock names in the clock-names
-    property
- - samsung,audio-widgets - this property specifies off-codec audio elements
-   like headphones or speakers, for details see widgets.txt
- - samsung,audio-routing - a list of the connections between audio
-   components;  each entry is a pair of strings, the first being the
-   connection's sink, the second being the connection's source;
-   valid names for sources and sinks are the MAX98090's pins (as
-   documented in its binding), and the jacks on the board
-
-   For Odroid X2:
-     "Headphone Jack", "Mic Jack", "DMIC"
-
-   For Odroid U3, XU3:
-     "Headphone Jack", "Speakers"
-
-   For Odroid XU4:
-     no entries
-
-Required sub-nodes:
-
- - 'cpu' subnode with a 'sound-dai' property containing the phandle of the I2S
-    controller
- - 'codec' subnode with a 'sound-dai' property containing list of phandles
-    to the CODEC nodes, first entry must be corresponding to the MAX98090
-    CODEC and the second entry must be the phandle of the HDMI IP block node
-
-Example:
-
-sound {
-	compatible = "hardkernel,odroid-xu3-audio";
-	model = "Odroid-XU3";
-	samsung,audio-routing =
-		"Headphone Jack", "HPL",
-		"Headphone Jack", "HPR",
-		"IN1", "Mic Jack",
-		"Mic Jack", "MICBIAS";
-
-	cpu {
-		sound-dai = <&i2s0 0>;
-	};
-	codec {
-		sound-dai = <&hdmi>, <&max98090>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/sound/samsung,odroid.yaml b/Documentation/devicetree/bindings/sound/samsung,odroid.yaml
new file mode 100644
index 000000000000..c6b244352d05
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/samsung,odroid.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/samsung,odroid.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos Odroid XU3/XU4 audio complex with MAX98090 codec
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+  - Sylwester Nawrocki <s.nawrocki@samsung.com>
+
+properties:
+  compatible:
+    oneOf:
+      - const: hardkernel,odroid-xu3-audio
+
+      - const: hardkernel,odroid-xu4-audio
+        deprecated: true
+
+      - const: samsung,odroid-xu3-audio
+        deprecated: true
+
+      - const: samsung,odroid-xu4-audio
+        deprecated: true
+
+  model:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: The user-visible name of this sound complex.
+
+  cpu:
+    type: object
+    properties:
+      sound-dai:
+        $ref: /schemas/types.yaml#/definitions/phandle-array
+        description: phandles to the I2S controllers
+
+  codec:
+    type: object
+    properties:
+      sound-dai:
+        $ref: /schemas/types.yaml#/definitions/phandle-array
+        description: |
+          List of phandles to the CODEC nodes,
+          first entry must be corresponding to the MAX98090 CODEC and
+          the second entry must be the phandle of the HDMI IP block node.
+
+  samsung,audio-routing:
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    description: |
+      List of the connections between audio
+      components;  each entry is a pair of strings, the first being the
+      connection's sink, the second being the connection's source;
+      valid names for sources and sinks are the MAX98090's pins (as
+      documented in its binding), and the jacks on the board.
+      For Odroid X2: "Headphone Jack", "Mic Jack", "DMIC"
+      For Odroid U3, XU3: "Headphone Jack", "Speakers"
+      For Odroid XU4: no entries
+
+  samsung,audio-widgets:
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    description: |
+      This property specifies off-codec audio elements
+      like headphones or speakers, for details see widgets.txt
+
+required:
+  - compatible
+  - model
+  - cpu
+  - codec
+
+examples:
+  - |
+    sound {
+        compatible = "hardkernel,odroid-xu3-audio";
+        model = "Odroid-XU3";
+        samsung,audio-routing =
+                "Headphone Jack", "HPL",
+                "Headphone Jack", "HPR",
+                "IN1", "Mic Jack",
+                "Mic Jack", "MICBIAS";
+
+        cpu {
+            sound-dai = <&i2s0 0>;
+        };
+
+        codec {
+            sound-dai = <&hdmi>, <&max98090>;
+        };
+    };
+
-- 
2.17.1

