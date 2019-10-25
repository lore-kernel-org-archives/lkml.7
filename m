Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80445CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 22:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 539BA21E6F
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 22:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YPNNxVZO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfJYWuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 18:50:22 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34746 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfJYWuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 18:50:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id b128so2592730pfa.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 15:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KxqkayFb7m9sYPELw0DxQ5VjRvj+WqO4uI8I+KYabjE=;
        b=YPNNxVZOZJlLKs7oXdvUCzvzCrltQPL8eWMoKdZWWv6dR9YRavL7O8GUrDdJN+aF1c
         NONSin6KYmGXn/ghUVTQuPQPS7fDeC0To+Axtws+gmTPLAZH8XKDibrwFAtn9aXa44zn
         z3R6iQ02U7OFyhYvs8GNx7UWmkS60YLobBM9GP1y/oHOBiWjS0KRzPNBiXLalgKt0/lk
         luVuTeAece9hd7my2vsqWp2iOIEILuRyhxB675rOPv/o+UmDNg2pK5vP4bAZ5+L+q3Bu
         EBPnMKcpO1TROkAZXERNtRg70QdVQbrEdXao1+P4SsHD5z1hkzgeGU7RNdmqeG+6JL4B
         pVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KxqkayFb7m9sYPELw0DxQ5VjRvj+WqO4uI8I+KYabjE=;
        b=e0VoK8+iKvwlu8MrTZqBD786e3hbZtstoIicjhQ9/SNYIGDFasMnRgOgkOX59wG4xH
         RYiBUGt3L2RusOCLI1hwYf5sFHfCxuSnwd3qSwQNPHRYMrwZdQf8VGWXTblhtXsxEYZo
         +XULsXDaMglqQ1LUYQc3XuoSJk3SRyGjwyT50IUiFKRc9PFTqdP0ovSZfL9I+e2MxzTh
         Ak7bEtc1dmOW9lzj79BrSBDxlaYQHQqLcSXc8JaXymDvHySJVL77Ri7tqI4qHLTVAmoH
         h96htYK6WlAC4NOZXyc9bdwdO01G647s08BnlV5touFgJ4UMAZCL7kbicB6wuo1qUs3q
         f1oQ==
X-Gm-Message-State: APjAAAWQP86WBu+v9zrZSgv+cFusrcpAlbbKPnT9B+qqJFJnl8LvJQfW
        2Hc933RtH5Wk5yJHHJephTztB8gq5OQ=
X-Google-Smtp-Source: APXvYqwH7FDeikwYbqOx/o7f38x/ORIOox29XW0WwLYwBPb50atXz5l+ZpfB/8ub7NnMSoQQiqTbow==
X-Received: by 2002:a65:638a:: with SMTP id h10mr7136687pgv.388.1572043818363;
        Fri, 25 Oct 2019 15:50:18 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id o15sm2758018pjs.14.2019.10.25.15.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 15:50:17 -0700 (PDT)
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
Subject: [RFC][PATCH 2/3] dma-buf: heaps: Allow adding specified non-default CMA heaps
Date:   Fri, 25 Oct 2019 22:50:08 +0000
Message-Id: <20191025225009.50305-3-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025225009.50305-1-john.stultz@linaro.org>
References: <20191025225009.50305-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In earlier versions of the dmabuf CMA heap, we added all CMA
areas as CMA heaps. Andrew noted this might not be desired,
and so we changed the code to only add the default CMA area.

This patch extends the earlier effort so that devices can
specifiy which CMA areas they want to add as dmabuf heaps via
DT, and we'll only add those.

This allows multiple CMA areas to be exported via the dmabuf
heaps interface.

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
 drivers/dma-buf/heaps/cma_heap.c | 38 ++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma_heap.c
index 064926b5d735..0d5231a1e561 100644
--- a/drivers/dma-buf/heaps/cma_heap.c
+++ b/drivers/dma-buf/heaps/cma_heap.c
@@ -15,6 +15,9 @@
 #include <linux/errno.h>
 #include <linux/highmem.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/scatterlist.h>
 #include <linux/sched/signal.h>
@@ -174,5 +177,40 @@ static int add_default_cma_heap(void)
 	return ret;
 }
 module_init(add_default_cma_heap);
+
+static int cma_heaps_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct cma *cma_area;
+	int ret;
+
+	ret = of_reserved_mem_device_init_by_idx(&pdev->dev, np, 0);
+	if (ret) {
+		pr_err("Error %s(): of_reserved_mem_device_init_by_idx failed!\n", __func__);
+		return ret;
+	}
+
+	cma_area = dev_get_cma_area(&pdev->dev);
+	if (cma_area)
+		ret = __add_cma_heap(cma_area, NULL);
+
+	return ret;
+}
+
+static const struct of_device_id cma_heap_dt_ids[] = {
+	{ .compatible = "dmabuf-heap-cma" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, cma_heap_dt_ids);
+
+static struct platform_driver cma_heaps_driver = {
+	.driver	= {
+		.name		= "CMA Heaps",
+		.of_match_table	= cma_heap_dt_ids,
+	},
+	.probe	= cma_heaps_probe,
+};
+
+module_platform_driver(cma_heaps_driver);
 MODULE_DESCRIPTION("DMA-BUF CMA Heap");
 MODULE_LICENSE("GPL v2");
-- 
2.17.1

