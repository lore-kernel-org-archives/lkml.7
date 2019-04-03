Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AAEC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B5B20693
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbfDCHwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:52:21 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38676 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725970AbfDCHwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 03:52:21 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [10.3.19.209])
        by Forcepoint Email with ESMTP id 528244757348771CA2F0;
        Wed,  3 Apr 2019 15:52:19 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Wed, 3 Apr 2019
 15:52:12 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <dougmill@linux.ibm.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ehea: remove set but not used variables 'epa' and 'cq_handle_ref'
Date:   Wed, 3 Apr 2019 15:52:08 +0800
Message-ID: <20190403075208.30000-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/net/ethernet/ibm/ehea/ehea_qmr.c: In function 'ehea_create_cq':
drivers/net/ethernet/ibm/ehea/ehea_qmr.c:127:7: warning: variable 'cq_handle_ref' set but not used [-Wunused-but-set-variable]
drivers/net/ethernet/ibm/ehea/ehea_qmr.c:126:15: warning: variable 'epa' set but not used [-Wunused-but-set-variable]

They are never used since commit
7a291083225a ("[PATCH] ehea: IBM eHEA Ethernet Device Driver")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/ibm/ehea/ehea_qmr.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ehea/ehea_qmr.c b/drivers/net/ethernet/ibm/ehea/ehea_qmr.c
index 5e4e371..77ce173 100644
--- a/drivers/net/ethernet/ibm/ehea/ehea_qmr.c
+++ b/drivers/net/ethernet/ibm/ehea/ehea_qmr.c
@@ -123,8 +123,7 @@ struct ehea_cq *ehea_create_cq(struct ehea_adapter *adapter,
 			       int nr_of_cqe, u64 eq_handle, u32 cq_token)
 {
 	struct ehea_cq *cq;
-	struct h_epa epa;
-	u64 *cq_handle_ref, hret, rpage;
+	u64 hret, rpage;
 	u32 counter;
 	int ret;
 	void *vpage;
@@ -139,8 +138,6 @@ struct ehea_cq *ehea_create_cq(struct ehea_adapter *adapter,
 
 	cq->adapter = adapter;
 
-	cq_handle_ref = &cq->fw_handle;
-
 	hret = ehea_h_alloc_resource_cq(adapter->handle, &cq->attr,
 					&cq->fw_handle, &cq->epas);
 	if (hret != H_SUCCESS) {
@@ -188,7 +185,6 @@ struct ehea_cq *ehea_create_cq(struct ehea_adapter *adapter,
 	}
 
 	hw_qeit_reset(&cq->hw_queue);
-	epa = cq->epas.kernel;
 	ehea_reset_cq_ep(cq);
 	ehea_reset_cq_n1(cq);
 
-- 
2.7.0


