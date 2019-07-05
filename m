Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD96C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 14:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B99F20828
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 14:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfGEOOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 10:14:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:10830 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727122AbfGEOOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 10:14:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2019 07:14:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,455,1557212400"; 
   d="scan'208";a="166547297"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 05 Jul 2019 07:14:42 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v1 2/5] intel_th: msu-sink: An example msu buffer "sink"
Date:   Fri,  5 Jul 2019 17:14:22 +0300
Message-Id: <20190705141425.19894-3-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190705141425.19894-1-alexander.shishkin@linux.intel.com>
References: <20190705141425.19894-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an example MSU buffer "sink", which consumes trace
data from MSC buffers.

Functionally, it acts similarly to "multi" mode with automatic window
switching.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwtracing/intel_th/Makefile   |   3 +
 drivers/hwtracing/intel_th/msu-sink.c | 116 ++++++++++++++++++++++++++
 2 files changed, 119 insertions(+)
 create mode 100644 drivers/hwtracing/intel_th/msu-sink.c

diff --git a/drivers/hwtracing/intel_th/Makefile b/drivers/hwtracing/intel_th/Makefile
index d9252fa8d9ca..b63eb8f309ad 100644
--- a/drivers/hwtracing/intel_th/Makefile
+++ b/drivers/hwtracing/intel_th/Makefile
@@ -20,3 +20,6 @@ intel_th_msu-y			:= msu.o
 
 obj-$(CONFIG_INTEL_TH_PTI)	+= intel_th_pti.o
 intel_th_pti-y			:= pti.o
+
+obj-$(CONFIG_INTEL_TH_MSU)	+= intel_th_msu_sink.o
+intel_th_msu_sink-y		:= msu-sink.o
diff --git a/drivers/hwtracing/intel_th/msu-sink.c b/drivers/hwtracing/intel_th/msu-sink.c
new file mode 100644
index 000000000000..2c7f5116be12
--- /dev/null
+++ b/drivers/hwtracing/intel_th/msu-sink.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * An example software sink buffer for Intel TH MSU.
+ *
+ * Copyright (C) 2019 Intel Corporation.
+ */
+
+#include <linux/intel_th.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+
+#define MAX_SGTS 16
+
+struct msu_sink_private {
+	struct device	*dev;
+	struct sg_table **sgts;
+	unsigned int	nr_sgts;
+};
+
+static void *msu_sink_assign(struct device *dev, int *mode)
+{
+	struct msu_sink_private *priv;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return NULL;
+
+	priv->sgts = kcalloc(MAX_SGTS, sizeof(void *), GFP_KERNEL);
+	if (!priv->sgts) {
+		kfree(priv);
+		return NULL;
+	}
+
+	priv->dev = dev;
+	*mode = MSC_MODE_MULTI;
+
+	return priv;
+}
+
+static void msu_sink_unassign(void *data)
+{
+	struct msu_sink_private *priv = data;
+
+	kfree(priv->sgts);
+	kfree(priv);
+}
+
+/* See also: msc.c: __msc_buffer_win_alloc() */
+static int msu_sink_alloc_window(void *data, struct sg_table **sgt, size_t size)
+{
+	struct msu_sink_private *priv = data;
+	unsigned int nents;
+	struct scatterlist *sg_ptr;
+	void *block;
+	int ret, i;
+
+	if (priv->nr_sgts == MAX_SGTS)
+		return -ENOMEM;
+
+	nents = DIV_ROUND_UP(size, PAGE_SIZE);
+
+	ret = sg_alloc_table(*sgt, nents, GFP_KERNEL);
+	if (ret)
+		return -ENOMEM;
+
+	priv->sgts[priv->nr_sgts++] = *sgt;
+
+	for_each_sg((*sgt)->sgl, sg_ptr, nents, i) {
+		block = dma_alloc_coherent(priv->dev->parent->parent,
+					   PAGE_SIZE, &sg_dma_address(sg_ptr),
+					   GFP_KERNEL);
+		sg_set_buf(sg_ptr, block, PAGE_SIZE);
+	}
+
+	return nents;
+}
+
+/* See also: msc.c: __msc_buffer_win_free() */
+static void msu_sink_free_window(void *data, struct sg_table *sgt)
+{
+	struct msu_sink_private *priv = data;
+	struct scatterlist *sg_ptr;
+	int i;
+
+	for_each_sg(sgt->sgl, sg_ptr, sgt->nents, i) {
+		dma_free_coherent(priv->dev->parent->parent, PAGE_SIZE,
+				  sg_virt(sg_ptr), sg_dma_address(sg_ptr));
+	}
+
+	sg_free_table(sgt);
+	priv->nr_sgts--;
+}
+
+static int msu_sink_ready(void *data, struct sg_table *sgt, size_t bytes)
+{
+	struct msu_sink_private *priv = data;
+
+	intel_th_msc_window_unlock(priv->dev, sgt);
+
+	return 0;
+}
+
+static const struct msu_buffer sink_mbuf = {
+	.name		= "sink",
+	.assign		= msu_sink_assign,
+	.unassign	= msu_sink_unassign,
+	.alloc_window	= msu_sink_alloc_window,
+	.free_window	= msu_sink_free_window,
+	.ready		= msu_sink_ready,
+};
+
+module_intel_th_msu_buffer(sink_mbuf);
+
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

