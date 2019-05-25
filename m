Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A5FC282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 12:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA8DE20863
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 12:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfEYMio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 08:38:44 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46866 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726672AbfEYMio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 08:38:44 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0467EF1B86BAE6BB9BB2;
        Sat, 25 May 2019 20:38:41 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Sat, 25 May 2019
 20:38:30 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <kashyap.desai@broadcom.com>, <sumit.saxena@broadcom.com>,
        <shivasharan.srikanteshwara@broadcom.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <megaraidlinux.pdl@broadcom.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] scsi: megaraid_sas: remove set but not used variable 'cur_state'
Date:   Sat, 25 May 2019 20:38:21 +0800
Message-ID: <20190525123821.16528-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/scsi/megaraid/megaraid_sas_base.c: In function megasas_transition_to_ready:
drivers/scsi/megaraid/megaraid_sas_base.c:3900:6: warning: variable cur_state set but not used [-Wunused-but-set-variable]

It's not used any more since commit 7218df69e360 ("[SCSI]
megaraid_sas: use the firmware boot timeout when waiting for commands")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 25281a2eb424..39d173ed5b69 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -3897,7 +3897,6 @@ megasas_transition_to_ready(struct megasas_instance *instance, int ocr)
 	int i;
 	u8 max_wait;
 	u32 fw_state;
-	u32 cur_state;
 	u32 abs_state, curr_abs_state;
 
 	abs_state = instance->instancet->read_fw_status_reg(instance);
@@ -3918,7 +3917,6 @@ megasas_transition_to_ready(struct megasas_instance *instance, int ocr)
 				   abs_state & MFI_STATE_FAULT_SUBCODE, __func__);
 			if (ocr) {
 				max_wait = MEGASAS_RESET_WAIT_TIME;
-				cur_state = MFI_STATE_FAULT;
 				break;
 			} else {
 				dev_printk(KERN_DEBUG, &instance->pdev->dev, "System Register set:\n");
@@ -3944,7 +3942,6 @@ megasas_transition_to_ready(struct megasas_instance *instance, int ocr)
 					&instance->reg_set->inbound_doorbell);
 
 			max_wait = MEGASAS_RESET_WAIT_TIME;
-			cur_state = MFI_STATE_WAIT_HANDSHAKE;
 			break;
 
 		case MFI_STATE_BOOT_MESSAGE_PENDING:
@@ -3960,7 +3957,6 @@ megasas_transition_to_ready(struct megasas_instance *instance, int ocr)
 					&instance->reg_set->inbound_doorbell);
 
 			max_wait = MEGASAS_RESET_WAIT_TIME;
-			cur_state = MFI_STATE_BOOT_MESSAGE_PENDING;
 			break;
 
 		case MFI_STATE_OPERATIONAL:
@@ -3993,7 +3989,6 @@ megasas_transition_to_ready(struct megasas_instance *instance, int ocr)
 					&instance->reg_set->inbound_doorbell);
 
 			max_wait = MEGASAS_RESET_WAIT_TIME;
-			cur_state = MFI_STATE_OPERATIONAL;
 			break;
 
 		case MFI_STATE_UNDEFINED:
@@ -4001,32 +3996,26 @@ megasas_transition_to_ready(struct megasas_instance *instance, int ocr)
 			 * This state should not last for more than 2 seconds
 			 */
 			max_wait = MEGASAS_RESET_WAIT_TIME;
-			cur_state = MFI_STATE_UNDEFINED;
 			break;
 
 		case MFI_STATE_BB_INIT:
 			max_wait = MEGASAS_RESET_WAIT_TIME;
-			cur_state = MFI_STATE_BB_INIT;
 			break;
 
 		case MFI_STATE_FW_INIT:
 			max_wait = MEGASAS_RESET_WAIT_TIME;
-			cur_state = MFI_STATE_FW_INIT;
 			break;
 
 		case MFI_STATE_FW_INIT_2:
 			max_wait = MEGASAS_RESET_WAIT_TIME;
-			cur_state = MFI_STATE_FW_INIT_2;
 			break;
 
 		case MFI_STATE_DEVICE_SCAN:
 			max_wait = MEGASAS_RESET_WAIT_TIME;
-			cur_state = MFI_STATE_DEVICE_SCAN;
 			break;
 
 		case MFI_STATE_FLUSH_CACHE:
 			max_wait = MEGASAS_RESET_WAIT_TIME;
-			cur_state = MFI_STATE_FLUSH_CACHE;
 			break;
 
 		default:
-- 
2.17.1


