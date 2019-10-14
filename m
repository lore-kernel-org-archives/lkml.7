Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C6EECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 07:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F7D20673
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 07:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="k/ju0uxL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbfJNH4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 03:56:30 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36978 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbfJNH4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 03:56:30 -0400
Received: by mail-pg1-f196.google.com with SMTP id p1so9616986pgi.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 00:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WYgJCjRBqhwY0ulINWDVeN12R2Tn8RH5kuZplnJEZos=;
        b=k/ju0uxLkLwtL3sDWDJCprGxKz//1GuP8ugQKBBSTurB2DBli1VodHNahR+le8ArUW
         yYf8lfdY1mdptXyuBBoTgkrfaEffPGxpLi0BdzvZHnf0u1yZ5SJ1aEXgZZk7/O1J4SVa
         h/TkRNnxxIe+X7ICYeDw457FVI5cTvQTbZiCrqjOKPBIehiaTcYmsz81ukHKMKjlsryz
         Q5tEOgi42uUAGhrRbuZ/5+pU0Sg1kN5kyM7PZ3IvVW3V55HIpXE+l5D3UMSno9rEmBqf
         882ynOY89OgiJ5TXj3ZlPKvpuEa0my6ehw4v7CUPu5YVMN1rmP8XKZlQ5tQVgyr+DwFL
         zwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WYgJCjRBqhwY0ulINWDVeN12R2Tn8RH5kuZplnJEZos=;
        b=rJr18I14Tz7C+d04BA9Hlug9KpqgPYUtbqjmBoRfpLYu9PJe67KqYTxBOEM4NU4tHK
         Czn8U7zQd/Qs/8Mun0ksVSD07aw4zcgvEMj54ie6bBjlgxzSXqD6gxrIHLLakEgoYyvx
         PEk8d2JjGQonaBi+MdOEIAXiiRdvcchjdgQxGyr/DSvQzRTCOlySHPVWjQdVh9g/rF/E
         O6v4EXG006paRivz8cZ5GrLnSPvFcygHjJ21bTnKI40+I5PPdUVlH3OiOZh+s84I7Mne
         cZMmSeJZSGBvWmLtGFCQQX1pKF2cRddG+kJRsWUBogg9rc6A1v5ll92sHVM1q1kWQ2k/
         zmtw==
X-Gm-Message-State: APjAAAUH3Coud3SEMLhqy4WKKDtqGJAtKjknS8aPKotCkxYL/99vG2Ba
        vlkajkHFkg3Nd2iN38pdDsNx1w==
X-Google-Smtp-Source: APXvYqz6tFVkfmFOz7LA+7Ptn1VlaJiPkif2QscBsinQM/p+ODS5CXWKT7Oydfmx35z0zZZjIf7slw==
X-Received: by 2002:aa7:8a97:: with SMTP id a23mr31494124pfc.76.1571039788241;
        Mon, 14 Oct 2019 00:56:28 -0700 (PDT)
Received: from localhost.localdomain (111-241-168-233.dynamic-ip.hinet.net. [111.241.168.233])
        by smtp.gmail.com with ESMTPSA id j126sm16583137pfb.186.2019.10.14.00.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 00:56:27 -0700 (PDT)
From:   Green Wan <green.wan@sifive.com>
Cc:     linux-hackers@sifive.com, Green Wan <green.wan@sifive.com>,
        Vinod Koul <vkoul@kernel.org>,
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
Subject: [RFC v2 1/4] dt-bindings: dmaengine: sf-pdma: add bindins for SiFive PDMA
Date:   Mon, 14 Oct 2019 15:54:24 +0800
Message-Id: <20191014075502.15105-2-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191014075502.15105-1-green.wan@sifive.com>
References: <20191014075502.15105-1-green.wan@sifive.com>
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

