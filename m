Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E44EC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 02:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7433D20879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 02:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfDHCEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 22:04:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36516 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726349AbfDHCEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 22:04:38 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8E3B5DCED5814F282F06;
        Mon,  8 Apr 2019 10:04:36 +0800 (CST)
Received: from [127.0.0.1] (10.184.189.20) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Mon, 8 Apr 2019
 10:04:25 +0800
To:     David Ahern <dsa@cumulusnetworks.com>, <shrijeet@gmail.com>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Mingfangsen <mingfangsen@huawei.com>
From:   linmiaohe <linmiaohe@huawei.com>
Subject: [PATCH net v3] net: vrf: Fix ping failed when vrf mtu is set to 0
Message-ID: <b32ed160-6c7f-fb8e-aa14-11d935a1cb15@huawei.com>
Date:   Mon, 8 Apr 2019 10:04:20 +0800
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
failed. So I think we should limit vrf mtu in a reasonable range
to solve this problem. I set dev->min_mtu to IPV6_MIN_MTU, so it
will works for both ipv4 and ipv6. And if dev->max_mtu still be 0
can be confusing, so I set dev->max_mtu to ETH_MAX_MTU.

Here is the reproduce step:

1.Config vrf interface and set mtu to 0:
3: enp4s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel
master vrf1 state UP mode DEFAULT group default qlen 1000
    link/ether 52:54:00:9e:dd:c1 brd ff:ff:ff:ff:ff:ff

2.Ping peer:
3: enp4s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel
master vrf1 state UP group default qlen 1000
    link/ether 52:54:00:9e:dd:c1 brd ff:ff:ff:ff:ff:ff
    inet 10.0.0.1/16 scope global enp4s0
       valid_lft forever preferred_lft forever
connect: Network is unreachable

3.Set mtu to default value, ping works:
PING 10.0.0.2 (10.0.0.2) 56(84) bytes of data.
64 bytes from 10.0.0.2: icmp_seq=1 ttl=64 time=1.88 ms

Fixes: ad49bc6361ca2 ("net: vrf: remove MTU limits for vrf device")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
V2->V3:
- delete VRF specific mtu macros
- set mtu range directly and add a comment

 drivers/net/vrf.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 6d1a1abbed27..cd15c32b2e43 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1275,8 +1275,12 @@ static void vrf_setup(struct net_device *dev)
 	dev->priv_flags |= IFF_NO_QUEUE;
 	dev->priv_flags |= IFF_NO_RX_HANDLER;

-	dev->min_mtu = 0;
-	dev->max_mtu = 0;
+	/* VRF devices do not care about MTU, but if the MTU is set
+	 * too low then the ipv4 and ipv6 protocols are disabled
+	 * which breaks networking.
+	 */
+	dev->min_mtu = IPV6_MIN_MTU;
+	dev->max_mtu = ETH_MAX_MTU;
 }

 static int vrf_validate(struct nlattr *tb[], struct nlattr *data[],
-- 
2.19.1


