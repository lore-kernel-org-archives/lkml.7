Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DBDC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 03:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194D920868
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 03:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbfGODn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 23:43:58 -0400
Received: from gate.crashing.org ([63.228.1.57]:42039 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727721AbfGODn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 23:43:58 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x6F3hbhI016855;
        Sun, 14 Jul 2019 22:43:38 -0500
Message-ID: <71b009057582cd9c82cff2b45bc1af846408bcf7.camel@kernel.crashing.org>
Subject: [PATCH] nvme: Add support for Apple 2018+ models
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     linux-nvme@lists.infradead.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>, Paul Pawlowski <paul@mrarm.io>
Date:   Mon, 15 Jul 2019 13:43:37 +1000
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on reverse engineering and original patch by

Paul Pawlowski <paul@mrarm.io>

This adds support for Apple weird implementation of NVME in their
2018 or later machines. It accounts for the twice-as-big SQ entries
for the IO queues, and the fact that only interrupt vector 0 appears
to function properly.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

I reworked Paul's patch to be less invasive in nvme_submit_cmd()
hot path, effectively only adding a shift with a value hopefully
coming from the same cache line as existing stuff.

It could probably be made even less by making sq_extra_shift be
instead "sq_shift" and contain the complete shift between entries,
ie, 6 or 7, and then replacing the memcpy to

	&nvmeq->sq_cmds[nvmeq->sq_tail]

With something like

	((char *)nvmeq->sq_cmds) + ((size_t)nvmeq->sq_tail) << nvmeq->sq_shift

But I doubt the difference will be measurable anywhere and it makes
the code grosser imho.

Note: I'm not subscribed to linux-nvme, please CC me on replies.

 drivers/nvme/host/nvme.h |  5 ++++
 drivers/nvme/host/pci.c  | 59 ++++++++++++++++++++++++++++------------
 2 files changed, 47 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 55553d293a98..9ae53cbfb320 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -92,6 +92,11 @@ enum nvme_quirks {
 	 * Broken Write Zeroes.
 	 */
 	NVME_QUIRK_DISABLE_WRITE_ZEROES		= (1 << 9),
+
+	/*
+	 * Apple 2018 and latter variant has a few issues
+	 */
+	NVME_QUIRK_APPLE_2018			= (1 << 10),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 524d6bd6d095..1a41412fc48b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -27,8 +27,8 @@
 #include "trace.h"
 #include "nvme.h"
 
-#define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
-#define CQ_SIZE(depth)		(depth * sizeof(struct nvme_completion))
+#define SQ_SIZE(q)	((((size_t)(q)->q_depth) << (q)->sq_extra_shift) * sizeof(struct nvme_command))
+#define CQ_SIZE(q)	(((size_t)(q)->q_depth) * sizeof(struct nvme_completion))
 
 #define SGES_PER_PAGE	(PAGE_SIZE / sizeof(struct nvme_sgl_desc))
 
@@ -195,6 +195,7 @@ struct nvme_queue {
 	u16 last_cq_head;
 	u16 qid;
 	u8 cq_phase;
+	u8 sq_extra_shift;
 	unsigned long flags;
 #define NVMEQ_ENABLED		0
 #define NVMEQ_SQ_CMB		1
@@ -504,8 +505,11 @@ static inline void nvme_write_sq_db(struct nvme_queue *nvmeq, bool write_sq)
 static void nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd,
 			    bool write_sq)
 {
+	u16 sq_actual_pos;
+
 	spin_lock(&nvmeq->sq_lock);
-	memcpy(&nvmeq->sq_cmds[nvmeq->sq_tail], cmd, sizeof(*cmd));
+	sq_actual_pos = nvmeq->sq_tail << nvmeq->sq_extra_shift;
+	memcpy(&nvmeq->sq_cmds[sq_actual_pos], cmd, sizeof(*cmd));
 	if (++nvmeq->sq_tail == nvmeq->q_depth)
 		nvmeq->sq_tail = 0;
 	nvme_write_sq_db(nvmeq, write_sq);
@@ -1361,16 +1365,16 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 
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
@@ -1450,12 +1454,12 @@ static int nvme_cmb_qdepth(struct nvme_dev *dev, int nr_io_queues,
 }
 
 static int nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue *nvmeq,
-				int qid, int depth)
+				int qid)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
 	if (qid && dev->cmb_use_sqes && (dev->cmbsz & NVME_CMBSZ_SQS)) {
-		nvmeq->sq_cmds = pci_alloc_p2pmem(pdev, SQ_SIZE(depth));
+		nvmeq->sq_cmds = pci_alloc_p2pmem(pdev, SQ_SIZE(nvmeq));
 		nvmeq->sq_dma_addr = pci_p2pmem_virt_to_bus(pdev,
 						nvmeq->sq_cmds);
 		if (nvmeq->sq_dma_addr) {
@@ -1464,7 +1468,7 @@ static int nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue *nvmeq,
 		}
 	}
 
-	nvmeq->sq_cmds = dma_alloc_coherent(dev->dev, SQ_SIZE(depth),
+	nvmeq->sq_cmds = dma_alloc_coherent(dev->dev, SQ_SIZE(nvmeq),
 				&nvmeq->sq_dma_addr, GFP_KERNEL);
 	if (!nvmeq->sq_cmds)
 		return -ENOMEM;
@@ -1478,12 +1482,24 @@ static int nvme_alloc_queue(struct nvme_dev *dev, int qid, int depth)
 	if (dev->ctrl.queue_count > qid)
 		return 0;
 
-	nvmeq->cqes = dma_alloc_coherent(dev->dev, CQ_SIZE(depth),
+	/*
+	 * On Apple 2018 or later implementations, the IO submission
+	 * queue(s) have twice as large entries. Current implementations
+	 * seem to only have qid 1, let's assume this is true of all IO
+	 * queues until we know better.
+	 */
+	if (qid && (dev->ctrl.quirks & NVME_QUIRK_APPLE_2018))
+		nvmeq->sq_extra_shift = 1;
+	else
+		nvmeq->sq_extra_shift = 0;
+
+	nvmeq->q_depth = depth;
+	nvmeq->cqes = dma_alloc_coherent(dev->dev, CQ_SIZE(nvmeq),
 					 &nvmeq->cq_dma_addr, GFP_KERNEL);
 	if (!nvmeq->cqes)
 		goto free_nvmeq;
 
-	if (nvme_alloc_sq_cmds(dev, nvmeq, qid, depth))
+	if (nvme_alloc_sq_cmds(dev, nvmeq, qid))
 		goto free_cqdma;
 
 	nvmeq->dev = dev;
@@ -1492,15 +1508,14 @@ static int nvme_alloc_queue(struct nvme_dev *dev, int qid, int depth)
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
@@ -1527,8 +1542,9 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 	nvmeq->last_sq_tail = 0;
 	nvmeq->cq_head = 0;
 	nvmeq->cq_phase = 1;
+
 	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
-	memset((void *)nvmeq->cqes, 0, CQ_SIZE(nvmeq->q_depth));
+	memset((void *)nvmeq->cqes, 0, CQ_SIZE(nvmeq));
 	nvme_dbbuf_init(dev, nvmeq, qid);
 	dev->online_queues++;
 	wmb(); /* ensure the first interrupt sees the initialization */
@@ -1546,9 +1562,16 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
 	 * A queue's vector matches the queue identifier unless the controller
 	 * has only one vector available.
 	 */
-	if (!polled)
+	if (!polled) {
 		vector = dev->num_vecs == 1 ? 0 : qid;
-	else
+
+		/*
+		 * On Apple 2018 or later implementations, only vector 0 is accepted
+		 * by the drive firmware
+		 */
+		if (dev->ctrl.quirks & NVME_QUIRK_APPLE_2018)
+			vector = 0;
+	} else
 		set_bit(NVMEQ_POLLED, &nvmeq->flags);
 
 	result = adapter_alloc_cq(dev, qid, nvmeq, vector);
@@ -2949,6 +2972,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2005),
+		.driver_data = NVME_QUIRK_APPLE_2018},
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, nvme_id_table);


