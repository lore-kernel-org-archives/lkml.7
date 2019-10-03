Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6C1C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 09:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95A4217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 09:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UXdpOExk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbfJCJK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 05:10:56 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39079 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729157AbfJCJKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 05:10:55 -0400
Received: by mail-pg1-f194.google.com with SMTP id e1so1367237pgj.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 02:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cl61NZhY5d45/Lbiju2rWHR/95fvQW/rzQHybTAnNrk=;
        b=UXdpOExk+DjqpI/3nuWER3Cht8DW7Do+r38+1fLADJv0vQ4hNM1f0Ag+4C9yGsB/VT
         zKWib8P0kpXAnS/PC2MSlK2mTflHfsCAav/ICDSntt8nvfmkm7FcYbRvA4jN0dElY8Rx
         vG2fIfbBtsHQwsEnulSya+KIj2MLK722ZMeDS0pumkvmQiozd6U/IBhEAiVNCbUinUVq
         2y5t9eWzfu6Z0i8iXDZb9OHImA8FnVb56aPXeTRguPG4FpaQGKEK5i6MUb17I84bJ9pG
         LPIw85fwBbdKx3g/sOEZDWFumMBxSOWOfJaqclkg4yt9Uj2UMNXnTap+8sb7nwmfSM86
         8cxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cl61NZhY5d45/Lbiju2rWHR/95fvQW/rzQHybTAnNrk=;
        b=BYjYeiss/6xEzmJGDhHmi/MTLfBqFIwfz1ItpaeQQ/VOCKVk2KhrpHyFc2HaS03DuQ
         h+ccQD+7iw9TBsLxak/1AOCKeTF16faCHPPHQXLaKjIA2Yy9tAYwTWt47E3AQa0+E+UT
         KB4EtOKeRO7WGawdtxfhAPHBg2vNr0q2ByHsmB1j8qtLzTP6kLpBZ+qmSwXjK1jiFTF2
         YTFV/ZCsg3+JXWxN7//v7DSHDGScaJEq1Nss3mgu7FTNPL7PDe6r7sHyZwwGET2OEXl/
         0wins711/DXPDr4Ii51Jahc3v0tEfZJDINtU3BvF1fHYsr3qIGLThYcEYQMBSiwOAebK
         Yc9w==
X-Gm-Message-State: APjAAAXyo4o3pJSSJUj0w8/AYX4l+b05V5llxE+nzUcxoE8gkWnQW/wC
        UcH93/ppwsbgHIiVWYvg0ITAJg==
X-Google-Smtp-Source: APXvYqzlBZJdgGNxd7XyFiEOJlwPzViCn8Ox6kTrAJFA7m0/z333Jav775/eeVAQrCP1PSa2KM2oZA==
X-Received: by 2002:a62:e109:: with SMTP id q9mr9618993pfh.231.1570093854790;
        Thu, 03 Oct 2019 02:10:54 -0700 (PDT)
Received: from localhost.localdomain (111-241-164-136.dynamic-ip.hinet.net. [111.241.164.136])
        by smtp.gmail.com with ESMTPSA id f128sm3445422pfg.143.2019.10.03.02.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 02:10:54 -0700 (PDT)
From:   Green Wan <green.wan@sifive.com>
To:     linux-hackers@sifive.com
Cc:     Green Wan <green.wan@sifive.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Dan Williams <dan.j.williams@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Yash Shah <yash.shah@sifive.com>,
        Bin Meng <bmeng.cn@gmail.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/4] dt-bindings: dmaengine: sf-pdma: add bindins for SiFive PDMA
Date:   Thu,  3 Oct 2019 17:09:01 +0800
Message-Id: <20191003090945.29210-2-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191003090945.29210-1-green.wan@sifive.com>
References: <20191003090945.29210-1-green.wan@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings document for Platform DMA(PDMA) driver of board,
HiFive Unleashed Rev A00.

Signed-off-by: Green Wan <green.wan@sifive.com>
---
 .../bindings/dma/sifive,fu540-c000-pdma.yaml  | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml

diff --git a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
new file mode 100644
index 000000000000..2ca3ddbe1ff4
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
@@ -0,0 +1,55 @@
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
+    minItems: 1
+    maxItems: 8
+
+  '#dma-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - '#dma-cells'
+
+examples:
+  - |
+    dma@3000000 {
+      compatible = "sifive,fu540-c000-pdma";
+      reg = <0x0 0x3000000 0x0 0x8000>;
+      interrupts = <23 24 25 26 27 28 29 30>;
+      #dma-cells = <1>;
+    };
+
+...
-- 
2.17.1

