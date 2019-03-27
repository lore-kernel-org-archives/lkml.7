Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E80CC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D725217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388993AbfC0SLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:11:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43650 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388972AbfC0SLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:11:08 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1h9D0x-0003vf-Jq; Wed, 27 Mar 2019 18:11:03 +0000
From:   Colin King <colin.king@canonical.com>
To:     QLogic-Storage-Upstream@cavium.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: qedi: remove declaration of nvm_image from stack
Date:   Wed, 27 Mar 2019 18:11:03 +0000
Message-Id: <20190327181103.15677-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The nvm_image is a large struct qedi_nvm_iscsi_image object of
over 24K so don't declare it on the stack just for a sizeof
requirement; use sizeof on struct qedi_nvm_iscsi_image instead.

Fixes: c77a2fa3ff8f ("scsi: qedi: Add the CRC size within iSCSI NVM image")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/qedi/qedi_main.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index e74a62448ba4..e5db9a9954dc 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -1392,10 +1392,8 @@ static void qedi_free_nvm_iscsi_cfg(struct qedi_ctx *qedi)
 
 static int qedi_alloc_nvm_iscsi_cfg(struct qedi_ctx *qedi)
 {
-	struct qedi_nvm_iscsi_image nvm_image;
-
 	qedi->iscsi_image = dma_alloc_coherent(&qedi->pdev->dev,
-					       sizeof(nvm_image),
+					       sizeof(struct qedi_nvm_iscsi_image),
 					       &qedi->nvm_buf_dma, GFP_KERNEL);
 	if (!qedi->iscsi_image) {
 		QEDI_ERR(&qedi->dbg_ctx, "Could not allocate NVM BUF.\n");
@@ -2236,14 +2234,13 @@ static void qedi_boot_release(void *data)
 static int qedi_get_boot_info(struct qedi_ctx *qedi)
 {
 	int ret = 1;
-	struct qedi_nvm_iscsi_image nvm_image;
 
 	QEDI_INFO(&qedi->dbg_ctx, QEDI_LOG_INFO,
 		  "Get NVM iSCSI CFG image\n");
 	ret = qedi_ops->common->nvm_get_image(qedi->cdev,
 					      QED_NVM_IMAGE_ISCSI_CFG,
 					      (char *)qedi->iscsi_image,
-					      sizeof(nvm_image));
+					      sizeof(struct qedi_nvm_iscsi_image));
 	if (ret)
 		QEDI_ERR(&qedi->dbg_ctx,
 			 "Could not get NVM image. ret = %d\n", ret);
-- 
2.20.1

