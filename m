Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EC4C2D0BF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 08:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA1624656
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 08:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbfLMIDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 03:03:38 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50345 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfLMIDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 03:03:37 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1iffvE-00025T-43; Fri, 13 Dec 2019 09:03:36 +0100
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1iffvD-000715-K4; Fri, 13 Dec 2019 09:03:35 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-ide@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] libata: Fix retrieving of active qcs
Date:   Fri, 13 Dec 2019 09:03:34 +0100
Message-Id: <20191213080334.26922-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ata_qc_complete_multiple() is called with a mask of the still active
tags.

mv_sata doesn't have this information directly and instead calculates
the still active tags from the started tags (ap->qc_active) and the
finished tags as (ap->qc_active ^ done_mask)

Since 28361c40368 the hw_tag and tag are no longer the same and the
equation is no longer valid. In ata_exec_internal_sg() ap->qc_active is
initialized as 1ULL << ATA_TAG_INTERNAL, but in hardware tag 0 is
started and this will be in done_mask on completion. ap->qc_active ^
done_mask becomes 0x100000000 ^ 0x1 = 0x100000001 and thus tag 0 used as
the internal tag will never be reported as completed.

This is fixed by introducing ata_qc_get_active() which returns the
active hardware tags and calling it where appropriate.

This is tested on mv_sata, but sata_fsl and sata_nv suffer from the same
problem. There is another case in sata_nv that most likely needs fixing
as well, but this looks a little different, so I wasn't confident enough
to change that.

Fixes: 28361c403683 ("libata: add extra internal command")
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/ata/libata-core.c | 23 +++++++++++++++++++++++
 drivers/ata/sata_fsl.c    |  2 +-
 drivers/ata/sata_mv.c     |  2 +-
 drivers/ata/sata_nv.c     |  2 +-
 include/linux/libata.h    |  1 +
 5 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index e9017c570bc5..a330e1f28ff4 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5328,6 +5328,29 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
 	}
 }
 
+/**
+ *	ata_qc_get_active - get bitmask of active qcs
+ *	@ap: port in question
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ *
+ *	RETURNS:
+ *	Bitmask of active qcs
+ */
+u64 ata_qc_get_active(struct ata_port *ap)
+{
+	u64 qc_active = ap->qc_active;
+
+	/* ATA_TAG_INTERNAL is sent to hw as tag 0 */
+	if (qc_active & (1ULL << ATA_TAG_INTERNAL)) {
+		qc_active |= (1 << 0);
+		qc_active &= ~(1ULL << ATA_TAG_INTERNAL);
+	}
+
+	return qc_active;
+}
+
 /**
  *	ata_qc_complete_multiple - Complete multiple qcs successfully
  *	@ap: port in question
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 9239615d8a04..d55ee244d693 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1280,7 +1280,7 @@ static void sata_fsl_host_intr(struct ata_port *ap)
 				     i, ioread32(hcr_base + CC),
 				     ioread32(hcr_base + CA));
 		}
-		ata_qc_complete_multiple(ap, ap->qc_active ^ done_mask);
+		ata_qc_complete_multiple(ap, ata_qc_get_active(ap) ^ done_mask);
 		return;
 
 	} else if ((ap->qc_active & (1ULL << ATA_TAG_INTERNAL))) {
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 277f11909fc1..d7228f8e9297 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -2829,7 +2829,7 @@ static void mv_process_crpb_entries(struct ata_port *ap, struct mv_port_priv *pp
 	}
 
 	if (work_done) {
-		ata_qc_complete_multiple(ap, ap->qc_active ^ done_mask);
+		ata_qc_complete_multiple(ap, ata_qc_get_active(ap) ^ done_mask);
 
 		/* Update the software queue position index in hardware */
 		writelfl((pp->crpb_dma & EDMA_RSP_Q_BASE_LO_MASK) |
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index f3e62f5528bd..eb9dc14e5147 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -984,7 +984,7 @@ static irqreturn_t nv_adma_interrupt(int irq, void *dev_instance)
 					check_commands = 0;
 				check_commands &= ~(1 << pos);
 			}
-			ata_qc_complete_multiple(ap, ap->qc_active ^ done_mask);
+			ata_qc_complete_multiple(ap, ata_qc_get_active(ap) ^ done_mask);
 		}
 	}
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index d3bbfddf616a..2dbde119721d 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1175,6 +1175,7 @@ extern unsigned int ata_do_dev_read_id(struct ata_device *dev,
 					struct ata_taskfile *tf, u16 *id);
 extern void ata_qc_complete(struct ata_queued_cmd *qc);
 extern int ata_qc_complete_multiple(struct ata_port *ap, u64 qc_active);
+extern u64 ata_qc_get_active(struct ata_port *ap);
 extern void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd);
 extern int ata_std_bios_param(struct scsi_device *sdev,
 			      struct block_device *bdev,
-- 
2.24.0

