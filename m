Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00A4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A94C420850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfCSOne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:43:34 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46634 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727918AbfCSOn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:43:26 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EC417BE7C5A95EDE4D18;
        Tue, 19 Mar 2019 22:43:20 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Tue, 19 Mar 2019
 22:43:13 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <benh@kernel.crashing.org>, <paulus@samba.org>,
        <mpe@ellerman.id.au>, <tlfalcon@linux.ibm.com>,
        <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] ibmveth: Make array ibmveth_stats static
Date:   Tue, 19 Mar 2019 22:42:37 +0800
Message-ID: <20190319144237.19288-1-yuehaibing@huawei.com>
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

Fix sparse warning:
drivers/net/ethernet/ibm/ibmveth.c:96:21:
 warning: symbol 'ibmveth_stats' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index dd71d5d..d86b0e5 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -93,7 +93,7 @@ struct ibmveth_stat {
 #define IBMVETH_STAT_OFF(stat) offsetof(struct ibmveth_adapter, stat)
 #define IBMVETH_GET_STAT(a, off) *((u64 *)(((unsigned long)(a)) + off))
 
-struct ibmveth_stat ibmveth_stats[] = {
+static struct ibmveth_stat ibmveth_stats[] = {
 	{ "replenish_task_cycles", IBMVETH_STAT_OFF(replenish_task_cycles) },
 	{ "replenish_no_mem", IBMVETH_STAT_OFF(replenish_no_mem) },
 	{ "replenish_add_buff_failure",
-- 
2.7.4


