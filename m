Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE15C3A589
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 03:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7630A22DD3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 03:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfHUDUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 23:20:12 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4742 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726864AbfHUDUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 23:20:12 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5D0A5CDE30F52E2A0F31;
        Wed, 21 Aug 2019 11:20:09 +0800 (CST)
Received: from szxyal004123181.china.huawei.com (10.65.65.77) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Wed, 21 Aug 2019 11:20:03 +0800
From:   Dongxu Liu <liudongxu3@huawei.com>
To:     <davem@davemloft.net>, <kuznet@ms2.inr.ac.ru>,
        <yoshfuji@linux-ipv6.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] net: Add the same IP detection for duplicate address.
Date:   Wed, 21 Aug 2019 11:20:00 +0800
Message-ID: <20190821032000.10540-1-liudongxu3@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.65.65.77]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The network sends an ARP REQUEST packet to determine
whether there is a host with the same IP.
Windows and some other hosts may send the source IP
address instead of 0.
When IN_DEV_ORCONF(in_dev, DROP_GRATUITOUS_ARP) is enable,
the REQUEST will be dropped.
When IN_DEV_ORCONF(in_dev, DROP_GRATUITOUS_ARP) is disable,
The case should be added to the IP conflict handling process.

Signed-off-by: Dongxu Liu <liudongxu3@huawei.com>
---
 net/ipv4/arp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index 05eb42f..a51c921 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -801,7 +801,7 @@ static int arp_process(struct net *net, struct sock *sk, struct sk_buff *skb)
 						    GFP_ATOMIC);
 
 	/* Special case: IPv4 duplicate address detection packet (RFC2131) */
-	if (sip == 0) {
+	if (sip == 0 || sip == tip) {
 		if (arp->ar_op == htons(ARPOP_REQUEST) &&
 		    inet_addr_type_dev_table(net, dev, tip) == RTN_LOCAL &&
 		    !arp_ignore(in_dev, sip, tip))
-- 
2.12.3


