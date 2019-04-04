Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A23FC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 167972082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbfDDMBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 08:01:39 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6251 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726269AbfDDMBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 08:01:38 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 857F1C62C48255A8C4DF;
        Thu,  4 Apr 2019 20:01:33 +0800 (CST)
Received: from [127.0.0.1] (10.184.189.20) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Thu, 4 Apr 2019
 20:01:23 +0800
From:   linmiaohe <linmiaohe@huawei.com>
Subject: [PATCH net] net: vrf: Fix ping failed when vrf mtu is set to 0
To:     <dsa@cumulusnetworks.com>, <shrijeet@gmail.com>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Mingfangsen <mingfangsen@huawei.com>
Message-ID: <0da12059-229f-e167-ad41-14b56993a029@huawei.com>
Date:   Thu, 4 Apr 2019 20:01:13 +0800
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

When the mtu of a vrf device is set to 0, it would cause ping
failed.So I think we should limit dev->min_mtu to ETH_MIN_MTU
to solve this problem. And if dev->max_mtu still be 0 can be
confusing, so I limit dev->max_mtu to ETH_MAX_MTU.

Here is the reproduce step:

1.Config vrf interface and set mtu to 0:
# ip link show vrf vrf1
3: enp4s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel
master vrf1 state UP mode DEFAULT group default qlen 1000
    link/ether 52:54:00:9e:dd:c1 brd ff:ff:ff:ff:ff:ff
# ip link set vrf1 mtu 0

2.Ping peer:
# ip addr show enp4s0
3: enp4s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel
master vrf1 state UP group default qlen 1000
    link/ether 52:54:00:9e:dd:c1 brd ff:ff:ff:ff:ff:ff
    inet 10.0.0.1/16 scope global enp4s0
       valid_lft forever preferred_lft forever
# ip vrf exec vrf1 ping 10.0.0.2 -c 1
connect: Network is unreachable

3.Set mtu to default value, ping works:
# ip link set vrf1 mtu 65536
# ip vrf exec vrf1 ping 10.0.0.2 -c 1
PING 10.0.0.2 (10.0.0.2) 56(84) bytes of data.
64 bytes from 10.0.0.2: icmp_seq=1 ttl=64 time=1.88 ms

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 drivers/net/vrf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 7c1430ed0244..632d84fee366 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1274,8 +1274,8 @@ static void vrf_setup(struct net_device *dev)
 	/* default to no qdisc; user can add if desired */
 	dev->priv_flags |= IFF_NO_QUEUE;

-	dev->min_mtu = 0;
-	dev->max_mtu = 0;
+	dev->min_mtu = ETH_MIN_MTU;
+	dev->max_mtu = ETH_MAX_MTU;
 }

 static int vrf_validate(struct nlattr *tb[], struct nlattr *data[],
-- 
2.19.1




.


