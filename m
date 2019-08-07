Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31082C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 07:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B55D217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 07:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387500AbfHGHwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 03:52:04 -0400
Received: from gate.crashing.org ([63.228.1.57]:39476 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727331AbfHGHwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 03:52:04 -0400
Received: from ufdda393ec48b57.ant.amazon.com (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x777pPaN021791;
        Wed, 7 Aug 2019 02:51:40 -0500
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     linux-nvme@lists.infradead.org
Cc:     Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Paul Pawlowski <paul@mrarm.io>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v4 4/4] nvme-pci: Support shared tags across queues for Apple 2018 controllers
Date:   Wed,  7 Aug 2019 17:51:22 +1000
Message-Id: <20190807075122.6247-5-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190807075122.6247-1-benh@kernel.crashing.org>
References: <20190807075122.6247-1-benh@kernel.crashing.org>
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

This adds a quirk that marks tags 0..31 of the IO queue reserved

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Acked-by: Keith Busch <keith.busch@intel.com>
---
 drivers/nvme/host/nvme.h |  5 +++++
 drivers/nvme/host/pci.c  | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 0925f7fc13ff..3e64f7187e70 100644
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
+	NVME_QUIRK_SHARED_TAGS                  = (1 << 12),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c683263cdf60..de8c170d5abc 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2106,6 +2106,14 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	unsigned long size;
 
 	nr_io_queues = max_io_queues();
+
+	/*
+	 * If tags are shared with admin queue (Apple bug), then
+	 * make sure we only use one IO queue.
+	 */
+	if (dev->ctrl.quirks & NVME_QUIRK_SHARED_TAGS)
+		nr_io_queues = 1;
+
 	result = nvme_set_queue_count(&dev->ctrl, &nr_io_queues);
 	if (result < 0)
 		return result;
@@ -2276,6 +2284,14 @@ static int nvme_dev_add(struct nvme_dev *dev)
 		dev->tagset.flags = BLK_MQ_F_SHOULD_MERGE;
 		dev->tagset.driver_data = dev;
 
+		/*
+		 * Some Apple controllers requires tags to be unique
+		 * across admin and IO queue, so reserve the first 32
+		 * tags of the IO queue.
+		 */
+		if (dev->ctrl.quirks & NVME_QUIRK_SHARED_TAGS)
+			dev->tagset.reserved_tags = NVME_AQ_DEPTH;
+
 		ret = blk_mq_alloc_tag_set(&dev->tagset);
 		if (ret) {
 			dev_warn(dev->ctrl.device,
@@ -2356,6 +2372,18 @@ static int nvme_pci_enable(struct nvme_dev *dev)
                         "set queue depth=%u\n", dev->q_depth);
 	}
 
+	/*
+	 * Controllers with the shared tags quirk need the IO queue to be
+	 * big enough so that we get 32 tags for the admin queue
+	 */
+	if ((dev->ctrl.quirks & NVME_QUIRK_SHARED_TAGS) &&
+	    (dev->q_depth < (NVME_AQ_DEPTH + 2))) {
+		dev->q_depth = NVME_AQ_DEPTH + 2;
+		dev_warn(dev->ctrl.device, "IO queue depth clamped to %d\n",
+			 dev->q_depth);
+	}
+
+
 	nvme_map_cmb(dev);
 
 	pci_enable_pcie_error_reporting(pdev);
@@ -3057,7 +3085,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2005),
 		.driver_data = NVME_QUIRK_SINGLE_VECTOR |
-				NVME_QUIRK_128_BYTES_SQES },
+				NVME_QUIRK_128_BYTES_SQES |
+				NVME_QUIRK_SHARED_TAGS },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, nvme_id_table);
-- 
2.17.1

