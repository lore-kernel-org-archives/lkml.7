Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1D4C76195
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 00:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E382182B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 00:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389079AbfGQApx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 20:45:53 -0400
Received: from gate.crashing.org ([63.228.1.57]:56497 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbfGQApw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 20:45:52 -0400
Received: from ufdda393ec48b57.ant.amazon.com (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x6H0jXnh032429;
        Tue, 16 Jul 2019 19:45:34 -0500
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Paul Pawlowski <paul@mrarm.io>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2 1/3] nvme-pci: Pass the queue to SQ_SIZE/CQ_SIZE macros
Date:   Wed, 17 Jul 2019 10:45:25 +1000
Message-Id: <20190717004527.30363-1-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will make it easier to handle variable queue entry sizes
later. No functional change.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index dd10cf78f2d3..8f006638452b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -28,8 +28,8 @@
 #include "trace.h"
 #include "nvme.h"
 
-#define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
-#define CQ_SIZE(depth)		(depth * sizeof(struct nvme_completion))
+#define SQ_SIZE(q)	((q)->q_depth * sizeof(struct nvme_command))
+#define CQ_SIZE(q)	((q)->q_depth * sizeof(struct nvme_completion))
 
 #define SGES_PER_PAGE	(PAGE_SIZE / sizeof(struct nvme_sgl_desc))
 
@@ -1344,16 +1344,16 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 
 static void nvme_free_queue(struct nvme_queue *nvmeq)
 {
-	dma_free_coherent(nvmeq->dev->dev, CQ_SIZE(nvmeq->q_depth),
+	dma_free_coherent(nvmeq->dev->dev, CQ_SIZE(nvmeq),
 				(void *)nvmeq->cqes, nvmeq->cq_dma_addr);
 	if (!nvmeq->sq_cmds)
 		return;
 
 	if (test_and_clear_bit(NVMEQ_SQ_CMB, &nvmeq->flags)) {
 		pci_free_p2pmem(to_pci_dev(nvmeq->dev->dev),
-				nvmeq->sq_cmds, SQ_SIZE(nvmeq->q_depth));
+				nvmeq->sq_cmds, SQ_SIZE(nvmeq));
 	} else {
-		dma_free_coherent(nvmeq->dev->dev, SQ_SIZE(nvmeq->q_depth),
+		dma_free_coherent(nvmeq->dev->dev, SQ_SIZE(nvmeq),
 				nvmeq->sq_cmds, nvmeq->sq_dma_addr);
 	}
 }
@@ -1433,12 +1433,12 @@ static int nvme_cmb_qdepth(struct nvme_dev *dev, int nr_io_queues,
 }
 
 static int nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue *nvmeq,
-				int qid, int depth)
+				int qid)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
 	if (qid && dev->cmb_use_sqes && (dev->cmbsz & NVME_CMBSZ_SQS)) {
-		nvmeq->sq_cmds = pci_alloc_p2pmem(pdev, SQ_SIZE(depth));
+		nvmeq->sq_cmds = pci_alloc_p2pmem(pdev, SQ_SIZE(nvmeq));
 		if (nvmeq->sq_cmds) {
 			nvmeq->sq_dma_addr = pci_p2pmem_virt_to_bus(pdev,
 							nvmeq->sq_cmds);
@@ -1447,11 +1447,11 @@ static int nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue *nvmeq,
 				return 0;
 			}
 
-			pci_free_p2pmem(pdev, nvmeq->sq_cmds, SQ_SIZE(depth));
+			pci_free_p2pmem(pdev, nvmeq->sq_cmds, SQ_SIZE(nvmeq));
 		}
 	}
 
-	nvmeq->sq_cmds = dma_alloc_coherent(dev->dev, SQ_SIZE(depth),
+	nvmeq->sq_cmds = dma_alloc_coherent(dev->dev, SQ_SIZE(nvmeq),
 				&nvmeq->sq_dma_addr, GFP_KERNEL);
 	if (!nvmeq->sq_cmds)
 		return -ENOMEM;
@@ -1465,12 +1465,13 @@ static int nvme_alloc_queue(struct nvme_dev *dev, int qid, int depth)
 	if (dev->ctrl.queue_count > qid)
 		return 0;
 
-	nvmeq->cqes = dma_alloc_coherent(dev->dev, CQ_SIZE(depth),
+	nvmeq->q_depth = depth;
+	nvmeq->cqes = dma_alloc_coherent(dev->dev, CQ_SIZE(nvmeq),
 					 &nvmeq->cq_dma_addr, GFP_KERNEL);
 	if (!nvmeq->cqes)
 		goto free_nvmeq;
 
-	if (nvme_alloc_sq_cmds(dev, nvmeq, qid, depth))
+	if (nvme_alloc_sq_cmds(dev, nvmeq, qid))
 		goto free_cqdma;
 
 	nvmeq->dev = dev;
@@ -1479,15 +1480,14 @@ static int nvme_alloc_queue(struct nvme_dev *dev, int qid, int depth)
 	nvmeq->cq_head = 0;
 	nvmeq->cq_phase = 1;
 	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
-	nvmeq->q_depth = depth;
 	nvmeq->qid = qid;
 	dev->ctrl.queue_count++;
 
 	return 0;
 
  free_cqdma:
-	dma_free_coherent(dev->dev, CQ_SIZE(depth), (void *)nvmeq->cqes,
-							nvmeq->cq_dma_addr);
+	dma_free_coherent(dev->dev, CQ_SIZE(nvmeq), (void *)nvmeq->cqes,
+			  nvmeq->cq_dma_addr);
  free_nvmeq:
 	return -ENOMEM;
 }
@@ -1515,7 +1515,7 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 	nvmeq->cq_head = 0;
 	nvmeq->cq_phase = 1;
 	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
-	memset((void *)nvmeq->cqes, 0, CQ_SIZE(nvmeq->q_depth));
+	memset((void *)nvmeq->cqes, 0, CQ_SIZE(nvmeq));
 	nvme_dbbuf_init(dev, nvmeq, qid);
 	dev->online_queues++;
 	wmb(); /* ensure the first interrupt sees the initialization */
-- 
2.17.1

