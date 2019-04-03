Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE22C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677272084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbfDCHy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:54:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6225 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725936AbfDCHy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 03:54:26 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [10.3.19.214])
        by Forcepoint Email with ESMTP id 452B2EFFEAC11A69913E;
        Wed,  3 Apr 2019 15:54:24 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Wed, 3 Apr 2019
 15:54:16 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <mpe@ellerman.id.au>, <tlfalcon@linux.ibm.com>,
        <jallen@linux.ibm.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ibmvnic: remove set but not used variable 'netdev'
Date:   Wed, 3 Apr 2019 15:54:09 +0800
Message-ID: <20190403075409.29384-1-yuehaibing@huawei.com>
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

drivers/net/ethernet/ibm/ibmvnic.c: In function '__ibmvnic_reset':
drivers/net/ethernet/ibm/ibmvnic.c:1971:21: warning: variable 'netdev' set but not used [-Wunused-but-set-variable]

It's never used since introduction in
commit ed651a10875f ("ibmvnic: Updated reset handling")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 25b8e04..20c4e08 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1968,13 +1968,11 @@ static void __ibmvnic_reset(struct work_struct *work)
 {
 	struct ibmvnic_rwi *rwi;
 	struct ibmvnic_adapter *adapter;
-	struct net_device *netdev;
 	bool we_lock_rtnl = false;
 	u32 reset_state;
 	int rc = 0;
 
 	adapter = container_of(work, struct ibmvnic_adapter, ibmvnic_reset);
-	netdev = adapter->netdev;
 
 	/* netif_set_real_num_xx_queues needs to take rtnl lock here
 	 * unless wait_for_reset is set, in which case the rtnl lock
-- 
2.7.0


