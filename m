Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2711C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 820ED2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbfHENuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:50:21 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34658 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728815AbfHENuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:50:20 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E507AC09D589F8D79A86;
        Mon,  5 Aug 2019 21:50:18 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 5 Aug 2019 21:50:12 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, Luo Jiaxing <luojiaxing@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 03/15] scsi: hisi_sas: Fix pointer usage error in show debugfs IOST/ITCT
Date:   Mon, 5 Aug 2019 21:48:00 +0800
Message-ID: <1565012892-75940-4-git-send-email-john.garry@huawei.com>
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

Fix how the pointer is set in hisi_sas_debugfs_iost_show() and
hisi_sas_debugfs_itct_show().

Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 54bbab7151c7..325ec4306794 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -2992,9 +2992,10 @@ static int hisi_sas_debugfs_iost_show(struct seq_file *s, void *p)
 	struct hisi_hba *hisi_hba = s->private;
 	struct hisi_sas_iost *debugfs_iost = hisi_hba->debugfs_iost;
 	int i, ret, max_command_entries = HISI_SAS_MAX_COMMANDS;
-	__le64 *iost = &debugfs_iost->qw0;
 
 	for (i = 0; i < max_command_entries; i++, debugfs_iost++) {
+		__le64 *iost = &debugfs_iost->qw0;
+
 		ret = hisi_sas_show_row_64(s, i, sizeof(*debugfs_iost),
 					   iost);
 		if (ret)
@@ -3022,9 +3023,10 @@ static int hisi_sas_debugfs_itct_show(struct seq_file *s, void *p)
 	int i, ret;
 	struct hisi_hba *hisi_hba = s->private;
 	struct hisi_sas_itct *debugfs_itct = hisi_hba->debugfs_itct;
-	__le64 *itct = &debugfs_itct->qw0;
 
 	for (i = 0; i < HISI_SAS_MAX_ITCT_ENTRIES; i++, debugfs_itct++) {
+		__le64 *itct = &debugfs_itct->qw0;
+
 		ret = hisi_sas_show_row_64(s, i, sizeof(*debugfs_itct),
 					   itct);
 		if (ret)
-- 
2.17.1

