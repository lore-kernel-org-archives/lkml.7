Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A601C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36FA420644
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsj5Mqv5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfF0RnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:43:15 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39457 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfF0RnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:43:13 -0400
Received: by mail-pl1-f193.google.com with SMTP id b7so1676316pls.6;
        Thu, 27 Jun 2019 10:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AxIMu4BJ+ITDn4HqQxvZfXnYWuXpvemPdfghlXEyazU=;
        b=gsj5Mqv5FWgw2C8ZSbqPk4d3GPDt6a75jDCmFUt0ohXVM0ntKg46pDsV5+kfDd9Ntn
         1H5qWukGYQd+BQLzJkqij2QH29ZPTGjXw9Kqghol5YjjZQW0Q+joWN6WFrRUyQyCbEUN
         O/4NJ7XR4kb+564XUAt0q+MHqHjOMyMdANVXTQzg+/am43cgpNirltYbrH0hfYuDlusI
         o3+tAJovmDfLVeaftXXCHCAH1HBCc7x+Fw2vnTEUhayojJSnwXlP/xSLn6JrOykz7Omp
         25G6M8Zwffl33Hn5bF50Rc6oLrXeLw6cV01HxPAH0WR3EbNIAqZA6q6c8jwAhQAv2DuO
         NAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AxIMu4BJ+ITDn4HqQxvZfXnYWuXpvemPdfghlXEyazU=;
        b=BYo/oVwXez3qwe2QqnVzIwUzlsln4cIMJY1yPNUVKcjCXSpSXPKfot3sK356EcHvXe
         v2GDDJMDjKq/o8eY7vznSDAEtEX1kxVS65bfveQCdp0JsREnbayoHVHORrNuM9tQ5CW9
         I22xte6ECIhC5BEL+TkECutII3uRLTsE7hGq639ZjpJnGaSjxPXuF/pTxqrXEyytvo1h
         Qul3SiXMxvBQO5iYYQKxVUwoayIz+tVH4eDgihnKRdp1x4OkjKPr3bJY/YuUbK3p4UcN
         MkmxJSxbieNDpKiIlfvDFsDqciEwJ9FKW23+R21pz3Bxruxpnh6Y9Q9OsfKoWEWfQHwP
         vdOw==
X-Gm-Message-State: APjAAAUodaUAmo4EkufBSjnzfjPEJrx7VF426G8fblRHSUqCpM5we42X
        QOr3yEGTmmM7YyBESbQQ8Yc=
X-Google-Smtp-Source: APXvYqzNcFy5ilWx3mzo+KyhctxCrbf7SIbTOd01OLd8mmkxsuA3dBHq+4kMjsNAcZRLB7aYDxob6A==
X-Received: by 2002:a17:902:20c8:: with SMTP id v8mr6040367plg.284.1561657392653;
        Thu, 27 Jun 2019 10:43:12 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id k6sm3490852pfi.12.2019.06.27.10.43.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:43:12 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        qla2xxx-upstream@qlogic.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 54/87] scsi: qla2xxx: replace vmalloc and memset with vzalloc
Date:   Fri, 28 Jun 2019 01:43:04 +0800
Message-Id: <20190627174304.4936-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmalloc + memset(0) -> vzalloc

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/scsi/qla2xxx/qla_attr.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

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

