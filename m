Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD82AC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 00:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98AE520880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 00:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733153AbfGPAr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 20:47:27 -0400
Received: from gate.crashing.org ([63.228.1.57]:36343 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733097AbfGPArX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 20:47:23 -0400
Received: from ufdda393ec48b57.ant.amazon.com (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x6G0l1P6001806;
        Mon, 15 Jul 2019 19:47:05 -0500
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Paul Pawlowski <paul@mrarm.io>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/3] nvme: Retrieve the required IO queue entry size from the controller
Date:   Tue, 16 Jul 2019 10:46:48 +1000
Message-Id: <20190716004649.17799-2-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190716004649.17799-1-benh@kernel.crashing.org>
References: <20190716004649.17799-1-benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On PCIe based NVME devices, this will  retrieve the IO queue entry
size from the controller and use the "required" setting.

It should always be 6 (64 bytes) by spec. However some controllers
such as Apple's are not properly implementing the spec and require
the size to be 7 (128 bytes).

This provides the ground work for the subsequent quirks for these
controllers.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/nvme/host/core.c | 25 +++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/pci.c  |  9 ++++++---
 include/linux/nvme.h     |  1 +
 4 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cc09b81fc7f4..716ebe87a2b8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1986,6 +1986,7 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl, u64 cap)
 	ctrl->ctrl_config = NVME_CC_CSS_NVM;
 	ctrl->ctrl_config |= (page_shift - 12) << NVME_CC_MPS_SHIFT;
 	ctrl->ctrl_config |= NVME_CC_AMS_RR | NVME_CC_SHN_NONE;
+	/* Use default IOSQES. We'll update it later if needed */
 	ctrl->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
 	ctrl->ctrl_config |= NVME_CC_ENABLE;
 
@@ -2698,6 +2699,30 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 		ctrl->hmmin = le32_to_cpu(id->hmmin);
 		ctrl->hmminds = le32_to_cpu(id->hmminds);
 		ctrl->hmmaxd = le16_to_cpu(id->hmmaxd);
+
+		/* Grab required IO queue size */
+		ctrl->iosqes = id->sqes & 0xf;
+		if (ctrl->iosqes < NVME_NVM_IOSQES) {
+			dev_err(ctrl->device,
+				"unsupported required IO queue size %d\n", ctrl->iosqes);
+			ret = -EINVAL;
+			goto out_free;
+		}
+		/*
+		 * If our IO queue size isn't the default, update the setting
+		 * in CC:IOSQES.
+		 */
+		if (ctrl->iosqes != NVME_NVM_IOSQES) {
+			ctrl->ctrl_config &= ~(0xfu << NVME_CC_IOSQES_SHIFT);
+			ctrl->ctrl_config |= ctrl->iosqes << NVME_CC_IOSQES_SHIFT;
+			ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC,
+						     ctrl->ctrl_config);
+			if (ret) {
+				dev_err(ctrl->device,
+					"error updating CC register\n");
+				goto out_free;
+			}
+		}
 	}
 
 	ret = nvme_mpath_init(ctrl, id);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 716a876119c8..34ef35fcd8a5 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -244,6 +244,7 @@ struct nvme_ctrl {
 	u32 hmmin;
 	u32 hmminds;
 	u16 hmmaxd;
+	u8 iosqes;
 
 	/* Fabrics only */
 	u16 sqsize;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8f006638452b..54b35ea4af88 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -28,7 +28,7 @@
 #include "trace.h"
 #include "nvme.h"
 
-#define SQ_SIZE(q)	((q)->q_depth * sizeof(struct nvme_command))
+#define SQ_SIZE(q)	((q)->q_depth << (q)->sqes)
 #define CQ_SIZE(q)	((q)->q_depth * sizeof(struct nvme_completion))
 
 #define SGES_PER_PAGE	(PAGE_SIZE / sizeof(struct nvme_sgl_desc))
@@ -162,7 +162,7 @@ static inline struct nvme_dev *to_nvme_dev(struct nvme_ctrl *ctrl)
 struct nvme_queue {
 	struct nvme_dev *dev;
 	spinlock_t sq_lock;
-	struct nvme_command *sq_cmds;
+	void *sq_cmds;
 	 /* only used for poll queues: */
 	spinlock_t cq_poll_lock ____cacheline_aligned_in_smp;
 	volatile struct nvme_completion *cqes;
@@ -178,6 +178,7 @@ struct nvme_queue {
 	u16 last_cq_head;
 	u16 qid;
 	u8 cq_phase;
+	u8 sqes;
 	unsigned long flags;
 #define NVMEQ_ENABLED		0
 #define NVMEQ_SQ_CMB		1
@@ -488,7 +489,8 @@ static void nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd,
 			    bool write_sq)
 {
 	spin_lock(&nvmeq->sq_lock);
-	memcpy(&nvmeq->sq_cmds[nvmeq->sq_tail], cmd, sizeof(*cmd));
+	memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes),
+	       cmd, sizeof(*cmd));
 	if (++nvmeq->sq_tail == nvmeq->q_depth)
 		nvmeq->sq_tail = 0;
 	nvme_write_sq_db(nvmeq, write_sq);
@@ -1465,6 +1467,7 @@ static int nvme_alloc_queue(struct nvme_dev *dev, int qid, int depth)
 	if (dev->ctrl.queue_count > qid)
 		return 0;
 
+	nvmeq->sqes = qid ? dev->ctrl.iosqes : NVME_NVM_ADMSQES;
 	nvmeq->q_depth = depth;
 	nvmeq->cqes = dma_alloc_coherent(dev->dev, CQ_SIZE(nvmeq),
 					 &nvmeq->cq_dma_addr, GFP_KERNEL);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 01aa6a6c241d..7af18965fb57 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -141,6 +141,7 @@ enum {
  * (In bytes and specified as a power of two (2^n)).
  */
 #define NVME_NVM_IOSQES		6
+#define NVME_NVM_ADMSQES	6
 #define NVME_NVM_IOCQES		4
 
 enum {
-- 
2.17.1

