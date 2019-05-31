Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DBDC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8DCE26B91
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfEaP3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 11:29:30 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17640 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726421AbfEaP33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 11:29:29 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7764E844F282E0077772;
        Fri, 31 May 2019 23:29:26 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Fri, 31 May 2019
 23:29:20 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <james.smart@broadcom.com>, <dick.kennedy@broadcom.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jsmart2021@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] scsi: lpfc: Make some symbols static
Date:   Fri, 31 May 2019 23:28:41 +0800
Message-ID: <20190531152841.13684-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warnings:

drivers/scsi/lpfc/lpfc_sli.c:115:1: warning: symbol 'lpfc_sli4_pcimem_bcopy' was not declared. Should it be static?
drivers/scsi/lpfc/lpfc_sli.c:7854:1: warning: symbol 'lpfc_sli4_process_missed_mbox_completions' was not declared. Should it be static?
drivers/scsi/lpfc/lpfc_nvmet.c:223:27: warning: symbol 'lpfc_nvmet_get_ctx_for_xri' was not declared. Should it be static?
drivers/scsi/lpfc/lpfc_nvmet.c:245:27: warning: symbol 'lpfc_nvmet_get_ctx_for_oxid' was not declared. Should it be static?
drivers/scsi/lpfc/lpfc_init.c:75:10: warning: symbol 'lpfc_present_cpu' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/scsi/lpfc/lpfc_init.c  | 2 +-
 drivers/scsi/lpfc/lpfc_nvmet.c | 4 ++--
 drivers/scsi/lpfc/lpfc_sli.c   | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index cd8e47544d07..faf43b1d3dbe 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -72,7 +72,7 @@ unsigned long _dump_buf_dif_order;
 spinlock_t _dump_buf_lock;
 
 /* Used when mapping IRQ vectors in a driver centric manner */
-uint32_t lpfc_present_cpu;
+static uint32_t lpfc_present_cpu;
 
 static void lpfc_get_hba_model_desc(struct lpfc_hba *, uint8_t *, uint8_t *);
 static int lpfc_post_rcv_buf(struct lpfc_hba *);
diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index eb93189f4544..e471bbcca838 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -220,7 +220,7 @@ lpfc_nvmet_cmd_template(void)
 	/* Word 12, 13, 14, 15 - is zero */
 }
 
-struct lpfc_nvmet_rcv_ctx *
+static struct lpfc_nvmet_rcv_ctx *
 lpfc_nvmet_get_ctx_for_xri(struct lpfc_hba *phba, u16 xri)
 {
 	struct lpfc_nvmet_rcv_ctx *ctxp;
@@ -242,7 +242,7 @@ lpfc_nvmet_get_ctx_for_xri(struct lpfc_hba *phba, u16 xri)
 	return NULL;
 }
 
-struct lpfc_nvmet_rcv_ctx *
+static struct lpfc_nvmet_rcv_ctx *
 lpfc_nvmet_get_ctx_for_oxid(struct lpfc_hba *phba, u16 oxid, u32 sid)
 {
 	struct lpfc_nvmet_rcv_ctx *ctxp;
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 081c4357958e..dea8b9df27c0 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -108,7 +108,7 @@ lpfc_get_iocb_from_iocbq(struct lpfc_iocbq *iocbq)
  * endianness. This function can be called with or without
  * lock.
  **/
-void
+static void
 lpfc_sli4_pcimem_bcopy(void *srcp, void *destp, uint32_t cnt)
 {
 	uint64_t *src = srcp;
@@ -7882,7 +7882,7 @@ lpfc_sli4_mbox_completions_pending(struct lpfc_hba *phba)
  * and will process all the completions associated with the eq for the
  * mailbox completion queue.
  **/
-bool
+static bool
 lpfc_sli4_process_missed_mbox_completions(struct lpfc_hba *phba)
 {
 	struct lpfc_sli4_hba *sli4_hba = &phba->sli4_hba;
-- 
2.17.1


