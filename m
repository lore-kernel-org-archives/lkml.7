Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB473C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E08220693
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbfDCHu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:50:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6224 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725970AbfDCHuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 03:50:55 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [10.3.19.212])
        by Forcepoint Email with ESMTP id 3EB31334F0FEBBA0D3FC;
        Wed,  3 Apr 2019 15:50:52 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Wed, 3 Apr 2019
 15:50:44 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <mpe@ellerman.id.au>, <mcgrof@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] net: pasemi: remove set but not used variable 'cpyhdr'
Date:   Wed, 3 Apr 2019 15:50:27 +0800
Message-ID: <20190403075027.26744-1-yuehaibing@huawei.com>
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

drivers/net/ethernet/pasemi/pasemi_mac.c: In function 'pasemi_mac_queue_csdesc':
drivers/net/ethernet/pasemi/pasemi_mac.c:1358:29: warning: variable 'cpyhdr' set but not used [-Wunused-but-set-variable]

It's never used since commit 8d636d8bc5ff ("pasemi_mac: jumbo
frame support") and can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/pasemi/pasemi_mac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/pasemi/pasemi_mac.c b/drivers/net/ethernet/pasemi/pasemi_mac.c
index 55d686e..5ffaee9 100644
--- a/drivers/net/ethernet/pasemi/pasemi_mac.c
+++ b/drivers/net/ethernet/pasemi/pasemi_mac.c
@@ -1355,7 +1355,7 @@ static void pasemi_mac_queue_csdesc(const struct sk_buff *skb,
 	const int nh_off = skb_network_offset(skb);
 	const int nh_len = skb_network_header_len(skb);
 	const int nfrags = skb_shinfo(skb)->nr_frags;
-	int cs_size, i, fill, hdr, cpyhdr, evt;
+	int cs_size, i, fill, hdr, evt;
 	dma_addr_t csdma;
 
 	fund = XCT_FUN_ST | XCT_FUN_RR_8BRES |
@@ -1396,7 +1396,6 @@ static void pasemi_mac_queue_csdesc(const struct sk_buff *skb,
 		fill++;
 
 	/* Copy the result into the TCP packet */
-	cpyhdr = fill;
 	CS_DESC(csring, fill++) = XCT_FUN_O | XCT_FUN_FUN(csring->fun) |
 				  XCT_FUN_LLEN(2) | XCT_FUN_SE;
 	CS_DESC(csring, fill++) = XCT_PTR_LEN(2) | XCT_PTR_ADDR(cs_dest) | XCT_PTR_T;
-- 
2.7.0


