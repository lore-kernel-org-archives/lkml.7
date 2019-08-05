Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B623DC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 923702086D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbfHENvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:51:04 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44546 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729747AbfHENu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:50:27 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 174B5C4A8622A0199C17;
        Mon,  5 Aug 2019 21:50:24 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 5 Aug 2019 21:50:14 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, Luo Jiaxing <luojiaxing@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 12/15] scsi: hisi_sas: Modify return type of debugfs functions
Date:   Mon, 5 Aug 2019 21:48:09 +0800
Message-ID: <1565012892-75940-13-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1565012892-75940-1-git-send-email-john.garry@huawei.com>
References: <1565012892-75940-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luo Jiaxing <luojiaxing@huawei.com>

For functions which always return 0, which is never checked, make to return
void.

Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 51 ++++++++++-----------------
 1 file changed, 18 insertions(+), 33 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index a2255701b50b..be15280343d1 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -2956,8 +2956,8 @@ static const struct file_operations hisi_sas_debugfs_port_fops = {
 	.owner = THIS_MODULE,
 };
 
-static int hisi_sas_show_row_64(struct seq_file *s, int index,
-				int sz, __le64 *ptr)
+static void hisi_sas_show_row_64(struct seq_file *s, int index,
+				 int sz, __le64 *ptr)
 {
 	int i;
 
@@ -2970,12 +2970,10 @@ static int hisi_sas_show_row_64(struct seq_file *s, int index,
 	}
 
 	seq_puts(s, "\n");
-
-	return 0;
 }
 
-static int hisi_sas_show_row_32(struct seq_file *s, int index,
-				int sz, __le32 *ptr)
+static void hisi_sas_show_row_32(struct seq_file *s, int index,
+				 int sz, __le32 *ptr)
 {
 	int i;
 
@@ -2987,11 +2985,9 @@ static int hisi_sas_show_row_32(struct seq_file *s, int index,
 			seq_puts(s, "\n\t");
 	}
 	seq_puts(s, "\n");
-
-	return 0;
 }
 
-static int hisi_sas_cq_show_slot(struct seq_file *s, int slot, void *cq_ptr)
+static void hisi_sas_cq_show_slot(struct seq_file *s, int slot, void *cq_ptr)
 {
 	struct hisi_sas_cq *cq = cq_ptr;
 	struct hisi_hba *hisi_hba = cq->hisi_hba;
@@ -2999,20 +2995,18 @@ static int hisi_sas_cq_show_slot(struct seq_file *s, int slot, void *cq_ptr)
 	__le32 *complete_hdr = complete_queue +
 			(hisi_hba->hw->complete_hdr_size * slot);
 
-	return hisi_sas_show_row_32(s, slot,
-				hisi_hba->hw->complete_hdr_size,
-				complete_hdr);
+	hisi_sas_show_row_32(s, slot,
+			     hisi_hba->hw->complete_hdr_size,
+			     complete_hdr);
 }
 
 static int hisi_sas_debugfs_cq_show(struct seq_file *s, void *p)
 {
 	struct hisi_sas_cq *cq = s->private;
-	int slot, ret;
+	int slot;
 
 	for (slot = 0; slot < HISI_SAS_QUEUE_SLOTS; slot++) {
-		ret = hisi_sas_cq_show_slot(s, slot, cq);
-		if (ret)
-			return ret;
+		hisi_sas_cq_show_slot(s, slot, cq);
 	}
 	return 0;
 }
@@ -3030,7 +3024,7 @@ static const struct file_operations hisi_sas_debugfs_cq_fops = {
 	.owner = THIS_MODULE,
 };
 
-static int hisi_sas_dq_show_slot(struct seq_file *s, int slot, void *dq_ptr)
+static void hisi_sas_dq_show_slot(struct seq_file *s, int slot, void *dq_ptr)
 {
 	struct hisi_sas_dq *dq = dq_ptr;
 	struct hisi_hba *hisi_hba = dq->hisi_hba;
@@ -3038,18 +3032,15 @@ static int hisi_sas_dq_show_slot(struct seq_file *s, int slot, void *dq_ptr)
 	__le32 *cmd_hdr = cmd_queue +
 		sizeof(struct hisi_sas_cmd_hdr) * slot;
 
-	return hisi_sas_show_row_32(s, slot, sizeof(struct hisi_sas_cmd_hdr),
-				    cmd_hdr);
+	hisi_sas_show_row_32(s, slot, sizeof(struct hisi_sas_cmd_hdr), cmd_hdr);
 }
 
 static int hisi_sas_debugfs_dq_show(struct seq_file *s, void *p)
 {
-	int slot, ret;
+	int slot;
 
 	for (slot = 0; slot < HISI_SAS_QUEUE_SLOTS; slot++) {
-		ret = hisi_sas_dq_show_slot(s, slot, s->private);
-		if (ret)
-			return ret;
+		hisi_sas_dq_show_slot(s, slot, s->private);
 	}
 	return 0;
 }
@@ -3071,15 +3062,12 @@ static int hisi_sas_debugfs_iost_show(struct seq_file *s, void *p)
 {
 	struct hisi_hba *hisi_hba = s->private;
 	struct hisi_sas_iost *debugfs_iost = hisi_hba->debugfs_iost;
-	int i, ret, max_command_entries = HISI_SAS_MAX_COMMANDS;
+	int i, max_command_entries = HISI_SAS_MAX_COMMANDS;
 
 	for (i = 0; i < max_command_entries; i++, debugfs_iost++) {
 		__le64 *iost = &debugfs_iost->qw0;
 
-		ret = hisi_sas_show_row_64(s, i, sizeof(*debugfs_iost),
-					   iost);
-		if (ret)
-			return ret;
+		hisi_sas_show_row_64(s, i, sizeof(*debugfs_iost), iost);
 	}
 
 	return 0;
@@ -3140,17 +3128,14 @@ static const struct file_operations hisi_sas_debugfs_iost_cache_fops = {
 
 static int hisi_sas_debugfs_itct_show(struct seq_file *s, void *p)
 {
-	int i, ret;
+	int i;
 	struct hisi_hba *hisi_hba = s->private;
 	struct hisi_sas_itct *debugfs_itct = hisi_hba->debugfs_itct;
 
 	for (i = 0; i < HISI_SAS_MAX_ITCT_ENTRIES; i++, debugfs_itct++) {
 		__le64 *itct = &debugfs_itct->qw0;
 
-		ret = hisi_sas_show_row_64(s, i, sizeof(*debugfs_itct),
-					   itct);
-		if (ret)
-			return ret;
+		hisi_sas_show_row_64(s, i, sizeof(*debugfs_itct), itct);
 	}
 
 	return 0;
-- 
2.17.1

