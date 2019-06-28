Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1542FC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 02:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8E72086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 02:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvCSLEHt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfF1Ct3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 22:49:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37684 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfF1Ct3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 22:49:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id 25so1901866pgy.4;
        Thu, 27 Jun 2019 19:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4C5R5TDz5kYfK5urhURKV4Q0K9ak9s1wycDaZJheC38=;
        b=GvCSLEHtZiEcR0GG9tSMeSuqnh1OSm+/hrURMzQ+UtBinq8LKrVWTNfDjzT0lOKTj5
         3C0wPIQBrjfl2gQEGrgr1hzds7RA7V98mJyacnN+85W+5PgOcVDiclc5ujKfYYA4Bl2+
         weitp4ZdNjhRqLF1hI5tFXhOgTh7yM7Q5JqiVBM82/7dcMOKAIRaGlSJPW4UnnByGlvV
         WDij43/BPNPJ1LLBIi6yJLYhPgN29dFjyOaY7MprTfyS/177Cfytsb3GC0a9izDRhAAX
         FvD8pRzxAu5FkKQ6ySbGp/so6AbgXQ3lbuRhoyp3BwwNHeUZ7KLBO2stL8dx8Yh6wD1C
         IUiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4C5R5TDz5kYfK5urhURKV4Q0K9ak9s1wycDaZJheC38=;
        b=SXM1kajuUPCZzmo8hi1J5YcOhU0Mzjjws0i9xlug5nZek3W6yfjn6nZp4D0Sm0gSXN
         LyB9eNBY4BQH8VqNq13nMr0G3SY9l5Fg/Mj5Tx0LysxCJTJmxWi3devu5l6T2mi1Zyu2
         BpOVcQlk5Nq9Wj8lYqW0WrT+wYuUyhQSmRCmeiA+NKXyRoMJ7BqRbh5L+5YRdRDn0CR4
         sptW1Se2e0t7KqgxhoJYGZxnoq5aQ1jCJbkmEpvwRQ0s6JdkJyLW4n0eYRJgLxX6y51m
         uzKyS1uzqtlf7huZXxX+NuKLgY6q3dZz6EglNgyKxe79WwL/DCBFDzalM2dzIh1XaYla
         0AhQ==
X-Gm-Message-State: APjAAAXjpSTi2rSlLkYzctCbL1VHFT9UHIHgZoDSb+V32LymU8VxPY2a
        u+PY7wbzTaAGnIhjHuYvCzw=
X-Google-Smtp-Source: APXvYqwWbU6whNOo/stsWH4IGL7RrRuUYv3RXVxPL/nwY8LBxjXls5w4AEbYJJDNldIRLDAKkpm+Pw==
X-Received: by 2002:a63:190d:: with SMTP id z13mr7040452pgl.191.1561690168538;
        Thu, 27 Jun 2019 19:49:28 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id u65sm10891072pjb.1.2019.06.27.19.49.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 19:49:28 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        QLogic-Storage-Upstream@cavium.com, qla2xxx-upstream@qlogic.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 18/27] scsi: use zeroing allocator rather than allocator followed by memset 0
Date:   Fri, 28 Jun 2019 10:49:21 +0800
Message-Id: <20190628024922.15754-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace allocator followed by memset with 0 with zeroing allocator.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
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

