Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1C0C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 448D1222C0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="erajWbRY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388185AbfJDM7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 08:59:22 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:48950 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387976AbfJDM7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 08:59:22 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191004125920euoutp02c8637c847d4bd5cec3599f74fdcdb6cf~KcxZyl_2e1602316023euoutp02W
        for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2019 12:59:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191004125920euoutp02c8637c847d4bd5cec3599f74fdcdb6cf~KcxZyl_2e1602316023euoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1570193960;
        bh=GcBauXsEMEiJCxPDlVLXlQ0KFOglngvIkek6lOAaf7k=;
        h=From:To:Cc:Subject:Date:References:From;
        b=erajWbRYmnsHq1QJR1CJC/Bm1agzdXmnP1hlnB87ygKnzpviiS87lINMmPen7J214
         oU6u0Pz731hF6blwty46EAvEOwzMGo6suKlIgp1IGSgfd+AofJGXNJrYRqxlyM3wk5
         7UeZLprz8FkO50ocaEUXDWx/yIqsUEj9CYfHOsTc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191004125919eucas1p2654352f8c6e5147bbd04dd3be2af28e0~KcxZbqVQf0815808158eucas1p2B;
        Fri,  4 Oct 2019 12:59:19 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 59.09.04309.722479D5; Fri,  4
        Oct 2019 13:59:19 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191004125919eucas1p21149ecdf6d83fbe7bc8c39eaa8b29a46~KcxZH15pd0817408174eucas1p2D;
        Fri,  4 Oct 2019 12:59:19 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191004125919eusmtrp181c7b6d9ce9bfe3836201023081d05c2~KcxZHJ5Eq2829528295eusmtrp1W;
        Fri,  4 Oct 2019 12:59:19 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-6f-5d9742277290
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 3B.1E.04166.722479D5; Fri,  4
        Oct 2019 13:59:19 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191004125919eusmtip1edb4f2ee17db898daf6413aea45e7a27~KcxYjCVlC0401604016eusmtip1V;
        Fri,  4 Oct 2019 12:59:18 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maciej Falkowski <m.falkowski@samsung.com>
Subject: [PATCH v6] dt-bindings: sound: Convert Samsung I2S controller to
 dt-schema
Date:   Fri,  4 Oct 2019 14:59:14 +0200
Message-Id: <20191004125914.1033-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42LZduznOV11p+mxBi0fzC2uXDzEZLFxxnpW
        i6kPn7BZzD9yjtXi/PkN7BbfrnQwWVzeNYfNYsb5fUwWD5rXsVmsPXKX3eLwm3ZWB26PDZ+b
        2Dx2zrrL7rFpVSebR9+WVYwenzfJBbBGcdmkpOZklqUW6dslcGVM3P+AveCFR8WXw69ZGhgn
        WHQxcnJICJhIvNx4lrWLkYtDSGAFo8S3pRegnC+MErs+bGeCcD4zSnz82ssK09I9tZEZxBYS
        WM4oseWBH1xH35zfYEVsAoYSXW+72EBsEYE6ibNnjjCCFDELbGaS2Hh1JViRsECoxNxFHYwg
        NouAqsSZLWvYQWxeARuJ85+bmCG2yUus3nCAGaRZQuA3m8Snd9sZIRIuErt6jrNB2MISr45v
        YYewZSROT+5hgWhoZpR4eG4tO4TTwyhxuWkGVLe1xOHjF4HO4AC6SVNi/S59iLCjxL/9r5lA
        whICfBI33gqChJmBzEnbpjNDhHklOtqEIKrVJGYdXwe39uCFS1A3e0hMmzeNFRJCsRI3e94x
        TmCUm4WwawEj4ypG8dTS4tz01GKjvNRyveLE3OLSvHS95PzcTYzAtHH63/EvOxh3/Uk6xCjA
        wajEw/vBYnqsEGtiWXFl7iFGCQ5mJRHeS+unxArxpiRWVqUW5ccXleakFh9ilOZgURLnrWZ4
        EC0kkJ5YkpqdmlqQWgSTZeLglGpgNNndIsCTIN6WJ8Aa0yV1YZnW8dcf/HcU2pe556517fhb
        VnJ5Y9PcuWnyZgXZ57kSZ9VGcZrazt4WkcLnfUpH4b7X21WiQRJKabMCXz49+r1L+5hFt8nH
        z39TTlsIia42zL5r5LE44PyWTR9culZ9eV4dNDdr+mVzY5ET67Yb3nivOyEocBqTEktxRqKh
        FnNRcSIAZnwnUxcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsVy+t/xu7rqTtNjDa5Nlre4cvEQk8XGGetZ
        LaY+fMJmMf/IOVaL8+c3sFt8u9LBZHF51xw2ixnn9zFZPGhex2ax9shddovDb9pZHbg9Nnxu
        YvPYOesuu8emVZ1sHn1bVjF6fN4kF8AapWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hs
        HmtlZKqkb2eTkpqTWZZapG+XoJcxcf8D9oIXHhVfDr9maWCcYNHFyMkhIWAi0T21kbmLkYtD
        SGApo0Tn/mZGiISMxMlpDawQtrDEn2tdbCC2kMAnRomlXwtAbDYBQ4mutyBxLg4RgSZGiWOb
        Z7KAOMwC25kkzjcfAesQFgiWWHWwiQXEZhFQlTizZQ07iM0rYCNx/nMTM8QGeYnVGw4wT2Dk
        WcDIsIpRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMwXLcd+7l5B+OljcGHGAU4GJV4eD9YTI8V
        Yk0sK67MPcQowcGsJMJ7af2UWCHelMTKqtSi/Pii0pzU4kOMpkDLJzJLiSbnA2MpryTe0NTQ
        3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QDY+HuX7vv2l75uDjDeWLvjSta
        33dUr5s6aVLqz6lbG1yk7z+bsiel/kr+6dqG72dDpr14cHCqdFr/xuC/f7oKdjeUhbR8kEo8
        tanP9ZzUdqfz0nsdlWd6vf6iURbcz+Og4fOVof21aduLBx//W836oFSx537B9omPWF7HLNwy
        XT76fVgtH9+JWfZKLMUZiYZazEXFiQChayBLbQIAAA==
X-CMS-MailID: 20191004125919eucas1p21149ecdf6d83fbe7bc8c39eaa8b29a46
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191004125919eucas1p21149ecdf6d83fbe7bc8c39eaa8b29a46
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191004125919eucas1p21149ecdf6d83fbe7bc8c39eaa8b29a46
References: <CGME20191004125919eucas1p21149ecdf6d83fbe7bc8c39eaa8b29a46@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maciej Falkowski <m.falkowski@samsung.com>

Convert Samsung I2S controller to newer dt-schema format.

Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
[mszyprow: integrated fix for minor spelling issues]
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v6:
- integrated fix for minor spelling issues
- collected tags
---
 .../devicetree/bindings/sound/samsung-i2s.txt |  84 -----------
 .../bindings/sound/samsung-i2s.yaml           | 138 ++++++++++++++++++
 2 files changed, 138 insertions(+), 84 deletions(-)
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
index 000000000000..53e3bad4178c
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/samsung-i2s.yaml
@@ -0,0 +1,138 @@
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
+      samsung,s5pv210-i2s: for 8/16/24bit multichannel (5.1) I2S with
+      secondary FIFO, s/w reset control and internal mux for root clock
+      source.
+
+      samsung,exynos5420-i2s: for 8/16/24bit multichannel (5.1) I2S for
+      playback, stereo channel capture, secondary FIFO using internal
+      or external DMA, s/w reset control, internal mux for root clock
+      source and 7.1 channel TDM support for playback; TDM (Time division
+      multiplexing) is to allow transfer of multiple channel audio data on
+      single data line.
+
+      samsung,exynos7-i2s: with all the available features of Exynos5 I2S.
+      Exynos7 I2S has 7.1 channel TDM support for capture, secondary FIFO
+      with only external DMA and more number of root clock sampling
+      frequencies.
+
+      samsung,exynos7-i2s1: I2S1 on previous samsung platforms supports
+      stereo channels. Exynos7 I2S1 upgraded to 5.1 multichannel with
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
+      - items: # for I2S0
+          - const: iis
+          - const: i2s_opclk0
+          - const: i2s_opclk1
+      - items: # for I2S1 and I2S2
+          - const: iis
+          - const: i2s_opclk0
+    description: |
+      "iis" is the I2S bus clock and i2s_opclk0, i2s_opclk1 are sources
+      of the root clock. I2S0 has internal mux to select the source
+      of root clock and I2S1 and I2S2 doesn't have any such mux.
+
+  "#clock-cells":
+    const: 1
+
+  clock-output-names:
+    deprecated: true
+    oneOf:
+      - items: # for I2S0
+          - const: i2s_cdclk0
+      - items: # for I2S1
+          - const: i2s_cdclk1
+      - items: # for I2S2
+          - const: i2s_cdclk2
+    description: Names of the CDCLK I2S output clocks.
+
+  samsung,idma-addr:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Internal DMA register base address of the audio
+      subsystem (used in secondary sound source).
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
-- 
2.17.1

