Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C077CA9EBD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 07:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2182420650
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 07:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CwU6l44C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733123AbfJ1H6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 03:58:33 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40175 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731233AbfJ1H6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 03:58:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id 15so6361664pgt.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 00:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sLaQKTe9F/n+kmq28P+8uQ8BgB0NxQ/mf+3vugBIPOU=;
        b=CwU6l44Ck8MCNGOU0jv24uh0hpK31qPSOdqqp7NRy7xam03EzFoVx6p62/FMpjZiiY
         cZ/AXZkMXUukeVKic7nrEzC/rF1ZbkhkOMKYEBHNv7Jto0JHTBzCY4tNAhArCao5Y2w3
         KhoYTGHpZSG/QWHidVFTJ0LZzJR2r8iPEyJmvtswL7VYXUNKJBlSxurgdrdiMgM3ITOr
         dy3vR4HAWqXpX9PZqB3QL1kC1zrXNU05rGE4/rV5JCIBuHFSwGJLPFNiaE0bI4EI8260
         SI3Nip903r2N/Nq22aHxSEK60akOPL+7auB6Y+43x3xvN1K4rO1xvBGTuDTB/yj7Nlsx
         xdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sLaQKTe9F/n+kmq28P+8uQ8BgB0NxQ/mf+3vugBIPOU=;
        b=dEHZwNb0PV3g2AYT2lggeZD4plzue4fT4dJ9HZESSmIg1UvoJlvSa8veuADTTk+g77
         c7oRBcJEJXmRhMSOzoWowaUs2X/Tp20XugJYLb7X/s/imwT4i09aw1v3XJHr35o8yOzS
         5Cvf0YsHAlB+yUm+T4Hum8KJCw8qCR75EPJkltVXa3fR/yhrrD2K6umyFANhxGX+k/aB
         F1U93Y7QcqrDu3mAnQBi/7mro5avlHp9b6MV9Egs80SYYzBEQjsgDLzS40CSRDJKT/2m
         hXK+/Hv0b5qZu/OnOVHNqrl9e5PruIvjcqy7gdqYluF4FW/CrjsJEyghMY+cmFUfpLtj
         3dRw==
X-Gm-Message-State: APjAAAVDdd36Dh6dLPme8VFptrt/KB06/toUfRtM8rByxJaE4M+480i4
        MRo0K3JyrzlauIpz2bz+64kXmA==
X-Google-Smtp-Source: APXvYqzrDVIQTPM9eaDR25XDbHx5ZYaDusJXvaBMCN631OBtC7yMEttBxWYwLdXelIw/PQm9fSFlwg==
X-Received: by 2002:a17:90a:b946:: with SMTP id f6mr20395570pjw.81.1572249512044;
        Mon, 28 Oct 2019 00:58:32 -0700 (PDT)
Received: from localhost.localdomain (111-241-170-106.dynamic-ip.hinet.net. [111.241.170.106])
        by smtp.gmail.com with ESMTPSA id y36sm9504752pgk.66.2019.10.28.00.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 00:58:31 -0700 (PDT)
From:   Green Wan <green.wan@sifive.com>
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
        Bin Meng <bmeng.cn@gmail.com>,
        Yash Shah <yash.shah@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/4] dt-bindings: dmaengine: sf-pdma: add bindins for SiFive PDMA
Date:   Mon, 28 Oct 2019 15:56:20 +0800
Message-Id: <20191028075658.12143-2-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191028075658.12143-1-green.wan@sifive.com>
References: <20191028075658.12143-1-green.wan@sifive.com>
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

base-commit: d6d5df1db6e9d7f8f76d2911707f7d5877251b02
-- 
2.17.1

