Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E042DC76191
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 00:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C29C820880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 00:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733130AbfGPArX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 20:47:23 -0400
Received: from gate.crashing.org ([63.228.1.57]:36341 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730355AbfGPArV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 20:47:21 -0400
Received: from ufdda393ec48b57.ant.amazon.com (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x6G0l1P7001806;
        Mon, 15 Jul 2019 19:47:09 -0500
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Paul Pawlowski <paul@mrarm.io>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 3/3] nvme: Add support for Apple 2018+ models
Date:   Tue, 16 Jul 2019 10:46:49 +1000
Message-Id: <20190716004649.17799-3-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190716004649.17799-1-benh@kernel.crashing.org>
References: <20190716004649.17799-1-benh@kernel.crashing.org>
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
 drivers/nvme/host/core.c |  5 ++++-
 drivers/nvme/host/nvme.h | 10 ++++++++++
 drivers/nvme/host/pci.c  |  6 ++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 716ebe87a2b8..480ea24d8cf4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2701,7 +2701,10 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 		ctrl->hmmaxd = le16_to_cpu(id->hmmaxd);
 
 		/* Grab required IO queue size */
-		ctrl->iosqes = id->sqes & 0xf;
+		if (ctrl->quirks & NVME_QUIRK_128_BYTES_SQES)
+			ctrl->iosqes = 7;
+		else
+			ctrl->iosqes = id->sqes & 0xf;
 		if (ctrl->iosqes < NVME_NVM_IOSQES) {
 			dev_err(ctrl->device,
 				"unsupported required IO queue size %d\n", ctrl->iosqes);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 34ef35fcd8a5..b2a78d08b984 100644
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
index 54b35ea4af88..ab2358137419 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2080,6 +2080,9 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 	dev->io_queues[HCTX_TYPE_DEFAULT] = 1;
 	dev->io_queues[HCTX_TYPE_READ] = 0;
 
+	if (dev->ctrl.quirks & NVME_QUIRK_SINGLE_VECTOR)
+		irq_queues = 1;
+
 	return pci_alloc_irq_vectors_affinity(pdev, 1, irq_queues,
 			      PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
 }
@@ -3037,6 +3040,9 @@ static const struct pci_device_id nvme_id_table[] = {
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

