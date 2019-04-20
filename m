Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22E5C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 04:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A776421479
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 04:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfDTEKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 00:10:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37538 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725825AbfDTEKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 00:10:06 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 936D4CC2113F01A98B24;
        Sat, 20 Apr 2019 12:10:04 +0800 (CST)
Received: from [127.0.0.1] (10.184.189.20) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Sat, 20 Apr 2019
 12:09:56 +0800
From:   linmiaohe <linmiaohe@huawei.com>
Subject: [PATCH] net: vrf: Fix operation not supported when set vrf mac
To:     <dsa@cumulusnetworks.com>, <shrijeet@gmail.com>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Mingfangsen <mingfangsen@huawei.com>
Message-ID: <4e8a50df-bf96-3ef7-2977-71495d80643c@huawei.com>
Date:   Sat, 20 Apr 2019 12:09:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.189.20]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaohe Lin <linmiaohe@huawei.com>

Vrf device is not able to change mac address now because lack of
ndo_set_mac_address. Complete this in case some apps need to do
this.

Reported-by: Hui Wang <wanghui104@huawei.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 drivers/net/vrf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index cd15c32b2e43..9ee4d7402ca2 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -875,6 +875,7 @@ static const struct net_device_ops vrf_netdev_ops = {
 	.ndo_init		= vrf_dev_init,
 	.ndo_uninit		= vrf_dev_uninit,
 	.ndo_start_xmit		= vrf_xmit,
+	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_get_stats64	= vrf_get_stats64,
 	.ndo_add_slave		= vrf_add_slave,
 	.ndo_del_slave		= vrf_del_slave,
@@ -1274,6 +1275,7 @@ static void vrf_setup(struct net_device *dev)
 	/* default to no qdisc; user can add if desired */
 	dev->priv_flags |= IFF_NO_QUEUE;
 	dev->priv_flags |= IFF_NO_RX_HANDLER;
+	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;

 	/* VRF devices do not care about MTU, but if the MTU is set
 	 * too low then the ipv4 and ipv6 protocols are disabled
-- 
2.19.1


