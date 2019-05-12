Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0230BC04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 15:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC546208C0
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 15:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICgPz60r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfELPy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 11:54:58 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37204 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfELPyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 11:54:54 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6so5445563pgc.4
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 08:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZWsQsXMehV5WyDKT3pqjxYNNEF4Gpg7H5e9/WQTbbjY=;
        b=ICgPz60rfWATpox2Z/Emb0Lb+a2fQnt5kS0I4KmVEUbBNwHpyHmJ1dIzDyfh40sWjE
         Kzj8YUhFE/gwwh+8yH4Vqt70UdwBKbvU2kV2sx/sCrfjd6RniyC6xGaT0hq9SPgSHpR2
         U/BTvK0OZZx1EIeOKpEO/aq+eeGdVdecyrNhBIxJ9IEB+nimiX8nnHE+Eh5XuTAqSY7E
         4qBJbImpSpaiwEP6IcOAvm9VcjZuhu6ZVBTCXmvfYP8duMMQTJf/blUFuGYRzGZwWi6P
         Yss9WxWwfjWKdGuLHoF7OEdaH38iwRa+l0BAZGQnQ7qY5ZnJDSnd/HJr2Qr/Eng6LAxC
         sJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZWsQsXMehV5WyDKT3pqjxYNNEF4Gpg7H5e9/WQTbbjY=;
        b=pFTHyYa1XEiOq01WtBWAy8s+Tt5FEyfSOW0alNLIsHLk27N1bjsHdofeS/bEV1GZLI
         GmcBVkE3VSuKGRUHDqVayRaVeAuSRdFs1opsjyLbHYAKkzZ8zVlf9X8u3dVf318BkUSK
         /+AJhDgHducFJynuOHcLw7EXS1XJT7ttwGxWCpoWTDYn3CociG5jehVNp5DETjHKpf8k
         weOh9IIR6NnfRQ2+nJ80f4NrPDiHK3zO9hquDxDX0xfj7zBRat1MKv3j55n+5RIv3rUg
         HVmcU9IZZpcGIuc4jzNQFIeQJ/GLZl9HhKXCEaZB7OV7jDh6YtbShd99D/ozdXHGhyf2
         Uqug==
X-Gm-Message-State: APjAAAUOuj7odNPAVBeC9SixkmD6uiOlyYGDcVaYyWOTZAcq/Nj1YV3f
        3M9uyVYZimWu0WwnzgJL4gc=
X-Google-Smtp-Source: APXvYqzMjSO8VrWCPubzS8if7WpbgacA3DLwuUcY5EFYBC308ftU6Qooycr6GN/xqFG4dJ+HkpXiwQ==
X-Received: by 2002:a62:b517:: with SMTP id y23mr22328796pfe.182.1557676493962;
        Sun, 12 May 2019 08:54:53 -0700 (PDT)
Received: from mita-MS-7A45.lan ([240f:34:212d:1:918e:f7e4:1728:3f45])
        by smtp.gmail.com with ESMTPSA id v2sm4470058pgr.2.2019.05.12.08.54.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 12 May 2019 08:54:53 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>
Subject: [PATCH v3 5/7] nvme-pci: add device coredump infrastructure
Date:   Mon, 13 May 2019 00:54:15 +0900
Message-Id: <1557676457-4195-6-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557676457-4195-1-git-send-email-akinobu.mita@gmail.com>
References: <1557676457-4195-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This provides three functions to implement the device coredump for nvme
driver.

nvme_coredump_init() -  This function is called when the driver determines
to start collecting device coredump.  The snapshots of the controller
registers, and admin and IO queues are captured by this.

nvme_coredump_logs() - This function is called as soon as the device is
recovered from the crash and admin queue becomes available.  If the device
coredump has already been started by nvme_coredump_init(), the telemetry
controller-initiated data will be collected.  Otherwise do nothing.

nvme_coredump_complete() - This functions is called when the driver
determines that there is nothing to collect device coredump anymore.
All collected coredumps are exported via device coredump mechanism.

After finishing the nvme device coredump, the following files are created.

- regs: NVMe controller registers (00h to 4Fh)
- sq<qid>: Submission queue
- cq<qid>: Completion queue
- telemetry-ctrl-log: Telemetry controller-initiated log (if available)
- data: Empty

The reason for an empty 'data' file is to provide a uniform way to notify
the device coredump is no longer needed by writing the 'data' file.

Since all existing drivers using the device coredump provide a 'data' file
if the nvme device coredump doesn't provide it, the userspace programs need
to know which driver provides what coredump file.

Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: Kenneth Heitke <kenneth.heitke@intel.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v3
- Fix typo s/machanism/mechanism/ in commit log
- Fix max transfer size calculation for get log page
- Add function comments
- Extract 'enable to trigger device coredump by hand' patch

 drivers/nvme/host/Kconfig |   1 +
 drivers/nvme/host/core.c  |   1 +
 drivers/nvme/host/pci.c   | 448 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 450 insertions(+)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 0f345e2..c3a06af 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -5,6 +5,7 @@ config BLK_DEV_NVME
 	tristate "NVM Express block device"
 	depends on PCI && BLOCK
 	select NVME_CORE
+	select WANT_DEV_COREDUMP
 	---help---
 	  The NVM Express driver is for solid state drives directly
 	  connected to the PCI or PCI Express bus.  If you know you
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0cea2a8..172551b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2462,6 +2462,7 @@ int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp,
 
 	return nvme_submit_sync_cmd(ctrl->admin_q, &c, log, size);
 }
+EXPORT_SYMBOL_GPL(nvme_get_log);
 
 static int nvme_get_effects_log(struct nvme_ctrl *ctrl)
 {
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3e4fb89..3eebb98 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -9,6 +9,7 @@
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
 #include <linux/blk-mq-pci.h>
+#include <linux/devcoredump.h>
 #include <linux/dmi.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -89,6 +90,10 @@ struct nvme_queue;
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
 static bool __nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode);
 
+static void __maybe_unused nvme_coredump_init(struct nvme_dev *dev);
+static void __maybe_unused nvme_coredump_logs(struct nvme_dev *dev);
+static void __maybe_unused nvme_coredump_complete(struct nvme_dev *dev);
+
 /*
  * Represents an NVM Express device.  Each nvme_dev is a PCI function.
  */
@@ -131,6 +136,9 @@ struct nvme_dev {
 	dma_addr_t host_mem_descs_dma;
 	struct nvme_host_mem_buf_desc *host_mem_descs;
 	void **host_mem_desc_bufs;
+
+	struct dev_coredumpm_bulk_data *dumps;
+	int num_dumps;
 };
 
 static int io_queue_depth_set(const char *val, const struct kernel_param *kp)
@@ -2849,6 +2857,446 @@ static int nvme_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(nvme_dev_pm_ops, nvme_suspend, nvme_resume);
 
+#ifdef CONFIG_DEV_COREDUMP
+
+static ssize_t nvme_coredump_read(char *buffer, loff_t offset, size_t count,
+				  void *data, size_t datalen)
+{
+	return memory_read_from_buffer(buffer, count, &offset, data, datalen);
+}
+
+static void nvme_coredump_free(void *data)
+{
+	kvfree(data);
+}
+
+static int nvme_coredump_empty(struct dev_coredumpm_bulk_data *data)
+{
+	data->name = kstrdup("data", GFP_KERNEL);
+	if (!data->name)
+		return -ENOMEM;
+
+	data->data = NULL;
+	data->datalen = 0;
+	data->read = nvme_coredump_read;
+	data->free = nvme_coredump_free;
+
+	return 0;
+}
+
+static int nvme_coredump_regs(struct dev_coredumpm_bulk_data *data,
+			      struct nvme_ctrl *ctrl)
+{
+	const int reg_size = 0x50; /* 00h to 4Fh */
+
+	data->name = kstrdup("regs", GFP_KERNEL);
+	if (!data->name)
+		return -ENOMEM;
+
+	data->data = kvzalloc(reg_size, GFP_KERNEL);
+	if (!data->data) {
+		kfree(data->name);
+		return -ENOMEM;
+	}
+	memcpy_fromio(data->data, to_nvme_dev(ctrl)->bar, reg_size);
+
+	data->datalen = reg_size;
+	data->read = nvme_coredump_read;
+	data->free = nvme_coredump_free;
+
+	return 0;
+}
+
+static void *kvmemdup(const void *src, size_t len, gfp_t gfp)
+{
+	void *p;
+
+	p = kvmalloc(len, gfp);
+	if (p)
+		memcpy(p, src, len);
+
+	return p;
+}
+
+static int nvme_coredump_queues(struct dev_coredumpm_bulk_data *bulk_data,
+				struct nvme_ctrl *ctrl)
+{
+	int i;
+
+	for (i = 0; i < ctrl->queue_count; i++) {
+		struct dev_coredumpm_bulk_data *data = &bulk_data[2 * i];
+		struct nvme_queue *nvmeq = &to_nvme_dev(ctrl)->queues[i];
+
+		data[0].name = kasprintf(GFP_KERNEL, "sq%d", i);
+		data[0].data = kvmemdup(nvmeq->sq_cmds,
+					SQ_SIZE(nvmeq->q_depth), GFP_KERNEL);
+		data[0].datalen = SQ_SIZE(nvmeq->q_depth);
+		data[0].read = nvme_coredump_read;
+		data[0].free = nvme_coredump_free;
+
+		data[1].name = kasprintf(GFP_KERNEL, "cq%d", i);
+		data[1].data = kvmemdup((void *)nvmeq->cqes,
+					CQ_SIZE(nvmeq->q_depth), GFP_KERNEL);
+		data[1].datalen = CQ_SIZE(nvmeq->q_depth);
+		data[1].read = nvme_coredump_read;
+		data[1].free = nvme_coredump_free;
+
+		if (!data[0].name || !data[1].name ||
+		    !data[0].data || !data[1].data)
+			goto free;
+	}
+
+	return 0;
+free:
+	for (; i >= 0; i--) {
+		struct dev_coredumpm_bulk_data *data = &bulk_data[2 * i];
+
+		kfree(data[0].name);
+		kfree(data[1].name);
+		kvfree(data[0].data);
+		kvfree(data[1].data);
+	}
+
+	return -ENOMEM;
+}
+
+static struct
+dev_coredumpm_bulk_data *nvme_coredump_alloc(struct nvme_dev *dev, int n)
+{
+	struct dev_coredumpm_bulk_data *data;
+
+	data = krealloc(dev->dumps, sizeof(*data) * (dev->num_dumps + n),
+			GFP_KERNEL | __GFP_ZERO);
+	if (!data)
+		return NULL;
+
+	dev->dumps = data;
+	data += dev->num_dumps;
+	dev->num_dumps += n;
+
+	return data;
+}
+
+static void __nvme_coredump_discard(struct nvme_dev *dev, bool free_data)
+{
+	int i;
+
+	for (i = 0; i < dev->num_dumps; i++) {
+		kfree(dev->dumps[i].name);
+		if (free_data)
+			dev->dumps[i].free(dev->dumps[i].data);
+	}
+
+	kfree(dev->dumps);
+	dev->dumps = NULL;
+	dev->num_dumps = 0;
+}
+
+static void nvme_coredump_discard(struct nvme_dev *dev)
+{
+	__nvme_coredump_discard(dev, true);
+}
+
+static void nvme_coredump_clear(struct nvme_dev *dev)
+{
+	__nvme_coredump_discard(dev, false);
+}
+
+/**
+ * nvme_coredump_init() - start collecting device coredump
+ * @dev: the struct nvme_dev for the crashed device
+ *
+ * This function is called when the driver determines to start collecting
+ * device coredump.  The snapshots of the controller registers, and admin and
+ * IO queues are captured by this.
+ */
+static void nvme_coredump_init(struct nvme_dev *dev)
+{
+	struct nvme_ctrl *ctrl = &dev->ctrl;
+	struct dev_coredumpm_bulk_data *bulk_data;
+	int ret;
+
+	if (WARN_ON(dev->dumps))
+		nvme_coredump_discard(dev);
+
+	bulk_data = nvme_coredump_alloc(dev, 2 + 2 * ctrl->queue_count);
+	if (!bulk_data)
+		return;
+
+	ret = nvme_coredump_empty(&bulk_data[0]);
+	if (ret)
+		goto free_bulk_data;
+
+	ret = nvme_coredump_regs(&bulk_data[1], ctrl);
+	if (ret)
+		goto free_bulk_data;
+
+	ret = nvme_coredump_queues(&bulk_data[2], ctrl);
+	if (ret)
+		goto free_bulk_data;
+
+	return;
+
+free_bulk_data:
+	nvme_coredump_discard(dev);
+}
+
+static ssize_t nvme_coredump_read_sgtable(char *buffer, loff_t offset,
+					  size_t buf_len, void *data,
+					  size_t data_len)
+{
+	struct sg_table *table = data;
+
+	if (data_len <= offset)
+		return 0;
+
+	if (offset + buf_len > data_len)
+		buf_len = data_len - offset;
+
+	return sg_pcopy_to_buffer(table->sgl, sg_nents(table->sgl), buffer,
+				  buf_len, offset);
+}
+
+static void nvme_coredump_free_sgtable(void *data)
+{
+	struct sg_table *table = data;
+	struct scatterlist *sg;
+	int n = sg_nents(table->sgl);
+	int i;
+
+	for_each_sg(table->sgl, sg, n, i) {
+		struct page *page = sg_page(sg);
+
+		if (page)
+			__free_page(page);
+
+	}
+
+	kfree(table);
+}
+
+static struct sg_table *nvme_coredump_alloc_sgtable(size_t bytes)
+{
+	struct sg_table *table;
+	struct scatterlist *sg;
+	int n = DIV_ROUND_UP(bytes, PAGE_SIZE);
+	int i;
+
+	table = kzalloc(sizeof(*table), GFP_KERNEL);
+	if (!table)
+		return NULL;
+
+	if (sg_alloc_table(table, n, GFP_KERNEL))
+		goto free_table;
+
+	for_each_sg(table->sgl, sg, n, i) {
+		struct page *page = alloc_page(GFP_KERNEL);
+		size_t size = min_t(int, bytes, PAGE_SIZE);
+
+		if (!page)
+			goto free_page;
+
+		sg_set_page(sg, page, size, 0);
+		bytes -= size;
+	}
+
+	return table;
+free_page:
+	for_each_sg(table->sgl, sg, n, i) {
+		struct page *page = sg_page(sg);
+
+		if (page)
+			__free_page(page);
+
+	}
+free_table:
+	kfree(table);
+
+	return NULL;
+}
+
+static int nvme_get_telemetry_log_blocks(struct nvme_ctrl *ctrl, void *buf,
+					 size_t bytes, loff_t offset)
+{
+	loff_t pos = 0;
+	u32 chunk_size;
+
+	if (check_mul_overflow(ctrl->max_hw_sectors, 512u, &chunk_size))
+		chunk_size = UINT_MAX;
+
+	while (pos < bytes) {
+		size_t size = min_t(size_t, bytes - pos, chunk_size);
+		int ret;
+
+		ret = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_TELEMETRY_CTRL,
+				   0, buf + pos, size, offset + pos);
+		if (ret)
+			return ret;
+
+		pos += size;
+	}
+
+	return 0;
+}
+
+static int nvme_get_telemetry_log(struct nvme_ctrl *ctrl,
+				  struct sg_table *table, size_t bytes)
+{
+	int n = sg_nents(table->sgl);
+	struct scatterlist *sg;
+	size_t offset = 0;
+	int i;
+
+	for_each_sg(table->sgl, sg, n, i) {
+		struct page *page = sg_page(sg);
+		size_t size = min_t(int, bytes - offset, sg->length);
+		int ret;
+
+		ret = nvme_get_telemetry_log_blocks(ctrl, page_address(page),
+						    size, offset);
+		if (ret)
+			return ret;
+
+		offset += size;
+	}
+
+	return 0;
+}
+
+static int nvme_coredump_telemetry_log(struct dev_coredumpm_bulk_data *data,
+				       struct nvme_ctrl *ctrl)
+{
+	struct nvme_telemetry_log_page_hdr *page_hdr;
+	struct sg_table *table;
+	int log_size;
+	int ret;
+	u8 ctrldgn;
+
+	if (!(ctrl->lpa & NVME_CTRL_LPA_TELEMETRY_LOG))
+		return -EINVAL;
+	if (!(ctrl->lpa & NVME_CTRL_LPA_EXTENDED_DATA))
+		return -EINVAL;
+
+	page_hdr = kzalloc(sizeof(*page_hdr), GFP_KERNEL);
+	if (!page_hdr)
+		return -ENOMEM;
+
+	ret = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_TELEMETRY_CTRL, 0,
+			   page_hdr, sizeof(*page_hdr), 0);
+	if (ret)
+		goto free_page_hdr;
+
+	if (!page_hdr->ctrlavail) {
+		ret = -EINVAL;
+		goto free_page_hdr;
+	}
+
+	log_size = (le16_to_cpu(page_hdr->dalb3) + 1) * 512;
+
+	table = nvme_coredump_alloc_sgtable(log_size);
+	if (!table) {
+		ret = -ENOMEM;
+		goto free_page_hdr;
+	}
+
+	ret = nvme_get_telemetry_log(ctrl, table, log_size);
+	if (ret)
+		goto free_table;
+
+	sg_pcopy_to_buffer(table->sgl, sg_nents(table->sgl), &ctrldgn,
+			   sizeof(ctrldgn),
+			   offsetof(typeof(*page_hdr), ctrldgn));
+
+	ret = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_TELEMETRY_CTRL, 0,
+			   page_hdr, sizeof(*page_hdr), 0);
+	if (ret)
+		goto free_table;
+
+	if (page_hdr->ctrldgn != ctrldgn) {
+		ret = -EINVAL;
+		goto free_table;
+	}
+
+	data->name = kstrdup("telemetry-ctrl-log", GFP_KERNEL);
+	if (!data->name) {
+		ret = -ENOMEM;
+		goto free_table;
+	}
+
+	data->data = table;
+	data->datalen = log_size;
+	data->read = nvme_coredump_read_sgtable;
+	data->free = nvme_coredump_free_sgtable;
+
+	kfree(page_hdr);
+
+	return 0;
+free_table:
+	nvme_coredump_free_sgtable(table);
+free_page_hdr:
+	kfree(page_hdr);
+
+	return ret;
+}
+
+/**
+ * nvme_coredump_logs() - get telemetry log if available
+ * @dev: the struct nvme_dev for the crashed device
+ *
+ * This function is called as soon as the device is recovered from the crash
+ * and admin queue becomes available.  If the device coredump has already been
+ * started by nvme_coredump_init(), the telemetry controller-initiated data
+ * will be collected.  Otherwise do nothing.
+ */
+static void nvme_coredump_logs(struct nvme_dev *dev)
+{
+	struct dev_coredumpm_bulk_data *bulk_data;
+
+	if (!dev->dumps)
+		return;
+
+	bulk_data = nvme_coredump_alloc(dev, 1);
+	if (!bulk_data)
+		return;
+
+	if (nvme_coredump_telemetry_log(bulk_data, &dev->ctrl))
+		dev->num_dumps--;
+}
+
+/**
+ * nvme_coredump_complete() - finish device coredump
+ * @dev: the struct nvme_dev for the crashed device
+ *
+ * This functions is called when the driver determines that there is nothing
+ * to collect device coredump anymore.  All collected coredumps are exported
+ * via device coredump mechanism.
+ */
+static void nvme_coredump_complete(struct nvme_dev *dev)
+{
+	if (!dev->dumps)
+		return;
+
+	dev_coredumpm_bulk(dev->dev, THIS_MODULE, GFP_KERNEL,
+			   dev->dumps, dev->num_dumps);
+	nvme_coredump_clear(dev);
+}
+
+#else
+
+static void nvme_coredump_init(struct nvme_dev *dev)
+{
+}
+
+static void nvme_coredump_logs(struct nvme_dev *dev)
+{
+}
+
+static void nvme_coredump_complete(struct nvme_dev *dev)
+{
+}
+
+#endif /* CONFIG_DEV_COREDUMP */
+
 static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
 						pci_channel_state_t state)
 {
-- 
2.7.4

