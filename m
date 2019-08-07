Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCAAC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 07:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C2622BED
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 07:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbfHGHwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 03:52:10 -0400
Received: from gate.crashing.org ([63.228.1.57]:39484 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727331AbfHGHwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 03:52:09 -0400
Received: from ufdda393ec48b57.ant.amazon.com (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x777pPaL021791;
        Wed, 7 Aug 2019 02:51:33 -0500
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     linux-nvme@lists.infradead.org
Cc:     Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Paul Pawlowski <paul@mrarm.io>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v4 2/4] nvme-pci: Add support for variable IO SQ element size
Date:   Wed,  7 Aug 2019 17:51:20 +1000
Message-Id: <20190807075122.6247-3-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190807075122.6247-1-benh@kernel.crashing.org>
References: <20190807075122.6247-1-benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The size of a submission queue element should always be 6 (64 bytes)
by spec.

However some controllers such as Apple's are not properly implementing
the standard and require a different size.

This provides the ground work for the subsequent quirks for these
controllers.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 drivers/nvme/host/pci.c | 11 ++++++++---
 include/linux/nvme.h    |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b5b296984aa1..78a660e229d9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -28,7 +28,7 @@
 #include "trace.h"
 #include "nvme.h"
 
-#define SQ_SIZE(q)	((q)->q_depth * sizeof(struct nvme_command))
+#define SQ_SIZE(q)	((q)->q_depth << (q)->sqes)
 #define CQ_SIZE(q)	((q)->q_depth * sizeof(struct nvme_completion))
 
 #define SGES_PER_PAGE	(PAGE_SIZE / sizeof(struct nvme_sgl_desc))
@@ -100,6 +100,7 @@ struct nvme_dev {
 	unsigned io_queues[HCTX_MAX_TYPES];
 	unsigned int num_vecs;
 	int q_depth;
+	int io_sqes;
 	u32 db_stride;
 	void __iomem *bar;
 	unsigned long bar_mapped_size;
@@ -162,7 +163,7 @@ static inline struct nvme_dev *to_nvme_dev(struct nvme_ctrl *ctrl)
 struct nvme_queue {
 	struct nvme_dev *dev;
 	spinlock_t sq_lock;
-	struct nvme_command *sq_cmds;
+	void *sq_cmds;
 	 /* only used for poll queues: */
 	spinlock_t cq_poll_lock ____cacheline_aligned_in_smp;
 	volatile struct nvme_completion *cqes;
@@ -178,6 +179,7 @@ struct nvme_queue {
 	u16 last_cq_head;
 	u16 qid;
 	u8 cq_phase;
+	u8 sqes;
 	unsigned long flags;
 #define NVMEQ_ENABLED		0
 #define NVMEQ_SQ_CMB		1
@@ -488,7 +490,8 @@ static void nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd,
 			    bool write_sq)
 {
 	spin_lock(&nvmeq->sq_lock);
-	memcpy(&nvmeq->sq_cmds[nvmeq->sq_tail], cmd, sizeof(*cmd));
+	memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes),
+	       cmd, sizeof(*cmd));
 	if (++nvmeq->sq_tail == nvmeq->q_depth)
 		nvmeq->sq_tail = 0;
 	nvme_write_sq_db(nvmeq, write_sq);
@@ -1465,6 +1468,7 @@ static int nvme_alloc_queue(struct nvme_dev *dev, int qid, int depth)
 	if (dev->ctrl.queue_count > qid)
 		return 0;
 
+	nvmeq->sqes = qid ? dev->io_sqes : NVME_NVM_ADMSQES;
 	nvmeq->q_depth = depth;
 	nvmeq->cqes = dma_alloc_coherent(dev->dev, CQ_SIZE(nvmeq),
 					 &nvmeq->cq_dma_addr, GFP_KERNEL);
@@ -2317,6 +2321,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 	dev->ctrl.sqsize = dev->q_depth - 1; /* 0's based queue depth */
 	dev->db_stride = 1 << NVME_CAP_STRIDE(dev->ctrl.cap);
 	dev->dbs = dev->bar + 4096;
+	dev->io_sqes = NVME_NVM_IOSQES;
 
 	/*
 	 * Temporary fix for the Apple controller found in the MacBook8,1 and
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 01aa6a6c241d..d5a4bc21f36b 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -140,6 +140,7 @@ enum {
  * Submission and Completion Queue Entry Sizes for the NVM command set.
  * (In bytes and specified as a power of two (2^n)).
  */
+#define NVME_NVM_ADMSQES	6
 #define NVME_NVM_IOSQES		6
 #define NVME_NVM_IOCQES		4
 
-- 
2.17.1

