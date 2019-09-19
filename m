Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D662AC4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7FE21D6C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="BzOacMNy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732063AbfISH2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 03:28:07 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43133 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbfISH2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 03:28:06 -0400
Received: by mail-pl1-f193.google.com with SMTP id 4so1170960pld.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 00:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=H3ZFg6Ip4/ySx02vg351K3EIXCHgNEDMYbg7+0FsxGE=;
        b=BzOacMNyjiA5peSOoO00KtvDPv26/JEZvsyWkdGfR2lPQci/mNE/pJ0rq0rT40j0u1
         VRw8MyxfaeL+ZiJ2Tkqk1cSSJLlT9qTdJeOrHcNPE3UhanyV5WCw7dW33StrwxTgaULQ
         pQGLJQRhElY0qbQ6V+sds1rlmAGfqYcTjcZcnjdeYViNkhTfxPSXubGkFKSbM+enkeox
         RXFNcQNt1yqh0SO42/gjTEJLERjGpGZn4r5/iDIhB8nVYbEuUvK+XXfVHDdCJaGf70iI
         +SHbSe1Mwb7aHOKKW5XH+mD2wDztSDHWCRqvjAXYn4frH6eeWoC97Xg1JXFn6SAez6tx
         pBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H3ZFg6Ip4/ySx02vg351K3EIXCHgNEDMYbg7+0FsxGE=;
        b=Ysf3OZLF6jsbgOHWj+xJ/Em7qtTL60Yr1qhzdxRbchBmxyWgFib0kJuJQuy2pH8NAF
         R7xnt45UAvUpeJl8sp9JfnsOIy+XDcWdow/0KUOqlZv+lvgAWieQhgDQW5TnBQGYqpAT
         iNewIjBDIKKsEass9EWhhL+VFpsVY59dNKSEAXa+xg4z0otZ1t6JRC+Ld7iAj9c7Onnm
         /ElK9+DlNN6ff+jEEYaYq5w6vqJ9ptEBl+Aw7W1hg8UnsoD4qe1mun4uY8j1whSUgyAj
         NqZBN/cU6uLdY5PVh4COSsHSK1dWyPucvo408UHKo/FdlSyScx5zDSMwHUWKG9RiTxdo
         5Gyg==
X-Gm-Message-State: APjAAAU6K42Xs2Phn1SkL1UFsHpmxXUYnZ7zwAn6b6IHI2vUKkMDZHgp
        WzgBc7MS+cJuJvfJ4E7pVW0cdQ==
X-Google-Smtp-Source: APXvYqxjEWjRDxJHD23SXvXvigFy1rALZ2KN9JN0mQ+aijgBGvLLUSvpPERf9/0gk8rACJ+u3C0iIA==
X-Received: by 2002:a17:902:322:: with SMTP id 31mr8498009pld.150.1568878086106;
        Thu, 19 Sep 2019 00:28:06 -0700 (PDT)
Received: from localhost.localdomain (36-228-113-219.dynamic-ip.hinet.net. [36.228.113.219])
        by smtp.gmail.com with ESMTPSA id u31sm25491414pgn.93.2019.09.19.00.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 00:28:05 -0700 (PDT)
From:   Green Wan <green.wan@sifive.com>
Cc:     linux-hackers@sifive.com, Green Wan <green.wan@sifive.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: dmaengine: sf-pdma: add bindins for SiFive PDMA
Date:   Thu, 19 Sep 2019 15:27:26 +0800
Message-Id: <20190919072756.1973-1-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings document for Platform DMA(PDMA) driver of board,
HiFive Unleashed Rev A00.

Signed-off-by: Green Wan <green.wan@sifive.com>
---
 .../bindings/dma/sifive,fu540-c000-pdma.yaml  | 63 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml

diff --git a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
new file mode 100644
index 000000000000..b5423f1cfcaf
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/sifive,fu540-c000-pdma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SiFive Unleashed Rev C000 Platform DMA
+
+maintainers:
+  - Green Wan <green.wan@sifive.com>
+  - Palmer Debbelt <palmer@sifive.com>
+  - Paul Walmsley <paul.walmsley@sifive.com>
+
+description: |
+  Platform DMA is a DMA engine of SiFive Unleashed. It supports 4
+  channels. Each channel has 2 interrupts. One is for DMA done and
+  the other is for DME error.
+
+  In different SoC, DMA could be attached to different IRQ line.
+  DT file need to be changed to meet the difference. For technical
+  doc,
+
+  https://static.dev.sifive.com/FU540-C000-v1.0.pdf
+
+properties:
+  compatible:
+    items:
+      - const: sifive,fu540-c000-pdma
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 8
+    maxItems: 8
+
+  interrupt-parent:
+    description:
+      Interrupt parent must correspond to the name PLIC interrupt
+      controller, i.e. "plic0"
+    maxItems: 1
+
+  '#dma-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupt-parent
+  - interrupts
+  - '#dma-cells'
+
+examples:
+  - |
+    dma@3000000 {
+      compatible = "sifive,fu540-c000-pdma";
+      reg = <0x0 0x3000000 0x0 0x8000>;
+      interrupt-parent = <&plic0>;
+      interrupts = <23 24 25 26 27 28 29 30>;
+      #dma-cells = <1>;
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 49f75d1b7b51..d0caa09a479e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14591,6 +14591,11 @@ F:	drivers/media/usb/siano/
 F:	drivers/media/usb/siano/
 F:	drivers/media/mmc/siano/
 
+SIFIVE PDMA DRIVER
+M:	Green Wan <green.wan@sifive.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
+
 SIFIVE DRIVERS
 M:	Palmer Dabbelt <palmer@sifive.com>
 M:	Paul Walmsley <paul.walmsley@sifive.com>
-- 
2.17.1

