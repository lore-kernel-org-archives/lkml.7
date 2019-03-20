Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA3AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 117F92183E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfCTBzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 21:55:03 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45498 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726801AbfCTBzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 21:55:03 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4629E82398EEED7160C6;
        Wed, 20 Mar 2019 09:55:01 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Wed, 20 Mar 2019 09:54:55 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <davem@davemloft.net>, <bridge@lists.linux-foundation.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <nikolay@cumulusnetworks.com>,
        <roopa@cumulusnetworks.com>
Subject: [PATCH net-next] net: bridge: use eth_broadcast_addr() to assign broadcast address
Date:   Wed, 20 Mar 2019 10:06:57 +0800
Message-ID: <20190320020657.31423-1-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to use eth_broadcast_addr() to assign broadcast address
insetad of memset().

Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 net/bridge/br_multicast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index a0e369179f6d..b257342c0860 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -517,7 +517,7 @@ struct net_bridge_port_group *br_multicast_new_port_group(
 	if (src)
 		memcpy(p->eth_addr, src, ETH_ALEN);
 	else
-		memset(p->eth_addr, 0xff, ETH_ALEN);
+		eth_broadcast_addr(p->eth_addr);
 
 	return p;
 }
-- 
2.20.1

