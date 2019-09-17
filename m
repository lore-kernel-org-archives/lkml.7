Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96198C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 12:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 602AE21906
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 12:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JIZSedQM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfIQMGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 08:06:37 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39841 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbfIQMGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 08:06:37 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190917120636euoutp0286d7647f5db8919f67ce2742d884c9d0~FOFgWLVfj1656816568euoutp02G
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 12:06:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190917120636euoutp0286d7647f5db8919f67ce2742d884c9d0~FOFgWLVfj1656816568euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568721996;
        bh=F+K6DpAwBVxjsgY/t1njI26Ph1Zyasw/JStH2ygMML8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JIZSedQMus46TOWPAyFxeBmkeG0jCrJpmjgRBW3NJnxS8fyd6GIdtXMawZKnlRDcg
         /lrXiqUfjTD/PdDpCqjMwrlR5KsjNmJJOLeRjoSHaE33Tvb04XKQ94ge1z6fYfNGO5
         Udsjp+gttOK/mxy9VcJAPgMjs2a4MRReJiudAXBg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190917120635eucas1p2478a3be2e7530954dec8e3ac7401df42~FOFflNBmZ0999409994eucas1p2h;
        Tue, 17 Sep 2019 12:06:35 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 08.C8.04374.B4CC08D5; Tue, 17
        Sep 2019 13:06:35 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190917120634eucas1p20addfc4e369468561714f3c44d3d8bf5~FOFe1FmH-0999409994eucas1p2g;
        Tue, 17 Sep 2019 12:06:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190917120634eusmtrp204d933922ebe17ddc87561189e95aa75~FOFem1hc30498804988eusmtrp2S;
        Tue, 17 Sep 2019 12:06:34 +0000 (GMT)
X-AuditID: cbfec7f5-4f7ff70000001116-44-5d80cc4bf6ab
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D5.14.04166.A4CC08D5; Tue, 17
        Sep 2019 13:06:34 +0100 (BST)
Received: from AMDC2459.digital.local (unknown [106.120.51.95]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190917120633eusmtip1d575e4d8348d03e071cb08485b0a87ab~FOFeA4bdY2136821368eusmtip1S;
        Tue, 17 Sep 2019 12:06:33 +0000 (GMT)
From:   Maciej Falkowski <m.falkowski@samsung.com>
To:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     krzk@kernel.org, sbkim73@samsung.com, s.nawrocki@samsung.com,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, a.hajda@samsung.com,
        m.szyprowski@samsung.com, m.falkowski@samsung.com
Subject: [PATCH v2 2/2] dt-bindings: sound: Convert Samsung SMDK audio
 complex
Date:   Tue, 17 Sep 2019 14:06:27 +0200
Message-Id: <20190917120627.28357-1-m.falkowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190917111413.22711-1-m.falkowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSbUhTYRTHe+69u7uOZtc58EFn0kCiIDVndCGTyqCL9sEvBSqWN72o5Kbt
        qmlSzkydFqlBmpIvEelac6kT38IlS5IsmuL7WyjtizFDmRnGsna9Rt9+//85/+ccDg+BylpE
        /kSGJofVaphMJS7Bet5v24/FftIlhc09w6h582cRNTluQ6jHKw6cah72SLu9Q0xtTeoRamLg
        KU49sVsRarnEjFPtw0ti6sXMOEKVDg6LqXfOchE1bthEznjTHa67OG1qMgG6v2FJTHcZK3D6
        YbcR0K6ug3F4giQylc3MyGO1oVHJkvTy1lEsu12e3zPkRnTgpU8l8CIgGQHv99qxSiAhZKQB
        wJ3+70AQmwBa6hZwQbgAtK1Oi/9FDA79XqQNwKpVB8IXdiMlxVKecTIMVjkHMZ7l5B1YU9uE
        8gGUXAFwcdC1+5IvGQfNLVMinjEyGBaPbuz6UjISrk/UIcK0IPiqYwjl2Ys8DRvnf4sE3yiG
        nStEJSA8fB46DecE2xd+G+neW1QB//Q3I0JLIZzeCuRXgOQ9AGdq13Ch5xR0G2twvgclj8DX
        A6GCfRY+mOK35KPecHZt91qoBx/11KGCLYX6MpmAwdBZnSQEA2Cp6S0QmIb1+tK9C1YD6Kof
        Q6pBUMP/WS0AGIEfm8up01hOpWFvhnCMmsvVpIWkZKm7gOfffNwZ+dEHrO5rNkASQLlfOmsp
        SpKJmDyuQG0DkECVcmncbY8lTWUKbrHarKva3EyWs4EAAlP6SQv3LSfKyDQmh73Ostms9l8V
        Ibz8dWAuvyzoV0k3arKqLitKy674mDu/LjwvSVEcms1oOqHVyQryqizWeA23daBYNTGVziXE
        bhd8MNKNjHzkcGLFyfkv6/Ftvsn4pcDQ8J/hF6Sq6AVanxqjm+4be1OUERFjqeZiWkWNs3aF
        ZsOB66PcfZaAG9FIb4AfqrjoNbCoxLh05vhRVMsxfwGoNQoJMwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42I5/e/4XV2vMw2xBlfXC1rcWneO1eLKxUNM
        FlMfPmGzmH8EyD1/fgO7xbcrHUwWl3fNYbOYcX4fk8WD5nVsFmuP3GW3WHr9IpNF694j7BaH
        37SzWlxc8YXJgc9jw+cmNo8189YweuycdZfdY9OqTjaPvi2rGD0+b5ILYIvSsynKLy1JVcjI
        Ly6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy2hfdoqlYK1IxbYDf5ga
        GFcKdjFyckgImEiseNLB0sXIxSEksJRRouPeJkaIhLTE/msf2SFsYYk/17rYIIo+MUr03V/C
        BpJgEzCQ6H+zF6xbRKCJUWL+zZ9gDrPAW0aJlh2HmECqhAX8JB719YCNYhFQlWg8BTGWV8BG
        4sPl6UwQK+QlVm84wAxicwrYSsy99ZcVxBYCqln65Az7BEa+BYwMqxhFUkuLc9Nziw31ihNz
        i0vz0vWS83M3MQIjYduxn5t3MF7aGHyIUYCDUYmH98Cphlgh1sSy4srcQ4wSHMxKIrwBtfWx
        QrwpiZVVqUX58UWlOanFhxhNgY6ayCwlmpwPjNK8knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC
        6YklqdmpqQWpRTB9TBycUg2MeVf/TrVJiJh5qHbKduFA3iWCxinJinPWX241VKxfxvxNwZ8n
        /9PuktZDDWFTjUzaOErFQ16yff+Y7NDPMZvLKPRn+UY/ySNz1YQPMEfpf0h045GYyHHn5EFT
        obRJtwprNi/j/iKimLCvZ8b5F7LrNc6Zb0p/Ih2RcPcY56O2xs/y1htuuPMpsRRnJBpqMRcV
        JwIAt7uxd5oCAAA=
X-CMS-MailID: 20190917120634eucas1p20addfc4e369468561714f3c44d3d8bf5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190917120634eucas1p20addfc4e369468561714f3c44d3d8bf5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190917120634eucas1p20addfc4e369468561714f3c44d3d8bf5
References: <20190917111413.22711-1-m.falkowski@samsung.com>
        <CGME20190917120634eucas1p20addfc4e369468561714f3c44d3d8bf5@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Samsung SMDK audio complex to newer dt-schema format.

Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
v2:
- Added missing Signed-off-by certificate
---
 .../bindings/sound/samsung,smdk-wm8994.txt    | 14 -------
 .../bindings/sound/samsung,smdk-wm8994.yaml   | 38 +++++++++++++++++++
 2 files changed, 38 insertions(+), 14 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/samsung,smdk-wm8994.txt
 create mode 100644 Documentation/devicetree/bindings/sound/samsung,smdk-wm8994.yaml

diff --git a/Documentation/devicetree/bindings/sound/samsung,smdk-wm8994.txt b/Documentation/devicetree/bindings/sound/samsung,smdk-wm8994.txt
deleted file mode 100644
index 4686646fb122..000000000000
--- a/Documentation/devicetree/bindings/sound/samsung,smdk-wm8994.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-Samsung SMDK audio complex
-
-Required properties:
-- compatible : "samsung,smdk-wm8994"
-- samsung,i2s-controller: The phandle of the Samsung I2S0 controller
-- samsung,audio-codec: The phandle of the WM8994 audio codec
-Example:
-
-sound {
-		compatible = "samsung,smdk-wm8994";
-
-		samsung,i2s-controller = <&i2s0>;
-		samsung,audio-codec = <&wm8994>;
-};
diff --git a/Documentation/devicetree/bindings/sound/samsung,smdk-wm8994.yaml b/Documentation/devicetree/bindings/sound/samsung,smdk-wm8994.yaml
new file mode 100644
index 000000000000..a66c0dfdeb57
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/samsung,smdk-wm8994.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/samsung,smdk-wm8994.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung SoC SMDK audio complex
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+  - Sangbeom Kim <sbkim73@samsung.com>
+  - Sylwester Nawrocki <s.nawrocki@samsung.com>
+
+properties:
+  compatible:
+    const: "samsung,smdk-wm8994"
+
+  samsung,i2s-controller:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle of the Samsung I2S0 controller
+
+  samsung,audio-codec:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle of the WM8994 audio codec
+
+required:
+  - compatible
+  - samsung,i2s-controller
+  - samsung,audio-codec
+
+examples:
+  - |
+    sound {
+        compatible = "samsung,smdk-wm8994";
+        samsung,i2s-controller = <&i2s0>;
+        samsung,audio-codec = <&wm8994>;
+    };
+
-- 
2.17.1

