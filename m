Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3C5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 793E62054F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257962;
	bh=QG0xvZfK12w2PsMBR9JOpmykI87HCpbrPESOPeF+tSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QxEdTxG9wyWPdX+IpIYk1s1qLbn6yXqR0uHgpMgVhi/6rlr5NzjKUrAfF7NA66SRO
	 WNTK9jkdc7IY1NaD64aNg52l1vY3tU0KnHiJJrDUFe5Aa0w+uy+Zpj9cqHWtcON2Ui
	 ttN/aUZW4TkIZ2p0KsDHYF4mtPOHl51635JroTpc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388952AbfCVMck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:32:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:54336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389432AbfCVMPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:15:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A0222083D;
        Fri, 22 Mar 2019 12:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256947;
        bh=QG0xvZfK12w2PsMBR9JOpmykI87HCpbrPESOPeF+tSM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cES33dXWKQrdFBpjweHDAtPIkQ70Emocw5iKYCQ3oMxe886B6V+2beXA2WprqCsd8
         WalhT9PPYdc41FbPzM8Ef6P6dxPW52zyhMcSScIhYHKLvT7HDS7CWSNtq1x+5mb8qH
         dqdrtwVzVAr2Rv4nPIoIX3ZqzJw4NZu4KIca7GXY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Giridhar Malavali <gmalavali@marvell.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.0 084/238] scsi: qla2xxx: Avoid PCI IRQ affinity mapping when multiqueue is not supported
Date:   Fri, 22 Mar 2019 12:15:03 +0100
Message-Id: <20190322111303.543680685@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Giridhar Malavali <gmalavali@marvell.com>

commit f3e026951771bceb17319a4d0d6121ca58746c88 upstream.

This patch fixes warning seen when BLK-MQ is enabled and hardware does not
support MQ. This will result into driver requesting MSIx vectors which are
equal or less than pre_desc via PCI IRQ Affinity infrastructure.

    [   19.746300] qla2xxx [0000:00:00.0]-0005: : QLogic Fibre Channel HBA Driver: 10.00.00.12-k.
    [   19.746599] qla2xxx [0000:02:00.0]-001d: : Found an ISP2432 irq 18 iobase 0x(____ptrval____).
    [   20.203186] ------------[ cut here ]------------
    [   20.203306] WARNING: CPU: 8 PID: 268 at drivers/pci/msi.c:1273 pci_irq_get_affinity+0xf4/0x120
    [   20.203481] Modules linked in: tg3 ptp qla2xxx(+) pps_core sg libphy scsi_transport_fc flash loop autofs4
    [   20.203700] CPU: 8 PID: 268 Comm: systemd-udevd Not tainted 5.0.0-rc5-00358-gdf3865f #113
    [   20.203830] Call Trace:
    [   20.203933]  [0000000000461bb0] __warn+0xb0/0xe0
    [   20.204090]  [00000000006c8f34] pci_irq_get_affinity+0xf4/0x120
    [   20.204219]  [000000000068c764] blk_mq_pci_map_queues+0x24/0x120
    [   20.204396]  [00000000007162f4] scsi_map_queues+0x14/0x40
    [   20.204626]  [0000000000673654] blk_mq_update_queue_map+0x94/0xe0
    [   20.204698]  [0000000000676ce0] blk_mq_alloc_tag_set+0x120/0x300
    [   20.204869]  [000000000071077c] scsi_add_host_with_dma+0x7c/0x300
    [   20.205419]  [00000000100ead54] qla2x00_probe_one+0x19d4/0x2640 [qla2xxx]
    [   20.205621]  [00000000006b3c88] pci_device_probe+0xc8/0x160
    [   20.205697]  [0000000000701c0c] really_probe+0x1ac/0x2e0
    [   20.205770]  [0000000000701f90] driver_probe_device+0x50/0x100
    [   20.205843]  [0000000000702134] __driver_attach+0xf4/0x120
    [   20.205913]  [0000000000700644] bus_for_each_dev+0x44/0x80
    [   20.206081]  [0000000000700c98] bus_add_driver+0x198/0x220
    [   20.206300]  [0000000000702950] driver_register+0x70/0x120
    [   20.206582]  [0000000010248224] qla2x00_module_init+0x224/0x284 [qla2xxx]
    [   20.206857] ---[ end trace b1de7a3f79fab2c2 ]---

The fix is to check if the hardware does not have Multi Queue capabiltiy,
use pci_alloc_irq_vectors() call instead of pci_alloc_irq_affinity().

Fixes: f664a3cc17b7d ("scsi: kill off the legacy IO path")
Cc: stable@vger.kernel.org #4.19
Signed-off-by: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_isr.c |    2 +-
 drivers/scsi/qla2xxx/qla_os.c  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -3410,7 +3410,7 @@ qla24xx_enable_msix(struct qla_hw_data *
 		min_vecs++;
 	}
 
-	if (USER_CTRL_IRQ(ha)) {
+	if (USER_CTRL_IRQ(ha) || !ha->mqiobase) {
 		/* user wants to control IRQ setting for target mode */
 		ret = pci_alloc_irq_vectors(ha->pdev, min_vecs,
 		    ha->msix_count, PCI_IRQ_MSIX);
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -6936,7 +6936,7 @@ static int qla2xxx_map_queues(struct Scs
 	scsi_qla_host_t *vha = (scsi_qla_host_t *)shost->hostdata;
 	struct blk_mq_queue_map *qmap = &shost->tag_set.map[0];
 
-	if (USER_CTRL_IRQ(vha->hw))
+	if (USER_CTRL_IRQ(vha->hw) || !vha->hw->mqiobase)
 		rc = blk_mq_map_queues(qmap);
 	else
 		rc = blk_mq_pci_map_queues(qmap, vha->hw->pdev, vha->irq_offset);


