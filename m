Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B692CC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A01322CE5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbfGZN4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:56:08 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39926 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728452AbfGZN4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:56:05 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 358F2D34AB62BD8B557C;
        Fri, 26 Jul 2019 21:56:01 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Fri, 26 Jul 2019
 21:55:52 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <kashyap.desai@broadcom.com>, <sumit.saxena@broadcom.com>,
        <shivasharan.srikanteshwara@broadcom.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <megaraidlinux.pdl@broadcom.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] scsi: megaraid_sas: Make a bunch of functions static
Date:   Fri, 26 Jul 2019 21:55:40 +0800
Message-ID: <20190726135540.48780-1-yuehaibing@huawei.com>
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

drivers/scsi/megaraid/megaraid_sas_fusion.c:3369:1: warning: symbol 'complete_cmd_fusion' was not declared. Should it be static?
drivers/scsi/megaraid/megaraid_sas_fusion.c:3535:6: warning: symbol 'megasas_sync_irqs' was not declared. Should it be static?
drivers/scsi/megaraid/megaraid_sas_fusion.c:3554:1: warning: symbol 'megasas_complete_cmd_dpc_fusion' was not declared. Should it be static?
drivers/scsi/megaraid/megaraid_sas_fusion.c:3573:13: warning: symbol 'megasas_isr_fusion' was not declared. Should it be static?
drivers/scsi/megaraid/megaraid_sas_fusion.c:3604:1: warning: symbol 'build_mpt_mfi_pass_thru' was not declared. Should it be static?
drivers/scsi/megaraid/megaraid_sas_fusion.c:3661:40: warning: symbol 'build_mpt_cmd' was not declared. Should it be static?
drivers/scsi/megaraid/megaraid_sas_fusion.c:3688:1: warning: symbol 'megasas_issue_dcmd_fusion' was not declared. Should it be static?
drivers/scsi/megaraid/megaraid_sas_fusion.c:3881:5: warning: symbol 'megasas_wait_for_outstanding_fusion' was not declared. Should it be static?
drivers/scsi/megaraid/megaraid_sas_fusion.c:4005:6: warning: symbol 'megasas_refire_mgmt_cmd' was not declared. Should it be static?
drivers/scsi/megaraid/megaraid_sas_fusion.c:4525:25: warning: symbol 'megasas_get_peer_instance' was not declared. Should it be static?
drivers/scsi/megaraid/megaraid_sas_fusion.c:4825:7: warning: symbol 'megasas_fusion_crash_dump' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index 120e3c4..10ef99e 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -3511,7 +3511,7 @@ megasas_complete_r1_command(struct megasas_instance *instance,
  * @instance:			Adapter soft state
  * Completes all commands that is in reply descriptor queue
  */
-int
+static int
 complete_cmd_fusion(struct megasas_instance *instance, u32 MSIxIndex,
 		    struct megasas_irq_context *irq_context)
 {
@@ -3702,7 +3702,7 @@ static void megasas_enable_irq_poll(struct megasas_instance *instance)
  * megasas_sync_irqs -	Synchronizes all IRQs owned by adapter
  * @instance:			Adapter soft state
  */
-void megasas_sync_irqs(unsigned long instance_addr)
+static void megasas_sync_irqs(unsigned long instance_addr)
 {
 	u32 count, i;
 	struct megasas_instance *instance =
@@ -3760,7 +3760,7 @@ int megasas_irqpoll(struct irq_poll *irqpoll, int budget)
  *
  * Tasklet to complete cmds
  */
-void
+static void
 megasas_complete_cmd_dpc_fusion(unsigned long instance_addr)
 {
 	struct megasas_instance *instance =
@@ -3780,7 +3780,7 @@ megasas_complete_cmd_dpc_fusion(unsigned long instance_addr)
 /**
  * megasas_isr_fusion - isr entry point
  */
-irqreturn_t megasas_isr_fusion(int irq, void *devp)
+static irqreturn_t megasas_isr_fusion(int irq, void *devp)
 {
 	struct megasas_irq_context *irq_context = devp;
 	struct megasas_instance *instance = irq_context->instance;
@@ -3816,7 +3816,7 @@ irqreturn_t megasas_isr_fusion(int irq, void *devp)
  * mfi_cmd:			megasas_cmd pointer
  *
  */
-void
+static void
 build_mpt_mfi_pass_thru(struct megasas_instance *instance,
 			struct megasas_cmd *mfi_cmd)
 {
@@ -3874,7 +3874,7 @@ build_mpt_mfi_pass_thru(struct megasas_instance *instance,
  * @cmd:			mfi cmd to build
  *
  */
-union MEGASAS_REQUEST_DESCRIPTOR_UNION *
+static union MEGASAS_REQUEST_DESCRIPTOR_UNION *
 build_mpt_cmd(struct megasas_instance *instance, struct megasas_cmd *cmd)
 {
 	union MEGASAS_REQUEST_DESCRIPTOR_UNION *req_desc = NULL;
@@ -3900,7 +3900,7 @@ build_mpt_cmd(struct megasas_instance *instance, struct megasas_cmd *cmd)
  * @cmd:			mfi cmd pointer
  *
  */
-void
+static void
 megasas_issue_dcmd_fusion(struct megasas_instance *instance,
 			  struct megasas_cmd *cmd)
 {
@@ -4096,8 +4096,9 @@ static inline void megasas_trigger_snap_dump(struct megasas_instance *instance)
 }
 
 /* This function waits for outstanding commands on fusion to complete */
-int megasas_wait_for_outstanding_fusion(struct megasas_instance *instance,
-					int reason, int *convert)
+static int
+megasas_wait_for_outstanding_fusion(struct megasas_instance *instance,
+				    int reason, int *convert)
 {
 	int i, outstanding, retval = 0, hb_seconds_missed = 0;
 	u32 fw_state, abs_state;
@@ -4221,7 +4222,7 @@ void  megasas_reset_reply_desc(struct megasas_instance *instance)
  * megasas_refire_mgmt_cmd :	Re-fire management commands
  * @instance:				Controller's soft instance
 */
-void megasas_refire_mgmt_cmd(struct megasas_instance *instance)
+static void megasas_refire_mgmt_cmd(struct megasas_instance *instance)
 {
 	int j;
 	struct megasas_cmd_fusion *cmd_fusion;
@@ -4747,7 +4748,8 @@ int megasas_reset_target_fusion(struct scsi_cmnd *scmd)
 }
 
 /*SRIOV get other instance in cluster if any*/
-struct megasas_instance *megasas_get_peer_instance(struct megasas_instance *instance)
+static struct
+megasas_instance *megasas_get_peer_instance(struct megasas_instance *instance)
 {
 	int i;
 
@@ -5053,7 +5055,7 @@ int megasas_reset_fusion(struct Scsi_Host *shost, int reason)
 }
 
 /* Fusion Crash dump collection */
-void  megasas_fusion_crash_dump(struct megasas_instance *instance)
+static void  megasas_fusion_crash_dump(struct megasas_instance *instance)
 {
 	u32 status_reg;
 	u8 partial_copy = 0;
-- 
2.7.4


