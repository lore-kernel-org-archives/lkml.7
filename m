Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF3AC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 05:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB8FF20873
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 05:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfGSFbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 01:31:19 -0400
Received: from gate.crashing.org ([63.228.1.57]:53042 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbfGSFbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 01:31:19 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x6J5V2e4001121;
        Fri, 19 Jul 2019 00:31:03 -0500
Message-ID: <b1f9bdf0294b8d87d292de3c7462c8e99551b02d.camel@kernel.crashing.org>
Subject: [PATCH v3] nvme-pci: Support shared tags across queues for Apple
 2018 controllers
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Paul Pawlowski <paul@mrarm.io>,
        Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Date:   Fri, 19 Jul 2019 15:31:02 +1000
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 8dcba2ef5b1466b023b88b4eca463b30de78d9eb Mon Sep 17 00:00:00 2001
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 19 Jul 2019 15:03:06 +1000
Subject: 

Another issue with the Apple T2 based 2018 controllers seem to be
that they blow up (and shut the machine down) if there's a tag
collision between the IO queue and the Admin queue.

My suspicion is that they use our tags for their internal tracking
and don't mix them with the queue id. They also seem to not like
when tags go beyond the IO queue depth, ie 128 tags.

This adds a quirk that marks tags 0..31 of the IO queue reserved

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Thanks Damien, reserved tags work and make this a lot simpler !

 drivers/nvme/host/nvme.h |  5 +++++
 drivers/nvme/host/pci.c  | 19 ++++++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ced0e0a7e039..8732da6df555 100644
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
index 7088971d4c42..fc74395a028b 100644
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
@@ -2278,6 +2286,14 @@ static int nvme_dev_add(struct nvme_dev *dev)
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
@@ -3057,7 +3073,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2005),
 		.driver_data = NVME_QUIRK_SINGLE_VECTOR |
-				NVME_QUIRK_128_BYTES_SQES },
+				NVME_QUIRK_128_BYTES_SQES |
+				NVME_QUIRK_SHARED_TAGS },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, nvme_id_table);


