Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7A9C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 00:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC282182B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 00:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389109AbfGQApy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 20:45:54 -0400
Received: from gate.crashing.org ([63.228.1.57]:56499 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbfGQApy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 20:45:54 -0400
Received: from ufdda393ec48b57.ant.amazon.com (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x6H0jXnj032429;
        Tue, 16 Jul 2019 19:45:41 -0500
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Paul Pawlowski <paul@mrarm.io>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2 3/3] nvme-pci: Add support for Apple 2018+ models
Date:   Wed, 17 Jul 2019 10:45:27 +1000
Message-Id: <20190717004527.30363-3-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190717004527.30363-1-benh@kernel.crashing.org>
References: <20190717004527.30363-1-benh@kernel.crashing.org>
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

# Conflicts:
#	drivers/nvme/host/core.c
---
 drivers/nvme/host/nvme.h | 10 ++++++++++
 drivers/nvme/host/pci.c  | 21 ++++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 716a876119c8..ced0e0a7e039 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -92,6 +92,16 @@ enum nvme_quirks {
 	 * Broken Write Zeroes.
 	 */
 	NVME_QUIRK_DISABLE_WRITE_ZEROES		= (1 << 9),
+
+	/*
+	 * Use only one interrupt vector for all queues
+	 */
+	NVME_QUIRK_SINGLE_VECTOR		= (1 << 10),
+
+	/*
+	 * Use non-standard 128 bytes SQEs.
+	 */
+	NVME_QUIRK_128_BYTES_SQES		= (1 << 11),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 1637677afb78..7088971d4c42 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2081,6 +2081,13 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 	dev->io_queues[HCTX_TYPE_DEFAULT] = 1;
 	dev->io_queues[HCTX_TYPE_READ] = 0;
 
+	/*
+	 * Some Apple controllers require all queues to use the
+	 * first vector.
+	 */
+	if (dev->ctrl.quirks & NVME_QUIRK_SINGLE_VECTOR)
+		irq_queues = 1;
+
 	return pci_alloc_irq_vectors_affinity(pdev, 1, irq_queues,
 			      PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
 }
@@ -2322,7 +2329,16 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 				io_queue_depth);
 	dev->db_stride = 1 << NVME_CAP_STRIDE(dev->ctrl.cap);
 	dev->dbs = dev->bar + 4096;
-	dev->io_sqes = NVME_NVM_IOSQES;
+
+	/*
+	 * Some Apple controllers require a non-standard SQE size.
+	 * Interestingly they also seem to ignore the CC:IOSQES register
+	 * so we don't bother updating it here.
+	 */
+	if (dev->ctrl.quirks & NVME_QUIRK_128_BYTES_SQES)
+		dev->io_sqes = 7;
+	else
+		dev->io_sqes = NVME_NVM_IOSQES;
 
 	/*
 	 * Temporary fix for the Apple controller found in the MacBook8,1 and
@@ -3039,6 +3055,9 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2005),
+		.driver_data = NVME_QUIRK_SINGLE_VECTOR |
+				NVME_QUIRK_128_BYTES_SQES },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, nvme_id_table);
-- 
2.17.1

