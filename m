Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A01C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0102020882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbfDCHs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:48:26 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44838 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726425AbfDCHs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 03:48:26 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [10.3.19.211])
        by Forcepoint Email with ESMTP id 011F91020F4A3907CD6A;
        Wed,  3 Apr 2019 15:48:24 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Wed, 3 Apr 2019
 15:48:13 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <dougmill@linux.ibm.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ehea: Fix a copy-paste err in ehea_init_port_res
Date:   Wed, 3 Apr 2019 15:47:59 +0800
Message-ID: <20190403074759.13496-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

pr->tx_bytes should be assigned to tx_bytes other than
rx_bytes.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: ce45b873028f ("ehea: Fixing statistics")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/ibm/ehea/ehea_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ehea/ehea_main.c b/drivers/net/ethernet/ibm/ehea/ehea_main.c
index 90b62c1..707c8ba 100644
--- a/drivers/net/ethernet/ibm/ehea/ehea_main.c
+++ b/drivers/net/ethernet/ibm/ehea/ehea_main.c
@@ -1463,7 +1463,7 @@ static int ehea_init_port_res(struct ehea_port *port, struct ehea_port_res *pr,
 
 	memset(pr, 0, sizeof(struct ehea_port_res));
 
-	pr->tx_bytes = rx_bytes;
+	pr->tx_bytes = tx_bytes;
 	pr->tx_packets = tx_packets;
 	pr->rx_bytes = rx_bytes;
 	pr->rx_packets = rx_packets;
-- 
2.7.0


