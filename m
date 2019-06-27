Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929F9C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712A62085A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfF0MwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 08:52:17 -0400
Received: from mga04.intel.com ([192.55.52.120]:36562 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbfF0MwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 08:52:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2019 05:52:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,423,1557212400"; 
   d="scan'208";a="245806005"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 27 Jun 2019 05:52:12 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [GIT PULL 8/9] intel_th: msu-sink: An example msu buffer driver
Date:   Thu, 27 Jun 2019 15:51:51 +0300
Message-Id: <20190627125152.54905-9-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627125152.54905-1-alexander.shishkin@linux.intel.com>
References: <20190627125152.54905-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an example "sink" MSU buffer driver, which consumes trace
data from MSC buffers.

Functionally, it acts similarly to "multi" mode with automatic window
switching.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwtracing/intel_th/Makefile   |   3 +
 drivers/hwtracing/intel_th/msu-sink.c | 127 ++++++++++++++++++++++++++
 2 files changed, 130 insertions(+)
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
index 000000000000..d2bdd4da6f14
--- /dev/null
+++ b/drivers/hwtracing/intel_th/msu-sink.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * An example software sink buffer driver for Intel TH MSU.
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
+static const struct msu_buffer_driver sink_bdrv = {
+	.name		= "sink",
+	.owner		= THIS_MODULE,
+	.assign		= msu_sink_assign,
+	.unassign	= msu_sink_unassign,
+	.alloc_window	= msu_sink_alloc_window,
+	.free_window	= msu_sink_free_window,
+	.ready		= msu_sink_ready,
+};
+
+static int msu_sink_init(void)
+{
+	return intel_th_msu_buffer_register(&sink_bdrv);
+}
+module_init(msu_sink_init);
+
+static void msu_sink_exit(void)
+{
+	intel_th_msu_buffer_unregister(&sink_bdrv);
+}
+module_exit(msu_sink_exit);
+
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

