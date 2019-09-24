Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52653C432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 11:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156C82168B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 11:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RmKwS2Bo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504711AbfIXL4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 07:56:04 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51693 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388579AbfIXL4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 07:56:04 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190924115602euoutp02ef9b842b837b7408488262799bcf5890~HXdRsSqhg2812428124euoutp02k
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 11:56:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190924115602euoutp02ef9b842b837b7408488262799bcf5890~HXdRsSqhg2812428124euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569326162;
        bh=gCAMdIvwje0m97+51GyLZ9EZlrEpry9bO8qk8eEJ/HI=;
        h=From:To:Cc:Subject:Date:References:From;
        b=RmKwS2BoSX10crOS1HUBmikd8tkxzKRHz6pzhuWtJda9oLZhF5S0oJFQYIQYXfSMr
         JVr/zUsLFE3iziamN7uY3p7RIZ4ZTYpbn54RJJA3EWTx/VG5sRV5mmHfpNTtyzw1UU
         sZherPYH//ZIQsW7iXjV+KniuSNskkYiocb12i/4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190924115601eucas1p152d6f03a0a36f525ace5b104c9fced7f~HXdRXG-IA1277412774eucas1p14;
        Tue, 24 Sep 2019 11:56:01 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id DC.AD.04374.1540A8D5; Tue, 24
        Sep 2019 12:56:01 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190924115601eucas1p13b27b09fcd22bb3961fa2491380c40eb~HXdRBYCat2634326343eucas1p1T;
        Tue, 24 Sep 2019 11:56:01 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190924115601eusmtrp14d25f412999fba76227653b950d85a1c~HXdQ-4Gpr0881808818eusmtrp1P;
        Tue, 24 Sep 2019 11:56:01 +0000 (GMT)
X-AuditID: cbfec7f5-4f7ff70000001116-bb-5d8a0451d9da
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 6D.92.04166.1540A8D5; Tue, 24
        Sep 2019 12:56:01 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190924115600eusmtip1976ff891f12f76ef2e685098d86c5c3c~HXdQU6eqh2538125381eusmtip1_;
        Tue, 24 Sep 2019 11:56:00 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maciej Falkowski <m.falkowski@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v4] dt-bindings: sound: Convert Samsung I2S controller to
 dt-schema
Date:   Tue, 24 Sep 2019 13:55:53 +0200
Message-Id: <20190924115553.25982-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42LZduzned1Alq5Yg3fTtC2uXDzEZDH14RM2
        i/lHzrFanD+/gd3i25UOJovLu+awWcw4v4/J4kHzOjaLtUfuslssvX6RyaJ17xF2i8Nv2lkd
        eDw2fG5i81gzbw2jx85Zd9k9Nq3qZPPo27KK0ePzJrkAtigum5TUnMyy1CJ9uwSujMdvigta
        PSsWfuNpYFxt0cXIySEhYCKxvWcpcxcjF4eQwApGicUr+xghnC+MEh/WtrFCOJ8ZJU5fncMI
        09K8eQVUy3JGiZsL5zDDtRz9doodpIpNwFCi620XG4gtIlAncfbMEbC5zAJHmCSa7/9mAkkI
        C4RK3NreDmazCKhKfFo6mQXE5hWwlfi8q5cdYp28xOoNB8A2SAj8Z5OYuH0N0FQOIMdFYu00
        HYgaYYlXx7dA1ctInJ7cwwJR38wo8fDcWnYIp4dR4nLTDKgnrCUOH7/ICjKIWUBTYv0ufYiw
        o8SVBUuZIObzSdx4KwgSZgYyJ22bzgwR5pXoaBOCqFaTmHV8HdzagxcuMUPYHhLHzz4HiwsJ
        xEqc6NrFMoFRbhbCrgWMjKsYxVNLi3PTU4uN81LL9YoTc4tL89L1kvNzNzEC08jpf8e/7mDc
        9yfpEKMAB6MSD6/Eto5YIdbEsuLK3EOMEhzMSiK8m7TaYoV4UxIrq1KL8uOLSnNSiw8xSnOw
        KInzVjM8iBYSSE8sSc1OTS1ILYLJMnFwSjUw8v/kPHy+b82EQDdvtsOb+b/aRhjmsUjcrzpS
        nftB6dvRGYwzbgldcc4vOMVyqubWmnv9y6RfhG8vNlj8wO/Y/JdzTZ8z3V4Q1yJuIfXRdwJr
        D1eo+a+EnKPdsoX5++bGHTsU1/5D9qqr99UnxiXv9zcY7igV5GfPSzt4+eDZqY/Zv2cdSnP+
        r8RSnJFoqMVcVJwIAMVPTrcfAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsVy+t/xu7qBLF2xBvP7+SyuXDzEZDH14RM2
        i/lHzrFanD+/gd3i25UOJovLu+awWcw4v4/J4kHzOjaLtUfuslssvX6RyaJ17xF2i8Nv2lkd
        eDw2fG5i81gzbw2jx85Zd9k9Nq3qZPPo27KK0ePzJrkAtig9m6L80pJUhYz84hJbpWhDCyM9
        Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jMdvigtaPSsWfuNpYFxt0cXIySEhYCLR
        vHkFcxcjF4eQwFJGiRlLGlghEjISJ6fB2MISf651sUEUfWKUWPJ3GzNIgk3AUKLrLURCRKCJ
        UeLY5pksIA6zwCkmiRtXpzCCVAkLBEs8an0D1sEioCrxaelkFhCbV8BW4vOuXnaIFfISqzcc
        YJ7AyLOAkWEVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYABvO/Zz8w7GSxuDDzEKcDAq8fBK
        bOuIFWJNLCuuzD3EKMHBrCTCu0mrLVaINyWxsiq1KD++qDQntfgQoynQ8onMUqLJ+cDoyiuJ
        NzQ1NLewNDQ3Njc2s1AS5+0QOBgjJJCeWJKanZpakFoE08fEwSnVwDhLoXnLZKvCbXKHklru
        fb6sp8pWLS1es6v0xtW43Uwfnlmo7PaoMFpXpzH9Z/uC74oXhHdtOS1zYf1vO6Uq2fc3D3M8
        XGvp31D7eJeVJ4PIt5AlGW/LcjT6Dvuu5H7IdJ/dbYHJmZpIbY5TazyaTop/7RX7Uibxpq/o
        0qvq6+YndvN9/80RHKzEUpyRaKjFXFScCAAOrd39dgIAAA==
X-CMS-MailID: 20190924115601eucas1p13b27b09fcd22bb3961fa2491380c40eb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190924115601eucas1p13b27b09fcd22bb3961fa2491380c40eb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190924115601eucas1p13b27b09fcd22bb3961fa2491380c40eb
References: <CGME20190924115601eucas1p13b27b09fcd22bb3961fa2491380c40eb@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maciej Falkowski <m.falkowski@samsung.com>

Convert Samsung I2S controller to newer dt-schema format.

Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
v4:
- Removed description of i2s device nodes' clocks from
'clocks' property.
- Added 'clock-output-names' property.
- Added description of clock names.
- Added '#clock-cells' property to required properties
- Description of the provided clocks moved to samsung-i2s.h
in separate patch

Best regards,
Maciej Falkowski
---
 .../devicetree/bindings/sound/samsung-i2s.txt |  84 -----------
 .../bindings/sound/samsung-i2s.yaml           | 136 ++++++++++++++++++
 2 files changed, 136 insertions(+), 84 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/samsung-i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/samsung-i2s.yaml

diff --git a/Documentation/devicetree/bindings/sound/samsung-i2s.txt b/Documentation/devicetree/bindings/sound/samsung-i2s.txt
deleted file mode 100644
index a88cb00fa096..000000000000
--- a/Documentation/devicetree/bindings/sound/samsung-i2s.txt
+++ /dev/null
@@ -1,84 +0,0 @@
-* Samsung I2S controller
-
-Required SoC Specific Properties:
-
-- compatible : should be one of the following.
-   - samsung,s3c6410-i2s: for 8/16/24bit stereo I2S.
-   - samsung,s5pv210-i2s: for 8/16/24bit multichannel(5.1) I2S with
-     secondary fifo, s/w reset control and internal mux for root clk src.
-   - samsung,exynos5420-i2s: for 8/16/24bit multichannel(5.1) I2S for
-     playback, stereo channel capture, secondary fifo using internal
-     or external dma, s/w reset control, internal mux for root clk src
-     and 7.1 channel TDM support for playback. TDM (Time division multiplexing)
-     is to allow transfer of multiple channel audio data on single data line.
-   - samsung,exynos7-i2s: with all the available features of exynos5 i2s,
-     exynos7 I2S has 7.1 channel TDM support for capture, secondary fifo
-     with only external dma and more no.of root clk sampling frequencies.
-   - samsung,exynos7-i2s1: I2S1 on previous samsung platforms supports
-     stereo channels. exynos7 i2s1 upgraded to 5.1 multichannel with
-     slightly modified bit offsets.
-
-- reg: physical base address of the controller and length of memory mapped
-  region.
-- dmas: list of DMA controller phandle and DMA request line ordered pairs.
-- dma-names: identifier string for each DMA request line in the dmas property.
-  These strings correspond 1:1 with the ordered pairs in dmas.
-- clocks: Handle to iis clock and RCLK source clk.
-- clock-names:
-  i2s0 uses some base clocks from CMU and some are from audio subsystem internal
-  clock controller. The clock names for i2s0 should be "iis", "i2s_opclk0" and
-  "i2s_opclk1" as shown in the example below.
-  i2s1 and i2s2 uses clocks from CMU. The clock names for i2s1 and i2s2 should
-  be "iis" and "i2s_opclk0".
-  "iis" is the i2s bus clock and i2s_opclk0, i2s_opclk1 are sources of the root
-  clk. i2s0 has internal mux to select the source of root clk and i2s1 and i2s2
-  doesn't have any such mux.
-- #clock-cells: should be 1, this property must be present if the I2S device
-  is a clock provider in terms of the common clock bindings, described in
-  ../clock/clock-bindings.txt.
-- clock-output-names (deprecated): from the common clock bindings, names of
-  the CDCLK I2S output clocks, suggested values are "i2s_cdclk0", "i2s_cdclk1",
-  "i2s_cdclk3" for the I2S0, I2S1, I2S2 devices respectively.
-
-There are following clocks available at the I2S device nodes:
- CLK_I2S_CDCLK    - the CDCLK (CODECLKO) gate clock,
- CLK_I2S_RCLK_PSR - the RCLK prescaler divider clock (corresponding to the
-		    IISPSR register),
- CLK_I2S_RCLK_SRC - the RCLKSRC mux clock (corresponding to RCLKSRC bit in
-		    IISMOD register).
-
-Refer to the SoC datasheet for availability of the above clocks.
-The CLK_I2S_RCLK_PSR and CLK_I2S_RCLK_SRC clocks are usually only available
-in the IIS Multi Audio Interface.
-
-Note: Old DTs may not have the #clock-cells property and then not use the I2S
-node as a clock supplier.
-
-Optional SoC Specific Properties:
-
-- samsung,idma-addr: Internal DMA register base address of the audio
-  sub system(used in secondary sound source).
-- pinctrl-0: Should specify pin control groups used for this controller.
-- pinctrl-names: Should contain only one value - "default".
-- #sound-dai-cells: should be 1.
-
-
-Example:
-
-i2s0: i2s@3830000 {
-	compatible = "samsung,s5pv210-i2s";
-	reg = <0x03830000 0x100>;
-	dmas = <&pdma0 10
-		&pdma0 9
-		&pdma0 8>;
-	dma-names = "tx", "rx", "tx-sec";
-	clocks = <&clock_audss EXYNOS_I2S_BUS>,
-		<&clock_audss EXYNOS_I2S_BUS>,
-		<&clock_audss EXYNOS_SCLK_I2S>;
-	clock-names = "iis", "i2s_opclk0", "i2s_opclk1";
-	#clock-cells = <1>;
-	samsung,idma-addr = <0x03000000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2s0_bus>;
-	#sound-dai-cells = <1>;
-};
diff --git a/Documentation/devicetree/bindings/sound/samsung-i2s.yaml b/Documentation/devicetree/bindings/sound/samsung-i2s.yaml
new file mode 100644
index 000000000000..7d2750c26f11
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/samsung-i2s.yaml
@@ -0,0 +1,136 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/samsung-i2s.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung SoC I2S controller
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+  - Sylwester Nawrocki <s.nawrocki@samsung.com>
+
+properties:
+  compatible:
+    description: |
+      samsung,s3c6410-i2s: for 8/16/24bit stereo I2S.
+
+      samsung,s5pv210-i2s: for 8/16/24bit multichannel(5.1) I2S with
+      secondary fifo, s/w reset control and internal mux for root clk src.
+
+      samsung,exynos5420-i2s: for 8/16/24bit multichannel(5.1) I2S for
+      playback, stereo channel capture, secondary fifo using internal
+      or external dma, s/w reset control, internal mux for root clk src
+      and 7.1 channel TDM support for playback. TDM (Time division multiplexing)
+      is to allow transfer of multiple channel audio data on single data line.
+
+      samsung,exynos7-i2s: with all the available features of exynos5 i2s.
+      exynos7 I2S has 7.1 channel TDM support for capture, secondary fifo
+      with only external dma and more no.of root clk sampling frequencies.
+
+      samsung,exynos7-i2s1: I2S1 on previous samsung platforms supports
+      stereo channels. exynos7 i2s1 upgraded to 5.1 multichannel with
+      slightly modified bit offsets.
+    enum:
+      - samsung,s3c6410-i2s
+      - samsung,s5pv210-i2s
+      - samsung,exynos5420-i2s
+      - samsung,exynos7-i2s
+      - samsung,exynos7-i2s1
+
+  reg:
+    maxItems: 1
+
+  dmas:
+    minItems: 2
+    maxItems: 3
+
+  dma-names:
+    oneOf:
+      - items:
+          - const: tx
+          - const: rx
+      - items:
+          - const: tx
+          - const: rx
+          - const: tx-sec
+
+  clocks:
+    minItems: 1
+    maxItems: 3
+
+  clock-names:
+    oneOf:
+      - items:
+          - const: iis
+      - items: # for i2s0
+          - const: iis
+          - const: i2s_opclk0
+          - const: i2s_opclk1
+      - items: # for i2s1 and i2s2
+          - const: iis
+          - const: i2s_opclk0
+    description: |
+      "iis" is the i2s bus clock and i2s_opclk0, i2s_opclk1 are sources
+      of the root clk. i2s0 has internal mux to select the source
+      of root clk and i2s1 and i2s2 doesn't have any such mux.
+
+  "#clock-cells":
+    const: 1
+
+  clock-output-names: # deprecated
+    oneOf:
+      - items: # for i2s0
+          - const: i2s_cdclk0
+      - items: # for i2s1
+          - const: i2s_cdclk1
+      - items: # for i2s2
+          - const: i2s_cdclk2
+    description: Names of the CDCLK I2S output clocks.
+
+  samsung,idma-addr:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Internal DMA register base address of the audio
+      sub system(used in secondary sound source).
+
+  pinctrl-0:
+    description: Should specify pin control groups used for this controller.
+
+  pinctrl-names:
+    const: default
+
+  "#sound-dai-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - dmas
+  - dma-names
+  - clocks
+  - clock-names
+  - "#clock-cells"
+
+examples:
+  - |
+    #include <dt-bindings/clock/exynos-audss-clk.h>
+
+    i2s0: i2s@3830000 {
+        compatible = "samsung,s5pv210-i2s";
+        reg = <0x03830000 0x100>;
+        dmas = <&pdma0 10>,
+                <&pdma0 9>,
+                <&pdma0 8>;
+        dma-names = "tx", "rx", "tx-sec";
+        clocks = <&clock_audss EXYNOS_I2S_BUS>,
+                <&clock_audss EXYNOS_I2S_BUS>,
+                <&clock_audss EXYNOS_SCLK_I2S>;
+        clock-names = "iis", "i2s_opclk0", "i2s_opclk1";
+        #clock-cells = <1>;
+        samsung,idma-addr = <0x03000000>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&i2s0_bus>;
+        #sound-dai-cells = <1>;
+    };
+
-- 
2.17.1



