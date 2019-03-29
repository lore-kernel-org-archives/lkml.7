Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07836C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F6C2075E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jbrWas5H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbfC2AQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:16:31 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38816 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728784AbfC2AQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 20:16:18 -0400
Received: by mail-pf1-f196.google.com with SMTP id 10so154969pfo.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 17:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=viFUhe6LpFGg7/lEQ9FuuvEf+iPLtzynE94Ig2iXdP4=;
        b=jbrWas5HNRqZs34e4EA4kuqSyKUHSirDi13Gj9om1pVr9LulhBpFlTHm3m2vAPuaB9
         BqGevEw5yA9mFF8DlnQJzWRQTEfjqTuycA6SHY5tXL0yZOF30uVjMdp9NfCqwiyGXFn3
         44XAlFk4ggSs966npkH+B60bxf5itRnAkEkxt3iEe88x8GPILSEwlUvSX4dDcY/u+WsB
         J7fELthyiePGdt9nH2Xo2SVGnoFPXLP6rDNA1Hvn26TguqrAr5vpCjFVQqynsTjOU9GW
         ljUOxAmLDWm9NyAyIMti1s0YlLTY4ChDqkrwCNm2Cc3h+1LYyOGGa7D7t9fef7QElkgb
         I1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=viFUhe6LpFGg7/lEQ9FuuvEf+iPLtzynE94Ig2iXdP4=;
        b=LXCGAH84OzYqgihn+9gE+PZFI7Mz0xBH2Wqelo/ozFG9u8pr757VuYvwG5pNiaNHCM
         ACLZeLc6LzKlohl1nu5WDfiG9EDf81t/evuuCZ6tqqMBNiN0MUEGiPAlg+n6JBQUr3fI
         Rbb+KgG4sfg2gEogMJJMh4rmx1q3U/Bk94TRPvB6UJpep07juIg9MaH5TsAQsulb7j5A
         2axQVZSIcK3GnsF6iGNa+frjQDGv4AufbX/kT/udolHhYzp90hL1Jl6Ld/CcFyX8Q4uN
         AeZfTdrU3qM+LMIMkmstmIbtpARIHJrh/hBkl3qXIMc3P8CEGMIK55kGze5+f6ZiLSb6
         FQqw==
X-Gm-Message-State: APjAAAXDWzZxBiGyBTa5Q4sfrTP0l6WyJk5sL9twU8FBusdYr2iMib2a
        +9om9kxPLyu1OZEl7Mv5Wu2MWny+/ls=
X-Google-Smtp-Source: APXvYqz1p/ncf6/URKK0zdV7oDLW/ybTFu36vwYa7Q7TOAlb+vOUiPR//K6om5XDLdeNDejUBIk74g==
X-Received: by 2002:a65:5c4b:: with SMTP id v11mr42054499pgr.411.1553818576987;
        Thu, 28 Mar 2019 17:16:16 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id g5sm430137pfo.53.2019.03.28.17.16.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Mar 2019 17:16:16 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     "Andrew F. Davis" <afd@ti.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Xu YiPing <xuyiping@hisilicon.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        butao <butao@hisilicon.com>,
        "Xiaqing (A)" <saberlily.xia@hisilicon.com>,
        Yudongbin <yudongbin@hisilicon.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel@lists.freedesktop.org,
        John Stultz <john.stultz@linaro.org>
Subject: [RFC][PATCH 5/6 v3] dma-buf: Add Dummy Importer Test Device
Date:   Thu, 28 Mar 2019 17:16:01 -0700
Message-Id: <1553818562-2516-6-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553818562-2516-1-git-send-email-john.stultz@linaro.org>
References: <1553818562-2516-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Andrew F. Davis" <afd@ti.com>

This dummy test driver lets us do some very basic testing of
importing dma-bufs.

It is based originally on TI's out of tree "DMA-BUF physical
address user-space exporter" originally by
Andrew F. Davis <afd@ti.com>

Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Liam Mark <lmark@codeaurora.org>
Cc: Pratik Patel <pratikp@codeaurora.org>
Cc: Brian Starkey <Brian.Starkey@arm.com>
Cc: Vincent Donnefort <Vincent.Donnefort@arm.com>
Cc: Sudipto Paul <Sudipto.Paul@arm.com>
Cc: Andrew F. Davis <afd@ti.com>
Cc: Xu YiPing <xuyiping@hisilicon.com>
Cc: "Chenfeng (puck)" <puck.chen@hisilicon.com>
Cc: butao <butao@hisilicon.com>
Cc: "Xiaqing (A)" <saberlily.xia@hisilicon.com>
Cc: Yudongbin <yudongbin@hisilicon.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Chenbo Feng <fengc@google.com>
Cc: Alistair Strachan <astrachan@google.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Andrew F. Davis <afd@ti.com>
[Renamed and refactored dma_buf_phys driver, rewote commitlog]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/dma-buf/Kconfig              |   6 +
 drivers/dma-buf/Makefile             |   1 +
 drivers/dma-buf/dma-buf-testdev.c    | 239 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/dma-buf-testdev.h |  37 ++++++
 4 files changed, 283 insertions(+)
 create mode 100644 drivers/dma-buf/dma-buf-testdev.c
 create mode 100644 include/uapi/linux/dma-buf-testdev.h

diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
index 63c139d..3cbcbe0 100644
--- a/drivers/dma-buf/Kconfig
+++ b/drivers/dma-buf/Kconfig
@@ -49,4 +49,10 @@ menuconfig DMABUF_HEAPS
 
 source "drivers/dma-buf/heaps/Kconfig"
 
+config DMABUF_TESTDEV
+	bool "DMA-BUF Dummy Test Device"
+	depends on DMA_SHARED_BUFFER
+	help
+	  This provides a dummy test device that can be used to test
+	  importing dma-bufs.
 endmenu
diff --git a/drivers/dma-buf/Makefile b/drivers/dma-buf/Makefile
index 09c2f2d..69bf45d 100644
--- a/drivers/dma-buf/Makefile
+++ b/drivers/dma-buf/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_DMABUF_HEAPS)	+= dma-heap.o
 obj-$(CONFIG_SYNC_FILE)		+= sync_file.o
 obj-$(CONFIG_SW_SYNC)		+= sw_sync.o sync_debug.o
 obj-$(CONFIG_UDMABUF)		+= udmabuf.o
+obj-$(CONFIG_DMABUF_TESTDEV)	+= dma-buf-testdev.o
diff --git a/drivers/dma-buf/dma-buf-testdev.c b/drivers/dma-buf/dma-buf-testdev.c
new file mode 100644
index 0000000..dc3ed93
--- /dev/null
+++ b/drivers/dma-buf/dma-buf-testdev.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DMA-BUF Dummy Importer Test Device
+ *
+ * Originally from TI DMA BUF contiguous buffer physical address
+ * user-space exporter
+ *
+ * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ *	Andrew F. Davis <afd@ti.com>
+ */
+
+#include <linux/device.h>
+#include <linux/dma-buf.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#include <uapi/linux/dma-buf-testdev.h>
+
+#define DEVICE_NAME "dma-buf-testdev"
+
+struct dma_buf_testdev_priv {
+	struct miscdevice miscdev;
+};
+
+struct dma_buf_testdev_file {
+	struct device *dev;
+	struct dma_buf *dma_buf;
+	struct dma_buf_attachment *attachment;
+	struct sg_table *sgt;
+};
+
+static int dma_buf_testdev_open(struct inode *inode, struct file *file)
+{
+	struct miscdevice *miscdev = file->private_data;
+	struct device *dev = miscdev->this_device;
+	struct dma_buf_testdev_file *priv;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	priv->dev = dev;
+	file->private_data = (void *)priv;
+
+	return 0;
+}
+
+static int dma_buf_testdev_release(struct inode *inode, struct file *file)
+{
+	struct dma_buf_testdev_file *priv = file->private_data;
+
+	if (priv->attachment && priv->sgt)
+		dma_buf_unmap_attachment(priv->attachment, priv->sgt,
+					 DMA_BIDIRECTIONAL);
+	if (priv->dma_buf && priv->attachment)
+		dma_buf_detach(priv->dma_buf, priv->attachment);
+	if (priv->dma_buf)
+		dma_buf_put(priv->dma_buf);
+
+	kfree(priv);
+
+	return 0;
+}
+
+static int dma_buf_testdev_convert(struct dma_buf_testdev_file *priv, int fd,
+				   phys_addr_t *phys)
+{
+	struct device *dev = priv->dev;
+	struct dma_buf *dma_buf;
+	struct dma_buf_attachment *attachment;
+	struct sg_table *sgt;
+	dma_addr_t dma_addr;
+	int ret;
+
+	dma_buf = dma_buf_get(fd);
+	if (IS_ERR(dma_buf))
+		return PTR_ERR(dma_buf);
+
+	/* Attach as the parent device as it will have the correct DMA ops */
+	attachment = dma_buf_attach(dma_buf, dev->parent);
+	if (IS_ERR(attachment)) {
+		ret = PTR_ERR(attachment);
+		goto fail_put;
+	}
+
+	sgt = dma_buf_map_attachment(attachment, DMA_BIDIRECTIONAL);
+	if (IS_ERR(sgt)) {
+		ret = PTR_ERR(sgt);
+		goto fail_detach;
+	}
+
+	/* Without PAT only physically contiguous buffers can be supported */
+	if (sgt->orig_nents != 1) {
+		dev_err(dev, "DMA-BUF not contiguous\n");
+		ret = -EINVAL;
+		goto fail_unmap;
+	}
+
+	dma_addr = sg_dma_address(sgt->sgl);
+
+	*phys = dma_addr;
+
+	priv->dma_buf = dma_buf;
+	priv->attachment = attachment;
+	priv->sgt = sgt;
+
+	return 0;
+
+fail_unmap:
+	dma_buf_unmap_attachment(attachment, sgt, DMA_BIDIRECTIONAL);
+fail_detach:
+	dma_buf_detach(dma_buf, attachment);
+fail_put:
+	dma_buf_put(dma_buf);
+
+	return ret;
+}
+
+static long dma_buf_testdev_ioctl(struct file *file, unsigned int cmd,
+				  unsigned long arg)
+{
+	struct dma_buf_testdev_file *priv = file->private_data;
+
+	switch (cmd) {
+	case DMA_BUF_TESTDEV_IOC_CONVERT:
+	{
+		struct dma_buf_testdev_data data;
+		int ret;
+
+		/*
+		 * TODO: this should likely be properly serialized, but I
+		 * see no reason this file would ever need to be shared.
+		 */
+		/* one attachment per file */
+		if (priv->dma_buf)
+			return -EFAULT;
+
+		if (copy_from_user(&data, (void __user *)arg, _IOC_SIZE(cmd)))
+			return -EFAULT;
+
+		ret = dma_buf_testdev_convert(priv, data.fd, &data.phys);
+		if (ret)
+			return ret;
+
+		if (copy_to_user((void __user *)arg, &data, _IOC_SIZE(cmd)))
+			return -EFAULT;
+
+		break;
+	}
+	default:
+		return -ENOTTY;
+	}
+
+	return 0;
+}
+
+static const struct file_operations dma_buf_testdev_fops = {
+	.owner = THIS_MODULE,
+	.open = dma_buf_testdev_open,
+	.release = dma_buf_testdev_release,
+	.unlocked_ioctl = dma_buf_testdev_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= dma_buf_testdev_ioctl,
+#endif
+};
+
+static int dma_buf_testdev_probe(struct platform_device *pdev)
+{
+	struct dma_buf_testdev_priv *priv;
+	struct device *dev = &pdev->dev;
+	int err;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	dev_set_drvdata(dev, priv);
+
+	dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
+
+	if (!dev->dma_parms) {
+		dev->dma_parms = devm_kzalloc(dev, sizeof(*dev->dma_parms),
+					      GFP_KERNEL);
+		if (!dev->dma_parms)
+			return -ENOMEM;
+	}
+	dma_set_max_seg_size(dev, DMA_BIT_MASK(32));
+
+	priv->miscdev.minor = MISC_DYNAMIC_MINOR;
+	priv->miscdev.name = devm_kasprintf(dev, GFP_KERNEL, "%s",
+					    DEVICE_NAME);
+	priv->miscdev.fops = &dma_buf_testdev_fops;
+	priv->miscdev.parent = dev;
+	err = misc_register(&priv->miscdev);
+	if (err) {
+		dev_err(dev,
+			"unable to register DMA-BUF to Phys misc device\n");
+		return err;
+	}
+
+	return 0;
+}
+
+static int dma_buf_testdev_remove(struct platform_device *pdev)
+{
+	struct dma_buf_testdev_priv *priv = dev_get_drvdata(&pdev->dev);
+
+	misc_deregister(&priv->miscdev);
+
+	return 0;
+}
+
+static struct platform_driver dma_buf_testdev_driver = {
+	.probe = dma_buf_testdev_probe,
+	.remove = dma_buf_testdev_remove,
+	.driver = {
+		.name = "dma_buf_testdev",
+	}
+};
+module_platform_driver(dma_buf_testdev_driver);
+
+static int __init dma_buf_testdev_init(void)
+{
+	struct platform_device *pdev;
+
+	pdev = platform_device_register_simple("dma_buf_testdev", -1, NULL, 0);
+
+	return PTR_ERR_OR_ZERO(pdev);
+}
+
+postcore_initcall(dma_buf_testdev_init);
+
+MODULE_AUTHOR("Andrew F. Davis <afd@ti.com>");
+MODULE_DESCRIPTION("DMA-BUF Dummy Importer Test Device");
+MODULE_LICENSE("GPL v2");
diff --git a/include/uapi/linux/dma-buf-testdev.h b/include/uapi/linux/dma-buf-testdev.h
new file mode 100644
index 0000000..b9706b8
--- /dev/null
+++ b/include/uapi/linux/dma-buf-testdev.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * DMA-BUF Dummy Importer Test Device
+ *
+ * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ *	Andrew F. Davis <afd@ti.com>
+ */
+
+#ifndef DMA_BUF_TESTDEV_H
+#define DMA_BUF_TESTDEV_H
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+/**
+ * struct dma_buf_testdev_data - metadata passed from userspace for conversion
+ * @fd:		DMA-BUF fd for conversion
+ * @phys:	populated with CPU physical address of DMA-BUF
+ */
+struct dma_buf_testdev_data {
+	__u32 fd;
+	__u64 phys;
+};
+
+#define DMA_BUF_TESTDEV_IOC_MAGIC 'D'
+
+/**
+ * DOC: DMA_BUF_TESTDEV_IOC_CONVERT - Convert DMA-BUF to physical address
+ *
+ * Takes a dma_buf_testdev_data struct containing a fd for a
+ * physicaly contigous buffer. Pins this buffer and populates
+ * phys field with the CPU physical address.
+ */
+#define DMA_BUF_TESTDEV_IOC_CONVERT _IOWR(DMA_BUF_TESTDEV_IOC_MAGIC, 0, \
+					  struct dma_buf_testdev_data)
+
+#endif /* DMA_BUF_PHYS_H */
-- 
2.7.4

