Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACAFC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 401DB2184E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfDKMr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:47:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6727 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726656AbfDKMr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 08:47:29 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9EA6360F8D3040CCEE90;
        Thu, 11 Apr 2019 20:47:24 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Thu, 11 Apr 2019 20:47:18 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 1/9] scsi: hisi_sas: add host reset interface for test
Date:   Thu, 11 Apr 2019 20:46:36 +0800
Message-ID: <1554986804-233706-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1554986804-233706-1-git-send-email-john.garry@huawei.com>
References: <1554986804-233706-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

Add host reset interface to make it easier for testing the host
reset feature.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 13 +++++++++++++
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |  1 +
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |  1 +
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  1 +
 4 files changed, 16 insertions(+)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 14bac4966c87..a1eaddcf740d 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -2234,6 +2234,19 @@ void hisi_sas_kill_tasklets(struct hisi_hba *hisi_hba)
 }
 EXPORT_SYMBOL_GPL(hisi_sas_kill_tasklets);
 
+int hisi_sas_host_reset(struct Scsi_Host *shost, int reset_type)
+{
+	struct hisi_hba *hisi_hba = shost_priv(shost);
+
+	if (reset_type != SCSI_ADAPTER_RESET)
+		return -EOPNOTSUPP;
+
+	queue_work(hisi_hba->wq, &hisi_hba->rst_work);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hisi_sas_host_reset);
+
 struct scsi_transport_template *hisi_sas_stt;
 EXPORT_SYMBOL_GPL(hisi_sas_stt);
 
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
index 293807443480..078ddd3871f2 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
@@ -1823,6 +1823,7 @@ static struct scsi_host_template sht_v1_hw = {
 	.target_destroy		= sas_target_destroy,
 	.ioctl			= sas_ioctl,
 	.shost_attrs		= host_attrs_v1_hw,
+	.host_reset             = hisi_sas_host_reset,
 };
 
 static const struct hisi_sas_hw hisi_sas_v1_hw = {
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index 89160ab3efb0..33b72c7f72c5 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -3599,6 +3599,7 @@ static struct scsi_host_template sht_v2_hw = {
 	.target_destroy		= sas_target_destroy,
 	.ioctl			= sas_ioctl,
 	.shost_attrs		= host_attrs_v2_hw,
+	.host_reset		= hisi_sas_host_reset,
 };
 
 static const struct hisi_sas_hw hisi_sas_v2_hw = {
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 086695a4099f..e8323d038d53 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -2678,6 +2678,7 @@ static struct scsi_host_template sht_v3_hw = {
 	.ioctl			= sas_ioctl,
 	.shost_attrs		= host_attrs_v3_hw,
 	.tag_alloc_policy	= BLK_TAG_ALLOC_RR,
+	.host_reset             = hisi_sas_host_reset,
 };
 
 static const struct hisi_sas_hw hisi_sas_v3_hw = {
-- 
2.17.1

