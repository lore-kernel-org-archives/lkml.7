Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62DBC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA47206E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfGBN0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 09:26:44 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7689 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725922AbfGBN0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 09:26:44 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 46EE2FECA8D12E48B4F3;
        Tue,  2 Jul 2019 21:26:41 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Tue, 2 Jul 2019
 21:26:30 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <anil.gurumurthy@qlogic.com>, <sudarsana.kalluru@qlogic.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] scsi: bfa: Make two functions static
Date:   Tue, 2 Jul 2019 21:23:24 +0800
Message-ID: <20190702132324.48136-1-yuehaibing@huawei.com>
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

drivers/scsi/bfa/bfa_ioc.c:6982:1: warning: symbol 'bfa_flash_sem_get' was not declared. Should it be static?
drivers/scsi/bfa/bfa_ioc.c:6995:1: warning: symbol 'bfa_flash_sem_put' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/scsi/bfa/bfa_ioc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/bfa/bfa_ioc.c b/drivers/scsi/bfa/bfa_ioc.c
index 93471d7..aae1db1 100644
--- a/drivers/scsi/bfa/bfa_ioc.c
+++ b/drivers/scsi/bfa/bfa_ioc.c
@@ -6970,7 +6970,7 @@ bfa_raw_sem_get(void __iomem *bar)
 
 }
 
-bfa_status_t
+static bfa_status_t
 bfa_flash_sem_get(void __iomem *bar)
 {
 	u32 n = FLASH_BLOCKING_OP_MAX;
@@ -6983,7 +6983,7 @@ bfa_flash_sem_get(void __iomem *bar)
 	return BFA_STATUS_OK;
 }
 
-void
+static void
 bfa_flash_sem_put(void __iomem *bar)
 {
 	writel(0, (bar + FLASH_SEM_LOCK_REG));
-- 
2.7.4


