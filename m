Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96441C282E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 00:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AFCD2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 00:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfE0A7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 20:59:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45078 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbfE0A7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 20:59:54 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 275A330842B1;
        Mon, 27 May 2019 00:59:51 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-83.pek2.redhat.com [10.72.12.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A5EE960477;
        Mon, 27 May 2019 00:59:40 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     don.brace@microsemi.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        esc.storagedev@microsemi.com, Thomas.Lendacky@amd.com,
        dyoung@redhat.com
Subject: [PATCH v2] scsi: smartpqi: properly set both the DMA mask and the coherent DMA mask in pqi_pci_init()
Date:   Mon, 27 May 2019 08:59:34 +0800
Message-Id: <20190527005934.1493-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 27 May 2019 00:59:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When SME is enabled, the smartpqi driver won't work on the HP DL385
G10 machine, which causes the failure of kernel boot because it fails
to allocate pqi error buffer. Please refer to the kernel log:
....
[    9.431749] usbcore: registered new interface driver uas
[    9.441524] Microsemi PQI Driver (v1.1.4-130)
[    9.442956] i40e 0000:04:00.0: fw 6.70.48768 api 1.7 nvm 10.2.5
[    9.447237] smartpqi 0000:23:00.0: Microsemi Smart Family Controller found
         Starting dracut initqueue hook...
[  OK  ] Started Show Plymouth Boot Scre[    9.471654] Broadcom NetXtreme-C/E driver bnxt_en v1.9.1
en.
[  OK  ] Started Forward Password Requests to Plymouth Directory Watch.
[[0;[    9.487108] smartpqi 0000:23:00.0: failed to allocate PQI error buffer
....
[  139.050544] dracut-initqueue[949]: Warning: dracut-initqueue timeout - starting timeout scripts
[  139.589779] dracut-initqueue[949]: Warning: dracut-initqueue timeout - starting timeout scripts

Basically, the fact that the coherent DMA mask value wasn't set caused
the driver to fall back to SWIOTLB when SME is active.

For correct operation, lets call the dma_set_mask_and_coherent() to
properly set the mask for both streaming and coherent, in order to
inform the kernel about the devices DMA addressing capabilities.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
Acked-by: Don Brace <don.brace@microsemi.com>
Tested-by: Don Brace <don.brace@microsemi.com>
---
Changes since v1:
1. Add the extra description suggested by Tom to patch log.
2. Add Don's Acked-by and Tested-by to the commit. 

 drivers/scsi/smartpqi/smartpqi_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index c26cac819f9e..8b1fde6c7dab 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -7282,7 +7282,7 @@ static int pqi_pci_init(struct pqi_ctrl_info *ctrl_info)
 	else
 		mask = DMA_BIT_MASK(32);
 
-	rc = dma_set_mask(&ctrl_info->pci_dev->dev, mask);
+	rc = dma_set_mask_and_coherent(&ctrl_info->pci_dev->dev, mask);
 	if (rc) {
 		dev_err(&ctrl_info->pci_dev->dev, "failed to set DMA mask\n");
 		goto disable_device;
-- 
2.17.1

