Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D13CC5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42CAD21479
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEPH0U7U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfGBH7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 03:59:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37098 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfGBH7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 03:59:08 -0400
Received: by mail-pf1-f193.google.com with SMTP id 19so7864399pfa.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 00:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sU3v5ccebtOG4x5yZ5yy+8gNckKMnQQqua1s9PyanRk=;
        b=kEPH0U7UpWMoGhJeYxoN0CBYntMa7BSNbxRyRiy/0xsP83XPlropWxQ7GEJWw2AMI4
         ZKawp2s4rqyJbTuKQfa/Ie8/hUr+dGE8hLMbh56A7V+IHOtCc3SyHtxLVFN0905LKAvC
         cMwp89yze4bvdsTPKgeBTcPqw9MG6Dv347MHb6n+N+KYJJkkjjQlau4NoN7eJFm2j73F
         jngghs5SvcIPiKahczAzM7/0yIFudPLxai5GZeNO3mx7ECdbVPQ8aKfojgvekSFV2AbA
         YLd2g8FPpoEZbnFGwnwluCKGGzKc93DeOZK06f9L6myiz5c+P6bIUCDO5Bc70t86+LFF
         c6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sU3v5ccebtOG4x5yZ5yy+8gNckKMnQQqua1s9PyanRk=;
        b=mSh0CnF04mUPMhtsDf7OJw/YaayRt2G8WFv+m74cW4VcwvD1wSnHgKs4iEfBxR7lFW
         EmRTkhCIfYR/l6p4HvIetxbtxWdCJyvNCjLgqQ4AFJ0B25nKrFyI6B/Bj4hBFzEM7oiv
         lPf8uigzdbTgpS8AKcMx7cRcuIaLlMt5QOLOTFQWFnz37X7GeISvUExWYM/DwmMVO/Xy
         raO4pHjVRvS2+DXJlg5tQ4sSpRlW/jxlbBSkz7K0qBUqessfpOU4g6RxMf4pnfrdH1WK
         4ci6Ca8fKghQPiXLkug2LKZ85qMOslXyTs125tZvWzZqy49eKX6WCErkMxVIxfz6huYU
         5RGA==
X-Gm-Message-State: APjAAAWeFGzEdRAunO76OBvU8tReDs/GSF+zuj1DG5XtIBT+LUKm9otN
        wk7XdMFvGvtRtVYzW1FR7lSLeqgysBk=
X-Google-Smtp-Source: APXvYqzX/5jwOalW+CR0s5kZxpI1LSgDlDj9vN763nuYG1vxWtszdEmbH7OLql6DliJnmvmJsjXmtg==
X-Received: by 2002:a17:90a:1a8f:: with SMTP id p15mr4053084pjp.18.1562054347254;
        Tue, 02 Jul 2019 00:59:07 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id x128sm33678392pfd.17.2019.07.02.00.59.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 00:59:06 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3 18/27] scsi: use zeroing allocator rather than allocator followed by memset 0
Date:   Tue,  2 Jul 2019 15:59:02 +0800
Message-Id: <20190702075902.24352-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace allocator followed by memset with 0 with zeroing allocator.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v3:
  - Resend

 drivers/scsi/lpfc/lpfc_debugfs.c | 5 +----
 drivers/scsi/qedf/qedf_dbg.c     | 3 +--
 drivers/scsi/qla2xxx/qla_attr.c  | 7 ++-----
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index 1ee857d9d165..0dfac41f2fa8 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -6017,7 +6017,7 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 				 phba->hba_debugfs_root,
 				 phba, &lpfc_debugfs_op_slow_ring_trc);
 		if (!phba->slow_ring_trc) {
-			phba->slow_ring_trc = kmalloc(
+			phba->slow_ring_trc = kzalloc(
 				(sizeof(struct lpfc_debugfs_trc) *
 				lpfc_debugfs_max_slow_ring_trc),
 				GFP_KERNEL);
@@ -6028,9 +6028,6 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 				goto debug_failed;
 			}
 			atomic_set(&phba->slow_ring_trc_cnt, 0);
-			memset(phba->slow_ring_trc, 0,
-				(sizeof(struct lpfc_debugfs_trc) *
-				lpfc_debugfs_max_slow_ring_trc));
 		}
 
 		snprintf(name, sizeof(name), "nvmeio_trc");
diff --git a/drivers/scsi/qedf/qedf_dbg.c b/drivers/scsi/qedf/qedf_dbg.c
index e0387e495261..0d2aed82882a 100644
--- a/drivers/scsi/qedf/qedf_dbg.c
+++ b/drivers/scsi/qedf/qedf_dbg.c
@@ -106,11 +106,10 @@ qedf_dbg_info(struct qedf_dbg_ctx *qedf, const char *func, u32 line,
 int
 qedf_alloc_grc_dump_buf(u8 **buf, uint32_t len)
 {
-		*buf = vmalloc(len);
+		*buf = vzalloc(len);
 		if (!(*buf))
 			return -ENOMEM;
 
-		memset(*buf, 0, len);
 		return 0;
 }
 
diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_attr.c
index 8d560c562e9c..dabd139fdaeb 100644
--- a/drivers/scsi/qla2xxx/qla_attr.c
+++ b/drivers/scsi/qla2xxx/qla_attr.c
@@ -382,7 +382,7 @@ qla2x00_sysfs_write_optrom_ctl(struct file *filp, struct kobject *kobj,
 		ha->optrom_region_size = size;
 
 		ha->optrom_state = QLA_SREADING;
-		ha->optrom_buffer = vmalloc(ha->optrom_region_size);
+		ha->optrom_buffer = vzalloc(ha->optrom_region_size);
 		if (ha->optrom_buffer == NULL) {
 			ql_log(ql_log_warn, vha, 0x7062,
 			    "Unable to allocate memory for optrom retrieval "
@@ -404,7 +404,6 @@ qla2x00_sysfs_write_optrom_ctl(struct file *filp, struct kobject *kobj,
 		    "Reading flash region -- 0x%x/0x%x.\n",
 		    ha->optrom_region_start, ha->optrom_region_size);
 
-		memset(ha->optrom_buffer, 0, ha->optrom_region_size);
 		ha->isp_ops->read_optrom(vha, ha->optrom_buffer,
 		    ha->optrom_region_start, ha->optrom_region_size);
 		break;
@@ -457,7 +456,7 @@ qla2x00_sysfs_write_optrom_ctl(struct file *filp, struct kobject *kobj,
 		ha->optrom_region_size = size;
 
 		ha->optrom_state = QLA_SWRITING;
-		ha->optrom_buffer = vmalloc(ha->optrom_region_size);
+		ha->optrom_buffer = vzalloc(ha->optrom_region_size);
 		if (ha->optrom_buffer == NULL) {
 			ql_log(ql_log_warn, vha, 0x7066,
 			    "Unable to allocate memory for optrom update "
@@ -471,8 +470,6 @@ qla2x00_sysfs_write_optrom_ctl(struct file *filp, struct kobject *kobj,
 		ql_dbg(ql_dbg_user, vha, 0x7067,
 		    "Staging flash region write -- 0x%x/0x%x.\n",
 		    ha->optrom_region_start, ha->optrom_region_size);
-
-		memset(ha->optrom_buffer, 0, ha->optrom_region_size);
 		break;
 	case 3:
 		if (ha->optrom_state != QLA_SWRITING) {
-- 
2.11.0

