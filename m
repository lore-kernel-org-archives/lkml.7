Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16404C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 02:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D1E206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 02:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfDZCSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 22:18:14 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37666 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726086AbfDZCSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 22:18:14 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CF38B5D256DEA74723D7;
        Fri, 26 Apr 2019 10:18:11 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Fri, 26 Apr 2019 10:18:01 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <james.morse@arm.com>
CC:     <wangxiongfeng2@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] firmware: arm_sdei: Prohibit probing in '_sdei_handler'
Date:   Fri, 26 Apr 2019 10:16:36 +0800
Message-ID: <1556244996-1047-1-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Functions called in '_sdei_handler' are needed to be marked as
'nokprobe'. Because these functions are called in NMI context and
neither the arch-code's debug infrastructure nor kprobes core supports
this.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Reviewed-by: James Morse <james.morse@arm.com>
---
 drivers/firmware/arm_sdei.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index e6376f9..9cd70d1 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -165,6 +165,7 @@ static int invoke_sdei_fn(unsigned long function_id, unsigned long arg0,
 
 	return err;
 }
+NOKPROBE_SYMBOL(invoke_sdei_fn);
 
 static struct sdei_event *sdei_event_find(u32 event_num)
 {
@@ -879,6 +880,7 @@ static void sdei_smccc_smc(unsigned long function_id,
 {
 	arm_smccc_smc(function_id, arg0, arg1, arg2, arg3, arg4, 0, 0, res);
 }
+NOKPROBE_SYMBOL(sdei_smccc_smc);
 
 static void sdei_smccc_hvc(unsigned long function_id,
 			   unsigned long arg0, unsigned long arg1,
@@ -887,6 +889,7 @@ static void sdei_smccc_hvc(unsigned long function_id,
 {
 	arm_smccc_hvc(function_id, arg0, arg1, arg2, arg3, arg4, 0, 0, res);
 }
+NOKPROBE_SYMBOL(sdei_smccc_hvc);
 
 int sdei_register_ghes(struct ghes *ghes, sdei_event_callback *normal_cb,
 		       sdei_event_callback *critical_cb)
-- 
1.7.12.4

