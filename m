Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208BCC04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD87020656
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kejwneSN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbfESRiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 13:38:12 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45880 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfESRiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 13:38:11 -0400
Received: by mail-pl1-f194.google.com with SMTP id a5so5586221pls.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 10:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qb/jt89+9e++uPBRWiXI+lTLzEpxKOnSUavj6Tvl2rg=;
        b=kejwneSNHmXKZIu5n49NEypF4QAQMAU03CuK16P8W+sl+8WnLzXmgW+LQJXdJdljC/
         5XuyO6iKLaBk7zzobPskRBhrfH+nAWJQsbEfsk9FuCPa/0dZe9eLvat7pL+6+vCeeJ2a
         KPbKPbDAexg31b3prETpkkQuHTqvVfl4SGAFmpdwalghrcIQgjRtlY/o4SVBuJDjF1Lq
         0kFBjffYnfb4ZFDesFzW3fBjCOfr7EF5PnXk6y4q+ij0gSD2XOXCBuqM8CBS0gSq1l1q
         Yohr3Q2xVO1P0SBSxCQL8Jm0ZOyvE8f8rKkpaF8hBAP5gv2fHdk2keyY0Zk/RXF9QP8h
         MLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qb/jt89+9e++uPBRWiXI+lTLzEpxKOnSUavj6Tvl2rg=;
        b=chwoCCXv5N1uZ6+Kz2v94VQvQJDMHik70XWitHwubnBtSFzimDmp28bmnQhFZrdsoH
         eu2aawmuWdwlrX7QmbCAUSmA2ECOHiRe7COxwsfzTZo5bbW2oIE5EpsGP69yVXVr2T70
         bXsOSUvBJV+ptjwyLnlWmapBSTMhVrUZq3EjugY2ivVqOxNYTz6vqx59++nf6uyUNNY4
         BeH02qsTC0dx+dAALg9Ndk4VQs+YBFMaH88PUQeVfAyNe9N+U4HxCWlTOGv3nPqPkylP
         kQzXmTAMlPYu3KZfZuquuy3Vy+39DLX7wfBVqUFVL5knmslYjh2R5/7MIPsOTS26K+1y
         9HHQ==
X-Gm-Message-State: APjAAAXOwJSYOn2aCv5JOAXrcs2d/ezphQipfJpDs0T2zVnXZpnMVrAF
        PJlwuQYV4V5GAsA/uTEZamMwsUhl
X-Google-Smtp-Source: APXvYqy+LVHFBw7opLjOnXj2veuQ8xGSZN9eBsPMYFcwrnHySxTecQCDsPGDtt/98nteUYgRziyiAA==
X-Received: by 2002:a17:902:bc42:: with SMTP id t2mr18812022plz.55.1558278449499;
        Sun, 19 May 2019 08:07:29 -0700 (PDT)
Received: from mita-MS-7A45.lan ([240f:34:212d:1:5085:bb4a:e3a8:fc9d])
        by smtp.gmail.com with ESMTPSA id g17sm2441105pfb.56.2019.05.19.08.07.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 May 2019 08:07:28 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH v4 5/7] nvme-pci: add device coredump infrastructure
Date:   Mon, 20 May 2019 00:06:56 +0900
Message-Id: <1558278418-5702-6-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558278418-5702-1-git-send-email-akinobu.mita@gmail.com>
References: <1558278418-5702-1-git-send-email-akinobu.mita@gmail.com>
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v4
- Move nvme_get_telemetry_log() to nvme core module.
- Use bio_vec instead of sg_table to store telemetry log page
- Make nvme_coredump_logs() return error if the device didn't produce
  a response.

 drivers/nvme/host/Kconfig |   1 +
 drivers/nvme/host/pci.c   | 425 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 426 insertions(+)

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
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2a8708c..8a29c52 100644
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
+static int __maybe_unused nvme_coredump_logs(struct nvme_dev *dev);
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
@@ -2849,6 +2857,423 @@ static int nvme_resume(struct device *dev)
 
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
+struct nvme_coredump_bvecs {
+	unsigned int nents;
+	struct bio_vec bvecs[];
+};
+
+static ssize_t nvme_coredump_read_bvecs(char *buffer, loff_t offset,
+					size_t buf_len, void *data,
+					size_t data_len)
+{
+	struct nvme_coredump_bvecs *table = data;
+	struct bvec_iter iter = {
+		.bi_size = data_len,
+	};
+	loff_t pos = 0;
+
+	if (data_len <= offset)
+		return 0;
+
+	if (offset + buf_len > data_len)
+		buf_len = data_len - offset;
+
+	bvec_iter_advance(table->bvecs, &iter, offset);
+
+	while (pos < buf_len) {
+		struct bio_vec bvec = mp_bvec_iter_bvec(table->bvecs, iter);
+		size_t size = min_t(int, buf_len - pos, bvec.bv_len);
+
+		memcpy(buffer + pos,
+		       page_address(bvec.bv_page) + bvec.bv_offset, size);
+
+		pos += size;
+		bvec_iter_advance(table->bvecs, &iter, size);
+	}
+
+	return buf_len;
+}
+
+static void nvme_coredump_free_bvecs(void *data)
+{
+	struct nvme_coredump_bvecs *table = data;
+	int i;
+
+	for (i = 0; i < table->nents; i++) {
+		struct bio_vec *bvec = &table->bvecs[i];
+
+		__free_pages(bvec->bv_page, get_order(bvec->bv_len));
+	}
+
+	kfree(table);
+}
+
+static struct nvme_coredump_bvecs *nvme_coredump_alloc_bvecs(size_t bytes)
+{
+	struct nvme_coredump_bvecs *table;
+	int order = PAGE_ALLOC_COSTLY_ORDER - 1;
+	int n = DIV_ROUND_UP(bytes, PAGE_SIZE << order);
+	int i;
+
+	table = kzalloc(struct_size(table, bvecs, n), GFP_KERNEL);
+	if (!table)
+		return NULL;
+
+	table->nents = n;
+
+	for (i = 0; i < n; i++) {
+		struct page *page;
+		size_t size = min_t(int, bytes, PAGE_SIZE << order);
+
+		page = alloc_pages(GFP_KERNEL, get_order(size));
+		if (!page)
+			goto free_pages;
+
+		table->bvecs[i].bv_page = page;
+		table->bvecs[i].bv_len = size;
+		table->bvecs[i].bv_offset = 0;
+
+		bytes -= size;
+	}
+
+	return table;
+
+free_pages:
+	while (--i >= 0) {
+		struct bio_vec *bvec = &table->bvecs[i];
+
+		__free_pages(bvec->bv_page, get_order(bvec->bv_len));
+	}
+
+	kfree(table);
+
+	return NULL;
+}
+
+static int nvme_coredump_telemetry_log(struct dev_coredumpm_bulk_data *data,
+				       struct nvme_ctrl *ctrl)
+{
+	struct nvme_telemetry_log_page_hdr *page_hdr;
+	struct nvme_coredump_bvecs *table;
+	int log_size;
+	int ret;
+	u8 ctrldgn;
+
+	if (!(ctrl->lpa & NVME_CTRL_LPA_TELEMETRY_LOG))
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
+	table = nvme_coredump_alloc_bvecs(log_size);
+	if (!table) {
+		ret = -ENOMEM;
+		goto free_page_hdr;
+	}
+
+	ret = nvme_get_telemetry_log(ctrl, table->bvecs, log_size);
+	if (ret)
+		goto free_table;
+
+	nvme_coredump_read_bvecs(&ctrldgn, offsetof(typeof(*page_hdr), ctrldgn),
+				 sizeof(ctrldgn), table, log_size);
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
+	data->read = nvme_coredump_read_bvecs;
+	data->free = nvme_coredump_free_bvecs;
+
+	kfree(page_hdr);
+
+	return 0;
+free_table:
+	nvme_coredump_free_bvecs(table);
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
+static int nvme_coredump_logs(struct nvme_dev *dev)
+{
+	struct dev_coredumpm_bulk_data *bulk_data;
+	int ret;
+
+	if (!dev->dumps)
+		return 0;
+
+	bulk_data = nvme_coredump_alloc(dev, 1);
+	if (!bulk_data)
+		return 0;
+
+	ret = nvme_coredump_telemetry_log(bulk_data, &dev->ctrl);
+	if (ret)
+		dev->num_dumps--;
+
+	/* The request timed out */
+	if (ret == -EINTR || ret == NVME_SC_ABORT_REQ)
+		return -EIO;
+
+	return 0;
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
+static int nvme_coredump_logs(struct nvme_dev *dev)
+{
+	return 0;
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

