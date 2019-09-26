Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D66C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 18:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C00A8206E0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 18:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569523025;
	bh=mp0cAdKqEqH/s9D+3ht8kbYbJ5u3i3m3qD9oNpDN+K4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=fJTI2RZclvHCoakCm05/b8xiqeB/Jf6NGZbfLVUsmDuKtJ4DnTXPMqQeALxc7U9ON
	 tx4MnCoclTzxXogJLQcxBKen3VZV0B9XL7X2/t9cbDl0J9pWHH+WzZYvYVPGhsC6Ul
	 j4d1lEk1lx55ebJ7Sku29uRWGJdb87FQhnSsIqM8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbfIZShF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 14:37:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:39364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728413AbfIZShE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 14:37:04 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38AD820872;
        Thu, 26 Sep 2019 18:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569523023;
        bh=mp0cAdKqEqH/s9D+3ht8kbYbJ5u3i3m3qD9oNpDN+K4=;
        h=From:To:Cc:Subject:Date:From;
        b=h9Edz85612LyGIUz2DxRyySgApO6Tt3gb7FCJN5UBhbsJSfrIe/yWvrl1nlYoGuEs
         IZ4hJF6ntWeoZ3YD0fSUKRjxj2BWLCLtv2q6qip3DdKlZkwfl//fsqL7Q84QkCePh6
         9/5293kg2lwsw7idmxCfCLhQb6oG30V/G0lRtxHY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] dt-bindings: timer: Use defines instead of numbers in Exynos MCT examples
Date:   Thu, 26 Sep 2019 20:36:43 +0200
Message-Id: <20190926183643.7118-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the examples in Exynos Multi Core Timer bindings more readable and
bring them closer to real DTS by using defines for interrupt flags.

Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Rebased on top of:
https://patchwork.kernel.org/project/linux-samsung-soc/list/?series=177667&state=*
---
 .../timer/samsung,exynos4210-mct.yaml         | 37 ++++++++++++++-----
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
index bff3f54a398f..c4d152009f76 100644
--- a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
+++ b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
@@ -75,51 +75,68 @@ examples:
     // In this example, the IP contains two local timers, using separate
     // interrupts, so two local timer interrupts have been specified,
     // in addition to four global timer interrupts.
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
 
     timer@10050000 {
         compatible = "samsung,exynos4210-mct";
         reg = <0x10050000 0x800>;
-        interrupts = <0 57 0>, <0 69 0>, <0 70 0>, <0 71 0>,
-                     <0 42 0>, <0 48 0>;
+        interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
     };
 
   - |
     // In this example, the timer interrupts are connected to two separate
     // interrupt controllers. Hence, an interrupts-extended is needed.
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
 
     timer@101c0000 {
         compatible = "samsung,exynos4210-mct";
         reg = <0x101C0000 0x800>;
-        interrupts-extended = <&gic 0 57 0>,
-                              <&gic 0 69 0>,
+        interrupts-extended = <&gic GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+                              <&gic GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
                               <&combiner 12 6>,
                               <&combiner 12 7>,
-                              <&gic 0 42 0>,
-                              <&gic 0 48 0>;
+                              <&gic GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
+                              <&gic GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
     };
 
   - |
     // In this example, the IP contains four local timers, but using
     // a per-processor interrupt to handle them. Only one first local
     // interrupt is specified.
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
 
     timer@10050000 {
         compatible = "samsung,exynos4412-mct";
         reg = <0x10050000 0x800>;
 
-        interrupts = <0 57 0>, <0 69 0>, <0 70 0>, <0 71 0>,
-                     <0 42 0>;
+        interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
     };
 
   - |
     // In this example, the IP contains four local timers, but using
     // a per-processor interrupt to handle them. All the local timer
     // interrupts are specified.
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
 
     timer@10050000 {
         compatible = "samsung,exynos4412-mct";
         reg = <0x10050000 0x800>;
 
-        interrupts = <0 57 0>, <0 69 0>, <0 70 0>, <0 71 0>,
-                     <0 42 0>, <0 42 0>, <0 42 0>, <0 42 0>;
+        interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
     };
-- 
2.17.1

