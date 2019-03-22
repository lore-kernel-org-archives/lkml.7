Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFED2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94CE5218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbfCVOLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:11:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5172 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727746AbfCVOLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:11:24 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D0961248CE40E3374C06;
        Fri, 22 Mar 2019 22:11:20 +0800 (CST)
Received: from [127.0.0.1] (10.184.189.20) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Fri, 22 Mar 2019
 22:11:11 +0800
From:   linmiaohe <linmiaohe@huawei.com>
Subject: [PATCH net] net: vrf: remove redundant vrf neigh entry
To:     David Ahern <dsa@cumulusnetworks.com>,
        Shrijeet Mukherjee <shrijeet@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Mingfangsen <mingfangsen@huawei.com>
Message-ID: <a0fb851b-f9a2-1424-f7f0-2800bb3b469c@huawei.com>
Date:   Fri, 22 Mar 2019 22:10:35 +0800
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

When vrf->rth is created, it wouldn't change in his lifetime.And in
func vrf_finish_output, we always create a neigh with ip_hdr(skb)->daddr
as key because rth->rt_gateway is equal to 0. But I think we only need
one vrf neigh entry because we strip the ethernet header and reset the
dst_entry in vrf_process_v4_outbound.
So I set rth->rt_gateway to loopback addr(It's ok to set any other
valid ip address, just choose one.). And we would only create one vrf
neigh entry. This helps saving some memory and improving the hitting
rate of neigh lookup.
If there is something I misunderstand, it's very nice of you to
let me know. Thanks a lot.

Signed-off-by: linmiaohe <linmiaohe@huawei.com>
---
 drivers/net/vrf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 7c1430ed0244..2b0227fb8f53 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -738,6 +738,7 @@ static int vrf_rtable_create(struct net_device *dev)
 		return -ENOMEM;

 	rth->dst.output	= vrf_output;
+	rth->rt_gateway = htonl(INADDR_LOOPBACK);

 	rcu_assign_pointer(vrf->rth, rth);

-- 
2.16.2


