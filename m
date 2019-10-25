Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AFCCA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 22:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7245C21D81
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 22:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QuTmYOTq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfJYWuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 18:50:20 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42645 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfJYWuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 18:50:19 -0400
Received: by mail-pf1-f193.google.com with SMTP id 21so2563952pfj.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 15:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/QsSnbqT/vxBzyqQX0KdepymXuDj6dGQtXlO9dbOSkk=;
        b=QuTmYOTqrurVmJ/xuipLBhM7GLFY5pGr1iJX3QKVdcKK/H8I/5AdYHQwYMY2NUiqXc
         AxSegHg7VxQ7X/0azpl7Q8w46j+KDFXLJrEkkWcH6302yTkS51/vcbuJFQHzVwUgBWj6
         JzKzOF5iC3EH7xZqAoCQULcCl2yXADIIzruVCenqNO7lW51zLg2HmLfFuT1VYsYAmSL3
         3hnxUHcxN+1kHcPwaaGoAQ+jv/eXxBlLQUSk4/h9aGt3i0AK0wdV7K8dTsU2mZ3h+46J
         Faj4npHwJnvDE245x+lkyKBoXHWzL1LDqC/pK//cfEiAkdcXSCixwBIguLUCDpUHNjem
         amjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/QsSnbqT/vxBzyqQX0KdepymXuDj6dGQtXlO9dbOSkk=;
        b=AG8YQL4hr3CSsnd8wYYw5zS/SxqsIOT6viti9y9t0+TqUUhID7e6J90Rp9yRlF0kjd
         +KC1DO50NUMPg0ORtgieAaaTFDGKd4Yx8db1F42jUbrGL7jgupKnfKQt7WWElttSZwac
         9qXoGurVbOJ3/XpIH4qmXOw577XGS205FbXRbEhBK6Up4AP88Mg2ZrR6PlPRFgSf8b8u
         +IEdSwjL2DWs7bToc8prb6p8u9Yupmv+PTL1YEBHAMiM+YV0WdayHbaf/3dJtl4kiY/z
         r1bey0RQCVQPqRyQpDwH9TxzVm20XkRA3Dyjf1lCjnvJQFvI0337LPZIePe9Pz2nnLlF
         bSNw==
X-Gm-Message-State: APjAAAWbRRBi/zO4ZMmP1jY85KUM8iDmC/CbIuUzhhfGdD3acON4lY6j
        xWwVAKaSDUhCMjmONrx68I9e6kptsLA=
X-Google-Smtp-Source: APXvYqziC/rX8OG0ZvE60odRUgM4+OMxyzH9YT1VE6orCRtoxz0Nkzr2UbFad4Lx05yIE7lyxETSEw==
X-Received: by 2002:a63:5c21:: with SMTP id q33mr7104380pgb.78.1572043817153;
        Fri, 25 Oct 2019 15:50:17 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id o15sm2758018pjs.14.2019.10.25.15.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 15:50:16 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Andrew F . Davis" <afd@ti.com>, Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [RFC][PATCH 1/3] dt-bindings: dma-buf: heaps: Describe CMA regions to be added to dmabuf heaps interface.
Date:   Fri, 25 Oct 2019 22:50:07 +0000
Message-Id: <20191025225009.50305-2-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025225009.50305-1-john.stultz@linaro.org>
References: <20191025225009.50305-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This binding specifies which CMA regions should be added to the
dmabuf heaps interface.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Liam Mark <lmark@codeaurora.org>
Cc: Pratik Patel <pratikp@codeaurora.org>
Cc: Brian Starkey <Brian.Starkey@arm.com>
Cc: Andrew F. Davis <afd@ti.com>
Cc: Chenbo Feng <fengc@google.com>
Cc: Alistair Strachan <astrachan@google.com>
Cc: Sandeep Patil <sspatil@google.com>
Cc: Hridya Valsaraju <hridya@google.com>
Cc: devicetree@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 .../bindings/dma/dmabuf-heap-cma.txt          | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/dmabuf-heap-cma.txt

diff --git a/Documentation/devicetree/bindings/dma/dmabuf-heap-cma.txt b/Documentation/devicetree/bindings/dma/dmabuf-heap-cma.txt
new file mode 100644
index 000000000000..bde7b1f1c269
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/dmabuf-heap-cma.txt
@@ -0,0 +1,31 @@
+* DMA-BUF CMA Heap
+
+Specifies a CMA region that should be added to the dma-buf heaps
+interface.
+
+Required properties:
+- compatible: Must be "dmabuf-heap-cma"
+- memory-region: phandle to a CMA reserved memory node
+
+Example:
+This example has a camera CMA node in reserved memory, which is then
+referenced by the dmabuf-heap-cma node.
+
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		...
+		cma_camera: cma-camera {
+			compatible = "shared-dma-pool";
+			reg = <0x0 0x24C00000 0x0 0x4000000>;
+			reusable;
+		};
+		...
+	};
+
+       cma_heap {
+               compatible = "dmabuf-heap-cma";
+               memory-region = <&cma_camera>;
+        };
-- 
2.17.1

