Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD36C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF6624292
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfFCJXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:23:14 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18071 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726684AbfFCJXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:23:13 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A676135D6334608C5412;
        Mon,  3 Jun 2019 17:23:11 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Mon, 3 Jun 2019
 17:23:03 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <martin.petersen@oracle.com>, <jejb@linux.ibm.com>, <hare@suse.de>,
        <sedat.dilek@gmail.com>, <jth@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] scsi: fcoe: Fix possible memleak in fcoe_if_init
Date:   Mon, 3 Jun 2019 17:22:18 +0800
Message-ID: <20190603092218.15064-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If it fails to alloc fcoe_vport_scsi_transport in fcoe_if_init,
we should check the err and free allocted fcoe_nport_scsi_transport.
Also return ENOMEM instead of ENODEV.

Fixes: 8ca86f84dd5f ("[SCSI] fcoe: prepare fcoe for using fcoe transport")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/scsi/fcoe/fcoe.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/fcoe/fcoe.c b/drivers/scsi/fcoe/fcoe.c
index 8ba8862..12ca0b7 100644
--- a/drivers/scsi/fcoe/fcoe.c
+++ b/drivers/scsi/fcoe/fcoe.c
@@ -1262,12 +1262,17 @@ static int __init fcoe_if_init(void)
 	/* attach to scsi transport */
 	fcoe_nport_scsi_transport =
 		fc_attach_transport(&fcoe_nport_fc_functions);
+	if (!fcoe_nport_scsi_transport)
+		return -ENOMEM;
+
 	fcoe_vport_scsi_transport =
 		fc_attach_transport(&fcoe_vport_fc_functions);
 
-	if (!fcoe_nport_scsi_transport) {
-		printk(KERN_ERR "fcoe: Failed to attach to the FC transport\n");
-		return -ENODEV;
+	if (!fcoe_vport_scsi_transport) {
+		pr_err("fcoe: Failed to attach to the FC transport\n");
+		fc_release_transport(fcoe_nport_scsi_transport);
+		fcoe_nport_scsi_transport = NULL;
+		return -ENOMEM;
 	}
 
 	return 0;
-- 
1.8.3.1


