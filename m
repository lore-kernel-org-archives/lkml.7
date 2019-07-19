Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A442DC76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F0BC206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388741AbfGSEgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:36:40 -0400
Received: from gate.crashing.org ([63.228.1.57]:60658 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730891AbfGSEgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:36:36 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x6J4aDNX030520;
        Thu, 18 Jul 2019 23:36:14 -0500
Message-ID: <f19ac710b4dc28fb3b59ef11bd06d341bc939f3d.camel@kernel.crashing.org>
Subject: [PATCH v2] nvme-pci: Support shared tags across queues for Apple
 2018 controllers
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Paul Pawlowski <paul@mrarm.io>,
        Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Date:   Fri, 19 Jul 2019 14:36:13 +1000
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another issue with the Apple T2 based 2018 controllers seem to be
that they blow up (and shut the machine down) if there's a tag
collision between the IO queue and the Admin queue.

My suspicion is that they use our tags for their internal tracking
and don't mix them with the queue id. They also seem to not like
when tags go beyond the IO queue depth, ie 128 tags.

This adds a quirk that offsets all the tags in the IO queue by 32
to avoid those collisions. It also limits the number of IO queues
to 1 since the code wouldn't otherwise make sense (the device
supports only one queue anyway but better safe than sorry) and
reduces the size of the IO queue

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Note: One thing I noticed is how we have nvme_completion as volatile.

I don't think we really need that, it's forcing the compiler to constantly
reload things which makes no sense once we have established that an
entry is valid.

And since we have a data & control dependency from nvme_cqe_pending(),
we know that reading the CQE is going to depend on it being valid. I
don't really see what volatile is buying us here other than cargo culting.

Cheers,
Ben.

 drivers/nvme/host/nvme.h |  5 ++++
 drivers/nvme/host/pci.c  | 52 +++++++++++++++++++++++++++++++++-------
 2 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ced0e0a7e039..7c6de398de7d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -102,6 +102,11 @@ enum nvme_quirks {
 	 * Use non-standard 128 bytes SQEs.
 	 */
 	NVME_QUIRK_128_BYTES_SQES		= (1 << 11),
+
+	/*
+	 * Prevent tag overlap between queues
+	 */
+	NVME_QUIRK_SHARED_TAGS			= (1 << 12),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7088971d4c42..c38e946ad8ca 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -178,6 +178,7 @@ struct nvme_queue {
 	u16 cq_head;
 	u16 last_cq_head;
 	u16 qid;
+	u16 tag_offset;
 	u8 cq_phase;
 	u8 sqes;
 	unsigned long flags;
@@ -490,6 +491,7 @@ static void nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd,
 			    bool write_sq)
 {
 	spin_lock(&nvmeq->sq_lock);
+	cmd->common.command_id += nvmeq->tag_offset;
 	memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes),
 	       cmd, sizeof(*cmd));
 	if (++nvmeq->sq_tail == nvmeq->q_depth)
@@ -951,9 +953,10 @@ static inline void nvme_ring_cq_doorbell(struct nvme_queue *nvmeq)
 static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 {
 	volatile struct nvme_completion *cqe = &nvmeq->cqes[idx];
+	u16 ctag = cqe->command_id - nvmeq->tag_offset;
 	struct request *req;
 
-	if (unlikely(cqe->command_id >= nvmeq->q_depth)) {
+	if (unlikely(ctag >= nvmeq->q_depth)) {
 		dev_warn(nvmeq->dev->ctrl.device,
 			"invalid id %d completed on queue %d\n",
 			cqe->command_id, le16_to_cpu(cqe->sq_id));
@@ -966,14 +969,13 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 	 * aborts.  We don't even bother to allocate a struct request
 	 * for them but rather special case them here.
 	 */
-	if (unlikely(nvmeq->qid == 0 &&
-			cqe->command_id >= NVME_AQ_BLK_MQ_DEPTH)) {
+	if (unlikely(nvmeq->qid == 0 && ctag >= NVME_AQ_BLK_MQ_DEPTH)) {
 		nvme_complete_async_event(&nvmeq->dev->ctrl,
 				cqe->status, &cqe->result);
 		return;
 	}
 
-	req = blk_mq_tag_to_rq(*nvmeq->tags, cqe->command_id);
+	req = blk_mq_tag_to_rq(*nvmeq->tags, ctag);
 	trace_nvme_sq(req, cqe->sq_head, nvmeq->sq_tail);
 	nvme_end_request(req, cqe->status, cqe->result);
 }
@@ -1004,7 +1006,10 @@ static inline int nvme_process_cq(struct nvme_queue *nvmeq, u16 *start,
 
 	*start = nvmeq->cq_head;
 	while (nvme_cqe_pending(nvmeq)) {
-		if (tag == -1U || nvmeq->cqes[nvmeq->cq_head].command_id == tag)
+		u16 ctag = nvmeq->cqes[nvmeq->cq_head].command_id;
+
+		ctag -= nvmeq->tag_offset;
+		if (tag == -1U || ctag == tag)
 			found++;
 		nvme_update_cq_head(nvmeq);
 	}
@@ -1487,6 +1492,10 @@ static int nvme_alloc_queue(struct nvme_dev *dev, int qid, int depth)
 	nvmeq->qid = qid;
 	dev->ctrl.queue_count++;
 
+	if (qid && (dev->ctrl.quirks & NVME_QUIRK_SHARED_TAGS))
+		nvmeq->tag_offset = NVME_AQ_DEPTH;
+	else
+		nvmeq->tag_offset = 0;
 	return 0;
 
  free_cqdma:
@@ -2106,6 +2115,14 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	unsigned long size;
 
 	nr_io_queues = max_io_queues();
+
+	/*
+	 * If tags are shared with admin queue (Apple bug), then
+	 * make sure we only use one queue.
+	 */
+	if (dev->ctrl.quirks & NVME_QUIRK_SHARED_TAGS)
+		nr_io_queues = 1;
+
 	result = nvme_set_queue_count(&dev->ctrl, &nr_io_queues);
 	if (result < 0)
 		return result;
@@ -2300,6 +2317,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 {
 	int result = -ENOMEM;
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	unsigned int mqes;
 
 	if (pci_enable_device_mem(pdev))
 		return result;
@@ -2325,8 +2343,8 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 
 	dev->ctrl.cap = lo_hi_readq(dev->bar + NVME_REG_CAP);
 
-	dev->q_depth = min_t(int, NVME_CAP_MQES(dev->ctrl.cap) + 1,
-				io_queue_depth);
+	mqes = NVME_CAP_MQES(dev->ctrl.cap);
+	dev->q_depth = min_t(int, mqes + 1, io_queue_depth);
 	dev->db_stride = 1 << NVME_CAP_STRIDE(dev->ctrl.cap);
 	dev->dbs = dev->bar + 4096;
 
@@ -2340,6 +2358,23 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 	else
 		dev->io_sqes = NVME_NVM_IOSQES;
 
+	/*
+	 * Another Apple one: If we're going to offset the IO queue tags,
+	 * we still want to make sure they are no bigger than MQES,
+	 * it *looks* like otherwise, bad things happen (I suspect some
+	 * of the tag tracking in that device is limited).
+	 */
+	if (dev->ctrl.quirks & NVME_QUIRK_SHARED_TAGS) {
+		if (mqes <= NVME_AQ_DEPTH) {
+			dev_err(dev->ctrl.device, "Apple shared tags quirk"
+				" not compatible with device mqes %d\n", mqes);
+			result = -ENODEV;
+			goto disable;
+		}
+		dev->q_depth = min_t(int, dev->q_depth,
+				     mqes - NVME_AQ_DEPTH + 1);
+	}
+
 	/*
 	 * Temporary fix for the Apple controller found in the MacBook8,1 and
 	 * some MacBook7,1 to avoid controller resets and data loss.
@@ -3057,7 +3092,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2005),
 		.driver_data = NVME_QUIRK_SINGLE_VECTOR |
-				NVME_QUIRK_128_BYTES_SQES },
+				NVME_QUIRK_128_BYTES_SQES |
+				NVME_QUIRK_SHARED_TAGS },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, nvme_id_table);


