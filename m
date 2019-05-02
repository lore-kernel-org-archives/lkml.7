Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D8DC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48CF2089E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGNyR9ML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfEBI7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 04:59:47 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41308 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfEBI7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 04:59:47 -0400
Received: by mail-pl1-f196.google.com with SMTP id d9so715798pls.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 01:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tXYM5nw7ak39L4uM2osotFg5pKyIiXvFREZpA8SFmCI=;
        b=kGNyR9MLScTRt4jQGlSoW5UjQ3KVMJL5DyQn24jm4+Kq6OGT9b4WVDKE9ceKyM8MZE
         h0aCenY0U1TFau1IfRTHsKwxiWvDg+t4HO5YnkvDPYuftLv0KGIkbubFJKRrfoadhSfN
         7N6mzeaMAx7RZcseN9bohnaL5r2JjL0ttRRs4yf2pqZXVipH9oTnTIdfbu+Xlr+3let1
         6mgEA+BFdWKJpdZ/dwn79pfY821+3bYxHkV1P0Jfh5rM6I7hebF/DnJmgvfZNGNNWnDr
         J6SniuSruQAtEM/muUQrsKFCTGFc2gY6i8MT5MJPkIfmgj0WucnOcyr+MHiUD+j+mn3E
         xA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tXYM5nw7ak39L4uM2osotFg5pKyIiXvFREZpA8SFmCI=;
        b=coziamm4a5FrHCCHBjPTcswA+vG0Fge8irlFphWEG9nCgkZv1oTEf+/OBOU853j0QA
         LIzgy+nbkm21Kf5Mlec0GmZz78SJNqJuk1OwybYVtRzElzs5uXysaAem/Ev0RKJnwMcN
         60aixsewZPLz04kR67cCGzQFKKJ/wFAlxkzMJgiM1x0Dh7r1b7hY8o0F9YNzourSe7lW
         Whl2cz6rhSsB8Bkdlh2A+KhaemBk1CC1iy5J8Qa3/ggome88LlhDTHKDQ+lcSPi9VQ/y
         +BF7feDS0NoXnFL8Q9Aom+4Gt+hMelcc4vcowJJ/q6/dzJz+NjWWpHV3L6mkj9VoUJ5X
         n1TA==
X-Gm-Message-State: APjAAAVQAT62vOFmQAr3xiA9om3UNh3FuA/Z2IRlDxMJBNsqRkiJucIi
        /31QkJ1vzdmV+W0L3b+UZmk=
X-Google-Smtp-Source: APXvYqxp9EQRTqmOExtZ1lGxRSi3l+QszIulZL1dsNrhpA5fRJDy1wCWRRU8pnnC+3k126/gJoSWRg==
X-Received: by 2002:a17:902:7d8a:: with SMTP id a10mr2480916plm.167.1556787586054;
        Thu, 02 May 2019 01:59:46 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:1b24:991b:df50:ea3f])
        by smtp.gmail.com with ESMTPSA id z7sm74960831pgh.81.2019.05.02.01.59.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 May 2019 01:59:45 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 3/4] nvme-pci: add device coredump support
Date:   Thu,  2 May 2019 17:59:20 +0900
Message-Id: <1556787561-5113-4-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556787561-5113-1-git-send-email-akinobu.mita@gmail.com>
References: <1556787561-5113-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables to capture snapshot of controller information via device
coredump machanism.

The nvme device coredump creates the following coredump files.

- regs: NVMe controller registers, including each I/O queue doorbell
        registers, in nvme-show-regs style text format.

- sq<qid>: I/O submission queue

- cq<qid>: I/O completion queue

Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/nvme/host/Kconfig |   1 +
 drivers/nvme/host/pci.c   | 221 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 222 insertions(+)

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
index a90cf5d..7f3077c 100644
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
@@ -2867,6 +2868,225 @@ static int nvme_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(nvme_dev_pm_ops, nvme_suspend, nvme_resume);
 
+#ifdef CONFIG_DEV_COREDUMP
+
+struct nvme_reg {
+	u32 off;
+	const char *name;
+	int bits;
+};
+
+static const struct nvme_reg nvme_regs[] = {
+	{ NVME_REG_CAP,		"cap",		64 },
+	{ NVME_REG_VS,		"version",	32 },
+	{ NVME_REG_INTMS,	"intms",	32 },
+	{ NVME_REG_INTMC,	"intmc",	32 },
+	{ NVME_REG_CC,		"cc",		32 },
+	{ NVME_REG_CSTS,	"csts",		32 },
+	{ NVME_REG_NSSR,	"nssr",		32 },
+	{ NVME_REG_AQA,		"aqa",		32 },
+	{ NVME_REG_ASQ,		"asq",		64 },
+	{ NVME_REG_ACQ,		"acq",		64 },
+	{ NVME_REG_CMBLOC,	"cmbloc",	32 },
+	{ NVME_REG_CMBSZ,	"cmbsz",	32 },
+};
+
+static int nvme_coredump_regs_padding(int num_queues)
+{
+	char name[16];
+	int padding;
+	int i;
+
+	padding = sprintf(name, "sq%dtdbl", num_queues - 1);
+
+	for (i = 0; i < ARRAY_SIZE(nvme_regs); i++)
+		padding = max_t(int, padding, strlen(nvme_regs[i].name));
+
+	return padding;
+}
+
+static int nvme_coredump_regs_buf_size(int num_queues, int padding)
+{
+	int line_size = padding + strlen(" : ffffffffffffffff\n");
+	int buf_size;
+
+	/* Max print buffer size for controller registers */
+	buf_size = line_size * ARRAY_SIZE(nvme_regs);
+
+	/* Max print buffer size for SQyTDBL and CQxHDBL registers */
+	buf_size += line_size * num_queues * 2;
+
+	return buf_size;
+}
+
+static int nvme_coredump_regs_print(void *buf, int buf_size,
+				    struct nvme_ctrl *ctrl, int padding)
+{
+	struct nvme_dev *dev = to_nvme_dev(ctrl);
+	int len = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(nvme_regs); i++) {
+		const struct nvme_reg *reg = &nvme_regs[i];
+		u64 val;
+
+		if (reg->bits == 32)
+			val = readl(dev->bar + reg->off);
+		else
+			val = readq(dev->bar + reg->off);
+
+		len += snprintf(buf + len, buf_size - len, "%-*s : %llx\n",
+				padding, reg->name, val);
+	}
+
+	for (i = 0; i < ctrl->queue_count; i++) {
+		struct nvme_queue *nvmeq = &dev->queues[i];
+		char name[16];
+
+		sprintf(name, "sq%dtdbl", i);
+		len += snprintf(buf + len, buf_size - len, "%-*s : %x\n",
+				padding, name, readl(nvmeq->q_db));
+
+		sprintf(name, "cq%dhdbl", i);
+		len += snprintf(buf + len, buf_size - len, "%-*s : %x\n",
+				padding, name,
+				readl(nvmeq->q_db + dev->db_stride));
+	}
+
+	return len;
+}
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
+static int nvme_coredump_regs(struct dev_coredumpm_bulk_data *data,
+			      struct nvme_ctrl *ctrl)
+{
+	int padding = nvme_coredump_regs_padding(ctrl->queue_count);
+	int buf_size = nvme_coredump_regs_buf_size(ctrl->queue_count, padding);
+	void *buf;
+
+	buf = kvzalloc(buf_size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	data->name = kstrdup("regs", GFP_KERNEL);
+	if (!data->name) {
+		kvfree(buf);
+		return -ENOMEM;
+	}
+
+	data->data = buf;
+	data->datalen = nvme_coredump_regs_print(buf, buf_size, ctrl, padding);
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
+static void nvme_coredump(struct device *dev)
+{
+	struct nvme_dev *ndev = dev_get_drvdata(dev);
+	struct nvme_ctrl *ctrl = &ndev->ctrl;
+	struct dev_coredumpm_bulk_data *bulk_data;
+	int ret;
+	int i;
+
+	bulk_data = kcalloc(1 + 2 * ctrl->queue_count, sizeof(*bulk_data),
+			    GFP_KERNEL);
+	if (!bulk_data)
+		return;
+
+	ret = nvme_coredump_regs(&bulk_data[0], ctrl);
+	if (ret)
+		goto free_bulk_data;
+
+	ret = nvme_coredump_queues(&bulk_data[1], ctrl);
+	if (ret)
+		goto free_bulk_data;
+
+	dev_coredumpm_bulk(dev, THIS_MODULE, GFP_KERNEL, bulk_data,
+			   1 + 2 * ctrl->queue_count);
+
+free_bulk_data:
+	for (i = 0; i < 1 + 2 * ctrl->queue_count; i++) {
+		kfree(bulk_data[i].name);
+		if (ret)
+			kvfree(bulk_data[i].data);
+	}
+
+	kfree(bulk_data);
+}
+
+#else
+
+static void nvme_coredump(struct device *dev)
+{
+}
+
+#endif /* CONFIG_DEV_COREDUMP */
+
 static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
 						pci_channel_state_t state)
 {
@@ -2972,6 +3192,7 @@ static struct pci_driver nvme_driver = {
 	.shutdown	= nvme_shutdown,
 	.driver		= {
 		.pm	= &nvme_dev_pm_ops,
+		.coredump = nvme_coredump,
 	},
 	.sriov_configure = pci_sriov_configure_simple,
 	.err_handler	= &nvme_err_handler,
-- 
2.7.4

