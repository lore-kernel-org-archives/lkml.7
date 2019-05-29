Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1132AC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7F6208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfE2KAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 06:00:24 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57488 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725894AbfE2KAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 06:00:21 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 873DAA6CDEC2254E07E;
        Wed, 29 May 2019 18:00:18 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Wed, 29 May 2019 18:00:11 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, John Garry <john.garry@huawei.com>,
        "dann frazier" <dann.frazier@canonical.com>
Subject: [PATCH 3/6] scsi: hisi_sas: Reduce HISI_SAS_SGE_PAGE_CNT in size
Date:   Wed, 29 May 2019 17:58:44 +0800
Message-ID: <1559123927-160502-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1559123927-160502-1-git-send-email-john.garry@huawei.com>
References: <1559123927-160502-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Macro HISI_SAS_SGE_PAGE_CNT is defined to SG_CHUNK_SIZE, which is
128.

This means that sizeof(struct hisi_sas_slot_buf_table) is 4192. This is
just over a 4K, which can mean inefficient DMA memory usage (for no PI).

Reduce the size of HISI_SAS_SGE_PAGE_CNT to 124 to fit in a 4K page. With
this change, we experience no performance hit.

Cc: dann frazier <dann.frazier@canonical.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index fc87994b5d73..06f22fb372b1 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -484,12 +484,12 @@ struct hisi_sas_command_table_stp {
 	u8	atapi_cdb[ATAPI_CDB_LEN];
 };
 
-#define HISI_SAS_SGE_PAGE_CNT SG_CHUNK_SIZE
+#define HISI_SAS_SGE_PAGE_CNT (124)
 struct hisi_sas_sge_page {
 	struct hisi_sas_sge sge[HISI_SAS_SGE_PAGE_CNT];
 }  __aligned(16);
 
-#define HISI_SAS_SGE_DIF_PAGE_CNT   SG_CHUNK_SIZE
+#define HISI_SAS_SGE_DIF_PAGE_CNT   HISI_SAS_SGE_PAGE_CNT
 struct hisi_sas_sge_dif_page {
 	struct hisi_sas_sge sge[HISI_SAS_SGE_DIF_PAGE_CNT];
 }  __aligned(16);
-- 
2.17.1

