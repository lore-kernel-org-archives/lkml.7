Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03ACC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E6C20645
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfDWOmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:42:24 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38734 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727703AbfDWOmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:42:23 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6086C9C0BC83A1EB381D;
        Tue, 23 Apr 2019 22:42:16 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Tue, 23 Apr 2019
 22:42:05 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <QLogic-Storage-Upstream@cavium.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] scsi: qedf: remove set but not used variables
Date:   Tue, 23 Apr 2019 22:41:38 +0800
Message-ID: <20190423144138.20428-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Fixes gcc '-Wunused-but-set-variable' warnings:

drivers/scsi/qedf/qedf_els.c: In function 'qedf_process_els_compl':
drivers/scsi/qedf/qedf_els.c:149:20: warning: variable 'sc_cmd' set but not used [-Wunused-but-set-variable]
drivers/scsi/qedf/qedf_els.c:148:28: warning: variable 'task_ctx' set but not used [-Wunused-but-set-variable]
drivers/scsi/qedf/qedf_els.c: In function 'qedf_send_srr':
drivers/scsi/qedf/qedf_els.c:612:6: warning: variable 'sid' set but not used [-Wunused-but-set-variable]

They are never used since introduction.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/scsi/qedf/qedf_els.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/scsi/qedf/qedf_els.c b/drivers/scsi/qedf/qedf_els.c
index 1781e73..d900c89e 100644
--- a/drivers/scsi/qedf/qedf_els.c
+++ b/drivers/scsi/qedf/qedf_els.c
@@ -145,9 +145,6 @@ static int qedf_initiate_els(struct qedf_rport *fcport, unsigned int op,
 void qedf_process_els_compl(struct qedf_ctx *qedf, struct fcoe_cqe *cqe,
 	struct qedf_ioreq *els_req)
 {
-	struct fcoe_task_context *task_ctx;
-	struct scsi_cmnd *sc_cmd;
-	uint16_t xid;
 	struct fcoe_cqe_midpath_info *mp_info;
 
 	QEDF_INFO(&(qedf->dbg_ctx), QEDF_LOG_ELS, "Entered with xid = 0x%x"
@@ -158,10 +155,6 @@ void qedf_process_els_compl(struct qedf_ctx *qedf, struct fcoe_cqe *cqe,
 	/* Kill the ELS timer */
 	cancel_delayed_work(&els_req->timeout_work);
 
-	xid = els_req->xid;
-	task_ctx = qedf_get_task_mem(&qedf->tasks, xid);
-	sc_cmd = els_req->sc_cmd;
-
 	/* Get ELS response length from CQE */
 	mp_info = &cqe->cqe_info.midpath_info;
 	els_req->mp_req.resp_len = mp_info->data_placement_size;
@@ -609,7 +602,7 @@ static int qedf_send_srr(struct qedf_ioreq *orig_io_req, u32 offset, u8 r_ctl)
 	struct qedf_rport *fcport;
 	struct fc_lport *lport;
 	struct qedf_els_cb_arg *cb_arg = NULL;
-	u32 sid, r_a_tov;
+	u32 r_a_tov;
 	int rc;
 
 	if (!orig_io_req) {
@@ -635,7 +628,6 @@ static int qedf_send_srr(struct qedf_ioreq *orig_io_req, u32 offset, u8 r_ctl)
 
 	qedf = fcport->qedf;
 	lport = qedf->lport;
-	sid = fcport->sid;
 	r_a_tov = lport->r_a_tov;
 
 	QEDF_INFO(&(qedf->dbg_ctx), QEDF_LOG_ELS, "Sending SRR orig_io=%p, "
-- 
2.7.0


