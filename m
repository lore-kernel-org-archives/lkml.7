Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A799BCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 20:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D5221E6F
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 20:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbfJYUZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 16:25:50 -0400
Received: from ale.deltatee.com ([207.54.116.67]:35314 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728279AbfJYUZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 16:25:46 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1iO69R-00078e-Ir; Fri, 25 Oct 2019 14:25:39 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1iO69Q-000392-RZ; Fri, 25 Oct 2019 14:25:36 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Fri, 25 Oct 2019 14:25:35 -0600
Message-Id: <20191025202535.12036-4-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025202535.12036-1-logang@deltatee.com>
References: <20191025202535.12036-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me, kbusch@kernel.org, Chaitanya.Kulkarni@wdc.com, maxg@mellanox.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [RFC PATCH 3/3] nvme: Introduce nvme_execute_passthru_rq_nowait()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is similar to nvme_execute_passthru_rq() but does
not wait and will call a callback when the request is complete.

The new function can also be called in interrupt context, so if there
are side effects, the request will be executed in a work queue to
avoid sleeping.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/host/core.c | 42 ++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  7 +++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2b4f0ea55f8d..6d3cade0e63d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4211,6 +4211,48 @@ void nvme_sync_queues(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_sync_queues);
 
+#ifdef CONFIG_NVME_TARGET_PASSTHRU
+static void nvme_execute_passthru_rq_work(struct work_struct *w)
+{
+	struct nvme_request *req = container_of(w, struct nvme_request, work);
+	struct request *rq = blk_mq_rq_from_pdu(req);
+	rq_end_io_fn *done = rq->end_io;
+	void *end_io_data = rq->end_io_data;
+
+	nvme_execute_passthru_rq(rq);
+
+	if (done) {
+		rq->end_io_data = end_io_data;
+		done(rq, 0);
+	}
+}
+
+void nvme_execute_passthru_rq_nowait(struct request *rq, rq_end_io_fn *done)
+{
+	struct nvme_command *cmd = nvme_req(rq)->cmd;
+	struct nvme_ctrl *ctrl = nvme_req(rq)->ctrl;
+	struct nvme_ns *ns = rq->q->queuedata;
+	struct gendisk *disk = ns ? ns->disk : NULL;
+	u32 effects;
+
+	/*
+	 * This function may be called in interrupt context, so we cannot sleep
+	 * but nvme_passthru_[start|end]() may sleep so we need to execute
+	 * the command in a work queue.
+	 */
+	effects = nvme_command_effects(ctrl, ns, cmd->common.opcode);
+	if (effects) {
+		rq->end_io = done;
+		INIT_WORK(&nvme_req(rq)->work, nvme_execute_passthru_rq_work);
+		queue_work(nvme_wq, &nvme_req(rq)->work);
+		return;
+	}
+
+	blk_execute_rq_nowait(rq->q, disk, rq, 0, done);
+}
+EXPORT_SYMBOL_GPL(nvme_execute_passthru_rq_nowait);
+#endif /* CONFIG_NVME_TARGET_PASSTHRU */
+
 /*
  * Check we didn't inadvertently grow the command structure sizes:
  */
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 22e8401352c2..9523779de662 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -128,6 +128,9 @@ struct nvme_request {
 	u8			flags;
 	u16			status;
 	struct nvme_ctrl	*ctrl;
+#ifdef CONFIG_NVME_TARGET_PASSTHRU
+	struct work_struct	work;
+#endif
 };
 
 /*
@@ -652,4 +655,8 @@ static inline struct nvme_ns *nvme_get_ns_from_dev(struct device *dev)
 	return dev_to_disk(dev)->private_data;
 }
 
+#ifdef CONFIG_NVME_TARGET_PASSTHRU
+void nvme_execute_passthru_rq_nowait(struct request *rq, rq_end_io_fn *done);
+#endif /* CONFIG_NVME_TARGET_PASSTHRU */
+
 #endif /* _NVME_H */
-- 
2.20.1

