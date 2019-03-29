Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C8EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EEC2218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbfC2Pug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:50:36 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33330 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728815AbfC2Pug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:50:36 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EC91632957A6DA0A6FA9;
        Fri, 29 Mar 2019 23:50:30 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Fri, 29 Mar 2019
 23:50:23 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <fbarrat@linux.ibm.com>, <andrew.donnellan@au1.ibm.com>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ocxl: remove set but not used variables 'tid' and 'lpid'
Date:   Fri, 29 Mar 2019 23:44:56 +0800
Message-ID: <20190329154456.27152-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/misc/ocxl/link.c: In function 'xsl_fault_handler':
drivers/misc/ocxl/link.c:187:17: warning: variable 'tid' set but not used [-Wunused-but-set-variable]
drivers/misc/ocxl/link.c:187:6: warning: variable 'lpid' set but not used [-Wunused-but-set-variable]

They are never used and can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/misc/ocxl/link.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c
index d50b861..3be07e9 100644
--- a/drivers/misc/ocxl/link.c
+++ b/drivers/misc/ocxl/link.c
@@ -184,7 +184,7 @@ static irqreturn_t xsl_fault_handler(int irq, void *data)
 	u64 dsisr, dar, pe_handle;
 	struct pe_data *pe_data;
 	struct ocxl_process_element *pe;
-	int lpid, pid, tid;
+	int pid;
 	bool schedule = false;
 
 	read_irq(spa, &dsisr, &dar, &pe_handle);
@@ -192,9 +192,7 @@ static irqreturn_t xsl_fault_handler(int irq, void *data)
 
 	WARN_ON(pe_handle > SPA_PE_MASK);
 	pe = spa->spa_mem + pe_handle;
-	lpid = be32_to_cpu(pe->lpid);
 	pid = be32_to_cpu(pe->pid);
-	tid = be32_to_cpu(pe->tid);
 	/* We could be reading all null values here if the PE is being
 	 * removed while an interrupt kicks in. It's not supposed to
 	 * happen if the driver notified the AFU to terminate the
-- 
2.7.0


