Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1174C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA07F2166E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="G7HveYk1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733293AbfKGIwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 03:52:39 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41317 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733257AbfKGIwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 03:52:39 -0500
Received: by mail-pf1-f193.google.com with SMTP id p26so2115288pfq.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 00:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WYgJCjRBqhwY0ulINWDVeN12R2Tn8RH5kuZplnJEZos=;
        b=G7HveYk1IudPQMGmvQ2c7tpccDcJSLzQvM5gihotCO9sU2EOQLD2dorDNKZBfLnQbT
         N299NgJA3fiMAGdZgC783yJ9ZXiHACZgpJKpgs7L982cA26pzAI5GYZNrG7ANQNxjnXb
         qd0j7fsekgVSkMUTPu4TaxKbzSWwciTPEeZu+WoSCijwnzq0YqxWwyK+Y4jCYbuOIWMm
         Vpk/29WFu6gz7HwqVrz/+GW+0eRA2epF1LgMr271rBQUiHgEZMG8EBtg/A3gmYIt6z3x
         Gx9CKuJfuUJMDCInxFFvPWBGivrfBPjMSyqDt8Y96fYzEzxlSWkV1iu6zyuHfFBBAl7S
         K6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WYgJCjRBqhwY0ulINWDVeN12R2Tn8RH5kuZplnJEZos=;
        b=S3xXqPbYHzK/EP5hHiWuQMSVacikGWvFgrnRnesXluppdaHmzPNS+WibwTy6APOYkT
         8ElvLOgvVJLVMb1ONdd/F5AIdqzpXor6bGXys0guyL3PzeYFNvGh7q+KMnm6Svg8MPwu
         ZuOE/li3ZaJREBPjasEaVkDbAaUNWIxLuYngeC85/LryTOl025PqEajTPaSmTOtF5xJx
         NReB1IdpxIPFMcArr/d+sY8eu7B64xF2JrOVnT2OrZzXroFMsf4K7FUGhyu5af0R3xo4
         3Oc+BLpI7AvH2l25/56JhnbaLjfc2YySCSSb52adE98HpC79ww7JmqPQA7qE/9MkoSQI
         R1lA==
X-Gm-Message-State: APjAAAWgPh/nTikUGL2Er1jAlLw8nP9WuI9i+8BAZW43WmScZQZPhYd0
        4KucZrgWhkgsciTo0E2s1I7PbA==
X-Google-Smtp-Source: APXvYqzwiffXH7qAwTNlrwNnSzFYjok1bc9tn4Pi6HSzCFjYW64y7zo3+tmzH1fmx6SaC2g7igW/Ig==
X-Received: by 2002:a63:d405:: with SMTP id a5mr3054839pgh.79.1573116756735;
        Thu, 07 Nov 2019 00:52:36 -0800 (PST)
Received: from localhost.localdomain (36-228-119-18.dynamic-ip.hinet.net. [36.228.119.18])
        by smtp.gmail.com with ESMTPSA id a33sm2402361pgb.57.2019.11.07.00.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 00:52:36 -0800 (PST)
From:   Green Wan <green.wan@sifive.com>
Cc:     Green Wan <green.wan@sifive.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Dan Williams <dan.j.williams@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Bin Meng <bmeng.cn@gmail.com>,
        Yash Shah <yash.shah@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/4] dt-bindings: dmaengine: sf-pdma: add bindins for SiFive PDMA
Date:   Thu,  7 Nov 2019 16:49:19 +0800
Message-Id: <20191107084955.7580-2-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191107084955.7580-1-green.wan@sifive.com>
References: <20191107084955.7580-1-green.wan@sifive.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings document for Platform DMA(PDMA) driver of board,
HiFive Unleashed Rev A00.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Pragnesh Patel <pragnesh.patel@sifive.com>
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

