Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E032C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66DAD20856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730801AbfDBLtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 07:49:17 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6212 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726903AbfDBLtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 07:49:16 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [10.3.19.209])
        by Forcepoint Email with ESMTP id 88C49794F1B78C7F4759;
        Tue,  2 Apr 2019 19:49:09 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Tue, 2 Apr 2019
 19:48:59 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <linux-ide@vger.kernel.org>, <tj@kernel.org>, <axboe@kernel.dk>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] ata: ahci: fix race between EH and ahci interrupt
Date:   Tue, 2 Apr 2019 20:06:42 +0800
Message-ID: <20190402120642.9274-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a race condition between EH and ahci interrupt when the EH is
interrupted after the ata port is thaw by the ahci interrupt. In the
ahci interrupt callback the port will be frozen again but the EH thread
will not be scheduled because it is already running.

[interrupt]                             [scsi_eh]
ahci_error_intr                         scsi_error_handler
  =>ata_port_freeze
  =>ahci_freeze (turn IRQ off)
  =>ata_port_abort
    =>ata_port_schedule_eh
      =>host_eh_scheduled++;
	host_eh_scheduled = 1
    =>scsi_eh_wakeup
					 =>ata_scsi_error
					 =>ata_eh_thaw_port
					   =>ahci_thaw (turn IRQ on)
ahci_error_intr
  =>ata_port_freeze
  =>ahci_freeze (turn IRQ off)
  =>ata_port_abort
    =>ata_port_schedule_eh
      =>host_eh_scheduled++;
	host_eh_scheduled = 2
      =>EH already running
					 =>ata_std_end_eh
					   =>host_eh_scheduled = 0;
					 =>EH over, IRQ remain off

The host_eh_scheduled is 0 and scsi EH thread will not be scheduled again,
and the ata port remain freeze and will never be enabled. If EH thread is
already running, no need to freeze port and schedule EH again.

Reported-by: luojian <luojian5@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/ata/libahci.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 692782dddc0f..cba0f5dcb36f 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1805,9 +1805,15 @@ static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
 
 	/* okay, let's hand over to EH */
 
-	if (irq_stat & PORT_IRQ_FREEZE)
+	if (irq_stat & PORT_IRQ_FREEZE) {
+		/*
+		 * EH already running, this may happen if the port is thawed in the EH.
+		 * But we cannot freeze it again otherwise the port will never be thawed.
+		 */
+		if (ap->pflags & (ATA_PFLAG_EH_PENDING | ATA_PFLAG_EH_IN_PROGRESS))
+			return;
 		ata_port_freeze(ap);
-	else if (fbs_need_dec) {
+	} else if (fbs_need_dec) {
 		ata_link_abort(link);
 		ahci_fbs_dec_intr(ap);
 	} else
-- 
2.17.2

